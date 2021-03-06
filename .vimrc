set shell=/bin/sh " Rquired when using the fish sell. All plugins break without this.

let mapleader = "\<Space>"
let localleader = "\<Space>"

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType mumps nnoremap <buffer> <localleader>c I;<esc>
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd FileType python call SetPythonOptions()
autocmd FileType python call SetPythonCommands()
autocmd FileType html call SetHTMLOptions()
autocmd FileType javascript call SetJavascriptOptions()
autocmd FileType javascript call SetJavascriptCommands()

function SetDefaultOptions()
  set expandtab
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  set autoindent
endfunction

call SetDefaultOptions()

function SetPythonOptions()
  set expandtab
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  set autoindent
  set fileformat=unix
  set formatprg=yapf
endfunction

function SetPythonCommands()
  nnoremap <buffer> <localleader>c I#<esc>
  autocmd BufWritePre * :%s/\s\+$//e
endfunction

function SetFrontEndOptions()
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set autoindent
endfunction

function SetJavascriptOptions()
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set autoindent
endfunction

function SetJavascriptCommands()
  nnoremap <buffer> <localleader>c I\/\/<esc>
  autocmd BufWritePre * :%s/\s\+$//e
endfunction

" backspace deletes all whitespace
set backspace=indent,eol,start

""""""""""""""""" Enter and exit paste mode when pasting from mouse
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
""""""""""""""""""

" Search settings
set smartcase " Use case if caps are used
set incsearch " Show match as search proceeds
set hlsearch  " Search highlighting
set number    " Show line numbers

set ruler
set showcmd
set encoding=utf-8
syntax on

" remap escape insert mode
inoremap jk <ESC>

" Allow us to insert new lines without entering insert mode
nnoremap <Enter> i<Enter><ESC>

" Set up vundle and plugins"
set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Stop overwriting paste buffer when I delete one character
nnoremap "_x x
nnoremap "_X X

" Tab works from normal mode
nnoremap i<Tab><esc> <Tab>

" Easy swith betweem splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Substitute word under cursor in entire file
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>

"""""""""""""""" Relative numbering settings
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

autocmd FocusLost * :set number
autocmd FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
""""""""""""""""""""

call vundle#begin()
" Keep Plugin commands between vundle#begin/end.
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'suan/vim-instant-markdown'
"Plugin 'nvie/vim-flake8'
"Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'zoner14/vim_mumps'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()            " required

filetype plugin indent on    " required

let g:pymode_lint_on_fly = 1
let  g:pymode_folding = 0

let g:flake8_show_in_gutter=1
"To customize whether the show marks in the file, set g:flake8_show_in_file:
let g:flake8_show_in_file=1

" To ignore plugin indent changes, instead use:
" Filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal


""""""""""""""""" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['eslint', 'jshint']
"""""""""""""""

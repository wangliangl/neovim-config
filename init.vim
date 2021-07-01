set number
set showmatch
set shiftwidth =4
set tabstop=4
set encoding=utf-8
set autoindent
set clipboard=unnamed
set nocursorcolumn 
set nocursorline 
set backspace=2
set signcolumn=number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch            " 高亮显示搜索结果
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缓存设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup            " 设置不备份
set noswapfile          " 禁止生成临时文件
set autoread            " 文件在vim之外修改过，自动重新读入
set autowrite           " 设置自动保存

"
" 个性化文件列表
set confirm             " 在处理未保存或只读文件的时候，弹出确认

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

" 快捷操作替换空格为/
map <space> /
map <c-space> ?
map <leader><leader>c :nohlsearch<CR>
" 快速保存
nmap <leader>w :w!<cr>

call plug#begin('~/.vim/plugged')

" 快速对齐
Plug 'junegunn/vim-easy-align'

" coc 补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 目录树
Plug 'scrooloose/nerdtree'

" vim状态栏美化
Plug 'vim-airline/vim-airline'

" vim状态栏美化主题
Plug 'vim-airline/vim-airline-themes'

" vim tagbar
Plug 'majutsushi/tagbar'

" vim 批量注释
Plug 'tpope/vim-commentary'

" vim 快速跳转到想去的位置
Plug 'easymotion/vim-easymotion'

" vim 括号匹配插件
Plug 'jiangmiao/auto-pairs'

" vim 代码片段
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" vim快速搜索文件
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" vim 主题 molokai
Plug 'fatih/molokai'

" vim 主题
Plug 'morhetz/gruvbox'

" vim  go代码插件
Plug 'fatih/vim-go'

" vim 代码对齐线
Plug 'Yggdroot/indentLine'

" 个性化文件列表
Plug 'mhinz/vim-startify'

" vim文件类型支持
Plug 'ryanoasis/vim-devicons'

call plug#end()


" Set leader shortcut to a comma ','. By default it's the backslash
let mapleader = ','

nnoremap <leader>v :NERDTreeFind<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>t :TagbarToggle<cr>
nmap ss <Plug>(easymotion-s2)
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>

let g:indentLine_color_term = 243 " 对齐线的颜色
let g:indentLine_char = '┊' " 用字符串代替默认的标示线
" vim-go
let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1
" let g:go_bin_path = '$GOBIN'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

augroup go
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" Colorscheme
" syntax enable
" set t_Co=256
" let g:rehash256 = 1
" let g:molokai_original = 1
" let g:one_allow_italics = 1 
" colorscheme molokai

set bg=dark
colorscheme gruvbox
"去掉两边的scrollbar
set guioptions=


" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'

" 打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  " 设置浮动窗口打开的位置，大小等。
  " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  " 设置浮动窗口高亮
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction



" ctrl + b 跳转到函数，并在新的tab页面中打开
" nmap <silent> <C-b> :call CocAction('jumpDefinition', 'tab drop')<CR>
 nmap <silent> <C-b> :call CocAction('jumpDefinition')<CR>

" 设置按下tab时，是选择补全，而不是输入tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 回车选中补全，而不是换行
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else           
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" 
endif

"解决tab 冲突
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrgger="<leader><tab>"
let g:UltiSnipsListSnippets="<c-e>"

Return-Path: <linux-kernel+bounces-363585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C70599C444
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EE4285CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A81581F8;
	Mon, 14 Oct 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VniLSdMR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD8156C62
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896220; cv=none; b=n0BSw89228qWu+wiwJX/infjBOZMpMcfAj8Dk7ma02bprvkg1pP1iG4mI5xb4R6eRuIkYJjYQ6ZQj5tFGUPFlSWyoamotoHmnxECEUTd44YW0HSs5MPBnHH05MAWfj4ZzDSytxSfo88ok9Ur4N+SZkOF3PZiO6Iqt0InfnUEXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896220; c=relaxed/simple;
	bh=7PQCc5ZPvesJubjCVCYp0o4cv/kIIAwXvMmv5eCDMPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRET29tV1Qt4WTudRauIFkbN5Zt5psxS2fx/xFbxVufuhfmaf1BKs5FRG/YqmxRAohnkXyRPpnJk6e6Rf/hZH63TZVeqyg7zg73ixWq/BL9Ue/4pclCmU70fJepco6ErN0/11dV+BQ/DPXDOLA+CQOctlbtn7vEqZ+h+tXezDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VniLSdMR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728896218; x=1760432218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7PQCc5ZPvesJubjCVCYp0o4cv/kIIAwXvMmv5eCDMPc=;
  b=VniLSdMRdadXaXDIVQcNaO2uUDO9gJUaF0rz+fsq5+9dktkjpZtUxX4N
   +oxV+lWVkoXaowImeqGhipKxMKkOqLX5lHPf+1LaGCD0usJmE7UVZkE6A
   9z4Ui4YYK6Q/8ipSr2zw2TzjIjMTUt68TCdFBiFzDARL0qTrlCoUkKk1i
   xKP50Lajo3/zHk4UIPwN1KERmsEKRjDd2aeU7DGqYK6n3+qZvjYt9crhS
   +PdJP4s2DCzd21csK3VfD8wnhto0NM1sZbWUNk6xLeJ4x6RUsj0zMV/4T
   mcbTayJ44VMQ1qnFG85Ou7PkzDk2xPVYhIoWonlLFbNTijtU5gFdHC4AG
   w==;
X-CSE-ConnectionGUID: r/O7AUVxQ/egcc8FFkE0rw==
X-CSE-MsgGUID: Dyb6iLivRkuDtzolJ4vXWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="53654505"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="53654505"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 01:56:57 -0700
X-CSE-ConnectionGUID: O8FvCSjcT6qND7fvE9nJtw==
X-CSE-MsgGUID: BSVfV5QYR/qAcWD6fOLIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="108308189"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 01:56:54 -0700
Date: Mon, 14 Oct 2024 16:55:56 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	phillip.lougher@gmail.com,
	syzbot+604424eb051c2f696163@syzkaller.appspotmail.com,
	yi1.lai@intel.com
Subject: Re: [PATCH] Squashfs: Fix variable overflow triggered by sysbot
Message-ID: <ZwzcnCAosIPqQ9Ie@ly-workstation>
References: <20231113160901.6444-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113160901.6444-1-phillip@squashfs.org.uk>

Hi Phillip,

Greetings!

I used Syzkaller and found that there is KASAN: slab-out-of-bounds Write in squashfs_readpage_block

After bisection and the first bad commit is:
"
12427de9439d Squashfs: fix variable overflow triggered by sysbot
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241014_011832_squashfs_readpage_block
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241014_011832_squashfs_readpage_block/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241014_011832_squashfs_readpage_block/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241014_011832_squashfs_readpage_block/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241014_011832_squashfs_readpage_block/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241014_011832_squashfs_readpage_block/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241014_011832_squashfs_readpage_block/bzImage_9852d85ec9d492ebef56dc5f229416c925758edc
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241014_011832_squashfs_readpage_block/9852d85ec9d492ebef56dc5f229416c925758edc_dmesg.log

"
[   16.081397] SQUASHFS error: read_indexes: reading block [6dc:0]
[   16.081825] SQUASHFS error: Failed to read block 0x0: -5
[   16.083147] ==================================================================
[   16.083508] BUG: KASAN: slab-out-of-bounds in squashfs_readpage_block+0xa3b/0xbd0
[   16.083941] Write of size 8 at addr ffff88800eab5800 by task repro/726
[   16.084234] 
[   16.084315] CPU: 1 UID: 0 PID: 726 Comm: repro Not tainted 6.12.0-rc1-9852d85ec9d4+ #1
[   16.084671] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   16.085207] Call Trace:
[   16.085327]  <TASK>
[   16.085471]  dump_stack_lvl+0xea/0x150
[   16.085657]  print_report+0xce/0x610
[   16.085834]  ? squashfs_readpage_block+0xa3b/0xbd0
[   16.086063]  ? kasan_complete_mode_report_info+0x40/0x200
[   16.086332]  ? squashfs_readpage_block+0xa3b/0xbd0
[   16.086562]  kasan_report+0xcc/0x110
[   16.086794]  ? squashfs_readpage_block+0xa3b/0xbd0
[   16.087025]  __asan_report_store8_noabort+0x1b/0x30
[   16.087257]  squashfs_readpage_block+0xa3b/0xbd0
[   16.087486]  squashfs_read_folio+0x4c7/0x9c0
[   16.087715]  ? __pfx_squashfs_read_folio+0x10/0x10
[   16.087968]  ? down_read+0x143/0x4d0
[   16.088151]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   16.088426]  ? __pfx_squashfs_read_folio+0x10/0x10
[   16.088688]  filemap_read_folio+0x52/0x1c0
[   16.088913]  filemap_fault+0x451/0x27f0
[   16.089110]  ? __pfx_filemap_fault+0x10/0x10
[   16.089385]  ? __pfx_lock_release+0x10/0x10
[   16.089605]  __do_fault+0x112/0x870
[   16.089806]  do_fault+0xb76/0x1470
[   16.089977]  __handle_mm_fault+0x1589/0x2e60
[   16.090205]  ? __pfx___handle_mm_fault+0x10/0x10
[   16.090505]  ? __pfx_lock_release+0x10/0x10
[   16.090732]  ? follow_page_pte+0x53f/0x1860
[   16.090944]  handle_mm_fault+0x2c4/0x890
[   16.091159]  __get_user_pages+0x589/0x40b0
[   16.091388]  ? __pfx___get_user_pages+0x10/0x10
[   16.091670]  ? __this_cpu_preempt_check+0x21/0x30
[   16.091943]  ? lock_is_held_type+0xef/0x150
[   16.092158]  populate_vma_page_range+0x1fa/0x2e0
[   16.092426]  ? __pfx_populate_vma_page_range+0x10/0x10
[   16.092703]  ? userfaultfd_unmap_complete+0x227/0x340
[   16.092981]  __mm_populate+0x119/0x3e0
[   16.093183]  ? __pfx___mm_populate+0x10/0x10
[   16.093391]  ? up_write+0x1c0/0x550
[   16.093579]  ? lock_is_held_type+0xef/0x150
[   16.093862]  vm_mmap_pgoff+0x2c4/0x390
[   16.094086]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[   16.094293]  ? __fget_files+0x23c/0x4b0
[   16.094533]  ksys_mmap_pgoff+0x3dc/0x520
[   16.094729]  __x64_sys_mmap+0x139/0x1d0
[   16.094923]  x64_sys_call+0x18c6/0x20d0
[   16.095114]  do_syscall_64+0x6d/0x140
[   16.095296]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   16.095537] RIP: 0033:0x7f022363ee5d
[   16.095711] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   16.096544] RSP: 002b:00007ffe7d28fdd8 EFLAGS: 00000216 ORIG_RAX: 0000000000000009
[   16.096912] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f022363ee5d
[   16.097268] RDX: 000000000000000c RSI: 0000000000002000 RDI: 0000000020000000
[   16.097613] RBP: 00007ffe7d28fe00 R08: 0000000000000004 R09: 0020000000000000
[   16.097974] R10: 0000000000012812 R11: 0000000000000216 R12: 00007ffe7d28ff18
[   16.098312] R13: 00000000004026a9 R14: 0000000000404e08 R15: 00007f0223a00000
[   16.098762]  </TASK>
[   16.098871] 
[   16.098964] Allocated by task 726:
[   16.099195]  kasan_save_stack+0x2c/0x60
[   16.099431]  kasan_save_track+0x18/0x40
[   16.099615]  kasan_save_alloc_info+0x3c/0x50
[   16.099846]  __kasan_kmalloc+0x88/0xa0
[   16.100057]  __kmalloc_noprof+0x1cd/0x4a0
[   16.100335]  squashfs_readpage_block+0x269/0xbd0
[   16.100581]  squashfs_read_folio+0x4c7/0x9c0
[   16.100785]  filemap_read_folio+0x52/0x1c0
[   16.101083]  filemap_fault+0x451/0x27f0
[   16.101275]  __do_fault+0x112/0x870
[   16.101475]  do_fault+0xb76/0x1470
[   16.101692]  __handle_mm_fault+0x1589/0x2e60
[   16.101951]  handle_mm_fault+0x2c4/0x890
[   16.102149]  __get_user_pages+0x589/0x40b0
[   16.102414]  populate_vma_page_range+0x1fa/0x2e0
[   16.102705]  __mm_populate+0x119/0x3e0
[   16.102926]  vm_mmap_pgoff+0x2c4/0x390
[   16.103113]  ksys_mmap_pgoff+0x3dc/0x520
[   16.103333]  __x64_sys_mmap+0x139/0x1d0
[   16.103607]  x64_sys_call+0x18c6/0x20d0
[   16.103795]  do_syscall_64+0x6d/0x140
[   16.104024]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   16.104376] 
[   16.104460] The buggy address belongs to the object at ffff88800eab5000
[   16.104460]  which belongs to the cache kmalloc-2k of size 2048
[   16.105085] The buggy address is located 0 bytes to the right of
[   16.105085]  allocated 2048-byte region [ffff88800eab5000, ffff88800eab5800)
[   16.105826] 
[   16.105908] The buggy address belongs to the physical page:
[   16.106190] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xeab0
[   16.106686] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   16.107042] flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
[   16.107363] page_type: f5(slab)
[   16.107572] raw: 000fffffc0000040 ffff88800d442000 ffffea0000518200 dead000000000002
[   16.107934] raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[   16.108289] head: 000fffffc0000040 ffff88800d442000 ffffea0000518200 dead000000000002
[   16.108770] head: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[   16.109147] head: 000fffffc0000003 ffffea00003aac01 ffffffffffffffff 0000000000000000
"

I hope you find it useful.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Mon, Nov 13, 2023 at 04:09:01PM +0000, Phillip Lougher wrote:
> Sysbot reports a slab out of bounds write in squashfs_readahead().
> 
> This is ultimately caused by a file reporting an (infeasibly) large file
> size (1407374883553280 bytes) with the minimum block size of 4K.
> 
> This causes variable overflow.
> 
> Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
> Reported-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000b1fda20609ede0d1@google.com/
> ---
>  fs/squashfs/file.c        | 3 ++-
>  fs/squashfs/file_direct.c | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 8ba8c4c50770..e8df6430444b 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -544,7 +544,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
>  	struct squashfs_page_actor *actor;
>  	unsigned int nr_pages = 0;
>  	struct page **pages;
> -	int i, file_end = i_size_read(inode) >> msblk->block_log;
> +	int i;
> +	loff_t file_end = i_size_read(inode) >> msblk->block_log;
>  	unsigned int max_pages = 1UL << shift;
>  
>  	readahead_expand(ractl, start, (len | mask) + 1);
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index f1ccad519e28..763a3f7a75f6 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -26,10 +26,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>  	struct inode *inode = target_page->mapping->host;
>  	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>  
> -	int file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
> +	loff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
>  	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> -	int start_index = target_page->index & ~mask;
> -	int end_index = start_index | mask;
> +	loff_t start_index = target_page->index & ~mask;
> +	loff_t end_index = start_index | mask;
>  	int i, n, pages, bytes, res = -ENOMEM;
>  	struct page **page;
>  	struct squashfs_page_actor *actor;
> -- 
> 2.35.1
> 


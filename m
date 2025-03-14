Return-Path: <linux-kernel+bounces-560648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70363A607B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15513BEB77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D312B9B4;
	Fri, 14 Mar 2025 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOYZMRdU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426CA32
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741922203; cv=none; b=uOizVxfBjCGv/QgX5s8j1pzLR76fbKDgO/BQ+lSNu4vUA3Ec4nXfbl5NXgbPHuVsjWd3cAU+gjdyi03Rbew7DNg3GWkgSyfGnPfhAM7/Ky5Gh9fwvBQue/IK2OhAclNes+bI+6Ze+44MIxr6L3kcuJGrRb0fyLqNgAqAtdXqnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741922203; c=relaxed/simple;
	bh=ptJZgoFsiXIZcOdEXdmnP5ShHQIWqNPV3cxfd9w0VhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF4acZD3bVidfQnmP4mgDnYw2m65GNnAqQDWb3PuRntYjMO8z2yrM5DEYQNoQ9JupdLg4Dk0OXK2irZD/GcBjh05f6ZOjn5NUFpNBot8L4cIqVb5N55AOK6pGI0CyB5ZFofuC3UB6W3S6tr6OyHAnd92AJ+HFd+SfxznrhzVuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOYZMRdU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741922201; x=1773458201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptJZgoFsiXIZcOdEXdmnP5ShHQIWqNPV3cxfd9w0VhU=;
  b=OOYZMRdUWirrPf76c7V0gCPyqp95nWas5RVdHRqmHU1TI20OaJBgBzBd
   A3hlichFfS5yJ76Sb/7TPBgFyp1hYG+ZJwJmmpmU+rxRzGBbWq6HhrhZX
   k0KSudvilaoCjkZSyqrg2H9nF9ZtebKUwo5IUMkJS3yR/Z9+ojuCv18kk
   Zu4AShTq2M9BAD1d9x1EIZZb/R37juR3FBasJPgkXhQUHgBgP6chXhrfH
   a5+iWUEzdFpD11K0kR0CVTLCHx6xRk3aBsXgKi5IrCtG1hrgN5koqVpwF
   u/GNgA6ywDat0eE9A6qIQTXDaVlY1WOgy7D327BYKp9EfbUaLmUgM4mBK
   A==;
X-CSE-ConnectionGUID: n5dojhPoQgm5t1q28yz7aQ==
X-CSE-MsgGUID: 0DF76bx7QdisJxp6nLpqUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43272742"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43272742"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 20:16:39 -0700
X-CSE-ConnectionGUID: DBvRhw8pRBiiE+jAu8aMDw==
X-CSE-MsgGUID: zKpk+zn+RKmj6r3J5p5DxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152077946"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 20:16:37 -0700
Date: Fri, 14 Mar 2025 11:16:58 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, oliver.sang@intel.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to
 file rmap tree
Message-ID: <Z9OfqukbHB0lz72y@ly-workstation>
References: <20250312221521.1255690-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312221521.1255690-1-yang@os.amperecomputing.com>

On Wed, Mar 12, 2025 at 03:15:21PM -0700, Yang Shi wrote:
> LKP reported 800% performance improvement for small-allocs benchmark
> from vm-scalability [1] with patch ("/dev/zero: make private mapping
> full anonymous mapping") [2], but the patch was nack'ed since it changes
> the output of smaps somewhat.
> 
> The profiling shows one of the major sources of the performance
> improvement is the less contention to i_mmap_rwsem.
> 
> The small-allocs benchmark creates a lot of 40K size memory maps by
> mmap'ing private /dev/zero then triggers page fault on the mappings.
> When creating private mapping for /dev/zero, the anonymous VMA is
> created, but it has valid vm_file.  Kernel basically assumes anonymous
> VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
> rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
> will be inserted to the file rmap tree, this resulted in the contention
> to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
> to insert it to file rmap tree.
> 
> Skip anonymous VMA for this case.  Over 400% performance improvement was
> reported [3].
> 
> It is not on par with the 800% improvement from the original patch.  It is
> because page fault handler needs to access some members of struct file
> if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
> the same cacheline with file refcount.  When mmap'ing a file the file
> refcount is inc'ed and dec'ed, this caused bad cache false sharing
> problem.  The further debug showed checking whether the VMA is anonymous
> or not can alleviate the problem.  But I'm not sure whether it is the
> best way to handle it, maybe we should consider shuffle the layout of
> struct file.
> 
> However it sounds rare that real life applications would create that
> many maps with mmap'ing private /dev/zero and share the same struct
> file, so the cache false sharing problem may be not that bad.  But
> i_mmap_rwsem contention problem seems more real since all /dev/zero
> private mappings even from different applications share the same struct
> address_space so the same i_mmap_rwsem.  Inserting anonymous VMA into
> file rmap tree is also a broken behavior.  It is worth fixing from this
> perspective too.
> 
> [1] https://lore.kernel.org/linux-mm/202501281038.617c6b60-lkp@intel.com/
> [2] https://lore.kernel.org/linux-mm/20250113223033.4054534-1-yang@os.amperecomputing.com/
> [3] https://lore.kernel.org/linux-mm/Z6RshwXCWhAGoMOK@xsang-OptiPlex-9020/#t
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
> v2:
>    * Added the comments in code suggested by Lorenzo
>    * Collected R-b from Lorenze
> 
>  mm/vma.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index c7abef5177cc..2fe99d181cfd 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1648,6 +1648,10 @@ static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
>  void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
>  			       struct vm_area_struct *vma)
>  {
> +	/* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */
> +	if (vma_is_anonymous(vma))
> +		return;
> +
>  	if (vma->vm_file == NULL)
>  		return;
>  
> @@ -1671,8 +1675,13 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
>   */
>  void unlink_file_vma(struct vm_area_struct *vma)
>  {
> -	struct file *file = vma->vm_file;
> +	struct file *file;
> +
> +	/* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */
> +	if (vma_is_anonymous(vma))
> +		return;
>  
> +	file = vma->vm_file;
>  	if (file) {
>  		struct address_space *mapping = file->f_mapping;
>  
> @@ -1684,9 +1693,14 @@ void unlink_file_vma(struct vm_area_struct *vma)
>  
>  void vma_link_file(struct vm_area_struct *vma)
>  {
> -	struct file *file = vma->vm_file;
> +	struct file *file;
>  	struct address_space *mapping;
>  
> +	/* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */
> +	if (vma_is_anonymous(vma))
> +		return;
> +
> +	file = vma->vm_file;
>  	if (file) {
>  		mapping = file->f_mapping;
>  		i_mmap_lock_write(mapping);
> -- 
> 2.48.1
> 

Hi Yang Shi,

Greetings!

I used Syzkaller and found that there are two issues in v6.14-rc6 and were bisected to your patch as the first bad commit:
  general protection fault in vma_interval_tree_insert_after
  KASAN: slab-use-after-free Read in vma_interval_tree_insert

I see that you asked the patch to be dropped in maintainer's tree. I hope the issue dmesg can be insightful to you and the reproduction binary can be served to test your new design.

Issue one - general protection fault in vma_interval_tree_insert_after:

"
[   26.488762]  ? __rb_insert_augmented+0x7a/0x9d0
[   26.489380]  ? down_write+0x155/0x210
[   26.489879]  ? __pfx_down_write+0x10/0x10
[   26.490444]  vma_interval_tree_insert_after+0x2a2/0x370
[   26.491190]  copy_mm+0x11f6/0x2740
[   26.491702]  ? __pfx_copy_mm+0x10/0x10
[   26.492242]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   26.492934]  ? lockdep_hardirqs_on+0x89/0x110
[   26.493559]  ? __raw_spin_lock_init+0x44/0x120
[   26.494201]  copy_process+0x29d8/0x69c0
[   26.494752]  ? __pfx_copy_process+0x10/0x10
[   26.495352]  ? lock_is_held_type+0xef/0x150
[   26.495947]  ? __kasan_check_read+0x15/0x20
[   26.496548]  ? __lock_acquire+0x1bad/0x5d60
[   26.497202]  kernel_clone+0xfc/0x8c0
[   26.497574]  ? __pfx_kernel_clone+0x10/0x10
[   26.497979]  ? __pfx___lock_acquire+0x10/0x10
[   26.498370]  ? __pfx_do_mmap+0x10/0x10
[   26.498722]  __do_sys_clone+0xf5/0x140
[   26.499074]  ? __pfx___do_sys_clone+0x10/0x10
[   26.499478]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   26.500051]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   26.500485]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   26.500961]  __x64_sys_clone+0xc7/0x150
[   26.501445]  ? syscall_trace_enter+0x14d/0x280
[   26.501985]  x64_sys_call+0x1acf/0x2150
[   26.502475]  do_syscall_64+0x6d/0x140
[   26.502956]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   26.503410] RIP: 0033:0x7f286523ee5d
[   26.503739] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   26.505269] RSP: 002b:00007ffff77719f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[   26.505908] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f286523ee5d
[   26.506509] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   26.507116] RBP: 00007ffff7771a40 R08: 0000000000000000 R09: 0000000000000000
[   26.507717] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffff7771bb8
[   26.508309] R13: 000000000040183a R14: 0000000000403e08 R15: 00007f28655e3000
[   26.508911]  </TASK>
[   26.509112] Modules linked in:
[   26.509761] ---[ end trace 0000000000000000 ]---
[   26.510167] RIP: 0010:__rb_insert_augmented+0x7a/0x9d0
[   26.510615] Code: 89 e2 48 c1 ea 03 42 80 3c 32 00 0f 85 9c 05 00 00 4d 8b 2c 24 41 f6 c5 01 0f 85 88 01 00 00 4d 8d 45 08 4c 89 c2 48 c1 ea 03 <42> 80 3c 32 00 0f 85 95 05 00 00 4d 8b 7d 08 4d 39 e7 0f 84 78 01
[   26.512126] RSP: 0018:ffff88801d53f8d0 EFLAGS: 00010202
[   26.512569] RAX: ffffffff81d744d0 RBX: ffff888013c26970 RCX: ffff88800ed4ea80
[   26.513192] RDX: 0000000000000001 RSI: 1ffff11002784d2e RDI: ffff888013c26970
[   26.513787] RBP: ffff88801d53f918 R08: 0000000000000008 R09: ffffed1001da9d62
[   26.514376] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888021604830
[   26.514974] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888021604838
[   26.515568] FS:  00007f2865596740(0000) GS:ffff8880e368d000(0000) knlGS:0000000000000000
[   26.516235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.516742] CR2: 0000000020000000 CR3: 000000001f1f4003 CR4: 0000000000770ef0
[   26.517340] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.517930] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   26.518522] PKRU: 55555554
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_011927_vma_interval_tree_insert_after
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_011927_vma_interval_tree_insert_after/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_011927_vma_interval_tree_insert_after/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_011927_vma_interval_tree_insert_after/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_011927_vma_interval_tree_insert_after/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_011927_vma_interval_tree_insert_after/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250313_011927_vma_interval_tree_insert_after/bzImage_eea255893718268e1ab852fb52f70c613d109b99
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250313_011927_vma_interval_tree_insert_after/eea255893718268e1ab852fb52f70c613d109b99_dmesg.log

Issue two - KASAN: slab-use-after-free Read in vma_interval_tree_insert

"
[   18.362663] ==================================================================
[   18.363058] BUG: KASAN: slab-use-after-free in vma_interval_tree_insert+0x3ac/0x460
[   18.363448] Read of size 8 at addr ffff8880178025c8 by task repro/731
[   18.363756] 
[   18.363850] CPU: 1 UID: 0 PID: 731 Comm: repro Not tainted 6.14.0-rc6-next-20250311-eea255893718 #1
[   18.363858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   18.363865] Call Trace:
[   18.363872]  <TASK>
[   18.363877]  dump_stack_lvl+0xea/0x150
[   18.363905]  print_report+0xce/0x660
[   18.363918]  ? vma_interval_tree_insert+0x3ac/0x460
[   18.363926]  ? kasan_complete_mode_report_info+0x80/0x200
[   18.363934]  ? vma_interval_tree_insert+0x3ac/0x460
[   18.363940]  kasan_report+0xd6/0x110
[   18.363946]  ? vma_interval_tree_insert+0x3ac/0x460
[   18.363955]  __asan_report_load8_noabort+0x18/0x20
[   18.363961]  vma_interval_tree_insert+0x3ac/0x460
[   18.363969]  vma_prepare+0x23f/0x6b0
[   18.363981]  __split_vma+0x8df/0xe70
[   18.363988]  ? __pfx___split_vma+0x10/0x10
[   18.363995]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   18.364007]  ? mas_walk+0x6a7/0x8b0
[   18.364016]  vms_gather_munmap_vmas+0x17b/0xd40
[   18.364024]  __mmap_region+0x312/0x23e0
[   18.364032]  ? __pfx___mmap_region+0x10/0x10
[   18.364039]  ? __kasan_check_read+0x15/0x20
[   18.364049]  ? mark_lock.part.0+0xf2/0x17a0
[   18.364063]  ? __pfx_mark_lock.part.0+0x10/0x10
[   18.364069]  ? stack_trace_save+0x96/0xd0
[   18.364094]  ? __this_cpu_preempt_check+0x21/0x30
[   18.364107]  ? lock_is_held_type+0xef/0x150
[   18.364114]  mmap_region+0x1c0/0x3e0
[   18.364120]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   18.364128]  do_mmap+0xe0c/0x1270
[   18.364137]  ? __pfx_do_mmap+0x10/0x10
[   18.364144]  ? down_write_killable+0x163/0x250
[   18.364152]  ? __pfx_down_write_killable+0x10/0x10
[   18.364157]  ? __this_cpu_preempt_check+0x21/0x30
[   18.364166]  vm_mmap_pgoff+0x233/0x3d0
[   18.364176]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[   18.364182]  ? __fget_files+0x204/0x3b0
[   18.364196]  ksys_mmap_pgoff+0x3dc/0x520
[   18.364206]  __x64_sys_mmap+0x139/0x1d0
[   18.364218]  x64_sys_call+0x200d/0x2150
[   18.364226]  do_syscall_64+0x6d/0x140
[   18.364235]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.364241] RIP: 0033:0x7ff9b4c3ee5d
[   18.364249] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   18.364255] RSP: 002b:00007ffdbb3b6718 EFLAGS: 00000216 ORIG_RAX: 0000000000000009
[   18.364269] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff9b4c3ee5d
[   18.364272] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000020ffc000
[   18.364276] RBP: 00007ffdbb3b6740 R08: 0000000000000005 R09: 0000000000000000
[   18.364279] R10: 0000000000000012 R11: 0000000000000216 R12: 00007ffdbb3b6898
[   18.364283] R13: 000000000040181e R14: 0000000000403e08 R15: 00007ff9b4f19000
[   18.364290]  </TASK>
[   18.364292] 
[   18.376442] Allocated by task 730:
[   18.376616]  kasan_save_stack+0x2c/0x60
[   18.376812]  kasan_save_track+0x18/0x40
[   18.377004]  kasan_save_alloc_info+0x3c/0x50
[   18.377220]  __kasan_slab_alloc+0x62/0x80
[   18.377417]  kmem_cache_alloc_noprof+0x13d/0x440
[   18.377649]  vm_area_alloc+0x29/0x180
[   18.377839]  __mmap_region+0xced/0x23e0
[   18.378033]  mmap_region+0x1c0/0x3e0
[   18.378464]  do_mmap+0xe0c/0x1270
[   18.378807]  vm_mmap_pgoff+0x233/0x3d0
[   18.379188]  ksys_mmap_pgoff+0x3dc/0x520
[   18.379584]  __x64_sys_mmap+0x139/0x1d0
[   18.379968]  x64_sys_call+0x200d/0x2150
[   18.380353]  do_syscall_64+0x6d/0x140
[   18.380724]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.381219] 
[   18.381389] Freed by task 24:
[   18.381694]  kasan_save_stack+0x2c/0x60
[   18.382191]  kasan_save_track+0x18/0x40
[   18.382387]  kasan_save_free_info+0x3f/0x60
[   18.382591]  __kasan_slab_free+0x3d/0x60
[   18.382784]  slab_free_after_rcu_debug+0xdb/0x2b0
[   18.383016]  rcu_core+0x86b/0x1920
[   18.383198]  rcu_core_si+0x12/0x20
[   18.383368]  handle_softirqs+0x1c5/0x860
[   18.383563]  run_ksoftirqd+0x46/0x70
[   18.383739]  smpboot_thread_fn+0x666/0xa20
[   18.383942]  kthread+0x444/0x980
[   18.384114]  ret_from_fork+0x56/0x90
[   18.384296]  ret_from_fork_asm+0x1a/0x30
[   18.384487] 
[   18.384572] Last potentially related work creation:
[   18.384804]  kasan_save_stack+0x2c/0x60
[   18.384993]  kasan_record_aux_stack+0x93/0xa0
[   18.385211]  kmem_cache_free+0x1b8/0x540
[   18.385402]  vm_area_free+0xa5/0xd0
[   18.385584]  remove_vma+0x135/0x180
[   18.385763]  vms_complete_munmap_vmas+0x432/0x810
[   18.386000]  __mmap_region+0x70c/0x23e0
[   18.386193]  mmap_region+0x1c0/0x3e0
[   18.386377]  do_mmap+0xe0c/0x1270
[   18.386545]  vm_mmap_pgoff+0x233/0x3d0
[   18.386737]  ksys_mmap_pgoff+0x3dc/0x520
[   18.386937]  __x64_sys_mmap+0x139/0x1d0
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_133334_vma_interval_tree_insert
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_133334_vma_interval_tree_insert/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_133334_vma_interval_tree_insert/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_133334_vma_interval_tree_insert/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_133334_vma_interval_tree_insert/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250313_133334_vma_interval_tree_insert/bisect_info.log
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250313_133334_vma_interval_tree_insert/eea255893718268e1ab852fb52f70c613d109b99_dmesg.log

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



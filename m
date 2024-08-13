Return-Path: <linux-kernel+bounces-284498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D795019F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C392844D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941C194AD7;
	Tue, 13 Aug 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI1p9FV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E6189F2A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542732; cv=none; b=Dn+8MMDNL0Zww+Z55bdhrQSi9MKhwAZmTeBeLlbGcFBTeC0BRtzxxfJN+KwxXAe/ZnoGKllOoWYjYvvPbGLjAhI1l9b/RImz79NYZYSmkRtFtwth0DNzYcc71aEN2AFtslLP++Mi1o9MJ4wIfL941eBMhWZkC7NWh1l5u8O1hxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542732; c=relaxed/simple;
	bh=mliOT5sF/c6G1ykt7Gg/Ps9h7dqFg8KEdYmAxnjEAUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzGO7D8MbiAu8mwANrXxQ/s/I3hEEXiGnvweQHC8ZBUziRld4AhmLo3LGRmdzK41ljigPWSKzoQhW4ZmDzp0dLityfyIKzpwiw0AXg/Bxhrm9SybdiGqWiO3EMRVJHJl5crYHh3GIRjMvphoUQorAVGDg3uk+hLFb0r/LEzETig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI1p9FV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83BAC4AF0B;
	Tue, 13 Aug 2024 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542731;
	bh=mliOT5sF/c6G1ykt7Gg/Ps9h7dqFg8KEdYmAxnjEAUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VI1p9FV2r5Tk28XdZ1eYLjP3i+8xYJ5M4xN91ntF1WztILdIkCSOum+1aV7/BBbHr
	 x/0xkAWYmMrj3N70U2apPifiGOV3FeXCaVlI4WT/8ghcOASpFxFLMgpXfUCp3NF6YO
	 2XMxuP8jCPBYi5QMr2bAJWUV8U3Nc+62Nzgruu6au7Af25AFLeGD7SbNBkTx6ZfTLA
	 /Fi77CKxRZ30fjfrEAj4tAqK96HItvvkORB8H5TwvRWGsoEfSkN9lcdTHvoYQz+D0g
	 rtehWXadNgbyhU9PWn12k4L9o2Cj0P/NPUdHybqadsh6qyQL6FrL8Zz1nJ3PbWeLdh
	 SSfegY0jc8sSw==
Message-ID: <c628b268-1690-430d-9d55-af62b81754fa@kernel.org>
Date: Tue, 13 Aug 2024 17:52:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: slab-use-after-free Read in __destroy_extent_node
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: jaegeuk <jaegeuk@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <b9664c53-fab0-42ba-9dc0-e7cb9601bbb0.bugreport@valiantsec.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <b9664c53-fab0-42ba-9dc0-e7cb9601bbb0.bugreport@valiantsec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/5 9:33, Ubisectech Sirius wrote:
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.8. Attached to the email were a PoC file of the issue.

Hi, syzbot has reported this issue, and it has been fixed by below commit.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7409b05a64f212735f0d33f5f1602051a886eab

Thanks,

> 
> Stack dump:
> 
> R13: 000000000000006e R14: 00007f03a5b34078 R15: 00007f03a6781000
>   </TASK>
> F2FS-fs (loop3): sanity_check_extent_cache: inode (ino=8) extent info [5634, 0, 3] is incorrect, run fsck to fix
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: slab-use-after-free in __destroy_extent_node+0xb8/0x260 fs/f2fs/extent_cache.c:1061
> Read of size 4 at addr ffff8880516c3070 by task syz.3.23/9717
> 
> CPU: 1 PID: 9717 Comm: syz.3.23 Not tainted 6.10.0-rc6-g1dfe225e9af5 #48
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0xc0/0x5e0 mm/kasan/report.c:488
>   kasan_report+0xbd/0xf0 mm/kasan/report.c:601
>   check_region_inline mm/kasan/generic.c:183 [inline]
>   kasan_check_range+0xf4/0x1a0 mm/kasan/generic.c:189
>   instrument_atomic_read include/linux/instrumented.h:68 [inline]
>   atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>   __destroy_extent_node+0xb8/0x260 fs/f2fs/extent_cache.c:1061
>   __destroy_extent_tree+0x14a/0x6f0 fs/f2fs/extent_cache.c:1126
>   f2fs_destroy_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1143
>   f2fs_evict_inode+0x3ff/0x1da0 fs/f2fs/inode.c:837
>   evict+0x2ed/0x6c0 fs/inode.c:667
>   iput_final fs/inode.c:1741 [inline]
>   iput.part.0+0x559/0x760 fs/inode.c:1767
>   iput+0x5c/0x80 fs/inode.c:1757
>   f2fs_iget+0xfe6/0x5a40 fs/f2fs/inode.c:627
>   f2fs_nfs_get_inode fs/f2fs/super.c:3265 [inline]
>   f2fs_nfs_get_inode+0x86/0x130 fs/f2fs/super.c:3251
>   generic_fh_to_dentry+0xdf/0x110 fs/libfs.c:1456
>   exportfs_decode_fh_raw+0x12b/0x7a0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x90 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x2bc/0x590 fs/fhandle.c:226
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f03a59958cd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f03a67a0fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
> RAX: ffffffffffffffda RBX: 00007f03a5b34078 RCX: 00007f03a59958cd
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000004
> RBP: 00007f03a5a2d6e6 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007f03a5b34078 R15: 00007f03a6781000
>   </TASK>
> 
> Allocated by task 9642:
>   kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   unpoison_slab_object mm/kasan/common.c:312 [inline]
>   __kasan_slab_alloc+0x87/0x90 mm/kasan/common.c:338
>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>   slab_post_alloc_hook mm/slub.c:3940 [inline]
>   slab_alloc_node mm/slub.c:4002 [inline]
>   kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4009
>   f2fs_kmem_cache_alloc_nofail fs/f2fs/f2fs.h:2815 [inline]
>   f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2825 [inline]
>   __grab_extent_tree+0x27c/0x5b0 fs/f2fs/extent_cache.c:334
>   f2fs_init_read_extent_tree+0x1e2/0x710 fs/f2fs/extent_cache.c:405
>   do_read_inode fs/f2fs/inode.c:512 [inline]
>   f2fs_iget+0x1e1e/0x5a40 fs/f2fs/inode.c:566
>   f2fs_nfs_get_inode fs/f2fs/super.c:3265 [inline]
>   f2fs_nfs_get_inode+0x86/0x130 fs/f2fs/super.c:3251
>   generic_fh_to_dentry+0xdf/0x110 fs/libfs.c:1456
>   exportfs_decode_fh_raw+0x12b/0x7a0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x90 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x2bc/0x590 fs/fhandle.c:226
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 9642:
>   kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
>   poison_slab_object mm/kasan/common.c:240 [inline]
>   poison_slab_object+0xf9/0x180 mm/kasan/common.c:211
>   __kasan_slab_free+0x33/0x50 mm/kasan/common.c:256
>   kasan_slab_free include/linux/kasan.h:184 [inline]
>   slab_free_hook mm/slub.c:2196 [inline]
>   slab_free mm/slub.c:4438 [inline]
>   kmem_cache_free+0x12a/0x3a0 mm/slub.c:4513
>   __destroy_extent_tree+0x1f8/0x6f0 fs/f2fs/extent_cache.c:1132
>   f2fs_destroy_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1143
>   f2fs_evict_inode+0x3ff/0x1da0 fs/f2fs/inode.c:837
>   evict+0x2ed/0x6c0 fs/inode.c:667
>   iput_final fs/inode.c:1741 [inline]
>   iput.part.0+0x559/0x760 fs/inode.c:1767
>   iput+0x5c/0x80 fs/inode.c:1757
>   f2fs_iget+0xfe6/0x5a40 fs/f2fs/inode.c:627
>   f2fs_nfs_get_inode fs/f2fs/super.c:3265 [inline]
>   f2fs_nfs_get_inode+0x86/0x130 fs/f2fs/super.c:3251
>   generic_fh_to_dentry+0xdf/0x110 fs/libfs.c:1456
>   exportfs_decode_fh_raw+0x12b/0x7a0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x90 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x2bc/0x590 fs/fhandle.c:226
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff8880516c3000
>   which belongs to the cache f2fs_extent_tree of size 144
> The buggy address is located 112 bytes inside of
>   freed 144-byte region [ffff8880516c3000, ffff8880516c3090)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x516c3
> flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffefff(slab)
> raw: 04fff00000000000 ffff888042d6c640 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000080130013 00000001ffffefff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x152c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 9642, tgid 9641 (syz.3.23), ts 151346879967, free_ts 0
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x2e7/0x350 mm/page_alloc.c:1473
>   prep_new_page mm/page_alloc.c:1481 [inline]
>   get_page_from_freelist+0xbf4/0x2850 mm/page_alloc.c:3425
>   __alloc_pages_noprof+0x214/0x21e0 mm/page_alloc.c:4683
>   __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>   alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>   alloc_slab_page+0x5d/0x120 mm/slub.c:2265
>   allocate_slab mm/slub.c:2428 [inline]
>   new_slab+0x83/0x260 mm/slub.c:2481
>   ___slab_alloc+0xbb7/0x1850 mm/slub.c:3667
>   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
>   __slab_alloc_node mm/slub.c:3810 [inline]
>   slab_alloc_node mm/slub.c:3990 [inline]
>   kmem_cache_alloc_noprof+0x2a8/0x2f0 mm/slub.c:4009
>   f2fs_kmem_cache_alloc_nofail fs/f2fs/f2fs.h:2815 [inline]
>   f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2825 [inline]
>   __grab_extent_tree+0x27c/0x5b0 fs/f2fs/extent_cache.c:334
>   f2fs_init_read_extent_tree+0x1e2/0x710 fs/f2fs/extent_cache.c:405
>   do_read_inode fs/f2fs/inode.c:512 [inline]
>   f2fs_iget+0x1e1e/0x5a40 fs/f2fs/inode.c:566
>   f2fs_nfs_get_inode fs/f2fs/super.c:3265 [inline]
>   f2fs_nfs_get_inode+0x86/0x130 fs/f2fs/super.c:3251
>   generic_fh_to_dentry+0xdf/0x110 fs/libfs.c:1456
>   exportfs_decode_fh_raw+0x12b/0x7a0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x90 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x2bc/0x590 fs/fhandle.c:226
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>   ffff8880516c2f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8880516c2f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff8880516c3000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                               ^
>   ffff8880516c3080: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8880516c3100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> Thank you for taking the time to read this email and we look forward to working with you further.
> 
> 
> 
> 



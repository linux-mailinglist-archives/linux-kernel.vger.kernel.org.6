Return-Path: <linux-kernel+bounces-421994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B69D9303
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CDBB24A89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521B190072;
	Tue, 26 Nov 2024 08:03:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64664143748
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608185; cv=none; b=jOzVm880XSdjAR+v8BfDJ7Iq9gvYj12P8IXazGrk7hSzSEucFuOWVl3pG6Sz43e0oFfMHXLUS1rx61Enp7YJ1pE3yjwl0WnMk76bLqmuj74vFpY3Kc5O6IO5SBWtRuczzGWGeqnMc+hoh9XKzk82dVj1HVea3BU6hFYLYzr/K5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608185; c=relaxed/simple;
	bh=rgQRTlp5HJ8EycX45gDQvugfetWO31DEQjd3014jrDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZCBV4MxSRNdR5RhB5uHMYq+dDPzhtcw4qym3aanPd3vaaroXta4pLbhNjWblEshVKHKzNJSWc6zaqyZvy2VSDJVNXiQrGRr2sZvcohumBjxNvM9NHvYoqe2LbTW7HrE12oU7NWSFppVQd9sIxpqFu/SO39AsmNw5CdtIsStl4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so37331145ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608182; x=1733212982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/CB/cpl92LzEHbPaYsTh/uURIg4ljI7Sokgz4uTg08=;
        b=fQwDGeQ8WYrEiqDDYg/VpzDOgZOHWxfrCxQK1TZaBHkCn9Tt/cGBMN5pe9KCvR7b+V
         wdld91bANHWyOmfG3HhHvxAlEpaTG8PiwKcI4LCjS5C9PabtXKqJaP/Be3Iiwg7PhilD
         LDNfHGkfJbJ+w5TA6mxWG3Og20OL+PhlNrM38XYQNV/Ve0W2Gyc5QoX8Muj0t2xcjJrq
         qf/OHsxQ49tH9REU30zJYf9k8b2cahczeocKDTzASBhWuGg6A7dEKgog7wzcqtDJXP5N
         g+f9F6qps4nwPtbo2HzCQH0OLaAAk4Jy3IXvIEevBZnO3m4BjNqm4RhzNxhmIWPk7wqf
         Xgig==
X-Forwarded-Encrypted: i=1; AJvYcCUKjmUJLcDX7q5zV0LBcwliUGs1+L1dKQJQ0hpzqHb59GWFG+S0OJAKztGQUhDlCh6nZ4wIxEByLUgRf6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvn5hq75Lm2yPC7gU42+5ZmQAYgmGnFMRx/FwpsrFwzxMtr4ey
	feFEeZ0INGyCBLe3xR5ZfddV9IxQDl05PdJwyM+679MMnfdYPX9iR1YFBJNZa1h9TBB5YZ/aLX4
	1A+dFBXfBGQnh8BDJaF+BUkOaUXWHvXv47bmM2aJ+oFJo6rMZIPSbgIE=
X-Google-Smtp-Source: AGHT+IEvRMG2ifwsTfzj4SSD+fii4f3iRe9c65vDVUznt8I7+8JiR3AO9qz4X2f6eJIq1zqlbcjvwDk8vjJhrQ7+9NLquzUIn6bC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1524:b0:3a7:87f2:b00e with SMTP id
 e9e14a558f8ab-3a79af7b337mr159748145ab.19.1732608182474; Tue, 26 Nov 2024
 00:03:02 -0800 (PST)
Date: Tue, 26 Nov 2024 00:03:02 -0800
In-Reply-To: <tencent_5ED3752374297923ADA44E776F777CC6C005@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674580b6.050a0220.1286eb.0012.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: slab-out-of-bounds Read in ovl_inode_upper
From: syzbot <syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in ovl_inode_upper

loop0: detected capacity change from 0 to 2048
==================================================================
BUG: KASAN: slab-out-of-bounds in ovl_upperdentry_dereference fs/overlayfs/ovl_entry.h:195 [inline]
BUG: KASAN: slab-out-of-bounds in ovl_i_dentry_upper fs/overlayfs/util.c:366 [inline]
BUG: KASAN: slab-out-of-bounds in ovl_inode_upper+0x36/0x80 fs/overlayfs/util.c:386
Read of size 8 at addr ffff8880728b3f40 by task syz.0.15/6652

CPU: 0 UID: 0 PID: 6652 Comm: syz.0.15 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 ovl_upperdentry_dereference fs/overlayfs/ovl_entry.h:195 [inline]
 ovl_i_dentry_upper fs/overlayfs/util.c:366 [inline]
 ovl_inode_upper+0x36/0x80 fs/overlayfs/util.c:386
 ovl_file_accessed+0x7e/0x370 fs/overlayfs/file.c:307
 backing_file_mmap+0x1f8/0x260 fs/backing-file.c:345
 ovl_mmap+0x1c9/0x220 fs/overlayfs/file.c:487
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x2204/0x2cd0 mm/vma.c:2456
 mmap_region+0x1d0/0x2c0 mm/mmap.c:1347
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f111e37e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f111f22f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f111e535fa0 RCX: 00007f111e37e819
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000020ffc000
RBP: 00007f111e3f175e R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f111e535fa0 R15: 00007ffc35013e98
 </TASK>

Allocated by task 6652:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_lru_noprof+0x1dd/0x390 mm/slub.c:4172
 nilfs_alloc_inode+0x2e/0x110 fs/nilfs2/super.c:158
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 iget5_locked+0x4a/0xa0 fs/inode.c:1404
 nilfs_iget_locked fs/nilfs2/inode.c:535 [inline]
 nilfs_iget+0x130/0x810 fs/nilfs2/inode.c:544
 nilfs_lookup+0x198/0x210 fs/nilfs2/namei.c:69
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1791
 lookup_slow fs/namei.c:1808 [inline]
 lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2966
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
 lookup_open fs/namei.c:3627 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x11a7/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_open fs/open.c:1425 [inline]
 __se_sys_open fs/open.c:1421 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880728b3960
 which belongs to the cache nilfs2_inode_cache of size 1504
The buggy address is located 0 bytes to the right of
 allocated 1504-byte region [ffff8880728b3960, ffff8880728b3f40)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x728b0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88807e515401
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888140fa9140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080140014 00000001f5000000 ffff88807e515401
head: 00fff00000000040 ffff888140fa9140 dead000000000122 0000000000000000
head: 0000000000000000 0000000080140014 00000001f5000000 ffff88807e515401
head: 00fff00000000003 ffffea0001ca2c01 ffffffffffffffff 0000000000000000
head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 6652, tgid 6651 (syz.0.15), ts 115182091449, free_ts 67917668748
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_lru_noprof+0x26c/0x390 mm/slub.c:4172
 nilfs_alloc_inode+0x2e/0x110 fs/nilfs2/super.c:158
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 iget5_locked+0x4a/0xa0 fs/inode.c:1404
 nilfs_iget_locked+0x113/0x160 fs/nilfs2/inode.c:535
 nilfs_dat_read+0xc3/0x320 fs/nilfs2/dat.c:511
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:118 [inline]
 load_nilfs+0x56f/0x1090 fs/nilfs2/the_nilfs.c:299
 nilfs_fill_super+0x31e/0x720 fs/nilfs2/super.c:1067
page last free pid 5825 tgid 5825 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:962
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 vms_clear_ptes+0x437/0x530 mm/vma.c:1143
 vms_complete_munmap_vmas+0x210/0x8f0 mm/vma.c:1185
 do_vmi_align_munmap+0x5ef/0x6f0 mm/vma.c:1444
 do_vmi_munmap+0x24e/0x2d0 mm/vma.c:1492
 __vm_munmap+0x24c/0x480 mm/mmap.c:1367
 __do_sys_munmap mm/mmap.c:1384 [inline]
 __se_sys_munmap mm/mmap.c:1381 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1381
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880728b3e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880728b3e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880728b3f00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                           ^
 ffff8880728b3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880728b4000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         7eef7e30 Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a50f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929ae6e898cb218f
dashboard link: https://syzkaller.appspot.com/bug?extid=8d1206605b05ca9a0e6a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


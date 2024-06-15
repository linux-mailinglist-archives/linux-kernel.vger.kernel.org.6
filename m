Return-Path: <linux-kernel+bounces-215750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41E90969E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415F5285259
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717517BC9;
	Sat, 15 Jun 2024 07:46:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EC17580
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718437567; cv=none; b=Gr07vHgp91cn84cLtct5Hoj/nFTwFVFy110kT6eRFG09hulKk1G6Dd4eEnILdx5zRA8rYhArNxIZi+KzRX7wKb3W6CGEgY8VcqyeZGRJQcgSUCQe8a2ZUriZoCO2/JQZ446MJO7C5UO9Kz8wYkkphU+XBbmDqERyNEgprS2woUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718437567; c=relaxed/simple;
	bh=qN8ICJ8Su3tTS49NGea8m+Al2o50S/Hy2FxWett1vhA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eStA6Vh1uGoOKcGg5d8HTGoAxqs6prsVodpKewVo1+JobjHTpZitMrFZJht0F1dOWRDJGit3Zrp2LQvporBEwwQ86vFi0xfx7+qIcqNeTrbrxU+DX5Wj9GqAe7fF1gEF1TazzYwx3y2kxrgCQ4Lly2ACifyfnCZfBJFOQKCnH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ec0802fd0dso7868439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718437565; x=1719042365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2oNtY4+LOIsxoYFROaeF1Y88BbaVtM9v9Y7ZvnKs84=;
        b=Kaafbl1FJXM4VZvfJWUb7IcWpyzHxArJmQ1UKk8anjVyRhIMvDV2+4a2JStgXzr6nI
         JohYI33kFqd3FJhRjcCLQtQOUElPKaJxsw+i4udKvUma6Q2NwkhFHYTSxkD2E2HeJIaV
         Ox9JTyqI4OkC7lCcFfwJqPWLHC2UHv6dLusrGz0kzZZ+2BrmMk3gnBit91ncqDwhiVis
         ZiLRd0N8lXhG8MrzVliZzTjtxnaf3mM7TB9TmvepRqSsPWXC1/7Au0tz+qXIs0NIPOVy
         EenIjKXkbHPwt2DZDVjMMUaNV0EzinsL8TDJTpeJtaJTJZg9thvgnvzmVMlTdX/71LRt
         rAew==
X-Forwarded-Encrypted: i=1; AJvYcCXk0eSzNPzQTomlQYDg8TekHt/ZNpK+tOD6Q5A/PFUhFOLcYlwcbCuq+vPT9lC+oh7Xf+Iwhj/BYAQG0Rgmz2hs1Zt+EWoLP5dmNp3R
X-Gm-Message-State: AOJu0Yyeif067HoCvZjGe5HzNM2LBdhf48rwJNBh2mH+5Y0GH9KbN7Hq
	TsbJCenu29pjVd3e/Fbo0eZnOHof7dIgZblXw3QQilLUQbce1yfoiwqksEoRyP490uVGBlsJFSc
	uX5yqJjHoYuQfvdqrZZO8Lkf6qH+O5YnCgQegSNX/3PzeydLmgYIPeFE=
X-Google-Smtp-Source: AGHT+IEQJJAItLfsG2iLpOkPOP7ymyHftymR7TRKTFbfZ07qG9liV6eih3e9o9nL+ife/QD6JH0RA0yOVZQJDQgfIZc9HM8y4iDZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:268c:b0:4b7:c86f:f3cf with SMTP id
 8926c6da1cb9f-4b9640aeab2mr293832173.3.1718437564807; Sat, 15 Jun 2024
 00:46:04 -0700 (PDT)
Date: Sat, 15 Jun 2024 00:46:04 -0700
In-Reply-To: <20240615064746.915-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e8ef5061ae8eccc@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in chrdev_open

loop0: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
Read of size 8 at addr ffff888063a27ca8 by task syz-executor.0/5468

CPU: 0 PID: 5468 Comm: syz-executor.0 Not tainted 6.10.0-rc3-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 chrdev_open+0x2a9/0x630 fs/char_dev.c:396
 do_dentry_open+0x9f9/0x1760 fs/open.c:965
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8bc307dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8bc2bff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f8bc31abf80 RCX: 00007f8bc307dea9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 00007f8bc30ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8bc31abf80 R15: 00007ffe28199b08
 </TASK>

Allocated by task 5455:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4020
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:563
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 ntfs_new_inode+0x45/0x100 fs/ntfs3/fsntfs.c:1688
 ntfs_create_inode+0x5f1/0x3680 fs/ntfs3/inode.c:1347
 ntfs_mknod+0x3c/0x50 fs/ntfs3/namei.c:122
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4009
 do_mknodat+0x3ec/0x5b0
 __do_sys_mknodat fs/namei.c:4087 [inline]
 __se_sys_mknodat fs/namei.c:4084 [inline]
 __x64_sys_mknodat+0xa9/0xc0 fs/namei.c:4084
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4512
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1538
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1555
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
 kill_block_super+0x44/0x90 fs/super.c:1676
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1798
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888063a27600
 which belongs to the cache ntfs_inode_cache of size 1760
The buggy address is located 1704 bytes inside of
 freed 1760-byte region [ffff888063a27600, ffff888063a27ce0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x63a20
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880247d1f01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff88801aae6500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001ffffefff ffff8880247d1f01
head: 00fff00000000040 ffff88801aae6500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000110011 00000001ffffefff ffff8880247d1f01
head: 00fff00000000003 ffffea00018e8801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5455, tgid 5454 (syz-executor.0), ts 83365626429, free_ts 16584706916
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e43/0x2f00 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4020
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:563
 alloc_inode fs/inode.c:261 [inline]
 iget5_locked+0xa4/0x280 fs/inode.c:1235
 ntfs_iget5+0xd5/0x3b10 fs/ntfs3/inode.c:532
 ntfs_fill_super+0x2619/0x4a20 fs/ntfs3/super.c:1212
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2583
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6637
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1038
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1418
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888063a27b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888063a27c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888063a27c80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                  ^
 ffff888063a27d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888063a27d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f7d146980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111dc1de980000



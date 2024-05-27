Return-Path: <linux-kernel+bounces-190499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F390E8CFF46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237F71C222C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850715ECCA;
	Mon, 27 May 2024 11:48:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569115E5CE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810486; cv=none; b=EQPpN9nxikfo76mMTEdhOg121Yrpz00qWyOFFYW2JPHihC5hFNbXbWvD/DMcirw+Dkux+MzRF757XDhfgG6yjR/8f4HUrEtXskticru2gnPczGfnyJdbWvqI3gwslxgJA86Q2eQQzKwSOR2IlD8QphzeC5nGhc06waCdbya0hdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810486; c=relaxed/simple;
	bh=X4eStoHGKPNDbN3uHOCtPGZHzO2t2ipCA5maGQLWAWE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gff0IC+kxPUfAkc8+A9FmXYZSV05y85347AjIgfem4hibCyBn3zQa7lkaDs7I9FYFdDdzDtkznKnuWMq58vtAcTC+ZjJ8p18igJJ7dXfOdhYTW9oI/ktoqyN5Y3rbeZW8ZoO8sYIjI6Tp8ow2FRXG3t91es+wVk8KTUHpwj/O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1ea8608afso546604539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716810483; x=1717415283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RP1N2gYDPbAEzJ+dxnfId0QFiJ91EZiMV5boeOnTDQ=;
        b=xCdCxlF8v4ZLtD9cfxWQ613w9/Pp6JKm0WB16nvCA59FGCdG4TA1dJvw6MChiSfMK3
         vQrsxBkX06dS6knb4YwyFlrbs/Fqz0TPUmY2rRVX3uGHC+uJaAfLI0aUaB55O6xy/8eZ
         tPV7kc85tIJn91JDEU19uUdS9bGbHAP3SfOfU4gyz7k6Y2u++tN0g9fhQR/V9pjJYj2q
         5V2gP3fmtoz7jDizAok0w7biNXicLODJbjADohYg++vrl1I5eCMhmNxbNmDO+WTVVxfy
         OWUjDpHRa5BES6vr5X5K/RfxLiNfXOwM5qMIbShmEcUULywBwd1H21ZpKnEUuDF4sqzH
         /vvg==
X-Forwarded-Encrypted: i=1; AJvYcCWUbSzMrWrX/dVB0vJPCsqTld67rpzkkeoB6EwMdrGUuBzZOxLTmXf7KIMQmX/xl9Er4Gyzb91qaL0P/WyQTm4VK2E857W1w3v4m02J
X-Gm-Message-State: AOJu0YxX5FfH/bCjYbiuocj+XUrb1LoUifQu3S+eqGD3ZoCzyzYIzskc
	LbXShKNU1buA8ht0FOWHEIEs4R1kesmVNMHeCrZoiFzHXWfMW7qh5TetD0K5V+B/6JPqi6G3JfN
	6xqOpr5gRwj7jr8CSyLUguRm1kcYF2QMWPjB/EFK22xqmG6hQQXhl2dM=
X-Google-Smtp-Source: AGHT+IFHiB7ZZWWc1m/OJaIwnyyvdLmG31gTeXsmwI7YFgXuDGRyVBSr1L0KBqKxNhN4ssbYEh8usXL9GNC6AHVdfEuv85OqXHoS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:158d:b0:7e2:b00:2277 with SMTP id
 ca18e2360f4ac-7e8c6933fa2mr46561839f.2.1716810483639; Mon, 27 May 2024
 04:48:03 -0700 (PDT)
Date: Mon, 27 May 2024 04:48:03 -0700
In-Reply-To: <0a7a190a-edcf-492a-9ba2-868ea50c2cde@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000635f606196e1726@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in chrdev_open

loop0: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
Read of size 8 at addr ffff88807efaede8 by task syz-executor.0/5465

CPU: 1 PID: 5465 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-g1613e604df0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
 do_dentry_open+0x95a/0x1720 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb3347dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcb341700c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fcb335abf80 RCX: 00007fcb3347dea9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 00007fcb334ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fcb335abf80 R15: 00007ffeb2c1f828
 </TASK>

Allocated by task 5450:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4019
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
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4511
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

The buggy address belongs to the object at ffff88807efae740
 which belongs to the cache ntfs_inode_cache of size 1760
The buggy address is located 1704 bytes inside of
 freed 1760-byte region [ffff88807efae740, ffff88807efaee20)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7efa8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888028ddcf01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888019749c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001ffffefff ffff888028ddcf01
head: 00fff00000000040 ffff888019749c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000000110011 00000001ffffefff ffff888028ddcf01
head: 00fff00000000003 ffffea0001fbea01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5450, tgid 5448 (syz-executor.0), ts 83046102188, free_ts 16881244327
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e2d/0x2ee0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4019
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:563
 alloc_inode fs/inode.c:261 [inline]
 iget5_locked+0xa4/0x280 fs/inode.c:1235
 ntfs_iget5+0xd5/0x3b10 fs/ntfs3/inode.c:532
 ntfs_fill_super+0x2cab/0x4a20 fs/ntfs3/super.c:1275
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2565
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6619
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
 ffff88807efaec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807efaed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807efaed80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807efaee00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807efaee80: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         1613e604 Linux 6.10-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d05b3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


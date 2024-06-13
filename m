Return-Path: <linux-kernel+bounces-213229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98F90723B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7305281C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438C142E9C;
	Thu, 13 Jun 2024 12:45:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD064143862
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282706; cv=none; b=k/9JSTeIhkKwaVqD9Kv4Qhm6JAlH00NIDbnud5xh4/5zPHkUw/R/AQbIiHTuaLOrmI4ivjUoI+mj+5OVA1AJIjU0FJYngwAsT/aKwNSeV/xkeXqkySicL1ZXl3KHMfgHcRhk63pPi49qdU6QNVQ9LC2XFyLPi5UEdxpt8IlC+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282706; c=relaxed/simple;
	bh=vY3EuxA7EQhCL3ZcTn9YpncTAibYY8q5UAvVuAZIx9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HWY1AV3FManbEfmD9I0jKLR3vUG/AyXHAtDOpJr9QK17L/q5fmtLGHTSaqSi5VvLD3cwOR2cV8IGczJKsPZH8+4ctFqYfKLqp4OJdcjTaPOAlvA7SuAlVv/G1g6RNtSs04CXF6DOUfsqzoDGAfgn9q1XcoMqCie9hpnbpfD+bwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb4c4378c0so93985639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282704; x=1718887504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnEvTQni1iErP/oAx+ksf3cfjo3FOaynGESKBCOWuis=;
        b=Df9khkuOr2Z1pgk12cxUsK2pHWMsqvMtOQ4R5TeYpgG0WhBAPYmzcl9BQ/wjqmUkSA
         9e+rlvM8x0l5pAwl15Ux8XMriN7uLgdrTbpoxgtYDShQBq7EMubhXo7fYin/As8Pn0wo
         xG7M2x6W+8D5uGxby8OwY1i2WzZ3FwAxO8sYa5LZENxRP7Te4ECMjyfHdOfKIBlKH4nO
         glIywAm4wg3J+ZA76YNkjs1jUgXD2KfUMM5lXcjumkYX7jzIVMBhVgz2sQ3+bp2Q85IO
         dmf1bcng5ftgGJqKDyQO7U58k4/bCKbO8/w8N3aWdfsbsCK5maivrCAgasy8RR52nxei
         VriQ==
X-Forwarded-Encrypted: i=1; AJvYcCW66eiYVlxr85MKWNtDNMuOt+W0OH1N283zfJvMwhkpvd4ffM/xTfgAVGmO71T5fJyxYG+oABSg2hc5hNtSMypLrPdnFtlAYgvUuUWd
X-Gm-Message-State: AOJu0YzTs22EjFoYzvNSG/TZ9nCppJHKO1X+nOccCAyEjbSzkA+oleXe
	lik3MQxipbNSUhqxE2BrEw01SH/UNgY+oP+4c0zR2szt1QDXMTrqKU8E0Jf5ZMYz5l+1vPBazH+
	/aXsJz8iE2LPAaRoPFcN8BMsmCtR2+izu+4MXtJ+NXGQb1j6uh6npRKU=
X-Google-Smtp-Source: AGHT+IFwhYh74J7QI+OjLrSKMJ80GfaBv1X7S6K53oTJRgEu8D3EUYSERcX5Wr61pvsNos+6+MQylCD80rLFTaAUZT2qbuaqGBGT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3792:b0:488:75e3:f3e1 with SMTP id
 8926c6da1cb9f-4b93ea7a53dmr172641173.0.1718282704088; Thu, 13 Jun 2024
 05:45:04 -0700 (PDT)
Date: Thu, 13 Jun 2024 05:45:04 -0700
In-Reply-To: <20240613122428.2455-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033819f061ac4de44@google.com>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in lru_add_fn

NILFS (loop0): unable to write superblock: err=-5
Buffer I/O error on dev loop0, logical block 1, lost sync page write
NILFS (loop0): unable to write superblock: err=-5
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:259 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable mm/internal.h:353 [inline]
BUG: KASAN: slab-use-after-free in lru_add_fn+0x192/0xd70 mm/swap.c:184
Read of size 8 at addr ffff888037e42b18 by task syz-executor/5333

CPU: 3 PID: 5333 Comm: syz-executor Not tainted 6.10.0-rc3-syzkaller-g2ccbdf43d5e7-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:259 [inline]
 folio_evictable mm/internal.h:353 [inline]
 lru_add_fn+0x192/0xd70 mm/swap.c:184
 folio_batch_move_lru+0x243/0x400 mm/swap.c:220
 lru_add_drain_cpu+0x534/0x860 mm/swap.c:657
 lru_add_drain+0x109/0x440 mm/swap.c:757
 __folio_batch_release+0x68/0xb0 mm/swap.c:1081
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x5a1/0x1160 mm/shmem.c:1005
 shmem_truncate_range mm/shmem.c:1114 [inline]
 shmem_evict_inode+0x3a3/0xbb0 mm/shmem.c:1242
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
 dput+0x1f/0x30 fs/dcache.c:835
 __fput+0x54e/0xbb0 fs/file_table.c:430
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f3cc7cc4b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffef95738f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f6f3cc7cc4b
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
RBP: 00007ffef95739ac R08: 0000000000000000 R09: 00007ffef9573697
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 00000000000181b0 R14: 0000000000018130 R15: 0000000000000005
 </TASK>

Allocated by task 5369:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_lru_noprof+0x121/0x2f0 mm/slub.c:4020
 nilfs_alloc_inode+0x26/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x5d/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1235 [inline]
 iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
 nilfs_iget_locked+0xa1/0xe0 fs/nilfs2/inode.c:606
 nilfs_ifile_read+0x2f/0x1e0 fs/nilfs2/ifile.c:192
 nilfs_attach_checkpoint+0x12d/0x1d0 fs/nilfs2/super.c:557
 nilfs_fill_super fs/nilfs2/super.c:1067 [inline]
 nilfs_get_tree+0x951/0x1000 fs/nilfs2/super.c:1211
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4512
 i_callback+0x43/0x70 fs/inode.c:250
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2809
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 addrconf_dad_work+0x4c2/0x1500 net/ipv6/addrconf.c:4223
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:3072
 destroy_inode+0x12c/0x1b0 fs/inode.c:316
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 nilfs_put_root+0xae/0xe0 fs/nilfs2/the_nilfs.c:925
 nilfs_segctor_destroy fs/nilfs2/segment.c:2788 [inline]
 nilfs_detach_log_writer+0x5ef/0xaa0 fs/nilfs2/segment.c:2850
 nilfs_put_super+0x43/0x1b0 fs/nilfs2/super.c:498
 generic_shutdown_super+0x159/0x3d0 fs/super.c:642
 kill_block_super+0x3b/0x90 fs/super.c:1676
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888037e42670
 which belongs to the cache nilfs2_inode_cache of size 1512
The buggy address is located 1192 bytes inside of
 freed 1512-byte region [ffff888037e42670, ffff888037e42c58)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x37e40
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888020dade01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff8880192ad540 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080130013 00000001ffffefff ffff888020dade01
head: 00fff00000000040 ffff8880192ad540 dead000000000122 0000000000000000
head: 0000000000000000 0000000080130013 00000001ffffefff ffff888020dade01
head: 00fff00000000003 ffffea0000df9001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5369, tgid 5368 (syz-executor), ts 98810143084, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 kmem_cache_alloc_lru_noprof+0x2a0/0x2f0 mm/slub.c:4020
 nilfs_alloc_inode+0x26/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x5d/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1235 [inline]
 iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
 nilfs_iget_locked+0xa1/0xe0 fs/nilfs2/inode.c:606
 nilfs_dat_read+0x88/0x360 fs/nilfs2/dat.c:508
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:120 [inline]
 load_nilfs+0x399/0x12d0 fs/nilfs2/the_nilfs.c:301
 nilfs_fill_super fs/nilfs2/super.c:1062 [inline]
 nilfs_get_tree+0x8c9/0x1000 fs/nilfs2/super.c:1211
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888037e42a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888037e42a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888037e42b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888037e42b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888037e42c00: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
==================================================================


Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16e791fe980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17700e41980000



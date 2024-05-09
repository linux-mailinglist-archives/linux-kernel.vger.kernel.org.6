Return-Path: <linux-kernel+bounces-174176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941C8C0B43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB21F22317
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B41494BF;
	Thu,  9 May 2024 05:58:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD81494B0
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715234308; cv=none; b=CbZ5gmCmtWyJc51VuUpkhELmLzKW00s00fB4joNGSgE40DEA5AIlPvWB+QneUrAps48Pb+Nyagr9x/5ZBJCnsQ6jTzX1s6ofpbp5+AJ1Zk/5MH+EfyP5b/qLds2e5pWAmkeSg1wbTUxgrz9LPYW75iUUpw7cxcmKfRWuHJiPywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715234308; c=relaxed/simple;
	bh=7GBgN0fe90XQPhwS/0F/MD7bpnW5AK0RddixHGosspQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PYg01TsXf/Lu127QAe/nHDh9ayycvEcLvrRph1H6wvOLbTGH9i2WRSNozX3RcPpP+tu/KVF+Ynob68yibMwkq7k1HpPimQ+R4Il622iVoT5K3EMdHh1zWETT8Ct022Gm/jngn6c3iYeVtzDrQzJ2yDNvVRUjh4xoYJwOwE1wUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e182885d98so50744239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 22:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715234306; x=1715839106;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OCzkycdU/R8zQ86noBR5DwRz+uqKhU4CmPjG/iyOlY=;
        b=dkpIkZ7upeOJZT+iyQB0VZt3vpb6PPAOBfQf//PR5U0fIJM+NEqcGAwDD3G605kM7L
         wq7MZrtnzFSOipvc2Aq++W+BGBSdoI0bNhhBiocAOBicJRaboJpoEOgp9gSgS9tjjEG1
         jYtX+29DW5xH2P1jwU0qJKzbFQGMjjLWSyy+FPXXeiQWQKnjk6vjs5PN2o5Abqrbbz2m
         gAkUgoBC/wjsbrfBDHNPtqnAvdFW9f5QhUohJRnrZ4aYYNWKfaIdVHNEtupWAFWAFAkT
         WDDeqfVzc0ILzqW3Dtz77c5bJSzi7OcRs4c2ay+m0RvDX9GtGTaZzt0NGN/QzS1hBnmy
         OsWA==
X-Forwarded-Encrypted: i=1; AJvYcCUNEU/A8UILb2yCgpEp8OzWen8hj/zTp2fqEOgqf0HWpJen2R3xPdCwRekjQlGu9XCGiMSuHG4H/M/CBJnYzpzyaSarTZtoGSOWhLuo
X-Gm-Message-State: AOJu0Yzjc2mP3oLtcXWEnktrR6VZqI1ZlkBGe8gcosTnbhKck27I/VYy
	3fIbRIOcoU/5vMqSI+8Ihf+eZIYE4BshHtfA6nd0BAtPi0gn+LfXInGkhtnBnHeXIrQY2hTwjlY
	ZM4aZ/nWm7Qo1iOBq9AotWhIAdJFvARLAFZqH2gbJgjW5c9750zviOio=
X-Google-Smtp-Source: AGHT+IE1tMKTd2iOTOeD6MO9Gbo7bST+CLjH/lr9/n4TgbcPgiJlaZSNw3/yVSHBo7KoL4roHzdMXukaNjEKpvDkreI9P7TS/fRx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0f:b0:36c:8135:8d5f with SMTP id
 e9e14a558f8ab-36caebb3b95mr2068015ab.2.1715234306285; Wed, 08 May 2024
 22:58:26 -0700 (PDT)
Date: Wed, 08 May 2024 22:58:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008874480617ff1bad@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1263897f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d47450980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/98f66c028d40/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:257 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable mm/internal.h:353 [inline]
BUG: KASAN: slab-use-after-free in lru_add_fn+0x2cc/0x1a20 mm/swap.c:184
Read of size 8 at addr ffff88807ffa84a8 by task udevd/5139

CPU: 0 PID: 5139 Comm: udevd Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:257 [inline]
 folio_evictable mm/internal.h:353 [inline]
 lru_add_fn+0x2cc/0x1a20 mm/swap.c:184
 folio_batch_move_lru+0x322/0x690 mm/swap.c:220
 lru_add_drain_cpu+0x10e/0x8c0 mm/swap.c:657
 lru_add_drain+0x123/0x3e0 mm/swap.c:757
 wp_can_reuse_anon_folio mm/memory.c:3550 [inline]
 do_wp_page+0x2c65/0x5310 mm/memory.c:3662
 handle_pte_fault+0x1189/0x70f0 mm/memory.c:5396
 __handle_mm_fault mm/memory.c:5523 [inline]
 handle_mm_fault+0x10df/0x1ba0 mm/memory.c:5688
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fe7b90c72a4
Code: c0 02 49 8b 0c c6 64 8b 34 25 18 00 00 00 85 f6 75 22 48 39 cd 75 0c 48 8d 3d 24 e6 0e 00 e9 66 fe ff ff 48 c1 ea 0c 48 31 ca <48> 89 55 10 49 89 2c c6 eb 3c 89 d8 48 c1 ea 0c 48 89 ce 49 8d 3c
RSP: 002b:00007ffc001e7800 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 000055697463f110
RDX: 0000556c22f4b72b RSI: 0000000000000000 RDI: 000055697463b660
RBP: 000055697463b650 R08: 0000000000000007 R09: 729c72b1ba2b10a4
R10: f6f0f8c87f29ff62 R11: 0000000000000007 R12: 0000000000000000
R13: 000055697463b680 R14: 00007fe7b91f1aa0 R15: 0000556974631910
 </TASK>

Allocated by task 5122:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4019
 nilfs_alloc_inode+0x2e/0xf0 fs/nilfs2/super.c:154
 alloc_inode fs/inode.c:261 [inline]
 iget5_locked+0xa4/0x280 fs/inode.c:1235
 nilfs_iget_locked+0x12b/0x180 fs/nilfs2/inode.c:606
 nilfs_ifile_read+0x30/0x1b0 fs/nilfs2/ifile.c:192
 nilfs_attach_checkpoint+0xed/0x1a0 fs/nilfs2/super.c:557
 nilfs_fill_super+0x380/0x6a0 fs/nilfs2/super.c:1067
 nilfs_get_tree+0x4f9/0x920 fs/nilfs2/super.c:1211
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
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
 rcu_do_batch kernel/rcu/tree.c:2566 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2840
 handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
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
 __call_rcu_common kernel/rcu/tree.c:3103 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3207
 nilfs_put_root+0x97/0xc0 fs/nilfs2/the_nilfs.c:909
 nilfs_segctor_destroy fs/nilfs2/segment.c:2753 [inline]
 nilfs_detach_log_writer+0x8bb/0xbe0 fs/nilfs2/segment.c:2816
 nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:498
 generic_shutdown_super+0x136/0x2d0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1676
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x273/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807ffa8000
 which belongs to the cache nilfs2_inode_cache of size 1512
The buggy address is located 1192 bytes inside of
 freed 1512-byte region [ffff88807ffa8000, ffff88807ffa85e8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ffa8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88801f030301
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff88801abec3c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080130013 00000001ffffefff ffff88801f030301
head: 00fff00000000040 ffff88801abec3c0 dead000000000122 0000000000000000
head: 0000000000000000 0000000080130013 00000001ffffefff ffff88801f030301
head: 00fff00000000003 ffffea0001ffea01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5122, tgid 5122 (syz-executor.0), ts 74532588239, free_ts 16451630334
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4696
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4019
 nilfs_alloc_inode+0x2e/0xf0 fs/nilfs2/super.c:154
 alloc_inode fs/inode.c:261 [inline]
 iget5_locked+0xa4/0x280 fs/inode.c:1235
 nilfs_iget_locked+0x12b/0x180 fs/nilfs2/inode.c:606
 nilfs_ifile_read+0x30/0x1b0 fs/nilfs2/ifile.c:192
 nilfs_attach_checkpoint+0xed/0x1a0 fs/nilfs2/super.c:557
 nilfs_fill_super+0x380/0x6a0 fs/nilfs2/super.c:1067
 nilfs_get_tree+0x4f9/0x920 fs/nilfs2/super.c:1211
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2601
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6655
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1037
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1417
 do_one_initcall+0x248/0x880 init/main.c:1265
 do_initcall_level+0x157/0x210 init/main.c:1327
 do_initcalls+0x3f/0x80 init/main.c:1343
 kernel_init_freeable+0x435/0x5d0 init/main.c:1576
 kernel_init+0x1d/0x2b0 init/main.c:1465
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88807ffa8380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ffa8400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807ffa8480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88807ffa8500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ffa8580: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


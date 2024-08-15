Return-Path: <linux-kernel+bounces-287780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB5952C82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C31B22EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813CE1CB336;
	Thu, 15 Aug 2024 10:06:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047129CFB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716364; cv=none; b=AU9z9Ym4Uq2msg8slywKwIDcBW0b0giwPGPiLiAGParuzk6BNCwHmPz44RtvPxoGgyGy4qErtSc6WGsH5+/f3K1DR4YSBO6QHHXXrXVnV9qbU7LAe5lEW/l90v9QPygaD088BbSpRTjxc+1/g3Nef5Sm2GjvJ2Lk/Y7FWz2rBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716364; c=relaxed/simple;
	bh=ng/LgPKEzjUwrzdquIxgBmkfHl7MiNxbnOkvbQfybhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q/eKbST0uITkFnr+pM+OSFNSxx0NQGF7BmfWpNCD4yxAVvjLwa+8OIIQ3cx9DeuC2C+hpajNB5KgV2KiqeNzhoHnCza4JnsvagWNShrCkDmjUICLE6P1yoiQAOdLNKPyPoZKhDQN0Mj32J/cnc9SymmxzGXNSphkZVJPnrC6Wfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so84575939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716362; x=1724321162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueYCMfBP6zUzX9RPaMSYhlmhFnMWggJG9kQ5naGKZx0=;
        b=v171E2Q/9Tp0XPpFjRGVSbweBkuTvsr5jx0Eo8rsaxLUFMstqAlnMuylHPlD8lHd1/
         2PW8TX//6JB74v4ahn1hFMB0KbQXomPtav1I+RcVulHvkGDphpAl2pDgCIUdyZu20htv
         FWPxtjgyD8oz78oEachp5ZQ4eotl4WphV9bNe+3FlGlCBwG/KgG9+Ic5VrYh2CG+fFt3
         KRp+/XCP+mfSBS8tsofhci5ZCzc+lXDEhc3yRd1hTnoO+ZGGB8zW9S0gwMa/RGVU/u9V
         eSrfxJpTCkUR6ErLqUeljQIjsRjCrt9ZL+GKF3KJQJjWIe0RHDDnxqnBBUvO843ArUNJ
         7eug==
X-Forwarded-Encrypted: i=1; AJvYcCXCYOaYMVMjAGNCzK+pn4rbTwI/PxCP551NQxdyfbmFimsK8pfrD/kJRUU3sFaiIPNFnPaRV1s+5jnqez/SLSXhbe5LAEq/wIoyuR+x
X-Gm-Message-State: AOJu0YydkdHW3xOqUf7kkwCO8b799GsZoVZ1C5cGDqtZQL5X++tsNpV0
	zJwo89DiuNwwZ6b+EuGUV3be3wAkP6TgZ9a508QLHKcvGyCihbMH1cLDpLohO3IuxtFmsdK9UuO
	2E79BAJClBcB3g+9fiqh6Sip/pdNO1W+xjSw+deOQmLjWWfFipSZOkqU=
X-Google-Smtp-Source: AGHT+IG/hV5dLQDY7PyHlVXOuHIqusIebw3lCZQhaxfHdwQpvoSkeGaegZrB7SRq9yIMtOsXQuSi8UUtFw2LePySgcpMCJ59au4d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1405:b0:4c0:9a3e:c260 with SMTP id
 8926c6da1cb9f-4cab0538104mr163826173.0.1723716362063; Thu, 15 Aug 2024
 03:06:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 03:06:02 -0700
In-Reply-To: <1c96f019b31a46519b805c0a698af0e2@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000746151061fb5fd84@google.com>
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
Read of size 8 at addr ffff888076e3d768 by task syz-executor.0/5471

CPU: 0 UID: 0 PID: 5471 Comm: syz-executor.0 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 chrdev_open+0x2a9/0x630 fs/char_dev.c:396
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff63a67dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff63b46c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ff63a7abf80 RCX: 00007ff63a67dea9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 00007ff63a6ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff63a7abf80 R15: 00007ffc7cf90658
 </TASK>

Allocated by task 5458:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4056
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:559
 alloc_inode fs/inode.c:263 [inline]
 new_inode_pseudo fs/inode.c:1073 [inline]
 new_inode+0x6e/0x310 fs/inode.c:1092
 ntfs_new_inode+0x45/0x100 fs/ntfs3/fsntfs.c:1688
 ntfs_create_inode+0x681/0x3880 fs/ntfs3/inode.c:1345
 ntfs_mknod+0x3c/0x50 fs/ntfs3/namei.c:120
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4088
 do_mknodat+0x3ec/0x5b0
 __do_sys_mknodat fs/namei.c:4166 [inline]
 __se_sys_mknodat fs/namei.c:4163 [inline]
 __x64_sys_mknodat+0xa7/0xc0 fs/namei.c:4163
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x30f/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3106 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
 destroy_inode fs/inode.c:318 [inline]
 evict+0x88b/0x950 fs/inode.c:729
 __dentry_kill+0x20d/0x630 fs/dcache.c:610
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1545
 shrink_dcache_for_umount+0xb4/0x180 fs/dcache.c:1562
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
 kill_block_super+0x44/0x90 fs/super.c:1696
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1780
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888076e3d0c8
 which belongs to the cache ntfs_inode_cache of size 1752
The buggy address is located 1696 bytes inside of
 freed 1752-byte region [ffff888076e3d0c8, ffff888076e3d7a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76e38
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888028f9e901
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff8880197af500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080110011 00000001fdffffff ffff888028f9e901
head: 00fff00000000040 ffff8880197af500 dead000000000122 0000000000000000
head: 0000000000000000 0000000080110011 00000001fdffffff ffff888028f9e901
head: 00fff00000000003 ffffea0001db8e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5458, tgid 5457 (syz-executor.0), ts 85185459887, free_ts 85040278216
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4700
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4056
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:559
 alloc_inode fs/inode.c:263 [inline]
 iget5_locked+0xa3/0x250 fs/inode.c:1294
 ntfs_iget5+0xc7/0x3bb0 fs/ntfs3/inode.c:530
 ntfs_fill_super+0x2569/0x4730 fs/ntfs3/super.c:1208
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
page last free pid 5456 tgid 5456 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2612
 discard_slab mm/slub.c:2583 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3051
 put_cpu_partial+0x17c/0x250 mm/slub.c:3126
 __slab_free+0x2ea/0x3d0 mm/slub.c:4343
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_scan_exec_realpath security/tomoyo/condition.c:243 [inline]
 tomoyo_condition+0x1a8f/0x3230 security/tomoyo/condition.c:827
 tomoyo_check_acl+0x174/0x3f0 security/tomoyo/domain.c:177
 tomoyo_execute_permission+0x13d/0x410 security/tomoyo/file.c:615
 tomoyo_find_next_domain+0x404/0x1cf0 security/tomoyo/domain.c:752
 tomoyo_bprm_check_security+0x115/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x65/0x90 security/security.c:1191
 search_binary_handler fs/exec.c:1815 [inline]
 exec_binprm fs/exec.c:1869 [inline]
 bprm_execve+0xa56/0x1770 fs/exec.c:1920

Memory state around the buggy address:
 ffff888076e3d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076e3d680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888076e3d700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888076e3d780: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888076e3d800: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         1fb91896 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dfd5ed980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a161fc73d681a3b
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


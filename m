Return-Path: <linux-kernel+bounces-424415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB659DB41C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44968B22D20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E668153573;
	Thu, 28 Nov 2024 08:47:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D814F9D6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783644; cv=none; b=KeS/zCja71DtztPN4fOcZDO8OdQlPqvjQPjX8k65hxc/U826fWrBCoya+Etynd/UrFgL3jW7gkalR8nGwBxGDmFvLSpZLL+72q75cYWqS1VDV6NwJ0WVoOPU/66drOyat0/h5tz5rXdv8BwTgiREYwphfKwFZ9O5iDf8f+uY0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783644; c=relaxed/simple;
	bh=2Kep968pVjNyNXmhQnSjl95fn2RDiRo5ZeyBlODHN8c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pe3t8g5ZUbKChxmFxeEcGS5RLIMilLOBet7Jif9m11xlUrepj5TeG6QX7TMYhSuEHuZlCdv05BNZLRaDIPWSi7QFjJZLzAmyq1Bl/iBwh4eI5chsBWBYWyyRHr6qKC5/jWQTyzc3R1f8mk5XrWxzVFtBM6lc1YlYvRxiY+jyrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso7030685ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783642; x=1733388442;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r46dfHdFlV6BAA2ZlXpad8PKdChn5b7chFRwyqtXJ20=;
        b=oAruHmmQRMGXYnp4JfQhKgGLsoRn+9LAYq3BF2xHr4w+QpI46BHU1NdJ2nUg/Cwm2y
         9z2NsA7VM3X3HfIiibLf+/cW2nmm7PSwulFwZgWCPbZV59avMb1hfM8mKxXEdYace3UX
         qB2B+K7xs7iFcglGZew6xgkH/1mVLt3SjPkuf2bhqHZnhBw/MuerqHRJRcMCL4iyN8AS
         Owery3t+IvtCC6K6j6SxvgItLZnkM99dQjbxbrINw/2643/zotQ/ZpUxXd//He/x/pfH
         dYy1dBmco6HFS5KEh1ZzhU2SrmRLRvTTrKR6eyugvWRpHhT0XlVO0dTJynP5pk/kV1dg
         4OzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/rnAhfbWqNgkvQv6FNhsI36v8GZEVGGgoL4isgjh7j054pf3YGzzy6i9dAXdKfMyXSyluBBLhro7Twzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ilAZlYcaNhZdVn0CuImj0WOhC+K3lnpX0BDg28Ctp0Uu70Xq
	MRjbBfc1LDX8TqWC4bJXVyVI+ISigwZp2AgG02/vQhYItFJhT+Zc+lCgjmkvZMCeg2F1I4yydrF
	f6ZJ+e6y5jK/L/n8emKqNe4Jg8FGs31f2pmA6pBkjhumNMho59wsTKvk=
X-Google-Smtp-Source: AGHT+IHu+8j5RnhO/DXgq/mxcWqueucXPCsHCRrYoIZ7CZQRose5dR5C1S17YV7Fwo/FGIg5xHU6HxYhtra0bP8FAbxB2aHSsDan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3a7c55eb884mr58255825ab.20.1732783642160; Thu, 28 Nov 2024
 00:47:22 -0800 (PST)
Date: Thu, 28 Nov 2024 00:47:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67482e1a.050a0220.253251.0075.GAE@google.com>
Subject: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_get (2)
From: syzbot <syzbot+820f6ca050d313a3688a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fb8778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5073f0bff19a2470
dashboard link: https://syzkaller.appspot.com/bug?extid=820f6ca050d313a3688a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f2746321903/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dda5d116bf7/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2021123cc31/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+820f6ca050d313a3688a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in kernfs_get+0x20/0x90 fs/kernfs/dir.c:526
Read of size 4 at addr ffff8880126e04b0 by task kworker/1:1/57

CPU: 1 UID: 0 PID: 57 Comm: kworker/1:1 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 kernfs_get+0x20/0x90 fs/kernfs/dir.c:526
 sysfs_get include/linux/sysfs.h:795 [inline]
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x4ba/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 class_dir_create_and_add drivers/base/core.c:3215 [inline]
 get_device_parent+0x391/0x410 drivers/base/core.c:3266
 device_add+0x325/0xbf0 drivers/base/core.c:3596
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xdf7/0x13b0 drivers/base/firmware_loader/main.c:942
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1195
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 57:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 __kernfs_new_node+0xd8/0x870 fs/kernfs/dir.c:624
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1061
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 class_dir_create_and_add drivers/base/core.c:3215 [inline]
 get_device_parent+0x391/0x410 drivers/base/core.c:3266
 device_add+0x325/0xbf0 drivers/base/core.c:3596
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xdf7/0x13b0 drivers/base/firmware_loader/main.c:942
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1195
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 24:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4681
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaac/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
 smpboot_thread_fn+0x546/0xa30 kernel/smpboot.c:164
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 kernfs_put+0x1dc/0x370 fs/kernfs/dir.c:578
 __kernfs_remove+0x768/0x870 fs/kernfs/dir.c:1508
 kernfs_remove+0x7a/0xa0 fs/kernfs/dir.c:1528
 __kobject_del+0xe2/0x310 lib/kobject.c:604
 kobject_del+0x45/0x60 lib/kobject.c:627
 device_del+0x7ff/0x9b0 drivers/base/core.c:3881
 usb_disconnect+0x60b/0x950 drivers/usb/core/hub.c:2332
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880126e04b0
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 0 bytes inside of
 freed 176-byte region [ffff8880126e04b0, ffff8880126e0560)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x126e0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801c6e4000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080110011 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5908, tgid 5908 (kworker/1:4), ts 338587145335, free_ts 338568280310
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 __kernfs_new_node+0xd8/0x870 fs/kernfs/dir.c:624
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 __kernfs_create_file+0x49/0x2e0 fs/kernfs/file.c:1034
 sysfs_add_file_mode_ns+0x24a/0x310 fs/sysfs/file.c:307
 sysfs_merge_group+0x1fd/0x450 fs/sysfs/group.c:373
 dpm_sysfs_add+0xd3/0x280 drivers/base/power/sysfs.c:707
 device_add+0x5bc/0xbf0 drivers/base/core.c:3632
page last free pid 9178 tgid 9178 stack trace:
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
 exit_mmap+0x496/0xc40 mm/mmap.c:1680
 __mmput+0x115/0x390 kernel/fork.c:1347
 exec_mmap+0x7a5/0x890 fs/exec.c:1014
 begin_new_exec+0x12c0/0x2050 fs/exec.c:1280
 load_elf_binary+0x966/0x2710 fs/binfmt_elf.c:1002
 search_binary_handler fs/exec.c:1752 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xafa/0x1770 fs/exec.c:1845
 do_execveat_common+0x55f/0x6f0 fs/exec.c:1952
 do_execve fs/exec.c:2026 [inline]
 __do_sys_execve fs/exec.c:2102 [inline]
 __se_sys_execve fs/exec.c:2097 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2097
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880126e0380: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
 ffff8880126e0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>ffff8880126e0480: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880126e0500: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8880126e0580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


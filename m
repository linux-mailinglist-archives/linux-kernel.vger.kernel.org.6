Return-Path: <linux-kernel+bounces-399961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC729C070C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D747282391
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDDE20FA9D;
	Thu,  7 Nov 2024 13:17:22 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02865322E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985441; cv=none; b=aCsVYgmfjvC2nehh9NTfqZ2+drpZ5N0Xr71PWL2y9z8j6e8RrWPcEGoL8xSB36zjuSEojnO/tp48r/kKZK0/wr/fZGBAsO4U+AQePbtOEKtwN72X/x0HWDtjHHkTFlV+7ib3Egw7egOQv2dv/ipFZMOAv9yzEQNm/SEiA2to0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985441; c=relaxed/simple;
	bh=FUe6uE+0SC0eno/xhJpwzPBf9o+kpBs4bjGJiO6Kwc4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qiJ9iBliY0jnvimw3NgKWQ9PECBHrfzKsM/LSrIvOnGLjrwC0XJbf0v0a0KV9MCxbRy/IlbRYAdFFsh/O/VMlW7JFjn7vnESyWE1m4cFp9DV/yxR1xR9WrSAyVPlQBjS1XPs1dNyy8OE3YoGV2rJEhRNNZ8vrsVdSNsWVSXIM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so12618445ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985439; x=1731590239;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JWKPLyC19RRNfojKk0W4r0JRv6J0ynw7/EaQcVjcIw=;
        b=bqXEA3PsimYqVMxxohKHUOCOrwmukKfRkWT7GYrejR3k6d0ecOdv0W7MUDkGCcU+GG
         QygUAdMzexSEJIigSlWKmiIOYJGj2KGUmM3ljmxQQbwOU2DuGAVKl3z6vruG3rXuA6g1
         SrROO3wkv2BBOSZBTUOfVxrnhmOIvv8b1p4gDKaQB0AIJO1sD5KPrNu1sLeAqfaE5HVC
         +oJYElClAYuHMoZEdizK40Qa/CApydjG4iOErY0LJQlynFRPfBKg3/VA9BeYuCP5fpnd
         Op4Y+U9EppVQsGrFc2Yt+Jgto8/ud5+WqeEIAX0VPFuCGDC7faSZkevLPuqckeET+BOA
         F3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjaKphS6l0X6i6Gdr3DxWW4vTRnBQJqfD99p63TIc3Tcn72QvaxoKx265LVmID6+moONuISLIm+dSvUpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDU8ZIoy0OHu70kH8JirqN5bky15KkO6XeofaxwLykozQ/B/L
	lKrhpMY6mf04cifyZRF4Dq8PuLiIwmmAOjHFMQwcrNJvJC5oUM2LpMapXPfUmHV7VcwOOb26WCk
	ndsC7P09BZ1IbY1dOuog698sfwSqbISfsuHLxoYRoh7o1onOOW7Fc4dc=
X-Google-Smtp-Source: AGHT+IGPjbhnZS7Eq3guWOFwtM3hATxRZy4FJuTamIHjM72j/V4iyLmFVtBFSp2Hft2XHIY4vQXJgLUCCCvoNVzCwcW8Z6z3D7l3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188b:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a6ed121f54mr12017975ab.23.1730985439201; Thu, 07 Nov 2024
 05:17:19 -0800 (PST)
Date: Thu, 07 Nov 2024 05:17:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672cbddf.050a0220.3c7a22.0002.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_register_user
From: syzbot <syzbot+0fe7e1aad7c10418ca87@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dbb9a7ef3478 net: fjes: use ethtool string helpers
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104d6b40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=0fe7e1aad7c10418ca87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df61ec56738e/disk-dbb9a7ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ad9020b8df8/vmlinux-dbb9a7ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1b9e903e0c9/bzImage-dbb9a7ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fe7e1aad7c10418ca87@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:686 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x6c0/0xd70 kernel/locking/mutex.c:752
Read of size 8 at addr ffff888052f94060 by task syz.3.2057/13254

CPU: 1 UID: 0 PID: 13254 Comm: syz.3.2057 Not tainted 6.12.0-rc5-syzkaller-01053-gdbb9a7ef3478 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
 __mutex_lock_common kernel/locking/mutex.c:686 [inline]
 __mutex_lock+0x6c0/0xd70 kernel/locking/mutex.c:752
 l2cap_register_user+0x6d/0x1e0 net/bluetooth/l2cap_core.c:1696
 hidp_connection_add+0x144b/0x18c0 net/bluetooth/hidp/core.c:1378
 do_hidp_sock_ioctl net/bluetooth/hidp/sock.c:81 [inline]
 hidp_sock_ioctl+0x446/0x870 net/bluetooth/hidp/sock.c:128
 sock_do_ioctl+0x158/0x460 net/socket.c:1227
 sock_ioctl+0x626/0x8e0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f971237e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97130e8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9712535f80 RCX: 00007f971237e719
RDX: 0000000020000340 RSI: 00000000400448c8 RDI: 0000000000000005
RBP: 00007f97123f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9712535f80 R15: 00007ffe81f5ceb8
 </TASK>

Allocated by task 13010:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 hci_alloc_dev_priv+0x27/0x2030 net/bluetooth/hci_core.c:2440
 hci_alloc_dev include/net/bluetooth/hci_core.h:1621 [inline]
 __vhci_create_device drivers/bluetooth/hci_vhci.c:399 [inline]
 vhci_create_device+0x116/0x6a0 drivers/bluetooth/hci_vhci.c:470
 vhci_get_user drivers/bluetooth/hci_vhci.c:527 [inline]
 vhci_write+0x3cf/0x490 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 13010:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 hci_release_dev+0x1525/0x16b0 net/bluetooth/hci_core.c:2759
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 vhci_release+0x88/0xd0 drivers/bluetooth/hci_vhci.c:665
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xb66/0xf50 kernel/workqueue.c:2343
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1794
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2419 [inline]
 __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xb66/0xf50 kernel/workqueue.c:2343
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888052f94000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 96 bytes inside of
 freed 8192-byte region [ffff888052f94000, ffff888052f96000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x52f90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42280 ffffea00014be200 0000000000000004
raw: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42280 ffffea00014be200 0000000000000004
head: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00014be401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12269, tgid 12268 (syz.2.1784), ts 204471106147, free_ts 14821271321
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4270
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 kvmalloc_array_node_noprof include/linux/slab.h:1040 [inline]
 __ptr_ring_init_queue_alloc_noprof include/linux/ptr_ring.h:471 [inline]
 ptr_ring_init_noprof include/linux/ptr_ring.h:489 [inline]
 skb_array_init_noprof include/linux/skb_array.h:182 [inline]
 pfifo_fast_init+0x114/0x6e0 net/sched/sch_generic.c:871
 qdisc_create_dflt+0x136/0x4b0 net/sched/sch_generic.c:1021
 mq_init+0x2c9/0x6c0 net/sched/sch_mq.c:90
 qdisc_create_dflt+0x136/0x4b0 net/sched/sch_generic.c:1021
 attach_default_qdiscs net/sched/sch_generic.c:1203 [inline]
 dev_activate+0x210/0x1240 net/sched/sch_generic.c:1257
 __dev_open+0x352/0x450 net/core/dev.c:1485
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 free_contig_range+0x152/0x550 mm/page_alloc.c:6748
 destroy_args+0x8a/0x840 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888052f93f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888052f93f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888052f94000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888052f94080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888052f94100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


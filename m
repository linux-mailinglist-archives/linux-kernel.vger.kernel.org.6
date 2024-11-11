Return-Path: <linux-kernel+bounces-403829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4189C3B54
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DA11C2182E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46CB146A7A;
	Mon, 11 Nov 2024 09:49:34 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F4137747
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318574; cv=none; b=GsC+fms8iTOdWJDlstIhOjT1dtlJ43X7V/pRFiqeQHlJAmrRajA5vvh7weXQMqXfZaM0woN8tzXV7w9nSboiAVMXBn1yuo6D/5fwwyacAMGq+W8E+RlRVEFFBke7+QO4eP6YQGL/IWYaimeiUmLRaHjWyymuttqwc3MoDf7//cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318574; c=relaxed/simple;
	bh=VhczQpGJERGOzv5TOTtrnyJJ8c+6WH1F927iA6D6zug=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Th1Swx59T6bFzMjAU4JRb2SoLvDV4XkSLRU8scEqAkn99isrOL2dWwMnzste137TJtwkIe9cV+Ac2P6ZXbqhLfJgo/GkoymTjWkJ5cySAHtMoIM2iurwJs3WSjOrzUVv2RsZugwAwcFe7j0MwCgi38Shl8MqUjFIRoYfZitaqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6f3a08573so33669135ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318571; x=1731923371;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWFwwRFWCoft6fd4zzkhy8kAfTOj+Wjs9Nl4gZLDDDE=;
        b=KijNo7m81dhuftHuyfAcZyFZgg1a/CXQ9o/35kS9F5cP7R5eXchmETfwDouHp25vLE
         pbHMG3Grv+CgJEfwki951RzB+V4lLXx+p7QEN6l+05b0vfPDZKHcbXftXHdlXWqdP37a
         HnsRimE15rBdRdRlBi+mGR7F1W48kgqAPx+cSOjXNhDsB4eHG4vDJlrXYUJaEF9Ws1Mo
         7DFxr8p7J1Jyli60PWJ0Xo1xYw2yakOuh5qrdJAIJc84Jce5o8pv/gC3qyraWlY5V2EE
         9iJ74WkFH+cFlH5kgxWexlm6btYBDyMbvMHeWJ89JaN66yB9jHAtQMUN6wF0mnMgJIVF
         TVKw==
X-Forwarded-Encrypted: i=1; AJvYcCWz0gYSY0iFBbJ0X8HAC9bOgVyP1xUaAsaRBQyRFFBLM13SP5KVJhPKETV62TQO6Vm4NWBnmkoAopwH394=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fytroST7JXklq74z5GPLaPMNRVDb2bAhg7XnuQSicajOCs0t
	+Yoy9+6fFI72wciTQDptLgnl7Cm0om7rNMsOIca77c/98/p2jBudpC9Ymas6jbDf1FfHO1fXsJt
	+0mKqLVyYz8qnUeL6iKUbxsIr1aTbVPR80pIzpzA3Tnvsx9PTrcRjInQ=
X-Google-Smtp-Source: AGHT+IHbdKF7zGnucUlp4E7XJhjwH+TFU1bAiE8DdF4i1EfNtZepwWQSqgSSbpz09fLE+SdFLYgskksNggfrG5SPhAEDOITDyGOX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a6:c24d:c2f2 with SMTP id
 e9e14a558f8ab-3a6f1a35926mr139627765ab.17.1731318571352; Mon, 11 Nov 2024
 01:49:31 -0800 (PST)
Date: Mon, 11 Nov 2024 01:49:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731d32b.050a0220.1fb99c.014d.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in ld_usb_release
From: syzbot <syzbot+e8e879922808870c3437@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1650d6a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b77c8a55ccf1d9e2
dashboard link: https://syzkaller.appspot.com/bug?extid=e8e879922808870c3437
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2e1b3cc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b569b3c6c6e/vmlinux-2e1b3cc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45324d0fcac3/bzImage-2e1b3cc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8e879922808870c3437@syzkaller.appspotmail.com

ldusb 8-1:0.55: Couldn't submit interrupt_out_urb -19
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff888022387c0c by task syz.3.600/8305

CPU: 3 UID: 0 PID: 8305 Comm: syz.3.600 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
 __mutex_unlock_slowpath+0x197/0x650 kernel/locking/mutex.c:937
 ld_usb_release+0x10e/0x6e0 drivers/usb/misc/ldusb.c:403
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf740e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f56f655c EFLAGS: 00000296 ORIG_RAX: 0000000000000092
RAX: 0000000000000002 RBX: 000000000000000d RCX: 0000000020000000
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 829:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 ld_usb_probe+0x78/0xe80 drivers/usb/misc/ldusb.c:659
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_set_configuration+0x10ea/0x1ca0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd2c/0x1960 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 829:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 ld_usb_delete drivers/usb/misc/ldusb.c:212 [inline]
 ld_usb_disconnect+0x220/0x320 drivers/usb/misc/ldusb.c:774
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3861
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888022387c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 12 bytes inside of
 freed 512-byte region [ffff888022387c00, ffff888022387e00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22384
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42c80 ffffea0000961500 dead000000000003
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42c80 ffffea0000961500 dead000000000003
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000002 ffffea000088e101 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 6712, tgid 6706 (syz.3.167), ts 81637075237, free_ts 17992965642
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0xf7d/0x2d10 mm/page_alloc.c:3457
 __alloc_pages_slowpath mm/page_alloc.c:4269 [inline]
 __alloc_pages_noprof+0x6af/0x25a0 mm/page_alloc.c:4746
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_slab_page mm/slub.c:2414 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0xca/0x410 mm/slub.c:2631
 ___slab_alloc+0xd1d/0x16f0 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x367/0x440 mm/slub.c:4270
 kmalloc_array_node_noprof include/linux/slab.h:995 [inline]
 alloc_slab_obj_exts+0x41/0xa0 mm/slub.c:1968
 __memcg_slab_post_alloc_hook+0x2a7/0x9b0 mm/memcontrol.c:2982
 memcg_slab_post_alloc_hook mm/slub.c:2156 [inline]
 slab_post_alloc_hook mm/slub.c:4095 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x2cd/0x2f0 mm/slub.c:4141
 ep_ptable_queue_proc+0x5b/0x280 fs/eventpoll.c:1423
 poll_wait include/linux/poll.h:45 [inline]
 kernfs_generic_poll+0x8f/0x160 fs/kernfs/file.c:840
 kernfs_fop_poll+0x18c/0x1f0 fs/kernfs/file.c:860
 vfs_poll include/linux/poll.h:84 [inline]
 ep_item_poll+0x194/0x270 fs/eventpoll.c:1030
 ep_insert fs/eventpoll.c:1702 [inline]
 do_epoll_ctl+0x1dfc/0x3580 fs/eventpoll.c:2360
 __do_sys_epoll_ctl fs/eventpoll.c:2417 [inline]
 __se_sys_epoll_ctl fs/eventpoll.c:2408 [inline]
 __ia32_sys_epoll_ctl+0x15c/0x1e0 fs/eventpoll.c:2408
page last free pid 5388 tgid 5388 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4141
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 do_readlinkat+0xb5/0x390 fs/stat.c:536
 __do_sys_readlink fs/stat.c:574 [inline]
 __se_sys_readlink fs/stat.c:571 [inline]
 __x64_sys_readlink+0x78/0xc0 fs/stat.c:571
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888022387b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888022387b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888022387c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888022387c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888022387d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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


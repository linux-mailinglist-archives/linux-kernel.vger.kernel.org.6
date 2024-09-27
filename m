Return-Path: <linux-kernel+bounces-341892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5B9887DB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23CB1C20E63
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C239AD6;
	Fri, 27 Sep 2024 15:03:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457A8F5A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449413; cv=none; b=j0AG0TMimGUYZI2x/rTmsZwxpNDt/u7oFWwj6D5zimUQbvd/yc7IaL5QmwJscw9KVqfX6ZY1hxocn2fudhizeji+ALFsK/JHx45nMW7U3wUUOZH+2mP6f0IC3gLslEAqVmYrk06XJUUA986p9Fj9FqVTn94bE5LR5ZnRJgUY1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449413; c=relaxed/simple;
	bh=KNKpCkBpckWdA0w4g5GLWTqy3bNk2kwRAUvaIkRBazs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MManyE+yXdEaCi0479Zo+rgpPmqsqIi0ZmZPzIUgETxgRXcLqb2zSCqmnn0n23Zf+XtgEVEzwLAXrz1fv2Gj08+L3l0QKGN1dDu1QRYy/TktXSbkiN5sNI+PJ1fUvf5va/bBctFhGu+pKPs/SL9vg0FL6OZTVbS4v3V5lJBaTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce4692a4so21566795ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449411; x=1728054211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHHLauxXI1mLj4bhx6Ogen5Vfu/mamG0DCToncfTmZg=;
        b=a9vm/m3ZGajJhUkhYfx6Ub9s9+cW1QkXVRz4stpDmCLBG9a4IU5iXMsGjP6uRES9wB
         +4wAvKZ7fsQQbBHjek1tPIdexGvHN6Ho672h813VTaMi3El8B0q7tb3pNZ7dtAHsL0cZ
         s+Mqh1GYZe87tyocSMWfwsmu8JY8W/FFCZhMP9/Rcj3A7A8NU3q+G5GjuEeteTSrGQO2
         HexbQNAY2yUIeUU+fEIWb+s19fCRz37E0PKukHgrTLgOChtzZ3ZVm6r6W33EsPrVZ+6R
         4VOW7raJ2v2ZrhSWrsErqfDdkR4kLbqj+QYum2o978NLbenBrjCcfb4pwid6AQ9GaUSE
         7Xng==
X-Forwarded-Encrypted: i=1; AJvYcCUD/1cqWvSUENyMUYOEkEPCXxGuzkzD1TrfonQIJu8+hWRojGEHZzOyStqHburcxwH7HMKXpZIvCNgvrbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRcHqTVfMJAeZIkD4dXxtgSusU6qYUnU97lolWcPXdoyeN2vf
	G9WseQ6YBHz/8OSruTIVJk5B3ANciu3mpELQ4Ps6uy41w1EcZoR4xBSA4sW3gz7ASZHt68WhCFU
	NtjPoNjhcBx6G5bsdfMCrMG78yACfZZTN2n2USigX/22JdkaJ8f+ufFA=
X-Google-Smtp-Source: AGHT+IH02B4wPj0wpQYbNhEBGrVfoB1Ecno3Ar4Vggo//9jNHeo/XFbKLw5FOol0EyjfM/pz/7nyuZmFLQtB6xeWOvNplLx6YUI3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:3a2:6d54:33df with SMTP id
 e9e14a558f8ab-3a27685a0fcmr42773305ab.4.1727449411246; Fri, 27 Sep 2024
 08:03:31 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:03:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6c943.050a0220.46d20.001d.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in chaoskey_disconnect
From: syzbot <syzbot+422188bce66e76020e55@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, keithp@keithp.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176f749f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=422188bce66e76020e55
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-0babf683.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a0a995951c96/vmlinux-0babf683.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0aa5ce1558ab/bzImage-0babf683.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+422188bce66e76020e55@syzkaller.appspotmail.com

usb 7-1: USB disconnect, device number 8
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff8880272b801c by task kworker/2:1/64

CPU: 2 UID: 0 PID: 64 Comm: kworker/2:1 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
 __mutex_unlock_slowpath+0x197/0x650 kernel/locking/mutex.c:937
 chaoskey_disconnect+0x18b/0x290 drivers/usb/misc/chaoskey.c:245
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 1799:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 chaoskey_probe+0x1f9/0xc30 drivers/usb/misc/chaoskey.c:144
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 7645:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 chaoskey_free+0xce/0x150 drivers/usb/misc/chaoskey.c:102
 chaoskey_release+0x14c/0x290 drivers/usb/misc/chaoskey.c:304
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880272b8000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 28 bytes inside of
 freed 1024-byte region [ffff8880272b8000, ffff8880272b8400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x272b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac42dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac42dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea00009cae01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5341, tgid 5341 (syz-executor), ts 50543123558, free_ts 50455071523
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
 allocate_slab mm/slub.c:2488 [inline]
 new_slab+0x84/0x260 mm/slub.c:2541
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4181
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:605
 __alloc_skb+0x164/0x380 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 inet6_rt_notify+0xf0/0x2c0 net/ipv6/route.c:6180
 fib6_add_rt2node net/ipv6/ip6_fib.c:1266 [inline]
 fib6_add+0x2524/0x4b50 net/ipv6/ip6_fib.c:1495
 __ip6_ins_rt net/ipv6/route.c:1314 [inline]
 ip6_route_add+0x8d/0x1c0 net/ipv6/route.c:3857
 addrconf_prefix_route+0x2fe/0x510 net/ipv6/addrconf.c:2486
 inet6_addr_add+0x698/0xbc0 net/ipv6/addrconf.c:3063
 inet6_rtm_newaddr+0x11d1/0x1aa0 net/ipv6/addrconf.c:5048
page last free pid 5382 tgid 5382 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_node_track_caller_noprof+0x1c1/0x430 mm/slub.c:4181
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:605
 __alloc_skb+0x164/0x380 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2815
 sock_alloc_send_skb include/net/sock.h:1778 [inline]
 mld_newpack.isra.0+0x1ed/0x790 net/ipv6/mcast.c:1746
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1849
 add_grec+0x111e/0x1670 net/ipv6/mcast.c:1987
 mld_send_cr net/ipv6/mcast.c:2113 [inline]
 mld_ifc_work+0x41f/0xca0 net/ipv6/mcast.c:2650
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389

Memory state around the buggy address:
 ffff8880272b7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880272b7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880272b8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880272b8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880272b8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


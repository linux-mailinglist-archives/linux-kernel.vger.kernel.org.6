Return-Path: <linux-kernel+bounces-396041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 952E59BC716
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC75B23649
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362D1FCC7F;
	Tue,  5 Nov 2024 07:31:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAC1C57B2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791866; cv=none; b=da7deMSVwpBwBbZpsq372y+c+UAoO1Atk7hrJ5Ul/Oaxe0N0Dh6uHgLO882xneqLjFaQHcTmSyB6PWaUuu+zqF6eRl6paekXsnECaNrczOgY5+EtXp/3x5IsB5bocD1gsh5av20gVoCKoE9n1Tu85Yml34201MFujkGMDjk7S0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791866; c=relaxed/simple;
	bh=yfdPJTKEmhtiMeN9yOUX9Hd8GaUqNl23qgtpMpPweQE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q1ZjFZ8y6HMf0VRaVRmEJDeM7Dk/ftGm1BOX1IcSb1jgUG4pz4aTrkeFzFJEouQuuffZlZD8CXL2kExhHoW6hhrHc5l9qHuQeyTKxcLNUwAq1ETy5PzWyZ+P3IU3t8GFiXXaEYMxc528/b3gOpKM6AIInGFXlmTSHBhGRKy7V40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so55767455ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 23:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730791864; x=1731396664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQhpNs8yZrI2cPu0RIL+gZTGN8otKy7I9VYIvCwTXJQ=;
        b=OgR/nJpBmmk90ANqSEOvJdZUo+d4ppGSygV1PaEW985vIGSg3zj3gEvMcf0T0XpvqV
         sy38Q9gECM3/9VDuAQmY+0ESU0ss+ZD3N4o4gL1WBzD1kgyevRF975Jc/WJZN72M6WJJ
         9/fv3LBdwhzoV7RKLS3i7s/TnNXmjgxlJNXZHZcVVgFSyF/ZsZL/1fimQF1BK07tof0y
         SsMiOQBemh2Y6WSPX/lOG9rxJwVF9uzmFmxsFqlJ0Ly3/lnm0mi65cXlcY/hEV8EdQBM
         bTbreXKnD4AgXuIooRz6acy12O1yKXKueuVuvd4w70OR8b/WQRHKLo6yF+pZPFxxWWsv
         MFVg==
X-Forwarded-Encrypted: i=1; AJvYcCX+je1wkk4n5meYzKRv3/HSlxvIwg60CENUmaB/IQMOWuNJdJn8HyqVGGo8aVE8pzdUn2B5i2YM35lHK/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDx+kJj9DEEPdOdAlJliJBysHGFmO6CClTXO5+9FlD9IzvP0sn
	jDcpzvxMbCWgd7jkdadY9bPJ0E3Qdk+tLbHhVQlV+T/smW/KZz2uJdkcO70nD+CcPRbs9K6M/wS
	cmpnWulV6UCAgxJqsoCvjU8498EFVOkpSs84+7x3AZRWUxASTvdEQbRc=
X-Google-Smtp-Source: AGHT+IEIWp9flXGhhXhgak0B2xwMhDuvGbJEeEgooMA3ulZkQrEd7T2opRMQWMD/SiqFGUxx4YyX4ZVbrztloyW8hLlVSjOA1qSg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cb:b0:3a6:ae3d:920e with SMTP id
 e9e14a558f8ab-3a6b02cf8famr170485575ab.13.1730791863922; Mon, 04 Nov 2024
 23:31:03 -0800 (PST)
Date: Mon, 04 Nov 2024 23:31:03 -0800
In-Reply-To: <tencent_EE9DA7FFC6DD52DFC65889ABEEEC6EC64C06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729c9b7.050a0220.2edce.1504.GAE@google.com>
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in snd_ctl_release

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x2dfe/0x3ce0 kernel/locking/lockdep.c:5065
Read of size 8 at addr ffff888024ae6270 by task syz.0.15/6671

CPU: 1 UID: 0 PID: 6671 Comm: syz.0.15 Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __lock_acquire+0x2dfe/0x3ce0 kernel/locking/lockdep.c:5065
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __raw_write_lock_irqsave include/linux/rwlock_api_smp.h:186 [inline]
 _raw_write_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:318
 class_write_lock_irqsave_constructor include/linux/spinlock.h:601 [inline]
 snd_ctl_release+0x86/0x450 sound/core/control.c:120
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cdf97e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6b8df9c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000017f6a RCX: 00007f6cdf97e719
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f6cdfb37a80 R08: 0000000000000001 R09: 00007ffe6b8dfcbf
R10: 00007f6cdf800000 R11: 0000000000000246 R12: 0000000000018360
R13: 00007ffe6b8dfad0 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>

Allocated by task 965:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 snd_card_new+0x74/0x120 sound/core/init.c:184
 usx2y_create_card sound/usb/usx2y/usbusx2y.c:369 [inline]
 snd_usx2y_probe+0x387/0x9c0 sound/usb/usx2y/usbusx2y.c:450
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
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
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
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 25:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 snd_card_do_free sound/core/init.c:603 [inline]
 release_card_device+0x17f/0x1f0 sound/core/init.c:153
 device_release+0xa1/0x240 drivers/base/core.c:2574
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3780
 snd_card_free_when_closed sound/core/init.c:625 [inline]
 snd_card_free_when_closed sound/core/init.c:618 [inline]
 snd_card_free+0x1bf/0x250 sound/core/init.c:658
 snd_usx2y_disconnect+0x1aa/0x230 sound/usb/usx2y/usbusx2y.c:430
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
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888024ae6000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 624 bytes inside of
 freed 4096-byte region [ffff888024ae6000, ffff888024ae7000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24ae0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b042140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801b042140 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea000092b801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5202, tgid 5202 (udevd), ts 19805789419, free_ts 19472323126
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0xf7d/0x2d10 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x367/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 tomoyo_realpath_from_path+0xb9/0x720 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x273/0x450 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2373
 vfs_getattr+0x36/0xb0 fs/stat.c:204
 vfs_statx_path+0x36/0x390 fs/stat.c:251
 vfs_statx+0x145/0x1e0 fs/stat.c:315
 vfs_fstatat+0x9f/0x160 fs/stat.c:341
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505
page last free pid 5224 tgid 5224 stack trace:
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
 vfs_fstatat+0x86/0x160 fs/stat.c:340
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888024ae6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024ae6180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888024ae6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff888024ae6280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024ae6300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f8ed5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1630ed5f980000



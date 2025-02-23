Return-Path: <linux-kernel+bounces-527640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57FA40D9C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AE73A65F9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE11FCF63;
	Sun, 23 Feb 2025 09:17:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5B1C863A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740302225; cv=none; b=CLyG7ip4JhfEoN8QYQb1nFPd0/bus8opO98tqX8WqukTLKWNPXrOlb5JLhye287Ck6IedAYwxhsMOQY3x15+kwPpKiSRzjkadcnMzVmV3KaC6XZAdOCLxwgZMR2bvzmoiETA+qcZrVxO+qQAIkCBWb1XtsrYQWWpSYvuMrVV50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740302225; c=relaxed/simple;
	bh=cW/r6+D70A7WmJ7KIVUnZKGF3AfhLuZ2Ip3SFvIiKIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MNSYrn/yd9ckNLSQuCOzjEsWcKPzxxGDMmNvRR8Rm3hzSnAiO+1g0UNgqL9/YKc0EY8sHzvbPeZzl2S0AVTSBvAnUyPO5AJ3obwl6rrE9auzc0Jw3333KXwPJ4P8G1lOqCwhEewT9gVkWVeC/saQBMuRmAM+H/DLpOhBhXMGVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b6d933acso29203095ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 01:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740302222; x=1740907022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auPDD8oCQqBfR5Xi85x5KdU5u8VtDr6THDXmGxyO8L0=;
        b=IGWsO7DAhH9M6BanPMEGp3bAyiO3Ab+XHZB5I28BsFXu858b0O6/z7O2/Apyh4VpNt
         DQhCkIXy73Kv4JNbVahIG6agDznyV+21pycCXfWLVoum+Oa/9L1hKry2GO9WuE+/lIJ1
         VQ6tQ+c/BvCc4oTl9p30sjhsWP3A9nGco4nIKGdSpsmDBBSqGruSUr7bfKgndeyrfVwW
         6EnN66YmPSIs32fuVshnweIob76SW+Zpcu55SlEaWDILO/xllBO7mRBI51sKV5rmhQOA
         Oi0xZAxeBRW66KInQbUOMr/VO+olZSIezsMfLx6Xgq1wriFk1MgpLh50bTL/fThy0Rqn
         xrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJHVCD4U4xI4hJxDVM1/lUZOp02aw6tTViJnCgeyUjMiwbqK9l6nx/cWk/mfvwHni7yaxc5O+SVqc1XPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GJ5tONbxSec788+RtLcr5H1FJawjBjHALtFcuvH6qORVHMLi
	RXjxJ4B8x1FsWyt8CjaP0idZzNhTP/icof3JFnVjV623MtTIgh16SLB2grGnqzFDqcWylcqjXEj
	cV1xFu/DXMS9BeX+f0KfO3xlZ1o5SOEYHAtrOnObRgTCHsfdXOU3ne9A=
X-Google-Smtp-Source: AGHT+IHgiLwpa2s0Qt+LJpybDwHQ+VpuGY0s22JQvTgCQGqtc/0pwQPjljQxrpW02WM4c/AHyC5ocGlcAfOUE84RQMH76Tx5UHuH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3d2:5a0a:7227 with SMTP id
 e9e14a558f8ab-3d2cb48229dmr68797205ab.13.1740302222389; Sun, 23 Feb 2025
 01:17:02 -0800 (PST)
Date: Sun, 23 Feb 2025 01:17:02 -0800
In-Reply-To: <20250223090358.2692-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bae78e.050a0220.bbfd1.0012.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in steam_input_open

==================================================================
BUG: KASAN: slab-use-after-free in steam_input_open+0x14d/0x160 drivers/hid/hid-steam.c:604
Read of size 8 at addr ffff8881063ff130 by task udevd/6832

CPU: 0 UID: 0 PID: 6832 Comm: udevd Not tainted 6.14.0-rc3-syzkaller-00295-g27102b38b8ca-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xd9/0x110 mm/kasan/report.c:634
 steam_input_open+0x14d/0x160 drivers/hid/hid-steam.c:604
 input_open_device+0x230/0x390 drivers/input/input.c:600
 evdev_open_device drivers/input/evdev.c:391 [inline]
 evdev_open+0x52d/0x690 drivers/input/evdev.c:478
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:956
 vfs_open+0x82/0x3f0 fs/open.c:1086
 do_open fs/namei.c:3830 [inline]
 path_openat+0x1e88/0x2d80 fs/namei.c:3989
 do_filp_open+0x20c/0x470 fs/namei.c:4016
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb8155fa9a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fffe256d960 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb8155fa9a4
RDX: 0000000000080000 RSI: 000055674c828210 RDI: 00000000ffffff9c
RBP: 000055674c828210 R08: 000055674c851628 R09: fffffffffffffe98
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 00007fffe256db28 R14: 0000000000000000 R15: 0000556737a63ed5
 </TASK>

Allocated by task 24:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_node_track_caller_noprof+0x20b/0x4c0 mm/slub.c:4313
 alloc_dr drivers/base/devres.c:119 [inline]
 devm_kmalloc+0xa5/0x260 drivers/base/devres.c:843
 devm_kzalloc include/linux/device.h:328 [inline]
 steam_probe+0x132/0x1060 drivers/hid/hid-steam.c:1248
 __hid_device_probe drivers/hid/hid-core.c:2713 [inline]
 hid_device_probe+0x349/0x700 drivers/hid/hid-core.c:2750
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x114b/0x1a70 drivers/base/core.c:3665
 hid_add_device+0x374/0xa60 drivers/hid/hid-core.c:2896
 usbhid_probe+0xd32/0x1400 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x300/0x9c0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x114b/0x1a70 drivers/base/core.c:3665
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x114b/0x1a70 drivers/base/core.c:3665
 usb_new_device+0xd09/0x1a20 drivers/usb/core/hub.c:2663
 hub_port_connect drivers/usb/core/hub.c:5533 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5673 [inline]
 port_event drivers/usb/core/hub.c:5833 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5915
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 24:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x37/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x294/0x480 mm/slub.c:4757
 release_nodes+0x11e/0x240 drivers/base/devres.c:506
 devres_release_group+0x1be/0x2a0 drivers/base/devres.c:689
 hid_device_remove+0x107/0x260 drivers/hid/hid-core.c:2774
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 hid_remove_device drivers/hid/hid-core.c:2953 [inline]
 hid_destroy_device+0x19c/0x240 drivers/hid/hid-core.c:2975
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e2/0x960 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2316
 hub_port_connect drivers/usb/core/hub.c:5373 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5673 [inline]
 port_event drivers/usb/core/hub.c:5833 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5915
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0x9b/0xb0 mm/kasan/generic.c:548
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x1080 kernel/workqueue.c:2339
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2390
 hid_hw_close+0xaf/0xe0 drivers/hid/hid-core.c:2415
 drop_ref+0x186/0x390 drivers/hid/hidraw.c:360
 hidraw_release+0x3e6/0x560 drivers/hid/hidraw.c:384
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x24e/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0x9b/0xb0 mm/kasan/generic.c:548
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x1080 kernel/workqueue.c:2339
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 schedule_work include/linux/workqueue.h:723 [inline]
 steam_client_ll_open+0xab/0xf0 drivers/hid/hid-steam.c:1153
 hid_hw_open+0xe2/0x170 drivers/hid/hid-core.c:2392
 hidraw_open+0x274/0x7e0 drivers/hid/hidraw.c:308
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:956
 vfs_open+0x82/0x3f0 fs/open.c:1086
 do_open fs/namei.c:3830 [inline]
 path_openat+0x1e88/0x2d80 fs/namei.c:3989
 do_filp_open+0x20c/0x470 fs/namei.c:4016
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8881063ff000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 304 bytes inside of
 freed 1024-byte region [ffff8881063ff000, ffff8881063ff400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881063ff800 pfn:0x1063f8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100041dc0 ffffea00044cca00 dead000000000003
raw: ffff8881063ff800 000000000010000e 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100041dc0 ffffea00044cca00 dead000000000003
head: ffff8881063ff800 000000000010000e 00000000f5000000 0000000000000000
head: 0200000000000003 ffffea000418fe01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 1, tgid 1 (swapper/0), ts 7397750427, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xe76/0x2b90 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x21c/0x2290 mm/page_alloc.c:4739
 alloc_slab_page mm/slub.c:2425 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x94/0x330 mm/slub.c:2640
 ___slab_alloc+0xc41/0x1670 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __kmalloc_cache_node_noprof+0x21b/0x3f0 mm/slub.c:4333
 kmalloc_node_noprof include/linux/slab.h:924 [inline]
 blk_mq_alloc_hctx block/blk-mq.c:3945 [inline]
 blk_mq_alloc_and_init_hctx+0x639/0x11b0 block/blk-mq.c:4448
 blk_mq_realloc_hw_ctxs+0x8e0/0xbe0 block/blk-mq.c:4481
 blk_mq_init_allocated_queue+0x39e/0x11f0 block/blk-mq.c:4535
 blk_mq_alloc_queue+0x1c3/0x290 block/blk-mq.c:4348
 scsi_alloc_sdev+0x890/0xd80 drivers/scsi/scsi_scan.c:338
 scsi_probe_and_add_lun+0x525/0x7b0 drivers/scsi/scsi_scan.c:1209
 __scsi_scan_target+0x1e6/0x4e0 drivers/scsi/scsi_scan.c:1774
 scsi_scan_channel drivers/scsi/scsi_scan.c:1862 [inline]
 scsi_scan_channel+0x149/0x1e0 drivers/scsi/scsi_scan.c:1838
 scsi_scan_host_selected+0x2ae/0x370 drivers/scsi/scsi_scan.c:1891
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881063ff000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881063ff080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881063ff100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8881063ff180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881063ff200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         27102b38 Merge tag 'v6.14-rc3-smb3-client-fix-part2' o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17cec7a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28127f006c1c31ee
dashboard link: https://syzkaller.appspot.com/bug?extid=0154da2d403396b2bd59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158553b8580000



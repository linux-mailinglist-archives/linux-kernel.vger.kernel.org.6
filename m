Return-Path: <linux-kernel+bounces-266821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6694081B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E4E2831BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D54167DB9;
	Tue, 30 Jul 2024 06:09:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C59624
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319744; cv=none; b=DXczzHAvkDZwr6ra00Gok2Kz3TDoAsQtsOzNigyrqyZVUzCFXxAyHis4+IPJ4oroBcIqtKNK57KTXR6D1/UGhuUIL/5ykELSPvf71MXvxc/Ztgoh9MAkBl+QI9f2IA/qDcN87F1N1RUlQrZYFyGQynh0eKONeaVhPk4cHHx1KQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319744; c=relaxed/simple;
	bh=E4eOzSiK4plCX0GIU2sdJ0Wzf4yAogxHfSBNWnbvYjo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IISp1cyg1j4pKN6RC9A1E3IQQmvBEAnvnf20PjT5ibMzXWTVsOG7JaevU8Gazy5GqTdJ/tBrsKMgisoQBNYk7WdqGmRVHvv145VYKJQYiXhIGM0xy7j/Wd/8pdy2R7oqyANbeynabZTwku62KdknUqNwVjwB6KXAuNYnyiwhzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so153568839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722319742; x=1722924542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zdtroyni7nc8ql8tkXavVpPTvMhRQ4YRis8yLIEg2w=;
        b=Jv7Vvl3uJL13G6K8SKRsligUyfLkAwjaesMs3fsvYjo6NEO9ApHgEEqDUqGrIKKOpR
         eM0WnmXUqT1U/JbmfFIdIo6nY3m1RzOPLuRffplp0ucPl6wkcLfaTWm6CtPXcY3QOdLf
         kZFbxft6EdJ8IiefKPbu/ZBGGqB1tR5FDeLb++ydCRZa2an7+ScSpNAqHYdLhTsqywMT
         FIkQGoCaoB47V94qJIKcEdU5TlSc1LfLr8fpyueLXi1/+rDTK7kiL+2VprtpfGU6VaPe
         sxUWzb0KD3hRXe1LnzM0wUeaRKPS7QdKTU2tpabAml6PNKn/YePRpVruXBeQqyAyfGTt
         OTfw==
X-Forwarded-Encrypted: i=1; AJvYcCX+rpis2hXNtrj3dxiBOrO95DO0b4Fz+Zlp/yzUnlCk477enf2qlBRNFtMPQd1Y+xOgRA4kQs6tkL5SK5RoibyQtoElE8ik4tRQroej
X-Gm-Message-State: AOJu0YycZtM01V3OqOkkPjqCfhzfaU+z2EWuCQFfJ2EcVGPPlW8yMEP4
	UqFQC3TTMnytsMClUJMoZMzkNoJf8Blt3w5tgCPXSioAJJ7RCJPOxi4PVTOPt2piVB4pMWA6ckZ
	SSnkTEWl20eurYItBHq4xx/NP58fdc+DTXbOJ0mRrXvTgYkkdgwWClgM=
X-Google-Smtp-Source: AGHT+IE/PnEMPDSb7r+sd649m16falOp216mH1QsR+lrQHq4aCs0jv9vptuyzbMGGZAlCbR70TgHFtd6OZZj5OK+cpMPudRcvo+U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8708:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4c645146649mr231350173.4.1722319741875; Mon, 29 Jul 2024
 23:09:01 -0700 (PDT)
Date: Mon, 29 Jul 2024 23:09:01 -0700
In-Reply-To: <tencent_A2209684364A4BE47431769567DA3DC33709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006789bc061e70d00a@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
From: syzbot <syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in put_device

usb 1-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: slab-use-after-free in kobject_put+0x503/0x5b0 lib/kobject.c:733
Read of size 1 at addr ffff88811374003c by task kworker/0:2/43

CPU: 0 UID: 0 PID: 43 Comm: kworker/0:2 Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 kobject_put+0x503/0x5b0 lib/kobject.c:733
 put_device+0x1f/0x30 drivers/base/core.c:3787
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 41:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 hdm_probe+0xb3/0x1880 drivers/most/most_usb.c:959
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e66/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 43:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x10b/0x380 mm/slub.c:4594
 device_release+0xa1/0x240 drivers/base/core.c:2581
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 put_device drivers/base/core.c:3787 [inline]
 device_unregister+0x2f/0xc0 drivers/base/core.c:3910
 hdm_disconnect+0x1bb/0x220 drivers/most/most_usb.c:1127
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888113740000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 60 bytes inside of
 freed 8192-byte region [ffff888113740000, ffff888113742000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x113740
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000040(head|node=0|zone=2)
page_type: 0xfdffffff(slab)
raw: 0200000000000040 ffff888100042280 ffffea000425be00 dead000000000003
raw: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000040 ffff888100042280 ffffea000425be00 dead000000000003
head: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000003 ffffea00044dd001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2651, tgid 2651 (syz-executor), ts 42037680054, free_ts 41938721681
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4696
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2321
 allocate_slab mm/slub.c:2484 [inline]
 new_slab+0x84/0x260 mm/slub.c:2537
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3723
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __kmalloc_cache_noprof+0x27a/0x2c0 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 cgroup1_root_to_use kernel/cgroup/cgroup-v1.c:1217 [inline]
 cgroup1_get_tree+0x936/0xed0 kernel/cgroup/cgroup-v1.c:1244
 vfs_get_tree+0x8f/0x380 fs/super.c:1789
 do_new_mount fs/namespace.c:3472 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3799
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount fs/namespace.c:3997 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 2651 tgid 2651 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x698/0xce0 mm/page_alloc.c:2608
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x4e/0x70 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x11c/0x2b0 mm/slub.c:4044
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x86/0x160 fs/stat.c:340
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88811373ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811373ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888113740000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888113740080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888113740100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d2e79d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160b42f9980000



Return-Path: <linux-kernel+bounces-266873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C709408EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FE2B231D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87F18FDD2;
	Tue, 30 Jul 2024 06:55:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0F15D5C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322505; cv=none; b=LgeBJNwN6jWrQOdyDsUtWsCLz2x0iw4mh/fIA/HLeYlCLfVnBvl1rUcqFDjY1WfYvoy/1IRtN4mnSioxupiIoYnG313Ok4jnfKu99tG53HbBsp8fuxBTEsfJK4VFESNFmggDABFoI9JogzFzSeCZM5PzzA/5UIXAlFok/LXmzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322505; c=relaxed/simple;
	bh=/4cld57TW1JwI0R05bID8ZotcD54EqUGP4bqgHrr+cA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d3AFRF9vzTJ/ZYoI8A1QaDpBkuRvSJ7qWlENxmEuKXuJAVT07l7fsHZK4l/VqlVkBdmxFf2IxJvp9dTkX9EF9mO0c1AVT038Ob/MZ1CgNIYofRB2LSRIgMX4dXIaBRnffXC9tZgg844nR/1yXBMy5m7Nonj5PCFZ6ieQWq1B1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so663877539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322503; x=1722927303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWNbm36N88vnpQH5B7CrzF0SrR6tLieOkkp7BrFM/E8=;
        b=EI024hM2p664HSERa8ckjPP7Y2BrdkNd0nTE7qKBLoBCVnjTO5AzSkoZtcaADKuCOD
         8I8cQ80CMaZH2z2zT7Ga3SMekC2kYODqpKCbIojDm3YKLiXoYjmHrJskq6hWrnYA1iSq
         n0vd14CW4t4ZjuXxLBmWotKwec0ituJrcW5RSFwVy3W/Z2sM9yWNFP29DFJKuCRbntAA
         O+EGyHDw7WjWWV00dr7+iJ00brooRCAhdSdh0Li8EivAMIA2ttsZFGHLLJjdIRRMieiW
         2pm+RA1EPO/3GrezPhPEBwVT8vBL1cp27p//SbquUNUBPuSqDaKU0To36z7nxJAOxLCh
         Vbmw==
X-Forwarded-Encrypted: i=1; AJvYcCX/e+BA0FjnzLQ54ThPrmwUuhqqLFGVkCP00i+wEMLSQjosi+rqpuEm5u/g23tVlLzdSErRkCDm9OdYpnSZ9v2xyXjNzw5lxEEUN2vx
X-Gm-Message-State: AOJu0YxHUkirZR9rlJRkgCwCLHa3uTGBgQqRJgDTIEWmAA++CCCM4ITF
	x3NcFKj2r3p8zFcI7SwCq4LOhTGF/5Gn5rgEafEyPoplmEKavKxOA1pO2iYlVMRbPCYRyGyldA4
	0VpHYwFxy29fagdV+td9xvWqTxNoE/RrrbyuMbaWWRlNrnmaCiN0rmtE=
X-Google-Smtp-Source: AGHT+IE9plhkT9uswjE5wFVSN+iCRdKpSZ6FZRs02TwqFNDEnYTIWspcJMOG1KYtE9TwN/A405CRQOzKSlRczgQDhAhsKeKbOgqn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d5:b0:81f:7e71:250f with SMTP id
 ca18e2360f4ac-81f960b87d6mr19702039f.4.1722322503082; Mon, 29 Jul 2024
 23:55:03 -0700 (PDT)
Date: Mon, 29 Jul 2024 23:55:03 -0700
In-Reply-To: <tencent_55464A0A741D765767043CCB37A896943709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc3703061e717415@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
From: syzbot <syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hdm_disconnect

usb 1-1: New USB device found, idVendor=0424, idProduct=c001, bcdDevice=1c.8f
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: config 0 descriptor??
usb 1-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: slab-use-after-free in hdm_disconnect+0x227/0x250 drivers/most/most_usb.c:1125
Read of size 8 at addr ffff8881131c1898 by task kworker/0:1/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hdm_disconnect+0x227/0x250 drivers/most/most_usb.c:1125
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1271 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1294
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

Allocated by task 9:
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
 __device_attach+0x1e8/0x4e0 drivers/base/dd.c:1028
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
 __device_attach+0x1e8/0x4e0 drivers/base/dd.c:1028
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

Freed by task 9:
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
 hdm_disconnect+0x10b/0x250 drivers/most/most_usb.c:1123
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1271 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1294
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

The buggy address belongs to the object at ffff8881131c0000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 6296 bytes inside of
 freed 8192-byte region [ffff8881131c0000, ffff8881131c2000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1131c0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: 0xfdffffff(slab)
raw: 0200000000000040 ffff888100042280 ffffea00040ff000 dead000000000002
raw: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000040 ffff888100042280 ffffea00040ff000 dead000000000002
head: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000003 ffffea00044c7001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2651, tgid 2651 (syz-executor), ts 39969872238, free_ts 37861985419
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
page last free pid 2646 tgid 2646 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x698/0xce0 mm/page_alloc.c:2608
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2843
 handle_softirqs+0x209/0x8e0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff8881131c1780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881131c1800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881131c1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8881131c1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881131c1980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1402a373980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1022d19d980000



Return-Path: <linux-kernel+bounces-433188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5CA9E54E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5749E18812FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B267217707;
	Thu,  5 Dec 2024 12:04:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046A1F541D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400245; cv=none; b=gIg3Ov3G2McAajDS3oDK6xQllWJ5jWWiwRhkTpqy25SMJUoR6TaGTeNGI2Ig5QHAsB+7RSSNqsd6qNrtCMS2VF7NbJ6XLNkDkF/YCK2iHA+dGx6KCYNQMT+LvAZVCkcbuHPtIb4RMrflMmyf/bVTW9ZpkiQP0C1/666o3395WeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400245; c=relaxed/simple;
	bh=V/oDLGZlwSiaMBwPSdC4Pl02hunitghdiaZHyBglz0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OqFs8TI00Z32UiIUJJ2gPaP6UYE1wvqz6z4dlftND8Z8bpkll2TepGPHx34WPwlVgfI0jazKjiMRifWjghJveVjpyrt40X6eu1LKxcj1i8sC0W2yVABNkK62aclox+Bx3VSUqQzY8wyV+hTr71Nn00ODPrCase/RfsHFBl+6FJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7c729bfbaso7468245ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400243; x=1734005043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTNENRAU3blFTD54PWIHjBmb/8lmbSTBvWWM9IPjb/s=;
        b=Tgp8JgH7BC0yjXzTBlWmxAa2JPoZGsedoY1PHFw/QsM7naYt9vY2Kla0X/SldZD8ct
         owuwO6E0inhqbc2iSX/37NIC/09C/+C3e1CyEtNUDCJh+tmXiHYOrhMJLl/xw469bra2
         Rs2twIcBtZFXs5M/Yu1lh8ydOc3diFwHqXgH/zfCO7SgPCpIgs2cAM8dR3pba1VO2775
         vp+Mw4J+FX1g9llcd5fvstYinajk50mYI+mUc/gFlpu0V88tK7ivrhZJ5bxuav+s6zFA
         93Gn8dluyGZgK8cy+KpsiS1JQg0xWeKHhAZzuQrvZ77iElQFbIKq7CumD3NfayxVRyKC
         s1XQ==
X-Gm-Message-State: AOJu0YzFLdBh1Hg5tgU2BCCyIndB8L80XQ2GvTUg4uNCuv/DktxdQsRN
	BY3zs9zSridbkIr3e7gqu2lkE7ZgbRU/JB3nHXNMjNYGeFta7QAYtDid8mdDX0WDjNW6Y2pO89B
	NBwC1NJHiy+9pfVHuO7NOmHVI7mBGnBI5iJsYGxKLYOD/Jj89FxZlTYY=
X-Google-Smtp-Source: AGHT+IHHlwuELnYRicEGwHoFoapQxwXDaRgeUk8ITFchHlYBqvP8eRVV5vn3c8ySY8yS4IQkbnv53IW33y9LhBAdZeCGxqtc/x4S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:3a7:c5ff:e60b with SMTP id
 e9e14a558f8ab-3a7f9a3bab6mr138473685ab.6.1733400243268; Thu, 05 Dec 2024
 04:04:03 -0800 (PST)
Date: Thu, 05 Dec 2024 04:04:03 -0800
In-Reply-To: <D63QK91VZ3BS.3IA9R221PTFE5@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675196b3.050a0220.17bd51.009c.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
Read of size 8 at addr ffff888140ed2418 by task kworker/u9:3/6570

CPU: 0 UID: 0 PID: 6570 Comm: kworker/u9:3 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 17429:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5568
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 17422:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x430 mm/slub.c:4746
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9550
 hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5208
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888140ed2400
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888140ed2400, ffff888140ed2460)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x140ed2
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801ac41280 ffffea000503b580 dead000000000004
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3080886517, free_ts 3024822992
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 acpi_ut_evaluate_object+0x108/0x4a0 drivers/acpi/acpica/uteval.c:50
 acpi_ut_evaluate_numeric_object+0xb1/0x180 drivers/acpi/acpica/uteval.c:182
 acpi_get_object_info+0x5f6/0x1220 drivers/acpi/acpica/nsxfname.c:348
 acpi_set_pnp_ids drivers/acpi/scan.c:1410 [inline]
 acpi_init_device_object+0xbeb/0x31a0 drivers/acpi/scan.c:1829
 acpi_add_single_object+0x106/0x1e00 drivers/acpi/scan.c:1880
 acpi_bus_check_add+0x32b/0x980 drivers/acpi/scan.c:2181
 acpi_ns_walk_namespace+0x294/0x4f0
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 __slab_free+0x31b/0x3d0 mm/slub.c:4509
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_remove_cache+0x15d/0x180 mm/kasan/quarantine.c:378
 kmem_cache_shrink+0xd/0x20 mm/slab_common.c:563
 acpi_os_purge_cache+0x15/0x20 drivers/acpi/osl.c:1585
 acpi_purge_cached_objects+0x8f/0xc0 drivers/acpi/acpica/utxface.c:239
 acpi_initialize_objects+0x2e/0xa0 drivers/acpi/acpica/utxfinit.c:250
 acpi_bus_init+0xda/0xbc0 drivers/acpi/bus.c:1367
 acpi_init+0xb4/0x240 drivers/acpi/bus.c:1454
 do_one_initcall+0x248/0x870 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147

Memory state around the buggy address:
 ffff888140ed2300: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888140ed2380: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff888140ed2400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888140ed2480: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888140ed2500: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15eb10f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d310f8580000



Return-Path: <linux-kernel+bounces-432503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731039E4C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429A7169821
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE116C850;
	Thu,  5 Dec 2024 02:24:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321922EE5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365445; cv=none; b=RPEPyYnr9r9YRofkvFBYf4avEBwFc55JisH3zW8fsWpeYYI53bTSkohJL1jkWI0vIdsZAGcaIhsrB4toYZMC7Vx3Fu3vbXJywJcXN/pT77K0CZ/54AWS1uUKDzxoLgKUJh85S6GHjOniXHEZaconvHvel2gFZa8UiS5ytfYAUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365445; c=relaxed/simple;
	bh=l4NRzzzfK0f8IZWrBn5lvtCqKKcKYXBqU+kIXzH75/A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kuEe9/FP3DyTKQNEzHdwsYPaOrriGrNvXj/oPWWZToXbr0625lDU98aEev07Q1iGJrRJ7CquHgxYPX7IOGiitWxXR7cDyCZKmc5u7wA5SAHeRhGnTrfiPWYOaoptv0qwudORXXdAMSGaa4DmohYoAurVnWngXguvbXa5d2p2zrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8444dc6b982so147482739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 18:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733365443; x=1733970243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRnPHt1LQlhbSXjS+/kLxcXdOHuYNeuPv3wtFB9kK5M=;
        b=EEnFELdxvm2uiWyLD0MdU8YB8RqYK7tX41Av406zk51I0fgskqtdrv1fAA1P//H/6U
         vjg1WmAkfIDL9DGFICyvEFyWBhperi1v5CDLJsHFilxO72FhZbgZyGrmHkE+87W6Nset
         XdbSfxfo073eZNeWuYkp/fMcMf6WsF1UEz6I5kLzcatiev+EC1rCLaR5wCY4wfKyoOqR
         +YzX13CRtVLGmlCI5wDytAvZXyh+V+/t1bhBJ895BPaFfMhYzKoiKbQ9q3PV7av4xBeT
         tAFDP9iFv2JpnOLlKGEoBN6huL9tp/XE/joWYxjet5JGSQFN4vInUP91sGBcFjpA0SOh
         ObIw==
X-Gm-Message-State: AOJu0YwjmK1m+Hg1lq05vsBQbD8YFCX3pCKyUhBnmCb+46JIAiKXk962
	tvnjWBwvs3Dnk31HIeo2fh8f6bAIg+LdAvzIsuCZJ1l9fPvCAS9Cs8SWXV29NJtsH9U4bihhrmt
	DDa0UaIrn7vJgbpFr4U5RZREXigSeay3568IN01U9oomAvvg/794Q9+4=
X-Google-Smtp-Source: AGHT+IGRnP45M1MEIyLU63NJPy0SVX8vJApOUdP2Sqw0VQY3Dj2HBXoTN2H1BixkK2dIx2PHZkOm2ObJrYNpTaeiLwHwvn7I+NB9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:3a7:cff5:16d6 with SMTP id
 e9e14a558f8ab-3a807576a6amr20150665ab.3.1733365443352; Wed, 04 Dec 2024
 18:24:03 -0800 (PST)
Date: Wed, 04 Dec 2024 18:24:03 -0800
In-Reply-To: <D63E89JWB8QV.38E70BVWNMMVL@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67510ec3.050a0220.17bd51.0083.GAE@google.com>
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
Read of size 8 at addr ffff888146bcbd18 by task kworker/u9:10/6582

CPU: 0 UID: 0 PID: 6582 Comm: kworker/u9:10 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0
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

Allocated by task 18135:
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

Freed by task 18133:
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
 hci_dev_close_sync+0x6c4/0x11d0 net/bluetooth/hci_sync.c:5208
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

The buggy address belongs to the object at ffff888146bcbd00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888146bcbd00, ffff888146bcbd60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x146bcb
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801ac41280 ffffea00050cae00 dead000000000004
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 10039183850, free_ts 0
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
 usb_hub_create_port_device+0xc8/0xc10 drivers/usb/core/port.c:744
 hub_configure drivers/usb/core/hub.c:1710 [inline]
 hub_probe+0x2503/0x3640 drivers/usb/core/hub.c:1965
 usb_probe_interface+0x641/0xbb0 drivers/usb/core/driver.c:396
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888146bcbc00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888146bcbc80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff888146bcbd00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888146bcbd80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888146bcbe00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175c28df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b428df980000



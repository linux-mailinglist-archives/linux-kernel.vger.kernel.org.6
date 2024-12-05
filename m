Return-Path: <linux-kernel+bounces-432529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458B9E4C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34B1284E07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448D13A26F;
	Thu,  5 Dec 2024 03:06:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53F2F22
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367965; cv=none; b=JvgXT8DW8OKjmTTw5JdQH8u7gNnmVLC4yKkTf2zhBsz04EtmKTGfvdSeqVFfXvTLzLo8hR2Tcw049phVcgbI0loNbDW7bLR/Ae5f3ByOgqI5SGO8C/307Mgpdf4ilzn8sNkrURtRGYW+UCJVXIdbqlxU19c1YtnQXsF2EF9xzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367965; c=relaxed/simple;
	bh=FEBGg9Ws1rNDTaIenV2m551VskBWHe058rx/oAsTG1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q/LfmyEuAnVNbOt99Y8vEFqyNlQKZnEKqiITY7LIv5hHgwt+D6UHRmmQ3BhJQYcLTZZcnls5nMb95IiqRHKabiKX3F9umUQxAWcneT++recpBMYaoglXoCEIjKBjYgZYGWldXNe3bOyYyKmiJM5O7Cn/To/111f5ERYWdbhNUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7932544c4so5260665ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733367963; x=1733972763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNPT0FwEEa8W/1EdpIhm7lIMs9k7oUcth51xM2l0pHk=;
        b=TdGSxxZbh5/UCZnFp5Giv8sUHmROmOMctfralXMcl1mbYcpFwkfeO2Qt19RYjjOLP3
         GEVDmsOlpTTA/JxuYPuiD5Veujh5pR6qdqeXfEuH+5wDJlbXJu1vsTrKCgTo61Jv4Ahe
         1JHSCQS/Dpw0B8nGf/dp/obJesXDlOIrG+7kQLX4H7+Vmlpxl5PaYlxrLEw5TYJxVjfn
         d2/Q6Wcg8STv7aHFY9GCOIZQhLmMyWaEg9kgKTu89ULm4qPAubnQbMTKJ0hQBxHVHP54
         pjeXpjSFQZg6nLWRW4tFiMpkctTntW7Hbz141gTrlK9NqjM7c3LkFjlZ8ovfU7tpT48K
         lCwQ==
X-Gm-Message-State: AOJu0YxIViqNOCypCakP0K6t5YKpHNe0MAOzRcYTbVGxO35XzJqR8z3x
	gJ2ke5x4BLuHrrAOXNDQnZh0OMyIynY2uAzLwPpJw4yBPtxXMO0wrnlzmUAknSM+HFprnLvlmHv
	6cQdABDZBR5ZK76q1GZXs9PekL5Z56yoKTGsbE5qFZJKpc2Px7H/ZYDk=
X-Google-Smtp-Source: AGHT+IGHc2xTCwcq7UkOCKk6M5rblTg2fSXUhzLSwnyaZS5yarQ9F4JiqYOUROYonsbbapyFABh5KJ8DxS9o/GV4o2DAyWG4yeaI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3a7:e103:3c43 with SMTP id
 e9e14a558f8ab-3a7f9a9fce0mr118059435ab.19.1733367962917; Wed, 04 Dec 2024
 19:06:02 -0800 (PST)
Date: Wed, 04 Dec 2024 19:06:02 -0800
In-Reply-To: <D63F6G8FUI2Z.30SG3KT5F58CE@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751189a.050a0220.17bd51.0084.GAE@google.com>
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
Read of size 8 at addr ffff8880296a9a98 by task kworker/u9:3/6538

CPU: 0 UID: 0 PID: 6538 Comm: kworker/u9:3 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0
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

Allocated by task 13066:
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

Freed by task 13061:
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

The buggy address belongs to the object at ffff8880296a9a80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff8880296a9a80, ffff8880296a9ae0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x296a9
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0000b6b480 dead000000000004
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5925, tgid 5925 (syz-executor), ts 72840107512, free_ts 72823081230
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_slab_page+0x59/0x140 mm/slub.c:2410
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_noprof+0x2ee/0x4d0 mm/slub.c:4289
 kmalloc_array_node_noprof include/linux/slab.h:1018 [inline]
 alloc_slab_obj_exts mm/slub.c:1964 [inline]
 account_slab mm/slub.c:2537 [inline]
 allocate_slab+0xb6/0x2f0 mm/slub.c:2592
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_lru_noprof+0x26c/0x390 mm/slub.c:4172
 alloc_inode+0x87/0x1a0 fs/inode.c:338
 new_inode_pseudo fs/inode.c:1174 [inline]
 new_inode+0x22/0x1d0 fs/inode.c:1193
 debugfs_get_inode fs/debugfs/inode.c:72 [inline]
 __debugfs_create_file+0x142/0x4b0 fs/debugfs/inode.c:433
 nsim_bpf_init+0x178/0x260 drivers/net/netdevsim/bpf.c:634
page last free pid 5925 tgid 5925 stack trace:
 create_dummy_stack mm/page_owner.c:94 [inline]
 register_dummy_stack+0x8a/0xe0 mm/page_owner.c:100
 init_page_owner+0x3e/0x970 mm/page_owner.c:118
 invoke_init_callbacks mm/page_ext.c:148 [inline]
 page_ext_init+0x731/0x790 mm/page_ext.c:497
 mm_core_init+0x4c/0x60 mm/mm_init.c:2669

Memory state around the buggy address:
 ffff8880296a9980: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880296a9a00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff8880296a9a80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff8880296a9b00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880296a9b80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
==================================================================


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e0e330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a228df980000



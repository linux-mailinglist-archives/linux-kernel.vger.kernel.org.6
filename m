Return-Path: <linux-kernel+bounces-390213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2FF9B771C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78721F24E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898E2AE9A;
	Thu, 31 Oct 2024 09:10:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162471EB48
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365831; cv=none; b=nzJNKY5fGr9Y6vm6YqeP6orweYtZEwy0woC8k3ogp8R4D1ew4KYWHkV4BnBdUtTbGG8VoSFBw5EIApKgmYI7ePVsj4nzQLncYJ5AQooqlZzchuEw1X+rJGjWIsdWhrTaGosCn1JxhRzzoh3ffKJ4guNIqRyY2iqP9v8uekqeulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365831; c=relaxed/simple;
	bh=UXBKbN8Q03vwk0wBIECiFjMe0MiEs6y1L9qwO/mBlKc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FzSFuOk6QHWz3fNFxB/AnfG9NZxiGrzZCKA9MKwfSx1CQI1Ppv0g2I8PE51WHCMiyhqAHOVkRof5b1RaQydZwTtnXM6IiuS51/TcR1ck48wuTXr5TPcVy1zMIECDf0PXvD384aXi+fTodtEeKgAw4ln5kz+XdSnuXu5l4Y3KOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so6901515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730365828; x=1730970628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=un1eeePGJnb2fPMV/1p78PMykBsZecZQWVcVVauCuIk=;
        b=empT5v3fXMi/ITOsZ8yJuvkkq03+rkEgW5FbQdV9R6G2cGVsVlbyh9SsjM+jzQKEPw
         RKGt900owZQVQrzYrGSNWp0VvB1PBIhYj8OPKBDQGUXEdjQhdO1qBSGpfKbe6uqak66W
         NDYtMKgTWwFM9N0fjtbqF+zvFNxH4JlEUiEhbegPHhnCUFIMHaVIAGNP2yvMwdhwPzq9
         M48GaSJWlyV8vMvfB51mOxLECyTwGKoJMhg2R8s00fJ2Sb1ZOLDE3loYZUFdBcjiijjh
         1cr4Ez1pgNuqTgbMHrjW35XiseSkygB/JoaFdWL36egYi5xqGSaqb1JZrX+b1kqhz54S
         GAsg==
X-Forwarded-Encrypted: i=1; AJvYcCUEnOkKa0UHd0f+gUwNCkKhod2ngO1TTwq9zYt8hOunoa2xVE85VKoq6ymc6iAql87wvGrHez1ircJyr2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtLXclgkryuW5B7NhQGZeY6MGUnubqz2qYgTh52RjngdUHx25
	2B69Vu8mgmjwAtEWSL4IegkyJ6tHzG51EZIYUuv79B8tqYSSPH7dFEFwHdAliS03nH8qqaVj/hx
	PlTJ/hTMUp7V15+tNyqhvY1wV2jgTQd+RKafDerQLh7GEEUpjvhHS/F4=
X-Google-Smtp-Source: AGHT+IHKbdI2YKoxhIOU43ZBO3m56hgzYZhb+ATsLKvhK0upVCL7byKUGEq9NXKs0/LOo8/F+S4y+us9cbWmOmJrGo7C2VtUrvox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:3a0:9c20:8070 with SMTP id
 e9e14a558f8ab-3a4ed2f6686mr189239605ab.20.1730365828282; Thu, 31 Oct 2024
 02:10:28 -0700 (PDT)
Date: Thu, 31 Oct 2024 02:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67234984.050a0220.3c8d68.076e.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl (2)
From: syzbot <syzbot+0279a044abc93c9c0684@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b423f5a9a61f Merge tag 'acpi-6.12-rc5' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d87287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a34ca8ca33c0e535
dashboard link: https://syzkaller.appspot.com/bug?extid=0279a044abc93c9c0684
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd2685b6666a/disk-b423f5a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1f63783bd3d/vmlinux-b423f5a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4881955fd575/bzImage-b423f5a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0279a044abc93c9c0684@syzkaller.appspotmail.com

Bluetooth: hci4: command 0x0406 tx timeout
==================================================================
BUG: KASAN: slab-use-after-free in hci_send_acl+0xc03/0xd30 net/bluetooth/hci_core.c:3236
Read of size 8 at addr ffff8880278fe418 by task kworker/u9:3/16375

CPU: 1 UID: 0 PID: 16375 Comm: kworker/u9:3 Not tainted 6.12.0-rc4-syzkaller-00245-gb423f5a9a61f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci4 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hci_send_acl+0xc03/0xd30 net/bluetooth/hci_core.c:3236
 l2cap_send_cmd+0x6e5/0x920 net/bluetooth/l2cap_core.c:973
 cmd_reject_invalid_cid net/bluetooth/l2cap_core.c:4201 [inline]
 l2cap_disconnect_req+0x440/0x4e0 net/bluetooth/l2cap_core.c:4439
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4780 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5535 [inline]
 l2cap_recv_frame+0x1ee5/0x8da0 net/bluetooth/l2cap_core.c:6817
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7506
 hci_acldata_packet net/bluetooth/hci_core.c:3799 [inline]
 hci_rx_work+0xb1c/0x16c0 net/bluetooth/hci_core.c:4036
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 13060:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 hci_chan_create+0xa6/0x3d0 net/bluetooth/hci_conn.c:2732
 l2cap_conn_add.part.0+0x1a/0xa60 net/bluetooth/l2cap_core.c:6856
 l2cap_conn_add net/bluetooth/l2cap_core.c:69 [inline]
 l2cap_connect_cfm+0x428/0xf80 net/bluetooth/l2cap_core.c:7237
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_remote_features_evt+0x4f2/0x980 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7443 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x16c0 net/bluetooth/hci_core.c:4031
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5148:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 l2cap_conn_del+0x43a/0x730 net/bluetooth/l2cap_core.c:1795
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7233
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x340 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5592
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880278fe400
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff8880278fe400, ffff8880278fe480)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880278fe500 pfn:0x278fe
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801b041a00 ffffea0001f91950 ffffea000080d9d0
raw: ffff8880278fe500 000000000010000d 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 11, tgid 11 (kworker/u8:0), ts 9319502921, free_ts 9295059343
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_slab_page mm/slub.c:2414 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0xca/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_node_noprof+0xf1/0x350 mm/slub.c:4303
 kmalloc_node_noprof include/linux/slab.h:901 [inline]
 blk_alloc_flush_queue+0x94/0x2b0 block/blk-flush.c:483
 blk_mq_alloc_hctx block/blk-mq.c:3790 [inline]
 blk_mq_alloc_and_init_hctx+0xc28/0x11a0 block/blk-mq.c:4249
 blk_mq_realloc_hw_ctxs+0x4bf/0x630 block/blk-mq.c:4282
 blk_mq_init_allocated_queue+0x39e/0x11f0 block/blk-mq.c:4330
 blk_mq_alloc_queue+0x1f8/0x2f0 block/blk-mq.c:4158
 scsi_alloc_sdev+0x897/0xd90 drivers/scsi/scsi_scan.c:337
 scsi_probe_and_add_lun+0x789/0xda0 drivers/scsi/scsi_scan.c:1210
 __scsi_scan_target+0x1ea/0x580 drivers/scsi/scsi_scan.c:1757
 scsi_scan_channel drivers/scsi/scsi_scan.c:1845 [inline]
 scsi_scan_channel+0x149/0x1e0 drivers/scsi/scsi_scan.c:1821
page last free pid 46 tgid 46 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 vfree+0x17a/0x890 mm/vmalloc.c:3361
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3282
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880278fe300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 fc
 ffff8880278fe380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880278fe400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880278fe480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880278fe500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


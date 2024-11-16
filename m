Return-Path: <linux-kernel+bounces-411561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1449CFBF6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 02:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F8E1F2415E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C6118FC9D;
	Sat, 16 Nov 2024 01:23:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85D802
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731720184; cv=none; b=r+UL7bOCAe1yL0yscP4jeEDtmcctmOSmYwqQT7FksWcsZ7EV/NTZNjP8ZIWrtmLjSL2wt/HaPqjW8K+v/1X9LBfbsN17vG9QZ4KJdemKjzzFVOwPD7W0Q9rmub/PLOhGAxFEFfrnkmypPi2xYPTqra3ZUD5kS150VgAoBRcpAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731720184; c=relaxed/simple;
	bh=DbWt6Ye5C+XtNljQ9MbDq7KQunZoufbQmOsTCApRMX0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KTi0JmGOckSVyF+C2exMd35CbB/uAEPWpeUJCxZKzj/V1TlkEQlM4C7+mMmqzZTg+U+C9NtEoyY/Ubbo1eeZ+ORGweXTaDWkgiuWgjnVCvHDtSh4x7B2aMXVTDRiaORRgd3Vgm5ZfWrdpXfWzM82q/gaof0Pb+q+2GKq0naHHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so25791865ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731720182; x=1732324982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yg1yqUdS52SUB1M4lt6DBFrAHaBlhHNhXh3ZwI/40cQ=;
        b=vchO6zbOgE3Q0ilkK7/tKxnPLP12ZBVi1DAcC3r4z384ivB2LViZLBRD1hvS98GAlR
         kcnbtbWnq0sga9EgYg2V32+xh9nphncrBk09g0Dzb5PMe8Vlkgs25WZ7aydBTpsYDSsr
         Gd5L+PQdpd69Owo6kdm5bbJwn3zqFGewpy2l2kDuPHtINiGK0V8WlUBs+CIo9ru59MJ1
         /yK2/sUFZ7H2j6uiPsR/SNQkj/Yl+5U1RpOUyE6O9fc3eeV9gzOwdHL98oHTLtSKJE8Q
         waMfMnNXKeSXjufY13naayte92vB9d9x1doyrXfYEjTfBtD1d6kwVuJPTEzyxX2LZr96
         v97g==
X-Forwarded-Encrypted: i=1; AJvYcCWw796wJ9mri8N2aaWvluPvWUqcdh8Es4Q2CuchBwOFOoSJEIgzBENci18VozKEm/OqSNK4U7XSSI1vv84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnfTY2Qyjv0D2mshacljyGrc+bcjokPlG+3UtKbEcLjRP9Et7
	znrfe7phd8NsPigb56lExJnFKPDXf0IzaOhsIGjJ3NQwBoArX7sDfAOkOz0O5ljSfRYsvVaZ5mO
	OeQ87o45rCL06iX0W7Fdd5lokEFyddebwIs0dSC9o64GL2x0aEysZvTo=
X-Google-Smtp-Source: AGHT+IG1NtCA5adol+iZAFbCrsSg0dxlKn4kICBnbg3/e0KdTnzIeEjU4CGN0zbXeJHR4Zhh2ToEqNV1K6cveWi5oOkL/vGmMYDB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154a:b0:3a6:da79:12bc with SMTP id
 e9e14a558f8ab-3a74800f4f7mr43240145ab.7.1731720181974; Fri, 15 Nov 2024
 17:23:01 -0800 (PST)
Date: Fri, 15 Nov 2024 17:23:01 -0800
In-Reply-To: <20241116005604.3932-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6737f3f5.050a0220.85a0.000a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in set_powered_sync

==================================================================
BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
Read of size 8 at addr ffff888031242b98 by task kworker/u9:1/4627

CPU: 1 UID: 0 PID: 4627 Comm: kworker/u9:1 Not tainted 6.12.0-rc7-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
 hci_cmd_sync_work+0x1e3/0x380 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6066:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1165
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6061:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x106/0x430 net/bluetooth/mgmt.c:9460
 hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5201
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1227
 sock_ioctl+0x626/0x8e0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888031242b80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888031242b80, ffff888031242be0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x31242
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0000a16dc0 dead000000000004
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 4690, tgid 4690 (udevd), ts 66568318764, free_ts 63546710221
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1541
 prep_new_page mm/page_alloc.c:1549 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3459
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4735
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_slab_page+0x59/0x140 mm/slub.c:2414
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4270
 kmalloc_array_node_noprof include/linux/slab.h:995 [inline]
 alloc_slab_obj_exts mm/slub.c:1968 [inline]
 account_slab mm/slub.c:2541 [inline]
 allocate_slab+0xb6/0x2f0 mm/slub.c:2596
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4153
 alloc_inode+0x87/0x1a0 fs/inode.c:267
 iget_locked+0xf1/0x5a0 fs/inode.c:1418
 kernfs_get_inode+0x51/0x7b0 fs/kernfs/inode.c:251
 kernfs_iop_lookup+0x266/0x390 fs/kernfs/dir.c:1214
page last free pid 5303 tgid 5303 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1112 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2642
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2918
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888031242a80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888031242b00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff888031242b80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888031242c00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff888031242c80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git v6.12-rc7
console output: https://syzkaller.appspot.com/x/log.txt?x=1629eb5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db2ecab25173dcef
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ea71a7980000



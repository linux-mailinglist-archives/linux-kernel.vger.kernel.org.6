Return-Path: <linux-kernel+bounces-435815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5389E7D8C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA837188689E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D1323D;
	Sat,  7 Dec 2024 00:34:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2ED38B
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733531646; cv=none; b=Wzjyhev2F08jffz/+JC6dLha1V5AntDEtlar66eBOvjHcWLd3QN5K/7sRnLIxZIDjZD+dTbEpsvyhJnYLlnVdFV2iRQwCis3x2J6lqx/Rw5QV7vBWoAaVRwccu8CEzcm+knaGAf3os4tuYjVlGIy47ihEpvHBnYmFQc3tsnSB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733531646; c=relaxed/simple;
	bh=rPtPp0Fe7lh/8pSx6dRWRLp67T6IZWkNktsDIS3qUO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cLqdLxdCmwGld4vAK/EDkaB5ujA8ZRfkHn0a8/zkjlBLL7JZLmQh8QRrxPwSsGwqpUwNRApI2BHj2Orljj/Klak3pWAHIbzt4+e6JQVxNci7Rp94oZhSdRCCcLqhJjf2Qkoq0ZAMKb5sDSPjgEBAp3WmNbFcY/rVj3XaXSzfWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so11905775ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 16:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733531644; x=1734136444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41/CSxhNSB3sJSnXC2f01tY9/b8I7ZVmFs2laz/Pdmc=;
        b=D4PKPlu3E3clTmEQgBF8GRI5yzQO1r+xMJ3DB84jvdX+45pDMW3RXP7MTADly9Ntid
         R9F+Qwz5pn+Fm6g3pjEmgiDZUJhO42dUDqghf1hMWYbfdAWQV4naPYvgQBO01ITz/M9i
         VoLhFZzHrhQdoFizvjByxe/2NRtUeE6Yw+k/lTJVuUZUSd1bRRyC4uel7WCHVSz27Zz6
         RUk1eQdAZ0DbLHI/AGVIFoYu83Pj/5SG+///YoE1dayhK7s/jX8OnJmwtj/7RUDAOodf
         PMM0abEgOKR1gIacNtGnX2L2R289BOqtXe1Z1mvhW8ev6TZLMM9XQZnSL6JNLwykALcF
         JyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQA9BGG74Qs3dJDWPQCvNIPMBjSFYRV58SrpdS8o8dAiI1MT6zwLE0yq8j0MITdHRsquEAnO8GU4GFGMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGH8q6/p7rSzbPpKNJBNa/bYQR0lgrjVN2nYPNe2DuNBdf5TI
	cV9auQ30H3VZIu0GtB5Vl9h3Gl2szyxaUjJB6wUK3+nh94uAUzD3CVF0TqJ+c/qf0Xv7pMTZUkV
	rzecvoRme0BYkg4kBNp2+fiqjlAhUy5hdeqIk3kMZYgbJN7a7ZDVhvIA=
X-Google-Smtp-Source: AGHT+IG04VCi9La+hVsvN7F9g7HZAaAU+ELxxqXeMmWYWk5ycUEJ2ALFrO9HMBsdrKQwlA9Gbjba4r6Kpezg8BOTV5THyvEqrZFC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10ce:b0:3a8:13d5:bd2c with SMTP id
 e9e14a558f8ab-3a813d5bd8emr40234825ab.2.1733531644001; Fri, 06 Dec 2024
 16:34:04 -0800 (PST)
Date: Fri, 06 Dec 2024 16:34:03 -0800
In-Reply-To: <20241207000507.724-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675397fb.050a0220.a30f1.014c.GAE@google.com>
Subject: Re: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev
From: syzbot <syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev_rcu

==================================================================
BUG: KASAN: slab-use-after-free in netdev_next_lower_dev_rcu net/core/dev.c:7650 [inline]
BUG: KASAN: slab-use-after-free in netdev_walk_all_lower_dev_rcu+0x131/0x390 net/core/dev.c:7755
Read of size 8 at addr ffff8880281a41b8 by task syz.0.15/6768

CPU: 0 UID: 0 PID: 6768 Comm: syz.0.15 Not tainted 6.13.0-rc1-syzkaller-00172-g11776cff0b56-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 netdev_next_lower_dev_rcu net/core/dev.c:7650 [inline]
 netdev_walk_all_lower_dev_rcu+0x131/0x390 net/core/dev.c:7755
 smc_vlan_by_tcpsk+0x3ab/0x4e0 net/smc/smc_core.c:1899
 __smc_connect+0x292/0x1850 net/smc/af_smc.c:1517
 smc_connect+0x868/0xde0 net/smc/af_smc.c:1693
 __sys_connect_file net/socket.c:2055 [inline]
 __sys_connect+0x288/0x2d0 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce44d7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fce45b0d058 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fce44f46080 RCX: 00007fce44d7ff19
RDX: 000000000000001c RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007fce44df3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fce44f46080 R15: 00007ffee596f8c8
 </TASK>

Allocated by task 6551:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_node_noprof+0x290/0x4d0 mm/slub.c:4289
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
 alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11209
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x210/0xa40 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3896 [inline]
 rtnl_newlink+0x1b40/0x20e0 net/core/rtnetlink.c:4009
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6759:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x430 mm/slub.c:4746
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10924
 rtnl_unlock net/core/rtnetlink.c:152 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
 rtnl_dellink+0x760/0x8d0 net/core/rtnetlink.c:3526
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 br_multicast_del_mdb_entry net/bridge/br_multicast.c:646 [inline]
 br_multicast_dev_del+0x342/0x5e0 net/bridge/br_multicast.c:4366
 br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:155
 unregister_netdevice_many_notify+0x1735/0x1da0 net/core/dev.c:11548
 rtnl_delete_link net/core/rtnetlink.c:3476 [inline]
 rtnl_dellink+0x52b/0x8d0 net/core/rtnetlink.c:3518
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 schedule_work include/linux/workqueue.h:723 [inline]
 __rhashtable_remove_fast_one include/linux/rhashtable.h:1069 [inline]
 __rhashtable_remove_fast include/linux/rhashtable.h:1093 [inline]
 rhashtable_remove_fast include/linux/rhashtable.h:1122 [inline]
 fdb_delete+0x100c/0x1210 net/bridge/br_fdb.c:320
 br_fdb_delete_by_port+0x1ec/0x310 net/bridge/br_fdb.c:780
 del_nbp+0x665/0xb40 net/bridge/br_if.c:357
 br_dev_delete+0x6e/0x100 net/bridge/br_if.c:386
 rtnl_delete_link net/core/rtnetlink.c:3475 [inline]
 rtnl_dellink+0x518/0x8d0 net/core/rtnetlink.c:3518
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880281a4000
 which belongs to the cache kmalloc-cg-8k of size 8192
The buggy address is located 440 bytes inside of
 freed 8192-byte region [ffff8880281a4000, ffff8880281a6000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x281a0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888061d19001
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac4f640 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000020002 00000001f5000000 ffff888061d19001
head: 00fff00000000040 ffff88801ac4f640 dead000000000100 dead000000000122
head: 0000000000000000 0000000000020002 00000001f5000000 ffff888061d19001
head: 00fff00000000003 ffffea0000a06801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5920, tgid 5920 (syz-executor), ts 70312920153, free_ts 70066156251
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
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_noprof+0x2ee/0x4d0 mm/slub.c:4289
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
 alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11209
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x210/0xa40 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3896 [inline]
 rtnl_newlink+0x1b40/0x20e0 net/core/rtnetlink.c:4009
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
page last free pid 5840 tgid 5840 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x2ea/0x3d0 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 __kmalloc_cache_noprof+0x1d9/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 kernfs_fop_open+0x3e0/0xd10 fs/kernfs/file.c:623
 do_dentry_open+0xbe1/0x1b70 fs/open.c:945
 vfs_open+0x3e/0x330 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff8880281a4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880281a4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880281a4180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff8880281a4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880281a4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         11776cff net/mlx5: DR, prevent potential error pointer..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17383330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=2eab87cf3100f45423ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f6a020580000



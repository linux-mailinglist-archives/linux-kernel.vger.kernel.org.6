Return-Path: <linux-kernel+bounces-321282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77349716E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0209BB231F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B631B1D7A;
	Mon,  9 Sep 2024 11:31:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910942A81
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881464; cv=none; b=kJxo2HiqCMl12B6wT4Ur7RMPZ7lCute6/P6cRlsNk5rfVxVtcPrU8nFkwjvIZvQJMsOHfdkmJARqNuWibVrxUiqZ8TgV/ZOsL/HnUIVfxoeCBts+2hXjnAqpkk1/N/UacQoy6pXiCS7SSPAlvVHSbI+PM+kkhWpdI79cOsbx+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881464; c=relaxed/simple;
	bh=wen+YtnT5YphvwsI3oID3SdrJRqcFn0raA/XLLg9Row=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mBXCQCCDGZJqo2AAQLjDTZfzSAgFNQNwnrLdaKz821iLzSKbneu6L9PkX6OlP6DdJZ17owhMhsEVY4j61LrjcZAk2O+FkgqZ3s3OAqEa8fxCdeXhCTtixIZeJFzgvD7MAO3nR6cr74O4YKSPmkFsML3z69qxicfRwL8o/nRy97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f5605c674so84290875ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725881462; x=1726486262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W10qHicbh1lTcaTClxhuDrnfWEbmvhNz/WbRADIf5fQ=;
        b=cpGv2qFj4goPxa93S5AJric6QPZXjFzp88cNAsNlHPhkdhO396OEo43StrP77fkCVT
         w2ikY7eZUyXcBJEgtnVhA/q0fRY7APZNA5HOtYZ/Q+45NKbcR8oQjWQSOQk2tlhTKQKF
         WHaz+6w2kjSG+5d3sQaU+/3vaWXmEOe2UP4L7g/82NML/ekBKMibNW+ZJy0x3zyuwDyi
         dTIr7B0Fi4hQDbJylIwLeHCqaHlVuGImp8Gdpo8qEqu60NQgzSLo///I2KT6KQeKwxFS
         gX7+6uzMKMPDY6B58IqWrIMFrY8vf/9roJnKcMXS3gydG0lSEqBnqShja3940ohu6iBG
         T9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoEMXfAfU4+2W0u/1gC3+SRZNI7ZVjZEk9yaVwnNmTO07PNcCa3/NnsueN0DQDi9hnfFdzuc/qBpl+EcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrZIL6uI4i2isNUSfIwrCNjzIBzkt1mNcvUTD0JtoPyl9Py0s
	PEHOC/QCvSlcXbA8KLJpdlUGwBy+Sds9Jbf337iYUCPvI+fa+xRvJLQnbPpPLKNH0cXzwsIsWJe
	3s6RR6Q9ep6P77ApBG+Ca7vZhXPA/E5+C1zPeqP7hsdINW2trHayaUgo=
X-Google-Smtp-Source: AGHT+IHX8R+FJ3T76N+sMtmHOyCEjBrDRLPwYXiON5duDlEUrSMRzGhbqoKwsKZKtknAVFu3XBBaVqU5dF5VUVuEPePP2ppKE+b/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:376:40b7:b6f3 with SMTP id
 e9e14a558f8ab-3a04f069b27mr138572885ab.2.1725881462358; Mon, 09 Sep 2024
 04:31:02 -0700 (PDT)
Date: Mon, 09 Sep 2024 04:31:02 -0700
In-Reply-To: <20240909110641.2729-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d155e0621ae17cc@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_send_acl

==================================================================
BUG: KASAN: slab-use-after-free in hci_send_acl+0xc03/0xd30 net/bluetooth/hci_core.c:3230
Read of size 8 at addr ffff8880291d1618 by task kworker/u9:8/7107

CPU: 1 UID: 0 PID: 7107 Comm: kworker/u9:8 Not tainted 6.11.0-rc7-syzkaller-gda3ea35007d0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hci_send_acl+0xc03/0xd30 net/bluetooth/hci_core.c:3230
 l2cap_send_cmd+0x6e5/0x920 net/bluetooth/l2cap_core.c:973
 l2cap_connect.constprop.0+0x6f7/0x1270 net/bluetooth/l2cap_core.c:4032
 l2cap_connect_req net/bluetooth/l2cap_core.c:4078 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4770 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5541 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6823
 l2cap_recv_acldata+0xc03/0xf00 net/bluetooth/l2cap_core.c:7520
 hci_acldata_packet net/bluetooth/hci_core.c:3793 [inline]
 hci_rx_work+0xabe/0x1630 net/bluetooth/hci_core.c:4031
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 54:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 hci_chan_create+0xa6/0x3d0 net/bluetooth/hci_conn.c:2732
 l2cap_conn_add.part.0+0x1a/0xa60 net/bluetooth/l2cap_core.c:6862
 l2cap_conn_add net/bluetooth/l2cap_core.c:69 [inline]
 l2cap_connect_cfm+0x428/0xf80 net/bluetooth/l2cap_core.c:7243
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_remote_features_evt+0x548/0x9e0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
 hci_rx_work+0x2c6/0x1630 net/bluetooth/hci_core.c:4026
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5973:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 hci_chan_list_flush+0x81/0xf0 net/bluetooth/hci_conn.c:2772
 hci_conn_cleanup net/bluetooth/hci_conn.c:150 [inline]
 hci_conn_del+0x1cc/0xdb0 net/bluetooth/hci_conn.c:1162
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880291d1600
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff8880291d1600, ffff8880291d1680)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880291d1900 pfn:0x291d1
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000200 ffff88801ac41a00 ffffea0001fd5a90 ffffea00009ed310
raw: ffff8880291d1900 000000000010000d 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x352800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 5909, tgid 5909 (syz-executor), ts 135353944743, free_ts 135353325117
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
 allocate_slab mm/slub.c:2488 [inline]
 new_slab+0x84/0x260 mm/slub.c:2541
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_node_noprof+0x357/0x430 mm/slub.c:4168
 kmalloc_array_node_noprof include/linux/slab.h:788 [inline]
 alloc_slab_obj_exts+0x41/0xa0 mm/slub.c:1976
 __memcg_slab_post_alloc_hook+0x2bc/0x9c0 mm/memcontrol.c:3019
 memcg_slab_post_alloc_hook mm/slub.c:2164 [inline]
 slab_post_alloc_hook mm/slub.c:4002 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 kmem_cache_alloc_noprof+0x2c6/0x2f0 mm/slub.c:4048
 copy_sighand+0x43/0x2c0 kernel/fork.c:1794
 copy_process+0x2771/0x8de0 kernel/fork.c:2368
 kernel_clone+0xfd/0x960 kernel/fork.c:2781
 __do_sys_clone+0xba/0x100 kernel/fork.c:2924
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
page last free pid 5909 tgid 5909 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 vfree+0x181/0x7a0 mm/vmalloc.c:3367
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:882 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
 do_ip6t_get_ctl+0x8ec/0xaf0 net/ipv6/netfilter/ip6_tables.c:1677
 nf_getsockopt+0x79/0xe0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x1fd/0x2c0 net/ipv6/ipv6_sockglue.c:1493
 tcp_getsockopt+0x9e/0x100 net/ipv4/tcp.c:4409
 do_sock_getsockopt+0x3fe/0x800 net/socket.c:2386
 __sys_getsockopt+0x1a1/0x270 net/socket.c:2415
 __do_sys_getsockopt net/socket.c:2425 [inline]
 __se_sys_getsockopt net/socket.c:2422 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2422
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880291d1500: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff8880291d1580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880291d1600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880291d1680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880291d1700: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
==================================================================


Tested on:

commit:         da3ea350 Linux 6.11-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a3389f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131ace00580000



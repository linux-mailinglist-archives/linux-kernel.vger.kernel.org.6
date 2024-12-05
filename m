Return-Path: <linux-kernel+bounces-433255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200D9E55A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C27F283789
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404A217F3A;
	Thu,  5 Dec 2024 12:39:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795725765
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402345; cv=none; b=qJNkux4815BSdIHwDgDEExvAZ7iXG+n9IxLMx24cs1DLI9Gh73EqB7e2VDcHDF0nm0iBsvdNjWtFaVaW+FGIgAIda5YimlI30KTv625RabCOtFpGOnXR0RvskwTJgbNSV2snAvlYLGx7HIPl/Fw77H6+JeDKOJXVauukcCM945g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402345; c=relaxed/simple;
	bh=9dYEIbUUAabCu2HvaTr5nEv52TC4Vy3wRZoYfPAYWxc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q//6qCOaUhYvmOvNzl6E8CYRoF4X4TMIKR21n5ISKQUgFZyCuyR3x3G65TPEuE2eo6MctNI8KIJkW1OOOekXPxdXK9LHKY96YDYxPO4Di6LpxERPLnuly1bDtCyE2S9xK5eCmGqXviB9akodwrge2OCGFKtEzFw0Ioy8SXr9k90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so8074865ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733402343; x=1734007143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVIRsbDGbGwDoTswaOBlJD19Jjlk1z393x9mnf/0RaU=;
        b=MBEeFIC18+96FuKGN4XmMxdZ0o64TL9Uqq0bso1J8rpeXqj/4GladR7p11i84asA1w
         WvFBPHjbBRWlYTbtho0DUIfFvjVYeVNBvXKPG8AHQ5b1I2//VUxzqPuud21X+OQKciQS
         owpUjNN0YEqNH/YB2kvQqjOR7YEebAg88tjjX+jHHqZxaKZqRg7ArixXOaWQ3lStWqgF
         XFn/2/f7bJidHUUqhX7lOB9t54pYW1wO0iCr/cMqABPVb4Fo0SXDJxKHjt57cxySFQXK
         aG9G/qq7v7DIsJHEvvXe710aIQMJ1mPlbatyqOpxJKjr5jFBewyxWxlyVS6iaVJfxOTw
         pTHw==
X-Gm-Message-State: AOJu0YzNYL3k04FCkD5peVnDvr0kJetzTgGYV3hCbsVdihM2kPmg7qEB
	D3oIszRJVxBOCJkCFev9XQT4tj4tqRpHzCjYBhqPzszllNAdZaZAS0uaxD8jXRZAlcVsDahAaAi
	FbVrgr9NtycUrLSdQwZmaSlb+cFP6NdkdhierBaY11NYt/JSSeDlaAt4=
X-Google-Smtp-Source: AGHT+IF5YJ3gi0KYCTj0MHNRkQmDVaMZ1flzcYOjKEfO3MG/5BDQNKUdFtomT2xFkLBikSsAF1IXp04aZo7VajmjxLpUQrnMXByB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e6:b0:3a7:8d8e:e760 with SMTP id
 e9e14a558f8ab-3a7f9a314a1mr112093095ab.4.1733402342962; Thu, 05 Dec 2024
 04:39:02 -0800 (PST)
Date: Thu, 05 Dec 2024 04:39:02 -0800
In-Reply-To: <D63RERM1B1U9.YBW3S55TUSN7@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67519ee6.050a0220.17bd51.00a0.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync

Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
Read of size 8 at addr ffff8880325c2498 by task kworker/u9:4/6622

CPU: 1 UID: 0 PID: 6622 Comm: kworker/u9:4 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2-dirty #0
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

Allocated by task 13056:
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

Freed by task 13052:
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

The buggy address belongs to the object at ffff8880325c2480
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff8880325c2480, ffff8880325c24e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x325c2
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0000c8a240 dead000000000003
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1145, tgid 1145 (kworker/u8:8), ts 120767808239, free_ts 120761385838
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
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:990 [inline]
 nsim_fib_event_nb+0x17c/0x10b0 drivers/net/netdevsim/fib.c:1043
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xdb/0x180 kernel/notifier.c:223
 call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:35
 call_fib6_entry_notifiers net/ipv6/ip6_fib.c:397 [inline]
 fib6_add_rt2node net/ipv6/ip6_fib.c:1231 [inline]
 fib6_add+0x1bd5/0x4420 net/ipv6/ip6_fib.c:1488
 __ip6_ins_rt net/ipv6/route.c:1317 [inline]
 ip6_ins_rt+0x106/0x170 net/ipv6/route.c:1327
 __ipv6_ifa_notify+0x5d2/0x1230 net/ipv6/addrconf.c:6281
page last free pid 5209 tgid 5209 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 __slab_free+0x31b/0x3d0 mm/slub.c:4509
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_noprof+0x23c/0x4d0 mm/slub.c:4289
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x20c/0xd70 fs/seq_file.c:210
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880325c2380: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880325c2400: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff8880325c2480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff8880325c2500: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880325c2580: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156e640f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a81330580000



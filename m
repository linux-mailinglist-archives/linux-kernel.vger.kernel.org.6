Return-Path: <linux-kernel+bounces-348163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8E98E38A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F743285C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3613CFA6;
	Wed,  2 Oct 2024 19:37:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9F157A6C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897825; cv=none; b=Nk9mMZm/S4jWb+7l07TG3sq4ZDBpx2mBazSyeUlJi4DTfLbbsfpuyorO49y5eXsnBB3Q2ZRDxurDjGbKKNTI/yOl4N3z3atWBk8jaCl57NFOpj1RrVZG/39lkK7lHbfmAM5ddDGttV4OhSfvhPV39lJRzU8lQOSZvUtbVZixP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897825; c=relaxed/simple;
	bh=3wV+nmGIZ6WHi69/hf2Xvii1eufGqUm4n/5+9jfxXBE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jpas5rUbaurshcp4WVPfXJiWWtfe7Q5twzgXqyjZ1J7atC55W8XiPUyZVsbxoXmKJKcWU22pEz2tISgsQm45ha8y11Nt5ysDvZdJM3jWBt7+Q7ZeUKlYQwCoz+R2z7vY/63bZtCsbKk9rHqlTxuLavkHY1Wz3waNVjBaWR0kZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso1859715ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897823; x=1728502623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWBXZIO0Enm5/akeUd4R76hfv6g/lKMGHfoP9OEnhwg=;
        b=OOk3fdWZViXhyF1N7Ka56SBh7/fGV0xVoRXHpVbQj1P7yNfk9SfQd73RDqfpobeL7G
         /YqIHdAnaGjfHS2G5meRnMaGvKLIISJr/xoOTAOYkMN6ABPT6K8hqyF39JwAbBK1Gpkr
         khkTdjYS9sYA9pyaFdbPpmCJlxqT6ARTGBe6ifOdSl/p1yAUf4fXF21Hpj6P2rFdD08U
         K8kHwNKOyd4fXOlnij/HnlV6f2disLnXOGgLT+Gj+Fbl6sG68c80bpycyw9AZKAJNtTS
         dta2n/k2NJdKZ7ziEvlYomdufH/ht4N+8G+2z/ymsD7OHlvYyhFKjKp4HctiO13/TZyi
         lHLw==
X-Forwarded-Encrypted: i=1; AJvYcCUVbqLhPgj1t7/iwGuE/lCGsts+w7lxd6wCWqLO8qju5iDCAV+DcHQL1o5EV2qLph1xxd+ileX9nRnhJlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXwLnQtfiT1U4uzH8cJ3d52TIkA0RW8uHxau4OsJJzdPmYo88
	N4HWg9j0js9jqpxBibRLC/QoH2MjPzY+4km2rGpqAYqxBYvpQlwKvl7MuXUjLJBxCDfhBX60BIr
	5dZGpUZa8QpOnqvowsPuy/ZPq4hshKph2hDx2L14l4wpvvL95gGYLMuE=
X-Google-Smtp-Source: AGHT+IGpmul/DzKTBd+UNEuMeQ7WEYS5a+E4PlOHKEHRRE3t6u3UcxuT3+vjFzs8cuBc6DXIzm05TdNCF+OzXnzoi1Ngu7owKLRw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a36592ad9bmr37151015ab.13.1727897822984; Wed, 02 Oct 2024
 12:37:02 -0700 (PDT)
Date: Wed, 02 Oct 2024 12:37:02 -0700
In-Reply-To: <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fda0de.050a0220.9ec68.002b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_sock_timeout

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:781 [inline]
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x8b/0x270 net/bluetooth/sco.c:92
Write of size 4 at addr ffff88807e2d5080 by task kworker/1:1/47

CPU: 1 UID: 0 PID: 47 Comm: kworker/1:1 Not tainted 6.12.0-rc1-syzkaller-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events sco_sock_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 sock_hold include/net/sock.h:781 [inline]
 sco_sock_timeout+0x8b/0x270 net/bluetooth/sco.c:92
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5759:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2164
 sk_alloc+0x38/0x370 net/core/sock.c:2217
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:500 [inline]
 sco_sock_create+0xbb/0x390 net/bluetooth/sco.c:531
 bt_sock_create+0x163/0x230 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x492/0x920 net/socket.c:1576
 sock_create net/socket.c:1627 [inline]
 __sys_socket_create net/socket.c:1664 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1711
 __do_sys_socket net/socket.c:1725 [inline]
 __se_sys_socket net/socket.c:1723 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5760:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 sk_prot_free net/core/sock.c:2200 [inline]
 __sk_destruct+0x479/0x5f0 net/core/sock.c:2292
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1259
 __sock_release net/socket.c:658 [inline]
 sock_close+0xbe/0x240 net/socket.c:1426
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 get_signal+0x15e8/0x1740 kernel/signal.c:2690
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807e2d5000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff88807e2d5000, ffff88807e2d5800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e2d0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442000 ffffea0000a07800 dead000000000002
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442000 ffffea0000a07800 dead000000000002
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001f8b401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4533, tgid 4533 (acpid), ts 19751533769, free_ts 17515017965
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2164
 sk_alloc+0x38/0x370 net/core/sock.c:2217
 __netlink_create+0x65/0x260 net/netlink/af_netlink.c:646
 netlink_create+0x3ab/0x560 net/netlink/af_netlink.c:704
 __sock_create+0x492/0x920 net/socket.c:1576
 sock_create net/socket.c:1627 [inline]
 __sys_socket_create net/socket.c:1664 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1711
 __do_sys_socket net/socket.c:1725 [inline]
 __se_sys_socket net/socket.c:1723 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1723
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 free_contig_range+0x152/0x550 mm/page_alloc.c:6748
 destroy_args+0x8a/0x840 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x24a/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88807e2d4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e2d5000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807e2d5080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807e2d5100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e2d5180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174f23d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5997f8b13c390e73
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


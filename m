Return-Path: <linux-kernel+bounces-353952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3A993515
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D7C2820B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2D1DD527;
	Mon,  7 Oct 2024 17:33:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B66139587
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322385; cv=none; b=XaShL3PxW13ZqudHIUN4s5Ipac9gPLxfLtZFKt5SuwrvKbQ+tWY3Z5HPqTc+AR8qhtATer12DlC8PTpDqPkhogN6mEyzMJB7V4YEhkS71ysobpBCIyyniCba9ulqLsd9kXA5d94xH2Xtoyxzp2ra1KrNblqEDTWgGG/Q/5tAnk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322385; c=relaxed/simple;
	bh=LrLI4DG5ecUdK/ZW9VouXdNfUldCPnEqnCblguLvYj8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H+AwWCq1VGcewfFSX9cW3K0NV58Gz5/QCzfzioD0SdPbPFwaNWtRgl+cfzWmrqfmBAok4wDpbu9aBb+qVBd5kwYjcugYJgK9LTg/j/1akeLDrrofSvmS9xmsXLXU2YIGKLYfh9bwDqldb9I7swIeLlsF4HWsQpCEAtp/kNpVQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19665ed40so35033585ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728322383; x=1728927183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je8G6nmMXzSmkUM8wQx+ZqnZ8NRybpJUzghcC6pOUCo=;
        b=fMAb5ouIel2g39LKcSZbkFX2+WWTxDibJFHaVZYzWZeYcrSEKlrugUkQAAqPuOxZ9l
         h4HLkQfAItFPQ/pBrANhhmE9njTrYAv/uk0eNtkbZRLovHiDkXppElHq+2Z1N0RK7evz
         ajGJUcwgbGDsYMnDWG3EYp3GgzHD/bBC4Qu/lElGJ46AzaVa9guez5AUw1IKq8ec2lGR
         0V/Rx9xbX17yPMuFpChvsfnZxnCi1B3W4hRY4uwymmUowDR6Tev50ZNpkssgRP6Z9Q8m
         YhD5trTuQtDpULgymcgk38lqiVPBVQDtUtAPVz/0xCeEtUENK/tsWaM1+fFHNv9R6XQB
         hLsw==
X-Forwarded-Encrypted: i=1; AJvYcCW0CaIOfwTV5JLgpPImYQ1UTR1z+Ex9diyUD+g7P+NAxvRwq9UIxyyYnzV/bP2YrkrBrn6VpOllk6SOC1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaDRedrScyoXLneZCYkSF67sxgMfsrCXo0dm4mjbrURoOJFVC
	yoOjAKSojtCEsNAAKLy1j4SUbsQbZzhZZ5lTKLAwCNHWzql+9bR9h9BwHt7zwikRJOeQ9S3Yw0B
	WWGolbeteCftaOTIlMxfPDafJcTB4et4+K8DXgDB4v4HsZbZvVw/VVo0=
X-Google-Smtp-Source: AGHT+IGeHfV4nXrsBm7UxE9v0zqClI4XnMxG79/amJQLxhKbb7yGbl6fjEOrKAO6ovkEkPPb6IkKdJxSB5Gs/mEcGO3JmFXMwXeJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a21:b0:3a2:763b:c83e with SMTP id
 e9e14a558f8ab-3a38af225a2mr3361275ab.5.1728322382682; Mon, 07 Oct 2024
 10:33:02 -0700 (PDT)
Date: Mon, 07 Oct 2024 10:33:02 -0700
In-Reply-To: <CABBYNZ+XB+hAN7BmOQiKpdBBHXX_8JrDm3HpXJ=JKVBg8R1CGA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67041b4e.050a0220.49194.0512.GAE@google.com>
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
Write of size 4 at addr ffff8880237b3080 by task kworker/0:1/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc2-syzkaller-g8cf0b93919e1-dirty #0
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

Allocated by task 5742:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2164
 sk_alloc+0x38/0x370 net/core/sock.c:2217
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:521 [inline]
 sco_sock_create+0xbb/0x390 net/bluetooth/sco.c:552
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

Freed by task 5743:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 sk_prot_free net/core/sock.c:2200 [inline]
 __sk_destruct+0x479/0x5f0 net/core/sock.c:2292
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1280
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

The buggy address belongs to the object at ffff8880237b3000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff8880237b3000, ffff8880237b3800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880237b5000 pfn:0x237b0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff888015442000 ffffea00008c6a10 ffffea0001f13610
raw: ffff8880237b5000 0000000000080005 00000001f5000000 0000000000000000
head: 00fff00000000240 ffff888015442000 ffffea00008c6a10 ffffea0001f13610
head: ffff8880237b5000 0000000000080005 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00008dec01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4550, tgid 4550 (udevd), ts 62011136939, free_ts 61932137647
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4276
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
page last free pid 4539 tgid 4539 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4186
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1322 [inline]
 alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2883
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:2027
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff8880237b2f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880237b3000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880237b3080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880237b3100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880237b3180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         8cf0b939 Linux 6.12-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e7db80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5119ec8290b5433
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150b2707980000



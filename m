Return-Path: <linux-kernel+bounces-348364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F020B98E6A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A231F236F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A0D19C56B;
	Wed,  2 Oct 2024 23:16:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8E197A99
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910964; cv=none; b=RP3UiX7vMSA+JLl3lqsFbVl7tuRXraLQQOylm7ZcYdzO2qUKmELZDBZE4ddY787WHT/jswxYQ3veM1DC7chFdXuoZult1Iqy+Y95QAkIQqT50HviJR421Twqn9wOJ0p57g1HeA948Px2pvBz7wOOFQ3KZ2bYaOsAiRUnHIx9WHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910964; c=relaxed/simple;
	bh=JL+Nny7jqlEhuD/TM5/1uzKiv6YwShmschririXhttg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XYN9FCFSpDmLPFeSHDtn7B3Q1OLqSr9MT3TWIxx56zAcdCT860thLnwGVIBRAdNNRewncms00S0JrAtdDd3CosxXcSdJwZ/M6P6r5zh9xbj8jzPxPBIoeMeFSxXcKyWjqxX6mM/jrEN1FD9IYVd2bUjRpMEh69G6Iut3NX3MNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cf261659bso47943239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 16:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727910962; x=1728515762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MAT+MQh7KAWIz55WEh7FOszcLzUcpMBV7pkibF5Klg=;
        b=dDO0+RdUz0JOymCLaVmI4fo+VeMXb18M27EGXfOnmVgoI3WtrFaJUP71iYW+wGgtrl
         DG6VY9tR4WpcAy3goOSZZYgDDF1nJ8FIB0vf3mShM8n+K3U5ImyXNDC5nawIMhsyfUDD
         wp+RhmRUzdO/+xzRdv2JbrP1Oy71IVWGFwVGddA41L1xsoTm5vXPa3buozNKhF+mm+pk
         L1NIGTwBUVO80g5DD0ECHdHSjz6VW6O6SKjqWWE6wEZ6b+mVHS8r3xZ0FiuDDwbMZFmZ
         CYPIn1rC3L4XkcXoEmJRFg97vmFRq4s+SU2dvZQGc0dZsTqIQdQTLjUs22pOD58Ecb16
         /pog==
X-Forwarded-Encrypted: i=1; AJvYcCWEuDP8v2OvptEnyGKLB+0aXqdW9KaVehWKuHfoVP+9HVsMwNj6fEqduj5e79FuM7GdukpxML3EO7pP3kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iDSCfYbiMdcjFxV/y3B0TzsYoy1vtLAMuRjNBR+AC0Mn0G+x
	mOwD9OBKeV7dmaOrv/f+GCZImGr4H80oYZsK/W5xa7DZVVOGT7IZ4ZIMYoK4bEK4HuskY8WY3Yw
	U/TlLHrz1CHBn6dEP3YKjrK768X/8v0z7Ida9tK7p2GncS73yKeVxV6U=
X-Google-Smtp-Source: AGHT+IEiCAWc9+Ij5KsctWfjKIU2c6ODvSzsnZDXidLWrhWoxNmveRQeYAurR4IPfiB3i0vVt7ZLTZqnPQiuQSFhXntcgLJgdtas
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a06:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a3658bae68mr49900555ab.0.1727910962194; Wed, 02 Oct 2024
 16:16:02 -0700 (PDT)
Date: Wed, 02 Oct 2024 16:16:02 -0700
In-Reply-To: <CABBYNZLeWWtX9PdNarFajZynUSsyrd4mavExPXzY2GUf_ZzECw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdd432.050a0220.28a3b.01eb.GAE@google.com>
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
Write of size 4 at addr ffff8881442d6080 by task kworker/1:3/5112

CPU: 1 UID: 0 PID: 5112 Comm: kworker/1:3 Not tainted 6.12.0-rc1-syzkaller-gf23aa4c0761a-dirty #0
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

Allocated by task 5785:
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
 sco_sock_alloc net/bluetooth/sco.c:490 [inline]
 sco_sock_create+0xbb/0x390 net/bluetooth/sco.c:521
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

Freed by task 5786:
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
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1249
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

The buggy address belongs to the object at ffff8881442d6000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff8881442d6000, ffff8881442d6800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1442d0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff888015442000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 057ff00000000040 ffff888015442000 0000000000000000 dead000000000001
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 057ff00000000003 ffffea000510b401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2464151042, free_ts 0
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
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 acpi_ds_create_walk_state+0x103/0x2a0 drivers/acpi/acpica/dswstate.c:518
 acpi_ps_execute_method+0x245/0x880 drivers/acpi/acpica/psxface.c:134
 acpi_ns_evaluate+0x5df/0xa40 drivers/acpi/acpica/nseval.c:205
 acpi_evaluate_object+0x59b/0xaf0 drivers/acpi/acpica/nsxfeval.c:354
 map_mat_entry drivers/acpi/processor_core.c:241 [inline]
 acpi_get_phys_id+0xa5/0xd00 drivers/acpi/processor_core.c:274
 acpi_get_cpuid+0x28/0x1f0 drivers/acpi/processor_core.c:332
 processor_physically_present+0x29a/0x380 drivers/acpi/acpi_processor.c:565
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881442d5f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881442d6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881442d6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8881442d6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881442d6180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         f23aa4c0 Merge tag 'hid-for-linus-2024090201' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d02307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0ca089c3fc6b54e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14559927980000



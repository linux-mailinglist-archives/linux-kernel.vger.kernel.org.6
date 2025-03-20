Return-Path: <linux-kernel+bounces-570547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C6A6B1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D015E189782C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48A21C9E7;
	Thu, 20 Mar 2025 23:54:34 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0081EDA00
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514874; cv=none; b=gAWFNoGVYMt6ynmNyvUGT+HM4SL9NQAadLz3a2ThjVMPn99gepg3DZkQf5bkTFo1PnpdeFyb+djzxJmzfomMoG+qT/fpoiucPTdrpsauTgN0j++tOqqRXwE3rjLCTLZPm5nflIr80RwfxRkwVgIrMeNAztb+O7VtIcPSRnc+AcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514874; c=relaxed/simple;
	bh=/oW2+HVjW6sM8ZMXnGvnStYsV9xYOEnUS2hCyqbCDCE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QCCR4JUPbxM7p2QZ2p0HV9OJcgq4KO4wafqLt1l4+1O2x555H2KoBL5XuNHFu6thEWUWivQtLI7EG4UgnYT5gA1Qp0mTsCqxk2fMzGR8/U+D0Iam5iDUpCWNjB1pWZ3tlsqsmgG+6HAL8Uc8wbDRpT80A85hoLilIJdCND1kz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b418faf73so342953039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514870; x=1743119670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+KtPu1dYWBWxqYUdnOQjxio3Bz4Djstibgng8M+oQ8=;
        b=e4UqkY7LToEYw3jwxwk4he7scSycPpxSELrF0SD9R5niyYzu4xWyez38cctscVmUQx
         mnQcpfx7kr3u3V4jj3fTKjxO9kvhrw1QjwvauzEZVXc+7kwAQYHj7RJNwBHVTr70lRWe
         OTDTv69pqZJ6zEqDufFEb7gcmsabpIfDt5qPZfqMO8W1I7yrJ5J+bjyykhAu31oZB08D
         QrZ6FmYAmyytMo7OMy3t53Mkh6GpaS+d3yvNEbOlVNEdb3Ytm6eHZjbrTtbP0G0PITrn
         0hjBrttD7TcNbDtdlq9E6A8TURncQAnTCSnAnNwGeQr6/cLWlSKS8Cw/SCmFVL9+IFtE
         +7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFz/OkVjZilmhr747imGVbr7a4rdAx6n7PkojIihlUUsImTpH1y9XgOC6eAUFv/+YIzFt5xmue/uvqkD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyilp0l17kdii1S0mLeuwbwfsV3w7jUj0z/D2enuliMYzAfdJ8d
	CrY5q1vbZnCM50wApKQG5bGjEBthLfNWdLrOmsxxD0Pn1qtr2hh0mlSusO7SwEvJpjSZzhzisnk
	jtK14u5Mx+dh4qFgS+9RmYYPVDISIxE0IOjjrg2Fsz7Y1vq6hFpuvx9E=
X-Google-Smtp-Source: AGHT+IEBedI85UqfFvRmBj0NrqgA+1W1yKmG8nIuBPg1/0DDHvF8eAiQ0kGVw4a/HwRpWqQ8quQBwbfGaBHUBB6StXiK2ocphxbP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:3d3:dfc6:bc26 with SMTP id
 e9e14a558f8ab-3d596188bdfmr16770115ab.22.1742514870419; Thu, 20 Mar 2025
 16:54:30 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:54:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dcaab6.050a0220.31a16b.0014.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in __mm_populate
From: syzbot <syzbot+856397091bcfa77c8175@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5618886fdab Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15f8c474580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29061e148cfaa3d3
dashboard link: https://syzkaller.appspot.com/bug?extid=856397091bcfa77c8175
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b90307e7f61/disk-a5618886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b5ea0300ee3/vmlinux-a5618886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47f59a45fc8c/Image-a5618886.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+856397091bcfa77c8175@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mm_populate+0x14c/0x3d8 mm/gup.c:2013
Read of size 8 at addr ffff0000fa4da6d0 by task syz.7.313/8381

CPU: 0 UID: 0 PID: 8381 Comm: syz.7.313 Not tainted 6.14.0-rc6-syzkaller-ga5618886fdab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x198/0x550 mm/kasan/report.c:521
 kasan_report+0xd8/0x138 mm/kasan/report.c:634
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 __mm_populate+0x14c/0x3d8 mm/gup.c:2013
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x304/0x3c4 mm/util.c:580
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Allocated by task 8381:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:562
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x74/0x8c mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x254/0x410 mm/slub.c:4171
 vm_area_alloc+0x30/0x1bc kernel/fork.c:472
 __mmap_new_vma mm/vma.c:2345 [inline]
 __mmap_region mm/vma.c:2461 [inline]
 mmap_region+0x13ec/0x2518 mm/vma.c:2539
 do_mmap+0xbc8/0x1150 mm/mmap.c:561
 vm_mmap_pgoff+0x228/0x3c4 mm/util.c:575
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Freed by task 8500:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x64/0x8c mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x198/0x554 mm/slub.c:4711
 __vm_area_free+0xfc/0x148 kernel/fork.c:515
 vm_area_free_rcu_cb+0x80/0xa4 kernel/fork.c:526
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0x898/0x1b5c kernel/rcu/tree.c:2802
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2819
 handle_softirqs+0x320/0xd34 kernel/softirq.c:561
 __do_softirq+0x14/0x20 kernel/softirq.c:595

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 kasan_record_aux_stack+0xb4/0xcc mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3065 [inline]
 call_rcu+0x104/0xb9c kernel/rcu/tree.c:3172
 vm_area_free+0x28/0x38 kernel/fork.c:533
 remove_vma mm/vma.c:419 [inline]
 vms_complete_munmap_vmas+0x5ac/0x808 mm/vma.c:1202
 vms_abort_munmap_vmas mm/vma.c:2215 [inline]
 __mmap_region mm/vma.c:2486 [inline]
 mmap_region+0xba4/0x2518 mm/vma.c:2539
 do_mmap+0xbc8/0x1150 mm/mmap.c:561
 vm_mmap_pgoff+0x228/0x3c4 mm/util.c:575
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

The buggy address belongs to the object at ffff0000fa4da6c8
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 8 bytes inside of
 freed 184-byte region [ffff0000fa4da6c8, ffff0000fa4da780)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13a4da
memcg:ffff0000cee77f01
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000000 ffff0000c1877b40 fffffdffc3569380 dead000000000004
raw: 0000000000000000 0000000000100010 00000000f5000000 ffff0000cee77f01
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000fa4da580: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
 ffff0000fa4da600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000fa4da680: 00 fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb
                                                 ^
 ffff0000fa4da700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000fa4da780: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================
------------[ cut here ]------------
kernel BUG at mm/gup.c:1891!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 8381 Comm: syz.7.313 Tainted: G    B              6.14.0-rc6-syzkaller-ga5618886fdab #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : populate_vma_page_range+0x2c4/0x2f0 mm/gup.c:1891
lr : populate_vma_page_range+0x2c4/0x2f0 mm/gup.c:1891
sp : ffff80009d7e7a20
x29: ffff80009d7e7a80 x28: dfff800000000000 x27: ffff80009d7e7a20
x26: 1ffff00013afcf44 x25: dfff800000000000 x24: 0000000000000118
x23: 0000400000600000 x22: ffff0000fa4da6c8 x21: ffff0000d5372200
x20: ffff80009d7e7b20 x19: ffff0000f235f118 x18: 1fffe000366f1886
x17: ffff80008fbbd000 x16: ffff80008b7d1688 x15: 0000000000000001
x14: 1ffff0001262e8f8 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000080000 x10: 0000000000030d1d x9 : ffff8000a4ddd000
x8 : 0000000000030d1e x7 : 1fffe000366f1887 x6 : ffff8000803d5958
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080a62780
x2 : 0000000000000000 x1 : 0000000000000118 x0 : 0000000000000000
Call trace:
 populate_vma_page_range+0x2c4/0x2f0 mm/gup.c:1891 (P)
 __mm_populate+0x240/0x3d8 mm/gup.c:2032
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x304/0x3c4 mm/util.c:580
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 9406604b 17ffffa3 95d32b09 97f0fdc7 (d4210000) 
---[ end trace 0000000000000000 ]---


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


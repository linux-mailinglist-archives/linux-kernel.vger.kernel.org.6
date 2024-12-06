Return-Path: <linux-kernel+bounces-435650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9566D9E7A93
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7085616D334
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225811C5495;
	Fri,  6 Dec 2024 21:18:33 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97438213E98
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519912; cv=none; b=UcW/QC8yArnLwyXeIs0jQrY3+EQAZqTiZK6wB2b20U1MP51TAaQM1um8bk3w+pCO4UXwu4lPS5i7Kl03uBPLVqoeQp/yanFN7t6diQjl999SXeB5+juws+uaTL/A2Q+sWVlcMlYnlvp7cKGpFSN3jSJlHjR0ELnhfgXtRMGDezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519912; c=relaxed/simple;
	bh=mtOq41TrXo0ZNZtOkuJO891lOVQujSqBvbd4O8fDo1s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LugxvSRXL1L9uDlU9aIBQQzp3QJNgytmwACjKVn79B9VNvXiMJYY5Sl7zVGbUljr2zxOp0o1UcbyMBhDxZXTeO7KRFM3G5RYEpC43GMEIVJdhm/XtGCqTQYZAfcqJL7bqlChkgP9Zm65D5hqVHS9ykZXY728bL3n3F0+dgjVnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so51176985ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519909; x=1734124709;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/jTcw9U659NHfbVfvyGE0LV6xQht4eNjTO4MSHUBKQ=;
        b=Z9x+digOcuBh3Vfs86CM8spLT7mVB6yCB/CsSXLBqSKNaZbhJcR9HowpyKUtCelaX7
         2rvNI2OfUrUSxPI9vtrkL+1JhVqAAduOZpKENaBnfHI8VElhc4DgJq3CbQmMABZ/3vjL
         NHr2X+ihMJgos1BhAJDN3mMB6kR+sG1WQkvSCx/QzN2RGTUSVs91LGq+Jq+VrOqofVFM
         8nQknp5jsa+JDy59dFCYtObwDAt0InSa/Ym199xGkHkLV5slWOJ2cXfpeQHy6DSqBWkt
         r/04RAd46MZDvlEvx+7OlzUWqYH/LhehvdA3IMcc6m+A6Q5BoEQ9mQqu61EQtv5WJYqU
         dsVg==
X-Forwarded-Encrypted: i=1; AJvYcCXY2n5Ib0exoIhFg7h2/0hLltjRWygd8j3I92m5Jtr7GxybMDtdKulS9S2IIIR3xVki27TnHKiEx0Evd0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/lPtbOptURhRPUOJFqvgBnubo//5qCTsWoMrfsvLOJJzx0Ry
	jBLbcm26G8jknTvpfJPHZwU7xvnOkb/WCO98xyFF+6uz4OiqtAZH2iYNTb3I9w86Cwev/MulCnL
	PI2xQ4txBMgyn7VdapQRecPtbtiqm+Wj8PggX8uRexz+pq86tqQdaVGs=
X-Google-Smtp-Source: AGHT+IGRx17FYEQ2w8eg11cCqnscOvxvcb7OopEbd3IvadfHyFoDYjmAe7ikiLwJNSkWZSKBW4xkLuG6ZxmqYx9iO9nV8zfaAtOK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8c:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a811d87696mr53753785ab.10.1733519909710; Fri, 06 Dec 2024
 13:18:29 -0800 (PST)
Date: Fri, 06 Dec 2024 13:18:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67536a25.050a0220.a30f1.0149.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in __mmap_region
From: syzbot <syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e70140ba0d2b Get rid of 'remove_new' relic from platform d..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13300330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=91cf8da9401355f946c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124130df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a280f8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e70140ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91f313d8125b/vmlinux-e70140ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9bdf286943a/bzImage-e70140ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mmap_complete mm/vma.c:2408 [inline]
BUG: KASAN: slab-use-after-free in __mmap_region+0x1802/0x2cd0 mm/vma.c:2469
Read of size 8 at addr ffff8880403a6118 by task syz-executor239/5461

CPU: 0 UID: 0 PID: 5461 Comm: syz-executor239 Not tainted 6.13.0-rc1-syzkaller-00001-ge70140ba0d2b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 __mmap_complete mm/vma.c:2408 [inline]
 __mmap_region+0x1802/0x2cd0 mm/vma.c:2469
 mmap_region+0x226/0x2c0 mm/mmap.c:1347
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8522e6cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc930f7e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8522e6cb29
RDX: 0000000000000000 RSI: 0000000000001008 RDI: 0000000020ffc000
RBP: 00000000000f4240 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000013 R11: 0000000000000246 R12: 000000000001294d
R13: 00007ffc930f7e6c R14: 00007ffc930f7e80 R15: 00007ffc930f7e70
 </TASK>

Allocated by task 5461:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:472
 __mmap_new_vma mm/vma.c:2340 [inline]
 __mmap_region+0x196e/0x2cd0 mm/vma.c:2456
 mmap_region+0x226/0x2c0 mm/mmap.c:1347
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5295:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4700
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 lock_sock include/net/sock.h:1617 [inline]
 tcp_sendmsg+0x22/0x50 net/ipv4/tcp.c:1357
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:726
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
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 vma_complete+0x97f/0xb50 mm/vma.c:310
 commit_merge+0x6f6/0x760 mm/vma.c:674
 vma_merge_existing_range+0x13b8/0x16f0 mm/vma.c:897
 __mmap_region+0x175b/0x2cd0 mm/vma.c:2466
 mmap_region+0x226/0x2c0 mm/mmap.c:1347
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880403a60f8
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 32 bytes inside of
 freed 184-byte region [ffff8880403a60f8, ffff8880403a61b0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x403a6
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801be90b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5461, tgid 5461 (syz-executor239), ts 76280088571, free_ts 76278589874
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
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4160
 vm_area_dup+0x27/0x290 kernel/fork.c:487
 __split_vma+0x1cb/0xc50 mm/vma.c:434
 vms_gather_munmap_vmas+0x4c1/0x1600 mm/vma.c:1288
 __mmap_prepare mm/vma.c:2241 [inline]
 __mmap_region+0x7de/0x2cd0 mm/vma.c:2443
 mmap_region+0x226/0x2c0 mm/mmap.c:1347
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
page last free pid 5457 tgid 5457 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf62/0x1a90 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:962
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc20 mm/mmap.c:1680
 __mmput+0x115/0x3c0 kernel/fork.c:1353
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9b2/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880403a6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880403a6080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fa
>ffff8880403a6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880403a6180: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
 ffff8880403a6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


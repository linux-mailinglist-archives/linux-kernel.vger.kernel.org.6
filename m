Return-Path: <linux-kernel+bounces-253474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C75359321D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414501F22E98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC63176256;
	Tue, 16 Jul 2024 08:29:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529316A948
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118562; cv=none; b=VZX8E5ZQGxygvyMi28xdaqt9a5E/Z0dB8EiExOdk0iQ6h9Mr0c/PI9zY6YwK9dGFGfI0ITdS8IpwLY9aEFBOhor/66bo6GrCanNX3jVA24wve4usWopphIYMoVjPMCP60Goax4xtvyihakYeIBaoTLKhhbPV3Or1XPUy8Fh2skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118562; c=relaxed/simple;
	bh=/S5lYmoee1MWJyBWbLOZ1ZRpzZ4SRDr028DVj5Zg124=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VAj4otA0Ys/3w5EvsEKH+BG0gnKH6c6cFE1VPZUUWlm056beNk+tWWN+ZuYR+0j6oKoXkmyR/cfZpbJccYk2n+YdmcFC664NTu6g431MgRd6sbu4mU6LtcbnslId6zu5dILH2Z6iLJSx42UgAj5drW8Gu2mNQDiiiWzCRGqXEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3815c8c91b9so63304125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721118557; x=1721723357;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JYi/cYQmPnb1wJRCNZnSWIHuQaKPptej5dRCpbB/yk=;
        b=e/uOlVJNmh22oaHT0UEhX1wl4mSJgGJMaA8bEFExqtOkrwGK5MPp8VQiW3pOlmqQjZ
         4hznhjeNj0Z/PQPZ/S92xYgvF2/BvKfJWjjnBvN2u7bBjStuwPyieskh5sG27ReGLxa6
         vr6WTnECsMfEFk2cMDjoUaN/bFPZK9PLJJvxFhDWS9a4ONv/KB2gyuYBZDMOr1Z3y+v1
         5vIAyKDtwgkuikTekzLIkOlS3qp12kyC5VMAiMugibwl3A79UIHGJwo2ctBAEoCtqrz5
         w13n0wquqv8SNmt+jya2mtQP947e8UzGU8vqHd8OBnXhSL3ECOeo5ATOhZevHcPJUwXt
         TyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8CNU0ldO0dA++1NnM5PFG+xdZpjhvKW3IZ4qlAfN2bORbMuvlHysdzvs8Gay9qcPi1aYObeo73XE4Xitjpt9pRLowTegmHu0PXLOK
X-Gm-Message-State: AOJu0Yz61BHEp8UnWz1YzwaEIxLEJfwQ3ibKoBHfKEb1JTIovSZ8PTjJ
	E6KHG7tnatl59oz2vISqmCS1XKGDYStsnlyNKpeyg5YkikYLhU00DvpnDf06t5X6dbZj4/kDPUt
	Pop5GugglLcT1CJPSGZ7o2wUkYGNYG23nvpOB0rF0NeRqGeHERKKlVMM=
X-Google-Smtp-Source: AGHT+IHpdW3MuXUOYL5V88czliNf5/kvj2dLLMasq9YjrKTXqUYf9Ummsl+h8fF/hi3Gzep5k3IHdNC9OVw+dYk2tqkY+RMW3jwT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194e:b0:384:ff22:e5f9 with SMTP id
 e9e14a558f8ab-393d3172aa7mr1336495ab.3.1721118557189; Tue, 16 Jul 2024
 01:29:17 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:29:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037cdb0061d5924b3@google.com>
Subject: [syzbot] [crypto?] KASAN: slab-use-after-free Read in handle_mm_fault
From: syzbot <syzbot+4c882a4a0697c4a25364@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1097ebed980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=4c882a4a0697c4a25364
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d611a5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ce3259980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/66cfe5a679f2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c882a4a0697c4a25364@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in handle_mm_fault+0x14f0/0x19a0 mm/memory.c:5842
Read of size 8 at addr ffff88802c4719d0 by task syz-executor125/5235

CPU: 1 UID: 0 PID: 5235 Comm: syz-executor125 Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 handle_mm_fault+0x14f0/0x19a0 mm/memory.c:5842
 faultin_page mm/gup.c:1194 [inline]
 __get_user_pages+0x6ec/0x16a0 mm/gup.c:1493
 populate_vma_page_range+0x264/0x330 mm/gup.c:1932
 __mm_populate+0x27a/0x460 mm/gup.c:2035
 mm_populate include/linux/mm.h:3429 [inline]
 vm_mmap_pgoff+0x2c3/0x3d0 mm/util.c:593
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f093ce17fe9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f093cd9e158 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f093ce9f4b8 RCX: 00007f093ce17fe9
RDX: 0000000000000002 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f093ce9f4b0 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 00007f093ce9f4bc
R13: 000000000000006e R14: 00007ffe8008cc30 R15: 00007ffe8008cd18
 </TASK>

Allocated by task 5235:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:472
 mmap_region+0xc3d/0x2090 mm/mmap.c:2944
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5237:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3106 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
 remove_vma mm/mmap.c:189 [inline]
 remove_mt mm/mmap.c:2415 [inline]
 do_vmi_align_munmap+0x155c/0x18c0 mm/mmap.c:2758
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
 mmap_region+0x72f/0x2090 mm/mmap.c:2881
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802c4719b0
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 32 bytes inside of
 freed 184-byte region [ffff88802c4719b0, ffff88802c471a68)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2c471
memcg:ffff888024312e01
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff888015eefb40 ffffea000091a480 0000000000000008
raw: 0000000000000000 0000000080100010 00000001fdffffff ffff888024312e01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4769, tgid 4769 (S41dhcpcd), ts 42147845478, free_ts 42112307396
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2ccb/0x2d80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4732
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
 vm_area_dup+0x27/0x290 kernel/fork.c:487
 dup_mmap kernel/fork.c:696 [inline]
 dup_mm kernel/fork.c:1674 [inline]
 copy_mm+0xc7b/0x1f30 kernel/fork.c:1723
 copy_process+0x186b/0x3d90 kernel/fork.c:2376
 kernel_clone+0x226/0x8f0 kernel/fork.c:2788
 __do_sys_clone kernel/fork.c:2931 [inline]
 __se_sys_clone kernel/fork.c:2915 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2915
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4768 tgid 4768 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2692
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3425
 __mmput+0x115/0x390 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802c471880: fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00
 ffff88802c471900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>ffff88802c471980: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff88802c471a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff88802c471a80: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
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


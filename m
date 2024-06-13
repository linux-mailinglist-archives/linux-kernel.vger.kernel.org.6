Return-Path: <linux-kernel+bounces-213101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A4A906B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CB71F21E27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FFC14386B;
	Thu, 13 Jun 2024 11:38:28 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17113DDD8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278708; cv=none; b=MBUwHqVoizcDGTxf862GQFCqOLJzotGbd0uUme0m/ygD/FhxD/THrCp70B35cniseqLfqzFlVSnKoxT6fNZ9itig5e/yxMkDfouSzMwgfgLApQRcxE/vUVTrmI7yLbO4khiDy2niuOMQfUhRAaFxiTgzo6SQ0qvwGqL5kxLAqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278708; c=relaxed/simple;
	bh=bt36tVWPIm6cH81kkgPQxHtnHk40OBZs8KOHQSGY5wU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ii9zP+BIY8bZCrYnTNV+S7RfXElbHSEhwnlD8awp6CREyWsPyj4ksi2sfXant1SmRUGIfbNDm3FxVgqRp1gbDCAc/Vpu/LhaUG/xbGk2E8mJfRyGHTsGY5W/YnkisQ3CVZzDmEZ/u6G7ss0Z4dK5q4AgeezQAJu8uT7fB8oulH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ebd2481a89so77027539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278706; x=1718883506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnO0U251DYlEgIUK4rLgpaWrIAjlIqnBuEAndrf8ODc=;
        b=nKzYFi5iSKwbysfVDfzYV+2XB5POh1rEeFAwwMnDewUhZVTfrhGzeO73IYAoeLmKtd
         P0ZvTKvgQ5cNTycvBuFj2SQ4cE9mgaumLdXuLHvukdiDiUkr4gX7zF54yGP6ahPvXLbR
         Juqvf8cvyXpp70bh+8uHGQxNXOoNBRYou20myzMHJTeSyGHqzOqiIoQsPJj4s6/geZck
         4LY4GnvWAi2KebXwHJBLgCojUzUZrQFRyY9tFreGz7GTHaACXz+nu9NJPufs2W3dK2bn
         M460aRELKeYHd20csAn7YXhuCkxl0dCB4osnpjHYie/ashS+qScy9ROmNl/149TJ2sOe
         l3uw==
X-Forwarded-Encrypted: i=1; AJvYcCXVzBVF8KGIxZfd0Kqd3q4MlS6Ee28wyehve+oKeR2du3iXZYY+mz7WRXlMPunLetg/A9TUT2c3zw8tOWm9SSTNduSONCXxNE/FTAUE
X-Gm-Message-State: AOJu0YxqC2HMnuGBgZO8NE+/HTgJfOsKQTrBe3lM73zm6N8kKpjgB19f
	qSYUvxErarXIZgPHyJuLzR5FXTU6hFcBn0GH1Km117rSsn5B6QPLEaoP+Z/x6SBUxPefdYgXSEH
	nZOMM7kr8/jscyCRtQw5Bput6V6pJ/K4CpC7R6ajj+qW2o/zRrCQsuZA=
X-Google-Smtp-Source: AGHT+IHwPuXN1lN9JDotxBc/qiGkMK5Yvd/RI/1E2pneCunVJzcpNDaiTNsrmDR5yMoKsyiHMjOsc+uM8rlTiK4hD13pLZWFYGol
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3789:b0:4b7:ba5b:96af with SMTP id
 8926c6da1cb9f-4b93ebe7d04mr126029173.1.1718278705775; Thu, 13 Jun 2024
 04:38:25 -0700 (PDT)
Date: Thu, 13 Jun 2024 04:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e21956061ac3eff0@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in finish_fault
From: syzbot <syzbot+d6e5c328862b5ae6cbfe@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d35b2284e966 Add linux-next specific files for 20240607
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178b77ba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
dashboard link: https://syzkaller.appspot.com/bug?extid=d6e5c328862b5ae6cbfe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174c680a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111b9696980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0055a00a2cb/disk-d35b2284.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/192cbb8cf833/vmlinux-d35b2284.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57804c9c9319/bzImage-d35b2284.xz

The issue was bisected to:

commit 1c05047ad01693ad92bdf8347fad3b5c2b25e8bb
Author: Baolin Wang <baolin.wang@linux.alibaba.com>
Date:   Tue Jun 4 10:17:45 2024 +0000

    mm: memory: extend finish_fault() to support large folio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11267f94980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13267f94980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15267f94980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6e5c328862b5ae6cbfe@syzkaller.appspotmail.com
Fixes: 1c05047ad016 ("mm: memory: extend finish_fault() to support large folio")

==================================================================
BUG: KASAN: use-after-free in ptep_get include/linux/pgtable.h:317 [inline]
BUG: KASAN: use-after-free in ptep_get_lockless include/linux/pgtable.h:581 [inline]
BUG: KASAN: use-after-free in pte_range_none mm/memory.c:4409 [inline]
BUG: KASAN: use-after-free in finish_fault+0xf87/0x1460 mm/memory.c:4905
Read of size 8 at addr ffff88807bfb7000 by task syz-executor149/5117

CPU: 0 PID: 5117 Comm: syz-executor149 Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 ptep_get include/linux/pgtable.h:317 [inline]
 ptep_get_lockless include/linux/pgtable.h:581 [inline]
 pte_range_none mm/memory.c:4409 [inline]
 finish_fault+0xf87/0x1460 mm/memory.c:4905
 do_read_fault mm/memory.c:5052 [inline]
 do_fault mm/memory.c:5178 [inline]
 do_pte_missing mm/memory.c:3948 [inline]
 handle_pte_fault+0x3db5/0x7130 mm/memory.c:5502
 __handle_mm_fault mm/memory.c:5645 [inline]
 handle_mm_fault+0x10df/0x1ba0 mm/memory.c:5810
 faultin_page mm/gup.c:1339 [inline]
 __get_user_pages+0x6ef/0x1590 mm/gup.c:1638
 populate_vma_page_range+0x264/0x330 mm/gup.c:2078
 __mm_populate+0x27a/0x460 mm/gup.c:2181
 mm_populate include/linux/mm.h:3442 [inline]
 __do_sys_remap_file_pages mm/mmap.c:3177 [inline]
 __se_sys_remap_file_pages+0x7a1/0x9a0 mm/mmap.c:3103
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff1cbb3e399
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff1cbad8238 EFLAGS: 00000246 ORIG_RAX: 00000000000000d8
RAX: ffffffffffffffda RBX: 00007ff1cbbc8318 RCX: 00007ff1cbb3e399
RDX: 0000000000000000 RSI: 0000000000200000 RDI: 00000000202ec000
RBP: 00007ff1cbbc8310 R08: 0000000000000000 R09: 00007ff1cbad86c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff1cbbc831c
R13: 0000000000000000 R14: 00007ffcff8e0350 R15: 00007ffcff8e0438
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bfb7
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00007ed408 ffff8880b94448a0 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x440dc0(GFP_KERNEL_ACCOUNT|__GFP_COMP|__GFP_ZERO), pid 5097, tgid 5088 (syz-executor149), ts 55842453591, free_ts 55925905863
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1470
 prep_new_page mm/page_alloc.c:1478 [inline]
 get_page_from_freelist+0x2cbd/0x2d70 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4715
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 pagetable_alloc_noprof include/linux/mm.h:2881 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:70 [inline]
 pte_alloc_one+0x88/0x5d0 arch/x86/mm/pgtable.c:33
 do_fault_around mm/memory.c:5000 [inline]
 do_read_fault mm/memory.c:5039 [inline]
 do_fault mm/memory.c:5178 [inline]
 do_pte_missing mm/memory.c:3948 [inline]
 handle_pte_fault+0x2ba7/0x7130 mm/memory.c:5502
 __handle_mm_fault mm/memory.c:5645 [inline]
 handle_mm_fault+0x10df/0x1ba0 mm/memory.c:5810
 faultin_page mm/gup.c:1339 [inline]
 __get_user_pages+0x6ef/0x1590 mm/gup.c:1638
 populate_vma_page_range+0x264/0x330 mm/gup.c:2078
 __mm_populate+0x27a/0x460 mm/gup.c:2181
 mm_populate include/linux/mm.h:3442 [inline]
 __do_sys_remap_file_pages mm/mmap.c:3177 [inline]
 __se_sys_remap_file_pages+0x7a1/0x9a0 mm/mmap.c:3103
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5097 tgid 5088 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1089 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2669
 folios_put_refs+0x76e/0x860 mm/swap.c:1020
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3395
 __mmput+0x115/0x390 kernel/fork.c:1341
 exit_mm+0x220/0x310 kernel/exit.c:565
 do_exit+0x9aa/0x28e0 kernel/exit.c:861
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807bfb6f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807bfb6f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807bfb7000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807bfb7080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807bfb7100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


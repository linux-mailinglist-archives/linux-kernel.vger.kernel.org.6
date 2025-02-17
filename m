Return-Path: <linux-kernel+bounces-517600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97214A382EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623A9172BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697221A436;
	Mon, 17 Feb 2025 12:25:25 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27921A43C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795125; cv=none; b=tJfe1mjKMBWDOTKqXQi0Ak3Nrq5YRLTRw+6OwHFeW3NaU3+ZUY5RT3ETbKp1PhHQaBHZ9zSHbvlsNjxeL1CNTAm+Sz151PTLqJs4UxJQkTmFNXqXzZt8HjD0+DRXHkQ+Hn+3CyW2gJ6020w7ue3L/OFhp/f9+8qYpaoy+OE+oEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795125; c=relaxed/simple;
	bh=RmilnGrHH6J7N7Z28mtF8fvhpzLZ6IrgFXc3chIb9cA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D2OpyhzC71DAck7+fs55B7zSXF44YmrxssoBM01lDLYEGF9jxeyYLQNje3N8qtd86kyv6b07pQXiDyKBQvrwysSH84MbLXl2FI9hImxNMha4wR6/sByjV2GQrBHxRZEcnEeO/a9EbX8fcYt+G3evHlJXQCtRi+1A4oC1EgrNKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2a6102c1aso751575ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739795122; x=1740399922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3swDMaT0+LIdjt1PfacxmT1TKI2/kCMwU/Tp/sUfKMs=;
        b=VGFzBK5nkExiwWvvS9tuSmLYxwJ9Kmva13XEMkviEDz8YoLNpxA0JUryie4QpksvNH
         DWu4V6hGN+eydsH63VpIxBwoFebhH6o6PN84/kJGOZofOgRoVwpSrzhUXLhzJxUUTYt0
         3U1imq/GhTwHRr0+iegaFn/lzBPuemc9PiCsaLSJT+OVAI0y+3bnJ2PSuHOgZoUOSiFW
         62pbQ2WpxULqkg8TQIpwcNxxdeXwtAbSWpLta2tE51vWj+01ifRfGuJA3kiOEOC9RvEo
         LNOltnBFbOGimHwhoJMRj+TuyNhMNfRdqeqsj7xXQWrUuj1U8/XNLVbE1BW0bwwLVfuC
         a7tg==
X-Forwarded-Encrypted: i=1; AJvYcCXoBbmZXV24z0V49WYqKe6xRkMpBvlWiSDbn4WzcUJHBK+ldEQw3hYlCAXtWRGaZjRZiM1Z6BcfKvA0JBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXogWpvFaA1PGeqYXYBM+uj2fMOzCvh5yRG3LYWQsEfyOJz4M
	1BZavVJAQ2zUOOySC+E6f+upRaXZC8UnJ3wl2TK/47wbYlomZVUkhOhLe0aYYsJidgJI7LpZ5CN
	h2NJL4W76orZ2Np61B1CUcomV9lZOEHNhtvcXl4qSVm5HOohghFZPOww=
X-Google-Smtp-Source: AGHT+IGRWI9nEDrTOOAFEVPzFOyCXlnAUZVzYqwXbgjNc0duwUhNksCMdGPLmu2ajYpIG0TRqLVokaMwOGZDRmCFledYspalNuTA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1a:b0:3d1:78c6:208e with SMTP id
 e9e14a558f8ab-3d28092d233mr80033545ab.15.1739795122423; Mon, 17 Feb 2025
 04:25:22 -0800 (PST)
Date: Mon, 17 Feb 2025 04:25:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b32ab2.050a0220.173698.002d.GAE@google.com>
Subject: [syzbot] [mm?] [ntfs3?] BUG: unable to handle kernel paging request
 in shmem_undo_range
From: syzbot <syzbot+fca99d11e65ca4c28b41@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0ad2507d5d93 Linux 6.14-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ab6898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=fca99d11e65ca4c28b41
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1596d7df980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0ad2507d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfb4fc7c042e/vmlinux-0ad2507d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1682113b81f5/bzImage-0ad2507d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e065b353910d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fca99d11e65ca4c28b41@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Failed to load $UpCase (-22).
==================================================================
BUG: KASAN: stack-out-of-bounds in find_lock_entries+0x11b/0xbb0 mm/filemap.c:2115
Read of size 8 at addr ffffc9000ea2f9df by task syz.0.1571/8754

CPU: 0 UID: 0 PID: 8754 Comm: syz.0.1571 Not tainted 6.14.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 find_lock_entries+0x11b/0xbb0 mm/filemap.c:2115
 shmem_undo_range+0x2d4/0x1820 mm/shmem.c:1094
 shmem_truncate_range mm/shmem.c:1224 [inline]
 shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1352
 evict+0x4e8/0x9a0 fs/inode.c:796
 __dentry_kill+0x20d/0x630 fs/dcache.c:643
 dput+0x19f/0x2b0 fs/dcache.c:885
 __fput+0x60b/0x9f0 fs/file_table.c:472
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f30af38ba4a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 43 91 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 a3 91 02 00 8b 44 24
RSP: 002b:00007f30b0137e50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 00007f30af38ba4a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000016
R13: 00007f30b0137eb0 R14: 000000000001f768 R15: 0000400000000400
 </TASK>

The buggy address belongs to stack of task syz.0.1571/8754
 and is located at offset 671 in frame:
 shmem_undo_range+0x0/0x1820

This frame has 3 objects:
 [32, 288) 'fbatch'
 [352, 600) 'indices'
 [672, 680) 'index'

The buggy address belongs to the virtual mapping at
 [ffffc9000ea28000, ffffc9000ea31000) created by:
 copy_process+0x5d1/0x3cf0 kernel/fork.c:2233

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x56b3a
memcg:ffff88804873ec02
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88804873ec02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 8740, tgid 8740 (syz.0.1565), ts 249137916445, free_ts 248484849769
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4739
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_frozen_pages_noprof mm/mempolicy.c:2341 [inline]
 alloc_pages_noprof+0x121/0x190 mm/mempolicy.c:2361
 vm_area_alloc_pages mm/vmalloc.c:3591 [inline]
 __vmalloc_area_node mm/vmalloc.c:3669 [inline]
 __vmalloc_node_range_noprof+0x9c6/0x1380 mm/vmalloc.c:3846
 alloc_thread_stack_node kernel/fork.c:314 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1127
 copy_process+0x5d1/0x3cf0 kernel/fork.c:2233
 kernel_clone+0x226/0x8e0 kernel/fork.c:2815
 __do_sys_clone3 kernel/fork.c:3119 [inline]
 __se_sys_clone3+0x2ee/0x380 kernel/fork.c:3098
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5310 tgid 5310 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 pagetable_free include/linux/mm.h:2917 [inline]
 pagetable_dtor_free include/linux/mm.h:3015 [inline]
 __tlb_remove_table+0x33c/0x420 include/asm-generic/tlb.h:216
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x76/0xf0 mm/mmu_gather.c:282
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2802
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffffc9000ea2f880: f2 f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000ea2f900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000ea2f980: 00 00 00 f2 f2 f2 f2 f2 f2 f2 f2 f2 00 f3 f3 f3
                                                    ^
 ffffc9000ea2fa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000ea2fa80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2
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


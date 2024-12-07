Return-Path: <linux-kernel+bounces-436107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0439E8133
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E41318823FD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877C14B945;
	Sat,  7 Dec 2024 17:14:37 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C4F14A08E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591677; cv=none; b=vA8i5L9RzeW/aS/EsogTQHP6IAqwSnlRfZUukV6T8Nl6Er0BWmIqX4VSkB/VwQYhxtIMsk/zkFBaxM6FG4xsnnsv+g6771+E67AnSGmLERWykEDk3HYN9g/snGK9dnRjBh1p/wnZ75mFLAKclhsF1Q9WcxpDah+kzIzcOMsDDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591677; c=relaxed/simple;
	bh=Cp/N1pPdhAFkqExjuZ4NLSlkzeHKPd/zvNxoyeyQ4HE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cf53BBhddyCVvxltwSImleasIhj0HLIXG+ifeTxrxvx8IvSW5z/p1ySB7uSMke3kuDbryc/RsUpiRXCGJZGdtaOwXBDZ5dgvighqb5Gr0oe9bTpgGvSVWFwdEUE1su4iA5cQSaDHnWsGVckaRbBeltYDHppDO7zGWh8GIWfdicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-843eb4505e7so552271139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 09:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733591674; x=1734196474;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5LMVojwTd0VtvncMbk8RZR3OOVWhT5f3NpHlcHI0W0=;
        b=XtPlmRQAUCWPL95+J40O0VhNojlUyvSsBdhEedMX29D2JAAStJzaJNO4P+EKh7FUhc
         N/GI0K3HQqcH/6mDioBsauZ7ufIg29EMzAJJUKmxVxszQ4ExyoWG8S+V74BxgQd3707t
         gB6+A34FFaowHyK2tJ6ZSMDHD4d4Z1OICJUJJU63BKP/Tl2VhQtfjHBb0h/cQohi7EbP
         8RL+b2cHeKh1tvHATiL70dx0zm4TSBthGz4ttRUhUx43zzRU3Ynoeu2lsWkrujbUMKId
         0JSZFohg20k9ghLUeEUUZzPfTogb8UxFXaPpZWMYVgV838s9o2n7S2aRSPKI5lJZKQo3
         A3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXkyM8L+IHPkEuTUhE1yRVVUth3uueHs7XUEKItLZmEFRT4rYmZi8l63yJbK/05yyPjT2rl+xeDSFEC8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1GyX1q5OKD4Bgyqj0bGpRCMjvUIY+QZ4BNhOR984om4D71qN
	lNAdw1kI/bYCqeJXgAcMgheS5en6C0WZKppfwvWgZAmowoidwYNlHj+PNEKZj13ES7xyEGMOJOT
	gbEblrYFdX/u8oKA5V/6mM5+6+JMyBXh4wdqzVc8yh4NSkiqbDg/RjQA=
X-Google-Smtp-Source: AGHT+IFDDq+AtXsEWnz4yYYnjmO8BMSv0OOcZZODFntdd2ebCmaDe8y9G2EbxIlBj7oWQZuUm/5ZB564lKB7/IYWz6PsObeNoSFf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:776e:93fb with SMTP id
 e9e14a558f8ab-3a811d9c851mr79192855ab.8.1733591673941; Sat, 07 Dec 2024
 09:14:33 -0800 (PST)
Date: Sat, 07 Dec 2024 09:14:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67548279.050a0220.a30f1.015b.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
From: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    af2ea8ab7a54 Add linux-next specific files for 20241205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c4e8df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=1c58afed1cfd2f57efee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133850f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17be9330580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8af0861258fa/disk-af2ea8ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffb38cf7a344/vmlinux-af2ea8ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6fbd2e50358a/bzImage-af2ea8ab.xz

The issue was bisected to:

commit 5b29c4156f5801fced2ec504b44ab98f60c480bf
Author: Qi Zheng <zhengqi.arch@bytedance.com>
Date:   Wed Dec 4 11:09:51 2024 +0000

    x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d344df980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15d344df980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d344df980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com
Fixes: 5b29c4156f58 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64")

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5089
Read of size 8 at addr ffff888034718978 by task syz-executor352/6070

CPU: 0 UID: 0 PID: 6070 Comm: syz-executor352 Not tainted 6.13.0-rc1-next-20241205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5089
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 move_pages_pte+0x8aa/0x3400 mm/userfaultfd.c:1248
 move_pages+0xe75/0x16a0 mm/userfaultfd.c:1754
 userfaultfd_move fs/userfaultfd.c:1899 [inline]
 userfaultfd_ioctl+0x5221/0x6840 fs/userfaultfd.c:2022
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed8de85af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed8de40238 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fed8df10328 RCX: 00007fed8de85af9
RDX: 0000000020000080 RSI: 00000000c028aa05 RDI: 0000000000000003
RBP: 00007fed8df10320 R08: 00007fed8de406c0 R09: 00007fed8de406c0
R10: 00007fed8de406c0 R11: 0000000000000246 R12: 00007fed8dedd334
R13: 0000000000000010 R14: 00007ffc241241e0 R15: 00007ffc241242c8
 </TASK>

Allocated by task 6070:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 ptlock_alloc+0x20/0x70 mm/memory.c:7026
 ptlock_init include/linux/mm.h:2971 [inline]
 pagetable_pte_ctor include/linux/mm.h:2998 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:73 [inline]
 pte_alloc_one+0xd3/0x510 arch/x86/mm/pgtable.c:41
 __do_huge_pmd_anonymous_page mm/huge_memory.c:1229 [inline]
 do_huge_pmd_anonymous_page+0x2fb/0xb30 mm/huge_memory.c:1374
 create_huge_pmd mm/memory.c:5737 [inline]
 __handle_mm_fault mm/memory.c:5986 [inline]
 handle_mm_fault+0x15a7/0x1bb0 mm/memory.c:6183
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8b0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

Freed by task 6071:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4700
 pagetable_pte_dtor include/linux/mm.h:3009 [inline]
 ___pte_free_tlb+0x2b/0x140 arch/x86/mm/pgtable.c:63
 __pte_free_tlb arch/x86/include/asm/pgalloc.h:61 [inline]
 free_pte+0x142/0x190 mm/pt_reclaim.c:31
 zap_pte_range mm/memory.c:1780 [inline]
 zap_pmd_range mm/memory.c:1822 [inline]
 zap_pud_range mm/memory.c:1851 [inline]
 zap_p4d_range mm/memory.c:1872 [inline]
 unmap_page_range+0x4062/0x48d0 mm/memory.c:1893
 zap_page_range_single+0x45c/0x630 mm/memory.c:2018
 madvise_dontneed_single_vma mm/madvise.c:859 [inline]
 madvise_dontneed_free mm/madvise.c:940 [inline]
 madvise_vma_behavior mm/madvise.c:1270 [inline]
 madvise_walk_vmas mm/madvise.c:1502 [inline]
 do_madvise+0x2774/0x4d90 mm/madvise.c:1689
 __do_sys_madvise mm/madvise.c:1705 [inline]
 __se_sys_madvise mm/madvise.c:1703 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888034718960
 which belongs to the cache page->ptl of size 64
The buggy address is located 24 bytes inside of
 freed 64-byte region [ffff888034718960, ffff8880347189a0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34718
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac4f780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000802a002a 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5823, tgid 5823 (syz-executor352), ts 65548803787, free_ts 65433386693
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1549
 prep_new_page mm/page_alloc.c:1557 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3475
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4752
 alloc_pages_mpol+0x30e/0x550 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4160
 ptlock_alloc mm/memory.c:7026 [inline]
 ptlock_init include/linux/mm.h:2971 [inline]
 pmd_ptlock_init include/linux/mm.h:3078 [inline]
 pagetable_pmd_ctor include/linux/mm.h:3116 [inline]
 pmd_alloc_one_noprof include/asm-generic/pgalloc.h:141 [inline]
 __pmd_alloc+0x10b/0x670 mm/memory.c:6436
 pmd_alloc include/linux/mm.h:2862 [inline]
 copy_pmd_range+0x7352/0x77a0 mm/memory.c:1241
 copy_pud_range mm/memory.c:1298 [inline]
 copy_p4d_range mm/memory.c:1322 [inline]
 copy_page_range+0x99f/0xe90 mm/memory.c:1420
 dup_mmap kernel/fork.c:751 [inline]
 dup_mm kernel/fork.c:1693 [inline]
 copy_mm+0x12d2/0x2060 kernel/fork.c:1742
 copy_process+0x1845/0x3d80 kernel/fork.c:2393
 kernel_clone+0x226/0x8e0 kernel/fork.c:2805
 __do_sys_clone kernel/fork.c:2948 [inline]
 __se_sys_clone kernel/fork.c:2932 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2932
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
page last free pid 6052 tgid 6051 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2658
 __folio_put+0x2b3/0x360 mm/swap.c:112
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x76/0xf0 mm/mmu_gather.c:282
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff888034718800: 00 00 00 00 fc fc fc fc 00 00 00 00 00 00 00 00
 ffff888034718880: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff888034718900: 00 00 00 00 00 00 00 00 fc fc fc fc fa fb fb fb
                                                                ^
 ffff888034718980: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888034718a00: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
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


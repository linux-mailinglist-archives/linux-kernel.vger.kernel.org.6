Return-Path: <linux-kernel+bounces-173689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5988C0416
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD19284EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056EA12BF24;
	Wed,  8 May 2024 18:04:33 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5A127B5D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191472; cv=none; b=EeZRzuUXxA1SUSxD4WH4uvWnYnEDxpGHcZrznIJlskm1drSzcFwss2GlqM7UbxMNQXG0C2eRtVmgmBTnIa2gFtGezsD7h9ON2YGbE3l4SIA4RcrcWyHvLWFAU67bHrrlVhYH3Vi/W5SSe60dHzrJkSOFjD6r+2AcJHHqETJg6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191472; c=relaxed/simple;
	bh=FlcjUECuxpzrAiaXWY4z3Yu3cM1NkEV/wehj/sVTd0g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qE5L5Mr85bl8nEHIOf5tAsqhIXTCgOum2HHgGxhiFcpSQkJRDUa2PunumQsM4Wf53nj93Ts4BX4Do65MwpnR7WVHBYiMhF+W2muiWMhILDxhJPLhkiu/ftEbFWOtge4xorjytqZa3klxVCkBc9TeKMVBn9Asw9qbTJCnLE96hxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1849aee8cso229827939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 11:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715191469; x=1715796269;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMVCFQTwcDi5BJK5yOV0Srtx437mNRv7t//WI16coPk=;
        b=fHAKLxd9ZNHPqx0SxkZRHGnNNYJ69F5IxF37tQkYyN+RtFHLhKCeg+qu82ulnNp5j1
         qlcrxyeJVAj+PkZBDUgnCULt9JEhR5d67EWiu4g3tl0ZMLSMCMz6iUZZQn45vVtKTzo4
         7G2lw7hk90nl1MujxhqNJqu5540+gTxIT2q4n5twjvzgx8U2MFy4+w49pICEq1fQeZWV
         rpshaBqnCje7WoewySG0044PKLgmyLG196yRoihQ8yZK8F3Rk48Ky0arLYFc3GU7oNu2
         BFOBCeZQmINdBYDVxKf5VBvZbHCYkxGkfMbQHRA8EYZBpcfaAKyL9arxlkRfUxTvG8IT
         Cwtg==
X-Gm-Message-State: AOJu0YzCR9eVcTDLKgGJM7WHvKjfmeAayNUAScuwsZxzV8ZbzkzFOUYO
	E0VPXJFBsIWNnaYjRPeTrVBBq3mVUY7Gqv5pBzCtSfYGZDOdSI4DC78qOi8lI+crerN1Oxhqa/E
	TO0EBizz6D85kjJHI2VB2K0LrPIjBPK33By6yIffh57fWqseSv/moXcfyEA==
X-Google-Smtp-Source: AGHT+IFAJeC+1kIhiNLWCRqJLi4ifaULpb9kICJd6EagBd7sAEZUihP5iBLplhgcT5T9K4ogrKbkNDCG7hs1HMpFYDQnx474sY7l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218d:b0:488:7838:5aa9 with SMTP id
 8926c6da1cb9f-488fdd5cfaamr282268173.4.1715191469738; Wed, 08 May 2024
 11:04:29 -0700 (PDT)
Date: Wed, 08 May 2024 11:04:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000469f0d0617f5220f@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 kill_orphaned_pgrp (2)
From: syzbot <syzbot+68619f9e9e69accd8e0a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12928970980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=68619f9e9e69accd8e0a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc129693f2cc/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf12611cfdc7/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/311fbc1afd69/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68619f9e9e69accd8e0a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in task_pgrp include/linux/sched/signal.h:689 [inline]
BUG: KASAN: slab-use-after-free in kill_orphaned_pgrp+0x41/0x560 kernel/exit.c:379
Read of size 8 at addr ffff888064362708 by task vhost-9668/9669

CPU: 0 PID: 9669 Comm: vhost-9668 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 task_pgrp include/linux/sched/signal.h:689 [inline]
 kill_orphaned_pgrp+0x41/0x560 kernel/exit.c:379
 exit_notify kernel/exit.c:739 [inline]
 do_exit+0x1673/0x27e0 kernel/exit.c:898
 vhost_task_fn+0x2ff/0x320 kernel/vhost_task.c:61
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 8534:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmem_cache_alloc_node+0x194/0x390 mm/slub.c:3894
 alloc_task_struct_node kernel/fork.c:176 [inline]
 dup_task_struct+0x57/0x7d0 kernel/fork.c:1107
 copy_process+0x5d1/0x3df0 kernel/fork.c:2220
 kernel_clone+0x226/0x8f0 kernel/fork.c:2797
 __do_sys_clone kernel/fork.c:2940 [inline]
 __se_sys_clone kernel/fork.c:2924 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2924
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5326:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2111 [inline]
 slab_free mm/slub.c:4286 [inline]
 kmem_cache_free+0x10b/0x2d0 mm/slub.c:4350
 put_task_struct include/linux/sched/task.h:138 [inline]
 delayed_put_task_struct+0x125/0x2f0 kernel/exit.c:229
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
 handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
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
 __call_rcu_common kernel/rcu/tree.c:2734 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2838
 release_task+0x16d2/0x1810
 de_thread fs/exec.c:1172 [inline]
 begin_new_exec+0xfde/0x1ce0 fs/exec.c:1278
 load_elf_binary+0xb12/0x2e40 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1778 [inline]
 exec_binprm fs/exec.c:1820 [inline]
 bprm_execve+0xaf8/0x17c0 fs/exec.c:1872
 do_execveat_common+0x553/0x700 fs/exec.c:1979
 do_execve fs/exec.c:2053 [inline]
 __do_sys_execve fs/exec.c:2129 [inline]
 __se_sys_execve fs/exec.c:2124 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2124
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888064361e00
 which belongs to the cache task_struct of size 7424
The buggy address is located 2312 bytes inside of
 freed 7424-byte region [ffff888064361e00, ffff888064363b00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x64360
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88801ed27d81
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888015eea500 ffffea00008c9e00 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff88801ed27d81
head: 00fff00000000840 ffff888015eea500 ffffea00008c9e00 dead000000000002
head: 0000000000000000 0000000000040004 00000001ffffffff ffff88801ed27d81
head: 00fff00000000003 ffffea000190d801 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4538, tgid -361552985 (udevd), ts 4538, free_ts 24654065279
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2180
 allocate_slab mm/slub.c:2343 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2396
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3530
 __slab_alloc mm/slub.c:3615 [inline]
 __slab_alloc_node mm/slub.c:3668 [inline]
 slab_alloc_node mm/slub.c:3841 [inline]
 kmem_cache_alloc_node+0x24a/0x390 mm/slub.c:3894
 alloc_task_struct_node kernel/fork.c:176 [inline]
 dup_task_struct+0x57/0x7d0 kernel/fork.c:1107
 copy_process+0x5d1/0x3df0 kernel/fork.c:2220
 kernel_clone+0x226/0x8f0 kernel/fork.c:2797
 __do_sys_clone kernel/fork.c:2940 [inline]
 __se_sys_clone kernel/fork.c:2924 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2924
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6572
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1036
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1416
 do_one_initcall+0x248/0x880 init/main.c:1245
 do_initcall_level+0x157/0x210 init/main.c:1307
 do_initcalls+0x3f/0x80 init/main.c:1323
 kernel_init_freeable+0x435/0x5d0 init/main.c:1555
 kernel_init+0x1d/0x2b0 init/main.c:1444
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888064362600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888064362680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888064362700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888064362780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888064362800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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


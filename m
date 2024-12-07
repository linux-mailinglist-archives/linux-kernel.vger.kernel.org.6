Return-Path: <linux-kernel+bounces-436117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD509E8165
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670172812D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D41494B0;
	Sat,  7 Dec 2024 17:47:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24E1AAC4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593649; cv=none; b=bhzY6sLmZsZm7rPcIpwdJ0TRWZmIwf412nXoLt6eiHSYSgYOBWb7Gq1ILMpnCqadq3Whr8AC8tdhMV2AoiQmnE9EjGR8ALsjmDnLXdF6crHykoR51br7qdJpBYJfzVt0DxFWFvSTCOI5Rn+1MY6K8lCPsyCQM1xrNcPMcoIwmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593649; c=relaxed/simple;
	bh=KGS76y0X8pSxXAHQFWq1GFM9tVeah2PB1MidCyROtwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=opOObngz31Oi5Xlhah0fjdRDBFrriWH0Ch8zYNuJgeW8cigf9oh8mQ+YHFDrrZ2ROZxBP2f0IvVrDcpd25tJkvz2V6/3CNRM17jiXWa3CubDkeH1QCcDrQQWIiOtLA7uwglurXm55j0XvKOXWsU3TGLjuErBijjyg0REsKb+yJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so32006665ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 09:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593645; x=1734198445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kf1z0Dce04Vw+DFefI8+jgU34dXSN7+gshJqPBVj0qw=;
        b=PcK/VgupptyhmwpFtYF3MI30xb51rOS3xxYUW0WJSn2YEcs943hlfXCZDPx/OHw85v
         jqA1rLWKFNgA4mt5Hkfhtmjaqon1MsJcD9LYoWBneMPNu5dC5r913lf2BVeyNJWLzhxY
         ChK2CuzYoWAytDPeTaUqnKpA8fjdOg56mnZjqrtjkXSsgSRWk9pbEyW7qrayM8ff3Lh4
         VjtDQW8dRQ/T0oPGMjmisMNEdYAqonqrLfj4iNwSTbbEYxpxHz1fpSqppkM+P+DKdtcg
         EhxA+Pr+QoVoSKoKWNL6i3PN8eIPZ5THLbc31XwOS1lrzklPbVtSkEzr8X4YDlS7zYE8
         1PBw==
X-Forwarded-Encrypted: i=1; AJvYcCUql62vJWLyzK0I+055YrQpjtfty/736pdEue5gI9VRU37ka5umQghI8OMDyDk2e+45W0IvOic7MW6C/0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIroUj807ZzRk4Eq8E76eKeOj5uBhr+ZNzaM+bOXSliKa8I1Q
	d6RmQhXsxVa+WJ7LU7aLWcVAZmqZn3hm6xsVogMhaWEBCaFfY9gs0by3TasdN9MZsxdvNYqLzyF
	hFzu3KvdicQhXAcrzQzZbmX5IG6pU3ScOO0o/9LVhro9uYsXCXF2BirA=
X-Google-Smtp-Source: AGHT+IE50ouefAkt2BGufmMoPWuvwf/pYuVzrJlnaShulcNkIQZLK81fMothhtCAJZW5U6DxdPvbdTOFbOX43LYm1GOQYE1eTxeO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c46:b0:3a7:fe8c:b014 with SMTP id
 e9e14a558f8ab-3a811e29199mr72662135ab.21.1733593644938; Sat, 07 Dec 2024
 09:47:24 -0800 (PST)
Date: Sat, 07 Dec 2024 09:47:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67548a2c.050a0220.2477f.001a.GAE@google.com>
Subject: [syzbot] [mm?] upstream test error: WARNING: locking bug in __rmqueue_pcplist
From: syzbot <syzbot+4dbab151c88eb889644b@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ceb8bf2ceaa7 module: Convert default symbol namespace to s..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cef5e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6271abc57260d634
dashboard link: https://syzkaller.appspot.com/bug?extid=4dbab151c88eb889644b
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-ceb8bf2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30e29cf33ebb/vmlinux-ceb8bf2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee2d212ca202/zImage-ceb8bf2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dbab151c88eb889644b@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.13.0-rc1-syzkaller-00005-gceb8bf2ceaa7 #0 Not tainted
-----------------------------
syz.0.40/3323 is trying to lock:
ffff00007fc1ffd8 (&zone->lock){..-.}-{3:3}, at: rmqueue_bulk mm/page_alloc.c:2307 [inline]
ffff00007fc1ffd8 (&zone->lock){..-.}-{3:3}, at: __rmqueue_pcplist+0x388/0x1178 mm/page_alloc.c:3001
other info that might help us debug this:
context-{2:2}
4 locks held by syz.0.40/3323:
 #0: ffff0000171eed10 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
 #0: ffff0000171eed10 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0xe4/0x94c mm/mmap.c:1651
 #1: ffff800086f89760 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x0/0x290 mm/pgtable-generic.c:253
 #2: ffff00000fbdcc78 (ptlock_ptr(ptdesc)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff00000fbdcc78 (ptlock_ptr(ptdesc)){+.+.}-{3:3}, at: __pte_offset_map_lock+0x118/0x2ec mm/pgtable-generic.c:402
 #3: ffff000069f98698 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #3: ffff000069f98698 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3030 [inline]
 #3: ffff000069f98698 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3074 [inline]
 #3: ffff000069f98698 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x428/0x20f0 mm/page_alloc.c:3471
stack backtrace:
CPU: 1 UID: 0 PID: 3323 Comm: syz.0.40 Not tainted 6.13.0-rc1-syzkaller-00005-gceb8bf2ceaa7 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:484 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xa4/0xf4 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x1514/0x6604 kernel/locking/lockdep.c:5176
 lock_acquire kernel/locking/lockdep.c:5849 [inline]
 lock_acquire+0x450/0x76c kernel/locking/lockdep.c:5814
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x58/0x80 kernel/locking/spinlock.c:162
 rmqueue_bulk mm/page_alloc.c:2307 [inline]
 __rmqueue_pcplist+0x388/0x1178 mm/page_alloc.c:3001
 rmqueue_pcplist mm/page_alloc.c:3043 [inline]
 rmqueue mm/page_alloc.c:3074 [inline]
 get_page_from_freelist+0x4a0/0x20f0 mm/page_alloc.c:3471
 __alloc_pages_noprof+0x1b4/0x2248 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x104/0x490 mm/mempolicy.c:2265
 alloc_pages_noprof+0x178/0x1ec mm/mempolicy.c:2344
 stack_depot_save_flags+0x508/0x95c lib/stackdepot.c:627
 kasan_save_stack+0x50/0x64 mm/kasan/common.c:48
 __kasan_record_aux_stack+0xa0/0xb8 mm/kasan/generic.c:544
 kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:549
 task_work_add+0x9c/0x35c kernel/task_work.c:77
 __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1223 [inline]
 run_posix_cpu_timers+0x51c/0x810 kernel/time/posix-cpu-timers.c:1422
 update_process_times+0x16c/0x444 kernel/time/timer.c:2526
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x198/0x40c kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x5ec/0x964 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x2a0/0x768 kernel/time/hrtimer.c:1865
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_phys+0x40/0x6c drivers/clocksource/arm_arch_timer.c:692
 handle_percpu_devid_irq+0x19c/0x30c kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:714 [inline]
 generic_handle_domain_irq+0x78/0xa4 kernel/irq/irqdesc.c:770
 gic_handle_irq+0x54/0x184 drivers/irqchip/irq-gic.c:370
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
 do_interrupt_handler+0x12c/0x150 arch/arm64/kernel/entry-common.c:310
 __el1_irq arch/arm64/kernel/entry-common.c:560 [inline]
 el1_interrupt+0x34/0x54 arch/arm64/kernel/entry-common.c:575
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
 __kasan_check_write+0x20/0x2c mm/kasan/shadow.c:37 (P)
 __kasan_check_write+0x20/0x2c mm/kasan/shadow.c:37 (L)
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_add_negative include/linux/atomic/atomic-instrumented.h:1420 [inline]
 __folio_remove_rmap mm/rmap.c:1547 [inline]
 folio_remove_rmap_ptes+0x6c/0x380 mm/rmap.c:1620
 zap_present_folio_ptes mm/memory.c:1526 [inline]
 zap_present_ptes mm/memory.c:1585 [inline]
 zap_pte_range mm/memory.c:1627 [inline]
 zap_pmd_range mm/memory.c:1753 [inline]
 zap_pud_range mm/memory.c:1782 [inline]
 zap_p4d_range mm/memory.c:1803 [inline]
 unmap_page_range+0xe38/0x2318 mm/memory.c:1824
 unmap_single_vma.constprop.0+0xb4/0x188 mm/memory.c:1870
 unmap_vmas+0x194/0x318 mm/memory.c:1914
 exit_mmap+0x138/0x94c mm/mmap.c:1667
 __mmput+0xa8/0x39c kernel/fork.c:1353
 mmput+0x88/0x98 kernel/fork.c:1375
 exit_mm kernel/exit.c:570 [inline]
 do_exit+0x6d4/0x2048 kernel/exit.c:925
 do_group_exit+0xa4/0x208 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __arm64_sys_exit_group+0x3c/0x44 kernel/exit.c:1096
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
 do_el0_svc_compat+0x40/0x68 arch/arm64/kernel/syscall.c:157
 el0_svc_compat+0x4c/0x17c arch/arm64/kernel/entry-common.c:887
 el0t_32_sync_handler+0x98/0x13c arch/arm64/kernel/entry-common.c:897
 el0t_32_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:605


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


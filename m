Return-Path: <linux-kernel+bounces-176507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8D8C30DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54143B210EF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32455783;
	Sat, 11 May 2024 11:34:44 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB55336F
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715427283; cv=none; b=AwoChtz9tbxaoDBH7e7fobHuWAbBR/i//1Y01suEfRRFbFOXrHtpC1UXTyKUgFVbZ+V5rDfHPru77P27cU8DAyeL5ZJVwwY8T9omkyMqt61Sb4Wtc0kqjfcxHBkh7vAzHs64HOLLpIvjIOvipGkCYHt/5bafWyo7CZS9yPBQrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715427283; c=relaxed/simple;
	bh=v/w24e6m+Xp3lV67SosAbMbUyDHzmg6EJydhG2vftDo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=naNkC4mYXuJ+XWl2G4yWV8m/hFOgQfouIpC0i3hcJg1emQP+DDx48PDSUaXg6UToZZgdJJ18Rw1+wvX8dXbZAnPQcJmk0/y8u9rmj+QEoxdQ5x8Csy0w6MLP4MVHVms1suV0NiIE8uNEnZDnrg2/5S57EXH2sSBrN89JL22QahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c74ef7261so36606895ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 04:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715427244; x=1716032044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=823tPAIn1mpKpi+vEEP/0VjYNt90qCy66O+BWOoSBlg=;
        b=qArsnisvg8NAatqC81/MxD8DsplMwnJsioC0YT2lJK0MT5M9A2xCunOK2NffdLqH3D
         V98g0LlmAxviRenl18n68fiy+KX+717qwryzqf0SfbF/Dh8M0mbgA7VAVKl6D8//Q94U
         WNoXoywQLe7Thy942ZcueRZ+ucDbD15zOEbwJWssmbsZgc416JbqoD9L6Jp+/s09fPCE
         1kPUsPvbUFv2hyIVy9W5wzsEDxK1iBfVtyvmMduaKPnfaUPWvoRwb4ssOcznQWg0Mxva
         /OwoQEbJA78wsxm8647rTQOX2znWuGkAlLdrKsnKW1s0tm+0nAkyVhUyP/eV/I518lFt
         kpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIyAsclUKvQqXLfF6S5GwPUgXTtGvFN3zgWKHXC423qwA4NNkhCyev8t+fz52gO5Cue2MHehXF3hE9vdYMR3XOF2lr5Jf8JxVxKCoh
X-Gm-Message-State: AOJu0Yxn8IIMqF4s2yXg21ZYxS356ZCd2hP3krQq10jzcaUNHlGGa2XT
	20WcyiPiiOAxiJrBueWoQ5DNlDhgX0O/dCBk3zEHL28A9Ir6cMfokwivaVMTHhRSYDve0bNwcQM
	j8IrfMP6HqngE10+wgdclPzUfEVvu7yZK4KUvBlQ3Hvyw4cnsG9HZLjY=
X-Google-Smtp-Source: AGHT+IEKx4fw04vuZnoBuS04xZNDWgr6W0RXzPb8brqcwtoGsP3peYCPD3UeovI//r5Q+QKEdGW7XijnB1kwKJAivxItkNj93lAd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:111:b0:36a:3fb0:c96b with SMTP id
 e9e14a558f8ab-36cc143880emr631695ab.1.1715427244047; Sat, 11 May 2024
 04:34:04 -0700 (PDT)
Date: Sat, 11 May 2024 04:34:04 -0700
In-Reply-To: <20240511110614.2636-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008514bc06182c072c@google.com>
Subject: Re: [syzbot] [bpf?] [net?] INFO: rcu detected stall in handle_softirqs
From: syzbot <syzbot+afcbef13b9fa6ae41f9a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in sys_bpf

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5625
rcu: 	(detected by 1, t=10503 jiffies, g=13033, q=705 ncpus=2)
task:syz-executor.1  state:R  running task     stack:26928 pid:5625  tgid:5624  ppid:5443   flags:0x00004002
Call Trace:
 <IRQ>
 sched_show_task kernel/sched/core.c:9192 [inline]
 sched_show_task+0x42e/0x650 kernel/sched/core.c:9166
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:262 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:637 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:796 [inline]
 rcu_pending kernel/rcu/tree.c:3934 [inline]
 rcu_sched_clock_irq+0x2613/0x3100 kernel/rcu/tree.c:2297
 update_process_times+0x175/0x220 kernel/time/timer.c:2486
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x376/0x530 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x657/0xcc0 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:write_comp_data+0x34/0x90 kernel/kcov.c:236
Code: 48 8b 15 7f 10 76 7e 65 8b 05 80 10 76 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 14 16 00 00 85 c0 74 4f 8b 82 f0 15 00 00 <83> f8 03 75 44 48 8b 82 f8 15 00 00 8b 92 f4 15 00 00 48 8b 38 48
RSP: 0018:ffffc90003906fd8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff813d1d91
RDX: ffff88807d1f9e00 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffffff8b09ce80 R08: 0000000000000001 R09: 0000000000000002
R10: 0000000000000004 R11: 000000000040004e R12: 0000000000000004
R13: 0000000000000001 R14: 0000000000000008 R15: ffffc9000390711d
 __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:341
 unwind_next_frame+0x6c1/0x23a0 arch/x86/kernel/unwind_orc.c:515
 __unwind_start+0x5aa/0x880 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xb2/0x170 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmem_cache_alloc_node+0x177/0x350 mm/slub.c:3894
 kmalloc_reserve+0x18b/0x2c0 net/core/skbuff.c:577
 pskb_expand_head+0x240/0x11f0 net/core/skbuff.c:2251
 skb_ensure_writable net/core/skbuff.c:6117 [inline]
 skb_ensure_writable+0x2e7/0x450 net/core/skbuff.c:6109
 __bpf_try_make_writable net/core/filter.c:1665 [inline]
 bpf_try_make_writable net/core/filter.c:1671 [inline]
 bpf_try_make_head_writable net/core/filter.c:1679 [inline]
 ____bpf_clone_redirect net/core/filter.c:2454 [inline]
 bpf_clone_redirect+0x129/0x420 net/core/filter.c:2432
 ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
 __bpf_prog_run512+0xb7/0x100 kernel/bpf/core.c:2238
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x3e2/0x9e0 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0xb17/0x1db0 net/bpf/test_run.c:1058
 bpf_prog_test_run kernel/bpf/syscall.c:4269 [inline]
 __sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdb567dca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbdb63ad0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fbdb57abf80 RCX: 00007fbdb567dca9
RDX: 0000000000000050 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007fbdb56c947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbdb57abf80 R15: 00007ffd4906dd38
 </TASK>
rcu: rcu_preempt kthread starved for 10536 jiffies! g13033 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27664 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:1862
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 5625 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-00008-gee5b455b0ada-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:write_comp_data+0x34/0x90 kernel/kcov.c:236
Code: 48 8b 15 7f 10 76 7e 65 8b 05 80 10 76 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 14 16 00 00 85 c0 74 4f 8b 82 f0 15 00 00 <83> f8 03 75 44 48 8b 82 f8 15 00 00 8b 92 f4 15 00 00 48 8b 38 48
RSP: 0018:ffffc90003906fd8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff813d1d91
RDX: ffff88807d1f9e00 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffffff8b09ce80 R08: 0000000000000001 R09: 0000000000000002
R10: 0000000000000004 R11: 000000000040004e R12: 0000000000000004
R13: 0000000000000001 R14: 0000000000000008 R15: ffffc9000390711d
FS:  00007fbdb63ad6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001060 CR3: 00000000272e2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:341
 unwind_next_frame+0x6c1/0x23a0 arch/x86/kernel/unwind_orc.c:515
 __unwind_start+0x5aa/0x880 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xb2/0x170 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmem_cache_alloc_node+0x177/0x350 mm/slub.c:3894
 kmalloc_reserve+0x18b/0x2c0 net/core/skbuff.c:577
 pskb_expand_head+0x240/0x11f0 net/core/skbuff.c:2251
 skb_ensure_writable net/core/skbuff.c:6117 [inline]
 skb_ensure_writable+0x2e7/0x450 net/core/skbuff.c:6109
 __bpf_try_make_writable net/core/filter.c:1665 [inline]
 bpf_try_make_writable net/core/filter.c:1671 [inline]
 bpf_try_make_head_writable net/core/filter.c:1679 [inline]
 ____bpf_clone_redirect net/core/filter.c:2454 [inline]
 bpf_clone_redirect+0x129/0x420 net/core/filter.c:2432
 ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
 __bpf_prog_run512+0xb7/0x100 kernel/bpf/core.c:2238
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x3e2/0x9e0 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0xb17/0x1db0 net/bpf/test_run.c:1058
 bpf_prog_test_run kernel/bpf/syscall.c:4269 [inline]
 __sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdb567dca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbdb63ad0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fbdb57abf80 RCX: 00007fbdb567dca9
RDX: 0000000000000050 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007fbdb56c947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbdb57abf80 R15: 00007ffd4906dd38
 </TASK>


Tested on:

commit:         ee5b455b Merge tag 'slab-for-6.9-rc7-fixes' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1628ac00980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=afcbef13b9fa6ae41f9a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132d583f180000



Return-Path: <linux-kernel+bounces-376366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151289AB063
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DB52823D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C5F19F13B;
	Tue, 22 Oct 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXIpmePn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736ED19E82A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606010; cv=none; b=mmgk5ATKuf77L2v2Dq9jX1wPIi7BaxvAjs6vpYoIZ6zXcGK+rODbIYA+rhfkZw0CKJJK53iReuFWYoyT+wfPtRUwX40FDWsz+8kA6LZdn8u/J+Q1Sgf7hIwUNc9RYgv9Nv1PTLWBydFxO4kSA7xhFtrYAcOKrT4Yfk+nRSqMU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606010; c=relaxed/simple;
	bh=ohdiz9HrLbPUlplP4gVo28sJt66tJ+GrvH53jBfRqj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dumLoLo3Y8SwXNQ9dGebCmI09j7E5u/1ncsqV3+oEFMGE8j69E05cEal30RMMhM1oRKIU1mOlX48FMhrqam4GJv3JSJbKbCHb+i+iVg4tE8u3JSXSu3sRwDE0ljB7yAASoXIatqGuzYwVCGo4lA5B80aDZzct/WUyK1pm8ZdOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXIpmePn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD02C4CEE4;
	Tue, 22 Oct 2024 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729606010;
	bh=ohdiz9HrLbPUlplP4gVo28sJt66tJ+GrvH53jBfRqj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXIpmePnTww4wA+C/vHb4MhH2DEG6COOvKNP6V/QPjArukaSCT5fWmoQTvNp+yFgc
	 Br9Dvv8UPKXDco+fcvCchepqgQer5l0Efe9cHe1vXtS8LlldujLrxH1w+Doisi5Dan
	 LK/+Su3RBS0xXVIpbBdvpUAntAzOhKR5tbtW5BK/+c/zjPH1tUFhyfmf0MJ2GvWeeQ
	 71Hn8nHuJI8lBy9LcWVDzcXbHQSpLi14P7zNFUIjRPoDh8O7m3u9boYdssDocAXk0X
	 UB9Mi6HkvC0O4D8+Kg371Aq7UiWXOBA/3KaE2LV8th7qFXCqibZWOw94yViO5Z0sMO
	 CE1AWP4ZADf3A==
Date: Tue, 22 Oct 2024 16:06:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: syzbot <syzbot+4abde9163a953b8a0fd0@syzkaller.appspotmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
	mingo@kernel.org, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING in task_work_add
Message-ID: <Zxexd7nd3k8CM51w@localhost.localdomain>
References: <6717300e.050a0220.1e4b4d.006e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6717300e.050a0220.1e4b4d.006e.GAE@google.com>

Adding scheduler people in Cc.

Thanks.

Le Mon, Oct 21, 2024 at 09:54:38PM -0700, syzbot a écrit :
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9ec59cb3edc7 KVM: arm64: Shave a few bytes from the EL2 id..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17061430580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c154e2d4db830898
> dashboard link: https://syzkaller.appspot.com/bug?extid=4abde9163a953b8a0fd0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc9a7d36d46a/disk-9ec59cb3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/30547ddd681e/vmlinux-9ec59cb3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5c4e02d0f97a/Image-9ec59cb3.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4abde9163a953b8a0fd0@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404
> Modules linked in:
> CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc3-syzkaller-g9ec59cb3edc7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline]
> pc : kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
> pc : kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
> pc : do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
> pc : kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
> pc : arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404
> lr : 0x0
> sp : ffff8000800176a0
> x29: ffff800080017750 x28: 1ffff00010002f58 x27: 00000000ffff8d68
> x26: dfff800000000000 x25: ffff0000c2c588c0 x24: dfff800000000000
> x23: ffff700010002ef0 x22: ffff800080017850 x21: ffff8000800176b8
> x20: ffff800080462114 x19: ffff8000800177a0 x18: dfff800000000000
> x17: ffff800123f21000 x16: ffff80008b490b1c x15: 0000000000000001
> x14: 1fffe000366c806a x13: ffff800097807ff0 x12: ffff800097808000
> x11: 0000000000000000 x10: ffff0000c1978000 x9 : ffff800097807e9f
> x8 : ffff800097807fd8 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : fffffffffffffff0 x3 : 0000000000000000
> x2 : ffff0000c1978000 x1 : ffff800080029c40 x0 : 0000000000000001
> Call trace:
>  kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline] (P)
>  kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline] (P)
>  kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline] (P)
>  do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline] (P)
>  kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline] (P)
>  arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404 (P)
>  0x0 (L)
>  stack_trace_save+0xfc/0x1a0 kernel/stacktrace.c:122
>  kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xd0/0xec mm/kasan/generic.c:541
>  kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:546
>  task_work_add+0xb8/0x464 kernel/task_work.c:66
>  task_tick_mm_cid kernel/sched/core.c:10468 [inline]
>  sched_tick+0x2a8/0x404 kernel/sched/core.c:5605
>  update_process_times+0x204/0x260 kernel/time/timer.c:2524
>  tick_sched_handle kernel/time/tick-sched.c:276 [inline]
>  tick_nohz_handler+0x324/0x478 kernel/time/tick-sched.c:297
>  __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
>  __hrtimer_run_queues+0x468/0xce0 kernel/time/hrtimer.c:1755
>  hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1817
>  timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
>  arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:685
>  handle_percpu_devid_irq+0x174/0x308 kernel/irq/chip.c:942
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq_desc kernel/irq/irqdesc.c:692 [inline]
>  generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:748
>  __gic_handle_irq drivers/irqchip/irq-gic-v3.c:843 [inline]
>  __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:894 [inline]
>  gic_handle_irq+0x6c/0x190 drivers/irqchip/irq-gic-v3.c:938
>  call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
>  do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:310
>  __el1_irq arch/arm64/kernel/entry-common.c:560 [inline]
>  el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:575
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
>  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
>  spectre_v4_mitigations_off arch/arm64/kernel/proton-pack.c:425 [inline] (P)
>  spectre_v4_enable_task_mitigation+0x80/0x218 arch/arm64/kernel/proton-pack.c:671 (P)
>  spectre_v4_mitigations_off arch/arm64/kernel/proton-pack.c:424 [inline] (L)
>  spectre_v4_enable_task_mitigation+0x68/0x218 arch/arm64/kernel/proton-pack.c:671 (L)
>  start_thread arch/arm64/include/asm/processor.h:311 [inline]
>  load_elf_binary+0x1ce0/0x215c fs/binfmt_elf.c:1346
>  search_binary_handler fs/exec.c:1752 [inline]
>  exec_binprm fs/exec.c:1794 [inline]
>  bprm_execve+0x7e0/0x1490 fs/exec.c:1845
>  kernel_execve+0x724/0x820 fs/exec.c:2012
>  run_init_process+0x1bc/0x1ec init/main.c:1390
>  try_to_run_init_process init/main.c:1397 [inline]
>  kernel_init+0xdc/0x2a0 init/main.c:1525
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 dump_backtrace+0x980/0x9b0 arch/arm64/kernel/stacktrace.c:477
> Modules linked in:
> CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc3-syzkaller-g9ec59cb3edc7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> pstate: 004003c5 (nzcv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
> pc : kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
> pc : do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
> pc : kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
> pc : dump_backtrace+0x980/0x9b0 arch/arm64/kernel/stacktrace.c:477
> lr : kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
> lr : kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
> lr : do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
> lr : kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
> lr : dump_backtrace+0x980/0x9b0 arch/arm64/kernel/stacktrace.c:477
> sp : ffff800080017140
> x29: ffff800080017200 x28: ffff80008f81b770 x27: ffff800080017160
> x26: ffff800097808000 x25: 0000000000000000 x24: ffff800097807e9f
> x23: ffff800097807fd8 x22: ffff800080017160 x21: ffff80008b5a7ad8
> x20: ffff80008b5a4a20 x19: ffff0000c1978000 x18: 0000000000000008
> x17: 0000000000000000 x16: ffff80008b3ca11c x15: ffff700011f0d634
> x14: 0000000000010004 x13: 0000000000000002 x12: ffff0000c1978000
> x11: 0000000000ff0100 x10: 0000000000ff0100 x9 : 0000000000010004
> x8 : ffff0000c1978000 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff800080016838 x4 : ffff80008f8dd8a0 x3 : ffff800080396c78
> x2 : 0000000000000000 x1 : ffff80008f81b7b0 x0 : 0000000000000000
> Call trace:
>  kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline] (P)
>  kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline] (P)
>  do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline] (P)
>  kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline] (P)
>  dump_backtrace+0x980/0x9b0 arch/arm64/kernel/stacktrace.c:477 (P)
>  kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline] (L)
>  kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline] (L)
>  do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline] (L)
>  kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline] (L)
>  dump_backtrace+0x980/0x9b0 arch/arm64/kernel/stacktrace.c:477 (L)
>  show_regs+0x34/0x44 arch/arm64/kernel/process.c:248
>  __warn+0x134/0x6b8 kernel/panic.c:746
>  __report_bug lib/bug.c:199 [inline]
>  report_bug+0x298/0x5b0 lib/bug.c:219
>  bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:1010
>  call_break_hook arch/arm64/kernel/debug-monitors.c:319 [inline]
>  brk_handler+0x17c/0x2e0 arch/arm64/kernel/debug-monitors.c:326
>  do_debug_exception+0x1e4/0x398 arch/arm64/mm/fault.c:1002
>  el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:490
>  el1h_64_sync_handler+0x40/0xcc arch/arm64/kernel/entry-common.c:536
>  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
>  kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline] (P)
>  kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline] (P)
>  kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline] (P)
>  do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline] (P)
>  kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline] (P)
>  arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404 (P)
>  0x0 (L)
>  stack_trace_save+0xfc/0x1a0 kernel/stacktrace.c:122
>  kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xd0/0xec mm/kasan/generic.c:541
>  kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:546
>  task_work_add+0xb8/0x464 kernel/task_work.c:66
>  task_tick_mm_cid kernel/sched/core.c:10468 [inline]
>  sched_tick+0x2a8/0x404 kernel/sched/core.c:5605
>  update_process_times+0x204/0x260 kernel/time/timer.c:2524
>  tick_sched_handle kernel/time/tick-sched.c:276 [inline]
>  tick_nohz_handler+0x324/0x478 kernel/time/tick-sched.c:297
>  __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
>  __hrtimer_run_queues+0x468/0xce0 kernel/time/hrtimer.c:1755
>  hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1817
>  timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
>  arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:685
>  handle_percpu_devid_irq+0x174/0x308 kernel/irq/chip.c:942
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq_desc kernel/irq/irqdesc.c:692 [inline]
>  generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:748
>  __gic_handle_irq drivers/irqchip/irq-gic-v3.c:843 [inline]
>  __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:894 [inline]
>  gic_handle_irq+0x6c/0x190 drivers/irqchip/irq-gic-v3.c:938
>  call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
>  do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:310
>  __el1_irq arch/arm64/kernel/entry-common.c:560 [inline]
>  el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:575
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
>  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
>  spectre_v4_mitigations_off arch/arm64/kernel/proton-pack.c:425 [inline] (P)
>  spectre_v4_enable_task_mitigation+0x80/0x218 arch/arm64/kernel/proton-pack.c:671 (P)
>  spectre_v4_mitigations_off arch/arm64/kernel/proton-pack.c:424 [inline] (L)
>  spectre_v4_enable_task_mitigation+0x68/0x218 arch/arm64/kernel/proton-pack.c:671 (L)
>  start_thread arch/arm64/include/asm/processor.h:311 [inline]
>  load_elf_binary+0x1ce0/0x215c fs/binfmt_elf.c:1346
>  search_binary_handler fs/exec.c:1752 [inline]
>  exec_binprm fs/exec.c:1794 [inline]
>  bprm_execve+0x7e0/0x1490 fs/exec.c:1845
>  kernel_execve+0x724/0x820 fs/exec.c:2012
>  run_init_process+0x1bc/0x1ec init/main.c:1390
>  try_to_run_init_process init/main.c:1397 [inline]
>  kernel_init+0xdc/0x2a0 init/main.c:1525
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
> irq event stamp: 1359624
> hardirqs last  enabled at (1359623): [<ffff800083f42a84>] get_random_u64+0x338/0x584 drivers/char/random.c:554
> hardirqs last disabled at (1359624): [<ffff80008b48e24c>] __el1_irq arch/arm64/kernel/entry-common.c:557 [inline]
> hardirqs last disabled at (1359624): [<ffff80008b48e24c>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:575
> softirqs last  enabled at (1359132): [<ffff80008003084c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (1359130): [<ffff800080030818>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> irq event stamp: 1359624
> hardirqs last  enabled at (1359623): [<ffff800083f42a84>] get_random_u64+0x338/0x584 drivers/char/random.c:554
> hardirqs last disabled at (1359624): [<ffff80008b48e24c>] __el1_irq arch/arm64/kernel/entry-common.c:557 [inline]
> hardirqs last disabled at (1359624): [<ffff80008b48e24c>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:575
> softirqs last  enabled at (1359132): [<ffff80008003084c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (1359130): [<ffff800080030818>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


Return-Path: <linux-kernel+bounces-264133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C493DF4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B1DB21E40
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EF94A15;
	Sat, 27 Jul 2024 12:30:56 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AF1E485
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083455; cv=none; b=X4n7u1MWuAPPoeF41N8epSiqOm7kKWMjWcWOqfgu3PSNmJnFg50AjwAU4I5f2kHMXeBu9aii06In0uXcNj8IJ194vfqAR60vrpk39khznip4ECmG5xuB6sXDwUj+MaoOr+7MWTHqQWRJUzYzCwuA4OdT/pjYpOzxONGxeZeh28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083455; c=relaxed/simple;
	bh=AtE0b3ca0jmeurzQ8AC7atE/3fgar5AZwlk7W5FkBS8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Md7fpnPB4CtB9erWjKVM058QCO1fGgxUr/oDqEpKtCnzYjtnI3avsnL2i5Cm23qRdQxdY1E5R5NHnK19KpHFDPjOK8k4r6UGpcxWS2z+z9kCqJY8otNKwAE9dD+dhWj70FucHQ4lYvMhBSMyOwLOV7otcle1Jq2NUsHwLCmOM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46RCUdsf017245;
	Sat, 27 Jul 2024 21:30:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 27 Jul 2024 21:30:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46RCUd0a017241
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jul 2024 21:30:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4a0b4e3d-18de-40b4-aba0-0d913f6de78d@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jul 2024 21:30:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: profiling: Enabling kernel sleep profile lockups the system
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <63149ac0-73a4-49c0-975b-75dc3bd32f7a@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <63149ac0-73a4-49c0-975b-75dc3bd32f7a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The lock in get_wchan() was introduced by commit 42a20f86dc19 ("sched: Add
wrapper for get_wchan() to keep task blocked"). That is, presumably
kernel sleep profiling is no longer functional since Linux 5.16...

On 2024/07/17 19:08, Tetsuo Handa wrote:
(...snipped...) 
> 
> By the way, there remains a bug which this pull request does not address.
> Either booting with
> 
>   profile=sleep
> 
> kernel command line option added or executing
> 
>   # echo -n sleep > /sys/kernel/profiling
> 
> after boot causes the system to lock up.
> 
> I've reported this problem at
> https://lkml.kernel.org/r/60011cc3-b9fc-49c8-b0c0-35aafe46f313@I-love.SAKURA.ne.jp
> but nobody was interested in. Can somebody test this problem using real hardware?
> If this problem happens with real hardware, maybe nobody is using "kernel sleep
> profiling" and we can remove "kernel sleep profiling" functionality.
> 
> 
> 
> Booting with profile=sleep added:
> ----------------------------------------
> [    7.254439] kernel profiling enabled schedstats, disable via kernel.sched_schedstats.
> [    7.254514] kernel sleep profiling enabled (shift: 0)
> (...snipped...)
> [   13.334555] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: 0x6, model: 0x9a, stepping: 0x4)
> [   13.337444] 
> [   13.337857] ============================================
> [   13.337857] WARNING: possible recursive locking detected
> [   13.337857] 6.10.0 #95 Not tainted
> [   13.337857] --------------------------------------------
> [   13.337857] swapper/0/1 is trying to acquire lock:
> [   13.337857] ffff8a1784955d38 (&p->pi_lock){....}-{2:2}, at: get_wchan+0x32/0x80
> [   13.337857] 
> [   13.337857] but task is already holding lock:
> [   13.337857] ffff8a1784955d38 (&p->pi_lock){....}-{2:2}, at: try_to_wake_up+0x54/0x5f0
> [   13.337857] 
> [   13.337857] other info that might help us debug this:
> [   13.337857]  Possible unsafe locking scenario:
> [   13.337857] 
> [   13.337857]        CPU0
> [   13.337857]        ----
> [   13.337857]   lock(&p->pi_lock);
> [   13.337857]   lock(&p->pi_lock);
> [   13.337857] 
> [   13.337857]  *** DEADLOCK ***
> [   13.337857] 
> [   13.337857]  May be due to missing lock nesting notation
> [   13.337857] 
> [   13.337857] 2 locks held by swapper/0/1:
> [   13.337857]  #0: ffff8a1784955d38 (&p->pi_lock){....}-{2:2}, at: try_to_wake_up+0x54/0x5f0
> [   13.337857]  #1: ffff8a1819ff7dd8 (&rq->__lock){-.-.}-{2:2}, at: try_to_wake_up+0x16c/0x5f0
> [   13.337857] 
> [   13.337857] stack backtrace:
> [   13.337857] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0 #95
> [   13.337857] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [   13.337857] Call Trace:
> [   13.337857]  <TASK>
> [   13.337857]  dump_stack_lvl+0x79/0xb0
> [   13.337857]  validate_chain+0x300/0x4c0
> [   13.337857]  __lock_acquire+0x51f/0xb90
> [   13.337857]  lock_acquire.part.0+0x6e/0x1c0
> [   13.337857]  ? get_wchan+0x32/0x80
> [   13.337857]  ? lock_acquire+0xf4/0x130
> [   13.337857]  ? get_wchan+0x32/0x80
> [   13.337857]  __raw_spin_lock_irq+0x40/0x90
> [   13.337857]  ? get_wchan+0x32/0x80
> [   13.337857]  get_wchan+0x32/0x80
> [   13.337857]  __update_stats_enqueue_sleeper+0x153/0x380
> [   13.337857]  enqueue_entity+0x42b/0x580
> [   13.337857]  enqueue_task_fair+0x97/0x3d0
> [   13.337857]  activate_task+0x4e/0xe0
> [   13.337857]  ttwu_do_activate+0x5d/0x2a0
> [   13.337857]  try_to_wake_up+0x1cf/0x5f0
> [   13.337857]  ? __wait_for_common+0x4d/0x220
> [   13.337857]  __kthread_create_worker+0xab/0x100
> [   13.337857]  kthread_create_worker+0x61/0x80
> [   13.337857]  workqueue_init+0x1d/0x390
> [   13.337857]  kernel_init_freeable+0xc4/0x230
> [   13.337857]  ? __pfx_kernel_init+0x10/0x10
> [   13.337857]  kernel_init+0x1a/0x1d0
> [   13.337857]  ret_from_fork+0x31/0x50
> [   13.337857]  ? __pfx_kernel_init+0x10/0x10
> [   13.337857]  ret_from_fork_asm+0x1a/0x30
> [   13.337857]  </TASK>
> ----------------------------------------
> 
> Writing to /sys/kernel/profiling after boot:
> ----------------------------------------
> [   69.085956] kernel profiling enabled schedstats, disable via kernel.sched_schedstats.
> [   69.096289] kernel sleep profiling enabled (shift: 0)
> [   69.102141] 
> [   69.105003] ======================================================
> [   69.111960] WARNING: possible circular locking dependency detected
> [   69.118765] 6.10.0 #95 Not tainted
> [   69.122478] ------------------------------------------------------
> [   69.128995] swapper/2/0 is trying to acquire lock:
> [   69.134270] ffff94bac09cb5b8 (&p->pi_lock){-.-.}-{2:2}, at: get_wchan+0x32/0x80
> [   69.141938] 
> [   69.141938] but task is already holding lock:
> [   69.148104] ffff94bb5a7f7dd8 (&rq->__lock){-.-.}-{2:2}, at: _raw_spin_rq_lock_irqsave+0x2c/0x50
> [   69.157339] 
> [   69.157339] which lock already depends on the new lock.
> [   69.157339] 
> [   69.165841] 
> [   69.165841] the existing dependency chain (in reverse order) is:
> [   69.173805] 
> [   69.173805] -> #1 (&rq->__lock){-.-.}-{2:2}:
> [   69.180186]        __lock_acquire+0x51f/0xb90
> [   69.184799]        lock_acquire.part.0+0x6e/0x1c0
> [   69.190031]        _raw_spin_lock_nested+0x33/0x80
> [   69.195285]        raw_spin_rq_lock_nested+0x15/0x30
> [   69.200854]        task_fork_fair+0x3e/0xe0
> [   69.206084]        sched_cgroup_fork+0x11e/0x160
> [   69.211425]        copy_process+0x12d6/0x1c70
> [   69.216385]        kernel_clone+0x9e/0x390
> [   69.220996]        user_mode_thread+0x5f/0x90
> [   69.225841]        rest_init+0x1e/0x190
> [   69.230291]        start_kernel+0x5d6/0x6a0
> [   69.235052]        x86_64_start_reservations+0x18/0x30
> [   69.240660]        x86_64_start_kernel+0x92/0xa0
> [   69.245837]        common_startup_64+0x13e/0x141
> [   69.250905] 
> [   69.250905] -> #0 (&p->pi_lock){-.-.}-{2:2}:
> [   69.257221]        check_prev_add+0xf1/0xce0
> [   69.262034]        validate_chain+0x406/0x4c0
> [   69.266893]        __lock_acquire+0x51f/0xb90
> [   69.271676]        lock_acquire.part.0+0x6e/0x1c0
> [   69.276901]        __raw_spin_lock_irq+0x40/0x90
> [   69.281950]        get_wchan+0x32/0x80
> [   69.286109]        __update_stats_enqueue_sleeper+0x153/0x380
> [   69.292413]        enqueue_entity+0x42b/0x580
> [   69.297274]        enqueue_task_fair+0x97/0x3d0
> [   69.302301]        activate_task+0x4e/0xe0
> [   69.306790]        ttwu_do_activate+0x5d/0x2a0
> [   69.311689]        sched_ttwu_pending+0xe7/0x1a0
> [   69.316756]        __flush_smp_call_function_queue+0x1d9/0x690
> [   69.323108]        __sysvec_call_function_single+0x3c/0x150
> [   69.329181]        sysvec_call_function_single+0x68/0x90
> [   69.334953]        asm_sysvec_call_function_single+0x1a/0x20
> [   69.341089]        pv_native_safe_halt+0xf/0x20
> [   69.346141]        acpi_safe_halt+0x14/0x20
> [   69.350757]        acpi_idle_enter+0x83/0xd0
> [   69.355541]        cpuidle_enter_state+0xcb/0x550
> [   69.360770]        cpuidle_enter+0x2d/0x40
> [   69.365292]        cpuidle_idle_call+0xf4/0x160
> [   69.370263]        do_idle+0x96/0xf0
> [   69.374282]        cpu_startup_entry+0x29/0x30
> [   69.379178]        start_secondary+0x121/0x140
> [   69.384062]        common_startup_64+0x13e/0x141
> [   69.389210] 
> [   69.389210] other info that might help us debug this:
> [   69.389210] 
> [   69.397778]  Possible unsafe locking scenario:
> [   69.397778] 
> [   69.404212]        CPU0                    CPU1
> [   69.409217]        ----                    ----
> [   69.414230]   lock(&rq->__lock);
> [   69.417973]                                lock(&p->pi_lock);
> [   69.424200]                                lock(&rq->__lock);
> [   69.430373]   lock(&p->pi_lock);
> [   69.434115] 
> [   69.434115]  *** DEADLOCK ***
> [   69.434115] 
> [   69.440608] 1 lock held by swapper/2/0:
> [   69.444875]  #0: ffff94bb5a7f7dd8 (&rq->__lock){-.-.}-{2:2}, at: _raw_spin_rq_lock_irqsave+0x2c/0x50
> [   69.454596] 
> [   69.454596] stack backtrace:
> [   69.459437] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.10.0 #95
> [   69.467336] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [   69.478770] Call Trace:
> [   69.481622]  <IRQ>
> [   69.484047]  dump_stack_lvl+0x79/0xb0
> [   69.488303]  check_noncircular+0x133/0x150
> [   69.492874]  ? lock_is_held_type+0xaf/0x130
> [   69.497547]  ? update_sd_lb_stats.constprop.0+0x284/0x2d0
> [   69.503424]  check_prev_add+0xf1/0xce0
> [   69.507613]  ? add_chain_cache+0x111/0x310
> [   69.512100]  validate_chain+0x406/0x4c0
> [   69.516327]  __lock_acquire+0x51f/0xb90
> [   69.520523]  lock_acquire.part.0+0x6e/0x1c0
> [   69.525068]  ? get_wchan+0x32/0x80
> [   69.528858]  ? lock_acquire+0xf4/0x130
> [   69.533053]  ? get_wchan+0x32/0x80
> [   69.536923]  __raw_spin_lock_irq+0x40/0x90
> [   69.541444]  ? get_wchan+0x32/0x80
> [   69.545240]  get_wchan+0x32/0x80
> [   69.548942]  __update_stats_enqueue_sleeper+0x153/0x380
> [   69.554443]  enqueue_entity+0x42b/0x580
> [   69.558693]  enqueue_task_fair+0x97/0x3d0
> [   69.563127]  activate_task+0x4e/0xe0
> [   69.567123]  ttwu_do_activate+0x5d/0x2a0
> [   69.571500]  sched_ttwu_pending+0xe7/0x1a0
> [   69.576099]  __flush_smp_call_function_queue+0x1d9/0x690
> [   69.581823]  __sysvec_call_function_single+0x3c/0x150
> [   69.587257]  sysvec_call_function_single+0x68/0x90
> [   69.592491]  </IRQ>
> [   69.595084]  <TASK>
> [   69.597586]  asm_sysvec_call_function_single+0x1a/0x20
> [   69.603105] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [   69.608395] Code: 22 d7 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 65 3f 3e 00 fb f4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [   69.627892] RSP: 0018:ffffb58b000efe50 EFLAGS: 00000246
> [   69.633594] RAX: 0000000000004000 RBX: 0000000000000001 RCX: 0000000000000000
> [   69.641202] RDX: ffff94bb5a600000 RSI: ffff94bb79020800 RDI: ffff94bb79020864
> [   69.648787] RBP: ffff94bb79020864 R08: ffffffff96b63420 R09: 0000000000000000
> [   69.656489] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> [   69.663706] R13: ffffffff96b634a0 R14: 0000000000000001 R15: 00000000001f6a0c
> [   69.671313]  acpi_safe_halt+0x14/0x20
> [   69.675411]  acpi_idle_enter+0x83/0xd0
> [   69.679550]  cpuidle_enter_state+0xcb/0x550
> [   69.684224]  cpuidle_enter+0x2d/0x40
> [   69.688203]  cpuidle_idle_call+0xf4/0x160
> [   69.692204]  do_idle+0x96/0xf0
> [   69.695673]  cpu_startup_entry+0x29/0x30
> [   69.699998]  start_secondary+0x121/0x140
> [   69.704366]  common_startup_64+0x13e/0x141
> [   69.708374]  </TASK>
> ----------------------------------------



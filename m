Return-Path: <linux-kernel+bounces-168899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 756DF8BBF6B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 08:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778CB1C20C10
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25533FC2;
	Sun,  5 May 2024 06:20:06 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689F184D
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890006; cv=none; b=lNGS/dJtLw+pQwYudfr4qAQGYkVDvlV5L0VotoFBWuVTKAzHsjcxVTjxvOQJ4zQ61D4e4h/YbfQNlKr4Ly/SfdAR3liNDMuHJ8M4a7QDS/nm61LTFFT9zmyAbDaMCEBJ8O1uHlSUTE57/Su7HpGn//t9XLqSw3YlnslnC9U0HmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890006; c=relaxed/simple;
	bh=vOkalvN35feLaqx4tzZDoR4mgM2pSMuyrcn8dQH7Pr8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jx45JZsYjbUxkVH+voBF5Hg/x0+lZtAfF6paqCf4d6xqoRBDATwGE2Zw1PzM2EmHv07yZo+BWbf4lc2zXLv4Dzc83pO3tyJezf7Spbx/bVC5SR5o6Z8wzCOKOizsBdP73KGDbaBQope2Gm9rUdaSjltdiZjmsA+pg3Tgr088Ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4456IuXD078512;
	Sun, 5 May 2024 15:18:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 05 May 2024 15:18:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4456IHRd078429
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 5 May 2024 15:18:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60011cc3-b9fc-49c8-b0c0-35aafe46f313@I-love.SAKURA.ne.jp>
Date: Sun, 5 May 2024 15:18:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH (REPOST)] profiling: initialize prof_cpu_mask from
 profile_online_cpu()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
        akpm@linux-foundation.org
Cc: tglx@linutronix.de, paskripkin@gmail.com, rostedt@goodmis.org,
        glider@google.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000d6b55e060d6bc390@google.com>
 <7227c8d1-08f6-4f95-ad0f-d5c3e47d874d@I-love.SAKURA.ne.jp>
 <85edf211-aa30-4671-93e0-5173b3f7adf2@I-love.SAKURA.ne.jp>
 <239eadaf-d694-4dff-89b9-b476be35f4e9@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <239eadaf-d694-4dff-89b9-b476be35f4e9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/27 15:51, Tetsuo Handa wrote:
> Can somebody test this patch? I don't know how not using
> cpu_possible_mask affects expected profile data collection
> (especially when written to /sys/kernel/profiling interface
> when some of CPUs are offline).

I confirmed that writing to /sys/kernel/profiling while some of
/sys/devices/system/cpu/cpu$num/online are 0 will not affect profile data
collection, for profile_online_cpu() is called (and corresponding bit is set)
when /sys/devices/system/cpu/cpu$num/online becomes 1. Thus, I consider that
this patch itself is correct and safe.

But I found a different problem with current code. Just running

# echo -n sleep > /sys/kernel/profiling

after boot causes the system to lock up. ;-)



[  102.002703] kernel profiling enabled schedstats, disable via kernel.sched_schedstats.
[  102.013462] kernel sleep profiling enabled (shift: 0)
[  102.019515] 
[  102.021862] ======================================================
[  102.028037] WARNING: possible circular locking dependency detected
[  102.034940] 6.9.0-rc6+ #64 Not tainted
[  102.039178] ------------------------------------------------------
[  102.045236] swapper/1/0 is trying to acquire lock:
[  102.050140] ffff9a3d809a0e30 (&p->pi_lock){-.-.}-{2:2}, at: get_wchan+0x33/0x80
[  102.057446] 
[  102.057446] but task is already holding lock:
[  102.062449] ffff9a3e1a3f79d8 (&rq->__lock){-.-.}-{2:2}, at: _raw_spin_rq_lock_irqsave+0x27/0x50
[  102.071546] 
[  102.071546] which lock already depends on the new lock.
[  102.071546] 
[  102.079435] 
[  102.079435] the existing dependency chain (in reverse order) is:
[  102.085407] 
[  102.085407] -> #1 (&rq->__lock){-.-.}-{2:2}:
[  102.090805]        lock_acquire+0xca/0x2d0
[  102.095400]        _raw_spin_lock_nested+0x32/0x80
[  102.100616]        raw_spin_rq_lock_nested+0x15/0x30
[  102.104595]        task_fork_fair+0x3a/0xe0
[  102.109176]        sched_cgroup_fork+0x11e/0x160
[  102.113277]        copy_process+0x15b5/0x2140
[  102.117990]        kernel_clone+0x9e/0x6d0
[  102.122376]        user_mode_thread+0x5f/0x90
[  102.127207]        rest_init+0x1e/0x1d0
[  102.131843]        start_kernel+0x64a/0x730
[  102.136213]        x86_64_start_reservations+0x18/0x30
[  102.141857]        x86_64_start_kernel+0x91/0xa0
[  102.147018]        common_startup_64+0x13e/0x141
[  102.152186] 
[  102.152186] -> #0 (&p->pi_lock){-.-.}-{2:2}:
[  102.158338]        check_prevs_add+0x1e2/0xc60
[  102.162335]        __lock_acquire+0x10d4/0x12b0
[  102.167147]        lock_acquire+0xca/0x2d0
[  102.171738]        _raw_spin_lock_irq+0x48/0x90
[  102.176284]        get_wchan+0x33/0x80
[  102.180519]        __update_stats_enqueue_sleeper+0x156/0x390
[  102.185878]        enqueue_entity+0x34c/0x3e0
[  102.190237]        enqueue_task_fair+0xa3/0x350
[  102.195030]        activate_task+0x4c/0xe0
[  102.199643]        ttwu_do_activate+0x5d/0x1f0
[  102.203992]        sched_ttwu_pending+0xe2/0x1a0
[  102.209097]        __flush_smp_call_function_queue+0x1e8/0x6e0
[  102.214120]        __sysvec_call_function_single+0x36/0x150
[  102.220072]        sysvec_call_function_single+0x65/0x80
[  102.224282]        asm_sysvec_call_function_single+0x1a/0x20
[  102.229298]        pv_native_safe_halt+0xf/0x20
[  102.233969]        acpi_safe_halt+0x14/0x20
[  102.238649]        acpi_idle_enter+0x7f/0xd0
[  102.242926]        cpuidle_enter_state+0x93/0x570
[  102.248198]        cpuidle_enter+0x2d/0x40
[  102.252902]        do_idle+0x213/0x270
[  102.257070]        cpu_startup_entry+0x29/0x30
[  102.262396]        start_secondary+0x123/0x140
[  102.267423]        common_startup_64+0x13e/0x141
[  102.272129] 
[  102.272129] other info that might help us debug this:
[  102.272129] 
[  102.280775]  Possible unsafe locking scenario:
[  102.280775] 
[  102.285824]        CPU0                    CPU1
[  102.289461]        ----                    ----
[  102.294154]   lock(&rq->__lock);
[  102.297868]                                lock(&p->pi_lock);
[  102.303641]                                lock(&rq->__lock);
[  102.310000]   lock(&p->pi_lock);
[  102.311916] 
[  102.311916]  *** DEADLOCK ***
[  102.311916] 
[  102.318184] 1 lock held by swapper/1/0:
[  102.321543]  #0: ffff9a3e1a3f79d8 (&rq->__lock){-.-.}-{2:2}, at: _raw_spin_rq_lock_irqsave+0x27/0x50
[  102.331290] 
[  102.331290] stack backtrace:
[  102.336159] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.9.0-rc6+ #64
[  102.342814] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[  102.354177] Call Trace:
[  102.356981]  <IRQ>
[  102.359373]  dump_stack_lvl+0x77/0xb0
[  102.363183]  check_noncircular+0x131/0x150
[  102.367844]  check_prevs_add+0x1e2/0xc60
[  102.372341]  __lock_acquire+0x10d4/0x12b0
[  102.376757]  lock_acquire+0xca/0x2d0
[  102.380836]  ? get_wchan+0x33/0x80
[  102.383514]  ? lock_is_held_type+0xac/0x120
[  102.387749]  _raw_spin_lock_irq+0x48/0x90
[  102.391997]  ? get_wchan+0x33/0x80
[  102.395911]  get_wchan+0x33/0x80
[  102.399713]  __update_stats_enqueue_sleeper+0x156/0x390
[  102.405394]  enqueue_entity+0x34c/0x3e0
[  102.409721]  enqueue_task_fair+0xa3/0x350
[  102.413522]  activate_task+0x4c/0xe0
[  102.417455]  ttwu_do_activate+0x5d/0x1f0
[  102.421393]  sched_ttwu_pending+0xe2/0x1a0
[  102.424410]  __flush_smp_call_function_queue+0x1e8/0x6e0
[  102.430129]  __sysvec_call_function_single+0x36/0x150
[  102.435543]  sysvec_call_function_single+0x65/0x80
[  102.441465]  </IRQ>
[  102.443080]  <TASK>
[  102.445524]  asm_sysvec_call_function_single+0x1a/0x20
[  102.451011] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  102.456052] Code: 22 d7 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 55 af 26 00 fb f4 <c3> cc cc cc cc 66 90 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[  102.474565] RSP: 0018:ffffbba0000dfe60 EFLAGS: 00000246
[  102.481811] RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffff9a3e1a200000
[  102.488391] RDX: 00000000001f37e8 RSI: ffffffff88961bc0 RDI: ffff9a3e39030464
[  102.496168] RBP: ffff9a3e39030464 R08: ffff9a3e39030400 R09: 0000000000000001
[  102.503844] R10: 0000000000000001 R11: ffffffff888d2648 R12: ffff9a3e238ac000
[  102.510614] R13: ffffffff88961bc0 R14: 0000000000000001 R15: 0000000000000000
[  102.517439]  acpi_safe_halt+0x14/0x20
[  102.522052]  acpi_idle_enter+0x7f/0xd0
[  102.525629]  cpuidle_enter_state+0x93/0x570
[  102.530429]  cpuidle_enter+0x2d/0x40
[  102.534386]  do_idle+0x213/0x270
[  102.536860]  cpu_startup_entry+0x29/0x30
[  102.540286]  start_secondary+0x123/0x140
[  102.542516]  common_startup_64+0x13e/0x141
[  102.545389]  </TASK>



[   93.099702] kernel profiling enabled schedstats, disable via kernel.sched_schedstats.
[   93.110562] kernel sleep profiling enabled (shift: 0)
[   93.118228] 
[   93.121032] ============================================
[   93.127279] WARNING: possible recursive locking detected
[   93.133167] 6.9.0-rc6+ #65 Not tainted
[   93.136486] --------------------------------------------
[   93.142349] swapper/8/0 is trying to acquire lock:
[   93.147140] ffff9227c0998e30 (&p->pi_lock){-.-.}-{2:2}, at: get_wchan+0x33/0x80
[   93.154036] 
[   93.154036] but task is already holding lock:
[   93.160368] ffff9227c0998e30 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x56/0x580
[   93.166995] 
[   93.166995] other info that might help us debug this:
[   93.173123]  Possible unsafe locking scenario:
[   93.173123] 
[   93.179771]        CPU0
[   93.181941]        ----
[   93.184727]   lock(&p->pi_lock);
[   93.188471]   lock(&p->pi_lock);
[   93.192588] 
[   93.192588]  *** DEADLOCK ***
[   93.192588] 
[   93.198248]  May be due to missing lock nesting notation
[   93.198248] 
[   93.205640] 3 locks held by swapper/8/0:
[   93.210208]  #0: ffffb17f40674e98 ((&timer.timer)){+.-.}-{0:0}, at: call_timer_fn+0x80/0x260
[   93.216945]  #1: ffff9227c0998e30 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x56/0x580
[   93.225435]  #2: ffff92285bff79d8 (&rq->__lock){-.-.}-{2:2}, at: try_to_wake_up+0x1ab/0x580
[   93.234238] 
[   93.234238] stack backtrace:
[   93.238342] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 6.9.0-rc6+ #65
[   93.245220] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[   93.254093] Call Trace:
[   93.256901]  <IRQ>
[   93.258420]  dump_stack_lvl+0x77/0xb0
[   93.261825]  __lock_acquire+0x765/0x12b0
[   93.289798]  lock_acquire+0xca/0x2d0
[   93.293381]  ? get_wchan+0x33/0x80
[   93.297140]  ? lock_is_held_type+0xac/0x120
[   93.301057]  _raw_spin_lock_irq+0x48/0x90
[   93.307264]  ? get_wchan+0x33/0x80
[   93.310410]  get_wchan+0x33/0x80
[   93.314484]  __update_stats_enqueue_sleeper+0x156/0x390
[   93.318493]  enqueue_entity+0x34c/0x3e0
[   93.322788]  enqueue_task_fair+0xa3/0x350
[   93.326960]  activate_task+0x4c/0xe0
[   93.330226]  ttwu_do_activate+0x5d/0x1f0
[   93.347525]  try_to_wake_up+0x1da/0x580
[   93.352071]  ? __pfx_process_timeout+0x10/0x10
[   93.357023]  ? __pfx_process_timeout+0x10/0x10
[   93.361356]  call_timer_fn+0xae/0x260
[   93.365165]  __run_timer_base.part.35+0x26d/0x2c0
[   93.371324]  ? ktime_get+0x6b/0x130
[   93.375678]  ? ktime_get+0x8b/0x130
[   93.379055]  ? native_apic_msr_write+0x30/0x40
[   93.383911]  run_timer_softirq+0x51/0x90
[   93.397918]  __do_softirq+0xb6/0x3ec
[   93.402236]  irq_exit_rcu+0xba/0xe0
[   93.406044]  sysvec_apic_timer_interrupt+0x6a/0x80
[   93.410164]  </IRQ>
[   93.411967]  <TASK>
[   93.413257]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   93.418952] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   93.423460] Code: 22 d7 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 55 af 26 00 fb f4 <c3> cc cc cc cc 66 90 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[   93.459197] RSP: 0018:ffffb17f40117e60 EFLAGS: 00000246
[   93.465006] RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffff92285be00000
[   93.471498] RDX: 00000000001f37e8 RSI: ffffffffafd61b00 RDI: ffff92286a432c64
[   93.479505] RBP: ffff92286a432c64 R08: ffff92286a432c00 R09: 0000000000000001
[   93.503897] R10: 0000000000000001 R11: ffff92285bfe6258 R12: ffff92286646a400
[   93.512211] R13: ffffffffafd61b00 R14: 0000000000000001 R15: 0000000000000000
[   93.518061]  acpi_safe_halt+0x14/0x20
[   93.522244]  acpi_idle_enter+0x7f/0xd0
[   93.526335]  cpuidle_enter_state+0x93/0x570
[   93.530482]  cpuidle_enter+0x2d/0x40
[   93.533615]  do_idle+0x213/0x270
[   93.545854]  cpu_startup_entry+0x29/0x30
[   93.549904]  start_secondary+0x123/0x140
[   93.553957]  common_startup_64+0x13e/0x141
[   93.558172]  </TASK>



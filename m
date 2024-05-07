Return-Path: <linux-kernel+bounces-172221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3058BEEEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CBA283190
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE976410;
	Tue,  7 May 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XcNOwbWR"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4574433
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118054; cv=none; b=R3Qp0l3nxHoamPlacNag2xtAtF1+vWz/NzLGc7qSsFnO/3/w2ghLEdjU5nbIDLYXnMtU2FDnnC2GxwdxEb2pXq7MzFujdDaUqaZYRJw84R944vBSjzHuG8Mm5uNHXKjvs6EQFk0SjXmniGQkWf/MHIWU6Fxmm3jEcCHJQqEH168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118054; c=relaxed/simple;
	bh=VpkOLQg0axggRVnkVVkWkPpv6IUOtc5+bTkTQo+ApEk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=uINxC/3xwOCxsjQspqr1IukilD93/Ff5fnKV97p0MRiqzDuRtJ8qKSAUE4IXAZ8z4qveexeFg1kgj/RM/G0WhpHMC7KuY4cviAddM5beg4kAzsAlJ9h6u+GJl1ETuH7sz3g+OL+INIfBLV7AQ61RJ6lq/0HFiDizKD4B9Le4/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XcNOwbWR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.112] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06CB020B2C82;
	Tue,  7 May 2024 14:40:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06CB020B2C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715118052;
	bh=ZkkdJbSLg8o/7IJdUA+jt2AhvtIP37M87RHkqOlUm4E=;
	h=Date:To:From:Subject:Cc:From;
	b=XcNOwbWRc+LESVunJgMi/yWwUf9JEgaCADY8Enrw7nvJRK6cSHXIYTszBPSEMWz7d
	 1fDrrUEif3inKliWi8qOqj2jkKjT92NFczSaKzpw2sMin6OQ2ROhTCZewcKs7C8ZXw
	 zJhAx3qk5aH6OUp1AlJfwLwXHhHpPhnXHS+3m2AA=
Message-ID: <f1d66585-64ee-4052-928a-bd5182ea4ca8@linux.microsoft.com>
Date: Tue, 7 May 2024 14:40:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
Subject: Watchdog Reset on Idle CPU with a task on its runq
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
 Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

We are seeing watchdog reset on ARM64 SoC running v5.10.178 kernel 
(stable) where CPU 0 running an idle task even though there is a 
runnable task on CFS runq (rcu_sched in output below).  We are wondering 
why do we see a task waiting to get scheduled to run a CPU otherwise 
running an idle task.  What does this indicate with respect to state of 
CPU 0?  What else could we check in the kernel crash dump. Any pointers 
appreciated.

Thanks,
Vijay

(crash tool output)

[530671.963762] Kernel panic - not syncing: SBSA Generic Watchdog timeout
[530671.970288] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: G 
         O      5.10.178.13-microsoft-standard #1
[530671.980969] Hardware name: Overlake (DT)
[530671.984967] Call trace:
[530671.987499]  dump_backtrace+0x0/0x1f0
[530671.991238]  show_stack+0x1c/0x24
[530671.994630]  dump_stack+0xe0/0x13c
[530671.998107]  panic+0x198/0x3a4
[530672.001239]  sbsa_gwdt_set_timeout+0x0/0x7c
[530672.005498]  __handle_irq_event_percpu+0xf0/0x2ac
[530672.010277]  handle_irq_event+0x60/0x144
[530672.014275]  handle_fasteoi_irq+0x144/0x234
[530672.018533]  __handle_domain_irq+0x8c/0xcc
[530672.022704]  gic_handle_irq+0xc0/0x120
[530672.026527]  el1_irq+0xcc/0x180
[530672.029744]  cpuidle_enter_state+0x1fc/0x31c
[530672.034088]  cpuidle_enter+0x3c/0x50
[530672.037740]  do_idle+0x1e4/0x28c
[530672.041042]  cpu_startup_entry+0x28/0x2c
[530672.045042]  rest_init+0xc4/0xd0
[530672.048346]  arch_call_rest_init+0x14/0x1c
[530672.052517]  start_kernel+0x328/0x3a4
[530672.056267] SMP: stopping secondary CPUs
[530672.060450] Starting crashdump kernel...
[530672.064447] Bye!
crash> runq -c 0
CPU 0 RUNQUEUE: ffff07cf49233200
   CURRENT: PID: 0      TASK: ffffde8e444e8900  COMMAND: "swapper/0"
   RT PRIO_ARRAY: ffff07cf49233440
      [no tasks queued]
   CFS RB_ROOT: ffff07cf492332b0
      [120] PID: 11     TASK: ffff07ad40c10000  COMMAND: "rcu_sched"
crash> bt ffffde8e444e8900
PID: 0        TASK: ffffde8e444e8900  CPU: 0    COMMAND: "swapper/0"
  #0 [ffff800010003db0] __crash_kexec at ffffde8e4370b424
  #1 [ffff800010003e60] panic at ffffde8e4363b64c
  #2 [ffff800010003eb0] sbsa_gwdt_interrupt at ffffde8e43d92aa8
  #3 [ffff800010003ed0] __handle_irq_event_percpu at ffffde8e436b9720
  #4 [ffff800010003f40] handle_irq_event at ffffde8e436b99c4
  #5 [ffff800010003f70] handle_fasteoi_irq at ffffde8e436bff0c
  #6 [ffff800010003fa0] __handle_domain_irq at ffffde8e436b831c
  #7 [ffff800010003fe0] gic_handle_irq at ffffde8e43600974
--- <IRQ stack> ---
  #8 [ffffde8e444d3e50] el1_irq at ffffde8e43602288
  #9 [ffffde8e444d3e70] cpuidle_enter_state at ffffde8e43dd6190
#10 [ffffde8e444d3ed0] cpuidle_enter at ffffde8e43dd6314
#11 [ffffde8e444d3f10] do_idle at ffffde8e4368307c
#12 [ffffde8e444d3f70] cpu_startup_entry at ffffde8e4368314c
#13 [ffffde8e444d3f90] rest_init at ffffde8e4408d79c
#14 [ffffde8e444d3fb0] arch_call_rest_init at ffffde8e443b0730
#15 [ffffde8e444d3fe0] start_kernel at ffffde8e443b0a60
crash>


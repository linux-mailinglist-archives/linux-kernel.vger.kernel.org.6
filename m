Return-Path: <linux-kernel+bounces-200760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDCA8FB495
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C421F21466
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E73EEDE;
	Tue,  4 Jun 2024 13:59:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184C8F45
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509567; cv=none; b=UKducgJwbjC9Bz2rpqQyU5JjDg2UJRZboMEk8IQdds9FMHoLPfozr5eTvyUxwGEs4CNBico3jnsYlKUVFb3IRjhAbHdRb8Oso58smrrXBV0qBrPYheTrAKuHU45rWv/HjmlJIchW+NKu7euMmGKb/mLLlxHxv6ODEJo6LHSSDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509567; c=relaxed/simple;
	bh=pl4eKa1UZ407AuAGYGHmod1d6t/IKp0yCymSrRM5kbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF/d0eqwSN0OYx/LQroMn6SmX+vmRCgGOPsCKHtTeIIjZ5RD9I+WIIShKJ1qhHZaLVx2Z7eZG1fP1zcyBtZTwMhx313OiomkA0WaHHjaGHXtKAaMGou48l+hhG6i3X2vVt5oqQG1FicAPO9b68+/s4Hrxajc1qyl4wOSdeUkuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3503A1042;
	Tue,  4 Jun 2024 06:59:49 -0700 (PDT)
Received: from [10.1.37.57] (e133649.arm.com [10.1.37.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6803F64C;
	Tue,  4 Jun 2024 06:59:22 -0700 (PDT)
Message-ID: <0910b0a4-42ca-4b49-9247-a8ce9dc96fe2@arm.com>
Date: Tue, 4 Jun 2024 14:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>
References: <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240604101107.GO26599@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

On 04/06/2024 11:11, Peter Zijlstra wrote:
> On Mon, Jun 03, 2024 at 08:30:43PM +0100, Luis Machado wrote:
> 
>> Exchanging some information with Hongyan today, he was a bit suspicious of the uclamp
>> behavior with the eevdf complete series applied.
>>
>> Checking the uclamp code, I see we have some refcounting tied to enqueuing/dequeuing
>> of tasks, and the uclamp values are organized in buckets.
>>
>> Just for fun I added a few trace_printk's in uclamp_eff_value, uclamp_rq_inc_id and
>> uclamp_rq_dec_id.
>>
>> Booting up the system with delayed_dequeue disabled and running the benchmark, I
>> see the uclamp bucket management pretty stable. Tasks get added to the uclamp
>> buckets but then get removed. At the end of the benchmark, the uclamp buckets
>> are (almost always) clean of tasks.
>>
>> Enabling delayed dequeue, I can see the uclamp buckets slowly filling up with
>> tasks. At the end of the benchmark, I see uclamp buckets with 30, 40 or 50
>> tasks still. If I do another run, I can see 80, 100 tasks still.
>>
>> I suspect refcounting might be going wrong somewhere due to delayed dequeue
>> tasks, but that's more of a guess right now. Hopefully that is useful
>> information. I'll resume investigation tomorrow.
> 
> Thank you both!!
> 
> Does the below help?
> 
> Note how dequeue_task() does uclamp_rq_dec() unconditionally, which is
> then not balanced in the case below.
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3664,6 +3664,7 @@ static int ttwu_runnable(struct task_str
>   			/* mustn't run a delayed task */
>   			SCHED_WARN_ON(task_on_cpu(rq, p));
>   			enqueue_task(rq, p, ENQUEUE_DELAYED);
> +			uclamp_rq_inc(rq, p);
>   		}
>   		if (!task_on_cpu(rq, p)) {
>   			/*

Further communication with Luis makes me investigate more on uclamp 
bucket leaks.

I added a separate variable uclamp_on_rq in task_struct and WARN when 
the state didn't match. The thing is, without your above fix, the first 
WARN happens on uclamp_rq_inc(), not dec(), which means a task is 
already added to rq uclamp and is somehow added again by mistake.

Because this is a double inc(), your fix won't fix this problem. I added 
the trace here when the double inc() happened, in case you can see 
something.

Juno-r2-Debian login: [  176.010780] ------------[ cut here 
]------------ 
                             [1083/15764]
[  176.015414] WARNING: CPU: 5 PID: 0 at kernel/sched/core.c:1594 
uclamp_rq_inc+0x188/0x1a0 

[  176.023539] Modules linked in: 
 

[  176.026602] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 
6.10.0-rc1-ga946a2b48119-dirty #1034 

[  176.034882] Hardware name: ARM Juno development board (r2) (DT) 
 

[  176.040815] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--) 

[  176.047796] pc : uclamp_rq_inc+0x188/0x1a0 
 

[  176.051903] lr : enqueue_task+0x48/0x70 
 

[  176.055752] sp : ffffffc081fb3de0 
 

[  176.059073] x29: ffffffc081fb3de0 x28: 0000000000000000 x27: 
ffffff8800342300 

[  176.066233] x26: ffffff88084311b8 x25: ffffffc081ed2000 x24: 
ffffffc081ca7008 

[  176.073388] x23: 0000000000000000 x22: 00000000000000c0 x21: 
ffffff897efbbf40 

[  176.080543] x20: ffffff8808431180 x19: 0000000000000049 x18: 
0000000000000408 

[  176.087700] x17: ffffffc8fd301000 x16: ffffffc081fb0000 x15: 
000000000000afc8 

[  176.094857] x14: 0000000000000001 x13: 0000000000000004 x12: 
000000020c8392c2 

[  176.102017] x11: 0000000000000800 x10: 0000000000000800 x9 : 
0000000000000000 

[  176.109177] x8 : 0000000000000001 x7 : 0000000000000021 x6 : 
ffffffffffffff4c 

[  176.116337] x5 : 0000000000007e90 x4 : 00000000000fc33c x3 : 
00000000000139b4 

[  176.123487] x2 : 0000000000000049 x1 : ffffff8808431180 x0 : 
ffffff897efbbf40 

[  176.130639] Call trace: 
 

[  176.133089]  uclamp_rq_inc+0x188/0x1a0 
 

[  176.136849]  activate_task+0x48/0x60 
 

[  176.140433]  ttwu_do_activate+0x80/0x22c 
 

[  176.144364]  sched_ttwu_pending+0x9c/0x120 
 

[  176.148470]  __flush_smp_call_function_queue+0x3d0/0x568 
 

[  176.153792]  generic_smp_call_function_single_interrupt+0x10/0x18 
 

[  176.159902]  do_handle_IPI+0xa0/0x230 
 

[  176.163577]  ipi_handler+0x18/0x24 
 

[  176.166987]  handle_percpu_devid_irq+0x80/0x204 
 

[  176.171532]  generic_handle_domain_irq+0x28/0x40 
 

[  176.176161]  gic_handle_irq+0x58/0xd0 
 

[  176.179833]  call_on_irq_stack+0x24/0x34 
 

[  176.183764]  el1_interrupt+0x70/0xbc 
 

[  176.187348]  el1h_64_irq_handler+0x14/0x1c 
 

[  176.191449]  el1h_64_irq+0x64/0x68 
 

[  176.194857]  arch_local_irq_enable+0x4/0x8 
 

[  176.198960]  cpuidle_enter+0x34/0x48 
 

[  176.202547]  do_idle+0x1c4/0x234 
 

[  176.205786]  cpu_startup_entry+0x30/0x34 
 

[  176.209723]  secondary_start_kernel+0x124/0x144 
 

[  176.214267]  __secondary_switched+0x6c/0x70 
 

[  176.218458] ---[ end trace 0000000000000000 ]---

Or, do you mean to add a uclamp_rq_dec() instead? But even if I skip the 
uclamp_rq_inc() at that line (which is equivalent to doing 
uclamp_rq_dec() after enqueue_task()), I still get a WARN like this:

Juno-r2-Debian login: [   77.183511] ------------[ cut here 
]------------ 

[   77.188157] WARNING: CPU: 2 PID: 114 at kernel/sched/core.c:1594 
uclamp_rq_inc+0x188/0x1a0 

[   77.196455] Modules linked in: 
 

[   77.199519] CPU: 2 PID: 114 Comm: kworker/u25:3 Not tainted 
6.10.0-rc1-ga946a2b48119-dirty #1035 

[   77.208325] Hardware name: ARM Juno development board (r2) (DT) 
 

[   77.214255] Workqueue: rpciod rpc_async_schedule 
 

[   77.218893] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--) 

[   77.225873] pc : uclamp_rq_inc+0x188/0x1a0 
 

[   77.229979] lr : enqueue_task+0x44/0x7c 
 

[   77.233826] sp : ffffffc082af3c80 
 

[   77.237143] x29: ffffffc082af3c80 x28: ffffffc081cd6000 x27: 
0000000000000402 

[   77.244305] x26: ffffffc8fd285000 x25: ffffffc081cbaf40 x24: 
ffffff8800f92300 

[   77.251466] x23: ffffff897ef3ff40 x22: 00000000000000c0 x21: 
ffffff897ef3ff40 

[   77.258625] x20: ffffff88028f3480 x19: 0000000000000009 x18: 
0000000000000000 

[   77.265784] x17: 0000000000000000 x16: 0000000000000001 x15: 
00000000000003ae 

[   77.272943] x14: 000000000003eca5 x13: 000000000003eca5 x12: 
00000000000000eb 

[   77.280102] x11: 0000000000000000 x10: 0000000000001800 x9 : 
0000000000000000 

[   77.287261] x8 : 0000000000000001 x7 : 0000000000000000 x6 : 
000000000000003f 

[   77.294420] x5 : 0000000000000311 x4 : 0000000000000113 x3 : 
000000000000017f 

[   77.301578] x2 : 0000000000000009 x1 : ffffff88028f3480 x0 : 
ffffff897ef3ff40 

[   77.308738] Call trace: 
 

[   77.311185]  uclamp_rq_inc+0x188/0x1a0 
 

[   77.314944]  activate_task+0x48/0x60 
 

[   77.318530]  ttwu_do_activate+0x80/0x22c 
 

[   77.322464]  try_to_wake_up+0x1e8/0x50c 
 

[   77.326311]  wake_up_process+0x14/0x1c 

[   77.330070]  kick_pool+0xb8/0x144 

[   77.333395]  process_one_work+0x104/0x3a4 

[   77.337418]  worker_thread+0x2b8/0x424 

[   77.341176]  kthread+0xf8/0x194 

[   77.344327]  ret_from_fork+0x10/0x20 

[   77.347913] ---[ end trace 0000000000000000 ]---

I pasted the trace here in case useful.

Hongyan


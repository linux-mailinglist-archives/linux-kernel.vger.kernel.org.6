Return-Path: <linux-kernel+bounces-374010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756069A608F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263791F22670
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212AC1E32C6;
	Mon, 21 Oct 2024 09:47:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B8198A0C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504064; cv=none; b=KHicB3Jj95K4VfAUPkIZ6P6odKuzsWHTQzaGO27hDuQcWVj/vf79Hz4NFhUOUuY96W/Un+SXPIU17jFOhHgoklRTNfmy/HXlGD12zl4n6vGl4Li8QZ0UysyXqLPUOOEZyTS649qAEjgap8zGH3hZgIC8fLjKJYXoH861AN5Ctts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504064; c=relaxed/simple;
	bh=oAp3L5CV2bt9dtDS14DNSsb7t3ptWnuakMc+aOTfdVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZzLmxKFQ4WqZ8sMz8cSm0YRvNOVUwP0nT9q+MYuRsaPMlTYieOfTGQutEvtiqtB4Uk0IJ5+X6BTZl5Krg+fWKT2MsDdBBS8QGXMOP6jV10t1JOIPqLF51fhu7FhQBqaW2X2UiRhZ1JMju78m/YSGeqMgiRWXVhSDF+mSvtydDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853EEDA7;
	Mon, 21 Oct 2024 02:48:11 -0700 (PDT)
Received: from [10.34.125.15] (e126645.nice.arm.com [10.34.125.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39C2E3F73B;
	Mon, 21 Oct 2024 02:47:39 -0700 (PDT)
Message-ID: <7dcb39bb-7647-4d54-a28f-4bebdf40b8e9@arm.com>
Date: Mon, 21 Oct 2024 11:47:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: Update blocked averages on tick
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Hongyan Xia <hongyan.xia2@arm.com>,
 Chritian Loehle <christian.loehle@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20241011123222.1282936-1-pierre.gondois@arm.com>
 <20241011123222.1282936-2-pierre.gondois@arm.com>
 <CAKfTPtBo7Kny0r15ik07pMLCjETw7UQo=ypbXww22fMLHzQkgA@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAKfTPtBo7Kny0r15ik07pMLCjETw7UQo=ypbXww22fMLHzQkgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 10/15/24 14:44, Vincent Guittot wrote:
> On Fri, 11 Oct 2024 at 14:32, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> The Energy Aware Scheduler (EAS) relies on CPU/tasks utilization
>> signals. On an idle CPU, the blocked load is updated during
>> load balancing.
>>
>> sd->balance_interval increases with the number of CPUs in the domain.
>> On an Arm DynamIQ system, sched domains containing CPUs with the same
>> capacity do not exist. On a Pixel6 with 4 little, 2 mid, 2 big CPUs:
>> - sd->min_interval = 8
>> - sd->min_interval = 16
>>
>> The balance interval is doubled if the system is balanced, meaning
>> that a balanced system will likely update blocked load every 16ms.
> 
> The real max boundary is LOAD_AVG_PERIOD that is used to update
> nohz.next_blocked. This is the max between 2 updates of blocked load.
> The other ones are opportunistics updates when a normal load balance
> is triggered.

I wanted to mean that on an idle CPU with ticks still on, the cfs_rq load
is only updated through this path:
sched_balance_trigger() {
   if (time_after_eq(jiffies, rq->next_balance))
     raise_softirq(SCHED_SOFTIRQ);
}

...

sched_balance_softirq()
\-sched_balance_update_blocked_averages()

If the next_balance happens every 16ms, this means feec() might operate
its task placement using an (up to) 16ms old util signal. The CPU might
thus look busier than what it actually is.

> 
>>
>> The find_energy_efficient_cpu() function might thus relies on outdated
>> util signals to place tasks, leading to bad energy placement.
> 
> Moving from 8ms to 16 ms is what makes the difference for you ?

With this patch, the cfs_rq signal of an idle CPU is updated every tick,
so every 4ms.

> 
> The LOAD_AVG_PERIOD mas period has been used as a default value but if
> it's too long, we could consider changing the max period between 2
> updates
> 
>>
>> Update blocked load on sched tick if:
>> - the rq is idle
>> - the load balancer will not be triggered.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   kernel/sched/fair.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 225b31aaee55..2f03bd10ac7a 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9841,15 +9841,12 @@ static unsigned long task_h_load(struct task_struct *p)
>>   }
>>   #endif
>>
>> -static void sched_balance_update_blocked_averages(int cpu)
>> +static void update_blocked_averages(struct rq *rq)
>>   {
>>          bool decayed = false, done = true;
>> -       struct rq *rq = cpu_rq(cpu);
>> -       struct rq_flags rf;
>>
>> -       rq_lock_irqsave(rq, &rf);
>> -       update_blocked_load_tick(rq);
>>          update_rq_clock(rq);
>> +       update_blocked_load_tick(rq);
>>
>>          decayed |= __update_blocked_others(rq, &done);
>>          decayed |= __update_blocked_fair(rq, &done);
>> @@ -9857,6 +9854,18 @@ static void sched_balance_update_blocked_averages(int cpu)
>>          update_blocked_load_status(rq, !done);
>>          if (decayed)
>>                  cpufreq_update_util(rq, 0);
>> +}
>> +
>> +static void sched_balance_update_blocked_averages(int cpu)
>> +{
>> +       struct rq *rq = cpu_rq(cpu);
>> +       struct cfs_rq *cfs_rq;
>> +       struct rq_flags rf;
>> +
>> +       cfs_rq = &rq->cfs;
>> +
>> +       rq_lock_irqsave(rq, &rf);
>> +       update_blocked_averages(rq);
>>          rq_unlock_irqrestore(rq, &rf);
>>   }
>>
>> @@ -12877,6 +12886,8 @@ void sched_balance_trigger(struct rq *rq)
>>
>>          if (time_after_eq(jiffies, rq->next_balance))
>>                  raise_softirq(SCHED_SOFTIRQ);
>> +       else if (idle_cpu(rq->cpu))
>> +               update_blocked_averages(rq);
> 
> would be good to explain why you don't need rq lock here

This is a mistake, the lock is indeed required.

> 
> There is no rate limit so we can do this every tick (possibly  1ms)
> when staying in shallowest state

I'm not sure we understood each other as this patch should no be related
to NOHZ CPUs. So please let me know if I used a wrong path as you said,
or if a rate limit would be needed.

> 
> So it's looks better to update the period between 2 update of blocked
> load instead of adding a new path
> 
>>
>>          nohz_balancer_kick(rq);
>>   }
>> --
>> 2.25.1
>>

Regards,
Pierre


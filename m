Return-Path: <linux-kernel+bounces-563134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C4A6375B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFADF7A5C8F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230C1E1DE1;
	Sun, 16 Mar 2025 20:22:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C314E1A08B8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742156528; cv=none; b=fgJLEinx1n6fyaiGC3EIYX/AQp4RMyYn68fdcChSlUORhtvMk9F6YyAaTjd2p1c1gEf+HfBBusMfuCrFCqwTNvyKBN9bJgMlwxN53lF35hzDORYzjNmBToHAoHV9+gjru+bn6rpZr/0Q+t4W5JHiobCKVzdFQZpPopDWwGDTzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742156528; c=relaxed/simple;
	bh=8yOj2yR7LYmL4Pv8j9UTNIDeMexTEJJ+kApyA4aMYL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBUg29N4gxmjmvXk3wa3PNFrHBIihf3f/9sh5cRUltAo1vwdRn0SJ6xbgt4nQon/S6oWgAPomM8dx4DVmct1x4cD1xiEpME9YJWS54uXWX2RSnLLgDsXaHI/1eW2Vf0AB8FjuA/JnRdU3zRAhtDx5ED+j+kP5K4tjwwnWRXOeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4631B113E;
	Sun, 16 Mar 2025 13:22:07 -0700 (PDT)
Received: from [192.168.1.12] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 765153F694;
	Sun, 16 Mar 2025 13:21:54 -0700 (PDT)
Message-ID: <b9e0c546-c560-4d84-bc59-6f9f0df53dc1@arm.com>
Date: Sun, 16 Mar 2025 21:21:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7 v5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 qyousef@layalina.io, hongyan.xia2@arm.com, christian.loehle@arm.com,
 luis.machado@arm.com, qperret@google.com
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-4-vincent.guittot@linaro.org>
 <24bc804e-305f-4273-922a-a24070aa3e56@arm.com>
 <CAKfTPtBO_DYM+HK+wWMvunMzDAzHwYghy4ae7GnyQHRe1A8kZg@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAKfTPtBO_DYM+HK+wWMvunMzDAzHwYghy4ae7GnyQHRe1A8kZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/14/25 17:24, Vincent Guittot wrote:
> On Wed, 12 Mar 2025 at 15:09, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Hello Vincent,
>>
>> On 3/2/25 22:05, Vincent Guittot wrote:
>>> feec() looks for the CPU with highest spare capacity in a PD assuming that
>>> it will be the best CPU from a energy efficiency PoV because it will
>>> require the smallest increase of OPP. Although this is true generally
>>> speaking, this policy also filters some others CPUs which will be as
>>> efficients because of using the same OPP.
>>> In fact, we really care about the cost of the new OPP that will be
>>> selected to handle the waking task. In many cases, several CPUs will end
>>> up selecting the same OPP and as a result using the same energy cost. In
>>> these cases, we can use other metrics to select the best CPU for the same
>>> energy cost.
>>>
>>> Rework feec() to look 1st for the lowest cost in a PD and then the most
>>> performant CPU between CPUs. The cost of the OPP remains the only
>>> comparison criteria between Performance Domains.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>    kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
>>>    1 file changed, 246 insertions(+), 220 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index d3d1a2ba6b1a..a9b97bbc085f 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>
>> [...]
>>
>>> +static bool update_best_cpu(struct energy_cpu_stat *target,
>>> +                         struct energy_cpu_stat *min,
>>> +                         int prev, struct sched_domain *sd)
>>>    {
>>> -     unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
>>> -     unsigned long busy_time = eenv->pd_busy_time;
>>> -     unsigned long energy;
>>> -
>>> -     if (dst_cpu >= 0)
>>> -             busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
>>> +     /*  Select the one with the least number of running tasks */
>>> +     if (target->nr_running < min->nr_running)
>>> +             return true;
>>> +     if (target->nr_running > min->nr_running)
>>> +             return false;
>>>
>>> -     energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
>>> +     /* Favor previous CPU otherwise */
>>> +     if (target->cpu == prev)
>>> +             return true;
>>> +     if (min->cpu == prev)
>>> +             return false;
>>>
>>> -     trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
>>> +     /*
>>> +      * Choose CPU with lowest contention. One might want to consider load
>>> +      * instead of runnable but we are supposed to not be overutilized so
>>> +      * there is enough compute capacity for everybody.
>>> +      */
>>
>> I'm not sure I understand the comment. With UCLAMP_MAX tasks, a CPU can lack
>> compute capacity while not being tagged as overutilized. IIUC this is actually
>> the goal of UCLAMP_MAX.
> 
> the uclamp_max says that the task doesn't need more than a compute
> capacity of 1 so there is no lack

If UCLAMP_MAX was a bandwidth hint and the task was requesting 1/1024 ~= 0.1%
of the bandwidth, then effectively there would be no lack.
However if this is a performance hint, then the CPU will run at the lowest
available performance level of the CPU. I don't think there is any guarantee
on the bandwidth in that case.

> 
>>
>> With the following workload:
>> - 2 tasks A with duty_cycle=30%, UCLAMP_MIN/MAX=(0,1), niceness=0
>> - 2 tasks B with duty_cycle=70%, UCLAMP_MIN/MAX=(0,1), niceness=-10
> 
> Does the duty cycle make any difference here ? they won't be able to
> run 30% or 70% anyway because of their uclamp_max, will they ?

No indeed, this will make no difference.

> 
>> The workload runs on a Pixel6 with a reduced cpuset of [1,2,7], i.e. 2 little
>> CPUs (1,2) capa=160 and one big CPU (7) capa=1024.
>> CPU7 is avoided by the tasks as their UCLAMP_MAX setting make them fit on the
>> little CPUs.
>>
>> select_best_cpu() prefers to place tasks based on nr_running. If the 2 tasks A
>> end up being placed on one little CPU, and the 2 tasks B are placed on the
>> other little CPU, feec() is theoretically unable to balance the workload.
> 
> They will all have 80 compute capacity which is more than their uclamp_max= 1

Cf. above, if UCLAMP_MAX is a performance hint, then there should be no guarantee
on the received bandwidth. If we take the same example with UCLAMP_MAX=81, then
this should still hold. However the received bandwidth will be of 80 util.

(Small note that with UCLAMP_MAX=1, the little CPUs should run at a performance
level lower than 160. But the example should still hold if the little CPUs only
have one OPP at 160.)

------

To go further in that direction, balancing with the number of tasks + runnable
seems like a similar version of the load balancer's group_overloaded case. We're
trying to share the bandwidth equally among UCLAMP_MAX tasks, but without taking
into account the niceness of tasks.
EAS didn't have to handle the case of compute capacity shortage until UCLAMP_MAX
came in: EAS was only active when there was enough compute capacity due to the
overutilized threshold.

Doing load balancing among UCLAMP_MAX tasks in feec() seems like a complex
exercise: what if the pd topology is: 2 little CPUs + 2 little CPUs + 1 big CPU.
AFAICS, UCLAMP_MAX tasks could all start on one of the little CPUs' pd and never
be balanced toward the second little CPU's pd as we are looking for the CPU with
the lowest #tasks inside one pd (assuming that all little CPUs are running at
the same, lowest OPP).

> 
>> In practice, a kworker ends up spawning on one of these 2 little CPUs and tasks
>> are shuffled, so the pattern breaks after ~30ms.
>>
>> This pattern seems problematic as tasks A are:
>> - smaller (30% < 70%)
>> - nicer (0 > -10)
>> than tasks B. So I assume the correct task placement should be one task of each
>> type on each little CPU.
>>
>> ------
>>
>> There are some comments in the load balancer code:
>> 1.
>> /* Computing avg_load makes sense only when group is overloaded */
>> 2.
>> /*
>> * Computing avg_load makes sense only when group is fully busy or
>> * overloaded
>> */
>>
>> IIUC, the load is only meaningful when there is not enough compute capacity
>> to estimate the task size, otherwise util_avg makes more sense. It seems that
>> when it comes to UCLAMP_MAX task, CPUs are placed in this exact situation:
>> load_avg makes more sense that util_avg.
>> However, in this situation, energy computations also lose sense since they
>> are based on the util_avg values.
>>
>> ------
>>
>> select_best_cpu() could check the CPU load before checking nr_running, but it
>> would be meaningless if there is enough CPU time for all the tasks.
>>
>> Maybe CPU load should then be checked only if the system doesn't have enough
>> CPU time. But this would be equivalent to:
>> - remove UCLAMP_MAX in cpu_overutilized()
>> - when the system is overutilized (no UCLAMP_MAX involved), go back to the
>>     load balancer
>>
>> In other words, I don't really see how it is possible to reconciliate UCLAMP_MAX
>> tasks with EAS as EAS relies on util_avg values, and UCLAMP_MAX forces to
>> rely on load_avg value rather than util_avg.
>>
>> Regards,
>> Pierre
>>
>>
>>> +     if ((target->runnable * min->capa * sd->imbalance_pct) >=
>>> +                     (min->runnable * target->capa * 100))
>>> +             return false;
>>>
>>> -     return energy;
>>> +     return true;
>>>    }


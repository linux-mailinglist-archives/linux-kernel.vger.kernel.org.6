Return-Path: <linux-kernel+bounces-433653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E69E5B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DB716883A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5111F21D595;
	Thu,  5 Dec 2024 16:23:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7F2F29
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415833; cv=none; b=emm0tJROatDI908vG3/cBMV1stpWjpRQplqFFlgt+FAb/Q9CjdMRhTZqo8TjOuA9XFlnrOZQ6aa0afNK9YGXvyontrp7gihu/zk+BYNKk3CXO07tXlMVeV0jzm3QPbjfEpXogd5/PEp5xRViMBXd6uQSDOOohLUQp3ulGNmmHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415833; c=relaxed/simple;
	bh=nScCYoYh8ZIYGoSYEtfbkhZQvZzPo/nZrdIdIxjLA54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE/HL35mcAYpPBIYFNpwTz+XnVhw7CH/Q6yKVO9diSk9mJZmWCJce+26f3ry/VuqfUQVr9Vr7Cq+4kqV4Tj0zJLV07IbGIomCpBUfiItO2lqKkp0DQZtjhXwdlBNrmGPEWE1mcAxCRSXrF0Hu3O9vfDwFwOpzNWSHWNabOdEl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246B11063;
	Thu,  5 Dec 2024 08:24:18 -0800 (PST)
Received: from [10.57.70.49] (unknown [10.57.70.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74A173F5A1;
	Thu,  5 Dec 2024 08:23:46 -0800 (PST)
Message-ID: <ed7aaf8a-a00f-4fcd-a15f-abbb439c4f03@arm.com>
Date: Thu, 5 Dec 2024 17:23:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 qyousef@layalina.io, hongyan.xia2@arm.com,
 Christian Loehle <Christian.Loehle@arm.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org>
 <52274486-b385-4080-9938-399d601fe892@arm.com>
 <CAKfTPtD3skwkhRUNOnfheK+bUxYgXvPQT-RWT_SQ+C3uK4kS8w@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAKfTPtD3skwkhRUNOnfheK+bUxYgXvPQT-RWT_SQ+C3uK4kS8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 9/12/24 14:22, Vincent Guittot wrote:
> On Wed, 11 Sept 2024 at 16:03, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Hello Vincent,
>>
>> On 8/30/24 15:03, Vincent Guittot wrote:
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
>>> performant CPU between CPUs.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>    kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
>>>    1 file changed, 244 insertions(+), 222 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e67d6029b269..2273eecf6086 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>
>> [snip]
>>
>>>
>>> -/*
>>> - * compute_energy(): Use the Energy Model to estimate the energy that @pd would
>>> - * consume for a given utilization landscape @eenv. When @dst_cpu < 0, the task
>>> - * contribution is ignored.
>>> - */
>>> -static inline unsigned long
>>> -compute_energy(struct energy_env *eenv, struct perf_domain *pd,
>>> -            struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
>>> +/*Check if the CPU can handle the waking task */
>>> +static int check_cpu_with_task(struct task_struct *p, int cpu)
>>>    {
>>> -     unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
>>> -     unsigned long busy_time = eenv->pd_busy_time;
>>> -     unsigned long energy;
>>> +     unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
>>> +     unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
>>> +     unsigned long util_min = p_util_min;
>>> +     unsigned long util_max = p_util_max;
>>> +     unsigned long util = cpu_util(cpu, p, cpu, 0);
>>> +     struct rq *rq = cpu_rq(cpu);
>>>
>>> -     if (dst_cpu >= 0)
>>> -             busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
>>
>> I think you should mention that the energy computation is not capped anymore.
>> It used to be:
>> pd_util: sum of the CPU's util for the pd considered, without task_util
>> pd_cap: sum of the CPU's capacity for the pd
>>
>> (a)
>> busy_time = min(pd_cap, pd_util);
>> prev_energy = busy_time * OPP[prev_max_util].cost;
>>
>> busy_time = min(pd_cap, pd_util + task_util);
>> new_energy = busy_time * OPP[new_max_util].cost;
>>
>> delta_energy = new_energy - prev_energy;
>>
>> Note that when computing busy_time, task_util is not capped to one CPU's
>> max_cap. This means that in empty pd, a task can 'steal' capacity from
>> CPUs during the energy computation.
>> Cf. [1]
>>
>> and it is now:
>> (b)
>> delta_energy = task_util * OPP[new_max_util].cost;
>> delta_energy += pd_util * (OPP[new_max_util].cost - OPP[prev_max_util].cost);
>>
>> Note that the busy_time (task_util + pd_util) is now not capped by anything.
> 
> As discussed in [1], capping utilization with max capacity is a
> mistake because we lost  the information that this will run longer
> 


I think this comes down to the fact that uClampMax tasks are force fit into
CPUs that don't have the required spare capacity [1].

On a little CPU with a capacity=200, a task with util=600 will run longer,
but it will eventually finish. Such task should not fit a little CPU normally.
By setting the task with UCLAMP_MAX=100, the task now fits the little CPU
and consumes less energy.

As Quentin mentioned I think, EAS can place tasks if utilization values are
correct. The initial condition was to have a 20% margin on the CPU capacity,
but it seems the intent was more to detect situations where the CPU is always
running (i.e. no idle time anymore).

With [1], having a 20% margin (with uClampMax tasks) doesn't mean that there
is idle time anymore. When there is no idle time anymore, utilization values
are a reflection of the niceness of the task. I.e. the utilization represents
how much time the CFS scheduler allowed them to run rather than how much
compute power tasks require.

------- Example start -------

In this condition, EAS should not be able to make always accurate task
placements. For instance, on a platform with 1 big CPU (capa=1024) and one
little CPU (capa=200), and with X tasks such as:
- duty-cycle=60%
- UCLAMP_MAX=800
Tasks being CPU demanding, they are placed on the big CPU. Each task will have
a utilization of 1024/X. The system is not overutilized since tasks have
a UCLAMP_MAX setting.
The bigger X, the lower the task utilization. Eventually, tasks' utilization
will be low enough to have feec() migrating one of them to the little CPU.
The system then becomes overutilized.

With the present patchset, the task is migrated back to the big CPU. Indeed:
task_tick_fair()
\-check_update_overutilized_status() --> // setting overutilzed=1
\-check_misfit_cpu()
   \-find_energy_efficient_cpu()      --> task doesn't fit the little CPU anymore,
                                      --> migrate back to the big CPU
                                      --> // resetting overutilzed=0 later

So these UCLAMP_MAX tasks will bounce on the little CPU, transiently activating
the overutilized state.

Similarly, when there is no idle time, it is possible to play with the task
niceness to make the utilization smaller/bigger.

------- Example end -------

This behaviour was existing before this present patchset due to [1]. However,
it was not really visible since feec() only ran during task wakeup.

It seems that the condition in update_idle_rq_clock_pelt() would be a better
way to tag a CPU as overutilized.

Down migrating UCLAMP_MAX tasks makes sense IMO, but to avoid making a CPU
overutilized, throttling these tasks (like the bandwidth control seems to do)
could be a solution.

[1] https://lore.kernel.org/lkml/20220629194632.1117723-1-qais.yousef@arm.com/

Regards,
Pierre


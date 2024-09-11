Return-Path: <linux-kernel+bounces-325091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB89754E8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE8DB23ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F84193092;
	Wed, 11 Sep 2024 14:03:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E69187353
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063388; cv=none; b=r8xLImmK+44VgPNPyIM01ximCHryOjMhg3o8FTwZMebjyNvRUjkhSIn3jow2R2X3xUat6LU0W+xTdwHCrjxKnkmdaGRlziznFDd9UaV5LFZjCPGEFy7hbdTd5v1T3mb0107XIEdmLyF3neh0t2zLwqw3r8L7a1pQs1cszvhKl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063388; c=relaxed/simple;
	bh=lSLK95eQ5zd6nCz0OA3UzoXkRZ8ZkdonIEHxa4KZwqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwKMyF8zCBAVTDgbIjbtdLysT94hn3/JkErRJ+VZGEHauKM2MF4iLUIEZSwkbOCreni64ymHQVkUgyyRnlqKP4WTJpJ/S4m1ExjZI5pYPMLAhp2bL5HKS7FljOMyl4/G+e0ttTwDLc9gKsMlHqfwHc8Zpv4zKNnzqJYSAnymE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 050861007;
	Wed, 11 Sep 2024 07:03:34 -0700 (PDT)
Received: from [10.57.74.218] (unknown [10.57.74.218])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6750B3F73B;
	Wed, 11 Sep 2024 07:03:01 -0700 (PDT)
Message-ID: <52274486-b385-4080-9938-399d601fe892@arm.com>
Date: Wed, 11 Sep 2024 16:02:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240830130309.2141697-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 8/30/24 15:03, Vincent Guittot wrote:
> feec() looks for the CPU with highest spare capacity in a PD assuming that
> it will be the best CPU from a energy efficiency PoV because it will
> require the smallest increase of OPP. Although this is true generally
> speaking, this policy also filters some others CPUs which will be as
> efficients because of using the same OPP.
> In fact, we really care about the cost of the new OPP that will be
> selected to handle the waking task. In many cases, several CPUs will end
> up selecting the same OPP and as a result using the same energy cost. In
> these cases, we can use other metrics to select the best CPU for the same
> energy cost.
> 
> Rework feec() to look 1st for the lowest cost in a PD and then the most
> performant CPU between CPUs.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
>   1 file changed, 244 insertions(+), 222 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e67d6029b269..2273eecf6086 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[snip]

>   
> -/*
> - * compute_energy(): Use the Energy Model to estimate the energy that @pd would
> - * consume for a given utilization landscape @eenv. When @dst_cpu < 0, the task
> - * contribution is ignored.
> - */
> -static inline unsigned long
> -compute_energy(struct energy_env *eenv, struct perf_domain *pd,
> -	       struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
> +/*Check if the CPU can handle the waking task */
> +static int check_cpu_with_task(struct task_struct *p, int cpu)
>   {
> -	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> -	unsigned long busy_time = eenv->pd_busy_time;
> -	unsigned long energy;
> +	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
> +	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> +	unsigned long util_min = p_util_min;
> +	unsigned long util_max = p_util_max;
> +	unsigned long util = cpu_util(cpu, p, cpu, 0);
> +	struct rq *rq = cpu_rq(cpu);
>   
> -	if (dst_cpu >= 0)
> -		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);

I think you should mention that the energy computation is not capped anymore.
It used to be:
pd_util: sum of the CPU's util for the pd considered, without task_util
pd_cap: sum of the CPU's capacity for the pd

(a)
busy_time = min(pd_cap, pd_util);
prev_energy = busy_time * OPP[prev_max_util].cost;

busy_time = min(pd_cap, pd_util + task_util);
new_energy = busy_time * OPP[new_max_util].cost;

delta_energy = new_energy - prev_energy;

Note that when computing busy_time, task_util is not capped to one CPU's
max_cap. This means that in empty pd, a task can 'steal' capacity from
CPUs during the energy computation.
Cf. [1]

and it is now:
(b)
delta_energy = task_util * OPP[new_max_util].cost;
delta_energy += pd_util * (OPP[new_max_util].cost - OPP[prev_max_util].cost);

Note that the busy_time (task_util + pd_util) is now not capped by anything.

---

Not capping the task_util is discussed in [1][3] and [2] (at 21:15).
IIUC, UCLAMP_MAX tasks are the only case leveraging this. Indeed,
non-clamped tasks will not fit and be placed on a bigger CPU. Same for
UCLAMP_MIN tasks.
FWIU, not capping the utilization of tasks during the energy computation
allows to reflect that a task will (likely) run longer. However the
task's performance would likely decrease as the other tasks on the target
CPU are not taken into account (it is assumed the task to be placed will
receive the compute power it requires).

---
Case A:

Assuming we have an empty system with:
- 4 little CPUs (max_capa=512, first OPP as [capa=256, cost=10])
- 2 big CPUs (max_capa=1024, first OPP as [capa=512, cost=10])
i.e. the first OPP of all the CPU consumes the same amount of energy.
And a task with: [UCLAMP_MIN=0, UCLAMP_MAX=10, util = 1000]

Then feec() would have no reason to prefer a big CPU over a little CPU,
even though the big CPU would provide more performance.

---
Case B:

(This is not especially related to this patch.)
Another case that might be problematic:
- 4 little CPUs (max_capa=512, first OPP as [capa=256])
- 2 big CPUs (max_capa=1024, first OPP as [capa=512])
- little CPUs consume less than big CPUs, but the highest OPP
   of the little CPUs consume more than the lowest of the big CPUs.
And tasks:
- 3 tasks with [UCLAMP_MIN=0, UCLAMP_MAX=10, util = 1000]
- 1 task with [UCLAMP_MIN=0, UCLAMP_MAX=1024, util = 50]

Then
- the 3 UCLAMP_MAX tasks will be placed on the little CPUs. Indeed,
   due to the last patch of the serie, these tasks have now an opportunity
   to run feec() and be placed on a more energy efficient CPU.
- the 'normal' task will be placed on a big CPU. Indeed, placing
   it on a little CPU would raise the OPP of the little cluster.

This means that the 'normal' task is prevented to run the remaining little
CPU even though:
- the little CPU can provide the compute capacity
- the little CPU would consume less energy

In other terms, using UCLAMP_MAX on some tasks makes the system consume
more energy.

---

In my opinion, this last case comes from the difficulty of defining UCLAMP_MAX.
 From sched-util-clamp.rst (about UCLAMP_MAX):
- Uclamp is a hinting mechanism that allows the scheduler to understand the
   performance requirements and restrictions of the tasks
- The right way to view util clamp is as a mechanism to make request or hint on
   performance constraints.
- some tasks should be restricted from consuming too
   much resources and should not go above a specific performance point.
-
Another example is in Android where tasks are classified as background,
foreground, top-app, etc. Util clamp can be used to constrain how much
resources background tasks are consuming by capping the performance point they
can run at. This constraint helps reserve resources for important tasks, like
the ones belonging to the currently active app (top-app group). Beside this
helps in limiting how much power they consume. This can be more obvious in
heterogeneous systems (e.g. Arm big.LITTLE); the constraint will help bias the
background tasks to stay on the little cores which will ensure that:

         1. The big cores are free to run top-app tasks immediately. top-app
            tasks are the tasks the user is currently interacting with, hence
            the most important tasks in the system.
         2. They don't run on a power hungry core and drain battery even if they
            are CPU intensive tasks.
-
For example, it can be handy to limit performance when running low on battery
or when the system wants to limit access to more energy hungry performance
levels when it's in idle state or screen is off.

"""
This constraint helps reserve resources for important tasks, like
the ones belonging to the currently active app (top-app group).
"""
It doesn't seem that UCLAMP_MAX does this. This looks more like bandwidth
control.

"""
They don't run on a power hungry core and drain battery even if they
are CPU intensive tasks.
"""
Avoiding mid/big CPUs could be done with tasksets,

I can understand that one might want to run a task at a higher OPP due to
timing constraints for instance. However I don't see why someone would want
to run a task at a lower OPP, regarding only the performance and not the
energy consumption. It thus means that UCLAMP_MAX is an energy hint rather
of a performance hint.

UCLAMP_MAX could be set for a task to make it spend less energy, but the
loss in performance would be unknown.
A case Hongyan mentioned in his uclamp sum aggregation serie [4] is that
an infinite task with [UCLAMP_MIN=0, UCLAMP_MAX=1, util = 1000] could fit
in a little CPU. The energy consumption would indeed be very low, but the
performance would also be very low.

With Hongyan's sum aggregation serie [5]:
- case B would not happen as the 'normal' task would not raise the OPP of
   the whole cluster.
- the 'infinite UCLAMP_MAX tasks' case would not happen as each task would
   account for 1 util
- case A would still happen, but could be solved in any case.

I know Hongyan's patchset has already been discussed, but I still don't
understand why max aggregation is preferred over sum aggregation.
The definition of UCLAMP_MAX values seems clearer and in effect results in
a simpler implementation and less corner cases. In simple words:
"When estimating the CPU frequency to set, for this task,
account for at most X util."
rather than:
"When estimating the CPU frequency to set, the task with the highest
UCLAMP_MAX of the CPU will cap the requested frequency."

Note that actually I think it's a good idea to run feec() regularly
and to take into account other parameters like nr_running. I just think
that UCLAMP_MAX's max aggregation creates corner cases that are difficult
to solve altogether.

Thanks in advance for the time you will take answering,
Regards,
Pierre

[1] https://lore.kernel.org/all/20240606070645.3295-1-xuewen.yan@unisoc.com/
[2] https://www.youtube.com/watch?v=PHEBAyxeM_M
[3] https://lore.kernel.org/all/CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com/
[4] https://lore.kernel.org/all/b81a5b1c-14de-4232-bee9-ee647355dd8c@arm.com/
[5] https://lore.kernel.org/all/cover.1706792708.git.hongyan.xia2@arm.com/#t


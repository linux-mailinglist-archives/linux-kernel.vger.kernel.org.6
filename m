Return-Path: <linux-kernel+bounces-557856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FBA5DEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F0C1883AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA2B24CEEA;
	Wed, 12 Mar 2025 14:09:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63016245013
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788547; cv=none; b=gwjdBmCustE+EkGi49SOPD7kXFxrp8P7t+O3FaJu1W2kXMv8v3tP/eBDcHF8IQqhrXRTjVhfLP2c36gbu7BXKCU7zs5SAUpwWKRgydgGDAanF//4TXnfLyUvF3PHEx7/Q/MXR1IqMZyPPwoSca26NXchyvApLD7a3ZgfjBfdrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788547; c=relaxed/simple;
	bh=xTbMTL7WEs0BFVycF0m7F9W9YWnDQyVH/eFGlm0GWwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+ab+HWke+rMTdhi7beGpWo+Csg7gQX4EBNw9PuElUG35I0EUQ9IMRf2OQ7ehcdAfJBlXN8skcPV6GV7qj2Fh5f9uHopLhUSlQoOgeRQv4CEGvt3lMWhEqqPmdUV0jXFQat1Qy7LoU6/Y3HHxh3VrL884rdfAIyIUhR6/YAKmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D65F152B;
	Wed, 12 Mar 2025 07:09:11 -0700 (PDT)
Received: from [10.34.111.154] (e126645.nice.Arm.com [10.34.111.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E7533F5A1;
	Wed, 12 Mar 2025 07:08:57 -0700 (PDT)
Message-ID: <24bc804e-305f-4273-922a-a24070aa3e56@arm.com>
Date: Wed, 12 Mar 2025 15:08:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7 v5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, christian.loehle@arm.com,
 luis.machado@arm.com, qperret@google.com
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-4-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20250302210539.1563190-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 3/2/25 22:05, Vincent Guittot wrote:
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
> performant CPU between CPUs. The cost of the OPP remains the only
> comparison criteria between Performance Domains.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
>   1 file changed, 246 insertions(+), 220 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d3d1a2ba6b1a..a9b97bbc085f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[...]

> +static bool update_best_cpu(struct energy_cpu_stat *target,
> +			    struct energy_cpu_stat *min,
> +			    int prev, struct sched_domain *sd)
>   {
> -	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> -	unsigned long busy_time = eenv->pd_busy_time;
> -	unsigned long energy;
> -
> -	if (dst_cpu >= 0)
> -		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
> +	/*  Select the one with the least number of running tasks */
> +	if (target->nr_running < min->nr_running)
> +		return true;
> +	if (target->nr_running > min->nr_running)
> +		return false;
>   
> -	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> +	/* Favor previous CPU otherwise */
> +	if (target->cpu == prev)
> +		return true;
> +	if (min->cpu == prev)
> +		return false;
>   
> -	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
> +	/*
> +	 * Choose CPU with lowest contention. One might want to consider load
> +	 * instead of runnable but we are supposed to not be overutilized so
> +	 * there is enough compute capacity for everybody.
> +	 */

I'm not sure I understand the comment. With UCLAMP_MAX tasks, a CPU can lack
compute capacity while not being tagged as overutilized. IIUC this is actually
the goal of UCLAMP_MAX.

With the following workload:
- 2 tasks A with duty_cycle=30%, UCLAMP_MIN/MAX=(0,1), niceness=0
- 2 tasks B with duty_cycle=70%, UCLAMP_MIN/MAX=(0,1), niceness=-10
The workload runs on a Pixel6 with a reduced cpuset of [1,2,7], i.e. 2 little
CPUs (1,2) capa=160 and one big CPU (7) capa=1024.
CPU7 is avoided by the tasks as their UCLAMP_MAX setting make them fit on the
little CPUs.

select_best_cpu() prefers to place tasks based on nr_running. If the 2 tasks A
end up being placed on one little CPU, and the 2 tasks B are placed on the
other little CPU, feec() is theoretically unable to balance the workload.
In practice, a kworker ends up spawning on one of these 2 little CPUs and tasks
are shuffled, so the pattern breaks after ~30ms.

This pattern seems problematic as tasks A are:
- smaller (30% < 70%)
- nicer (0 > -10)
than tasks B. So I assume the correct task placement should be one task of each
type on each little CPU.

------

There are some comments in the load balancer code:
1.
/* Computing avg_load makes sense only when group is overloaded */
2.
/*
* Computing avg_load makes sense only when group is fully busy or
* overloaded
*/

IIUC, the load is only meaningful when there is not enough compute capacity
to estimate the task size, otherwise util_avg makes more sense. It seems that
when it comes to UCLAMP_MAX task, CPUs are placed in this exact situation:
load_avg makes more sense that util_avg.
However, in this situation, energy computations also lose sense since they
are based on the util_avg values.

------

select_best_cpu() could check the CPU load before checking nr_running, but it
would be meaningless if there is enough CPU time for all the tasks.

Maybe CPU load should then be checked only if the system doesn't have enough
CPU time. But this would be equivalent to:
- remove UCLAMP_MAX in cpu_overutilized()
- when the system is overutilized (no UCLAMP_MAX involved), go back to the
   load balancer

In other words, I don't really see how it is possible to reconciliate UCLAMP_MAX
tasks with EAS as EAS relies on util_avg values, and UCLAMP_MAX forces to
rely on load_avg value rather than util_avg.

Regards,
Pierre


> +	if ((target->runnable * min->capa * sd->imbalance_pct) >=
> +			(min->runnable * target->capa * 100))
> +		return false;
>   
> -	return energy;
> +	return true;
>   }


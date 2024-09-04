Return-Path: <linux-kernel+bounces-315371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207A96C1C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07281B22A35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDF1DCB07;
	Wed,  4 Sep 2024 15:07:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272CDDCD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462442; cv=none; b=sXCYMoLUPluxe1Oh2LgGfmBxV5n7WMWQMLevgrSv6RfkQQLEWAlos/En63Q9g7pwCTOFhNjU6ZSiO4PUNISjopSu1mUKp2N/g+gSyOfas1yoZdHHmbGujT2QlWWcL7h+DxzYkIVLjDybIi+qpG5Py0nGyz5YlP8608vJ20WxuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462442; c=relaxed/simple;
	bh=VC1zM/aX0T1GFC2qC5H4DS84+Tz6GAaLaLkOLyEfq7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU4+A0jK8D0K2178PE5qOPxRuz1IrdioZvuqqN4d+G3Mk4xZHS97EYvgoYsZ0+jhTcCXm6wwklegz3n/wcuE0pD3Ay5Ahwix/DdGXvmM6hrEGal/ezeuTtNsQJav1Q+ncaA5UeiiAild8iOcSqiAw0qqVxkAyXQ65bkK2TUe+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C50FEC;
	Wed,  4 Sep 2024 08:07:45 -0700 (PDT)
Received: from [192.168.1.12] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 042A23F73F;
	Wed,  4 Sep 2024 08:07:16 -0700 (PDT)
Message-ID: <4b5a6038-3b1e-4983-814b-280938173a2d@arm.com>
Date: Wed, 4 Sep 2024 17:07:15 +0200
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
> +	/*
> +	 * Skip CPUs that cannot satisfy the capacity request.
> +	 * IOW, placing the task there would make the CPU
> +	 * overutilized. Take uclamp into account to see how
> +	 * much capacity we can get out of the CPU; this is
> +	 * aligned with sched_cpu_util().
> +	 */
> +	if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
> +		unsigned long rq_util_min, rq_util_max;
> +		/*
> +		 * Open code uclamp_rq_util_with() except for
> +		 * the clamp() part. I.e.: apply max aggregation
> +		 * only. util_fits_cpu() logic requires to
> +		 * operate on non clamped util but must use the
> +		 * max-aggregated uclamp_{min, max}.
> +		 */
> +		rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
> +		rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
> +		util_min = max(rq_util_min, p_util_min);
> +		util_max = max(rq_util_max, p_util_max);
> +	}
> +	return util_fits_cpu(util, util_min, util_max, cpu);
> +}
>   
> -	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);

I think em_cpu_energy() would need to be removed with this patch,
if there are no more references to it.



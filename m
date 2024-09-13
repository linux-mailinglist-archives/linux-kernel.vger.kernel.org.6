Return-Path: <linux-kernel+bounces-328539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A297857B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84BFB23164
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6E61FEA;
	Fri, 13 Sep 2024 16:08:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB3D502
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243717; cv=none; b=C4zeQZRpMX7QBQZ4SV95kqzNmln+sKTqprl4ME8XSP+QNRCaCtBY4It57+L8SaO94f9aZojCFXVS1gQ83DPC5Hd5fXW5KAquX5HT6MhCw6STaAYJ2n/yFbHzPUd/AERtHxL5/HSTJxxOpqRu3lV/QOGaGouABX3IAf6e5X3dZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243717; c=relaxed/simple;
	bh=mvzHZFx08U2Gg1mtWil1Pm8x0VrHAl+uYWoMf5StAxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2zG0FQSYK27pguEG/cHIqqDfl0Y2qudqD9k+xLzX4v0bPOm31+18KyOhEUckZOLG+hE/Fzk+q68seAbX60g3B4D/sDscDW7zKTmzqvaGc8JZau/NK9iZ4avsI6thODf03ijKz1WhNW6SLyXarH8oFT/NMqeSHWwaYXVo8Gw7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 460B713D5;
	Fri, 13 Sep 2024 09:09:03 -0700 (PDT)
Received: from [10.57.75.215] (unknown [10.57.75.215])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80143F64C;
	Fri, 13 Sep 2024 09:08:29 -0700 (PDT)
Message-ID: <ff2be1d5-ace4-4d8a-9894-4ccc16c84d06@arm.com>
Date: Fri, 13 Sep 2024 18:08:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-6-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240830130309.2141697-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 8/30/24 15:03, Vincent Guittot wrote:
> EAS is based on wakeup events to efficiently place tasks on the system, but
> there are cases where a task will not have wakeup events anymore or at a
> far too low pace. For such situation, we can take advantage of the task
> being put back in the enqueued list to check if it should be migrated on
> another CPU. When the task is the only one running on the CPU, the tick
> will check it the task is stuck on this CPU and should migrate on another
> one.
> 
> Wake up events remain the main way to migrate tasks but we now detect
> situation where a task is stuck on a CPU by checking that its utilization
> is larger than the max available compute capacity (max cpu capacity or
> uclamp max setting)
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c  | 211 +++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/sched.h |   2 +
>   2 files changed, 213 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e46af2416159..41fb18ac118b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[...]

> +
> +static inline void check_misfit_cpu(struct task_struct *p, struct rq *rq)
> +{
> +	int new_cpu, cpu = cpu_of(rq);
> +
> +	if (!sched_energy_enabled())
> +		return;
> +
> +	if (WARN_ON(!p))
> +		return;
> +
> +	if (WARN_ON(p != rq->curr))
> +		return;
> +
> +	if (is_migration_disabled(p))
> +		return;
> +
> +	if ((rq->nr_running > 1) || (p->nr_cpus_allowed == 1))

If the goal is to detect tasks that should be migrated to bigger CPUs,
couldn't the check be changed from:
-  (p->nr_cpus_allowed == 1)
to
- (p->max_allowed_capacity == arch_scale_cpu_capacity(cpu))
to avoid the case where a task is bound to the little cluster for instance ?

Similar question for update_misfit_status(), doesn't:
- (arch_scale_cpu_capacity(cpu) == p->max_allowed_capacity)
include this case:
- (p->nr_cpus_allowed == 1)


> +		return;
> +
> +	if (!task_misfit_cpu(p, cpu))
> +		return;

task_misfit_cpu() intends to check whether the task will have an opportunity
to run feec() though wakeups/push-pull.

Shouldn't we check whether the task fits the CPU with the 20% margin
with task_fits_cpu() aswell ? This would allow to migrate the task
faster than the load_balancer.


> +
> +	new_cpu = find_energy_efficient_cpu(p, cpu);
> +
> +	if (new_cpu == cpu)
> +		return;
> +
> +	/*
> +	 * ->active_balance synchronizes accesses to
> +	 * ->active_balance_work.  Once set, it's cleared
> +	 * only after active load balance is finished.
> +	 */
> +	if (!rq->active_balance) {
> +		rq->active_balance = 1;
> +		rq->push_cpu = new_cpu;
> +	} else
> +		return;
> +
> +	raw_spin_rq_unlock(rq);
> +	stop_one_cpu_nowait(cpu,
> +		active_load_balance_cpu_stop, rq,
> +		&rq->active_balance_work);
> +	raw_spin_rq_lock(rq);
> +}
> +

Regards,
Pierre


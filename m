Return-Path: <linux-kernel+bounces-328249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E897810B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEF1C21390
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177601DA63A;
	Fri, 13 Sep 2024 13:22:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160011DA62D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233722; cv=none; b=BOoc6Y86f6zWjMNOMYtw4caF66cGoGHYGxiRCdgs68yPC0KSpbXUD5cYiyNqJRDg5D4azINX8lHkP58s22/BuEze6C6+XOEE0j3ZREs4prGw51YUeiwHInmy2YUzDNysZMylzO39JOSzZyJ+NTRVu8xiLGfm1lDWMPMUeTV19Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233722; c=relaxed/simple;
	bh=LEc8/yhpZ26RxR9ueKyv8LG+JsOB/7eOwMUyrz/lAoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGikZMTwUwdsENtaDZQgcAhI9C8Io5q4pHqydP91vBLUnq9FAVc5JCDg7M3Sgql8wX5FjS79LeUkDYnN7CZokeWYdHVqmE1IWnoC15jlleVN4Ie4V5PAdue2q3jqAQhCygfLmiyjlTHtX4NFf73Kse1CPhA9vcBwtT74Q6EAOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D836E13D5;
	Fri, 13 Sep 2024 06:22:29 -0700 (PDT)
Received: from [10.57.75.215] (unknown [10.57.75.215])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E6FA3F73B;
	Fri, 13 Sep 2024 06:21:57 -0700 (PDT)
Message-ID: <b781baf0-7c7e-41c3-a2b6-a2d620df3210@arm.com>
Date: Fri, 13 Sep 2024 15:21:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] sched/fair: Filter false overloaded_group case for
 EAS
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-2-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240830130309.2141697-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

I have been trying this patch with the following workload, on a Pixel6
(4 littles, 2 mid, 2 big):
a. 5 tasks with: [UCLAMP_MIN:0, UCLAMP_MAX:1, duty_cycle=100%, cpuset:0-2]
b. 1 task with: [duty_cycle=100%, cpuset:0-7] but starting on CPU4

a.
There are many UCLAMP_MAX task also to pass the following condition
to tag a group as overloaded.
group_is_overloaded()
\-(sgs->sum_nr_running <= sgs->group_weight)
These tasks should put

b. to see if a CPU-bound task is migrated to the big cluster.

---
- Without patch 5 [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
- Without this patch
The migration is effectively due to the load_balancer selecting the
little cluster over the mid cluster.
The little cluster put the system in an overutilized state.

---
- Without patch 5 [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
- With this patch
The load_balancer effectively selects the medium cluster over the little
cluster (since none of the little CPU is overutilized). The load_balancer
migrates the task b. to a big CPU.

Note:
This is true most of the time, but whenever a non-UCLAMP_MAX tasks wakes-up
on one of CPU0-3 (where the UCLAMP_MAX are pinned), the cluster becomes
overutilized and the new mechanism is bypassed.
Same thing if a task with [UCLAMP_MIN:0, UCLAMP_MAX:1024, duty_cycle=100%, cpuset:0]
is added to the workload.

---
- With patch 5 [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
- Without this patch

The task b. gets an opportunity to migrate to a big CPU through the sched_tick.
However with both patches are applied, the migration is triggered by the
load_balancer.

---
So FWIW, from a mechanism PoV and independently from patch 5:
Tested-by: Pierre Gondois <pierre.gondois@arm.com>


On 8/30/24 15:03, Vincent Guittot wrote:
> With EAS, a group should be set overloaded if at least 1 CPU in the group
> is overutilized bit it can happen that a CPU is fully utilized by tasks
> because of clamping the compute capacity of the CPU. In such case, the CPU
> is not overutilized and as a result should not be set overloaded as well.
> 
> group_overloaded being a higher priority than group_misfit, such group can
> be selected as the busiest group instead of a group with a mistfit task
> and prevents load_balance to select the CPU with the misfit task to pull
> the latter on a fitting CPU.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fea057b311f6..e67d6029b269 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9806,6 +9806,7 @@ struct sg_lb_stats {
>   	enum group_type group_type;
>   	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
>   	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
> +	unsigned long group_overutilized;	/* No CPU is overutilized in the group */
>   	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
>   #ifdef CONFIG_NUMA_BALANCING
>   	unsigned int nr_numa_running;
> @@ -10039,6 +10040,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>   static inline bool
>   group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>   {
> +	/*
> +	 * With EAS and uclamp, 1 CPU in the group must be overutilized to
> +	 * consider the group overloaded.
> +	 */
> +	if (sched_energy_enabled() && !sgs->group_overutilized)
> +		return false;
> +
>   	if (sgs->sum_nr_running <= sgs->group_weight)
>   		return false;
>   
> @@ -10252,8 +10260,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   		if (nr_running > 1)
>   			*sg_overloaded = 1;
>   
> -		if (cpu_overutilized(i))
> +		if (cpu_overutilized(i)) {
>   			*sg_overutilized = 1;
> +			sgs->group_overutilized = 1;
> +		}
>   
>   #ifdef CONFIG_NUMA_BALANCING
>   		sgs->nr_numa_running += rq->nr_numa_running;


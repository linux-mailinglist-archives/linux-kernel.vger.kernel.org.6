Return-Path: <linux-kernel+bounces-311181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E59685AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A781F218ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBB51D6785;
	Mon,  2 Sep 2024 11:03:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB41D61BD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275010; cv=none; b=uDyH6UXy7+XVHvmbDYKISf6xXji1vRB6nUjvUgc3OgMz9i8bjwpK0EgfBckFzjPpBfw8mXTNgI6h4EsGdo4pph5XfxWH09Kf/1guOxb05qG8tMMDXIeUNFLfKSPwzEAaSDkpDzrCSaMAn9pJVOgl32Q/+2Q+cX7FR2BtNv06owY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275010; c=relaxed/simple;
	bh=D5Zd+YXYUgY0BjRp8kFaofANSPag5yi+/w5XM+LWXhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqaPH9AI2xqigFrkAlQihm+WgYcymV/fVkLilzNzIl8jZ+bGLd/KExfak9N+9gg53Zr/UtJ0MqKpfnRyqkyCt7u3zWfeUIoEB9P9dn6xFHwV4GPrREQ0CE9TkilqTmraCaphxFNN73gi3Ke7iXDUwbowBjSc49FzMD/k/eDavJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAEBBFEC;
	Mon,  2 Sep 2024 04:03:53 -0700 (PDT)
Received: from [10.57.50.57] (unknown [10.57.50.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A37C93F73B;
	Mon,  2 Sep 2024 04:03:24 -0700 (PDT)
Message-ID: <066b7de8-0854-424b-8888-b18fc61ec21c@arm.com>
Date: Mon, 2 Sep 2024 12:03:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, vschneid@redhat.com, lukasz.luba@arm.com,
 mgorman@suse.de, rafael.j.wysocki@intel.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240830130309.2141697-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2024 14:03, Vincent Guittot wrote:
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
> [...]
>   
> -	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> +/* For a same cost, select the CPU that will povide best performance for the task */
> +static bool select_best_cpu(struct energy_cpu_stat *target,
> +			    struct energy_cpu_stat *min,
> +			    int prev, struct sched_domain *sd)
> +{
> +	/*  Select the one with the least number of running tasks */
> +	if (target->nr_running < min->nr_running)
> +		return true;
> +	if (target->nr_running > min->nr_running)
> +		return false;
>   
This makes me a bit worried about systems with coarse-grained OPPs. All 
my dev boards and one of my old phones have <= 3 OPPs. On my Juno board, 
the lowest OPP on the big core spans across 512 utilization, half of the 
full capacity. Assuming a scenario where there are 4 tasks, each with 
300, 100, 100, 100 utilization, the placement should be 300 on one core 
and 3 tasks with 100 on another, but the nr_running check here would 
give 2 tasks (300 + 100) on one CPU and 2 tasks (100 + 100) on another 
because they are still under the lowest OPP on Juno. The second CPU will 
also finish faster and idle more than the first one.

To give an extreme example, assuming the system has only one OPP (such a 
system is dumb to begin with, but just to make a point), before this 
patch EAS would still work okay in task placement, but after this patch, 
EAS would just balance on the number of tasks, regardless of utilization 
of tasks on wake-up.

I wonder if there is a way to still take total utilization as a factor. 
It used to be 100% of the decision making, but maybe now it is only 60%, 
and the other 40% are things like number of tasks and contention.

> -	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
> +	/* Favor previous CPU otherwise */
> +	if (target->cpu == prev)
> +		return true;
> +	if (min->cpu == prev)
> +		return false;
>   
> -	return energy;
> +	/*
> +	 * Choose CPU with lowest contention. One might want to consider load instead of
> +	 * runnable but we are supposed to not be overutilized so there is enough compute
> +	 * capacity for everybody.
> +	 */
> +	if ((target->runnable * min->capa * sd->imbalance_pct) >=
> +			(min->runnable * target->capa * 100))
> +		return false;
> +
> +	return true;
>   }
> [...]



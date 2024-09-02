Return-Path: <linux-kernel+bounces-310899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E896829E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF680284DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F4187872;
	Mon,  2 Sep 2024 09:01:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29D18784F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267676; cv=none; b=gubliTP+9bExti97/aPk6TPmQ7ywlrFD/uff4LuI6v1plVRwko9sp1Zu7lxdiDqJuxG4SM73uTA2+5AiIx333PB5mIQVN906bshvMJ1CsVYXpfbsCSDe/+Wn5d4+3OslkbchwutGwaRZ0a5Wx0tmaUXhmvLXVwnHY+7RXoAy8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267676; c=relaxed/simple;
	bh=gsTZa6RASASfuAkvIaC+kGDIPagUWin7+txDcVwr3cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mShM1FaKI00Z0ZfczEpVDErFwmKJ9QCKngGyW64cWiRB8fXmbz7yUnczWeHNI2JHuE35k/9E/poxuIgG2WkVds16IVEFhV8SvABNY/w2KVFpO9ZlUze8hHvfRRExqWziQfacKPeyaZ3uMiQL9lmgNGL/jE0zIU9a14bJn1CMlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF0FFEC;
	Mon,  2 Sep 2024 02:01:40 -0700 (PDT)
Received: from [10.57.50.57] (unknown [10.57.50.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372F83F73F;
	Mon,  2 Sep 2024 02:01:11 -0700 (PDT)
Message-ID: <a499b2f6-eac3-4c15-bca6-001a724225ff@arm.com>
Date: Mon, 2 Sep 2024 10:01:09 +0100
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
Cc: qyousef@layalina.io
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-2-vincent.guittot@linaro.org>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240830130309.2141697-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2024 14:03, Vincent Guittot wrote:
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

Does this have to be unsigned long? I think a shorter width like bool 
(or int to be consistent with other fields) expresses the intention.

Also the comment to me is a bit confusing. All other fields are positive 
but this one's comment is in a negative tone.

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


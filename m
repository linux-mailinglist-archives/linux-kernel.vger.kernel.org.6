Return-Path: <linux-kernel+bounces-513673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A41BA34D49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B33161B09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F824169B;
	Thu, 13 Feb 2025 18:15:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72F24166D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470544; cv=none; b=oFmw5kotV45qMMS79nEkyEexEmzmxWwCOhpiXNxuyZYb//46i1gsOxBzQ3pTrj1QHG6EHk/KxDrO01Ut+D99HLHyuf7FnRg0CMrFFOLjPQKDZUZKGk9GiKmHyCDXECxruOq2mXuCimwIKmlMUldRwlr8jEEl0FELFM0qQ/Hmlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470544; c=relaxed/simple;
	bh=8PZEmGXiV6pVd97uS7r+2Qg+cgLSJWnlAYS4C/wVFvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTCg7J5EgI4KOn4DsFLVf5scqBV4oyREuKeIv7zCxly+epkLMoW1Jt07XhfF3Xxe/MXVgj+6lakjRujzVhBms1mEYlghpH5bxIuipBg4FXeVWf0HbIPthSiVHc7GyNuN1gGe8NVsWZO6LjPmxmI/fKXXTPlFpofNR9s+W99X94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3CFB113E;
	Thu, 13 Feb 2025 10:16:02 -0800 (PST)
Received: from [10.57.79.221] (unknown [10.57.79.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4A93F5A1;
	Thu, 13 Feb 2025 10:15:38 -0800 (PST)
Message-ID: <d7713049-5b44-4e86-8c0d-ca2c365c925f@arm.com>
Date: Thu, 13 Feb 2025 18:15:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/uclamp: Alaways using uclamp_is_used()
To: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, qyousef@layalina.io,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250213091554.2593-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250213091554.2593-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 09:15, Xuewen Yan wrote:
> Now, we have the uclamp_is_used() func to judge the uclamp enabled,
> so replace the static_branch_unlikely(&sched_uclamp_used) with it.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/core.c  |  4 ++--
>  kernel/sched/sched.h | 28 ++++++++++++++--------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 165c90ba64ea..841147759ec7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1756,7 +1756,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  	 * The condition is constructed such that a NOP is generated when
>  	 * sched_uclamp_used is disabled.
>  	 */
> -	if (!static_branch_unlikely(&sched_uclamp_used))
> +	if (!uclamp_is_used())
>  		return;
>  
>  	if (unlikely(!p->sched_class->uclamp_enabled))
> @@ -1783,7 +1783,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  	 * The condition is constructed such that a NOP is generated when
>  	 * sched_uclamp_used is disabled.
>  	 */
> -	if (!static_branch_unlikely(&sched_uclamp_used))
> +	if (!uclamp_is_used())
>  		return;
>  
>  	if (unlikely(!p->sched_class->uclamp_enabled))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 38e0e323dda2..f5de05354d80 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3394,6 +3394,19 @@ static inline bool update_other_load_avgs(struct rq *rq) { return false; }
>  
>  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>  
> +/*
> + * When uclamp is compiled in, the aggregation at rq level is 'turned off'
> + * by default in the fast path and only gets turned on once userspace performs
> + * an operation that requires it.
> + *
> + * Returns true if userspace opted-in to use uclamp and aggregation at rq level
> + * hence is active.
> + */
> +static inline bool uclamp_is_used(void)
> +{
> +	return static_branch_likely(&sched_uclamp_used);
> +}
> +
>  static inline unsigned long uclamp_rq_get(struct rq *rq,
>  					  enum uclamp_id clamp_id)
>  {
> @@ -3417,7 +3430,7 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
>  	unsigned long rq_util;
>  	unsigned long max_util;
>  
> -	if (!static_branch_likely(&sched_uclamp_used))
> +	if (!uclamp_is_used())
>  		return false;
>  
>  	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
> @@ -3426,19 +3439,6 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
>  	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
>  }
>  
> -/*
> - * When uclamp is compiled in, the aggregation at rq level is 'turned off'
> - * by default in the fast path and only gets turned on once userspace performs
> - * an operation that requires it.
> - *
> - * Returns true if userspace opted-in to use uclamp and aggregation at rq level
> - * hence is active.
> - */
> -static inline bool uclamp_is_used(void)
> -{
> -	return static_branch_likely(&sched_uclamp_used);
> -}
> -
>  #define for_each_clamp_id(clamp_id) \
>  	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
>  

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


Return-Path: <linux-kernel+bounces-260589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FD93AB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EE0B21372
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A59517753;
	Wed, 24 Jul 2024 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mmnj1Jex"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351A171BB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788178; cv=none; b=VfxnXgt872N+jGx20ZRduwe/+4l1ZJgKHHw131COb70QueariF4YP5qSOZV2wIzGULfkLBnVeebG4pIDPEjN6Iw6GWBoN1Ce+RVoc07lVo7OEm6ngI+QccT+vBQvOckEDUpwVHkzbyLRmTDXwW8Y0kgzHle7Je8ZofuZ6M0iN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788178; c=relaxed/simple;
	bh=KMC50gGNo/ANP1CNEx08E3SfNuc0oTVoDEsir8mjJsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fu1AdzbJUjZ8yhRQAFeEfFhvo7/s9Fjw+etrr7nyTHaA2n1WMFb4LdOrGtPt77S4MipW/X7VwzjnkuEkgAhafc1lPCSHj4wxSFb/Ta1t4e0jMLdm8Sr5uAvwe0pDh0NjyYGXdKzna6bg7PORCRJo1jUnHfibtM5At8AWvvjTv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mmnj1Jex; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6df6a8d3-6c5e-4ea7-8f55-08c2a56928f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721788174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUI9uq9ukuV5NOUleSI/XhSxPfRiSHqbaOJWHlmO/V4=;
	b=Mmnj1Jex5qdaczN/I1YE9g0sWhUQ8mCv60nbWz3/JVYSmgjusjvmLeMQ6sXS1TB5bRlpEa
	npgtRG3VKdjP/HCSlCZ2Pix3hYlga3ZhLVeJ8lPxLKcFzA7D/xSpa46pcyrXEjAbYma6I6
	8qIo2mjIyzBPF/KpLU68U1iS6jnuvyg=
Date: Wed, 24 Jul 2024 10:29:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] sched/fair: Decrease cfs bandwidth usage in
 task_group destruction
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, joshdon@google.com
References: <20240723122006.47053-1-zhouchuyi@bytedance.com>
 <20240723122006.47053-2-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240723122006.47053-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/23 20:20, Chuyi Zhou wrote:
> The static key __cfs_bandwidth_used is used to indicate whether bandwidth
> control is enabled in the system. Currently, it is only decreased when a
> task group disables bandwidth control. This is incorrect because if there
> was a task group in the past that enabled bandwidth control, the
> __cfs_bandwidth_used will never go to zero, even if there are no task_group
> using bandwidth control now.
> 
> This patch tries to fix this issue by decrsasing bandwidth usage in
> destroy_cfs_bandwidth(). cfs_bandwidth_usage_dec() calls
> static_key_slow_dec_cpuslocked which needs to hold hotplug lock, but cfs
> bandwidth destroy maybe run in a rcu callback. Move the call to
> destroy_cfs_bandwidth() from unregister_fair_sched_group() to
> cpu_cgroup_css_free() which runs in process context.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Yeah, autogroup can't have bandwidth set, so it's ok to just destroy 
bandwidth in .css_free().

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Just some nits below:

> ---
>   kernel/sched/core.c  |  2 ++
>   kernel/sched/fair.c  | 13 +++++++------
>   kernel/sched/sched.h |  2 ++
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6d35c48239be..7720d34bd71b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8816,6 +8816,8 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>   {
>   	struct task_group *tg = css_tg(css);
>   
> +	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));

Instead of exporting this tg_cfs_bandwidth(), how about just changing
the parameter of init_cfs_bandwidth()/destroy_cfs_bandwidth() to tg?
Which maybe clearer? but this is your call.

Thanks.

> +
>   	/*
>   	 * Relies on the RCU grace period between css_released() and this.
>   	 */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da3cdd86ab2e..c56b6d5b8ed7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5615,7 +5615,7 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>   	cfs_b->runtime_snap = cfs_b->runtime;
>   }
>   
> -static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> +struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>   {
>   	return &tg->cfs_bandwidth;
>   }
> @@ -6438,7 +6438,7 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>   	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>   }
>   
> -static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> +void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>   {
>   	int __maybe_unused i;
>   
> @@ -6472,6 +6472,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>   		local_irq_restore(flags);
>   	}
>   #endif
> +	guard(cpus_read_lock)();
> +	if (cfs_b->quota != RUNTIME_INF)
> +		cfs_bandwidth_usage_dec();
>   }
>   
>   /*
> @@ -6614,11 +6617,11 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *paren
>   static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
>   #endif
>   
> -static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> +struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>   {
>   	return NULL;
>   }
> -static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
> +void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
>   static inline void update_runtime_enabled(struct rq *rq) {}
>   static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
>   #ifdef CONFIG_CGROUP_SCHED
> @@ -12992,8 +12995,6 @@ void unregister_fair_sched_group(struct task_group *tg)
>   	struct rq *rq;
>   	int cpu;
>   
> -	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
> -
>   	for_each_possible_cpu(cpu) {
>   		if (tg->se[cpu])
>   			remove_entity_load_avg(tg->se[cpu]);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8a071022bdec..d251842867ce 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2938,6 +2938,8 @@ extern void init_dl_rq(struct dl_rq *dl_rq);
>   extern void cfs_bandwidth_usage_inc(void);
>   extern void cfs_bandwidth_usage_dec(void);
>   
> +extern struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg);
> +extern void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
>   #ifdef CONFIG_NO_HZ_COMMON
>   
>   #define NOHZ_BALANCE_KICK_BIT	0


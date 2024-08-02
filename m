Return-Path: <linux-kernel+bounces-273003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E867394633C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173CB1C21B23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC771ABED9;
	Fri,  2 Aug 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lA3kiHBc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64E1ABECC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623425; cv=none; b=IRuveyTufxwiv/7tqshRQg1JfQMsipxYYQFtbexj0eW7MhQncUQCzhCwfjzDfYdoWDPe1sTLFRKvEack0dSl8Wv8Pq/wiTaTLvfC1dR6EN+mxL40mKcIz7iaGuQ7D3JzqynpaGPCrKXy211tHLApqbje0Yp4m4lDiE3ARpPXP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623425; c=relaxed/simple;
	bh=qxp6XOu737VJNOpOMzKEgPrtx3gTmGMKDLCjvkz/YGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hoi6zryM4aOLA78VYvY5taoWiCtygnGQf08feESDaVVwmvDgEdveNjvlTqWHL6rAMvo7TtT/WLyrDGdQWcPX74eGIULBoKubezLmi+6j1+uW94jj08qkN97cZ+ZxQwPcX2jeWcFbtDvPy8Mjuo2gLSXcjbg8TkR5zcV/uv10pH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lA3kiHBc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722623423; x=1754159423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qxp6XOu737VJNOpOMzKEgPrtx3gTmGMKDLCjvkz/YGY=;
  b=lA3kiHBcyZ+VwuPX0BGRohpax9B1rtU8VX4GOChEg2CO0Y90AkQH+ubL
   KwEcpkZS2DBVcnSHvmBa530Co/WISUnmtNV3+UjRoVSK597ZhESLVYZ6H
   wpI9fmsRBDq1ccv9K9DkS3BNf4p6FxyIa5SArPXEft76vZ3ueCWUmuSyP
   enr92KHPE68en9KEaEFeurqQiVMCtAwmgFuyKn3E/+7lM3TkdOC8UftWF
   5S5RQRaqhV+m5OJcrT2exbJASR2m02WBvOzeBC0rdKNolgdlamVXApf6e
   Pa3CiuVRmx+omjylyWnA6+amzIqH1rpq6trCspeO7KL3SWdCF/gwHYTCN
   A==;
X-CSE-ConnectionGUID: BruAAMlVQrex3yW8NzhIuw==
X-CSE-MsgGUID: jh35Le4RTZC5alj4OiWgjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20470627"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20470627"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 11:30:22 -0700
X-CSE-ConnectionGUID: X0zijsq7QDS4J9n6pMH5kg==
X-CSE-MsgGUID: fkoDhJCvRPKKO5si+7DAIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="93023757"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 11:30:22 -0700
Received: from [10.212.17.69] (kliang2-mobl1.ccr.corp.intel.com [10.212.17.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 270A920B5782;
	Fri,  2 Aug 2024 11:30:21 -0700 (PDT)
Message-ID: <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
Date: Fri, 2 Aug 2024 14:30:19 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>,
 Mingwei Zhang <mizhang@google.com>
References: <20240731000607.543783-1-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240731000607.543783-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-30 8:06 p.m., Namhyung Kim wrote:
> Current ctx_resched() reschedules every events in all PMUs in the
> context even if it only needs to do it for a single event.  This is the
> case when it opens a new event or enables an existing one.  What we
> want is to reschedule events in the PMU only.  Also perf_pmu_resched()
> currently calls ctx_resched() without PMU information.
> 
> Let's add pmu argument to ctx_resched() to do the work for the given
> PMU only.  And change the __pmu_ctx_sched_in() to be symmetrical to the
> _sched_out() counterpart for its arguments so that it can be called
> easily in the __perf_pmu_resched().
> 
> Note that __perf_install_in_context() should call ctx_resched() for the
> very first event in the context in order to set ctx->is_active.  Later
> events can be handled by __perf_pmu_resched().
> 
> Care should be taken when it installs a task event for a PMU and
> there's no CPU event for the PMU.  __perf_pmu_resched() will ask the
> CPU PMU context to schedule any events in it according to the group
> info.  But as the PMU context was not activated, it didn't set the
> event context pointer.  So I added new NULL checks in the
> __pmu_ctx_sched_{in,out}.
> 
> With this change I can get 4x speed up (but actually it's proportional
> to the number of uncore PMU events) on a 2-socket Intel EMR machine in
> opening and closing a perf event for the core PMU in a loop while there
> are a bunch of uncore PMU events active on the CPU.  The test code
> (stress-pmu) follows below.
> 
> Before)
>   # ./stress-pmu
>   delta: 0.087068 sec (870 usec/op)
> 
> After)
>   # ./stress-pmu
>   delta: 0.021440 sec (214 usec/op)
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   $ cat stress-pmu.c
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <linux/perf_event.h>
>   #include <sys/syscall.h>
>   #include <sys/time.h>
> 
>   /* from uncore cpumask on EMR */
>   #define TARGET_CPU 60
> 
>   #define LOOP 100
>   #define US2S 1000000
> 
>   int open_perf_event(int type, int config)
>   {
>   	struct perf_event_attr attr = {
>   		.type = type,
>   		.config = config,
>   	};
>   	int fd;
> 
>   	fd = syscall(SYS_perf_event_open, &attr, /*pid=*/-1, TARGET_CPU,
>   			/*group_fd=*/-1, /*flags=*/0);
>   	if (fd < 0)
>   		printf("perf_event_open failed (type=%d, config=%d): %m\n", type, config);
>   	return fd;
>   }
> 
>   int main(int argc, char *argv[])
>   {
>   	struct timeval ts1, ts2;
>   	unsigned long long delta;
>   	int target_cpu = TARGET_CPU;
> 
>   	/* open random uncore PMU events */
>   	for (int i = 0; i < 100; i++)
>   		open_perf_event(/*type=*/i + 20, /*config=*/0);
> 
>   	gettimeofday(&ts1, NULL);
>   	for (int i = 0; i < LOOP; i++)
>   		close(open_perf_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES));
>   	gettimeofday(&ts2, NULL);
> 
>   	delta = ts2.tv_sec * US2S + ts2.tv_usec - (ts1.tv_sec * US2S + ts1.tv_usec);
>   	printf("delta: %llu.%06llu sec (%llu usec/op)\n",
>   		delta / US2S, delta % US2S, delta / LOOP);
>   	return 0;
>   }
> ---
> v2) add 'pmu' argument to ctx_resched() to reduce duplication
> 
>  kernel/events/core.c | 118 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 93 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f64c30e7d5da..41e2533859a4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -709,6 +709,10 @@ static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
>  
>  static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
>  static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
> +static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
> +				enum event_type_t event_type);
> +static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
> +			       enum event_type_t event_type);
>  
>  #ifdef CONFIG_CGROUP_PERF
>  
> @@ -2668,6 +2672,17 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
>  		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
>  }
>  
> +static void perf_pmu_sched_in(struct perf_cpu_pmu_context *cpc,
> +			      struct perf_event_pmu_context *task_epc)
> +{
> +	__pmu_ctx_sched_in(&cpc->epc, EVENT_PINNED);
> +	if (task_epc)
> +		 __pmu_ctx_sched_in(task_epc, EVENT_PINNED);
> +	__pmu_ctx_sched_in(&cpc->epc, EVENT_FLEXIBLE);
> +	if (task_epc)
> +		 __pmu_ctx_sched_in(task_epc, EVENT_FLEXIBLE);
> +}
> +
>  /*
>   * We want to maintain the following priority of scheduling:
>   *  - CPU pinned (EVENT_CPU | EVENT_PINNED)
> @@ -2683,16 +2698,13 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
>   * event_type is a bit mask of the types of events involved. For CPU events,
>   * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
>   */
> -/*
> - * XXX: ctx_resched() reschedule entire perf_event_context while adding new
> - * event to the context or enabling existing event in the context. We can
> - * probably optimize it by rescheduling only affected pmu_ctx.
> - */
>  static void ctx_resched(struct perf_cpu_context *cpuctx,
>  			struct perf_event_context *task_ctx,
> -			enum event_type_t event_type)
> +			struct pmu *pmu, enum event_type_t event_type)
>  {
>  	bool cpu_event = !!(event_type & EVENT_CPU);
> +	struct perf_cpu_pmu_context *cpc = NULL;
> +	struct perf_event_pmu_context *epc = NULL;
>  
>  	/*
>  	 * If pinned groups are involved, flexible groups also need to be
> @@ -2703,10 +2715,24 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  
>  	event_type &= EVENT_ALL;
>  
> -	perf_ctx_disable(&cpuctx->ctx, false);
> +	if (pmu) {
> +		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
> +		perf_pmu_disable(pmu);
> +	} else {
> +		perf_ctx_disable(&cpuctx->ctx, false);
> +	}
> +
>  	if (task_ctx) {
> -		perf_ctx_disable(task_ctx, false);
> -		task_ctx_sched_out(task_ctx, event_type);
> +		if (pmu) {
> +			if (WARN_ON_ONCE(!cpc->task_epc || cpc->task_epc->ctx != task_ctx))
> +				goto out;
> +
> +			epc = cpc->task_epc;
> +			__pmu_ctx_sched_out(epc, event_type);
> +		} else {
> +			perf_ctx_disable(task_ctx, false);
> +			task_ctx_sched_out(task_ctx, event_type);
> +		}
>  	}
>  
>  	/*
> @@ -2716,15 +2742,30 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	 *  - EVENT_PINNED task events: schedule out EVENT_FLEXIBLE groups;
>  	 *  - otherwise, do nothing more.
>  	 */
> -	if (cpu_event)
> -		ctx_sched_out(&cpuctx->ctx, event_type);
> -	else if (event_type & EVENT_PINNED)
> -		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
> +	if (cpu_event) {
> +		if (pmu)
> +			__pmu_ctx_sched_out(&cpc->epc, event_type);
> +		else
> +			ctx_sched_out(&cpuctx->ctx, event_type);
> +	} else if (event_type & EVENT_PINNED) {
> +		if (pmu)
> +			__pmu_ctx_sched_out(&cpc->epc, EVENT_FLEXIBLE);
> +		else
> +			ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
> +	}
> +
> +	if (pmu)
> +		perf_pmu_sched_in(cpc, epc);
> +	else
> +		perf_event_sched_in(cpuctx, task_ctx);
>  
> -	perf_event_sched_in(cpuctx, task_ctx);
> +out:
> +	if (pmu)
> +		perf_pmu_enable(pmu);
> +	else
> +		perf_ctx_enable(&cpuctx->ctx, false);
>  
> -	perf_ctx_enable(&cpuctx->ctx, false);
> -	if (task_ctx)
> +	if (task_ctx && !pmu)
>  		perf_ctx_enable(task_ctx, false);
>  }
>  
> @@ -2734,7 +2775,7 @@ void perf_pmu_resched(struct pmu *pmu)
>  	struct perf_event_context *task_ctx = cpuctx->task_ctx;
>  
>  	perf_ctx_lock(cpuctx, task_ctx);
> -	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> +	ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU);
>  	perf_ctx_unlock(cpuctx, task_ctx);
>  }
>  
> @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
>  	if (reprogram) {
>  		ctx_sched_out(ctx, EVENT_TIME);
>  		add_event_to_ctx(event, ctx);
> -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +		if (ctx->nr_events == 1) {
> +			/* The first event needs to set ctx->is_active. */
> +			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
> +		} else {
> +			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> +				    get_event_type(event));
> +			ctx_sched_in(ctx, EVENT_TIME);

The changelog doesn't mention the time difference much. As my
understanding, the time is shared among PMUs in the same ctx.
When perf does ctx_resched(), the time is deducted.
There is no problem to stop and restart the global time when perf
re-schedule all PMUs.
But if only one PMU is re-scheduled while others are still running, it
may be a problem to stop and restart the global time. Other PMUs will be
impacted.

Thanks,
Kan
> +		}
>  	} else {
>  		add_event_to_ctx(event, ctx);
>  	}
> @@ -2962,7 +3010,8 @@ static void __perf_event_enable(struct perf_event *event,
>  	if (ctx->task)
>  		WARN_ON_ONCE(task_ctx != ctx);
>  
> -	ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +	ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu, get_event_type(event));
> +	ctx_sched_in(ctx, EVENT_TIME);
>  }
>  
>  /*
> @@ -3230,6 +3279,13 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
>  	struct perf_event *event, *tmp;
>  	struct pmu *pmu = pmu_ctx->pmu;
>  
> +	/*
> +	 * CPU's pmu_ctx might not be active when __perf_pmu_resched() is called
> +	 * for task events and there's no cpu events.
> +	 */
> +	if (ctx == NULL)
> +		return;
> +
>  	if (ctx->task && !ctx->is_active) {
>  		struct perf_cpu_pmu_context *cpc;
>  
> @@ -3872,10 +3928,22 @@ static void ctx_groups_sched_in(struct perf_event_context *ctx,
>  	}
>  }
>  
> -static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
> -			       struct pmu *pmu)
> +static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
> +			       enum event_type_t event_type)
>  {
> -	pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
> +	struct perf_event_context *ctx = pmu_ctx->ctx;
> +
> +	/*
> +	 * CPU's pmu_ctx might not be active when __perf_pmu_resched() is called
> +	 * for task events and there's no cpu events.
> +	 */
> +	if (ctx == NULL)
> +		return;
> +
> +	if (event_type & EVENT_PINNED)
> +		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
> +	if (event_type & EVENT_FLEXIBLE)
> +		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
>  }
>  
>  static void
> @@ -4309,14 +4377,14 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
>  		update_context_time(&cpuctx->ctx);
>  		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
>  		rotate_ctx(&cpuctx->ctx, cpu_event);
> -		__pmu_ctx_sched_in(&cpuctx->ctx, pmu);
> +		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
>  	}
>  
>  	if (task_event)
>  		rotate_ctx(task_epc->ctx, task_event);
>  
>  	if (task_event || (task_epc && cpu_event))
> -		__pmu_ctx_sched_in(task_epc->ctx, pmu);
> +		__pmu_ctx_sched_in(task_epc, EVENT_FLEXIBLE);
>  
>  	perf_pmu_enable(pmu);
>  	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> @@ -4394,7 +4462,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
>  	 */
>  	if (enabled) {
>  		clone_ctx = unclone_ctx(ctx);
> -		ctx_resched(cpuctx, ctx, event_type);
> +		ctx_resched(cpuctx, ctx, NULL, event_type);
>  	} else {
>  		ctx_sched_in(ctx, EVENT_TIME);
>  	}


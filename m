Return-Path: <linux-kernel+bounces-267125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A207940CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29448281611
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE61946D2;
	Tue, 30 Jul 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cRFO11pE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22364442C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330289; cv=none; b=fJiY278Rtjk36XVZbfqKiRvvE8ut6k/FqJpXmcjpdrVHJuK+FKm0NjEfcjabNDkLFeOeSnhoADpqdpoqjs1/m+AKmYKmjJ741255QBONHMlrWAwjsLmYbTl+MVSx2SmVxOpCT28vDffW7GYzyJg/8G4uJ8/X5oJ0Qdrk7nIdgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330289; c=relaxed/simple;
	bh=Gx93XEXJrT2KsRaSE16ZJ4peaeDphKVaCPLr7xkFNzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7Em7wGZ3KyIU4CHafhoD5wSEDV5OcQ23YgxJdmnBs8j4T9+i+8lsY6l2KjNstOvI3jJGIw6AmkX6Q1l6tX83tSq98WjUpoK/pjf8QY/NvVWV//R09MvAlCXggxBof690/0Dh1URv/3QnpZnoLw7T3QxkF7vy/PL1pHnpqD/fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cRFO11pE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KPeZT8yf5McMqzF7IfFFrvy8IFCRBGRlb5SeNB6WMSs=; b=cRFO11pEMzwhMH+FppiySJ4TiX
	FjjnOgTsBMRJLUR6v85UCVLjdjs0l3DprTylHN21byyohIyub42w/QNpMwvbjrS9Lo7MsUKgw9TMu
	ir11xrOWnCsPG9Wj+B5O2c3n/zDgRaZ/sms0Tvr/0aKsaHgfd629+38V5PfvPfvpeNQsJ/f9GxQpf
	kHjJsBMHL3Q7xlskmxPxyjyMNnegb/P5HIjeaRRD9VQQJM0VeGPCdI5NzsMbZyXfxsgbf/w0kRsIv
	oDeMa6QNdK5XP+ywIdFQA5dp3CDli9K644jrhdgD9M97ob516Ps+XUyjgs/Lgyjz9nXF2jnTYSBGD
	Fn91MYGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYimi-0000000EV8J-0NZ4;
	Tue, 30 Jul 2024 09:04:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 775E03003EA; Tue, 30 Jul 2024 11:04:43 +0200 (CEST)
Date: Tue, 30 Jul 2024 11:04:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Tejun Heo <tj@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240730090443.GI33588@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240725011907.3f5ropfai3xoy3l3@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725011907.3f5ropfai3xoy3l3@airbuntu>

On Thu, Jul 25, 2024 at 02:19:07AM +0100, Qais Yousef wrote:

> We really shouldn't change how schedutil works. The governor is supposed to
> behave in a certain way, and we need to ensure consistency. I think you should
> look on how you make your scheduler compatible with it. Adding hooks to say
> apply this perf value that I want is a recipe for randomness.

That would be this part right?

> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..e683e5d08daa 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -197,8 +197,10 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  
>  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  {
> -	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> +	unsigned long min, max, util = scx_cpuperf_target(sg_cpu->cpu);
>  
> +	if (!scx_switched_all())
> +		util += cpu_util_cfs_boost(sg_cpu->cpu);
>  	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
>  	util = max(util, boost);
>  	sg_cpu->bw_min = min;
> @@ -325,16 +327,35 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> -static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> +static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>  {
> -	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> -	bool ret = idle_calls == sg_cpu->saved_idle_calls;
> +	unsigned long idle_calls;
> +	bool ret;
> +
> +	/*
> +	 * The heuristics in this function is for the fair class. For SCX, the
> +	 * performance target comes directly from the BPF scheduler. Let's just
> +	 * follow it.
> +	 */
> +	if (scx_switched_all())
> +		return false;

This one does seem really weird. It makes schedutil behave significantly
different from the BPF pov depending on if you have this partial mode on
or not.

So I would really like this to be reconsidered as I agree with Qais,
things should be consistent.

> +	/* if capped by uclamp_max, always update to be in compliance */
> +	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
> +		return false;
> +
> +	/*
> +	 * Maintain the frequency if the CPU has not been idle recently, as
> +	 * reduction is likely to be premature.
> +	 */
> +	idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> +	ret = idle_calls == sg_cpu->saved_idle_calls;
>  
>  	sg_cpu->saved_idle_calls = idle_calls;
>  	return ret;
>  }
>  #else
> -static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
> +static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return false; }
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
>  /*
> @@ -382,14 +403,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>  		return;
>  
>  	next_f = get_next_freq(sg_policy, sg_cpu->util, max_cap);
> -	/*
> -	 * Do not reduce the frequency if the CPU has not been idle
> -	 * recently, as the reduction is likely to be premature then.
> -	 *
> -	 * Except when the rq is capped by uclamp_max.
> -	 */
> -	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> -	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> +
> +	if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
>  	    !sg_policy->need_freq_update) {
>  		next_f = sg_policy->next_freq;
>  
> @@ -436,14 +451,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>  	if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
>  		return;
>  
> -	/*
> -	 * Do not reduce the target performance level if the CPU has not been
> -	 * idle recently, as the reduction is likely to be premature then.
> -	 *
> -	 * Except when the rq is capped by uclamp_max.
> -	 */
> -	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> -	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> +	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>  		sg_cpu->util = prev_util;
>  
>  	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,


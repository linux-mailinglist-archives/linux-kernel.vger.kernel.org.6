Return-Path: <linux-kernel+bounces-247798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A5E92D4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8BA281440
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810B194085;
	Wed, 10 Jul 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c5P6bHCE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8319248D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623977; cv=none; b=BKDNEKLE2UIyTzQ7fsJQO/EfHVouA/grrxlHiuOpTnEuc2iZ8e4wnlTJD23QV49H5jvrGJQGMv1885KGY1J6cK6IYYn9WonmoS2kXD83L7liZSYr1WDBGkXWshZFanLbctpOxlO2utPFhlThr5Et/u4HCioc4F++ZXKYw6Dp0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623977; c=relaxed/simple;
	bh=cVXIYGTqtky8ZoFLKiwTS+5dVo61mjnWuZncWALEa58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRPusktIaagc2nvJnt8z8HpU3c2jxbUyz2Ii1JStoslQTAMVjnckdK4oQnl3i06PIN2YbC+Zk36RVuZ61sNw0UrfK6kvyiupALW8LgBdPZlXUq9sE0N6/XEhxP06lV5Xylxa8eLGbORbLrhqjj+BeWrnOVonatQs31AIMgIc8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c5P6bHCE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CJyO7ZjhNxh7Oj2aJB5dfjhJOZJxIGIAZdnEbpMOJRE=; b=c5P6bHCE3KU3Ll4Z0OeBULTfZ2
	t/kyh/GqBr04ibiUFmTSmorL8diKPwUElodSixnFZ+HB5OJPLm5D4ksWsg5SxkHOLCf/IEDa8fk4H
	pU0b3Yt+Yxy22sS//4UEQ1L3+hdsOJE01fsgdgoEyPMB9izw+7xnVYnXCWmGkhu0NTPGIO9LyFg3E
	PktSpRzGnUrWhqa31QFpp3dHgg5RU+fT1QlWJpqdaAZokZvG9Ldw5fFbGedYSeyO/tLRsUzsUpxPk
	3AWcFQ9SfLjq7KIFBMbAPWbYQNDIjH1YDtlM1/h5Q9+B6gUF4H6U8Mdw1wGnE1nTbVCD37Kfppyl6
	LBSm8lbA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRYtK-00000009QkG-2OxY;
	Wed, 10 Jul 2024 15:05:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1674A300694; Wed, 10 Jul 2024 17:05:58 +0200 (CEST)
Date: Wed, 10 Jul 2024 17:05:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>,
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	Rik van Riel <riel@surriel.com>, Tejun Heo <tj@kernel.org>,
	Cruz Zhao <CruzZhao@linux.alibaba.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [RFC PATCH 3/3] softirq: Avoid waking up ksoftirqd from
 flush_smp_call_function_queue()
Message-ID: <20240710150557.GB27299@noisy.programming.kicks-ass.net>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710090210.41856-4-kprateek.nayak@amd.com>

On Wed, Jul 10, 2024 at 09:02:10AM +0000, K Prateek Nayak wrote:

> diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
> index 21ac44428bb0..3731e79fe19b 100644
> --- a/kernel/sched/smp.h
> +++ b/kernel/sched/smp.h
> @@ -9,7 +9,9 @@ extern void sched_ttwu_pending(void *arg);
>  extern bool call_function_single_prep_ipi(int cpu);
>  
>  #ifdef CONFIG_SMP
> +extern bool do_softirq_pending(void);
>  extern void flush_smp_call_function_queue(void);
>  #else
> +static inline bool do_softirq_pending(void) { return false; }
>  static inline void flush_smp_call_function_queue(void) { }
>  #endif
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f085ebcdf9e7..2eab5e1d5cef 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -559,6 +559,36 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
>  	}
>  }
>  
> +/* Indicate an impending call to do_softirq_post_smp_call_flush() */
> +static DEFINE_PER_CPU_ALIGNED(bool, will_do_softirq_post_flush);
> +
> +static __always_inline void __set_will_do_softirq_post_flush(void)
> +{
> +	this_cpu_write(will_do_softirq_post_flush, true);
> +}
> +
> +static __always_inline void __clr_will_do_softirq_post_flush(void)
> +{
> +	this_cpu_write(will_do_softirq_post_flush, false);
> +}
> +
> +/**
> + * do_softirq_pending - Check if do_softirq_post_smp_call_flush() will
> + *			be called after the invocation of
> + *			__flush_smp_call_function_queue()
> + *
> + * When flush_smp_call_function_queue() executes in the context of idle,
> + * migration thread, a softirq raised from the smp-call-function ends up
> + * waking ksoftirqd despite an impending softirq processing via
> + * do_softirq_post_smp_call_flush().
> + *
> + * Indicate an impending do_softirq() to should_wake_ksoftirqd() despite
> + * not being in an interrupt context.
> + */
> +__always_inline bool do_softirq_pending(void)
> +{
> +	return this_cpu_read(will_do_softirq_post_flush);
> +}
>  
>  /**
>   * flush_smp_call_function_queue - Flush pending smp-call-function callbacks
> @@ -583,7 +613,9 @@ void flush_smp_call_function_queue(void)
>  	local_irq_save(flags);
>  	/* Get the already pending soft interrupts for RT enabled kernels */
>  	was_pending = local_softirq_pending();
> +	__set_will_do_softirq_post_flush();
>  	__flush_smp_call_function_queue(true);
> +	__clr_will_do_softirq_post_flush();
>  	if (local_softirq_pending())
>  		do_softirq_post_smp_call_flush(was_pending);
>  
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 02582017759a..b39eeed03042 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -34,6 +34,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/irq.h>
>  
> +#include "sched/smp.h"
> +
>  /*
>     - No shared variables, all the data are CPU local.
>     - If a softirq needs serialization, let it serialize itself
> @@ -413,7 +415,13 @@ static inline void ksoftirqd_run_end(void)
>  
>  static inline bool should_wake_ksoftirqd(void)
>  {
> -	return true;
> +	/*
> +	 * Avoid waking up ksoftirqd when a softirq is raised from a
> +	 * call-function executed by flush_smp_call_function_queue()
> +	 * in idle, migration thread's context since it'll soon call
> +	 * do_softirq_post_smp_call_flush().
> +	 */
> +	return !do_softirq_pending();
>  }

On first reading I wonder why you've not re-used and hooked into the
PREEMPT_RT variant of should_wake_ksoftirqd(). That already has a per
CPU variable to do exactly this.


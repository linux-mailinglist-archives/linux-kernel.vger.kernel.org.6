Return-Path: <linux-kernel+bounces-192715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5BE8D2117
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1501F2643D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4A171E53;
	Tue, 28 May 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtVhYV2B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAC170834
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912206; cv=none; b=U0uGdqbj6dFljocT9U+VuLoMKckyL6hIPol+3zq4IQZkS0BZDvR1ehuPrrQKCH6H3BlKfQ8RRF1K21sDfRGelL0whPTb2QNPrEujh5dZCjjNKxmMnebayx6BEaixOD343Q/hpWWfaj2USoRHS+uLowSGUQk4yr/kssIRqTjM+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912206; c=relaxed/simple;
	bh=Hc62IPRKaTz8big8EcySqThUgK13WcPmdZcRYBCx46E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTwUEXP4MGYuOYQmF/A4vvDTADLcrecOmJdATVEuA1J1hpg5T/642l6YFL3RkRYPtVxI6EYn28OM5XZdQbNIS0DeNVwmBhLi+3cQBXQTWr8otS9RqguvynUwm0pNI4pcpaK8GFHxHG3oTI4DN5n8LQCBEntIiawjFQYaFv3C0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AtVhYV2B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T6m7GRL/l5fVnq/ReBptkLC/Ipu0179TKWXFXUccS2w=; b=AtVhYV2BMBwMSrezNMKiKQKLzN
	PAxqNnyWDZAmyp8kiu0yKQ9vSUizDlmBmtMj5qKgERpqZGrJsiDW7W3uGG5NXVNfXP7K8fLoCyuzJ
	+b4UM3BpgdQ2zw/jPfIJs0+xmUR2XUHnIlyqv7aP2xWY9niPl95zOAjXiN8TOLvt4ChrlnK+wvc3V
	pTYT8sPCmn1sLFJ6aaSNyytASGINL6wOxLEMC5rNUUv7Qi9kOyKCzGc5Je4l8GWE3XWheTmUSj9go
	9y++geS9iCmp03+aMRgxSQFl3/k7DDy4dMg/N04BuMIbe498Pz7wDy+ZA5gV4YWN3qlDGNMTrwxrh
	9UCCiOXg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzI7-00000008nma-1b4y;
	Tue, 28 May 2024 16:03:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0729030058E; Tue, 28 May 2024 18:03:11 +0200 (CEST)
Date: Tue, 28 May 2024 18:03:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 06/35] thread_info: define
 __tif_need_resched(resched_t)
Message-ID: <20240528160310.GB26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-7-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-7-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:52PM -0700, Ankur Arora wrote:

> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 65e5beedc915..e246b01553a5 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -216,22 +216,44 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
>  
>  #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
>  
> -static __always_inline bool tif_need_resched(void)
> +static __always_inline bool __tif_need_resched_bitop(int nr_flag)
>  {
> -	return arch_test_bit(TIF_NEED_RESCHED,
> -			     (unsigned long *)(&current_thread_info()->flags));
> +	return arch_test_bit(nr_flag,
> +		     (unsigned long *)(&current_thread_info()->flags));
>  }
>  
>  #else
>  
> -static __always_inline bool tif_need_resched(void)
> +static __always_inline bool __tif_need_resched_bitop(int nr_flag)
>  {
> -	return test_bit(TIF_NEED_RESCHED,
> -			(unsigned long *)(&current_thread_info()->flags));
> +	return test_bit(nr_flag,
> +		(unsigned long *)(&current_thread_info()->flags));
>  }

:se cino=(0:0

That is, you're wrecking the indentation here.

>  
>  #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>  
> +static __always_inline bool __tif_need_resched(resched_t rs)
> +{
> +	/*
> +	 * With !PREEMPT_AUTO, this check is only meaningful if we
> +	 * are checking if tif_resched(RESCHED_NOW) is set.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
> +		return __tif_need_resched_bitop(tif_resched(rs));
> +	else
> +		return false;
> +}

	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO) && rs == RESCHED_LAZY)
		return false;

	return __tif_need_resched_bitop(tif_resched(rs));


> +
> +static __always_inline bool tif_need_resched(void)
> +{
> +	return __tif_need_resched(RESCHED_NOW);
> +}
> +
> +static __always_inline bool tif_need_resched_lazy(void)
> +{
> +	return __tif_need_resched(RESCHED_LAZY);
> +}
> +
>  #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
>  static inline int arch_within_stack_frames(const void * const stack,
>  					   const void * const stackend,
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 233d1af39fff..ed229527be05 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2511,7 +2511,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>  	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
>  		trace_flags |= TRACE_FLAG_BH_OFF;
>  
> -	if (tif_need_resched())
> +	if (__tif_need_resched(RESCHED_NOW))
>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;

Per the above this is a NO-OP.


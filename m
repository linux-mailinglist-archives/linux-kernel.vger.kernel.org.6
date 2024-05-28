Return-Path: <linux-kernel+bounces-192750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832168D2198
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A9284EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE653172BB1;
	Tue, 28 May 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5s+JUTi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475316F91D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913590; cv=none; b=DhgjvBi8mUID/LNUhPPXXzFDTJwEgc7W12kdHSFDGunmPxaMfD6K14+1l6aziPF/Fe9KYmisLoaWlplCPDl4W/VHy9EWNNKNTEgDZEQhpKVblKR7Tab6HPb72CIT3D7qimI0i7WroNvOBYqOeZ5J3Fa2Vdli1wZ+S/tQeTEtgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913590; c=relaxed/simple;
	bh=T+N5NCYcb/1CJ58rc8kq2NIC8cRUS+4Az8GxC7eQp3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbqFGZQ3U22dbBcWzKvFj9fQVVqc3MipXuL1o+dROHOcyg2ufiZmn8bgwXdF50EBSa6LFuk/qA5jHW6eU5flU9V4gxd0+zBw2FOHfzeMnpuXhfoaOh6tSd+w//m4MEK4HEZqgjHNbq2xHQY6J3JWdARrh67w8ksTVrMeucmbEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T5s+JUTi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wSXL2SlOjEvveaaFF85+qhUrKzO5LhurNd/gv2GGsio=; b=T5s+JUTi6lcAVjA5PIaUX1c/mz
	C4tyNT9U3VRd7tFO5C9kEAPPexiEFVxeiJgF4WBLwiSamy0fY6VrpjjX6/szW6ONJdbHQQr7v/Z07
	ik0cFPlB63q7W7E7Jlw7F+UxwmcewSwNfsMDKe5SWmiJXr0MaQ2UB8cCObBkxlq64k0WMzyu9DN8N
	cTvva43gOk/MK0lIY4t7vA907WVqcu2/qjl/cMij6AG7PFmU4LT6dz5yUtEXiP6S/oKkGizP0xZNM
	ZtRVl9t0r0L6d0WdWwLqLHkW3852Un4IVhDeQ0e9NMz+LNFQFMuN+kLdrha1olomSSc9k8BM7MVhV
	WN3KIGxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzdn-0000000Bjaz-1Hfx;
	Tue, 28 May 2024 16:25:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AFC3B30058E; Tue, 28 May 2024 18:25:34 +0200 (CEST)
Date: Tue, 28 May 2024 18:25:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 12/35] sched: separate PREEMPT_DYNAMIC config logic
Message-ID: <20240528162534.GG26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-13-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-13-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:58PM -0700, Ankur Arora wrote:
> Pull out the PREEMPT_DYNAMIC setup logic to allow other preemption
> models to dynamically configure preemption.

Uh what ?!? What's the point of creating back-to-back #ifdef sections ?

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/sched/core.c | 165 +++++++++++++++++++++++---------------------
>  1 file changed, 86 insertions(+), 79 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0c26b60c1101..349f6257fdcd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8713,6 +8713,89 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
>  }
>  EXPORT_SYMBOL(__cond_resched_rwlock_write);
>  
> +#if defined(CONFIG_PREEMPT_DYNAMIC)
> +
> +#define PREEMPT_MODE "Dynamic Preempt"
> +
> +enum {
> +	preempt_dynamic_undefined = -1,
> +	preempt_dynamic_none,
> +	preempt_dynamic_voluntary,
> +	preempt_dynamic_full,
> +};
> +
> +int preempt_dynamic_mode = preempt_dynamic_undefined;
> +static DEFINE_MUTEX(sched_dynamic_mutex);
> +
> +int sched_dynamic_mode(const char *str)
> +{
> +	if (!strcmp(str, "none"))
> +		return preempt_dynamic_none;
> +
> +	if (!strcmp(str, "voluntary"))
> +		return preempt_dynamic_voluntary;
> +
> +	if (!strcmp(str, "full"))
> +		return preempt_dynamic_full;
> +
> +	return -EINVAL;
> +}
> +
> +static void __sched_dynamic_update(int mode);
> +void sched_dynamic_update(int mode)
> +{
> +	mutex_lock(&sched_dynamic_mutex);
> +	__sched_dynamic_update(mode);
> +	mutex_unlock(&sched_dynamic_mutex);
> +}
> +
> +static void __init preempt_dynamic_init(void)
> +{
> +	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
> +		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
> +			sched_dynamic_update(preempt_dynamic_none);
> +		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
> +			sched_dynamic_update(preempt_dynamic_voluntary);
> +		} else {
> +			/* Default static call setting, nothing to do */
> +			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
> +			preempt_dynamic_mode = preempt_dynamic_full;
> +			pr_info("%s: full\n", PREEMPT_MODE);
> +		}
> +	}
> +}
> +
> +static int __init setup_preempt_mode(char *str)
> +{
> +	int mode = sched_dynamic_mode(str);
> +	if (mode < 0) {
> +		pr_warn("%s: unsupported mode: %s\n", PREEMPT_MODE, str);
> +		return 0;
> +	}
> +
> +	sched_dynamic_update(mode);
> +	return 1;
> +}
> +__setup("preempt=", setup_preempt_mode);
> +
> +#define PREEMPT_MODEL_ACCESSOR(mode) \
> +	bool preempt_model_##mode(void)						 \
> +	{									 \
> +		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
> +		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
> +	}									 \
> +	EXPORT_SYMBOL_GPL(preempt_model_##mode)
> +
> +PREEMPT_MODEL_ACCESSOR(none);
> +PREEMPT_MODEL_ACCESSOR(voluntary);
> +PREEMPT_MODEL_ACCESSOR(full);
> +
> +#else /* !CONFIG_PREEMPT_DYNAMIC */
> +
> +static inline void preempt_dynamic_init(void) { }
> +
> +#endif /* !CONFIG_PREEMPT_DYNAMIC */
> +
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  
>  #ifdef CONFIG_GENERIC_ENTRY
> @@ -8749,29 +8832,6 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>   *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>   */
>  
> -enum {
> -	preempt_dynamic_undefined = -1,
> -	preempt_dynamic_none,
> -	preempt_dynamic_voluntary,
> -	preempt_dynamic_full,
> -};
> -
> -int preempt_dynamic_mode = preempt_dynamic_undefined;
> -
> -int sched_dynamic_mode(const char *str)
> -{
> -	if (!strcmp(str, "none"))
> -		return preempt_dynamic_none;
> -
> -	if (!strcmp(str, "voluntary"))
> -		return preempt_dynamic_voluntary;
> -
> -	if (!strcmp(str, "full"))
> -		return preempt_dynamic_full;
> -
> -	return -EINVAL;
> -}
> -
>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
>  #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
> @@ -8782,7 +8842,6 @@ int sched_dynamic_mode(const char *str)
>  #error "Unsupported PREEMPT_DYNAMIC mechanism"
>  #endif
>  
> -static DEFINE_MUTEX(sched_dynamic_mutex);
>  static bool klp_override;
>  
>  static void __sched_dynamic_update(int mode)
> @@ -8807,7 +8866,7 @@ static void __sched_dynamic_update(int mode)
>  		preempt_dynamic_disable(preempt_schedule_notrace);
>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
>  		if (mode != preempt_dynamic_mode)
> -			pr_info("Dynamic Preempt: none\n");
> +			pr_info("%s: none\n", PREEMPT_MODE);
>  		break;
>  
>  	case preempt_dynamic_voluntary:
> @@ -8818,7 +8877,7 @@ static void __sched_dynamic_update(int mode)
>  		preempt_dynamic_disable(preempt_schedule_notrace);
>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
>  		if (mode != preempt_dynamic_mode)
> -			pr_info("Dynamic Preempt: voluntary\n");
> +			pr_info("%s: voluntary\n", PREEMPT_MODE);
>  		break;
>  
>  	case preempt_dynamic_full:
> @@ -8829,20 +8888,13 @@ static void __sched_dynamic_update(int mode)
>  		preempt_dynamic_enable(preempt_schedule_notrace);
>  		preempt_dynamic_enable(irqentry_exit_cond_resched);
>  		if (mode != preempt_dynamic_mode)
> -			pr_info("Dynamic Preempt: full\n");
> +			pr_info("%s: full\n", PREEMPT_MODE);
>  		break;
>  	}
>  
>  	preempt_dynamic_mode = mode;
>  }
>  
> -void sched_dynamic_update(int mode)
> -{
> -	mutex_lock(&sched_dynamic_mutex);
> -	__sched_dynamic_update(mode);
> -	mutex_unlock(&sched_dynamic_mutex);
> -}
> -
>  #ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
>  
>  static int klp_cond_resched(void)
> @@ -8873,51 +8925,6 @@ void sched_dynamic_klp_disable(void)
>  
>  #endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
>  
> -static int __init setup_preempt_mode(char *str)
> -{
> -	int mode = sched_dynamic_mode(str);
> -	if (mode < 0) {
> -		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
> -		return 0;
> -	}
> -
> -	sched_dynamic_update(mode);
> -	return 1;
> -}
> -__setup("preempt=", setup_preempt_mode);
> -
> -static void __init preempt_dynamic_init(void)
> -{
> -	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
> -		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
> -			sched_dynamic_update(preempt_dynamic_none);
> -		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
> -			sched_dynamic_update(preempt_dynamic_voluntary);
> -		} else {
> -			/* Default static call setting, nothing to do */
> -			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
> -			preempt_dynamic_mode = preempt_dynamic_full;
> -			pr_info("Dynamic Preempt: full\n");
> -		}
> -	}
> -}
> -
> -#define PREEMPT_MODEL_ACCESSOR(mode) \
> -	bool preempt_model_##mode(void)						 \
> -	{									 \
> -		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
> -		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
> -	}									 \
> -	EXPORT_SYMBOL_GPL(preempt_model_##mode)
> -
> -PREEMPT_MODEL_ACCESSOR(none);
> -PREEMPT_MODEL_ACCESSOR(voluntary);
> -PREEMPT_MODEL_ACCESSOR(full);
> -
> -#else /* !CONFIG_PREEMPT_DYNAMIC */
> -
> -static inline void preempt_dynamic_init(void) { }
> -
>  #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
>  
>  /**
> -- 
> 2.31.1
> 


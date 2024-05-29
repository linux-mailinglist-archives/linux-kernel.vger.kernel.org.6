Return-Path: <linux-kernel+bounces-193849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81D8D3315
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FACE1C23DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B8167DB1;
	Wed, 29 May 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CXCd440G"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A0175B1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975143; cv=none; b=GbQyVxa/z0KhOljHl2aC4WpzPIeZ3aq7wj/EeaoFEe8YRVHXuWmOKsFvkEN3fIcdPJnz+uwZe52DVTj+d9gDwajsY7Ul2MF/3phfv8sWFKIWQBW/XY0GGlsP5g/IQabXR+8vnSgUpAj7CQHLAYSIyXaoRLNaDuQHHlJT4gWv/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975143; c=relaxed/simple;
	bh=EWAPZgeL3+uGu8UqpwB3Q+nWlC0SjXpgLPpxeANvK5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EULACt7GRcGrUXtH6TGcWXzeXEV35nALnLs2SJMTrGc6thMbltwKWH9Z4YTkI8wuwXZaWAyAKZZVRz482Jy9H4Za6Qg4LsO3JavKRj9pNRp0jVK8IxEjh74qbJIox5Pna9ucl6triwT/QlceMrBe4DFKBEv1dKuR4PCZlu4z7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CXCd440G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/gJb3HA1e2GgiV5CyomcmHGNAjwVDxaf7X6WiAqGPqA=; b=CXCd440Gy7nH0JmVHLFiesU09E
	0rx+Im+5GNTK58jHI/wLeJUMHCyA5B+cOFlXXgTsxvzt7TTEHtDnhUSN4A46nyxeq31JymsP3yeV8
	Zaqpj/JdjhJn0uJUq0MOlujRsrvw5c0n9GjmTld0Mx/dADwpFz43j4+0hxJ6XANRguzi7n1X2BGJC
	fWw6WMrL6Nh3NvaZI2iJ4hUbaaiGtDAv24vPw2Gr8HGArgeM12o8V9cNUrrJ1Ji7VeEsNivIir+m3
	+NrJfrVblorPnqGJkC9pmGdErC09WxJdfUplJGJUCMFdirlGaEg1gCjbQO5Wz0vXfQbpss4T3duUd
	neiTTp1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCFfC-0000000DWvX-35jf;
	Wed, 29 May 2024 09:32:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A43EE30073F; Wed, 29 May 2024 11:32:03 +0200 (CEST)
Date: Wed, 29 May 2024 11:32:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 21/35] sched: prepare for lazy rescheduling in
 resched_curr()
Message-ID: <20240529093203.GK26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-22-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-22-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:35:07PM -0700, Ankur Arora wrote:

> @@ -1041,25 +1041,34 @@ void wake_up_q(struct wake_q_head *head)
>  void resched_curr(struct rq *rq)
>  {
>  	struct task_struct *curr = rq->curr;
> +	resched_t rs = RESCHED_NOW;
>  	int cpu;
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	if (__test_tsk_need_resched(curr, RESCHED_NOW))
> +	/*
> +	 * TIF_NEED_RESCHED is the higher priority bit, so if it is already
> +	 * set, nothing more to be done.
> +	 */
> +	if (__test_tsk_need_resched(curr, RESCHED_NOW) ||
> +	    (rs == RESCHED_LAZY && __test_tsk_need_resched(curr, RESCHED_LAZY)))
>  		return;
>  
>  	cpu = cpu_of(rq);
>  
>  	if (cpu == smp_processor_id()) {
> -		__set_tsk_need_resched(curr, RESCHED_NOW);
> -		set_preempt_need_resched();
> +		__set_tsk_need_resched(curr, rs);
> +		if (rs == RESCHED_NOW)
> +			set_preempt_need_resched();
>  		return;
>  	}
>  
> -	if (set_nr_and_not_polling(curr))
> -		smp_send_reschedule(cpu);
> -	else
> +	if (set_nr_and_not_polling(curr, rs)) {
> +		if (rs == RESCHED_NOW)
> +			smp_send_reschedule(cpu);

I'm thinking this wants at least something like:

		WARN_ON_ONCE(rs == RESCHED_LAZY && is_idle_task(curr));


> +	} else {
>  		trace_sched_wake_idle_without_ipi(cpu);
> +	}
>  }
>  
>  void resched_cpu(int cpu)


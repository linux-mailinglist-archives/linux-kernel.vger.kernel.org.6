Return-Path: <linux-kernel+bounces-170853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E758BDCF1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D83E2846B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF813C8FB;
	Tue,  7 May 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dxMNaAMh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3113C667;
	Tue,  7 May 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069314; cv=none; b=PVydSUl5oZY1tDdh3iMKK4omPy1ApwfUED7n+0+jX8Z4/bCIz1N+eGjPVhcyH2Xr6+BdAficLIQVtr9EpaLTVyTr5m8A36PslsLJpOIvl0nrq1Yos+C8hcFo2r0+8E6B57QRbLFIwiVMqufeBGAODvKRsT7i1eamnCC20HfOjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069314; c=relaxed/simple;
	bh=EWayG2dooI4l80D4YPv+uZuesHLcm/Cr3UnEsBDEcYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMNVv5mInEUMbuXvNSG18BOZpdeI46QCN2ytbibjZlH3WAs9xyFdQ2sVN/IhdiAdovv4lSao9+Xvkq34hS9N0s7k3wFd3F3yzxWCeELYwVjI9rxSfTFnoQsYnVsheqzSkXJ3SFOg35u4xuy7otRplopH9w7vGaukzmXvj5y0Bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dxMNaAMh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mwrUGiZ0asXgwHyY2TVTmTc3sgOxDoElawtH7VwSdAg=; b=dxMNaAMhkKp+u5Tf42Mj3ImcKi
	OAVk7QxxSNtkMfxBYyMJw7PQ7YrnAd0UXs844ZTpEeKdHGhUL4pKtZTLDqa8xm9G8WVDh+ZQFxdzw
	oWhpAK5vz++tK0pjvjxAlrGmiKFI0FXTJcsu/B+W3e7ZzdMOnhfmj8FyvcGJHd4eAeHV5KCsRsD+s
	Peh+iAagKMZzuw0A3kAvI3S9PIJQCF3v9bs3hCVlDMOhwCgQ9Mll1FaO6YK4RcxWf9BU9M7uUrInT
	nUJhoEdX8TMFD5ZcrmxkG0DLSUovFBpx8iDSNrBNno5t3kU7FWCfS4dGoM2F54w9uDeZJkLAxS4nh
	CUb9GCow==;
Received: from [24.132.130.84] (helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Fmq-0000000218z-1JFp;
	Tue, 07 May 2024 08:05:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6F9D8300276; Tue,  7 May 2024 10:02:30 +0200 (CEST)
Date: Tue, 7 May 2024 10:02:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
Message-ID: <20240507080230.GP40213@noisy.programming.kicks-ass.net>
References: <20240505233103.168766-1-qyousef@layalina.io>
 <20240506100509.GL40213@noisy.programming.kicks-ass.net>
 <20240507005659.d4rzzaoq3isanndf@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507005659.d4rzzaoq3isanndf@airbuntu>

On Tue, May 07, 2024 at 01:56:59AM +0100, Qais Yousef wrote:

> Yes. How about this? Since stopper class appears as RT, we should still check
> for this class specifically.

Much nicer!

> static inline void update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> {
> #ifdef CONFIG_CPU_FREQ
> 	if (likely(fair_policy(current->policy))) {
> 
> 		if (unlikely(current->in_iowait)) {
> 			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> 			return;
> 		}
> 
> #ifdef CONFIG_SMP
> 		/*
> 		 * Allow cpufreq updates once for every update_load_avg() decay.
> 		 */
> 		if (unlikely(rq->cfs.decayed)) {
> 			rq->cfs.decayed = false;
> 			cpufreq_update_util(rq, 0);
> 			return;
> 		}
> #endif
> 		return;
> 	}
> 
> 	/*
> 	 * RT and DL should always send a freq update. But we can do some
> 	 * simple checks to avoid it when we know it's not necessary.
> 	 */
> 	if (task_is_realtime(current)) {
> 		if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV) {
> 			/* Ignore sugov kthreads, they're responding to our requests */
> 			return;
> 		}
> 
> 		if (rt_task(current) && rt_task(prev)) {

doesn't task_is_realtime() impy rt_task() ?

Also, this clause still includes DL tasks, is that okay?

> #ifdef CONFIG_UCLAMP_TASK
> 			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> 			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> 
> 			if (curr_uclamp_min == prev_uclamp_min)
> #endif
> 				return;
> 		}
> 
> #ifdef CONFIG_SMP
> 		if (unlikely(current->sched_class == &stop_sched_class))
> 			return;
> #endif
> 
> 		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> 		return;
> 	}
> 
> 	/* Everything else shouldn't trigger a cpufreq update */
> 	return;
> #endif
> }


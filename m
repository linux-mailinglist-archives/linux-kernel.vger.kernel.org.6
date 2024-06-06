Return-Path: <linux-kernel+bounces-204811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DFC8FF3CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE12F1C27128
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9A1991B4;
	Thu,  6 Jun 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pHqsDa9b"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8F197A6A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695149; cv=none; b=TrWTK7rGskRexjGt2c8xdH+GEmt64nz05PTdt2VS6m6Bbmvdv6posjaEpHDXosO4FjlVXGKJI61rci6HLhze5FVVwBLwTThXLRWZ0LNvVy2XCInZBBRfxYBMJDopWh5ZOW5r/fIXf3yTNnzBWy4w5TkQDVapCZu2ZGSe43zY4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695149; c=relaxed/simple;
	bh=dlYFinXfCkxNrRnud10X4800BIN5HA363aSLpULQkTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0LokOjNPSjoHzduoszze4vkxMOYi5RbULD0JTqULF2Od5OTgCdJm/PGy/dHzs14AxDlwSn9Tq280gkBf9pC26W+tw3L43Cv0Ha/Ix11SYMlOJGwwpdgp3u/OKL2AW1w8PdNvIFiCJakrkSnNJ3Ul1RAoPMC5nqDeHxPnzLggHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pHqsDa9b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HH8pCn4DL4peY1ACh84eGN/5aYBN7dsVAbiZCE/SC3E=; b=pHqsDa9bCO8k4DpIEEZZiEQSj1
	T4WO23ahJ4Mo7ulaAkoBzMkK8MWD1SPMNQlQWhb+YngEqCzHZQ0l3UUCpy3+b/CplLiy3ECYKiNXv
	6nuHEQGA/GmiLA530F/dYTnDTgboTJhEesws29D9b9Q0zKnTH13s52V2EkS3xnvrCW2VmrcJu9WB/
	hLcCPkg7OuAGHdvIM77dFuPLSFpIf6Ti+Mi6S8LTT817rgu/HiTzmnFrdtYXDxZKa17gNINsJz9Oq
	2zj74dWgtihfDVl74/KeTR5DHVqeb6vtynL7OndhXnDmR5cjaD3ihg5SHI9ehVIlIsUNAm06hwHGq
	BPRMU+Sg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFGyI-00000001fvU-3mnB;
	Thu, 06 Jun 2024 17:32:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 87E3D30047C; Thu,  6 Jun 2024 19:32:18 +0200 (CEST)
Date: Thu, 6 Jun 2024 19:32:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
Message-ID: <20240606173218.GH8774@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-14-ankur.a.arora@oracle.com>
 <20240528162725.GH26599@noisy.programming.kicks-ass.net>
 <87ttif641i.fsf@oracle.com>
 <20240606115101.GC8774@noisy.programming.kicks-ass.net>
 <87ikymw1g2.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikymw1g2.fsf@oracle.com>

On Thu, Jun 06, 2024 at 08:11:41AM -0700, Ankur Arora wrote:
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Thu, May 30, 2024 at 02:29:45AM -0700, Ankur Arora wrote:
> >>
> >> Peter Zijlstra <peterz@infradead.org> writes:
> >>
> >> > On Mon, May 27, 2024 at 05:34:59PM -0700, Ankur Arora wrote:
> >> >> Reuse sched_dynamic_update() and related logic to enable choosing
> >> >> the preemption model at boot or runtime for PREEMPT_AUTO.
> >> >>
> >> >> The interface is identical to PREEMPT_DYNAMIC.
> >> >
> >> > Colour me confused, why?!? What are you doing and why aren't just just
> >> > adding AUTO to the existing DYNAMIC thing?
> >>
> >> You mean have a single __sched_dynamic_update()? AUTO doesn't use any
> >> of the static_call/static_key stuff so I'm not sure how that would work.
> >
> > *sigh*... see the below, seems to work.
> 
> Sorry, didn't mean for you to have to do all that work to prove the
> point.

Well, for a large part it was needed for me to figure out what your
patches were actually doing anyway. Peel away all the layers and this is
what remains.

> I phrased it badly. I do understand how lazy can be folded in as
> you do here:
> 
> > +	case preempt_dynamic_lazy:
> > +		if (!klp_override)
> > +			preempt_dynamic_disable(cond_resched);
> > +		preempt_dynamic_disable(might_resched);
> > +		preempt_dynamic_enable(preempt_schedule);
> > +		preempt_dynamic_enable(preempt_schedule_notrace);
> > +		preempt_dynamic_enable(irqentry_exit_cond_resched);
> > +		preempt_dynamic_key_enable(preempt_lazy);
> > +		if (mode != preempt_dynamic_mode)
> > +			pr_info("Dynamic Preempt: lazy\n");
> > +		break;
> >  	}
> 
> But, if the long term goal (at least as I understand it) is to get rid
> of cond_resched() -- to allow optimizations that needing to call cond_resched()
> makes impossible -- does it make sense to pull all of these together?

It certainly doesn't make sense to add yet another configurable thing. We
have one, so yes add it here.

> Say, eventually preempt_dynamic_lazy and preempt_dynamic_full are the
> only two models left. Then we will have (modulo figuring out how to
> switch over klp from cond_resched() to a different unwinding technique):
> 
> static void __sched_dynamic_update(int mode)
> {
>         preempt_dynamic_enable(preempt_schedule);
>         preempt_dynamic_enable(preempt_schedule_notrace);
>         preempt_dynamic_enable(irqentry_exit_cond_resched);
> 
>         switch (mode) {
>         case preempt_dynamic_full:
>                 preempt_dynamic_key_disable(preempt_lazy);
>                 if (mode != preempt_dynamic_mode)
>                         pr_info("%s: full\n", PREEMPT_MODE);
>                 break;
> 
> 	case preempt_dynamic_lazy:
> 		preempt_dynamic_key_enable(preempt_lazy);
> 		if (mode != preempt_dynamic_mode)
> 			pr_info("Dynamic Preempt: lazy\n");
> 		break;
>         }
> 
>         preempt_dynamic_mode = mode;
> }
> 
> Which is pretty similar to what the PREEMPT_AUTO code was doing.

Right, but without duplicating all that stuff in the interim.


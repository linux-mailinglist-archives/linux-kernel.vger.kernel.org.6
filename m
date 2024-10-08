Return-Path: <linux-kernel+bounces-355444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E403995254
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57622287D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC021E00A5;
	Tue,  8 Oct 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkbtJF7R"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582001DFE3B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398920; cv=none; b=kqimYqsn1SO1GwPPdy8aoLSXOzt9iP7Zi28j5M363fIsRfOmOzTrzzjW1X//iAit8h1NYOqB2DB2iEjkIcE/WahvL0EaPmyNAIteOI8IMBFlTt9ol3LIIcUb0ApykJvTd2DL4CnFLRbqO0eqSmi6iMt8ZOLlQCFk6k4//vwoxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398920; c=relaxed/simple;
	bh=GfO3ftx8Cd/IbPp9FfCFYBOKg9ZTjzzfneLa82iMQvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxTXg6PvWyH3xW1of/ot7eqWbcDZPGJ25pUWLP1p+CrOX6f/8X09wNsBZcK//gyTXhs/Vtj/AVq+j6ykFURt8Dj73jiQANMXuwJLx0Jh30X9R8Ef0IO4etlIicZkdNGMF9yYNiyiQ39yM4aCB/TlZVerSoUyRXtRpPi3VV7271c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hkbtJF7R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c7ppkgOov6PMhnPJBNZzT6Rv5WIKoZCH+9MiueHIsCw=; b=hkbtJF7RtB5vQQyn/7GchQetl6
	4yS2PBbMp+zQ9dNVi0PIfEurKdP6JqwZM+RS8r68xe5Gcob8HoF4sYsj7I0sdg/Gk6A72zpKaxh81
	nujR+/WWdoWbOf99z46SemO/61D0uO1XDwFXg88pD0V342GXue3fs4F3uYuKFT6sW2/jLpalE33Yx
	eJtWsLVZB0ix7KT3V+iGF1M3FFu76npEjuiqH0cPuaE+gihVLfSoTuPBJw0BR5heGlhtnjUGMgkUi
	ABrgsqO4KODM6we3k1QLLKPfCn8NF5iJ94PPfySt3cG/7xCy3O4gcBvujQSO+MWUIyf1aGPaVjZ28
	xJU2ixPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syBVk-00000002Y3S-3tcj;
	Tue, 08 Oct 2024 14:48:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 33BD9300C1F; Tue,  8 Oct 2024 16:48:29 +0200 (CEST)
Date: Tue, 8 Oct 2024 16:48:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
Message-ID: <20241008144829.GG14587@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
 <877cajdu8x.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cajdu8x.fsf@oracle.com>

On Mon, Oct 07, 2024 at 10:43:58PM -0700, Ankur Arora wrote:

> > @@ -519,7 +525,7 @@ static inline bool preempt_model_rt(void
> >   */
> >  static inline bool preempt_model_preemptible(void)
> >  {
> > -	return preempt_model_full() || preempt_model_rt();
> > +	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
> >  }
> 
> In addition to preempt_model_preemptible() we probably also need
> 
>   static inline bool preempt_model_minimize_latency(void)
>   {
>   	return preempt_model_full() || preempt_model_rt();
>   }
> 
> for spin_needbreak()/rwlock_needbreak().
> 
> That would make the behaviour of spin_needbreak() under the lazy model
> similar to none/voluntary.

That whole thing needs rethinking, for one the preempt_model_rt() one
doesn't really make sense anymore at the end of this.

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1078,6 +1078,9 @@ static void __resched_curr(struct rq *rq
> >
> >  	lockdep_assert_rq_held(rq);
> >
> > +	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
> > +		tif = TIF_NEED_RESCHED;
> > +
> 
> Tasks with idle policy get handled at the usual user space boundary.
> Maybe a comment reflecting that?

is_idle_task() != SCHED_IDLE. This is about the idle task, which you
want to force preempt always. But I can stick a comment on.

> > @@ -5598,6 +5627,10 @@ void sched_tick(void)
> >  	update_rq_clock(rq);
> >  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> >  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> > +
> > +	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> > +		resched_curr(rq);
> > +
> 
> So this works for SCHED_NORMAL. But, does this do the right thing for
> deadline etc other scheduling classes?

Yeah, only fair.c uses resched_curr_laz8(), the others still use
resched_curr() and will work as if Full.

So that is: SCHED_IDLE, SCHED_BATCH and SCHED_NORMAL/OTHER get the lazy
thing, FIFO, RR and DEADLINE get the traditional Full behaviour.


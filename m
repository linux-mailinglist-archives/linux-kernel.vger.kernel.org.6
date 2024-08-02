Return-Path: <linux-kernel+bounces-272941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1194629B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E4285C23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E8165F0A;
	Fri,  2 Aug 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LwWD0FrF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F111AE02B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620232; cv=none; b=cDNVzr10pMora6YcB2tdDAYX2LcXn2zFg0DdyRzbkccgQgRxu3PV1nsbAdi2Yam6Q0pgIRIk8fgDpCiIYvZnJCUNpD8fi+2KGaJPOGXmNhQcasX8L0EaxKUWu1dWQt1ixPl5IbJXcexjWZsS9/LxPUAbjnUIrHiZy7uJDz1UWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620232; c=relaxed/simple;
	bh=mdQg6/rJnHNyjDJ3RviHmWMeky72HxfLDggfK36J9r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewa7I0+TA4Ua4Dc5fJtKvNiU2P/UqkF4ZlGvzeqn+jyjldLTHNvjk1PdV07H0//XmTUOp1P3XrhUYrZoy5rrw8HENtayNd9Xlf6LOL7UBIZ2BIC/NYUbV941Dz9Ubk9HsnqdXCQ/4c1Vuwfu36HcofXiAvxuo2856Rv74lg11C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LwWD0FrF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TpMme9o8L0FB33WSeYfbPRcV2DUGnUsz5ZsE80TtxhY=; b=LwWD0FrF4C99NN2wEUoHWr9XFr
	fqMVetzuxy1MZHEF+MDhwP5eiRVKt/QFziM6YU6T2oNtdp1rECntps8FXOpkb7kgjuJkhRjLFszvy
	69ezVet+tBk5aFN9imHNQ7gv9ScQLkHcpplKHCHzpfNUauQ+kYtS1XmFayTiCQ2rVbDE6UdOia4s4
	smxh+Knci+l+fgJi/dzpmVu7vZor5gZjQM6LSaZZZ0JJCd391JwG8sg3it61q1FPafyP3YLe/0XZx
	TuIg8N3988wP/pCkB/5ELbrG60lcsAVcSJfl4RlDnv7lXJU0jqdhdgs55QJ4vcPR2TxfolF+64vNB
	9DmYOE1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZwDD-00000005lTE-0RNM;
	Fri, 02 Aug 2024 17:37:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B99ED30049D; Fri,  2 Aug 2024 19:37:06 +0200 (CEST)
Date: Fri, 2 Aug 2024 19:37:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240802173706.GO39708@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240802111018.GI39708@noisy.programming.kicks-ass.net>
 <Zq0En8pFfgzH0HMH@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq0En8pFfgzH0HMH@slm.duckdns.org>

On Fri, Aug 02, 2024 at 06:09:03AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Aug 02, 2024 at 01:10:18PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2024 at 03:36:27PM -1000, Tejun Heo wrote:
> ...
> > > Maybe, but at the same time, it's also just some isolated cruft that enables
> > > UP support, so both sides of the scale seem similarly light-weight? I lean
> > > towards "why not support it?" but don't feel particularly strongly about it.
> > 
> > So you're basically looking for something like this?
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a9f655025607..69ec02a28117 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5772,7 +5772,6 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >  static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> >  				  struct rq_flags *rf)
> >  {
> > -#ifdef CONFIG_SMP
> >  	const struct sched_class *class;
> >  	/*
> >  	 * We must do the balancing pass before put_prev_task(), such
> > @@ -5783,10 +5782,9 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> >  	 * a runnable task of @class priority or higher.
> >  	 */
> >  	for_class_range(class, prev->sched_class, &idle_sched_class) {
> > -		if (class->balance(rq, prev, rf))
> > +		if (class->balance && class->balance(rq, prev, rf))
> >  			break;
> >  	}
> > -#endif
> >  
> >  	put_prev_task(rq, prev);
> >  }
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 4c36cc680361..40f3dc436f4f 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2296,8 +2296,8 @@ struct sched_class {
> >  	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
> >  	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
> >  
> > -#ifdef CONFIG_SMP
> >  	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
> > +#ifdef CONFIG_SMP
> >  	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
> >  
> >  	struct task_struct * (*pick_task)(struct rq *rq);
> 
> Yes, exactly. This is how it was implemented in the first RFC patchset. If
> you're okay with the above, I'd love to go back to it.

Yeah, I don't find I can make myself care for SMP=n much. So lets just
do that.


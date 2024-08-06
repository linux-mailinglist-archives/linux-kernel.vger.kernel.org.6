Return-Path: <linux-kernel+bounces-275870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1874948B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D441F22B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674931BD011;
	Tue,  6 Aug 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oNkFNfgL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6DF1BCA06
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932844; cv=none; b=dnvkzYLpCKHMR0ftj4aA0an6o24IZrLINwRRDlPyX3yBc52tVRWBxCv5t5rihyB7mczMiCoNzMYPlQLeC54e/6C1q/eK/dE4qsBZqEi7cIOu2qIwfzT6c4J5ymF3azAFsvzlGXgP/7ToaYEqvtjOcJ1T4Q4W/eLEg3rnS55y6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932844; c=relaxed/simple;
	bh=eIesG8t60+K8FeaonUdws/9nqAlhzL9g5yfZvQx+N1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6UGAwJnRCdhBDUGa41soY6ZXIn7QLmRqljvnp4QetsymC1RoGKT9rEwJ5qTTyXNvnldxIDjux7cvnxAMbZpJvSi+SAHN5+yHZBy7Qt4KmiRDlZ4OB7v96QL1qM6eb1Zu3vdrRFdWQNc+2Ve+dJ7XBcTRSG8TS35k3ZKCogOJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oNkFNfgL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gGf1RRMLsvUqCDo/9XbUQDO+27CXmxKKBoYyC5G8/rg=; b=oNkFNfgLGqDL52M/3JAZQ/hjHi
	yo7Xzbi9gXLhBsdoGUKv8tOP/WfubI70Cg8H6VF+Rotgz+cjHeFZg2Jcibhbfq/QpAJUjgUOjovol
	y2Bk98ExWzGvW+C1BVixGcqgO72ONyWGatv6Cvm/Ykj5uGz5MlbmhdMHhCJ2IQeFvqu5lkc3FD+u9
	nxQK7dPIro4nvLoqdSCYh9EvdvnXhB9Tw3NopugJj8sI0BYjSdGbxJ0mM3Vak9Gjs26UINuffKKiD
	OfJOFqBAxE4VKxfk0/yYT19qtf36uv4/fQ9BNNyAZb8+yYB3VG9vO/o9dDFW5a+Iiho87BdOWLCoc
	YHDYavyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFXJ-00000005Rcc-06kN;
	Tue, 06 Aug 2024 08:27:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3FD4B30049D; Tue,  6 Aug 2024 10:27:16 +0200 (CEST)
Date: Tue, 6 Aug 2024 10:27:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240806082716.GP37996@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <20240802122034.GZ12673@noisy.programming.kicks-ass.net>
 <Zq0p154ndOtU9Ypu@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq0p154ndOtU9Ypu@slm.duckdns.org>

On Fri, Aug 02, 2024 at 08:47:51AM -1000, Tejun Heo wrote:

> > > +static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
> > > +				struct task_struct *p, struct rq *task_rq)
> > > +{
> > > +	bool moved = false;
> > > +
> > > +	lockdep_assert_held(&dsq->lock);	/* released on return */
> > > +
> > > +	/*
> > > +	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
> > > +	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
> > > +	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
> > > +	 * rq lock or fail, do a little dancing from our side. See
> > > +	 * move_task_to_local_dsq().
> > > +	 */
> > > +	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> > > +	task_unlink_from_dsq(p, dsq);
> > > +	dsq_mod_nr(dsq, -1);
> > > +	p->scx.holding_cpu = raw_smp_processor_id();
> > > +	raw_spin_unlock(&dsq->lock);
> > > +
> > > +	double_lock_balance(rq, task_rq);
> > > +
> > > +	moved = move_task_to_local_dsq(rq, p, 0);
> > > +
> > > +	double_unlock_balance(rq, task_rq);
> > > +
> > > +	return moved;
> > > +}
> > 
> > I've gotta ask, why are you using the double_lock_balance() pattern
> > instead of the one in move_queued_task() that does:
> > 
> >   lock src
> >   dequeue src, task
> >   set_task_cpu task, dst
> >   unlock src
> > 
> >   lock dst
> >   enqueue dst, task
> >   unlock dst
> 
> When !CONFIG_PREEMPTION, double_lock_balance() seems cheaper than unlocking
> and locking unconditionally. Because SCX schedulers can do a lot more hot
> migrations, I thought it'd be better to go that way. I haven't actually
> measured anything tho, so I could be wrong.

So I think the theory is something like this.

If you take a spinlock, you wait-time W is N times the hold-time H,
where the hold-time is avg/max (depending on your analysis goals) time
you hold the lock for, and N is the contention level or number of
waiters etc.

Now, when you go nest locks, your hold-time increases with the wait-time
of the nested lock. In this case, since it's the 'same' lock, your
hold-time gets a recursive wait-time term, that is: H'=H+N*H.

This blows up your wait-time, which makes contention worse. Because what
was W=N*H then becomes W=N*(N*H).

Anyway, at the time we saw great benefits from moving away from the
double-lock thing, it might be worth looking into when/if you see
significant lock contention; because obviously if the locks are not
contended it all doesn't matter.


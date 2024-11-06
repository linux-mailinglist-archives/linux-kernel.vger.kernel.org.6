Return-Path: <linux-kernel+bounces-398376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE999BF087
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3655B24E55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390961F9EB5;
	Wed,  6 Nov 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d/6XbqOJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A791CF2A0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903913; cv=none; b=OZXmA4BhQIs6eibLFFY0thlRZ0ATj3aLdYEF3HlKsE47JIbNqPNop5JAAgCJk0+XKZVGlrMkSweRfPQ+RyP9JoeGkhhVVCakNd0y8wuH37MnbjZnjUc2eZK1bBhQjWdKzioklBr65uZAXXUCFCsXw5UagIblvIDhOJVrjIIJRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903913; c=relaxed/simple;
	bh=y51ap+5t1SHbXH+M9o+TuvUtQT2Tl+VGIXKO1A2W3OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuVKvE4P2C6r/AxIPNzFfwMjOJEw/P9LGJ5cR8oipWuNwTEKHJSJlLkmKA752I89PP3qL0Q2LpFNdePqQozQGh7XaBFjSGwpNHhIDqEZKKu1CP+25wctzzgd6t9xU9BbX747xsvy0rJlJNogtpp3RAgIyHdvrzwuzOv93kTvWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d/6XbqOJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w3encRiZfvyj6zAtht2HtIL8kEWQoEE8GW/e7NhQ5SY=; b=d/6XbqOJI0r3q6fcMD28wDiiQK
	OJOryUEiGCLOu/ve0vDQOYKQ4PZaCKG58HDAQOOnpTfbXLkLNBD2yvt1ZlxCGcyzF/b0tGshSj3e0
	7g8klJxvs6lW1+IiXoVTKalU8V1/FLAQLZcoCl+PLBzh13fTIzNDYqEu3MGIhXieVJjOn0jPWm8YV
	7XA/MqI/EVcDBVESH+k5xOitPE72R8zjH0YblGmMvDx0svd44B7BZ12zMlwp9jBjKHr7jdFqW6Ut8
	v1btFK0qr+Obv8IDfG1/Iu75HgwBjE/TL1z8f4I59inm2WrAZ98jJhwybTkBq+1mnsVG+nx6N2Xdh
	ZbYPUsZg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8hAs-00000004j6f-0xmH;
	Wed, 06 Nov 2024 14:38:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25146300478; Wed,  6 Nov 2024 15:38:22 +0100 (CET)
Date: Wed, 6 Nov 2024 15:38:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241106143822.GA33184@noisy.programming.kicks-ass.net>
References: <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106141420.GZ33184@noisy.programming.kicks-ass.net>

On Wed, Nov 06, 2024 at 03:14:20PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 06, 2024 at 02:53:46PM +0100, Peter Zijlstra wrote:
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 54d82c21fc8e..b083c6385e88 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3774,28 +3774,38 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
> >   */
> >  static int ttwu_runnable(struct task_struct *p, int wake_flags)
> >  {
> > +	CLASS(__task_rq_lock, rq_guard)(p);
> > +	struct rq *rq = rq_guard.rq;
> >  
> > +	if (!task_on_rq_queued(p))
> > +		return 0;
> > +
> > +	update_rq_clock(rq);
> > +	if (p->se.sched_delayed) {
> > +		int queue_flags = ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
> > +
> > +		/*
> > +		 * Since sched_delayed means we cannot be current anywhere,
> > +		 * dequeue it here and have it fall through to the
> > +		 * select_task_rq() case further along the ttwu() path.
> > +		 */
> > +		if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
> > +			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
> > +			return 0;
> >  		}
> > +
> > +		enqueue_task(rq, p, queue_flags);
> 
> And then I wondered... this means that !task_on_cpu() is true for
> sched_delayed, and thus we can move this in the below branch.
> 
> But also, we can probably dequeue every such task, not only
> sched_delayed ones.
> 
> >  	}
> > +	if (!task_on_cpu(rq, p)) {
> > +		/*
> > +		 * When on_rq && !on_cpu the task is preempted, see if
> > +		 * it should preempt the task that is current now.
> > +		 */
> > +		wakeup_preempt(rq, p, wake_flags);
> > +	}
> > +	ttwu_do_wakeup(p);
> >  
> > +	return 1;
> >  }
> 
> 
> Yielding something like this on top... which boots. But since I forgot
> to make it a feature, I can't actually tell at this point.. *sigh*

It dies real fast, so clearly I'm missing something. Oh well.


Return-Path: <linux-kernel+bounces-445762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEF9F1B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594197A0273
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD010E9;
	Sat, 14 Dec 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gn/WWb+1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21993219E0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734135038; cv=none; b=Id3w62nqiSh6UBivBwaKy4ddyT2PH5l7SoQV/KtuC6m+9GLRM9ayLhdaJ+mG8dRt3068qkRr6Ty2uYHlUGHW0ZXa5nyoBRp/w+2zD64B+CYi2gkVqbzLPUeDg6rQWyue3pUF8/aIXhJZdYBDfkWMbBQpxzKHPQLy50vKqlJ2DTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734135038; c=relaxed/simple;
	bh=mHn8mfJErqxB5H4WshLQA9vyr6rqYDo3kQ8HAoLsBHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9pNjED4U0NzlJvMahfybxNm4YxdJrBLihELs7KRCCUZb8U8CoOkzuRbb+36HmNfZ8O4vfNpxKMU9TWtR/xLxp7R9p8JXxoLKOSSrn08/enPoDqjJS+O9uLMkxCrco0OpdxXpMevpySOq/2XULCLgyLYkqIxjXqCHzVEurtmlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gn/WWb+1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OmiJxOeNnPjvpvuJCX8ychQ11vYzyL9LLXwO+uAyIqE=; b=gn/WWb+11oriupvv3H984R25Tt
	9MLln4VV+Komz5LkwbSvpSiQqpbjT+1D+JbTaG1haGQzAJTKjVfB5RYdEiGL7cqP8Fj4ma+bxqeJR
	9mBsxjCh8DgmuKSTdI6qgCIATWagOMA1uHecnr9Ncxvbzi8iPPnSrsrogFLDfelStcv9japk5+SG3
	5w9/fOBkMhtT1Kh7q1S5P+ja/bouqWVGvAOeCFa0b+brtC9cBrEi8jsVDCCSn9HWRtIg+2N7qVcTG
	E/TKwp7+7wjvHgfOJcXXCuQNX9AjA76obX3AyAQ1In1/dlBMppYYi6P8Qr2zdJ9m85Aw+a6CSfVem
	NfMBwoSQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMFjE-00000004Mel-24vY;
	Sat, 14 Dec 2024 00:10:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74EC630049D; Sat, 14 Dec 2024 01:09:51 +0100 (CET)
Date: Sat, 14 Dec 2024 01:09:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Subject: Re: [RFC][PATCH v14 3/7] sched: Fix runtime accounting w/ split exec
 & sched contexts
Message-ID: <20241214000951.GA16123@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-4-jstultz@google.com>
 <20241213233740.GB17501@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213233740.GB17501@noisy.programming.kicks-ass.net>

On Sat, Dec 14, 2024 at 12:37:40AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 25, 2024 at 11:51:57AM -0800, John Stultz wrote:
> 
> 
> 
> > -static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
> > +static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
> >  {
> >  	u64 now = rq_clock_task(rq);
> >  	s64 delta_exec;
> >  
> > -	delta_exec = now - curr->exec_start;
> > +	delta_exec = now - se->exec_start;
> >  	if (unlikely(delta_exec <= 0))
> >  		return delta_exec;
> >  
> > -	curr->exec_start = now;
> > -	curr->sum_exec_runtime += delta_exec;
> > +	se->exec_start = now;
> > +	if (entity_is_task(se)) {
> > +		struct task_struct *running = rq->curr;
> > +		/*
> > +		 * If se is a task, we account the time against the running
> > +		 * task, as w/ proxy-exec they may not be the same.
> > +		 */
> > +		running->se.exec_start = now;
> > +		running->se.sum_exec_runtime += delta_exec;
> > +	} else {
> > +		/* If not task, account the time against se */
> > +		se->sum_exec_runtime += delta_exec;
> > +	}
> >  
> >  	if (schedstat_enabled()) {
> >  		struct sched_statistics *stats;
> >  
> > -		stats = __schedstats_from_se(curr);
> > +		stats = __schedstats_from_se(se);
> >  		__schedstat_set(stats->exec_max,
> >  				max(delta_exec, stats->exec_max));
> >  	}
> 
> Would it not be *much* clearer if we do it like:
> 
> static s64 update_curr_se(struct rq *rq, struct sched_entity *donor,
> 			  struct sched_entity *curr)
> {
> 	...
> 	donor->exec_start = now;
> 	curr->exec_start = now;
> 	curr->sum_exec_runtime += delta_exec;
> 	...
> }
> 
> and update the callsites like so:
> 
> update_curr_common()
> 	update_curr_se(rq, &donor->se, &rq->curr.se)
> 
> update_curr()
> 	update_curr_se(rq, &curr->se, &curr->se);
> 
> 
> except, now I'm confused about the update_curr() case. That seems to
> always update the execution context, rather than the donor ?

Ah no, cfs_rq->curr is the donor.

I'll try again later; or risk keyboard face.. Zzzz




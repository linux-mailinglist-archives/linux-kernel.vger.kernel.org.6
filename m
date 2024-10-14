Return-Path: <linux-kernel+bounces-364282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B49C99D039
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F80286625
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43DC1AA7AE;
	Mon, 14 Oct 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="maUzWCI4"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33011CA8D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918033; cv=none; b=rAYiVbBwb17UGqFnu2o8C7uffXbkthhtUUbjh9aOFcMbO1UjfYhbXnAUrN2Vs5H4i5E6CXyr5en3ItCJUnYEW92gfEf1eUoJRzCk9fca1MaTDQg2ypFQ+oSm9ui8+Kec5kncT+qk1jDOZxUFuls9WBkT72aAV2fUtBSLSZYD3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918033; c=relaxed/simple;
	bh=c9klRdtmfQ1jSeSsmH3rq7gnU/BLvFDWgrhzM6GgnGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZUixzRqRJs2S8y13QmTDIoN0MlsXFuAKeQKuxo6qU40Jb6TPw14eK8+8TFsamj5t2pX/n9/TXHSaql9jG//gpnmJIdSJiDdMtgO4KCngdYv+R00stvnpcqQWPCIi7mMd2rKxEMFRWMMzFraq7RvDjTNEjiM47K998KpzjJ4i88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=maUzWCI4; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 17:00:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728918026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sulRIvdyGva2HvmQHD6chWx2d7ARWFv2QudetJpYFk=;
	b=maUzWCI4w4zRMc744W0WfWhUzCk2BiNKULEwfgB9UD4g+mgCUJYUjx1aLEN/g2+CoY51Sr
	qGh/qF3XgYo+oCeLzY2LvUJMSYKEqvwylBhoXoJND5mji2GOt0lgks+Q/u91ifTJEKkamG
	NM6j2QAxx/uQIT0CSwXf4tcprNlrieo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Always call put_prev_task() with scx enabled
Message-ID: <Zw0yBekifvsv9s2G@gpd3>
References: <20241013173928.20738-1-andrea.righi@linux.dev>
 <20241014083608.GU17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014083608.GU17263@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 10:36:08AM +0200, Peter Zijlstra wrote:
> On Sun, Oct 13, 2024 at 07:39:28PM +0200, Andrea Righi wrote:
> > With the consolidation of put_prev_task/set_next_task(), we are now
> > skipping the sched_ext ops.stopping/running() transitions when the
> > previous and next tasks are the same, see commit 436f3eed5c69 ("sched:
> > Combine the last put_prev_task() and the first set_next_task()").
> > 
> > While this optimization makes sense in general, it can negatively impact
> > performance in some user-space schedulers, that expect to handle such
> > transitions when tasks exhaust their timeslice (see SCX_OPS_ENQ_LAST).
> > 
> > For example, scx_rustland suffers a significant performance regression
> > (e.g., gaming benchmarks drop from ~60fps to ~10fps).
> > 
> > To fix this, ensure that put_prev_task()/set_next_task() are never
> > skipped when the scx scheduling class is enabled, allowing the scx class
> > to handle such transitions.
> > 
> > This change restores the previous behavior, fixing the performance
> > regression in scx_rustland.
> > 
> > Link: https://github.com/sched-ext/scx/issues/788
> 
> How persistent are links like that? In general I strongly discourage
> links to things not pointing to kernel.org resources.

This one persists also after the issue is marked as resolved, I only
added it to provide more context about the problem. However, the the
commit description already contains all the details, so we can probably
get rid of the link.

> 
> > @@ -2523,6 +2508,21 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
> >  #define scx_switched_all()	false
> >  #endif /* !CONFIG_SCHED_CLASS_EXT */
> >  
> > +static inline void put_prev_set_next_task(struct rq *rq,
> > +					  struct task_struct *prev,
> > +					  struct task_struct *next)
> > +{
> > +	WARN_ON_ONCE(rq->curr != prev);
> > +
> > +	__put_prev_set_next_dl_server(rq, prev, next);
> > +
> > +	if (next == prev && !scx_enabled())
> > +		return;
> 
> Does that not also want to include a 'next->sched_class ==
> &ext_sched_class' clause ? And a comment?

Good point.

> 
> > +
> > +	prev->sched_class->put_prev_task(rq, prev, next);
> > +	next->sched_class->set_next_task(rq, next, true);
> > +}
> 
> And is there really no way scx can infer this happened? We just did pick
> after all, that can see this coming a mile of.

I'll do some testing, we can probably infer this in pick_task_scx() and
make adjustments there, or possibly in scx_update_idle() within the idle
class, since that seems to be where the real issue lies.

Thanks for looking at this,
-Andrea


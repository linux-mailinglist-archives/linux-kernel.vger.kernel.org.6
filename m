Return-Path: <linux-kernel+bounces-364369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8999D3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB7528254B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE71ADFEC;
	Mon, 14 Oct 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r87D5XJm"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE91ADFE4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920622; cv=none; b=FOEGdbBRuANL/UkBkL8YLMMM/VwAQrY/0jE4hd+ZeD97qgfCUtuyOqD6K0YojF986uy3XtrKFUc+iT8QSKKQhs50TuP7mGlKaV4TQ1vPjOobwFh736Hkkq9iRTH8DGd6pdrmercNkc8tZ2g63OEvUGGHYgHeC+SCCJY3d4IPbqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920622; c=relaxed/simple;
	bh=r1sb5uWNoptiAeL9yGdUfaOt0UuYamFtPL+AEfq1epA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZVsDTgpm172l8D27Nj9zo3PjcCgIQzkaMnfC+0Re/JV00A5bT7OXKUx2T+MsxM2clV+A02PoBPcDJ5aIhSPlOgL/bhIqKvb9C0fnOa1P4vHfiAZrZ9UOo4tGYdpAzXlwin6JVFd0hV/wisdHCTefTMthqfPTDAC/OVLmlogzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r87D5XJm; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 17:43:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728920617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gQbzq0SBCVNErmwjmVNt/xzC0FXhs9tyXk41hnnLPPk=;
	b=r87D5XJmaAXDDYbXwqXTxr7HD4B3uapOcAl53YLF+uXDXIsJ10bxHPe3989o8KgRJs1poh
	XdoaPU5VGYrwz32cj0zepN8w+NarTWptPPY41nllWNOazm2QHNhtktmim+xkm/zsLOp111
	Sk5b8XA0nofd3JC3nwVNoTtL1RLjANI=
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
Message-ID: <Zw08JUlsm7b8xZk8@gpd3>
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
...
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
> 
> > +
> > +	prev->sched_class->put_prev_task(rq, prev, next);
> > +	next->sched_class->set_next_task(rq, next, true);
> > +}
> 
> And is there really no way scx can infer this happened? We just did pick
> after all, that can see this coming a mile of.

Ah, I believe I understand better what's happening now.

When prev == next with the idle class we're not calling
->put_prev_task/set_next_task anymore, so we may skip calling
ops.update_idle() in scx.

I think that's the only special case that we need to handle, and we may
be able to solve the regression by calling scx_update_idle() from
pick_task_idle().

Will do some testing with this.

-Andrea


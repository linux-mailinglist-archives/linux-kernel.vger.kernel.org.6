Return-Path: <linux-kernel+bounces-363527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B699C37D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE631C221A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140D13D8B0;
	Mon, 14 Oct 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ta1hmdfu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5361A270
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894983; cv=none; b=pU5IyQgCIM+/YZqIjcWacxjNarGgs4HOtkYg1kL/9Xo3CqpfY2F8LXYLpxbhlwGM9OS51izRdJKpTjDLIDj6JAcymt7rDRgbzAU1EILcHmb2zvuMIGjhpqKkx6Ge94DWsXmJXBsZUHtKyOOKd9jo6hViv1rJaoRyZEYj0PMrOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894983; c=relaxed/simple;
	bh=m5aniVC3Z+WNaDtIgb27OroQtk71olXhdhms+he20T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj4QGGiUWRK6SC7f9AwblxvBRYBjTW+Ntg8QwNSWmqV1ALdWTFZE3LXSThUbwwRTgNf7Pfx3nQiW1u16pqrpCzaK5JcCdswWQNQAvmlc9VSp/8kRZZjw+VWcBXPy1foJPulSUiXABZq+3FVK8gWEFHomUI5tNjUIIwggMHr380E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ta1hmdfu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tqdzksLr8USjqPwEK4fkd6EbSESCupOIPQ8Ly0wBFr0=; b=Ta1hmdfuRjHq7MhsCKOGpzksfG
	VpkJq1nwZKQbxayzZ5hpBvmaWFlm1SHuWxHWoETXgpgHnawFQQQK+dsBCimvcM8O3xK/Gt1hrOh99
	vuEAHYpPdVcrpiiRxBUiHPPsKQvhmYBkVBNVgM7cOQ08yEqtCuOz7r0+KqVmf3zuzbQO3oa8VeEfw
	ty6/fqWnRzoly3koMPdR3pzMXh6IpoYTtrOT9Hqp7mKmhC8Vj9EEtKMgzYirJCY9a+16ATribTYpe
	2cpTfhBRr+FBZ9dpQC/i27z+l6BgGOKSBXMma8cg+2WQXdAQLWnfbexy1+JrD6kf5MfedlID1+2ha
	bVoiLvug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0GYh-000000015cF-3hMi;
	Mon, 14 Oct 2024 08:36:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F9DB300777; Mon, 14 Oct 2024 10:36:08 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:36:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Always call put_prev_task() with scx enabled
Message-ID: <20241014083608.GU17263@noisy.programming.kicks-ass.net>
References: <20241013173928.20738-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013173928.20738-1-andrea.righi@linux.dev>

On Sun, Oct 13, 2024 at 07:39:28PM +0200, Andrea Righi wrote:
> With the consolidation of put_prev_task/set_next_task(), we are now
> skipping the sched_ext ops.stopping/running() transitions when the
> previous and next tasks are the same, see commit 436f3eed5c69 ("sched:
> Combine the last put_prev_task() and the first set_next_task()").
> 
> While this optimization makes sense in general, it can negatively impact
> performance in some user-space schedulers, that expect to handle such
> transitions when tasks exhaust their timeslice (see SCX_OPS_ENQ_LAST).
> 
> For example, scx_rustland suffers a significant performance regression
> (e.g., gaming benchmarks drop from ~60fps to ~10fps).
> 
> To fix this, ensure that put_prev_task()/set_next_task() are never
> skipped when the scx scheduling class is enabled, allowing the scx class
> to handle such transitions.
> 
> This change restores the previous behavior, fixing the performance
> regression in scx_rustland.
> 
> Link: https://github.com/sched-ext/scx/issues/788

How persistent are links like that? In general I strongly discourage
links to things not pointing to kernel.org resources.

> @@ -2523,6 +2508,21 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
>  #define scx_switched_all()	false
>  #endif /* !CONFIG_SCHED_CLASS_EXT */
>  
> +static inline void put_prev_set_next_task(struct rq *rq,
> +					  struct task_struct *prev,
> +					  struct task_struct *next)
> +{
> +	WARN_ON_ONCE(rq->curr != prev);
> +
> +	__put_prev_set_next_dl_server(rq, prev, next);
> +
> +	if (next == prev && !scx_enabled())
> +		return;

Does that not also want to include a 'next->sched_class ==
&ext_sched_class' clause ? And a comment?

> +
> +	prev->sched_class->put_prev_task(rq, prev, next);
> +	next->sched_class->set_next_task(rq, next, true);
> +}

And is there really no way scx can infer this happened? We just did pick
after all, that can see this coming a mile of.


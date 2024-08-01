Return-Path: <linux-kernel+bounces-270961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1829447D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC311F28BF6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92763198A10;
	Thu,  1 Aug 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jphi91jP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DD194AC7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503533; cv=none; b=Aw7VUe75cekgcQfVgOJ6QXw5AlSQ5zmFbXdq00UjkMDjaaBPe/8Zvr0UzqaxbcWH2Hiz0PR2JyGuzrb00U8W4AGLeJUJITuTQ9hWGfZPfpfeq0Pg4sosDfLmF+IphfrzSjYVFpTc/gAqngKZObzhpbH6w3C/4TszH+Wp1KdcQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503533; c=relaxed/simple;
	bh=WbUo6wvN5DgA5QNO9T/7o5dXEyMdeickRgDWdNhkdTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd0vhI4wiQCjgkilPWdGbpcLLTPEdtnRIbyWutF1fP21RF/WGqFp838UlMM9x0dyjua89MsOgNITO6noS8rxEKce3GoJ+9fAfuZjSHF3+Im3Ah5iKcQlvW9FjSR2paH+SfeZ8t0fSTxBRSRebq3kwOpUMhD6zURpwpSKMWRHOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jphi91jP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+ESklm0KlyN2z1e99cQP0oeK1j4M6/cU8F519sniAQw=; b=Jphi91jPBUZfR3RcL/kAhRmNnw
	Wk3hkmP5gLaB+STJTkrYoFzO41mKwB7kfWuA6DAkTkMGHEt6xITSJRaxHlqiZHkxFWMm9l794GjC0
	PSSIrO+6B2MuChzU0Fp2FSUq9Nx/IvwcR0rrEXARs6V4zfTkR1zM6L6wXLMSXQS99l+9btIpz7R2e
	6n8cDVtAvq6kp0jVKSka//xmESpNIwJBUyNIQzfB8AGIf4EsTKG3jgmFh4sFE8uFUxOit1lBWDapV
	fuod/8RSxBZ9gvUm4s97pnPSXi3edGlZcRa6auxiasWI9XJdXWxu1D2a+OBJL9P51PYsUuvEvr25C
	2ARneIcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZRqq-00000005Qne-2znd;
	Thu, 01 Aug 2024 09:12:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ED69D30074E; Thu,  1 Aug 2024 11:11:59 +0200 (CEST)
Date: Thu, 1 Aug 2024 11:11:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Hao Jia <jiahao.os@bytedance.com>
Cc: mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/eevdf: Fixed se->deadline possibly being refilled
 twice in yield_task_fair()
Message-ID: <20240801091159.GN33588@noisy.programming.kicks-ass.net>
References: <20240801035906.72603-1-jiahao.os@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801035906.72603-1-jiahao.os@bytedance.com>

On Thu, Aug 01, 2024 at 11:59:06AM +0800, Hao Jia wrote:
> We call update_deadline() in yield_task_fair(), if se->deadline has been
> refilled in update_deadline(). We should avoid filling se->deadline again
> in yield_task_fair().

Why do you think so? This is purely a timing artifact.

update_curr() simplu catches up with the present. That is, consider two
otherwise identical scenarios, that is, both A and B have the exact same
vruntime/deadline and will call yield() at the exact same time. Except,
A will get a timer tick right before it calls yield().

Then A will get update_curr() from the tick and your new check below
will not avoid it getting its deadline pushed out further.

While B will update_curr() in yield() and then does avoid its deadline
being pushed out.

After which A dna B are no longer the same, even though they did the
exact same thing.

So no, I don't think what you propose is right.

update_rq_clock()/update_curr() simply catch up with 'now'. If that
includes pushing out the deadline so be it, that could've been done
right before by any number of scheduling operations and is immaterial
for the action yield() should take itself.

Does that make sense?

> Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>  kernel/sched/fair.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 795ceef5e7e1..b0949e670bc4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8695,6 +8695,7 @@ static void yield_task_fair(struct rq *rq)
>  	struct task_struct *curr = rq->curr;
>  	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
>  	struct sched_entity *se = &curr->se;
> +	u64 deadline_snap = se->deadline;
>  
>  	/*
>  	 * Are we the only task in the tree?
> @@ -8716,6 +8717,14 @@ static void yield_task_fair(struct rq *rq)
>  	 */
>  	rq_clock_skip_update(rq);
>  
> +	/*
> +	 * If se->deadline has been refilled in
> +	 * update_curr()->update_deadline(),
> +	 * skip updating again.
> +	 */
> +	if (READ_ONCE(se->deadline) != deadline_snap)
> +		return;
> +
>  	se->deadline += calc_delta_fair(se->slice, se);
>  }
>  
> -- 
> 2.20.1
> 


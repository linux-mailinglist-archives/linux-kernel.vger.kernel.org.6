Return-Path: <linux-kernel+bounces-410510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A249CDC84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B81C280D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C51B21BA;
	Fri, 15 Nov 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6n+c6ux"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5A61FEB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666286; cv=none; b=a/AT6sR1yxHhoWM1gz6l8IS8wIiM8v/BJ/59stwd7eVZn/8QN2XcT7U0jrrePAOM+E8qOk6O5KGZs/NX+MCDHKQOhSpHZMvgoLrwV2YqGd0TMqWexysQfQFtYcIyd3TpbT3FboGMM0mFjl0w+o3dWR2oG4JvkrI7Cvf+f/MOols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666286; c=relaxed/simple;
	bh=I8HdiQeucqnAMJvr8FfOCOT9gbNtJ65hfM5hP5QRWkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cppjY3iMcX1klTkQBPte3FMyOK8udAClR6GYh7t+c+vWINFMb0MmftVRuzhfzBEVdjxf6PRLkvaYlFH4Q0QfunlBGLq9EXb8h955Aj3inlaEBdUF9NCCaTrVZVHZNBxp3WGl5rxNj0TVX2mdeJJzaSPVpVLqf+adDwocXrgR+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i6n+c6ux; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/g2tWW2+AOL2JnK7+s7dpVdr5i9io5RHCB9dxQaNkPI=; b=i6n+c6uxqgnc5qj+z3Ejk0OITR
	+gbRCZd7Lc1DG69nCk4waI5rn35V63vKtec1dLxqKpsSO8nYiB1IxyZHZ6xKk1pP4Ck3bCkiXL2hw
	/7jbPH0u6jZkL/utZhLUkUUrhMQLFD/suCqfO7zCa/RFY98Pon4zUUWR+3IG58HKmex/8oOKgHIHC
	uXmqxo7YuMutJTB/FGh5JMQC//FAnKRd25bE5oLHyaTQbBsQCg7IbgCWys4FAgjsAHjX4pLWdMJd7
	RG8wUBPsqg02MVGYo+AdtXUWdFuRMnK+FHxJ/MgWipcvzL+a6WUjJMMwbq1JYbHhwTyN+Iak1dkNN
	vHdnNp1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtB0-00000000DPM-2sfI;
	Fri, 15 Nov 2024 10:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4FAB30066A; Fri, 15 Nov 2024 11:03:41 +0100 (CET)
Date: Fri, 15 Nov 2024 11:03:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: use smp_wmb in rt_clear_overload
Message-ID: <20241115100341.GW22801@noisy.programming.kicks-ass.net>
References: <20241114213156.1839644-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114213156.1839644-1-jon@nutanix.com>

On Thu, Nov 14, 2024 at 02:31:56PM -0700, Jon Kohler wrote:
> Add smp_wmb in rt_clear_overload, which ensures that the cleared
> cpumask bit is visible to properly iterate over any remaining
> overloaded CPU(s).
> 
> The smp_wmb pairs with the smp_rmb in pull_rt_task(), ensuring that a
> thread will observe rto_count and the correct cpumask.
> 
> This visibility is important for NO_RT_PUSH_IPI use cases where a
> thread may iterate over an outdated view of rto_mask where target CPUs
> are no longer overloaded.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  kernel/sched/rt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 172c588de542..f68a454bb0e3 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -354,9 +354,13 @@ static inline void rt_clear_overload(struct rq *rq)
>  	if (!rq->online)
>  		return;
>  
> -	/* the order here really doesn't matter */
>  	atomic_dec(&rq->rd->rto_count);
>  	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
> +	/*
> +	 * Barrier pairs with pull_rt_task(), such that threads will
> +	 * observe the correct cpu mask for any remaining overloaded CPU(s).
> +	 */
> +	smp_wmb();
>  }

There is a comment in pull_rt_task() that says there is a barrier in
rt_set_overloaded(), was there ever, when did it go away?

Also, both atomic_dec() and cpumask_clear_cpu() are atomic ops, sadly
they're both variants that don't imply much on our weak architectures
and smp_mb__after_atomic() would be too much for them :/

Oh well.

Also, when modifying rt, always look at dl because that shares a ton of
logic, dl_set_overload() weirdly has all this differently -- and
actually has the barrier on. Please make it all match.


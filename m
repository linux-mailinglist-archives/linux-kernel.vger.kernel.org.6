Return-Path: <linux-kernel+bounces-425412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B69DC1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5CBB214B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C753C18871F;
	Fri, 29 Nov 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YE+89rru"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC191865E0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874112; cv=none; b=q+juKe1mos3NbjyxHg7FhAXCQKvpw80mSQpL+QbibI9zySvSadfGwIouGwyNy4ToAPi8HqK3mes46mUk4m0ifYT64sE8+Y23xQ/++ISe09bsQCRhUk7hPKjSk2DyYK8HV1ZPpQqs0pURl4HIa47/9J8uxi1gJUOrJBxWQIgPa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874112; c=relaxed/simple;
	bh=Dy6iAYqzkqe2LMvEeLx9o5WgIQZcx1GxGecGH3O8ozI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCegjm9Q4GWFCZNjUoppDsPCPk0giVgwc0OO9hHlfiBqv971I3szX5MnFAxyUwre0QE9nIecNdcehPxuTZ1E98diOKFCFxxc3BEq5QcZrMEsRs9Wvt4UsIBkZ2Q4ETwTAXfT4x1dTFdjyD8OOXEMDFhaUCtuooub++HLE1pu5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YE+89rru; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vj9kEays9qpmD3X59elW8XQopyTChfHA/yhgeC1rr1s=; b=YE+89rruStCuIl42aKGcTYVPZd
	WrxPiA9iVXvNHKICu4wABWg/PZlCxte2W4bNBtNf0VWs5cIfpQ4kJdAINrFFpdNkBMGCTc0FfD+1N
	ZGJ+Vyjo09WrEcOdaiHM91LlDQXbnC4isCQT9ILLX7OsSCnv7NunFZq3gfxjKLX7pnjLYCwDsroxU
	+MYGEUkMYgssIUd462xCYTeE762mzrRDVvDpeZ/jBM/IWxwrDJ3RnHz5IQekQLc/uFHP9h6XnrGM7
	PgLRA5Peua6svmo6g+d9A9i8bMblv6UKJ2l47g3g+Cy6kXJbNgamX1Mhvsmft6WMFUDmmnFMMtbpN
	V3ncs6dw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxiF-00000003rQN-3Uvq;
	Fri, 29 Nov 2024 09:55:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4209830026A; Fri, 29 Nov 2024 10:55:00 +0100 (CET)
Date: Fri, 29 Nov 2024 10:55:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
	vineethr@linux.ibm.com
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
Message-ID: <20241129095500.GD15382@noisy.programming.kicks-ass.net>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>

On Thu, Nov 28, 2024 at 12:59:54PM +0530, K Prateek Nayak wrote:

> I tried to put a SCHED_WARN_ON() here to track where this comes from and
> seems like it is usually from attach_task() in the load balancing path
> pulling a delayed task which is set as the next buddy in
> check_preempt_wakeup_fair()
> 
> Can you please try the following diff instead of the first two patches
> and see if you still hit these warnings, stalls, and pick_eevdf()
> returning NULL?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff7cae9274c5..61e74eb5af22 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5478,6 +5478,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	bool sleep = flags & DEQUEUE_SLEEP;
>  	update_curr(cfs_rq);
> +	clear_buddies(cfs_rq, se);
>  	if (flags & DEQUEUE_DELAYED) {
>  		SCHED_WARN_ON(!se->sched_delayed);
> @@ -5520,8 +5521,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	update_stats_dequeue_fair(cfs_rq, se, flags);
> -	clear_buddies(cfs_rq, se);
> -
>  	update_entity_lag(cfs_rq, se);
>  	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
>  		se->deadline -= se->vruntime;

So this puts the clear_buddies() before the whole delayed thing, and
should be sufficient afaict, no?

> @@ -8767,7 +8766,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
>  		return;
> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
> +	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
>  		set_next_buddy(pse);
>  	}

But then this should never happen, which is after a wakeup, p and the
whole hierarchy up should be runnable at this point.

Or should I go find more wake-up juice and try again :-)



Anyway..  I'm sure I started a patch series cleaning up the whole next
buddy thing months ago (there's more problems here), but I can't seem to
find it in a hurry :/





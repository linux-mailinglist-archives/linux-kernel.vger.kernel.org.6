Return-Path: <linux-kernel+bounces-269096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD3942D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25051F244F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543E1AED3D;
	Wed, 31 Jul 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KCX1BhX5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469D1AE86A;
	Wed, 31 Jul 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426864; cv=none; b=nKb/ruuQp7AMax4Avn0Df1O0gvWbXeBXiofI18f6QweLYDGrx7Kv3hqlrqvdfGpwM5Z3dFCt4H+2kufvH0aAxfpHLvhbg146B7l7otnc4gkk/YlyigS9zp9rmaX2AAAZD0528w4L3QAUiKQCbJurSjnQSNsxo9s37urrJYrM/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426864; c=relaxed/simple;
	bh=YUuSxA7mIfVsnXc6vdgnTqKiQiVZZJtT8xpOvEhOXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqIRuYWkdrCUOlk9A4D5EEVtnCTGHsC6aKSA1sCCzGeMAtavMMtv63PyVagYM7Z8MZlwtdmLHB2Z2POTKHn3u7xaYrRnic5fGgWRKyEn0GmFFKrVB59iONL5y7IX8Msgqa2Lp/TEsKmbWSgQndTxnGd3WK5/MFY+NcoFp9C7grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KCX1BhX5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EQUjTI3vNYH2LHPdO+Cc9PfhoPmlNK4Lfv8AZJOXwLM=; b=KCX1BhX5vd+ro3EnlM2Nsv96LU
	in3BmLrCkqAZkWTWjMXLfaNEagJ8n2tXauweDDqQhV9HlZUZia2zYrvGCA6t+qwoF7I3YtTYK7tkW
	D1Y2VDxFugEe91mjH6cPGmOeEUnsGDsoO6A5+7Gbtrwc8qQhLQ10sIx9aGtZ3VM34sd61Uk7ewzQ5
	9EDzkLYjqbu+m+uT8O451f4qazSPc+OAGVW2D1yPz4o8AkpOjeNxKlTYgx4yOpIZ/bj4r4AIsXcgr
	ubQzJ8vqz4u/bO7GcFgeeJRbm6dfiM4iModuABbKSgYZm5OsJS1rgnpB9kjESkBiMi2sxHH+KXix/
	dYmhxEWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ7uN-0000000G4bM-0hZn;
	Wed, 31 Jul 2024 11:54:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA3A8300820; Wed, 31 Jul 2024 13:54:18 +0200 (CEST)
Date: Wed, 31 Jul 2024 13:54:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [peterz-queue:sched/prep] [sched/fair] 124c8f4374:
 WARNING:at_kernel/sched/sched.h:#update_load_avg
Message-ID: <20240731115418.GD33588@noisy.programming.kicks-ass.net>
References: <202407291328.761441a7-oliver.sang@intel.com>
 <5e3b9b29-8d17-6a04-f2a5-1748a52d1a6a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e3b9b29-8d17-6a04-f2a5-1748a52d1a6a@amd.com>

On Wed, Jul 31, 2024 at 11:46:48AM +0530, K Prateek Nayak wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cd4a6bf14828..c437b408d29b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13297,10 +13297,34 @@ void unregister_fair_sched_group(struct task_group *tg)
>  			if (se->sched_delayed) {
>  				guard(rq_lock_irqsave)(rq);
>  				if (se->sched_delayed) {
> +					/*
> +					 * We can reach here when processing RCU_SOFTIRQ on exit path from
> +					 * a reschedule IPI. wakeup_preempt() may have set RQCF_REQ_SKIP to
> +					 * skip a close clock update in schedule(), however, in presence of
> +					 * a delayed entity, this trips the check in rq_clock_pelt() which
> +					 * now believes the clock value is stale and needs updating. To
> +					 * prevent such situation, cancel any pending skip updates, and
> +					 * update the rq clock.
> +					 */
> +					rq_clock_cancel_skipupdate(rq);
> +
> +					/*
> +					 * XXX: Will this trip WARN_DOUBLE_CLOCK? In which case, can
> +					 * rq_clock_cancel_skipupdate() be made to return a bool if
> +					 * RQCF_REQ_SKIP is set and we avoid this update?
> +					 */
>  					update_rq_clock(rq);
> +
>  					dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> +
> +					/* Avoid updating the clock again if a schedule() is pending */
> +					if (task_on_rq_queued(rq->curr) &&
> +					    test_tsk_need_resched(rq->curr))
> +						rq_clock_skip_update(rq);
>  				}
>  				list_del_leaf_cfs_rq(cfs_rq);
> +
> +
>  			}
>  			remove_entity_load_avg(se);
>  		}

So I did update this to simply add update_rq_clock() before the
dequeue_entity(SLEEP|DELAYED). I initially had, these, then confused
myself between deactivate_task() and dequeue_entity(), where the former
updates the clock but the latter does not, and removed them. Then Mike
complained, and I restored it for the regular exit path and forgot the
cgroup exit path.

But now they should both be doing update_rq_clock() here.

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=5b3a132d4dd5c91f26beb3e8973c03cdb77d7873

Since this is all with our own rq->lock held, I don't think skip would
be relevant here.


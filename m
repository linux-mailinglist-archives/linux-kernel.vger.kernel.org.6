Return-Path: <linux-kernel+bounces-418168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 673DC9D5DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52D7B26EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CD1DE4CC;
	Fri, 22 Nov 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yrv9iFPu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138AF1DE4D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274475; cv=none; b=lh96zLxAjSLKKvrxGBd/ZuE0EkDVtqtWWBOBnErlqRwJ0nmRmDnYJhvS3Cs72s4Djjww6Ik8KOEkZ27koH2qbHnjft3lePAei/5y0Qd9HD9z5nthzxhi9pqF109Vav4fP2FD03KQDzA7l53s89fK5PQaJzYXXdCcUU/Ig7tE0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274475; c=relaxed/simple;
	bh=oV9sa8Zpps4KEvNcx09iJaE4EcBbRG+1df4HMJqVtSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGKrNCNxAm65z5UD9/fBT6nQSk4Q3CzInaPVj3jLz1BpNNPx2Y1oKUpBWIGZkutpbnwjGIGqLchVfUXuFid5vLeazPbPEQptWqi84KvX3xjlX54NcxUbtjo0HCUMuizniV63qNAx1KMVNXGBL4IxGQ5JHgPVpTPR7mCsFy1Tn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yrv9iFPu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xlunDlLpKv69obk0KNd8vKwx7o+CIMbG84s+jMC3nFQ=; b=Yrv9iFPudjgwR50DGJ+0So1eXm
	UY/8kvGasTdP1SbpjsbE+0mm7lsy5L/TS/FQjWRbH1jHaZnJhK/fvPpEPepPUH7QmQymUjhKW8LqJ
	PTnhmbrh+JW3YxlpFuZlogO2TMyBc+VyvhFoNr7R7uOSh+HP+WBfDXPNYgwOi5e5nwCHLZYH84CrT
	pNNjUCYUQtopTsO6Sf/lgHj1nfjqsxATKm9yYZNM5iYlx5ag/BWycut5CVDEApFfP6cqfbXRwlI1R
	u5uq+Su0JX6WTlrNFNmlKt/x96Oe3qHEhh1azZtLjCofqARUmJs9u3z6Ke2lYcC4VFK9InSCucWmU
	M3Am2ddg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERij-00000007aid-3vs1;
	Fri, 22 Nov 2024 11:21:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8C0E30066A; Fri, 22 Nov 2024 12:21:06 +0100 (CET)
Date: Fri, 22 Nov 2024 12:21:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Don <joshdon@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Roman Gushchin <kfree@google.com>, torvalds@linux-foundation.org
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
Message-ID: <20241122112106.GU24774@noisy.programming.kicks-ass.net>
References: <20241111182738.1832953-1-joshdon@google.com>
 <CABk29NuO0awfERpRBHyEyRPaCcrKJ-Zx1fR9f8RgSrqpqNM_cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABk29NuO0awfERpRBHyEyRPaCcrKJ-Zx1fR9f8RgSrqpqNM_cg@mail.gmail.com>

On Thu, Nov 21, 2024 at 04:09:16PM -0800, Josh Don wrote:
> On Mon, Nov 11, 2024 at 10:27 AM Josh Don <joshdon@google.com> wrote:
> >
> > Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
> > a WARN when a per-task affinity assignment races with a cpuset update.
> >
> > Specifically, we can have a race where a cpuset update results in the
> > task affinity no longer being a subset of the cpuset. That's fine; we
> > have a fallback to instead use the cpuset mask. However, we have a WARN
> > set up that will trigger if the cpuset mask has no overlap at all with
> > the requested task affinity. This shouldn't be a warning condition; its
> > trivial to create this condition.
> >
> > Reproduced the warning by the following setup:
> >
> > - $PID inside a cpuset cgroup
> > - another thread repeatedly switching the cpuset cpus from 1-2 to just 1
> > - another thread repeatedly setting the $PID affinity (via taskset) to 2
> >
> > Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask")
> > Signed-off-by: Josh Don <joshdon@google.com>
> > Acked-by: Waiman Long <longman@redhat.com>
> > Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> > Acked-and-tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/syscalls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> > index 4fae3cf25a3a..3a88f7c0cb69 100644
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -1321,7 +1321,7 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
> >                         bool empty = !cpumask_and(new_mask, new_mask,
> >                                                   ctx->user_mask);
> >
> > -                       if (WARN_ON_ONCE(empty))
> > +                       if (empty)
> >                                 cpumask_copy(new_mask, cpus_allowed);
> >                 }
> >                 __set_cpus_allowed_ptr(p, ctx);
> > --
> > 2.46.0.469.g59c65b2a67-goog
> >
> 
> Hey,
> 
> I wanted to bump this one last time. It's a pretty simple change that
> already has ACK's from 3 other folks, but has seemed to fall through
> the cracks [1].

Got it, I'll stick it in tip/sched/urgent post -rc1 or so.


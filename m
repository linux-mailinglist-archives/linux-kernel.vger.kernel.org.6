Return-Path: <linux-kernel+bounces-358811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB53B99841F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE31F2502E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38121BE251;
	Thu, 10 Oct 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DcnNL9FJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4F1A00F0;
	Thu, 10 Oct 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557256; cv=none; b=Zd1xgIa+Hr+z4ikcWDjj3SZErKaR70GL7AJbvbYa6J8mnN+oiAj9LjvXDJSOEf9y/Q1ti+PCv8Yx5eYdy9RPsliTBOQMjJcaIOaH//KdCufNPOCcCyGGz0JHsXMnd7VGihe5vEI+NvPJUj6YNl5droWVrQDObKf02uo5vnflQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557256; c=relaxed/simple;
	bh=v1m6sKjUWaKH5tcwIPZPQRzsAK8mfmTeuH6SEbXZQJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyeGb3kQ0ir3+6MH0AiRqR/dyiIAZyJ+hwDZIIUDR+gC0poDkbUuwiEMff5gKYO9i9uBKmWCmIjS/klSQZH73Ur51TZmvW8mLTXSsEcNWA0FL8lEZhM5ZWS/YA31nYFnsyLbhQxCbifpdVjP7J6OX+AoxWhjkmmBbtjNsrpiESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DcnNL9FJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b0md/58JspE7aFSFNfnKWagcGNvByj1vnQKOUmwdHEw=; b=DcnNL9FJHzB7UIU0Q3YEGQLBhv
	yAd7Rqhpm2GWXdmU+LEJAP6KhN9sNVezFfP+X8y07JKbwLtx2Nl7dXj3fL/t115ocOsDmPfEEDIZn
	FOsDnPnExT93oBErJq4mPZPuW/lTMPLproEMScJrftmp86eccLgDCJFyXjKUQ1+i/JLtNz2si/y/F
	B0GrX1SNaeutFnLxvK849Fu1/Kh/Q6BibXoZiiri2/R/3JicuNFFj04wtJgVzM/5FPmb+kmX7ZLOR
	iGLLa4p0MfvGRqZA7U1PxwimyGLSiftU0SHi2nE3aP1QOhh1akqJ3oCeTbav+OgqmplLewxzTU64z
	4L0rtLCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syqhY-00000007QLt-2DDQ;
	Thu, 10 Oct 2024 10:47:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9AFCA30088D; Thu, 10 Oct 2024 12:47:24 +0200 (CEST)
Date: Thu, 10 Oct 2024 12:47:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bert Karwatzki <spasswolf@web.de>, regressions@lists.linux.dev
Subject: Re: [PATCH 0/3] sched/core: Fix PSI inconsistent task state splats
 with DELAY_DEQUEUE
Message-ID: <20241010104724.GK14587@noisy.programming.kicks-ass.net>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010082838.2474-1-kprateek.nayak@amd.com>

On Thu, Oct 10, 2024 at 08:28:35AM +0000, K Prateek Nayak wrote:
> After the introduction of DELAY_DEQUEUE, PSI consistently started
> warning about inconsistent task state early into the boot. This could be
> root-caused to three issues that the three patches respectively solve:
> 
> o PSI signals not being dequeued when the task is blocked, but also
>   delayed since psi_sched_switch() considered "!task_on_rq_queued()" as
>   the task being blocked but a delayed task will remain queued on the
>   runqueue until it is picked again and goes through a full dequeue.
> 
> o enqueue_task() not using the ENQUEUE_WAKEUP alongside ENQUEUE_DELAYED
>   in ttwu_runnable(). Since psi_enqueue() only considers (in terms of
>   enqueue flags):
> 
>     (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)
> 
>   ... as a wakeup, the lack of ENQUEUE_WAKEUP can misguide psi_enqueue()
>   which only clears TSK_IOWAIT flag on wakeups.
> 
> o When a delayed task is migrated by the load balancer, the requeue or
>   the wakeup context may be aware that the task has migrated between it
>   blocking and it waking up. This is necessary to be communicated to PSI
>   which forgoes clearing TSK_IOWAIT since it expects the psi_.*dequeue()
>   to have cleared it during migration.
> 
> The series correctly communicates the blocked status of a delayed task
> to psi_dequeue(), adds the ENQUEUE_WAKEUP flag during a requeue in
> ttwu_runnable(), re-arranges the psi_enqueue() to be called after a
> "p->sched_class->enqueue_task()", and notify psi_enqueue() of a
> migration in delayed state using "p->migration_flags" to maintain the
> task state consistently.
> 
> This series was previously posted as one large diff at
> https://lore.kernel.org/lkml/f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com/
> and was tested by Johannes. The tags on the diff have been carried
> to this series.

Thanks!

I've renamed DELAYED_MIGRATED to MF_DELAYED, and made a note to go
rename the MDF_PUSH thing to something consistent.

I've stuck then in queue.git sched/urgent along with a few other fixes
and I will hopefully push the lot into tip soon.


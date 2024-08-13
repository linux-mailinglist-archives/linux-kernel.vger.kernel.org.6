Return-Path: <linux-kernel+bounces-285551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B07950F86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA32B2241A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826ED1AAE10;
	Tue, 13 Aug 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/4sV7UM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021826AFB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586894; cv=none; b=IumOlfKbNkWAloLIrS9bKtCx8X7akWAnhi5wNJSwN/psCSgsf2Wg0Tcv8T/Kco1xesPEbNgD4Sh3kg0pvG3gynFpVZcQOxqNGiBlpyUZHMo4GsjJQ1BXQc7dhxNT5ucqnCWFkwa7nqyRo/PDB2O+oK0PErfReyXIHv365mY2XYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586894; c=relaxed/simple;
	bh=RVp/3Jm/vGpRVsC5wWe8uhyY3BOPage89QkUfN4y71A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWSXkU0FVp2yBF6XoF8mCtJINLG9hshTfb8JwshY7id9NGUxLYie3ndQBKkTQHit/orR0lKBMuJhQhWUZVQ5REa4KKduvyOfp3ZuFeLiwH94WS9LRNF8PIZnS700bUdlqGZNqF4aCYW67o+N2b9xMXVV4PDnpD6qEbt1kM8k38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X/4sV7UM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0dw7TpPqoQ/iCGcXQKDxO6JOltSrDdi0YYRWVHZjDsY=; b=X/4sV7UMgZarP9//BZyZ8MoeGM
	D4PbFqiygZg6u/0Y/asNUgWP/WAy1vB6D3Mo5J9HSe29eBP9q7LrNQ9L/9huWgsyPLIgCiJJksE/h
	iNOodq6Q0GE62wPZtzirRZ0qPIOSs6kLDYb4MJLX4kTzbnaQ97iTrOAJs/ur/I32OGXT5SoGbau0i
	4auPAVA9S3Gz6yTzKZLf407vdmxDb3MUioIFUtTOoEyqLgbIKvSOPwHOXWytapXsVgAieSFgWqbYN
	fW0eOCdgffId6srI+C04D4B8t6dbHHQ3jNfr4xu2r5J993VK5pNk11VH7yTAqdUgJwYedZvqMwbCX
	FSrf9E6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdzgN-0000000H6IW-2Dsk;
	Tue, 13 Aug 2024 22:07:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8AD7130074E; Wed, 14 Aug 2024 00:07:57 +0200 (CEST)
Date: Wed, 14 Aug 2024 00:07:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
Message-ID: <20240813220757.GA22760@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
 <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813215421.GA10328@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813215421.GA10328@noisy.programming.kicks-ass.net>

On Tue, Aug 13, 2024 at 11:54:21PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 13, 2024 at 02:43:47PM +0200, Valentin Schneider wrote:
> > On 27/07/24 12:27, Peter Zijlstra wrote:
> > > @@ -12817,10 +12830,26 @@ static void attach_task_cfs_rq(struct ta
> > >  static void switched_from_fair(struct rq *rq, struct task_struct *p)
> > >  {
> > >       detach_task_cfs_rq(p);
> > > +	/*
> > > +	 * Since this is called after changing class, this isn't quite right.
> > > +	 * Specifically, this causes the task to get queued in the target class
> > > +	 * and experience a 'spurious' wakeup.
> > > +	 *
> > > +	 * However, since 'spurious' wakeups are harmless, this shouldn't be a
> > > +	 * problem.
> > > +	 */
> > > +	p->se.sched_delayed = 0;
> > > +	/*
> > > +	 * While here, also clear the vlag, it makes little sense to carry that
> > > +	 * over the excursion into the new class.
> > > +	 */
> > > +	p->se.vlag = 0;
> > 
> > RQ lock is held, the task can't be current if it's ->sched_delayed; is a
> > dequeue_task() not possible at this point?  Or just not worth it?
> 
> Hurmph, I really can't remember why I did it like this :-(

Obviously I remember it right after hitting send...

We've just done:

	dequeue_task();
	p->sched_class = some_other_class;
	enqueue_task();

IOW, we're enqueued as some other class at this point. There is no way
we can fix it up at this point.

Perhaps I can use the sched_class::switching_to thing sched_ext will
bring.

For now, lets keep things as is. I'll look at things later



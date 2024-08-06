Return-Path: <linux-kernel+bounces-276971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441E949A89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1051F23BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3116F26D;
	Tue,  6 Aug 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jB4+338i"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D916D33D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981341; cv=none; b=m+eeAEb2NvC+p44rm7K8wVAdy/ioKg+Mrq8nrWWY7hts2fjZPiMa7E/N5c1ch7eoRsT5Kndmn1Jjomjx1wp30yKoNYp+/RaF7C04xhtw5k8gTOJcJv6iDvfGfjJrK+OU/nFcv6wNtVMykn9H+TkjMO+bBw+rHAL8VKAFiAi5G1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981341; c=relaxed/simple;
	bh=n1CsJvO4RUncYz1C9N6354Je8MjF9roKSsq0uARHNEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCUPzu8dwpK5Hmiy83hR2LIQ5AvTdneT21hNSR3bjucwVRoi1sAO0qNfOYbyPMNMnT5G3d/75/+eM2BAxNRWJTnamxsNq9SHzDaY2p89ykumakaksA4ZBNSJYhKHwldZr882JbpqyongazyCEkgQMpTa6lLJAJEcdgOs/gvtE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jB4+338i; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OYAn+zIBaN840s8JSyuuYFV+HpHAFTrA+0QShvGCpAM=; b=jB4+338ibrSGZ89k2okOOjNyjy
	Eo3dmypnkVhI3k08v5/Kg8h2Z/iDL725eoaQ9gVm3J7wzH4l42aPn13mNb5QsAtIHOiofVXoPnndk
	ICTvx02cw9fZeAW+oSumL4M5TDWGeYbuVlD2kQfJdLQSg9e20/nQxSy/oBR+rD/Nk8AJnILZkGWri
	Ike0xcPxjdcQFb/6vXzbxP6LhXD94c7yLT19rd6+TgnKGXjeJILLWOSIMm2pARwS0CMzefC+V+Bx7
	M/2sa+HiKc5yHr9AB71URNkVy876VP7pHwOYrjfOx1WisLUV+2npFkMnj6cacAer8qJLaLcZ8E9Yr
	51ZcwGKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbS9Y-00000006Wxy-2g2u;
	Tue, 06 Aug 2024 21:55:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63AA430066A; Tue,  6 Aug 2024 23:55:35 +0200 (CEST)
Date: Tue, 6 Aug 2024 23:55:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240806215535.GA36996@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240806211002.GA37996@noisy.programming.kicks-ass.net>
 <ZrKW2wZTT3myBI0d@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrKW2wZTT3myBI0d@slm.duckdns.org>

On Tue, Aug 06, 2024 at 11:34:19AM -1000, Tejun Heo wrote:

> > > +static struct task_struct *pick_task_scx(struct rq *rq)
> > > +{
> > > +	struct task_struct *curr = rq->curr;
> > > +	struct task_struct *first = first_local_task(rq);
> > > +
> > > +	if (curr->scx.flags & SCX_TASK_QUEUED) {
> > > +		/* is curr the only runnable task? */
> > > +		if (!first)
> > > +			return curr;
> > > +
> > > +		/*
> > > +		 * Does curr trump first? We can always go by core_sched_at for
> > > +		 * this comparison as it represents global FIFO ordering when
> > > +		 * the default core-sched ordering is used and local-DSQ FIFO
> > > +		 * ordering otherwise.
> > > +		 *
> > > +		 * We can have a task with an earlier timestamp on the DSQ. For
> > > +		 * example, when a current task is preempted by a sibling
> > > +		 * picking a different cookie, the task would be requeued at the
> > > +		 * head of the local DSQ with an earlier timestamp than the
> > > +		 * core-sched picked next task. Besides, the BPF scheduler may
> > > +		 * dispatch any tasks to the local DSQ anytime.
> > > +		 */
> > > +		if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
> > > +						     first->scx.core_sched_at))
> > > +			return curr;
> > > +	}
> > 
> > And the above condition seems a little core_sched specific. Is that
> > suitable for the primary pick function?
> 
> Would there be any distinction between pick_task() being called for regular
> and core sched paths?

There currently is not -- but if you need that, we can definitely add a
boolean argument or something. But I think it would be good if a policy
can inherently know if curr is the better pick.

ISTR you having two queue types, one FIFO and one vtime ordered, for
both I think it should be possible to determine order, right?


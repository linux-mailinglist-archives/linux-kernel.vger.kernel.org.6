Return-Path: <linux-kernel+bounces-389098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE89B687E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6041F23A81
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AA2141A5;
	Wed, 30 Oct 2024 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LomRR9HR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021B213EF9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303652; cv=none; b=V8yDdtQCfc0WIbps+FojPBTdh6xfvtxAtP0aC+/4NILl0xgryLTAXEqLE1DnRjBRJk3UOhntNl9fSkVK/VCFJQNEBTLzEP/KY/lIkxxbSqmo+4RjQXJOnclzc0Lie0gn7tnKWuFjVFTKGZdLSdVxLnKOfLyD61oH4huycUfO2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303652; c=relaxed/simple;
	bh=arSOT0r89f3l1GYllHvyc9zPs51VqGrI+YBzZ7Rv+Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkE5umPkYClz56U/22snnJonz9w46X7AidzDc/IEiuPtytXwk2WP/yGLxflG+tzsFZ/lhgLSWyW3MGpGE6PIa7bKg7YvEr1UO78CC+JK37weEuOhuy4t8JLEPAFqsvS//2GW28Hrdmz4NpBOEoznwpqwsA07qU/Z8zgzPDYRS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LomRR9HR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ind1uMP0jsdAMwnAlkouV2En44aSbAAxl0FaedMhEmc=; b=LomRR9HRJLfQ1LaKWVoh5gPZaO
	eB2GBHB9H2+RHabJiSA71SsOjB40Tnq7iLy49d1XyKT4/bV3gY4eLE64+gSQR0J8EFuwAXCrCg1Dx
	qbULF2bCOcBKAZE+DMQfjTfCAgs1ud5NF8Y056HBRr2AYreO+W6YFHI3dJdQno7QfPu4V3Iho4iVu
	z4YdjnMZfVMVlsKHZd7/pF11ur2ouwCc4nvTsvMN1+G+SO6HFfMrs+VSaI7u6XNyijDtKy01/Nrju
	T82Pqk/0nvmO0OCjzPkDB5aSELH2eXDAZt8aEAXweB4RTxKQqaldki/zfO6qobyHEenQIZMKkHGoi
	5HlGTRYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6B1H-0000000DdkB-1S23;
	Wed, 30 Oct 2024 15:54:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 90CF6300ABE; Wed, 30 Oct 2024 16:54:03 +0100 (CET)
Date: Wed, 30 Oct 2024 16:54:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched/ext: Fix scx vs sched_delayed
Message-ID: <20241030155403.GO14555@noisy.programming.kicks-ass.net>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.372771313@infradead.org>
 <a20ccb66-0233-4e09-94cd-586133072c3c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20ccb66-0233-4e09-94cd-586133072c3c@arm.com>

On Wed, Oct 30, 2024 at 03:50:05PM +0000, Christian Loehle wrote:
> On 10/30/24 15:12, Peter Zijlstra wrote:
> > Commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs
> > switched_from_fair()") forgot about scx :/
> > 
> > Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20241030104934.GK14555@noisy.programming.kicks-ass.net
> > ---
> >  kernel/sched/ext.c |   14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -4489,11 +4489,16 @@ static void scx_ops_disable_workfn(struc
> >  	scx_task_iter_start(&sti);
> >  	while ((p = scx_task_iter_next_locked(&sti))) {
> >  		const struct sched_class *old_class = p->sched_class;
> > +		const struct sched_class *new_class =
> > +			__setscheduler_class(p->policy, p->prio);
> >  		struct sched_enq_and_set_ctx ctx;
> >  
> > +		if (old_class != new_class && p->se.sched_delayed)
> > +			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> > +
> >  		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
> >  
> > -		p->sched_class = __setscheduler_class(p->policy, p->prio);
> > +		p->sched_class = new_class;
> >  		check_class_changing(task_rq(p), p, old_class);
> >  
> >  		sched_enq_and_set_task(&ctx);
> > @@ -5199,12 +5204,17 @@ static int scx_ops_enable(struct sched_e
> >  	scx_task_iter_start(&sti);
> >  	while ((p = scx_task_iter_next_locked(&sti))) {
> >  		const struct sched_class *old_class = p->sched_class;
> > +		const struct sched_class *new_class =
> > +			__setscheduler_class(p->policy, p->prio);
> >  		struct sched_enq_and_set_ctx ctx;
> >  
> > +		if (old_class != new_class && p->se.sched_delayed)
> > +			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEE_DELAYED);
> > +
> 
> s/DEQUEE_DELAYED/DEQUEUE_DELAYED

Bah, typing so hard..

> Anyway, no luck for me applying the series onto sched/core scx's for-next or rc5.
> Any hint or do you mind supplying a branch?

I think I did it on top of tip/master..


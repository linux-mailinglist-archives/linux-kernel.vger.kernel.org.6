Return-Path: <linux-kernel+bounces-392346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B629B92E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7410E2824D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153771A263F;
	Fri,  1 Nov 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m5mwr98u"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B81A08DF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470348; cv=none; b=PvOtuaQgBrFnmbxQ7GWjdmUtS4gbsSDcf8/v8qC6PEP+FJVz57YFJdby6k+Y+zEB2yVo/wwBVfSlZPknTTMyjAXs+P4/FRq4+8RmRfqXa5UZ+b2oh1rSAYDyNCCPfrbScPHS82ib6EN1YMgqa/c8aeRvI5ovChlrfxT1eS4nipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470348; c=relaxed/simple;
	bh=x4wrgNcfM2UY5F/ImCG+cR6s7ypnAPLWysAOE8G9FOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKIqjGS2KelIStQPDtXpOubLnXWRXkhm/1PmsH29ogG7EHDrEDHH/9ugBzPn4qnmUQO0ywL3vC+kBQGjSENkw6RadJezTLX1y6TgsAjDdMCwcMe2oC50IXNeT2+h7pCDoRd7luvDGL10hxWNS32rQUv0mlvrtBOjW1Q5qVUUVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m5mwr98u; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JpGfaH8X1y4C6VpQICzmdQVq3BIRCx+B6mG6qIoAJAc=; b=m5mwr98u8vYjlBPe9kvXiYGKtk
	jFJ9A5ySWayOfbddhWtlMdEyqJlTEzG02NqmjbS6zlpZAuz5+sTN6uBxpQCNDUQEhoTOMozGXe61+
	mm2oVuNasxiMHLrBAmZAlpLSfSLgLEG3Dl8ePSl6xcyhGrnU8cI1LPoyh3wq06DTNVWegXxUs1bUX
	mGfTJrhSfi4hw8FCrzY6eg4qdUP1qlpwP2cplWH81Vzdo7/1UUuQK9LzjqNBc7EGnuIf3QsUkJTTz
	e/Cf/DUNOY/T8Jlvu3Wh35ryIIBeiGVXMWRUwYo9xpI3oEulX8uPCdAWCHLP9TMt01Ujm2IfZOD5B
	YV6UtvTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sNv-0000000Ajyn-2lYT;
	Fri, 01 Nov 2024 14:12:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C5BBD300599; Fri,  1 Nov 2024 15:12:18 +0100 (CET)
Date: Fri, 1 Nov 2024 15:12:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@meta.com, kernel-team@meta.com,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH sched_ext/for-6.12-fixes] sched_ext: Call
 __balance_callbacks() from __scx_task_iter_rq_unlock()
Message-ID: <20241101141218.GV33184@noisy.programming.kicks-ass.net>
References: <ZyKoE9RUulWtYpEh@slm.duckdns.org>
 <20241031233634.GU14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031233634.GU14555@noisy.programming.kicks-ass.net>

On Fri, Nov 01, 2024 at 12:36:34AM +0100, Peter Zijlstra wrote:
> On Wed, Oct 30, 2024 at 11:41:39AM -1000, Tejun Heo wrote:
> 
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1315,6 +1315,8 @@ static void scx_task_iter_start(struct s
> >  static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
> >  {
> >  	if (iter->locked) {
> > +		/* ->switched_from() may have scheduled balance callbacks */
> > +		__balance_callbacks(iter->rq);
> >  		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
> >  		iter->locked = NULL;
> >  	}
> 
> I think you need to unpin/repin around it. The balance callbacks like to
> drop rq->lock at times.

Maybe something like so.. I'm not sure it's an improvement.

---
 kernel/sched/core.c  | 12 +++++-------
 kernel/sched/ext.c   |  1 +
 kernel/sched/sched.h |  9 +++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5de31c312189..c826745eedef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5039,7 +5039,7 @@ struct balance_callback *splice_balance_callbacks(struct rq *rq)
 	return __splice_balance_callbacks(rq, true);
 }
 
-static void __balance_callbacks(struct rq *rq)
+void __balance_callbacks(struct rq *rq)
 {
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
@@ -6721,9 +6721,8 @@ static void __sched notrace __schedule(int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
-		rq_unpin_lock(rq, &rf);
-		__balance_callbacks(rq);
-		raw_spin_rq_unlock_irq(rq);
+		rf.balance = true;
+		rq_unlock_irq(rq, &rf);
 	}
 }
 
@@ -7217,9 +7216,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	/* Avoid rq from going away on us: */
 	preempt_disable();
 
-	rq_unpin_lock(rq, &rf);
-	__balance_callbacks(rq);
-	raw_spin_rq_unlock(rq);
+	rf.balance = true;
+	rq_unlock(rq, &rf);
 
 	preempt_enable();
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7bc4fb7f3926..8e5b31983f37 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1314,6 +1314,7 @@ static void scx_task_iter_start(struct scx_task_iter *iter)
 static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
 {
 	if (iter->locked) {
+		iter->rf.balance = true;
 		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
 		iter->locked = NULL;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0aa6da2633aa..5a39ad0fa574 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1704,6 +1704,7 @@ static inline void rq_clock_stop_loop_update(struct rq *rq)
 struct rq_flags {
 	unsigned long flags;
 	struct pin_cookie cookie;
+	bool balance;
 #ifdef CONFIG_SCHED_DEBUG
 	/*
 	 * A copy of (rq::clock_update_flags & RQCF_UPDATED) for the
@@ -1739,6 +1740,8 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 #endif
 }
 
+extern void __balance_callbacks(struct rq *rq);
+
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 {
 #ifdef CONFIG_SCHED_DEBUG
@@ -1747,6 +1750,12 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 #endif
 
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
+#ifdef CONFIG_SMP
+	if (rf->balance) {
+		rf->balance = false;
+		__balance_callbacks(rq);
+	}
+#endif
 }
 
 static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)


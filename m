Return-Path: <linux-kernel+bounces-201874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6368FC470
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C741C210AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A111922D5;
	Wed,  5 Jun 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DD7GC1V7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6B1922CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572161; cv=none; b=akqQx8pH00GOSAuFqCzSOHLB/wGQcyUFe/vcbSRP3p310zfXydBQolZvfPDoa+hre+wHKajUCvwFOG4/yvYfzHrqY5IgoO8BvhhxVm1M0R7WEsKskQErM/RIU30/9hJ/yjMdyw9Zw3ivKmB5thQS5GNxXmT1II2aNRYdWUuD4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572161; c=relaxed/simple;
	bh=qPGwC7HGbWgPLBtWVHtHAymAsmQlkK7RgCtJb9BIm4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZOHPM8yzyme+D2lM/NZ6SWYyTdpBPtsZxlqsYitxUFiwFv6U9GILzquL3r5iNT0NQvPGC6pTuNzmHR4dYLNffhEsU2rOvz8VkrsWEDg//vKJndUW2/ex8qHvBcDcF5pBEQp6NcJ5b17xXyBNROBhcjo1KcUUTLcsaThlrkaaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DD7GC1V7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hahZNk18IXIh7Vd2j2tgth9wPADAG2KPuz9e9/5LimA=; b=DD7GC1V7JoVstDsD3rNCi4X5ek
	AEEKVCB9RhHpdJ4LW0Ivjn6qTgcQtAN8xNrWUXyv3yNBDgnLfiN9NmjyoecoFAI3UGBFB1+z3cGvQ
	aaNZ2cwGXDzb1a4eGZuIEG/SUeJKo4j81B2e6MVafuN9IBAi2gcu/gRtnPfii4bUJ7z96uORZQ1U5
	MkTNQC343ZHiBTBRxXZAKjX0mQ0sfn0hwAYda7xC3rAACa4cY9Iq1at3KS1JNbB+4fNBsmc1+UxVv
	we8yzcJl60IJY0OyMyq5DSDDWYJ+aR6JOm+rMSj3u+KTub8fXzDQ2A3QZisJxO18ONIqvWVx/MACH
	Bi+oLquw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkyZ-0000000FR1o-1Dm8;
	Wed, 05 Jun 2024 07:22:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D14AC30068B; Wed,  5 Jun 2024 09:22:25 +0200 (CEST)
Date: Wed, 5 Jun 2024 09:22:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>,
	Hongyan.Xia2@arm.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240605072225.GR12673@noisy.programming.kicks-ass.net>
References: <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
 <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
 <20240604191220.GP40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604191220.GP40213@noisy.programming.kicks-ass.net>

On Tue, Jun 04, 2024 at 09:12:20PM +0200, Peter Zijlstra wrote:

> But with the above, you skip inc for sched_delayed, but dequeue_task()
> will have done the dec, so isn't it then still unbalanced?
> 
> Oh well, I'll go stare at this in tomorrow.

OK, just before I went to play in my giant hamster wheel it hit me.

When dequeue_task() 'fails' and sets sched_delayed, we'll have done
uclamp_rq_dec().

Then, since the delayed task is still on the rq -- per the failure -- it
can be migrated, this will again do dequeue_task() which will *agian* do
a uclamp_rq_dec().

So now we have a double dequeue -- *FAIL*.

Worse, the migration will then do an enqueue_task() on the new rq
causing uclamp_rq_inc(). If you then get a ttwu() / ENQUEUE_DELAYED, you
can tickle yet another uclamp_rq_inc() for another fail.

Something like the below avoids uclamp_rq_{inc,dec}() when
->sched_delayed, and moves it post class->enqueue_task() such that for
the ENQUEUE_DELAYED case, we *will* do the inc after ->sched_delayed
gets cleared.

Hmm?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9ac1054c2a4bb..965e6464e68e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
 
@@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
@@ -1979,9 +1985,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
-	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 
+	uclamp_rq_inc(rq, p);
+
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
 }
@@ -2003,6 +2010,7 @@ bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	}
 
 	uclamp_rq_dec(rq, p);
+
 	return p->sched_class->dequeue_task(rq, p, flags);
 }
 


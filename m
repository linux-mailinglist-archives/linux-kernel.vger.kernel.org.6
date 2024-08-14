Return-Path: <linux-kernel+bounces-286025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67295157B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D211F2ACF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60BF13D503;
	Wed, 14 Aug 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P+HLG3Vg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089426F2FD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620365; cv=none; b=brFiu4K4rqvs9AidWD5jlJCErdg2VHh5jUNJ+6kY95yjD29+jVvPowAJTS/8RbC3mLJ1qf1BvGbY3hj87xvfa99EOIvYG00bF5qe7UblgNZDlXH3UxiSPBU/4oDVHI7n7clsVOgi8f3Rk3nCCFlg7vq1mFlncrM8AtOzeu5/84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620365; c=relaxed/simple;
	bh=poywOuStYhUetZu/UHSF/VloBA8a4576b2vd54xGlvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqUmFwElyulRroUFKSBT5LG5Vh6xFwDJ/U5FAT++HoFuNY/fVLyp2OLPivlx5/rR0ciWkJFKVFSwaXLU1EdQ7bKQcp+Qsia4ONxZkf0Fe8lWHeHigfOWWqID4e2NRY0C8b7h2xEjNmvKloRi0FwwWeRI5G59URXrmCQek2DJkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P+HLG3Vg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktl7L6T+RI2efOnQZ23lWcMkdOS4KwDH6qEDEskAmOM=; b=P+HLG3VgbJO6d9nTBqXaPC666y
	V8/q+MAGTvGFL/5yAHJmlfyuy4QJWZiFmoYL38PWxhOnZMfOotuWriudoxO/OxotS2Jxk5l32PyGI
	/v/+Zkiipcdu9sZGQeOjELNTDDyP2CbONSoK6iBrR4BCOylWKjmNgqna+HXhJypVrgo8ANJFhIA/q
	9KX5cfvOd2Ochhbd11JbA0Ak2cb1ZtC9W+A9XDOb4A98HpqZF9AZA3IBA1R2owMrdmqL/2DD0GPCV
	/1vDxiwhCH/O0ify03uk7zz+dyb7xnUS6+t6bREOif9zaTsCcAs3R85QfGgn0VchdHt7Co2ScXDmz
	bf3atzeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se8OE-00000000532-0Pm7;
	Wed, 14 Aug 2024 07:25:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8586130074E; Wed, 14 Aug 2024 09:25:48 +0200 (CEST)
Date: Wed, 14 Aug 2024 09:25:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
Message-ID: <20240814072548.GB22686@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.514088302@infradead.org>
 <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813221806.GB10328@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813221806.GB10328@noisy.programming.kicks-ass.net>

On Wed, Aug 14, 2024 at 12:18:07AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 13, 2024 at 02:43:56PM +0200, Valentin Schneider wrote:
> > On 27/07/24 12:27, Peter Zijlstra wrote:
> > > Note that tasks that are kept on the runqueue to burn off negative
> > > lag, are not in fact runnable anymore, they'll get dequeued the moment
> > > they get picked.
> > >
> > > As such, don't count this time towards runnable.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/sched/fair.c  |    2 ++
> > >  kernel/sched/sched.h |    6 ++++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5388,6 +5388,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> > >                       if (cfs_rq->next == se)
> > >                               cfs_rq->next = NULL;
> > >                       se->sched_delayed = 1;
> > > +			update_load_avg(cfs_rq, se, 0);
> > 
> > Shouldn't this be before setting ->sched_delayed? accumulate_sum() should
> > see the time delta as spent being runnable.
> > 
> > >                       return false;
> > >               }
> > >       }
> > > @@ -6814,6 +6815,7 @@ requeue_delayed_entity(struct sched_enti
> > >       }
> > >
> > >       se->sched_delayed = 0;
> > > +	update_load_avg(cfs_rq, se, 0);
> > 
> > Ditto on the ordering
> 
> Bah, so I remember thinking about it and then I obviously go and do it
> the exact wrong way around eh? Let me double check this tomorrow morning
> with the brain slightly more awake :/

OK, so I went over it again and I ended up with the below diff -- which
assuming I didn't make a giant mess of things *again*, I should go fold
back into various other patches ...

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1b15dbfb1ce5..fa8907f2c716 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5461,14 +5461,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool sleep = flags & DEQUEUE_SLEEP;
 
+	update_curr(cfs_rq);
+
 	if (flags & DEQUEUE_DELAYED) {
-		/*
-		 * DEQUEUE_DELAYED is typically called from pick_next_entity()
-		 * at which point we've already done update_curr() and do not
-		 * want to do so again.
-		 */
 		SCHED_WARN_ON(!se->sched_delayed);
-		se->sched_delayed = 0;
 	} else {
 		bool delay = sleep;
 		/*
@@ -5479,14 +5475,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 			delay = false;
 
 		SCHED_WARN_ON(delay && se->sched_delayed);
-		update_curr(cfs_rq);
 
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
-			se->sched_delayed = 1;
 			update_load_avg(cfs_rq, se, 0);
+			se->sched_delayed = 1;
 			return false;
 		}
 	}
@@ -5536,6 +5531,12 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 
+	if (flags & DEQUEUE_DELAYED) {
+		se->sched_delayed = 0;
+		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
+			se->vlag = 0;
+	}
+
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 
@@ -5611,11 +5612,6 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	struct sched_entity *se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-		SCHED_WARN_ON(se->sched_delayed);
-		SCHED_WARN_ON(se->on_rq);
-		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
-			se->vlag = 0;
-
 		return NULL;
 	}
 	return se;
@@ -6906,7 +6902,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	/*
-	 * se->sched_delayed should imply both: se->on_rq == 1.
+	 * se->sched_delayed should imply: se->on_rq == 1.
 	 * Because a delayed entity is one that is still on
 	 * the runqueue competing until elegibility.
 	 */
@@ -6927,8 +6923,8 @@ requeue_delayed_entity(struct sched_entity *se)
 		}
 	}
 
-	se->sched_delayed = 0;
 	update_load_avg(cfs_rq, se, 0);
+	se->sched_delayed = 0;
 }
 
 /*


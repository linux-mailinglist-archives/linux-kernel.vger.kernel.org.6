Return-Path: <linux-kernel+bounces-285902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012695140F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932DE1C23244
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1B55E58;
	Wed, 14 Aug 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WCTjv7L7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237838DCD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614827; cv=none; b=f0NwhFQq7hj/BWTnrZnP3vzuyj2IDnp9/05oTAr8NH+MyFMfbH6B7mbXYCT/RjnufT5gv373insf4sgGpZKWY1AID8wc+s4iwIGcNIuVK33//N46eSqURePcjjRCgx+3qfEyVUoRaZofh64kJQKWO6D8AZwJ3In8j1cAnmHjQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614827; c=relaxed/simple;
	bh=EF0ftDknC6NCD/P9zysYKlBbjYwBm0RQnzhlHq/J1ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj6RPC/gsIw08LUFwoI2ZVUDSGmEd6LbvY7eaPPymID9N++ldn/WAYobc0gj3+T/V7Ba6CMdI4QdJ0pdIDcmpK1f+1zKhzQpdSrFIw10mNkwuHwEYsLasWw4iN4Xi6z0uVBzpjQDqtOqjX8Gce3ivYmKkGYwgUc6DQaPzx+mWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WCTjv7L7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Xb0yVzWS+A2EgUf7XQFZYTsxzbtLkJhI3bQfGnm0/k=; b=WCTjv7L76iFdrCw/ZfEaGXUXDK
	ZmiiYLUTGvNM6zjBWLk6uiBaWMZxKdAT0kt9EPI4lrNZMnfL3kFU8cLRcqfVz7ZLDM3cKF7ZOrxiT
	mFwm2EI5BGeOdsDIhb/6oHS3Kr74gG8Bt90P7sQN7WFVOA1zeFNgBe+porFT60KNVIz/cx3j1q9k+
	AsHHPuphxp6vLR+zR1U68++0CWWiHMcx9R2khXL4wycswIIgPRZFwQVppn9QgDQpA15drSMOTgBte
	kaij8gUkc/AwYONys6gZX0BDRjQIRYwYS158AXU07/ezGWsaNNixgPvySy3CFD3hCx1zxLDZaG2qP
	ou8Zflhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6wt-0000000005B-2WWt;
	Wed, 14 Aug 2024 05:53:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 97AA230074E; Wed, 14 Aug 2024 07:53:30 +0200 (CEST)
Date: Wed, 14 Aug 2024 07:53:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
Message-ID: <20240814055330.GA22686@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
 <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813215421.GA10328@noisy.programming.kicks-ass.net>
 <20240813220757.GA22760@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813220757.GA22760@noisy.programming.kicks-ass.net>

On Wed, Aug 14, 2024 at 12:07:57AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 13, 2024 at 11:54:21PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 13, 2024 at 02:43:47PM +0200, Valentin Schneider wrote:
> > > On 27/07/24 12:27, Peter Zijlstra wrote:
> > > > @@ -12817,10 +12830,26 @@ static void attach_task_cfs_rq(struct ta
> > > >  static void switched_from_fair(struct rq *rq, struct task_struct *p)
> > > >  {
> > > >       detach_task_cfs_rq(p);
> > > > +	/*
> > > > +	 * Since this is called after changing class, this isn't quite right.
> > > > +	 * Specifically, this causes the task to get queued in the target class
> > > > +	 * and experience a 'spurious' wakeup.
> > > > +	 *
> > > > +	 * However, since 'spurious' wakeups are harmless, this shouldn't be a
> > > > +	 * problem.
> > > > +	 */
> > > > +	p->se.sched_delayed = 0;
> > > > +	/*
> > > > +	 * While here, also clear the vlag, it makes little sense to carry that
> > > > +	 * over the excursion into the new class.
> > > > +	 */
> > > > +	p->se.vlag = 0;
> > > 
> > > RQ lock is held, the task can't be current if it's ->sched_delayed; is a
> > > dequeue_task() not possible at this point?  Or just not worth it?
> > 
> > Hurmph, I really can't remember why I did it like this :-(
> 
> Obviously I remember it right after hitting send...
> 
> We've just done:
> 
> 	dequeue_task();
> 	p->sched_class = some_other_class;
> 	enqueue_task();
> 
> IOW, we're enqueued as some other class at this point. There is no way
> we can fix it up at this point.

With just a little more sleep than last night, perhaps you're right
after all. Yes we're on a different class, but we can *still* dequeue it
again.


That is, something like the below ... I'll stick it on and see if
anything falls over.

---
 kernel/sched/fair.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 714826d97ef2..53c8f3ccfd0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13105,20 +13105,16 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
 	/*
-	 * Since this is called after changing class, this isn't quite right.
-	 * Specifically, this causes the task to get queued in the target class
-	 * and experience a 'spurious' wakeup.
-	 *
-	 * However, since 'spurious' wakeups are harmless, this shouldn't be a
-	 * problem.
-	 */
-	p->se.sched_delayed = 0;
-	/*
-	 * While here, also clear the vlag, it makes little sense to carry that
-	 * over the excursion into the new class.
+	 * Since this is called after changing class, this is a little weird
+	 * and we cannot use DEQUEUE_DELAYED.
 	 */
-	p->se.vlag = 0;
-	p->se.rel_deadline = 0;
+	if (p->se.sched_delayed) {
+		dequeue_task(DEQUEUE_NOCLOCK, DEQUEUE_SLEEP);
+		p->se.sched_delayed = 0;
+		p->se.rel_deadline = 0;
+		if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
+			p->se.vlag = 0;
+	}
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)


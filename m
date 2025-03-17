Return-Path: <linux-kernel+bounces-564666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40957A6591B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8383B568D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE911A2C27;
	Mon, 17 Mar 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgZbRL/E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05B1B424A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229849; cv=none; b=QLGo8BOG2to+b4QH7BmqTQE8GHUUfapnQw4V1gzQmGdCz2Xc6dPDwlqL3SaMYPdatY6YfK0P7pNjB9U9Mq9VBJqtwS8ymoLqgIZ0dLqvF+XvpHnG0WFZV4rIEK9MJcrvS4S+u+kf/mxmKvBzTnfQ0qWpt0d36wpHq/FYir57Kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229849; c=relaxed/simple;
	bh=tVX1RAeKNz+AzeKI+1WkaGBpjlfjKqx09pRl8Rg9Qc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8IA3hzohPSVGnqw1fAyH6xPRrhvfsN6B+oe/uJYndPKHMV0s7QicBde5SVV1TTC67r880Z96Cr1LL4QUv1/YfsLXHF+YrZUd60T7WVsd5GeiouMu7sJvCHe4uyx4Qdbju1AFCvz+6pn6KBJMqW3x3plCbp+6vkkvSZhoBPWieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XgZbRL/E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mIdjkLEEeBJMs5pyzTmP02nC/w57bJPA8VeXEgQJysE=; b=XgZbRL/EzFtg/ETIP74QosLUj6
	hlexmwOvwU1Dnpxu6OUSq6Xv+YA2pjm9hk7luL144/+wwPq4Iw2o+STDzhzlfUggClpM5tTdz75j2
	RLmQfUymvbi4uhYCvJSpjVnD58tkLydtqLFqhSyLGDehI+MhhqqJ6gikoIH+TjrWqua1Z6FXlTRxd
	dR+QOgTVhAgH3L4ID5EtbVwVRKEUeh7CT74PJDCfW8edv2I1sft4ri433PPSuSPSBZBFBGVdRABCw
	5rSq+GtcZKalfbWOgrTz7gNPG02DKc7/jcplle1obMHEE1FioGwLG1D/SPR+YAYH7uYclsMwtrpzC
	9+c8sVLw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDZF-000000097Ca-13BI;
	Mon, 17 Mar 2025 16:43:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CEA1300783; Mon, 17 Mar 2025 17:43:56 +0100 (CET)
Date: Mon, 17 Mar 2025 17:43:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com,
	Valentin Schneider <valentin.schneider@arm.com>,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC PATCH v15 7/7] sched: Start blocked_on chain processing in
 find_proxy_task()
Message-ID: <20250317164356.GB6888@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-8-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312221147.1865364-8-jstultz@google.com>

On Wed, Mar 12, 2025 at 03:11:37PM -0700, John Stultz wrote:
> @@ -6668,47 +6676,138 @@ static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
>  }
>  
>  /*
> + * Find runnable lock owner to proxy for mutex blocked donor
> + *
> + * Follow the blocked-on relation:
> + *   task->blocked_on -> mutex->owner -> task...
> + *
> + * Lock order:
> + *
> + *   p->pi_lock
> + *     rq->lock
> + *       mutex->wait_lock
> + *
> + * Returns the task that is going to be used as execution context (the one
> + * that is actually going to be run on cpu_of(rq)).
>   */
>  static struct task_struct *
>  find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  {
> +	struct task_struct *owner = NULL;
> +	struct task_struct *ret = NULL;
> +	int this_cpu = cpu_of(rq);
> +	struct task_struct *p;
>  	struct mutex *mutex;
>  
> +	/* Follow blocked_on chain. */
> +	for (p = donor; task_is_blocked(p); p = owner) {
> +		mutex = p->blocked_on;
> +		/* Something changed in the chain, so pick again */
> +		if (!mutex)
> +			return NULL;
>  		/*
> +		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> +		 * and ensure @owner sticks around.
>  		 */
> +		raw_spin_lock(&mutex->wait_lock);

This comment -- that is only true if you kill __mutex_unlock_fast(),
which I don't think you did in the previous patches.

> +
> +		/* Check again that p is blocked with wait_lock held */
> +		if (mutex != __get_task_blocked_on(p)) {
> +			/*
> +			 * Something changed in the blocked_on chain and
> +			 * we don't know if only at this level. So, let's
> +			 * just bail out completely and let __schedule
> +			 * figure things out (pick_again loop).
> +			 */
> +			goto out;
> +		}
> +
> +		owner = __mutex_owner(mutex);
> +		if (!owner) {
> +			__clear_task_blocked_on(p, mutex);
> +			ret = p;
> +			goto out;
> +		}
> +
> +		if (task_cpu(owner) != this_cpu) {
> +			/* XXX Don't handle migrations yet */
> +			if (!proxy_deactivate(rq, donor))
> +				goto deactivate_failed;
> +			goto out;
> +		}
> +
> +		if (task_on_rq_migrating(owner)) {
> +			/*
> +			 * One of the chain of mutex owners is currently migrating to this
> +			 * CPU, but has not yet been enqueued because we are holding the
> +			 * rq lock. As a simple solution, just schedule rq->idle to give
> +			 * the migration a chance to complete. Much like the migrate_task
> +			 * case we should end up back in find_proxy_task(), this time
> +			 * hopefully with all relevant tasks already enqueued.
> +			 */
> +			raw_spin_unlock(&mutex->wait_lock);
> +			return proxy_resched_idle(rq);
> +		}
> +
> +		if (!owner->on_rq) {
> +			/* XXX Don't handle blocked owners yet */
> +			if (!proxy_deactivate(rq, donor))
> +				goto deactivate_failed;
> +			goto out;
> +		}
> +
> +		if (owner->se.sched_delayed) {
> +			/* XXX Don't handle delayed dequeue yet */
> +			if (!proxy_deactivate(rq, donor))
> +				goto deactivate_failed;
> +			goto out;
> +		}
> +
> +		if (owner == p) {
> +			/*
> +			 * It's possible we interleave with mutex_unlock like:
> +			 *
> +			 *				lock(&rq->lock);
> +			 *				  find_proxy_task()
> +			 * mutex_unlock()
> +			 *   lock(&wait_lock);
> +			 *   donor(owner) = current->blocked_donor;
> +			 *   unlock(&wait_lock);
> +			 *
> +			 *   wake_up_q();
> +			 *     ...
> +			 *       ttwu_runnable()
> +			 *         __task_rq_lock()
> +			 *				  lock(&wait_lock);
> +			 *				  owner == p
> +			 *
> +			 * Which leaves us to finish the ttwu_runnable() and make it go.
> +			 *
> +			 * So schedule rq->idle so that ttwu_runnable can get the rq lock
> +			 * and mark owner as running.
> +			 */
> +			raw_spin_unlock(&mutex->wait_lock);
> +			return proxy_resched_idle(rq);
> +		}
>  
>  		/*
> +		 * OK, now we're absolutely sure @owner is on this
> +		 * rq, therefore holding @rq->lock is sufficient to
> +		 * guarantee its existence, as per ttwu_remote().
>  		 */
>  		raw_spin_unlock(&mutex->wait_lock);
>  	}
> +
> +	WARN_ON_ONCE(owner && !owner->on_rq);
> +	return owner;
> +
> +deactivate_failed:
> +	/*
> +	 * XXX: For now, if deactivation failed, set donor
> +	 * as unblocked, as we aren't doing proxy-migrations
> +	 * yet (more logic will be needed then).
> +	 */
> +	donor->blocked_on = NULL; /* XXX not following locking rules :( */
>  out:
>  	raw_spin_unlock(&mutex->wait_lock);
>  	return NULL; /* do pick_next_task again */


Also, something like the below might be a cleanup -- I didn't check your
full series.

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6653,7 +6653,7 @@ proxy_resched_idle(struct rq *rq)
 	return rq->idle;
 }
 
-static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
+static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
 {
 	unsigned long state = READ_ONCE(donor->__state);
 
@@ -6673,6 +6673,19 @@ static bool proxy_deactivate(struct rq *
 	return try_to_block_task(rq, donor, state, true);
 }
 
+static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *donor)
+{
+	if (!__proxy_deactivate(rq, donor)) {
+		/*
+		 * XXX: For now, if deactivation failed, set donor
+		 * as unblocked, as we aren't doing proxy-migrations
+		 * yet (more logic will be needed then).
+		 */
+		donor->blocked_on = NULL;
+	}
+	return NULL;
+}
+
 /*
  * Find runnable lock owner to proxy for mutex blocked donor
  *
@@ -6691,23 +6704,17 @@ static bool proxy_deactivate(struct rq *
 static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 {
-	struct task_struct *owner = NULL;
-	struct task_struct *ret = NULL;
+	struct task_struct *owner, *p;
 	int this_cpu = cpu_of(rq);
-	struct task_struct *p;
 	struct mutex *mutex;
 
 	/* Follow blocked_on chain. */
-	for (p = donor; task_is_blocked(p); p = owner) {
-		mutex = p->blocked_on;
-		/* Something changed in the chain, so pick again */
-		if (!mutex)
-			return NULL;
+	for (p = donor; (mutex = p->blocked_on); p = owner) {
 		/*
 		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
 		 * and ensure @owner sticks around.
 		 */
-		raw_spin_lock(&mutex->wait_lock);
+		guard(raw_spinlock)(&mutex->wait_lock);
 
 		/* Check again that p is blocked with wait_lock held */
 		if (mutex != __get_task_blocked_on(p)) {
@@ -6717,22 +6724,17 @@ find_proxy_task(struct rq *rq, struct ta
 			 * just bail out completely and let __schedule
 			 * figure things out (pick_again loop).
 			 */
-			goto out;
+			return NULL;
 		}
 
 		owner = __mutex_owner(mutex);
 		if (!owner) {
 			__clear_task_blocked_on(p, mutex);
-			ret = p;
-			goto out;
+			return p;
 		}
 
-		if (task_cpu(owner) != this_cpu) {
-			/* XXX Don't handle migrations yet */
-			if (!proxy_deactivate(rq, donor))
-				goto deactivate_failed;
-			goto out;
-		}
+		if (task_cpu(owner) != this_cpu)
+			return proxy_deactivate(rq, donor);
 
 		if (task_on_rq_migrating(owner)) {
 			/*
@@ -6743,22 +6745,17 @@ find_proxy_task(struct rq *rq, struct ta
 			 * case we should end up back in find_proxy_task(), this time
 			 * hopefully with all relevant tasks already enqueued.
 			 */
-			raw_spin_unlock(&mutex->wait_lock);
-			return proxy_resched_idle(rq);
+			goto ret_idle;
 		}
 
 		if (!owner->on_rq) {
 			/* XXX Don't handle blocked owners yet */
-			if (!proxy_deactivate(rq, donor))
-				goto deactivate_failed;
-			goto out;
+			return proxy_deactivate(rq, donor);
 		}
 
 		if (owner->se.sched_delayed) {
 			/* XXX Don't handle delayed dequeue yet */
-			if (!proxy_deactivate(rq, donor))
-				goto deactivate_failed;
-			goto out;
+			return proxy_deactivate(rq, donor);
 		}
 
 		if (owner == p) {
@@ -6784,8 +6781,7 @@ find_proxy_task(struct rq *rq, struct ta
 			 * So schedule rq->idle so that ttwu_runnable can get the rq lock
 			 * and mark owner as running.
 			 */
-			raw_spin_unlock(&mutex->wait_lock);
-			return proxy_resched_idle(rq);
+			goto ret_idle;
 		}
 
 		/*
@@ -6793,22 +6789,13 @@ find_proxy_task(struct rq *rq, struct ta
 		 * rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
-		raw_spin_unlock(&mutex->wait_lock);
 	}
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 
-deactivate_failed:
-	/*
-	 * XXX: For now, if deactivation failed, set donor
-	 * as unblocked, as we aren't doing proxy-migrations
-	 * yet (more logic will be needed then).
-	 */
-	donor->blocked_on = NULL; /* XXX not following locking rules :( */
-out:
-	raw_spin_unlock(&mutex->wait_lock);
-	return NULL; /* do pick_next_task again */
+ret_idle:
+	return proxy_resched_idle(rq);
 }
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *


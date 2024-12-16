Return-Path: <linux-kernel+bounces-447776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D49F36D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D7E1638B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB3209691;
	Mon, 16 Dec 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Of1+CeMK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9222063C9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368075; cv=none; b=MoyluSWed7P4j7wAeZpA+XuI5GfVegyEKq8s+F33vXNTyQzme6pRnriHsuMGhf6Q6Cfau4sEKhDQYtHjCXGFIreIrZvrw47ZAM400yRcCfUJBkgOMTVUuD/aBnG7IgqyaTqeHDE55iER8ueownExREBxy9rbUC9AkSKrA7lSVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368075; c=relaxed/simple;
	bh=7A0davVIwiuSEmuPTLBJUHT0Al8qNb8UxsZyk/HAbe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLu8ntimJFR5uPZnh9Rp2V+DvfNmxXS+lkbPIOeveV+NPLYcW3XK2v/9WwtikL8Sk7DgDflHNcRE0weOXqiK2m6sYaIbN0HZXh0mB+lVVxWcbtdhUrdVS2Bs4cryQQLQsNgLmFrsteHAu2MkFnRT8RWw4khpESYF2beEmms27dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Of1+CeMK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=96t2WbR0Dygs8PZjguz/sy8Oqz4g6k7vcC/SQJy+9II=; b=Of1+CeMK7FyrRDMltZ6Rxnhb77
	xWhWmFa7EluvfpevIm2QjXeSq6ZGGvGwaFOOep6PvznRBmWgeatpM1IYmr/wIugw5NgCF+Y3NQe2r
	WcMbHCrjQtMv+AdCdAUP+TU8wJuRbb7qhk5tnannxubvZDhOvxcQ+2lYA56IIm4FDxYCec0CfvsvX
	KeKjGRwREIUCvW79jTx/FH3gUcgNbLQAtCQcELjXWt603cJIbkCBG1HZBozMMH6xAkjzL6aFJvBe4
	D+jIA8HRHNMcGn/1LSowAYg4S70cDenjQD4MuxDqzX5QxI4OdSWvVvfLCDJzot0PFBc9jLgO3L6/9
	at2O3mUw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEMO-00000004uHG-1RR3;
	Mon, 16 Dec 2024 16:54:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 480C830031E; Mon, 16 Dec 2024 17:54:19 +0100 (CET)
Date: Mon, 16 Dec 2024 17:54:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
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
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC][PATCH v14 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20241216165419.GE35539@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-3-jstultz@google.com>
 <20241213232214.GA17501@noisy.programming.kicks-ass.net>
 <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>

On Fri, Dec 13, 2024 at 07:39:57PM -0800, John Stultz wrote:
> On Fri, Dec 13, 2024 at 3:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 25, 2024 at 11:51:56AM -0800, John Stultz wrote:
> >
> > > Also add a blocked_on_state value so we can distinguish when a
> > > task is blocked_on a mutex, but is either blocked, waking up, or
> > > runnable (such that it can try to acquire the lock its blocked
> > > on).
> > >
> > > This avoids some of the subtle & racy games where the blocked_on
> > > state gets cleared, only to have it re-added by the
> > > mutex_lock_slowpath call when it tries to acquire the lock on
> > > wakeup
> >
> > If you can remember those sublte cases, I'm sure our future selves
> > would've loved it if you wrote a comment to go with these states :-)
> 
> Thanks so much for the review feedback! I really appreciate it!
> 
> So yes, the description can use improvement here. I at one time had
> 3-4 separate very fine grained patches (see the top 4 patches here:
> https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc6-fine-grained/?after=c4cad6e353c00254a2dfbb227ef81d8c3827427d+35)
> that I rolled into one when sending out(mostly to avoid overwhelming
> folks), but the squished commit description isn't as clear.
> So if it's helpful I can split this back out?
> 
> I'll also add some better comments as well.

Not sure yet about splitting back out -- let me try and figure out what
all is actually done / needed.

So blocked_lock started out as another lock around ttwu(), in order to
serialize the task wakeup vs reading a remote ->blocked_on relation.

Since we do this with rq->lock held, it can't be ->pi_lock, and hence
->blocked_lock was born.

Later patches appear to have moved it into mutex, mirroring the
->wait_lock -- this is probably better.

/me goes chase that state thing for a bit..

So, this all seems to have started with:

  https://github.com/johnstultz-work/linux-dev/commit/c122552e07b75bb39d0297431799801de30f147f


> > > @@ -627,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> > >                       goto err_early_kill;
> > >       }
> > >
> > > +     set_task_blocked_on(current, lock);
> > >       set_current_state(state);
> >
> > blocked_on_state mirrors task-state
> 
> Yea. I know I always move a little fast in my talks but at OSPM and
> LPC, but I've raised the point that the blocked_on_state very much
> seems like it aliases the task->__state.
> (See slide 26: https://lpc.events/event/18/contributions/1887/attachments/1402/3074/LPC_%20Proxy%20Exec%20deep%20dive%20outline.pdf)
> 
> I've not quite worked out how to integrate it though.
> 
> My initial introduction of the blocked_on_state was mostly to help
> detangle the code, as there were a number of cases originally where in
> order to let the task be selected to try to acquire the mutex, we
> cleared the task->blocked_on pointer.  But this often ran into races
> with ttwu, as if it cleared the blocked_on pointer, the task could get
> selected to run before the return migration happened. So having the
> tri-state BLOCKED->WAKING->RUNNABLE be explicit helped ensure we
> enforced the rules properly so we didn't run on the wrong cpu.

Right, so we already have a TASK_WAKING state, that is that
intermediate. But let me try and get a feel for how things relate;
TASK_WAKING is after we've determined it is elegible for wakeup, but
before it is enqueued -- eg. it sits on the wakelist.

This BO_WAKING is not quite that. It happens before doing the actual
wakeup.

Also, when I pull your proxy-exec-v7-6.7-rc6-fine-gained and put that
next to your slides, I'm a little confused.

Specifically, slide 27 talks about a modification to try_to_wake_up() in
order to force the task into ttwu_runnable() such that it then hits
proxy_needs_return(). This latter part I can find, but not the former.

/me puzzles

Hmm, since a blocked task is on the runqueue and all that, you should
always walk that path, anything else would be buggy.

So fundamentally the problem is that you want to do a reverse migration
-- it needs to go back to a CPU where it is allowed to run. The way it
does this is to dequeue itself and let ttwu continue and clean up the
mess.

This all makes sense, but why can't you do this on the waking side? That
is, instead of setting BO_WAKING, do this whole if (!is_cpu_allowed())
deactivate_task() thing right there, before issuing the wakeup.

Notably, that sched_proxy_exec() block in __mutex_unlock_slowpath():

 - probably doesn't need current->blocked_lock, current isn't blocked
 
 - probably doesn't need lock->wait_lock, donor is stable under
   preempt_disable().


Something like the completely untested below (also, ttwu path needs
surgery now):

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2711af8c0052..47cfa01cd066 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -946,32 +946,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	}
 
 	preempt_disable();
+	next = proxy_handoff(lock);
+
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 
-	if (sched_proxy_exec()) {
-		raw_spin_lock(&current->blocked_lock);
-		/*
-		 * If we have a task boosting current, and that task was boosting
-		 * current through this lock, hand the lock to that task, as that
-		 * is the highest waiter, as selected by the scheduling function.
-		 */
-		donor = current->blocked_donor;
-		if (donor) {
-			struct mutex *next_lock;
-
-			raw_spin_lock_nested(&donor->blocked_lock, SINGLE_DEPTH_NESTING);
-			next_lock = get_task_blocked_on(donor);
-			if (next_lock == lock) {
-				next = donor;
-				donor->blocked_on_state = BO_WAKING;
-				wake_q_add(&wake_q, donor);
-				current->blocked_donor = NULL;
-			}
-			raw_spin_unlock(&donor->blocked_lock);
-		}
-	}
-
 	/*
 	 * Failing that, pick any on the wait list.
 	 */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6eaffa913495..30d7371bb5c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4035,6 +4035,53 @@ static inline void activate_blocked_entities(struct rq *target_rq,
 }
 #endif /* CONFIG_SCHED_PROXY_EXEC */
 
+struct task_struct *proxy_handoff(struct mutex *lock);
+{
+	struct task_struct *next;
+
+	if (!sched_proxy_exec())
+		return NULL;
+
+	/*
+	 * current->blocked_donor can't change if we can't schedule
+	 * caller needs to do this, since its needs stabiliy of return value
+	 */
+	lockdep_assert_preemption_disabled();
+	next = current->blocked_donor;
+	if (!next)
+		return NULL;
+
+	scoped_guard (task_rq_lock, next) {
+		/*
+		 * current->blocked_donor had better be on the same CPU as current
+		 */
+		WARN_ON_ONCE(scope.rq != this_rq());
+
+		scoped_guard (raw_spin_lock, next->blocked_lock) {
+			/*
+			 * WARN_ON on this? How can this happen
+			 */
+			if (next->blocked_on != lock)
+				return NULL;
+		}
+
+		/*
+		 * blocked_on relation is stable, since we hold both
+		 * next->pi_lock and it's rq->lock
+		 *
+		 * OK -- we have a donor, it is blocked on the lock we're about
+		 * to release and it cannot run on this CPU -- fixies are
+		 * required.
+		 *
+		 * Dequeue the task, such that ttwu() can fix up the placement thing.
+		 */
+		if (!is_cpu_allowed(next, cpu_of(scope.rq)))
+			deactivate_task(scope.rq, next, DEQUEUE_SLEEP);
+	}
+
+	return next;
+}
+
 #ifdef CONFIG_SMP
 static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 {


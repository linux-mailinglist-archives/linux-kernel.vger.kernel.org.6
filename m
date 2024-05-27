Return-Path: <linux-kernel+bounces-190532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623BC8CFF96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1201A281D62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998715ECE2;
	Mon, 27 May 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCKRRG2x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7A15ECDE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811652; cv=none; b=cO+Zlr60mxJVMq7eoG36uZfSSdT9rzKLok2XqMkYC1gCpZQg6C74q/PTOVBnRf0lZSvBg5WGzpqPALZWxRYQWldpsqjwhPmZq/B3ZzMZbkauh/QFBQrx6VreRc1mM8DakpyhxQWMsBjXjhmTcjLYM2kMwsgpF3EkelnvkWasPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811652; c=relaxed/simple;
	bh=v0GEfxwNhDkKjb2yyYTKi/u+TmOm87sO5ofC42i4j/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNBxVR7dTf3cCXAVkbPyjayj32rp2Bd8s7R/Qys5f4OS53RSySE04X2eP7M5IXsBtMXfaqoh3ATSnf4w7SztP9z6NhXhGdcs/xZF+XDNVi/TZmYCntBJe7+3GmSxv0WhdtGTAl9+JbfwfESvA2u2++hA10EXRF8UUB69V045lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCKRRG2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6982FC2BBFC;
	Mon, 27 May 2024 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811652;
	bh=v0GEfxwNhDkKjb2yyYTKi/u+TmOm87sO5ofC42i4j/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCKRRG2xnvWcz5I30mZ7uv40nqJqtLYljK4pDCrI6QH64p3ICa1L7vKdkc5t/nKHD
	 nsvUwi1z30I3JnE3JVK26H02s86/Cwq7uOeruZCAaakfuFYdz9rBuN87H2DrBXKFmu
	 X2adIBwE+CNwMej4pRvsyhf1zUwHmnH8sJt5p8hmBhyX0IYYXmbtgPHk9NDd44u8kJ
	 xsreIOheJ3Kd0ElCY+vli2f92bLWgxgSRt3r3RVeDhQ5ChC/TdI6cZ8vZiDEnhUpNg
	 teTd9cqdlXozvX9O4ku4b0rHg2wccrHD3TSsT5YaSvzFF/ukwm6ARicD7ywivR+vU6
	 lmx15DqqeZy7A==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V7 5/9] sched/deadline: Deferrable dl server
Date: Mon, 27 May 2024 14:06:51 +0200
Message-ID: <dd175943c72533cd9f0b87767c6499204879cc38.1716811044.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Among the motivations for the DL servers is the real-time throttling
mechanism. This mechanism works by throttling the rt_rq after
running for a long period without leaving space for fair tasks.

The base dl server avoids this problem by boosting fair tasks instead
of throttling the rt_rq. The point is that it boosts without waiting
for potential starvation, causing some non-intuitive cases.

For example, an IRQ dispatches two tasks on an idle system, a fair
and an RT. The DL server will be activated, running the fair task
before the RT one. This problem can be avoided by deferring the
dl server activation.

By setting the defer option, the dl_server will dispatch an
SCHED_DEADLINE reservation with replenished runtime, but throttled.

The dl_timer will be set for the defer time at (period - runtime) ns
from start time. Thus boosting the fair rq at defer time.

If the fair scheduler has the opportunity to run while waiting
for defer time, the dl server runtime will be consumed. If
the runtime is completely consumed before the defer time, the
server will be replenished while still in a throttled state. Then,
the dl_timer will be reset to the new defer time

If the fair server reaches the defer time without consuming
its runtime, the server will start running, following CBS rules
(thus without breaking SCHED_DEADLINE). Then the server will
continue the running state (without deferring) until it fair
tasks are able to execute as regular fair scheduler (end of
the starvation).

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h   |  12 ++
 kernel/sched/deadline.c | 301 ++++++++++++++++++++++++++++++++++------
 kernel/sched/fair.c     |  24 +++-
 kernel/sched/idle.c     |   2 +
 kernel/sched/sched.h    |   4 +-
 5 files changed, 298 insertions(+), 45 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index abce356932cc..611771fec4df 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -639,12 +639,24 @@ struct sched_dl_entity {
 	 * overruns.
 	 *
 	 * @dl_server tells if this is a server entity.
+	 *
+	 * @dl_defer tells if this is a deferred or regular server. For
+	 * now only defer server exists.
+	 *
+	 * @dl_defer_armed tells if the deferrable server is waiting
+	 * for the replenishment timer to activate it.
+	 *
+	 * @dl_defer_running tells if the deferrable server is actually
+	 * running, skipping the defer phase.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_defer	  : 1;
+	unsigned int			dl_defer_armed	  : 1;
+	unsigned int			dl_defer_running  : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b69d6c3e1587..eddfe18d9762 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -771,6 +771,15 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	/* for non-boosted task, pi_of(dl_se) == dl_se */
 	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
 	dl_se->runtime = pi_of(dl_se)->dl_runtime;
+
+	/*
+	 * If it is a deferred reservation, and the server
+	 * is not handling an starvation case, defer it.
+	 */
+	if (dl_se->dl_defer & !dl_se->dl_defer_running) {
+		dl_se->dl_throttled = 1;
+		dl_se->dl_defer_armed = 1;
+	}
 }
 
 /*
@@ -809,6 +818,9 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	replenish_dl_new_period(dl_se, rq);
 }
 
+static int start_dl_timer(struct sched_dl_entity *dl_se);
+static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
+
 /*
  * Pure Earliest Deadline First (EDF) scheduling does not deal with the
  * possibility of a entity lasting more than what it declared, and thus
@@ -837,9 +849,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	/*
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
+	 *
+	 * Or, it could be the case of a deferred reservation that
+	 * was not able to consume its runtime in background and
+	 * reached this point with current u > U.
+	 *
+	 * In both cases, set a new period.
 	 */
-	if (dl_se->dl_deadline == 0)
-		replenish_dl_new_period(dl_se, rq);
+	if (dl_se->dl_deadline == 0 ||
+	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
+		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+	}
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;
@@ -873,6 +894,44 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 		dl_se->dl_yielded = 0;
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
+
+	/*
+	 * If this is the replenishment of a deferred reservation,
+	 * clear the flag and return.
+	 */
+	if (dl_se->dl_defer_armed) {
+		dl_se->dl_defer_armed = 0;
+		return;
+	}
+
+	/*
+	 * A this point, if the deferred server is not armed, and the deadline
+	 * is in the future, if it is not running already, throttle the server
+	 * and arm the defer timer.
+	 */
+	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
+	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
+		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
+
+			/*
+			 * Set dl_se->dl_defer_armed and dl_throttled variables to
+			 * inform the start_dl_timer() that this is a deferred
+			 * activation.
+			 */
+			dl_se->dl_defer_armed = 1;
+			dl_se->dl_throttled = 1;
+			if (!start_dl_timer(dl_se)) {
+				/*
+				 * If for whatever reason (delays), a previous timer was
+				 * queued but not serviced, cancel it and clean the
+				 * deferrable server variables intended for start_dl_timer().
+				 */
+				hrtimer_try_to_cancel(&dl_se->dl_timer);
+				dl_se->dl_defer_armed = 0;
+				dl_se->dl_throttled = 0;
+			}
+		}
+	}
 }
 
 /*
@@ -1023,6 +1082,15 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 		}
 
 		replenish_dl_new_period(dl_se, rq);
+	} else if (dl_server(dl_se) && dl_se->dl_defer) {
+		/*
+		 * The server can still use its previous deadline, so check if
+		 * it left the dl_defer_running state.
+		 */
+		if (!dl_se->dl_defer_running) {
+			dl_se->dl_defer_armed = 1;
+			dl_se->dl_throttled = 1;
+		}
 	}
 }
 
@@ -1055,8 +1123,21 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
 	 * We want the timer to fire at the deadline, but considering
 	 * that it is actually coming from rq->clock and not from
 	 * hrtimer's time base reading.
+	 *
+	 * The deferred reservation will have its timer set to
+	 * (deadline - runtime). At that point, the CBS rule will decide
+	 * if the current deadline can be used, or if a replenishment is
+	 * required to avoid add too much pressure on the system
+	 * (current u > U).
 	 */
-	act = ns_to_ktime(dl_next_period(dl_se));
+	if (dl_se->dl_defer_armed) {
+		WARN_ON_ONCE(!dl_se->dl_throttled);
+		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
+	} else {
+		/* act = deadline - rel-deadline + period */
+		act = ns_to_ktime(dl_next_period(dl_se));
+	}
+
 	now = hrtimer_cb_get_time(timer);
 	delta = ktime_to_ns(now) - rq_clock(rq);
 	act = ktime_add_ns(act, delta);
@@ -1106,6 +1187,62 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 #endif
 }
 
+/* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
+static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
+
+static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
+{
+	struct rq *rq = rq_of_dl_se(dl_se);
+	u64 fw;
+
+	scoped_guard (rq_lock, rq) {
+		struct rq_flags *rf = &scope.rf;
+
+		if (!dl_se->dl_throttled || !dl_se->dl_runtime)
+			return HRTIMER_NORESTART;
+
+		sched_clock_tick();
+		update_rq_clock(rq);
+
+		if (!dl_se->dl_runtime)
+			return HRTIMER_NORESTART;
+
+		if (!dl_se->server_has_tasks(dl_se)) {
+			replenish_dl_entity(dl_se);
+			return HRTIMER_NORESTART;
+		}
+
+		if (dl_se->dl_defer_armed) {
+			/*
+			 * First check if the server could consume runtime in background.
+			 * If so, it is possible to push the defer timer for this amount
+			 * of time. The dl_server_min_res serves as a limit to avoid
+			 * forwarding the timer for a too small amount of time.
+			 */
+			if (dl_time_before(rq_clock(dl_se->rq),
+					   (dl_se->deadline - dl_se->runtime - dl_server_min_res))) {
+
+				/* reset the defer timer */
+				fw = dl_se->deadline - rq_clock(dl_se->rq) - dl_se->runtime;
+
+				hrtimer_forward_now(timer, ns_to_ktime(fw));
+				return HRTIMER_RESTART;
+			}
+
+			dl_se->dl_defer_running = 1;
+		}
+
+		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+
+		if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
+			resched_curr(rq);
+
+		__push_dl_task(rq, rf);
+	}
+
+	return HRTIMER_NORESTART;
+}
+
 /*
  * This is the bandwidth enforcement timer callback. If here, we know
  * a task is not on its dl_rq, since the fact that the timer was running
@@ -1128,28 +1265,8 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (dl_server(dl_se)) {
-		struct rq *rq = rq_of_dl_se(dl_se);
-		struct rq_flags rf;
-
-		rq_lock(rq, &rf);
-		if (dl_se->dl_throttled) {
-			sched_clock_tick();
-			update_rq_clock(rq);
-
-			if (dl_se->server_has_tasks(dl_se)) {
-				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
-				resched_curr(rq);
-				__push_dl_task(rq, &rf);
-			} else {
-				replenish_dl_entity(dl_se);
-			}
-
-		}
-		rq_unlock(rq, &rf);
-
-		return HRTIMER_NORESTART;
-	}
+	if (dl_server(dl_se))
+		return dl_server_timer(timer, dl_se);
 
 	p = dl_task_of(dl_se);
 	rq = task_rq_lock(p, &rf);
@@ -1319,22 +1436,10 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 	return (delta * u_act) >> BW_SHIFT;
 }
 
-static inline void
-update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
-                        int flags);
-static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
+s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	s64 scaled_delta_exec;
 
-	if (unlikely(delta_exec <= 0)) {
-		if (unlikely(dl_se->dl_yielded))
-			goto throttle;
-		return;
-	}
-
-	if (dl_entity_is_special(dl_se))
-		return;
-
 	/*
 	 * For tasks that participate in GRUB, we implement GRUB-PA: the
 	 * spare reclaimed bandwidth is used to clock down frequency.
@@ -1353,8 +1458,64 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
 	}
 
+	return scaled_delta_exec;
+}
+
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags);
+static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
+{
+	s64 scaled_delta_exec;
+
+	if (unlikely(delta_exec <= 0)) {
+		if (unlikely(dl_se->dl_yielded))
+			goto throttle;
+		return;
+	}
+
+	if (dl_server(dl_se) && dl_se->dl_throttled && !dl_se->dl_defer)
+		return;
+
+	if (dl_entity_is_special(dl_se))
+		return;
+
+	scaled_delta_exec = dl_scaled_delta_exec(rq, dl_se, delta_exec);
+
 	dl_se->runtime -= scaled_delta_exec;
 
+	/*
+	 * The fair server can consume its runtime while throttled (not queued/
+	 * running as regular CFS).
+	 *
+	 * If the server consumes its entire runtime in this state. The server
+	 * is not required for the current period. Thus, reset the server by
+	 * starting a new period, pushing the activation.
+	 */
+	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
+		/*
+		 * If the server was previously activated - the starving condition
+		 * took place, it this point it went away because the fair scheduler
+		 * was able to get runtime in background. So return to the initial
+		 * state.
+		 */
+		dl_se->dl_defer_running = 0;
+
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+
+		replenish_dl_new_period(dl_se, dl_se->rq);
+
+		/*
+		 * Not being able to start the timer seems problematic. If it could not
+		 * be started for whatever reason, we need to "unthrottle" the DL server
+		 * and queue right away. Otherwise nothing might queue it. That's similar
+		 * to what enqueue_dl_entity() does on start_dl_timer==0. For now, just warn.
+		 */
+		WARN_ON_ONCE(!start_dl_timer(dl_se));
+
+		return;
+	}
+
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
 		dl_se->dl_throttled = 1;
@@ -1414,9 +1575,46 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	}
 }
 
+/*
+ * In the non-defer mode, the idle time is not accounted, as the
+ * server provides a guarantee.
+ *
+ * If the dl_server is in defer mode, the idle time is also considered
+ * as time available for the fair server, avoiding a penalty for the
+ * rt scheduler that did not consumed that time.
+ */
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+{
+	s64 delta_exec, scaled_delta_exec;
+
+	if (!rq->fair_server.dl_defer)
+		return;
+
+	/* no need to discount more */
+	if (rq->fair_server.runtime < 0)
+		return;
+
+	delta_exec = rq_clock_task(rq) - p->se.exec_start;
+	if (delta_exec < 0)
+		return;
+
+	scaled_delta_exec = dl_scaled_delta_exec(rq, &rq->fair_server, delta_exec);
+
+	rq->fair_server.runtime -= scaled_delta_exec;
+
+	if (rq->fair_server.runtime < 0) {
+		rq->fair_server.dl_defer_running = 0;
+		rq->fair_server.runtime = 0;
+	}
+
+	p->se.exec_start = rq_clock_task(rq);
+}
+
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+	/* 0 runtime = fair server disabled */
+	if (dl_se->dl_runtime)
+		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
 void dl_server_start(struct sched_dl_entity *dl_se)
@@ -1430,6 +1628,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
 
 		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
 	}
 
@@ -1447,6 +1646,9 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 		return;
 
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+	hrtimer_try_to_cancel(&dl_se->dl_timer);
+	dl_se->dl_defer_armed = 0;
+	dl_se->dl_throttled = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -1758,7 +1960,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	 * be counted in the active utilization; hence, we need to call
 	 * add_running_bw().
 	 */
-	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+	if (!dl_se->dl_defer && dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
 		if (flags & ENQUEUE_WAKEUP)
 			task_contending(dl_se, flags);
 
@@ -1780,6 +1982,25 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 		setup_new_dl_entity(dl_se);
 	}
 
+	/*
+	 * If the reservation is still throttled, e.g., it got replenished but is a
+	 * deferred task and still got to wait, don't enqueue.
+	 */
+	if (dl_se->dl_throttled && start_dl_timer(dl_se))
+		return;
+
+	/*
+	 * We're about to enqueue, make sure we're not ->dl_throttled!
+	 * In case the timer was not started, say because the defer time
+	 * has passed, mark as not throttled and mark unarmed.
+	 * Also cancel earlier timers, since letting those run is pointless.
+	 */
+	if (dl_se->dl_throttled) {
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+		dl_se->dl_defer_armed = 0;
+		dl_se->dl_throttled = 0;
+	}
+
 	__enqueue_dl_entity(dl_se);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d5d3e6c1e72..20e8b02c5cb3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1156,12 +1156,13 @@ s64 update_curr_common(struct rq *rq)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	delta_exec = update_curr_se(rq, curr);
 	if (unlikely(delta_exec <= 0))
 		return;
 
@@ -1169,8 +1170,19 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr))
-		update_curr_task(task_of(curr), delta_exec);
+	if (entity_is_task(curr)) {
+		struct task_struct *p = task_of(curr);
+
+		update_curr_task(p, delta_exec);
+
+		/*
+		 * Any fair task that runs outside of fair_server should
+		 * account against fair_server such that it can account for
+		 * this time and possibly avoid running this period.
+		 */
+		if (p->dl_server != &rq->fair_server)
+			dl_server_update(&rq->fair_server, delta_exec);
+	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
@@ -6769,8 +6781,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running)
+	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr);
 		dl_server_start(&rq->fair_server);
+	}
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6135fbe83d68..5f8806bc6924 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -458,12 +458,14 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+	dl_server_update_idle_time(rq, prev);
 }
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	next->se.exec_start = rq_clock_task(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 39c9669b23a7..76751b945474 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -328,7 +328,7 @@ extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int  dl_bw_check_overflow(int cpu);
-
+extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec);
 /*
  * SCHED_DEADLINE supports servers (nested scheduling) with the following
  * interface:
@@ -356,6 +356,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void dl_server_update_idle_time(struct rq *rq,
+		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
 
 #ifdef CONFIG_CGROUP_SCHED
-- 
2.45.1



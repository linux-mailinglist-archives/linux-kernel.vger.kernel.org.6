Return-Path: <linux-kernel+bounces-390827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A383E9B7EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F611F22A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4EC1C1ACB;
	Thu, 31 Oct 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GRxH1ijY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o9QnRikO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DC1BD515
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389599; cv=none; b=D3XeqcAc5qbd1KuvOdngmTa3STIw6edpDSIoVmtWUOMKcJd4PwTuKg6yHsIoChAlKnK517EL85IZ9ttnJPhxH0YGo5A3A1eL7xNiYP6qzcugi7lDoXGs+d4aG/JK7+9XyXWQmlBgDJv/PQQnhjYScGg06GZvrBbpyFRUHZlTcAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389599; c=relaxed/simple;
	bh=CexgufO+1Osh5TMOL66HRJxKyFDyiRssUXwnxU9QZ7A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MJlEE96/946HhJQkaDNpQY6IPNeMXXS4YwMCdzQCl0TKmUACIjR+AAbs/ihUiyKruSTnVTh8CEpP1TWh0/yMMvJeY3V1E5tlchipf/x6X7h2wQkl9YfpGhgLaDzvRe194Z0F+SnMkjcdnMw+IBiAkALb7OQ1guD0Z0s7ltjd22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GRxH1ijY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o9QnRikO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.119202459@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ChIynh12PYnBXnJ3TWILE4o90Tsj+76TEesTqrWpYsU=;
	b=GRxH1ijYp8N1NtIJU+yFpPeI7GWAjrUJ/LA6m0sanotdE1tectOHaWYmyD2HAySlmZtvUl
	7BjxXP3C/aillEvm7WYZoYVM8gVde2S8IeF1IJzNV+OE/bi8hKjVHHPhtEg3T0a0z1lsXA
	hi0+clRIbKWF0tzF8liNuxvuY+kIBK4lv+kDACyQ1/nBj3GvZzu422CnHdM5DrF0sRi2m8
	n3JIegp7bYiiLWhyC8KQnZUD3ZEAjBy6BHFyLj/yAurUbNwWy9A801FP3M0Afg9gCJDauM
	osp5efm9U6m28PFgUO1bpiQqLA6FkGg5Gva6Ja9I3sj935QwdxyltLpYbr/85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ChIynh12PYnBXnJ3TWILE4o90Tsj+76TEesTqrWpYsU=;
	b=o9QnRikOMkaxkTGjXEaAzzFFmGXW/0IpSuGeLe9T3n/DPcucqwc+fjSpQdLOFPDFTnVWxQ
	FyOUe2EkZpFeLDAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v6 09/20] signal: Refactor send_sigqueue()
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:34 +0100 (CET)

To handle posix timers which have their signal ignored via SIG_IGN properly
it is required to requeue a ignored signal for delivery when SIG_IGN is
lifted so the timer gets rearmed.

Split the required code out of send_sigqueue() so it can be reused in
context of sigaction().

While at it rename send_sigqueue() to posixtimer_send_sigqueue() so its
clear what this is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h |    1 
 include/linux/sched/signal.h |    1 
 kernel/signal.c              |   82 +++++++++++++++++++++++--------------------
 kernel/time/posix-timers.c   |    2 -
 4 files changed, 47 insertions(+), 39 deletions(-)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -109,6 +109,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
+int posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -340,7 +340,6 @@ extern int send_sig(int, struct task_str
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1947,40 +1947,54 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
+static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t, enum pid_type type)
 {
-	int sig = q->info.si_signo;
 	struct sigpending *pending;
+	int sig = q->info.si_signo;
+
+	signalfd_notify(t, sig);
+	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
+	list_add_tail(&q->list, &pending->list);
+	sigaddset(&pending->signal, sig);
+	complete_signal(sig, t, type);
+}
+
+/*
+ * This function is used by POSIX timers to deliver a timer signal.
+ * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
+ * set), the signal must be delivered to the specific thread (queues
+ * into t->pending).
+ *
+ * Where type is not PIDTYPE_PID, signals must be delivered to the
+ * process. In this case, prefer to deliver to current if it is in
+ * the same thread group as the target process, which avoids
+ * unnecessarily waking up a potentially idle task.
+ */
+static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
+{
+	struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
+
+	if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
+		t = current;
+	return t;
+}
+
+int posixtimer_send_sigqueue(struct k_itimer *tmr)
+{
+	struct sigqueue *q = tmr->sigq;
+	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
 	int ret, result;
 
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return 0;
-	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
-		return 0;
+	guard(rcu)();
 
-	ret = -1;
-	rcu_read_lock();
-
-	/*
-	 * This function is used by POSIX timers to deliver a timer signal.
-	 * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
-	 * set), the signal must be delivered to the specific thread (queues
-	 * into t->pending).
-	 *
-	 * Where type is not PIDTYPE_PID, signals must be delivered to the
-	 * process. In this case, prefer to deliver to current if it is in
-	 * the same thread group as the target process, which avoids
-	 * unnecessarily waking up a potentially idle task.
-	 */
-	t = pid_task(pid, type);
+	t = posixtimer_get_target(tmr);
 	if (!t)
-		goto ret;
-	if (type != PIDTYPE_PID && same_thread_group(t, current))
-		t = current;
+		return -1;
+
 	if (!likely(lock_task_sighand(t, &flags)))
-		goto ret;
+		return -1;
 
 	/*
 	 * Update @q::info::si_sys_private for posix timer signals with
@@ -1988,30 +2002,24 @@ int send_sigqueue(struct sigqueue *q, st
 	 * decides based on si_sys_private whether to invoke
 	 * posixtimer_rearm() or not.
 	 */
-	q->info.si_sys_private = si_private;
+	q->info.si_sys_private = tmr->it_signal_seq;
 
 	ret = 1; /* the signal is ignored */
-	result = TRACE_SIGNAL_IGNORED;
-	if (!prepare_signal(sig, t, false))
+	if (!prepare_signal(sig, t, false)) {
+		result = TRACE_SIGNAL_IGNORED;
 		goto out;
+	}
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-
-	signalfd_notify(t, sig);
-	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
-	list_add_tail(&q->list, &pending->list);
-	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, type);
+	posixtimer_queue_sigqueue(q, t, tmr->it_pid_type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
-	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
+	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
-ret:
-	rcu_read_unlock();
 	return ret;
 }
 #endif /* CONFIG_POSIX_TIMERS */
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -307,7 +307,7 @@ int posix_timer_queue_signal(struct k_it
 
 	timr->it_status = state;
 
-	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
+	ret = posixtimer_send_sigqueue(timr);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }



Return-Path: <linux-kernel+bounces-341492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7E9880CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC2CB24696
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3F1B29B8;
	Fri, 27 Sep 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="djPS6DVs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T2w9BYgn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A81B252D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426943; cv=none; b=drgmpT8U9IogyXatGJo3wE2QhvCmWbNKFJOOPG1LfvREiU+jihpXeFvzX7mqrV9j4A1dLF7Rx5B7gN/NnvXAL30LCwNIg5nCmaKthr0bYz6gN+JfO5Xz1+aIyLzqUH5BiIh6UT3BYanHLDUrvm7qj6fSiRcDu09E7kkCz0Dwzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426943; c=relaxed/simple;
	bh=gmlXbfdqzo/4QeK3ossw6X30lZBL4wrLRlOZ35Jc6xc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ojzeFi5v4J31JjyjusuL9PBEC412Al/vTxfIjnOM93nCdgvrVTXXkbzZp8YfMVsjcY0H/TlizRixTpjpXg6wJdgwPU+oRZI+1lzQBODkPf1J105Cn29Mhjbvac+GQkLzcevPdxnddoGijELh+blhe0krgtSWjtymMC1E7PWrGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=djPS6DVs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T2w9BYgn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.948507874@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=okOUrbWkuU0neRq7h1aK4Wj+R1IhH/blhyN65/RKs4Q=;
	b=djPS6DVsjO6liHfqDHGJIcyzLUHlvHBohoTEp8E2UGiuD05dakFytPAB5fW16ybtSgVe4V
	0A/HzqmL2DhAUCocRhqhabnteeYlOruVhUMF5k/yNUN9EuUZr/VGaTkgPgozngYRiUhPnu
	UH8/0NTrienyyBUMuDiQg27V4Ddkga+hWDDSJXscezsXphkOHgP4rQ/oZaLT3gN5sBfzaP
	MXmZp6tplk3lO7HbW5X8SWhAiIfB9md/bX4CC6Nfb4LznjCYuybtTEo2k5ru2Tfuu2Hhi1
	BobjRzzm4REfrSb/ZVYYFTeKwKvqvdxzA6HdRUbeBXL31pdrdMIXC4OJUUFrNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=okOUrbWkuU0neRq7h1aK4Wj+R1IhH/blhyN65/RKs4Q=;
	b=T2w9BYgnC0uOCo11acuHqoHKgcSY0SsLUPtk5xgtJ+MjLSRzivPcgiQaQ5geMnWaMkFshl
	EHU2b3ScgsbAupDQ==
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
Subject: [patch v4 17/27] signal: Refactor send_sigqueue()
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:59 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To handle posix timers which have their signal ignored via SIG_IGN properly
it is required to requeue a ignored signal for delivery when SIG_IGN is
lifted so the timer gets rearmed.

Split the required code out of send_sigqueue() so it can be reused in
context of sigaction().

While at it rename send_sigqueue() to posixtimer_send_sigqueue() so its
clear what this is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h |  1 +-
 include/linux/sched/signal.h |  1 +-
 kernel/signal.c              | 73 +++++++++++++++++++++++++--------------------
 kernel/time/posix-timers.c   |  2 +-
 4 files changed, 44 insertions(+), 33 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 947176582de9..52611ea923b2 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -109,6 +109,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
+int posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index bd9f569231d9..36283c1c55e9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -340,7 +340,6 @@ extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index 0aa01eec5e2d..01102470e174 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1947,38 +1947,53 @@ void sigqueue_free(struct sigqueue *q)
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
-
 	ret = -1;
 	rcu_read_lock();
 
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
 		goto ret;
-	if (type != PIDTYPE_PID && same_thread_group(t, current))
-		t = current;
+
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
@@ -1988,7 +2003,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int s
 	 * decides based on si_sys_private whether to invoke
 	 * posixtimer_rearm() or not.
 	 */
-	q->info.si_sys_private = si_private;
+	q->info.si_sys_private = tmr->it_signal_seq;
 
 	/*
 	 * Set the overrun count to zero unconditionally. The posix timer
@@ -2019,24 +2034,20 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int s
 	q->info.si_overrun = 0;
 
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
 ret:
 	rcu_read_unlock();
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bf68d80a0d75..369c8f1c5e4c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -308,7 +308,7 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 	}
 	timr->it_status = state;
 
-	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
+	ret = posixtimer_send_sigqueue(timr);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }



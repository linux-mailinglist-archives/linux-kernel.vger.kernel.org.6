Return-Path: <linux-kernel+bounces-345543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0098B75A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A4D1C2126C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969A91A0AF2;
	Tue,  1 Oct 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzSJkuZq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AsozLfrk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBFD1A0733
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772143; cv=none; b=HquyoVQ5QpVPKlP32AlD5tavRlazM1vq8L3o0oA1pktqS2Te+LxdpxLRWoJLz97hsXuu3X/8opsPBoA+57jyqynCg63wcbzgfdm9235pPWYp4iq6AlxAiG3asrXlXdeFxLXnbbBEttdIkLgs4Y+GnwxKjgALsnfFMMrsqw78RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772143; c=relaxed/simple;
	bh=WyFuk/suctmcv8BFM7PlM005FryHmRRohpHmHbyRo5Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GHLxwRd9nQpd3TEBpa3x/ieuSibfFxQcvEpxmnEe9QJYKyCoBRmOymDWNT6+O7/b72zYkScUOlLqe+zxamqHzh8nGiY4rlnfGVJ6429g1rqo4nS2fIjozMOPthgSfWjlSdWREikJ4I6wrVtSJazTAdbt5PLyxUOnLzqwyjNuDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzSJkuZq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AsozLfrk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.160940133@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PxocNGfHSoOJ5DIOApgPE8UuY1gORaIild4LzEnBwws=;
	b=bzSJkuZqKzH+cdbQ7haNI15owB00znJO3A5eMeEIdmHEr/bLDI11ikac3yRnHlXWekpYXV
	racANEMCrFVfdXlAQLhtBSAwBSZx9Fl/YZ3jX0B+jqn0PeyRgxGbJUnNS/y+SsnSxJwC2l
	26gVC/rkRHw/eDKAxD25AADLofktG/9y+KTaQUNFEkrY/wooyp7qlYZCAuVkRKQyQUw86d
	1Z9zNsDneOHQOx+LCgbh9EB7/KDHCDdMGJmmKEu0R7T8aUU/uWrF3Lqwtb0V04fhbx0E/a
	t2Bt+8O0r6RJE1r887VHx8iZx8AvQ6x6+TkTylbwHUlE6ygVLeXSvk9EB8iaGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PxocNGfHSoOJ5DIOApgPE8UuY1gORaIild4LzEnBwws=;
	b=AsozLfrkf8xwcq16MeE8YdrzCP9yICmfEkmlImYtLztPY5MHFoosqA/VFtGR3nlEqazk3J
	PVyI00hA5ADMpfBA==
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
Subject: [patch V5 15/26] signal: Refactor send_sigqueue()
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:20 +0200 (CEST)

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
@@ -1949,40 +1949,54 @@ void sigqueue_free(struct sigqueue *q)
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
@@ -1990,7 +2004,7 @@ int send_sigqueue(struct sigqueue *q, st
 	 * decides based on si_sys_private whether to invoke
 	 * posixtimer_rearm() or not.
 	 */
-	q->info.si_sys_private = si_private;
+	q->info.si_sys_private = tmr->it_signal_seq;
 
 	/*
 	 * Set the overrun count to zero unconditionally. The posix timer
@@ -2021,27 +2035,21 @@ int send_sigqueue(struct sigqueue *q, st
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
-ret:
-	rcu_read_unlock();
 	return ret;
 }
 #endif /* CONFIG_POSIX_TIMERS */
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -307,7 +307,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
+	ret = posixtimer_send_sigqueue(timr);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }



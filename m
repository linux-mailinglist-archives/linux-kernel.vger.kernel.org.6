Return-Path: <linux-kernel+bounces-345529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1600098B74A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BE71F22FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331319ABC4;
	Tue,  1 Oct 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7CaYWHV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YTw3kA+H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D11E4AF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772124; cv=none; b=l6SmsOan5XI7JzrnXaNL2cDKpTblrNUm3FpCl/1xyY2fXPq1iXBTP0MitYD5rrfJhRSr+CBV5E1fUFD1a/j6QvbBjjIaMqT/QATidntk3C2+vsEftTjy6d4yQXBItWOOa9uzGFtgG6LOtpEQc6S04obclf9SVMGJxDCnjM6uf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772124; c=relaxed/simple;
	bh=fhSPKX8PS5jBj1jD/BvvLqlYrYimhgE67tPyDk5gkpw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bFGrLGGL7+RzmzotOjSznu8q9qRe4ztJTtk9XpTxapOqAaANTrZThOGcQrlhumsvzmnHP/TTdO4AweqwjxheiCgxeVkvhnL9ldnfSUiH8ixgN+sQox5nGF/gITQjds19kTMmiqxDQvogPcZ4goxs7zy9YPclxkZIemXRY3hiPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7CaYWHV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YTw3kA+H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.314100569@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jY/Ysxs3ZzGz/myGmp3wKK1jf40clRFR+vHBO2p3aPY=;
	b=e7CaYWHVFCpmEgah9VALGTh98sYTzvdB9kDyAEJPtgN/URnZJjuVXY94X5Xk0pxWxg2Er7
	fWmi922GCJ+U9WCn4KOHmgXuRvcrdK1iqimObdz3QEpWkn+xGpkrwZskxZBkW46nMLN0pK
	oh4GXE3T0/yrBwY1156uM6K4jbSCXqFt/98+jRRoV1h3ZbwihpTHH6ILGHa+GnS32CBP8H
	lvpEyTAf2ZZDLs3DTmKDI3d6WwSnM6lxDSBo1e3qy/99NZpJN9SFsYCYypd1wBhJ4p4cWx
	hYff5shKH2+zfVJMYodcUaieEws+7XDHo11jGFsg08dnJ0uxjSBbMiIxaLDvQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jY/Ysxs3ZzGz/myGmp3wKK1jf40clRFR+vHBO2p3aPY=;
	b=YTw3kA+HEpt7MkftscBTp3TCTSe+PpNt5LbOtc6q9eNpvJam/uAPBVvEQogtWivff/BTeG
	uqnzi+pNEnU6q9Dw==
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
Subject: [patch V5 01/26] signal: Confine POSIX_TIMERS properly
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:00 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Move the itimer rearming out of the signal code and consolidate all posix
timer related functions in the signal code under one ifdef.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h |   5 +-
 kernel/signal.c              | 125 +++++++++++++++-----------------------------
 kernel/time/itimer.c         |  22 +++++++-
 kernel/time/posix-timers.c   |  15 ++++-
 4 files changed, 81 insertions(+), 86 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 453691710839..670bf03a56ef 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -100,6 +100,8 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+void posixtimer_rearm_itimer(struct task_struct *p);
+void posixtimer_rearm(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -122,6 +124,8 @@ struct cpu_timer { };
 static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
+static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
+static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -196,5 +200,4 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
-void posixtimer_rearm(struct kernel_siginfo *info);
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index 6f3a5aa39b09..a83ea99f9389 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -478,42 +478,6 @@ void flush_signals(struct task_struct *t)
 }
 EXPORT_SYMBOL(flush_signals);
 
-#ifdef CONFIG_POSIX_TIMERS
-static void __flush_itimer_signals(struct sigpending *pending)
-{
-	sigset_t signal, retain;
-	struct sigqueue *q, *n;
-
-	signal = pending->signal;
-	sigemptyset(&retain);
-
-	list_for_each_entry_safe(q, n, &pending->list, list) {
-		int sig = q->info.si_signo;
-
-		if (likely(q->info.si_code != SI_TIMER)) {
-			sigaddset(&retain, sig);
-		} else {
-			sigdelset(&signal, sig);
-			list_del_init(&q->list);
-			__sigqueue_free(q);
-		}
-	}
-
-	sigorsets(&pending->signal, &signal, &retain);
-}
-
-void flush_itimer_signals(void)
-{
-	struct task_struct *tsk = current;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	__flush_itimer_signals(&tsk->pending);
-	__flush_itimer_signals(&tsk->signal->shared_pending);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
-}
-#endif
-
 void ignore_signals(struct task_struct *t)
 {
 	int i;
@@ -636,31 +600,9 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info, &resched_timer);
-#ifdef CONFIG_POSIX_TIMERS
-		/*
-		 * itimer signal ?
-		 *
-		 * itimers are process shared and we restart periodic
-		 * itimers in the signal delivery path to prevent DoS
-		 * attacks in the high resolution timer case. This is
-		 * compliant with the old way of self-restarting
-		 * itimers, as the SIGALRM is a legacy signal and only
-		 * queued once. Changing the restart behaviour to
-		 * restart the timer in the signal dequeue path is
-		 * reducing the timer noise on heavy loaded !highres
-		 * systems too.
-		 */
-		if (unlikely(signr == SIGALRM)) {
-			struct hrtimer *tmr = &tsk->signal->real_timer;
-
-			if (!hrtimer_is_queued(tmr) &&
-			    tsk->signal->it_real_incr != 0) {
-				hrtimer_forward(tmr, tmr->base->get_time(),
-						tsk->signal->it_real_incr);
-				hrtimer_restart(tmr);
-			}
-		}
-#endif
+
+		if (unlikely(signr == SIGALRM))
+			posixtimer_rearm_itimer(tsk);
 	}
 
 	recalc_sigpending();
@@ -682,22 +624,12 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 		 */
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
-#ifdef CONFIG_POSIX_TIMERS
-	if (resched_timer) {
-		/*
-		 * Release the siglock to ensure proper locking order
-		 * of timer locks outside of siglocks.  Note, we leave
-		 * irqs disabled here, since the posix-timers code is
-		 * about to disable them again anyway.
-		 */
-		spin_unlock(&tsk->sighand->siglock);
-		posixtimer_rearm(info);
-		spin_lock(&tsk->sighand->siglock);
 
-		/* Don't expose the si_sys_private value to userspace */
-		info->si_sys_private = 0;
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		if (unlikely(resched_timer))
+			posixtimer_rearm(info);
 	}
-#endif
+
 	return signr;
 }
 EXPORT_SYMBOL_GPL(dequeue_signal);
@@ -1922,15 +1854,43 @@ int kill_pid(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pid);
 
+#ifdef CONFIG_POSIX_TIMERS
 /*
- * These functions support sending signals using preallocated sigqueue
- * structures.  This is needed "because realtime applications cannot
- * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of POSIX Timers
- * we allocate the sigqueue structure from the timer_create.  If this
- * allocation fails we are able to report the failure to the application
- * with an EAGAIN error.
+ * These functions handle POSIX timer signals. POSIX timers use
+ * preallocated sigqueue structs for sending signals.
  */
+static void __flush_itimer_signals(struct sigpending *pending)
+{
+	sigset_t signal, retain;
+	struct sigqueue *q, *n;
+
+	signal = pending->signal;
+	sigemptyset(&retain);
+
+	list_for_each_entry_safe(q, n, &pending->list, list) {
+		int sig = q->info.si_signo;
+
+		if (likely(q->info.si_code != SI_TIMER)) {
+			sigaddset(&retain, sig);
+		} else {
+			sigdelset(&signal, sig);
+			list_del_init(&q->list);
+			__sigqueue_free(q);
+		}
+	}
+
+	sigorsets(&pending->signal, &signal, &retain);
+}
+
+void flush_itimer_signals(void)
+{
+	struct task_struct *tsk = current;
+
+	guard(spinlock_irqsave)(&tsk->sighand->siglock);
+	__flush_itimer_signals(&tsk->pending);
+	__flush_itimer_signals(&tsk->signal->shared_pending);
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
@@ -2027,6 +1987,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	rcu_read_unlock();
 	return ret;
 }
+#endif /* CONFIG_POSIX_TIMERS */
 
 void do_notify_pidfd(struct task_struct *task)
 {
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 00629e658ca1..876d389b2e21 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -151,7 +151,27 @@ COMPAT_SYSCALL_DEFINE2(getitimer, int, which,
 #endif
 
 /*
- * The timer is automagically restarted, when interval != 0
+ * Invoked from dequeue_signal() when SIG_ALRM is delivered.
+ *
+ * Restart the ITIMER_REAL timer if it is armed as periodic timer.  Doing
+ * this in the signal delivery path instead of self rearming prevents a DoS
+ * with small increments in the high reolution timer case and reduces timer
+ * noise in general.
+ */
+void posixtimer_rearm_itimer(struct task_struct *tsk)
+{
+	struct hrtimer *tmr = &tsk->signal->real_timer;
+
+	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr != 0) {
+		hrtimer_forward(tmr, tmr->base->get_time(),
+				tsk->signal->it_real_incr);
+		hrtimer_restart(tmr);
+	}
+}
+
+/*
+ * Interval timers are restarted in the signal delivery path.  See
+ * posixtimer_rearm_itimer().
  */
 enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1cc830ef93a7..bcd5e56412e7 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,7 +251,7 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 
 /*
  * This function is called from the signal delivery code if
- * info->si_sys_private is not zero, which indicates that the timer has to
+ * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
 void posixtimer_rearm(struct kernel_siginfo *info)
@@ -259,9 +259,15 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	struct k_itimer *timr;
 	unsigned long flags;
 
+	/*
+	 * Release siglock to ensure proper locking order versus
+	 * timr::it_lock. Keep interrupts disabled.
+	 */
+	spin_unlock(&current->sighand->siglock);
+
 	timr = lock_timer(info->si_tid, &flags);
 	if (!timr)
-		return;
+		goto out;
 
 	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
@@ -275,6 +281,11 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	}
 
 	unlock_timer(timr, flags);
+out:
+	spin_lock(&current->sighand->siglock);
+
+	/* Don't expose the si_sys_private value to userspace */
+	info->si_sys_private = 0;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)



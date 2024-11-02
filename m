Return-Path: <linux-kernel+bounces-393572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA39BA277
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E5D1F226BC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAA1591EA;
	Sat,  2 Nov 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TbwydwBd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jmINAL4J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32A191
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730581513; cv=none; b=HX4vR5dvrs3phLTA6H4/+CE2BSPyKEnDirrP8YBr9N9gecRCkubp7GyG+tkmXzqmzuwHSht9M533Tvo110ArwkbfVVCI1t8uhMTKDRhY6aHlhAD3yGCGlme4P5wflpJDeiubqu0vLtUQMIcgu6+oPXk4Iry95sAtwTCD5jCwFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730581513; c=relaxed/simple;
	bh=uiM/9Pam/unNavdTN0S5iIpsowGVXHGTW/CZFd0BWIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bW6RhhM6jiuPpQW8Gwd1F5gE/Z13odaZJ7gqYhEtso8f4flJWftT8MhnZIrIfFW75Z89krdgbzC3TOfGZh/rFDVDAII925T4QRLeb3T/KTyTMmgEeYl1xdWQw9SzG4H7yxcIwVMVguBKF1xgJ4gPsmp7emXl4WGgFZVh/0evNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TbwydwBd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jmINAL4J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730581509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fx71LjJ8Vur0Z9gY62guw/B9yetMjJPpIdnrpX84Ls=;
	b=TbwydwBdrr7slZwWKtDl1WpuacyMBgk/5XvrQo6i4gc3n9WA/mN+JkwV3geRa7EcMHFPNK
	6HyTRYqB2m9RnhSByq/KM+WQ3ZH+KhBX723StVHgWG5Ud2SfjGYwvNEa7PTwj7HL1wORwo
	hnsDE0G03NY10QDBKgK8P4NnPLQKjRxRRLGL7gflm3G2d86j3Sc990wPZx1LMApgUscXtB
	cozVeDv1AUfDJ+rGuNo22vE9/OGadjETT81Vmnusro9ZByHE62qXkzJz+2NLUhsg/FnXGS
	gkaQ5vGDNkikkKwsD05xTXMciYVH+a4tdVs+7xyKuKJ8O7TkMEMvDo5Zgy6E5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730581509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fx71LjJ8Vur0Z9gY62guw/B9yetMjJPpIdnrpX84Ls=;
	b=jmINAL4Jhv8TdnLl9KQk4l/tQmzldP8I+cbJGCYVqPaCJ3XsLzJeIveXC/MlcRhhqWm4I4
	ucBpRO8iZWSiPnAg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg Nesterov
 <oleg@redhat.com>
Subject: [patch v6.1 17/20] signal: Queue ignored posixtimers on ignore list
In-Reply-To: <20241031154425.624061922@linutronix.de>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
Date: Sat, 02 Nov 2024 22:05:08 +0100
Message-ID: <8734k9qrcr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Queue posixtimers which have their signal ignored on the ignored list:

   1) When the timer fires and the signal has SIG_IGN set

   2) When SIG_IGN is installed via sigaction() and a timer signal
      is already queued

This completes the SIG_IGN handling and such timers are not longer self
rearmed which avoids pointless wakeups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V6.1: Handle oneshot timer expiry or transitioning from periodic to
      oneshot after a rearming correctly. - Frederic
---
 kernel/signal.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)
---

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -731,6 +731,16 @@ void signal_wake_up_state(struct task_st
 		kick_process(t);
 }
 
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
+
+static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *q)
+{
+	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code != SI_TIMER))
+		__sigqueue_free(q);
+	else
+		posixtimer_sig_ignore(tsk, q);
+}
+
 /* Remove signals in mask from the pending set and queue. */
 static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
 {
@@ -747,7 +757,7 @@ static void flush_sigqueue_mask(struct t
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(p, q);
 		}
 	}
 }
@@ -1964,7 +1974,7 @@ int posixtimer_send_sigqueue(struct k_it
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
 	guard(rcu)();
 
@@ -1981,13 +1991,48 @@ int posixtimer_send_sigqueue(struct k_it
 	 */
 	tmr->it_sigqueue_seq = tmr->it_signal_seq;
 
-	ret = 1; /* the signal is ignored */
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
+
+		/* Paranoia check. Try to survive. */
+		if (WARN_ON_ONCE(!list_empty(&q->list)))
+			goto out;
+
+		/* Periodic timers with SIG_IGN are queued on the ignored list */
+		if (tmr->it_status == POSIX_TIMER_REQUEUE_PENDING) {
+			/*
+			 * Already queued means the timer was rearmed after
+			 * the previous expiry got it on the ignore list.
+			 * Nothing to do for that case.
+			 */
+			if (hlist_unhashed(&tmr->ignored_list)) {
+				/*
+				 * Take a signal reference and queue it on
+				 * the ignored list.
+				 */
+				posixtimer_sigqueue_getref(q);
+				posixtimer_sig_ignore(t, tmr);
+			}
+		} else if (!hlist_unhashed(&tmr->ignored_list)) {
+			/*
+			 * Covers the case where a timer was periodic and
+			 * then signal was ignored. Then it was rearmed as
+			 * oneshot timer. The previous signal is invalid
+			 * now, and the oneshot signal has to be dropped.
+			 * Remove it from the ignored list and drop the
+			 * reference count as the signal is not longer
+			 * queued.
+			 */
+			hlist_del_init(&tmr->ignored_list);
+			posixtimer_putref(tmr);
+		}
 		goto out;
 	}
 
-	ret = 0;
+	/* This should never happen and leaks a reference count */
+	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
+		hlist_del_init(&tmr->ignored_list);
+
 	if (unlikely(!list_empty(&q->list))) {
 		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
@@ -2000,7 +2045,21 @@ int posixtimer_send_sigqueue(struct k_it
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
-	return ret;
+	return 0;
+}
+
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	/*
+	 * Only enqueue periodic timer signals to the ignored list. For
+	 * oneshot timers, drop the reference count.
+	 */
+	if (tmr->it_status == POSIX_TIMER_REQUEUE_PENDING)
+		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
+	else
+		posixtimer_putref(tmr);
 }
 
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
@@ -2048,6 +2107,7 @@ static void posixtimer_sig_unignore(stru
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 


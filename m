Return-Path: <linux-kernel+bounces-208612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E7D90272E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F87D28732C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD991591F0;
	Mon, 10 Jun 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHBGxA2z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9sue7UHJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC49158D92
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037787; cv=none; b=g/6eHqr8sxDcJ5tNwuN3Ke9yD5VPhBKftiMFcyX7B4c/sFWI+mHf+7HscF4SytV2psjoGNqtAelFpdc7XDKXHQowGpY0u++4ZWdVSM/tEDP8imxJzz6l/EZN6NfNXOCbAp2SWJTithT5fWz8v5q8u4HSzQdrGi2ZbyuQMBOzZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037787; c=relaxed/simple;
	bh=ojSHAmzDSUCtV20tG0Eic6qt8OMUSGLWdNQCp73/DO0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=E/Vkqk6zXOVHElUuIqiZKg02I0/UZgbsnOuITCifjRablf+/ZxH7VOlwaWFxNP/CfpCjlv7muCnyq7V3KQ0aykEzYb6T0ZaPK8JoYL8DDGALotnbxgdmz7uGEzJhm+sdXZvdYFHn6ffFJMzg1PmdTCs08Vduq/EeMXephfRWPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHBGxA2z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9sue7UHJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164028.472552548@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bzEboz8AUjwt0LmBupDNjtajHSCekoKcw08hOKXcNgs=;
	b=JHBGxA2zo3ckjoiV+jfcQFRkEegNH5I7sEkHaNRQSFyeYMnVXEo/+80EV3Jn4SLb+mLdyv
	uV6cuxCfGeg3EJS3gt/22aqX5qpuzwCtpWqqPSp5mKqEfVTRDIqv3gIc+lp++4g6zVEAOU
	Rqj3k9gBP5idUKSCv6j1vy4EcZ+yP99Ph9Wt9J9nMC6ojAu4V+RIioMFHwVH8LYZc5N7jm
	jXAIXgKbn1jfQ7nrdb2sq2KkpM+QLtY3M0+EtYCmcWmwjyJbDUsgoBqh27/A6PLj6PQPPd
	osFyDV2mbp9YK0IuDwwnauy3Zp9g6gI9J2BhB2++izRXT9tU4P21FXTvQoN/cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bzEboz8AUjwt0LmBupDNjtajHSCekoKcw08hOKXcNgs=;
	b=9sue7UHJ0fM9lfxdYR+ucFA4iFErDrsi1NyiT0OsKC01vB+6fbz6IUP3AhMzjFaG7sRFFN
	mO+lkdzMXcw2glDA==
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
Subject: [patch V3 48/51] signal: Queue ignored posixtimers on ignore list
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:43:04 +0200 (CEST)

Queue posixtimers which have their signal ignored on the ignored list:

   1) When the timer fires and the signal has SIG_IGN set

   2) When SIG_IGN is installed via sigaction() and a timer signal
      is queued

This completes the SIG_IGN handling and such timers are not longer self
rearmed which avoids pointless wakeups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -722,6 +722,16 @@ void signal_wake_up_state(struct task_st
 		kick_process(t);
 }
 
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
+
+static void sigqueue_free_ignored(struct task_struct *ptmr_tsk, struct sigqueue *q)
+{
+	if (likely(!ptmr_tsk || q->info.si_code != SI_TIMER))
+		__sigqueue_free(q);
+	else
+		posixtimer_sig_ignore(ptmr_tsk, q);
+}
+
 /*
  * Remove signals in mask from the pending set and queue.
  *
@@ -740,7 +750,7 @@ static void flush_sigqueue_mask(sigset_t
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(ptmr_tsk, q);
 		}
 	}
 }
@@ -1964,9 +1974,8 @@ int posixtimer_send_sigqueue(struct k_it
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
-	ret = -1;
 	rcu_read_lock();
 
 	t = posixtimer_get_target(tmr);
@@ -2012,13 +2021,24 @@ int posixtimer_send_sigqueue(struct k_it
 	 */
 	q->info.si_overrun = 0;
 
-	ret = 1; /* the signal is ignored */
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
+
+		/* Paranoia check. Try to survive. */
+		if (WARN_ON_ONCE(!list_empty(&q->list)))
+			goto out;
+
+		if (hlist_unhashed(&tmr->ignored_list)) {
+			hlist_add_head(&tmr->ignored_list, &t->signal->ignored_posix_timers);
+			posixtimer_sigqueue_getref(q);
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
@@ -2033,7 +2053,14 @@ int posixtimer_send_sigqueue(struct k_it
 	unlock_task_sighand(t, &flags);
 ret:
 	rcu_read_unlock();
-	return ret;
+	return 0;
+}
+
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
 }
 
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
@@ -2082,6 +2109,7 @@ static void posixtimer_sig_unignore(stru
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
@@ -4272,9 +4300,9 @@ int do_sigaction(int sig, struct k_sigac
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
+			flush_sigqueue_mask(&mask, &p->signal->shared_pending, p);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending, NULL);
+				flush_sigqueue_mask(&mask, &t->pending, p);
 		} else if (was_ignored) {
 			posixtimer_sig_unignore(p, sig);
 		}



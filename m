Return-Path: <linux-kernel+bounces-341499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078B9880D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F341C223B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC781B3B29;
	Fri, 27 Sep 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c53wwif7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+rI6XlQ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C11B375B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426952; cv=none; b=aldg6uUIHFdG/+r8pvqn+58155ts+EYQFFOpPBD9YKvgtl+Od8OBMMDOS5LO/UYtulrSp5Rz3mAEBMT4lPV7Q5V0J6qwAxzsFvTASYG9Z7N6b1oBJDqVWIFVIbIeXn8isYmIp2B+YQBXhAfTDlzItUEimOHx7U57Tore44LNP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426952; c=relaxed/simple;
	bh=9aWJhRR/RK2CQO7SC4nFWIvUcnJd1Mkv4T+t691rosA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OtG094oql0cEYEzO4fsTDulQE88bLsrbJzM5sJKXHbdiF1DGiV1sEokf1zMLPNqZ51SVLBWYgx98ZTtl6U2M5L+UD7uOmIq9h64LfrnNNlaAJf1t+84Cm+9Ng8Pl8AHYrzu+3SLeaUGYOmVWSjFgfwgKjA7rP19ClH0MGJvxciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c53wwif7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+rI6XlQ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.369295053@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TF+iChkDpC8djbwSiyvAn6vmK0/roDaeslI0MvC9sk4=;
	b=c53wwif7oNcWytZgGt2ytmXB9CaVDjLFsf8ct82ZlLKv2DJgvaTMzWDVbyq0PtwSyWSoBg
	JQZPJXkuuViLZXMP7ntec0gFml9uzdHlWUt/3XiQgOkv6pOPxbY1+9lq4TCPdJvoNnE8Ia
	/oFj2hsVAQeWdKUcbrNbjGKx/8wTmfm6bv0acmCeUritkQ6a/U+UPc0moenEkqpKV1lk7I
	nDVtpd3NmtaeDuTtynGGPQ/6ouBxFc+ATkAaMCo/8fXa6fRD7o61BuKbMBN6q0jcCDAkd9
	d6G0maEQRxFqPMC43D52QSsGUqXFmRX9slhRtzOUx3huXOlKkSeegKSIf3NEWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TF+iChkDpC8djbwSiyvAn6vmK0/roDaeslI0MvC9sk4=;
	b=+rI6XlQ2NBAQTPR0CcxmXINMunfUQNP8MB6g7a6X9+FcIG974LJRl/SnNyC3Y/SF7vfYIg
	EcXQ51zjI45d4pBA==
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
Subject: [patch v4 24/27] signal: Queue ignored posixtimers on ignore list
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:08 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Queue posixtimers which have their signal ignored on the ignored list:

   1) When the timer fires and the signal has SIG_IGN set

   2) When SIG_IGN is installed via sigaction() and a timer signal
      is already queued

This completes the SIG_IGN handling and such timers are not longer self
rearmed which avoids pointless wakeups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 kernel/signal.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)
---
diff --git a/kernel/signal.c b/kernel/signal.c
index 855f19f74287..cb29f817b71a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -722,6 +722,16 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
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
@@ -740,7 +750,7 @@ static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s, struct tas
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(ptmr_tsk, q);
 		}
 	}
 }
@@ -1960,9 +1970,8 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
-	ret = -1;
 	rcu_read_lock();
 
 	t = posixtimer_get_target(tmr);
@@ -2008,13 +2017,24 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
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
@@ -2029,7 +2049,14 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
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
@@ -2078,6 +2105,7 @@ static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
@@ -4286,9 +4314,9 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
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



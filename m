Return-Path: <linux-kernel+bounces-390835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4E9B7EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0836B1F22A79
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8D1CB516;
	Thu, 31 Oct 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JA/C+Sw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1CyKhAbw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476E1C9DFB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389607; cv=none; b=jg5LIkbp7TjsCRFOUugATEDEnNiNDybbqiPGOF/npxlpuhY6LXpiB4tjr0aeUupmNvn2IUQTyMz/vzSZbu/d/zTwyqMqpTTvJAjgTUfxNtrNMhWTW4IwTN6TZGOeaIVh8zZxwsHSFLxHCtIXmVgfk7/+ZA329N5IGBJ7+jVsWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389607; c=relaxed/simple;
	bh=FsZHFUc97NANFXySRtBoYWeaYGRrCOHuIEW3PWSHUNQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AxxBMbzxmS0+ajcT/+nEO37GMHnxV7wthWAZTEnc5fffVXP4qzOm8RXfb9E3yUSDWpdrod2h9idiFYBSRYs1iir92r+lM29/ZOGLQpU3HfkOha4Y6Cj6Jaeez0U8KqlMV4tKYif0AcmUItYfWWrOcMyuS8du6kpNuJi8MJNScsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JA/C+Sw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1CyKhAbw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.624061922@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=p/tTn/QrnM+A/Oc6EjwYLiCaX5sZMF5Ke/nd1sitETM=;
	b=JA/C+Sw8MaxCNScjJB5ATywyvBvuOCOCFVZjDd+v6mSewzM4iyFrwWBTEUSwfTT0qgPhcs
	3NEU7k2kEQYjBN3f8Hd1LxLN1hw9Lelu0volhsT+NKXYNkIlt9MIJMoe4svdTD9kV7IibS
	2AuRfFfjWkGPeoQAq2IvZNaS7vcYG6GFTanhT+Zs0ekAezXLK4vIpQ6+aAGKN/YiSdhigO
	GqDhqE6OfY3BH2AUdH/Hf6CQy4+9agAffM4OQW4N249qtfASxo1MLRBkvI6mhK4pqW9BEU
	hd+C3YV2rT2WAJuqgJcsFCSNv4YLs70TYdKn51Jr2QHUE8mpJIHMaVKiMXD25w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=p/tTn/QrnM+A/Oc6EjwYLiCaX5sZMF5Ke/nd1sitETM=;
	b=1CyKhAbwDLkSuQP1Xz86SzPwcziAmPcI/nq1DyveTBKKlnyLHkdBWWLX+UTBoCQasACjzO
	9Kh/mp34urw6IJCg==
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
Subject: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:43 +0100 (CET)

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
 kernel/signal.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)
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
 
@@ -1981,13 +1991,24 @@ int posixtimer_send_sigqueue(struct k_it
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
@@ -2000,7 +2021,14 @@ int posixtimer_send_sigqueue(struct k_it
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
+	hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
 }
 
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
@@ -2048,6 +2076,7 @@ static void posixtimer_sig_unignore(stru
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 



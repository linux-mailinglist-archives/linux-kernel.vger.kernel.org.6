Return-Path: <linux-kernel+bounces-345552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DC98B765
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA19B2739F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018F19D884;
	Tue,  1 Oct 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMfuzTSZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xnJ451YM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7BB1BF333
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772155; cv=none; b=O9aydtSkn6umT0wM4RC/jq7Eai9v3awj769p8rEN/gRJncU8IdmUsJLjAGd/Yh9NMtKcEj9M9xm0LiYhTF8Z0ljmbXCdLJ4eEGismLy9T4u1QTqOv9mhJRSAFoXLIGD0QRQgCfpEYiCOhkQ5P5SZ0nrKQH7+7Dh9+RSPSpEzRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772155; c=relaxed/simple;
	bh=wdZ59129PILYRWjjVFMBE8pu7bJMfTyI28JUVeoeRaA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PUD3+uZxo8YxCd3+ikAfBUVuSDx/eDBo7KLIzZlzH3OxZ6gjhLt6IFREWvekBlOEwn1PNH+heQN/d7omYia5d8bn5edFmBEa1DCLY+A9v5b9VPbJmbCFTFGM/wTCxx3e8/d+bHN8VBb5sjRzliSeKCMYD+Z57wjkH4LBXZ+563c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMfuzTSZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xnJ451YM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.631221131@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6WJ5wulr4rlassEh+UEKQljccgKAlhW7SpWTOZzEt2M=;
	b=ZMfuzTSZIyWOd8X1f1gbHp/StNmdyQ9p201nWQRxdXbx4TwnTsBlrUv5nJJxIh0+55F4Ak
	tAWbPy7pXaNpj3IKs8Q3cc1eaT50GbBsDPjSecZ30oQVsBn3FhmLn8zby8VakEtqNlQPza
	RLlskq8e1bopq9pBUfryXwS/wrR1fL7xJH9y+7Np7sMtHQIbcIS4ttqrYNepbrwpMvGl3S
	PRCt63Xh3J4iVc4XpHfKJd5dAToskJKSv1ecLppRILSGmaY3EO1X2+afK1v3HlIhnzkPke
	elNAjw6OBbLCzQpyAXFPzEMkE+T4bx6Xbb5RHcH22ozqj5bMAlBNSpnYp4bX6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6WJ5wulr4rlassEh+UEKQljccgKAlhW7SpWTOZzEt2M=;
	b=xnJ451YMtSI14+QiMo/ze6LLJnkoWT4bOaPjSZD2ZNZaoocrDF4PIipjw+vCmzZn2USEJg
	yMdqQlny7aMlpsDQ==
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
Subject: [patch V5 23/26] signal: Queue ignored posixtimers on ignore list
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:32 +0200 (CEST)

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
@@ -723,6 +723,16 @@ void signal_wake_up_state(struct task_st
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
@@ -739,7 +749,7 @@ static void flush_sigqueue_mask(struct t
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(p, q);
 		}
 	}
 }
@@ -1956,7 +1966,7 @@ int posixtimer_send_sigqueue(struct k_it
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
 	guard(rcu)();
 
@@ -2001,13 +2011,24 @@ int posixtimer_send_sigqueue(struct k_it
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
@@ -2020,7 +2041,14 @@ int posixtimer_send_sigqueue(struct k_it
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
@@ -2068,6 +2096,7 @@ static void posixtimer_sig_unignore(stru
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 



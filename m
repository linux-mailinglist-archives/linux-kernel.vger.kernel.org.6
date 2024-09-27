Return-Path: <linux-kernel+bounces-341481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700429880B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8014C1F214ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7971B010A;
	Fri, 27 Sep 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cnMcQj9b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sohlXReU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5618A6DD
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426932; cv=none; b=kSd7m9epjnC5lTOn3wLVXvVTkWLzS6fE35j6+IU3mtmPI9+Ellf7A6yK5teaq673m2CfeOXTOz00+iBty8LRVtlDetwCSEH0NjRZewiaR5brTO4uDcEKragd9ASycLWgsucSHg9ROY5HYbjHbPJzhdb+L73kjHyrXWaPXU7LiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426932; c=relaxed/simple;
	bh=zIuK2lE66Z+HPke8d7lxHWmFzYXh1WtDOUi7OBB0t5M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DcmxT1dAlLoQKK56Px4mp8qXv4Vq6o/rIwNXbwvGKC8B1SC0eA5GjfoDXFaOo6bettIJ7ySgs3RJSdwIqUtt90fkXY6PHVqKX/7SRJ1C5G4YyHn2vUkSZY8QOsaKbm9lwGAv1khvhQ/QhbP2qjJNLPVukjBx7CU9fDP9HJULD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cnMcQj9b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sohlXReU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.077215973@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=iFAEBuAlpYC8f3qlbhRRUEyjDeW+2nw5ukmxpOId5Ps=;
	b=cnMcQj9bsJFJwQXsbJ8e0OOF+oNES2h8zXkMGOb30KGnQ8FU9FSz3w9hwB4kAMI6CwKix1
	2VnzP/NjQjR6yUv4rb3h6VhdnWuO2c/MspRugcuWtNGmwF6uoLWiQje+Ov/axnzw2XN/ly
	PMXW1c8ySyNq6BhFP4R4+bB6XNUwsABuvEZa9KUfEjOioqIEmG4tMpymt7qS9qNk1WxklB
	+GVCtntXjujgZhD3vBLPLX1ITbX+IYTHNtA2PpU0nATA5TmieDj8LPuaR0u2LkZByuzauh
	f9MWAfMgiZ6f9NCrur+158K86iYNTeFc1HVaTS/zJPSbN8lud4iu/j2wHWzVDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=iFAEBuAlpYC8f3qlbhRRUEyjDeW+2nw5ukmxpOId5Ps=;
	b=sohlXReUJtQRrFj/uGz3qIDaurVitSPZM2GR0yFEjXEJ5e4e4nCUES8LTBAuMIUxKZBXAl
	cVHw6q/wETDn/TCw==
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
Subject: [patch v4 03/27] signal: Get rid of resched_timer logic
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:42 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason for handing the *resched pointer argument through
several functions just to check whether the signal is related to a self
rearming posix timer.

SI_TIMER is only used by the posix timer code and cannot be queued from
user space. The only extra check in collect_signal() to verify whether the
queued signal is preallocated is not really useful. Some other places
already check purely the SI_TIMER type.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 kernel/signal.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)
---
diff --git a/kernel/signal.c b/kernel/signal.c
index 7706cd304785..3d2e087283ab 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -526,8 +526,7 @@ bool unhandled_signal(struct task_struct *tsk, int sig)
 	return !tsk->ptrace;
 }
 
-static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
-			   bool *resched_timer)
+static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info)
 {
 	struct sigqueue *q, *first = NULL;
 
@@ -549,12 +548,6 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
-
-		*resched_timer =
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code == SI_TIMER) &&
-			(info->si_sys_private);
-
 		__sigqueue_free(first);
 	} else {
 		/*
@@ -571,13 +564,12 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 	}
 }
 
-static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			kernel_siginfo_t *info, bool *resched_timer)
+static int __dequeue_signal(struct sigpending *pending, sigset_t *mask, kernel_siginfo_t *info)
 {
 	int sig = next_signal(pending, mask);
 
 	if (sig)
-		collect_signal(sig, pending, info, resched_timer);
+		collect_signal(sig, pending, info);
 	return sig;
 }
 
@@ -589,17 +581,15 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
 	struct task_struct *tsk = current;
-	bool resched_timer = false;
 	int signr;
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
 	*type = PIDTYPE_PID;
-	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
 		*type = PIDTYPE_TGID;
-		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
+		signr = __dequeue_signal(&tsk->signal->shared_pending, mask, info);
 
 		if (unlikely(signr == SIGALRM))
 			posixtimer_rearm_itimer(tsk);
@@ -626,7 +616,7 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(resched_timer))
+		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
 			posixtimer_rearm(info);
 	}
 
@@ -1011,6 +1001,9 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 
 	lockdep_assert_held(&t->sighand->siglock);
 
+	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
+		return 0;
+
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, force))
 		goto ret;



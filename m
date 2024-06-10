Return-Path: <linux-kernel+bounces-208593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B292902703
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A510C285155
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187115687D;
	Mon, 10 Jun 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOwMPaZo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S92bN/nM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DD156642
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037764; cv=none; b=atq/AztG9XWGWrRdc4n7cEebxevlxb2KIo8E9JDrhuNmNMSHk2trSf6Hl5t2ILrqTUA8NPACJT/Dy3KANaRMxwbI0MFC/Dxqj8fuH7m1nWozNnplRJznh0Yw4CAM9Bhk3jO1xpkquAXF2M/3715WtXUi2PP0IeG0CeBAXc3Yvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037764; c=relaxed/simple;
	bh=KhNVeFgd6lRRQ/L8jZVrXHF5SioQPrOiKVccu67AM2o=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ELfOqpgESq5nqY7+zHSM8FbleKp+r/D19NgBxGRVJ0PuuTspa0EsO5ejKbrKEnWftWZDLE8CywgEZC48JCp2AjT9a793Zl9OtbzJ3cR/BIKq21xvEre8HvfZ4MB/WeC7AS7b5+mvswvn37AYWr1yM22hWnjpArJglt9r1BRnLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOwMPaZo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S92bN/nM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.240256030@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/sm/3Zjyw3ZZ6H1Z9wjufOHjksvdXGdFCfNiQCsGsAs=;
	b=TOwMPaZo5gJpvAndfavHXFCa12+gHtuBVfzCRy9zIPtOHiC+lTv0fCSXXrF+v/62xP/9r9
	amqtTjmZR+KGNg3/hPABHcLAjbwFDO6As5s+HibLUS4hUYYfCvoMMuPHCkxc9LYJBNS8/C
	qzTmZXLdgC9mdkHqyPJE2TWPjiBS2Is2csp7a1+ycAZf2LweTwHWqWPAMukIhttk6mYCQY
	SE3JkUZyxrp7xBcOOp28xMyvomx0gZT0BdG0nG1SOf+hhFPZuXjWihhDnGf/3XhAQ++SiD
	BegjwgDzWbX2LQ3RACsKrJlb8L3tZFCmGo01YMtv/+qTS25pfHrR+2aWKT/C3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/sm/3Zjyw3ZZ6H1Z9wjufOHjksvdXGdFCfNiQCsGsAs=;
	b=S92bN/nMNA7k/zwi9wfRRqWkzYm4oMv7uVY8SJFAEhCj6VxlB6gy3NWTdpKOOedaubzopc
	Rll/VOLo7MX3V6Aw==
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
Subject: [patch V3 28/51] posix-timers: Cure si_sys_private race
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:39 +0200 (CEST)

The si_sys_private member of the siginfo which is embedded in the
preallocated sigqueue is used by the posix timer code to decide whether a
timer must be reprogrammed on signal delivery.

The handling of this is racy as a long standing comment in that code
documents. It is modified with the timer lock held, but without sighand
lock being held. The actual signal delivery code checks for it under
sighand lock without holding the timer lock.

Hand the new value to send_sigqueue() as argument and store it with sighand
lock held.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/signal.h |    2 +-
 kernel/signal.c              |   10 +++++++++-
 kernel/time/posix-timers.c   |   15 +--------------
 3 files changed, 11 insertions(+), 16 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -340,7 +340,7 @@ extern int send_sig(int, struct task_str
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
+extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1919,7 +1919,7 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
+int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
 {
 	int sig = q->info.si_signo;
 	struct sigpending *pending;
@@ -1954,6 +1954,14 @@ int send_sigqueue(struct sigqueue *q, st
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
+	/*
+	 * Update @q::info::si_sys_private for posix timer signals with
+	 * sighand locked to prevent a race against dequeue_signal() which
+	 * decides based on si_sys_private whether to invoke
+	 * posixtimer_rearm() or not.
+	 */
+	q->info.si_sys_private = si_private;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,21 +299,8 @@ int posix_timer_queue_signal(struct k_it
 	if (timr->it_interval)
 		si_private = ++timr->it_requeue_pending;
 
-	/*
-	 * FIXME: if ->sigq is queued we can race with
-	 * dequeue_signal()->posixtimer_rearm().
-	 *
-	 * If dequeue_signal() sees the "right" value of
-	 * si_sys_private it calls posixtimer_rearm().
-	 * We re-queue ->sigq and drop ->it_lock().
-	 * posixtimer_rearm() locks the timer
-	 * and re-schedules it while ->sigq is pending.
-	 * Not really bad, but not that we want.
-	 */
-	timr->sigq->info.si_sys_private = si_private;
-
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }



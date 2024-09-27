Return-Path: <linux-kernel+bounces-341480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E829880BA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817C0B23232
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB451AFB2E;
	Fri, 27 Sep 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vA8AzNfN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hqzHayhN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3518A948
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426932; cv=none; b=PZJaobde2qASVvv5vD+8ak7yMnaFlvhXOoXpblTo/rRMKAKAUIe8Z525HX/XAwHpmiDN88mTaphQPrshbaWrSk7BITqfyTNuYFcCq1aGn7bogvt4keLztnI1Nhrw3DJIMoA12IXW6PreMMT7kV3J1REFKPB72loke7UWXlOhpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426932; c=relaxed/simple;
	bh=TX3TFV/PcpEe2I3CEleRen+sJB2L82vbAcbfKlv8tFg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ea95tZLKWuR2bLSZ8Yq9JEgY5+o1vE5ve9MTavzqE60icLdwTrkOC75adRmyEj57XABly8nQQwrHCxntMNu01bv14pxXVBmv5J8sfHkRWg5fr55mmDt/USddxZSCsiIHjebzn+U1hrUFAdlPQUlqoCC1i/ABRP1GzraxVS4IqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vA8AzNfN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hqzHayhN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.138903581@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nMa/V7VTOC/xYG0c2/c7ZQoshOFect1N4p4ux1Yw8j8=;
	b=vA8AzNfNgYk2u+L8GExYnSy/sFsLR9Nui3/VeV7TxyQYBlRNyGy8tm7lTp9PsJWhDfzuAp
	4aYh7O8pFtJv4O00Chh5Nie4jv0CuupTfw/yJRAGNBQTMIr2QtpkA4ovZtbDmYR2HrpFSQ
	TQnTNtQHEo51Npk94X0AQjdm+dAfPtq/0Kk/6mOO2ZBsbEuilQiEXiYhWhdSmCNokPoiUX
	htEuBZQxZLa4M383hUh9Y+Yp5k6sLQikKZ45upg27viX1hT0IiaZuGefk9qRh41MVmTdZ0
	4VxbBdBtnGMHXeYXcwgyH70jNWIoS0aDob9k9yLueG4HomAdEjq+S8mS3TpcJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nMa/V7VTOC/xYG0c2/c7ZQoshOFect1N4p4ux1Yw8j8=;
	b=hqzHayhNX/8gPsxyhFQFubHdXMuFgw56TbWU+eHivhDRqAXQh+ipUuLAiXmyGLDW8UccYn
	uzpTCMGckq3sirBg==
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
Subject: [patch v4 04/27] posix-timers: Cure si_sys_private race
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:44 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/sched/signal.h |  2 +-
 kernel/signal.c              | 10 +++++++++-
 kernel/time/posix-timers.c   | 15 +--------------
 3 files changed, 11 insertions(+), 16 deletions(-)
---
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index c8ed09ac29ac..bd9f569231d9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -340,7 +340,7 @@ extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
+extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index 3d2e087283ab..443baadb5ab0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1915,7 +1915,7 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
+int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
 {
 	int sig = q->info.si_signo;
 	struct sigpending *pending;
@@ -1950,6 +1950,14 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
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
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bcd5e56412e7..b6cca1ed2f90 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,21 +299,8 @@ int posix_timer_queue_signal(struct k_itimer *timr)
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



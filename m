Return-Path: <linux-kernel+bounces-345531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D777798B74D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078B31C20C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AC19D09F;
	Tue,  1 Oct 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6NLIMbL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzQgrbYT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB419CC10
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772126; cv=none; b=DErwMTp3M4mn7+9dyz3ATAjnmii6c3KTwCP6txl95oLqGa+XSJp4pKA3be22Yrd4GE2lw8Grx5l8laxg6zSO2XwuoxRIN30B7mUq968gcZMJG3rdpg7oln5fSngr+2QOnHV48ZqS/6xXKe1r0vV5nKDQeTDC8RgpxB3fsupkPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772126; c=relaxed/simple;
	bh=XTy2ZNeK7EMPqchjlUR0zI191FYgGBIFUYbh/0+ygwY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FOEJNZxEl4T2rqCswGAOKPpHF4sbWgpA1b7r0OdOEEHM6rzJjyLuyEHbITju/UT12Vgg3rpahx/julxw7nm6E1Dw9equMPlsv1p0nZ5ThLfTO9p5YiXA/1eZuYqZGu48PznKroQAYzlhWIKsu0ecFVfptJzeaSyx4PxytFfnl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6NLIMbL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzQgrbYT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.434338954@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SdD1XuzyyTjiv1VlRVUmflvcPUaAwKIRKorXREyi9yI=;
	b=a6NLIMbLV/HGNFDTHVe0xaQrBxzWf5xY17zba1l5FNhd4n+v3j4mpiPD2xvqmhVSZftmGk
	CVSSG53xSUi6gBM+lBiDScdFau0DnErVRe92Gh05jYQWdMJWsyjMwro10g/pGYUXCBrSzv
	2cMAnBJ35wsEv3yGgFjkD+ongGbQAe+RrZZfzNBhsvGs/WrTB9qj7VdKUjDHwcD0lSq6dH
	+H69hxWDsg3Jb91qM3gPcCirdd6UX+kRCp2dKQmaJqaQ4FHk0+OVkDAbM9EMQm2C/PIuHx
	9s9cCrqtcBBIGmIfU3aFcFi71D0gQ3RsryXIEIidFijmVfG6NiGJzSRFaRgQXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SdD1XuzyyTjiv1VlRVUmflvcPUaAwKIRKorXREyi9yI=;
	b=IzQgrbYTUpNzLIDZbFcRssUkpTsVh6Jc3VMmC3qY0AYPsMy/ky/PljfSscfArQKE+jkx6Y
	5hKU+YmbQUllloDQ==
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
Subject: [patch V5 03/26] posix-timers: Cure si_sys_private race
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:03 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

The si_sys_private member of the siginfo which is embedded in the
preallocated sigqueue is used by the posix timer code to decide whether a
timer must be reprogrammed on signal delivery.

The handling of this is racy as a long standing comment in that code
documents. It is modified with the timer lock held, but without sighand
lock being held. The actual signal delivery code checks for it under
sighand lock without holding the timer lock.

Hand the new value to send_sigqueue() as argument and store it with sighand
lock held. This is an intermediate change to address this issue.

The arguments to this function will be cleanup in subsequent changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V5: Document in the change log that this is intermediate.
---
 include/linux/sched/signal.h |    2 +-
 kernel/signal.c              |   10 +++++++++-
 kernel/time/posix-timers.c   |   15 +--------------
 3 files changed, 11 insertions(+), 16 deletions(-)
---
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



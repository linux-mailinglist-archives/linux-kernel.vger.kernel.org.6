Return-Path: <linux-kernel+bounces-208601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78C902720
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703371C2218C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503B1581F4;
	Mon, 10 Jun 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M+YnR1AP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fyaRYZMm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB0156C68
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037774; cv=none; b=opldI4fqdpCRGrC0aX0dYhkB0pAfOFE1bmHVGbC7WGN7TO1T110mLyxXc5HmyFfIkQAxrmiVehtY/OhBPrM4xMoE7cyK/hFv1Wp7SOa7MTq2fRukPw7ASZaN7GBJMpt9lcubbOu7QKsUNpS2BznQMN2ki6TBwM3Sx6Z1fjahWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037774; c=relaxed/simple;
	bh=SeQ2OVxjlLINqynDEK9vT3MFjf860yuU+9xoy6p/o24=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=D2bu8xX+PXIbYjaUrXQ7Hd/wAj1K3iD56RAqixCyDgvJEgmmwyQ6osKdRm7ynQopEQcLiOj5hs/urOqHomI7r74QI+rkCeQIlE9YXzAWJHeQHVH6yb5D+rvIpQQPy/RkYq25JmkxJychIlPWWIjUjKVdK5G/8fobcALiRGvnw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M+YnR1AP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fyaRYZMm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.729743690@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hZthBClJqDYnocBuqiMS4yLZv+QB2bQbndBZ4lDgqqQ=;
	b=M+YnR1APSqUzzBQlmb2mgoBY3RQs5sF9wpg8fJ5I1jnes5kArHvjBIhUlp5ltDGf+mSLed
	KjxuS7dNWyEFENAzg2rrLUaJWfTyrriU6V6BNQ3PpHVgX5vI+ORD3fjpiJpjetXFuQKxwn
	ctULEnawGL86Ce27FuFx1BRn7BdbxKM/YGUB6H31MjUbEli1jgGwlrk5E/YHO2IA6AQG8/
	U1kzYmGwxhaQu5YimOp1MzWotzvKlrfYSWVtp2mBvaNuqpDLHrKzjW0KvidLRiW6nCD8UG
	IYostn++mTpjtEm+J6lF0ZdfK7/bnoHoTDw8/4OCApYjIBDxFhVcbv2WR7/c8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hZthBClJqDYnocBuqiMS4yLZv+QB2bQbndBZ4lDgqqQ=;
	b=fyaRYZMmxHpt5QNepDFFFvh4F4/79CcyeFWrXpiWvjIhSxIMDsI8neIBoplLONZhAN8gt7
	O6XOAWdoVvh72nBg==
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
Subject: [patch V3 36/51] posix-timers: Add a refcount to struct k_itimer
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:49 +0200 (CEST)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

To make this work correctly this needs reference counting so that timer
deletion does not free the timer prematuraly when there is a signal queued
or delivered concurrently.

Add a rcuref to the posix timer part.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |   14 ++++++++++++++
 kernel/time/posix-timers.c   |    7 ++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,11 +6,13 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/posix-timers_types.h>
+#include <linux/rcuref.h>
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
+struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
 		const clockid_t clock)
@@ -105,6 +107,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
+void posixtimer_free_timer(struct k_itimer *timer);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -129,6 +132,7 @@ static inline void posix_cputimers_group
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
+static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -156,6 +160,7 @@ static inline void posix_cputimers_init_
  * @it_signal:		Pointer to the creators signal struct
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
+ * @rcuref:		Reference count for life time management
  * @sigq:		Pointer to preallocated sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
@@ -180,6 +185,7 @@ struct k_itimer {
 		struct task_struct	*it_process;
 	};
 	struct sigqueue		*sigq;
+	rcuref_t		rcuref;
 	union {
 		struct {
 			struct hrtimer	timer;
@@ -200,4 +206,12 @@ void set_process_cpu_timer(struct task_s
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
+#ifdef CONFIG_POSIX_TIMERS
+static inline void posixtimer_putref(struct k_itimer *tmr)
+{
+	if (rcuref_put(&tmr->rcuref))
+		posixtimer_free_timer(tmr);
+}
+#endif /* !CONFIG_POSIX_TIMERS */
+
 #endif
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -417,6 +417,7 @@ static struct k_itimer * alloc_posix_tim
 		return NULL;
 	}
 	clear_siginfo(&tmr->sigq->info);
+	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
 
@@ -427,7 +428,7 @@ static void k_itimer_rcu_free(struct rcu
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
-static void posix_timer_free(struct k_itimer *tmr)
+void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
@@ -439,7 +440,7 @@ static void posix_timer_unhash_and_free(
 	spin_lock(&hash_lock);
 	hlist_del_rcu(&tmr->t_hash);
 	spin_unlock(&hash_lock);
-	posix_timer_free(tmr);
+	posixtimer_putref(tmr);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -474,7 +475,7 @@ static int do_timer_create(clockid_t whi
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		posix_timer_free(new_timer);
+		posixtimer_free_timer(new_timer);
 		return new_timer_id;
 	}
 



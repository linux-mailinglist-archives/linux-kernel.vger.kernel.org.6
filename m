Return-Path: <linux-kernel+bounces-341487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267589880C7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE04281323
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C801B1D56;
	Fri, 27 Sep 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P1BgWwB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qq56EgBf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2411B1408
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426937; cv=none; b=YhmkEefTw/UiC/MxaJM1CxYX11J8hK0K7r1EzkiEQZr+0zofKVu1fK1cXhVJXCK21m/SJDnuUOSpHGgg6VE1bNsebBFY5/x26mbUpkS2Ab4wvHJ4dlJ3Y56drnCOZ/GFAXpOjv18EaA3esCPsfm3OXl9z+EVuHPnD1+Nlzb4cLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426937; c=relaxed/simple;
	bh=bqKMIW20BvE93+TTGpef15PeydDZXZdPbYIig5eo5rs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=T8HDRc4gokva2gnMie8fUZAtClgROoE145bzSHjoSYvNIMmMLd27TgZHov0uyJ0GPB3AIJkYjohKx/Zsqizy6FLab/WYPGP3KjB4BkCINfNhvM5c48LlKdTrkJqU/hBTmRF3Mj1z7jNCeHIHYbMWPY8eFmHxDDYY2xsL63TzjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P1BgWwB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qq56EgBf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.635782665@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1s4/+wgUFt/xsHtMm50Sqp9rImc2F37Rzip7gGAsmzM=;
	b=P1BgWwB+0j+DyGvl/E8dK0s9s/9HYgFtD1CJd2blCEHoJSVygT8tsWzfLjnFWGnA7K5T/8
	M6ywSUGr8+FYUdKvuXl1ajXT6lnd96hoCagFdP7mVIREdaTIhxExQN0D1PlslUagarqUsH
	pg2GP0h8KzpopAtg8TmQhnUSgiI26g/sH0ZuYslxvOFkkQxVtyJcFaXrC9G+J40D0Lxp9T
	mjb2bOGPsJwcCzW+/leQT/ycid4r8gnoaXrcU96AbSSzCdFuFbiUm87CrdWnQiWB5Tggx7
	X3eIgmKm0FN5hjJzarupWv2RDgtiHFPuSbYen/arxlZAktoIHRA+8/gFs59MjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1s4/+wgUFt/xsHtMm50Sqp9rImc2F37Rzip7gGAsmzM=;
	b=qq56EgBfkfmoN3A9FAu6kKf2nFpRp2Am0DoyaYmfwRmLoDuT3dGwXQHY9PjKPiDYCn0wy6
	b4MTSGwMyueKIDCg==
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
Subject: [patch v4 12/27] posix-timers: Add a refcount to struct k_itimer
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:53 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

To make that work correctly it needs reference counting so that timer
deletion does not free the timer prematuraly when there is a signal queued
or delivered concurrently.

Add a rcuref to the posix timer part.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h | 14 ++++++++++++++
 kernel/time/posix-timers.c   |  7 ++++---
 2 files changed, 18 insertions(+), 3 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index bcd01208d795..9740fd0c2933 100644
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
@@ -105,6 +107,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
+void posixtimer_free_timer(struct k_itimer *timer);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -129,6 +132,7 @@ static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
+static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -156,6 +160,7 @@ static inline void posix_cputimers_init_work(void) { }
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
@@ -200,4 +206,12 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 
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
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1231efb7c30f..1c2f6090b767 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -417,6 +417,7 @@ static struct k_itimer * alloc_posix_timer(void)
 		return NULL;
 	}
 	clear_siginfo(&tmr->sigq->info);
+	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
 
@@ -427,7 +428,7 @@ static void k_itimer_rcu_free(struct rcu_head *head)
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
-static void posix_timer_free(struct k_itimer *tmr)
+void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
@@ -439,7 +440,7 @@ static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 	spin_lock(&hash_lock);
 	hlist_del_rcu(&tmr->t_hash);
 	spin_unlock(&hash_lock);
-	posix_timer_free(tmr);
+	posixtimer_putref(tmr);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -474,7 +475,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		posix_timer_free(new_timer);
+		posixtimer_free_timer(new_timer);
 		return new_timer_id;
 	}
 



Return-Path: <linux-kernel+bounces-552636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBDEA57C24
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F43ACF0C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6925214A67;
	Sat,  8 Mar 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VaVA7+4S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLyAtnQM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919C2144D0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452529; cv=none; b=k1/AGcTYfDhbIqM4rAcv+a2HF5HvDUknGc/CiehHnp20kOt5w58RzEzqjfynipltb2CHCIESBAwfQXgVXzWcc17SYE7qiRVMKCnUTh9XDTW14clLkvQooZUS1qv2OieXR2+c1fiEqd8vjIf/ctYLoAbGOIScGTIdNpcgUkVpHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452529; c=relaxed/simple;
	bh=Ri0ZjOLv4CEHlOoYBusHjqOyUxJwtOmZYU+uz9YxkQU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=T+Bv0psQFuub9Qi4KcAJQVEpcmuzP9VQLJLYsElkSk+crlkp+5nVa7RNvipB3SBBmPmU3Tz4MRMnsUOdpD9nve4t1nM1fKjMcin1Ad+q7XilONa1SSs3162ZiGKHmIpiZ19LR/0QmRju2QGCOXo12VR97LThhP8vllZxwNBCLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VaVA7+4S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLyAtnQM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155624.465175807@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uc4dKyPH/2nSK2noyFwgLXUhSjpPC4g5+353BlQ1hbI=;
	b=VaVA7+4S+8F0h2HOZH09ojQKezw2tyE2Ikv3uRq9/Yi4Td7LdkLww2oeCM6nTvVSS/5I3G
	Pg4YtMRPG3lEogcF5BpAP9HVcvlDAxIVrqSeLaJnjqji3yuwsMEeK0QEpCVwHOoDq1TXzS
	iThAT7Ga3gYPhFS+RUas0pgguhAzQONgw4uLowIt5IFJrfuk8FScbYVqIF1EHfCB7ZCayO
	Y/xZRcU36KDa7CVqCrZnSNZ9uYim/FW/GdQu0aWnhq7oxkO5ViqsAH0eddlxHyauu3dIup
	atMa4O3YrbC71abWqdocCBF1DNxqRHyYZdWnkt0FEJQ4ajKgU+38dYlAu2cwmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uc4dKyPH/2nSK2noyFwgLXUhSjpPC4g5+353BlQ1hbI=;
	b=qLyAtnQMRU3oVgQ5MT9zD07v7TvGLmxd+V6XrmVavf9/cONoJIqpyDp+6ZjKbVycSrC00y
	59D+UETV8staLUAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 16/18] posix-timers: Dont iterate /proc/$PID/timers with
 sighand:: Siglock held
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:45 +0100 (CET)

The readout of /proc/$PID/timers holds sighand::siglock with interrupts
disabled. That is required to protect against concurrent modifications of
the task::signal::posix_timers list because the list is not RCU safe.

With the conversion of the timer storage to a RCU protected hlist, this is
not longer required.

The only requirement is to protect the returned entry against a concurrent
free, which is trivial as the timers are RCU protected.

Removing the trylock of sighand::siglock is benign because the life time of
task_struct::signal is bound to the life time of the task_struct itself.

There are two scenarios where this matters:

  1) The process is life and not about to be checkpointed

  2) The process is stopped via ptrace for checkpointing

#1 is a racy snapshot of the armed timers and nothing can rely on it. It's
   not more than debug information and it has been that way before because
   sighand lock is dropped when the buffer is full and the restart of
   the iteration might find a completely different set of timers.

   The task and therefore task::signal cannot be freed as timers_start()
   acquired a reference count via get_pid_task().

#2 the process is stopped for checkpointing so nothing can delete or create
   timers at this point. Neither can the process exit during the traversal.

   If CRIU fails to observe an exit in progress prior to the dissimination
   of the timers, then there are more severe problems to solve in the CRIU
   mechanics as they can't rely on posix timers being enabled in the first
   place.

Therefore replace the lock acquisition with rcu_read_lock() and switch the
timer storage traversal over to seq_hlist_*_rcu().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 fs/proc/base.c |   48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2497,11 +2497,9 @@ static const struct file_operations proc
 
 #if defined(CONFIG_CHECKPOINT_RESTORE) && defined(CONFIG_POSIX_TIMERS)
 struct timers_private {
-	struct pid *pid;
-	struct task_struct *task;
-	struct sighand_struct *sighand;
-	struct pid_namespace *ns;
-	unsigned long flags;
+	struct pid		*pid;
+	struct task_struct	*task;
+	struct pid_namespace	*ns;
 };
 
 static void *timers_start(struct seq_file *m, loff_t *pos)
@@ -2512,54 +2510,48 @@ static void *timers_start(struct seq_fil
 	if (!tp->task)
 		return ERR_PTR(-ESRCH);
 
-	tp->sighand = lock_task_sighand(tp->task, &tp->flags);
-	if (!tp->sighand)
-		return ERR_PTR(-ESRCH);
-
-	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
+	rcu_read_lock();
+	return seq_hlist_start_rcu(&tp->task->signal->posix_timers, *pos);
 }
 
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp = m->private;
-	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
+
+	return seq_hlist_next_rcu(v, &tp->task->signal->posix_timers, pos);
 }
 
 static void timers_stop(struct seq_file *m, void *v)
 {
 	struct timers_private *tp = m->private;
 
-	if (tp->sighand) {
-		unlock_task_sighand(tp->task, &tp->flags);
-		tp->sighand = NULL;
-	}
-
 	if (tp->task) {
 		put_task_struct(tp->task);
 		tp->task = NULL;
+		rcu_read_unlock();
 	}
 }
 
 static int show_timer(struct seq_file *m, void *v)
 {
-	struct k_itimer *timer;
-	struct timers_private *tp = m->private;
-	int notify;
 	static const char * const nstr[] = {
-		[SIGEV_SIGNAL] = "signal",
-		[SIGEV_NONE] = "none",
-		[SIGEV_THREAD] = "thread",
+		[SIGEV_SIGNAL]	= "signal",
+		[SIGEV_NONE]	= "none",
+		[SIGEV_THREAD]	= "thread",
 	};
 
-	timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
-	notify = timer->it_sigev_notify;
+	struct k_itimer *timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
+	struct timers_private *tp = m->private;
+	int notify = timer->it_sigev_notify;
+
+	guard(spinlock_irq)(&timer->it_lock);
+	if (!posixtimer_valid(timer))
+		return 0;
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
-	seq_printf(m, "signal: %d/%px\n",
-		   timer->sigq.info.si_signo,
+	seq_printf(m, "signal: %d/%px\n", timer->sigq.info.si_signo,
 		   timer->sigq.info.si_value.sival_ptr);
-	seq_printf(m, "notify: %s/%s.%d\n",
-		   nstr[notify & ~SIGEV_THREAD_ID],
+	seq_printf(m, "notify: %s/%s.%d\n", nstr[notify & ~SIGEV_THREAD_ID],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
 		   pid_nr_ns(timer->it_pid, tp->ns));
 	seq_printf(m, "ClockID: %d\n", timer->it_clock);



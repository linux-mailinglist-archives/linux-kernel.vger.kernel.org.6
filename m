Return-Path: <linux-kernel+bounces-212472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECC906170
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B151C2106B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D217756;
	Thu, 13 Jun 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X48SWAHP"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A9DDB2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243929; cv=none; b=sAhwqIDlrBgWHnp31ESLTVvSHCqi+bt13jLPF6B0dlCySJM7PCF+GMFF0apKAzrhxuwzh+CmzaW6j2blGpqJyN7oWLuoMIgj+6/yw4k+ZvieFssuGMSJ9z3zl8istdNFoY38dSmsVlvrgTIHI8rKNAfPTH6Vpa1CdmzPr1nN0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243929; c=relaxed/simple;
	bh=/GlDiqg+KT0hvfrqYVGZ6+VHfiJkr8ffTpTsneUid4o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ppj7e+cm2mpdN7d2DbVLKDlYs8Kvrs+Btti7ScTVWqdjHVlY6dMEQOyrqFCoye33820ZHI23DYSI45Tf7TA5VpliclLEYLWjwhz0KQ/P2yMXx2W2D3ytGOwezy5DxaKXiHe/4ycQJSumjok9g2oUsy0EgHZStkrrQCnxM359U2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X48SWAHP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f71d5a85f9so5175465ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718243927; x=1718848727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XR6AMFWe1KXkR6OV27ESv59bBQmo8YjxA22W97Ip+bk=;
        b=X48SWAHP6d6txsFUjt7hCHfmzFg8ZP+uqklUuNP7mpWAkh3Yz31/xPTEQR3/pJr/rC
         dXCg0YFU5VDzkLyQGNlHKtCVqzMxbNG1yJKVaxNW6aJb7S/lws8kPu5799rNGghlJtrZ
         vRUrttGz2S1H6+pcbW69livHsIROFmk/X0oY1Zi/FR3WH0Ff832/+/hwV/lhMrSGpSn+
         ZzamLRBD8lBk2poCrY0sy6oxKY7KoVsjKcMdANmgsqAtKczS8nIZzqQ4pgtgBJK7I2c7
         RUyWtRYrjyiuKBqTtROt2CadmjabG8Pb+Ou8zE0mxEVShf4rRrZwDeeezOKhAp1RMLSf
         ykDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243927; x=1718848727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XR6AMFWe1KXkR6OV27ESv59bBQmo8YjxA22W97Ip+bk=;
        b=ryCnbUocvIVq33r2wyLPknsTKXYrMP/dcnBrEyzR6mV97WOeZegq5I0sUQC+6cFXrw
         aqLKoH4D88DvJp8de0Q7kQ6t1kO2DEEo4h7NzM5PUZj3Rgvs0mj16OMZSNEqZXZIb9iG
         pod5Ar7MCMLWys5jyBhyJbBs4Vcqp11MU/7QZcWMwgGi6B7tnGz2FyJYVGDEotpC7MEm
         0LF0fnDkQnQddZakFsmcG4IqB259ay57aazEU1mxRI5Z//oJPCrhVAwDQKrpkPwJg+DN
         jfdZgKdrOridy+5oHdt0H22S8ldDpIrBQDlIZi9Jn42z2jWNFOMsAeyPevFx5YejDny+
         sOzQ==
X-Gm-Message-State: AOJu0Yx+DhIlFpSwIR5F5L/DdAXCq/541Nd29C8WqjANKIhSit9fqd5x
	6kkiL/qIoFrkG5X1YJ6PR6zTebhwZ1ZwaV7geTy7+CYzvy1ACntXIx2A51YBa/Upe9+gCZs8BOZ
	FkJ+sUomQC4O4YNkxzO3V9YswpnQtxVPOwdSorybD0FUAHIasa8K/vCSArVbowhuyfv3a2FgHTy
	DYZfu6BP/0DJS0nmqmM4N2L+6vevBRGL8dIvbnnZU7V0hY
X-Google-Smtp-Source: AGHT+IFBu+oz1w3gdyRfGKsJE5EGR1AZzcvTCAn4ny9jrZvXbOGcU2MB1osfdZu9By8mF6ih6dacw7cWjzIS
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:c40e:b0:1f6:f3ea:f7a2 with SMTP id
 d9443c01a7336-1f83b53a3acmr102595ad.2.1718243924485; Wed, 12 Jun 2024
 18:58:44 -0700 (PDT)
Date: Wed, 12 Jun 2024 18:58:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613015837.4132703-1-jstultz@google.com>
Subject: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling update_rq_clock
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Qais Yousef <qyousef@layalina.io>, Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

I recently got a bug report that
clock_gettime(CLOCK_THREAD_CPUTIME_ID,...) had regressed between
5.10 and 6.1. Its not a huge regression in absolute time
(~30-40ns), but is >10% change.

I narrowed the cause down to the addition of
psi_account_irqtime() in update_rq_clock_task(), in commit
52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
pressure")

So that explains the behavior change, but it also seems odd that
we're doing psi irq accounting from a syscall that is just
trying to read the thread's cputime.

Thinking about it more, it seems the re-use of update_rq_clock()
to handle accounting for any in-progress time for the current
task has the potential for side effects and unnecessary work.

So instead rework the logic so we calculate the current cpu
runtime in a read-only fashion.

This has the side benefit of improving
clock_gettime(CLOCK_THREAD_CPUTIME_ID,...) performance by ~12%
over the behavior in 5.10, and ~21% over the 6.1 behavior.

NOTE: I'm not 100% sure this is correct yet. There may be some
edge cases I've overlooked, so I'd greatly appreciate any
review or feedback.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c | 82 ++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..b29cde5ded84 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -692,16 +692,11 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
  * RQ-clock updating methods:
  */
 
-static void update_rq_clock_task(struct rq *rq, s64 delta)
-{
-/*
- * In theory, the compile should just see 0 here, and optimize out the call
- * to sched_rt_avg_update. But I don't trust it...
- */
-	s64 __maybe_unused steal = 0, irq_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
+static inline s64 get_irq_delta(struct rq *rq, s64 delta)
+{
+	s64 irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
 
 	/*
 	 * Since irq_time is only updated on {soft,}irq_exit, we might run into
@@ -720,7 +715,45 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	 */
 	if (irq_delta > delta)
 		irq_delta = delta;
+	return irq_delta;
+}
+#else
+static inline s64 get_irq_delta(struct rq *rq, s64 delta)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
+static inline s64 get_steal_time(struct rq *rq, s64 delta)
+{
+	s64 steal;
 
+	if (!static_key_false(&paravirt_steal_rq_enabled))
+		return 0;
+	steal = paravirt_steal_clock(cpu_of(rq));
+	steal -= rq->prev_steal_time_rq;
+	if (unlikely(steal > delta))
+		steal = delta;
+	return steal;
+}
+#else
+static inline s64 get_steal_time(struct rq *rq, s64 delta)
+{
+	return 0;
+}
+#endif
+
+static void update_rq_clock_task(struct rq *rq, s64 delta)
+{
+/*
+ * In theory, the compile should just see 0 here, and optimize out the call
+ * to sched_rt_avg_update. But I don't trust it...
+ */
+	s64 __maybe_unused steal = 0, irq_delta = 0;
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	irq_delta = get_irq_delta(rq, delta);
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
 	psi_account_irqtime(rq->curr, irq_delta);
@@ -728,12 +761,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
-		steal = paravirt_steal_clock(cpu_of(rq));
-		steal -= rq->prev_steal_time_rq;
-
-		if (unlikely(steal > delta))
-			steal = delta;
-
+		steal = get_steal_time(rq, delta);
 		rq->prev_steal_time_rq += steal;
 		delta -= steal;
 	}
@@ -5547,23 +5575,6 @@ DEFINE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
 EXPORT_PER_CPU_SYMBOL(kstat);
 EXPORT_PER_CPU_SYMBOL(kernel_cpustat);
 
-/*
- * The function fair_sched_class.update_curr accesses the struct curr
- * and its field curr->exec_start; when called from task_sched_runtime(),
- * we observe a high rate of cache misses in practice.
- * Prefetching this data results in improved performance.
- */
-static inline void prefetch_curr_exec_start(struct task_struct *p)
-{
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	struct sched_entity *curr = (&p->se)->cfs_rq->curr;
-#else
-	struct sched_entity *curr = (&task_rq(p)->cfs)->curr;
-#endif
-	prefetch(curr);
-	prefetch(&curr->exec_start);
-}
-
 /*
  * Return accounted runtime for the task.
  * In case the task is currently running, return the runtime plus current's
@@ -5573,6 +5584,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 {
 	struct rq_flags rf;
 	struct rq *rq;
+	s64 delta_exec = 0;
 	u64 ns;
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_SMP)
@@ -5598,11 +5610,11 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * thread, breaking clock_gettime().
 	 */
 	if (task_current(rq, p) && task_on_rq_queued(p)) {
-		prefetch_curr_exec_start(p);
-		update_rq_clock(rq);
-		p->sched_class->update_curr(rq);
+		delta_exec = sched_clock_cpu(cpu_of(rq)) - p->se.exec_start;
+		delta_exec -= get_irq_delta(rq, delta_exec);
+		delta_exec -= get_steal_time(rq, delta_exec);
 	}
-	ns = p->se.sum_exec_runtime;
+	ns = p->se.sum_exec_runtime + delta_exec;
 	task_rq_unlock(rq, p, &rf);
 
 	return ns;
-- 
2.45.2.505.gda0bf45e8d-goog



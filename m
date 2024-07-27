Return-Path: <linux-kernel+bounces-264102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B393DF01
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4011F22AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7049080633;
	Sat, 27 Jul 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eS13RqF4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98055894
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078147; cv=none; b=XS35I0pCGST6IJExlSpUOGDUDqgwhCuheQGBKpG2Te3q1VBYOaHhfkVq0X4b6lmk3ZY9fbI1RLSVJ7tGeaEEdKhyhR1Pbv2GcNmkkkb15kTIE7o2DtfoawLb1eG+KYrCn7AMIYTMABFVXl7Vxu1KparHzqn2040omMbORzqt0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078147; c=relaxed/simple;
	bh=jvrYKQlA1u/jdzQXZTXd1P3gWMEwCKuD3bzEi2iyJFE=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rjrr9V7JK+3pFnh89BtP1tmGfr+YaScqddIeiCiAJTz5sbjokNFJ1jSo8U3l0xMtUlwN9londk2cRs6TL0i+Qh/RmLcqopeGpaNSZfEWvhSr4buWEd8yhVFiH7xLMFxCT858BhGisjGeo25IzaOosIfjOeKW2DSWsupGBlsUhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eS13RqF4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=yJLgJxK/rIWYjJubSkU0CormnL4GDwWbu+QPPlsX1Sk=; b=eS13RqF4jL6eGUDhOoMWabFclS
	NAYkP7Xe9mP2WQ35cNAiISO0wNYm4ANQrlzGXnXlCAaA8/Yj+6LwUh/Q4MYgNEfQVjf49T/6yCFq6
	y8WMuVHaaLRvHGZkbAP8vSbhJgzaAuWYFU5Xi8mdepC+4tJYeTI7w0ikLMkW55NDidlG6tMFhDS8e
	zAg37WJlGyAaMplapfqulk+RYorvajtmEYb8rno0LtbrSM/TMDlHPqoqvfKIZ5fEEyIK4MMtxV1xS
	XdiULU9nDNnhh32aeTkGXfPlTgoyd9IV5sTj/ircgBmS1aVqIRMP05z+MyULdde3RFCxC9J/b9bd0
	4cBsjMPA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBh-00000004QN4-42Nk;
	Sat, 27 Jul 2024 11:02:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 09823308528; Sat, 27 Jul 2024 13:02:07 +0200 (CEST)
Message-Id: <20240727105031.053611186@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC PATCH 24/24] sched/time: Introduce CLOCK_THREAD_DVFS_ID
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to measure thread time in a DVFS world, introduce
CLOCK_THREAD_DVFS_ID -- a copy of CLOCK_THREAD_CPUTIME_ID that slows
down with both DVFS scaling and CPU capacity.

The clock does *NOT* support setting timers.

Useful for both SCHED_DEADLINE and the newly introduced
sched_attr::sched_runtime usage for SCHED_NORMAL.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers_types.h |    5 ++--
 include/linux/sched.h              |    1 
 include/linux/sched/cputime.h      |    3 ++
 include/uapi/linux/time.h          |    1 
 kernel/sched/core.c                |   40 +++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c                |    8 +++++--
 kernel/time/posix-cpu-timers.c     |   16 +++++++++++++-
 kernel/time/posix-timers.c         |    1 
 kernel/time/posix-timers.h         |    1 
 9 files changed, 71 insertions(+), 5 deletions(-)

--- a/include/linux/posix-timers_types.h
+++ b/include/linux/posix-timers_types.h
@@ -13,9 +13,9 @@
  *
  * Bit 2 indicates whether a cpu clock refers to a thread or a process.
  *
- * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
+ * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or DVSF=3
  *
- * A clockid is invalid if bits 2, 1, and 0 are all set.
+ * (DVFS is PERTHREAD only)
  */
 #define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
 #define CPUCLOCK_PERTHREAD(clock) \
@@ -27,6 +27,7 @@
 #define CPUCLOCK_PROF		0
 #define CPUCLOCK_VIRT		1
 #define CPUCLOCK_SCHED		2
+#define CPUCLOCK_DVFS		3
 #define CPUCLOCK_MAX		3
 #define CLOCKFD			CPUCLOCK_MAX
 #define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -550,6 +550,7 @@ struct sched_entity {
 	u64				exec_start;
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
+	u64				sum_dvfs_runtime;
 	u64				vruntime;
 	s64				vlag;
 	u64				slice;
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -180,4 +180,7 @@ static inline void prev_cputime_init(str
 extern unsigned long long
 task_sched_runtime(struct task_struct *task);
 
+extern unsigned long long
+task_sched_dvfs_runtime(struct task_struct *task);
+
 #endif /* _LINUX_SCHED_CPUTIME_H */
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -62,6 +62,7 @@ struct timezone {
  */
 #define CLOCK_SGI_CYCLE			10
 #define CLOCK_TAI			11
+#define CLOCK_THREAD_DVFS_ID		12
 
 #define MAX_CLOCKS			16
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4551,6 +4551,7 @@ static void __sched_fork(unsigned long c
 	p->se.exec_start		= 0;
 	p->se.sum_exec_runtime		= 0;
 	p->se.prev_sum_exec_runtime	= 0;
+	p->se.sum_dvfs_runtime		= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
@@ -5632,6 +5633,45 @@ unsigned long long task_sched_runtime(st
 	task_rq_unlock(rq, p, &rf);
 
 	return ns;
+}
+
+unsigned long long task_sched_dvfs_runtime(struct task_struct *p)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	u64 ns;
+
+#if defined(CONFIG_64BIT) && defined(CONFIG_SMP)
+	/*
+	 * 64-bit doesn't need locks to atomically read a 64-bit value.
+	 * So we have a optimization chance when the task's delta_exec is 0.
+	 * Reading ->on_cpu is racy, but this is ok.
+	 *
+	 * If we race with it leaving CPU, we'll take a lock. So we're correct.
+	 * If we race with it entering CPU, unaccounted time is 0. This is
+	 * indistinguishable from the read occurring a few cycles earlier.
+	 * If we see ->on_cpu without ->on_rq, the task is leaving, and has
+	 * been accounted, so we're correct here as well.
+	 */
+	if (!p->on_cpu || !task_on_rq_queued(p))
+		return p->se.sum_dvfs_runtime;
+#endif
+
+	rq = task_rq_lock(p, &rf);
+	/*
+	 * Must be ->curr _and_ ->on_rq.  If dequeued, we would
+	 * project cycles that may never be accounted to this
+	 * thread, breaking clock_gettime().
+	 */
+	if (task_current(rq, p) && task_on_rq_queued(p)) {
+		prefetch_curr_exec_start(p);
+		update_rq_clock(rq);
+		p->sched_class->update_curr(rq);
+	}
+	ns = p->se.sum_dvfs_runtime;
+	task_rq_unlock(rq, p, &rf);
+
+	return ns;
 }
 
 #ifdef CONFIG_SCHED_DEBUG
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1118,15 +1118,19 @@ static void update_tg_load_avg(struct cf
 static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 {
 	u64 now = rq_clock_task(rq);
-	s64 delta_exec;
+	s64 delta_exec, delta_dvfs;
 
-	delta_exec = now - curr->exec_start;
+	delta_dvfs = delta_exec = now - curr->exec_start;
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
 	curr->exec_start = now;
 	curr->sum_exec_runtime += delta_exec;
 
+	delta_dvfs = cap_scale(delta_dvfs, arch_scale_freq_capacity(cpu_of(rq)));
+	delta_dvfs = cap_scale(delta_dvfs, arch_scale_cpu_capacity(cpu_of(rq)));
+	curr->sum_dvfs_runtime += delta_dvfs;
+
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -164,7 +164,7 @@ posix_cpu_clock_getres(const clockid_t w
 	if (!error) {
 		tp->tv_sec = 0;
 		tp->tv_nsec = ((NSEC_PER_SEC + HZ - 1) / HZ);
-		if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+		if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_SCHED) {
 			/*
 			 * If sched_clock is using a cycle counter, we
 			 * don't have any idea of its true resolution
@@ -198,6 +198,9 @@ static u64 cpu_clock_sample(const clocki
 	if (clkid == CPUCLOCK_SCHED)
 		return task_sched_runtime(p);
 
+	if (clkid == CPUCLOCK_DVFS)
+		return task_sched_dvfs_runtime(p);
+
 	task_cputime(p, &utime, &stime);
 
 	switch (clkid) {
@@ -1628,6 +1631,7 @@ static long posix_cpu_nsleep_restart(str
 
 #define PROCESS_CLOCK	make_process_cpuclock(0, CPUCLOCK_SCHED)
 #define THREAD_CLOCK	make_thread_cpuclock(0, CPUCLOCK_SCHED)
+#define THREAD_DVFS_CLOCK make_thread_cpuclock(0, CPUCLOCK_DVFS)
 
 static int process_cpu_clock_getres(const clockid_t which_clock,
 				    struct timespec64 *tp)
@@ -1664,6 +1668,11 @@ static int thread_cpu_timer_create(struc
 	timer->it_clock = THREAD_CLOCK;
 	return posix_cpu_timer_create(timer);
 }
+static int thread_dvfs_cpu_clock_get(const clockid_t which_clock,
+				struct timespec64 *tp)
+{
+	return posix_cpu_clock_get(THREAD_DVFS_CLOCK, tp);
+}
 
 const struct k_clock clock_posix_cpu = {
 	.clock_getres		= posix_cpu_clock_getres,
@@ -1690,3 +1699,8 @@ const struct k_clock clock_thread = {
 	.clock_get_timespec	= thread_cpu_clock_get,
 	.timer_create		= thread_cpu_timer_create,
 };
+
+const struct k_clock clock_thread_dvfs = {
+	.clock_getres		= thread_cpu_clock_getres,
+	.clock_get_timespec	= thread_dvfs_cpu_clock_get,
+};
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1516,6 +1516,7 @@ static const struct k_clock * const posi
 	[CLOCK_MONOTONIC]		= &clock_monotonic,
 	[CLOCK_PROCESS_CPUTIME_ID]	= &clock_process,
 	[CLOCK_THREAD_CPUTIME_ID]	= &clock_thread,
+	[CLOCK_THREAD_DVFS_ID]		= &clock_thread_dvfs,
 	[CLOCK_MONOTONIC_RAW]		= &clock_monotonic_raw,
 	[CLOCK_REALTIME_COARSE]		= &clock_realtime_coarse,
 	[CLOCK_MONOTONIC_COARSE]	= &clock_monotonic_coarse,
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -34,6 +34,7 @@ extern const struct k_clock clock_posix_
 extern const struct k_clock clock_posix_dynamic;
 extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
+extern const struct k_clock clock_thread_dvfs;
 extern const struct k_clock alarm_clock;
 
 int posix_timer_event(struct k_itimer *timr, int si_private);




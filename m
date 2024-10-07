Return-Path: <linux-kernel+bounces-352957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E535992674
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780801C21A93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF118C345;
	Mon,  7 Oct 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oG47bYnw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34518C017
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287519; cv=none; b=KPv8e8ofbkDASlheUJV2jijFqAb9CZXKm8oYnssT8qKoxCJF6k93QSeQE6LNuN2xJg/TxDGsGZX+MqKYg5QmwShUNnv6k7fVL+WvA9Lv4OKwykXUd7yR/Rk5PbOjRtAcypBWZ50pAVDSV64XfxIH7izvm7FmahhtZyDU8ONf/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287519; c=relaxed/simple;
	bh=RCUseBAvGquRefoieB96aAdGNA9/NTeQ8XeLRDQpzac=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=V4Jji1ivpPKF61dGA0L8IiJcFr87vrPe7amepLuGhKnfKg2R3OsXX5zdtPDE6tfOBFiBmjb37xVByK4ojKjIwVBPT1tqzXRrczl3LzErAWGW0i1VRJWXXTzJupESJCcl9frsUZVZ2ysfmxK//A3ZravGfYIcJQ3exNODkrDbNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oG47bYnw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=nATjKTapaRz3vaFy/xB6j/zCcWoh/uDG0jvv6zZuLJQ=; b=oG47bYnwU6w969RsE721YkPcyj
	L6EPJm0gzVuEo4DJ4kxk7Nug91EaDpavpMcPtWJp9HyvA7A/563ueitTw1CyAdDpkPAha2DIhpKfc
	elPGvI9TjNZSlbBCkqx722Yxbz7XZ1b6MaA9V8u3GD5RrwuWURhg5H1tevHzx6r/KPQIG8ObEmm5B
	R3vshRIduUf23fiJ35MXyqkZjBhg/tS69Djsy+Vx84mYOG22EYvzlPXccBJKqSzCdIY51DBt5o6Md
	PXfOu4HAQwap7mMm+iMw1UhTbr1Jzrv7ZqPc6ndkb3p7bRsZEmjuvpuggWG80WwBk4QLVwkfInhbF
	Jslc2dOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxiWu-0000000Gvkw-2Eq6;
	Mon, 07 Oct 2024 07:51:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 36FF630221D; Mon,  7 Oct 2024 09:51:44 +0200 (CEST)
Message-Id: <20241007075055.331243614@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 09:46:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: bigeasy@linutronix.de,
 tglx@linutronix.de,
 mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 ankur.a.arora@oracle.com,
 efault@gmx.de
Subject: [PATCH 2/5] sched: Add Lazy preemption model
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Change fair to use resched_curr_lazy(), which, when the lazy
preemption model is selected, will set TIF_NEED_RESCHED_LAZY.

This LAZY bit will be promoted to the full NEED_RESCHED bit on tick.
As such, the average delay between setting LAZY and actually
rescheduling will be TICK_NSEC/2.

In short, Lazy preemption will delay preemption for fair class but
will function as Full preemption for all the other classes, most
notably the realtime (RR/FIFO/DEADLINE) classes.

The goal is to bridge the performance gap with Voluntary, such that we
might eventually remove that option entirely.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/preempt.h |    8 ++++-
 kernel/Kconfig.preempt  |   15 +++++++++
 kernel/sched/core.c     |   76 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/debug.c    |    5 +--
 kernel/sched/fair.c     |    6 +--
 kernel/sched/sched.h    |    1 
 6 files changed, 103 insertions(+), 8 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -486,6 +486,7 @@ DEFINE_LOCK_GUARD_0(migrate, migrate_dis
 extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
 extern bool preempt_model_full(void);
+extern bool preempt_model_lazy(void);
 
 #else
 
@@ -502,6 +503,11 @@ static inline bool preempt_model_full(vo
 	return IS_ENABLED(CONFIG_PREEMPT);
 }
 
+static inline bool preempt_model_lazy(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
+}
+
 #endif
 
 static inline bool preempt_model_rt(void)
@@ -519,7 +525,7 @@ static inline bool preempt_model_rt(void
  */
 static inline bool preempt_model_preemptible(void)
 {
-	return preempt_model_full() || preempt_model_rt();
+	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
 }
 
 #endif /* __LINUX_PREEMPT_H */
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -11,6 +11,9 @@ config PREEMPT_BUILD
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 
+config ARCH_HAS_PREEMPT_LAZY
+	bool
+
 choice
 	prompt "Preemption Model"
 	default PREEMPT_NONE
@@ -67,6 +70,18 @@ config PREEMPT
 	  embedded system with latency requirements in the milliseconds
 	  range.
 
+config PREEMPT_LAZY
+	bool "Scheduler controlled preemption model"
+	depends on !ARCH_NO_PREEMPT
+	depends on ARCH_HAS_PREEMPT_LAZY
+	select PREEMPT_BUILD
+	help
+	  This option provides a scheduler driven preemption model that
+	  is fundamentally similar to full preemption, but is less
+	  eager to preempt SCHED_NORMAL tasks in an attempt to
+	  reduce lock holder preemption and recover some of the performance
+	  gains seen from using Voluntary preemption.
+
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1078,6 +1078,9 @@ static void __resched_curr(struct rq *rq
 
 	lockdep_assert_rq_held(rq);
 
+	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
+		tif = TIF_NEED_RESCHED;
+
 	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
 		return;
 
@@ -1103,6 +1106,32 @@ void resched_curr(struct rq *rq)
 	__resched_curr(rq, TIF_NEED_RESCHED);
 }
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
+static __always_inline bool dynamic_preempt_lazy(void)
+{
+	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
+}
+#else
+static __always_inline bool dynamic_preempt_lazy(void)
+{
+	return IS_ENABLED(PREEMPT_LAZY);
+}
+#endif
+
+static __always_inline int tif_need_resched_lazy(void)
+{
+	if (dynamic_preempt_lazy())
+		return TIF_NEED_RESCHED_LAZY;
+
+	return TIF_NEED_RESCHED;
+}
+
+void resched_curr_lazy(struct rq *rq)
+{
+	__resched_curr(rq, tif_need_resched_lazy());
+}
+
 void resched_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -5598,6 +5627,10 @@ void sched_tick(void)
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
+
+	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		resched_curr(rq);
+
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
@@ -7334,6 +7367,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy       <- false
  *
  * VOLUNTARY:
  *   cond_resched               <- __cond_resched
@@ -7341,6 +7375,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy       <- false
  *
  * FULL:
  *   cond_resched               <- RET0
@@ -7348,6 +7383,15 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
  *   preempt_schedule           <- preempt_schedule
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- false
+ *
+ * LAZY:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- true
  */
 
 enum {
@@ -7355,6 +7399,7 @@ enum {
 	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
+	preempt_dynamic_lazy,
 };
 
 int preempt_dynamic_mode = preempt_dynamic_undefined;
@@ -7370,15 +7415,23 @@ int sched_dynamic_mode(const char *str)
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
 
+#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
+	if (!strcmp(str, "lazy"))
+		return preempt_dynamic_lazy;
+#endif
+
 	return -EINVAL;
 }
 
+#define preempt_dynamic_key_enable(f)	static_key_enable(&sk_dynamic_##f.key)
+#define preempt_dynamic_key_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
-#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+#define preempt_dynamic_enable(f)	preempt_dynamic_key_enable(f)
+#define preempt_dynamic_disable(f)	preempt_dynamic_key_disable(f)
 #else
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
@@ -7398,6 +7451,7 @@ static void __sched_dynamic_update(int m
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
 	preempt_dynamic_enable(irqentry_exit_cond_resched);
+	preempt_dynamic_key_disable(preempt_lazy);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -7407,6 +7461,7 @@ static void __sched_dynamic_update(int m
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: none\n");
 		break;
@@ -7418,6 +7473,7 @@ static void __sched_dynamic_update(int m
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: voluntary\n");
 		break;
@@ -7429,9 +7485,22 @@ static void __sched_dynamic_update(int m
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: full\n");
 		break;
+
+	case preempt_dynamic_lazy:
+		if (!klp_override)
+			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_enable(preempt_schedule);
+		preempt_dynamic_enable(preempt_schedule_notrace);
+		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_enable(preempt_lazy);
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: lazy\n");
+		break;
 	}
 
 	preempt_dynamic_mode = mode;
@@ -7494,6 +7563,8 @@ static void __init preempt_dynamic_init(
 			sched_dynamic_update(preempt_dynamic_none);
 		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
 			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
+			sched_dynamic_update(preempt_dynamic_lazy);
 		} else {
 			/* Default static call setting, nothing to do */
 			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
@@ -7514,6 +7585,7 @@ static void __init preempt_dynamic_init(
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
+PREEMPT_MODEL_ACCESSOR(lazy);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
 
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,11 +245,12 @@ static ssize_t sched_dynamic_write(struc
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
 	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
+		"none", "voluntary", "full", "lazy",
 	};
+	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+	for (i = 0; i < j; i++) {
 		if (preempt_dynamic_mode == i)
 			seq_puts(m, "(");
 		seq_puts(m, preempt_modes[i]);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1251,7 +1251,7 @@ static void update_curr(struct cfs_rq *c
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {
-		resched_curr(rq);
+		resched_curr_lazy(rq);
 		clear_buddies(cfs_rq, curr);
 	}
 }
@@ -5677,7 +5677,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
 	 * validating it and just reschedule.
 	 */
 	if (queued) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr_lazy(rq_of(cfs_rq));
 		return;
 	}
 	/*
@@ -8832,7 +8832,7 @@ static void check_preempt_wakeup_fair(st
 	return;
 
 preempt:
-	resched_curr(rq);
+	resched_curr_lazy(rq);
 }
 
 static struct task_struct *pick_task_fair(struct rq *rq)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2692,6 +2692,7 @@ extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
 extern void resched_curr(struct rq *rq);
+extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);




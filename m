Return-Path: <linux-kernel+bounces-352956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34086992673
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578CB1C22454
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72018C33C;
	Mon,  7 Oct 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h48XuwlU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322018C004
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287519; cv=none; b=QNstbZdewWNyGK7mRcehNoKndw9AclDdAYCier7jWeFXlAKiD790ZWKMABMl477MWr0CUw40+2q0jr0lVjH1hJqfRw6GyAElPiFT0iW7scE9siNu0vwVE5uYAVI0L3DvLunHtMaEyHRiGWm8LsuU4Ka+VFPsh/G48OXDjJXoF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287519; c=relaxed/simple;
	bh=Fm2SnhLBB/ZhkbPVFzxg9IjtEZtZTmWGt4gdXLhmxF8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=u3tv/TIok30PaZSirVU1iZXgZcp+Wt8CW7jr3I3zDbxdzpcblSymvREn1X2k+7LAepKOP968sJe8/LUnScftAkWdFZPsVUEsm2fjKxWJGWqVoSa1FFjKJWoL4Qc4rs7o8+YyCcXCMvBWJCLPRSE+NNLC6hiyrKqRne8J0csLJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h48XuwlU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ippGUddcEenIDxPXrEM34DuRJYRL1QRqJM/qeMRfePg=; b=h48XuwlUhr7/lW2lcaE/pyPdcV
	2sRXRxWGl59o0/BQmaPSlPcpsOkYOGs/Out9uIissl1EwV4YUvW1kTkYFGsRK9lNEPEEFOBU4BpM5
	LiaIo7XeB5FAsEU/yqnHtsmkU6G2+kHJ0Yi+y3KcMdTRnc/RIzci5BK4SRlutm7nqqpFK3iZ3X9rr
	XOcei9lkX09YzTdjzW3Kpw+hxiQ03/dzGFewW+dQSaBCfEaC+neFr5WRL9DJXMdNLoG+f5+kuwoXD
	zY0MMGNacPQv3nuHPxkeyHV/n0qvzFl27p1fC/+mVnM8wbpy8bbkC4JgGy/6VGAjS1oPUD6qFlOZH
	tmflZUyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxiWv-00000004Nud-2Ske;
	Mon, 07 Oct 2024 07:51:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 44BAE302DFF; Mon,  7 Oct 2024 09:51:44 +0200 (CEST)
Message-Id: <20241007075055.671722644@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 09:46:14 +0200
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
Subject: [PATCH 5/5] sched: Add laziest preempt model
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Much like LAZY, except lazier still. It will not promote LAZY to full
preempt on tick and compete with None for suckage.

(do we really wants this?)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/preempt.h |   10 ++++++++-
 kernel/Kconfig.preempt  |   12 +++++++++++
 kernel/sched/core.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/debug.c    |    4 +--
 4 files changed, 71 insertions(+), 4 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -487,6 +487,7 @@ extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
 extern bool preempt_model_full(void);
 extern bool preempt_model_lazy(void);
+extern bool preempt_model_laziest(void);
 
 #else
 
@@ -507,6 +508,10 @@ static inline bool preempt_model_lazy(vo
 {
 	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
 }
+static inline bool preempt_model_laziest(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_LAZIEST);
+}
 
 #endif
 
@@ -525,7 +530,10 @@ static inline bool preempt_model_rt(void
  */
 static inline bool preempt_model_preemptible(void)
 {
-	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
+	return preempt_model_full() ||
+	       preempt_model_lazy() ||
+	       preempt_model_laziest() ||
+	       preempt_model_rt();
 }
 
 #endif /* __LINUX_PREEMPT_H */
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -84,6 +84,18 @@ config PREEMPT_LAZY
 	  reduce lock holder preemption and recover some of the performance
 	  gains seen from using Voluntary preemption.
 
+config PREEMPT_LAZIEST
+	bool "Scheduler controlled preemption model"
+	depends on !ARCH_NO_PREEMPT
+	depends on ARCH_HAS_PREEMPT_LAZY
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
+	help
+	  This option provides a scheduler driven preemption model that
+	  is fundamentally similar to full preemption, but is least
+	  eager to preempt SCHED_NORMAL tasks in an attempt to
+	  reduce lock holder preemption and recover some of the performance
+	  gains seen from using no preemption.
+
 endchoice
 
 config PREEMPT_RT
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1108,13 +1108,22 @@ void resched_curr(struct rq *rq)
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_promote);
 static __always_inline bool dynamic_preempt_lazy(void)
 {
 	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
 }
+static __always_inline bool dynamic_preempt_promote(void)
+{
+	return static_branch_unlikely(&sk_dynamic_preempt_promote);
+}
 #else
 static __always_inline bool dynamic_preempt_lazy(void)
 {
+	return IS_ENABLED(PREEMPT_LAZY) | IS_ENABLED(PREEMPT_LAZIEST);
+}
+static __always_inline bool dynamic_preempt_promote(void)
+{
 	return IS_ENABLED(PREEMPT_LAZY);
 }
 #endif
@@ -5628,7 +5637,7 @@ void sched_tick(void)
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 
-	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+	if (dynamic_preempt_promote() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
 		resched_curr(rq);
 
 	curr->sched_class->task_tick(rq, curr, 0);
@@ -7368,6 +7377,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
  *   dynamic_preempt_lazy       <- false
+ *   dynamic_preempt_promote    <- false
  *
  * VOLUNTARY:
  *   cond_resched               <- __cond_resched
@@ -7376,6 +7386,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
  *   dynamic_preempt_lazy       <- false
+ *   dynamic_preempt_promote    <- false
  *
  * FULL:
  *   cond_resched               <- RET0
@@ -7384,6 +7395,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
  *   dynamic_preempt_lazy       <- false
+ *   dynamic_preempt_promote    <- false
  *
  * LAZY:
  *   cond_resched               <- RET0
@@ -7392,6 +7404,16 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
  *   dynamic_preempt_lazy       <- true
+ *   dynamic_preempt_promote    <- true
+ *
+ * LAZIEST:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- true
+ *   dynamic_preempt_promote    <- false
  */
 
 enum {
@@ -7400,6 +7422,7 @@ enum {
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
 	preempt_dynamic_lazy,
+	preempt_dynamic_laziest,
 };
 
 int preempt_dynamic_mode = preempt_dynamic_undefined;
@@ -7420,6 +7443,9 @@ int sched_dynamic_mode(const char *str)
 #ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
 	if (!strcmp(str, "lazy"))
 		return preempt_dynamic_lazy;
+
+	if (!strcmp(str, "laziest"))
+		return preempt_dynamic_laziest;
 #endif
 
 	return -EINVAL;
@@ -7454,6 +7480,7 @@ static void __sched_dynamic_update(int m
 	preempt_dynamic_enable(preempt_schedule_notrace);
 	preempt_dynamic_enable(irqentry_exit_cond_resched);
 	preempt_dynamic_key_disable(preempt_lazy);
+	preempt_dynamic_key_disable(preempt_promote);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -7464,6 +7491,7 @@ static void __sched_dynamic_update(int m
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		preempt_dynamic_key_disable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: none\n");
 		break;
@@ -7476,6 +7504,7 @@ static void __sched_dynamic_update(int m
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		preempt_dynamic_key_disable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: voluntary\n");
 		break;
@@ -7488,6 +7517,7 @@ static void __sched_dynamic_update(int m
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
 		preempt_dynamic_key_disable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: full\n");
 		break;
@@ -7500,9 +7530,23 @@ static void __sched_dynamic_update(int m
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
 		preempt_dynamic_key_enable(preempt_lazy);
+		preempt_dynamic_key_enable(preempt_promote);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: lazy\n");
 		break;
+
+	case preempt_dynamic_laziest:
+		if (!klp_override)
+			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_enable(preempt_schedule);
+		preempt_dynamic_enable(preempt_schedule_notrace);
+		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_enable(preempt_lazy);
+		preempt_dynamic_key_disable(preempt_promote);
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: laziest\n");
+		break;
 	}
 
 	preempt_dynamic_mode = mode;
@@ -7567,6 +7611,8 @@ static void __init preempt_dynamic_init(
 			sched_dynamic_update(preempt_dynamic_voluntary);
 		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
 			sched_dynamic_update(preempt_dynamic_lazy);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZIEST)) {
+			sched_dynamic_update(preempt_dynamic_laziest);
 		} else {
 			/* Default static call setting, nothing to do */
 			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
@@ -7588,6 +7634,7 @@ PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
 PREEMPT_MODEL_ACCESSOR(lazy);
+PREEMPT_MODEL_ACCESSOR(laziest);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
 
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,9 +245,9 @@ static ssize_t sched_dynamic_write(struc
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
 	static const char * preempt_modes[] = {
-		"none", "voluntary", "full", "lazy",
+		"none", "voluntary", "full", "lazy", "laziest",
 	};
-	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
+	int j = ARRAY_SIZE(preempt_modes) - 2*!IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
 
 	for (; i < j; i++) {




Return-Path: <linux-kernel+bounces-352958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2177992675
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFEA1C2249F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EDA18C35A;
	Mon,  7 Oct 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eduVKx7g"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337218C327
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287521; cv=none; b=tEoXcJ9Wt07il4jEu11hwvGAeQNxuW8VmGIMK7NiNE8PFhh06fWm8iAUSnAkbOe8BtCLPYLZHhAgN/9U38w9xhOhwwwrxWqB9/KiAL4WucICZD1shVo9c1Y2+q83QzNuRgO5H0ye3s5XeM5Ok6mzifMlXluCEpi+lbvBS7UbFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287521; c=relaxed/simple;
	bh=OX8KGupN8rW/QFbg83LuXMRW/ellxnM86n9Ov8ZGJRI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bgrTC0PFC02jjQlUTNvXNb6Auk3D71Oq9L3FkCNLnahbcoV4Gh0FnhtZyEVR7rC3MDEF8RQkpJrv3zA9T0gfIrxHwAqQf0Aong4dXc060FAKjGf2/1k3BN3nsoDjhYcJHZffP33Ixb/lF1Mw+FcVASYCWPYrPqPWsNonGZFYHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eduVKx7g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=eJ8uirHpYpBUE4MiXI/smRm+GvzNWv+XYpFw0nRJ8Yg=; b=eduVKx7gP3bhf5GpOlMou1pF2X
	vctuCj1JuV0+EvP3F5uKxTDkPZo/LFDt2Vgeq2hSzv0DL1IcEnQsai5Z29nDMpT9tOHI8YsDE4BqJ
	WZVb4tb6/n79VxhCareIngC6i5Obv146ooe3sIkF8rt2O2R76nwByZGASWG/piyNKezCs30T/uNm+
	8PO/0sQTaDmF5ioij/XmU7VRwli8uzwxO8I01J5/scJjPB8SU7vyPrqa0Hlv3wK8emSiAzua8w+qe
	I9h5DImAdxW1kO3aKCZCnILGyKMhUcfHDFXk8oTSsUyYnEFuD5RS7GiRyhuW6KXqlVB+zg1YEDJT7
	5Et920WA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxiWu-0000000Gvkv-2Ix7;
	Mon, 07 Oct 2024 07:51:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 32B43300ABE; Mon,  7 Oct 2024 09:51:44 +0200 (CEST)
Message-Id: <20241007075055.219540785@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 09:46:10 +0200
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
Subject: [PATCH 1/5] sched: Add TIF_NEED_RESCHED_LAZY infrastructure
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add the basic infrastructure to split the TIF_NEED_RESCHED bit in two.
Either bit will cause a resched on return-to-user, but only
TIF_NEED_RESCHED will drive IRQ preemption.

No behavioural change intended.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/entry-common.h |    3 ++-
 include/linux/entry-kvm.h    |    5 +++--
 include/linux/sched.h        |    3 ++-
 include/linux/thread_info.h  |   21 +++++++++++++++++----
 kernel/entry/common.c        |    2 +-
 kernel/entry/kvm.c           |    4 ++--
 kernel/sched/core.c          |   34 +++++++++++++++++++++-------------
 7 files changed, 48 insertions(+), 24 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -64,7 +64,8 @@
 
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
+	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -17,8 +17,9 @@
 #endif
 
 #define XFER_TO_GUEST_MODE_WORK						\
-	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | _TIF_SIGPENDING | \
+	 _TIF_NOTIFY_SIGNAL | _TIF_NOTIFY_RESUME |			\
+	 ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2002,7 +2002,8 @@ static inline void set_tsk_need_resched(
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
+			   (atomic_long_t *)&task_thread_info(tsk)->flags);
 }
 
 static inline int test_tsk_need_resched(struct task_struct *tsk)
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,6 +59,14 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
+#ifndef TIF_NEED_RESCHED_LAZY
+#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
+#error Inconsistent PREEMPT_LAZY
+#endif
+#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
+#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
@@ -179,22 +187,27 @@ static __always_inline unsigned long rea
 
 #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_test_bit(int bit)
 {
-	return arch_test_bit(TIF_NEED_RESCHED,
+	return arch_test_bit(bit,
 			     (unsigned long *)(&current_thread_info()->flags));
 }
 
 #else
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_test_bit(int bit)
 {
-	return test_bit(TIF_NEED_RESCHED,
+	return test_bit(bit,
 			(unsigned long *)(&current_thread_info()->flags));
 }
 
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
+static __always_inline bool tif_need_resched(void)
+{
+	return tif_test_bit(TIF_NEED_RESCHED);
+}
+
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -98,7 +98,7 @@ __always_inline unsigned long exit_to_us
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struc
 			return -EINTR;
 		}
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
@@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struc
 			return ret;
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
 	return 0;
 }
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -936,10 +936,9 @@ static inline void hrtick_rq_init(struct
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
-	struct thread_info *ti = task_thread_info(p);
-	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
+	return !(fetch_or(&ti->flags, 1 << tif) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -964,9 +963,9 @@ static bool set_nr_if_polling(struct tas
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
-	set_tsk_need_resched(p);
+	atomic_long_or(1 << tif, (atomic_long_t *)&ti->flags);
 	return true;
 }
 
@@ -1071,28 +1070,37 @@ void wake_up_q(struct wake_q_head *head)
  * might also involve a cross-CPU call to trigger the scheduler on
  * the target CPU.
  */
-void resched_curr(struct rq *rq)
+static void __resched_curr(struct rq *rq, int tif)
 {
 	struct task_struct *curr = rq->curr;
+	struct thread_info *cti = task_thread_info(curr);
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr))
+	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr);
-		set_preempt_need_resched();
+		set_ti_thread_flag(cti, tif);
+		if (tif == TIF_NEED_RESCHED)
+			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
-	else
+	if (set_nr_and_not_polling(cti, tif)) {
+		if (tif == TIF_NEED_RESCHED)
+			smp_send_reschedule(cpu);
+	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
+	}
+}
+
+void resched_curr(struct rq *rq)
+{
+	__resched_curr(rq, TIF_NEED_RESCHED);
 }
 
 void resched_cpu(int cpu)
@@ -1187,7 +1195,7 @@ static void wake_up_idle_cpu(int cpu)
 	 * and testing of the above solutions didn't appear to report
 	 * much benefits.
 	 */
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(task_thread_info(rq->idle), TIF_NEED_RESCHED))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);




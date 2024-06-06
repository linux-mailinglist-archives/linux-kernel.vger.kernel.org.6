Return-Path: <linux-kernel+bounces-204203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE788FE5C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B202E284393
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AA194C90;
	Thu,  6 Jun 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b66s5NvW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4939FEF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674680; cv=none; b=PO4BBv8kLeCWEZElPpsdqQ96YycgvvxpZKNdmsrQ2k7qZV6Jv5WAtqYHYHhmTlI0dzOFe5+YOlo2tE+39xoIPIb/c598Ij0r7v1yahQse6w0ykNo1wPEc5n2D+0cSGQEltd9YYlym20+U7PSz9IHfX6/P9UuttjnFmTHnqkXg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674680; c=relaxed/simple;
	bh=0M3xOAc2HC4csxEZb1oJv5fdLrk77diQQvaYbfCEeNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwmTvRCHUEz7KpdiN9ZlAoqXiW+xqZcRWfWAtU5PkTXWwksRw508uHQsCrvtUOntsDbbkQ0COLEdTybKTTskuGXfdDnWVc2cI1+LwbDh04O02LFTBe/6fYtu7Dn2t5eP3L0Dfnb7kgBJ9PViOnakgsvw3c2bRFxoSZKKkPD+SoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b66s5NvW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AHdOdenD+920HAhEjYpY1r+IbqvKfn9NM80bM7pYhDw=; b=b66s5NvWVOCrAQbVXiLMcID3Qy
	UV7jDnlNeZ6ABZYnftZ8X71E3+5Xm7QZSza/AjFBI9Wkqnkrq1bhmBMcFyJgcqz6OBNIuqnj6BjFM
	X/VcC4/MFFyBvs78nDIBKVF7qlWS10viUt6Ym/U1mlYYpj5d4DrAurSPXlcDdwZcqYFHHFXNTfARj
	KIvJDGmOYiX/enTMl7hOOZX8Rfgyh3khRKzzcKOjtRDsGZK3l4V8z6Y4hqHnuXYpsa+iDYlr4cfzx
	EpRpVDW4gKzt/v9zPFlLovjbtVFsd2Aczy0bqTxgePoGf0XCWG+iHns0YURLQIkxwWr9OrU4vMjWG
	Z+2wtwYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFBe5-0000000DxVW-3IEX;
	Thu, 06 Jun 2024 11:51:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CDCC930047C; Thu,  6 Jun 2024 13:51:01 +0200 (CEST)
Date: Thu, 6 Jun 2024 13:51:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
Message-ID: <20240606115101.GC8774@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-14-ankur.a.arora@oracle.com>
 <20240528162725.GH26599@noisy.programming.kicks-ass.net>
 <87ttif641i.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttif641i.fsf@oracle.com>

On Thu, May 30, 2024 at 02:29:45AM -0700, Ankur Arora wrote:
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Mon, May 27, 2024 at 05:34:59PM -0700, Ankur Arora wrote:
> >> Reuse sched_dynamic_update() and related logic to enable choosing
> >> the preemption model at boot or runtime for PREEMPT_AUTO.
> >>
> >> The interface is identical to PREEMPT_DYNAMIC.
> >
> > Colour me confused, why?!? What are you doing and why aren't just just
> > adding AUTO to the existing DYNAMIC thing?
> 
> You mean have a single __sched_dynamic_update()? AUTO doesn't use any
> of the static_call/static_key stuff so I'm not sure how that would work.

*sigh*... see the below, seems to work.

---
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/thread_info.h |   6 +-
 include/linux/entry-common.h       |   3 +-
 include/linux/entry-kvm.h          |   5 +-
 include/linux/sched.h              |  10 +++-
 include/linux/thread_info.h        |  21 +++++--
 kernel/Kconfig.preempt             |  11 ++++
 kernel/entry/common.c              |   2 +-
 kernel/entry/kvm.c                 |   4 +-
 kernel/sched/core.c                | 110 ++++++++++++++++++++++++++++++++-----
 kernel/sched/debug.c               |   2 +-
 kernel/sched/fair.c                |   4 +-
 kernel/sched/sched.h               |   1 +
 13 files changed, 148 insertions(+), 32 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e8837116704ce..61f86b69524d7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -91,6 +91,7 @@ config X86
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 12da7dfd5ef13..75bb390f7baf5 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,8 +87,9 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
+#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
+#define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -110,6 +111,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b0fb775a600d9..e66c8a7c113f4 100644
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
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb2..16149f6625e48 100644
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
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7635045b2395c..5900d84e08b3c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1968,7 +1968,8 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
+			   (atomic_long_t *)&task_thread_info(tsk)->flags);
 }
 
 static inline int test_tsk_need_resched(struct task_struct *tsk)
@@ -2074,6 +2075,7 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
 extern bool preempt_model_full(void);
+extern bool preempt_model_lazy(void);
 
 #else
 
@@ -2089,6 +2091,10 @@ static inline bool preempt_model_full(void)
 {
 	return IS_ENABLED(CONFIG_PREEMPT);
 }
+static inline bool preempt_model_lazy(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
+}
 
 #endif
 
@@ -2107,7 +2113,7 @@ static inline bool preempt_model_rt(void)
  */
 static inline bool preempt_model_preemptible(void)
 {
-	return preempt_model_full() || preempt_model_rt();
+	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
 }
 
 static __always_inline bool need_resched(void)
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f49..cf2446c9c30d4 100644
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
@@ -179,22 +187,27 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 
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
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c2f1fd95a8214..1a2e3849e3e5f 100644
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
@@ -67,6 +70,14 @@ config PREEMPT
 	  embedded system with latency requirements in the milliseconds
 	  range.
 
+config PREEMPT_LAZY
+	bool "Scheduler controlled preemption model"
+	depends on !ARCH_NO_PREEMPT
+	depends on ARCH_HAS_PREEMPT_LAZY
+	select PREEMPT_BUILD
+	help
+	  Hamsters in your brain...
+
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90843cc385880..bcb23c866425e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -98,7 +98,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd1..8485f63863afc 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
@@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return ret;
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
 	return 0;
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 965e6464e68e9..c32de809283cf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -904,10 +904,9 @@ static inline void hrtick_rq_init(struct rq *rq)
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
@@ -932,9 +931,9 @@ static bool set_nr_if_polling(struct task_struct *p)
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
-	set_tsk_need_resched(p);
+	atomic_long_or(1 << tif, (atomic_long_t *)&ti->flags);
 	return true;
 }
 
@@ -1039,28 +1038,66 @@ void wake_up_q(struct wake_q_head *head)
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
+	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
+		tif = TIF_NEED_RESCHED;
+
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
+}
+
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
 }
 
 void resched_cpu(int cpu)
@@ -1155,7 +1192,7 @@ static void wake_up_idle_cpu(int cpu)
 	 * and testing of the above solutions didn't appear to report
 	 * much benefits.
 	 */
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(task_thread_info(rq->idle), TIF_NEED_RESCHED))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -5537,6 +5574,10 @@ void sched_tick(void)
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
@@ -7245,6 +7286,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy	<- false
  *
  * VOLUNTARY:
  *   cond_resched               <- __cond_resched
@@ -7252,6 +7294,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy	<- false
  *
  * FULL:
  *   cond_resched               <- RET0
@@ -7259,6 +7302,15 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- preempt_schedule
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy	<- false
+ *
+ * LAZY:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy	<- true
  */
 
 enum {
@@ -7266,6 +7318,7 @@ enum {
 	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
+	preempt_dynamic_lazy,
 };
 
 int preempt_dynamic_mode = preempt_dynamic_undefined;
@@ -7281,15 +7334,23 @@ int sched_dynamic_mode(const char *str)
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
@@ -7309,6 +7370,7 @@ static void __sched_dynamic_update(int mode)
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
 	preempt_dynamic_enable(irqentry_exit_cond_resched);
+	preempt_dynamic_key_disable(preempt_lazy);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -7318,6 +7380,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: none\n");
 		break;
@@ -7329,6 +7392,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: voluntary\n");
 		break;
@@ -7340,9 +7404,22 @@ static void __sched_dynamic_update(int mode)
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
@@ -7405,6 +7482,8 @@ static void __init preempt_dynamic_init(void)
 			sched_dynamic_update(preempt_dynamic_none);
 		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
 			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
+			sched_dynamic_update(preempt_dynamic_lazy);
 		} else {
 			/* Default static call setting, nothing to do */
 			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
@@ -7425,6 +7504,7 @@ static void __init preempt_dynamic_init(void)
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
+PREEMPT_MODEL_ACCESSOR(lazy);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1bc24410ae501..87309cf247c68 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,7 +245,7 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
 	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
+		"none", "voluntary", "full", "lazy",
 	};
 	int i;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b5d50dbc79dc..71b4112cadde0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1007,7 +1007,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * The task has consumed its request, reschedule.
 	 */
 	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr_lazy(rq_of(cfs_rq));
 		clear_buddies(cfs_rq, se);
 	}
 }
@@ -8615,7 +8615,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	return;
 
 preempt:
-	resched_curr(rq);
+	resched_curr_lazy(rq);
 }
 
 static struct task_struct *pick_task_fair(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 041d8e00a1568..48a4617a5b28b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2494,6 +2494,7 @@ extern void init_sched_fair_class(void);
 extern void reweight_task(struct task_struct *p, int prio);
 
 extern void resched_curr(struct rq *rq);
+extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;


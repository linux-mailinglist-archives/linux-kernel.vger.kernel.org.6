Return-Path: <linux-kernel+bounces-406889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 356489C65A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B412A1F23FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDF1E4B0;
	Wed, 13 Nov 2024 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a5JYqmHm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D4800
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456121; cv=none; b=UV7OKyBQksN+A+0zZ4qJ4ea9kVicDeG+Hc1KucmWzRr1SiQ0lZTelCCTezT6+lIBEYi4G35ENgKzSHNGf3eAICIwG33z8QSWP6cL4Aa/V8QA0LBLDKoTZTqd86LOGKHqu9Cf9oaDOlFzSMZXwvHRaD46W/BuCVcpiLmkk0si5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456121; c=relaxed/simple;
	bh=OiAGIEGGIcbEnAnd1bCCitwZcpjye5jEN/qWdPFxlOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzVykFOcYmADu/yX09vl5gCwz3ghtSweOdOJbit8Oj69GhqhgfA4BzTqNOD3vHCgztpMAao/USkFwWhpXJEil9T/grlmboMeLkfsVcuzJ2E/CStDnMh1dg81qhIPqsXa8jdP9cY1PcojzcXUtgBVFT40ySgx+MWrZjB6BToqLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a5JYqmHm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN1WS2026420;
	Wed, 13 Nov 2024 00:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=hIsy3
	2Kufsjc84Tmu/XoYPOOh39oLFi4btQaeZJIVJ4=; b=a5JYqmHmgIDorGhrF2W2V
	oKQk6JombaN2pMO5REAvBY0oOBL1q7Y/IiZ1OzRmdQ6F0x95ou501/cFhhPnOFge
	Ngb4FOa4Rp3g8QAPWfwuAncZMLs+8c5Un43tgN1/lj8S9kQ1Uy3mK7Qt9BSdc/+3
	MHUXLirNVYPor/WuEbsyi6UiK/L0uPwOQGf/TxA4MZBFpfmTmPjHIFPgAVY6OsLq
	jGhWOfR/xpn+wlVsMOC+x/wCdgQBMpBU0dmL+Dc+wquX8Kr+RVm4+tffNM9tzdgo
	LiCzURXuKSRWpM23ol3yAZDn6Rc2o9wy5w8wYE/Xcd+KSibTXBV8aIic6iPevvtK
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbdqxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 00:01:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN4jqM007920;
	Wed, 13 Nov 2024 00:01:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AD01bKi011807;
	Wed, 13 Nov 2024 00:01:39 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq2j-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:39 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, peterz@infradead.org, tglx@linutronix.de,
        daniel.m.jordan@oracle.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 2/4] Scheduler time extention
Date: Wed, 13 Nov 2024 00:01:24 +0000
Message-ID: <20241113000126.967713-3-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241113000126.967713-1-prakash.sangappa@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120193
X-Proofpoint-GUID: mZjXpmKrj6q3jD9-8okMhstnnsmKoQgu
X-Proofpoint-ORIG-GUID: mZjXpmKrj6q3jD9-8okMhstnnsmKoQgu

Introduce support for a thread to request extending execution time on
the cpu, when holding locks in user space. Adds a member 'sched_delay' to
the per thread shared mapped structure. Request for cpu execution time
extention is made by the thread by updating 'sched_delay' member.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/entry-common.h     | 10 +++++--
 include/linux/sched.h            | 17 +++++++++++
 include/uapi/linux/task_shared.h |  2 +-
 kernel/entry/common.c            | 15 ++++++----
 kernel/sched/core.c              | 16 ++++++++++
 kernel/sched/syscalls.c          |  7 +++++
 mm/task_shared.c                 | 50 ++++++++++++++++++++++++++++++++
 7 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1e50cdb83ae5..904f5cdfe0b7 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -302,7 +302,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
  * exit_to_user_mode_loop - do any pending work before leaving to user space
  */
 unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
+				     unsigned long ti_work, bool irq);
 
 /**
  * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
@@ -314,7 +314,8 @@ unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
  *    EXIT_TO_USER_MODE_WORK are set
  * 4) check that interrupts are still disabled
  */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs,
+						bool irq)
 {
 	unsigned long ti_work;
 
@@ -325,7 +326,10 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	ti_work = read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
+		ti_work = exit_to_user_mode_loop(regs, ti_work, irq);
+
+	if (irq)
+		taskshrd_delay_resched_fini();
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1ca7d4efa932..b53e7a878a01 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -326,6 +326,7 @@ extern int __must_check io_schedule_prepare(void);
 extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
+extern void hrtick_local_start(u64 delay);
 
 /**
  * struct prev_cputime - snapshot of system and user cputime
@@ -957,6 +958,9 @@ struct task_struct {
 	 * ->sched_remote_wakeup gets used, so it can be in this word.
 	 */
 	unsigned			sched_remote_wakeup:1;
+#ifdef CONFIG_TASKSHARED
+	unsigned			taskshrd_sched_delay:1;
+#endif
 #ifdef CONFIG_RT_MUTEXES
 	unsigned			sched_rt_mutex:1;
 #endif
@@ -2186,6 +2190,19 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_TASKSHARED
+
+extern bool taskshrd_delay_resched(void);
+extern void taskshrd_delay_resched_fini(void);
+extern void taskshrd_delay_resched_tick(void);
+#else
+
+static inline bool taskshrd_delay_resched(void) { return false; }
+static inline void taskshrd_delay_resched_fini(void) { }
+static inline void taskshrd_delay_resched_tick(void) { }
+
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
diff --git a/include/uapi/linux/task_shared.h b/include/uapi/linux/task_shared.h
index a07902c57380..6e4c664eea60 100644
--- a/include/uapi/linux/task_shared.h
+++ b/include/uapi/linux/task_shared.h
@@ -13,6 +13,6 @@
 #define TASK_SHAREDINFO 1
 
 struct task_sharedinfo {
-		int version;
+		volatile unsigned short sched_delay;
 };
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 11ec8320b59d..0e0360e8c127 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -89,7 +89,8 @@ void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
  * @ti_work:	TIF work flags as read by the caller
  */
 __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+						     unsigned long ti_work,
+						     bool irq)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -99,8 +100,12 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
+		if (ti_work & _TIF_NEED_RESCHED) {
+			if (irq && taskshrd_delay_resched())
+				clear_tsk_need_resched(current);
+			else
+				schedule();
+		}
 
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
@@ -208,7 +213,7 @@ static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *reg
 {
 	syscall_exit_to_user_mode_prepare(regs);
 	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
+	exit_to_user_mode_prepare(regs, false);
 }
 
 void syscall_exit_to_user_mode_work(struct pt_regs *regs)
@@ -232,7 +237,7 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	exit_to_user_mode_prepare(regs, true);
 	instrumentation_end();
 	exit_to_user_mode();
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 71b6396db118..713c43491403 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -815,6 +815,7 @@ void update_rq_clock(struct rq *rq)
 
 static void hrtick_clear(struct rq *rq)
 {
+	taskshrd_delay_resched_tick();
 	if (hrtimer_active(&rq->hrtick_timer))
 		hrtimer_cancel(&rq->hrtick_timer);
 }
@@ -830,6 +831,8 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	WARN_ON_ONCE(cpu_of(rq) != smp_processor_id());
 
+	taskshrd_delay_resched_tick();
+
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
@@ -903,6 +906,16 @@ void hrtick_start(struct rq *rq, u64 delay)
 
 #endif /* CONFIG_SMP */
 
+void hrtick_local_start(u64 delay)
+{
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+
+	rq_lock(rq, &rf);
+	hrtick_start(rq, delay);
+	rq_unlock(rq, &rf);
+}
+
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
@@ -6645,6 +6658,9 @@ static void __sched notrace __schedule(int sched_mode)
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_TASKSHARED
+	prev->taskshrd_sched_delay = 0;
+#endif
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
 #endif
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index d23c34b8b3eb..0904667924d8 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1419,6 +1419,13 @@ static void do_sched_yield(void)
  */
 SYSCALL_DEFINE0(sched_yield)
 {
+
+#ifdef  CONFIG_TASKSHARED
+	if (current->taskshrd_sched_delay) {
+		schedule();
+		return 0;
+	}
+#endif
 	do_sched_yield();
 	return 0;
 }
diff --git a/mm/task_shared.c b/mm/task_shared.c
index cea45d913b91..575b335d6879 100644
--- a/mm/task_shared.c
+++ b/mm/task_shared.c
@@ -268,6 +268,56 @@ static int task_ushared_alloc(void)
 	return ret;
 }
 
+bool taskshrd_delay_resched(void)
+{
+	struct task_struct *t = current;
+	struct task_ushrd_struct *shrdp = t->task_ushrd;
+
+	if (!IS_ENABLED(CONFIG_SCHED_HRTICK))
+		return false;
+
+	if(shrdp == NULL || shrdp->kaddr == NULL)
+		return false;
+
+	if (t->taskshrd_sched_delay)
+		return false;
+
+	if (!(shrdp->kaddr->ts.sched_delay))
+		return false;
+
+	shrdp->kaddr->ts.sched_delay = 0;
+	t->taskshrd_sched_delay = 1;
+
+	return true;
+}
+
+void taskshrd_delay_resched_fini(void)
+{
+#ifdef CONFIG_SCHED_HRTICK
+	struct task_struct *t = current;
+	/*
+	* IRQs off, guaranteed to return to userspace, start timer on this CPU
+	* to limit the resched-overdraft.
+	*
+	* If your critical section is longer than 50 us you get to keep the
+	* pieces.
+	*/
+	if (t->taskshrd_sched_delay)
+		hrtick_local_start(50 * NSEC_PER_USEC);
+#endif
+}
+
+void taskshrd_delay_resched_tick(void)
+{
+#ifdef CONFIG_SCHED_HRTICK
+	struct task_struct *t = current;
+
+	if (t->taskshrd_sched_delay) {
+		set_tsk_need_resched(t);
+	}
+#endif
+}
+
 
 /*
  * Get Task Shared structure, allocate if needed and return mapped user address.
-- 
2.43.5



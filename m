Return-Path: <linux-kernel+bounces-216930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7FD90A8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E04B2602E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09319067B;
	Mon, 17 Jun 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OcRA8St9"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8B171B0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613974; cv=none; b=K/guH2IgC/g/+yC/3F5XHmObtfFqeikszZp6bRu3ISb7pTHkcXx7556N+9ZMhwaA6BTkVyRSgaUBvbDEevaTxOHNBaUCLLU3qZbX+CtBMcLpqiZtreyJLVHBUITOzMGJjURiILG+fYJsCE3G9s8mLOG6uuKbc5ISELlAZ14vcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613974; c=relaxed/simple;
	bh=j8ppNxmC4fTY7RuZBWlTYXHhxmOMeTxYX6OQc6shWJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3pbV8SbSYZge63ijfhhqiGm1/ENZKWG8RCUmSW1qsuoalSD8ClgmRoswPImiCzqWDx1CBXnxy8lDRZJfP29S/aT/E44LXO04+7LM/6vWE3iw6csMN/NuCw5sc55/iHC6WdIETtEQEqJ/Aj6uwT6nerHGDNjROrkeGiH0Qxeg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OcRA8St9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45H8jGt21484406
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 17 Jun 2024 01:45:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45H8jGt21484406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1718613922;
	bh=TtDNCH2JQ5R+8SPYrvMZcbUwDGS6x0n/87jEWB8+7RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcRA8St9Gdx37CsUgiYY+pSegRKV/5C0plLP4MuT485H05d1ntzNgHflPG1NJOhTy
	 Kmf8F7zkQmx+HcY+RQP3iuL6VA/dXBiM/oKDdAVjASiHjH7GY8obF5hpu7Om9V75mj
	 /kI7UStnhujKuGtM18ZZJmzX48q09Vm7vgNipvAUPXT3uMkHeZsnsY5MAOgOae2lzt
	 GspkA3RlLPcbaBEIOeiX70nvYZAp/VbExcNyT9QbedUXwQKgbSb9eJoYHx5Qif7AgS
	 KPPPcmjLGPfvfMhNM6B42AplIxOeuU/5aliOzomYXjnrCzT55i85ZEu4rNbEtGqOMP
	 3Kq/mnNIlrTAg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v1 1/3] x86/fred: Allow variable-sized event frame
Date: Mon, 17 Jun 2024 01:45:13 -0700
Message-ID: <20240617084516.1484390-2-xin@zytor.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617084516.1484390-1-xin@zytor.com>
References: <20240617084516.1484390-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A FRED event frame could contain different amount of information for
different event types, or perhaps even for different instances of the
same event type. Thus the size of an event frame pushed by a FRED CPU
is not fixed and the address of the pt_regs structure that is used to
save a user level context of current task is not at a fixed offset
from top of current task kernel stack.

Add a new field named 'user_pt_regs' in the thread_info structure to
save the address of user level context pt_regs structure, thus to
eliminate the need of any advance information of event frame size
and allow a FRED CPU to push variable-sized event frame.

For IDT user level event delivery, a pt_regs structure is pushed by
hardware and software _always_ at a fixed offset from top of current
task kernel stack, so simply initialize user_pt_regs to point to the
pt_regs structure no matter whether one is pushed or not.

While for FRED user level event delivery, user_pt_regs is updated with
a pt_regs structure pointer generated in asm_fred_entrypoint_user().

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/entry/entry_fred.c        | 22 ++++++++++++++++++++++
 arch/x86/include/asm/processor.h   | 18 ++++++++++++------
 arch/x86/include/asm/thread_info.h |  9 ++++++---
 arch/x86/kernel/process.c          | 22 ++++++++++++++++++++++
 include/linux/thread_info.h        |  1 +
 kernel/fork.c                      |  6 ++++++
 6 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4dc74c2..1d54d451acb6 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -228,6 +228,28 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
 	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
 	regs->orig_ax = -1;
 
+	/*
+	 * A FRED event frame could contain different amount of information
+	 * for different event types, or perhaps even for different instances
+	 * of the same event type. Thus the size of an event frame pushed by
+	 * a FRED CPU is not fixed and the address of the pt_regs structure
+	 * that is used to save a user level context of current task is not
+	 * at a fixed offset from top of current task stack.
+	 *
+	 * Save the address of the pt_regs structure passed from and generated
+	 * in the caller function asm_fred_entrypoint_user() in thread_info so
+	 * that task_pt_regs() can be used to access the pt_regs structure
+	 * containing user level context after this point.
+	 *
+	 * What if another event happens before this point?
+	 *
+	 * Actually, another kernel event could happen earlier, even before the
+	 * pt_regs structure for saving user level context is completely saved.
+	 * It is guaranteed that the handler of the new event will NOT access
+	 * the pt_regs structure of the previous user level event.
+	 */
+	current->thread_info.user_pt_regs = regs;
+
 	switch (regs->fred_ss.type) {
 	case EVENT_TYPE_EXTINT:
 		return fred_extint(regs);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bd0621210f63..ea7733e7bf1d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -634,12 +634,18 @@ static __always_inline void prefetchw(const void *x)
 
 #define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1))
 
-#define task_pt_regs(task) \
-({									\
-	unsigned long __ptr = (unsigned long)task_stack_page(task);	\
-	__ptr += THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;		\
-	((struct pt_regs *)__ptr) - 1;					\
-})
+/*
+ * task_pt_regs() no longer converts a fixed offset from top of a task
+ * kernel stack to a pt_regs structure pointer, but rather returns
+ * whatever in the thread_info.user_pt_regs field, which contains the
+ * address of a pt_regs structure used to save a user level context of
+ * current task.
+ *
+ * Note, this can't be converted to an inline function as this header
+ * file defines 'struct thread_struct' which is used in the task_struct
+ * structure definition.
+ */
+#define task_pt_regs(task) ((task)->thread_info.user_pt_regs)
 
 #ifdef CONFIG_X86_32
 #define INIT_THREAD  {							  \
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 12da7dfd5ef1..326268d440cf 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -56,6 +56,7 @@
  */
 #ifndef __ASSEMBLY__
 struct task_struct;
+struct pt_regs;
 #include <asm/cpufeature.h>
 #include <linux/atomic.h>
 
@@ -66,11 +67,13 @@ struct thread_info {
 #ifdef CONFIG_SMP
 	u32			cpu;		/* current CPU */
 #endif
+	struct pt_regs		*user_pt_regs;
 };
 
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.flags		= 0,			\
+#define INIT_THREAD_INFO(tsk)						\
+{									\
+	.flags		= 0,						\
+	.user_pt_regs	= (struct pt_regs *)TOP_OF_INIT_STACK - 1,	\
 }
 
 #else /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 0c63035d8164..787a402e4ead 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -100,6 +100,28 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+/*
+ * Initialize thread_info.user_pt_regs for IDT event delivery.
+ *
+ * For IDT user level event delivery, a pt_regs structure is pushed by both
+ * hardware and software and always resides at a fixed offset from top of
+ * current task kernel stack, thus thread_info.user_pt_regs is a per-task
+ * constant and NEVER changes after initialization.
+ *
+ * While for FRED user level event delivery, user_pt_regs is updated in
+ * fred_entry_from_user() immediately after user level event delivery.
+ *
+ * Note: thread_info.user_pt_regs of the init task is initialized at build
+ * time.
+ */
+void arch_init_user_pt_regs(struct task_struct *tsk)
+{
+	unsigned long top_of_stack = (unsigned long)task_stack_page(tsk) + THREAD_SIZE;
+
+	top_of_stack -= TOP_OF_KERNEL_STACK_PADDING;
+	tsk->thread_info.user_pt_regs = (struct pt_regs *)top_of_stack - 1;
+}
+
 #ifdef CONFIG_X86_64
 void arch_release_task_struct(struct task_struct *tsk)
 {
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f4..5b2a75a19a07 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -260,6 +260,7 @@ void arch_task_cache_init(void); /* for CONFIG_SH */
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst,
 				struct task_struct *src);
+void arch_init_user_pt_regs(struct task_struct *tsk);
 
 #endif	/* __KERNEL__ */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..c4198599a7d4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1089,6 +1089,10 @@ int __weak arch_dup_task_struct(struct task_struct *dst,
 	return 0;
 }
 
+void __weak arch_init_user_pt_regs(struct task_struct *tsk)
+{
+}
+
 void set_task_stack_end_magic(struct task_struct *tsk)
 {
 	unsigned long *stackend;
@@ -1116,6 +1120,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_tsk;
 
+	arch_init_user_pt_regs(tsk);
+
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
-- 
2.45.1



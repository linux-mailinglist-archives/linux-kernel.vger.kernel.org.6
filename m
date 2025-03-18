Return-Path: <linux-kernel+bounces-565597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4CA66B78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C7118976B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4951EF367;
	Tue, 18 Mar 2025 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OWkCm5iY"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A371CAA76
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282422; cv=none; b=lsiHqeSMFtnX041rZMxMT0nZEf9poEuPTVP5UQTMs97iB728U+m00JwUZj9jncEcemn1zXAJx7r6YdcRqSkC6ihKQ7KwQGzh9X1SAMsa4atqzCNygyc9ATYLBpzGOalkMMJH/p/G5WjGL8TOXVXUPS7Z7i6KVsX16DlavcEPvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282422; c=relaxed/simple;
	bh=be2bvKOMCKS1jo/dC+qxUJHw7UhlXYsqQovZKKyr8BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNySh49S/Trb+EolO0ZxXaJ1zyMdAfHb/u5CzZUNrEvJddGlhPz6Sps1l15uD83zwACvIgwrZ3PmREu2iuIxlk3XhDdK8CfP6K6/1U3m7/3kj9f1A4oUerrCkXLoyPeiaR3fntSZBTksHHHgPJ77PFzggKj5Dhxha76pAqT48S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OWkCm5iY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52I7JmWV907380
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 18 Mar 2025 00:19:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52I7JmWV907380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742282396;
	bh=sb85uY7XIBcxdiaEv5PAqA2GWmDJIXnqyAKp40GA3D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWkCm5iYS9avos6J6ahHYO8oblnT4aES6cDdEwV1DGiIvfetnac5yNrBVgCjCqXjG
	 fRoibRnlqDJiYVL89Fj0Wrpe16hdkJP8fmUeBtW0XblgXRadEGzBiQKLSMghF1ZRoG
	 WVOpE4H0MQxHwCGAi6G+KywXzA3X5ad62T9bF6Anva4JDpwQEa8VKttpKTdMCCvLoy
	 yuy//LNa4t6ltKM9tjb8kQ/jicmhMrhyG9NWBzgdFo03dF2z1F37f/0qYuL+WPPR+r
	 Urm/3/e6lCNRizQKFO/FMWZhcE4uC6q6645uY6Vql3AY2dI1udjFrzgItmuZADhBwY
	 is4SJruCRVzrg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [RESEND PATCH v2 1/3] x86/fred: Allow variable-sized event frame
Date: Tue, 18 Mar 2025 00:19:45 -0700
Message-ID: <20250318071947.907364-2-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318071947.907364-1-xin@zytor.com>
References: <20250318071947.907364-1-xin@zytor.com>
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
 arch/x86/entry/entry_fred.c        | 10 ++++++++++
 arch/x86/include/asm/processor.h   | 12 ++++++------
 arch/x86/include/asm/thread_info.h |  9 ++++++---
 arch/x86/kernel/process.c          | 22 ++++++++++++++++++++++
 include/linux/thread_info.h        |  1 +
 kernel/fork.c                      |  6 ++++++
 6 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4dc74c2..a5f5bdd16ad8 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -228,6 +228,16 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
 	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
 	regs->orig_ax = -1;
 
+	/*
+	 * A FRED event frame could contain different amount of information
+	 * for different event types, or perhaps even for different instances
+	 * of the same event type. Thus the size of an event frame pushed by
+	 * a FRED CPU is not fixed and the address of the pt_regs structure
+	 * that is used to save a user level context of current task is not
+	 * at a fixed offset from top of current task stack.
+	 */
+	current->thread_info.user_pt_regs = regs;
+
 	switch (regs->fred_ss.type) {
 	case EVENT_TYPE_EXTINT:
 		return fred_extint(regs);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5aff26..7ff3443eb57d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -646,12 +646,12 @@ static __always_inline void prefetchw(const void *x)
 
 #define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1))
 
-#define task_pt_regs(task) \
-({									\
-	unsigned long __ptr = (unsigned long)task_stack_page(task);	\
-	__ptr += THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;		\
-	((struct pt_regs *)__ptr) - 1;					\
-})
+/*
+ * Note, this can't be converted to an inline function as this header
+ * file defines 'struct thread_struct' which is used in the task_struct
+ * structure definition.
+ */
+#define task_pt_regs(task) ((task)->thread_info.user_pt_regs)
 
 #ifdef CONFIG_X86_32
 #define INIT_THREAD  {							  \
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 9282465eea21..4372f171c65f 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -56,6 +56,7 @@
  */
 #ifndef __ASSEMBLER__
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
 
 #else /* !__ASSEMBLER__ */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 91f6ff618852..58c1cd4ca60a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -108,6 +108,28 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
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
index cf2446c9c30d..324667e0b8dd 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -273,6 +273,7 @@ void arch_task_cache_init(void); /* for CONFIG_SH */
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst,
 				struct task_struct *src);
+void arch_init_user_pt_regs(struct task_struct *tsk);
 
 #endif	/* __KERNEL__ */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 8695c345ca49..21af95645d84 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1105,6 +1105,10 @@ int __weak arch_dup_task_struct(struct task_struct *dst,
 	return 0;
 }
 
+void __weak arch_init_user_pt_regs(struct task_struct *tsk)
+{
+}
+
 void set_task_stack_end_magic(struct task_struct *tsk)
 {
 	unsigned long *stackend;
@@ -1132,6 +1136,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_tsk;
 
+	arch_init_user_pt_regs(tsk);
+
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
-- 
2.48.1



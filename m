Return-Path: <linux-kernel+bounces-570742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB805A6B416
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C816C3B149A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180891E3DED;
	Fri, 21 Mar 2025 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vlkFrIgN"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655812E7F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742535508; cv=none; b=mE3TeeJ81Gql2GhfyRdEuwgdGHBlNW6VIUJI4nYGDxLvGUJp/TEAPpnoPeKr86dJPYLeuJkH281R3D587WXYRfvG+kNEA7/cxzLViT40xZQOCttJ+3O/O/uEpQ4rzHHxY42fxvDiIxtzk0R+9+Gg+dO6140XlcG8ZvSP3d6Vlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742535508; c=relaxed/simple;
	bh=NC6QiepBs9K+Sok8y6Yh+YN7Hclo1o+gg9PZoRh7qxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soMFj7+n0j7BfcUgbgUkn3od1OzZg1KKB+Sh6zZOqo1iaVnJXqR1m7LRCHEr0P0eWpuCCgWEu+CCHbSRIKtYHAaEJfQE1U4Kln7hzooEeLd/FPr3GAIWwjXR0VltFA3cwuuV4VLqXoIRKOsm2+CFfO3t69btXIzATt3IRJrwZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=vlkFrIgN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52L5baLZ2479887
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 20 Mar 2025 22:37:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52L5baLZ2479887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742535459;
	bh=7Ui5I04vfxpOv5HtAhqzlCLJj97+ac7rGHmQk2Q9rQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vlkFrIgNs3CrKDehOpzP4SmNtyvkWL7kXJQk+SJ8BIIQpQ6LmVu0QOXlMNeEvv1KJ
	 myr57051a+RM6AY5gRAzbV58+fu8uimVwZ8IILgT/A+AlYmJc2iPDM/o7KVb6nKqVN
	 jHkDM+CU6EYjxcacU6JVztJKTEEGk7iyT+UbekmhBKu0OwcAnHC3SQnB9J+0sMG9h8
	 ZA3QSKovyfYnV8B5wf6eaTxiEygAgSqf1wckk/79AYH132kEOjFD6k0rrgkZaQXu/c
	 kcgyyz3tMAE4IqZVRjh+A/FUnKjCJT0198YVkMcymYJTXe1QwcPUIr7Bn0onYQ7TMu
	 B75vRh/e7+dpg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v3A 1/3] x86/fred: Allow variable-sized event frame
Date: Thu, 20 Mar 2025 22:37:35 -0700
Message-ID: <20250321053735.2479875-1-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319071009.1390984-2-xin@zytor.com>
References: <20250319071009.1390984-2-xin@zytor.com>
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

Change in v3A:
* Add declaration for __top_init_kernel_stack[] (Intel lkp).

Change in v3:
* Replace "(struct pt_regs *)TOP_OF_INIT_STACK - 1" with
  (struct pt_regs *)__top_init_kernel_stack (Brian Gerst).
---
 arch/x86/entry/entry_fred.c        | 10 ++++++++++
 arch/x86/include/asm/processor.h   | 12 ++++++------
 arch/x86/include/asm/thread_info.h | 11 ++++++++---
 arch/x86/kernel/process.c          | 22 ++++++++++++++++++++++
 include/linux/thread_info.h        |  1 +
 kernel/fork.c                      |  6 ++++++
 6 files changed, 53 insertions(+), 9 deletions(-)

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
index 9282465eea21..07c6a6a92c65 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -56,6 +56,7 @@
  */
 #ifndef __ASSEMBLER__
 struct task_struct;
+struct pt_regs;
 #include <asm/cpufeature.h>
 #include <linux/atomic.h>
 
@@ -66,11 +67,15 @@ struct thread_info {
 #ifdef CONFIG_SMP
 	u32			cpu;		/* current CPU */
 #endif
+	struct pt_regs		*user_pt_regs;
 };
 
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.flags		= 0,			\
+extern unsigned long __top_init_kernel_stack[];
+
+#define INIT_THREAD_INFO(tsk)						\
+{									\
+	.flags		= 0,						\
+	.user_pt_regs	= (struct pt_regs *)__top_init_kernel_stack,	\
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
index e27fe5d5a15c..2b0367368afb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1101,6 +1101,10 @@ int __weak arch_dup_task_struct(struct task_struct *dst,
 	return 0;
 }
 
+void __weak arch_init_user_pt_regs(struct task_struct *tsk)
+{
+}
+
 void set_task_stack_end_magic(struct task_struct *tsk)
 {
 	unsigned long *stackend;
@@ -1128,6 +1132,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_tsk;
 
+	arch_init_user_pt_regs(tsk);
+
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
-- 
2.48.1



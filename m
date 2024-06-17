Return-Path: <linux-kernel+bounces-216929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4CF90A8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E97B21771
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F719066E;
	Mon, 17 Jun 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="q9F0VIjf"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCC5336A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613974; cv=none; b=lg9ieczWnOmLbDMGuCpB6gH8CzXl0b3SP9D+dDob4YKqzJ1Tovr/o5rL9TvMEw3W8vjg9bcvc84+1InjKs4tJ+IpfE06lFm+dGoltn6/17WVQoqxGqxU/JbXL+vThCIrzN5iaOu8L0s39CATubOfQtrhb41e+B2iGPpzmsrCRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613974; c=relaxed/simple;
	bh=Bq7/0qa7R8/HJvVA9joTBDPoHjCRFLDPoUwUWy0pxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoP+znlh0c+/fk7FU2WMPbGDbF2t7wE7Q33wAA/x59XIlqpgaZCTMJhbAm+hbFf5Ax/9P6eJCsSl+MY6Wgnm8E3WCu6kuOPqdQANeELgi9sTabOOAVjzEqLWZ7AuKjufc8/wCa7u/7Tfb7nX+kVVV4/vH4dtNg6aGF5vQ9raYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=q9F0VIjf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45H8jGt41484406
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 17 Jun 2024 01:45:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45H8jGt41484406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1718613923;
	bh=qFqPyA+WpBJtrQjQTK7/FKSQCXP4sJIk7KZPCCFOrmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9F0VIjfaodugVbHzMYnwV5Phc+D5gNSrIvWNP6JPQMlI06InAr5ruZWm+6bmDSTY
	 yunkv9fASMIKAU97OkAUWImt/VrBMpIQO6/j8jd/ZI+BJv+Q53tYKCTl/rk+kYulki
	 J5VVt4nB0SzWsJlbdL6x9xAvyuP7LA4KKQ9/hC2zZwjykiV0rdiTQ3Cs+jyehZH15n
	 epRb5e59JlpWyfWJ5VB21C1uAelS5bpufMg/t0hxyA5NSWi0a8XNeO+BYwUIrQuCGh
	 VrUHlmUkISSIk3SNRmhb3EKjRnzp5ICro6snWjTB9Vc6epFCIfUE4lNv9z1hc4oQWb
	 ckg33WmbG8HyA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v1 3/3] x86: Get rid of TOP_OF_KERNEL_STACK_PADDING on x86_64
Date: Mon, 17 Jun 2024 01:45:15 -0700
Message-ID: <20240617084516.1484390-4-xin@zytor.com>
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

Because task_pt_regs() is now just an alias of thread_info.user_pt_regs,
and no matter whether FRED is enabled or not a user level event frame on
x86_64 is always pushed from top of current task kernel stack, i.e.,
'(unsigned long)task_stack_page(task) + THREAD_SIZE', there is no meaning
to keep TOP_OF_KERNEL_STACK_PADDING on x86_64, thus remove it.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/processor.h   |  6 ++++--
 arch/x86/include/asm/switch_to.h   |  2 +-
 arch/x86/include/asm/thread_info.h | 10 ----------
 arch/x86/kernel/process.c          |  3 +--
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 91803844c4d7..9c5294f6d923 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -644,8 +644,6 @@ extern unsigned long __end_init_stack[];
  */
 #define TOP_OF_INIT_STACK ((unsigned long)&__end_init_stack)
 
-#define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1))
-
 /*
  * task_pt_regs() no longer converts a fixed offset from top of a task
  * kernel stack to a pt_regs structure pointer, but rather returns
@@ -660,6 +658,9 @@ extern unsigned long __end_init_stack[];
 #define task_pt_regs(task) ((task)->thread_info.user_pt_regs)
 
 #ifdef CONFIG_X86_32
+#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + THREAD_SIZE	\
+				 - TOP_OF_KERNEL_STACK_PADDING)
+
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
 	.sysenter_cs		= __KERNEL_CS,				  \
@@ -669,6 +670,7 @@ extern unsigned long __end_init_stack[];
 
 #else
 extern unsigned long __top_init_kernel_stack[];
+#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + THREAD_SIZE)
 
 #define INIT_THREAD {							\
 	.sp	= (unsigned long)&__top_init_kernel_stack,		\
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index c3bd0c0758c9..902f1612ef3f 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -72,7 +72,7 @@ static inline void update_task_stack(struct task_struct *task)
 #else
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
 		/* WRMSRNS is a baseline feature for FRED. */
-		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
+		wrmsrns(MSR_IA32_FRED_RSP0, task_top_of_stack(task));
 	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 326268d440cf..331a6f32a0be 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -30,10 +30,6 @@
  *
  * In vm86 mode, the hardware frame is much longer still, so add 16
  * bytes to make room for the real-mode segments.
- *
- * x86-64 has a fixed-length stack frame, but it depends on whether
- * or not FRED is enabled. Future versions of FRED might make this
- * dynamic, but for now it is always 2 words longer.
  */
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_VM86
@@ -41,12 +37,6 @@
 # else
 #  define TOP_OF_KERNEL_STACK_PADDING 8
 # endif
-#else /* x86-64 */
-# ifdef CONFIG_X86_FRED
-#  define TOP_OF_KERNEL_STACK_PADDING (2 * 8)
-# else
-#  define TOP_OF_KERNEL_STACK_PADDING 0
-# endif
 #endif
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 787a402e4ead..99f9887f710e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -116,9 +116,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
  */
 void arch_init_user_pt_regs(struct task_struct *tsk)
 {
-	unsigned long top_of_stack = (unsigned long)task_stack_page(tsk) + THREAD_SIZE;
+	unsigned long top_of_stack = task_top_of_stack(tsk);
 
-	top_of_stack -= TOP_OF_KERNEL_STACK_PADDING;
 	tsk->thread_info.user_pt_regs = (struct pt_regs *)top_of_stack - 1;
 }
 
-- 
2.45.1



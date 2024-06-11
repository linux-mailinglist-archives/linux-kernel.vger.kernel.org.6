Return-Path: <linux-kernel+bounces-210591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634E9045F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B360B287A42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67656153836;
	Tue, 11 Jun 2024 20:46:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14484A21
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138772; cv=none; b=ZB3LhkhB5kU4eI0uiEWj82UNnVOnomupbbl8dTv3PL+mIK6ddnFvairECO8NvU0ERh6Xs2x60w45hcVziMo3XX1J0t3EmVqtUDrxD41LreZY+lhpahjpcsDbrzDQm40GHxVUzubsJOotbqIcDLZiwX2HhO37Ak45TC/7PFLvAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138772; c=relaxed/simple;
	bh=NLn3FypQGVT0OqUHI0W5V8u523q/O3WxpepNIZOFktE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oK4Fu70PjePYhiuWE1PBas6HD23cQztUvCE+ONt2UUpVvtt4vjQfskA4z9kTflqQQruKHAZ3qRCHfkMwrZSicW9iq0UlN1mXBhInus9nrrh4+3izqEH0dUcYOEpjU3QlUnG6EaGeIlAqD5rDyWgnzLCcL39PEePZdmPM/P97DBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9E9C4AF52;
	Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH8Nw-00000001V3d-3zE0;
	Tue, 11 Jun 2024 16:46:28 -0400
Message-ID: <20240611204628.808810560@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 16:45:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: [for-next][PATCH 3/4] function_graph: Everyone uses HAVE_FUNCTION_GRAPH_RET_ADDR_PTR,
 remove it
References: <20240611204554.092271761@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

All architectures that implement function graph also implements
HAVE_FUNCTION_GRAPH_RET_ADDR_PTR. Remove it, as it is no longer a
differentiator.

Link: https://lore.kernel.org/linux-trace-kernel/20240611031737.982047614@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace-design.rst | 12 ---------
 arch/arm64/include/asm/ftrace.h       | 11 ---------
 arch/csky/include/asm/ftrace.h        |  2 --
 arch/loongarch/include/asm/ftrace.h   |  1 -
 arch/powerpc/include/asm/ftrace.h     |  2 --
 arch/riscv/include/asm/ftrace.h       |  1 -
 arch/s390/include/asm/ftrace.h        |  1 -
 arch/x86/include/asm/ftrace.h         |  2 --
 include/linux/ftrace.h                |  2 --
 kernel/trace/fgraph.c                 | 35 +--------------------------
 10 files changed, 1 insertion(+), 68 deletions(-)

diff --git a/Documentation/trace/ftrace-design.rst b/Documentation/trace/ftrace-design.rst
index 6893399157f0..dc82d64b3a44 100644
--- a/Documentation/trace/ftrace-design.rst
+++ b/Documentation/trace/ftrace-design.rst
@@ -217,18 +217,6 @@ along to ftrace_push_return_trace() instead of a stub value of 0.
 
 Similarly, when you call ftrace_return_to_handler(), pass it the frame pointer.
 
-HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
---------------------------------
-
-An arch may pass in a pointer to the return address on the stack.  This
-prevents potential stack unwinding issues where the unwinder gets out of
-sync with ret_stack and the wrong addresses are reported by
-ftrace_graph_ret_addr().
-
-Adding support for it is easy: just define the macro in asm/ftrace.h and
-pass the return address pointer as the 'retp' argument to
-ftrace_push_return_trace().
-
 HAVE_SYSCALL_TRACEPOINTS
 ------------------------
 
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index ab158196480c..dc9cf0bd2a4c 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -12,17 +12,6 @@
 
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 
-/*
- * HAVE_FUNCTION_GRAPH_RET_ADDR_PTR means that the architecture can provide a
- * "return address pointer" which can be used to uniquely identify a return
- * address which has been overwritten.
- *
- * On arm64 we use the address of the caller's frame record, which remains the
- * same for the lifetime of the instrumented function, unlike the return
- * address in the LR.
- */
-#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #else
diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
index fd215c38ef27..00f9f7647e3f 100644
--- a/arch/csky/include/asm/ftrace.h
+++ b/arch/csky/include/asm/ftrace.h
@@ -7,8 +7,6 @@
 
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 
-#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 
 #define MCOUNT_ADDR	((unsigned long)_mcount)
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index de891c2c83d4..c0a682808e07 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -28,7 +28,6 @@ struct dyn_ftrace;
 struct dyn_arch_ftrace { };
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
-#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #define ftrace_init_nop ftrace_init_nop
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 107fc5a48456..559560286e6d 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -8,8 +8,6 @@
 #define MCOUNT_ADDR		((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
 
-#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-
 /* Ignore unused weak functions which will have larger offsets */
 #if defined(CONFIG_MPROFILE_KERNEL) || defined(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY)
 #define FTRACE_MCOUNT_MAX_OFFSET	16
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 9eb31a7ea0aa..2cddd79ff21b 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -11,7 +11,6 @@
 #if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_FRAME_POINTER)
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 #endif
-#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 77e479d44f1e..fbadca645af7 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_S390_FTRACE_H
 #define _ASM_S390_FTRACE_H
 
-#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #define MCOUNT_INSN_SIZE	6
 
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 897cf02c20b1..0152a81d9b4a 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -20,8 +20,6 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #endif
 
-#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-
 #ifndef __ASSEMBLY__
 extern void __fentry__(void);
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 4135dc171447..845c2ab0bc1c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1071,9 +1071,7 @@ struct ftrace_ret_stack {
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	unsigned long fp;
 #endif
-#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	unsigned long *retp;
-#endif
 };
 
 /*
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 91f1eef256af..8317d1a7f43a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -593,9 +593,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	ret_stack->fp = frame_pointer;
 #endif
-#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	ret_stack->retp = retp;
-#endif
 	return offset;
 }
 
@@ -887,10 +885,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
  * will be assigned that location so that if called again, it will continue
  * where it left off.
  *
- * @retp is a pointer to the return address on the stack.  It's ignored if
- * the arch doesn't have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR defined.
+ * @retp is a pointer to the return address on the stack.
  */
-#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
@@ -926,35 +922,6 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 	return ret;
 }
-#else /* !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
-unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
-				    unsigned long ret, unsigned long *retp)
-{
-	struct ftrace_ret_stack *ret_stack;
-	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
-	int offset = task->curr_ret_stack;
-	int i;
-
-	if (ret != return_handler)
-		return ret;
-
-	if (!idx)
-		return ret;
-
-	i = *idx;
-	do {
-		ret_stack = get_ret_stack(task, offset, &offset);
-		if (ret_stack && ret_stack->ret == return_handler)
-			continue;
-		i--;
-	} while (i >= 0 && ret_stack);
-
-	if (ret_stack)
-		return ret_stack->ret;
-
-	return ret;
-}
-#endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
 static struct ftrace_ops graph_ops = {
 	.func			= ftrace_graph_func,
-- 
2.43.0




Return-Path: <linux-kernel+bounces-530970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC13A43A86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EBE3A97E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2DC2690F1;
	Tue, 25 Feb 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYMA07ox"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469B2698A2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477336; cv=none; b=G08ccdpx7H5wEC1PmHl4r6k6H4sLnHfri+dseG0opIw014AmMpste6Vj4y/ddpGptAh+tmVy/CFF3uRtpmcVUQSszpxHsau7aR7U7gnJPkEzTWbql6nnV0NmBEOrqo1JH8n4UX7oqpnZ4Hu+53GSZ0PRtKC9cu+2P3/U+v7wJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477336; c=relaxed/simple;
	bh=6INxnIe+xrzxI+Vwg3aF3lDkhPHGsChWklsSxcPftSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+X8vYbr5gJwrcJyQSdLiL1UV8svWJfyABVHPSGuF7S26ggv89UvNN7Z/rlxRvssKjJsmYaWcRmt77UVsqUJZ8dPTWz2SoES7WvcLM8DIms/EpssNbVE7ry2fo4zj8erG8sRcEGgBq63z6FnQPntwAmWKPbmnmNcuxo+b0ez+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYMA07ox; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54838cd334cso4363980e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477332; x=1741082132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3uDcPAUn17u5guwAmKffFv3WeYri61KKtnRD7KLFFU=;
        b=QYMA07ox9HD2WsqVn1/fAuShNj91xxKYAKFs0r58o5raxwkHvfNBrD5sYdqUrGlgor
         d/TBexmH0RYhEYyNGMe0ftPu9bK3IlHGURAA0YHOVwrweMI7UzKSDbTTegIeaZ1pih4i
         7F1RfsBKKdUXvTzyxWVySB0N+SgSqgitGUVFmYXqEyOjVhCX+OCPPM7pV7AoOS4ZFcIq
         Ph1XiS/BSrCMiHu8G35QuR0pm6gJYs13AVcEqr9TKQYr/PHXq0ifECfd0HBlvF/oIjrf
         9xN/09BcR0tYLu6GRLlfrtmW1Ubvn67m5hHOlSZoTFDnBetTgaFlJWMMHLI/4brlpsvL
         hxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477332; x=1741082132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3uDcPAUn17u5guwAmKffFv3WeYri61KKtnRD7KLFFU=;
        b=gZBdGee2fmP69Z4aPJKQkXJzU1QL/Yy1f9Ckmh53dy/5Jng2PgAdQ8a/4zx9DV6AXt
         vHEKrE35+sYxqS/a0AQkXpWdA/wl22K6AuIawNhEcMVfoLVVwJ5fFjvDHbdERHuPxje8
         8+BPqFHxx7RBCfxwO7sOu/Z34R9wMmad+qvygFYSy+HR/eAV5eSuehoLNmpMjKUo1A53
         GOd0AhrXCuo0G6ItIw6BuIXk786JbpBWt5xkboCKzU8v52iEfK78X8rpwSTtnCLyclqT
         NFPFQnEAL+KTqW30M6hwhIgvypDZYOZEDCEMTkRwztN6h2cubgUr7k+Paf0qBLZaCWl8
         zgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJuIlMY6If5X0vbs0MTSHWcxv8XH6CPiKFLTavXPcTFP99A44sWf2x9dXn6GaazEsQNLkJrTWd49mnXls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZB5ucS04dzY18biI6+T1gTGfP4BAzH21ZAeurlCxMeOY0eyo
	R9OHj47rWy8288apXzYEz5g4/xW0dUrcgjwY22ia/zmcTM0L1qNXaJ7/bW/LyA4=
X-Gm-Gg: ASbGncuRXIbxv5510fZgI6vUTFI8AW0GJX0JTRJT3L0X56VjXBcJAH129mM3p7djj3M
	uT9flILya1Jjx4zzRT2QWAjzo1eBrH3E8/gRF28XQ26xVVFMXPNNzvZ6PTNLYQGuS5LYEny/fAm
	m9Go5FfvSKfoz7pk2+cGXeFjOpm/eA3xMt7xGs20TXzZTkeFI7fSJsZgnbvl1vVhWWX5xmErZoO
	Q2nm/EURkCD9sD0e4JEgTihFUy84SPQFWavh8xVnUU53R8ilFcwWu+jq+MliIpaNvN2NAfJGx4R
	MhIbB6OqWVzRQ7I7o5jTiTsCZZY81D44OFXW
X-Google-Smtp-Source: AGHT+IGZSyqBfVWqqe5J4Zp72BCqTmEE8EDYl5esUBqbgbQwzfkt9iMaTDDcYx6uNEGX+3vdzFMHVg==
X-Received: by 2002:a05:6512:1152:b0:545:271d:f85 with SMTP id 2adb3069b0e04-54838ef8816mr5740468e87.29.1740477331850;
        Tue, 25 Feb 2025 01:55:31 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:31 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:15 +0100
Subject: [PATCH v5 28/31] ARM: entry: Convert to generic entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-28-2f02313653e5@linaro.org>
References: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
In-Reply-To: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

This rewrites ARM to use the generic entry.

All of the irqentry_* callbacks are collapsed and made to
call into the generic entry code that handle the interrupts
storing regs context before entry and restoring it after.

The syscall_enter_from_user_mode(), syscall_exit_to_user_mode(),
do_work_pending() constructs are replaced with generic code.

The syscall invocation now enables syscall tracing "work" using
the generic callbacks and no extra actions are needed to
enable/disable syscall tracing.

The old context tracking with user_exit_callable()
user_enter_callable() is no longer used. Only CSKY and Xtensa
use this deprecated mechanism now.

handle_fiq_as_nmi() is retired as the generic entry provides
the same functionality in irqentry_nmi_enter() and
irqentry_nmi_exit().

Like with the ARM64 proposed patch for generic entry, it is
necessary to create a small call "arm_exit_to_user_mode()"
that is used for things such as ret_from_fork, i.e. when
we create a completely new execution context with a botched
return from interrupt.

The elaborate checking and switching to IRQ stack in
the irq_handler macro was reimplemented in C for this
exercise: this was easiest and there was already code
making use of the IRQ stack from C for soft interrupts.

I have dropped the context tracking (i.e. calling
irqentry_enter() and looking for trace conditions) on
dabt/pabt i.e. do_DataAbort and do_PrefetchAbort code paths.
These are addressed in a separate patch for development/review
reasons.

I added stubs for PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
returning -EIO like the UM arch does, since those syscalls
are required by generic entry. If someone wants to implement
them, the placeholders are there.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                    |  1 +
 arch/arm/include/asm/entry-common.h | 66 ++++++++++++++++++++++++++
 arch/arm/include/asm/entry.h        | 13 ++---
 arch/arm/include/asm/ptrace.h       |  3 --
 arch/arm/include/asm/signal.h       |  2 -
 arch/arm/include/asm/syscall.h      |  7 ++-
 arch/arm/include/asm/thread_info.h  | 17 +------
 arch/arm/include/asm/traps.h        |  1 -
 arch/arm/include/uapi/asm/ptrace.h  |  2 +
 arch/arm/kernel/entry-armv.S        | 50 ++++---------------
 arch/arm/kernel/entry-common.S      | 34 +++----------
 arch/arm/kernel/entry-header.S      | 18 -------
 arch/arm/kernel/entry.c             | 94 ++++++++++++++++++------------------
 arch/arm/kernel/process.c           |  5 +-
 arch/arm/kernel/ptrace.c            | 95 ++-----------------------------------
 arch/arm/kernel/signal.c            | 31 +-----------
 arch/arm/kernel/syscall.c           | 30 ++++--------
 arch/arm/kernel/traps.c             | 25 ----------
 18 files changed, 161 insertions(+), 333 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 835b5f100e926e54bab4be7802aeada4af37a145..564575f52cf7ec8296938944fa5296a4acc2a598 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -69,6 +69,7 @@ config ARM
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ENTRY
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm/include/asm/entry-common.h b/arch/arm/include/asm/entry-common.h
new file mode 100644
index 0000000000000000000000000000000000000000..7b1f108512db0001a65911af0df4f48197d99e75
--- /dev/null
+++ b/arch/arm/include/asm/entry-common.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_ARM_ENTRY_COMMON_H
+#define _ASM_ARM_ENTRY_COMMON_H
+
+#include <linux/thread_info.h>
+
+#include <asm/stacktrace.h>
+
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
+static inline unsigned long
+arch_prepare_report_syscall_entry(struct pt_regs *regs)
+{
+	unsigned long ip;
+
+	/*
+	 * IP is used to denote syscall entry/exit:
+	 * IP = 0 -> entry
+	 */
+	ip = regs->ARM_ip;
+	regs->ARM_ip = PTRACE_SYSCALL_ENTER;
+
+	return ip;
+}
+#define arch_prepare_report_syscall_entry arch_prepare_report_syscall_entry
+
+static inline void
+arch_post_report_syscall_entry(struct pt_regs *regs,
+			       unsigned long saved_reg, long ret)
+{
+	regs->ARM_ip = saved_reg;
+}
+#define arch_post_report_syscall_entry arch_post_report_syscall_entry
+
+
+static inline unsigned long
+arch_prepare_report_syscall_exit(struct pt_regs *regs,
+				 unsigned long work)
+{
+	unsigned long ip;
+
+	/*
+	 * IP is used to denote syscall entry/exit:
+	 * IP = 1 -> exit
+	 */
+	ip = regs->ARM_ip;
+	regs->ARM_ip = PTRACE_SYSCALL_EXIT;
+
+	return ip;
+}
+#define arch_prepare_report_syscall_exit arch_prepare_report_syscall_exit
+
+static inline void
+arch_post_report_syscall_exit(struct pt_regs *regs,
+			      unsigned long saved_reg,
+			      unsigned long work)
+{
+	regs->ARM_ip = saved_reg;
+}
+#define arch_post_report_syscall_exit arch_post_report_syscall_exit
+
+#endif /* _ASM_ARM_ENTRY_COMMON_H */
diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index a78bc5054b093120e903f08369fb8b1a9feb7f81..df2dd14ab51a586b83b6da6bbf9bd99858c1ddf4 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -4,15 +4,8 @@
 
 struct pt_regs;
 
-/*
- * These are copies of generic entry headers so we can transition
- * to generic entry once they are semantically equivalent.
- */
-long syscall_enter_from_user_mode(struct pt_regs *regs, long);
-void syscall_exit_to_user_mode(struct pt_regs *regs);
-void irqentry_enter_from_user_mode(struct pt_regs *regs);
-void irqentry_exit_to_user_mode(struct pt_regs *regs);
-void irqentry_enter_from_kernel_mode(struct pt_regs *regs);
-void irqentry_exit_to_kernel_mode(struct pt_regs *regs);
+void arm_irq_handler(struct pt_regs *regs, int mode);
+void arm_fiq_handler(struct pt_regs *regs);
+void arm_exit_to_user_mode(struct pt_regs *regs);
 
 #endif /* __ASM_ENTRY_H__ */
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index a01c66f0ad907882af2a383e53de8aca68c551e5..8a7de4020cbc016f743dcf515b9fa83b9bd3e3f0 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -200,8 +200,5 @@ static inline unsigned long it_advance(unsigned long cpsr)
 	return cpsr;
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
-void syscall_trace_exit(struct pt_regs *regs);
-
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm/include/asm/signal.h b/arch/arm/include/asm/signal.h
index bb753cd3e29fc54186543c48b2aee7b221301a37..45885383646c9f166b0d7ee80080b78776b515e7 100644
--- a/arch/arm/include/asm/signal.h
+++ b/arch/arm/include/asm/signal.h
@@ -23,6 +23,4 @@ typedef struct {
 
 #include <asm/sigcontext.h>
 
-void do_work_pending(struct pt_regs *regs, unsigned int thread_flags);
-
 #endif
diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index b94fd7ce17f82f0baf06b74800245112e1f13002..a6c8f0e799bb8bf3833161dec70fc7a1aaa513f6 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -19,7 +19,12 @@
 
 extern const unsigned long sys_call_table[];
 
-int invoke_syscall(void *table, struct pt_regs *regs, int scno);
+void invoke_syscall(void *table, struct pt_regs *regs, int scno);
+
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index d8a45c5a10496aaf806bfeaa0353d5e8985bd6f5..84e58a9cdab63ad264c2cd2bad64239d1912cbe7 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -74,6 +74,7 @@ struct thread_info {
 #ifdef CONFIG_ARM_THUMBEE
 	unsigned long		thumbee_state;	/* ThumbEE Handler Base register */
 #endif
+	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 };
 
 #define INIT_THREAD_INFO(tsk)						\
@@ -149,30 +150,14 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	19
-#define TIF_SYSCALL_TRACE	20	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	21	/* syscall auditing active */
-#define TIF_SYSCALL_TRACEPOINT	22	/* syscall tracepoint instrumentation */
-#define TIF_SECCOMP		23	/* seccomp syscall filtering active */
-
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 
-/* Checks for any syscall work in entry-common.S */
-#define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-			   _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
-
-/*
- * Change these and you break ASM code in entry-common.S
- */
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_NOTIFY_SIGNAL)
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index b888912c2450e0e8eec8139166c7292f283545c7..f8695104c72f2f450092839c7c50920e540e594b 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -38,7 +38,6 @@ extern void *vectors_page;
 
 asmlinkage void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl);
 asmlinkage void do_undefinstr(struct pt_regs *regs);
-asmlinkage void handle_fiq_as_nmi(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason);
 int arm_syscall(int no, struct pt_regs *regs);
 asmlinkage void baddataabort(int code, unsigned long instr, struct pt_regs *regs);
diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 8896c23ccba78ed7e10c7d1b9955124314496dc6..336a5beb282f360e875703045ee833974bbd68b2 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -33,6 +33,8 @@
 #define PTRACE_GETHBPREGS	29
 #define PTRACE_SETHBPREGS	30
 #define PTRACE_GETFDPIC		31
+#define PTRACE_SYSEMU		32
+#define PTRACE_SYSEMU_SINGLESTEP 33
 
 #define PTRACE_GETFDPIC_EXEC	0
 #define PTRACE_GETFDPIC_INTERP	1
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 2a789c8834b93475c32dcb6ba5854e24ddd8d6e9..498a22f5fa8a6516d1eab584f0523c3d6c6e4926 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -36,35 +36,6 @@
 #define RELOC_TEXT_NONE
 #endif
 
-/*
- * Interrupt handling.
- */
-	.macro	irq_handler, from_user:req
-	mov	r1, sp
-	ldr_this_cpu r2, irq_stack_ptr, r2, r3
-	.if	\from_user == 0
-	@
-	@ If we took the interrupt while running in the kernel, we may already
-	@ be using the IRQ stack, so revert to the original value in that case.
-	@
-	subs	r3, r2, r1		@ SP above bottom of IRQ stack?
-	rsbscs	r3, r3, #THREAD_SIZE	@ ... and below the top?
-#ifdef CONFIG_VMAP_STACK
-	ldr_va	r3, high_memory, cc	@ End of the linear region
-	cmpcc	r3, r1			@ Stack pointer was below it?
-#endif
-	bcc	0f			@ If not, switch to the IRQ stack
-	mov	r0, r1
-	bl	generic_handle_arch_irq
-	b	1f
-0:
-	.endif
-
-	mov_l	r0, generic_handle_arch_irq
-	bl	call_with_stack
-1:
-	.endm
-
 	.macro	pabt_helper
 	@ PABORT handler takes pt_regs in r2, fault address in r4 and psr in r5
 #ifdef MULTI_PABORT
@@ -205,9 +176,6 @@ ENDPROC(__und_invalid)
 	get_thread_info tsk
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
-	mov	r0, sp				@ 'regs'
-	bl	irqentry_enter_from_kernel_mode
-
 	.endm
 
 	.align	5
@@ -223,7 +191,9 @@ ENDPROC(__dabt_svc)
 	.align	5
 __irq_svc:
 	svc_entry
-	irq_handler from_user=0
+	mov	r0, sp				@ regs
+	mov	r1, #0				@ from kernel mode
+	bl	arm_irq_handler
 
 #ifdef CONFIG_PREEMPTION
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
@@ -300,7 +270,7 @@ ENDPROC(__pabt_svc)
 __fiq_svc:
 	svc_entry
 	mov	r0, sp				@ struct pt_regs *regs
-	bl	handle_fiq_as_nmi
+	bl	arm_fiq_handler
 	svc_exit_via_fiq
  UNWIND(.fnend		)
 ENDPROC(__fiq_svc)
@@ -329,7 +299,7 @@ __fiq_abt:
 	stmfd	sp!, {r1 - r2}
 
 	add	r0, sp, #8			@ struct pt_regs *regs
-	bl	handle_fiq_as_nmi
+	bl	arm_fiq_handler
 
 	ldmfd	sp!, {r1 - r2}
  ARM(	msr	cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
@@ -420,7 +390,6 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
-	asm_irqentry_enter_from_user_mode
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -431,9 +400,10 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-	asm_irqentry_enter_from_user_mode
 	kuser_cmpxchg_check
-	irq_handler from_user=1
+	mov	r0, sp				@ regs
+	mov	r1, #1				@ from user mode
+	bl	arm_irq_handler
 	get_thread_info tsk
 	mov	why, #0
 	b	ret_to_user_from_irq
@@ -445,7 +415,6 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
-	asm_irqentry_enter_from_user_mode
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -470,7 +439,6 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
-	asm_irqentry_enter_from_user_mode
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
@@ -493,7 +461,7 @@ __fiq_usr:
 	usr_entry
 	kuser_cmpxchg_check
 	mov	r0, sp				@ struct pt_regs *regs
-	bl	handle_fiq_as_nmi
+	bl	arm_fiq_handler
 	get_thread_info tsk
 	restore_user_regs
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 6b0f86786a7d9e656ecbe8c741f2edbcbafd2915..a5a0e757ab23d151485092a078af98966e039869 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -39,10 +39,6 @@ ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	add	sp, sp, #(S_R0 + S_OFF)
-	/* do_rseq_syscall needs interrupts enabled. */
-	mov	r0, sp				@ 'regs'
-	bl	syscall_exit_to_user_mode
-
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
 #endif
@@ -60,7 +56,7 @@ ENTRY(ret_to_user)
 	/* do_rseq_syscall needs interrupts enabled. */
 	enable_irq_notrace			@ enable interrupts
 	mov	r0, sp				@ 'regs'
-	bl	syscall_exit_to_user_mode
+	bl	arm_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
@@ -69,8 +65,6 @@ ENTRY(ret_to_user)
 ENDPROC(ret_to_user)
 
 ENTRY(ret_to_user_from_irq)
-	asm_irqentry_exit_to_user_mode
-
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
 #endif
@@ -92,9 +86,10 @@ SYM_TYPED_FUNC_START(ret_from_fork_asm)
 	mov	r2, r5
 	mov	r3, r4
 	bl	ret_from_fork
-	mov	r0, #0
-1:	get_thread_info tsk
-	b	ret_to_user
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
+	restore_user_regs
 SYM_FUNC_END(ret_from_fork_asm)
 
 /*=============================================================================
@@ -210,29 +205,12 @@ ENTRY(vector_swi)
 #else
 	str	scno, [tsk, #TI_ABI_SYSCALL]
 #endif
-
-	/*
-	 * Calling out to C to be careful to save and restore registers.
-	 * This call could modify the syscall number. scno is r7 so we
-	 * do not save and restore r7.
-	 */
-	mov	r0, sp				@ regs
-	mov	r1, scno
-	push	{r4 - r6, r8 - r10, lr}
-	bl	syscall_enter_from_user_mode
-	pop	{r4 - r6, r8 - r10, lr}
-	mov	scno, r0
-
 	mov	r1, sp				@ put regs into r1
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 	mov	r0, tbl
 	mov	r2, scno			@ syscall number from r7
 	bl	invoke_syscall
-	cmp	r0, #0
-	beq	ret_fast_syscall
-	/* This path taken when tracing */
-	add	sp, sp, #(S_R0 + S_OFF)
-	b	ret_to_user
+	b	ret_fast_syscall
 
 #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
 	/*
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index cfaf14d71378ba14bbb2a42cd36d48a23838eee1..abd927f1cc3a4d813cc48bc046191f49f3c0e533 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -203,10 +203,6 @@
 
 	@ IRQs off again before pulling preserved data off the stack
 	disable_irq_notrace
-
-	mov	r0, sp				@ 'regs'
-	bl	irqentry_exit_to_kernel_mode
-
 	uaccess_exit tsk, r0, r1
 
 #ifndef CONFIG_THUMB2_KERNEL
@@ -340,20 +336,6 @@ ALT_UP_B(.L1_\@)
 #endif	/* !CONFIG_THUMB2_KERNEL */
 	.endm
 
-/*
- * Context tracking and other mode transitions. Used to instrument transitions
- * between user and kernel mode.
-*/
-	.macro asm_irqentry_enter_from_user_mode
-	mov	r0, sp				@ regs
-	bl	irqentry_enter_from_user_mode
-	.endm
-
-	.macro asm_irqentry_exit_to_user_mode
-	mov	r0, sp				@ regs
-	bl	irqentry_exit_to_user_mode
-	.endm
-
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - r0 to r6.
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 1e1284cc4caed6e602ce36e812d535e6fe324f34..08b8680233e5aae6e477f9bf15d7f06d7fd3e5af 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -1,71 +1,71 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/entry.h>
-#include <asm/ptrace.h>
-#include <asm/signal.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
+#include <linux/hardirq.h>
+#include <linux/irq.h>
 #include <linux/irqflags.h>
+#include <linux/percpu.h>
 #include <linux/rseq.h>
+#include <asm/stacktrace.h>
 
-long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
-{
-	trace_hardirqs_on();
-	local_irq_enable();
-	/* This context tracking call has inverse naming */
-	user_exit_callable();
-
-	/* This will optionally be modified later */
-	return syscall;
-}
+#include "irq.h"
 
-void syscall_exit_to_user_mode(struct pt_regs *regs)
+static void noinstr handle_arm_irq(void *data)
 {
-	unsigned long flags = read_thread_flags();
+	struct pt_regs *regs = data;
+	struct pt_regs *old_regs;
 
-	rseq_syscall(regs);
-	local_irq_disable();
-	/*
-	 * It really matters that we check for flags != 0 and not
-	 * just for pending work here!
-	 */
-	if (flags)
-		do_work_pending(regs, flags);
+	irq_enter_rcu();
+	old_regs = set_irq_regs(regs);
 
-	trace_hardirqs_on();
-	/* This context tracking call has inverse naming */
-	user_enter_callable();
-}
+	handle_arch_irq(regs);
 
-noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
-{
-	trace_hardirqs_off();
-	/* This context tracking call has inverse naming */
-	user_exit_callable();
+	set_irq_regs(old_regs);
+	irq_exit_rcu();
 }
 
-noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
+noinstr void arm_irq_handler(struct pt_regs *regs, int mode)
 {
-	unsigned long flags = read_thread_flags();
+	irqentry_state_t state = irqentry_enter(regs);
 
 	/*
-	 * It really matters that we check for flags != 0 and not
-	 * just for pending work here!
+	 * If we are executing in usermode, or kernel process context
+	 * (on the thread stack) then switch to the IRQ stack. Else we
+	 * are already on the IRQ stack (or the overflow stack) and we
+	 * can just proceed to handle the IRQ.
 	 */
-	if (flags)
-		do_work_pending(regs, flags);
-	trace_hardirqs_on();
-	/* This context tracking call has inverse naming */
-	user_enter_callable();
+	if (mode == 1)
+		call_on_irq_stack(handle_arm_irq, regs);
+	else if (on_thread_stack())
+		call_on_irq_stack(handle_arm_irq, regs);
+	else
+		handle_arm_irq(regs);
+
+	irqentry_exit(regs, state);
 }
 
-noinstr void irqentry_enter_from_kernel_mode(struct pt_regs *regs)
+/*
+ * Handle FIQ similarly to NMI on x86 systems.
+ *
+ * The runtime environment for NMIs is extremely restrictive
+ * (NMIs can pre-empt critical sections meaning almost all locking is
+ * forbidden) meaning this default FIQ handling must only be used in
+ * circumstances where non-maskability improves robustness, such as
+ * watchdog or debug logic.
+ *
+ * This handler is not appropriate for general purpose use in drivers
+ * platform code and can be overrideen using set_fiq_handler.
+ */
+noinstr void arm_fiq_handler(struct pt_regs *regs)
 {
-	trace_hardirqs_off();
+	irqentry_state_t state = irqentry_nmi_enter(regs);
+
+	irqentry_nmi_exit(regs, state);
 }
 
-noinstr void irqentry_exit_to_kernel_mode(struct pt_regs *regs)
+asmlinkage void arm_exit_to_user_mode(struct pt_regs *regs)
 {
-	if (interrupts_enabled(regs))
-		trace_hardirqs_on();
-	else
-		trace_hardirqs_off();
+	local_irq_disable();
+	irqentry_exit_to_user_mode(regs);
 }
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81c1c3f988344185917cf4e53d0d8ee47ae912f4..a59ad5fdaaf51f653c352884bbdd10d1211b2669 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -25,6 +25,7 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
+#include <linux/entry-common.h>
 
 #include <asm/processor.h>
 #include <asm/thread_notify.h>
@@ -248,8 +249,8 @@ __visible void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
 		 * execve() syscall.
 		 */
 	}
-
-	/* syscall_exit_to_user_mode(regs); here once we switch to generic entry */
+	local_irq_enable();
+	syscall_exit_to_user_mode(regs);
 }
 
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ac7b98ae47249b4a00fc1cb871bb2d309bfd8c88..d1e5a78c616b0e71f9466c201b74e06ce0d7a08f 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -27,9 +27,6 @@
 #include <asm/syscall.h>
 #include <asm/traps.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
 #define REG_PC	15
 #define REG_PSR	16
 /*
@@ -737,6 +734,11 @@ long arch_ptrace(struct task_struct *child, long request,
 			ret = ptrace_write_user(child, addr, data);
 			break;
 
+		case PTRACE_SYSEMU:
+		case PTRACE_SYSEMU_SINGLESTEP:
+			ret = -EIO;
+			break;
+
 		case PTRACE_GETREGS:
 			ret = copy_regset_to_user(child,
 						  &user_arm_view, REGSET_GPR,
@@ -821,90 +823,3 @@ long arch_ptrace(struct task_struct *child, long request,
 
 	return ret;
 }
-
-enum ptrace_syscall_dir {
-	PTRACE_SYSCALL_ENTER = 0,
-	PTRACE_SYSCALL_EXIT,
-};
-
-static void report_syscall_enter(struct pt_regs *regs)
-{
-	unsigned long ip;
-
-	/*
-	 * IP is used to denote syscall entry/exit:
-	 * IP = 0 -> entry
-	 */
-	ip = regs->ARM_ip;
-	regs->ARM_ip = PTRACE_SYSCALL_ENTER;
-
-	if (ptrace_report_syscall_entry(regs))
-		current_thread_info()->abi_syscall = -1;
-
-	regs->ARM_ip = ip;
-}
-
-static void report_syscall_exit(struct pt_regs *regs)
-{
-	unsigned long ip;
-
-	/*
-	 * IP is used to denote syscall entry/exit:
-	 * IP = 1 -> exit
-	 */
-	ip = regs->ARM_ip;
-	regs->ARM_ip = PTRACE_SYSCALL_EXIT;
-
-	ptrace_report_syscall_exit(regs, 0);
-
-	regs->ARM_ip = ip;
-}
-
-asmlinkage int syscall_trace_enter(struct pt_regs *regs)
-{
-	int scno;
-
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		report_syscall_enter(regs);
-
-	/* Do seccomp after ptrace; syscall may have changed. */
-#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-	if (secure_computing() == -1)
-		return -1;
-#else
-	/* XXX: remove this once OABI gets fixed */
-	secure_computing_strict(syscall_get_nr(current, regs));
-#endif
-
-	/* Tracer or seccomp may have changed syscall. */
-	scno = syscall_get_nr(current, regs);
-
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, scno);
-
-	audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r2,
-			    regs->ARM_r3);
-
-	return scno;
-}
-
-void syscall_trace_exit(struct pt_regs *regs)
-{
-	/*
-	 * Audit the syscall before anything else, as a debugger may
-	 * come in and change the current registers.
-	 */
-	audit_syscall_exit(regs);
-
-	/*
-	 * Note that we haven't updated the ->syscall field for the
-	 * current thread. This isn't a problem because it will have
-	 * been set on syscall entry and there hasn't been an opportunity
-	 * for a PTRACE_SET_SYSCALL since then.
-	 */
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, regs_return_value(regs));
-
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		report_syscall_exit(regs);
-}
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a39ee14ec5b70b3738ecef537709326ef1e8217c..35d2bb3cd2b442dac164548037262e065fbfe12a 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 1995-2009 Russell King
  */
+#include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/random.h>
 #include <linux/signal.h>
@@ -535,7 +536,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
  * the kernel can handle, and then we build all the user-level signal handling
  * stack-frames in one go after that.
  */
-static void arch_do_signal_or_restart(struct pt_regs *regs)
+void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
 	bool syscall = (syscall_get_nr(current, regs) != -1);
@@ -598,34 +599,6 @@ static void arch_do_signal_or_restart(struct pt_regs *regs)
 	return;
 }
 
-void do_work_pending(struct pt_regs *regs, unsigned int thread_flags)
-{
-	/*
-	 * The assembly code enters us with IRQs off, but it hasn't
-	 * informed the tracing code of that for efficiency reasons.
-	 * Update the trace code with the current status.
-	 */
-	trace_hardirqs_off();
-	do {
-		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
-			schedule();
-		} else {
-			if (unlikely(!user_mode(regs)))
-				return;
-			local_irq_enable();
-			if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
-				arch_do_signal_or_restart(regs);
-			} else if (thread_flags & _TIF_UPROBE) {
-				uprobe_notify_resume(regs);
-			} else {
-				resume_user_mode_work(regs);
-			}
-		}
-		local_irq_disable();
-		thread_flags = read_thread_flags();
-	} while (thread_flags & _TIF_WORK_MASK);
-}
-
 struct page *get_signal_page(void)
 {
 	unsigned long ptr;
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index 6f518ec3870fb36a64d1b671b20f96d63a52bf78..ed3ab51283c06c1398ece2ad3ee1fae16cd03ee8 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -1,25 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/entry-common.h>
 #include <linux/syscalls.h>
 #include <asm/syscall.h>
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
 int invoke_syscall_asm(void *table, struct pt_regs *regs, int scno);
 __ADDRESSABLE(invoke_syscall_asm);
 
-__visible int invoke_syscall(void *table, struct pt_regs *regs, int scno)
+__visible void invoke_syscall(void *table, struct pt_regs *regs, int scno)
 {
-	unsigned long flags = read_thread_flags();
 	int ret;
 
-	if (has_syscall_work(flags)) {
-		scno = syscall_trace_enter(regs);
-		if (scno == -1)
-			goto trace_exit_nosave;
+	scno = syscall_enter_from_user_mode(regs, scno);
+	/* When tracing syscall -1 means "skip syscall" */
+	if (scno < 0) {
+		ret = 0;
+		goto exit_save;
 	}
 
 	if (scno < NR_syscalls) {
@@ -35,13 +31,7 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno)
 	ret = sys_ni_syscall();
 
 exit_save:
-	/* Save return value from syscall */
-	regs->ARM_r0 = ret;
-	if (!has_syscall_work(flags))
-		return 0;
-
-trace_exit_nosave:
-	local_irq_enable();
-	syscall_trace_exit(regs);
-	return 1;
+	syscall_set_return_value(current, regs, 0, ret);
+
+	syscall_exit_to_user_mode(regs);
 }
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 942c77767919466d5b89d83d8eb77032b119473e..57e74b49c52533babe177a8a2e0160a83c9bde05 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -502,31 +502,6 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 
-/*
- * Handle FIQ similarly to NMI on x86 systems.
- *
- * The runtime environment for NMIs is extremely restrictive
- * (NMIs can pre-empt critical sections meaning almost all locking is
- * forbidden) meaning this default FIQ handling must only be used in
- * circumstances where non-maskability improves robustness, such as
- * watchdog or debug logic.
- *
- * This handler is not appropriate for general purpose use in drivers
- * platform code and can be overrideen using set_fiq_handler.
- */
-asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	nmi_enter();
-
-	/* nop. FIQ handlers for special arch/arm features can be added here. */
-
-	nmi_exit();
-
-	set_irq_regs(old_regs);
-}
-
 /*
  * bad_mode handles the impossible case in the vectors.  If you see one of
  * these, then it's extremely serious, and could mean you have buggy hardware.

-- 
2.48.1



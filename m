Return-Path: <linux-kernel+bounces-530947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A6A43A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA8D1788E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514E0267393;
	Tue, 25 Feb 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dv+5PV0F"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081426657F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477310; cv=none; b=RYakv0nSKLtSPiqnLOTsKPJ+TP5Y+HTLy7SNGg04IzuwjS+rTqpZfwLGjtAsMt6BDZT6odkkmVAaxEUjwcKvYbOoBdNu+L7Yg/zje76SabudgdNeK58BDrkX5s91Pf241w95hnjcHkSaLhW2bEup5aZVNv8rEe+GowdEWr3UQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477310; c=relaxed/simple;
	bh=uIrNsvfXiEIKEM8U0o8JGW9TxOtHpV7VJq4MGLDIiKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jurmvJKKY8UbRYQ9Ejjlp58PAJU0IZCs4iQPVXo0rFkJ5wl3pZF8I9WxhaB0f5/dZqd+7vposT2iSh0kx9vHuM2cMyYVqrsQbXuvTciRcQ3xKLjz+6KIGIj53ya0JZH0OLI4LuJS44nGoKvQzz3bdBJ4J2h7tYtkNxWPS6jPmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dv+5PV0F; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-546210287c1so5523276e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477306; x=1741082106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2oUY/WKIEq8Evp3ZyFIu+cgZC04yoqr/o6eiYlPpGs=;
        b=dv+5PV0FnFyf1VtDkEHMtITjjgtUIHUPyA9KOc7j+x9YH1876OM6h6LHyC7IS6xPVx
         2wZ10FEn9AxrdHsKeUEyFfx3+PDfJs9JOqo02mukNNDK1ELiWAgPld30hRtflBGFh4SR
         j4Sq9A+LlvixAxhHky6PrLq5Jksn+05Ofqeut7VfoDcxBs+bxtJS8tyamnDUmPRZNC9U
         Q9WkxwRNnfUiiC+VPBcgtbMOe+qyU8GX27qemMXAqxNN8m12u9Slwka732+VZ4doqGur
         xgZc/ShyYEVSy6LCkLQtmXl3CES4ogvduQT/EFDEe2tzWTeZp3qKI+Qlkq6oRPKv1jQW
         QkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477306; x=1741082106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2oUY/WKIEq8Evp3ZyFIu+cgZC04yoqr/o6eiYlPpGs=;
        b=mixoOwDu4SJ7RRCFJsbIQ0A1KpIZLPsjDnbiAKNZDe9yd5PqC3sWPk6XtzgS23gwKi
         umPw0lAxf8Zi/cJgyurMDJpUIOuKa9WODixGWSTYoqyzgxs/INSWmzCsNhP+TFbj2E4X
         CDOVOKaFyLSC3+xfYpjZuqgO1pbq0LXnGeQB74KY9pR+9JyXSDxLoNa37A0EtQT4ZyUx
         3m/KWHzDqu21nyO79HlGctKiaMZG9grlPUDN0lXBoDU43Xb5dcT7uqU9SW20GH8z7lU1
         RjIHEKns2wVVh2qU+pCyAtzjh7TPBJRtt0TH/XECqBOJvqKtW6BkHfLxIjVrVioYyXG9
         ZylA==
X-Forwarded-Encrypted: i=1; AJvYcCXeu9pL2Ey/2DS8agNUrikKFl+aZ4KndFihTXD1PWPRot/zTOZsURzn3HKROz4OmSRv+qQKQ6V2b4g6L78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkq+5ImDYlIjj+IwFeUnMuqJgoc8kq9rrViddJDbqOmTwJ6pfx
	O+uFuP3jw8iPRPa8PlunSM/Byhq+QFgeuT1TPHUCb781jPEJtXjg7qLujpEleNg=
X-Gm-Gg: ASbGncuT3ccYyxNtlIaLnAq7xSl1N7XA9gpMNA1aXk3wzXcY5G010Y+iWVNW9aV9FZV
	Pf7quQPCBkWs6Bexya450ILtobkkWffgZ8bTNB7M6L9nyKwiKWO7tfu/QfgcPeA1eFI3BDFfCG5
	SDmkyIopzPelzQOt/XyDJap49zqv9uMhVNPsWjpQgWmNSVaDb1ZZ2sbLl3KjlgFA5bfWlngbqvs
	MmD3oLdm9skFedo/Vbkc3ryDL5dq3P7QlBVrdVyo02LSWp2dLl+Wcfsm6iNxL/H4kdfWAp23PA/
	/c5YW8QJtbEGnPk2yslZ2fB3rZ/XLAnbR6A0
X-Google-Smtp-Source: AGHT+IHAFWSNeFOCqj7itWqejwjbFtkz5zB14hTY/lexRvyjjC7gm0PhxyvvhicInIiEhLg5asuYew==
X-Received: by 2002:a05:6512:b05:b0:545:2efc:7458 with SMTP id 2adb3069b0e04-54839259c52mr6699501e87.39.1740477306361;
        Tue, 25 Feb 2025 01:55:06 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:05 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:53 +0100
Subject: [PATCH v5 06/31] ARM: entry: Invoke syscalls using C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-6-2f02313653e5@linaro.org>
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

This makes the assembly invoking syscalls switch over to
doing this from C with a small assembly stub to actually
jump into the syscall.

Split the syscall invocation into two paths: one for plain
invocation and one for tracing (also known as "reload"
as it was reloading the registers from regs). We rename
this path with the infix "trace" as that code will be
trace-specific as we move code over to C.

Some registers such as r1 and lr get cobbled during the
C calls and need to be restored when we return.

Right now the part in C doesn't do much more than check the
syscall number to be valid (a test previously done with
a cmp r #NR_syscalls inside the invoke_syscall macro)
but we will gradually factor over more assembly to C that can
then be switched to the generic entry code so the exercise
gets a point.

Since both functions are called from a C file that is in
turn only called from assembly, the functions have to be
tagged with __ADDRESSABLE() in order not to upset CFI.

Tested with a full system boot and by issuing some command
line tools with strace to make sure the tracing path still
works.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h |  3 ++
 arch/arm/kernel/Makefile       |  3 +-
 arch/arm/kernel/entry-common.S | 65 ++++++++++++++++++++++++++++++++++++------
 arch/arm/kernel/entry-header.S | 25 ----------------
 arch/arm/kernel/syscall.c      | 28 ++++++++++++++++++
 5 files changed, 90 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index fe4326d938c18efb54c96930e6b52ab7da9b2942..1d21f26ecf510ac00a878b4d51a5753ee49475f5 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -19,6 +19,9 @@
 
 extern const unsigned long sys_call_table[];
 
+int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *retp);
+int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp);
+
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
 {
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index b3333d070390a8ff366a306931614b1b260647bd..69ddf51081f4791982518d37df60c11211b8955a 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -20,7 +20,8 @@ CFLAGS_REMOVE_return_address.o = -pg
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o reboot.o io.o \
 		   setup.o signal.o sigreturn_codes.o \
-		   stacktrace.o sys_arm.o time.o traps.o
+		   stacktrace.o sys_arm.o time.o traps.o \
+		   syscall.o
 
 KASAN_SANITIZE_stacktrace.o := n
 KASAN_SANITIZE_traps.o := n
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index da5c2d4b62e56cce644b15e329ab4149d69c5b79..57aa1084a0476e9c218cd100ce4fdf4aaa748234 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -254,21 +254,23 @@ ENTRY(vector_swi)
 #else
 	str	scno, [tsk, #TI_ABI_SYSCALL]
 #endif
-	/*
-	 * Reload the registers that may have been corrupted on entry to
-	 * the syscall assembly (by tracing or context tracking.)
-	 */
- TRACE(	ldmia	sp, {r0 - r3}		)
-
+	mov	r1, sp				@ put regs into r1
 	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 
 	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
 	bne	__sys_trace
 
-	invoke_syscall tbl, scno, r10, __ret_fast_syscall
+	mov	r0, tbl
+	/* r1 already contains regs */
+	mov	r2, scno			@ syscall number from r7
+	badr	r3, __ret_fast_syscall
+	bl 	invoke_syscall
 
+	/* Restore regs into r1 and lr after C call */
+	badr	lr, __ret_fast_syscall
 	add	r1, sp, #S_OFF
+
 2:	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
 	eor	r0, scno, #__NR_SYSCALL_BASE	@ put OS number back
 	bcs	arm_syscall
@@ -301,7 +303,16 @@ __sys_trace:
 	add	r0, sp, #S_OFF
 	bl	syscall_trace_enter
 	mov	scno, r0
-	invoke_syscall tbl, scno, r10, __sys_trace_return, reload=1
+	mov	r2, r0				@ scno into r2
+	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
+	mov	r0, tbl
+	badr	r3, __sys_trace_return
+	bl	invoke_syscall_trace
+
+	/* Restore regs into r1 and lr after C call */
+	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
+	badr	lr, __sys_trace_return
+
 	cmp	scno, #-1			@ skip the syscall?
 	bne	2b
 	add	sp, sp, #S_OFF			@ restore stack
@@ -415,6 +426,44 @@ sys_mmap2:
 		b	sys_mmap_pgoff
 ENDPROC(sys_mmap2)
 
+/*
+ * This call wants:
+ * r0: syscall table
+ * r1: regs
+ * r2: syscall number
+ * r3: pointer to return function
+ */
+SYM_TYPED_FUNC_START(invoke_syscall_asm)
+#ifdef CONFIG_CPU_SPECTRE
+	csdb
+#endif
+	mov	tbl, r0
+	mov	scno, r2
+	mov	lr, r3				@ return address
+	ldmia 	r1, {r0 - r3}			@ reload r0-r3
+	/* Arguments 5 and 6 are (hopefully) on the stack */
+	ldr	pc, [tbl, scno, lsl #2]		@ call sys_* routine
+SYM_FUNC_END(invoke_syscall_asm)
+
+/*
+ * This call wants:
+ * r0: syscall table
+ * r1: regs
+ * r2: syscall number
+ * r3: pointer to return function
+ */
+SYM_TYPED_FUNC_START(invoke_syscall_trace_asm)
+#ifdef CONFIG_CPU_SPECTRE
+	csdb
+#endif
+	mov	tbl, r0
+	mov	scno, r2
+	mov	lr, r3				@ return address
+	ldmia	r1, {r0 - r6}			@ reload r0-r6
+	stmia	sp, {r4, r5}			@ update stack arguments
+	ldr	pc, [tbl, scno, lsl #2]		@ call sys_* routine
+SYM_FUNC_END(invoke_syscall_trace_asm)
+
 #ifdef CONFIG_OABI_COMPAT
 
 /*
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 99411fa913501cad8b55ef04a2b8ab3d44f3e39e..52b4fa97226dbfa4b55aca8eaf74ae24e1e220f8 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -389,31 +389,6 @@ ALT_UP_B(.L1_\@)
 #endif
 	.endm
 
-	.macro	invoke_syscall, table, nr, tmp, ret, reload=0
-#ifdef CONFIG_CPU_SPECTRE
-	mov	\tmp, \nr
-	cmp	\tmp, #NR_syscalls		@ check upper syscall limit
-	movcs	\tmp, #0
-	csdb
-	badr	lr, \ret			@ return address
-	.if	\reload
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	ldmiacc	r1, {r0 - r6}			@ reload r0-r6
-	stmiacc	sp, {r4, r5}			@ update stack arguments
-	.endif
-	ldrcc	pc, [\table, \tmp, lsl #2]	@ call sys_* routine
-#else
-	cmp	\nr, #NR_syscalls		@ check upper syscall limit
-	badr	lr, \ret			@ return address
-	.if	\reload
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	ldmiacc	r1, {r0 - r6}			@ reload r0-r6
-	stmiacc	sp, {r4, r5}			@ update stack arguments
-	.endif
-	ldrcc	pc, [\table, \nr, lsl #2]	@ call sys_* routine
-#endif
-	.endm
-
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - r0 to r6.
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
new file mode 100644
index 0000000000000000000000000000000000000000..edc0ac88ec60ce3f23149a526de7dc1205906552
--- /dev/null
+++ b/arch/arm/kernel/syscall.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/syscalls.h>
+#include <asm/syscall.h>
+
+int invoke_syscall_asm(void *table, struct pt_regs *regs, int scno, void *retp);
+__ADDRESSABLE(invoke_syscall_asm);
+
+__visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *retp)
+{
+	if (scno < NR_syscalls)
+		/* Doing this with return makes sure the stack gets pop:ed */
+		return invoke_syscall_asm(table, regs, scno, retp);
+
+	return 0;
+}
+
+int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
+__ADDRESSABLE(invoke_syscall_trace_asm);
+
+__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp)
+{
+	if (scno < NR_syscalls)
+		/* Doing this with return makes sure the stack gets pop:ed */
+		return invoke_syscall_trace_asm(table, regs, scno, retp);
+
+	return 0;
+}

-- 
2.48.1



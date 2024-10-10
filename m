Return-Path: <linux-kernel+bounces-358888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA955998510
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAF01C235B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01BD1C8FD5;
	Thu, 10 Oct 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfsC3bz/"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16D1C7B85
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560046; cv=none; b=DUPj5Kk7ExAtBNyZaIyC0OKuBNIGcQhNCDnvetBmlyLxcvYj6qBpujO184C3mbk5BavAsp5F8D0C56IJrokKIAMNnDTQuxxV2Fv+Hfzhb2ke2rOHts7QaYA4BU8hrWDFKY3jzCzb8AVsPN3ws2I9VukK9R4D+0tDNyF+0K7trRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560046; c=relaxed/simple;
	bh=Xo+V1CZRSvq8YRy8tU8+41AjinOUKFVT3YCYSnKFWvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udisWWGveKqIIPSnbfogZZewcGvJxqLswR6+oOEAozgETCaJFgHUnMJl7d2ceSyh3PwXKOpE+76AmXaS9AnQs+7AUXLt0ihnuqjVIMZcvGrtIYxmj0TLVRf3+OJ5HOXipHp0ZdutMmf7hhLwNfIkuwCB5RptE0dBcET3KMrT8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CfsC3bz/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso989924a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560042; x=1729164842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ojsf1FDD3J/q7BWA6tzk7mG2LcyH7oHP8nC2ES9d2U=;
        b=CfsC3bz/svGs7eFrKyFrHpqw+hhYp7z4jr1sQiRXY4uBwEo9yYIeROsAMlz5fZXpQx
         Q5hodcVSgicP0DjszSjpYGRycHwe8DXjs1okTHPTXf6dmZnLqwKPdR0wEyxBf79f8dCM
         Vneg/U14uVTnlSbhulblRG9YyFMETtL6P03OeyQHo+67lC7fEtAEB1qi5EGLfsAKaZgl
         /8ER2JbYRBvEyQKdN/wq+opel2xQ9ce4Ynbztg0Bm5rX/AwvQjthQT80TrNO1kI9yGwN
         Sslxgo422kSrUDkelP8ccbQCCngI+qrRdz9hPW4sds4t9fZZt3drOT3ZbHbVJzGgh+Ng
         RiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560042; x=1729164842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ojsf1FDD3J/q7BWA6tzk7mG2LcyH7oHP8nC2ES9d2U=;
        b=aPz80xNyfndDaokPqUHJrKg8cODvC5hgBopkBC6S4D69FrZi4M3M/+gBk1CkinKSQ/
         fYQEwJJXNO8GFsT121Lmye9eY0FOxd/QzvXyq6Tc5l/y085Qi/eSMJ+sOSsDflYx5EW4
         orKaHQvdi3r3vxHsT9PRWwiGkzTQo9e5w6S1ow6Z7GHbz/wex+k9Z9kwxkXTpHga8Us7
         KoJKmb6WkCsj7494aD3GJqX6RJfLmSFd921WbTmD0eTnsFlN7eLbDEVf7AtFSVrMLlF7
         olguFl3AiMEhddSpuMDeF3E+/T2wpLeLEk3/7xsaHAHnfDFhV+abQH2GuY2KMm5fqtII
         BpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYAi32g1ncaDfPO7IT9auyceE3tj+zCIoGnW8ks870oqhjZn/PGPyKzftm97tD2WmlAJFJ5CiilQ6ej/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDIh0d0uVdvbK9N7fpaoFj1fZw7btPXrX9gXq/+2mYe6y+ARl
	N5Y1XiqKqJTuQkBCuwNbQ7zUMZBxkY4T2EgXgpX1WZ9zpKNc5F+LdbnHpdLcsMw=
X-Google-Smtp-Source: AGHT+IEnD0Vl7gplgYYFyXbkA3DuwA6nUrMhw3YhotT21n+Ce3lTwwfBSn8bVKNVmOPEtF7j8R0Y7g==
X-Received: by 2002:a17:907:9705:b0:a99:4b58:c0b7 with SMTP id a640c23a62f3a-a999e8f41fbmr307100666b.57.1728560042464;
        Thu, 10 Oct 2024 04:34:02 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:01 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:49 +0200
Subject: [PATCH RFC 11/28] ARM: entry: Merge the common and trace entry
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-11-b94f451d087b@linaro.org>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
In-Reply-To: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The trace entry code now can handle recursive and complex
calls in C using stack.

Move the common code over to using that approach.

We now use the ret_fast_syscall return path also when tracing,
which appears to work just fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h |  3 +--
 arch/arm/kernel/entry-common.S | 61 +++++++++---------------------------------
 arch/arm/kernel/syscall.c      | 34 +++++++++++------------
 3 files changed, 28 insertions(+), 70 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index cb0073c4151b..9c664d8c5718 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -19,8 +19,7 @@
 
 extern const unsigned long sys_call_table[];
 
-int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *retp);
-void invoke_syscall_trace(void *table, struct pt_regs *regs);
+int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno);
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index dbc947d301ec..f0f1f8723965 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -39,7 +39,6 @@ saved_pc	.req	lr
  * from those features make this path too inefficient.
  */
 ret_fast_syscall:
-__ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	disable_irq_notrace			@ disable interrupts
@@ -47,13 +46,13 @@ __ret_fast_syscall:
 	movs	r1, r1, lsl #16
 	bne	fast_work_pending
 
-	restore_user_regs fast = 1, offset = S_OFF
+	restore_user_regs fast = 0, offset = S_OFF
  UNWIND(.fnend		)
 ENDPROC(ret_fast_syscall)
 
 	/* Ok, we need to do extra processing, enter the slow path. */
 fast_work_pending:
-	str	r0, [sp, #S_R0+S_OFF]!		@ returned r0
+	add	sp, sp, #(S_R0 + S_OFF)
 	/* fall through to work_pending */
 #else
 /*
@@ -63,10 +62,9 @@ fast_work_pending:
  * call.
  */
 ret_fast_syscall:
-__ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
-	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+	add	sp, sp, #(S_R0 + S_OFF)
 #if IS_ENABLED(CONFIG_DEBUG_RSEQ)
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
@@ -83,7 +81,9 @@ ENDPROC(ret_fast_syscall)
 #endif
 
 	tst	r1, #_TIF_SYSCALL_WORK
-	bne	__sys_trace_return_nosave
+	beq	slow_work_pending
+	b	ret_to_user
+
 slow_work_pending:
 	mov	r0, sp				@ 'regs'
 	bl	do_work_pending
@@ -257,19 +257,15 @@ ENTRY(vector_swi)
 	str	scno, [tsk, #TI_ABI_SYSCALL]
 #endif
 	mov	r1, sp				@ put regs into r1
-	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
-
-	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
-	bne	__sys_trace
-
 	mov	r0, tbl
-	/* r1 already contains regs */
 	mov	r2, scno			@ syscall number from r7
-	/* We return here no matter what, also pass this as an argument */
-	badr	lr, __ret_fast_syscall
-	mov	r3, lr
-	b 	invoke_syscall
+	bl	invoke_syscall_trace
+	cmp	r0, #0
+	beq	ret_fast_syscall
+	/* This path taken when tracing */
+	add	sp, sp, #(S_R0 + S_OFF)
+	b	ret_to_user
 
 #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
 	/*
@@ -289,20 +285,6 @@ ENTRY(vector_swi)
 ENDPROC(vector_swi)
 	.ltorg
 
-	/*
-	 * This is the really slow path.  We're going to be doing
-	 * context switches, and waiting for our parent to respond.
-	 */
-__sys_trace:
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	mov	r0, tbl
-	bl	invoke_syscall_trace
-	add	sp, sp, #S_OFF			@ restore stack pointer
-	b	ret_to_user
-
-__sys_trace_return_nosave:
-	b	ret_to_user
-
 	.macro	syscall_table_start, sym
 	.equ	__sys_nr, 0
 	.type	\sym, #object
@@ -402,25 +384,6 @@ sys_mmap2:
 		b	sys_mmap_pgoff
 ENDPROC(sys_mmap2)
 
-/*
- * This call wants:
- * r0: syscall table
- * r1: regs
- * r2: syscall number
- * r3: pointer to return function
- */
-SYM_TYPED_FUNC_START(invoke_syscall_asm)
-#ifdef CONFIG_CPU_SPECTRE
-	csdb
-#endif
-	mov	tbl, r0
-	mov	scno, r2
-	mov	lr, r3				@ return address
-	ldmia 	r1, {r0 - r3}			@ reload r0-r3
-	/* Arguments 5 and 6 are (hopefully) on the stack */
-	ldr	pc, [tbl, scno, lsl #2]		@ call sys_* routine
-SYM_FUNC_END(invoke_syscall_asm)
-
 /*
  * This call wants:
  * r0: syscall table
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index 3ee367958298..ab9e66da0a80 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -3,48 +3,44 @@
 #include <linux/syscalls.h>
 #include <asm/syscall.h>
 
-int invoke_syscall_asm(void *table, struct pt_regs *regs, int scno, void *retp);
-
-__visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *retp)
+static inline bool has_syscall_work(unsigned long flags)
 {
-	if (scno < NR_syscalls)
-		/* Doing this with return makes sure the stack gets pop:ed */
-		return invoke_syscall_asm(table, regs, scno, retp);
-
-	if (scno >= __ARM_NR_BASE)
-		return arm_syscall(scno, regs);
-
-	return sys_ni_syscall();
+	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
 int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno);
 
-__visible void invoke_syscall_trace(void *table, struct pt_regs *regs)
+__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno)
 {
-	int scno;
+	unsigned long flags = read_thread_flags();
 	int ret;
 
-	scno = syscall_trace_enter(regs);
-	if (scno == -1)
-		goto trace_exit_nosave;
+	if (has_syscall_work(flags)) {
+		scno = syscall_trace_enter(regs);
+		if (scno == -1)
+			goto trace_exit_nosave;
+	}
 
 	if (scno < NR_syscalls) {
 		ret = invoke_syscall_trace_asm(table, regs, scno);
-		goto trace_exit_save;
+		goto exit_save;
 	}
 
 	if (scno >= __ARM_NR_BASE) {
 		ret = arm_syscall(scno, regs);
-		goto trace_exit_save;
+		goto exit_save;
 	}
 
 	ret = sys_ni_syscall();
 
-trace_exit_save:
+exit_save:
 	/* Save return value from syscall */
 	regs->ARM_r0 = ret;
+	if (!has_syscall_work(flags))
+		return 0;
 
 trace_exit_nosave:
 	local_irq_enable();
 	syscall_trace_exit(regs);
+	return 1;
 }

-- 
2.46.2



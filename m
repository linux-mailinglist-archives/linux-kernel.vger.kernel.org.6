Return-Path: <linux-kernel+bounces-386751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1D9B47A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448581C21FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B180208208;
	Tue, 29 Oct 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCXQFpnw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743F207A17
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199190; cv=none; b=Ki2tW35FDc0OsPCeMwaB4yUNUfUrWRpsBQXvTua1/a5QDbImzahM8j2+1kvBFHmeAI1PZIHmHMVdJG8x4cFhquIoodAYPmiZ1qVikj7KSIsWGBjOI1JDRGXD6bhfG9oqiV8+qrd7wcjoaiCxPSbg9f65i8XKnDAf/i5Veu7mH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199190; c=relaxed/simple;
	bh=Xo+V1CZRSvq8YRy8tU8+41AjinOUKFVT3YCYSnKFWvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fkUkRY7k+pRs5BXV8CuByoEee30Zg1oW2AmZ8SOEMfoTlNZYBHmE8AZr0Y+raYip0XeKWIgrnxqatVI4KwgZVCpYff+lS/xeC5ULSGJ/FQkNGnc5/NiucTwqgbWk4yHyPPuxcSJgHxi7MFKHkK1ikQYqnF6ebZfL1EVdzxDA6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCXQFpnw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53a0c160b94so5892395e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199186; x=1730803986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ojsf1FDD3J/q7BWA6tzk7mG2LcyH7oHP8nC2ES9d2U=;
        b=mCXQFpnww5d0GTztfQ48K7FTPQEV4DAcHqDCNguo4J8ZLFTakNvWsMujP6mTMx1hq3
         jo0X2W9gItdYYZzFdVX8mPcImjHTBCNre0k7wh2ylRIYvBrRzcbX+vGUY5qwSDzbgPq3
         goYIr4iNbIBZFanWqpKKEfsPTfIlsE4TKoDzECT3ZBhAAnlieBygatZ+xiij8zfeBpKp
         M4xbCMk9zPf3i9xcqVJaV9+4VOalM7ryypsOOoUS/IkXcnqn3PLaK9zGLRu6VHBQgMgj
         ytTKuGCww9ijKC9sa8YS92thCsbfmXPez7z4p8ijRw05QqbkVKV/K9jfq2vn6mvRZkXp
         AxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199186; x=1730803986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ojsf1FDD3J/q7BWA6tzk7mG2LcyH7oHP8nC2ES9d2U=;
        b=JYKkJxQVbTRzQf50OYXlqWRhwur+2PeXmCXXQGOShFMoJhIVwXMKxKqQk8JqXax73X
         NCmFyOWcZ2fhvp+CkppufmM/W6lRESJKXM4sk0COlDaFssHeSFl5t4RlFOGv//6nu0DM
         4gsRxxMCyB0tY5vz93Y8163AZmMMmyrENAWja9olHkBRPoDiogvHIO+azS+ZE3+VgKtu
         wKoNiNI1K6HkwEYybHJYXP9G4Rs6N6WlOLjYDSmAvASoYZPCGFmUhlO56f0Rz8MHt9Gn
         KMBg8ZLBidMFZ2dVh4Uduin0/zho709iQrWD3FzqT1x/iSejOAWDRB9woiSh+81hh8um
         3/kg==
X-Forwarded-Encrypted: i=1; AJvYcCXQIXa0dF6QPqp6KuOawD7oO8M9Ap2GW7ioIWnCQPPVCuqbJuDGWQOfS+/N9ZCzXOiVchWDEl4Ebr9lXPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OEGHUC7204eHi/M26U5bnv88CZfCzR1g9zcUKGRxNfR6lcWb
	c6jTTiTBkGS5aMel5YYQyO2DdieGGZJftcOTY4CISIWEHbZblj9JL+Q2fVibz6Y=
X-Google-Smtp-Source: AGHT+IFXG4+qFOLuZpZcmM1Lay+S0Jgq0PH3SGHMivCPOmdGtmS+4HV+qVrZtyBne6W8UBHPMqEfcA==
X-Received: by 2002:ac2:4e0b:0:b0:536:741a:6bad with SMTP id 2adb3069b0e04-53b348c1086mr5244851e87.12.1730199186296;
        Tue, 29 Oct 2024 03:53:06 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:04 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:51 +0100
Subject: [PATCH RFC v2 11/28] ARM: entry: Merge the common and trace entry
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-11-573519abef38@linaro.org>
References: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
In-Reply-To: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
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



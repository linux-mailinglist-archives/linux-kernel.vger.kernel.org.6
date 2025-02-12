Return-Path: <linux-kernel+bounces-511014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EEA324C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8703C18870F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6920A5C4;
	Wed, 12 Feb 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSEwuhHr"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132F20DD7F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359401; cv=none; b=a8NQ97Qjpw5QQNTofxz4S0AIprl8d6UlvgBoEJGDmTPYS5CQj9SzyhAPKrgkfTmso1gYmHc+ps4RZ2GScXS0uysw72Hp/F6bjOEa90lFxtJedkd2lce71qkWpq3XL8NIq4Qs5oxoqXB50OQXGO9a8FP44REKcZOvQLv8ECGo248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359401; c=relaxed/simple;
	bh=N+6JdwMNGquesH7qb0RP8fIf28m6SmqW3xolOuov51o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpWIi8NLOpvQSDYUW8yjIfC9FEhaubyUcR64RE6fBa1psF1sRkh6nCf26XNpS12VK9bRJBjvvfXj6Gn/3ghDjBwrjDq0aB5nhioUezQo1QYle+krbLbLLcymbH0kgRwDQmf1vN1xLIOb7xZK2no4nLeenWQVB5YRRIwZBXwR1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSEwuhHr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30762598511so64711221fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359398; x=1739964198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjCfgKpzfePVa0TyVy/JvnFpB7AUCXqKC35hzfV3hLA=;
        b=kSEwuhHrkpPUV9MxQwwwllhKFD9fEKM7MS4AS6Hz2HA5luH5uR2N8WdVc1JAwJ7CXV
         RX7PXU2RHdl0avOCcRSDbU03c0ud0EdoMbcLiM8ZbCSrpBpRUh4ZqwhbASpLj2kLUihb
         GDIPOsbvu8a+ONhPzhclVAhOFIyIkmXzIUXZ8s0iZslSD+QcdDk3qBgevH3/p4JmK6Jo
         W+skJDR2BOud8oKEWQo46zHjPasYxsXtDOpWNDS/QRx6p4UtRCADKUvcDiaqJFWztBNQ
         fNEqAGfPZ1X/E+FmOfzrxCAIDPLSOR7KSrs7fd0+k7l/WACeY1SQNRLGFoSt1cKt9uo1
         tgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359398; x=1739964198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjCfgKpzfePVa0TyVy/JvnFpB7AUCXqKC35hzfV3hLA=;
        b=pRL/1a7GV70G2uyc3XqZzZSfR//T+4LmauBnsklKYKYHh+Ne0RC5lfKeTePdqjZhgy
         BkOLM+kiQZ4MhGfhlJajViwkkIgLu6cEyUBY+R6oDiG2DwJTb3ZeSaX0HD2s6qDbfzgd
         cKtce/6bqD5yzxyJni9xjZ3JTvkhZRL0R/xBkJOsOXmX1tRBCCQUdcmS0a1vEb6BFhf7
         ntLnDrnnFC/ghyG0n0LXTobOy97gvoXGF4nMje/6ti9GkZdKaV+SJn/nbe7h/mNe/3qS
         5hyOvTPgmQBqiQaVmqro/xpT8MdsxoFBxFIQLJvtYLqL9hkTrmsEaxVhPqneSCHW4+DX
         t+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdtY/ZnCEhX/ouASN1S2hlDKrfH9vFgb1lMhjEhjCog3Y6u7v5N4Mz4ZAXkD8aapFm9TIHlyu+odmX8Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRSyxZE5HX98t79lEcbrkbze44Lp9dWSkJLW5bL+mrXFBLjPl
	yZTKeH5k126jOxcQjcNa4okO4TfYlmeFmuLHUxftJv0x8ZEvXye+gvHuTWdhBbo=
X-Gm-Gg: ASbGncvuJk9CvrG5A6N8MfYuBwOEeQPaSInDijENhiijm9IgrYeBZ2uoR5QqXdll4AS
	Zokv2P7ihr3Xxu5kN3eowBN0yR3oX9aSzqw+zpS4z7od+LW7Ao4jS8uBqEALOvLciyNHyXmvSEn
	BPaTrm7yiUDZvwYrDWf0r1Y91RneMI1BCFWN+JoV2WLIWuDKhJ6izjGbPk3xHFy8/dGf9DNxlQx
	CC+tBBpAu3vufav11rreKiZ5u4D2d2edhYhomVRSBD4SNoC5OfjoNjy2aV4G+LrHvFS6ZUJP098
	saCCeuRV4IcG486K9uhhgbFWfA==
X-Google-Smtp-Source: AGHT+IH751jL04M7McMnVl+Lf+gieXyjpD8AD36LFvaCxdH/f/sQl+jWkhu6bmO5y/ajdqZRtC2dng==
X-Received: by 2002:a05:651c:211e:b0:304:68e5:eabd with SMTP id 38308e7fff4ca-30903699ffdmr9620161fa.3.1739359397554;
        Wed, 12 Feb 2025 03:23:17 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:17 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:05 +0100
Subject: [PATCH v4 11/31] ARM: entry: Merge the common and trace entry code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-11-a457ff0a61d6@linaro.org>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
In-Reply-To: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
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

The trace entry code now can handle recursive and complex
calls in C using stack.

Move the common code over to using that approach.

We now use the ret_fast_syscall return path also when tracing,
which appears to work just fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h |  3 +--
 arch/arm/kernel/entry-common.S | 61 +++++++++---------------------------------
 arch/arm/kernel/syscall.c      | 35 +++++++++++-------------
 3 files changed, 28 insertions(+), 71 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index cb0073c4151bf70a82d15e17a95b6b6f48b245d6..9c664d8c5718f58034f442c20a030b59faf65dd9 100644
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
index dbc947d301ec11bb13007cb4bb161c035ede5c10..f0f1f8723965313b287158fb2a238908db72fcd2 100644
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
index e90f04f35b3485968a1e9046cf0889f56cca92e5..36330023b5484399a4ca2fdb5727b410e2c74b6f 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -3,50 +3,45 @@
 #include <linux/syscalls.h>
 #include <asm/syscall.h>
 
-int invoke_syscall_asm(void *table, struct pt_regs *regs, int scno, void *retp);
-__ADDRESSABLE(invoke_syscall_asm);
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
 __ADDRESSABLE(invoke_syscall_trace_asm);
 
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
2.48.1



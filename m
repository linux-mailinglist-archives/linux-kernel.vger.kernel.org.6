Return-Path: <linux-kernel+bounces-530948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D1A43A70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABE516AEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2C52673B3;
	Tue, 25 Feb 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTCczMrW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59861266B5F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477311; cv=none; b=PvpGmSXPXSKTfMTUtykKQ3bDjfdrbk5RC8eT2iulidZTkibJpwWpaMgH7R3IiwYwN8hqO/2FUeeIHp5inlxD5MoqBmdjyhs0Q1A9kDw8p7Y1C+WMuWx3zR0o0un2tIIMoXvgnOlnr6H/ZRwm/+1jAMth9f2VVBPFUEZYSfPRGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477311; c=relaxed/simple;
	bh=hXVFyo95Fd8AEwhm82LpDlV5OS0uorB3k4MP3pL+pwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOSCYiVWwlTFV/Wa7n88vyG9ETfj9oWZmW/BIHIDtR0koQ6yYLwQCErS+W7RItZygp6fOqAjMIl6yvbg/ihFVusJFR+EQ0hQee6FuELKOkbowt9Tm6Vrui8AWTNUgcX7ykLTW+AWlED5a94XGKuflZAetuCnhO2bWysZemuFb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yTCczMrW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-545316f80beso4810352e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477307; x=1741082107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yplTGeg8q5Jb1IHX+lZzUxdHnSw+Ki6MseFOXEsgMb4=;
        b=yTCczMrW41gPMUqWM2H1YVWu3DVfmmMn4m0eEasFQBk8QHwv/0rjwdFgXeAyFxr8Lp
         b6ZK3/6upYWpFkN7l4tR69MOrTKtMRj5f0yJxrdAx3o/hpMAIABoJzR8lMntaSNJMuc2
         drNk4PaVRHis/ZrVms5PJfZa7NTHS7lN06fRRu1C7v1jlS6sPYB2cw26PeWK9l5caAG1
         5yufmOdlZuMD7zfyETwpjloF/vxJFIujyAnad+orJM9WyAEystTGr+xT4JtqPQ8eQzUY
         1w6unzQXzyoN/AiTtj9Kjh1dTJ9qIW2vgNIMjbAJtD3LqxNFpnheCREw1tCoGbokElTk
         inZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477307; x=1741082107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yplTGeg8q5Jb1IHX+lZzUxdHnSw+Ki6MseFOXEsgMb4=;
        b=embp5tCr9UBNrjquP7E+kaKmz6XgNYf70LIjvumf8/59zFmJomvXBK6yZbIJDLVz2H
         MAip+i4nOZI8WXbYzblpsq1fh40douSRAj9JuRdnXSniEEB71w6D2pj04uAY2+tl6twP
         xEFcNViLb2DCm/WDMBLXjrzMw70CwaPYcTzKlAip5+cppCaLAqqQWkSRIDP/MEpT9+xq
         3MS0Rl6thp7iLVKy23uxU3F16Dk2vAHXVaBDTGyhtlixIYkQXWjP/mxIxxjwvq+rKxC2
         Quz5tDIZbleF46AYcoCeahO9GO1oIoY8vjEE31G2OXQ206/Lj/tsJZYAcEZR8G5X8aky
         fI1g==
X-Forwarded-Encrypted: i=1; AJvYcCWIvMUl42Hy4Lf4UbtML31w8ytpNq3CBoU8bzo2Ijxjv9HkAsYgnBNDswptT+Iah0LS1cdqYAEDkgpCJ7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbsBI6tKD80slnanCYOw3WuvVvzvBMc1okuymM5sqQnneD4ZK
	sd2SEKLq7+XFSlBVhODQbvwiq/gr1spboZzhqBzvoDGx7BhUiUkBzGsx8A/UXGU=
X-Gm-Gg: ASbGncvNoCNAqwBAAjlFk+zsIe6PmCekBRZmcUJMwSUOReVTONGoUkAbiGCs/8+OIQ9
	fJtnTK5KLC6TPgq7MpZo6WOLYSqmg3lCobDdfKzdDuACL42gEy2s+Gq0fKmSiUwUtEgLaO106NX
	I+wJCpWewXQ4jATj4lGG9mGfJs68M1gqR8XMDfprA12Xa9YQcZwrTvG26EmmCeyQWCLd35UKMqR
	lL6ypmbuRpcc2JaersDpABpCtYcDmeDj5SEMJ4FLwSqpfHPtheAY+DqvDwDVOyDZSxlNu5x/7F/
	tNIe5NVi0GY1sAyJDdRGEnUc+9ywdf+ZTld1
X-Google-Smtp-Source: AGHT+IGoTxLJRfhLsWrHbxJYsDg42lv8XbjjipYTWunjh9XthEIABhj8ikVXP3Y+TyRAMRgkg54cow==
X-Received: by 2002:a05:6512:3f10:b0:545:27ee:79f3 with SMTP id 2adb3069b0e04-54850e8790bmr925786e87.0.1740477307404;
        Tue, 25 Feb 2025 01:55:07 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:54 +0100
Subject: [PATCH v5 07/31] ARM: entry: Rewrite two asm calls in C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-7-2f02313653e5@linaro.org>
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

The normal and trace entry code calls out to arm_syscall()
and sys_ni_syscall() from assembly, but these calls can
be moved over to the new C implementation.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/traps.h   |  2 +-
 arch/arm/kernel/entry-common.S | 23 +++++------------------
 arch/arm/kernel/syscall.c      | 13 +++++++++++--
 arch/arm/kernel/traps.c        |  2 +-
 4 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 2621b9fb9b19b064aa40a8ab4a3a89067b98a010..b888912c2450e0e8eec8139166c7292f283545c7 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -40,7 +40,7 @@ asmlinkage void dump_backtrace_stm(u32 *stack, u32 instruction, const char *logl
 asmlinkage void do_undefinstr(struct pt_regs *regs);
 asmlinkage void handle_fiq_as_nmi(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason);
-asmlinkage int arm_syscall(int no, struct pt_regs *regs);
+int arm_syscall(int no, struct pt_regs *regs);
 asmlinkage void baddataabort(int code, unsigned long instr, struct pt_regs *regs);
 asmlinkage void __div0(void);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 57aa1084a0476e9c218cd100ce4fdf4aaa748234..77801d039b5f6562b231a6fd4979e318c7e736a6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -264,18 +264,10 @@ ENTRY(vector_swi)
 	mov	r0, tbl
 	/* r1 already contains regs */
 	mov	r2, scno			@ syscall number from r7
-	badr	r3, __ret_fast_syscall
-	bl 	invoke_syscall
-
-	/* Restore regs into r1 and lr after C call */
+	/* We return here no matter what, also pass this as an argument */
 	badr	lr, __ret_fast_syscall
-	add	r1, sp, #S_OFF
-
-2:	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
-	eor	r0, scno, #__NR_SYSCALL_BASE	@ put OS number back
-	bcs	arm_syscall
-	mov	why, #0				@ no longer a real syscall
-	b	sys_ni_syscall			@ not private func
+	mov	r3, lr
+	b 	invoke_syscall
 
 #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
 	/*
@@ -308,13 +300,8 @@ __sys_trace:
 	mov	r0, tbl
 	badr	r3, __sys_trace_return
 	bl	invoke_syscall_trace
-
-	/* Restore regs into r1 and lr after C call */
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	badr	lr, __sys_trace_return
-
-	cmp	scno, #-1			@ skip the syscall?
-	bne	2b
+	cmp	r0, #-1
+	bne	__sys_trace_return
 	add	sp, sp, #S_OFF			@ restore stack
 
 __sys_trace_return_nosave:
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index edc0ac88ec60ce3f23149a526de7dc1205906552..d637dc74b1c70415933898fbcadbedc71df5f654 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -12,7 +12,10 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *
 		/* Doing this with return makes sure the stack gets pop:ed */
 		return invoke_syscall_asm(table, regs, scno, retp);
 
-	return 0;
+	if (scno >= __ARM_NR_BASE)
+		return arm_syscall(scno, regs);
+
+	return sys_ni_syscall();
 }
 
 int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
@@ -20,9 +23,15 @@ __ADDRESSABLE(invoke_syscall_trace_asm);
 
 __visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp)
 {
+	if (scno == -1)
+		return -1;
+
 	if (scno < NR_syscalls)
 		/* Doing this with return makes sure the stack gets pop:ed */
 		return invoke_syscall_trace_asm(table, regs, scno, retp);
 
-	return 0;
+	if (scno >= __ARM_NR_BASE)
+		return arm_syscall(scno, regs);
+
+	return sys_ni_syscall();
 }
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 6ea645939573fb65ed36f5435a9c94e98828f45b..942c77767919466d5b89d83d8eb77032b119473e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -609,7 +609,7 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
  *  0x9f0000 - 0x9fffff are some more esoteric system calls
  */
 #define NR(x) ((__ARM_NR_##x) - __ARM_NR_BASE)
-asmlinkage int arm_syscall(int no, struct pt_regs *regs)
+int arm_syscall(int no, struct pt_regs *regs)
 {
 	if ((no >> 16) != (__ARM_NR_BASE>> 16))
 		return bad_syscall(no, regs);

-- 
2.48.1



Return-Path: <linux-kernel+bounces-358890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D3998512
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010B01F25F55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062921C3F30;
	Thu, 10 Oct 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXTJkkXv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5001C8FD7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560049; cv=none; b=QZbvE/LJuqsvduj+MWqFYv27nb9J2RJOHY5Jz51tuK4eHSp0eT8eaUvxgn3IgAtwEIqgJPfY++og2x00guirxl145ZiNepwtpRVmE+1od8HgnjPW2L5NeV9ZesSzD0pG90EFH9wPRXmKDy1MTCImgQ+bRoliafO17Jo0AjxGRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560049; c=relaxed/simple;
	bh=F5bQDfkVsSRu/OqASLHtGTld91a3P5BAk4tZTozpgOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoMXPJ8ERknFnrgEc8vKICS6rrFulCjZodmD54wCvwlEk1bUFAFoY8oD//aKOlz5+KtIdU/4bqBgNNdhEqlyx+dGq5LsmS5R/IszSuBJSNRRCBTmrfaD2vUZRK2Kg5LH3Kwej2oLYsTPh9K/Q2DnLNxSDWra+EahHQUmhuJSHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wXTJkkXv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so881947a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560046; x=1729164846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be+GUyUOPZhG4HeyC8y7wViGnm8iy+tOVPMx83A5Zgg=;
        b=wXTJkkXvsa7ny+SlAPIJ1UbWtrv18AcHzMjo0xyR+CBTvrmAxIKd3BcZwHdusQu+Tg
         z43sA5TycDtkxnsve0PeNdhYREQycH9cliuwIot9h4BzdNVVQ0R+IkVxtkv+JbMye9do
         FnhGf5gyTAx8U0XuwTGLSAEVLqgjZOHO3vt/ZnEkot6mwOZz/OzOzpHnhlj4il+EclPB
         qXpkL2WGehKKGDltNyjTkKvfv2IcqURsu83wB0RZtNK+54l9XUy9cmYnCRT/XDsxksih
         jp3fpkSxXTyYWXmNYak1EGbdo0jPaz+yHOYUtOEss2GVI/V/lHjUZxiiBWvQdnobLHhB
         harg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560046; x=1729164846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be+GUyUOPZhG4HeyC8y7wViGnm8iy+tOVPMx83A5Zgg=;
        b=IL+PHlrpMb/AN2WoxYqUvpHJe6r5eXvA9rsAYhGqryxBAk8fX/WO8Xva7wvdf1o9kX
         araU5SoY+BuC2hx4lnj/F4LbHyLTIQHlBB4hcTtuvwfZjd1/45pYu07oZ5wRReBkF+8z
         yBRF3OeHKSLUv0gbK/WlKobfVqcPoq/SA7R42e9tVnFNjcxNb1nbP3fDT6Vo4dp3OOMI
         PhtdxSgYq81ivlj3vf7a2NwrEmxbJXT+uiYsMqDjvKvhE0xXEQhH/Kv8X82IEITI5VmH
         4ffI3P7hdgcDnGgodCJPWquhJa7F0i7AYDRm2R6+eg115a+00akzK9Crc5yVa3FaW9Cq
         ntyg==
X-Forwarded-Encrypted: i=1; AJvYcCVeNXUaLnrg6uEreblzrXV2UlaovV5oAVuMAzKNJ9Mxrp+8MmM6HCmBUgKLRXN1srcqZswk0zgt98M1wqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvibLjK2SY5WjphrGnETm9ZT92ZSCBb+flr3m37+AE2Vg9xL7H
	bLCt9qGqd5SWbdO7LAzJiix0ZY/JER5NeL4p13MTzSuwYZBiRuwMP6QZmHl8gJs=
X-Google-Smtp-Source: AGHT+IGmc9n6VQianQrFxqDVPOVQDV5YCcFVpaGOA7jxGuHzUJl/veHr7yvG1GzHaeWsSpHDbkqbxQ==
X-Received: by 2002:a17:906:c151:b0:a8d:3338:a497 with SMTP id a640c23a62f3a-a999e628c38mr322887866b.4.1728560045769;
        Thu, 10 Oct 2024 04:34:05 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:04 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:51 +0200
Subject: [PATCH RFC 13/28] ARM: entry: Create user_mode_enter/exit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-13-b94f451d087b@linaro.org>
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

The callbacks to the context tracking will be repurposed
for several uses that are needed on the IRQ transition
to/from userspace.

Rename the macro, establish call sites in C calling into
the context tracking following the corresponding generic
entry function prototypes, despite the assembly macro
names become a bit long this makes it clear to readers
exactly what is going on and where this call will go.

Drop the ifdefs pertaining to context tracking from
the macro. The C calls we will use have stubs that will
compile these out anyway.

The inversion of the signature of the context tracking
calls are especially confusing since the generic entry
uses the reverse semantics: *enter from* user mode (to
kernel mode) and *exit to* user mode (from kernel mode)
instead of the other way around as the old context tracker
code user_exit_callable() and user_enter_callable()
which have inverted semantics.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   | 14 ++++++++++++++
 arch/arm/kernel/Makefile       |  2 +-
 arch/arm/kernel/entry-armv.S   |  2 +-
 arch/arm/kernel/entry-common.S |  4 ++--
 arch/arm/kernel/entry-header.S | 24 ++++++++++++------------
 arch/arm/kernel/entry.c        | 15 +++++++++++++++
 6 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
new file mode 100644
index 000000000000..e26f369375ca
--- /dev/null
+++ b/arch/arm/include/asm/entry.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_ENTRY_H__
+#define __ASM_ENTRY_H__
+
+struct pt_regs;
+
+/*
+ * These are copies of generic entry headers so we can transition
+ * to generic entry once they are semantically equivalent.
+ */
+void irqentry_enter_from_user_mode(struct pt_regs *regs);
+void irqentry_exit_to_user_mode(struct pt_regs *regs);
+
+#endif /* __ASM_ENTRY_H__ */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index d5a128a4228d..9a6ac0974110 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -17,7 +17,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= elf.o entry-common.o irq.o opcodes.o \
+obj-y		:= elf.o entry.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o reboot.o io.o \
 		   setup.o signal.o sigreturn_codes.o \
 		   stacktrace.o sys_arm.o time.o traps.o \
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1dfae1af8e31..d6e8b36c70f5 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -405,7 +405,7 @@ ENDPROC(__fiq_abt)
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
-	ct_user_exit save = 0
+	asm_irqentry_enter_from_user_mode save = 0
 	.endif
 	.endm
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f1e48002bd30..ff1dd3169346 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -111,7 +111,7 @@ ENTRY(ret_to_user_from_irq)
 no_work_pending:
 	asm_trace_hardirqs_on save = 0
 
-	ct_user_enter save = 0
+	asm_irqentry_exit_to_user_mode save = 0
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
@@ -191,7 +191,7 @@ ENTRY(vector_swi)
 	alignment_trap r10, ip, cr_alignment
 	asm_trace_hardirqs_on save=0
 	enable_irq_notrace
-	ct_user_exit save=0
+	asm_irqentry_enter_from_user_mode save = 0
 
 	/*
 	 * Get the system call number.
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 52b4fa97226d..fb5bb019199b 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -362,31 +362,31 @@ ALT_UP_B(.L1_\@)
 	.endm
 
 /*
- * Context tracking subsystem.  Used to instrument transitions
+ * Context tracking and other mode transitions. Used to instrument transitions
  * between user and kernel mode.
- */
-	.macro ct_user_exit, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING_USER
+*/
+	.macro asm_irqentry_enter_from_user_mode, save = 1
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	user_exit_callable
+	mov	r0, sp				@ regs
+	bl	irqentry_enter_from_user_mode
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	user_exit_callable
+	mov	r0, sp				@ regs
+	bl	irqentry_enter_from_user_mode
 	.endif
-#endif
 	.endm
 
-	.macro ct_user_enter, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING_USER
+	.macro asm_irqentry_exit_to_user_mode, save = 1
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	user_enter_callable
+	mov	r0, sp				@ regs
+	bl	irqentry_exit_to_user_mode
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	user_enter_callable
+	mov	r0, sp				@ regs
+	bl	irqentry_exit_to_user_mode
 	.endif
-#endif
 	.endm
 
 /*
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
new file mode 100644
index 000000000000..8b2e8ea66c13
--- /dev/null
+++ b/arch/arm/kernel/entry.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/entry.h>
+#include <linux/context_tracking.h>
+
+noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
+{
+	/* This context tracking call has inverse naming */
+	user_exit_callable();
+}
+
+noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
+{
+	/* This context tracking call has inverse naming */
+	user_enter_callable();
+}

-- 
2.46.2



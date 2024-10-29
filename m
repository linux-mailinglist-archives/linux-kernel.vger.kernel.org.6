Return-Path: <linux-kernel+bounces-386753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F18159B47A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585EEB234B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657D208972;
	Tue, 29 Oct 2024 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ku6BZNp3"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C820820F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199194; cv=none; b=Ggjsa1OAaV/hTkUitbhMY1plw00WU0Q6OVDwFj/rxdK+sfPvdE2iXhEHIZISidGoZ6mKGQ01/sVG4Ww5GzJpjh0bebO964BJ/a5MiWl64KyoIhg7tzeXXuM5hCr7CBCpAAqmOcJpFu7AQTKkAo0uoJTT25zbLb+xu9YIgVvd15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199194; c=relaxed/simple;
	bh=F5bQDfkVsSRu/OqASLHtGTld91a3P5BAk4tZTozpgOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jff3cu8kb8JZtWUaYwBTEE+ZMl9fAXE1TsQwICHO14yqKzCvDL2g0hvIq17fIkmL60MJiw2ffFQPUlRdEhvL7UcJcvVbmQ1YZrVJ0fmVYt5UDcCGoypz+OrPWaxIIolblN30VCJ9cg/dHoMrSkzm+zuM+IE9lg1NGG20CXwLcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ku6BZNp3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e6c754bdso4744273e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199190; x=1730803990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be+GUyUOPZhG4HeyC8y7wViGnm8iy+tOVPMx83A5Zgg=;
        b=Ku6BZNp3mjrolV5kaqL9LQIPwv4RkAkYlWrfUKz6q/Gi+njaoqorcCMa44oELCCALX
         6qTGFIsgWQ8dwGsACqSfGPvluahILfD4KDbwYL5VmXM8b8hQUBiARqs4AMVMrRTpaLmj
         SOsWrc85NTkm2mIcqqvSpHZ9wqEurmSOi/vh3WENjoy1mMqaLCmvpR8kzwsO3PPQ7tjw
         hszScrqNRGzBl7ati1aJh58cOTrXWFyL8VYUGb5Cn/ZS6x+42Ad1xwHid9t6njub9mEl
         X3fmBMJEyn0i3wo0b+aYzHG9APfzPtc2w26PGG7N+6SWN8Bo/gxSf/Nt44K413zX0jEe
         kC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199190; x=1730803990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be+GUyUOPZhG4HeyC8y7wViGnm8iy+tOVPMx83A5Zgg=;
        b=WwSwhtjGnoOEAvXBdabB4VPJvbVkxjHDUKPf1JTrrDet5C6PiihOKM4XqZIZ+US9uQ
         3yjVqQqDVZXE2ULDpfjO8f2WnD9mAzTZntwkZdmp3fX2iKfQj/+JzKV/HkmE09eCKbDh
         CARKw4SysDXnhwNsUtGN8wGsDBhQT+aBuadz9mr3iaJfGpqpyD1pCdj7/D2bfke0z8VD
         i82iFiE3FpVq0Tichf1ba5270KDUwFnYARZWtDVI/cqvkkTb/dQA7RtU3CWZItfCFwzn
         lTRGxAWBwURarCvmYc7pCfIOAqk/cy1AbP1SdtKqhwi2SFyW+fP4vRmC0IVyxEvU5Lo/
         SeSg==
X-Forwarded-Encrypted: i=1; AJvYcCUXWN90rcO/15V0gkGfcaBOatGV5RNTzxs8MN4lKxSOusMMZK5IBT4c/pGWDjh/PNeS8JHBanOVAEV/eUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ONWjPJwkPvBFl664QJY729U6FlW3FlKzBDeVcDJ5gZh3/cyv
	SDgDeQRqFkvLtxPKKzaZU+fDmWEoo5Kjrg36MTjvEOTVHTht4ob7VJezYa6VJqk=
X-Google-Smtp-Source: AGHT+IHnu3r1g0OwvCLOiPYGKbeTf+Hv9O68OAgzGiZtRX6hJe7xHb3GGSvsAVORAIl1GunSQigcZQ==
X-Received: by 2002:a05:6512:33d5:b0:53a:3a:f4f4 with SMTP id 2adb3069b0e04-53b348e599cmr4735466e87.31.1730199190072;
        Tue, 29 Oct 2024 03:53:10 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:08 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:53 +0100
Subject: [PATCH RFC v2 13/28] ARM: entry: Create user_mode_enter/exit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-13-573519abef38@linaro.org>
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



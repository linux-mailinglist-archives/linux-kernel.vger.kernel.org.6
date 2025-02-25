Return-Path: <linux-kernel+bounces-530954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196EA43A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93591888405
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CB267B76;
	Tue, 25 Feb 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZabU4A7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADF263C75
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477318; cv=none; b=Khhatvwk5RvdO8pSDInM0K+sX9UsIwo7tAlSTuGcBqOZILr5GLCWxKHXoNbkNjBGGwMiIForu7+8og6dyTbnIlcusRkIqapatP/MOu+ZWZvEdpyprV2FplilUwznMvd1fdYyI5MoFb7LkfP+b2D1LpvNDUh6hyTYRRFwLKJED0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477318; c=relaxed/simple;
	bh=Cm2W2dOXUniD0nDz2glOKlgTOVn7IEYQC1SwcPmOZAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDNKuLv1+LyfbQcsC2FFH08tcxeezaediXOxoB/O0j29oxfng7OAXhXEMi5OuRXBUJWTqJiHU8cDpMhYbI1k97tTXzk4N8BQWdGs2LMix2niMAr0JTBr84GRiU35Wi3v7ewpbvyVidd1JLxoIvGxLRvFIo0sJijcWNZihnGMCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZabU4A7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30795988ebeso56038971fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477315; x=1741082115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ugjh5wDawxRKPKlBJt/tVpltkHg0eR7Bu8LyZ1i/cWo=;
        b=pZabU4A7/oOqnzT4XOwDOUQwvwsu67OBQBIfH3pXJEgnC9rW4YzlBn3DXkIJibKDmr
         9A8cbs1opN3r6eC+/2ia5ukJoE0YD0QGx3QBt30LzqrxG3bwlcMoGBeyXmNEZ8pk6E/G
         xJY2YUjyA1Sgy6c7raEDw8yAPosQuSb9GrdpGXPofovCkE9QJFW6vQo6HyUxNcgLj3PU
         dW3kYA+DuUv/NbgJnBGbYmJHqKvK6CdXr0n4LVRgWxz8MmkLsNvV9/jYPxMPOo+oKhGC
         9bHLgRc0wieflFQOoctT2bcHJp1U38wEXOmhnKy1zzA1P4Fa2MPDTocnCpfmXtsdVYcp
         zxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477315; x=1741082115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugjh5wDawxRKPKlBJt/tVpltkHg0eR7Bu8LyZ1i/cWo=;
        b=nt5cW2Z0mSuK1cc/ArySp71vaHoOqHQpzUvzhFn8JkEE/SCiTVoWyZMQ1jPBdjbWwo
         As+N57toc3rY8Z9SGhEQzwaDLS6xbqOuQG1Kjqes9Xi9rvqp7Dz+KhwfsDE0jyieMC/1
         fxZCKL01MOk1Ih/QoZfIKOMbpdDzAnCDz7LQWYqcg5ditysY22PmrsmOctChUrFBTrSw
         PjTvFPF+Q661PwOh8TW7Sfiz95wG+xcYUaD0SZOEY7eioz2pu+SwnfOAgUL8JN9VNxYQ
         qPrysXgkQxQCP4/Rp7JIlLxURFE3sSkWndZkmn8BM40O5wgiqSUNRZzWVfvutvvC+Cxs
         7CYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGzK44n+pKjYurxjVRA6XW7UvIebRLTMX5WSy1EUoDHL1ZUY6z+bUH1LHEQJzWzW5TuGfmZQ3s6pGe4j4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5AJX/hBbdwJgzF5RrNKYx7oMqFnyjrK2NHym4DehfOVwjJRIY
	Z+QduRIFYcs8PIxNpgMFmEe1wA4ETQoeTSbqaDeXjS3rN4mEFvembt3mKN2tFV0=
X-Gm-Gg: ASbGncum9hXmAkF99B5P8s6lsyOWVuK/y8NugygWNVWsHAFoIYaZhxIVuAVm7MMEgbM
	EtC2MfTUbEK/xx35+x5prS9OT1/XYXbKReFqIc2cFdOywZCQr7Yr/JJ5d1tfRk3sxtl0bKUK3B1
	AEI9N2p2yh03EUBeKc5AWo0Xm34JqJcdrkMwL8IsEpIQmP+0RL6k0DsVSHHnARqpKLNy5C8EdWk
	puQiITjM30/MsePkniIu2snUN/rSAUFewqEsxZsncN4RAQcOQZzPTtq6+6yHfq2cud+guiX5Nvk
	4FdD+lfmSK6lHr+UQW21JgZJtQabhKCEVSOu
X-Google-Smtp-Source: AGHT+IGqkcF8DuM2/ZHDNxMpAtKrMC3XCNpt2RI/Sl+BYKODnNKv6ouUbi026+ezhu+8diXjeteQjw==
X-Received: by 2002:a05:6512:10c8:b0:545:17b:3cf9 with SMTP id 2adb3069b0e04-548510ed5f5mr1084027e87.48.1740477314909;
        Tue, 25 Feb 2025 01:55:14 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:14 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:00 +0100
Subject: [PATCH v5 13/31] ARM: entry: Create user_mode_enter/exit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-13-2f02313653e5@linaro.org>
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
index 0000000000000000000000000000000000000000..e26f369375ca3cf762f92fb499657a666b223ca2
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
index 69ddf51081f4791982518d37df60c11211b8955a..dd45c6eb8cbdd2595edc4f26026c12b25dd49717 100644
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
index ef6a657c8d130663e68acd07226815ce8a3fff7d..93a37437a9520118eff411f009e8f6bd729412fc 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -406,7 +406,7 @@ ENDPROC(__fiq_abt)
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
-	ct_user_exit save = 0
+	asm_irqentry_enter_from_user_mode save = 0
 	.endif
 	.endm
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f1e48002bd3075ea67b5883178583127fa0055c6..ff1dd3169346f3770cad6b7e218f5d74ffc646fe 100644
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
index 52b4fa97226dbfa4b55aca8eaf74ae24e1e220f8..fb5bb019199b2871e29e306a29bea8fdf47dd7f3 100644
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
index 0000000000000000000000000000000000000000..8b2e8ea66c1376759d6c0c14aad8728895b3ff1e
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
2.48.1



Return-Path: <linux-kernel+bounces-530972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FABA43A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9D0171613
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AC26A1C5;
	Tue, 25 Feb 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsQkA3ug"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E826A0A9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477338; cv=none; b=lrJHLg/eg65PPb0Ft7AEpbnx+ZDb0pY9olI3hSs+KzRd1gzPURA6DurWVk8WhWZWymbRnSnXLUvjORJwTHKq0jX/wBzvYE1dkg7MvsKPw2wE61xWm0KyOMvneYa3iMG8bEIeYDNT+2WhKqNAeJEXce8pHbdu8TPZ2bC0Gn97jrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477338; c=relaxed/simple;
	bh=lX4qxRLBXNpOAjk4fd3zFuvKNpAg99aRB3Y6YiAkTsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFGTkpRJePhSqzzBeQMBnyUH3QddtGEpl0z6KtTsvAn659XrPffou+v2X6jCUvnnv+8ZVOheIV9ePhBiJQUWbM/lDnP0sKK9fj1NqL29KyzihgFY6r4WayGfw09mwprL5BRpP+eniBV6G9zrqlpzBENJzKG956d3e4bwbsCwpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dsQkA3ug; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5484fa1401cso1187451e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477333; x=1741082133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG0/vjAYb5Ulc6jjnKhm2XeOXEYOwE4Q8HmW4VgPla8=;
        b=dsQkA3ugKwMDalkaUM1OS3V8eH1xq7pdaB/eCzIX/afYSseTBNg+ij+NczfzWCa5hy
         FIAR7IcYVXiq6lUpQguiy8B/AlTjmL37wB7wzKHlzE43mRxzToNYES/pL4jHUeXwa29h
         kxp7HKgSWIKVWGXq49EsC3aDd5guwTHTQ8w2Wq/+t+nuw6qRmTvnppVw1jM7Nb/pWqux
         2R+Vadsvvwa54yLgQLa0zIB2ZnsFOlGGVZlHsbwKpygzZGhdxOP9ChK2/D04wQmlLJhE
         HFwPiWvhTMY2WrPcCSXY6weqnukLUJxEuuuv/i+jVU+Rl528F4uKGEiWdVYZKsEvdABZ
         mouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477333; x=1741082133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG0/vjAYb5Ulc6jjnKhm2XeOXEYOwE4Q8HmW4VgPla8=;
        b=VnBU9R5vAAyoLhGmIi7pv+0ekbRokvmNh1Fm1PYQsfL+zAHTNEXJjf8irSaxXmRIRU
         0CmdKNyj+tFLAAKUVKNbK0PgQJhG+hgSF65ymyHPlBgxRYnZD2SgGsbHzhgqOplFoDfK
         XdgeWHgzpMqS3I/5Zvi14wHAJ2+H7TMkqy7P6laTLXCkEioSaXvoqxnabON1d1tGskJF
         NdsFRKsPNHvfayhqVhH6OUAVeddOqysiVpssjsl7Oh25VirUMXJGz83AiSygWNrkehHk
         vHcFAy8Q7afwv4mJYby8cucONHOrZumNCnSqMUUsVxUGWVlTiqTmy5u48HdrtaCghKo4
         SecQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdq3xbmN5+ZyYwdAC+bH/WHu0T+3mO7yKDsB4tNrbhO15xXc0uP59sS9/56pBXX8Xwa3SEHnxg3CS+pBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfwVFzzh7MeUMqtgR5hciL5UI+TSEL6mYukLByOT6lCwY2fOs
	XZ9bsgqhugVBXh6yiMnr9yAH/m5IPGsTBK/cVLuSu6UKhDKlzOGt1Uyf8sYMU7Q=
X-Gm-Gg: ASbGncssRefgKkQUvFfeH52ztIubSKZdfwZmsNqTov04/F6H1Qza4I2OGNtbj+qGeYh
	vKwxkeXZpif8nY5aChz5KQkMLkwH0UQCs5zvow+H0LN4qhRNPI00zQlaWBA+JZ7GfJFQWMMmeis
	quC3mpqh3+k/yXWnOfNgU9XZzbkQO34YekiWLugQ0lbzJ/tN8/LRdQ5f6ukx1mb+GRJg1tujhMb
	BYx8UXWaDgQ5XB0dVzbHBS4gi2Iv3NP/tMOjR915oiZND9ELJlxTZucKt+MzsmToknmm/VBvFpb
	7eQtoh0TK+H4uScNX9yZLqmyuQ7XrybdZcgA
X-Google-Smtp-Source: AGHT+IH5uBgAMA9dHOegGGT93vBd6r8QwClPslh2DXLtCCBanyA3O0/Gp1EuUpD/mB0oY2I3FDeTFQ==
X-Received: by 2002:a05:6512:104e:b0:546:2ea9:6666 with SMTP id 2adb3069b0e04-54838f4e48emr8380278e87.34.1740477333117;
        Tue, 25 Feb 2025 01:55:33 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:32 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:16 +0100
Subject: [PATCH v5 29/31] ARM: entry: Handle dabt, pabt, and und as
 interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-29-2f02313653e5@linaro.org>
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

While it isn't entirely intuitive, it appears that any kind
of exception such as data or prefetch abort ("page faults")
need to be handled as some kind of "interrupts" when using
generic entry. At least this is what other platforms are doing.

The same goes for undefined instruction handling, i.e.
floating point emulation in the kernel (und-exceptions).

This is necessary for the context checking to pass: without
this patch, a whole slew of warnings start to trigger
from syscall_exit_to_user_mode_prepare()
CT_WARN_ON(ct_state() != CT_STATE_KERNEL), i.e. syscalls
seems to exit from user mode to user mode (not good),
because the page faults screws up the context tracker.

This patch restores the order.

If this seems like the previous patch introduces a
regression that is then fixed in this patch, it can simply
be squashed into the former: having this rewrite separately
surely makes development and review easier.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h |  3 +++
 arch/arm/include/asm/traps.h |  2 +-
 arch/arm/kernel/entry-armv.S |  7 +++----
 arch/arm/kernel/entry.c      | 31 +++++++++++++++++++++++++++++++
 arch/arm/kernel/traps.c      |  2 +-
 arch/arm/mm/abort-ev4.S      |  2 +-
 arch/arm/mm/abort-ev4t.S     |  2 +-
 arch/arm/mm/abort-ev5t.S     |  4 ++--
 arch/arm/mm/abort-ev5tj.S    |  6 +++---
 arch/arm/mm/abort-ev6.S      |  2 +-
 arch/arm/mm/abort-ev7.S      |  2 +-
 arch/arm/mm/abort-lv4t.S     | 36 ++++++++++++++++++------------------
 arch/arm/mm/abort-macro.S    |  2 +-
 arch/arm/mm/abort-nommu.S    |  2 +-
 arch/arm/mm/fault.c          |  4 ++--
 arch/arm/mm/fault.h          |  8 ++++----
 arch/arm/mm/pabort-legacy.S  |  2 +-
 arch/arm/mm/pabort-v6.S      |  2 +-
 arch/arm/mm/pabort-v7.S      |  2 +-
 19 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index df2dd14ab51a586b83b6da6bbf9bd99858c1ddf4..de722084d5309194e02cb87db64ec32b9e6cd627 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -4,6 +4,9 @@
 
 struct pt_regs;
 
+void arm_und_handler(struct pt_regs *regs);
+void arm_dabt_handler(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
+void arm_pabt_handler(unsigned long addr, unsigned int ifsr, struct pt_regs *regs);
 void arm_irq_handler(struct pt_regs *regs, int mode);
 void arm_fiq_handler(struct pt_regs *regs);
 void arm_exit_to_user_mode(struct pt_regs *regs);
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index f8695104c72f2f450092839c7c50920e540e594b..0ca98271e10a210225c1714f5b24668cebab2def 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -37,7 +37,7 @@ extern void ptrace_break(struct pt_regs *regs);
 extern void *vectors_page;
 
 asmlinkage void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl);
-asmlinkage void do_undefinstr(struct pt_regs *regs);
+void do_undefinstr(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason);
 int arm_syscall(int no, struct pt_regs *regs);
 asmlinkage void baddataabort(int code, unsigned long instr, struct pt_regs *regs);
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 498a22f5fa8a6516d1eab584f0523c3d6c6e4926..ae2f952beea7611f0abc7bd299fc944335a21219 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -230,7 +230,7 @@ __und_fault:
 	ldr	r2, [r0, #S_PC]
 	sub	r2, r2, r1
 	str	r2, [r0, #S_PC]
-	b	do_undefinstr
+	b	arm_und_handler
 ENDPROC(__und_fault)
 
 	.align	5
@@ -449,9 +449,8 @@ __pabt_usr:
 ENTRY(ret_from_exception)
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
-	get_thread_info tsk
-	mov	why, #0
-	b	ret_to_user
+	disable_irq_notrace
+	b	ret_to_user_from_irq
  UNWIND(.fnend		)
 ENDPROC(__pabt_usr)
 ENDPROC(ret_from_exception)
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 08b8680233e5aae6e477f9bf15d7f06d7fd3e5af..01e4339ccdb4951e04a89fb91ad7c6e1991e09af 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -8,8 +8,39 @@
 #include <linux/percpu.h>
 #include <linux/rseq.h>
 #include <asm/stacktrace.h>
+#include <asm/traps.h>
 
 #include "irq.h"
+#include "../mm/fault.h"
+
+noinstr asmlinkage void arm_und_handler(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	do_undefinstr(regs);
+
+	irqentry_exit(regs, state);
+}
+
+noinstr asmlinkage void arm_dabt_handler(unsigned long addr, unsigned int fsr,
+					 struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	do_DataAbort(addr, fsr, regs);
+
+	irqentry_exit(regs, state);
+}
+
+noinstr asmlinkage void arm_pabt_handler(unsigned long addr, unsigned int ifsr,
+					 struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	do_PrefetchAbort(addr, ifsr, regs);
+
+	irqentry_exit(regs, state);
+}
 
 static void noinstr handle_arm_irq(void *data)
 {
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 57e74b49c52533babe177a8a2e0160a83c9bde05..d3a689bd05955f1ae46a6341e456bb097e831311 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -449,7 +449,7 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 	return fn ? fn(regs, instr) : 1;
 }
 
-asmlinkage void do_undefinstr(struct pt_regs *regs)
+noinstr void do_undefinstr(struct pt_regs *regs)
 {
 	unsigned int instr;
 	void __user *pc;
diff --git a/arch/arm/mm/abort-ev4.S b/arch/arm/mm/abort-ev4.S
index a10bcb89594dd38ce31ca30bf97d68cf421afc42..68d8ae2f4e9c0955c9f08112b4ff1887867d550a 100644
--- a/arch/arm/mm/abort-ev4.S
+++ b/arch/arm/mm/abort-ev4.S
@@ -24,4 +24,4 @@ ENTRY(v4_early_abort)
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
-	b	do_DataAbort
+	b	arm_dabt_handler
diff --git a/arch/arm/mm/abort-ev4t.S b/arch/arm/mm/abort-ev4t.S
index 14743a2f6997fcae0eeb55f53dec07b7b2ec227c..76c6cfa79e2a32e34b6f35a15c71c1af407956f3 100644
--- a/arch/arm/mm/abort-ev4t.S
+++ b/arch/arm/mm/abort-ev4t.S
@@ -25,4 +25,4 @@ ENTRY(v4t_early_abort)
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ check write
 	orreq	r1, r1, #1 << 11
-	b	do_DataAbort
+	b	arm_dabt_handler
diff --git a/arch/arm/mm/abort-ev5t.S b/arch/arm/mm/abort-ev5t.S
index 98c523118820798668bf04d065ad86ea05fb6d2c..fda1e54debc44b380fb3f3af95c1f198a9cc008a 100644
--- a/arch/arm/mm/abort-ev5t.S
+++ b/arch/arm/mm/abort-ev5t.S
@@ -25,7 +25,7 @@ ENTRY(v5t_early_abort)
 	uaccess_disable ip			@ disable user access
 	bic	r1, r1, #1 << 11		@ clear bits 11 of FSR
 	teq_ldrd tmp=ip, insn=r3		@ insn was LDRD?
-	beq	do_DataAbort			@ yes
+	beq	arm_dabt_handler			@ yes
 	tst	r3, #1 << 20			@ check write
 	orreq	r1, r1, #1 << 11
-	b	do_DataAbort
+	b	arm_dabt_handler
diff --git a/arch/arm/mm/abort-ev5tj.S b/arch/arm/mm/abort-ev5tj.S
index fec72f4fbaf508597d826e58d0dc084ee6e58dd0..a786a7d69e6ae23aa1125ccd41deaaaa743601e1 100644
--- a/arch/arm/mm/abort-ev5tj.S
+++ b/arch/arm/mm/abort-ev5tj.S
@@ -22,12 +22,12 @@ ENTRY(v5tj_early_abort)
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r5, #PSR_J_BIT			@ Java?
-	bne	do_DataAbort
+	bne	arm_dabt_handler
 	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
 	ldreq	r3, [r4]			@ read aborted ARM instruction
 	uaccess_disable ip			@ disable userspace access
 	teq_ldrd tmp=ip, insn=r3		@ insn was LDRD?
-	beq	do_DataAbort			@ yes
+	beq	arm_dabt_handler			@ yes
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
-	b	do_DataAbort
+	b	arm_dabt_handler
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index 836dc1299243415faaac1a93dce35ac46ae1a7da..2366236053eb86484cb179ff572f06db6559426b 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -42,4 +42,4 @@ ENTRY(v6_early_abort)
 	orreq	r1, r1, #1 << 11		@ yes.
 #endif
 1:	uaccess_disable ip			@ disable userspace access
-	b	do_DataAbort
+	b	arm_dabt_handler
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index 53fb41c24774db985eddc370904aa7666527f538..72b6eba101555651d7afd749fd5d7715a2964372 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -18,5 +18,5 @@ ENTRY(v7_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 	uaccess_disable ip			@ disable userspace access
-	b	do_DataAbort
+	b	arm_dabt_handler
 ENDPROC(v7_early_abort)
diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index fbd60a120f6684c56c63cea10b00200765473f1d..3fef9c1479c17bb07652e43e0b8b0683e00c4b2f 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -46,8 +46,8 @@ ENTRY(v4t_late_abort)
 /* 9 */	b	.data_arm_ldmstm		@ ldm*b	rn, <rlist>
 /* a */	b	.data_unknown
 /* b */	b	.data_unknown
-/* c */	b	do_DataAbort			@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
-/* d */	b	do_DataAbort			@ ldc	rd, [rn, #m]
+/* c */	b	arm_dabt_handler		@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
+/* d */	b	arm_dabt_handler		@ ldc	rd, [rn, #m]
 /* e */	b	.data_unknown
 /* f */	b	.data_unknown
 
@@ -60,7 +60,7 @@ ENTRY(v4t_late_abort)
 
 .data_arm_ldmstm:
 	tst	r8, #1 << 21			@ check writeback bit
-	beq	do_DataAbort			@ no writeback -> no fixup
+	beq	arm_dabt_handler		@ no writeback -> no fixup
 	str	r9, [sp, #-4]!
 	mov	r7, #0x11
 	orr	r7, r7, #0x1100
@@ -81,11 +81,11 @@ ENTRY(v4t_late_abort)
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
 	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	ldr	r9, [sp], #4
-	b	do_DataAbort
+	b	arm_dabt_handler
 
 .data_arm_lateldrhpre:
 	tst	r8, #1 << 21			@ Check writeback bit
-	beq	do_DataAbort			@ No writeback -> no fixup
+	beq	arm_dabt_handler		@ No writeback -> no fixup
 .data_arm_lateldrhpost:
 	str	r9, [sp, #-4]!
 	and	r9, r8, #0x00f			@ get Rm / low nibble of immediate value
@@ -101,14 +101,14 @@ ENTRY(v4t_late_abort)
 	addeq	r7, r7, r6			@ Undo decrement
 	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	ldr	r9, [sp], #4
-	b	do_DataAbort
+	b	arm_dabt_handler
 
 .data_arm_lateldrpreconst:
 	tst	r8, #1 << 21			@ check writeback bit
-	beq	do_DataAbort			@ no writeback -> no fixup
+	beq	arm_dabt_handler		@ no writeback -> no fixup
 .data_arm_lateldrpostconst:
 	movs	r6, r8, lsl #20			@ Get offset
-	beq	do_DataAbort			@ zero -> no fixup
+	beq	arm_dabt_handler		@ zero -> no fixup
 	str	r9, [sp, #-4]!
 	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
@@ -117,11 +117,11 @@ ENTRY(v4t_late_abort)
 	addeq	r7, r7, r6, lsr #20		@ Undo decrement
 	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	ldr	r9, [sp], #4
-	b	do_DataAbort
+	b	arm_dabt_handler
 
 .data_arm_lateldrprereg:
 	tst	r8, #1 << 21			@ check writeback bit
-	beq	do_DataAbort			@ no writeback -> no fixup
+	beq	arm_dabt_handler		@ no writeback -> no fixup
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
 	ldr	r6, [r2, r7, lsl #2]		@ Get register 'Rm'
@@ -180,10 +180,10 @@ ENTRY(v4t_late_abort)
 /* 3 */	b	.data_unknown
 /* 4 */	b	.data_unknown
 /* 5 */	b	.data_thumb_reg
-/* 6 */	b	do_DataAbort
-/* 7 */	b	do_DataAbort
-/* 8 */	b	do_DataAbort
-/* 9 */	b	do_DataAbort
+/* 6 */	b	arm_dabt_handler
+/* 7 */	b	arm_dabt_handler
+/* 8 */	b	arm_dabt_handler
+/* 9 */	b	arm_dabt_handler
 /* A */	b	.data_unknown
 /* B */	b	.data_thumb_pushpop
 /* C */	b	.data_thumb_ldmstm
@@ -193,10 +193,10 @@ ENTRY(v4t_late_abort)
 
 .data_thumb_reg:
 	tst	r8, #1 << 9
-	beq	do_DataAbort
+	beq	arm_dabt_handler
 	tst	r8, #1 << 10			@ If 'S' (signed) bit is set
 	movne	r1, #0				@ it must be a load instr
-	b	do_DataAbort
+	b	arm_dabt_handler
 
 .data_thumb_pushpop:
 	tst	r8, #1 << 10
@@ -217,7 +217,7 @@ ENTRY(v4t_late_abort)
 	subne	r7, r7, r6, lsl #2		@ decrement SP if POP
 	str	r7, [r2, #13 << 2]
 	ldr	r9, [sp], #4
-	b	do_DataAbort
+	b	arm_dabt_handler
 
 .data_thumb_ldmstm:
 	str	r9, [sp, #-4]!
@@ -234,4 +234,4 @@ ENTRY(v4t_late_abort)
 	sub	r7, r7, r6, lsl #2		@ always decrement
 	str	r7, [r2, r9, lsr #6]
 	ldr	r9, [sp], #4
-	b	do_DataAbort
+	b	arm_dabt_handler
diff --git a/arch/arm/mm/abort-macro.S b/arch/arm/mm/abort-macro.S
index bacf53fd0b70c6307e74ef8601d8dcc7db292700..30bb5e2135862902951b5077b0b860fd12ed8c28 100644
--- a/arch/arm/mm/abort-macro.S
+++ b/arch/arm/mm/abort-macro.S
@@ -20,7 +20,7 @@
 	orreq	\tmp, \tmp, #1 << 11		@ Set L-bit if yes
 	tst	\tmp, #1 << 11			@ L = 0 -> write
 	orreq	\fsr, \fsr, #1 << 11		@ yes.
-	b	do_DataAbort
+	b	arm_dabt_handler
 not_thumb:
 	.endm
 
diff --git a/arch/arm/mm/abort-nommu.S b/arch/arm/mm/abort-nommu.S
index 6e2366a263219b379f4fdb43cc8e5413fb36e52a..573a09529ac7794f8004680ab350750de7c8e15d 100644
--- a/arch/arm/mm/abort-nommu.S
+++ b/arch/arm/mm/abort-nommu.S
@@ -17,5 +17,5 @@
 ENTRY(nommu_early_abort)
 	mov	r0, #0				@ clear r0, r1 (no FSR/FAR)
 	mov	r1, #0
-	b	do_DataAbort
+	b	arm_dabt_handler
 ENDPROC(nommu_early_abort)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ab01b51de5590bff6c2acaf446d01c589a5f7987..78afb701b34a17d8d841762944eb5f8af6843dc4 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -588,7 +588,7 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
 /*
  * Dispatch a data abort to the relevant handler.
  */
-asmlinkage void
+void
 do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
@@ -618,7 +618,7 @@ hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *
 	ifsr_info[nr].name = name;
 }
 
-asmlinkage void
+void
 do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = ifsr_info + fsr_fs(ifsr);
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index e8f8c190254442a015a6cbc179602589cfddb0ea..36a7e7138c310a8311458207d2b694cb44c63b93 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -37,9 +37,9 @@ static inline int fsr_fs(unsigned int fsr)
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 void early_abt_enable(void);
-asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
-			     struct pt_regs *regs);
-asmlinkage void do_PrefetchAbort(unsigned long addr, unsigned int ifsr,
-				 struct pt_regs *regs);
+void do_DataAbort(unsigned long addr, unsigned int fsr,
+		  struct pt_regs *regs);
+void do_PrefetchAbort(unsigned long addr, unsigned int ifsr,
+		      struct pt_regs *regs);
 
 #endif	/* __ARCH_ARM_FAULT_H */
diff --git a/arch/arm/mm/pabort-legacy.S b/arch/arm/mm/pabort-legacy.S
index b2ffce4201062e3ec2045364ddc454cf706bab8d..26c62e568638d37133661f4f5b8dec430593f8eb 100644
--- a/arch/arm/mm/pabort-legacy.S
+++ b/arch/arm/mm/pabort-legacy.S
@@ -18,5 +18,5 @@
 ENTRY(legacy_pabort)
 	mov	r0, r4
 	mov	r1, #5
-	b	do_PrefetchAbort
+	b	arm_pabt_handler
 ENDPROC(legacy_pabort)
diff --git a/arch/arm/mm/pabort-v6.S b/arch/arm/mm/pabort-v6.S
index 8686265dc9418b29381942bfd87a937a3234d46e..25abd11a35253bf464fe9fd7fc14fd11bc564dcd 100644
--- a/arch/arm/mm/pabort-v6.S
+++ b/arch/arm/mm/pabort-v6.S
@@ -18,5 +18,5 @@
 ENTRY(v6_pabort)
 	mov	r0, r4
 	mrc	p15, 0, r1, c5, c0, 1		@ get IFSR
-	b	do_PrefetchAbort
+	b	arm_pabt_handler
 ENDPROC(v6_pabort)
diff --git a/arch/arm/mm/pabort-v7.S b/arch/arm/mm/pabort-v7.S
index 9c70b1a21dc9204f24524df9905fbc077a82f2dc..e05c7d44d307adeba6759213374b2aa328c693da 100644
--- a/arch/arm/mm/pabort-v7.S
+++ b/arch/arm/mm/pabort-v7.S
@@ -18,5 +18,5 @@
 ENTRY(v7_pabort)
 	mrc	p15, 0, r0, c6, c0, 2		@ get IFAR
 	mrc	p15, 0, r1, c5, c0, 1		@ get IFSR
-	b	do_PrefetchAbort
+	b	arm_pabt_handler
 ENDPROC(v7_pabort)

-- 
2.48.1



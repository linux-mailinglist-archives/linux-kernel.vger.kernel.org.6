Return-Path: <linux-kernel+bounces-530956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3F2A43A71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDA83AA5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB526773C;
	Tue, 25 Feb 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wU7HQsdX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73F267B6B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477321; cv=none; b=VMtKx9wh/oi2MTqyP7RkfrUKTUrWzE2td1u2fZedr2xkX53McoKG4G4RsjneKRSQBRDFdI++CXK/lGpCk6rJYaZp7b6w2eSbC9+PYkH4OeVBqAIjOr0feGJFeBMuc4l+G5CozUhfUP4UeuGCHk/AgfWv/TURh+FKkb4T2lQHvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477321; c=relaxed/simple;
	bh=QsEh4Kq3Nh4Enz/jpo47A8dhwzkGmSSaMao58QTOPb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olQDtaWWtdVej5htw5LPI6z5wWnJR1oE8iJCNKdnyWk3b3eI0KoJNghIlkIXtWRKVswj+GcGtFBlG5PHeR77x9+yOw5vI7MCecvWMQPDkp9U0plWmjYO9OilgT3LUp/mkH9DDjCwhCdsK32Sbl/Ue+IQqeBVMoShSRqIVv4+ivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wU7HQsdX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548430564d9so3040032e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477317; x=1741082117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l4jcdIT0+K6QMNd0VK8RPhMVALn2TkHG1rRCOsPTks=;
        b=wU7HQsdXKZVzXLIBM7EQT81caKS1wr+ZkB+R1cg+B60v6vS4nGXtZy/JUYrQVKU87t
         Dt7NOz67GTfMJ8YEmmPbsyUwMS2tXOmtqj2+8r5qDA11YNT+74s2Jo96EIvZm5ZBJzjl
         /o4cogQX6GzeZqqR9QvXe+ddIEuQAyqOG/2aYNfDrJr/txcThnvWX9sYc6B8WbQCCsOv
         PyXT0WD53afEFnGA6ATXxU/ru54CR5r1vCbyaMcr1Nl8GNuhNIagANDA4TNAU82bnu4I
         1UZpFEZQuI4WzwvwpZZtdWSZ1gJbL0qISO9T1PF0ezr91pzI7WuU3VCN8n7ZWLs5tvNl
         D4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477317; x=1741082117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l4jcdIT0+K6QMNd0VK8RPhMVALn2TkHG1rRCOsPTks=;
        b=tuTsw6ImRnXQeUptwYU5EF+NdkC7cAc6xqq/JbK22iSJWuE7dvXjZW6adkKSaykK/7
         wt9I6/38UYdqeTu3fpClEtcBAj8Qhpmbnoky75+C1YQGP0Z8maWcks/v5IFvcO/G37a1
         CaGnJ7oQVCw1+uQxNJoUF9sgRY1H8x+kCwqFBBwmj20kbv18I1v8YER5Vf/YlNNN7+lG
         LOPQ5Wp2sm1bRI271RJXdKU375MF0xzFaam8E+o0qhN01YXOhxDwknFAbpKNbYEfOhNX
         METOxwrTL7ctMa1CowCzGw+mI0RapCgM+aHWDY504PMfXzRQwDjX7bVXZdJrchyY9raZ
         EsVw==
X-Forwarded-Encrypted: i=1; AJvYcCUpzMy9IHwWADk4QAO4kxE0fOea2q28DOYu9IBA+EgsIdBVf25yZeq+c+ZWLN3xddGBcNnJPILEy6ngX98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdO5xdSQgIzA3YxPbx3mBuQanhX8qxd/oOh1h0UFz2xuDPUxA
	Rx0NHTfmmWlyLoAN9DT9DpfXHitsZHy87EfC2FNa8PFE1mbNLEDqFaQDVo2bnzM=
X-Gm-Gg: ASbGnct3U3d8mF1DY/NO2Vwl7rfvu0iDy7IWpQrVf/odHfDz5P4cYb91LWPmbAqNsKP
	O70NcN4w1JbDRG8koGB1faPhHllN282eRP2P3ALosb/wnYMSU129CUZBaE9TENClPWd82dkKM7G
	gnQTnYWeeu3XesE3TCuh2rn8OjqRTOsyHB/pVbf7npBQ8SNEwWOih3XRvMPmr24Pp9kEHFU51x9
	8D+g/uGWsydqHObvNKoErANZywzn+u/ggE4STF6OsIT+2RsbUZihMRYqJ17J11kVXxFH729mGNA
	woDMwjPYPjdYbLwoEpa65ZXJVmuaZOMSa6Bq
X-Google-Smtp-Source: AGHT+IHtmonsQI8mjfkxDPF9rkkwlOMD+FnaR5UIKDlAt4SXZ1OQl3Nrl9JuRZs/P07o5ZESbealNQ==
X-Received: by 2002:a05:6512:b98:b0:545:16fe:536a with SMTP id 2adb3069b0e04-548391452a9mr7078517e87.31.1740477317024;
        Tue, 25 Feb 2025 01:55:17 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:16 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:02 +0100
Subject: [PATCH v5 15/31] ARM: entry: Separate call path for syscall SWI
 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-15-2f02313653e5@linaro.org>
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

The syscalls (SWIs, software interrupts) are deviating from how
any other interrupts are handled as they enable the IRQs again
while processing the syscall, while "hard" IRQs disable all
interrupts until they are handled.

Break out syscall_enter_from_user_mode() into its own function
and call it instead of irqentry_enter_from_user_mode().

As we are moving toward generic entry, we use the signature
from the generic function.

As the generic function requires the syscall number to be
determined, we move the call down below the code that
figures out the syscall number, the only practical effect
should be that interrupts are re-enabled a few instructions
later.

As we move the trace_hardirqs_on/off() calls into C, we can
just get rid of the helper macro usr_entry_enter again and
call asm_irqentry_enter_from_user_mode directly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   |  1 +
 arch/arm/kernel/entry-armv.S   | 16 ++++------------
 arch/arm/kernel/entry-common.S | 18 +++++++++++++-----
 arch/arm/kernel/entry.c        | 14 ++++++++++++++
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index e26f369375ca3cf762f92fb499657a666b223ca2..e259b074caef75c7f777b18199623f07bebee5b4 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -8,6 +8,7 @@ struct pt_regs;
  * These are copies of generic entry headers so we can transition
  * to generic entry once they are semantically equivalent.
  */
+long syscall_enter_from_user_mode(struct pt_regs *regs, long);
 void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c71110126fc105fc6ac2d6cb0f5f399b4c8b1548..6edf362ab1e1035dafebf6fb7c55db71462c1eae 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -403,14 +403,6 @@ ENDPROC(__fiq_abt)
 	zero_fp
 	.endm
 
-	/* Called after usr_entry for everything except FIQ */
-	.macro	usr_entry_enter
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-	asm_irqentry_enter_from_user_mode save = 0
-	.endm
-
 	.macro	kuser_cmpxchg_check
 #if !defined(CONFIG_CPU_32v6K) && defined(CONFIG_KUSER_HELPERS)
 #ifndef CONFIG_MMU
@@ -430,7 +422,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -441,7 +433,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -455,7 +447,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -480,7 +472,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index ff1dd3169346f3770cad6b7e218f5d74ffc646fe..14b2495cae3c2f95b0dfecd849b4e16ec143dbe9 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -109,8 +109,6 @@ ENTRY(ret_to_user_from_irq)
 	movs	r1, r1, lsl #16
 	bne	slow_work_pending
 no_work_pending:
-	asm_trace_hardirqs_on save = 0
-
 	asm_irqentry_exit_to_user_mode save = 0
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
@@ -189,9 +187,6 @@ ENTRY(vector_swi)
 	reload_current r10, ip
 	zero_fp
 	alignment_trap r10, ip, cr_alignment
-	asm_trace_hardirqs_on save=0
-	enable_irq_notrace
-	asm_irqentry_enter_from_user_mode save = 0
 
 	/*
 	 * Get the system call number.
@@ -256,6 +251,19 @@ ENTRY(vector_swi)
 #else
 	str	scno, [tsk, #TI_ABI_SYSCALL]
 #endif
+
+	/*
+	 * Calling out to C to be careful to save and restore registers.
+	 * This call could modify the syscall number. scno is r7 so we
+	 * do not save and restore r7.
+	 */
+	mov	r0, sp				@ regs
+	mov	r1, scno
+	push	{r4 - r6, r8 - r10, lr}
+	bl	syscall_enter_from_user_mode
+	pop	{r4 - r6, r8 - r10, lr}
+	mov	scno, r0
+
 	mov	r1, sp				@ put regs into r1
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 	mov	r0, tbl
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 8b2e8ea66c1376759d6c0c14aad8728895b3ff1e..1973947c7ad753fccd694b3ef334fba1326f58b6 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -1,15 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/entry.h>
 #include <linux/context_tracking.h>
+#include <linux/irqflags.h>
+
+long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	trace_hardirqs_on();
+	local_irq_enable();
+	/* This context tracking call has inverse naming */
+	user_exit_callable();
+
+	/* This will optionally be modified later */
+	return syscall;
+}
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
+	trace_hardirqs_off();
 	/* This context tracking call has inverse naming */
 	user_exit_callable();
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
+	trace_hardirqs_on();
 	/* This context tracking call has inverse naming */
 	user_enter_callable();
 }

-- 
2.48.1



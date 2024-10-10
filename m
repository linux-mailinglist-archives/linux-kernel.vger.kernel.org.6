Return-Path: <linux-kernel+bounces-358899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2499851D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DCC1C243B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5421C4626;
	Thu, 10 Oct 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cni6dLyH"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A31CB52F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560063; cv=none; b=CsfFpO/jCGydAz6fbhDs4tufJrlIsp4MMK5NTyTlEsb/o1D16aPFSvRRxEup4b/acvg7I6irkLjwAPfn1Ck24q90X4lNkwTGNWuSxeztwmdgmvPTRbT//RGDz02jTCeN5HgEw1doFYhSVpuk98P3FuTrEZqq0hyk62HmwslkoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560063; c=relaxed/simple;
	bh=oB6HP3SopbCX1pJb2/iEaIAmUOMLymz+4GahfTzk35I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ongiox0DeKO9CQqdrpL+S8Ww0MiqDbvrLW9fST/bl0ZYYv+WNkiRCQZD3MDbQ3sWk0t8nyGV7MmzHXB4aoohFuinNAPbZTYwNAJNkjgVCytXsd9SbIr3NvKtTi11iw09H0NF74z0eZrrDpwAv7BUgepUqpetAGQCFOJ6AGwx8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cni6dLyH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99415adecaso340306066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560060; x=1729164860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gi2KcUYCbZkPlsUdwrNEo9QLrpmnXM+YJIWNYO7+o8Y=;
        b=cni6dLyHsCCvLlMUb4SeWPDVDfo+x1aGg30gbaF8IEP8hZE//4nJTX252D6PFkhrs/
         zogwdb+vNVJcamarzWoNHon4U395sr4iO3apMyRdVic7vrVlgv9cEfc9JT9GfPW5bFe9
         0Qyg/F8QzM2SOx2Kfyx8nf+etefaHL+aZ0AlIG+L0B2nrNLd2HLLm6CMD4/25vOLjcNU
         /bHVGFvDjVarlpQnQijKcYrdnz7qyhhxCDb6Waum7JGQubp/diWMvBl4iPm848L9DFQY
         y0/YIWYJ9ipDYprfbRSwJJN/R+2IX9pLX9f1mYAH0vdbMq14E350aYTuwdxp5BgIXcWp
         ON/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560060; x=1729164860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi2KcUYCbZkPlsUdwrNEo9QLrpmnXM+YJIWNYO7+o8Y=;
        b=w27mR13VoHuEO4iC45uiiK5AiAYMS8FbguXKyBRAPWF2eMF4meQFdYswPfVrSWJh45
         csGaoI9ttg5WpvtabWPAWFi4kFuqGQe+waBAkpVrajXdBYirYpu/gNLWV2C8rJAf6x0j
         vgHwG58N6XdqLNgdUc8p1i2RxjulqH2gf4ja0DL1T2019eGbehnOMPLTaoXhCwYwKdmi
         RVH1tYoiSWHulsid4cA9jlT0Ogd4XQTbtSk/U8E4rsmY2auhddZMaF6Fw6BnuAJTXSA8
         U4r3HmJWbFLlSxuVkSWB/n1uaMeO02pV+OrbgtB+AiZGFIjoyzet+Y0TZ6JUqmXhBhVk
         DIBA==
X-Forwarded-Encrypted: i=1; AJvYcCUoTei8x6O4AiCuBpUPwu8rcBKBRjiiILHZmJGhoaGnJre9i3z+RmafhhNqqB94ZDEMlUvymVpy+OClYDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjTXPAvgBQMzShGwRQkXXg9JMtKPp3qRpzfiYc4pc5AYcP0R8
	4H1ewQ1ZjPH3XdGAsnZ8kkAN2Na48vudIa4RXNILHYGYWAUshGC/qzDaSE+SYgs=
X-Google-Smtp-Source: AGHT+IG0T9Kw9rtdvh8MtWNWqvxS8ro6kLfwIAoOvd9amat2XPjlnHbF8UXzNiDyhtYS8hL41xf2rA==
X-Received: by 2002:a17:907:7f8e:b0:a8d:4954:c209 with SMTP id a640c23a62f3a-a99a13ae710mr266075066b.22.1728560060101;
        Thu, 10 Oct 2024 04:34:20 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:18 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:34:00 +0200
Subject: [PATCH RFC 22/28] ARM: entry: Move work processing to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-22-b94f451d087b@linaro.org>
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

At the end of a syscall software interrupt and every time we exit
an interrupt handler we check if there is work to do, i.e. if the
current thread (userspace or kernel daemon) has set the
_TIF_SYSCALL_WORK flag.

Move this processing over to the C entry code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 14 +-------------
 arch/arm/kernel/entry.c        | 10 ++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 33bc9e7c5b32..5385574c4339 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -42,19 +42,7 @@ ret_fast_syscall:
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
-	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
-	movs	r1, r1, lsl #16
-	beq	2f
-
-	tst	r1, #_TIF_SYSCALL_WORK
-	beq	1f
-
-	b	2f
-
-1:	mov	r0, sp				@ 'regs'
-	bl	do_work_pending
-
-2:	asm_irqentry_exit_to_user_mode
+	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 472338047337..0e3960844b94 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -1,10 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/entry.h>
+#include <asm/ptrace.h>
 #include <asm/signal.h>
 #include <linux/context_tracking.h>
 #include <linux/irqflags.h>
 #include <linux/rseq.h>
 
+static inline bool has_syscall_work(unsigned long flags)
+{
+	return unlikely(flags & _TIF_SYSCALL_WORK);
+}
+
 long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	trace_hardirqs_on();
@@ -18,8 +24,12 @@ long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
+	unsigned long flags = read_thread_flags();
+
 	rseq_syscall(regs);
 	local_irq_disable();
+	if (has_syscall_work(flags))
+		do_work_pending(regs, flags);
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)

-- 
2.46.2



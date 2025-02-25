Return-Path: <linux-kernel+bounces-530946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85511A43A64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0F83A339E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A38F5E;
	Tue, 25 Feb 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpSGkWkT"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42894265CBD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477309; cv=none; b=iORy4EeLidxJib9ksMlZu5Q55iGPzKLj5x26LyCzEIYkiTTkPO6yhesNZPPMlFvA+XY1XRDZ9gJ08TKDSCyxDxs6QhJezU12l/SSrmIQl5KpS46wrwGJnvK+Ao43BHc/JO9pFX9UfRXZ8WwBA+JfS89QmK105JvGnKn4++Egh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477309; c=relaxed/simple;
	bh=Ucfgbv6/pmNWaRtl2GyhPSA/IXKZfYpySVqt290mNxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsJaJFnMATkQqUoh/umo0dk00ktYTSyykFV02tlvviY10HFSi4AgtT1FK0jQHOprC9yWgpihqmiStOIHL5qTBmIkkg81OFt551oq36sxyNNekrn93Nm34XGHPcMYht007GplrosDw6rPmnl+Sy9TG1omfuwOE3/aJlWfi1rHT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xpSGkWkT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-546237cd3cbso5411837e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477305; x=1741082105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tokJWXMpPS52pGnN85+C7ykU4Uc3aikcglEb93YpSqg=;
        b=xpSGkWkTT/qrFXDM3cqAWiq8Zt48Pgwdcj2t+7/ZKj8XUPPvoruXDkSAQrIvv7idYI
         4FV+hVI7vifLC1RfJTz6DEZzk6Ghb46YyocMsQVPJ/74fRF7CkUsA6XEnNW1Gm3L+k4/
         1u3pY+KeBPXlUzZ4kWW+P6uXkTJvAvcljJv9ogr7OzcvWdRoEKMPAgea5LyzZ9Z4LX5n
         kF8kJ8LqWXuPGyDac5Srvq544eZbqVgI3wdP+xZadDPVEPDesKCLLTqKMa4zF0IaYzxV
         RDWu8vmW5MzyiQOXMbw6gHlScpUAtndIUf/KlSkAMvRqZPzmo7wuhFFPzqw3h2qRdLqJ
         1ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477305; x=1741082105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tokJWXMpPS52pGnN85+C7ykU4Uc3aikcglEb93YpSqg=;
        b=PXiO0KP7hf2qeEBAQttgzc1BZCrP8R49jBP7lViiemdIrx0VEjZYardl9IjrrsV3bR
         qdMn/zMI6e4gX/VTUhDkdo0GJUyYLXj6926prQyKW9fsG/eP/ACHkKHhKwDRDpLRtSxq
         31oq4990QuRFf5JgcX+Xp2w5gpz+OtXQY7qW4SvoSFw1mB/EVS2pGcsTHrMoudYKky53
         ok1xsBU1nQb/O0uDP+pxhlrp+gSsvkwL8d3MKCezODRA5TPS1qhTE6IKTEQC6fmYEsE9
         KMFvCyMe0N8PTqBcz9065lRtILU2TbgtPu+vmiTkx9l8JFZcGLjSOzUKGM9L86Q8LYan
         B2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVgP4nIkjceSrvl2PKEDa0vNGrwp/5Z9W56J5KcBdlwVL/DDhUfKZDEo3DYO9io9QKClCFFKAohulFTZYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYP7N8fHlIwucR3uI4XZrq1mw5g7EF0/rl/v4JN99txuiZbWv
	WTBFlbvITZBKuURZ+Pm5vhLV+6Hk77VTq0hhrQvS/q/A52skN1Y94UMds5yo03o=
X-Gm-Gg: ASbGnct1oEE4rUKtULhrj1N72P0ZUQtpdyAZ3a8s9yjfo5Cgk5iDl0u3xb9Gjakp75+
	BXgvscLLeE8aAvlK2LAQa1McoGaO0XqoCR7dtCF50KTTlZFlAjSdIw366UaVzg5YR7mxST7d7hq
	4EUYuF0qC3oh27k9HPgXAaq2vM7ihtZ4uJ4G5v05vpg/3DFlhwPO5mEKUckEt6uBy8/Js7A7P+M
	FTL91lsFf6zAHB0hxFsu7Fcm6T/OMkHpYK5+43GZLx4J3LQ9CtuYRD0l4IYzF3vsTuO/uxLR4+8
	aE3R1OHRybUxoqQ0zOcNAsH0c0M1hH0QGrhJ
X-Google-Smtp-Source: AGHT+IGAmJN5oP6/0azJ8UrklFwsjFNaH/XCFoS/k5MzdQEera2+lJew2uD4+v03oYKKl/xsUE50dA==
X-Received: by 2002:a05:6512:1305:b0:545:2b20:5b21 with SMTP id 2adb3069b0e04-54851109ba6mr924438e87.50.1740477305355;
        Tue, 25 Feb 2025 01:55:05 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:04 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:52 +0100
Subject: [PATCH v5 05/31] ARM: process: Remove local restart
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-5-2f02313653e5@linaro.org>
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

The ARM kernel contains a quirk to handle syscall restarts
inside the kernel without exiting to userspace. The generic
entry cannot handle this.

Rename do_signal() to arch_do_signal_or_restart() to fit
with the upcoming generic entry conversion.

This is essentially a revert of commit 81783786d5cf
"ARM: 7473/1: deal with handlerless restarts without leaving the kernel"
from 2012.

After the conversion to generic entry later in this series,
the local restart will be reimplemented again, but in C.

Link: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104733.html
Link: https://lore.kernel.org/all/1340377626-17075-1-git-send-email-will.deacon@arm.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/signal.h  |  3 +--
 arch/arm/kernel/entry-common.S |  9 +--------
 arch/arm/kernel/signal.c       | 28 +++++++++-------------------
 3 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/signal.h b/arch/arm/include/asm/signal.h
index 8b84092d151800cb4076672d1c31f0a83777d0d8..7acccc96840c8a17744cc3f2894f19d142aba4fd 100644
--- a/arch/arm/include/asm/signal.h
+++ b/arch/arm/include/asm/signal.h
@@ -24,7 +24,6 @@ typedef struct {
 #include <asm/sigcontext.h>
 
 void do_rseq_syscall(struct pt_regs *regs);
-int do_work_pending(struct pt_regs *regs, unsigned int thread_flags,
-		    int syscall);
+void do_work_pending(struct pt_regs *regs, unsigned int thread_flags);
 
 #endif
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index df6961a1006b7a0f3522728812bf52ccb849e511..da5c2d4b62e56cce644b15e329ab4149d69c5b79 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -86,14 +86,8 @@ ENDPROC(ret_fast_syscall)
 	bne	__sys_trace_return_nosave
 slow_work_pending:
 	mov	r0, sp				@ 'regs'
-	mov	r2, why				@ 'syscall'
 	bl	do_work_pending
-	cmp	r0, #0
-	beq	no_work_pending
-	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
-	str	scno, [tsk, #TI_ABI_SYSCALL]	@ make sure tracers see update
-	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
-	b	local_restart			@ ... and off we go
+	b	no_work_pending
 ENDPROC(ret_fast_syscall)
 
 /*
@@ -266,7 +260,6 @@ ENTRY(vector_swi)
 	 */
  TRACE(	ldmia	sp, {r0 - r3}		)
 
-local_restart:
 	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 79a6730fa0eb7d6581343bdbbeb6834dcaabb9f8..7b1a16e86b236575efdc29cda9b751e8e2a3f64e 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -18,6 +18,7 @@
 #include <asm/traps.h>
 #include <asm/unistd.h>
 #include <asm/vfp.h>
+#include <asm/syscall.h>
 #include <asm/syscalls.h>
 
 #include "signal.h"
@@ -534,9 +535,10 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
  * the kernel can handle, and then we build all the user-level signal handling
  * stack-frames in one go after that.
  */
-static int do_signal(struct pt_regs *regs, int syscall)
+static void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
+	bool syscall = (syscall_get_nr(current, regs) != -1);
 	struct ksignal ksig;
 	int restart = 0;
 
@@ -590,16 +592,14 @@ static int do_signal(struct pt_regs *regs, int syscall)
 	} else {
 		/* no handler */
 		restore_saved_sigmask();
-		if (unlikely(restart) && regs->ARM_pc == restart_addr) {
+		if (unlikely(restart) && regs->ARM_pc == restart_addr)
 			regs->ARM_pc = continue_addr;
-			return restart;
-		}
 	}
-	return 0;
+	return;
 }
 
-asmlinkage int
-do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
+asmlinkage void
+do_work_pending(struct pt_regs *regs, unsigned int thread_flags)
 {
 	/*
 	 * The assembly code enters us with IRQs off, but it hasn't
@@ -612,19 +612,10 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			schedule();
 		} else {
 			if (unlikely(!user_mode(regs)))
-				return 0;
+				return;
 			local_irq_enable();
 			if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
-				int restart = do_signal(regs, syscall);
-				if (unlikely(restart)) {
-					/*
-					 * Restart without handlers.
-					 * Deal with it without leaving
-					 * the kernel space.
-					 */
-					return restart;
-				}
-				syscall = 0;
+				arch_do_signal_or_restart(regs);
 			} else if (thread_flags & _TIF_UPROBE) {
 				uprobe_notify_resume(regs);
 			} else {
@@ -634,7 +625,6 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 		local_irq_disable();
 		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
-	return 0;
 }
 
 struct page *get_signal_page(void)

-- 
2.48.1



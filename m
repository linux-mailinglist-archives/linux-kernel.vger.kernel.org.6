Return-Path: <linux-kernel+bounces-511008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07705A324BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15A4165D70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625C20C487;
	Wed, 12 Feb 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y58r7dRE"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB620AF74
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359394; cv=none; b=pcU4qHMoqaCLqU2hrOBaLtKUbdtpIZpVpjsfhX+OvVokWo+JHkMx8DevPN3SlKvT1Nto9hWTzsaksUmGY+eG33iW96mNYCnJRWzZzbTaiABC4gVenETlgfUE+tHh0uSsMKStoKNIgJoTs3HubyyjNVmHhuSnNoh4egT9tNlbIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359394; c=relaxed/simple;
	bh=q4dNSKjwIFqbkAOUqPUF0yUYlI4QN8xkRxJDuP9QiXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGl0avoS+z/x2cjiqiflSUfreSfMAGfKJ19aeN/6YlDUdPvN+pma8ao3JriMU5/aBRFld27u7qzZTqMGEvzqD0SPn/vi9iekgi1u0hT0nRdaDCFW5YHmlRFM2e36qKWN/NCFPic2Ou98DIMD+NXhae5iAaHtFeWuphgsOwF9Ois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y58r7dRE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30737db1aa9so67737901fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359391; x=1739964191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCFlnePKkNndn1RG+PlEu//ug35hNzDbDVRdXX0Jf/g=;
        b=y58r7dRE8q134yXUnDM4YgSznkmSsuwGFvbHejgoMDfOI806rnN70G5iFH2sZ8yVxq
         j9szd1LXesYZ1USXxRsokX9OjHT6UqZo6EIii92+4wt6zr8oIrW8UtcIa3TMOf/OAfie
         dWHURGy9msyTNWrAYla8GbN87yRfDxOgvE5gdnalULB2r0iOBcDvLGl2sM6jCEUZfh4F
         O5vzOnyglmzHwYeO3wQ2pMqsT2cz11mZ6hsVdZhC64K3DJh9PAvHYFd/+V6SLSDRTuv4
         dxuRsXl4y/er3P13/N4XQ7RTwur823a4GdHEvCTsNz3wn94wIxYa7YPWju1oWn5TXDMU
         u2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359391; x=1739964191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCFlnePKkNndn1RG+PlEu//ug35hNzDbDVRdXX0Jf/g=;
        b=OnhZVCdwdCqPw+zZRcx3qrlzobM1aL3XsNGAdbEwHt0o/Ehm4fsm6lF/zZscbzexWe
         QA9s+aBPnGbv7DP5BDIktYyYBGA1ufc5wGDWukoffRnbdidravJHfRZeHa3VAHf/lTdi
         o5Je0nXyoSIkktRlg0Bc8Lgz69eItqZQwUCNmJvmzwrVAaTSYxqLs5qpPS9EH6OS4zpf
         O7J4SHihsIlPttOTeByrC5p9tdWEuLmrLz7XcNEPo+b1/EIhL1FNX07p4bQDNgSmGflV
         7TPRHt9OOWfrIV2vESr0CcBH7iRN27/ZKnjIbRP+VQTv2aA+ghsUAyYmiDM1ds2Kh8wA
         ZFRg==
X-Forwarded-Encrypted: i=1; AJvYcCUcAkaBiMLZBsCQ69eeL8zeFANqoNBfgv+hzg8aZvKdai7+sxJzvC5ONnu1F2ipvr8AsE1Mjhl2cBW+wI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyI5kVDBApDtF6C4AEVdgoREUVoFkROhElAYh7zJlPkEymO6YK
	Tk/i03kxanlbMe8rn8NPbV4lOBgy88zXVmZ8t+jEpl6fFqymsEyl1v5zayA7IB0=
X-Gm-Gg: ASbGncvtEE2UKzKy1XrepnGL4fnJggAQXoBzcyrwalIzFdo9DNVB0E4d9wF60JINXeG
	4z1Xcr+K9usKlHNBtl2dDjaZjlZSx6pCG+xRJNgBTxSpbCurBFBm9XRUD+7KGkRDA68AURNqoHS
	VHdXiP3aiw65fVsJP0DTi8t0Mw45goC44Z9P9mVbyNnzv5vZjizBo8eJIA2uQLDyqecwkQp4qSo
	7xiYbRGSosTYXQ1mz/66MS/+zqKALeIKfjINr5PseTs6c1nIgwaserKrjeolBTz9PRYhX2mY6Ju
	my5/aeaFYvEN/TZyTczY09+aLQ==
X-Google-Smtp-Source: AGHT+IEYodYzadqUx2Im4nLmPVhkj0QvmLDghRs5R4XGCmQddXyPfDz0d1vVwCk+T4sDxY8MmfEg4A==
X-Received: by 2002:a2e:a588:0:b0:300:2d54:c2c8 with SMTP id 38308e7fff4ca-3090369c207mr7437881fa.8.1739359390812;
        Wed, 12 Feb 2025 03:23:10 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:22:59 +0100
Subject: [PATCH v4 05/31] ARM: process: Remove local restart
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-5-a457ff0a61d6@linaro.org>
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

The ARM kernel contains a quirk to handle syscall restarts
inside the kernel without exiting to userspace. The generic
entry cannot handle this.

Rename do_signal() to arch_do_signal_or_restart() to fit
with the upcoming generic entry conversion.

This is essentially a revert of commit 81783786d5cf
"ARM: 7473/1: deal with handlerless restarts without leaving the kernel"
from 2012.

Other solutions may be possible, such as checking the PC after
do_work_pending and assume it is a local restart if that address
is inside the kernel, or modifying the generic entry code to
track local restarts like ARM does and pass that information
back.

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



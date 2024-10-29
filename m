Return-Path: <linux-kernel+bounces-386745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F29B4798
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5472816E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906682071E4;
	Tue, 29 Oct 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1/ihUO6"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3D206E82
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199179; cv=none; b=eKKH/N9w10Tc/0EMNBjTrrXoupwCTE6iHmCla0OsUFefFp9ljuicg8nGzo+ktcI55RJg8b90wiM0hHprfBYxsW6OFxYqOovR+Oi3hF76Xt1gaFWe7VJMyTEOwRsipdjIcd+fE+XrtFg0J80PPq0kHO5g44H+0jTWmmnX0c21ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199179; c=relaxed/simple;
	bh=TXjj9xFMQ8ObJncCvfOXEQyxyh4pdr8dOD7N4vVAW1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMOFadXQn6caGKAKf+Zi5ZU7cxGEGg6nnRa+1zETh0YFnINLoCwe1xGj0edBAPsVLFBM1AfnPR0OVN5xeM7dahoXp7CJ0lwrXIIE//SdLiX3Zhkbi9mTkxw9rt4LNlsr7FctOTk0zjfwXkYJKvUIVjtmwCQZY4VndJ3vHa5MZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1/ihUO6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5435641e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199175; x=1730803975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhwutFaJAhBwzUvxWfpVZxdfXLNUR2eiL6c/Y41YU9M=;
        b=O1/ihUO6X0FWsjLTrki5Kiv/jiGQdCAP7+sNVXn3o/AwONpV9JqIE1LRsqIIUfS0gB
         V4duyfBIwosraTXNEpByRia434Hez7wf60AnnI/hy1eNOlX2QVgcpXIhb6vfuCJkP7/W
         I17ZhBXp54Y/wbXzz8tqyZi2BRj+wn7LQ1MAb8/gojnvdZFRN0j37KLjmj9vKg6kvRHY
         /TEvVMorexZRiamtNfZQ+H6q8Di0/NSI4ygrJ4pieVFvbwEkPXp5kmGKFlwJ8zV/I6Ha
         Llz3F3xjiroRSpEfGn+ehS3Oyron1CqVpOR6lnjreAsfAIRMV8dUn3S9DyCTLtBXYDHa
         wlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199175; x=1730803975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhwutFaJAhBwzUvxWfpVZxdfXLNUR2eiL6c/Y41YU9M=;
        b=I3FPJCpH8XMuQ5cmWJNy0hHYQcEloZpHegBPgG7fmmhUz1yiyloseaoAbvg9alEZq7
         JqTqF0lyI9L4iDk3dMP5zn7AGsg9/xN1j09lUdF3BS7Ek5xkVHHXhJlPVkuhhBemWmiv
         0aiNLLd3l1fPjN2qMDqGn7VL1HhXz4TJKjyycV9p89Q2FnyzFlQ4v/GD367dzyDjOg6R
         UR4X1bb97GWgHj3Pyu7hAPbGVxkNE8Kx01vKtZv954HNy4V9tXZWehAZN6uixK/MpgRq
         mo6TBY7j2CUo4ExPqJTbqQn+7BkhKGz2MHwiumhlFk/9F9idvyo6DogfvtI39Tt8e5Ih
         nCJw==
X-Forwarded-Encrypted: i=1; AJvYcCVkkdy1wp5Ex5MhiaLoeUlE95Cja5SII7ncxN6cgu6to8ObwKqX9ZZs8TL7ABO+6PNT6iamynoPx+sac+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MbGPOUbwLFc2AkBY8YyvXooPmhcMN9MmONP7INUeAvY12ROj
	usOl1cJHaD/AkybDUCBE4/BBamI9yjldMvppv9VcVF6JmNWpgBrWCCfKVWQbDRo=
X-Google-Smtp-Source: AGHT+IE7TBLGcMxKsC7a30pUEcJoXeIzSiYTepdqh334Y6u9VYfbvLHbrLSewuIIAuux0bNQMqTTNA==
X-Received: by 2002:a05:6512:3b2b:b0:539:e1ea:c298 with SMTP id 2adb3069b0e04-53b348cbb37mr5497449e87.22.1730199175441;
        Tue, 29 Oct 2024 03:52:55 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:45 +0100
Subject: [PATCH RFC v2 05/28] ARM: process: Remove local restart
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-5-573519abef38@linaro.org>
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
index 8b84092d1518..7acccc96840c 100644
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
index df6961a1006b..da5c2d4b62e5 100644
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
index 79a6730fa0eb..7b1a16e86b23 100644
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
2.46.2



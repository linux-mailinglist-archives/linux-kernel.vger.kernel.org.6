Return-Path: <linux-kernel+bounces-511015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAFA324CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1366A7A401A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8820E704;
	Wed, 12 Feb 2025 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmTmX25w"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED920E034
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359402; cv=none; b=YoTO/zDPrNxBkBpGbVrUaFRCf+ruEfi6vkJgqsIQcTqCHv9yVBKramnb3KuJuM5a5E6tzRr0Puwk/lRaIwejDb98/ZHV43vJW6AVAXqAPpPurfhYBhGePqmA+PGxGk39Yz+bymEyfatZA9Tk6+lq5O8W+YJkvd6uXeGnw4WfVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359402; c=relaxed/simple;
	bh=uLdRblJEcBgqrdlNhpGIwJYjD/vcY62yplB7gd+NKqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICyGM7Lk5NBF/DmlaItaUc2rU6tcuu74cYr6tbYbP9UyMrX7MXFjLrYxE5rivCt8kSx+ydhR+THjpCldYuqbX3hy2+rbIfzH34DeYEHJu2TsTuBrhzyZ3lknliKXh+UyE0q1bNDUZEn0TVMfp2ii7K1hdm8qEobQzmTDrJTM9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pmTmX25w; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543e49a10f5so6966457e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359399; x=1739964199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr2oSZFQs/khvnnGeJohJHSvChXi9NfDOygi+WZQm/M=;
        b=pmTmX25w5kQ7F81WUli7x5oidfPa2IliVNPGZDF/x8grn5TEH1kYq0d7/L5J/fbr/0
         J+mevEmAKxXTAk/Xn8A9pyVnkx7CkEXPjIluaSMVSoE6Z1FG87n39sf00/bjjXK3syLW
         Y/JtI+u6UcTxU9QkgYrholbIjuWY0S0DFD7Vb5l7FMawRD/apC+2p18k5rdkFNzr6cfX
         PV5AZK9sS5PDsNM396c3MCxcLT45b0Z2g8aDUqSMgptSJog5VYOF5FQgJi8hzSO1fF1U
         oxB0P+JhNkb2AFdkymLcx88FwR9TIXNaPBPYJsOEI7xuDJfdTCZM9rKPOwfbrUzdW0jr
         8ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359399; x=1739964199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr2oSZFQs/khvnnGeJohJHSvChXi9NfDOygi+WZQm/M=;
        b=Ctdhkby1LeIGSnC4MPKejuUA2pGf7KTflqcslkwLg1yiYf2j18vX1Lp7Zu9kN9S880
         VDkDC0rivnZGloktiOSvk/bh46n+zEwCr2EMQE3WEsXlnriAMACpRa9EyyFYsPLudv4B
         zLQY4wE7qtpz0a3HrkVRCvgnhXX2ClPLkDe+CmCTq96SA7ZG3HpRFQ9buW7H0dEEL8iW
         gYrxZsra5dWh2E2TBBupdDMx9P1mbGne3pZb3u8HhJQMyEVBgammPo25VspWn4Ji+Ix+
         mco1yMYi5RmB5UZ5BZdtB9mmqWZuyCz0LSe33Rrf+Puboqi42Ia+FETnQoOi81qZ5Rqa
         jfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrhBlaUOSwMzW69tfYd+XTMlJCQLAWZSTUEVCKKdskJBcjwRAX03UDp1OaEKSyLEZYccxTp+tdT0EdLmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVG7Fcs/6/wA7LQouzeXEaR1h+uCgZOYD6RqmfFDvMYPuZ2Sj
	eC3t+Rweaq0iy4hTPWoJfI8mIKmhC2VSclb4xVdYlxQpCcOwg3SUkycQSIfAPwA=
X-Gm-Gg: ASbGncskr7+NfDbamAvY1unVKKC+cOnM4A9T71lOBb6C4zPUzXhmOhZkZjAtl1QBOyG
	8yS8IMKxhKw3fHxzjWIrK2xRn4toW0ie0WF5dfTj7ZpzlX+ybRSB7XhGTiXDbMGeIydFe23deS0
	GGIQ9aKsRN6VDfE+wgaSaNqDz7zZ2FGc3lQGzMYiaV80VSOPmAj2RqQ48gEh0F1QFmoo9H1niSx
	OLnfNOCRSAWPNdaQejAKa/Uzf+wf2DuZ7NVROBekCufn3vfbLQ+F2GA+7fy17m9h/3H0JbkT0wN
	XXMy93LW3q93EKDVrX4ZJ6ttZw==
X-Google-Smtp-Source: AGHT+IH+IdKt2FT6tNPNoUo8a9kRuj3wtpUX5pKBXA/WPHTi8mdjHVXpF8+ZHzJO2eM+nciMsumGwg==
X-Received: by 2002:a05:6512:3b99:b0:545:cd5:84ce with SMTP id 2adb3069b0e04-545180de56dmr819224e87.8.1739359398590;
        Wed, 12 Feb 2025 03:23:18 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:18 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:06 +0100
Subject: [PATCH v4 12/31] ARM: entry: Rename syscall invocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-12-a457ff0a61d6@linaro.org>
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

Now that we do not have a separate trace syscall invocation
path, rename the invocation functions to be generic.

This can be squashed into the previous patch, it is just done
here for the previous patch to be easier to get a cleaner
diff and be easier to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h |  2 +-
 arch/arm/kernel/entry-common.S | 10 +++++-----
 arch/arm/kernel/syscall.c      |  8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 9c664d8c5718f58034f442c20a030b59faf65dd9..b94fd7ce17f82f0baf06b74800245112e1f13002 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -19,7 +19,7 @@
 
 extern const unsigned long sys_call_table[];
 
-int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno);
+int invoke_syscall(void *table, struct pt_regs *regs, int scno);
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f0f1f8723965313b287158fb2a238908db72fcd2..f1e48002bd3075ea67b5883178583127fa0055c6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -260,7 +260,7 @@ ENTRY(vector_swi)
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 	mov	r0, tbl
 	mov	r2, scno			@ syscall number from r7
-	bl	invoke_syscall_trace
+	bl	invoke_syscall
 	cmp	r0, #0
 	beq	ret_fast_syscall
 	/* This path taken when tracing */
@@ -390,7 +390,7 @@ ENDPROC(sys_mmap2)
  * r1: regs
  * r2: syscall number
  */
-SYM_TYPED_FUNC_START(invoke_syscall_trace_asm)
+SYM_TYPED_FUNC_START(invoke_syscall_asm)
 #ifdef CONFIG_CPU_SPECTRE
 	csdb
 #endif
@@ -400,17 +400,17 @@ SYM_TYPED_FUNC_START(invoke_syscall_trace_asm)
 	/* Make space to copy the two syscall stack arguments */
 	sub	sp, sp, #S_OFF
 	mov	scno, r2
-	badr	lr, __invoke_syscall_trace_ret	@ return right here
+	badr	lr, __invoke_syscall_ret	@ return right here
 	ldmia	r1, {r0 - r6}			@ reload r0-r6 from regs
 	stmia	sp, {r4, r5}			@ copy stack arguments
 	ldr	pc, [tbl, scno, lsl #2]		@ call sys_* routine
-__invoke_syscall_trace_ret:
+__invoke_syscall_ret:
 	/* Drop the copied stack arguments */
 	add	sp, sp, #S_OFF
 	pop	{r4 - r10, lr}
  ARM(	mov	pc, lr		)
  THUMB(	bx	lr		)
-SYM_FUNC_END(invoke_syscall_trace_asm)
+SYM_FUNC_END(invoke_syscall_asm)
 
 #ifdef CONFIG_OABI_COMPAT
 
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index 36330023b5484399a4ca2fdb5727b410e2c74b6f..6f518ec3870fb36a64d1b671b20f96d63a52bf78 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -8,10 +8,10 @@ static inline bool has_syscall_work(unsigned long flags)
 	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
-int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno);
-__ADDRESSABLE(invoke_syscall_trace_asm);
+int invoke_syscall_asm(void *table, struct pt_regs *regs, int scno);
+__ADDRESSABLE(invoke_syscall_asm);
 
-__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno)
+__visible int invoke_syscall(void *table, struct pt_regs *regs, int scno)
 {
 	unsigned long flags = read_thread_flags();
 	int ret;
@@ -23,7 +23,7 @@ __visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno)
 	}
 
 	if (scno < NR_syscalls) {
-		ret = invoke_syscall_trace_asm(table, regs, scno);
+		ret = invoke_syscall_asm(table, regs, scno);
 		goto exit_save;
 	}
 

-- 
2.48.1



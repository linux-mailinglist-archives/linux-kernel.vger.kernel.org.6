Return-Path: <linux-kernel+bounces-386752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08E9B47A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609991C228C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F2208228;
	Tue, 29 Oct 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GB/Olxc4"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE43207A31
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199192; cv=none; b=KDqqsbgxoUjWeUNP4e4D5P7ThGnS/4xW5n+GR/0cf6m0USWJyJM+nPu12EC7BwbAagav6TpCEYXQ6QbM5W2j1Vve3bfiWu5CzZMgNu/kq5Ql2NngVejq7gSEdDP/NqqUBBIxiSn9WG+LduQffMHl0O87aZln7ha/r4jFIEQ3w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199192; c=relaxed/simple;
	bh=GlhKGb3knP5MTTv+ON8XhDtdyIyG0oHge7Bj6y3E7+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNsWG6Wqwj73PD9dlZeDlshRqEDuc8GcwuFuAS4vP8SEr5pv3mX2UxJXXN224l3e+JwDHE3VLG/FpqP/cap7WH5HViczPiuvhXHnxofDj0D58IH634UFkIcX8le5IllqpbATfnPGT3FriT5T03vE/GzJLi9b99gLLCyrYv/TCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GB/Olxc4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so77807021fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199188; x=1730803988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzzrIJOoccLZThZLp3kOXktHyMNXE6/2voWdPpMOjWQ=;
        b=GB/Olxc4blEpmLem/1YoVHxvlzdUTIb/6hFuocmi2tfU1xu5yzuxXxqO4NFmvILcZW
         9ZDU8CwKT+z2wPgTX59eEF7Ue4J3MhfKC6Xs1Ajrxe+sPsb6o8AV9yKIXh2oNT5URMNT
         mNsD2xKJeEG2/Q+LsPHLT2WG2CO4+GwaoMzRoi0957X80d0dlfwZvUj3CFCe0d/7VdGD
         282E7PGOqUVAQlnqgd+nv+tPw5LF2ftZclY2zjARJTBzXxELkxbeRiDsMA8FkbY4aq1F
         +w6LSRGFpgmw5rfOeXDw0n0CPtRrrdwqHBEM04d7Q+QD99IqlfUs6nK3x0+6ZJ60OMU5
         IfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199188; x=1730803988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzzrIJOoccLZThZLp3kOXktHyMNXE6/2voWdPpMOjWQ=;
        b=e9PLXVHU49dsr44V42bsmAjLLVCn1yBv5bXktt3wnPg5RvSBCjtDDDjsGg6ce3njJl
         qZiYgjJRtL5/GNDWKopwJA54/xpPEXViKnubEpP/P+Zx4Vy+AQG7gKZ3WfabWHIRa9nK
         pu2pWftFKZjIaN2WD5BCwUh6JbaArxm1Bun4gaXYraTIjb/xCVONR/WnP5CjJoe+QT+G
         S0IRt7d14jkxnoy6ZJNLP2NeFU5vXYtu+r6FqNngvv7ghKgi5qObPg9Mqjb8yrSHRJZr
         tgAJcGRK/x8sjo/4RlfgAHqMWzS8fK9ii4h5UzyuFoKb8B6QX1s+dMg05ztdjBeyVsRy
         WUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLK8C7EYFH5eaFN/Q6JvqIzz/ne7rm01ngPBaGT62Y9fZD9enDN41UUqz/Gcr80nZIIG9krZLoe8GG7uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZqtVW2Knf42mhPHlaqztwPWTPy649TnE0Cif80iZwqjdE5Cu
	DBf04rCQ8W8lbBzoMORqwF7VtMA6MYCop18yvLHASMLPZOtbA5ONjprEFKQO608t60IwGLb9URL
	v
X-Google-Smtp-Source: AGHT+IGRCP9njDT3bh0HLZQdKXOdaIKdzw+lCjY7s08cyEsqWgr6D/0u3fyrkqBD9EnSPMiRj86V7w==
X-Received: by 2002:a05:6512:10c7:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-53b348cc510mr9200713e87.16.1730199187934;
        Tue, 29 Oct 2024 03:53:07 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:06 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:52 +0100
Subject: [PATCH RFC v2 12/28] ARM: entry: Rename syscall invocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-12-573519abef38@linaro.org>
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

Now that we do not have a separate trace syscall invocation
path, rename the invocation functions to be generic.

This can be squashed into the previous patch, it is just done
here for the previous patch to be easier to get a cleaner
diff and be easier to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h |  2 +-
 arch/arm/kernel/entry-common.S | 10 +++++-----
 arch/arm/kernel/syscall.c      |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 9c664d8c5718..b94fd7ce17f8 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -19,7 +19,7 @@
 
 extern const unsigned long sys_call_table[];
 
-int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno);
+int invoke_syscall(void *table, struct pt_regs *regs, int scno);
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f0f1f8723965..f1e48002bd30 100644
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
index ab9e66da0a80..968cec945a7e 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -8,9 +8,9 @@ static inline bool has_syscall_work(unsigned long flags)
 	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
-int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno);
+int invoke_syscall_asm(void *table, struct pt_regs *regs, int scno);
 
-__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno)
+__visible int invoke_syscall(void *table, struct pt_regs *regs, int scno)
 {
 	unsigned long flags = read_thread_flags();
 	int ret;
@@ -22,7 +22,7 @@ __visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno)
 	}
 
 	if (scno < NR_syscalls) {
-		ret = invoke_syscall_trace_asm(table, regs, scno);
+		ret = invoke_syscall_asm(table, regs, scno);
 		goto exit_save;
 	}
 

-- 
2.46.2



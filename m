Return-Path: <linux-kernel+bounces-358889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C7998511
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75805285C28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D81C3F1B;
	Thu, 10 Oct 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIVz4mbO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1D1C8FAA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560047; cv=none; b=CBMJn8/KYXrXQbWTpw/0ntZDZYXoLCI7E2WCd35GniidnqusoATFTm3hfABVUVKesUtFJrCrUuz9dkJMw84m/taNdwL4cmyENBMO4qVJvT+CI3yAVduRTqX5JCxIXB/SXtsrUVsPdXWGhmJXaNUspKcrNgo1KbZztpLRmL5ekkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560047; c=relaxed/simple;
	bh=GlhKGb3knP5MTTv+ON8XhDtdyIyG0oHge7Bj6y3E7+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMMXRH4raHVuAzkHx8UqpHsBQOFhDp1xwLOv3M/oJAWL+/WZFVmgy6SmT/xhyIpw1021xoDlOTFRPvE+vM7rNpw+KTnXXqs8UDUfV3CXjX8UQ62q6Ct/GKxzZDtv38CcV0hHqHbEv7F+m1ia6CMcA7KH2xx7iEqS77DdWqFxSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIVz4mbO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99422929c5so96539766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560043; x=1729164843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzzrIJOoccLZThZLp3kOXktHyMNXE6/2voWdPpMOjWQ=;
        b=CIVz4mbOw7FagehXCAvCMDjfzh70O2in6V5eoGlYXWp+lFMttvl2sYdcF++D0XLdHT
         O5CCrDGTZWL5WsieI7bXhUS1Vzf18EjgtyjLIsd4/cZrum60U2DrP6N5CecFVaomFjK6
         Y1nRgr3RFXyKhxxcdRRrDemLHQF6TmbwgdbF2ayAd1IU6FGB+o5eRgWquuK6djB7lrUl
         sWBdxvIa3UN0tuOwJyyTiyvLOHJykiObfOIEiFxUhkcSYj9qchP5v3dFBFW9TlC4EJ5m
         G6l4lYb/eqSv/zWKvjcDJ0zhgekQzV8iHDaAhO3t/ssSikVAhcQn/nSiUUmIwbSU3/Y+
         psOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560043; x=1729164843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzzrIJOoccLZThZLp3kOXktHyMNXE6/2voWdPpMOjWQ=;
        b=bhnpv3rFf6OI2O0ZisDV/WXHWw66IQwU04+d/TucolKsYLkCJp2k/SRi4Fpx49SxpF
         K3p4Zd1uBcC5DlWzxsOKNdNAiEUj9HQ9JOKNd+ZMC1r+u/ZTJvQPtg3gwkB3YgjehDOj
         DdNrvuO0JZvqigY9vI0jfJ2aZ7J3rAObClNdeU8L/GB/w5ql2iyxvsAMlPPhUKoQWTeP
         aj3L5J/MJV+P24YJ1BSWG4SJBUbuItarGk77dZ46B9JcjkLgMJhA6pXlCRfZsqUOh2KA
         P921X8aTukb6FlBj3GyRCviHcGvxLrOPWLVqOssn0Uz07/4KYTv1D2fZrRGfkpniLpgQ
         1gsg==
X-Forwarded-Encrypted: i=1; AJvYcCWVRTByDutUsEn8ly/uc+6c7YIDkPJUyVX/gYTOcZ3HxkfPTuKn/ukJmxO31iggu1L7OctQmyAkSSEgLr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvEdNNwpDqXEjphBR6FmnsCLrxcoXZp+9mZLvd6yBZRtPCKXz
	odZKQdJjYP+Gu/21xlBidQ7pmfg3lDbmfnhHMvh0hdBTWi9H9EEf0W9ZCAIVkqs=
X-Google-Smtp-Source: AGHT+IHADUgNkk0hVOK1JFXtca7534b5748m22i8omloPYXVG1QKj3GD3Xqq0GICp3+Pdqz4GrjLzQ==
X-Received: by 2002:a17:906:730b:b0:a99:4a87:cc7c with SMTP id a640c23a62f3a-a998d34c373mr530776766b.58.1728560043498;
        Thu, 10 Oct 2024 04:34:03 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:03 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:50 +0200
Subject: [PATCH RFC 12/28] ARM: entry: Rename syscall invocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-12-b94f451d087b@linaro.org>
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



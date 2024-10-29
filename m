Return-Path: <linux-kernel+bounces-386748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758609B479C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9954A1C22868
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A0207213;
	Tue, 29 Oct 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKWyFmag"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144F20720D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199184; cv=none; b=BaybqyW3d/mnZ0YdtbHZunbN7cSmPdOl+sDFfgS4KP5/Wc8a/qyZznmSjp5fsskovirL+s3qY0Pa7iZsZZpOw44NtXG8ffmqKTeOeGHkmoRVcVBqqaVONGl73oBERa5wMzo/qY6Keo7YvYYVAiY5+bAEetZtwsqUOMMwE6TFwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199184; c=relaxed/simple;
	bh=t98uwCV61GyOOlPQHbY+AntVKd7h/1gQX9jOuNSoZ9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYuoBWo6TBUwWqSfOSsOHMn+wXI19C4tr4V5yyJ6N779ZKM8GDaTZt8Wy5pC0ZOrsWb7xfbuBpGQvHqk+Usbd1Jlu2Xdx3+gWBRjOKYkTlRSFA8BnaSz8t0XQ/iHsdELD83fxCZtdKHTAx8lI1eEidoHhoa32c91LUpgVvltFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKWyFmag; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e4b7409fso5072504e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199180; x=1730803980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kAN7grhcUpbCDFoKucfYZVBg7IClr2vppXay/MPoLQ=;
        b=QKWyFmagbzSc/ye+E3f3d9Xoix10Pyvq7vXQ4LXoJdsubjHKq+6W67TJkhxm5blIzS
         lCu9+uPRQ6ky8OnqlHIuS+nu2lAn0nEOEvFgfMYxeFA1p7bwKcnNnOmIHs/dAakEktoL
         Ab4IqAn1qwwTT7un5/BXhTs3D+M5FnpENkrOAmKNiZdk/muvltt4RikpKsIHfEearjK6
         cVkXCGEe72scDLmJzze0ldcGyrjjw2hcYKUr7tGVlvxImZMrJhuwWLgpPUDXuc2yukNV
         EuB/eNvmR6SOijM+OGERGirbYiKGEnkzGK+xfiaf11DFY3iGUVGjSeeLA6H9LaC6KkUp
         pTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199180; x=1730803980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kAN7grhcUpbCDFoKucfYZVBg7IClr2vppXay/MPoLQ=;
        b=fwDbfe7J/O4QbTGbG2BVc2opU8eW0LVHZZUkIVuhchaJe2rgJyCuzZ45XVRrfouTRf
         tRTsoP+ke7C+wjSjtsD8GTKyeDigaB2IIxUpw1Bykq5QKYvucsFm+SD7xevhO/HsywcG
         Cn/T4yyC6srNKk2JgJKlQIaglf9ZpX+KQ6LRLqtXxGpsotjx5WMVxt/YWI0iCydNyqdx
         6+0bBliOhxMJIO8UQR/HuLC+wsqhQsERIg4gDz0C1iiGAO3tV55oLLc88ac+hVidYcSc
         oCT3WQImUe6BN4sPbEAw0qiDHlo2NSbTzEX2rBrxQJOufiAo/vSk59tv4cOlsLLhH0sS
         LbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCURt/mmKgrFgQ0H14YO/ks5MltJi8wLHUJR8MxW/+SfMgV1rSvAHr29dGe5GmTi/oui/lUqyW6HwcIRwto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8QEG4E4W/yUUvcjpkoc5DX6XWZ9Pl9JJlZ0AqcPP0ucv0Zb6
	pWRv25Z7rhVp/uzfKcvdBq6sRW+RwVufYTtkhGIuWkojvHOHNuOQ9DwhwyIMYsk=
X-Google-Smtp-Source: AGHT+IE+BAtVqBrWdYhrt5vvhzxjJUA1tOK/oyMlifKXwIMsOAQXf/e2P1Qd8xMaKhzFGR4sJKMkaA==
X-Received: by 2002:a05:6512:4012:b0:539:e263:331c with SMTP id 2adb3069b0e04-53b4944ffd6mr614860e87.17.1730199180265;
        Tue, 29 Oct 2024 03:53:00 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:59 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:48 +0100
Subject: [PATCH RFC v2 08/28] ARM: entry: Move trace entry to C function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-8-573519abef38@linaro.org>
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

This moves over the code entering into tracing into the
C syscall invocation code. As syscall_trace_enter() will
provide the current syscall number from the regs we need
not provide the syscall number to the invocation function
any more.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h | 2 +-
 arch/arm/kernel/entry-common.S | 6 +-----
 arch/arm/kernel/syscall.c      | 5 ++++-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 1d21f26ecf51..66067d165ba3 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -20,7 +20,7 @@
 extern const unsigned long sys_call_table[];
 
 int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *retp);
-int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp);
+int invoke_syscall_trace(void *table, struct pt_regs *regs, void *retp);
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 77801d039b5f..3cfc6d952ff9 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -292,13 +292,9 @@ ENDPROC(vector_swi)
 	 * context switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	add	r0, sp, #S_OFF
-	bl	syscall_trace_enter
-	mov	scno, r0
-	mov	r2, r0				@ scno into r2
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
 	mov	r0, tbl
-	badr	r3, __sys_trace_return
+	badr	r2, __sys_trace_return
 	bl	invoke_syscall_trace
 	cmp	r0, #-1
 	bne	__sys_trace_return
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index d1259c6d2805..815312f7b254 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -19,8 +19,11 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *
 
 int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
 
-__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp)
+__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, void *retp)
 {
+	int scno;
+
+	scno = syscall_trace_enter(regs);
 	if (scno == -1)
 		return -1;
 

-- 
2.46.2



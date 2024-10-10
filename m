Return-Path: <linux-kernel+bounces-358885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43699850D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A4285BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D41C3315;
	Thu, 10 Oct 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOJCmzIf"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE181C68A3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560040; cv=none; b=G2i0pnwIgVUlTfIMDgJlcM6n/Ai6tqBtLjR+xaZ5FZL8MaWujyF+CRhlX2wf28sas1K72yNzKfr6x6tdPPeIJDqYJO2r7jmky7Qwnb0JB8+Wja96debAPXoHUWkJaIq/on3uSkPDhNRBQEVlsYsXDAlZetlX65ID5oz62BymrvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560040; c=relaxed/simple;
	bh=t98uwCV61GyOOlPQHbY+AntVKd7h/1gQX9jOuNSoZ9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=By5AKSdMD/Hk4V7xMHkoQXRzrDGwJ4igFuwKIPdLUBUV6FXNGjOtx22wODoalkzawtMn0osnWPydwU1bIQwRWjAs2t9e/QmklG6pUO/h4IzddmoV8avC4HCszYgiHa2gr46XyYN0831YJb0OLatCQ+G62bQitYL71AkXvpFkc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KOJCmzIf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a998a5ca499so116894566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560037; x=1729164837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kAN7grhcUpbCDFoKucfYZVBg7IClr2vppXay/MPoLQ=;
        b=KOJCmzIf6MWbl3PsaHXQdDWnQxHAmPCq/BDeIaATbyOBr8Q+bnl19bY0pEwNryudxO
         BLu8nYUQt2OmSsfLNntsdsiZKT+JcZY9ASNOpEVuh//8lmDabBfvFs70l0n2zZfFxSjE
         06V+pI8qHUObnhm/dg7S7+wjBZLWYrNgCoq3ZzXkhj5H5TDkDLdotNcWEUmsKS5vndqk
         NNvUct08ThcQu21Rjg+JGmN7R1JcyGoowSX+3pRj1+rO57/BwySWn4N+Q8PM1dUEIfkM
         +jxkRjDLuTcaFcQLHWs5hgk3O0ZeUzjbLoycIIzLWXrixSm4ST0LWzdAhIe1TEFbr4/h
         gBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560037; x=1729164837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kAN7grhcUpbCDFoKucfYZVBg7IClr2vppXay/MPoLQ=;
        b=hADWL+H4WEpanvP7dDLPlYkKaiEHkgeCtpQqg0nbfm36a6MzkzbYV8pxZupfjsMwiA
         G7dJLQz2ZlSNMC3ZoKWvGaNnu7PpYHNSSnX/tXRnUBjJ6Bbmni8E2ff168NLc8dhxlzr
         7Ew9E22wdQ9n0MSzuOilkeQ2w6N5xrCMdOQRd8i8qKOQrdXUDFU5Tf1wPvalxQzaCfzp
         dQAyC3NN58AwIMzbGK5J1gnAw6D8xudmc6ObJYl6q86JF7PamczAmCkZJ6QKevoXK9q3
         qNn+8KonIXbcpoJ8gSIke0uQnXKvmk6SvgocLy0nT6DZdjfv9dAjRmuF8BXlgi2cxhwk
         LFiA==
X-Forwarded-Encrypted: i=1; AJvYcCU28W7n3V5LzBOz0ls5v1SlSBErzEWTkkTycr4v9cKK62dcqSbZAkdWqWCiPdK/jtSAXrmQMr+RhspzEP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxll6To9pItVDsJsiI6Zfgb72n6eONV7ZJ+AbsvxxBbFl/N4i0q
	nftizzgLokkvm0KadqqRHFeYiNXocB3wGhgm9Fia9UMU/SsRuE6ELUl0gKuSxdc=
X-Google-Smtp-Source: AGHT+IFukWWZ+4l7WL4Af/FV3llg/yA4aFqolHoqsZkfDC6Tj/Nvfup8eye8T7q53dHtZfNUaRUeAQ==
X-Received: by 2002:a17:907:e2c1:b0:a8d:3085:a7b1 with SMTP id a640c23a62f3a-a998d205f31mr531467266b.38.1728560037608;
        Thu, 10 Oct 2024 04:33:57 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:33:56 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:46 +0200
Subject: [PATCH RFC 08/28] ARM: entry: Move trace entry to C function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-8-b94f451d087b@linaro.org>
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



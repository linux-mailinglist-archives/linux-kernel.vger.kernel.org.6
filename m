Return-Path: <linux-kernel+bounces-386749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930DF9B479F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5071C22843
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4451F207A0A;
	Tue, 29 Oct 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/DGrALV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DD2071FE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199186; cv=none; b=RMDGl7GS8WA1CZmNC4n8+KeNaxuoUsywtmxVRgK8fTUI82TQNqLnoeqxPlx8PaTUJWqmCp/sgV48EBTi4hx9KJRqj1J5bsHSfmg73R0/+Wx0vpPoGSiB8fvoEaxdnEplzTX76X222xWtvPAipqCUic9VdDt5d0Z5FUzaWuQ9T48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199186; c=relaxed/simple;
	bh=TeWXUuVvYN/LOwsrfz7FuUVO8Dn9W3GDV6NRqA6SalU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=az3/pZl65BkbP0sFd0QAG2XC0ZMaOzuO+EXkfqYRnZeLT67FPSLflA4TfxRliHy0U/2deaarCdEnuaZFHoMvnHttInp32HNWMvjp5kuzw0jMA+rAFLm1o8e+zEJbbXdH9595vQ+Hz5DUDBewh13rO5ARojyuuBvFJsjnLynlpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/DGrALV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e63c8678so5347725e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199182; x=1730803982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP1nC9llP2df/xsfs1zPIJ3oMrkiGOdpltxFcj+OFqQ=;
        b=K/DGrALVhGULPSU7M9E2Pj6YTXJtexwqx+iZVVVMreq8aml/Nz4KzapBTF9/YGWN1B
         X5bc//iFm+40Gq6Yh0bya+MqjigaW7yASTmj3HAHYlP4VFwe7glXTShvHkN9LvlPFTYa
         kCsFHBRff6HLBW0ddQYtgXf68UZIJB2KZ654lzY5vO7XYt5CB+f0PVOxUmVnqHfTLa6O
         aU9CNVzittcsiKEYf0X6nZ49iHmOWpebYb1fvQA5k2/HghBhJT17lBNZTK5+qLgb9tEX
         /ZdSgx6kiAHgthq+Ube9z6LY3L5LXBhF8Ss2S0q83hi31/fMNtcSFBOiUeu0AIMVZ7AY
         Kpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199182; x=1730803982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wP1nC9llP2df/xsfs1zPIJ3oMrkiGOdpltxFcj+OFqQ=;
        b=n4WT6HyO6Nbb++9gV3oSy5lt+opGJfH5SZ+80NsCIHGazl7Rgb1M7e/Ka0XABA5UDE
         lQLpMogvvghza42asAKow8pm/SJYrtOzGNVtke4CvOQDyYFTmgn5DTq8vRoswjYgsfKZ
         YqTzexJF53C5eZGPkC9DhX5oS7HaIQ2+eReu8EMg5ZKtAxAE07D21q6NcSfVlRg3Uhrh
         i+F5s+mmHEmahPxZEEkVApC8OED8xFpMTx1j4FyVP88/a+MMshNobsxJ5ryAhKNeLGxm
         6fC1YBQsS26zC75AHYHJ/CXXvpVHdeJSPPAE11v8Io1Mdc5UUGTFa7H2ExQQ6miUbjTt
         Y7uw==
X-Forwarded-Encrypted: i=1; AJvYcCVzELRAPfoNRA2CZV98pkp3/mFnMGlqJogewH9vl6syaoNljPi059wl6NE0EhQcBAz8tFW0mb3pNkUYSHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zpcP4Xdx8IUHDodbAzFXOXr5YM8xGXgs9Gg+pQPBW2ETypM4
	R3FNi57FQqRWCBYnFHHmX4m/7tbUDhbdhtLqTSLi1kaLYXS8QLeCjGloiMU84HY=
X-Google-Smtp-Source: AGHT+IE/w7kIOXo/Y3qsbp0tgFseC/dxf4IJVHvxSY84qtp5r2/GkVLWSkRL6dmR+BAQtvd2iOudFA==
X-Received: by 2002:a05:6512:10d1:b0:53b:1f7a:9bfd with SMTP id 2adb3069b0e04-53b34a343d5mr5817803e87.52.1730199182371;
        Tue, 29 Oct 2024 03:53:02 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:00 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:49 +0100
Subject: [PATCH RFC v2 09/28] ARM: entry: save the syscall sp in
 thread_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-9-573519abef38@linaro.org>
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

We are going to rewrite the syscall handling in C, which
means that the stack used by the call code is no longer
predicatably 8 bytes (for syscall arguments r4 and r5)
but a varying number of bytes depending on how nested the
C code is.

However the current code is just assuming it can rewind
the stack by adding 8 to sp if a syscall is interrupted by
a sigreturn call.

Solve this by storing the entry sp in the per-task
struct thread_info and use that in the sigreturn wrapper
instead. We already have the thread info available in
the SWI entry and sigreturn is probably not so common
that retrieveing a pointer to thread_info should affect
anything very much.

Storing this per-task in thread_info makes the solution
SMP robust.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/thread_info.h | 1 +
 arch/arm/kernel/asm-offsets.c      | 1 +
 arch/arm/kernel/entry-common.S     | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d2..d8a45c5a1049 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -67,6 +67,7 @@ struct thread_info {
 	__u32			cpu_domain;	/* cpu domain */
 	struct cpu_context_save	cpu_context;	/* cpu context */
 	__u32			abi_syscall;	/* ABI type and syscall nr */
+	__u32			sp_syscall;	/* SP when entering syscall */
 	unsigned long		tp_value[2];	/* TLS registers */
 	union fp_state		fpstate __attribute__((aligned(8)));
 	union vfp_state		vfpstate;
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 4853875740d0..c9525cbb26b7 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -49,6 +49,7 @@ int main(void)
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
   DEFINE(TI_ABI_SYSCALL,	offsetof(struct thread_info, abi_syscall));
+  DEFINE(TI_SP_SYSCALL,		offsetof(struct thread_info, sp_syscall));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
 #ifdef CONFIG_VFP
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3cfc6d952ff9..8baab7f97f59 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -232,6 +232,8 @@ ENTRY(vector_swi)
 
 	uaccess_disable tbl
 	get_thread_info tsk
+	/* Save a per-task copy of SP for sigreturn */
+	str	sp, [tsk, #TI_SP_SYSCALL]
 
 	adr	tbl, sys_call_table		@ load syscall table pointer
 
@@ -377,13 +379,15 @@ sys_syscall:
 ENDPROC(sys_syscall)
 
 sys_sigreturn_wrapper:
-		add	r0, sp, #S_OFF
+		get_thread_info tsk
+		ldr	r0, [tsk, #TI_SP_SYSCALL]	@ read back SP
 		mov	why, #0		@ prevent syscall restart handling
 		b	sys_sigreturn
 ENDPROC(sys_sigreturn_wrapper)
 
 sys_rt_sigreturn_wrapper:
-		add	r0, sp, #S_OFF
+		get_thread_info tsk
+		ldr	r0, [tsk, #TI_SP_SYSCALL]	@ read back SP
 		mov	why, #0		@ prevent syscall restart handling
 		b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)

-- 
2.46.2



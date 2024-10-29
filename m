Return-Path: <linux-kernel+bounces-386767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F209B47B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4551C2271D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F120F5B5;
	Tue, 29 Oct 2024 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrXbuvNB"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4F20F3C9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199220; cv=none; b=slXd2h9voIKYUKZQQGa1y4DNuGCJR/AzU1JZtJxZgilcwXo1CzJFTkMthlNPeP3zNMdk7SVq4z7hDsiIYls6r8BSYgicbj7IvRHeOIVWsd2oa0oHRln6gSLshfEs09ky3pByuDQqivHNwUAvunUSUxRK/LTWGWvjReOziXH7rJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199220; c=relaxed/simple;
	bh=LswCk2i9g8K5KyBn9gI4xldOhoqS7tQiTwGUwHGEJZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIR/eKBaOiue5NRHCFeH5CapP+htxaj86A42b2Ck8obt1NBytcfyAa4kbHDBAczJZI+vgNrnh5nELg8hAhoTWxaNIpX0GA4Z5Fvk2ZTl4OeEVYXsHGT75mXMFSdMB9p+3gAgw2xCf+21reloJw2I2bP8uNbbeOub8P/GXEYXE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TrXbuvNB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5436376e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199217; x=1730804017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aytaH1oLbxE7oXL5Lh1BICkPib3Ft7vQWy4tTKokWI=;
        b=TrXbuvNBxPwq33fZ17rEnplyUXjRDa4QzByPf3hx8zyafiFBdIbJLLJzXZKNqvjwiP
         yDvFehp8icK1CYzj+1/Dwszlfxi4gfsiClJKNuM/Chx0xB/L/1d/2hybg+07Nvyx6exw
         rslx2bDISrMAGsqcIrNJMnpziFrI4F4/ggvRZxGxoce71Nz+krdSweTbQloBpYmEECWb
         EwkiQX7YUMZISyFWYiSNoQyMOlkcLLUx7lpDJKdlAR36tTzfdUYg2j9UmJIMsXviG67T
         NsH/2lFRhysCGGUmsPaaUJN8n/mQFae9BUZ1FBRceveWtr/5HhtokdsYrAIWwqJ1Iui+
         9Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199217; x=1730804017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aytaH1oLbxE7oXL5Lh1BICkPib3Ft7vQWy4tTKokWI=;
        b=W5IYtdO2HjSGy2tQU8jgvTFHP8FzuIfi1X4XTySPlHyQ9NWM8A0mo+gYhxSBwLPM4c
         haRKPivXYhY1n1LWQK9Fiw6QQmm3rJiugZzBewQ5q0wAoyaud70Kv0Um97fkWwEXEk1/
         BdfXaeFYjL28wYaDB61J3Vnw/ngB62SJg++Rlo5Niie768bgRSmewzEBgESOWGLo9pAJ
         gApIhS2PFBc2AKI+pINMAztwesZa/r/TdRa+CEX+oG6bx0y7SsU/H4LjN1ahSRVGRTUL
         u1+9nuVhd3p0KWQb5mBkMxRFJH9tgi+cdpFN59yXeqTWMjgN8CwPqHsUYqkWTPbo51wQ
         31JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZr55kdDKS+Ai97Ijxai/fXu5XWZ2/m3GEAVlfjDvEtJyW1+Av75ngaX5HyEnxf6HdPfNYcGRKqGtZgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEKX/Gie5/IDyF6dL++jXQvo1obK6GQA0tAyP4bh1n62tKagE
	eZX9P3RJNAVcNo2hldJmMYGYwGypPQwOJRdZrcCG1lL1xuy18HfKnjoMJ2ieox0=
X-Google-Smtp-Source: AGHT+IGR4YQInxFI66N5j0WfMdCdeF355iwdhYBDKEXmAVJwY1SO6OvLh/7PzjphT8TgoLwPMIQX0Q==
X-Received: by 2002:a05:6512:10d6:b0:539:f7de:df6a with SMTP id 2adb3069b0e04-53b34a3208dmr5334035e87.52.1730199216687;
        Tue, 29 Oct 2024 03:53:36 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:35 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:07 +0100
Subject: [PATCH RFC v2 27/28] ARM: entry: Add FIQ/NMI C callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-27-573519abef38@linaro.org>
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

These NMI (FIQ) callbacks are added to complete the calls expected
by the generic entry. They are perfectly fine to add code to
but are left empty for now.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   |  4 ++++
 arch/arm/kernel/entry-armv.S   | 14 +++++++++++---
 arch/arm/kernel/entry-header.S |  2 ++
 arch/arm/kernel/entry.c        | 16 ++++++++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index a78bc5054b09..2e7ccd87f0eb 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -14,5 +14,9 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 void irqentry_enter_from_kernel_mode(struct pt_regs *regs);
 void irqentry_exit_to_kernel_mode(struct pt_regs *regs);
+void irqentry_nmi_enter_from_user_mode(struct pt_regs *regs);
+void irqentry_nmi_exit_to_user_mode(struct pt_regs *regs);
+void irqentry_nmi_enter_from_kernel_mode(struct pt_regs *regs);
+void irqentry_nmi_exit_to_kernel_mode(struct pt_regs *regs);
 
 #endif /* __ASM_ENTRY_H__ */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 600375f6f5d8..839f3ebe7228 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -157,7 +157,7 @@ ENDPROC(__und_invalid)
 #define SPFIX(code...)
 #endif
 
-	.macro	svc_entry, stack_hole=0 uaccess=1, overflow_check=1
+	.macro	svc_entry, stack_hole=0 uaccess=1, overflow_check=1, nmi=0
  UNWIND(.fnstart		)
 	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole)
  THUMB(	add	sp, r1		)	@ get SP in a GPR without
@@ -205,7 +205,11 @@ ENDPROC(__und_invalid)
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
 	mov	r0, sp				@ 'regs'
+	.if \nmi
+	bl	irqentry_nmi_enter_from_kernel_mode
+	.else
 	bl	irqentry_enter_from_kernel_mode
+	.endif
 
 	.endm
 
@@ -297,7 +301,7 @@ ENDPROC(__pabt_svc)
 
 	.align	5
 __fiq_svc:
-	svc_entry
+	svc_entry nmi=1
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
 	svc_exit_via_fiq
@@ -315,7 +319,7 @@ ENDPROC(__fiq_svc)
 @
 	.align 5
 __fiq_abt:
-	svc_entry
+	svc_entry nmi=1
 
  ARM(	msr	cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
  THUMB( mov	r0, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
@@ -490,9 +494,13 @@ ENDPROC(ret_from_exception)
 	.align	5
 __fiq_usr:
 	usr_entry
+	mov	r0, sp
+	bl	irqentry_nmi_enter_from_user_mode
 	kuser_cmpxchg_check
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
+	mov	r0, sp
+	bl	irqentry_nmi_exit_to_user_mode
 	get_thread_info tsk
 	restore_user_regs
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index cfaf14d71378..ec8a6e193802 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -252,6 +252,8 @@
 	@
 	.macro  svc_exit_via_fiq
 	uaccess_exit tsk, r0, r1
+	mov	r0, sp
+	bl	irqentry_nmi_exit_to_kernel_mode
 #ifndef CONFIG_THUMB2_KERNEL
 	@ ARM mode restore
 	mov	r0, sp
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 1e1284cc4cae..09109215dfdf 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -69,3 +69,19 @@ noinstr void irqentry_exit_to_kernel_mode(struct pt_regs *regs)
 	else
 		trace_hardirqs_off();
 }
+
+noinstr void irqentry_nmi_enter_from_user_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_nmi_exit_to_user_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_nmi_enter_from_kernel_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_nmi_exit_to_kernel_mode(struct pt_regs *regs)
+{
+}

-- 
2.46.2



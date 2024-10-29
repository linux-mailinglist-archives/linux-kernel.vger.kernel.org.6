Return-Path: <linux-kernel+bounces-386754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1CE9B47A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BA61F23837
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433EF20C470;
	Tue, 29 Oct 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9zjvJr+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89568208236
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199195; cv=none; b=HXFwHIh7VlQwD4r3DDwq7ggnzn2VcNsuml0Sw575Nw1x/nxLhHXzMjS2OfAVAaRntBJ5i4f+J/1PQ1KU5tO3NxrLfqBgI8nwzBac1PfZ5drOerRTuMrA0bVWU0hJLVQidVQCyKGAXvg2W946LXfGdGKNwpmac0mU4opvF4xuX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199195; c=relaxed/simple;
	bh=VwHPcRKEp6wrJTlkngBKpHSq3ywUIHnGGlB2f5ulxQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjV7bkKl7y9EGqPBWaRpXJltlHTC7oVhzjGNYGIKNvcwyZgxb2DuIt5vVbd7u4MARenx4TEJOc3tP79HUCM91kCUxCauXyh1+RVSUVl2ppyWKFN61gUEthheXNdYQ1rA3OxWeaDD8IIY2Mk6OtXx7p9YbxkLevONFIUMHwLqUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e9zjvJr+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53b34ed38easo2587477e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199192; x=1730803992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsQ2/1OD1833y3AwH5IJOrZR5jmPSoKtfSG79U8bJN4=;
        b=e9zjvJr+74fmcGx/FffVtGb2MFi7vTcs4ri+L+99YSG6LNn1euR5ogTQZspg8w9+bE
         UogKOuMbyGSEN5Knu3xf8u9bmMpccpeXSNrAVLryPFwcU4xdlP+for11d5qxwrwYMlig
         fy5nn5IhVUndpJfGVoGe9p5DuiDrmpUsMHyn5odXRd7/XqNsO2Rp+enPOW/Ruu9CqzRW
         ah/S7iTC4Yd5eOly3jiBV+UxJriBVMuFZC4P00VVaTKuUlXFkfuOTLCZyFL0xoq+7AF0
         TUciskfwjlNMg+YIOeF8/GFYM1MAwhx/u3Pn9yffoJVuDutgplB9pkCRgHiogTj025nA
         Snvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199192; x=1730803992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsQ2/1OD1833y3AwH5IJOrZR5jmPSoKtfSG79U8bJN4=;
        b=I4AthUVABmfkS9ziMCUNpBIVq+d+jRuGB6x8xObyqUUWWCL08rmNIWV7LT8/OMrlAc
         DBjyUaCsyQIlzt6hx+dF63IKnC8pxY+/uZ+kai2cnZxQmw99Rj4SPYSB9nBFz51XFRcB
         p7jnsceZlBTXkhPqPHKrt1KT0JCIHnyc1HJB8Su3MExH5BVtaD8EQgZ5A+sa/Yoz4cUD
         k7iSN9W8JiAgHMhEVyFDpKGvnpmeoIl6I6oFgxgX/iaKIzjPrXbpwbQ4+8X/9F7vdcTT
         K9d522+9dIUmu4b3IozV3hVyjAS3rzCYNskOzXr+XM3ZPajTzLw5vby6tzjUdsqIIEqY
         qlcw==
X-Forwarded-Encrypted: i=1; AJvYcCVDoS4Up0LdGG/CsRewluzCxeImLfzqXtOP1L3idUh7+u1yxK59hFr/tNet7BA8uFwYDRyPivSweMixnoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwyIh5MlC9M8dck4NMcopHLJA+c/9bSAGYGUoWBlnlrzvwilv
	9KBdXKVMm3/rnTLvGHP78ysemJZ+5RGdsfqNDUJt0ECn+TBpB/uA6nKxsxTcyhX1Kta3+cUTV/N
	y
X-Google-Smtp-Source: AGHT+IGOwfWqSbH0lylD+oRmBxNetXVYp5mK7klp6qC5Jtc7snUGEHRWcKY/n0b0UsFd0cmE4rybVA==
X-Received: by 2002:a05:6512:2341:b0:536:554a:24c2 with SMTP id 2adb3069b0e04-53b348c8978mr5274118e87.13.1730199191697;
        Tue, 29 Oct 2024 03:53:11 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:10 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:54 +0100
Subject: [PATCH RFC v2 14/28] ARM: entry: Drop trace argument from
 usr_entry macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-14-573519abef38@linaro.org>
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

The trace argument select whether to look into tracing of
the hardirqs for the exceptions from userspace, but also
selects whether to call further down to establish context
for RCU.

Split off a second macro that is called on everything
except the FIQ since this is the only outlier.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d6e8b36c70f5..be2df297ec0a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -356,7 +356,7 @@ ENDPROC(__fiq_abt)
 #error "sizeof(struct pt_regs) must be a multiple of 8"
 #endif
 
-	.macro	usr_entry, trace=1, uaccess=1
+	.macro	usr_entry, uaccess=1
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)	@ don't unwind the user space
 	sub	sp, sp, #PT_REGS_SIZE
@@ -400,13 +400,14 @@ ENDPROC(__fiq_abt)
 	@ Clear FP to mark the first stack frame
 	@
 	zero_fp
+	.endm
 
-	.if	\trace
+	/* Called after usr_entry for everything except FIQ */
+	.macro	usr_entry_enter
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
 	asm_irqentry_enter_from_user_mode save = 0
-	.endif
 	.endm
 
 	.macro	kuser_cmpxchg_check
@@ -428,6 +429,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
+	usr_entry_enter
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -438,6 +440,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
+	usr_entry_enter
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -451,6 +454,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
+	usr_entry_enter
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -475,6 +479,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
+	usr_entry_enter
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
@@ -494,7 +499,7 @@ ENDPROC(ret_from_exception)
 
 	.align	5
 __fiq_usr:
-	usr_entry trace=0
+	usr_entry
 	kuser_cmpxchg_check
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi

-- 
2.46.2



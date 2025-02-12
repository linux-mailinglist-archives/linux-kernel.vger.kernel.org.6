Return-Path: <linux-kernel+bounces-511017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDCA324C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C63416763A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5A20F07A;
	Wed, 12 Feb 2025 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTwaJl/E"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062820E6E8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359404; cv=none; b=Kl+G/gwNfw7c6Bbv9qmJjD0AEvr7gO4cASKgPVGgajEjWusJTVItiPiFlKiKG6fRFBqBfL/LS40/bt7xah3oGAPIeI47xrywVNgjA/aa4IRjyPOAY/lRwvYiLEmz3qG56aZQfKRpZyoFRm2z+JKbtW78Yo519xWuHJNXA1XXMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359404; c=relaxed/simple;
	bh=0QHPLkprIrLa7FY7skG/G0BimBto0am5TbhUU9Y2D1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/YFDv8EJdocX1mbDFOiZgqtyrDp5ZB00B6ZN9wUCIru3wrLeQ8OPn4kc/IPFS6DUk7OTmxAyg6LIh1hEb2oYDtFml6uJyvxbuPeiUzuDv8Eo/t0cnMCzZrJIHzAuoktZTNupoEj+cuZTTEFVNrbZN8HXJ9ZyLjwASTCnAf8pZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZTwaJl/E; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30615661f98so71114501fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359401; x=1739964201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgvrpQqwFQ0R0umdPRsAplUpCRMZEe+n8Q2dyj0aMbc=;
        b=ZTwaJl/Ej2VD0cc85KbTKp/nQRYvfqqmJ42ORQsYuJvpTY1vE4I4ctgc+QbVBKmXT5
         5fbjdlHnVFHa5C2jU2dQVgB2kr3mT4wyEsBZ9Q41INYXUQMXtvQKZ/AWMc1b6+cYmdFZ
         Y1vgYg5iqZwl4ZPH1KhnRynDCVLrbfg+OXIAGMVAqWrdy9Cb3rQfQuAkHcnWgfK9+4qa
         HSDByF0Q88362dGA4elEHtohWKEZgpIrxwtzlNuKwgQnUwJOQ31cu+mqtjJ7pFvBmDEL
         Ow2zHZ1ExSic7e7VrbGZagRUpB9ejWXDYDy8ALKop41EprDLfjlV0OrnD58zBVP3eoGK
         /ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359401; x=1739964201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgvrpQqwFQ0R0umdPRsAplUpCRMZEe+n8Q2dyj0aMbc=;
        b=CGp1yhkjOf9lvIxtsRTAavbh932qEyhn3k5K6jjkhhoIvqvnCxGRi00bFnN9eh3ii1
         VRiHX7a69MYGReEp0XLXVztd4AodVw1r3ny+CeQAW8YdzAJBrwVpTee0MHL92ZhY2axF
         tKnbeKGgFoSgoKttrQFYUvyymg+9G7Ftupa5vNcc1EMR+rFppnhYzQZ2XSyzO4p08DyU
         0ueOuV2hGsHypoG2S8EuMjVYix/tYhwVS0NdeSZx7icTsf8Ycd42g2Rq9pEN/I7GjYYL
         pGPT/xcYxBORrtuXhj3nSzfp5ISBLjg/aEzRi9nMz5xnUeQARIeum0fmOovwKJj7R161
         nKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWXHfyJAe0KVSD8fTv0SzK7l/LnJs0paavUe4SPKrkxksmSNkKmoHVaSoMC2tHL6/jkY4p+hnM/GSHlmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3NU4kR6csqldgUICmmKXiLrDh94wS+P2bBRJf18tzhRnkrUR
	QrC1fbrKtp5M13QodvnDo9euadW65XXmyAEQlNqcjEGU5FlmUkOPQtwKygOcD3g=
X-Gm-Gg: ASbGnctik6JXhWffmqbooisSeH0ZKdMrV/FY0H8S+ZzK1pcmY/XuMywFSMxKkN9ztT3
	+1cuCR3KPEdJOncr6ocoU07nfsevHRDF50jG/LczLgaT7h5AdYjpisDUewoXqglgGKPxfgZQiIZ
	ol2re8KcogFXS/wixloG2SzpoPT6NLJQKUh401uJS6FaJEnqWmGZNmZKIkRgL4I873X3egX0EZC
	CkyM9amESYaDicH9xl02AWPV9myuDftZu67RehBTALe9QUsakWiv9AdL95mDzeUfds8WyJabLU5
	HIqzfhf2lREjzzz5wY+3N9688g==
X-Google-Smtp-Source: AGHT+IFJnUYDjF8FB8NajpoFIXNop4QIT5L6sFMa3fWK7tI1+RrzzH8NZHHj8Q+W0l9RcxU2y5/akA==
X-Received: by 2002:a2e:9fc2:0:b0:307:9648:65c3 with SMTP id 38308e7fff4ca-30903665fe5mr11295941fa.15.1739359400622;
        Wed, 12 Feb 2025 03:23:20 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:20 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:08 +0100
Subject: [PATCH v4 14/31] ARM: entry: Drop trace argument from usr_entry
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-14-a457ff0a61d6@linaro.org>
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
index 93a37437a9520118eff411f009e8f6bd729412fc..c71110126fc105fc6ac2d6cb0f5f399b4c8b1548 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -357,7 +357,7 @@ ENDPROC(__fiq_abt)
 #error "sizeof(struct pt_regs) must be a multiple of 8"
 #endif
 
-	.macro	usr_entry, trace=1, uaccess=1
+	.macro	usr_entry, uaccess=1
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)	@ don't unwind the user space
 	sub	sp, sp, #PT_REGS_SIZE
@@ -401,13 +401,14 @@ ENDPROC(__fiq_abt)
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
@@ -429,6 +430,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
+	usr_entry_enter
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -439,6 +441,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
+	usr_entry_enter
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -452,6 +455,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
+	usr_entry_enter
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -476,6 +480,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
+	usr_entry_enter
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
@@ -495,7 +500,7 @@ ENDPROC(ret_from_exception)
 
 	.align	5
 __fiq_usr:
-	usr_entry trace=0
+	usr_entry
 	kuser_cmpxchg_check
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi

-- 
2.48.1



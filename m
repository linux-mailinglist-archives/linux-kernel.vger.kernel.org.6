Return-Path: <linux-kernel+bounces-358891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFA998513
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81ACB1F263AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248001C8FAA;
	Thu, 10 Oct 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFils/bD"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52841C9B87
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560050; cv=none; b=PThD2TqFgIiZjLCN4yQ9x6/cjdE8tv3Z1H6Q3WHJ7pwIzKNy64qb1h6xif7BF7jjWmqDKeme/637/JJAlVb/NcQTzNmsmBuTnX7x/bH+Z30+oQ0Vq8Z8Xui2FZgbClcoCrQc6bSNSy7cWk5JhgOix2anVtIlTwE4Teyd81NGtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560050; c=relaxed/simple;
	bh=VwHPcRKEp6wrJTlkngBKpHSq3ywUIHnGGlB2f5ulxQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HykXcl2qCl9h65MG34CftiTq2s9aE2bhJdFp1V8KvmOPTYGmEAQ1xZ+1+x5yt5fcipbHFnKMr5cgfHsXX8DOXkY2tb6enpTeADYxhP07nXq/OEPPACV+2ORJmh3HBkt09pM6YfcFQcm0mh/lAcd6IBA7q9Fs+FUosYjQnlTBtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xFils/bD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so940926a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560047; x=1729164847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsQ2/1OD1833y3AwH5IJOrZR5jmPSoKtfSG79U8bJN4=;
        b=xFils/bDWktfBBDsgHi46VJ+UM/w+07ATID6sSA90fi9ZhzZp3mGUVmU87i0IyHgfY
         of5RAeDYQGGd603N1U9b8FOoOPClRePSUU+sI6VdSBv8eCdoB87Bp5xs6spcB1fxZsjU
         5C/WLLa3+4zKdp+oFieMsycwzcMtaNbACukwJvZR5V3YpBKfBjbD2WfJazJZvBbo9eqB
         jFYPjcntUB8w1u79yHy9hk/xSDo6CdXvAfV00qoOXJkDwErjcJKTwIgQ/U8GL6wMUJQo
         088d2X1G/8CexEXnKxNo3TTeXkNPpw/4NZeQLBNX8dpC3feDJeUVrjUhguopIfAPE879
         jzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560047; x=1729164847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsQ2/1OD1833y3AwH5IJOrZR5jmPSoKtfSG79U8bJN4=;
        b=naQbnuYRo1dB3WhUB0Oy8XDE3VEkdV+lX3ywg/7YP02MIs9SeG1bVEW88a0mXim3+b
         3X19U13HpNd6n77j9+s5Cnn7QXWlYSpAVwY6AtvKNwAKgAJZYMOJkZ/lXUY8OBBhjC64
         DIAOP5NsCzxNDohe4rAe3pUS5hpn1E+lBnT5ahrqnC09YkFvBH0ptPcSEB54hqvX+XTV
         Uedm3jI0V7iw0NW8cC03eovL0eGqoQYUO2i7nk9nantmGVF39XvTQvxoWgKbRrc8kV21
         FwolGBoMM/FX7r0is7pEZrODriqk+nph7+SLT/9vxdNDHodc/8OPmJJBDqyvBUrEw0H/
         IBIg==
X-Forwarded-Encrypted: i=1; AJvYcCW1v2TuLgkdbq8XfkUqKmC639dbrZhx/WvjVjVJYXhVPjBBMywEcK3EGlhct7UmcJ6mjCOSZ7I7gnV3Be8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgwI7rG+cCEZG6jObi2BFyypeBcD3wNugWSyJMqJd0EABEazp
	qvYqpKsSXlD3PolZDkaqrbL8RtEC3PU5ggCc9wTeqypIXg5hj0A8ykVVfjDaUiE=
X-Google-Smtp-Source: AGHT+IFtzNsWgaNiVVEj8OP/CCcRSjW/L9HZNJ/xW1811pDAMg/fQ7GHSKZ1D1WYhG9TkEqfw7s76w==
X-Received: by 2002:a17:907:e2d3:b0:a99:52aa:cae9 with SMTP id a640c23a62f3a-a998d1a256bmr530617366b.24.1728560046838;
        Thu, 10 Oct 2024 04:34:06 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:06 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:52 +0200
Subject: [PATCH RFC 14/28] ARM: entry: Drop trace argument from usr_entry
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-14-b94f451d087b@linaro.org>
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



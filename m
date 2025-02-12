Return-Path: <linux-kernel+bounces-511034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42AA324E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6849718853BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BA254B09;
	Wed, 12 Feb 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyUQY0xz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4A20B1F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359422; cv=none; b=YR4PYVyZGD7eCV/pJXBh+9iTqf+XoatQtXDpgNCvds6xlMqOS6TGUm2+ZxWxjTZSK3Fjrg3Rc06Muaxn3wk1acpgbpiVPD1qHRrmh9UBcH7VPqfLfWraAmCZQlJpuc0S93HN65KQD9y4+z+vdNp+CBRBWcoq525vbjIU+kRmFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359422; c=relaxed/simple;
	bh=b3M6qYg0KD95KLfHfeT357d4vgmk2nogAqPAsvE5nuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8Lf3+1h8XVF69f68o8be9KfPvcZwIiBMXO7BP2H/W4AbG6/oAFCUbLwOs54DlSljDfG3fAa1uqhquAFU7xJLNhLnUrKATafF+8eEXrj8DHyQnC/MeylFE5le7Kpu1OjRxNZRxBZuuqYwFjojqDGI+/2UYPo5/IwmF6uBC0SPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WyUQY0xz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-308edbc368cso32852311fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359419; x=1739964219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd5myOXJmBrq2ZireMN1LAxoO4XGu12StPrpGUT11PQ=;
        b=WyUQY0xzdx6U95jLocwtNAHUmKKz4y9XCmk84ZAypI1ohv9bnT9Vlv1jI7b//ioUur
         DsV7zCKgMfOK0d3GzyFLCnXaEO9KczWoYY2kT6OAjwKEUlf8/CAjIMDv4mB3fzVBxSGV
         7L+II1tshPpPSTIv9+h7bjY7OPu3UPUQ5+d1HsbSGxy0jnWe+We27C01tvmaEDIbGNqa
         WAhpPUaD40hDJZrLc9qAC5Rma0x/TI3uLIur+Pd3xhM11t8HWMA5uzdNMdHmkNkjTWuE
         xnj+0kN8qgNCld63PPi6KBPhxap9FFCkUWO9Mk6XaPR2LzVU7GcXqzJKle6TNsReHbmV
         xhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359419; x=1739964219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd5myOXJmBrq2ZireMN1LAxoO4XGu12StPrpGUT11PQ=;
        b=F8OoV2SxsgbP6Sbw8XS4X3kdVhYsM45u8BEmlghl7zm+fl8lEhjxMJj12n+Dl+Rbtq
         AqAsa755qwQshnmDzYDoolpW87xdGkgYb+iW4QfiaP1SPuUD8m9JB42SnHw1pSUYvI1O
         cCrWiuXPSZZ5K8R3j6I3GWy6/VhYi/fTkZLrJAsrnfe5o4KG2g0JUYBql2EwMvMuoLwY
         PgdSxGwzw9PPFjQ4J1OJGsu9ZBLsV3qAVN6qHwx4HwygrE8XUYVAXw4ot1B9wiEAEkN8
         AkfIqJFeyxN7zd6NsjFBVCZ3PVlCk+j5M5AGQDlRbh/bz/9a0pOQEbEfeBajOf6C4/o/
         RwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlA/jlBetrh7yzCbIa9/yW5+hI9Kz6Z5GDWKUh2sePcsuq7J0bKMRKQcz0+0gYJ6b7SxdD74Si/kGfmTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7kn79I2cr2noV07JVAoCmOOQKoRbXmBUf0izeX65T8lfi+Ani
	3grd7fWJ2XAaGksjyacXGu5YLdZT6LMgbVyiuGBneVrmFM6YFyo4E2GPn5Qh3jg=
X-Gm-Gg: ASbGncs+9lfMMNnsOd9M2do19XH6uDGHaKtbWT2X5Aa8ho3BJHgO9Pphh/knKeqJlUq
	Np+wY2k5QfeNZoADUNIno1huMZWZUz/h0ztw5wpqlbpcfEOYEHOz6O5HNNw0XC6VaT4/e4CgpCu
	5brPucWVwm3v6F/FLkC1bSnCthmQsw9VGEwi4p54BXho2CzqtDanCdwdf5mNIuqQLi4e33U8CS9
	3iJq+uvxfnn1xp19VWlQu8ZiLvTuswS8/cMCU6j3V9pTRox86xDH9TLBLV1XLV6QnRxkaDD4q87
	jjqvGauRd7o4PvfrAcv1X9KDvA==
X-Google-Smtp-Source: AGHT+IFnBCvVu/VGrB3ufwIm9PIPjMNjQwi218jFm+vuC3QKd2lwYi8qU7J4iPr0yHXGhJ+sLSoDTg==
X-Received: by 2002:a05:651c:1991:b0:2ff:c3a2:f408 with SMTP id 38308e7fff4ca-30904fe65b4mr8433611fa.12.1739359418597;
        Wed, 12 Feb 2025 03:23:38 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:38 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:25 +0100
Subject: [PATCH v4 31/31] ARM: entry: Straighten syscall returns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-31-a457ff0a61d6@linaro.org>
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

Since ret_fast_syscall() is now only called in two spots in
vector_swi, we can inline the function into vector_swi, and
skip the separate call, placing the code from ret_fast_syscall
at the end of vector_swi and one of them inside an ifdef that
gets compiled out for !EABI.

TODO: is the UNWIND(.fnstart/.cantunwind/.fnend) really needed
on vector_swi after this change or can I just drop it?
I do not understand unwind well enough :/

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index a5a0e757ab23d151485092a078af98966e039869..f9c38f5311851e299234997796cd78de06a5c531 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -30,21 +30,6 @@ saved_pc	.req	lr
 
 	.section .entry.text,"ax",%progbits
 	.align	5
-/*
- * As we will need to call out to some C functions,
- * we save r0 first to avoid needing to save registers around each C function
- * call.
- */
-ret_fast_syscall:
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)
-	add	sp, sp, #(S_R0 + S_OFF)
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
-	bl	stackleak_erase_on_task_stack
-#endif
-	restore_user_regs
- UNWIND(.fnend		)
-ENDPROC(ret_fast_syscall)
 
 /*
  * "slow" syscall return path.  "why" tells us if this was a real syscall.
@@ -122,6 +107,8 @@ ENDPROC(vector_bhb_bpiall_swi)
 #endif
 	.align	5
 ENTRY(vector_swi)
+ UNWIND(.fnstart	)
+ UNWIND(.cantunwind	)
 #ifdef CONFIG_CPU_V7M
 	v7m_exception_entry
 #else
@@ -210,9 +197,9 @@ ENTRY(vector_swi)
 	mov	r0, tbl
 	mov	r2, scno			@ syscall number from r7
 	bl	invoke_syscall
-	b	ret_fast_syscall
-
 #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
+	b	9002
+
 	/*
 	 * We failed to handle a fault trying to access the page
 	 * containing the swi instruction, but we're not really in a
@@ -225,8 +212,17 @@ ENTRY(vector_swi)
 	sub	lr, saved_pc, #4
 	str	lr, [sp, #S_PC]
 	get_thread_info tsk
-	b	ret_fast_syscall
+9002:
+	/* Exit !AEABI clause */
+#endif
+
+	/* Return from syscall */
+	add	sp, sp, #(S_R0 + S_OFF)
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
 #endif
+	restore_user_regs
+ UNWIND(.fnend		)
 ENDPROC(vector_swi)
 	.ltorg
 

-- 
2.48.1



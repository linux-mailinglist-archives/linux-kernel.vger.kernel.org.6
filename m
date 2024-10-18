Return-Path: <linux-kernel+bounces-371193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5AD9A37AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1BA2831C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523C18C92A;
	Fri, 18 Oct 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B80xh7EL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056618C33E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238041; cv=none; b=XtDY02UVXg8Mq9k2TBj7/4Go77xr7vJIVKcy/zILi75BviEjkNH1YaY/Q/PlUwg76qHzVTjdneQMj9TmAJTcuQXVUFhgm3OxDwC1JYgw4EkSrC7mqT+92VAHFVNEDcBKXNIVsI8MfrYvuBd67V9pamK/tHlmuddSC8uDDYuPKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238041; c=relaxed/simple;
	bh=Jlg+6uPR7/7OaiOrAMoZ+JGT2+27o/oDT1dKUQsADAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O5oTn3F8PNr2HYg8p1JDjt90CQ7yyT0soarMONUjF2MfWfYiImBianUN3XjCFgv+IsT2IqquB0eCYdxa9CNBU9aCcMk2ogINRbPiXADNMXWJgvUccAXYJP1/KPqV6xm6iFtRWg5DoPjKUR/ZVtaS3s8IUuncKtpVt2ZNKIlylCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B80xh7EL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso11826987b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729238039; x=1729842839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNwrKgHpfeEPpiezt/Iqbr3KcELj8yx0Qy4sFreW/+w=;
        b=B80xh7EL+H5JqWvcEjOL/xTlJxqlhqFEze2WeWbMzugZvJTSR45KRLK0ardUcNc1AC
         dP7kQN1bB+z071Qcg43BSKExTiIEAQesIaR/G6BS1KZD+xaqX+BKL8AV8FhsHOjiyaCG
         aVEjhpU/BuEjWgSOgHIn56xfIPAi3xNiV1+MFkEBEaDtJ5j6wG2U3HIEWcqwqhPrHSSA
         e7LgGsO6IUbrNfutruE0en8S7PsaYoZhQmYCzMYeDUlN/iW9EwpTksFuYGz4fCcv/kGg
         76pGfzD3CAp7fJUfalyaxLI+hzdkHtBPQYgee5jwTMg1A/Br1fuQC175JgAtb9zKNyeo
         X+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238039; x=1729842839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNwrKgHpfeEPpiezt/Iqbr3KcELj8yx0Qy4sFreW/+w=;
        b=ZEa2AeA6kDwRdHGmZwfu168l6xpV3Fak74RpeLs8xIS7HPYeQyl+UbmShytzaDKGoj
         N6DFHaa5pf9v2UUbtpxgbdf5agfL0OTZek102wrNt5he9fLUYEfnJqq8kUYMP5jEjQ/9
         WaeR1OOyqXcLftZAhfnFtkVuxVF+fF5+DV5A8etVL6YoZjb1LVTFbjL+mtdKjUfYraVL
         LuounpsChCnmlOiAT3/+tb5STOGPLtDZ3aDxm1uQcWoHFuUFOzn6fkUuOOdxlzcByg00
         jLR2f1l4ogy3+95vw/ngrZPNNUSotijX/uXM41waDkvgvjrM//MQYWhU21DD3e1Duz8t
         LOaw==
X-Gm-Message-State: AOJu0YyutudwmE15GkurQkjWLNNoAk6sNoOZ1koOdOegut7Ep7+773qH
	tDvwwm438j8qUXWgQfdW8njnSR8tQP/AEmbD6kya3XEQ86h0HztiUfrBwv8USL/gT4OvsA==
X-Google-Smtp-Source: AGHT+IEe29XOvyn9WDi9xAEfZbcgksmYHhNGnVdSc/NhMxBAycrneIeqDFrR9WDdNM7rvT4ebtva2h+o
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:368c:b0:6e2:1b8c:39bf with SMTP id
 00721157ae682-6e5bfbe2e35mr374097b3.2.1729238039135; Fri, 18 Oct 2024
 00:53:59 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:53:50 +0200
In-Reply-To: <20241018075347.2821102-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018075347.2821102-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3357; i=ardb@kernel.org;
 h=from:subject; bh=mLKqxqTEQhRSUiFWy6NyWFEr4AEp2njT3OggUKTWlcU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV1IhK+mUG3X1MInF46ZVaW39MzS7Dc+PettVdqLe0vYD
 kyfxqzZUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby6jXDP91/7D2zGxc7ilVI
 lTPPOHkmLbhXvmWVjXix0Tk7hmkNcxj+h/rmCu6d8Jl5zcKE+y/Uj9VPSmN6dH2N0Z5/wtzTT7m 2cQMA
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018075347.2821102-7-ardb+git@google.com>
Subject: [PATCH v4 2/3] arm64/crc32: Reorganize bit/byte ordering macros
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, will@kernel.org, catalin.marinas@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for a new user, reorganize the bit/byte ordering macros
that are used to parameterize the crc32 template code and instantiate
CRC-32, CRC-32c and 'big endian' CRC-32.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/lib/crc32.S | 91 +++++++++-----------
 1 file changed, 39 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
index 22139691c7ae..f9920492f135 100644
--- a/arch/arm64/lib/crc32.S
+++ b/arch/arm64/lib/crc32.S
@@ -10,44 +10,48 @@
 
 	.arch		armv8-a+crc
 
-	.macro		byteorder, reg, be
-	.if		\be
-CPU_LE( rev		\reg, \reg	)
-	.else
-CPU_BE( rev		\reg, \reg	)
-	.endif
+	.macro		bitle, reg
 	.endm
 
-	.macro		byteorder16, reg, be
-	.if		\be
-CPU_LE( rev16		\reg, \reg	)
-	.else
-CPU_BE( rev16		\reg, \reg	)
-	.endif
+	.macro		bitbe, reg
+	rbit		\reg, \reg
 	.endm
 
-	.macro		bitorder, reg, be
-	.if		\be
-	rbit		\reg, \reg
-	.endif
+	.macro		bytele, reg
 	.endm
 
-	.macro		bitorder16, reg, be
-	.if		\be
+	.macro		bytebe, reg
 	rbit		\reg, \reg
-	lsr		\reg, \reg, #16
-	.endif
+	lsr		\reg, \reg, #24
+	.endm
+
+	.macro		hwordle, reg
+CPU_BE(	rev16		\reg, \reg	)
 	.endm
 
-	.macro		bitorder8, reg, be
-	.if		\be
+	.macro		hwordbe, reg
+CPU_LE(	rev		\reg, \reg	)
 	rbit		\reg, \reg
-	lsr		\reg, \reg, #24
-	.endif
+CPU_BE(	lsr		\reg, \reg, #16	)
+	.endm
+
+	.macro		le, regs:vararg
+	.irp		r, \regs
+CPU_BE(	rev		\r, \r		)
+	.endr
+	.endm
+
+	.macro		be, regs:vararg
+	.irp		r, \regs
+CPU_LE(	rev		\r, \r		)
+	.endr
+	.irp		r, \regs
+	rbit		\r, \r
+	.endr
 	.endm
 
-	.macro		__crc32, c, be=0
-	bitorder	w0, \be
+	.macro		__crc32, c, order=le
+	bit\order	w0
 	cmp		x2, #16
 	b.lt		8f			// less than 16 bytes
 
@@ -60,14 +64,7 @@ CPU_BE( rev16		\reg, \reg	)
 	add		x8, x8, x1
 	add		x1, x1, x7
 	ldp		x5, x6, [x8]
-	byteorder	x3, \be
-	byteorder	x4, \be
-	byteorder	x5, \be
-	byteorder	x6, \be
-	bitorder	x3, \be
-	bitorder	x4, \be
-	bitorder	x5, \be
-	bitorder	x6, \be
+	\order		x3, x4, x5, x6
 
 	tst		x7, #8
 	crc32\c\()x	w8, w0, x3
@@ -95,42 +92,32 @@ CPU_BE( rev16		\reg, \reg	)
 32:	ldp		x3, x4, [x1], #32
 	sub		x2, x2, #32
 	ldp		x5, x6, [x1, #-16]
-	byteorder	x3, \be
-	byteorder	x4, \be
-	byteorder	x5, \be
-	byteorder	x6, \be
-	bitorder	x3, \be
-	bitorder	x4, \be
-	bitorder	x5, \be
-	bitorder	x6, \be
+	\order		x3, x4, x5, x6
 	crc32\c\()x	w0, w0, x3
 	crc32\c\()x	w0, w0, x4
 	crc32\c\()x	w0, w0, x5
 	crc32\c\()x	w0, w0, x6
 	cbnz		x2, 32b
-0:	bitorder	w0, \be
+0:	bit\order	w0
 	ret
 
 8:	tbz		x2, #3, 4f
 	ldr		x3, [x1], #8
-	byteorder	x3, \be
-	bitorder	x3, \be
+	\order		x3
 	crc32\c\()x	w0, w0, x3
 4:	tbz		x2, #2, 2f
 	ldr		w3, [x1], #4
-	byteorder	w3, \be
-	bitorder	w3, \be
+	\order		w3
 	crc32\c\()w	w0, w0, w3
 2:	tbz		x2, #1, 1f
 	ldrh		w3, [x1], #2
-	byteorder16	w3, \be
-	bitorder16	w3, \be
+	hword\order	w3
 	crc32\c\()h	w0, w0, w3
 1:	tbz		x2, #0, 0f
 	ldrb		w3, [x1]
-	bitorder8	w3, \be
+	byte\order	w3
 	crc32\c\()b	w0, w0, w3
-0:	bitorder	w0, \be
+0:	bit\order	w0
 	ret
 	.endm
 
@@ -146,5 +133,5 @@ SYM_FUNC_END(crc32c_le_arm64)
 
 	.align		5
 SYM_FUNC_START(crc32_be_arm64)
-	__crc32		be=1
+	__crc32		order=be
 SYM_FUNC_END(crc32_be_arm64)
-- 
2.47.0.rc1.288.g06298d1525-goog



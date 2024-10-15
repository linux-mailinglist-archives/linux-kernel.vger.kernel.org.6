Return-Path: <linux-kernel+bounces-365557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484099E45A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E54281509
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9FE1E765B;
	Tue, 15 Oct 2024 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2Ymbtuc"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFC146D6B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988919; cv=none; b=r+umj25SCACp8ttvEy+Rc9ANyFGVxgER9hHDPM+glBNBee3sLFdquDwaBhS4SasL4DFtLIam2jXW0aAXB3L6f8djOBMH36Wuq98uhovapNXdHyZSchx5nOFrACsC8588Yhuaap000n3F0nSob9dnKKBao2w8aslOS5Oexc2Lyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988919; c=relaxed/simple;
	bh=kEqsGqMnenIrGLULLkXDJmc0xqN2YM+PDFTCKGEnApw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rGJ12bmnhMgDmVrnatElT8nRJ6vPOVqsyribPE+EOpDSngjFtLZPb+Inl2yeXtN95g2boj1t+xDV73KRO7taafiOwT3zoVniiqwVOu5fmv7wAH8Jj4G/RY1yjnja/40PYyrix4ey54b2YmDFftkvA5VSf21MEm92O8GUSUw1r1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2Ymbtuc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so94112947b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728988917; x=1729593717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdyYwjyFS7cKng3xrhrvuZYheW62euvO0qiJZmOhRNg=;
        b=A2Ymbtuc9UJWsAxXwyaY8T0Yf88RTc8/0KvrV88edG0xDjJ0dyr8hAkDRwjPD5K7xV
         v+1ILDwGGrxwR+gc5Js1pb/jaYicSyHSNWf6GZ2e7pYXNxSlMJDkDWKt1JrE5u9B1lQi
         AeONNCGDGRIXJ0OiRJnFigJaS9WNV8UmbvFFRqvusN8vZ9970gdocOgaOosYTg7ZuHyl
         RJpB/ICAFYSvtZdHqfgS48Lx6yS2u/E5oW918F/sopzaA284kwtqicj7Kb+yH3dZlXLw
         XIg2FIUj0DlTte6ITZngOLhroIbh/IKNDlE57uzsMO34RTWl5h3+RXa1KTudCzVUTT3N
         t73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988917; x=1729593717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdyYwjyFS7cKng3xrhrvuZYheW62euvO0qiJZmOhRNg=;
        b=cJgOWiuz9hHJ3jsAScfJu9Rmt93rphQBiGT+HYGfVi7MCAfVW/9g1TTuJPfvp7dktX
         zN8x7FW22i7JsOzewgjYjGyfqFcxQpSPaJdaTsHMA4xp3BLu195FVglrTSJOzFeFQ0qr
         Xcuxs1E0H1LfVwxq9oOQBBSuYcRHB1bCW7mqGvfxqbGBfSLXcm7lBNJJcFbGT8/RUjBG
         W+aM8kd+YZCFCqzdMR/1m7jV1ILmSLCzx604TL49gXNXAv1Gpm9W1/cQgAD1SfUuABWE
         dx8sHGTc1LGPUqTesowGHjFHZlmQ1GTkIPXHgTnt3Z+ATgSCfTwnPsNz6XT2RrVRhwpn
         sHrg==
X-Gm-Message-State: AOJu0Yyqth85joUGUEpwiBZWd8wYlwV53xOtn6rpLE87jjJTSq/hMaxl
	s92lcaduyf35dwgJLnjmneDaSYvG+EVQEEEykkAOXnR/+Z1Vpvls/0VJMK5EabN/AEyKAw==
X-Google-Smtp-Source: AGHT+IH+rC92o2dS6805siIyLPfs5IU3LYfFFrB+W0nlBTHPZXIyU9ukNyfRiy6dx7SJ2FOe9DBahSKj
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:3190:b0:6e2:120b:be57 with SMTP id
 00721157ae682-6e347b4aec8mr261627b3.5.1728988916665; Tue, 15 Oct 2024
 03:41:56 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:41:39 +0200
In-Reply-To: <20241015104138.2875879-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015104138.2875879-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3064; i=ardb@kernel.org;
 h=from:subject; bh=t1qGgmVoGyL6ETZIh2nQx2YqAZcU/0d9D3ED8tzRuT0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ3P7bFhxxzJmUnPdeKnny8Plj8qv/GplpG6pL6eOMO31
 pW7X67oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPxa2D47y61wknXbrn3JttT
 usdM7J6+OZBq+HeyiWJL3T7PmKZvoQz/bHazmYb5znhboJb3XUBp8/SJHa6s+2cHrZrAzhAUqju LAQA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015104138.2875879-5-ardb+git@google.com>
Subject: [PATCH 1/2] arm64/lib: Handle CRC-32 alternative in C code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, will@kernel.org, catalin.marinas@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for adding another code path for performing CRC-32, move
the alternative patching for ARM64_HAS_CRC32 into C code. The logic for
deciding whether to use this new code path will be implemented in C too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/lib/Makefile     |  2 +-
 arch/arm64/lib/crc32-glue.c | 34 ++++++++++++++++++++
 arch/arm64/lib/crc32.S      | 21 ++++--------
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 13e6a2829116..8e882f479d98 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -13,7 +13,7 @@ endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
-obj-$(CONFIG_CRC32) += crc32.o
+obj-$(CONFIG_CRC32) += crc32.o crc32-glue.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
diff --git a/arch/arm64/lib/crc32-glue.c b/arch/arm64/lib/crc32-glue.c
new file mode 100644
index 000000000000..0b51761d4b75
--- /dev/null
+++ b/arch/arm64/lib/crc32-glue.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crc32.h>
+#include <linux/linkage.h>
+
+#include <asm/alternative.h>
+
+asmlinkage u32 crc32_le_arm64(u32 crc, unsigned char const *p, size_t len);
+asmlinkage u32 crc32c_le_arm64(u32 crc, unsigned char const *p, size_t len);
+asmlinkage u32 crc32_be_arm64(u32 crc, unsigned char const *p, size_t len);
+
+u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
+{
+	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
+		return crc32_le_base(crc, p, len);
+
+	return crc32_le_arm64(crc, p, len);
+}
+
+u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
+{
+	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
+		return __crc32c_le_base(crc, p, len);
+
+	return crc32c_le_arm64(crc, p, len);
+}
+
+u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
+{
+	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
+		return crc32_be_base(crc, p, len);
+
+	return crc32_be_arm64(crc, p, len);
+}
diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
index 8340dccff46f..5dac63da4247 100644
--- a/arch/arm64/lib/crc32.S
+++ b/arch/arm64/lib/crc32.S
@@ -136,25 +136,16 @@ CPU_BE( rev16		\reg, \reg	)
 	.endm
 
 	.align		5
-SYM_FUNC_START(crc32_le)
-alternative_if_not ARM64_HAS_CRC32
-	b		crc32_le_base
-alternative_else_nop_endif
+SYM_FUNC_START(crc32_le_arm64)
 	__crc32
-SYM_FUNC_END(crc32_le)
+SYM_FUNC_END(crc32_le_arm64)
 
 	.align		5
-SYM_FUNC_START(__crc32c_le)
-alternative_if_not ARM64_HAS_CRC32
-	b		__crc32c_le_base
-alternative_else_nop_endif
+SYM_FUNC_START(crc32c_le_arm64)
 	__crc32		c
-SYM_FUNC_END(__crc32c_le)
+SYM_FUNC_END(crc32c_le_arm64)
 
 	.align		5
-SYM_FUNC_START(crc32_be)
-alternative_if_not ARM64_HAS_CRC32
-	b		crc32_be_base
-alternative_else_nop_endif
+SYM_FUNC_START(crc32_be_arm64)
 	__crc32		be=1
-SYM_FUNC_END(crc32_be)
+SYM_FUNC_END(crc32_be_arm64)
-- 
2.47.0.rc1.288.g06298d1525-goog



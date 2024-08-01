Return-Path: <linux-kernel+bounces-270600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8779441EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0765B22206
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B513D633;
	Thu,  1 Aug 2024 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="huxNvLTp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1021EB4A0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483451; cv=none; b=j4HfhESab0y0MtbP1eINz5y/eztIR5THMhhVw2sqtN1ycPaP1PPkHnFjRBEjzcwI9STrd6yaBbfRuyZ7mmTOvBRc4eIoOlITJxfjKUPJqdZXzXhza9ndxBKwxzwisDGXKXGXgadKWMcF5wBOdUHhvP/AHk8eWQAxhkPGnHZEfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483451; c=relaxed/simple;
	bh=8Ikd0az4JJrUiwdL8FoGustpzMl6inpDXJ+jDfZEthU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWaUNQnMvo+2Jb26Wy8pufh0TuysCEQwqaDXSeo7JqzlqYzn5sT/4cfGFE9FmibzQjlK/8/oOG5nf2qIqSZFP/QoElRM7RJRrQ0DlTkWM1GDBwfPT3La0owl2twjZKZZz88OwaehvnbK3u+4VvBgULRpUp6d4IbJe+wdz6XyPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=huxNvLTp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d1c655141so4879772b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722483449; x=1723088249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juGX4dhtMScEhsSdRcfK8Rpc9+vyV1DigC2XZp7/goM=;
        b=huxNvLTp6kr2yuvnHybyobmReP1jiVSeSsLflUuSyFLYcDsxhw9J+GhGkzomef9KDH
         RZr5RWHpFkl1USBiBKGPfhDtT99LchCI1MxINPmtqkonh6dvEE3EwS0dxoJHGqWc6Oze
         oPKB0PmvrZjU9l0qSnZHohxhHNVpJnzCTgiFFtVQDpv1ut+3/IQe995/RwqPUJvOEDnA
         Y5b0PhmmRPH1aGBNWMrIdEqE3PZpARa1s42QIa9zpKL2HCrllabotXAD/K6s382Lu31j
         KnjzLoImYyvXRxw/bFiVt5fyGPB05tQbmjj/c0bRlGtd3GSl5LUmc2sf21lvFreWs26E
         3BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722483449; x=1723088249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juGX4dhtMScEhsSdRcfK8Rpc9+vyV1DigC2XZp7/goM=;
        b=Q3GVTHcYqbMkasr8uI6nMUshohruSd609pb+k2inMFCNj7OzAhXy1VBpP5oVgPo8hY
         tkKHtAvFSQwyPCOgUWDH5mlME4I5jF4uPHi0+s/JVZKyh2kUt5TJ1vdk+SLtxui3j7ff
         etfc8I7KD69CYidmHaQqNT495O/UA+qkDZ/FN1gyDFTjpPk2K1FeKRWcc3xhHtM6zjXq
         kUfj0Mi86nzl+JcmVH7rIZPjWx4uMjwd98CyrgLpSy5VQWV6TEw+XFp6bsWv3KFl5BVi
         4QNZM4OGnuBfYeaB7CppdSyaDXdpQxkOZ5ruv4UkBDuaNO86P2XHQX2+a4uoM4J4evt8
         YcAA==
X-Forwarded-Encrypted: i=1; AJvYcCX28Efgewjp7IByN8zWHb1JmOobxQ5k9vHHW780MrT7lPUb6Dh74wBbe2LO2f4bX2IPGcj+i8nUstbaXNhwbIpgMt5531zCZF5+k8z2
X-Gm-Message-State: AOJu0YwMmQz8pbH1ve/xtKA/J/fgFaokSt5i8LGswQmeD2PoomGaSAw5
	P+qG+tnxjRT+LTJE5FvX6oyF3KcpxbtlQZ+SCyUV9n45oCm/VyiKYmhH/6gP2UA=
X-Google-Smtp-Source: AGHT+IHd77R4Q6aO0Qn2A2tAcoDWubL4f4kxPAt+IpSkUcrrst/BIV5U2jMLCnwx7gBBaZIyiw7PjQ==
X-Received: by 2002:a05:6a00:4650:b0:70b:1134:95a8 with SMTP id d2e1a72fcca58-7105d7bbc06mr1573942b3a.23.1722483449233;
        Wed, 31 Jul 2024 20:37:29 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ae3asm10954457b3a.91.2024.07.31.20.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 20:37:28 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/2] riscv: Omit optimized string routines when using KASAN
Date: Wed, 31 Jul 2024 20:36:59 -0700
Message-ID: <20240801033725.28816-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240801033725.28816-1-samuel.holland@sifive.com>
References: <20240801033725.28816-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The optimized string routines are implemented in assembly, so they are
not instrumented for use with KASAN. Fall back to the C version of the
routines in order to improve KASAN coverage. This fixes the
kasan_strings() unit test.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/string.h | 2 ++
 arch/riscv/kernel/riscv_ksyms.c | 3 ---
 arch/riscv/lib/Makefile         | 2 ++
 arch/riscv/lib/strcmp.S         | 1 +
 arch/riscv/lib/strlen.S         | 1 +
 arch/riscv/lib/strncmp.S        | 1 +
 arch/riscv/purgatory/Makefile   | 2 ++
 7 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index a96b1fea24fe..5ba77f60bf0b 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -19,6 +19,7 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
 extern asmlinkage void *memmove(void *, const void *, size_t);
 extern asmlinkage void *__memmove(void *, const void *, size_t);
 
+#if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 #define __HAVE_ARCH_STRCMP
 extern asmlinkage int strcmp(const char *cs, const char *ct);
 
@@ -27,6 +28,7 @@ extern asmlinkage __kernel_size_t strlen(const char *);
 
 #define __HAVE_ARCH_STRNCMP
 extern asmlinkage int strncmp(const char *cs, const char *ct, size_t count);
+#endif
 
 /* For those files which don't want to check by kasan. */
 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index a72879b4249a..5ab1c7e1a6ed 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -12,9 +12,6 @@
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 2b369f51b0a5..8eec6b69a875 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -3,9 +3,11 @@ lib-y			+= delay.o
 lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= memmove.o
+ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= strncmp.o
+endif
 lib-y			+= csum.o
 ifeq ($(CONFIG_MMU), y)
 lib-$(CONFIG_RISCV_ISA_V)	+= uaccess_vector.o
diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 687b2bea5c43..542301a67a2f 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -120,3 +120,4 @@ strcmp_zbb:
 .option pop
 #endif
 SYM_FUNC_END(strcmp)
+EXPORT_SYMBOL(strcmp)
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 8ae3064e45ff..962983b73251 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -131,3 +131,4 @@ strlen_zbb:
 #endif
 SYM_FUNC_END(strlen)
 SYM_FUNC_ALIAS(__pi_strlen, strlen)
+EXPORT_SYMBOL(strlen)
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index aba5b3148621..0f359ea2f55b 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -136,3 +136,4 @@ strncmp_zbb:
 .option pop
 #endif
 SYM_FUNC_END(strncmp)
+EXPORT_SYMBOL(strncmp)
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index f11945ee2490..fb9c917c9b45 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
+ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 purgatory-y += strcmp.o strlen.o strncmp.o
+endif
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
-- 
2.45.1



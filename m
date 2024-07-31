Return-Path: <linux-kernel+bounces-268692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080549427EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8688D1F2148C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C71A71EA;
	Wed, 31 Jul 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QU+woTb7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D61A71E7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410957; cv=none; b=fDQAliS1eeN3B1452IAFYhdtj5ENkDNP0CNwResgHkNZoEcruQE4bMD0UUgui8Txv7Bt/0T8BKWIN48CDP9IvucnGYcwi1A+qrU8k+51RgpwgHo5TKAkYwJcHa7jGNgyALmq/DfucBG5rCptJB85tgqWr5XI5bsrP4xnhLLaObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410957; c=relaxed/simple;
	bh=EqitUUjKu5Zm5gcBsrKLsjrHvKELarvSQjIMj7eqnxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmLo3CFNa089c7JQG8j6IZjyrPs4e2EXmbl89+74ZSqD4bBi33WGudIWT8rfSS/IjiDxYQ02Rcl/IQvKkVw3y/twih9bBb9eEV6zcfA4BeT8rVMaKOvZeQ5UKf+pUADPDH1RodRf2b+TOp4eupTio+PD2ve+SPcNs3qbJ7EGDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QU+woTb7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so31483585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722410954; x=1723015754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTv3dCV8uOmdi0okEMo3U0BHPIZT88r4+7MFI/VgzDo=;
        b=QU+woTb7q9ZO9xxQ3KGU/RomYu1pwu8u36RhJcfsLH7m2tcwYpBbVje12/1IylQVR5
         OdoebsgJskkdcOT5ANzcoNvuJy9GRcJTU5uQkmq97K380YMfi7mKdQUk+ZRJremWDpDD
         YCdytMKNOYjJePyB1bhSr92ZOKHa0KtpDRasWAtaMcPEVIh9vOoKFfdjrLtK2NPb9XmC
         yVwjHQHl+sSfQCA6IR9FUSPFVkKDAiNRw0jd75bPycCqz7+bntGjZNVv6U9PfrdQ/8nN
         rhnpaPpaIHo51/Hv8+lvecTUhNUlP5fJ5ZEG0sfY2TG7YLytekTHCO32gKv8Fk+nZLHw
         94/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722410954; x=1723015754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTv3dCV8uOmdi0okEMo3U0BHPIZT88r4+7MFI/VgzDo=;
        b=TJEQ1+NvxMb6Gxjezplb/imKXN4cAeR2JRU8Jdc43DBIN9ciOuq3CJ7eZU+JjgwEbk
         VfEKiqzlrSL1m/Q+/pc2fTh8Yr5DwwvedILrGRk9Ej5w2uh+dGXSNzFoEKXnkTTp9qjt
         xCf1aKGpC6is7vBdoj3xSOhDrmAXuyEZSNvL+6H70kfWoLxg7Op5LptHHSgfGpCcWqHr
         ERNVrmfFLwR6lITCKbVeM46EjqlSLPAxU/nsEkqgo8oxe6xl2r9aUAl1ubtzU/KIZqkv
         cIpa85Bz2JfkoATfdUZ8GJATwvvo8DFFpzy4WgrSAiAKAqHn8lXXDD8SzQn3Q/j6TjmF
         Pzsw==
X-Forwarded-Encrypted: i=1; AJvYcCVImiSi5dcSrul2k80XS8p6/zIjyRTtmQNp3NZxXvWvrB2/8repAHGtU6jmccZGMAuYQj7AHXBm9H/vzvpZHtbtt4I2UBQIn2vfQbJC
X-Gm-Message-State: AOJu0YwteGxeBBSwbYHxM6cCPKyyecf/9T3epjHKUtourLhRMpcPoYC1
	RMGvCVQv7B4ujjsQ6m9A8YUkBsbGE4R9p4ti94JsYRtRy+9BUAe5sv1tuWUvg+c=
X-Google-Smtp-Source: AGHT+IGdWI7pNX76CY5MDuyu7lWxBLphPJYSwh1U+oglkHzUOKa2xmfRAJ3FI2utc6jCiAfVd04UpA==
X-Received: by 2002:a5d:440f:0:b0:367:f056:24ac with SMTP id ffacd0b85a97d-36b5ceff66emr7868257f8f.28.1722410954255;
        Wed, 31 Jul 2024 00:29:14 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862271sm16319776f8f.98.2024.07.31.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:29:13 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 05/13] riscv: Implement cmpxchg8/16() using Zabha
Date: Wed, 31 Jul 2024 09:23:57 +0200
Message-Id: <20240731072405.197046-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zabha in cmpxchg8/16() operations.

Note that in the absence of Zacas support in the toolchain, CAS
instructions from Zabha won't be used.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               | 18 ++++++++
 arch/riscv/Makefile              |  3 ++
 arch/riscv/include/asm/cmpxchg.h | 78 ++++++++++++++++++++------------
 arch/riscv/include/asm/hwcap.h   |  1 +
 arch/riscv/kernel/cpufeature.c   |  1 +
 5 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d955c64d50c2..212ec2aab389 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -613,6 +613,24 @@ config RISCV_ISA_ZAWRS
 	  use of these instructions in the kernel when the Zawrs extension is
 	  detected at boot.
 
+config TOOLCHAIN_HAS_ZABHA
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zabha)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zabha)
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZABHA
+	bool "Zabha extension support for atomic byte/halfword operations"
+	depends on TOOLCHAIN_HAS_ZABHA
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	  Enable the use of the Zabha ISA-extension to implement kernel
+	  byte/halfword atomic memory operations when it is detected at boot.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZACAS
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index f1788131d5fe..f6dc5ba7c526 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -85,6 +85,9 @@ endif
 # Check if the toolchain supports Zacas
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
 
+# Check if the toolchain supports Zabha
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index c626fe0d08ae..ebcd4a30ae60 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -108,34 +108,49 @@
  * indicated by comparing RETURN with OLD.
  */
 
-#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
-({									\
-	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
-	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
-	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
-			<< __s;						\
-	ulong __newx = (ulong)(n) << __s;				\
-	ulong __oldx = (ulong)(o) << __s;				\
-	ulong __retx;							\
-	ulong __rc;							\
-									\
-	__asm__ __volatile__ (						\
-		prepend							\
-		"0:	lr.w %0, %2\n"					\
-		"	and  %1, %0, %z5\n"				\
-		"	bne  %1, %z3, 1f\n"				\
-		"	and  %1, %0, %z6\n"				\
-		"	or   %1, %1, %z4\n"				\
-		"	sc.w" sc_sfx " %1, %1, %2\n"			\
-		"	bnez %1, 0b\n"					\
-		append							\
-		"1:\n"							\
-		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
-		: "rJ" ((long)__oldx), "rJ" (__newx),			\
-		  "rJ" (__mask), "rJ" (~__mask)				\
-		: "memory");						\
-									\
-	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
+({										\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
+	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&				\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA) &&		\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)) {		\
+		r = o;								\
+										\
+		__asm__ __volatile__ (						\
+			prepend							\
+			"	amocas" cas_sfx " %0, %z2, %1\n"		\
+			append							\
+			: "+&r" (r), "+A" (*(p))				\
+			: "rJ" (n)						\
+			: "memory");						\
+	} else {								\
+		u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+		ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+		ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			       << __s;						\
+		ulong __newx = (ulong)(n) << __s;				\
+		ulong __oldx = (ulong)(o) << __s;				\
+		ulong __retx;							\
+		ulong __rc;							\
+										\
+		__asm__ __volatile__ (						\
+			prepend							\
+			"0:	lr.w %0, %2\n"					\
+			"	and  %1, %0, %z5\n"				\
+			"	bne  %1, %z3, 1f\n"				\
+			"	and  %1, %0, %z6\n"				\
+			"	or   %1, %1, %z4\n"				\
+			"	sc.w" sc_sfx " %1, %1, %2\n"			\
+			"	bnez %1, 0b\n"					\
+			append							\
+			"1:\n"							\
+			: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+			: "rJ" ((long)__oldx), "rJ" (__newx),			\
+			  "rJ" (__mask), "rJ" (~__mask)				\
+			: "memory");						\
+										\
+		r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	}									\
 })
 
 #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
@@ -177,8 +192,13 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
+		__arch_cmpxchg_masked(sc_cas_sfx, ".b" sc_cas_sfx,	\
+					prepend, append,		\
+					__ret, __ptr, __old, __new);    \
+		break;							\
 	case 2:								\
-		__arch_cmpxchg_masked(sc_cas_sfx, prepend, append,	\
+		__arch_cmpxchg_masked(sc_cas_sfx, ".h" sc_cas_sfx,	\
+					prepend, append,		\
 					__ret, __ptr, __old, __new);	\
 		break;							\
 	case 4:								\
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5a0bd27fd11a..f5d53251c947 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -92,6 +92,7 @@
 #define RISCV_ISA_EXT_ZCF		83
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
+#define RISCV_ISA_EXT_ZABHA		86
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 8f20607adb40..2a608056c89c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -322,6 +322,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
+	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
-- 
2.39.2



Return-Path: <linux-kernel+bounces-230789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C806C9181EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D8FB27852
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D061849C1;
	Wed, 26 Jun 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="buQBuKBk"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079C18411D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407219; cv=none; b=PRWAdfEKd3U7Xs9ndkuaMnFo5rgk4/0XaH65UsnMxT7R5efi64ic+TljAQTaGAR/plrcdCjNDup8DXA7SnJs6+uqzyxNPXNRmOzmv27nlRCbyPeuyQVRSwbRRkXnVinD9v4u1DOJFKk/hy9ukx90MdnbdaKne6Llu5ZPDLXln+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407219; c=relaxed/simple;
	bh=rpfxEbsRT/4K6N86opeEt+FlWD6Kd8gRa5IyY7sK7sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oApqaouZGHyd0CXvccgXAB6BC8xsiX67DNqQ3fDVObzmLGa44bxwXPC6B1gXWTQ1NaSbMEFLKXntIvmm5C4RX+Uyv+uobOpN3dxlFAZSI6GbPiwEv3seOt74lSmMXCmsrTd0sQjevpZclGgNVPQlpGnsatSwW/6DgsCZsFc3gkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=buQBuKBk; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec5779b423so45337551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407215; x=1720012015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr0+ChkIZxO95Fw/MskGbHkedxBPmtMPKffgsaSfjcQ=;
        b=buQBuKBk6q9TyaSIWF9iWkcuiPgoM3VvQyNRRaN+Aeg19gVVU5GOQ0IkRMN62FqAsW
         UKHPc8sbgKuMizbmtLRGc3agP2bTBlxwXhuCjRadINC8ZVPDzjlSMcuDIXHeKcSDvuOk
         m73pKViXcvShGUlmmf84WNLXwlSFW/HgWI/A75ORQtcKjL/rort09xsyyGRCiB8LW6j4
         4A60aRdaIsuJa3WmV5+11LqyEkC7BV5GFYJ3Lr6GwjNceBQ+dCQIFrlY0CUU31Of0kMh
         pEkEMPA/XFepdoqtSf6ZMijM1p2bpurPM36pSSM4R74ZRjGmmrxqnobXbfOZjPJe1SqE
         q9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407215; x=1720012015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr0+ChkIZxO95Fw/MskGbHkedxBPmtMPKffgsaSfjcQ=;
        b=CU3k+I1yEcMe9zCdKONN+OHwR0ESk6bCdPbyglYxMHn/K7Eh8+TDFh4VZYA0rFdtGH
         Zrt/Ed12P54El3C3NDNfJ7h+53XDyNYGq3T0gdARpHEWJC9Y27wzyTNruv9RvnV6jv1D
         M/11Yg/99V36CFuXx70fmevei89WjSrUolTTA7IDaFCkBp6JQvf+mT9J13QA910bP+WB
         fCq4Lizu/BEGlSZ4J0ScG6bf54sRLtxVYLBHFW1NCXTph+NrJs05lbHMCl+zXT9kwWW5
         q11tc2anxV/F0IaZ+7jdPc2YYW/mixUPXGYoGmSf0sQdnjcOzKESh8N4Yi5Ug0SIosjY
         L8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU7pDq3fOZgr8FUB0Gn9fTo/7Jdycnjo3iq3pChKwunk0ObUUjjfpg66Rfz/NqoghVsVxsIkEEoJnEit0yb8ZgUYIgIP+yruUy5+x53
X-Gm-Message-State: AOJu0YzzR95KKtAYG6Dcc+Z3cVADuPKn+sgKHHhF00Xk81q63IozzlOU
	/C7Q0iddjvZG/gC8h0CS2jgujfxMO9VXnBtIgNpmp7hETJMgz7cqSb4RpytA1js=
X-Google-Smtp-Source: AGHT+IFc4UBrVIS7Rn9fDb0+V6vAa1vZLUOTYZ8/Eg+bWg3KUQ8/IYiEJJBiokMuSCcEt25man3iiw==
X-Received: by 2002:a2e:9b4d:0:b0:2ec:543f:6013 with SMTP id 38308e7fff4ca-2ec5931d86amr78335911fa.13.1719407215370;
        Wed, 26 Jun 2024 06:06:55 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c846a7e7sm25696035e9.45.2024.06.26.06.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:55 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 03/10] riscv: Implement cmpxchg8/16() using Zabha
Date: Wed, 26 Jun 2024 15:03:40 +0200
Message-Id: <20240626130347.520750-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626130347.520750-1-alexghiti@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zabha in cmpxchg8/16() operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               | 17 ++++++++++++++++
 arch/riscv/Makefile              |  3 +++
 arch/riscv/include/asm/cmpxchg.h | 34 ++++++++++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1caaedec88c7..d3b0f92f92da 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -596,6 +596,23 @@ config RISCV_ISA_V_PREEMPTIVE
 	  preemption. Enabling this config will result in higher memory
 	  consumption due to the allocation of per-task's kernel Vector context.
 
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
index 9fd13d7a9cc6..78dcaaeebf4e 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -88,6 +88,9 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
 # Check if the toolchain supports Zacas
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
 
+# Check if the toolchain supports Zabha
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index a58a2141c6d3..b9a3fdcec919 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -105,8 +105,20 @@
  * indicated by comparing RETURN with OLD.
  */
 
-#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
+#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
 ({									\
+	__label__ no_zacas, zabha, end;					\
+									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
+		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
+				     RISCV_ISA_EXT_ZACAS, 1)		\
+			 : : : : no_zacas);				\
+		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
+				     RISCV_ISA_EXT_ZABHA, 1)		\
+			 : : : : zabha);				\
+	}								\
+									\
+no_zacas:;								\
 	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
 	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
@@ -133,6 +145,19 @@
 		: "memory");						\
 									\
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	goto end;							\
+									\
+zabha:									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
+		__asm__ __volatile__ (					\
+			prepend						\
+			"	amocas" cas_sfx " %0, %z2, %1\n"	\
+			append						\
+			: "+&r" (r), "+A" (*(p))			\
+			: "rJ" (n)					\
+			: "memory");					\
+	}								\
+end:;									\
 })
 
 #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
@@ -181,8 +206,13 @@ end:;									\
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
+		__arch_cmpxchg_masked(sc_sfx, ".b" sc_sfx,		\
+					prepend, append,		\
+					__ret, __ptr, __old, __new);    \
+		break;							\
 	case 2:								\
-		__arch_cmpxchg_masked(sc_sfx, prepend, append,		\
+		__arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,		\
+					prepend, append,		\
 					__ret, __ptr, __old, __new);	\
 		break;							\
 	case 4:								\
-- 
2.39.2



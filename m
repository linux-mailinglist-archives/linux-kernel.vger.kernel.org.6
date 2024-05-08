Return-Path: <linux-kernel+bounces-172602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C71718BF428
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B01FB22061
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA212E5E;
	Wed,  8 May 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hSP/IXnH"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA7EADC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132211; cv=none; b=AUxMLOacc4sG34s+1xWJZSY92BLV4O05EmrmdQ4E0EUZialb6XQQN6i2GKeFgg/a1QDwyEBEqcnhK1fywLsD1sjYP6nLg+0xfBui5tDy7faSboo2xMBlOaT2Sx8mRGw0cyBfZR51XA15rgtIZR5I+8McSJRQyV/cLo2BSdhtpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132211; c=relaxed/simple;
	bh=cOJgPTsZER0QYbl0huXDzsEpoo6FnPUGzH8hvF+KHqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o69I4Zj1wWolA4thm/gvy31ps1UJGXulx6pA5v/hK8QFlstLFZiJGvktazf+XbvPWX9igt9uKJdo83YR9GkB8OyEG4nNNvgLnBXbxN/mXidAkQjYBe9y3tEPo3fy2RjsFeg73Z4vYbVdKMMaTXqVoxG51EbSQY6ThaJhAxu4LCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hSP/IXnH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b4348fa971so2634092a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132209; x=1715737009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=th9kOuU1e9CFgMoeHZSK9oNWtH0aPnkCZu5MPXoJ/hI=;
        b=hSP/IXnHFAyfKVhcKEdHo00ygFvFODIV5lvaQG7wEibl0+PGA59nKgdjGYAeNsj1uN
         w4+/A0Eo/0U7qPU+7cDq5Fk8xJnJrgz4/iTOZOl49xrqmLcIOPDETX373MX3FIKjbiI6
         Ro4DFVEmdUGeTTeVpAu1u9lA2zPTozDqi0UF7LfaZj6xlGvpk2WOKPE/yBvD2vF63Lfo
         +L00+bHKjJpELkSjNXHnZ+BZbfF8gsfiBokb6MQQJRp5N6w8SZLBhQW88778gU1Kk4Ah
         BUyG0+z5aT6O0ZfS80HLoVsGQ63rQ0u4SOm8whMjcldGLOKCw2OPrZR29nFqEn4GFhDS
         oRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132209; x=1715737009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=th9kOuU1e9CFgMoeHZSK9oNWtH0aPnkCZu5MPXoJ/hI=;
        b=CVCrQDU4WzAPjrtc0qHj9lHbXdanFAqwT3mNnR6F+81MhGS+jfboKynHCoJISdkZX+
         VbJzp+4neIxWbYXR2wwJ86qsUjGPulsjXQ/xQqljgtd6exXRx8rksepUffAYOT9tCDsA
         TZ9q5Jycsy0jLcg+l2f0vrbE2mhsKIoUB7KnV5JOLcQGk5CXE8oPS6wP9zkHDpPkAfQl
         v5LJdvZfZlnhEKSCLjSPfRgIUfyJRnlw+FedqG2v0ef/dHxKyNHzP9Rakdd1ZsCeI3Zd
         T2oTpRnMXVGMfCcPspxlBtpGO26Ns4Ln+CqarbfKH/VzUb7MILQebiqGgY44nfeMM2O2
         1lpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwNMJrmkWjNdOCz83QWPwkS2uSIhFuma9rn+8Rt5iBYSMBflX2Wxb9wnB60HpDf1NUKT1g9fxFrmSr4z2W1lz/dTxq/wPWtVLaRJO8
X-Gm-Message-State: AOJu0Yx6mKsMKspQGuS91xPQqIC0jSta8L6+R43aiipBV8SDVNtXarDF
	I5iKUAlNygl4mp1xVL0rHAMQ251CkDIOy2HA832aSqRfE2fy55SE+IpJJvSu+6A=
X-Google-Smtp-Source: AGHT+IFXoQ5QrGUnjsqJOFF8ILEziuw2R/JwNz2AA0yMtAfuMkwguJG5FDUdd+JLIhNLXY8MnpekNA==
X-Received: by 2002:a17:90a:6581:b0:2b2:c6f8:70b0 with SMTP id 98e67ed59e1d1-2b6165a4d0dmr1314326a91.11.1715132208778;
        Tue, 07 May 2024 18:36:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:48 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 May 2024 18:36:31 -0700
Subject: [PATCH v2 5/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBB Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-compile_kernel_with_extensions-v2-5-722c21c328c6@rivosinc.com>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
In-Reply-To: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=14084;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=cOJgPTsZER0QYbl0huXDzsEpoo6FnPUGzH8hvF+KHqU=;
 b=ama9tCwHrUazEXquTbnZAxNqCYykgl/D7s4mQyJl2bwHPMJO1TKXiGVKJBZJCxYEciqIl5MoE
 pLyQxwfvk5LAV3FUe7c3WxRmXxBOBLnme26x/X+JygB1MhlaYlKAdB+
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zbb can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBB that allows arbitrary Zbb instruction
sequences to be emitted by the compiler. This assumption also allows the
alternatives to become evaluated at compile time for Zbb.

The existing "RISCV_ISA_ZBB" option is repurposed to be used to by kernel
code to determine if either PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBB or
PLATFORM_SUPPORTS_RISCV_ISA_ZBB has been set.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig                    | 24 ----------------
 arch/riscv/Kconfig.isa                | 54 ++++++++++++++++++++++++++++++++++-
 arch/riscv/Makefile                   |  1 +
 arch/riscv/include/asm/arch_hweight.h | 33 ++++++++++-----------
 arch/riscv/include/asm/checksum.h     | 18 ++++++------
 arch/riscv/lib/csum.c                 | 48 +++++++++++++++----------------
 arch/riscv/lib/strcmp.S               |  4 +--
 arch/riscv/lib/strlen.S               |  4 +--
 arch/riscv/lib/strncmp.S              |  4 +--
 arch/riscv/net/bpf_jit.h              |  4 ++-
 10 files changed, 113 insertions(+), 81 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 47a1d28bbb64..df620e534b3f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -484,14 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
 	help
 	  Allows early patching of the kernel for special errata
 
-config TOOLCHAIN_HAS_ZBB
-	bool
-	default y
-	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbb)
-	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbb)
-	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
-	depends on AS_HAS_OPTION_ARCH
-
 # This symbol indicates that the toolchain supports all v1.0 vector crypto
 # extensions, including Zvk*, Zvbb, and Zvbc.  LLVM added all of these at once.
 # binutils added all except Zvkb, then added Zvkb.  So we just check for Zvkb.
@@ -499,22 +491,6 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
 	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
 	depends on AS_HAS_OPTION_ARCH
 
-config RISCV_ISA_ZBB
-	bool "Zbb extension support for bit manipulation instructions"
-	depends on TOOLCHAIN_HAS_ZBB
-	depends on MMU
-	depends on RISCV_ALTERNATIVE
-	default y
-	help
-	   Add support for enabling optimisations in the kernel when the
-	   Zbb extension is detected at boot.
-
-	   The Zbb extension provides instructions to accelerate a number
-	   of bit-specific operations (count bit population, sign extending,
-	   bitrotation, etc).
-
-	   If you don't know what to do here, say Y.
-
 config RISCV_ISA_ZICBOM
 	bool "Zicbom extension support for non-coherent DMA operation"
 	depends on MMU
diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
index 50e217dc5719..49bed8c75263 100644
--- a/arch/riscv/Kconfig.isa
+++ b/arch/riscv/Kconfig.isa
@@ -169,7 +169,7 @@ config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
 
 endchoice
 
-config RISCV_ISA_SVPBMT
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
 	bool "Svpbmt extension support for supervisor mode page-based memory types"
 	depends on 64BIT && MMU
 	depends on RISCV_ALTERNATIVE
@@ -185,3 +185,55 @@ config RISCV_ISA_SVPBMT
 	   The Svpbmt extension is only available on 64-bit cpus.
 
 	   If you don't know what to do here, say Y.
+
+config TOOLCHAIN_HAS_ZBB
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbb)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbb)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBB
+	bool
+
+choice
+	prompt "Zbb extension for bit manipulation instructions support"
+	default PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBB
+	help
+	  This selects the level of support for Zbb instructions to be
+	  built into the Linux Kernel. This does not impact whether Zbb
+	  instructions are allowed to be emitted by user-space code.
+
+	  The Zbb extension provides instructions to accelerate a number
+	  of bit-specific operations (count bit population, sign extending,
+	  bitrotation, etc).
+
+config PROHIBIT_RISCV_ISA_ZBB
+	bool "Prohibit Zbb instruction sequences"
+	depends on NONPORTABLE
+	help
+	  Regardless of if the platform supports Zbb instructions,
+	  prohibit the kernel from emitting Zbb instructions.
+
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBB
+	bool "Allow Zbb instruction sequences if supported"
+	depends on TOOLCHAIN_HAS_ZBB
+	depends on RISCV_ALTERNATIVE
+	select RISCV_ISA_ZBB
+	help
+	  Add support for enabling optimisations in the kernel when the
+	  Zbb extension is detected at boot.
+
+config PLATFORM_SUPPORTS_RISCV_ISA_ZBB
+	bool "Emit Zbb instructions when building Linux"
+	depends on TOOLCHAIN_HAS_ZBB
+	depends on NONPORTABLE
+	select RISCV_ISA_ZBB
+	help
+	  Adds "zbb" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in Zbb instructions in the
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support the Zbb extension.
+
+endchoice
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index e1111e62ca20..6b0c3a782f99 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -66,6 +66,7 @@ riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2
diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 85b2c443823e..d89a18d5104f 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -19,21 +19,20 @@
 
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
-#ifdef CONFIG_RISCV_ISA_ZBB
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
-
-	asm (".option push\n"
-	     ".option arch,+zbb\n"
-	     CPOPW "%0, %0\n"
-	     ".option pop\n"
-	     : "+r" (w) : :);
-
-	return w;
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB)) {
+		if (!IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB))
+			asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+						RISCV_ISA_EXT_ZBB, 1)
+				 : : : : legacy);
+		asm (".option push\n"
+		".option arch,+zbb\n"
+		CPOPW "%0, %0\n"
+		".option pop\n"
+		: "+r" (w) : :);
 
+		return w;
+	}
 legacy:
-#endif
 	return __sw_hweight32(w);
 }
 
@@ -50,11 +49,12 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 #if BITS_PER_LONG == 64
 static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
-# ifdef CONFIG_RISCV_ISA_ZBB
+#ifdef CONFIG_PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBB
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
-
+#endif
+#ifdef CONFIG_RISCV_ISA_ZBB
 	asm (".option push\n"
 	     ".option arch,+zbb\n"
 	     "cpop %0, %0\n"
@@ -62,7 +62,8 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	     : "+r" (w) : :);
 
 	return w;
-
+#endif
+#ifdef CONFIG_PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBB
 legacy:
 # endif
 	return __sw_hweight64(w);
diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index 88e6f1499e88..2fe92abf5525 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -2,7 +2,7 @@
 /*
  * Checksum routines
  *
- * Copyright (C) 2023 Rivos Inc.
+ * Copyright (C) 2023-2024 Rivos Inc.
  */
 #ifndef __ASM_RISCV_CHECKSUM_H
 #define __ASM_RISCV_CHECKSUM_H
@@ -49,16 +49,16 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
 	 * worth checking if supported without Alternatives.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB)) {
 		unsigned long fold_temp;
 
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-		    :
-		    :
-		    :
-		    : no_zbb);
+		if (!IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB))
+			asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+						RISCV_ISA_EXT_ZBB, 1)
+				 :
+				 :
+				 :
+				 : no_zbb);
 
 		if (IS_ENABLED(CONFIG_32BIT)) {
 			asm(".option push				\n\
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 7fb12c59e571..5ea2bf71c963 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -44,8 +44,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	 * Zbb support saves 4 instructions, so not worth checking without
 	 * alternatives if supported
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB)) {
 		unsigned long fold_temp;
 
 		/*
@@ -53,12 +52,13 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 		 * support, so nop when Zbb is available and jump when Zbb is
 		 * not available.
 		 */
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-				  :
-				  :
-				  :
-				  : no_zbb);
+		if (!IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB))
+			asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+						RISCV_ISA_EXT_ZBB, 1)
+					  :
+					  :
+					  :
+					  : no_zbb);
 		asm(".option push					\n\
 		.option arch,+zbb					\n\
 			rori	%[fold_temp], %[sum], 32		\n\
@@ -161,8 +161,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	 * Zbb support saves 6 instructions, so not worth checking without
 	 * alternatives if supported
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB)) {
 		unsigned long fold_temp;
 
 		/*
@@ -170,12 +169,13 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 		 * support, so nop when Zbb is available and jump when Zbb is
 		 * not available.
 		 */
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-				  :
-				  :
-				  :
-				  : no_zbb);
+		if (!IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB))
+			asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+						RISCV_ISA_EXT_ZBB, 1)
+					  :
+					  :
+					  :
+					  : no_zbb);
 
 #ifdef CONFIG_32BIT
 		asm_goto_output(".option push			\n\
@@ -248,8 +248,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 	 * Zbb support saves 6 instructions, so not worth checking without
 	 * alternatives if supported
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB)) {
 		unsigned long fold_temp;
 
 		/*
@@ -257,12 +256,13 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 		 * support, so nop when Zbb is available and jump when Zbb is
 		 * not available.
 		 */
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-				  :
-				  :
-				  :
-				  : no_zbb);
+		if (!IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB))
+			asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+						RISCV_ISA_EXT_ZBB, 1)
+					  :
+					  :
+					  :
+					  : no_zbb);
 
 #ifdef CONFIG_32BIT
 		asm (".option push				\n\
diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 687b2bea5c43..5798ef7e73fc 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -7,7 +7,7 @@
 
 /* int strcmp(const char *cs, const char *ct) */
 SYM_FUNC_START(strcmp)
-
+#ifndef CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB
 	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
 
 	/*
@@ -37,7 +37,7 @@ SYM_FUNC_START(strcmp)
 	 */
 	sub	a0, t0, t1
 	ret
-
+#endif /* !CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB */
 /*
  * Variant of strcmp using the ZBB extension if available.
  * The code was published as part of the bitmanip manual
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 8ae3064e45ff..b63b91f74084 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -7,7 +7,7 @@
 
 /* int strlen(const char *s) */
 SYM_FUNC_START(strlen)
-
+#ifndef CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB
 	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
 
 	/*
@@ -29,7 +29,7 @@ SYM_FUNC_START(strlen)
 2:
 	sub	a0, t1, a0
 	ret
-
+#endif /* !CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB */
 /*
  * Variant of strlen using the ZBB extension if available
  */
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index aba5b3148621..3a1330d7d4a2 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -7,7 +7,7 @@
 
 /* int strncmp(const char *cs, const char *ct, size_t count) */
 SYM_FUNC_START(strncmp)
-
+#ifndef CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB
 	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
 
 	/*
@@ -42,7 +42,7 @@ SYM_FUNC_START(strncmp)
 	 */
 	sub	a0, t0, t1
 	ret
-
+#endif /* !CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB */
 /*
  * Variant of strncmp using the ZBB extension if available
  */
diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 259294bdbc3a..61892044124e 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -22,7 +22,9 @@ static inline bool rvc_enabled(void)
 
 static inline bool rvzbb_enabled(void)
 {
-	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
+	return IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_ZBB) ||
+	       (IS_ENABLED(CONFIG_PLATFORM_MAY_SUPPORT_RISCV_ISA_ZBB) &&
+		riscv_has_extension_likely(RISCV_ISA_EXT_ZBB));
 }
 
 enum {

-- 
2.44.0



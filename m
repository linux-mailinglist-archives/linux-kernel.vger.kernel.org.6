Return-Path: <linux-kernel+bounces-170563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D88BD926
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441DB1F230E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB863D0AF;
	Tue,  7 May 2024 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TMRw+c5+"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5ADB652
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046170; cv=none; b=ooXT3uhBxS3HBkolKGLgar8swn3f8bzmqVyKxTS19tqBRja7gNohG7BoUtSSPLpWoF+eoXrTQJmC/+8XIwrrLI9h7okXwOqmJ+3EBGJRKBUotb8V6W53+9JheB/OcjjJR2mcUX7AyCkPUkPRVEmjePeda8JhXMp30gaXyolISyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046170; c=relaxed/simple;
	bh=Gpo8hfh/9+N/iqKYe3MCveS+qLzCuqVg4e2wcSoQx+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQvJ837jp+PLsFdL06LwBXKa2w/BSVwvlqsyaadygciyE4gTu+Brr5Cm7j69Jjr2wcDIgxWXsdIYFnW1Y6YCP0xXuJe99tQfOX8pMxQK6hV/7W56Gcowx2q7xkdkVY7pWWHxeV3y0G+ya7qhDrR34BeE2np3s1nA+NX5Ad+47DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TMRw+c5+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso1710329a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046168; x=1715650968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ7EdBQ/6M4rSNFMLjyTKcQvY5gDVj45XBOC4QQu44U=;
        b=TMRw+c5+aFKE/r9xIn1d8MRnRHaKoRKz7WaaHMuleHbju9qQoPQ5OBzIuxfB6pXtyY
         rFMTMvC1LQdVfG3N8k/Nf3WLtNnXDOaqooEeMHoi0YkPpNwPTv9QAxY9OxFHpwtKrbo0
         BcqWtHs5ZVxm452SPjYu0s1MonLSiVPpZmDY60w+zkagDYM1Dn/wxbScjnhZaBAmHQ8i
         ZpKIFOu3qWyF0zCNUWr7pqZ1ZJ4ZB6e7CH/acJBKgjj8ETy6D1Vt9WCJtjcxbI/rbhCG
         NA9OHxzOn5C+vS5RHR2dXaAPWcz5yhZQurpwGnTziWQErgGQT/s2JDXz620JUX2iTguR
         R5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046168; x=1715650968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ7EdBQ/6M4rSNFMLjyTKcQvY5gDVj45XBOC4QQu44U=;
        b=f5sE3nN+3WvjkXfCV0RptVEf0ewRoHZYoBENJNwmkxk5K9lFgByDvql5xX49fEfHK1
         Yb/LadhNL7MlpuWcUcRtSyqCMNeLtoJNTCoYXHId2mJx0GzqeJx0FcQDf2284pQNJcyC
         rZZR078B2fwv1N4EHJb00u6jOfbglpPX8AvXLmN4EtGlR6d+L9VNg3geqAib2pgEb7aE
         d/ToKAMlGktqMtxKAuAEx9JTy2ffHY+n60amqSGN7HzUPRNU2UvBtXgvuYgwdoA9F7L8
         nkYFX3ne1NAevpzti2coPmEnJ7bOaeaMQVul2oy0a1uWfGba7Xnu/+iVreraZg7G5idb
         OtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZW78HiUU2JDvjJ51n5QT0ox1zUM2eT0j7d5Zvg+0zxq0q76leFOsAxEPBwQDot3kGeGr6tvdrJMcgtmAl7vWj2guymC+7137XxQUl
X-Gm-Message-State: AOJu0YwtdgJi3BVOedvc1+JBcRzwnzNht4Bv83qUuJU1IZpXcYDCodeb
	Ptdj9TqNEBPVYLQt3/uldmtNoX582MdIdYkWmtsnSWM71EfgZ0dBaVO0nR322VE=
X-Google-Smtp-Source: AGHT+IG74efm7SCihJUa+3UxSqiFR7Y+JP/oI05ti3saBVyRnzR7LLXjViia41Gnlo5YIxHxcbAIsw==
X-Received: by 2002:a17:90a:c506:b0:2a7:398:c943 with SMTP id k6-20020a17090ac50600b002a70398c943mr10034219pjt.5.1715046167251;
        Mon, 06 May 2024 18:42:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:46 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:46 -0700
Subject: [PATCH 5/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBB Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-5-5c25c134c097@rivosinc.com>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
In-Reply-To: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=13922;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Gpo8hfh/9+N/iqKYe3MCveS+qLzCuqVg4e2wcSoQx+U=;
 b=m8/HF7kazTy7o4ZfgsZjhlNqH+CvzkHBhbQ+vWX/D63rJN6F8KOeV0tLeTu497v9kqzLOE4qJ
 0adciAodBPdBtQs+DNs794X9bZdrWBWPzNc44KflkwEKvt4SQqMaFeM
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Zbb can optimize kernel instruction sequences. Add a config option
PLATFORM_SUPPORTS_RISCV_ISA_ZBB that allows arbitrary Zbb instruction
sequences to be emitted by the compiler. This assumption also allows the
alternatives to become evaluated at compile time for Zbb.

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
index 22303a3ab59e..685092045447 100644
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
index f2120db6ed92..934e20de576b 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -67,6 +67,7 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_V)	:= $(riscv-march-y)v
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



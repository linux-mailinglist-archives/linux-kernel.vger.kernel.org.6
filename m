Return-Path: <linux-kernel+bounces-170560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBD38BD923
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B58C1F236DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085F5A93B;
	Tue,  7 May 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pM2tDOcj"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBE4436
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046165; cv=none; b=p7JBiFxmjDrrZKvS6qJe0IlYXJhOWASOJOMNADQPAMvFL+wnU2803uarygKIOHaMBVwPPqT/k8xcHrDsR+ANbeixIiNvIgjQHwWjqXNA2grj2oQn1jt+2MbzAGQYahq0qBVA3IxFN4tnA0LKXqFdeCL4z80MsDzAajhVwlZdjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046165; c=relaxed/simple;
	bh=agm7J56cL8mYhZaFD22IJKlosZSuCxUEk3BLHORDVBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9JyRHhioJdIr0R+KJG5BoTjvWeBCdukLL9uaToYmEHz5tYPo73K3L7iL9G7mO+Ax3YFjVm8X9UOlTWAKswDrib26fSevOKAcwxo0Q7r6JeDaQ+uJU8kZcuRq2PJgFji1HrJfxbpDjvqnnhV8P1dvAkO1mxgGvvvMAeb3r5txSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pM2tDOcj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b387e2e355so1750215a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046163; x=1715650963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1SlwHEQve3XGtUzt1D2PtY9mRWz0p9lvDMiT9rqTMQ=;
        b=pM2tDOcjjiOWP10Q7l6WbEtsZCPNA/XFR0DIwDUs32kaQm7SFw1t4zbFGP4Pi9Khyi
         20XSh6GHlfIDayj7eC+ixJzZ23k8O0dsOn1/vC3FTKVCpPk9qBWJ3xpop48n5zYGd/gL
         7zkTriegG7Lgsh1RxbZ0MbBxgntMvuFWGN1/y07aQpC5i/n8imOHi9Jx5mqAVtKEgj/s
         70gEOwmegq7iYUawTbjcpSEMUEVzbxwWro8xnEAmkbZRmtG8ZV+/CDYL21IQ3OxHO8lM
         F8nJPmI1/AXoDwQq7lNiBIbdwOrd2jP1PmA8/1k+pVhec++b1GxPAfl/q7BCgRsXAp/X
         qIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046163; x=1715650963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1SlwHEQve3XGtUzt1D2PtY9mRWz0p9lvDMiT9rqTMQ=;
        b=Z75VnTxe2WCWyPB6IYqTnFt3M6AjOgfiBNnN2HaYh/SBTqVnk8ezNl1HXZ590o7l5A
         FFAquTDZAEA4pOsZq3UVnyxJsVzXR7/ZDh0sHn1RJHTMfp3x3JCv8a1NW/DKR4w+mOYO
         TW7XsZc0yuBN1UTHzBj2NBgdB30sz9W5HHC+22srGU+QjF0LPFHUt++fhiT4sZX6a1s1
         SYGbWn7Urjz29umpXDsl0Rq7hblPbTacvXb40AWEJKSnX+JucdO75k/dZo3DB96lamSG
         yLS5nEPVfNd1Orr8XZO2sz/T/2Dfv6ojKCBnIOYLJG7gZHIYtWE45sYrR4JD2SBG1txe
         AZmA==
X-Forwarded-Encrypted: i=1; AJvYcCW0vrmSQnoi2gG5qiOUpx/ERWG5BkInSb/GmAJTDWPUAFH8fZRhRBhhT+yAG2e86M28xNfwm2GSzgi9RIgNjiqkMC2dB46t0N6G3ERK
X-Gm-Message-State: AOJu0YwhrpB++++Tm+BBMkaYidk0HOmnt2J32myxiGU6PDw7V4L3vjFW
	8xorroFFzv0mvpnGAUoD4vJ4INGx15qC6a/i5/frsuxEaTrG3cC5/KGdR0vVJ68=
X-Google-Smtp-Source: AGHT+IE+kH2E8eCWhpfbYai+ib3XAIvK3eLPva3AMWLlSeK8GjCXQfE9rI3kRhkOuiQ/InWmIFNnZw==
X-Received: by 2002:a17:90a:bb92:b0:2b5:258c:5f10 with SMTP id v18-20020a17090abb9200b002b5258c5f10mr5030446pjr.30.1715046162600;
        Mon, 06 May 2024 18:42:42 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:41 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:43 -0700
Subject: [PATCH 2/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-2-5c25c134c097@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=16227;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=agm7J56cL8mYhZaFD22IJKlosZSuCxUEk3BLHORDVBc=;
 b=rfsxkrzyXrHGtjN9yY8m4rOIS5Sh7mt/xLFcnNyakq5WIfAzBHPdwdXqbH1hC4dJHymFnq47R
 xuqKc/7KojFDXXUhuVt4LTbmOoJ0K2avl8lJ/Y0iOMS46DWdRuOwt0k
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Current versions of the kernel add "v" to the march and then immeidately
filter it out such that "v" is not passed to CFLAGS.  Instead of doing
this filtering, code blocks in the kernel that want to use vector
assembly have been changed to locally enable vector (using ".option
arch, +v").

To support kernels that can run on hardware that may support vector, the
config option PLATFORM_MAY_SUPPORT_RISCV_ISA_V is added, and the
previous behavior of RISCV_ISA_V is retained with the option
CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_V. When the hardware is assumed to
support vector, has_vector() unconditionally returns true and "v" is
added to the kernel march.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig               | 54 -------------------------
 arch/riscv/Kconfig.isa           | 85 ++++++++++++++++++++++++++++++++++++++++
 arch/riscv/Makefile              |  7 +---
 arch/riscv/crypto/Kconfig        | 14 +++----
 arch/riscv/include/asm/simd.h    |  3 ++
 arch/riscv/include/asm/vector.h  |  3 +-
 arch/riscv/kernel/cpufeature.c   |  3 +-
 arch/riscv/kernel/head.S         |  8 +++-
 arch/riscv/kernel/process.c      | 14 +++----
 arch/riscv/kernel/ptrace.c       |  6 +++
 arch/riscv/lib/riscv_v_helpers.c |  1 -
 arch/riscv/lib/uaccess_vector.S  |  2 +
 arch/riscv/lib/xor.S             |  2 +
 13 files changed, 124 insertions(+), 78 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c2a4f5364707..c2e9eded0a7d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -520,60 +520,6 @@ config RISCV_ISA_SVPBMT
 
 	   If you don't know what to do here, say Y.
 
-config TOOLCHAIN_HAS_V
-	bool
-	default y
-	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64iv)
-	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32iv)
-	depends on LLD_VERSION >= 140000 || LD_VERSION >= 23800
-	depends on AS_HAS_OPTION_ARCH
-
-config RISCV_ISA_V
-	bool "Vector extension support"
-	depends on TOOLCHAIN_HAS_V
-	depends on FPU
-	select DYNAMIC_SIGFRAME
-	default y
-	help
-	  Add support for the Vector extension when it is detected at boot.
-	  When this option is disabled, neither the kernel nor userspace may
-	  use vector procedures.
-
-	  If you don't know what to do here, say Y.
-
-config RISCV_ISA_V_DEFAULT_ENABLE
-	bool "Enable userspace Vector by default"
-	depends on RISCV_ISA_V
-	default y
-	help
-	  Say Y here if you want to enable Vector in userspace by default.
-	  Otherwise, userspace has to make explicit prctl() call to enable
-	  Vector, or enable it via the sysctl interface.
-
-	  If you don't know what to do here, say Y.
-
-config RISCV_ISA_V_UCOPY_THRESHOLD
-	int "Threshold size for vectorized user copies"
-	depends on RISCV_ISA_V
-	default 768
-	help
-	  Prefer using vectorized copy_to_user()/copy_from_user() when the
-	  workload size exceeds this value.
-
-config RISCV_ISA_V_PREEMPTIVE
-	bool "Run kernel-mode Vector with kernel preemption"
-	depends on PREEMPTION
-	depends on RISCV_ISA_V
-	default y
-	help
-	  Usually, in-kernel SIMD routines are run with preemption disabled.
-	  Functions which envoke long running SIMD thus must yield core's
-	  vector unit to prevent blocking other tasks for too long.
-
-	  This config allows kernel to run SIMD without explicitly disable
-	  preemption. Enabling this config will result in higher memory
-	  consumption due to the allocation of per-task's kernel Vector context.
-
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
index 08b7af5aabb0..0663c98b5b17 100644
--- a/arch/riscv/Kconfig.isa
+++ b/arch/riscv/Kconfig.isa
@@ -39,3 +39,88 @@ config PLATFORM_SUPPORTS_RISCV_ISA_C
 	  If you don't know what to do here, say Y.
 
 endchoice
+
+config TOOLCHAIN_HAS_V
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64iv)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32iv)
+	depends on LLD_VERSION >= 140000 || LD_VERSION >= 23800
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_V
+	bool
+
+choice
+	prompt "Vector extension support"
+	default PLATFORM_MAY_SUPPORT_RISCV_ISA_V
+	help
+	  This selects the level of support for vector instructions to be
+	  built into the Linux Kernel. This does not impact whether vector
+	  instructions are allowed to be emitted by user-space code.
+
+config PROHIBIT_RISCV_ISA_V
+	bool "Prohibit vector instructions"
+	depends on NONPORTABLE
+	help
+	  Regardless of if the platform supports vector instructions,
+	  prohibit the kernel from emitting vector instructions.
+
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_V
+	bool "Allow vector instruction sequences if supported"
+	depends on TOOLCHAIN_HAS_V
+	depends on FPU
+	select DYNAMIC_SIGFRAME
+	select RISCV_ISA_V
+	help
+	  Only allow vector instructions to be emitted if "V" is present in
+	  the device tree or ACPI table. No vector instructions will be
+	  emitted if the platform does not support them.
+
+config PLATFORM_SUPPORTS_RISCV_ISA_V
+	bool "Emit vector instructions when building Linux"
+	depends on TOOLCHAIN_HAS_V
+	depends on FPU
+	depends on NONPORTABLE
+	select DYNAMIC_SIGFRAME
+	select RISCV_ISA_V
+	help
+	  Adds "V" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in vector instructions in the
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support vector instructions.
+
+endchoice
+
+config RISCV_ISA_V_DEFAULT_ENABLE
+	bool "Enable userspace Vector by default"
+	depends on RISCV_ISA_V
+	default y
+	help
+	  Say Y here if you want to enable Vector in userspace by default.
+	  Otherwise, userspace has to make explicit prctl() call to enable
+	  Vector, or enable it via the sysctl interface.
+
+	  If you don't know what to do here, say Y.
+
+config RISCV_ISA_V_UCOPY_THRESHOLD
+	int "Threshold size for vectorized user copies"
+	depends on RISCV_ISA_V
+	default 768
+	help
+	  Prefer using vectorized copy_to_user()/copy_from_user() when the
+	  workload size exceeds this value.
+
+config RISCV_ISA_V_PREEMPTIVE
+	bool "Run kernel-mode Vector with kernel preemption"
+	depends on PREEMPTION
+	depends on RISCV_ISA_V
+	default y
+	help
+	  Usually, in-kernel SIMD routines are run with preemption disabled.
+	  Functions which envoke long running SIMD thus must yield core's
+	  vector unit to prevent blocking other tasks for too long.
+
+	  This config allows kernel to run SIMD without explicitly disable
+	  preemption. Enabling this config will result in higher memory
+	  consumption due to the allocation of per-task's kernel Vector context.
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index e1be36004097..f2120db6ed92 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -66,7 +66,7 @@ riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
-riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_V)	:= $(riscv-march-y)v
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2
@@ -78,10 +78,7 @@ endif
 # Check if the toolchain supports Zihintpause extension
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
 
-# Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
-# matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
-KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
-
+KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
 KBUILD_CFLAGS += -mno-save-restore
diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index ad58dad9a580..5f7ea675a8cf 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -4,7 +4,7 @@ menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
 config CRYPTO_AES_RISCV64
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTS"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && PLATFORM_SUPPORTS_RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	select CRYPTO_SKCIPHER
@@ -20,7 +20,7 @@ config CRYPTO_AES_RISCV64
 
 config CRYPTO_CHACHA_RISCV64
 	tristate "Ciphers: ChaCha"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && PLATFORM_SUPPORTS_RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	help
@@ -31,7 +31,7 @@ config CRYPTO_CHACHA_RISCV64
 
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && PLATFORM_SUPPORTS_RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_GCM
 	help
 	  GCM GHASH function (NIST SP 800-38D)
@@ -41,7 +41,7 @@ config CRYPTO_GHASH_RISCV64
 
 config CRYPTO_SHA256_RISCV64
 	tristate "Hash functions: SHA-224 and SHA-256"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && PLATFORM_SUPPORTS_RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SHA256
 	help
 	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
@@ -52,7 +52,7 @@ config CRYPTO_SHA256_RISCV64
 
 config CRYPTO_SHA512_RISCV64
 	tristate "Hash functions: SHA-384 and SHA-512"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && PLATFORM_SUPPORTS_RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SHA512
 	help
 	  SHA-384 and SHA-512 secure hash algorithm (FIPS 180)
@@ -63,7 +63,7 @@ config CRYPTO_SHA512_RISCV64
 
 config CRYPTO_SM3_RISCV64
 	tristate "Hash functions: SM3 (ShangMi 3)"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && PLATFORM_SUPPORTS_RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 	help
@@ -75,7 +75,7 @@ config CRYPTO_SM3_RISCV64
 
 config CRYPTO_SM4_RISCV64
 	tristate "Ciphers: SM4 (ShangMi 4)"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && PLATFORM_SUPPORTS_RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
index adb50f3ec205..81508325fd51 100644
--- a/arch/riscv/include/asm/simd.h
+++ b/arch/riscv/include/asm/simd.h
@@ -26,6 +26,9 @@
  */
 static __must_check inline bool may_use_simd(void)
 {
+	if (!has_vector())
+		return false;
+
 	/*
 	 * RISCV_KERNEL_MODE_V is only set while preemption is disabled,
 	 * and is clear whenever preemption is enabled.
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 731dcd0ed4de..a08c4bf92ecd 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -37,7 +37,8 @@ static inline u32 riscv_v_flags(void)
 
 static __always_inline bool has_vector(void)
 {
-	return riscv_has_extension_unlikely(RISCV_ISA_EXT_v);
+	return IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_V) ||
+	       riscv_has_extension_likely(RISCV_ISA_EXT_v);
 }
 
 static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..7cb365714855 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -683,7 +683,6 @@ void __init riscv_fill_hwcap(void)
 	}
 
 	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
-		riscv_v_setup_vsize();
 		/*
 		 * ISA string in device tree might have 'v' flag, but
 		 * CONFIG_RISCV_ISA_V is disabled in kernel.
@@ -691,6 +690,8 @@ void __init riscv_fill_hwcap(void)
 		 */
 		if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
 			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
+		else
+			riscv_v_setup_vsize();
 	}
 
 	memset(print_str, 0, sizeof(print_str));
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 4236a69c35cb..b027be82bbb3 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -428,17 +428,20 @@ SYM_CODE_START_LOCAL(reset_regs)
 .Lreset_regs_done_fpu:
 #endif /* CONFIG_FPU */
 
-#ifdef CONFIG_RISCV_ISA_V
+#if defined(CONFIG_PLATFORM_MAY_SUPPORT_RISCV_ISA_V)
 	csrr	t0, CSR_MISA
 	li	t1, COMPAT_HWCAP_ISA_V
 	and	t0, t0, t1
 	beqz	t0, .Lreset_regs_done_vector
-
+#endif
+#ifdef CONFIG_RISCV_ISA_V
 	/*
 	 * Clear vector registers and reset vcsr
 	 * VLMAX has a defined value, VLEN is a constant,
 	 * and this form of vsetvli is defined to set vl to VLMAX.
 	 */
+	.option push
+	.option arch, +v
 	li	t1, SR_VS
 	csrs	CSR_STATUS, t1
 	csrs	CSR_VCSR, x0
@@ -447,6 +450,7 @@ SYM_CODE_START_LOCAL(reset_regs)
 	vmv.v.i v8, 0
 	vmv.v.i v16, 0
 	vmv.v.i v24, 0
+	.option pop
 	/* note that the caller must clear SR_VS */
 .Lreset_regs_done_vector:
 #endif /* CONFIG_RISCV_ISA_V */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e4bc61c4e58a..af10715a63f7 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -163,14 +163,14 @@ void flush_thread(void)
 	fstate_off(current, task_pt_regs(current));
 	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
 #endif
-#ifdef CONFIG_RISCV_ISA_V
 	/* Reset vector state */
-	riscv_v_vstate_ctrl_init(current);
-	riscv_v_vstate_off(task_pt_regs(current));
-	kfree(current->thread.vstate.datap);
-	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
-	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
-#endif
+	if (has_vector()) {
+		riscv_v_vstate_ctrl_init(current);
+		riscv_v_vstate_off(task_pt_regs(current));
+		kfree(current->thread.vstate.datap);
+		memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
+		clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
+	}
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 92731ff8c79a..bdfaed2a4023 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -92,6 +92,9 @@ static int riscv_vr_get(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
+	if (!has_vector())
+		return 0;
+
 	if (!riscv_v_vstate_query(task_pt_regs(target)))
 		return -EINVAL;
 
@@ -127,6 +130,9 @@ static int riscv_vr_set(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
+	if (!has_vector())
+		return 0;
+
 	if (!riscv_v_vstate_query(task_pt_regs(target)))
 		return -EINVAL;
 
diff --git a/arch/riscv/lib/riscv_v_helpers.c b/arch/riscv/lib/riscv_v_helpers.c
index be38a93cedae..661c77fdd7f7 100644
--- a/arch/riscv/lib/riscv_v_helpers.c
+++ b/arch/riscv/lib/riscv_v_helpers.c
@@ -21,7 +21,6 @@ asmlinkage int enter_vector_usercopy(void *dst, void *src, size_t n)
 {
 	size_t remain, copied;
 
-	/* skip has_vector() check because it has been done by the asm  */
 	if (!may_use_simd())
 		goto fallback;
 
diff --git a/arch/riscv/lib/uaccess_vector.S b/arch/riscv/lib/uaccess_vector.S
index 7c45f26de4f7..4de37a3a2163 100644
--- a/arch/riscv/lib/uaccess_vector.S
+++ b/arch/riscv/lib/uaccess_vector.S
@@ -5,6 +5,8 @@
 #include <asm/asm-extable.h>
 #include <asm/csr.h>
 
+.option arch, +v
+
 #define pDst a0
 #define pSrc a1
 #define iNum a2
diff --git a/arch/riscv/lib/xor.S b/arch/riscv/lib/xor.S
index b28f2430e52f..9a3e2c19efc9 100644
--- a/arch/riscv/lib/xor.S
+++ b/arch/riscv/lib/xor.S
@@ -6,6 +6,8 @@
 #include <linux/export.h>
 #include <asm/asm.h>
 
+.option arch, +v
+
 SYM_FUNC_START(xor_regs_2_)
 	vsetvli a3, a0, e8, m8, ta, ma
 	vle8.v v0, (a1)

-- 
2.44.0



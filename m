Return-Path: <linux-kernel+bounces-170559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7248BD922
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E24D1C20C6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07824C63;
	Tue,  7 May 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AqsfXfDD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F411FA5
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046164; cv=none; b=eXCU7Ysgrkae6m1+4hBEPV8GmNLz8TPFt+Ta3IMap9y65wK7tbp5IsbzHUhESt+RsHRfreCr+2p9IAvejIJyTGzHpjcNM4u1JIKBBAt8HRqA6WGuiLtMUhtAcd4/kZssFjbpad6ZlHtHxvmzmGrmYKpmNS8kFLNegXzMYWWu/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046164; c=relaxed/simple;
	bh=9E+2LlRyJf3rtGlOBhbopLxrTNkU6Xw7Fp6ra7sa6aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADMGa2LyzSlZffBSDH6JDqDm8Be/leDqQEnJ6HvFhQOYo8LoPqYU4nf3glLKodadX53psERPkYLZZxuzqtpUeYB3txyV45FFLFnSWaz4M0yMFU9DDBInvFNCEW8Dl6dTlgJOFAsHCA1efTVLhDTOWwaUTgDwdHQ7SmyXy35dVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AqsfXfDD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so13745545ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046161; x=1715650961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF8qGaJ1aJzNvgYvOCba3skq1TjRznxQuNnEFWLH5Zw=;
        b=AqsfXfDDK9WPrMiVC6+4wMpa3i1anGD+aQNxnOnIbwYQObZfCtkyFGc90p3swn7OFa
         zZKNI2vFMlQ5kONb6tMOGponqyh5fdKcXeJ6d3F9mf/P//Ulvj11gOerKFrUWrLpmz1v
         wuoJqyw8mkatzE1mqhX1h5yDkDgikxm+Twu+mLs6dpL6a2wpEH4tkpUavAxPb7KB2xCc
         +KXXma02yedNtYzgg5b/XyMaieLQWI0cPHni/2bEWKIEDdaDxZ4IN7HFZ1hzomUAhlMW
         UBAO7f/XxwitNJXVB79vfwWKePDQW6wIHtDwdMnHwC5aRaVEJvOCPGdcRQMR0yxLkVb2
         HaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046161; x=1715650961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gF8qGaJ1aJzNvgYvOCba3skq1TjRznxQuNnEFWLH5Zw=;
        b=DObyN+ndLL4ba58c8VnnDXM1GGq08a9UIdKpHvUVivCDLHwfP+l80MF+TUMKzMgU0g
         9m0O/Q5W9H31zvVMIv2Zgk5mnwTEe6SVHbEkkuWT4KYtCeHiSyspdLRFlO0rozcJTKiE
         ff+E3bzPDQ65KyFdqoxeE9P1c7kTMwhYfPsTYAXTq3lDYPaAKda6xOHLA/ainpkfUBY8
         JHXszUA3MObPAuWLGis9+zluUmpiObcAeKGW1RRV7+Pb55Fv2xogn5yn8ucIr3/AGOEI
         CkHAa4vs4wT/BUFEKk5E21+JmMf70Ue6M6GoGlFqAj0Dv03xuAPIJQ99uQtZiOGR0ZvU
         iHaA==
X-Forwarded-Encrypted: i=1; AJvYcCX1wi17ARbxlTJwiCf63GeDimBTfxsatG7VeCc7d3Bb2jsqNngD/CcE9G35kVpG9UEXxtCt8rTnKnJxT1GdI9+MM5BkmY4DAH0joMZB
X-Gm-Message-State: AOJu0YwaHb6//5j1XSrP8ipfmN3VWLRe20sMxxdkmBVVECxrl0FEL1H8
	+atgEOoV7Fe0Q2R2UKa8Ep+/QLSXTaRkcDhkpkoxfNW//0UnmUEWOs3txN2L9wU=
X-Google-Smtp-Source: AGHT+IGpzHifmpGiAxjTcocbBFK+V7WiJThQ/SJeU/Miqz5kdTjCFTH4LwBRLMK2doOE8zu4aQNSJA==
X-Received: by 2002:a17:90b:350e:b0:2b2:7855:da05 with SMTP id ls14-20020a17090b350e00b002b27855da05mr10460825pjb.26.1715046161112;
        Mon, 06 May 2024 18:42:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:40 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:42 -0700
Subject: [PATCH 1/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_C Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-1-5c25c134c097@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=5775;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=9E+2LlRyJf3rtGlOBhbopLxrTNkU6Xw7Fp6ra7sa6aw=;
 b=k/qKiLIMvmJ90rd1YTXngnEJRwKO8kGBQZf+APAC5CZ1sloS8A25+YytARmKTTvmNP+IkLjri
 cazABYZHlYsDSt+hvd03k1xMjto5tOexlRaM5aKXwgjWVr3MEZAkbVA
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce a "Kernel ISA" menu and migrate the compressed instruction
support options into a new file Kconfig.isa. Add a new option
"PLATFORM_MAY_SUPPORT_RISCV_ISA_C" that can be used to conditionally
emit C extensions if the hardware supports it.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig                 | 19 +++++++-----------
 arch/riscv/Kconfig.isa             | 41 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/Makefile                |  4 ++--
 arch/riscv/kernel/probes/uprobes.c |  2 +-
 arch/riscv/net/bpf_jit.h           |  4 +++-
 5 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c8bdfd33abf4..c2a4f5364707 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -369,6 +369,12 @@ config ARCH_RV64I
 
 endchoice
 
+menu "Kernel ISA"
+
+source "arch/riscv/Kconfig.isa"
+
+endmenu
+
 # We must be able to map all physical memory into the kernel, but the compiler
 # is still a bit more efficient when generating code if it's setup in a manner
 # such that it can only map 2GiB of memory.
@@ -478,17 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
 	help
 	  Allows early patching of the kernel for special errata
 
-config RISCV_ISA_C
-	bool "Emit compressed instructions when building Linux"
-	default y
-	help
-	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
-	  when building Linux, which results in compressed instructions in the
-	  Linux binary. This option produces a kernel that will not run on
-	  systems that do not support compressed instructions.
-
-	  If you don't know what to do here, say Y.
-
 config RISCV_ISA_SVNAPOT
 	bool "Svnapot extension support for supervisor mode NAPOT pages"
 	depends on 64BIT && MMU
@@ -937,6 +932,7 @@ config EFI
 	bool "UEFI runtime support"
 	depends on OF && !XIP_KERNEL
 	depends on MMU
+	depends on PLATFORM_SUPPORTS_RISCV_ISA_C
 	default y
 	select ARCH_SUPPORTS_ACPI if 64BIT
 	select EFI_GENERIC_STUB
@@ -944,7 +940,6 @@ config EFI
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
 	select LIBFDT
-	select RISCV_ISA_C
 	select UCS2_STRING
 	help
 	  This option provides support for runtime services provided
diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
new file mode 100644
index 000000000000..08b7af5aabb0
--- /dev/null
+++ b/arch/riscv/Kconfig.isa
@@ -0,0 +1,41 @@
+config RISCV_ISA_C
+	bool
+
+choice
+	prompt "Compressed instruction support"
+	default PLATFORM_SUPPORTS_RISCV_ISA_C
+	help
+	  This selects the level of support for compressed instructions to be
+	  built into the Linux Kernel. This does not impact whether compressed
+	  instructions are allowed to be emitted by user-space code.
+
+config PROHIBIT_RISCV_ISA_C
+	bool "Prohibit compressed instructions"
+	depends on NONPORTABLE
+	help
+	  Regardless of if the platform supports compressed instructions,
+	  prohibit the kernel from emitting compressed instructions.
+
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_C
+	bool "Allow compressed instructions sequences if supported"
+	depends on FPU
+	depends on NONPORTABLE
+	select RISCV_ISA_C
+	help
+          Only allow compressed instructions to be emitted if "C" is present in
+          the device tree or ACPI table. No compressed instructions will be
+          emitted if the platform does not support them.
+
+config PLATFORM_SUPPORTS_RISCV_ISA_C
+	bool "Emit compressed instructions when building Linux"
+	depends on FPU
+	select RISCV_ISA_C
+	help
+	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in compressed instructions in the
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support compressed instructions.
+
+	  If you don't know what to do here, say Y.
+
+endchoice
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 5b3115a19852..e1be36004097 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -14,7 +14,7 @@ endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux += --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
-ifeq ($(CONFIG_RISCV_ISA_C),y)
+ifeq ($(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C),y)
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
 else
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
@@ -65,7 +65,7 @@ endif
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
+riscv-march-$(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 4b3dc8beaf77..a468689a6f6d 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -11,7 +11,7 @@
 
 bool is_swbp_insn(uprobe_opcode_t *insn)
 {
-#ifdef CONFIG_RISCV_ISA_C
+#ifdef CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C
 	return (*insn & 0xffff) == UPROBE_SWBP_INSN;
 #else
 	return *insn == UPROBE_SWBP_INSN;
diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index f4b6b3b9edda..259294bdbc3a 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -15,7 +15,9 @@
 
 static inline bool rvc_enabled(void)
 {
-	return IS_ENABLED(CONFIG_RISCV_ISA_C);
+	return IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_C) ||
+		(IS_ENABLED(CONFIG_PLATFORM_MAY_SUPPORT_RISCV_ISA_C) &&
+			riscv_has_extension_likely(RISCV_ISA_EXT_c));
 }
 
 static inline bool rvzbb_enabled(void)

-- 
2.44.0



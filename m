Return-Path: <linux-kernel+bounces-172598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4550C8BF424
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADA1B21BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA8BA38;
	Wed,  8 May 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N7yDtre1"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143379EA
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132204; cv=none; b=QaaEIC1j7kb8wVGGhpO1KVFIKojVxFgtZav4GAxFHrLAeBmy0BfSsQfUG2O6D3txvusMPEt5Uo7QYJBAzWVqQkIFQ123PejxF92qgNpBxgCj4pKbJDdEqOJkQ4t+YVT1Icfb00SipxPuKQ2N5mNJA+HoTnqN3bo6R1HIj/GphRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132204; c=relaxed/simple;
	bh=j9swSxT8d2fDA4kDGEnqoj8fqzKxNkC+d4MpaFY3y4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2bOmiceuw7n/XnGbvHPdHPO6tPRCkKw8y1TPGPihJIRyuI4yE63bRSAjWEQFK+b6EF9XrBjK+75M9BLGmQqKgKz3SS/bXOkeSxAISghW7/9bQMjV5BqGzvdArDZgAvEbKLDHUmgWArA5p/LADv/eNJ57qVIYP7kMI1JX4hzBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N7yDtre1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so2898664a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132202; x=1715737002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9yTxfWOtF5boAkE9/9YrcfOh3vEqeNnQBOu8ePUP3A=;
        b=N7yDtre1cHDBY2/PkKzxOyT/cJnehOHXyml0RTrBZ2mjtYZJYhek7WiP71M8wPI78n
         nfJJqKRj6+12kktbBvmLhVjt7Ooa4iziFMdEFseF5mjs84qWw2/MescDMmWchqLkwOFt
         maFifA9Z5Dt3Wq0JzYuyUjLgBiw6EtG1ms25+587uats9Bcp8L473rvjTpa9lQ0zhxG8
         /ybtj1S+5tHWfsqI3RSb07l4+K3s5xbDVyvlxN1glkr5doBig2a8BbhsEG+p/Sjshm6y
         1iHNj5jV9TS9930gv719NEMWdpL+dIxXzZM3vHhr0nhqn7FFHmiu01qHwaSCtnQYdweM
         GKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132202; x=1715737002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9yTxfWOtF5boAkE9/9YrcfOh3vEqeNnQBOu8ePUP3A=;
        b=erokPvuzrEr+6i+D8pmgEHRej944PtDm7TRGZ2flbFXQFAoj67fXFwzzu4BJNtl4ZF
         aVXJM3w0n33Wr5XBBq5C6t6tzpxDGv6b8mriNOa3UNCbNyWmQdFA6+TNq3gt1eTDG58A
         Xr2UYyf1zUifnIk7XA2UMfPokAo1maQwYG81375+O4kF4aUNidNksPZhXdGVTutPZNAC
         4tYAn17gp+7fVDw+X7HdTnp3FAxqlCSLwJr3i/d/GVndjgXrG8ytjtA+6CEmCxS9HFZV
         naUxvBP42g1KeU/72CI8bn5jtidT2MNUZgvookfrh0WfQUuUwAjpAOa10N5TWNQJ+Uxu
         IPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJppIOmoNdBUlqCMCUJhQ5WIpNrMHbI6cmxDIAOdJ2OUb7w7AX3eFo2/ukQF45B2EjcylC60uPkDr/9ro5ZerhMNQApMhVNv33JM7p
X-Gm-Message-State: AOJu0YzZ1vkIbqvNSFDh0ZJyOPgiuF5Jza2Wouk8XSN1etUTgM234avp
	fss/LSqYslq3+2BUJTowI9kOgO0/Eb8XvrM3RgK3g3LxqKZf2s+wBIELcUhfYmY=
X-Google-Smtp-Source: AGHT+IG1y+2SksOJ5/iFT/Z5fKQTo1Zf9NVG2qfabMXNk0GuZoWNzylHq8ETlUv78rTnGDNbEMlqHg==
X-Received: by 2002:a17:90a:fd0c:b0:2ac:23ec:6a57 with SMTP id 98e67ed59e1d1-2b6169db571mr1212359a91.39.1715132201989;
        Tue, 07 May 2024 18:36:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:41 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 May 2024 18:36:27 -0700
Subject: [PATCH v2 1/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_C Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-compile_kernel_with_extensions-v2-1-722c21c328c6@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=5960;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=j9swSxT8d2fDA4kDGEnqoj8fqzKxNkC+d4MpaFY3y4k=;
 b=7HgrUjF7yNqvZHKoMqkfNlOf3VFDhBOLsI3MIl5rTg6+kqCvct+IvjzRfsRPpeygmRzDbM6zH
 UvjMdMc28OiCM/Bc16GtdVCvODCU5QyePqQ0aq1o9XFlS1lGoN15AbV
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce a "Kernel ISA" menu and migrate the compressed instruction
support options into a new file Kconfig.isa. Add a new option
"PLATFORM_MAY_SUPPORT_RISCV_ISA_C" that can be used to conditionally
emit C extensions if the hardware supports it.

The existing "RISCV_ISA_C" option is repurposed to be used to by kernel
code to determine if either PLATFORM_MAY_SUPPORT_RISCV_ISA_C or
PLATFORM_SUPPORTS_RISCV_ISA_C has been set.

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



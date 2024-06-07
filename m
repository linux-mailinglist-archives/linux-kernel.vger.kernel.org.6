Return-Path: <linux-kernel+bounces-206812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 948BB900E12
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2BE1F22958
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7E15572C;
	Fri,  7 Jun 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j99fshAa"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5D13DDCA;
	Fri,  7 Jun 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799418; cv=none; b=gi2VvEF9y80hFM69cZ21VxlqWCsNsp17WIJ73euMxYgcSLWYowJCvAPybp099hWSBQWhXEYCrulMDuGVURz/a8rOyWzta0eXiZmHoOQ7YNHVZAzeT3ZEFBgxLe65XCljR6My0r1smN5GEIPmj/SU9b4k9TcFZGUkFmJkWROY0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799418; c=relaxed/simple;
	bh=Rzz2lr5jDDCxd19LGs+cCednwI0D/qvvd4uXfAbNrMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=V1LFJV//YDeKqD3axZ7xbuUCClh8n0Aez3YFPcxAkmVINGUX9JVETQrg10le7VcLjbzpli9yPNtkuRzwI5AB2WoaSNYRGAa7kTFo6nqlWmoKQ7HV1cSF7a6rgC9V7ZwaaNjTu9FvKApxsvCNOfWEsWDH9DrbHBan+9qFBNf5lsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j99fshAa; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c6d3e6606so61191a12.0;
        Fri, 07 Jun 2024 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717799414; x=1718404214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CN4Fagcr9kw1yaYPk5eRmX9Rl/PBb8fEu5udOKhfOY=;
        b=j99fshAaSa2ej10wNxuYTFSIZvLVymZd80QjhGmMbSk8gDdy4g2cjrV7nUwEY0zj5u
         wfmNnRQ2Hn6Gv8gKMTzwPLz8diNmeEq2Y6ZIX4wHKuRjvHAwcWGDoiDDspZS7Z5ekw3O
         qyMXpeLfm081yODb4CdKBjn3+QmlWEiSMfkZdTKmAI7BOYkfnh3hlf0O+4JCNEC1UjI1
         mxsRj35vR0hTVXOkClvy3sFf+UQ3kJGJ1bx3edrZHYZNHRKyERU7rjTd57gOlDLcMtb0
         kX2omymLKr/d6f59WxJyDf7WhnxsnwXJ1i79glFVOVRKeGqG869hgNwP0yXz+BIxr4So
         NnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717799414; x=1718404214;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+CN4Fagcr9kw1yaYPk5eRmX9Rl/PBb8fEu5udOKhfOY=;
        b=nVX3kxrZhjF7GfyHV+MqSr5IcTDLMzMhW4kIj7koG9W7lq2CaYMK/2Tc5kWvtfpaJC
         66//FWHu8GMRtyUX4zbWzLYIbIT5NTRNfC4UMd0g0L+fjLIumeZIhFjSRdG0rO4HkVyE
         klImwwYil70ioVM6DrPHkiH3tGcCX/XRefoQDzBk9OviOzeSvj7R8nO8gbKjXZDNZGJT
         qZqdKN9Akeg1ltJ98EUJwv+B3w7dpLhHPTQykCXpLTJ0IaaLUjXcS407q/oMbH52uygi
         Rd1dgjspWl5EtVBUDgVkNK916mpQ1mBimbtq9GMJsoBTvXLzJwWykpflQF/Wr703vx/t
         A1bw==
X-Forwarded-Encrypted: i=1; AJvYcCWRhga3JXGzC+SdPKP6ll1f3t61/98AJBwvSnH8mMEzxfUsLQXM8BEJLdHwF2MiDF988PhyDIl8EDe74oRJZuqYfMTz7sPyesxY3Zdyd4w=
X-Gm-Message-State: AOJu0Yw4H+GksoE4CyiIO6ORjyA60tizSuyIvh4Ky4NfE0GBIV1yXvng
	CCULOIc+z+2mjykY8+++TBeztgUncg1ag0G2zY9BweClLzcmkrNDQYPiZYQQ
X-Google-Smtp-Source: AGHT+IHPgEwmpOZ+rHjWFDdF79iPXCV9lwQCFpy9QbdOdMW+rl+644y2eM/xOb5ilZlXNNr/KU/z4w==
X-Received: by 2002:a17:906:c8c1:b0:a6d:fbed:7953 with SMTP id a640c23a62f3a-a6dfbed7a3cmr238081466b.27.1717799414057;
        Fri, 07 Jun 2024 15:30:14 -0700 (PDT)
Received: from [10.5.1.156] (188-22-218-164.adsl.highway.telekom.at. [188.22.218.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070bfcbsm305295866b.145.2024.06.07.15.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 15:30:13 -0700 (PDT)
Message-ID: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
Date: Sat, 8 Jun 2024 00:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
Subject: [PATCH 1/1] arm: rust: Enable Rust support for ARMv7
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
 Sven Van Asbroeck <thesven73@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit allows building ARMv7 kernels with Rust support.

The rust core library expects some __eabi_... functions
that are not implemented in the kernel.
Those functions are some float operations and __aeabi_uldivmod.

This is based on the code by Sven Van Asbroeck from the original
rust branch and inspired by the AArch version by Jamie Cunliffe.

I have tested the rust samples and a custom simple MMIO module
on on hardware (De1SoC FPGA + Arm A9 CPU).

Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>
---
 Documentation/rust/arch-support.rst |  1 +
 arch/arm/Kconfig                    |  1 +
 arch/arm/Makefile                   |  1 +
 rust/Makefile                       | 10 +++++++++-
 rust/bindgen_parameters             |  4 ++++
 rust/compiler_builtins.rs           | 24 ++++++++++++++++++++++++
 scripts/generate_rust_target.rs     |  4 +++-
 7 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index b13e19d84744..4bf5205f526d 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -15,6 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
 =============  ================  ==============================================
 Architecture   Level of support  Constraints
 =============  ================  ==============================================
+``arm``        Maintained        ARMv7 Little Endian only.
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
 ``riscv``      Maintained        ``riscv64`` only.
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ee5115252aac..f07149fe078b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -126,6 +126,7 @@ config ARM
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
+	select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 71afdd98ddf2..9cc10e32e8be 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -150,6 +150,7 @@ endif
 KBUILD_CPPFLAGS	+=$(cpp-y)
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_RUSTFLAGS += --target=arm-unknown-linux-gnueabi
 
 CHECKFLAGS	+= -D__arm__
 
diff --git a/rust/Makefile b/rust/Makefile
index f70d5e244fee..ef177ffb68a8 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -286,7 +286,8 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
-BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
+BINDGEN_TARGET_arm64:= aarch64-linux-gnu
+BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
 # All warnings are inhibited since GCC builds are very experimental,
@@ -413,6 +414,13 @@ redirect-intrinsics = \
 	__muloti4 __multi3 \
 	__udivmodti4 __udivti3 __umodti3
 
+ifdef CONFIG_ARM
+	# Add eabi initrinsics for ARM 32-bit
+	redirect-intrinsics += \
+		__aeabi_fadd __aeabi_fmul __aeabi_fcmpeq __aeabi_fcmple __aeabi_fcmplt __aeabi_fcmpun \
+		__aeabi_dadd __aeabi_dmul __aeabi_dcmple __aeabi_dcmplt __aeabi_dcmpun \
+		__aeabi_uldivmod
+endif
 ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
 	# These intrinsics are defined for ARM64 and RISCV64
 	redirect-intrinsics += \
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index a721d466bee4..bf0148b3019e 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -24,3 +24,7 @@
 # These functions use the `__preserve_most` calling convention, which neither bindgen
 # nor Rust currently understand, and which Clang currently declares to be unstable.
 --blocklist-function __list_.*_report
+
+# Depending on how the architecute defines ARCH_SLAB_MINALIGN, bindgen might generate a binding.
+# Disable this here as there is a const that will always be generated in bindings_helper.c
+--blocklist-item ARCH_SLAB_MINALIGN
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index bba2922c6ef7..c37142b16a45 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -70,5 +70,29 @@ pub extern "C" fn $ident() {
     __umodti3,
 });
 
+#[cfg(target_arch = "arm")]
+define_panicking_intrinsics!("`f32` should not be used", {
+    __aeabi_fadd,
+    __aeabi_fmul,
+    __aeabi_fcmpeq,
+    __aeabi_fcmple,
+    __aeabi_fcmplt,
+    __aeabi_fcmpun,
+});
+
+#[cfg(target_arch = "arm")]
+define_panicking_intrinsics!("`f64` should not be used", {
+    __aeabi_dadd,
+    __aeabi_dmul,
+    __aeabi_dcmple,
+    __aeabi_dcmplt,
+    __aeabi_dcmpun,
+});
+
+#[cfg(target_arch = "arm")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __aeabi_uldivmod,
+});
+
 // NOTE: if you are adding a new intrinsic here, you should also add it to
 // `redirect-intrinsics` in `rust/Makefile`.
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 641b713a033a..acfcf2e22e28 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -148,7 +148,9 @@ fn main() {
     let mut ts = TargetSpec::new();
 
     // `llvm-target`s are taken from `scripts/Makefile.clang`.
-    if cfg.has("ARM64") {
+    if cfg.has("ARM") {
+        panic!("arm uses the builtin rustc target");
+    } else if cfg.has("ARM64") {
         panic!("arm64 uses the builtin rustc aarch64-unknown-none target");
     } else if cfg.has("RISCV") {
         if cfg.has("64BIT") {
-- 
2.45.2



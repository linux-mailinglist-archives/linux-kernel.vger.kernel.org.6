Return-Path: <linux-kernel+bounces-217903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C290B68F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E305CB47A49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1801A182DF;
	Mon, 17 Jun 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIFnqAKj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906C1D951C;
	Mon, 17 Jun 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640201; cv=none; b=T3WsFz3VxHKPgFuDzxQMaoE3BNxGad0FlkwkETza6PBRpHwbaWqTfbOkFa/XTIqHx4wHgA3gHtvbpNoR2nq0zX8pmpfihWnx/0wmhHT33eH2UaxwKH3VbiT3EYQg6W/AaUjKkdFq2q3RDGNC+UY23HXL/wPgLyVBq1K/pQjvixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640201; c=relaxed/simple;
	bh=lBSAhG4kxwlt8HqpfAYOA3z3MYxAXqQuxAFF04DLk3A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=M8Xz3k6UBtuNn3V8MCueFORS68Le2LceMolM10zJIE29Ar9HiXNPZo3mjNgKxCHtoQ7V//iC8WocHNQJMVHdEV0ky8iVWvtZhiaS1s0/3SQwLIiy85p2CPI93EYrU6W820Mnr8dH9P5hkfpqxrA6qiX6ZV46IlaX2s9tFc6ukdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIFnqAKj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so35254605e9.3;
        Mon, 17 Jun 2024 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718640197; x=1719244997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zrczeM4bdzO0oUIzzu48HGb8iTeMt/017ltLJZV/Sk=;
        b=XIFnqAKj5DWPPl15jMhvWraTLgKk4tkf8xTRjeOb0EiiGtkidtMwq9TwGYZexogD+s
         I4ouMtfBfzpI09XFoJOM3ptlsli9Gkv5enKybgpuWtA5tti+mCTwUW0YfRX+urDqRm2Q
         Ep9MEFcmA2onvBcsvbUikvMLn8kgs7Ufnwvj37yGxmFHU7+YtWhiMUQPZXQ9s8lnbAAa
         S087ZrRuUWLp9Ac6ANh7bIkN25FIOsjhZTxUoRwMBuSzWMr2znJiOQfjfQQ9f8P0on9d
         yaGmw0KSGflZ4BQdYvWvRMFR6sAWpVPmXTLDDh0AncCxF4L3D5Vp3KeRYV0+KcOabewx
         U2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718640197; x=1719244997;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zrczeM4bdzO0oUIzzu48HGb8iTeMt/017ltLJZV/Sk=;
        b=ePnuubQTnc1D7Oi3BCu8MqsiB4UPltTUSfJaja/XIl1f01f4v8mqia9Fjtzu3wOkQy
         s7Urzrd9HvNzjDFphplTQh6iDirVWIVKsLeWuwxMBAtEril4xNEEl74r8mJQ413zJ5Lx
         AcFmwIDTQf66g9Q8a6Lf5GmqTomur28E2yizqvUWkso4GHCXnCKpMqvyJ11piMRbFp24
         t4ggFxFjom8u6W7OiYzHZbxdtVzO/xyvkCLz4rD6sRPv7tBDIRBBF2wUrWd7NoFjd8dU
         HtH+iV8qY02u2PkuxKmIbvlmF0bj2cDXbwJFrgGAeOmZsqqAWdT8AKWAXCShdyBw+u6r
         Atmg==
X-Forwarded-Encrypted: i=1; AJvYcCVPrCLcfR1pGH0sxefPp9wl+z0JQLwVI4C2aIRvCxEROt7697Va8VV13PwCaLeE7oiLtQdZlcc+CHCq25cUhun5EPpUOnxg+JyNkpI6IFc=
X-Gm-Message-State: AOJu0YxBAZ48V0r8ZGia78lV/ur+3RwEt0MAev84P7nF0gOUS3prbf4k
	22wOvX24nu7D+6uFULvj1Srn3mkcoejHSrHfdTIrBoik+OWn3uHo7YAz9YIC
X-Google-Smtp-Source: AGHT+IF6Ix1kuSan1958bYh1RWh8Zhz3051jysHe2tCHrIEyyJ43VzeMCWehCn/FWGfEkdNwIhyLgQ==
X-Received: by 2002:a05:600c:4ed0:b0:421:963b:57d9 with SMTP id 5b1f17b1804b1-4230484c5fdmr85942305e9.33.1718640197053;
        Mon, 17 Jun 2024 09:03:17 -0700 (PDT)
Received: from [10.5.1.156] (188-22-218-164.adsl.highway.telekom.at. [188.22.218.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114e09sm12117931f8f.117.2024.06.17.09.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 09:03:16 -0700 (PDT)
Message-ID: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
Date: Mon, 17 Jun 2024 18:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Schrefl <chrisi.schrefl@gmail.com>
Subject: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
 Sven Van Asbroeck <thesven73@gmail.com>,
 Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit allows building ARMv7 kernels with Rust support.

The rust core library expects some __eabi_... functions
that are not implemented in the kernel.
Those functions are some float operations and __aeabi_uldivmod.
For now those are implemented with define_panicking_intrinsics!.

This is based on the code by Sven Van Asbroeck from the original
rust branch and inspired by the AArch64 version by Jamie Cunliffe.

I have tested the rust samples and a custom simple MMIO module
on hardware (De1SoC FPGA + Arm A9 CPU).

This only includes support for ARMv7, but supporting other
sub-architectures in the future should be as simple as setting 
the correct rustc target.

Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>
---
Changes since V1 [1]:
- Removed unrelated whitespace change.
- Added target name to panic message in scripts/generate_rust_target.rs.
- Fixed the comment in rust/bindgen_parameters.


[1]: https://lore.kernel.org/rust-for-linux/4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com 
--
 Documentation/rust/arch-support.rst |  1 +
 arch/arm/Kconfig                    |  1 +
 arch/arm/Makefile                   |  1 +
 rust/Makefile                       |  8 ++++++++
 rust/bindgen_parameters             |  4 ++++
 rust/compiler_builtins.rs           | 24 ++++++++++++++++++++++++
 scripts/generate_rust_target.rs     |  4 +++-
 7 files changed, 42 insertions(+), 1 deletion(-)

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
index f70d5e244fee..8214a6f378e3 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -287,6 +287,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
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
index a721d466bee4..83f28ae4bb2b 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -24,3 +24,7 @@
 # These functions use the `__preserve_most` calling convention, which neither bindgen
 # nor Rust currently understand, and which Clang currently declares to be unstable.
 --blocklist-function __list_.*_report
+
+# Depending on how the architecture defines `ARCH_SLAB_MINALIGN`, `bindgen` might generate a binding.
+# Disable this here as there is a `const` item that will always be generated in `bindings_helper.h`
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
index 641b713a033a..c3a6058fdf30 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -148,7 +148,9 @@ fn main() {
     let mut ts = TargetSpec::new();
 
     // `llvm-target`s are taken from `scripts/Makefile.clang`.
-    if cfg.has("ARM64") {
+    if cfg.has("ARM") {
+        panic!("arm uses the builtin rustc arm-unknown-linux-gnueabi target");
+    } else if cfg.has("ARM64") {
         panic!("arm64 uses the builtin rustc aarch64-unknown-none target");
     } else if cfg.has("RISCV") {
         if cfg.has("64BIT") {

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.2


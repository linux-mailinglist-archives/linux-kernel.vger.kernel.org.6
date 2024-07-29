Return-Path: <linux-kernel+bounces-265500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09793F203
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D411287455
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1BB144D1F;
	Mon, 29 Jul 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNHu3sb7"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C31448C6;
	Mon, 29 Jul 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247100; cv=none; b=rm0Y+zbZ0k8Z0M2KayrRbcAeK+E84OgfSYNGZXDYPqpg7cJ5yLZ2VjNKqVrKCJDor8yNI5L2/Dqm7v5zBr2liPZzS/yXJVSeCXcVjQexVNkNgoz7csJ8/bJ+VXoyY59wHCkqc+2aEu1aqtf2CUEZmplBW7sCfbp4LkuKIyb2w4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247100; c=relaxed/simple;
	bh=3ZnQW3G376KGdLA9NvoQAlRC0iQCpALCsYgLYY95FBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M6DHSWpwWEuMrSkmlcSchArPFpQAQpFyZ19GNfHKD/28J89LB4XnHO3/iR24hoZrgzqCbFuNDY/yZstK7fdBEiZLzhOak7uqh2bUGUG8CaBPB2TpVfoofarEivjcRbjxmKOuDiZZPAVb+E5df6LIJ5mFkdGX5/Rhl8+fUotjY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNHu3sb7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so2751417a12.0;
        Mon, 29 Jul 2024 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722247097; x=1722851897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0C7vN/0GQE6CVzJx8SRnXrV4ZQXWzrPWijllSXnWlg=;
        b=KNHu3sb7/bTZWW5jD21S51yo7d5ok6gStMlWE0p6dqNdSJkuawnaj07trTBSf4su72
         27yLN+Tvl9RKxgQR3CdLFvu9pjH0Fh4Hh22i99BxONySLYNHAdIIm3AQx+wSIq5XY57P
         mJrb2RDjgl40KtPYcKmgMqidrmvfZ4EmdS1q64OjGxsI2DM/ZvJzwsDKtg3Iqt41VXB2
         dKwBqK7xQ67oB1ITAt6/eA3EEB7KEqZ5h0DdytrEC+53QJEP2/2YapSb3QYw/LPvgiEX
         Pvj6Q4uvqb35HXTUuSpxdKQRq9FotiTHxgS8WeMcgzeP3+umJJbzsR8Lg6KJYvtO7z5/
         K7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722247097; x=1722851897;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0C7vN/0GQE6CVzJx8SRnXrV4ZQXWzrPWijllSXnWlg=;
        b=B9iies+h1QShvnghkAOmZziY4KL7EMlBshATgmXQKOPycu3WtMOX9lQSAMGZqEHRtc
         NGDJ1A1lMybVpIWABwr946LdStJazEQGW9qxVzLPRZzIHxlmumIO5n4FJH05LOR4Q4wx
         uVau2pD87TRdpW/2n++N3u5CvJ8BC83rz5oGk+kLxq9lrDpZDiTHxnjlHQZeRQP2R5ab
         CaYUzeU0ATBOPAOi5EQU7wn6dfKWkTrIkFuxSi5Z1pteFOf66NrMyQeKKcPHV0VuqLJ9
         cKGX3klTp0eX6FCfpMgVXbgXb2UTG6gV6vb+ENr1DCh2mz+HrezLnkvYouLTWkiQYzr0
         eTCg==
X-Forwarded-Encrypted: i=1; AJvYcCXm8T3wtMRJSyfMMAhGikmR8XjIt1FVU3CvzeBpP+4wI6+9QxzCtPQsSsAvFFr+PfLstDTBvdJR0PRRDfFoW6xgm9BfLsOxXwFxH+aw/hE=
X-Gm-Message-State: AOJu0YzN+hIvfBg5QyJrrBS2abRPCz8UvqFellkE5B87C5XA0RbKhI9B
	3NY+EXCREjD1Dv/EBv+e9nwKTwfXJ3F8U035iRyGMgKSoZkzrLDN5lA7p0Vb
X-Google-Smtp-Source: AGHT+IGgKmfThrWFbCPtIXIL7Y46QvI/M2HNG0lq/TnBLEYMgdEIIiGGiu9+y4y5DeOHudisyXKBUQ==
X-Received: by 2002:a05:6402:5190:b0:5aa:32bb:161 with SMTP id 4fb4d7f45d1cf-5b021f0c55cmr5465600a12.22.1722247096558;
        Mon, 29 Jul 2024 02:58:16 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:50e2::2000? ([2001:871:22a:50e2::2000])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b044csm5520143a12.19.2024.07.29.02.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 02:58:16 -0700 (PDT)
Message-ID: <fc3e956c-4f0d-4705-8429-2b7c50e335ce@gmail.com>
Date: Mon, 29 Jul 2024 11:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
From: Christian Schrefl <chrisi.schrefl@gmail.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
 Sven Van Asbroeck <thesven73@gmail.com>,
 Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
Content-Language: en-US
In-Reply-To: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Greetings,

Friendly Ping :)

This has been on the mailing list for quite some time with only a few responses.

Please let me know if something is needed from my side (like rebasing or wanted changes).

Cheers
Christian


On 17.06.24 6:03 PM, Christian Schrefl wrote:
> This commit allows building ARMv7 kernels with Rust support.
> 
> The rust core library expects some __eabi_... functions
> that are not implemented in the kernel.
> Those functions are some float operations and __aeabi_uldivmod.
> For now those are implemented with define_panicking_intrinsics!.
> 
> This is based on the code by Sven Van Asbroeck from the original
> rust branch and inspired by the AArch64 version by Jamie Cunliffe.
> 
> I have tested the rust samples and a custom simple MMIO module
> on hardware (De1SoC FPGA + Arm A9 CPU).
> 
> This only includes support for ARMv7, but supporting other
> sub-architectures in the future should be as simple as setting 
> the correct rustc target.
> 
> Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> ---
> Changes since V1 [1]:
> - Removed unrelated whitespace change.
> - Added target name to panic message in scripts/generate_rust_target.rs.
> - Fixed the comment in rust/bindgen_parameters.
> 
> 
> [1]: https://lore.kernel.org/rust-for-linux/4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com 
> --
>  Documentation/rust/arch-support.rst |  1 +
>  arch/arm/Kconfig                    |  1 +
>  arch/arm/Makefile                   |  1 +
>  rust/Makefile                       |  8 ++++++++
>  rust/bindgen_parameters             |  4 ++++
>  rust/compiler_builtins.rs           | 24 ++++++++++++++++++++++++
>  scripts/generate_rust_target.rs     |  4 +++-
>  7 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> index b13e19d84744..4bf5205f526d 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -15,6 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
>  =============  ================  ==============================================
>  Architecture   Level of support  Constraints
>  =============  ================  ==============================================
> +``arm``        Maintained        ARMv7 Little Endian only.
>  ``arm64``      Maintained        Little Endian only.
>  ``loongarch``  Maintained        \-
>  ``riscv``      Maintained        ``riscv64`` only.
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ee5115252aac..f07149fe078b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -126,6 +126,7 @@ config ARM
>  	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RSEQ
> +	select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_UID16
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 71afdd98ddf2..9cc10e32e8be 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -150,6 +150,7 @@ endif
>  KBUILD_CPPFLAGS	+=$(cpp-y)
>  KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
>  KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> +KBUILD_RUSTFLAGS += --target=arm-unknown-linux-gnueabi
>  
>  CHECKFLAGS	+= -D__arm__
>  
> diff --git a/rust/Makefile b/rust/Makefile
> index f70d5e244fee..8214a6f378e3 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -287,6 +287,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
>  # Derived from `scripts/Makefile.clang`.
>  BINDGEN_TARGET_x86	:= x86_64-linux-gnu
>  BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
> +BINDGEN_TARGET_arm	:= arm-linux-gnueabi
>  BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
>  
>  # All warnings are inhibited since GCC builds are very experimental,
> @@ -413,6 +414,13 @@ redirect-intrinsics = \
>  	__muloti4 __multi3 \
>  	__udivmodti4 __udivti3 __umodti3
>  
> +ifdef CONFIG_ARM
> +	# Add eabi initrinsics for ARM 32-bit
> +	redirect-intrinsics += \
> +		__aeabi_fadd __aeabi_fmul __aeabi_fcmpeq __aeabi_fcmple __aeabi_fcmplt __aeabi_fcmpun \
> +		__aeabi_dadd __aeabi_dmul __aeabi_dcmple __aeabi_dcmplt __aeabi_dcmpun \
> +		__aeabi_uldivmod
> +endif
>  ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
>  	# These intrinsics are defined for ARM64 and RISCV64
>  	redirect-intrinsics += \
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index a721d466bee4..83f28ae4bb2b 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -24,3 +24,7 @@
>  # These functions use the `__preserve_most` calling convention, which neither bindgen
>  # nor Rust currently understand, and which Clang currently declares to be unstable.
>  --blocklist-function __list_.*_report
> +
> +# Depending on how the architecture defines `ARCH_SLAB_MINALIGN`, `bindgen` might generate a binding.
> +# Disable this here as there is a `const` item that will always be generated in `bindings_helper.h`
> +--blocklist-item ARCH_SLAB_MINALIGN
> diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> index bba2922c6ef7..c37142b16a45 100644
> --- a/rust/compiler_builtins.rs
> +++ b/rust/compiler_builtins.rs
> @@ -70,5 +70,29 @@ pub extern "C" fn $ident() {
>      __umodti3,
>  });
>  
> +#[cfg(target_arch = "arm")]
> +define_panicking_intrinsics!("`f32` should not be used", {
> +    __aeabi_fadd,
> +    __aeabi_fmul,
> +    __aeabi_fcmpeq,
> +    __aeabi_fcmple,
> +    __aeabi_fcmplt,
> +    __aeabi_fcmpun,
> +});
> +
> +#[cfg(target_arch = "arm")]
> +define_panicking_intrinsics!("`f64` should not be used", {
> +    __aeabi_dadd,
> +    __aeabi_dmul,
> +    __aeabi_dcmple,
> +    __aeabi_dcmplt,
> +    __aeabi_dcmpun,
> +});
> +
> +#[cfg(target_arch = "arm")]
> +define_panicking_intrinsics!("`u64` division/modulo should not be used", {
> +    __aeabi_uldivmod,
> +});
> +
>  // NOTE: if you are adding a new intrinsic here, you should also add it to
>  // `redirect-intrinsics` in `rust/Makefile`.
> diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
> index 641b713a033a..c3a6058fdf30 100644
> --- a/scripts/generate_rust_target.rs
> +++ b/scripts/generate_rust_target.rs
> @@ -148,7 +148,9 @@ fn main() {
>      let mut ts = TargetSpec::new();
>  
>      // `llvm-target`s are taken from `scripts/Makefile.clang`.
> -    if cfg.has("ARM64") {
> +    if cfg.has("ARM") {
> +        panic!("arm uses the builtin rustc arm-unknown-linux-gnueabi target");
> +    } else if cfg.has("ARM64") {
>          panic!("arm64 uses the builtin rustc aarch64-unknown-none target");
>      } else if cfg.has("RISCV") {
>          if cfg.has("64BIT") {
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0


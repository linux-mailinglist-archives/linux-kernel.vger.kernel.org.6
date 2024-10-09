Return-Path: <linux-kernel+bounces-357640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B01C9973A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6267A1C23371
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3C1EABCD;
	Wed,  9 Oct 2024 17:43:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0CA1EABB3;
	Wed,  9 Oct 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495816; cv=none; b=axVVKbyCtCCyfYD2dxTXLMep0HtZl0O/Yov7vLrS6niT0D1QKfwJuEs557UD4ZzGWB+yixMbiivr+XdzPUdKFjRuSWl6CxtJpW1ZsOOoxvRPM1RVKTM8z4cdd+ZkPu2esJJ/X1ewMRQ9VT731vVPG6lY6ngxraQxTIIbVl8eTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495816; c=relaxed/simple;
	bh=WH2AnXNFGs2kfRCljIeNV726W6HViMfQ0A2T6W5jCCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azHeyZV1CdsDBOS/xkjkYTQWTzO/CNrE3IkaQptq6grW269MwUWYvbpTaXoauqCJ1VoPoWX2aBGf8KeJxUlbi7xXQbysuVa7jzBkm+Y9Q/STT/vNJxqAko/O3UVEr4ygem0Zl9M9pWRWG4U4noV1X25X3z8IBad0Nqqf6FdCWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 720FADA7;
	Wed,  9 Oct 2024 10:44:02 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64B333F64C;
	Wed,  9 Oct 2024 10:43:29 -0700 (PDT)
Date: Wed, 9 Oct 2024 18:43:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all
 architectures
Message-ID: <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>

Hi Alice,

On Tue, Oct 08, 2024 at 05:37:16PM +0000, Alice Ryhl wrote:
> The KCFI sanitizer stores the CFI tag of a function just before its
> machine code. However, the patchable-function-entry flag can be used to
> introduce additional nop instructions before the machine code, taking up
> the space that normally holds the CFI tag.

To clarify, when you say "before the machine code", do you mean when
NOPs are placed before the function entry point? e.g. if we compiled
with -fpatchable-function-entry=M,N where N > 0? I'll refer tho this as
"pre-function NOPs" below.

There's an existing incompatibility between CFI and pre-function NOPs
for C code, because we override -fpatchable-function-entry on a
per-function basis (e.g. for noinstr and notrace), and we don't
currently have a mechanism to ensure the CFI tag is in the same place
regardless. This is why arm64 has CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
depend on !CFI.

For C code at least, just using regular -fpatchable-function-entry=M or
-fpatchable-function-entry=M,0 shouldn't change the location of the CFI
tag relative to the function entrypoint, and so should have no adverse
effect on CFI.

Is Rust any different here?

> In this case, a backwards offset is applied to the CFI tag to move
> them out of the way of the nop instructions. To ensure that C and Rust
> agree on the offset used by CFI tags, pass the
> -Zpatchable-function-entry to rustc whenever it is passed to the C
> compiler.

As above, I suspect this isn't necessary to make CFI work, for any case
that works with C today, due to -fpatchable-funtion-entry being
overridden on a per-function basis. Are you seeing a problem in
practice, or was this found by inspection?

However IIUC this will allow rust to be traced via ftrace (assuming rust
records the instrumented locations as gcc and clang do); is that the
case? Assuming so, is there any ABI difference that might bite us? On
arm64 we require that anything marked instrumented with
patchable-function-entry strictly follows the AAPCS64 calling convention
and our ftrace trampolines save/restore the minimal set of necessary
registers, and I don't know how rust whether rust will behave the same
or e.g. use specialized calling conventions internally.

Mark.

> The required rustc version is bumped to 1.81.0 to ensure that the
> -Zpatchable-function-entry flag is available when CFI is used.
> 
> Fixes: ca627e636551 ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Note that this fix uses rustc-option which has a pending fix:
> https://lore.kernel.org/all/20241008-rustc-option-bootstrap-v2-1-e6e155b8f9f3@google.com/
> ---
>  arch/arm64/Makefile     | 2 ++
>  arch/loongarch/Makefile | 1 +
>  arch/riscv/Makefile     | 2 ++
>  init/Kconfig            | 2 +-
>  4 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 9efd3f37c2fd..d7ec0bb09fc4 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -143,9 +143,11 @@ CHECKFLAGS	+= -D__aarch64__
>  ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
>    KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>    CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
> +  KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=4$(comma)2)
>  else ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
>    KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>    CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +  KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=2)
>  endif
>  
>  ifeq ($(CONFIG_KASAN_SW_TAGS), y)
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ae3f80622f4c..f9cef31d1f0e 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -44,6 +44,7 @@ endif
>  ifdef CONFIG_DYNAMIC_FTRACE
>  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=2)
>  endif
>  
>  ifdef CONFIG_64BIT
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index d469db9f46f4..65d4dcba309a 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -16,8 +16,10 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>  	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>  ifeq ($(CONFIG_RISCV_ISA_C),y)
>  	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
> +	KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=4)
>  else
>  	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +	KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=2)
>  endif
>  endif
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 530a382ee0fe..43434b681c3f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1946,7 +1946,7 @@ config RUST
>  	depends on !GCC_PLUGIN_RANDSTRUCT
>  	depends on !RANDSTRUCT
>  	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> -	depends on !CFI_CLANG || RUSTC_VERSION >= 107900 && HAVE_CFI_ICALL_NORMALIZE_INTEGERS
> +	depends on !CFI_CLANG || RUSTC_VERSION >= 108100 && HAVE_CFI_ICALL_NORMALIZE_INTEGERS
>  	select CFI_ICALL_NORMALIZE_INTEGERS if CFI_CLANG
>  	depends on !CALL_PADDING || RUSTC_VERSION >= 108100
>  	depends on !KASAN_SW_TAGS
> 
> ---
> base-commit: 4a335f920bc78e51b1d7d216d11f2ecbb6dd949f
> change-id: 20241008-cfi-patchable-all-ddd6275eaf4f
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
> 


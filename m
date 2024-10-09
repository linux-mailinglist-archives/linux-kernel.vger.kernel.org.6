Return-Path: <linux-kernel+bounces-356334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D56995FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E1CB21194
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A891684A5;
	Wed,  9 Oct 2024 06:22:06 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA17154430
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454925; cv=none; b=b9mZclJlmsF3QezPpVVOaJRzBe18WrnWukZ5AmwjoPVeffp77tQayPVCE7hZ+uj6wpJPrhU2/8vCEKtni/10b0bAg7/HTKK5NrSL7FRxmy3ts/SpmFNGtUvhLY/7C8ZEKmDynxyGWb8gWwe2UfvRGC8RdZjHD4aJDM7AksTPJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454925; c=relaxed/simple;
	bh=JAEhS2mqRRkb5iEnSsWZ0RACxT/0aX7Tg2yY0kQKOZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePbBnWDF0Sgto2zt9iCOkNR9962SVIrt/rF9qeubmSt+apvHXlwcgfWFxHMRv41gXh9emnR07x8QUGyus6urAU2HlDIFEvdTLRswMn6OwtBDuqCBt6B/M8ikFXAMNPjfE4sXXdd7IsujwHaKGXnRINwB5NdAtN9H22tut1MuCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.161.44])
	by gateway (Coremail) with SMTP id _____8AxSYoHIQZnCZ8QAA--.23707S3;
	Wed, 09 Oct 2024 14:22:00 +0800 (CST)
Received: from mail-oo1-f44.google.com (unknown [209.85.161.44])
	by front1 (Coremail) with SMTP id qMiowMDx7tUDIQZnSAMhAA--.48836S3;
	Wed, 09 Oct 2024 14:21:57 +0800 (CST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e803a9f208so295645eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 23:21:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgnzqKbV+C+CpAAWJlhfRfD5If3ke1qe6G4v+l88Bq2CYoGepq9LqoDiZGG3OBjA7AsAls61pvinG9g+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lGThaddsH7qQH6jrGQPviTs0St1ZAV9rtUyXewVuu1VjcyiG
	0NBzZsMmFzLB9ioKDCabKW8GbXpqLdyb2BbPkZEQRAI9uMhAwgVgLzbcDmqPVOo801DWd6tLgM5
	otC1RSemPPszkXlstr5enbwtox+sUnB7cKr9aJQ==
X-Google-Smtp-Source: AGHT+IFJ2asEEWxZSKka5K8xJcQuE0yhLrJteHJQVgRbKdn7qBkd8DoTGjvy8Kw8yN6hlp3uJSEmZIttYvn4pluc94E=
X-Received: by 2002:a05:690c:ed0:b0:6db:cea9:6ed9 with SMTP id
 00721157ae682-6e32219a1f8mr12411127b3.4.1728451783510; Tue, 08 Oct 2024
 22:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
In-Reply-To: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Wed, 9 Oct 2024 13:29:31 +0800
X-Gmail-Original-Message-ID: <CAHirt9g6kCwNarFo8Ah3+3dB=Sp1PJNs3PDJ5yFKBwwbdSqcrw@mail.gmail.com>
Message-ID: <CAHirt9g6kCwNarFo8Ah3+3dB=Sp1PJNs3PDJ5yFKBwwbdSqcrw@mail.gmail.com>
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
To: Alice Ryhl <aliceryhl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:qMiowMDx7tUDIQZnSAMhAA--.48836S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw48Cr1rZw17XF1xCr15Awc_yoWrWr15pa
	9Y9F1DCF4kJr48XrWxJrWfWr1j9w4DXr1Y9F1DG34rA347JrsxZ34vyw4qgayDursrCFWx
	X3WfKFy3Cw1UZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUjU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Mq2tUUUUU==

On Wed, Oct 9, 2024 at 1:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> The KCFI sanitizer stores the CFI tag of a function just before its
> machine code. However, the patchable-function-entry flag can be used to
> introduce additional nop instructions before the machine code, taking up
> the space that normally holds the CFI tag. In this case, a backwards
> offset is applied to the CFI tag to move them out of the way of the nop
> instructions. To ensure that C and Rust agree on the offset used by CFI
> tags, pass the -Zpatchable-function-entry to rustc whenever it is passed
> to the C compiler.
>
> The required rustc version is bumped to 1.81.0 to ensure that the
> -Zpatchable-function-entry flag is available when CFI is used.
>
> Fixes: ca627e636551 ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Note that this fix uses rustc-option which has a pending fix:
> https://lore.kernel.org/all/20241008-rustc-option-bootstrap-v2-1-e6e155b8=
f9f3@google.com/
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
> @@ -143,9 +143,11 @@ CHECKFLAGS +=3D -D__aarch64__
>  ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
>    KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>    CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
> +  KBUILD_RUSTFLAGS +=3D $(call rustc-option,-Zpatchable-function-entry=
=3D4$(comma)2)
>  else ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
>    KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>    CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> +  KBUILD_RUSTFLAGS +=3D $(call rustc-option,-Zpatchable-function-entry=
=3D2)
>  endif
>
>  ifeq ($(CONFIG_KASAN_SW_TAGS), y)
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ae3f80622f4c..f9cef31d1f0e 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -44,6 +44,7 @@ endif
>  ifdef CONFIG_DYNAMIC_FTRACE
>  KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>  CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> +KBUILD_RUSTFLAGS +=3D $(call rustc-option,-Zpatchable-function-entry=3D2=
)

Tested-by: WANG Rui <wangrui@loongson.cn>


>  endif
>
>  ifdef CONFIG_64BIT
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index d469db9f46f4..65d4dcba309a 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -16,8 +16,10 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>         KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>  ifeq ($(CONFIG_RISCV_ISA_C),y)
>         CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4
> +       KBUILD_RUSTFLAGS +=3D $(call rustc-option,-Zpatchable-function-en=
try=3D4)
>  else
>         CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> +       KBUILD_RUSTFLAGS +=3D $(call rustc-option,-Zpatchable-function-en=
try=3D2)
>  endif
>  endif
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 530a382ee0fe..43434b681c3f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1946,7 +1946,7 @@ config RUST
>         depends on !GCC_PLUGIN_RANDSTRUCT
>         depends on !RANDSTRUCT
>         depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> -       depends on !CFI_CLANG || RUSTC_VERSION >=3D 107900 && HAVE_CFI_IC=
ALL_NORMALIZE_INTEGERS
> +       depends on !CFI_CLANG || RUSTC_VERSION >=3D 108100 && HAVE_CFI_IC=
ALL_NORMALIZE_INTEGERS
>         select CFI_ICALL_NORMALIZE_INTEGERS if CFI_CLANG
>         depends on !CALL_PADDING || RUSTC_VERSION >=3D 108100
>         depends on !KASAN_SW_TAGS
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



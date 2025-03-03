Return-Path: <linux-kernel+bounces-541825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30287A4C216
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA31897F65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB7212B31;
	Mon,  3 Mar 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIDHEwe8"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D686347
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008835; cv=none; b=ccHCZA3luPPwjTHV6PtY9eg99+bFDew2LT7v/DEA7rthzhBjAs1ZLywGh5D0pDHzFuzr5E910a/eXuFpjr29Gpwm4qoT3XGFiScQMkE5Gs/+X/yqsvVtX5+sxZqyYERUoEb6LKZwfjS+4OIlx3HzA9ndFeiv0NCOutadRwEd1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008835; c=relaxed/simple;
	bh=0CT7Dtja27wpKuPK0J3uUyCc6Y5dVR1K8M0npmQguYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ecznkx8tm/EGJVF1/IVWs47NoAe/G+2sGM6XuAlOiDgHnRysom27kqdhDrzCZL3GCnvXJX+Shum54mH2xQNcBAPWHsdlkMH5V9xBv6ifWts4OQJ2amSW4A5VEIjvdSez5BqerLo4kYHSqieF8P6P0FkANjoc2Yp7NUSILQQFOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIDHEwe8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390dc0a7605so2412448f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741008831; x=1741613631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98OQ8wvaJ9wtoqY/FnFWTw/2aTBVHaqyurEF1+7THsM=;
        b=jIDHEwe8LddwPcJpPJ14BYSsjhgEx5uDCa9OesQDIbkqjZ0fY9BoInkPGfMTs4Bz7r
         mRkuVQ7KtVP/TMHzZyHocJq1K4UzCoGlx9EH0hLlhY/n5vBzj1suMZlupnRnAeKBF/Xe
         f6OUh4i24JleVcO7L8yTjdRDx1WbLbfsWpvtRwaw1Dej3wx0INwYjWODnMu6GEvFI6D0
         rI7wLFqwLysDFohAwsBhRLhYCNlj8FoODWBupnFpl+xkHQUOwwv+6sipRqlGz9hG4APA
         oDCBcSCyNCkr0G/NNZ6bOi2HYHGiFIBbzzvz6uv01pELaHVn0T8LN5x4h/jd2XvGG9Tg
         mpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008831; x=1741613631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98OQ8wvaJ9wtoqY/FnFWTw/2aTBVHaqyurEF1+7THsM=;
        b=a2v9yvbpGldxUJlHftsdzKSDL9xtVdkVnFfeVZEbCSUEdh/7iwGN1fAC6mSQ2MBftA
         rSUh8kvEziw10YhJzocsHIykKdlNWyxfiojBfZJmHVhow3TYvDi2CzkXX1BZCgp4cgLy
         NKGQbIWmHqoWjIgSTGRVO+fMcPISUGUAdTqFtiPizgM9ByU+8sTuDeq/3SdrrW3tgdR7
         CSjyAaMDtCvgUAMOB9j3hoBRDZvGqcBOTt42qqUUB3k3jcSvBLv2qqylexdhZ1QtwNn1
         UUOGD9565VVRHj4CTgxjlAmqf+5jwtwtFZftpSEOr9ez+8foloxQe376W6PntY5N1jbq
         UK/Q==
X-Gm-Message-State: AOJu0Yxf/AlCDmheIJbKL+Te1K9QG/JCAzYo/1brVHzT6/U94k/Ry4o0
	3mShYX4V/vSrleJZkYX/3yvLTY0VhBHrfK9zqp6Use7VYaAPkxpgNb24EjLgZoHXpubFWfvr6so
	tGnOq2vAtzMTuc8s/+jRONssAYms2hLgWDlV8
X-Gm-Gg: ASbGncvsgy1sm6jPP2uy7/9qMGWHCMlsGO6+Js7qKwlTZ7B5bayf2jaL1fEL7nUojEZ
	Pfhwt7rvGgOKFwy3J/DBNu5Wqf57bS8RpDaMyd50HH6UhPUZ60j6P7qQNSJFiYMxeciGcunj+f/
	VDjuJjPDE1Qs+QNRTOC8Jm8VQFWW6VVmYs1cOzDAHZ6d9opcH94bOs8jfZ
X-Google-Smtp-Source: AGHT+IE8JWpQtarWwp+2hNt/MR6epGuJDDazTrc2gMvmQUZSN/QRsDdQQeOGHqHvxcXWjRP0+QCxyieUoVOMPKqMUFM=
X-Received: by 2002:a05:6000:1f8a:b0:390:fc83:a070 with SMTP id
 ffacd0b85a97d-390fc83a160mr6688529f8f.0.1741008831435; Mon, 03 Mar 2025
 05:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213135759.190006-1-fujita.tomonori@gmail.com> <20250213135759.190006-6-fujita.tomonori@gmail.com>
In-Reply-To: <20250213135759.190006-6-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 14:33:39 +0100
X-Gm-Features: AQ5f1JoT3yLvXrcqi1UY1px9Dirgxz3oFETPYn_JBDKUcmKVulP6_KvtwihScxI
Message-ID: <CAH5fLgjX9hh+QRrKggOKr+6p+UwqHSavzu4UXy9iGNL2wSJXtg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] rust: Add warn_on and warn_on_once
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, tangyouling@loongson.cn, hejinyang@loongson.cn, 
	yangtiezhu@loongson.cn, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:01=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add warn_on and warn_on_once macros. Wrapping the C's WARN_* and BUG_*
> macros doesn't work so this uses the assembly code exported by the C
> side via ARCH_WARN_ASM macro. Like the static branch code, this
> generates the assembly code for rust at compile time by using the C
> preprocessor.
>
> file()! macro doesn't work for the Rust inline assembly in the same
> way as __FILE__ for the C inline assembly. So the code to handle a
> file name is different from the C assembly code (similar to the
> arm64/loongarch assembly).
>
> Similarly, ARCH_WARN_REACHABLE is also used at compile time to
> generate the assembly code; objtool's reachable anotation code. Only
> architectures that use objtool (x86 and loongarch) need it.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/Makefile                                 |   8 ++
>  rust/kernel/.gitignore                        |   2 +
>  rust/kernel/bug.rs                            | 100 ++++++++++++++++++
>  rust/kernel/generated_arch_reachable_asm.rs.S |   7 ++
>  rust/kernel/generated_arch_warn_asm.rs.S      |   7 ++
>  rust/kernel/lib.rs                            |   1 +
>  6 files changed, 125 insertions(+)
>  create mode 100644 rust/kernel/bug.rs
>  create mode 100644 rust/kernel/generated_arch_reachable_asm.rs.S
>  create mode 100644 rust/kernel/generated_arch_warn_asm.rs.S
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 8fcfd60447bc..a295b65c43f3 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -34,6 +34,9 @@ obj-$(CONFIG_RUST_KERNEL_DOCTESTS) +=3D doctests_kernel=
_generated.o
>  obj-$(CONFIG_RUST_KERNEL_DOCTESTS) +=3D doctests_kernel_generated_kunit.=
o
>
>  always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) +=3D kernel/genera=
ted_arch_static_branch_asm.rs
> +ifndef CONFIG_UML
> +always-$(subst y,$(CONFIG_RUST),$(CONFIG_BUG)) +=3D kernel/generated_arc=
h_warn_asm.rs kernel/generated_arch_reachable_asm.rs
> +endif
>
>  # Avoids running `$(RUSTC)` when it may not be available.
>  ifdef CONFIG_RUST
> @@ -481,5 +484,10 @@ $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/build_e=
rror.o \
>  ifdef CONFIG_JUMP_LABEL
>  $(obj)/kernel.o: $(obj)/kernel/generated_arch_static_branch_asm.rs
>  endif
> +ifndef CONFIG_UML
> +ifdef CONFIG_BUG
> +$(obj)/kernel.o: $(obj)/kernel/generated_arch_warn_asm.rs $(obj)/kernel/=
generated_arch_reachable_asm.rs
> +endif
> +endif
>
>  endif # CONFIG_RUST
> diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
> index 6ba39a178f30..f1d7f4225332 100644
> --- a/rust/kernel/.gitignore
> +++ b/rust/kernel/.gitignore
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  /generated_arch_static_branch_asm.rs
> +/generated_arch_warn_asm.rs
> +/generated_arch_reachable_asm.rs
> \ No newline at end of file
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> new file mode 100644
> index 000000000000..7ffd9cb1ad75
> --- /dev/null
> +++ b/rust/kernel/bug.rs
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 FUJITA Tomonori
> +
> +//! Support for BUG_* and WARN_* functionality.
> +//!
> +//! C header: [`include/asm-generic/bug.h`](srctree/include/asm-generic/=
bug.h)
> +
> +#[macro_export]
> +#[doc(hidden)]
> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
> +macro_rules! warn_flags {
> +    ($flags:expr) =3D> {
> +        const FLAGS: u32 =3D $crate::bindings::BUGFLAG_WARNING | $flags;
> +        // SAFETY: Just an FFI call.
> +        #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> +        unsafe {
> +            $crate::asm!(concat!(
> +                "/* {size} */",
> +                ".pushsection .rodata.str1.1, \"aMS\",@progbits, 1\n",
> +                "111:\t .string ", "\"", file!(), "\"\n",
> +                ".popsection\n",

It looks like you're doing this so that you can reference the filename
with "111b", but could you do this instead:

const _FILE: &[u8] =3D file!().as_bytes();
// Plus one for nul-terminator.
static FILE: [u8; 1 + _FILE.len()] =3D {
    let mut bytes =3D [0; 1 + _FILE.len()];
    let mut i =3D 0;
    while i < _FILE.len() {
        bytes[i] =3D _FILE[i];
        i +=3D 1;
    }
    bytes
};

and then use

asm!(
    concat!(
        "/* {size} */",
        include!(concat!(env!("OBJTREE"),
"/rust/kernel/generated_arch_warn_asm.rs")),
        include!(concat!(env!("OBJTREE"),
"/rust/kernel/generated_arch_reachable_asm.rs")));
    file =3D sym FILE,
    line =3D const line!(),
    ...
);

with
::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}",
"{flags}", "{size}")),

That would be a lot simpler to understand than what you are doing.


Alice


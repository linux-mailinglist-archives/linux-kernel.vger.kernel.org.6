Return-Path: <linux-kernel+bounces-441104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1499EC9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFCE1884517
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DAC1EC4C5;
	Wed, 11 Dec 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edyLe1FQ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522C1EC4D5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910523; cv=none; b=GxrEqD6T5YScVNxAzwlAscYQb41evV+6hHYl+43qAsxATKMMPYsdSkLSZQYEpfpFPPlaChGeniZqixwG3r1JBcASwry6iownUIKrwH1cC55by0rnI5vmW+aW158F5cLwxCwY3Mne+oZLx55SpfUEn6ltfQn+FxMkGdWt4RJBEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910523; c=relaxed/simple;
	bh=ZKaxjHmeS7EBCn4efUXAggiPsRojJiDnotoal15ttGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4Igs0G33HasAKkJAX9jICsaoVES+j0nRax47ajloi7+H45wVR6uabBX3QYRhLQKA8P3c1T2XJybEaB17C7w8x/MZS3KaosUl4F4TgUmRgJQcPkuIb53MztnALd4ErBUeeUrmc6TQmDKBI8uovgThazxDtzW5LGBpGN/PjW1kyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edyLe1FQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862a4b8ec2so2720819f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733910519; x=1734515319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPkuDVmQ8I0bPStjeQByqCDXTekXQdwOcRMPaf2EPFY=;
        b=edyLe1FQq3AnZlpeY1UASTnu/MEy3sHd/DrwDQvAssz1EZpCbZa14hxw4nRdAcXMxC
         Jkb05wyAFXkZv4QnDghirz7G8GMQx2A8MTq5xfEoAMTyr8qf5gCJ1X6FbXI5yPtu20B6
         u4BXun0pdqVQZCqtlTjEEFd5ru58Fp//Nhc0GzjK4zPerqWZMjL5P03tMZEbRDbjLT4j
         bkz8F4pwn79yMkho1DgDZC5cd8Hf/t38LhkkpnSY+bktmf25TNFEu19wve4ROf7qTylp
         c2JgGtInPnykvPOtWL+ve3NLA5WFfGPFZsDhDxq25dzNB0ZRKiAyTPKw0f4K9tY2hwmW
         KM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733910519; x=1734515319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPkuDVmQ8I0bPStjeQByqCDXTekXQdwOcRMPaf2EPFY=;
        b=RIOzfTxEV0jDdntSkcpD7rGqh0ARQtMSVlTLhhdBG87qQFPKgU34cdtK4t4QQ0wWYr
         Dj/IeOXRq5cVP67bvMvlVUN/qZq7/jiUk6ZJ4zTG5q/oLiktpsPQglrhymhjSVAgPnnC
         GDdma6wk0apCSY0/l2KENni3nSuEcNvXc1KxDgNDuLMwMGjhJjVWV92eC239/ugmM8j3
         Ov7UZ1hBZdtSJzUeurMkqTPyTNxnQgcgrLIqaMTYAvU8100SHdDfnUrNqGMFKL+nnfPg
         yz59xAcgBtKxVfnerof/Uj6i9p/nRly2Ziu++iPXaqC0Zfj9jElVJNp0w7ZM8k1stk52
         QPgQ==
X-Gm-Message-State: AOJu0YzSOsaafJIlhusfBGWUDeOaoKnmjgp27gqaSrsUjtQrqP2C1mfX
	Wj8Wjkij8nFKU8UU5SEmzF/FoIGf8Qf6LR0+xFVO6c3lkCQb8rv1w2WI8j31iTevhwZgIt1Gboo
	NU1O8VQTvtfIwhw6p6/FTAcJjnl2x1CPmemjQ
X-Gm-Gg: ASbGncswbvu0E0/19dlYpV15pRmxth87ZfmhpDHXCwR4lA8cYS9MXph7vTfS51Fqiw/
	b+CsFw/IE2CoFEYjuYhPepbwH5b0y+Xyw91HwuCxL0yUty1lsE6XZiChDNLESQHG4Mw==
X-Google-Smtp-Source: AGHT+IGgLsoa3jV2scUrxGJs3M3c7OjkCrlHZsyu8jTWcAJIYLV9qXmSt5/Cg8qsliTSfr6/wIq7uJuo1wJlePE++No=
X-Received: by 2002:a05:6000:410f:b0:385:f2a2:50df with SMTP id
 ffacd0b85a97d-3864cea200amr1277675f8f.27.1733910519359; Wed, 11 Dec 2024
 01:48:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210001802.228725-1-fujita.tomonori@gmail.com>
 <20241210001802.228725-6-fujita.tomonori@gmail.com> <CAH5fLgiShKMGo6AYWM-4S8JK+iDA+tUfz9uxkns82g0nLW--NQ@mail.gmail.com>
 <20241211.094054.1429837669366274024.fujita.tomonori@gmail.com>
In-Reply-To: <20241211.094054.1429837669366274024.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 10:48:27 +0100
Message-ID: <CAH5fLgj9rBOrcQa193RpuA708CFK1ojMqhmiNWF7dbyNFPJcJA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] rust: Add warn_on and warn_on_once
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

On Wed, Dec 11, 2024 at 1:41=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Tue, 10 Dec 2024 10:05:07 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Tue, Dec 10, 2024 at 1:19=E2=80=AFAM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> >>
> >> Add warn_on and warn_on_once macros. Wrapping the C's WARN_* and BUG_*
> >> macros doesn't work so this uses the assembly code exported by the C
> >> side via ARCH_WARN_ASM macro. Like the static branch code, this
> >> generates the assembly code for rust dynamically by using the C
> >> preprocessor.
> >>
> >> file()! macro doesn't work for the Rust inline assembly in the same
> >> way as __FILE__ for the C inline assembly. So the code to handle a
> >> file name is different from the C assembly code (similar to the
> >> arm64/loongarch assembly).
> >>
> >> ASM_REACHABLE definition works in the same way to get objtool's
> >> reachable asm code. The architectures which use objtool (x86 and
> >> loongarch) needs it.
> >>
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >
> >> +#[macro_export]
> >> +#[doc(hidden)]
> >> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
> >> +#[cfg(any(target_arch =3D "x86_64", target_arch =3D "riscv64"))]
> >
> >> +#[macro_export]
> >> +#[doc(hidden)]
> >> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
> >> +#[cfg(any(target_arch =3D "aarch64", target_arch =3D "loongarch64"))]
> >
> > What's the reason for this arch-specific code? The file!()/line!()
> > invocations? Could they be passed as an argument to the asm instead so
> > that we don't need target_arch cfgs? I understand that they don't work
> > exactly the same way, but maybe it could still work?
>
> Because of "error: named argument never used" in Rust inline assembly:
>
> All the archs define ARCH_WARN_ASM macro in the same way:
>
> #define ARCH_WARN_ASM(file, line, flags, size)
>
> However, only x86 and risc-v asm code use the size argument. Without
> the cfgs, I'll get the following on arm64/loongarch:
>
> error: named argument never used
>   --> /home/fujita/git/linux-rust/drivers/block/rnull.rs:54:9
>    |
> 54 |         warn_on!(true);
>    |         ^^^^^^^^^^^^^^ named argument never used
>    |
>    =3D help: if this argument is intentionally unused, consider using it =
in an asm comment: `"/* {size} */"`
>    =3D note: this error originates in the macro `$crate::warn_flags` whic=
h comes from the expansion of the macro `warn_on` (in Nightly builds, run w=
ith -Z macro-backtrace for more info)
>
>
> Any way to make the compiler to ignore this?

The error message suggests adding an asm comment. Does that not work?

You could even add the comment unconditionally on the Rust side. It's
not like the comment hurts on the platforms that *do* use the size
parameter.

> >> +#[macro_export]
> >> +#[doc(hidden)]
> >> +#[cfg(all(CONFIG_BUG, CONFIG_UML))]
> >> +macro_rules! warn_flags {
> >> +    ($flags:expr) =3D> {
> >> +        // SAFETY: Just an FFI call.
> >> +        unsafe {
> >> +            $crate::bindings::warn_slowpath_fmt(
> >> +                $crate::c_str!(::core::file!()).as_ptr() as *const ::=
core::ffi::c_char,
> >> +                line!() as i32,
> >> +                $flags as u32,
> >> +                ::core::ptr::null() as *const ::core::ffi::c_char,
> >
> > I wonder if this could be written to utilize Location::caller()
> > instead so that `#[track_caller]` works?
>
> You meant that we could make warn_flags() function instead of macro
> with Location::caller()?
>
> If so, we need to add cfgs to warn_on and warn_on_once because both macro
> and function of warn_flags are necessary?

Well, I'm not sure! I don't know if it's feasible at all, since using
Location::caller() would mean that the file/line is not a compile-time
constant. But if we can, then I think #[track_caller] support would be
nice.

Alice


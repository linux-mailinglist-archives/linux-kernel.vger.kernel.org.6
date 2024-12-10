Return-Path: <linux-kernel+bounces-439133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927B9EAB42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF4828247B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD4231C8E;
	Tue, 10 Dec 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0j4pNGwH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F19230D33
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821522; cv=none; b=ZyOyK3+TfgNh8SitzwUHQY+/8yxl3ewy8OWv5s/36WC5ctmmmaSF8vV/ySqLpPQ/UR/enOKDYMqOiQo8ZCxBYB5gP1gqsuOPegkGzVtHtC89A4jo3kz3tlpFxB/2ugC+IKtqYXYpUq+0D2Zy+NKuro/qDpPXJW24aP9lF2FHa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821522; c=relaxed/simple;
	bh=3NtIMl1DjCiUo8OeDU2MLnM1AfkfRHex0Tmo2GMo9SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iblestn6ojBU1rxsUgYO4DDzluzcp0SnulwLtixp9aKv82y/7gbTI2Actkhb3xauxO2az6n3FEFvhBl+8hpPYWNNcDrVzheidmhtqp/ZWlX7cQ26z9kEvDwgyF61fB+pxhHoiF2/tNzpMMeI0QMhoWcn35s7TMTEjJ73sBjK3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0j4pNGwH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385eed29d17so3648445f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733821519; x=1734426319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep5OKFJpfszekExX4/IRcefemdiT8s+lNUZhAL6lYhw=;
        b=0j4pNGwH+ea6cCJmstueJN4Zf/3m7JjiuSf+umWQ0PyT6FnPqDqi03YBPx3FmuZDS2
         uR/Ng2evyBE7dvBLD89C207AqsI9gJ19EZ0cq7sNgVnNshEqqIlehCJAbyu4YV9l7+99
         jnBa3te3GvTEb7wSJqRJbVJf4++j1ngu1P78rOail6EH1nTkaBShDLDq5y6XwdsckGK8
         QUrD3OixSgxIiQW3UFS8eeHTk2HpHxgRMpYB71RuHm9wnS0RDKF5ypjD8DchU9mZwQ2S
         i+G0p6MsulvhkvRIMlcHmN+RMt3EaYNJBjF7N7tcfuf5Cv0jch9PTvjIEAfgVyZLKqk4
         Ba9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821519; x=1734426319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ep5OKFJpfszekExX4/IRcefemdiT8s+lNUZhAL6lYhw=;
        b=BYblOFWGhQk7Oc8Aj53THMGKy2BMjMHV6jp17EM0FjOLdP0UXp3TfCUqytQKWLXhBr
         aCpTyaisyK1ZpUI3mcM76PzdhVzTjy/BnpnnaZJb1dMuuWXU6oAoqZLRojEK4SO+gdZo
         aevZh1QUl9Xvp3RZN6HSi9DWZ9INGZrwTEQe8jyzJ5Z6HLs7KGbpPPT5WETXcjebjl2m
         Esk/+Qkjk0FEgA6j7R9XeWSLibxIZI4pWfQJooiva5ltHLRJc+7DZZ564i04A4PrRWs2
         ncVw3ioIrb2rAaZ/XPZQCPQjW1oWySORAKIT5vQsX+k6riewyg6n3s9eTmgONdmA4cni
         dgnw==
X-Gm-Message-State: AOJu0Yx3owJejC15/80ofH0aiCQXb7yuuJnaDKjvZOCkJFdeev+xgJKr
	vezRbQ3cCNEWCCVXKbSboo5mo+AQc+GjMK4TYetiKyMU+lO9Exu60NdeHI6IR+LEuvHbr8V2DXA
	mzBcHk7GGUwynRX11+4FUpUew6ivWlOh2bxRG
X-Gm-Gg: ASbGnctrur0k/9GWf9F2Y+t5/dQavShyzsXttier881/GdTLdlFD6y/ntcn/dhwhSin
	TnCKMoXy+lNZKlKgxKeB68PjyRL838+ZbwHaGaHKOOWMWMLgVWs18ZqFviH24d1723w==
X-Google-Smtp-Source: AGHT+IGIVjgo6xFN35HYB1TgvILbI9Al6TSHNEWYp3ypNeyi+o9RjYaXrxzLsc97Z2zDVdAJ5OXIaoQOhG2vsZwboeY=
X-Received: by 2002:a05:6000:156f:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-3862b33e3cemr11655971f8f.5.1733821519043; Tue, 10 Dec 2024
 01:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210001802.228725-1-fujita.tomonori@gmail.com> <20241210001802.228725-6-fujita.tomonori@gmail.com>
In-Reply-To: <20241210001802.228725-6-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 10 Dec 2024 10:05:07 +0100
Message-ID: <CAH5fLgiShKMGo6AYWM-4S8JK+iDA+tUfz9uxkns82g0nLW--NQ@mail.gmail.com>
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

On Tue, Dec 10, 2024 at 1:19=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add warn_on and warn_on_once macros. Wrapping the C's WARN_* and BUG_*
> macros doesn't work so this uses the assembly code exported by the C
> side via ARCH_WARN_ASM macro. Like the static branch code, this
> generates the assembly code for rust dynamically by using the C
> preprocessor.
>
> file()! macro doesn't work for the Rust inline assembly in the same
> way as __FILE__ for the C inline assembly. So the code to handle a
> file name is different from the C assembly code (similar to the
> arm64/loongarch assembly).
>
> ASM_REACHABLE definition works in the same way to get objtool's
> reachable asm code. The architectures which use objtool (x86 and
> loongarch) needs it.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

> +#[macro_export]
> +#[doc(hidden)]
> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
> +#[cfg(any(target_arch =3D "x86_64", target_arch =3D "riscv64"))]

> +#[macro_export]
> +#[doc(hidden)]
> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
> +#[cfg(any(target_arch =3D "aarch64", target_arch =3D "loongarch64"))]

What's the reason for this arch-specific code? The file!()/line!()
invocations? Could they be passed as an argument to the asm instead so
that we don't need target_arch cfgs? I understand that they don't work
exactly the same way, but maybe it could still work?

> +#[macro_export]
> +#[doc(hidden)]
> +#[cfg(all(CONFIG_BUG, CONFIG_UML))]
> +macro_rules! warn_flags {
> +    ($flags:expr) =3D> {
> +        // SAFETY: Just an FFI call.
> +        unsafe {
> +            $crate::bindings::warn_slowpath_fmt(
> +                $crate::c_str!(::core::file!()).as_ptr() as *const ::cor=
e::ffi::c_char,
> +                line!() as i32,
> +                $flags as u32,
> +                ::core::ptr::null() as *const ::core::ffi::c_char,

I wonder if this could be written to utilize Location::caller()
instead so that `#[track_caller]` works?

Alice


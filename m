Return-Path: <linux-kernel+bounces-298915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D455F95CD49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608EF1F22A40
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23037186612;
	Fri, 23 Aug 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTbbNuKL"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8F18660F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418597; cv=none; b=ikx3yDnqDbQMyobBMIzTjOHTcHmGLche1pKUCbjNyP4FvPxVnKesx4cFCKa9ItttFveMQd0rBBAbPxN/TAeH3qoqeEdw++FZIHlxzMc/MCUxLhu95l8Y6PWcCSgBnfCLjXTbcNRHKfMXofkRg7C9yoxoDSVMrfbZJLvEINvtdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418597; c=relaxed/simple;
	bh=2inkt1HSSs8yK7Ur07Zj94tWlD+ohh7t2EGYKUEOAik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPXQwrI1jPXGaa/BpvMP/Ka2KXcHrMi9HNh/5mCeeDKF3hXFP1nMmBtvE5H+ZPFNGfBT3tKJhPOzXCAn4C5ps6O55pqIrlpBZ3iBgmhjemg2u7M4XvvoX3/mYN06YxLJi1P3Cq9Wo6iuyT66wm7MeDTsWV+EQ0PHs1TpNWaid6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTbbNuKL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3717ff2358eso1016642f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724418594; x=1725023394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwoowZQ8l1stDEvT19fP7caRf72q5eyqM6wnhXRpiRY=;
        b=dTbbNuKLcEyl4HtUqNncwrEb0B2l8Z9XUC1zMtqG6OeTPQQX4/so3f0nwR0z5C9x2m
         6MYhU0be033xeN/SiKjqYIuHuTb6G11xtyyRujy0Aswc2k+HxNW3H7rfESLaQGWDE9O9
         SnxbglKO4gNjaUudzVky9deE+5gSdXYfOa1hYCvWR8yVkE342WAy9cQ+8qujNr/Y1MOA
         K/9J/YjZCBMG7gvGTFEGAGgNBQkAuxFhzXlS0x2IydvQRX8NZC7J6zOzlEADKJlGtk59
         eFCg8aH/8zukWb2DMMZR4A/VhUdiSs+hRBT/22sYHBgZOcvXae3RdJz0PKghCAvBA6Zj
         QgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418594; x=1725023394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwoowZQ8l1stDEvT19fP7caRf72q5eyqM6wnhXRpiRY=;
        b=DoU51Kxh/L6hWGTSxiWjs8BSBN9UONesj7moTECBiwrjIw2jnYNEKvSDflvcZoZ5iu
         O+myhHNFgNJpEjRYYGoBqOceRoOr10oEwqP8BFFdt+RI3y+1mKbKBv1suj45lYdSCGuG
         tdQMZlqcUtWsO0tymqeK9mGGf0fABskmLUwKlA7lA0/NszhQ+JISPE7GhLAnUXXS7o2G
         Bz/3IqLGea9+Cv6Aa3qXEg5mjBjBDhoSVUfRBY0kDIk7pX01K4jOXlwlUX3CjFXdeeHM
         WGPkehGY5TMyHLCjl8KZd3fj3KDwjuLDTtIspEuo7qtftegPkDEjzNBhYJFadcOAHohJ
         DFJg==
X-Forwarded-Encrypted: i=1; AJvYcCWFcwdhjQ+W8jY5Vt6zYGD851uiJat1FZhtMvxEVSjeYsVDVWHgoTMXN3YL3uJpy/PJphu3fUJKHSVlvQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljuTo5NbPio5zLL0j51Ff8tgGC7uYEq8Xpg9w9vdrHIMDReAu
	8lg+Jc3ZkYsm9PVVb08QS819hTr7ZKAj5TaPGtZyvz7d4OFp4UJHTzt3mq8bmdkAB7+1rt6ZKPq
	Qlfn86Ax9Ucz4ltF4Lfq9KM+mHuA9SmHEmBbA
X-Google-Smtp-Source: AGHT+IHSoz5W9toLLADJUc7iP/4LDGyEBX8p4Wby0q53+YdJDBKyN8rx0Hivs+lO7ItAXkZ5QjAK4OX3+0uD3SrYGL8=
X-Received: by 2002:a5d:4a08:0:b0:371:8bc4:4f with SMTP id ffacd0b85a97d-373118e2fc6mr1266378f8f.51.1724418593573;
 Fri, 23 Aug 2024 06:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-shadow-call-stack-v5-1-26dccb829154@google.com>
 <20240820143503.GD28338@willie-the-truck> <CAH5fLggN+A2RawC-cpmSUHxYm=xz=1EDpMUv5C803hj37re1qA@mail.gmail.com>
 <20240823122423.GB32110@willie-the-truck> <CAH5fLgh6ywHeFSwbnaOu-QYrt_Jytv_y3zb1QbJzK-w4kQ617w@mail.gmail.com>
 <20240823125739.GA32156@willie-the-truck>
In-Reply-To: <20240823125739.GA32156@willie-the-truck>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 23 Aug 2024 15:09:40 +0200
Message-ID: <CAH5fLgiCr3hOEX1yaqy66OMsbPTtEhA4FCmRiw20zY64vYKHPw@mail.gmail.com>
Subject: Re: [PATCH v5] rust: support for shadow call stack sanitizer
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 2:57=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Aug 23, 2024 at 02:38:20PM +0200, Alice Ryhl wrote:
> > On Fri, Aug 23, 2024 at 2:24=E2=80=AFPM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Tue, Aug 20, 2024 at 05:13:58PM +0200, Alice Ryhl wrote:
> > > > On Tue, Aug 20, 2024 at 4:35=E2=80=AFPM Will Deacon <will@kernel.or=
g> wrote:
> > > > > On Tue, Aug 06, 2024 at 10:01:44AM +0000, Alice Ryhl wrote:
> > > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > > index fe76c5d0a72e..d857f6f90885 100644
> > > > > > --- a/init/Kconfig
> > > > > > +++ b/init/Kconfig
> > > > > > @@ -1909,7 +1909,7 @@ config RUST
> > > > > >       depends on !MODVERSIONS
> > > > > >       depends on !GCC_PLUGINS
> > > > > >       depends on !RANDSTRUCT
> > > > > > -     depends on !SHADOW_CALL_STACK
> > > > > > +     depends on !SHADOW_CALL_STACK || RUSTC_VERSION >=3D 10800=
0 && UNWIND_PATCH_PAC_INTO_SCS
> > > > >
> > > > > Sorry, I didn't spot this in v4, but since UNWIND_PATCH_PAC_INTO_=
SCS is
> > > > > specific to arm64 and the only other architecture selecting
> > > > > ARCH_SUPPORTS_SHADOW_CALL_STACK is riscv, I can't help but feel i=
t would
> > > > > be cleaner to move this logic into the arch code selecting HAVE_R=
UST.
> > > > >
> > > > > That is, it's up to the architecture to make sure that it has wha=
tever
> > > > > it needs for SCS to work with Rust if it claims to support Rust.
> > > > >
> > > > > What do you think?
> > > >
> > > > The `select RUST if ...` is going to get really complicated if we
> > > > apply that rule in general. Having options here allows us to split
> > > > them across several `depends on` clauses. I'm not sure it will even
> > > > work, I had issues with cyclic Kconfig errors previously. I also do=
n't
> > > > think it's unreasonable for the architecture to say it supports bot=
h
> > > > options when it really does support both; they are just mutually
> > > > exclusive. I also think there is value in having all of the options
> > > > that Rust doesn't work with in one place.
> > >
> > > I'm not sure I follow why this will get really complicated. Isn't it =
as
> > > straightforward as the diff below, or did I miss something?
> >
> > Hmm. I tried this but I wasn't able to enable Rust with this setup.
> > Even though the deps of RUSTC_SUPPORTS_ARM64 are ok, it doesn't seem
> > to be enabled and I can't find it in menuconfig. I think we need to
> > have a `select RUSTC_SUPPORTS_ARM64` somewhere.
>
> Sorry, yes, my diff was a little half-arsed:
>
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index a2f8ff354ca6..2f5702cb9dac 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -231,7 +231,7 @@ config ARM64
> > >         select HAVE_FUNCTION_ARG_ACCESS_API
> > >         select MMU_GATHER_RCU_TABLE_FREE
> > >         select HAVE_RSEQ
> > > -       select HAVE_RUST if CPU_LITTLE_ENDIAN
> > > +       select HAVE_RUST if RUSTC_SUPPORTS_ARM64
> > >         select HAVE_STACKPROTECTOR
> > >         select HAVE_SYSCALL_TRACEPOINTS
> > >         select HAVE_KPROBES
> > > @@ -265,6 +265,11 @@ config ARM64
> > >         help
> > >           ARM 64-bit (AArch64) Linux support.
> > >
> > > +config RUSTC_SUPPORTS_ARM64
> > > +       bool
>
> This line ^^^ should be 'def_bool y'.

Ah, I see, I guess I learned something today. It also seems to work if
I add `default y`.

I can change it if you think this is better. I still think there's
some value in having everything in one place, but it's not a big deal.
Either way, it should be temporary for a few kernel releases as we'll
eventually only support compiler versions where this works.

Alice


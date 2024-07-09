Return-Path: <linux-kernel+bounces-245563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E892B469
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADA6B21B57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5C155398;
	Tue,  9 Jul 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yyb5N2ir"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52715575C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518704; cv=none; b=CAnSy+Y1TZQtHbaFaft5PZCLq+oPVGLL46DczrjsdtNuWFgXoAW97rOavhM59fohUtzDtQCooiqfJ6C0Eg5/x6qLBxor0UWiYMj3Eux4KWtqZif3zOTmHNmzuT06NR0BRZOE/9dQtMGnPNfODXJshuzv1rFAEW7wwKClPmGcmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518704; c=relaxed/simple;
	bh=4XuEKNFSFuGP1kN6L/yXHwpYHIvQcGA6Ng+fKkoMgZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IL1AzIUKgInXNfStbz4iDaK7Hps3so7piQjnH+dgH797pfW8PAg4ROrWDqyzIj+EjM8T6kXXTzBB9Nxgn+2XkRNqmQJCFPvB9rycwgO+Sfi3vaxjEE1f1YBQD/dANaUFOqVY9+8gJVYLw97DszVBmTLv4HTTcYO4Ic+h8q+fcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yyb5N2ir; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f06861ae6so3202126f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720518701; x=1721123501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX06ye1J6PdkCSj3zoT0ZMNvrT9EtWcEE/YdxpESa/0=;
        b=yyb5N2irZdWL3EoE/fIxaNNT+g4AhZsV/eqyI6APYMd0IowCK/M66I8riz3A8WhD+M
         4UrQuId8DH2+iFO8yDPIVbtMD8HPuL0CsssOgj5xTGDZv622hrZ+s/PmVakOChIK2Akc
         wOf/6KACM1FexWKMRxBZoWgJ6zewOf6IbW8GFuJLAuKtKK/7c2xF7sENofscC8/REOQ7
         uqgNF8OiX5qaTxkqYWIQZDFQVxJFSXQuccBiBtNK2lLnr4nDz25Vhc1tTyXOm/RbwSfL
         /rbphmMJqNuFa01G+LYr2QntPPTB66B8p5SI/hrKFindXOXoxNqIJsouQP4/IInMd0Yl
         7eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518701; x=1721123501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX06ye1J6PdkCSj3zoT0ZMNvrT9EtWcEE/YdxpESa/0=;
        b=F+I9j/QAQfI+sixg5AFu22aPglIWIiCUGLAsrEtaaaEw4n4s+yugzty258cLEn58It
         zr3nwSQJbvLn/ZyDvNyynvrNtnY6EC9ROQG9e0tJD8UEfqY0HbjggWJGJbzG4E5nLLI2
         bUVpJziPu4COggPVh3VNC6qVgOS7hU5L+aKJ4z/MEwA2zWaIG54qQ5CAssx1MhBrw5oK
         kn/Iz/pFWl3c5xXbcAiPDv4Ogp8NhGxA0WOzA6dmbeX2m+0zPBqdtcIuc8omq/8Lnn/a
         KHrEZjcmlz7XRrOqJiz0hzYGLxm0o+AeGV2srIliPwpHWcbO4hyvGWQAtty4rfIuR/ky
         i3LA==
X-Forwarded-Encrypted: i=1; AJvYcCUOkC7LhjEBY5BHQ3dbCsaj81HgfDLxFRv8RgDVm21br8k04wSppnpYd9NeaFTNT1Fn3b4Fo3kczyOd0WmMBllZhbB5rr6z9xW2U2Qv
X-Gm-Message-State: AOJu0YwMpTcZLTtaRNgxqlNiMbXqHDT9xIjEy4lhOenNYaOcNcYDo26P
	YkPU0Lk7OlufqIhANPVY8sMYdPQGapEHHi51E362G8eTE52bDlCMb/g+41n2f632SJH+JjrWg5G
	8m6ys77oznt/zUhnM8RDxPoPERN6iMXV4aFJS
X-Google-Smtp-Source: AGHT+IEEa+ZOMuIVJB/R8kPUjfwxKMD1OHTTc3Vy0AHpNhSOsKMUU0Dz5ToEd38VyMlsqy8uUowwm6nPboz2Ks1ZR7c=
X-Received: by 2002:a5d:6da9:0:b0:367:88c2:bcfc with SMTP id
 ffacd0b85a97d-367cea46beamr1873409f8f.1.1720518701008; Tue, 09 Jul 2024
 02:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-shadow-call-stack-v3-0-d11c7a6ebe30@google.com>
 <20240704-shadow-call-stack-v3-2-d11c7a6ebe30@google.com> <20240704-unless-cache-8a971c244348@spud>
In-Reply-To: <20240704-unless-cache-8a971c244348@spud>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 9 Jul 2024 11:51:28 +0200
Message-ID: <CAH5fLgh850oUinnGS=1A47Es11qc9OL+Kw_6d-_Lvx7jcQmj=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add flags for shadow call stack sanitizer
To: Conor Dooley <conor@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:17=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Thu, Jul 04, 2024 at 03:07:58PM +0000, Alice Ryhl wrote:
> > As of rustc 1.80.0, the Rust compiler supports the -Zfixed-x18 flag, so
> > we can now use Rust with the shadow call stack sanitizer.
> >
> > On older versions of Rust, it is possible to use shadow call stack by
> > passing -Ctarget-feature=3D+reserve-x18 instead of -Zfixed-x18. However=
,
> > this flag emits a warning, so this patch does not add support for that.
> >
> > Currently, the compiler thinks that the aarch64-unknown-none target
> > doesn't support -Zsanitizer=3Dshadow-call-stack, so the build will fail=
 if
> > you enable shadow call stack in non-dynamic mode. See [2] for the
> > feature request to add this. Kconfig is not configured to reject this
> > configuration because that leads to cyclic Kconfig rules.
> >
> > Link: https://github.com/rust-lang/rust/issues/121972 [1]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  Makefile            | 1 +
> >  arch/Kconfig        | 2 +-
> >  arch/arm64/Makefile | 3 +++
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c11a10c8e710..4ae741601a1c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -945,6 +945,7 @@ ifdef CONFIG_SHADOW_CALL_STACK
> >  ifndef CONFIG_DYNAMIC_SCS
> >  CC_FLAGS_SCS :=3D -fsanitize=3Dshadow-call-stack
> >  KBUILD_CFLAGS        +=3D $(CC_FLAGS_SCS)
> > +KBUILD_RUSTFLAGS +=3D -Zsanitizer=3Dshadow-call-stack
> >  endif
> >  export CC_FLAGS_SCS
> >  endif
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 238448a9cb71..5a6e296df5e6 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -690,7 +690,7 @@ config SHADOW_CALL_STACK
> >       bool "Shadow Call Stack"
> >       depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> >       depends on DYNAMIC_FTRACE_WITH_ARGS || DYNAMIC_FTRACE_WITH_REGS |=
| !FUNCTION_GRAPH_TRACER
> > -     depends on !RUST
> > +     depends on !RUST || RUSTC_VERSION >=3D 108000
> >       depends on MMU
> >       help
> >         This option enables the compiler's Shadow Call Stack, which
>
> For these security related options, like CFI_CLANG or RANDSTRUCT, I'm
> inclined to say that RUST is actually what should grow the depends on.
> That way it'll be RUST that gets silently disabled in configs when patch
> 1 gets backported (where it is mostly useless anyway) rather than SCS
> nor will it disable SCS when someone enables RUST in their config,
> instead it'd be a conscious choice.

Okay, I'll make that change. I suspect this will also break the
Kconfig cycle mentioned in the commit message. Thanks for the
suggestion!

Alice


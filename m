Return-Path: <linux-kernel+bounces-240740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1609C9271EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AC1285750
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16BF1A4F01;
	Thu,  4 Jul 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3HO8WPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715A1A4F02;
	Thu,  4 Jul 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082526; cv=none; b=TRggJxUEFY2quByRX6jz6hEZYATLcUKmdYH4v0B6yKZVs/vPecbmp0LuwVNAf0nPiioFnQSX5Vh2+Xw0itu+Gskw02zegr78XuT0CUM3IbTvamy5ehNnY3bxAbJSzvwLMH3xDtQ5hY8D3QivVq0qsJxUO789Ko3U6Y+XLHf4jYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082526; c=relaxed/simple;
	bh=xUt8CirmU8C2wVZHTK7sroF3X6X7fJ6AgIjUXBM+YXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMYkMdmfu06VEHVpHvr5077pBQdUJkyXcWTmovFiQ+UGC5g8MvjysCdzGNpTOJ5nBSvAoZ85pnyPWOWtkm4lOZEH4JiWiC7SD7wWdGCnocHLfBc4uLM6txdtZI+BjFDudLOirU7tkSurOBFKgtrO2oB2EXiwy8PLjkSRIyAefB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3HO8WPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B870EC4AF0C;
	Thu,  4 Jul 2024 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720082525;
	bh=xUt8CirmU8C2wVZHTK7sroF3X6X7fJ6AgIjUXBM+YXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W3HO8WPyIaqEmf52CcARvR4eVtT5c6R/CgXTr3gKozbGSrxX4MSEr2wE6bS2Z+iof
	 GetjF4HOv8VR3FG7K8ZuJQIZ6mvS+Wi2p5JCoipuZTtnVTH2aRSx4dBbdpddVDd/wD
	 IWwwjr/tS9/KkRFw1NASGWiV+kldvXvRGNmhAApg7JiMWG9nTd7VJFBkQjMhRLOzKp
	 SAEs2+ugWX1MdcT8Vj3KyQZSZLBOtB22/Exh4ZZNZ/l3ZnQevTLnbte4FWwNEmyJ4Z
	 xjL3MS4HF1ZqfBANPwvu/69ulw7M7fAOxyW8kcpjXMfA0YwHkRM/ft/PEEn0P8Yf9G
	 w/4O1XJEvpeXA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso1025941fa.1;
        Thu, 04 Jul 2024 01:42:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjOFRpdy/IHfHzcixFbrFH3CEHHX9kmxZE6z7g6IxRG+pnkgX1E84lkm9b6TY6ylqJeuIzwJhlWonZGInX/cjEv67OdIkLhF70U4t8npxrYlnZzcrbT3VJ+VQOX5ezWCAWUnGOHq3bzUmMVnA=
X-Gm-Message-State: AOJu0YxX0Ceee/0gy640batDXf9OKJuw4RKwO7zWuf7KYfQFLEizKV0d
	lprCEDg/lh1gRH69X8tDp6lQEfV4kxswsG2Gbge//EyFYMFacc30niXqirK7JlUm3Xm/oQJRuiQ
	UsvmL5+p1N074XFijD/kH28u8hc4=
X-Google-Smtp-Source: AGHT+IGFdqhNk1lwlbyHm531/dWpSieXjv7RhHDfv/p3TlZwKHxkaUFlddN+XB+6J8QmHbutNQn1m9BjzHxXk71VBhs=
X-Received: by 2002:a2e:a26e:0:b0:2ee:4e67:85e9 with SMTP id
 38308e7fff4ca-2ee8edf2137mr4469991fa.47.1720082524004; Thu, 04 Jul 2024
 01:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com> <CAH5fLgj3z4TMnXz=zygLW9Fku6N6nX0jyw2b0uvg=Kat-d-o2Q@mail.gmail.com>
In-Reply-To: <CAH5fLgj3z4TMnXz=zygLW9Fku6N6nX0jyw2b0uvg=Kat-d-o2Q@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Jul 2024 10:41:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHpaOnFTDiLUZEUcq-SzwyXnRgbYokrAnrZc_0YOH31A@mail.gmail.com>
Message-ID: <CAMj1kXEHpaOnFTDiLUZEUcq-SzwyXnRgbYokrAnrZc_0YOH31A@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Sven Van Asbroeck <thesven73@gmail.com>, Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 at 10:20, Alice Ryhl <aliceryhl@google.com> wrote:
>
> On Mon, Jun 17, 2024 at 6:04=E2=80=AFPM Christian Schrefl
> <chrisi.schrefl@gmail.com> wrote:
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 71afdd98ddf2..9cc10e32e8be 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -150,6 +150,7 @@ endif
> >  KBUILD_CPPFLAGS        +=3D$(cpp-y)
> >  KBUILD_CFLAGS  +=3D$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(c=
all cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -mso=
ft-float -Uarm
> >  KBUILD_AFLAGS  +=3D$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y)=
 -include asm/unified.h -msoft-float
> > +KBUILD_RUSTFLAGS +=3D --target=3Darm-unknown-linux-gnueabi
>
> On arm64 we use a target called aarch64-unknown-none. Should you also
> be using arm-unknown-none? Or maybe the arm64 target should be changed
> to aarch64-unknown-linux-gnueabi?
>

Neither. EABI is highly specific to 32-bit ARM, no point in trying to
align this between architectures.


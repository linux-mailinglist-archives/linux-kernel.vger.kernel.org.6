Return-Path: <linux-kernel+bounces-525932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FCA3F778
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7086171E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF920D4E4;
	Fri, 21 Feb 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXHfLnCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3797080D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148738; cv=none; b=JKjX3XYZ5VJsZqtMxGIBfqH60xMBMCKA3DSNp6f5ys7IRIhVH3KgCNZ7k1D5X6GYbu0+EH7FMmitylhzETCJRq2Q3psvtMHQTRaONvfD6H10nY429AHKxzt50tSurk4ds9IE6pbwsYdksCj2IitpWqH5RRi3+qw0D5dd6Pq53qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148738; c=relaxed/simple;
	bh=wD8H04nyxo1UfAIg5zJDnOMhSj5Iwgq58P8M+Xj//7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcRxoUNTJe1XWp7mtoXJynBbni9PPeSDr7M8FxzoK4aw+1DhnXnvY83IvcaGkcPxSCExRWhjdvvjFqVl3wHhr7t5oagn5BWTC6pHm3ii+1mCFJInbMbk7bj85TlPLzVzcEQ2BMbUlEcR+mDgUnOZjAejKPFQrDcXvMgbNYwgySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXHfLnCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058C9C4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740148738;
	bh=wD8H04nyxo1UfAIg5zJDnOMhSj5Iwgq58P8M+Xj//7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sXHfLnCv00Cs4JS9CnUbSy8+/gr523ylt9Tnwm/7rqF09o0ttZu+8k946Xa379uEV
	 MXe7+SbFyImKgyJOEj5HDBh2RZS0N7GaFM5cxCGu4gKeuVVIRRAST6DkL2y1f/4NKV
	 r8H+52OPih1RWq2wuxoiFlTdfH0hBtO1uAGodb2U8RKD8NNmGuPFPWr2Yo6rAEEsyt
	 leDVcuEJe9uD9LffdecqGo+ZfLiZMFt69Or27FSk2URmJ806AdhSxZCnHvAlVRXS3g
	 JBbMpZy/lQ/lD3GmXFjGQmBL5rvBObXt5ij3rXerCguNY4VZP3XBTi6K0o3BNj8oAw
	 DKMkb6FMCvcNg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54605bfcc72so3725044e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:38:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXk0QUli2rZxfE3LTDju7xmZsgFsGouRL05jIjrI08ep9iHiLN9F4CSFFAxZnxqRA8StaB06Hd7O2OOBr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKMJmfrQVF5Mqls5khuB6QcmH8QoTi12yhgu5caZdxF5b3xfL
	GN+DCq0Omvu/dgBdQXUbpJuNXj/W+MOJDVZiwCLGnpo1s56ajUgAgR5Pi3AVzLASNYOmTlp5cgz
	dG7AMkKBjAvZgUO14Jcd29nE2H8Y=
X-Google-Smtp-Source: AGHT+IHuiI1BWuhEQY3osJkm6u8PobA8cs5cZHsJhUXyEitmSbAHM+o94n3IrxuTc5IAZc3lHwqD9exRFMNFc6yPwJ4=
X-Received: by 2002:a05:6512:2353:b0:545:240:55ba with SMTP id
 2adb3069b0e04-54838cd2edcmr1039200e87.26.1740148736236; Fri, 21 Feb 2025
 06:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
 <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
 <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com>
 <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com> <CAFULd4YuL9DCOs23Ev+iXooirLfKT3O_9poSUM7JeW_dO34o9A@mail.gmail.com>
In-Reply-To: <CAFULd4YuL9DCOs23Ev+iXooirLfKT3O_9poSUM7JeW_dO34o9A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Feb 2025 15:38:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG_zKei335-CqXwNi=+AkqtQt6xmoVw+qD1XzW7q-aPtA@mail.gmail.com>
X-Gm-Features: AWEUYZmp3f8FXbOA8urBhoLKNBhV3SA-KZWCYMZbhh4RQY_MZV4MXKkUUr7-Fnk
Message-ID: <CAMj1kXG_zKei335-CqXwNi=+AkqtQt6xmoVw+qD1XzW7q-aPtA@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 15:33, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Fri, Feb 21, 2025 at 3:13=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
>
> > > > I got a warning from the relocs tool, but not a hard error.  What
> > > > compiler/linker are you using?
> > > >
> > > > Does the attached patch build in your configuration?
> > >
> > > Ah, the attached patch is similar to my previous approach, where the
> > > build system *warned* on an offset (the patch was abandoned due to
> > > Ard's request to put stack_canary to the *beginning* of struct
> > > pcpu_hot, and this allowed for a simplified patch).
> > >
> > > The attached patch builds for me without warning/error for both, SMP
> > > and !SMP build.
> > >
> >
> > Did you try building modules too?
>
> make -j 24 olddefconfig prepare modules_prepare bzImage modules
>
> for defconfig, SMP and !SMP.
>

OK.

I think I prefer Brian's approach - the only nit is that the placement
of stack_canary creates a padding hole in struct pcpu_hot. However,
that does not actually matter until we run out of space so I think it
is fine as is.


Return-Path: <linux-kernel+bounces-359191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2D998881
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D355C1C234D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A281CB31B;
	Thu, 10 Oct 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFmkCOIA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D51C9DCB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568703; cv=none; b=bADGWLEHQqi72qm0fPzvB+i0coul7JSZscoFzupjPEjPhO2xnaXDiyfjTNDBvS8OGL/TV+tzcYpV84p5qVwd7rWuNCDcd78CXMdhv5LMJHB+YLKL1UpL4lfRv5pggzysYSeMBHJ/unkckotE+Js9bXZ/iRZQCd3UOJ8Ac4tsiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568703; c=relaxed/simple;
	bh=AO4evWtYc5vkoEupF0sX/FiVxN2xJ3m5UkrfF9YeDio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pggSqxy9wB6GhwpkrquSHye4XaThQAvYqSs9V8ip2qXA/A3eyPvX8wQis9vuIP1WGZIyqXqpGhAkqO2Pj3hUK9/uClUzAE4iIFIMI1WToZHXavkgL0gL3VlJj2R3A5eGInG9ksazDxWw4rzrOGNTPtJVg/FLduPQoaQRQjoqbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFmkCOIA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4ba20075so470188f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728568700; x=1729173500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pjStY+T2GIcJPDPOuqwTVy+1tGlWush7jCg2DdpNaE=;
        b=EFmkCOIAx/Ijl2kYeahsq/oIwBLJF4AhBKHO0MyM4nXJy98beCylxP4Bvi2iask96Q
         geBjrJe8toTz/jmJL1tAjg4avjAQROKWeAmWoCj/53Y+w1N2GR0ndu8b8Fkxoc20mHug
         vabxOsLHG3SeND6LDTppNsYRDwh57fh8W0v97/a/j37GIEiXBg4LIDpocrtgekh3nZwp
         e0lvwdJJ6YwUw0Ppcr5bKsGeQySMJ9ToxHR/RNgsqLo+qQXerOosNnOI2tmxuH0JdCu3
         DEE2RNYg2FcV9xLab16+dXni1ps6IXnorxYSmMyTI3VIlsrWmjwseYVA74tOFEDGPil2
         RCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568700; x=1729173500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pjStY+T2GIcJPDPOuqwTVy+1tGlWush7jCg2DdpNaE=;
        b=pEUeALXKhihVGgEp4VrKjeLQO3fPzThC4QaBIGsZHaTk7FVyzYZYFUA/FB/UEkZ9aU
         Hl8RyF3R7VLfAuHNAuoJlwMcFc52irlDxQqk60Sv+PwKmNh8NN8s9HjHQdVD3uVJJLes
         9XDxmVub9SgLf/471AquqXh7MS0auc4YXyzY6DbH9/Tj/QNAlY0FzJZKS7tTmVWKckOd
         V7trRzuSrWCH3bto8SQ59bVg80ugVzpeRu0GfIxnVUn3/GTOvoUo702QCqj0P8Kw57O4
         i/ImDz0MskB7dXz45fGN69e9Uy2FBr0ZvTJ25tVXcoED6H/NhgOy3SedGXpko9EQDzBC
         Vc5g==
X-Forwarded-Encrypted: i=1; AJvYcCUOyfgt+wIiGUSB5V7ac2E0hihaqUrFbFEyXnixa4xf35NqlWOMc8WgX7JdGBD/l8arQBrHX2Epe5ywki8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8kHF8pG9J0KRJ/qhWx0wUp7oXu1hyDRVSD31i2IRUpcoxnjB
	p+qHxiMHrlePrke/xRpMMZKOXZyZ0ts0uKQEZ2MWQpk56QRQsUvLcqg0pTidxJT9u5y99Ye5M0l
	xzyMCTiCm1Lj22tnXPN2ZlOo/tNEvy3LBubZA
X-Google-Smtp-Source: AGHT+IFWpwAmKmvG/Ff2Ajqul4AodwdBUoP4pTOHuSxB2d2PHoQyQE/W59Z7JWA/1KNkRgbg6wNTn2QKiyE+HgfMZgI=
X-Received: by 2002:a5d:4806:0:b0:37c:d1b6:a261 with SMTP id
 ffacd0b85a97d-37d3aae6ea3mr4103963f8f.59.1728568700337; Thu, 10 Oct 2024
 06:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
 <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me> <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
 <Zwfcwg23tfrKIyrq@boqun-archlinux>
In-Reply-To: <Zwfcwg23tfrKIyrq@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Oct 2024 15:58:07 +0200
Message-ID: <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: add global lock support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:55=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
> [...]
> > > > +#[macro_export]
> > > > +macro_rules! global_lock {
> > > > +    {
> > > > +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident=
<$valuety:ty> =3D unsafe { uninit };
> > > > +        value: $value:expr;
> > >
> > > I would find it more natural to use `=3D` instead of `:` here, since =
then
> > > it would read as a normal statement with the semicolon at the end.
> > > Another alternative would be to use `,` instead of `;`, but that does=
n't
> > > work nicely with the static keyword above (although you could make th=
e
> > > user write it in another {}, but that also isn't ideal...).
> > >
> > > Using `=3D` instead of `:` makes my editor put the correct amount of
> > > indentation there, `:` adds a lot of extra spaces.
> >
> > That seems sensible.
> >
>
> While we are at it, how about we make the syntax:
>
>         global_lock!{
>             static MY_LOCK: Mutex<u32> =3D unsafe { 0 };
>         }
>
> or
>
>         global_lock!{
>             static MY_LOCK: Mutex<u32> =3D unsafe { uninit { 0 } };
>         }
>
> ?
>
> i.e. instead of a "value" field, we put it in the "initialization
> expression". To me, this make it more clear that "value" is the
> initialized value protected by the lock. Thoughts?

`uninit { 0 }` looks pretty terrible IMO. Can we come up with something bet=
ter?

> Besides, instead of a "guard" type name, could you make a
> generic guard type over the "locked_by" type? E.g.
>
>         struct GlobalGuard<L: GlobalLockedBy>(Guard<...>, PhantomData<*mu=
t L>);
>
> I feel like this could make the relationship between the guard type and
> the locked_by type more obvious. But maybe there's something I'm
> missing?

Sorry, I don't understand this. Why is the LockedBy type relevant to the gu=
ard?

Alice


Return-Path: <linux-kernel+bounces-414670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B385D9D2C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F931B37BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9DE1D27A9;
	Tue, 19 Nov 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHNgDThv"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930213AA35;
	Tue, 19 Nov 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035101; cv=none; b=LkdRYebdcubIzL0hbP+V/26c0yG885uA4zeg1b+8PeTvYfXDpJ2tbOj6gFqrSk6tDL2snLJWwSG26K/kz9gCOJU3IwGBL3pao/sVasy4vEF2t5fmeCELNlG1t50SZinHh3QAmgWE+DX9bLlseXilnL3GGz5AhN7ukbqTTP4LzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035101; c=relaxed/simple;
	bh=PvNPz8sPtECmmp5qMJTLlVg78OWcbWQFWaExDeMtEYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo7AahjaVSZmNOZce/93NxOGNRdvcWCTXrYQnSTjX31+BPQ7H7tJur+x9LKrSYTm/NBimPBFh6ChfsTmISbW9i/+JmG5v08DfJ0F7W0lRDnEXh06WPQOUADP34U1X5LWzTsV3IhqbhJOM6CfijBFCb6jCQRX2mZRi9cMnvyLGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHNgDThv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb587d0436so31994181fa.2;
        Tue, 19 Nov 2024 08:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732035097; x=1732639897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yUnEb7DXjpYKhiCFXU6Jx12oUcHSD5GXi+o7wNjyCA=;
        b=cHNgDThvAtSlZrbwaf8I3RMqNQQ+UhxKJhWKp9I15ig+H3/oHiHGWJfwi7NWdAED33
         bNOcs5yZugJeFydNlVkTEgD2BlDC2MBcc5eza7Wo3OpkdhKmZ4wJscBDGe2+0fRKEMAr
         HlCo5qFh2kaTFFr50WbzXjbkkKU1ROfPRdnPjgpJgVbjFMrSKX2l4ItTClVqtI5tnk63
         2Dig/1WUOZ4gWrTYbCrmv8Hp7EYKKVop1556b6pc5v/n7RuPp3sGkpOEXtWJCl6iTYds
         u1rBvvHWQvxS19fDo2+Iym+P4FBvby4DS1TFXbI8Mox4mhQzpSlJjVvPlbxLJG63WN+A
         0xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035097; x=1732639897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yUnEb7DXjpYKhiCFXU6Jx12oUcHSD5GXi+o7wNjyCA=;
        b=Q+2qXDcTnv0fhs3MFCaUBs7R9GW2A4z2zp8muY0uoplJcMA0Tv5h/lbWWwjpo7iVNz
         vzNP8V4giLMO4StOfXPwjjE8D7lkEsxnheK7fWnE1n8hx2sRb6sowcfwOq2Gur85vz2E
         MHYdnPXxfMpXf5ES/HuNY4OxZBX95NuRhJZCHKj01c4I041iqKLX3WB1DkOwIkwDWW4m
         b3JLKpb4uLBfu1ESoy0AfE4TNLz0dsq1RSiIc47/e9TUr4SQXdzjL6JB/pzDOy9pzp5V
         kzJvPdhAv1AmjL3nu9nDwjits1DjfmTlF1inxOHnhb0DYjKh5aAg2qk1DEtLfmx9zXsY
         5mbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Vb9Wher/YyKAF4Ao5zfr0AqMJmQMVpacZLbgh+xo6BH2ao96ic/ieo/8NlJdZfFYFL38AXkRNeSUh/QZLHw=@vger.kernel.org, AJvYcCVja1k9zcMFvwuhVtl2b2GpCmHRrfL/lkpmIGxKg1pqveAg7slOqUjp0PuTsjmj6GP2ejk7ZmFYYxD/m3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMH7KcD7soloUhafcp0Bof18yT0UNMu0e8XfzCi5peCUk9WyMp
	E4g8+OZEPPbgMdjwLo3c6+CmntiBTmBTqf9bZZBzbCb9rlw8ZeO6H3e3LjjiwfF9UcTTKJaWn0z
	ENGOh9iDozOQ1uhxW14wSdBUPbcg=
X-Google-Smtp-Source: AGHT+IFtUWrhx3gRLegLhlFL6/mGwxN+F5+Lg1sSArknlQ/kPb4qHmI+qafReDrfmP5xlJE8SXiUbB7X4VDU/PtZ4ss=
X-Received: by 2002:a05:651c:905:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-2ff60767c16mr82247691fa.37.1732035097234; Tue, 19 Nov 2024
 08:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
 <Zzu9SzkDoq_1YQnJ@tardis.local> <CAJ-ks9mKArX37VzhcyymDoE-MsNxNcO8VvP4n3Xu1mdfOKiuag@mail.gmail.com>
 <CAH5fLggL7MTLVv2ym_tCCKH9hQtL=GpTwXjDUQzKQX9UdT7SkA@mail.gmail.com>
 <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com> <CAH5fLggBZsarrRkZ1Mf5ND9-A6kCc65QRwhUW5X9nQxRJUOXrQ@mail.gmail.com>
In-Reply-To: <CAH5fLggBZsarrRkZ1Mf5ND9-A6kCc65QRwhUW5X9nQxRJUOXrQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 19 Nov 2024 11:51:01 -0500
Message-ID: <CAJ-ks9=ZDRdh1UzBpV-ck2v5t4a3-81vD07Ndfmow4ABmQvJmQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 11:43=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Tue, Nov 19, 2024 at 5:40=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > On Tue, Nov 19, 2024 at 11:28=E2=80=AFAM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 5:24=E2=80=AFPM Tamir Duberstein <tamird@gmai=
l.com> wrote:
> > > >
> > > > On Mon, Nov 18, 2024 at 5:18=E2=80=AFPM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > On Mon, Nov 18, 2024 at 11:33:36AM -0500, Tamir Duberstein wrote:
> > > > > [...]
> > > > > > +
> > > > > > +/// A lock guard.
> > > > > > +///
> > > > > > +/// The lock is unlocked when the guard goes out of scope.
> > > > > > +#[must_use =3D "the lock unlocks immediately when the guard is=
 unused"]
> > > > > > +pub struct Guard<'a, T: ForeignOwnable> {
> > > > > > +    xa: &'a XArray<T>,
> > > > > > +}
> > > > >
> > > > > `Guard` would be `Send` if `XArray<T>` is `Sync`, however, it's
> > > > > incorrect since `Guard` represents an xa_lock() held, and that's =
a
> > > > > spin_lock, so cannot be dropped on another thread/context. `Guard=
`
> > > > > should probably be marked as `!Send`. Or am I missing something s=
ubtle
> > > > > here?
> > > >
> > > > I didn't know about this requirement, thanks for calling it out. I
> > > > have added `_not_send: PhantomData<*mut ()>` in v10.
> > >
> > > You can use _nts: NotThreadSafe. The type in question has landed in
> > > 6.13 and is available in Linus's tree since yesterday.
> >
> > TIL, thanks - though it looks like the field name is still `_not_send`.
> >
> > How do I set the base-commit/deps such that both
> > https://github.com/torvalds/linux/commit/e7572e5deaf3bc36818f19ba35ac8e=
0c454c8bac
> > and https://github.com/Rust-for-Linux/linux/commit/d072acda4862f095ec90=
56979b654cc06a22cc68
> > are present, given that the former is in 6.13 and the latter in
> > rust-next?
>
> Either you merge them yourself or you wait for rust-next to get merged
> into Linus's branch.

Sure, I can merge them locally - but how do I properly send a patch
that relies on both to the list?


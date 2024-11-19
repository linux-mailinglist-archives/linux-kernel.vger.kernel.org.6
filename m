Return-Path: <linux-kernel+bounces-414627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53249D2B27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EF41F237FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA01D0149;
	Tue, 19 Nov 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLhtddo4"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF614A639;
	Tue, 19 Nov 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034437; cv=none; b=sLvusI/9XFCzyljz/Y4rKm37YHwwRTiHEdU3v7fqBlQ+szh0sU8l6XkQ5bCI69k6bI+rgCLxM91XgAVP9ZGCw+XWhwPg++PDX2wExIgAodU5dmZE/Vo4pbEHomN8K1YeTeNeztlR1Xuy2xlpt7a3OhXEW/DsxSxG0k2vFlOMIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034437; c=relaxed/simple;
	bh=5/HMTjgDhQWQpJ657cllaUEozWIjrkJ8BkHpmAV9aC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGroHIUPjp2rdXXGi1AxMc8Egvw5niyfUORMu9VuVn/vpzd9QOfYLtp8jiuIW8FX7Sw4BXFG0B5xXmar3vlLsnm9nSXygs+InthVAUOfw7Sdup3FbWG9stuYKS+4sauGsVjzbqoMKN9tpOLDgaTNofL113azAUz7aJNmlj9YOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLhtddo4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so11560891fa.3;
        Tue, 19 Nov 2024 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732034434; x=1732639234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeXiHs+rxpkXwbRymJbwY2Tn4msSl3FzHgVXZFDYW9s=;
        b=SLhtddo409zFy5FiiweBOhRlhvo/qxH6ajx9xE0Qu1quid669Cedr0R+7Xfk4UknYD
         YyWbIrV4vTG62FO5dmsCuzIo/CasmGCE9xLM04g/XURaV2LpeMog94rb/mVIBOCSnpEK
         yhoDCWQJNellxbts52K2LH5SZR+LYxGQtGoaMsWrlWI1lC4aelw/eYQeEyE/us/dwRSA
         PnKjr5wO3g4fmSR4EQ3YSV1vNr1fvfjpfc1xZVu6IpJw5uBbA3RkIE1q4qA600RYSjfW
         7+aVObURhWl3x5RzrAsnvW2MnFgvdtUGzuYUHLe8Re3Q2NudI+67hf0PUEl8WA7bJqC1
         YlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034434; x=1732639234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeXiHs+rxpkXwbRymJbwY2Tn4msSl3FzHgVXZFDYW9s=;
        b=IP8rFvJnNcQjEMo+DyL6vyzSZAou/lw3mGApsJEZK7ZtDkRfHmFZoefSA3WEYPA9U4
         paPM6F052KBKponVCiXfQ7jTPzF2BTzNPp2eoqgxlwpQZVStMpBxcDmOsS2qHmiT5nPN
         wr+BiGXstK33Pk/8r1VOloZnHlAhG3T6R+k5OLYQfmqWg/k7mJKHiqXdGN53QgkRtpRC
         7BS772JbS0QTwJQcjGDgvePEyMzNf6UAuIsYyi4Y/D1q5sEPOI7VIR6naxNzKBrZxPqF
         HHQ7NdU8nNyxD6YK6w1LmJCea1Tj8ymIMy/8vINRrGnlW76wmuy1F0VTY6iVkGo1T4k6
         dfwA==
X-Forwarded-Encrypted: i=1; AJvYcCV6rxQHmk8yRQ9t2JXwY8SBUi/M/tRTmsvlvPHXaFaxvD0r+HndrI5j67gwkidM5A6n6sDUXM9JiFUtKjUgmsk=@vger.kernel.org, AJvYcCVCbF6jUEf9vgRZwQbJ7IodDgONL0dkiGmUB3HcSAWJEqjtCDehydHQgWEhQ0N9DBdWlDDmtg0mORQv8X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUKvYv7fzSmzq03kRv+e8TTvRYQ0o7hHXec5MUOfhnLk5PR4V
	Xduqiz1ut4L7N62PXGoZvgzne8w3NYRJw45CF6R7gTH7lsY/hVRAIuCqcs2147VPsczMxSQjkiO
	Asj1C7eXK1ZDMXIuSU94pugGfbkA=
X-Google-Smtp-Source: AGHT+IEptay1Gm7akrpracSOY9yuvHa6a3CR1414lpHta5rcOt9hZsBXz6t+16QOlSYXm+PVi3R9UTxgFja06io0QxQ=
X-Received: by 2002:a05:651c:158f:b0:2fb:5168:1a0c with SMTP id
 38308e7fff4ca-2ff6095e53emr79202931fa.19.1732034434025; Tue, 19 Nov 2024
 08:40:34 -0800 (PST)
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
In-Reply-To: <CAH5fLggL7MTLVv2ym_tCCKH9hQtL=GpTwXjDUQzKQX9UdT7SkA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 19 Nov 2024 11:39:57 -0500
Message-ID: <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com>
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

On Tue, Nov 19, 2024 at 11:28=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Tue, Nov 19, 2024 at 5:24=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > On Mon, Nov 18, 2024 at 5:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Nov 18, 2024 at 11:33:36AM -0500, Tamir Duberstein wrote:
> > > [...]
> > > > +
> > > > +/// A lock guard.
> > > > +///
> > > > +/// The lock is unlocked when the guard goes out of scope.
> > > > +#[must_use =3D "the lock unlocks immediately when the guard is unu=
sed"]
> > > > +pub struct Guard<'a, T: ForeignOwnable> {
> > > > +    xa: &'a XArray<T>,
> > > > +}
> > >
> > > `Guard` would be `Send` if `XArray<T>` is `Sync`, however, it's
> > > incorrect since `Guard` represents an xa_lock() held, and that's a
> > > spin_lock, so cannot be dropped on another thread/context. `Guard`
> > > should probably be marked as `!Send`. Or am I missing something subtl=
e
> > > here?
> >
> > I didn't know about this requirement, thanks for calling it out. I
> > have added `_not_send: PhantomData<*mut ()>` in v10.
>
> You can use _nts: NotThreadSafe. The type in question has landed in
> 6.13 and is available in Linus's tree since yesterday.

TIL, thanks - though it looks like the field name is still `_not_send`.

How do I set the base-commit/deps such that both
https://github.com/torvalds/linux/commit/e7572e5deaf3bc36818f19ba35ac8e0c45=
4c8bac
and https://github.com/Rust-for-Linux/linux/commit/d072acda4862f095ec905697=
9b654cc06a22cc68
are present, given that the former is in 6.13 and the latter in
rust-next?


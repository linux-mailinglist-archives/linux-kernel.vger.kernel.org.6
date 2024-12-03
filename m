Return-Path: <linux-kernel+bounces-429731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8272D9E2189
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B898285828
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145B1FCCE4;
	Tue,  3 Dec 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSCM4Bol"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371471F892A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238723; cv=none; b=otXg41hHwWlNvlGVit1SAK6UpQsb1H/MzoxUvW9h30SKJM9MpJvbGJLkhxVxrNNA0b2dXY14bowzCV3ITON+ifwJ29znQVcPM8EDbWn+AErigkgUA2axzyyVFEmP+MsZ2wu84Rywwd8oU/uw5242m0uQMXq6XB1F3ln4MYQlJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238723; c=relaxed/simple;
	bh=gyvEs1E/4I843Wo9tvfjpqqgLtC7wOGj2Udlrs9XjfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjrOws5y1axbzOxXN0W5cfv0YtL3JuOxmn7vUfU82XEoPEuMSS2k9BW7xlWVrvFDOf7FksAVZZiP3DyAYKpLh/uYvC6biH0+OGy4vXslh/quXcGsfO82UshBO48/h9LXKHTBx/PZQ3MAI9if3AWEy5Tubj/JHxoB0BxVWbc0sY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSCM4Bol; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e2c52c21so2208823f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733238719; x=1733843519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOKE0NDW2RgCYKsQSYaekUZqPmxVS4wlkRziwc8dWdg=;
        b=lSCM4Bol4S4c6Nl7tZZRxbdqF1/A8ijDMxuuHKJA5Jx1ATXGoJE3kELXbEl1dPCHf1
         89TEQAE9Juhqolp6GwoBOicXDkXUosMWYQ9lfo/1wcUqKm5gvrZoBhZKWzT2bpkhjQwL
         97y1qGODnN2u3gvMBADX0ylfpGyDF8L4Pz+nCwFP6Xvt1z1NEfsZ2CWsc8SEUccaJVLB
         CVRGLa3U1a+Vu8l13vsHOeSbOrRKrAEnh0mOcygy4WKz21DrvnW8JdXihSp70u7MYkYj
         Aj2w4fHlU1QfF4L1+t4AE5ydg8x+UCwPwJGZ53Xt3td0Vm1BOB44n8LZaHby6+Hk6ytL
         E7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238719; x=1733843519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOKE0NDW2RgCYKsQSYaekUZqPmxVS4wlkRziwc8dWdg=;
        b=DRSmIhA2jyuqT2hq4PoTBesgIMTznqgJEnbrzK1MEfGmmJg6cjb6ycWUqmb88LvC05
         VNrMSNU9LPllZfZ8GrcEJ4lCTYy5evzVYLhEqmfxpt2G6EdLpMom+eE4ngTC9hC2bco0
         vtf30c9aY1cW+mcy5kM9xKh+QbkhKvyOjKWs+tK1R4ci3qg7DvZ6+xrShwPgqFTvGBx/
         vK3ek5+0R5DDlahmS+f5sI+5ZRvBgkclquyd2Fm3bHwmkZEhK2nsunVxXzavpa3uWXut
         zdFoqp8ZGe86u2jYHZT8ZaEUabUlGjCRlAmJVKE1j8+vn9EESWrlsrP0Xc/PZfEtri4m
         CaRw==
X-Forwarded-Encrypted: i=1; AJvYcCWeH0HOPGtaK3zoFZ2sknG9po//NwSg/auUxPjnvWm7Cu6noGYoIVLAqfGQgYyOtn6P0QftpIM8nqsoz+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycXgxE3L8oyxMD+6PfSlq3goIEjEFciDFDi8ECAcYZZrWQCVIA
	K8owvfD6q4HVliyRa+dLGfQOHetcZa2mq+DBI/6ECWIraVsSwWegeccQ0G1xUqUJfAeavQXTR8w
	BNE/wZSQ5tsIWkd/gc8+gVT4+2lPHeDVil2Av
X-Gm-Gg: ASbGncskqkMiStZwM6b7DpUf4Ck99hsq2hYkMQwCSVW2slOjVc3sVLq/GQFDYYYukfO
	mbSo7q9JJWekfeUp+I6yOoCKtxAgZ25OBm0VIUDJ1PDYIWdBF3JTigxKSG0h38Q==
X-Google-Smtp-Source: AGHT+IH50DVbdbXafEbqkA0ERFhXhngJi7AHiDYU7M9oIqozFLwQkMRE5ghZjzggGcpDX5Mjb2Jr8AK4V72CS9i105M=
X-Received: by 2002:a5d:47a7:0:b0:385:f60b:da50 with SMTP id
 ffacd0b85a97d-385fd422ea9mr2691336f8f.33.1733238719365; Tue, 03 Dec 2024
 07:11:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
 <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
 <CAH5fLgipntMtu7_pdZDZGerGRO499yxDdz2dP=2Bb5FobcykYg@mail.gmail.com> <CAJ-ks9kwGi+hhsNUC=Ti3CL8iJ4mEN2vSkoFUnz67Usu+-_P6Q@mail.gmail.com>
In-Reply-To: <CAJ-ks9kwGi+hhsNUC=Ti3CL8iJ4mEN2vSkoFUnz67Usu+-_P6Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Dec 2024 16:11:47 +0100
Message-ID: <CAH5fLgiLPkVwgGiTFYbPTnz1EF8wAjopbBpmK6LpkmVRF+kVZw@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:00=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Tue, Dec 3, 2024 at 7:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > On Wed, Nov 20, 2024 at 12:48=E2=80=AFPM Tamir Duberstein <tamird@gmail=
.com> wrote:
> > > +use crate::{
> > > +    alloc, bindings, build_assert, build_error,
> > > +    error::{Error, Result},
> > > +    init::PinInit,
> > > +    pin_init,
> > > +    types::{ForeignOwnable, NotThreadSafe, Opaque},
> > > +};
> > > +use core::{iter, marker::PhantomData, mem};
> > > +use macros::{pin_data, pinned_drop};
> >
> > I think these are in crate::prelude.
>
> I prefer to be explicit, unless there's guidance on this somewhere?

I don't think I've ever seen anyone do a direct import from macros.

> > > +    fn iter(&self) -> impl Iterator<Item =3D core::ptr::NonNull<T::P=
ointedTo>> + '_ {
> > > +        // TODO: Remove when https://lore.kernel.org/all/20240913213=
041.395655-5-gary@garyguo.net/ is applied.
> > > +        const MIN: core::ffi::c_ulong =3D core::ffi::c_ulong::MIN;
> > > +        const MAX: core::ffi::c_ulong =3D core::ffi::c_ulong::MAX;
> >
> > Isn't MIN just zero?
>
> I liked the symmetry, but I could change it if you feel strongly.

I commented because I thought it was confusing; I spent some time
figuring out whether the integer was signed.

> > > +    /// Erases an entry from the array.
> > > +    ///
> > > +    /// Returns the entry which was previously at the given index.
> > > +    pub fn remove(&mut self, index: usize) -> Option<T> {
> > > +        // SAFETY: `self.xa.xa` is always valid by the type invarian=
t.
> > > +        //
> > > +        // SAFETY: The caller holds the lock.
> > > +        let ptr =3D unsafe { bindings::__xa_erase(self.xa.xa.get(), =
to_index(index)) }.cast();
> >
> > Two safety comments?
>
> There are two properties that must be upheld. How would you like to
> see it formatted?

Usually multiple preconditions are listed using a bulleted list:

// SAFETY:
// - `self.xa.xa` is always valid by the type invariant.
// - The caller holds the lock.

> > > +        // SAFETY: `ptr` is either NULL or came from `T::into_foreig=
n`.
> > > +        unsafe { T::try_from_foreign(ptr) }
> > > +    }
> > > +
> > > +    /// Stores an entry in the array.
> > > +    ///
> > > +    /// On success, returns the entry which was previously at the gi=
ven index.
> > > +    ///
> > > +    /// On failure, returns the entry which was attempted to be stor=
ed.
> >
> > I'd like to see documentation about the gfp flags. This may unlock the
> > spinlock temporarily if GFP_KERNEL is used.
>
> Will add the language from the C documentation: "May drop the lock if
> needed to allocate memory, and then reacquire it afterwards."

SGTM.

> > > +        // SAFETY: `__xa_store` returns the old entry at this index =
on success or `xa_err` if an
> > > +        // error happened.
> > > +        match unsafe { bindings::xa_err(old) } {
> > > +            0 =3D> {
> > > +                let old =3D old.cast();
> > > +                // SAFETY: `ptr` is either NULL or came from `T::int=
o_foreign`.
> > > +                Ok(unsafe { T::try_from_foreign(old) })
> >
> > It can't be XA_ZERO_ENTRY?
>
> No it can't. XA_ZERO_ENTRY is never returned from the "normal" API.
> XA_ZERO_ENTRY presents as NULL.

It's probably worth mentioning in the safety comment.

Alice


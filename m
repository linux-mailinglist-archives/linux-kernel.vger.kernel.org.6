Return-Path: <linux-kernel+bounces-429802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FB9E253C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E32A284A20
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0401F76DA;
	Tue,  3 Dec 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMQP/HPy"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F71DE8A5;
	Tue,  3 Dec 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241496; cv=none; b=Re1u2NuaGXhYYGZX1kZc9NrWBNvREQ4SxZMHOCTvEICcJDgc+l9GnwDQs7K5apUM2WvQqhtlZm6aqcLJklvmNAy7CXg/ZjiqcuaIsyH+fBRzzwm9/7ABfjF58o+FuhS4qfJAqHYaWa+y/Psi0ZFlR2T6udgRZK/Ms/oNmiY3RgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241496; c=relaxed/simple;
	bh=UQAYXZTlJVJ80kpIYpUioM7FGTeGoM4MDlESW3IkEWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLf5lqxzWPzshziItS7cFnZpg+dGIcEhCSz77elGYFuNK+isGYfen9HjWWhDCWOj1qIGQ3pzhz89SxS7gGdsy1idfXfhx6dVlVB82gV58X5mHpt5SsSOYjkfI55OYeHUg5/EQzf0ggGLgjVTNXhjR8FD/BwOe5Id645xOIkMbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMQP/HPy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so47507361fa.3;
        Tue, 03 Dec 2024 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733241493; x=1733846293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XByooqmAZSqUAgwg6BsfAtN4ejjPSt/22HI9qzsaKzk=;
        b=WMQP/HPyplY5UBR3MCVMXGynlSsqRqVTSe0r8nnNcy5pbKMbVREoCGzFbNZS3sf/D8
         BiXt5SY9WTiVFyWGscH+4oXrJsHu+1vwYPNry9ii0dxDxiUHQJPkuuo+EB82PvLPAnqs
         095fs9ezJfYiNnnrNsXarcWKaW7YENR1LAzc3vT71PuKjWHzcIqPpkcM2I7TdfwngTP/
         NNP/NAhphgnFcKyjRKoeYwatVvLXPrHTVhRjqBmO5tcb2t8ZiIpxH2GuVd/3PCt1aNtn
         QZO1rWGdKtfGsk+HUdrlp3rA+DZNTQStYR6/b0pJ46G867WPsiLSKsEJjP96NbKnaqf3
         qe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733241493; x=1733846293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XByooqmAZSqUAgwg6BsfAtN4ejjPSt/22HI9qzsaKzk=;
        b=M5orqobEP8qojQlpoQ21vTd4uRnmN2LHiD/Vx4LXqv+83E4xio5mQfHRp4UlABgbmv
         pY9QssOTRg65GX+Z2etNJQNttZwPXy/psvKrIdjLOSwZOvl/p+QURO55feCN0ajttghm
         GbXgYy3jq0CLpceRQkwoTMHUhPTON19VqtKSqIN7AkEarOrRZcdDOMltHfekuZEL9a+d
         UTXRtWNKlU/DdyKvzQcmQQ3V9N4YoOXcHo2n/4eLQCRZsl+ollen6COtTzmMCGoJSRqA
         alnwo/4byTcIV0Uj1a2WPzjwRGE+sesLLULS9HDj06oAnO4OGV3Xrh330Vd/KdLrXCTp
         EoKw==
X-Forwarded-Encrypted: i=1; AJvYcCUzoQnXlA6s1A0N94DXjtdNTpQFA5yDg5btIcOqdEEcF92+3E5TBH+s1QKvqOzD8qtnzR7pJxf6uWpPhE4DkD0=@vger.kernel.org, AJvYcCWmkNfKFf3mMRD03NejGd8WCrEsw4pZg6woI+QnoC6qEmVxQwV7uwMGXjRHEf06IPZ5qnY98asLfsR3Poo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KuZ+G9nIANrFleiK3ZMH6Vf9MzKt7cych40w1dh997CyzZkZ
	V79zuKFsaQW6xGQQkop0LGDuF6VU/u//XtIuLFOilCpGfMgYW+oqryVjCceBqDc0zFKR2MxRbAZ
	ecVTDxKYKb+I58kV6ZxxUcfCEMiQ=
X-Gm-Gg: ASbGncu6H+G0Jxhl5T39wSKNsxecQwR80gvsA8ttJWhe5ipLQNzg9oqe4VmnyUS/TMi
	MOfK7yheKVh9xjd4JWqER22hEZGGd/LyIHc5BOsfqjjBsER8=
X-Google-Smtp-Source: AGHT+IFd2mEOSqhbzbELOwLdOQlAPoc9LwQ8qAEjIE/p75NdBNNzR2juEoM9IRpGpA53+iN4zjbkuQ+i7wO1uHGCQTw=
X-Received: by 2002:a05:651c:210c:b0:2ff:7a4f:e770 with SMTP id
 38308e7fff4ca-30014eaa13cmr2973921fa.31.1733241492469; Tue, 03 Dec 2024
 07:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
 <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
 <CAH5fLgipntMtu7_pdZDZGerGRO499yxDdz2dP=2Bb5FobcykYg@mail.gmail.com>
 <CAJ-ks9kwGi+hhsNUC=Ti3CL8iJ4mEN2vSkoFUnz67Usu+-_P6Q@mail.gmail.com> <CAH5fLgiLPkVwgGiTFYbPTnz1EF8wAjopbBpmK6LpkmVRF+kVZw@mail.gmail.com>
In-Reply-To: <CAH5fLgiLPkVwgGiTFYbPTnz1EF8wAjopbBpmK6LpkmVRF+kVZw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 3 Dec 2024 10:57:36 -0500
Message-ID: <CAJ-ks9=gJ7O63Hv0VYiB=LV+CjA1iTQGs4-xzkaHWayryw-p6Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:12=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Dec 3, 2024 at 4:00=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > On Tue, Dec 3, 2024 at 7:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > >
> > > On Wed, Nov 20, 2024 at 12:48=E2=80=AFPM Tamir Duberstein <tamird@gma=
il.com> wrote:
> > > > +use crate::{
> > > > +    alloc, bindings, build_assert, build_error,
> > > > +    error::{Error, Result},
> > > > +    init::PinInit,
> > > > +    pin_init,
> > > > +    types::{ForeignOwnable, NotThreadSafe, Opaque},
> > > > +};
> > > > +use core::{iter, marker::PhantomData, mem};
> > > > +use macros::{pin_data, pinned_drop};
> > >
> > > I think these are in crate::prelude.
> >
> > I prefer to be explicit, unless there's guidance on this somewhere?
>
> I don't think I've ever seen anyone do a direct import from macros.

This exact stanza is also in `rust/kernel/block/mq/tag_set.rs`.

> > > > +    fn iter(&self) -> impl Iterator<Item =3D core::ptr::NonNull<T:=
:PointedTo>> + '_ {
> > > > +        // TODO: Remove when https://lore.kernel.org/all/202409132=
13041.395655-5-gary@garyguo.net/ is applied.
> > > > +        const MIN: core::ffi::c_ulong =3D core::ffi::c_ulong::MIN;
> > > > +        const MAX: core::ffi::c_ulong =3D core::ffi::c_ulong::MAX;
> > >
> > > Isn't MIN just zero?
> >
> > I liked the symmetry, but I could change it if you feel strongly.
>
> I commented because I thought it was confusing; I spent some time
> figuring out whether the integer was signed.

Alright, will replace with 0.

> > > > +    /// Erases an entry from the array.
> > > > +    ///
> > > > +    /// Returns the entry which was previously at the given index.
> > > > +    pub fn remove(&mut self, index: usize) -> Option<T> {
> > > > +        // SAFETY: `self.xa.xa` is always valid by the type invari=
ant.
> > > > +        //
> > > > +        // SAFETY: The caller holds the lock.
> > > > +        let ptr =3D unsafe { bindings::__xa_erase(self.xa.xa.get()=
, to_index(index)) }.cast();
> > >
> > > Two safety comments?
> >
> > There are two properties that must be upheld. How would you like to
> > see it formatted?
>
> Usually multiple preconditions are listed using a bulleted list:
>
> // SAFETY:
> // - `self.xa.xa` is always valid by the type invariant.
> // - The caller holds the lock.

Thanks for the suggestion, done.

> > > > +        // SAFETY: `ptr` is either NULL or came from `T::into_fore=
ign`.
> > > > +        unsafe { T::try_from_foreign(ptr) }
> > > > +    }
> > > > +
> > > > +    /// Stores an entry in the array.
> > > > +    ///
> > > > +    /// On success, returns the entry which was previously at the =
given index.
> > > > +    ///
> > > > +    /// On failure, returns the entry which was attempted to be st=
ored.
> > >
> > > I'd like to see documentation about the gfp flags. This may unlock th=
e
> > > spinlock temporarily if GFP_KERNEL is used.
> >
> > Will add the language from the C documentation: "May drop the lock if
> > needed to allocate memory, and then reacquire it afterwards."
>
> SGTM.
>
> > > > +        // SAFETY: `__xa_store` returns the old entry at this inde=
x on success or `xa_err` if an
> > > > +        // error happened.
> > > > +        match unsafe { bindings::xa_err(old) } {
> > > > +            0 =3D> {
> > > > +                let old =3D old.cast();
> > > > +                // SAFETY: `ptr` is either NULL or came from `T::i=
nto_foreign`.
> > > > +                Ok(unsafe { T::try_from_foreign(old) })
> > >
> > > It can't be XA_ZERO_ENTRY?
> >
> > No it can't. XA_ZERO_ENTRY is never returned from the "normal" API.
> > XA_ZERO_ENTRY presents as NULL.
>
> It's probably worth mentioning in the safety comment.

Will do.


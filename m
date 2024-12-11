Return-Path: <linux-kernel+bounces-441562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6099ED01E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF60282E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE01D61A2;
	Wed, 11 Dec 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXQLhsR5"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773421D5CF4;
	Wed, 11 Dec 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931705; cv=none; b=j50IZm4YPCx45ZKRrbU0w9t9zROyKeRRmofTegH0m3i/aXbp41dbt8h+VC9sUzGpEHZswRtKdLDPOLVcrNPxVwb5PiGqSQLSmx1me8N40UtxYhFWy15B/UPZRbHAk7R41JWUSmSNn4cX2ef2gixVzcvyF6z5izgFvkUWHZg8Q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931705; c=relaxed/simple;
	bh=NOZBo1+JNL4bPIBugXKrBr3qkhzKzwYQr3Ic7KNnheo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKV6eKbrLSfQjYzIWc/FM7KO4xbRqScywbuf9tf7zNDY5+OdItRBxo47UyW5W/MnJgcikD0z0f+eGp/9pCHY8mHbICDWFY2pSIaO2CNK9naB/BdvgJEFFcFzpKauN7FtprGcYn7Eh9/y5i8Y9F0zCF+F83LKynMfnNuL90vIOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXQLhsR5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3023c51146cso9404221fa.1;
        Wed, 11 Dec 2024 07:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931702; x=1734536502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ff9cb+2nLD8JalOVi1PdsyNf0i1E46g/pErfpxjw4A=;
        b=PXQLhsR5vaY0R/7Kx78kZTMOHnuWC3+ZkhRE6Qlx9WXcFXNby8rY3GpFdWWmlZ3yv9
         o0Ay9LRVonafM2aByJL9tuIMzKpTtFMASNPpuLWLKLpNPQ9tdH7x+EdujlCxm4jTViK5
         xS6TQze19ZfL3HtgCZPB2PVwDVmqYEXjw9NsBDfaH5+WAde+MujLz6FcxhXQr/lqJ1P6
         U81fQ186DvtXYgwNJ/mmDLuzRK1xEtc80lfi4aLpirERw6azLyrg0kXmOYeRo9Un4xnX
         IazQ66VmT7U0g3CqVB43OZfgMkdiLOdEDt3sghunypAF7MVehbYTIs6i9EvJmyWd4rM3
         hCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931702; x=1734536502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ff9cb+2nLD8JalOVi1PdsyNf0i1E46g/pErfpxjw4A=;
        b=q9prTEcDpa5xy93zbQpnBBOWdOqMe/BxuB5zKcnnjoo2rMTCGrnRrexGHxfAZJcKNb
         YpoxV+n61J0dCNGtSNsuAzM3JciI9VJ0Ind80hbLQlnmw/pCFrpBY0wBhvYpuYRVKf6Q
         7F5ymi1hWtHOwirHxN8W6eDphAZNVR0GEU4yXeGveqAjZ5HtB4lYS3SenZmFbqJaJ6Pt
         1o5nHn47VljtojO1YcvYjNtyGoY3HvKsE8T8VD95Bt7HzPwDJsaHXVlSq8OwAPHCT6cJ
         mh8dmzBMGOeOPJB2BzHo6UmiuECXRpW8WUYQCnvSzzM3kBU6vzSp8hv3hxlosxfaliw2
         CgEg==
X-Forwarded-Encrypted: i=1; AJvYcCWYMhJvVIhDxzX2wsRzBvvgpx1qjCNDNa2q1d35wx+HOAgwuui/lfzA6UzirsAkeFcPnLrCi1pJkA6qvLlN4Rc=@vger.kernel.org, AJvYcCXCk444+YE3jDwiRgaskmAl34xn9MVBBslxC9mNqoH3KFjGvxGQvpEzEhPZSHnUwvXy5VxO1AA+/s3dK+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoNe934rMpZ5vDV7DPJwvmZvGTa3rWEqZ6LTUrRShi6k1X58U
	e9LwrGnS3Yzz5gEz6BLB28sqZf5/R2zbAy+UxMaS3cwD3vhJxrtVyk//MAcrDdC4iR4frMAiO6R
	8L/vPbRzvAq1vKd8NJ+ojx+ZTiH+ZLKkL8Zs=
X-Gm-Gg: ASbGnct1jVGIk261Jjv3BoEEGeDhwabNEG5Dn/4X9SM6CcaeZ4d/Pcm1Cxz/vcMJWOs
	OGRwicbpm0hyo1gOM4qQc3/gNPC+k2sfCoI4BCrfYukvugMhf83k=
X-Google-Smtp-Source: AGHT+IEhS065GR8GCdLWIHmfihcTZwj5WW5a8mAJYES5//bs1giVZolIENRsdb3Xm9KdMTKYbCfEwCFOjZQsFAeoU8c=
X-Received: by 2002:a2e:a5c4:0:b0:2ff:bc33:b6d6 with SMTP id
 38308e7fff4ca-30241bc9872mr12985781fa.0.1733931701353; Wed, 11 Dec 2024
 07:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com>
 <20241203-rust-xarray-bindings-v11-2-58a95d137ec2@gmail.com> <CAH5fLgjPir8LfzfouBd3PYBvfCkWgQEw+im-=Vo7z8kBmFLtrw@mail.gmail.com>
In-Reply-To: <CAH5fLgjPir8LfzfouBd3PYBvfCkWgQEw+im-=Vo7z8kBmFLtrw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Dec 2024 10:41:05 -0500
Message-ID: <CAJ-ks9=oyLSkqAsAkO5VSM9js2G2AFvvrA-qHRKNYnsZyUx=mA@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] rust: xarray: Add an abstraction for XArray
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

On Wed, Dec 11, 2024 at 10:04=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> > +    fn iter(&self) -> impl Iterator<Item =3D core::ptr::NonNull<T::Poi=
ntedTo>> + '_ {
> > +        // TODO: Remove when https://lore.kernel.org/all/2024091321304=
1.395655-5-gary@garyguo.net/ is applied.
> > +        const MAX: core::ffi::c_ulong =3D core::ffi::c_ulong::MAX;
>
> I think you can use kernel::ffi::c_ulong already. Enough things were
> merged in 6.13 for that to work. If you import kernel::ffi::c_ulong at
> the top of this file, then you can just do c_ulong::MAX in the
> function calls below.

This isn't about using kernel::ffi::c_ulong; it's about using
usize::MAX. I'll clarify the comment and change this to use
kernel::ffi::c_ulong for now.

> > +        let mut index =3D 0;
> > +
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        iter::once(unsafe {
> > +            bindings::xa_find(self.xa.get(), &mut index, MAX, bindings=
::XA_PRESENT)
> > +        })
> > +        .chain(iter::from_fn(move || {
> > +            // SAFETY: `self.xa` is always valid by the type invariant=
.
> > +            Some(unsafe {
> > +                bindings::xa_find_after(self.xa.get(), &mut index, MAX=
, bindings::XA_PRESENT)
> > +            })
> > +        }))
> > +        .map_while(|ptr| core::ptr::NonNull::new(ptr.cast()))
>
> You use core::ptr::NonNull in many places. Consider importing it.

Will do.

> > +    /// Stores an entry in the array.
> > +    ///
> > +    /// May drop the lock if needed to allocate memory, and then reacq=
uire it afterwards.
> > +    ///
> > +    /// On success, returns the entry which was previously at the give=
n index.
> > +    ///
> > +    /// On failure, returns the entry which was attempted to be stored=
.
> > +    pub fn store(
> > +        &mut self,
> > +        index: usize,
> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<Option<T>, (T, Error)> {
>
> We can see in your examples that this return type is inconvenient.
> Perhaps it would be better to make a new error type containing a T and
> an Error, and implement From so that the question mark can convert
> directly to Error (throwing away the T).

Will do.

> > +// SAFETY: It is safe to send `XArray<T>` to another thread when the u=
nderlying `T` is `Send`
> > +// because XArray is thread-safe and all mutation operations are synch=
ronized.
> > +unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
> > +
> > +// SAFETY: It is safe to send `&XArray<T>` to another thread when the =
underlying `T` is `Sync`
> > +// because it effectively means sharing `&T` (which is safe because `T=
` is `Sync`); additionally, it
> > +// needs `T` to be `Send` because any thread that has a `&XArray<T>` m=
ay lock it and get a
> > +// `Guard<T>` on that thread, so the thread may ultimately access `T` =
using a mutable reference, for
> > +// example, using `get_mut` or `remove`.
> > +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}
>
> I don't think Sync is needed due to the spinlock.

Agreed. How's this phrasing for the comment?

// SAFETY: It is safe to send `&XArray<T>` to another thread when the
underlying `T` is `Send`
// because any thread that has a `&XArray<T>` may lock it and get a
`Guard<T>` on that thread, so
// the thread may ultimately access `T` using a mutable borrow, for
example, using `get_mut` or
// `remove`. It is not necessary for `T` to be `Sync` because access
to immutable borrows of `T` is
// also synchronized through `Guard<T>`.


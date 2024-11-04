Return-Path: <linux-kernel+bounces-395561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157019BBFE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CB31C22CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689851FCC72;
	Mon,  4 Nov 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7a2MHGx"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DA1F7553;
	Mon,  4 Nov 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755222; cv=none; b=dc50Bq48HhcF4FvPHR2HTuVVM7YibmUdvmFEb3+CalS0sWMi3xfYmswa/H9hqkRvHalecNCkzHC6sBI4rh3cUOoylLaKrCL38hddDrfoRVL2gkKQXme2z4mpM2BCvlzw2Dj8MAhyBux+8bnx3/TBaWJaqHtNz/NBVY8mmoXHHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755222; c=relaxed/simple;
	bh=Ex/yRDEcS38I2U+QV2u5q2lo/RA6PTu9t8WSYCQth9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBZUfCin9Uv0STdJ4W+rmHcRgaCjjdinl/tEiNUY9aPGvz83CghnZPG2JDZU7c6SITB/Npc3cd0qdDQiZaUoHMIP5IoGgEruSYwT14Jxr3JX6HIcrHtPkcBECR46zT5SRRSL7f3cpZkP4lYrkz/yf+gOnMzT5Lvi38StHff1YCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7a2MHGx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so42339561fa.3;
        Mon, 04 Nov 2024 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755219; x=1731360019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo3XbQnXPNJgTn+edeHCGinHSuyv/nW/EU54SGOsWYg=;
        b=U7a2MHGxLf6+eRiXEvyh/uPLGhJ+VthBJC3gXSBkmmofn1hz4f6fyb13Des+MECK00
         WhEykGNsf1n3VMd3x7oACLy5gL8BrGrzD2uLP+jmLsw/6jLu31OngCPzOCUMQmJf1FjT
         KGLSZxb9kDw0H5Is6v4yb+Fn5srjCujETLWMotxSKR2mC53AacbQPhu9GaPHCUVMPDlq
         7WfIBWbGX3GYNW4NX8sSedbHJAObbtYg3x6OwucP8cU1NIvWSth4FFpMlfmDUO8P2C5H
         eRXLGm4ooLH5p3+j6cHPQp1fWRslPiZe776dXrMIOwjseyqSNYeSVf1Szj1o6I3oyLfr
         5qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755219; x=1731360019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mo3XbQnXPNJgTn+edeHCGinHSuyv/nW/EU54SGOsWYg=;
        b=Om5QkRZYa6n2kHWPg00AFUUz1JnIpsfe6Rj5julBaDfAUUJtWdC7ImM1uvbFvzyOCK
         51Sk/mHScOJ7Ix5BX6OVg7fBxO0LH/E35Bcxs/g7r4q8xGCBLXewlbShAo4BUeZwT3hY
         aX5aNH+Jw+bLDvoY60NF7dFVMKcBXTB4il3+uJvn8kHNNEKzMOHTMr9ij4bY1mR1OhEC
         fW2uo26YXrvL1vTtGUog2JpJEVxiz7fF431zMYhmFS//k0ReYuwyuvfqU6EBTDOsdO/H
         Z8T30a06377W+LoLdCMus5YwbYqf6XZAUXcXfS8dkQpNltKUp8QCjoz5yGloA/alA24T
         a21A==
X-Forwarded-Encrypted: i=1; AJvYcCWdc+s8ZBgllKBSvlNqDpU+k/exyl4IdsDxO3DVH5nsp7b7sewLZwKjjKDVDeEu8cWRsNekllHV+E3dfVE=@vger.kernel.org, AJvYcCXWCB1cWRWzF35fIIm2amQ/FT2AscSuwwx2t3V497KFNDDNBDSLIyvPtTSSyNuu2GidskeECHJH3nVnv+EIOYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywaThzZDSKClx12vTelOh4923XeK+7pDeBl8BRpygAmb0/0pi9
	NXw8o1jnpoi0GhV7u9hl4oPai0crGsIIhqGEA37/8Y+SrHYZ7blga3LI8+VBd3jgq7J+/+Rdc/K
	z5kwhIO8ADLS2gpxGi+NU0Kr+I2c=
X-Google-Smtp-Source: AGHT+IGEnQRleiUK+bDc5XsJLFoXEu8sezFpNQJYh8P4+YtRF+9gEsSGsAJfFIJByaSv4HbYgKHnCm2c0R6VUQCf2hE=
X-Received: by 2002:a05:651c:50c:b0:2fb:8920:99c6 with SMTP id
 38308e7fff4ca-2fdec85890bmr79774071fa.23.1730755218293; Mon, 04 Nov 2024
 13:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <KJyhrgAd_z6Zh0U1iafSryM8P_vhgxML3COlPRUtks83dD0fidaO7EfCaNWqQLhVcN0hqekp3v6qmakvURvCsA==@protonmail.internalid>
 <20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com> <87frocpsui.fsf@kernel.org>
 <oMImkzhVI8Suke0P43bPXzVQrUiKWfFjEEqD2PrWWWx9qnyLx0rwCtjbgxRSdempiC-jexN26NFzejD5bFTiMw==@protonmail.internalid>
 <CAJ-ks9mrHuBEGvCi8pTNE=P1YHU81+cWF_emAvOKnsW0wQSWMQ@mail.gmail.com> <87cyjfnl8d.fsf@kernel.org>
In-Reply-To: <87cyjfnl8d.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 4 Nov 2024 17:19:42 -0400
Message-ID: <CAJ-ks9n9g+QgH=YMkeenm5219sCAK5v8-gaOh46r=E9snbR2iQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: types: avoid `as` casts, narrow unsafe scope
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:21=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > On Thu, Oct 31, 2024 at 4:51=E2=80=AFAM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
> >> Hi Tamir,
> >>
> >> "Tamir Duberstein" <tamird@gmail.com> writes:
> >>
> >> > Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
> >> >
> >> > Reduce the scope of unsafe blocks and add missing safety comments wh=
ere
> >> > an unsafe block has been split into several unsafe blocks.
> >> >
> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >> > ---
> >> >  rust/kernel/alloc/kbox.rs | 32 +++++++++++++++----------
> >> >  rust/kernel/sync/arc.rs   | 59 +++++++++++++++++++++++++++++-------=
-----------
> >> >  rust/kernel/types.rs      |  5 ++--
> >> >  3 files changed, 59 insertions(+), 37 deletions(-)
> >> >
> >> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> >> > index d69c32496b86a2315f81cafc8e6771ebb0cf10d1..7a5fdf7b660fb91ca2a8=
e5023d69d629b0d66062 100644
> >> > --- a/rust/kernel/alloc/kbox.rs
> >> > +++ b/rust/kernel/alloc/kbox.rs
> >> > @@ -182,12 +182,12 @@ impl<T, A> Box<MaybeUninit<T>, A>
> >> >      ///
> >> >      /// Callers must ensure that the value inside of `b` is in an i=
nitialized state.
> >> >      pub unsafe fn assume_init(self) -> Box<T, A> {
> >> > -        let raw =3D Self::into_raw(self);
> >> > +        let raw =3D Self::into_raw(self).cast();
> >> >
> >> >          // SAFETY: `raw` comes from a previous call to `Box::into_r=
aw`. By the safety requirements
> >> >          // of this function, the value inside the `Box` is in an in=
itialized state. Hence, it is
> >> >          // safe to reconstruct the `Box` as `Box<T, A>`.
> >> > -        unsafe { Box::from_raw(raw.cast()) }
> >> > +        unsafe { Box::from_raw(raw) }
> >>
> >> I don't think this change makes sense, and it also does not do what th=
e
> >> commit message says. The patch has quite a few changes of this pattern=
,
> >> and I think you should drop those changes from the patch.
> >
> > It's reducing the scope of the unsafe block, as mentioned in the commit=
 message.
>
> I guess you are right. I read the commit message semantically as "split
> unsafe blocks where there are multiple unsafe operations". I still do
> not think it makes sense to do these code movements.
>
> >
> >> I _do_ think changing `as _` to `ptr::cast` makes sense.
> >>
> >> >      }
> >> >
> >> >      /// Writes the value and converts to `Box<T, A>`.
> >> > @@ -247,10 +247,10 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<B=
ox<T, A>>, AllocError>
> >> >
> >> >      /// Forgets the contents (does not run the destructor), but kee=
ps the allocation.
> >> >      fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
> >> > -        let ptr =3D Self::into_raw(this);
> >> > +        let ptr =3D Self::into_raw(this).cast();
> >> >
> >> >          // SAFETY: `ptr` is valid, because it came from `Box::into_=
raw`.
> >> > -        unsafe { Box::from_raw(ptr.cast()) }
> >> > +        unsafe { Box::from_raw(ptr) }
> >> >      }
> >> >
> >> >      /// Drops the contents, but keeps the allocation.
> >> > @@ -356,19 +356,21 @@ impl<T: 'static, A> ForeignOwnable for Box<T, =
A>
> >> >      type Borrowed<'a> =3D &'a T;
> >> >
> >> >      fn into_foreign(self) -> *const core::ffi::c_void {
> >> > -        Box::into_raw(self) as _
> >> > +        Box::into_raw(self).cast_const().cast()
> >>
> >> But since we are at it, why not be more explicit and do `cast::<core::=
ffi:c_void>`?
> >
> > These functions (`cast`, `cast_const`, and `cast_mut`) exist as a
> > compromise between fully inferred and fully explicit type coercion.
> > The doc comment on `cast_mut` explains:
> >
> > /// This is a bit safer than as because it wouldn=E2=80=99t silently ch=
ange
> > the type if the code is refactored. [0]
> >
> > The inverse is true of `cast` - it won't silently change the constness
> > if the code is refactored.
> >
> > The purpose of this patch is to demonstrate the number of places where
> > both type and constness casting is taking place, and to set up the
> > removal of costness casts in a subsequent patch.
>
> I agree that `cast_const`, `cast_mut` and `cast` is an improvement to `as
> _`. But I think we would get even more robustness if we went with fully
> qualifying the generic parameter as in `.cast::<core::ffi::c_void>`.

I'd prefer not to make this series more controversial with that
change. Since we all agree that `as` casts are better avoided, I'll do
only that here.

> >
> >>
> >> <cut>
> >>
> >> > @@ -347,9 +352,11 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_v=
oid) -> ArcBorrow<'a, T> {
> >> >      }
> >> >
> >> >      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> >> > +        let ptr =3D ptr.cast_mut().cast();
> >> > +
> >> >          // SAFETY: The safety requirements of this function ensure =
that `ptr` comes from a previous
> >> >          // call to `Self::into_foreign`.
> >> > -        let inner =3D unsafe { NonNull::new_unchecked(ptr as _) };
> >> > +        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> >> >
> >> >          // SAFETY: By the safety requirement of this function, we k=
now that `ptr` came from
> >> >          // a previous call to `Arc::into_foreign`, which guarantees=
 that `ptr` is valid and
> >> > @@ -376,10 +383,14 @@ fn as_ref(&self) -> &T {
> >> >
> >> >  impl<T: ?Sized> Clone for Arc<T> {
> >> >      fn clone(&self) -> Self {
> >> > +        // SAFETY: By the type invariant, there is necessarily a re=
ference to the object, so it is
> >> > +        // safe to dereference it.
> >>
> >> I think it could be "By the type invariant and the existence of `&self=
`,
> >> it is safe to create a shared reference to the object pointed to by
> >> `self.ptr`."
> >
> > This comment was taken from the `Deref` impl just above. Should it be
> > updated there as well? The comment is contained in the `Drop` impl as
> > well.
>
> I did not realize it was a copy.
>
> I think the type invariant is actually not well formed:
>
> /// # Invariants
> ///
> /// The reference count on an instance of [`Arc`] is always non-zero.
>
> There is not a reference count on an instance of `Arc`, there is a count
> on `ArcInner`, of which `Arc` owns one.
>
> What do you think?

I think this is picking nits. The next line is similarly "malformed":

/// The object pointed to by [`Arc`] is always pinned.

There's no object pointed to by Arc, it is pointed to by ArcInner.

> I am OK with you copying the comment from `Deref`, but if you want to,
> you could fix the wording of the invariant and update the comments.

It's not crystal clear to me what the difference between these
wordings is, so I'll just leave it as-is. Perhaps you could update all
the phrasing in a separate patch?

> In that case the safety comment could be something like my suggestion.
> The fact that a reference to the `Arc` is live combined with the
> invariant is what guarantees the pointee of `self.ptr` is live as well.
>
> Best regards,
> Andreas Hindborg

Cheers.
Tamir


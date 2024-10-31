Return-Path: <linux-kernel+bounces-390447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C89B7A06
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73521C21ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9619C543;
	Thu, 31 Oct 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNz8rdeW"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BCF19AD89;
	Thu, 31 Oct 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375467; cv=none; b=YZBMYexqQFYksqZnibiMNxfd4YCE874dzvfktHvxnd4A5u9fvW6/OvHu2YmRKMryZJmHDHIz62MRDMAC1MoA73+ZPLp9Ao/BwMIS/o3+mLZkmjI69v20/jyU5+saeIOe2hJDThQD/qcTwTHsHoTTGu/AbNo+Wgll70pbmNh8S4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375467; c=relaxed/simple;
	bh=zZcIyMiPbOnKM2cuGZ0wCC2mHmVyVKKxbAWex7UXd4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWD0BcFOulIGYk4g4Sdjv4e4uE9BoLWN3zG2TYk7U13d2xL9aHi2QKybsyD0wNdQaSl5NXSTxnc9PJMcaZwGhC9O9lNm1RYRL5hOM5bHfT7pQsfCxVXvGKTXj7gB3tlk/nNU7C7BNYCePXUj5fmZapVcNB0+7XiVN/Ip1/0fYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNz8rdeW; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso9138391fa.0;
        Thu, 31 Oct 2024 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730375463; x=1730980263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plSye77KWeY4jld03CzbnOJTPipsRUWcox69aurs8ZA=;
        b=gNz8rdeW987sEiYt6rr7LtPIi3KkysfLAYexaq0VkeCos/dlysetmzv0BV90o8DMxp
         Zdy/2qK+fdaUE+/SsnjZzs7xm15gG3gxHvQY1IjUqZZVR1Tvp/nrWwgbQQkhbwoDl8h7
         UU1g7ZzEgsjGGvP20e1pA0XctaSs7CDLCZbaXVdxcDPO7WkYaGiFSy/pPLGHI+gfsl2O
         AETRUodGzV5VjqezX4yU5lKnuXjCbLgdIQpTGYg2rG7VxF07QIAzt5BWAmaTkPtOYE8j
         63vutXvgwq+fcPT2PZA1gCIbuXtsQjxVKn/2Um5G5K4OJvpgKQH3ZXrAGD0Gk+5Er23D
         7u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730375463; x=1730980263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plSye77KWeY4jld03CzbnOJTPipsRUWcox69aurs8ZA=;
        b=ZmKb3OZlkWfKhucEChRqBhsYEuQ+FxfHfuew90hO7d0Brumb8x6kT4I/u9e5mgJdWI
         kC4BmDNpu+Ee9nneALG1Vmh8bJENOWoFzSHFurrRxUtURyE1/GHmAtyktdeoYEUQK9zr
         6uccGggpuykUD7xiYBSfhDsLlnrTpyci48FlYVpUfUylS9m5QYBmLvoWSfAg8qsIA9qE
         Pw2asUNlJfN6PT/nGN/CrJgNzOUU+BX6Vq+fJH2DVnz2MdyA3+qQL5b7skj2wT1RRXam
         1UDxmkTs8vRCGhoFeGn06NK/iJuZcJcZ04BTddquxwTWtosuXxTPZ09cFXaQYGfLvpLi
         IOyA==
X-Forwarded-Encrypted: i=1; AJvYcCUu0sIRUCsrY6XUKc1kst65UP1u42iCTpw58BlpqV+dDF17cVr4X1bNJr3liG5pewnj8Qu6yL5iBFFKKAs=@vger.kernel.org, AJvYcCXiEsd6ehK6Ms6lwboFEFyRF5mkPvonorxR0hhOj4TssQbFjX6tSqo2GfHW/UHFxgPXcw9uE/Kunh3aJjfuA0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhOPxzMHeqd5brqpxGf9UIlmWjFu+mDlSalC1AYQW3JRHhN1i
	eyxcw38moEHTcxhgWyZMd/v2KEFGVdTbRs1/+7qv+l/lYaiCboW1eIdcgJ/vJU999g0sU5LCeDP
	hmtVMKM/OsLN2XJfVcgW4wy5brjU=
X-Google-Smtp-Source: AGHT+IFeOj7xn2WZIWnbdXVMtLHHC3syWav4q+UEwRfqBrXsDx9TmK2gldq/ldWbxhu5kviYSlZX/G63ck3gFBWoiKg=
X-Received: by 2002:a2e:be8a:0:b0:2fb:5d19:4689 with SMTP id
 38308e7fff4ca-2fdef22284amr7253761fa.1.1730375462299; Thu, 31 Oct 2024
 04:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <KJyhrgAd_z6Zh0U1iafSryM8P_vhgxML3COlPRUtks83dD0fidaO7EfCaNWqQLhVcN0hqekp3v6qmakvURvCsA==@protonmail.internalid>
 <20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com> <87frocpsui.fsf@kernel.org>
In-Reply-To: <87frocpsui.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 31 Oct 2024 07:50:26 -0400
Message-ID: <CAJ-ks9mrHuBEGvCi8pTNE=P1YHU81+cWF_emAvOKnsW0wQSWMQ@mail.gmail.com>
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

On Thu, Oct 31, 2024 at 4:51=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Hi Tamir,
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
> >
> > Reduce the scope of unsafe blocks and add missing safety comments where
> > an unsafe block has been split into several unsafe blocks.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kbox.rs | 32 +++++++++++++++----------
> >  rust/kernel/sync/arc.rs   | 59 +++++++++++++++++++++++++++++----------=
--------
> >  rust/kernel/types.rs      |  5 ++--
> >  3 files changed, 59 insertions(+), 37 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> > index d69c32496b86a2315f81cafc8e6771ebb0cf10d1..7a5fdf7b660fb91ca2a8e50=
23d69d629b0d66062 100644
> > --- a/rust/kernel/alloc/kbox.rs
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -182,12 +182,12 @@ impl<T, A> Box<MaybeUninit<T>, A>
> >      ///
> >      /// Callers must ensure that the value inside of `b` is in an init=
ialized state.
> >      pub unsafe fn assume_init(self) -> Box<T, A> {
> > -        let raw =3D Self::into_raw(self);
> > +        let raw =3D Self::into_raw(self).cast();
> >
> >          // SAFETY: `raw` comes from a previous call to `Box::into_raw`=
. By the safety requirements
> >          // of this function, the value inside the `Box` is in an initi=
alized state. Hence, it is
> >          // safe to reconstruct the `Box` as `Box<T, A>`.
> > -        unsafe { Box::from_raw(raw.cast()) }
> > +        unsafe { Box::from_raw(raw) }
>
> I don't think this change makes sense, and it also does not do what the
> commit message says. The patch has quite a few changes of this pattern,
> and I think you should drop those changes from the patch.

It's reducing the scope of the unsafe block, as mentioned in the commit mes=
sage.

> I _do_ think changing `as _` to `ptr::cast` makes sense.
>
> >      }
> >
> >      /// Writes the value and converts to `Box<T, A>`.
> > @@ -247,10 +247,10 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<=
T, A>>, AllocError>
> >
> >      /// Forgets the contents (does not run the destructor), but keeps =
the allocation.
> >      fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
> > -        let ptr =3D Self::into_raw(this);
> > +        let ptr =3D Self::into_raw(this).cast();
> >
> >          // SAFETY: `ptr` is valid, because it came from `Box::into_raw=
`.
> > -        unsafe { Box::from_raw(ptr.cast()) }
> > +        unsafe { Box::from_raw(ptr) }
> >      }
> >
> >      /// Drops the contents, but keeps the allocation.
> > @@ -356,19 +356,21 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
> >      type Borrowed<'a> =3D &'a T;
> >
> >      fn into_foreign(self) -> *const core::ffi::c_void {
> > -        Box::into_raw(self) as _
> > +        Box::into_raw(self).cast_const().cast()
>
> But since we are at it, why not be more explicit and do `cast::<core::ffi=
:c_void>`?

These functions (`cast`, `cast_const`, and `cast_mut`) exist as a
compromise between fully inferred and fully explicit type coercion.
The doc comment on `cast_mut` explains:

/// This is a bit safer than as because it wouldn=E2=80=99t silently change
the type if the code is refactored. [0]

The inverse is true of `cast` - it won't silently change the constness
if the code is refactored.

The purpose of this patch is to demonstrate the number of places where
both type and constness casting is taking place, and to set up the
removal of costness casts in a subsequent patch.

>
> <cut>
>
> > @@ -347,9 +352,11 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void=
) -> ArcBorrow<'a, T> {
> >      }
> >
> >      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > +        let ptr =3D ptr.cast_mut().cast();
> > +
> >          // SAFETY: The safety requirements of this function ensure tha=
t `ptr` comes from a previous
> >          // call to `Self::into_foreign`.
> > -        let inner =3D unsafe { NonNull::new_unchecked(ptr as _) };
> > +        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> >
> >          // SAFETY: By the safety requirement of this function, we know=
 that `ptr` came from
> >          // a previous call to `Arc::into_foreign`, which guarantees th=
at `ptr` is valid and
> > @@ -376,10 +383,14 @@ fn as_ref(&self) -> &T {
> >
> >  impl<T: ?Sized> Clone for Arc<T> {
> >      fn clone(&self) -> Self {
> > +        // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object, so it is
> > +        // safe to dereference it.
>
> I think it could be "By the type invariant and the existence of `&self`,
> it is safe to create a shared reference to the object pointed to by
> `self.ptr`."

This comment was taken from the `Deref` impl just above. Should it be
updated there as well? The comment is contained in the `Drop` impl as
well.

>
> <cut>
>
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index fae80814fa1c5e0f11933f2f15e173f0e3a10fe0..e8b7ff1387381e50d796397=
8e57b1d567113b035 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -418,7 +418,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> >      /// }
> >      ///
> >      /// let mut data =3D Empty {};
> > -    /// let ptr =3D NonNull::<Empty>::new(&mut data as *mut _).unwrap(=
);
> > +    /// let ptr =3D NonNull::new(&mut data).unwrap();
> >      /// # // SAFETY: TODO.
> >      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
> >      /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
> > @@ -450,8 +450,9 @@ fn deref(&self) -> &Self::Target {
> >  impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
> >      fn from(b: &T) -> Self {
> >          b.inc_ref();
> > +        let b =3D b.into();
> >          // SAFETY: We just incremented the refcount above.
> > -        unsafe { Self::from_raw(NonNull::from(b)) }
> > +        unsafe { Self::from_raw(b) }
>
> I think this change makes the code _less_ readable.
>
>
> Best regards,
> Andreas
>
>

Link: https://doc.rust-lang.org/stable/std/primitive.pointer.html#method.ca=
st_mut
[0]


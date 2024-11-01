Return-Path: <linux-kernel+bounces-392283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D619B91E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E10283072
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E519D089;
	Fri,  1 Nov 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFJivsXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86462175B1;
	Fri,  1 Nov 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467278; cv=none; b=d6vKhQ/T72PNNS5RvBfPm7O/5GYOYjgV8gMtCgwT4mEDvu9Ilh2EEeXW+hvlPnEEgFL3QiBFVGiKxYCTlApHCHutGk18+3uAX6zYpdJv1i3vbFEcrD4mVQTA9K54LJnJ9taRjhRtBswf6tyrO6iH3y2jSI6B6h2LFZnp2i3jygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467278; c=relaxed/simple;
	bh=GS8v4LBA28M1KDHq6fr9UYdlqdhff/Y22lq833IgKFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DtGxaF2epmahEif6bDi6F2BXzoviunQAcxzrIzeyMuIIyVqhLh/XzxQxO9POXkmILbeBk6UijCh3SgZLH+I13EF8rZSt9Gg5uI9NfhyyHjrp3+zoaHuFeAQNpGNZwEjcQrId1N9vDE9Z0JxmMbwm2hlR7hONwChUt1mWNwXa3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFJivsXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB0C4CECD;
	Fri,  1 Nov 2024 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730467278;
	bh=GS8v4LBA28M1KDHq6fr9UYdlqdhff/Y22lq833IgKFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gFJivsXp2fg1DmpZOi0RG8INEqji7ihl/EkRKiZPDDJyA9jdl+e19nPWUPCN/zAt6
	 7pNWYo0Ruk641070YtjVcG5bw/wMqsojJ/VpTTv/LP1uveaqpwkAli7ZSUqe9RwYe6
	 McI5Si93a2B6O1hTkoi8A7Fm0vGdaRg+hyePviKyLf1hxVZtzqVPd3WQ3DInRLkEfc
	 74l1lKXaVlt+/Ej3HlzlAB6MKSjzGV4nr2imWHWpMPvU2OEy+8ZNyUuf6XQm0s2IFc
	 3XpcupbJ/g78bQka0+ogkNrzWY7DlaKQ7/DQSA0mwvtbnD2/3WtFPRN3y/wxjKNgJb
	 T5ZFzForSRo/A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] rust: types: avoid `as` casts, narrow unsafe scope
In-Reply-To: <CAJ-ks9mrHuBEGvCi8pTNE=P1YHU81+cWF_emAvOKnsW0wQSWMQ@mail.gmail.com>
 (Tamir
	Duberstein's message of "Thu, 31 Oct 2024 07:50:26 -0400")
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<KJyhrgAd_z6Zh0U1iafSryM8P_vhgxML3COlPRUtks83dD0fidaO7EfCaNWqQLhVcN0hqekp3v6qmakvURvCsA==@protonmail.internalid>
	<20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com>
	<87frocpsui.fsf@kernel.org>
	<oMImkzhVI8Suke0P43bPXzVQrUiKWfFjEEqD2PrWWWx9qnyLx0rwCtjbgxRSdempiC-jexN26NFzejD5bFTiMw==@protonmail.internalid>
	<CAJ-ks9mrHuBEGvCi8pTNE=P1YHU81+cWF_emAvOKnsW0wQSWMQ@mail.gmail.com>
Date: Fri, 01 Nov 2024 14:21:06 +0100
Message-ID: <87cyjfnl8d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Thu, Oct 31, 2024 at 4:51=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Hi Tamir,
>>
>> "Tamir Duberstein" <tamird@gmail.com> writes:
>>
>> > Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
>> >
>> > Reduce the scope of unsafe blocks and add missing safety comments where
>> > an unsafe block has been split into several unsafe blocks.
>> >
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  rust/kernel/alloc/kbox.rs | 32 +++++++++++++++----------
>> >  rust/kernel/sync/arc.rs   | 59 +++++++++++++++++++++++++++++---------=
---------
>> >  rust/kernel/types.rs      |  5 ++--
>> >  3 files changed, 59 insertions(+), 37 deletions(-)
>> >
>> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>> > index d69c32496b86a2315f81cafc8e6771ebb0cf10d1..7a5fdf7b660fb91ca2a8e5=
023d69d629b0d66062 100644
>> > --- a/rust/kernel/alloc/kbox.rs
>> > +++ b/rust/kernel/alloc/kbox.rs
>> > @@ -182,12 +182,12 @@ impl<T, A> Box<MaybeUninit<T>, A>
>> >      ///
>> >      /// Callers must ensure that the value inside of `b` is in an ini=
tialized state.
>> >      pub unsafe fn assume_init(self) -> Box<T, A> {
>> > -        let raw =3D Self::into_raw(self);
>> > +        let raw =3D Self::into_raw(self).cast();
>> >
>> >          // SAFETY: `raw` comes from a previous call to `Box::into_raw=
`. By the safety requirements
>> >          // of this function, the value inside the `Box` is in an init=
ialized state. Hence, it is
>> >          // safe to reconstruct the `Box` as `Box<T, A>`.
>> > -        unsafe { Box::from_raw(raw.cast()) }
>> > +        unsafe { Box::from_raw(raw) }
>>
>> I don't think this change makes sense, and it also does not do what the
>> commit message says. The patch has quite a few changes of this pattern,
>> and I think you should drop those changes from the patch.
>
> It's reducing the scope of the unsafe block, as mentioned in the commit m=
essage.

I guess you are right. I read the commit message semantically as "split
unsafe blocks where there are multiple unsafe operations". I still do
not think it makes sense to do these code movements.

>
>> I _do_ think changing `as _` to `ptr::cast` makes sense.
>>
>> >      }
>> >
>> >      /// Writes the value and converts to `Box<T, A>`.
>> > @@ -247,10 +247,10 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box=
<T, A>>, AllocError>
>> >
>> >      /// Forgets the contents (does not run the destructor), but keeps=
 the allocation.
>> >      fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
>> > -        let ptr =3D Self::into_raw(this);
>> > +        let ptr =3D Self::into_raw(this).cast();
>> >
>> >          // SAFETY: `ptr` is valid, because it came from `Box::into_ra=
w`.
>> > -        unsafe { Box::from_raw(ptr.cast()) }
>> > +        unsafe { Box::from_raw(ptr) }
>> >      }
>> >
>> >      /// Drops the contents, but keeps the allocation.
>> > @@ -356,19 +356,21 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
>> >      type Borrowed<'a> =3D &'a T;
>> >
>> >      fn into_foreign(self) -> *const core::ffi::c_void {
>> > -        Box::into_raw(self) as _
>> > +        Box::into_raw(self).cast_const().cast()
>>
>> But since we are at it, why not be more explicit and do `cast::<core::ff=
i:c_void>`?
>
> These functions (`cast`, `cast_const`, and `cast_mut`) exist as a
> compromise between fully inferred and fully explicit type coercion.
> The doc comment on `cast_mut` explains:
>
> /// This is a bit safer than as because it wouldn=E2=80=99t silently chan=
ge
> the type if the code is refactored. [0]
>
> The inverse is true of `cast` - it won't silently change the constness
> if the code is refactored.
>
> The purpose of this patch is to demonstrate the number of places where
> both type and constness casting is taking place, and to set up the
> removal of costness casts in a subsequent patch.

I agree that `cast_const`, `cast_mut` and `cast` is an improvement to `as
_`. But I think we would get even more robustness if we went with fully
qualifying the generic parameter as in `.cast::<core::ffi::c_void>`.

>
>>
>> <cut>
>>
>> > @@ -347,9 +352,11 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_voi=
d) -> ArcBorrow<'a, T> {
>> >      }
>> >
>> >      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
>> > +        let ptr =3D ptr.cast_mut().cast();
>> > +
>> >          // SAFETY: The safety requirements of this function ensure th=
at `ptr` comes from a previous
>> >          // call to `Self::into_foreign`.
>> > -        let inner =3D unsafe { NonNull::new_unchecked(ptr as _) };
>> > +        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
>> >
>> >          // SAFETY: By the safety requirement of this function, we kno=
w that `ptr` came from
>> >          // a previous call to `Arc::into_foreign`, which guarantees t=
hat `ptr` is valid and
>> > @@ -376,10 +383,14 @@ fn as_ref(&self) -> &T {
>> >
>> >  impl<T: ?Sized> Clone for Arc<T> {
>> >      fn clone(&self) -> Self {
>> > +        // SAFETY: By the type invariant, there is necessarily a refe=
rence to the object, so it is
>> > +        // safe to dereference it.
>>
>> I think it could be "By the type invariant and the existence of `&self`,
>> it is safe to create a shared reference to the object pointed to by
>> `self.ptr`."
>
> This comment was taken from the `Deref` impl just above. Should it be
> updated there as well? The comment is contained in the `Drop` impl as
> well.

I did not realize it was a copy.

I think the type invariant is actually not well formed:

/// # Invariants
///
/// The reference count on an instance of [`Arc`] is always non-zero.

There is not a reference count on an instance of `Arc`, there is a count
on `ArcInner`, of which `Arc` owns one.

What do you think?

I am OK with you copying the comment from `Deref`, but if you want to,
you could fix the wording of the invariant and update the comments.

In that case the safety comment could be something like my suggestion.
The fact that a reference to the `Arc` is live combined with the
invariant is what guarantees the pointee of `self.ptr` is live as well.

Best regards,
Andreas Hindborg



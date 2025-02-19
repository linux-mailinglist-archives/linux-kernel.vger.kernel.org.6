Return-Path: <linux-kernel+bounces-522592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2512BA3CC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F563B4B45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0E23C393;
	Wed, 19 Feb 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id8XpDkI"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CD235341;
	Wed, 19 Feb 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003171; cv=none; b=J3G1YgeRZ0fdD6EiObwTsyQL4Te0DDsuKbrl8AoO/hn5Q6hYwbj9gRaGd7uedqpjXrVUXud1izcOSvWUVCZxLjInNI6V/IsR18J/q3DKEcdfFmt5a06Qm+c+IrAczkUc34uGRtbJ0apiHPi2rEhw4jK22wl136kgQjjgs9sr7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003171; c=relaxed/simple;
	bh=c+A+Sen05MwdGsybGVz4QGuNyPIh4f7uHp4qCz0u/OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AooZ6OJT1TEYfTm599BcUovhaBb328gDiJmwUF4QIqYjIrF6wJXmnAMbCr3UyMIDFyPu1qOGiUPxvlE2tr6h6hdkRmCf5Y/prFt3IK4/zccUR9yWv66pweSX/0h8g5fB1vekQ+5knL550uBF/Y1tX2vvd/4gaufwHYiMsrDyD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id8XpDkI; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30737db1aa9so2313561fa.1;
        Wed, 19 Feb 2025 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740003167; x=1740607967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIKBRHMcOqSVIdfOy3zE27b+P7n2oksvV9ggqE8kB6o=;
        b=id8XpDkIb98QpVoF8FF9N/Jwvhgku4TMHSNH8bxuJAX9PjeQSnZpRuU4MURHGcZyFU
         LvLylgC+Bw9gk+xDgsdMj1t3RWKf2Eg9XChSBe3nUtYuFLl/8Esl0Lp1iS7b9AAGkPjT
         g25lqq8fdTUj3j4eByS3mUrgir3jDYaA2ZlKbYF1mg+6d6UZgap7FlNXlPV9YCs6qUOA
         k6WmSRK2GGePI3b52RArFfKEaLh7PNo9y5ILwiLTUgbMxyKXxCUnq2hzx7b8HZnNseK8
         AOdvO5p8HFMW9+jF5ZSSv1PbFw4axXZEsYW47Q6pEbX/lDPD8YsUfllt9rAG2sVx9X42
         A/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003167; x=1740607967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIKBRHMcOqSVIdfOy3zE27b+P7n2oksvV9ggqE8kB6o=;
        b=XPnLg0e0YwsZ5W6WRuJg6fW0lMiU1Zv85kSVGgfA/ShcxFCZ8taKeHExu1/gmQbsFM
         iYgvRH0m551JqrmerFY8Q1RuSRk0FEySbw3WmCVUBEftzHCTpFFRMHcyGaK58Lt75Bh0
         mP6RPvo3P5oCbHijQmhBOw3euYiZad6GNG2kX+sdDeW+yzufI6TEVM1cuobHJ8xlIx4j
         tVYAKSEbdi7AXb+iMSQVN0pDP8nir3XekZPmB3QEnFFAsg7aQU8rz3aid+dJ/HWU8c18
         y6+TIwA9tdaS4hwGmWMd9fKlOO0KCPMCbHfePI00LsAgn9RIUbyLtMP3w7vdCca06MN6
         JYkA==
X-Forwarded-Encrypted: i=1; AJvYcCUYxivMFANo6dsWhRAO4E1+ftucdbwGap1/sHkJduoZMvTRTk0mDEzJyqi1hGf2IbdtBXODQHXfGJEyuwnSf5w=@vger.kernel.org, AJvYcCUrnPqLNzjrlyKctfvhO2gFRb4n6YsGg91JHHk82PUZkVIM2He2Wd6IF4romsHVceLhxn2/82/varAR278=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHy6OFZBxrUVStxSYtqJL1ir5bT/uDIHF8SQ+Fi1BGuUPBhuzE
	WG+N8jXfuYyQBKCDG0HHvVFHmFPW0oUnGs00JuAdi0rAk4A/pp03TiuX33B2la+xt1biNa+qdYJ
	cMTITgRNktbsIezbllfpBPvOUmGo=
X-Gm-Gg: ASbGnctp8xiTFOxqZAiERDytP0KK1BezlUtByMX8DISQ9WVfQhLZR+nflJYOcFlprFt
	/SaxgKntdKBQs81MvxoJt65+d5zSM6wz/0TbKnU0BbD2PaLIQKgJfw2M7G7I0DnX/JAHD4Lujd/
	DBymJB2j0A5gVR
X-Google-Smtp-Source: AGHT+IFLtX4yHsGsyOxSX8mpmfua0lhLcXVTvj9TgzcK4Mwq4JrkWyjZY+f79AqO9yva/1AiwVvZITBPILjdAWn6Ow8=
X-Received: by 2002:a2e:7206:0:b0:302:1cdd:73c6 with SMTP id
 38308e7fff4ca-30a44ed34d4mr17786141fa.20.1740003166972; Wed, 19 Feb 2025
 14:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-3-gary@garyguo.net>
In-Reply-To: <20250219201602.1898383-3-gary@garyguo.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Feb 2025 17:12:10 -0500
X-Gm-Features: AWEUYZmSeTADXrQZ9OhxAAoSUHqGwJ2KjAsCNPF-N3zoInkW0QEck3vsA1-kWvw
Message-ID: <CAJ-ks9npk8oSFHZHdViR1XhF+A8e2L+P0wCgmjE7mzAxS9WK1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: convert `Arc` to use `Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Alex Mantel <alexmantel93@mailbox.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> With `Refcount` type created, `Arc` can use `Refcount` instead of
> calling into FFI directly.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/sync/arc.rs | 65 +++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 39 deletions(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 3cefda7a4372..1f5fbc6b3742 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -8,7 +8,7 @@
>  //! threads.
>  //!
>  //! It is different from the standard library's [`Arc`] in a few ways:
> -//! 1. It is backed by the kernel's `refcount_t` type.
> +//! 1. It is backed by the kernel's [`Refcount`] type.
>  //! 2. It does not support weak references, which allows it to be half t=
he size.
>  //! 3. It saturates the reference count instead of aborting when it goes=
 over a threshold.
>  //! 4. It does not provide a `get_mut` method, so the ref counted object=
 is pinned.
> @@ -18,10 +18,10 @@
>
>  use crate::{
>      alloc::{AllocError, Flags, KBox},
> -    bindings,
>      init::{self, InPlaceInit, Init, PinInit},
> +    sync::Refcount,
>      try_init,
> -    types::{ForeignOwnable, Opaque},
> +    types::ForeignOwnable,
>  };
>  use core::{
>      alloc::Layout,
> @@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
>  #[pin_data]
>  #[repr(C)]
>  struct ArcInner<T: ?Sized> {
> -    refcount: Opaque<bindings::refcount_t>,
> +    refcount: Refcount,
>      data: T,
>  }
>
> @@ -155,7 +155,7 @@ impl<T: ?Sized> ArcInner<T> {
>      /// `ptr` must have been returned by a previous call to [`Arc::into_=
raw`], and the `Arc` must
>      /// not yet have been destroyed.
>      unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
> -        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> +        let refcount_layout =3D Layout::new::<Refcount>();
>          // SAFETY: The caller guarantees that the pointer is valid.
>          let val_layout =3D Layout::for_value(unsafe { &*ptr });
>          // SAFETY: We're computing the layout of a real struct that exis=
ted when compiling this
> @@ -207,8 +207,7 @@ impl<T> Arc<T> {
>      pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
>          // INVARIANT: The refcount is initialised to a non-zero value.
>          let value =3D ArcInner {
> -            // SAFETY: There are no safety requirements for this FFI cal=
l.
> -            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) })=
,
> +            refcount: Refcount::new(1),
>              data: contents,
>          };
>
> @@ -290,7 +289,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>      /// use kernel::sync::{Arc, UniqueArc};
>      ///
>      /// let arc =3D Arc::new(42, GFP_KERNEL)?;
> -    /// let unique_arc =3D arc.into_unique_or_drop();
> +    /// let unique_arc =3D Arc::into_unique_or_drop(arc);
>      ///
>      /// // The above conversion should succeed since refcount of `arc` i=
s 1.
>      /// assert!(unique_arc.is_some());
> @@ -306,35 +305,30 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>      /// let arc =3D Arc::new(42, GFP_KERNEL)?;
>      /// let another =3D arc.clone();
>      ///
> -    /// let unique_arc =3D arc.into_unique_or_drop();
> +    /// let unique_arc =3D Arc::into_unique_or_drop(arc);
>      ///
>      /// // The above conversion should fail since refcount of `arc` is >=
1.
>      /// assert!(unique_arc.is_none());
>      ///
>      /// # Ok::<(), Error>(())
>      /// ```
> -    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
> +    pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> =
{

Why did this signature need to change?

>          // We will manually manage the refcount in this method, so we di=
sable the destructor.
> -        let me =3D ManuallyDrop::new(self);
> +        let this =3D ManuallyDrop::new(this);
>          // SAFETY: We own a refcount, so the pointer is still valid.
> -        let refcount =3D unsafe { me.ptr.as_ref() }.refcount.get();
> +        let refcount =3D unsafe { &this.ptr.as_ref().refcount };
>
>          // If the refcount reaches a non-zero value, then we have destro=
yed this `Arc` and will
>          // return without further touching the `Arc`. If the refcount re=
aches zero, then there are
>          // no other arcs, and we can create a `UniqueArc`.
> -        //
> -        // SAFETY: We own a refcount, so the pointer is not dangling.
> -        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refcoun=
t) };
> -        if is_zero {
> -            // SAFETY: We have exclusive access to the arc, so we can pe=
rform unsynchronized
> -            // accesses to the refcount.
> -            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(=
1)) };
> +        if refcount.dec_and_test() {
> +            refcount.set(1);

We could retain the unsynchronized operation here by taking a mutable
reference above and writing through it. Right? Could we remove `set`
from the abstraction in the previous patch?

>
> -            // INVARIANT: We own the only refcount to this arc, so we ma=
y create a `UniqueArc`. We
> -            // must pin the `UniqueArc` because the values was previousl=
y in an `Arc`, and they pin
> -            // their values.
> +            // INVARIANT: If the refcount failed to decrement because it=
 is 1, then we have the
> +            // exclusive ownership, so we may create a `UniqueArc`. We m=
ust pin the `UniqueArc`
> +            // because the values was previously in an `Arc`, and they p=
in their values.

Pre-existing typo you're taking ownership of: "the values" should be
"the value". But why touch this comment at all?

>              Some(Pin::from(UniqueArc {
> -                inner: ManuallyDrop::into_inner(me),
> +                inner: ManuallyDrop::into_inner(this),
>              }))
>          } else {
>              None
> @@ -396,14 +390,10 @@ fn as_ref(&self) -> &T {
>
>  impl<T: ?Sized> Clone for Arc<T> {
>      fn clone(&self) -> Self {
> -        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
> -        // safe to dereference it.
> -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> -
> -        // INVARIANT: C `refcount_inc` saturates the refcount, so it can=
not overflow to zero.
> +        // INVARIANT: `Refcount` saturates the refcount, so it cannot ov=
erflow to zero.
>          // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
>          // safe to increment the refcount.
> -        unsafe { bindings::refcount_inc(refcount) };
> +        unsafe { self.ptr.as_ref().refcount.inc() };
>
>          // SAFETY: We just incremented the refcount. This increment is n=
ow owned by the new `Arc`.
>          unsafe { Self::from_inner(self.ptr) }
> @@ -412,16 +402,14 @@ fn clone(&self) -> Self {
>
>  impl<T: ?Sized> Drop for Arc<T> {
>      fn drop(&mut self) {
> -        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object. We cannot
> -        // touch `refcount` after it's decremented to a non-zero value b=
ecause another thread/CPU
> -        // may concurrently decrement it to zero and free it. It is ok t=
o have a raw pointer to
> -        // freed/invalid memory as long as it is never dereferenced.
> -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> -
>          // INVARIANT: If the refcount reaches zero, there are no other i=
nstances of `Arc`, and
>          // this instance is being dropped, so the broken invariant is no=
t observable.
> -        // SAFETY: Also by the type invariant, we are allowed to decreme=
nt the refcount.
> -        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refcoun=
t) };
> +        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object.
> +        // NOTE: we cannot touch `refcount` after it's decremented to a =
non-zero value because
> +        // another thread/CPU may concurrently decrement it to zero and =
free it. However it is okay
> +        // to have a transient reference to decrement the refcount, see
> +        // https://github.com/rust-lang/rust/issues/55005.
> +        let is_zero =3D unsafe { self.ptr.as_ref().refcount.dec_and_test=
() };

How come this careful handling is not required in into_unique_or_drop?
At least, the SAFETY comment there is much more mundane.

>          if is_zero {
>              // The count reached zero, we must free the memory.
>              //
> @@ -673,8 +661,7 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<M=
aybeUninit<T>>, AllocError>
>          // INVARIANT: The refcount is initialised to a non-zero value.
>          let inner =3D KBox::try_init::<AllocError>(
>              try_init!(ArcInner {
> -                // SAFETY: There are no safety requirements for this FFI=
 call.
> -                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1=
) }),
> +                refcount: Refcount::new(1),
>                  data <- init::uninit::<T, AllocError>(),
>              }? AllocError),
>              flags,
> --
> 2.47.2
>


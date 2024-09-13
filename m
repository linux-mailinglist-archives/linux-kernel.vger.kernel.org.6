Return-Path: <linux-kernel+bounces-328855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB69789F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EFE281689
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B6148316;
	Fri, 13 Sep 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zltOTJYO"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3312C54D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259498; cv=none; b=iu1WdPXNlWrDhTVdeaUY48J+rzWw391jSD0ShD13bH/kbu5Qkw1svvtOUhKkAtEITw/sE9+2JNwHuEX6oV8l/CMjgpHgNAQSMAnVYsokvrHi2VQ4Yy6Ku4YOyUNxYEUzBl73BhIQmF42T7M6Iz9bI/nFSZwzJIS5VSkkuQ7Fd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259498; c=relaxed/simple;
	bh=V+B3Q1mO6YXsH7aDvUqVMKegXFcHBT4wV+UdlpkVE14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nBANn22EYGl7ATfwX7Oiy3g/GyQE9ChZbWL07l+xmgwR7P9aoayCUj0WumLSihE3ZS5AdpEBlhlRgdlZ0xoTn4kcNGplOweWwLqFAMsqpa6OB0aKdVAMAeKarYVDadYLkT84kJqbw40Bp0eF22i5d9uUhOHdRUVfV1ozrYr7VoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zltOTJYO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371941bbfb0so1829903f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726259494; x=1726864294; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp0hM+TBi8EPvvh0ukI/PN3iFtwci/KfwR5JqGqtS98=;
        b=zltOTJYO6pd945h85Mgnkb9G+o3ZAptdpF/6lO1cXWcrhpT0wLZFFJCScHW3nQRi5U
         ATQundFejDWSUyeK+DeaagLAVjOEaisJmkbIfuYXaD2Ym1jzE7uLKgvSUggLLFUJkiiP
         StrQue17ZtQuS4XANxoZYc5Io5j61ve3HpTDRqX/CvdEH16DEjS+95IBVo8vOiAT4m/N
         G1DeHY23HX1zzvLqxMIYNhvGXF5CY5qH/HnxrlbXuFXunK0Dugx9GE83YjEP4NFJmMeQ
         eWllrmfRPRNhD79nVMZ9bJ/elprvcFOU0mkEU2I9xE8HHdLlTyTzFAKsuJ6lPTA8xQ8Q
         hfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726259494; x=1726864294;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp0hM+TBi8EPvvh0ukI/PN3iFtwci/KfwR5JqGqtS98=;
        b=o5/yk6qF9VAmxTnzePMteajZJkchafV5/OzHExGO+bUavcj8IZ8X5T9GlM+fn0PMYK
         mw0J6vx48C8rcnJThl776AKEmEsukpeLX+p7rb11WEb4UPmNCWmGkuViEw1u5uMlkb5T
         kr4+MlK0OoAgZeJjszuOVlfBCTC1uLolyr3uvYagg3E6OKqj+C5F5OuLXguL2NXvj/jU
         5DOYe/SO3G5n6LqRUkV3VjYe93Flpdq0PFsiNU8jwkcizrJRGNZZdQuIuqbqy5zzHT8Q
         gghCNLSwaz8WhVm/Hpb6ZCjpVvT9zol872RSg0sGj34XRxMETXGGC029vFUHCB8WoAmU
         ts/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRjjstAd7TlViB/SI6tm3IvRTtHH/T7j11GKun9zV0Ofqwf3g4zB0yU1WLGJKUphFRto+kAec65ZU0zm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMf2rIJLMo93R6oeHQPYKaDD6MV0rJeKW2k68OJljd89yqv4Y
	zG15qeO2sXW1FGFR/DUZFcsUM2UTHMHwvxBiiznnS8cHSW/wWTq1/DmTCIyULneRigW0sQFjaJl
	xleI07WKOnR5H6QeyB2ExIpLVHlU9qpyGdmiP
X-Google-Smtp-Source: AGHT+IF1fnPp9mwLpsUqju5x2gFBE+hqrz3Dt6yYJy5S9tNWMgR4qg6InTZcC0d9XddxCBbc+zqQtwEuta3AOEXvO18=
X-Received: by 2002:a5d:650c:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-378c2cd5b95mr4775105f8f.4.1726259493423; Fri, 13 Sep 2024
 13:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-shrinker-v1-1-18b7f1253553@google.com> <ZuSdcybAVM1Ix4bJ@phenom.ffwll.local>
In-Reply-To: <ZuSdcybAVM1Ix4bJ@phenom.ffwll.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Sep 2024 22:31:20 +0200
Message-ID: <CAH5fLgh7a7J8Z9xL1A-zY60Jv7kj73-OBM7VaMcy=1gq3y2bug@mail.gmail.com>
Subject: Re: [PATCH] rust: shrinker: add shrinker abstraction
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 10:15=E2=80=AFPM Simona Vetter <simona.vetter@ffwll=
.ch> wrote:
>
> On Thu, Sep 12, 2024 at 09:54:01AM +0000, Alice Ryhl wrote:
> > Rust Binder holds incoming transactions in a read-only mmap'd region
> > where it manually manages the pages. These pages are only in use until
> > the incoming transaction is consumed by userspace, but the kernel will
> > keep the pages around for future transactions. Rust Binder registers a
> > shrinker with the kernel so that it can give back these pages if the
> > system comes under memory pressure.
> >
> > Separate types are provided for registered and unregistered shrinkers.
> > The unregistered shrinker type can be used to configure the shrinker
> > before registering it. Separating it into two types also enables the
> > user to construct the private data between the calls to `shrinker_alloc=
`
> > and `shrinker_register` and avoid constructing the private data if
> > allocating the shrinker fails.
> >
> > The user specifies the callbacks in use by implementing the Shrinker
> > trait for the type used for the private data. This requires specifying
> > three things: implementations for count_objects and scan_objects, and
> > the pointer type that the private data will be wrapped in.
> >
> > The return values of count_objects and scan_objects are provided using
> > new types called CountObjects and ScanObjects respectively. These types
> > prevent the user from e.g. returning SHRINK_STOP from count_objects or
> > returning SHRINK_EMPTY from scan_objects.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Scary given that drm has a few, but I learned a few new thinks about
> shrinkers. Some comments below, but looks all really nice imo.
>
> Cheers, Sima
>
> > ---
> >  rust/bindings/bindings_helper.h |   2 +
> >  rust/kernel/lib.rs              |   1 +
> >  rust/kernel/shrinker.rs         | 324 ++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 327 insertions(+)
> >
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index ae82e9c941af..7fc958e05dc5 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -18,6 +18,7 @@
> >  #include <linux/phy.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sched.h>
> > +#include <linux/shrinker.h>
> >  #include <linux/slab.h>
> >  #include <linux/wait.h>
> >  #include <linux/workqueue.h>
> > @@ -31,4 +32,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT =3D =
GFP_KERNEL_ACCOUNT;
> >  const gfp_t RUST_CONST_HELPER_GFP_NOWAIT =3D GFP_NOWAIT;
> >  const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZERO;
> >  const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM =3D ___GFP_HIGHMEM;
> > +const gfp_t RUST_CONST_HELPER___GFP_FS =3D ___GFP_FS;
> >  const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D BLK_FEA=
T_ROTATIONAL;
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index f10b06a78b9d..f35eb290f2e0 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -45,6 +45,7 @@
> >  pub mod prelude;
> >  pub mod print;
> >  pub mod rbtree;
> > +pub mod shrinker;
> >  mod static_assert;
> >  #[doc(hidden)]
> >  pub mod std_vendor;
> > diff --git a/rust/kernel/shrinker.rs b/rust/kernel/shrinker.rs
> > new file mode 100644
> > index 000000000000..9af726bfe0b1
> > --- /dev/null
> > +++ b/rust/kernel/shrinker.rs
> > @@ -0,0 +1,324 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Shrinker for handling memory pressure.
> > +//!
> > +//! C header: [`include/linux/shrinker.h`](srctree/include/linux/shrin=
ker.h)
> > +
> > +use crate::{alloc::AllocError, bindings, c_str, str::CStr, types::Fore=
ignOwnable};
> > +
> > +use core::{
> > +    ffi::{c_int, c_ulong, c_void},
> > +    marker::PhantomData,
> > +    ptr::NonNull,
> > +};
> > +
> > +const SHRINK_STOP: c_ulong =3D bindings::SHRINK_STOP as c_ulong;
> > +const SHRINK_EMPTY: c_ulong =3D bindings::SHRINK_EMPTY as c_ulong;
> > +
> > +/// The default value for the number of seeks needed to recreate an ob=
ject.
> > +pub const DEFAULT_SEEKS: u32 =3D bindings::DEFAULT_SEEKS;
> > +
> > +/// An unregistered shrinker.
> > +///
> > +/// This type can be used to modify the settings of the shrinker befor=
e it is registered.
> > +///
> > +/// # Invariants
> > +///
> > +/// The `shrinker` pointer references an unregistered shrinker.
> > +pub struct UnregisteredShrinker {
> > +    shrinker: NonNull<bindings::shrinker>,
> > +}
> > +
> > +// SAFETY: Moving an unregistered shrinker between threads is okay.
> > +unsafe impl Send for UnregisteredShrinker {}
> > +// SAFETY: An unregistered shrinker is thread safe.
> > +unsafe impl Sync for UnregisteredShrinker {}
> > +
> > +impl UnregisteredShrinker {
> > +    /// Create a new shrinker.
> > +    pub fn alloc(name: &CStr) -> Result<Self, AllocError> {
> > +        // SAFETY: Passing `0` as flags is okay. Using `%s` as the for=
mat string is okay when we
>
> I'd elaborate here that we have to pass 0 as the only valid value because
> all the non-zero flags are for memcg and numa aware shrinkers, and we do
> not support those because we don't expose the relevant data from
> ShrinkControl.
>
> > +        // pass a nul-terminated string as the string for `%s` to prin=
t.
> > +        let ptr =3D
> > +            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_char_=
ptr(), name.as_char_ptr()) };
> > +
> > +        let shrinker =3D NonNull::new(ptr).ok_or(AllocError)?;
> > +
> > +        // INVARIANT: The creation of the shrinker was successful.
> > +        Ok(Self { shrinker })
> > +    }
> > +
> > +    /// Create a new shrinker using format arguments for the name.
> > +    pub fn alloc_fmt(name: core::fmt::Arguments<'_>) -> Result<Self, A=
llocError> {
> > +        // SAFETY: Passing `0` as flags is okay. Using `%pA` as the fo=
rmat string is okay when we
> > +        // pass a `fmt::Arguments` as the value to print.
> > +        let ptr =3D unsafe {
> > +            bindings::shrinker_alloc(
> > +                0,
> > +                c_str!("%pA").as_char_ptr(),
> > +                &name as *const _ as *const c_void,
> > +            )
> > +        };
> > +
> > +        let shrinker =3D NonNull::new(ptr).ok_or(AllocError)?;
> > +
> > +        // INVARIANT: The creation of the shrinker was successful.
> > +        Ok(Self { shrinker })
> > +    }
> > +
> > +    /// Set the number of seeks needed to recreate an object.
> > +    pub fn set_seeks(&mut self, seeks: u32) {
>
> Not sure we want to expose this, with ssd seeks kinda don't matter and
> it's just a bit about relative fairness. I think nowadays it's more
> important that the count_object values are normalized to size, if not all
> objects you shrink have the same fixed size.
>
> So not sure we need this, at least initially.

Good point about keeping the objects the same fixed size. I'll
incorporate that in the docs.

> > +        unsafe { (*self.shrinker.as_ptr()).seeks =3D seeks as c_int };
> > +    }
> > +
> > +    /// Register the shrinker.
> > +    ///
> > +    /// The provided pointer is used as the private data, and the type=
 `T` determines the callbacks
> > +    /// that the shrinker will use.
> > +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> Regist=
eredShrinker<T> {
> > +        let shrinker =3D self.shrinker;
> > +        let ptr =3D shrinker.as_ptr();
> > +
> > +        // The destructor of `self` calls `shrinker_free`, so skip the=
 destructor.
> > +        core::mem::forget(self);
> > +
> > +        let private_data_ptr =3D <T::Ptr as ForeignOwnable>::into_fore=
ign(private_data);
> > +
> > +        // SAFETY: We own the private data, so we can assign to it.
> > +        unsafe { (*ptr).private_data =3D private_data_ptr.cast_mut() }=
;
> > +        // SAFETY: The shrinker is not yet registered, so we can updat=
e this field.
> > +        unsafe { (*ptr).count_objects =3D Some(rust_count_objects::<T>=
) };
> > +        // SAFETY: The shrinker is not yet registered, so we can updat=
e this field.
> > +        unsafe { (*ptr).scan_objects =3D Some(rust_scan_objects::<T>) =
};
> > +
> > +        // SAFETY: The shrinker is unregistered, so it's safe to regis=
ter it.
> > +        unsafe { bindings::shrinker_register(ptr) };
> > +
> > +        RegisteredShrinker {
> > +            shrinker,
> > +            _phantom: PhantomData,
> > +        }
> > +    }
> > +}
> > +
> > +impl Drop for UnregisteredShrinker {
> > +    fn drop(&mut self) {
> > +        // SAFETY: The shrinker is a valid but unregistered shrinker, =
and we will not use it
> > +        // anymore.
> > +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> > +    }
> > +}
> > +
> > +/// A shrinker that is registered with the kernel.
> > +///
> > +/// # Invariants
> > +///
> > +/// The `shrinker` pointer refers to a registered shrinker using `T` a=
s the private data.
> > +pub struct RegisteredShrinker<T: Shrinker> {
> > +    shrinker: NonNull<bindings::shrinker>,
> > +    _phantom: PhantomData<T::Ptr>,
> > +}
> > +
> > +// SAFETY: This allows you to deregister the shrinker from a different=
 thread, which means that
> > +// private data could be dropped from any thread.
> > +unsafe impl<T: Shrinker> Send for RegisteredShrinker<T> where T::Ptr: =
Send {}
> > +// SAFETY: The only thing you can do with an immutable reference is ac=
cess the private data, which
> > +// is okay to access in parallel as the `Shrinker` trait requires the =
private data to be `Sync`.
> > +unsafe impl<T: Shrinker> Sync for RegisteredShrinker<T> {}
> > +
> > +impl<T: Shrinker> RegisteredShrinker<T> {
> > +    /// Access the private data in this shrinker.
> > +    pub fn private_data(&self) -> <T::Ptr as ForeignOwnable>::Borrowed=
<'_> {
> > +        // SAFETY: We own the private data, so we can access it.
> > +        let private =3D unsafe { (*self.shrinker.as_ptr()).private_dat=
a };
> > +        // SAFETY: By the type invariants, the private data is `T`. Th=
is access could happen in
> > +        // parallel with a shrinker callback, but that's okay as the `=
Shrinker` trait ensures that
> > +        // `T::Ptr` is `Sync`.
> > +        unsafe { <T::Ptr as ForeignOwnable>::borrow(private) }
> > +    }
> > +}
> > +
> > +impl<T: Shrinker> Drop for RegisteredShrinker<T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: We own the private data, so we can access it.
> > +        let private =3D unsafe { (*self.shrinker.as_ptr()).private_dat=
a };
> > +        // SAFETY: We will not access the shrinker after this call.
> > +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> > +        // SAFETY: The above call blocked until the completion of any =
shrinker callbacks, so there
> > +        // are no longer any users of the private data.
> > +        drop(unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private=
) });
> > +    }
> > +}
> > +
> > +/// Callbacks for a shrinker.
> > +pub trait Shrinker {
> > +    /// The pointer type used to store the private data of the shrinke=
r.
> > +    ///
> > +    /// Needs to be `Sync` because the shrinker callback could access =
this value immutably from
> > +    /// several thread in parallel.
> > +    type Ptr: ForeignOwnable + Sync;
> > +
> > +    /// Count the number of freeable items in the cache.
> > +    ///
> > +    /// May be called from atomic context.
>
> That's wrong, reclaim is allowed to block. Or my understanding of how thi=
s
> works is very busted. We do run in a pseudo locking context, the core
> code annotates that with fs_reclaim_acquire/release.

Ah, ok. Every shrinker I've looked at uses try_lock everywhere so I
assumed this could happen. Thanks for verifying that.

> > +    fn count_objects(
> > +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> > +        sc: ShrinkControl<'_>,
> > +    ) -> CountObjects;
> > +
> > +    /// Count the number of freeable items in the cache.
> > +    ///
> > +    /// May be called from atomic context.
>
> Same here.
>
> > +    fn scan_objects(
> > +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> > +        sc: ShrinkControl<'_>,
> > +    ) -> ScanObjects;
> > +}
> > +
> > +/// How many objects are there in the cache?
> > +///
> > +/// This is used as the return value of [`Shrinker::count_objects`].
> > +pub struct CountObjects {
> > +    inner: c_ulong,
> > +}
> > +
> > +impl CountObjects {
> > +    /// Indicates that the number of objects is unknown.
> > +    pub const UNKNOWN: Self =3D Self { inner: 0 };
> > +
> > +    /// Indicates that the number of objects is zero.
> > +    pub const EMPTY: Self =3D Self {
> > +        inner: SHRINK_EMPTY,
>
> So I spend way too much time looking at all this, and I think overflows
> don't matter to the core shrinker code (aside from maybe a bit of
> unfairness), as long as we don't accidently return SHRINK_EMPTY here. But
> that's only relevant for memcg aware shrinkers I think.

Overflow is one thing. The current API automatically converts 0 to
SHRINK_EMPTY, whereas many C shrinkers just return the size directly,
which means they return UNKNOWN when it's really empty. Thoughts?

> > +    };
> > +
> > +    /// The maximum possible number of freeable objects.
> > +    pub const MAX: Self =3D Self {
> > +        // The shrinker code assumes that it can multiply this value b=
y two without overflow.
> > +        inner: c_ulong::MAX / 2,
>
> I think the limits is actually ulong_max/4, since priority can be 0 from
> drop_slabs() and we multiply by 4 is seeks are nonzero. But then I tried
> to look at what the limit for nr_to_scan and hence ScanObjects, and I
> think aside from the special values the mm/shrinker.c simply does not car=
e
> about overflows at all. Both unsigned and signed integer math is well
> defined for overflow in linux, so no compiler license to do stupid stuff,
> and worst case if you do overflow you just end up shrinking a bit
> unfairly. But afaict nothing breaks.
>
> So not sure we should enforce this when core mm doesn't bother.
>
> Same for ScanObjects below.
>
> > +    };
> > +
> > +    /// Creates a new `CountObjects` with the given value.
> > +    pub fn from_count(count: usize) -> Self {
> > +        if count =3D=3D 0 {
> > +            return Self::EMPTY;
> > +        }
> > +
> > +        if count > Self::MAX.inner as usize {
> > +            return Self::MAX;
> > +        }
> > +
> > +        Self {
> > +            inner: count as c_ulong,
> > +        }
> > +    }
> > +}
> > +
> > +/// How many objects were freed?
> > +///
> > +/// This is used as the return value of [`Shrinker::scan_objects`].
> > +pub struct ScanObjects {
> > +    inner: c_ulong,
> > +}
> > +
> > +impl ScanObjects {
> > +    /// Indicates that the shrinker should stop trying to free objects=
 from this cache due to
> > +    /// potential deadlocks.
> > +    pub const STOP: Self =3D Self { inner: SHRINK_STOP };
> > +
> > +    /// The maximum possible number of freeable objects.
> > +    pub const MAX: Self =3D Self {
> > +        // The shrinker code assumes that it can multiply this value b=
y two without overflow.
> > +        inner: c_ulong::MAX / 2,
> > +    };
> > +
> > +    /// Creates a new `CountObjects` with the given value.
> > +    pub fn from_count(count: usize) -> Self {
> > +        if count > Self::MAX.inner as usize {
> > +            return Self::MAX;
> > +        }
> > +
> > +        Self {
> > +            inner: count as c_ulong,
> > +        }
> > +    }
> > +}
> > +
> > +/// This struct is used to pass information from page reclaim to the s=
hrinkers.
> > +pub struct ShrinkControl<'a> {
> > +    ptr: NonNull<bindings::shrink_control>,
> > +    _phantom: PhantomData<&'a bindings::shrink_control>,
> > +}
> > +
> > +impl<'a> ShrinkControl<'a> {
> > +    /// Create a `ShrinkControl` from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The pointer should point at a valid `shrink_control` for the d=
uration of 'a.
> > +    pub unsafe fn from_raw(ptr: *mut bindings::shrink_control) -> Self=
 {
> > +        Self {
> > +            // SAFETY: Caller promises that this pointer is valid.
> > +            ptr: unsafe { NonNull::new_unchecked(ptr) },
> > +            _phantom: PhantomData,
> > +        }
> > +    }
> > +
> > +    /// Determines whether it is safe to recurse into filesystem code.
> > +    pub fn gfp_fs(&self) -> bool {
>
> I guess you need this in your new binder code, because the current one
> seems to side-step __GFP_FS recursion with just trylocking absolutely
> everything aside from the lru spinlock. At least I haven't found any
> gfp_fs tests, but I might be blind.

Ah, yeah, I don't think C binder tests for that.

Either way, it probably makes more sense to just expose a method to
get the flags directly, rather than have a dedicated method for
testing this particular flags. Or what do you think?

> > +        // SAFETY: Okay by type invariants.
> > +        let mask =3D unsafe { (*self.ptr.as_ptr()).gfp_mask };
> > +
> > +        (mask & bindings::__GFP_FS) !=3D 0
> > +    }
> > +
> > +    /// Returns the number of objects that `scan_objects` should try t=
o reclaim.
> > +    pub fn nr_to_scan(&self) -> usize {
> > +        // SAFETY: Okay by type invariants.
> > +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> > +    }
> > +
> > +    /// The callback should set this value to the number of objects pr=
ocessed.
> > +    pub fn set_nr_scanned(&mut self, val: usize) {
>
> Unless my grep skills are really bad I think the drm/i915 shrinker is the
> only one that bothers with this. Not sure we want to bother either?
>
> > +        let mut val =3D val as c_ulong;
> > +        // SAFETY: Okay by type invariants.
> > +        let max =3D unsafe { (*self.ptr.as_ptr()).nr_to_scan };
> > +        if val > max {
> > +            val =3D max;
> > +        }
> > +
> > +        // SAFETY: Okay by type invariants.
> > +        unsafe { (*self.ptr.as_ptr()).nr_scanned =3D val };
> > +    }
> > +}
> > +
> > +unsafe extern "C" fn rust_count_objects<T: Shrinker>(
> > +    shrink: *mut bindings::shrinker,
> > +    sc: *mut bindings::shrink_control,
> > +) -> c_ulong {
> > +    // SAFETY: We own the private data, so we can access it.
> > +    let private =3D unsafe { (*shrink).private_data };
> > +    // SAFETY: This function is only used with shrinkers where `T` is =
the type of the private data.
> > +    let private =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(privat=
e) };
> > +    // SAFETY: The caller passes a valid `sc` pointer.
> > +    let sc =3D unsafe { ShrinkControl::from_raw(sc) };
> > +
> > +    let ret =3D T::count_objects(private, sc);
> > +    ret.inner
> > +}
> > +
> > +unsafe extern "C" fn rust_scan_objects<T: Shrinker>(
> > +    shrink: *mut bindings::shrinker,
> > +    sc: *mut bindings::shrink_control,
> > +) -> c_ulong {
> > +    // SAFETY: We own the private data, so we can access it.
> > +    let private =3D unsafe { (*shrink).private_data };
> > +    // SAFETY: This function is only used with shrinkers where `T` is =
the type of the private data.
> > +    let private =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(privat=
e) };
> > +    // SAFETY: The caller passes a valid `sc` pointer.
> > +    let sc =3D unsafe { ShrinkControl::from_raw(sc) };
> > +
> > +    let ret =3D T::scan_objects(private, sc);
> > +    ret.inner
> > +}
> >
> > ---
> > base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
> > change-id: 20240911-shrinker-f8371af00b68
> >
> > Best regards,
> > --
> > Alice Ryhl <aliceryhl@google.com>
> >
>
> --
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch


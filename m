Return-Path: <linux-kernel+bounces-328845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6309789CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B4B259B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C68153BF0;
	Fri, 13 Sep 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="k8vimjm2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4A148317
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258554; cv=none; b=CmeNYEqoYUsYRzXSaYq0er2JxzW+ox5MH9piSsagpTuDRiVIgl3xmPjpES9UTlORaVdfKv0i4ec6eMv17CDQOlxHn1MyMLTjcmMBsNdaDsh3TFESqCRYqYt+7w4gQ44MgsnlgbBr9xj1LHuyJ57bn2clXzuFlPdm/mEOP+o3Kc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258554; c=relaxed/simple;
	bh=hCc08vs80Vj2uEW0vCCXMikWw+Y1YU1LY//plSLtQks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMnJSye3GJVSNAs8h7UGo0/ohq52ewa2NcQEqZQQL0pMyFORWv/wzp/KXBKj1Ra3icyTJ9/+e25hTZDll+v/pb8pbu+11WxY2f1jS7o5/DV6/mz/WYqz/4ywDcoBEuPZyfkWHdB4xo8+Mi7QVT1Qua9HzI5dGP2R7rNCRUu1knI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=k8vimjm2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so16166825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726258550; x=1726863350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuyJWW2vvqqwaAM7XuSv3FjgZ+AWOxVG5dBHT28vO1Y=;
        b=k8vimjm2VlaVbRW9GIff4lMwOuVZnfPtJeZvHCFhk5dTbQ54xcsz2s+zzwO/pYKOx5
         f735F5JzK374R0fEqIhAZ7i4GTCHF61EDKEaAOQa8rFXYFfLMOVYMxcpdtWSEha0vq8P
         iDC9VkrKRwKAY57DaxO4uIETjYOxOkwAUHRrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726258550; x=1726863350;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuyJWW2vvqqwaAM7XuSv3FjgZ+AWOxVG5dBHT28vO1Y=;
        b=QAxcUhClT3XtjlkCyKSJyWWg9LKaQiN85WWpTFN1sNw9ZdH1cm1CeS6lLrFN55Jxqh
         6LgtOSm7iXUJNqgwCoSg7jL8li8rCPJosPVCerjvySZSaCvK9ED8okiUgxyBLD5GXcmY
         6x4OEA95kwupLjjxXepU6KW8ZkFZS+vKeeqn6KKTFpTyca1OVFCqK2NpS/a2gYlEVEyq
         RtSxmaEZxnLakBH3MYXteoTQJi59Q44/MglSSqvFDoPMZcJjICbSCXcXXUcY7SzbC6AQ
         lVur+tuFf/CjWntQ1OoOrR/IMF9Wgd/5ybKmo13k3bJnWAfjePjfOUNCFp/W3p/9C9sZ
         4tlw==
X-Forwarded-Encrypted: i=1; AJvYcCV8drs9J+LdjwTeccp1/xXYVGWKMa1DlICOBim8soj1P3Xv7Xu3/ocFvlzIw9/lXH2IoJPHs1a6YtvyzDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tENN++EVgYR1cklZO93QbdBCE0KstIxIjdAq9SL822zW2Vnh
	LR+NLwGvY8p2am/izaPSEx6V+W7o31edNLysgDxIPHcJt7PthNIAs29ltprXGM0=
X-Google-Smtp-Source: AGHT+IGbDy+nq3ODhI2sJtkt6noCoM4R+C1hi1ZSBuppCBvfeJn+HNQv1H6MrLWK2bHdm1WMxDYo1Q==
X-Received: by 2002:a05:600c:3b9c:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42cbddb7904mr92357825e9.2.1726258550108;
        Fri, 13 Sep 2024 13:15:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm15939f8f.116.2024.09.13.13.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 13:15:49 -0700 (PDT)
Date: Fri, 13 Sep 2024 22:15:47 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: shrinker: add shrinker abstraction
Message-ID: <ZuSdcybAVM1Ix4bJ@phenom.ffwll.local>
Mail-Followup-To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
References: <20240912-shrinker-v1-1-18b7f1253553@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-shrinker-v1-1-18b7f1253553@google.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Thu, Sep 12, 2024 at 09:54:01AM +0000, Alice Ryhl wrote:
> Rust Binder holds incoming transactions in a read-only mmap'd region
> where it manually manages the pages. These pages are only in use until
> the incoming transaction is consumed by userspace, but the kernel will
> keep the pages around for future transactions. Rust Binder registers a
> shrinker with the kernel so that it can give back these pages if the
> system comes under memory pressure.
> 
> Separate types are provided for registered and unregistered shrinkers.
> The unregistered shrinker type can be used to configure the shrinker
> before registering it. Separating it into two types also enables the
> user to construct the private data between the calls to `shrinker_alloc`
> and `shrinker_register` and avoid constructing the private data if
> allocating the shrinker fails.
> 
> The user specifies the callbacks in use by implementing the Shrinker
> trait for the type used for the private data. This requires specifying
> three things: implementations for count_objects and scan_objects, and
> the pointer type that the private data will be wrapped in.
> 
> The return values of count_objects and scan_objects are provided using
> new types called CountObjects and ScanObjects respectively. These types
> prevent the user from e.g. returning SHRINK_STOP from count_objects or
> returning SHRINK_EMPTY from scan_objects.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Scary given that drm has a few, but I learned a few new thinks about
shrinkers. Some comments below, but looks all really nice imo.

Cheers, Sima

> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/shrinker.rs         | 324 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 327 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..7fc958e05dc5 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -18,6 +18,7 @@
>  #include <linux/phy.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
> +#include <linux/shrinker.h>
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> @@ -31,4 +32,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
>  const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
>  const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
>  const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
> +const gfp_t RUST_CONST_HELPER___GFP_FS = ___GFP_FS;
>  const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f10b06a78b9d..f35eb290f2e0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -45,6 +45,7 @@
>  pub mod prelude;
>  pub mod print;
>  pub mod rbtree;
> +pub mod shrinker;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/shrinker.rs b/rust/kernel/shrinker.rs
> new file mode 100644
> index 000000000000..9af726bfe0b1
> --- /dev/null
> +++ b/rust/kernel/shrinker.rs
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Shrinker for handling memory pressure.
> +//!
> +//! C header: [`include/linux/shrinker.h`](srctree/include/linux/shrinker.h)
> +
> +use crate::{alloc::AllocError, bindings, c_str, str::CStr, types::ForeignOwnable};
> +
> +use core::{
> +    ffi::{c_int, c_ulong, c_void},
> +    marker::PhantomData,
> +    ptr::NonNull,
> +};
> +
> +const SHRINK_STOP: c_ulong = bindings::SHRINK_STOP as c_ulong;
> +const SHRINK_EMPTY: c_ulong = bindings::SHRINK_EMPTY as c_ulong;
> +
> +/// The default value for the number of seeks needed to recreate an object.
> +pub const DEFAULT_SEEKS: u32 = bindings::DEFAULT_SEEKS;
> +
> +/// An unregistered shrinker.
> +///
> +/// This type can be used to modify the settings of the shrinker before it is registered.
> +///
> +/// # Invariants
> +///
> +/// The `shrinker` pointer references an unregistered shrinker.
> +pub struct UnregisteredShrinker {
> +    shrinker: NonNull<bindings::shrinker>,
> +}
> +
> +// SAFETY: Moving an unregistered shrinker between threads is okay.
> +unsafe impl Send for UnregisteredShrinker {}
> +// SAFETY: An unregistered shrinker is thread safe.
> +unsafe impl Sync for UnregisteredShrinker {}
> +
> +impl UnregisteredShrinker {
> +    /// Create a new shrinker.
> +    pub fn alloc(name: &CStr) -> Result<Self, AllocError> {
> +        // SAFETY: Passing `0` as flags is okay. Using `%s` as the format string is okay when we

I'd elaborate here that we have to pass 0 as the only valid value because
all the non-zero flags are for memcg and numa aware shrinkers, and we do
not support those because we don't expose the relevant data from
ShrinkControl.

> +        // pass a nul-terminated string as the string for `%s` to print.
> +        let ptr =
> +            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_char_ptr(), name.as_char_ptr()) };
> +
> +        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
> +
> +        // INVARIANT: The creation of the shrinker was successful.
> +        Ok(Self { shrinker })
> +    }
> +
> +    /// Create a new shrinker using format arguments for the name.
> +    pub fn alloc_fmt(name: core::fmt::Arguments<'_>) -> Result<Self, AllocError> {
> +        // SAFETY: Passing `0` as flags is okay. Using `%pA` as the format string is okay when we
> +        // pass a `fmt::Arguments` as the value to print.
> +        let ptr = unsafe {
> +            bindings::shrinker_alloc(
> +                0,
> +                c_str!("%pA").as_char_ptr(),
> +                &name as *const _ as *const c_void,
> +            )
> +        };
> +
> +        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
> +
> +        // INVARIANT: The creation of the shrinker was successful.
> +        Ok(Self { shrinker })
> +    }
> +
> +    /// Set the number of seeks needed to recreate an object.
> +    pub fn set_seeks(&mut self, seeks: u32) {

Not sure we want to expose this, with ssd seeks kinda don't matter and
it's just a bit about relative fairness. I think nowadays it's more
important that the count_object values are normalized to size, if not all
objects you shrink have the same fixed size.

So not sure we need this, at least initially.

> +        unsafe { (*self.shrinker.as_ptr()).seeks = seeks as c_int };
> +    }
> +
> +    /// Register the shrinker.
> +    ///
> +    /// The provided pointer is used as the private data, and the type `T` determines the callbacks
> +    /// that the shrinker will use.
> +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> RegisteredShrinker<T> {
> +        let shrinker = self.shrinker;
> +        let ptr = shrinker.as_ptr();
> +
> +        // The destructor of `self` calls `shrinker_free`, so skip the destructor.
> +        core::mem::forget(self);
> +
> +        let private_data_ptr = <T::Ptr as ForeignOwnable>::into_foreign(private_data);
> +
> +        // SAFETY: We own the private data, so we can assign to it.
> +        unsafe { (*ptr).private_data = private_data_ptr.cast_mut() };
> +        // SAFETY: The shrinker is not yet registered, so we can update this field.
> +        unsafe { (*ptr).count_objects = Some(rust_count_objects::<T>) };
> +        // SAFETY: The shrinker is not yet registered, so we can update this field.
> +        unsafe { (*ptr).scan_objects = Some(rust_scan_objects::<T>) };
> +
> +        // SAFETY: The shrinker is unregistered, so it's safe to register it.
> +        unsafe { bindings::shrinker_register(ptr) };
> +
> +        RegisteredShrinker {
> +            shrinker,
> +            _phantom: PhantomData,
> +        }
> +    }
> +}
> +
> +impl Drop for UnregisteredShrinker {
> +    fn drop(&mut self) {
> +        // SAFETY: The shrinker is a valid but unregistered shrinker, and we will not use it
> +        // anymore.
> +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> +    }
> +}
> +
> +/// A shrinker that is registered with the kernel.
> +///
> +/// # Invariants
> +///
> +/// The `shrinker` pointer refers to a registered shrinker using `T` as the private data.
> +pub struct RegisteredShrinker<T: Shrinker> {
> +    shrinker: NonNull<bindings::shrinker>,
> +    _phantom: PhantomData<T::Ptr>,
> +}
> +
> +// SAFETY: This allows you to deregister the shrinker from a different thread, which means that
> +// private data could be dropped from any thread.
> +unsafe impl<T: Shrinker> Send for RegisteredShrinker<T> where T::Ptr: Send {}
> +// SAFETY: The only thing you can do with an immutable reference is access the private data, which
> +// is okay to access in parallel as the `Shrinker` trait requires the private data to be `Sync`.
> +unsafe impl<T: Shrinker> Sync for RegisteredShrinker<T> {}
> +
> +impl<T: Shrinker> RegisteredShrinker<T> {
> +    /// Access the private data in this shrinker.
> +    pub fn private_data(&self) -> <T::Ptr as ForeignOwnable>::Borrowed<'_> {
> +        // SAFETY: We own the private data, so we can access it.
> +        let private = unsafe { (*self.shrinker.as_ptr()).private_data };
> +        // SAFETY: By the type invariants, the private data is `T`. This access could happen in
> +        // parallel with a shrinker callback, but that's okay as the `Shrinker` trait ensures that
> +        // `T::Ptr` is `Sync`.
> +        unsafe { <T::Ptr as ForeignOwnable>::borrow(private) }
> +    }
> +}
> +
> +impl<T: Shrinker> Drop for RegisteredShrinker<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: We own the private data, so we can access it.
> +        let private = unsafe { (*self.shrinker.as_ptr()).private_data };
> +        // SAFETY: We will not access the shrinker after this call.
> +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> +        // SAFETY: The above call blocked until the completion of any shrinker callbacks, so there
> +        // are no longer any users of the private data.
> +        drop(unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) });
> +    }
> +}
> +
> +/// Callbacks for a shrinker.
> +pub trait Shrinker {
> +    /// The pointer type used to store the private data of the shrinker.
> +    ///
> +    /// Needs to be `Sync` because the shrinker callback could access this value immutably from
> +    /// several thread in parallel.
> +    type Ptr: ForeignOwnable + Sync;
> +
> +    /// Count the number of freeable items in the cache.
> +    ///
> +    /// May be called from atomic context.

That's wrong, reclaim is allowed to block. Or my understanding of how this
works is very busted. We do run in a pseudo locking context, the core
code annotates that with fs_reclaim_acquire/release.

> +    fn count_objects(
> +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        sc: ShrinkControl<'_>,
> +    ) -> CountObjects;
> +
> +    /// Count the number of freeable items in the cache.
> +    ///
> +    /// May be called from atomic context.

Same here.

> +    fn scan_objects(
> +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        sc: ShrinkControl<'_>,
> +    ) -> ScanObjects;
> +}
> +
> +/// How many objects are there in the cache?
> +///
> +/// This is used as the return value of [`Shrinker::count_objects`].
> +pub struct CountObjects {
> +    inner: c_ulong,
> +}
> +
> +impl CountObjects {
> +    /// Indicates that the number of objects is unknown.
> +    pub const UNKNOWN: Self = Self { inner: 0 };
> +
> +    /// Indicates that the number of objects is zero.
> +    pub const EMPTY: Self = Self {
> +        inner: SHRINK_EMPTY,

So I spend way too much time looking at all this, and I think overflows
don't matter to the core shrinker code (aside from maybe a bit of
unfairness), as long as we don't accidently return SHRINK_EMPTY here. But
that's only relevant for memcg aware shrinkers I think.

> +    };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self = Self {
> +        // The shrinker code assumes that it can multiply this value by two without overflow.
> +        inner: c_ulong::MAX / 2,

I think the limits is actually ulong_max/4, since priority can be 0 from
drop_slabs() and we multiply by 4 is seeks are nonzero. But then I tried
to look at what the limit for nr_to_scan and hence ScanObjects, and I
think aside from the special values the mm/shrinker.c simply does not care
about overflows at all. Both unsigned and signed integer math is well
defined for overflow in linux, so no compiler license to do stupid stuff,
and worst case if you do overflow you just end up shrinking a bit
unfairly. But afaict nothing breaks.

So not sure we should enforce this when core mm doesn't bother.

Same for ScanObjects below.

> +    };
> +
> +    /// Creates a new `CountObjects` with the given value.
> +    pub fn from_count(count: usize) -> Self {
> +        if count == 0 {
> +            return Self::EMPTY;
> +        }
> +
> +        if count > Self::MAX.inner as usize {
> +            return Self::MAX;
> +        }
> +
> +        Self {
> +            inner: count as c_ulong,
> +        }
> +    }
> +}
> +
> +/// How many objects were freed?
> +///
> +/// This is used as the return value of [`Shrinker::scan_objects`].
> +pub struct ScanObjects {
> +    inner: c_ulong,
> +}
> +
> +impl ScanObjects {
> +    /// Indicates that the shrinker should stop trying to free objects from this cache due to
> +    /// potential deadlocks.
> +    pub const STOP: Self = Self { inner: SHRINK_STOP };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self = Self {
> +        // The shrinker code assumes that it can multiply this value by two without overflow.
> +        inner: c_ulong::MAX / 2,
> +    };
> +
> +    /// Creates a new `CountObjects` with the given value.
> +    pub fn from_count(count: usize) -> Self {
> +        if count > Self::MAX.inner as usize {
> +            return Self::MAX;
> +        }
> +
> +        Self {
> +            inner: count as c_ulong,
> +        }
> +    }
> +}
> +
> +/// This struct is used to pass information from page reclaim to the shrinkers.
> +pub struct ShrinkControl<'a> {
> +    ptr: NonNull<bindings::shrink_control>,
> +    _phantom: PhantomData<&'a bindings::shrink_control>,
> +}
> +
> +impl<'a> ShrinkControl<'a> {
> +    /// Create a `ShrinkControl` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer should point at a valid `shrink_control` for the duration of 'a.
> +    pub unsafe fn from_raw(ptr: *mut bindings::shrink_control) -> Self {
> +        Self {
> +            // SAFETY: Caller promises that this pointer is valid.
> +            ptr: unsafe { NonNull::new_unchecked(ptr) },
> +            _phantom: PhantomData,
> +        }
> +    }
> +
> +    /// Determines whether it is safe to recurse into filesystem code.
> +    pub fn gfp_fs(&self) -> bool {

I guess you need this in your new binder code, because the current one
seems to side-step __GFP_FS recursion with just trylocking absolutely
everything aside from the lru spinlock. At least I haven't found any
gfp_fs tests, but I might be blind.

> +        // SAFETY: Okay by type invariants.
> +        let mask = unsafe { (*self.ptr.as_ptr()).gfp_mask };
> +
> +        (mask & bindings::__GFP_FS) != 0
> +    }
> +
> +    /// Returns the number of objects that `scan_objects` should try to reclaim.
> +    pub fn nr_to_scan(&self) -> usize {
> +        // SAFETY: Okay by type invariants.
> +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> +    }
> +
> +    /// The callback should set this value to the number of objects processed.
> +    pub fn set_nr_scanned(&mut self, val: usize) {

Unless my grep skills are really bad I think the drm/i915 shrinker is the
only one that bothers with this. Not sure we want to bother either?

> +        let mut val = val as c_ulong;
> +        // SAFETY: Okay by type invariants.
> +        let max = unsafe { (*self.ptr.as_ptr()).nr_to_scan };
> +        if val > max {
> +            val = max;
> +        }
> +
> +        // SAFETY: Okay by type invariants.
> +        unsafe { (*self.ptr.as_ptr()).nr_scanned = val };
> +    }
> +}
> +
> +unsafe extern "C" fn rust_count_objects<T: Shrinker>(
> +    shrink: *mut bindings::shrinker,
> +    sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We own the private data, so we can access it.
> +    let private = unsafe { (*shrink).private_data };
> +    // SAFETY: This function is only used with shrinkers where `T` is the type of the private data.
> +    let private = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller passes a valid `sc` pointer.
> +    let sc = unsafe { ShrinkControl::from_raw(sc) };
> +
> +    let ret = T::count_objects(private, sc);
> +    ret.inner
> +}
> +
> +unsafe extern "C" fn rust_scan_objects<T: Shrinker>(
> +    shrink: *mut bindings::shrinker,
> +    sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We own the private data, so we can access it.
> +    let private = unsafe { (*shrink).private_data };
> +    // SAFETY: This function is only used with shrinkers where `T` is the type of the private data.
> +    let private = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller passes a valid `sc` pointer.
> +    let sc = unsafe { ShrinkControl::from_raw(sc) };
> +
> +    let ret = T::scan_objects(private, sc);
> +    ret.inner
> +}
> 
> ---
> base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
> change-id: 20240911-shrinker-f8371af00b68
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


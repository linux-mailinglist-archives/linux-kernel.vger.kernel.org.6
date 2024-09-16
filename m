Return-Path: <linux-kernel+bounces-330122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3A9799FD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79101C2242B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288C417753;
	Mon, 16 Sep 2024 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tGs/rgpx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D999EAE9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726455581; cv=none; b=soKOdrroFpzG1kLLiEtvoyCATFt0wr87WqTXa5oTj1x+t4d/H5O1btCKWf4QmxyEgUQDzOQxf2dca9StDsa4OuzaZgruz0Fq/fB9ZQ7OGoJULqUXMfixF+JOLw0Fgb3NU0sLwyifn0dPYJX90fH1G2mFkqtuIwv4m75OJwo69jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726455581; c=relaxed/simple;
	bh=vtTKLPjhQcDNpuPTi4R7WOcxD130LiM9x7n2YqqRahk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPENmXT9HWJI3T0ohWx2u8QAJRkkvYA04xVSUyyCb9dhqTbLYtq6+mPU7gz8Pm7pUlnGLAUpP+CYIjBdGNcIWfh33Ch7VKbOTzQrTsUJlYdKI6qE4oe5HHUsk0c+cF/74ofcBCaMY643bjg/R0SNm9SAxtD+T08fpRp3PND5LpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tGs/rgpx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206bd1c6ccdso24549785ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726455578; x=1727060378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RSbbqBLAJlxb5D5ZWqxy/G4lwCUW9g98Ly58yRRj7LU=;
        b=tGs/rgpxBYjaSjNkBbpsQa04k1aqf/RI/lTi9WgvvlZQsKuGRI9uC2zauFMIT42NhE
         Uy8N108l7lMYes/DrgxTq04F2lK8JeBwM/0eGy+dWeAJ3N+7J03QetTsECVAKpfK9IQb
         5y+iGxb/G8wrJ0qRcFDEuBOGjO9foN16QD1zO5fQapzZapHZY7lEg1pso1sHctHDE90Q
         dfsUZ/jXpzK39F1DX+2gla4NmbN3fzG8y75J4MqJI4So67x/AeUloEZXXC1vOZk1fkvN
         b0yzlvFCzMimLOt+0KVs3Zg995US/0aw4CcXV2/xPTriJwPYFjPv2o+/57P0f6NRGhPL
         jdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726455578; x=1727060378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSbbqBLAJlxb5D5ZWqxy/G4lwCUW9g98Ly58yRRj7LU=;
        b=TxK6luS59NgL+Fbuu9ajfNWG4R7yXdqAPn+PoEXYssuRNkE32o6l2o67nUmXtNVHQ2
         mEDVJMYJUCrb/CZdeCqKA/b4l0MRXkyIPj0CE/QvKOO+OdphksAXEijn98K+kF8qCCwN
         +OkuOzvXu2uV0AdmG8xawcEzAAXWfxMa60f86PeAEDiXAuCz6j0QKmAACyc71WpSvBPd
         rmtwos9C1c62/S3F8abgIpAY1I2mAnGY66LmlU8uyfs3FinBTW+TvhS7uGN5WFtfqNXJ
         JTwA9nMFRky2+39LMUDXkpYGr2o8joxdeP9fDM7/He3aRZpUiEZsdlpXugKU762dgBrG
         4Sfw==
X-Forwarded-Encrypted: i=1; AJvYcCVNNuSX4Gjb+ghsEs8UIBpAiQm0iRpQYB+Vo8LgCeL1xEwsthmPWSdekRW87j4khshqmsyto3/+DIP8A3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQtBmoZuIOIGrFRuAPRcfpqDuTbwMUOSmf38wbpfD0nU5+Jfu
	Qub2ODwKyd4Kggzp3Vwwz+9H3H4TR191/hfFZqa+R2KK1Da7n5CFYcEGSewwrIs=
X-Google-Smtp-Source: AGHT+IGrxbaUIwm2DwH615cdY+BAD4tTTr+b1Q2wOYSYYfq3sf1V7kT4jnQ46vheQxGvDWTGudZYnA==
X-Received: by 2002:a17:902:e80a:b0:202:190e:2adb with SMTP id d9443c01a7336-2078253791bmr153778185ad.36.1726455578348;
        Sun, 15 Sep 2024 19:59:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d27cfsm28140295ad.161.2024.09.15.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 19:59:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sq1xe-005kpl-38;
	Mon, 16 Sep 2024 12:59:34 +1000
Date: Mon, 16 Sep 2024 12:59:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZuefFhomRvqtFzSn@dread.disaster.area>
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

This seems a bit nasty. It appears to me that the code does an
unsafe copy of the internal shrinker state between the unregistered
and registered types. Shrinkers have additional internal state when
SHRINKER_MEMCG_AWARE and/or SHRINKER_NUMA_AWARE flags are set,
and this abstraction doesn't seem to handle either those flags or
the internal state they use at all.

....

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
> +        // pass a nul-terminated string as the string for `%s` to print.
> +        let ptr =
> +            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_char_ptr(), name.as_char_ptr()) };

This passes flags as 0, so doesn't support SHRINKER_MEMCG_AWARE or
SHRINKER_NUMA_AWARE shrinker variants. These flags should be
passed through here.

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

Same again.

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
> +        unsafe { (*self.shrinker.as_ptr()).seeks = seeks as c_int };
> +    }

Seems kinda weird to have a separate function for setting seeks,
when...

> +
> +    /// Register the shrinker.
> +    ///
> +    /// The provided pointer is used as the private data, and the type `T` determines the callbacks
> +    /// that the shrinker will use.
> +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> RegisteredShrinker<T> {

.... all the other data needed to set up a shrinker is provided to
this function....

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

.... and implemented exactly the same way.

.....

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
> +    };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self = Self {
> +        // The shrinker code assumes that it can multiply this value by two without overflow.
> +        inner: c_ulong::MAX / 2,
> +    };
> +
> +    /// Creates a new `CountObjects` with the given value.
> +    pub fn from_count(count: usize) -> Self {
> +        if count == 0 {
> +            return Self::EMPTY;
> +        }

No. A return count of 0 is not the same as a return value of
SHRINK_EMPTY.

A return value of 0 means "no reclaim work can be done right now".

This implies that there are objects that can be reclaimed in the near
future, but right now they are unavailable for reclaim. This can be
due to a trylock protecting the count operation failing, the all the
objects in the cache being dirty and needing work to be done before
they can be reclaimed, etc.

A return value of SHRINK_EMPTY means "there are no reclaimable
objects at all".

This implies that the cache is empty - it has absolutely nothing in
it that can be reclaimed either now or in the near future.


These two return values are treated very differently by the high
level code. SHRINK_EMPTY is used by shrink_slab_memcg() to maintain
a "shrinker needs to run" bit in the memcg shrinker search bitmap.
The bit is cleared when SHRINK_EMPTY is returned, meaning the
shrinker will not get called again until a new object is queued
to it's LRU. This sets the "shrinker needs to run" bit again, and
so the shrinker will run next time shrink_slab_memcg() is called.

In constrast, a return value of zero (i.e. no work to be done right
now) does not change the "shrinker needs to run" state bit, and
hence it will always be called the next time the shrink_slab_memcg()
is run to try to reclaim objects from that memcg shrinker...

.....

> +impl ScanObjects {
> +    /// Indicates that the shrinker should stop trying to free objects from this cache due to
> +    /// potential deadlocks.
> +    pub const STOP: Self = Self { inner: SHRINK_STOP };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self = Self {
> +        // The shrinker code assumes that it can multiply this value by two without overflow.
> +        inner: c_ulong::MAX / 2,

No it doesn't. This is purely a count of objects freed by the
shrinker.

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
> +        // SAFETY: Okay by type invariants.
> +        let mask = unsafe { (*self.ptr.as_ptr()).gfp_mask };
> +
> +        (mask & bindings::__GFP_FS) != 0
> +    }

This needs a check for __GFP_IO as well, as there are block layer
shrinkers that need to be GFP_NOIO aware...

> +
> +    /// Returns the number of objects that `scan_objects` should try to reclaim.
> +    pub fn nr_to_scan(&self) -> usize {
> +        // SAFETY: Okay by type invariants.
> +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> +    }
> +
> +    /// The callback should set this value to the number of objects processed.
> +    pub fn set_nr_scanned(&mut self, val: usize) {
> +        let mut val = val as c_ulong;
> +        // SAFETY: Okay by type invariants.
> +        let max = unsafe { (*self.ptr.as_ptr()).nr_to_scan };
> +        if val > max {
> +            val = max;
> +        }

No. Shrinkers are allowed to scan more objects in a batch than
the high level code asked them to scan. If they do this, they
*must* report back the count of all the objects they scanned so the
batched scan accounting can adjust the remaining amount of work that
needs to be done appropriately.

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

Why are there two assignments to "private" here? And for the one
that is borrowing a reference, why is it needed as the shrinker is
supposed to hold a reference, right? Also, where is that reference
dropped - it's not at all obvious to me (as a relative n00b to rust)
what is going on here.


-Dave.
-- 
Dave Chinner
david@fromorbit.com


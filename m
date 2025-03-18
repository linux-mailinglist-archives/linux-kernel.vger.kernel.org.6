Return-Path: <linux-kernel+bounces-566888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC4DA67DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5BB169790
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48125211A1E;
	Tue, 18 Mar 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWsMDbCo"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C01DC9B4;
	Tue, 18 Mar 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329044; cv=none; b=XaeKoIJfy7Oa7JNLFe/2en1KzHSbGyd+3L3JGHg8mcVFtiGbSur56rQasJ2yVOxSDYb8NyN6lA5OkYG/SfDNGPO5oU+4w+FDmGwYKf8RiCOekrf9SSxGK7Clbz5xmCLgQ2DC+3lMwxxT3LTHNUmhrHMeQDLRT4hHLgrc9gEc6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329044; c=relaxed/simple;
	bh=emOpY3VIh/znAKQEM9W445MHttu28By0AxTmwhKj5K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2dM8TJp/aVqZw5VSTHGS6IUY2YbfJsnFDSbQkOqImxE1haUVANEy/geLEs0j7XGzk08kZvczOkk+Ib97dakQEru343t7/aEtTJhxRcJ21XhXDnIMdLtnb5Y7Fqh5UQxYBaDark+Mv6ipj60fzvV7wJ4PEr+1LkDWvbLMuXISAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWsMDbCo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2260c915749so39956285ad.3;
        Tue, 18 Mar 2025 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742329042; x=1742933842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNembivG+edesgM6cqjM7gnhstO8x72uttt7IEHkhtA=;
        b=SWsMDbCo0UAENPP5ocxp2KA8WGETlS/JyYpdT6PG+YRdq08VrfzVStKUTrcYb3z0KH
         hk+TqtWYo/LTkFh4NYI92NlXVsn8OaA554sFEHuJpSUv34LVp713aPuLrM4UiWW8bHmK
         XZp9BNIHV/eU5u9mRffDQXOPsS5Kfimzy3lYUyYkZiKTAQ6Q9yOVARUx9rHgHO6JfHZo
         lAdFEKhS9Fexi1rY13KgphJsXJeI6kOJTvyVt3R0pbairLYflLu7NLWmBCnPp5Cbl7vw
         12RJQi3QGw43xqG4/E3cGagnpHe7Dc9NoBNAL6E30VyFm+jK99+JgvJ853ITX91AnaYY
         Fkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742329042; x=1742933842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNembivG+edesgM6cqjM7gnhstO8x72uttt7IEHkhtA=;
        b=Oq9JnapCxchdUr/adRnu1jlMxbomFVYWb5ftE8VuREzVzIVCS/DXKpb/hsdOVftSG6
         Asqsg4y8++2VuDAITmLYfJkA8nWDfr1j2uhtmO5sH4DeVUezYFk2KpdP01lQF/xqRgCL
         bF0x9pxp2XYgbeWxCfoMaeI1VfUdnUT+7UJrJ0kbtqsUG8cxelONSJytXqJrLbmW8DP8
         J07+9QQaTh20Z6ezXXLuS0OJrRGa95MelHGK7PcJ15mF1oJ1suctTWhirwYD554HJ/Cb
         kkbw13wC8tZTRA5x4h283qdiTzfJQgbmnkxEdy2l8jJlq44bqOF1NuMpjdBxFlQAbSFa
         CsKA==
X-Forwarded-Encrypted: i=1; AJvYcCUD4373aUKP2zXt0v6tWANOeIWAGceh96FaZRNM/+atkdivQ2jMHdc78oqaqpa7lWF3K1YVh7nEuKCD5Fxn3eU=@vger.kernel.org, AJvYcCXCNxzfpaRe4zBLWOvUyZfdfpwhdq7PXudmk8gHD+cb+YMVpww/cMOBf4+Xm6R+0ntt9MXzKdDHtlmDrqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo14r6kFYZcIstVgXd3IhrHboS5k59H7fagNmh/3VWDCJAgdIo
	TolwmRc34nPsT/W3r4Q8S+eUE9EaqlU86Wl4SvEG8x7zfcmbF8Lu
X-Gm-Gg: ASbGnctvS3VWgUmZxbbUySbny5JkzSBUoUcmPKuuFDeWjEceqSEwyzF9gLgPiThS9Lj
	arTP/ZKVPczsL7S4fW+gC+boLRbDIIpBLkc+6ig6YtF3acnJVDvhT5oUJVGt12oS9STFvJ2QBjY
	sjCN9NRQCF2AB2tqxR/Ygyc6D1VWqr5UPN+LharnP9VF81/VNPYcRYwngTL/CfMa3vKfRTDN86Q
	jMlElZrwOmb7ZcYQwooYypNpP+SjJfRJBB1AvVureyvNkNoOvr1Qj0xgm2Gpx1Bgd23RmhrPp4n
	vXTulqmQlmHzfNbrhnV+5Qa1WI0P5FVPVG70KhNqt5V2D2SiN868oTdinNOXr07ZDh5+
X-Google-Smtp-Source: AGHT+IF/Wj2LRDk+hvSbfuinK6EgXlcgLUtjvjwp0IUanQedv0ZSH7dUG/dgbELHo+UuRb7DX3KSoQ==
X-Received: by 2002:a05:6a00:1391:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-7376d648296mr119300b3a.14.1742329041411;
        Tue, 18 Mar 2025 13:17:21 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711578ceasm10077490b3a.84.2025.03.18.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:17:20 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:17:18 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Adds Rust Bitmap API.
Message-ID: <Z9nUzjinU_mozCXC@thinkpad>
References: <20250318164221.1533590-1-bqe@google.com>
 <20250318175322.1627073-2-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318175322.1627073-2-bqe@google.com>

On Tue, Mar 18, 2025 at 05:51:53PM +0000, Burak Emir wrote:
> Provides an abstraction for C bitmap API and bitops operations.
> This includes enough functionality to reimplementing a Binder
> data structure (drivers/android/dbitmap.h). More methods can be
> added later. We offer a safe API through bounds checks which
> panic if violated.
> 
> We use the `usize` type for sizes and indices into the bitmap,
> because Rust generally always uses that type for indices and lengths
> and it will be more convenient if the API accepts that type. This means
> that we need to perform some casts to/from u32 and usize, since the C
> headers use unsigned int instead of size_t/unsigned long for these
> numbers in some places.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS           |   2 +
>  rust/kernel/bitmap.rs | 234 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   1 +
>  3 files changed, 237 insertions(+)
>  create mode 100644 rust/kernel/bitmap.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50f44d7e5c6e..b3bbce9274f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4036,9 +4036,11 @@ F:	rust/helpers/bitmap.c
>  F:	rust/helpers/cpumask.c
>  
>  BITMAP API [RUST]
> +M:	Alice Ryhl <aliceryhl@google.com> (bitmap)
>  M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
>  R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
> +F:	rust/kernel/bitmap.rs
>  F:	rust/kernel/cpumask.rs

If you guys are not ready to maintain this as a whole, please split
the record. scripts/get_maintainers doesn't honor this specifications,
and you will anyways receive all the bitmaps traffic.

I checked the existing records:

  $ grep ^M: MAINTAINERS | grep \(
  M:	Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
  M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
  M:	"Richard Russon (FlatCap)" <ldm@flatcap.org>
  M:	Matthew Wilcox (Oracle) <willy@infradead.org>
  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
  M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
  M:	Juri Lelli <juri.lelli@redhat.com> (SCHED_DEADLINE)
  M:	Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)

As you see, it's not a common practice - only scheduler and RCU people
do that. And I don't find this practice healthy.
  
>  BITOPS API
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> new file mode 100644
> index 000000000000..e8117e0dbe05
> --- /dev/null
> +++ b/rust/kernel/bitmap.rs
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Rust API for bitmap.
> +//!
> +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bindings;
> +use core::ptr::NonNull;
> +
> +/// Represents a bitmap.
> +///
> +/// Wraps underlying C bitmap API.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +/// ```
> +/// use kernel::alloc::flags::GFP_KERNEL;
> +/// use kernel::bitmap::Bitmap;
> +///
> +/// let mut b = Bitmap::new(16, GFP_KERNEL)?;
> +/// assert_eq!(16, b.len());
> +/// for i in 0..16 {
> +///   if i % 4 == 0 {
> +///     b.set_bit(i);
> +///   }
> +/// }
> +/// assert_eq!(Some(1), b.find_next_zero_bit(0));
> +/// assert_eq!(Some(5), b.find_next_zero_bit(5));
> +/// assert_eq!(Some(12), b.find_last_bit());
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// `ptr` is obtained from a successful call to `bitmap_zalloc` and
> +/// holds the address of an initialized array of `unsigned long`
> +/// that is large enough to hold `nbits` bits.
> +/// `nbits` is `<= u32::MAX` and never changes.
> +pub struct Bitmap {
> +    /// Pointer to an array of `unsigned long`.
> +    ptr: NonNull<usize>,
> +    /// How many bits this bitmap stores. Must be `<= u32::MAX`.

Must be <= i32:MAX - I already told that. For 'how many bits' we have a
special word: length.

> +    nbits: usize,
> +}
> +
> +impl Drop for Bitmap {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
> +        //
> +        // INVARIANT: there is no other use of the `self.ptr` after this
> +        // call and the value is being dropped so the broken invariant is
> +        // not observable on function exit.
> +        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
> +    }
> +}
> +
> +impl Bitmap {
> +    /// Constructs a new [`Bitmap`].
> +    ///
> +    /// Fails with [`AllocError`] when the [`Bitmap`] could not be
> +    /// allocated. This includes the case when `nbits` is greater
> +    /// than `u32::MAX`.
> +    #[inline]
> +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {

Are those 'drop' and 'new' something like a special rust words? If not -
can you use alloc and free wording? Would be nice to have rust part
looking similar to C. Nobody wants to keep two sets of names in mind.

> +        if let Ok(nbits_u32) = u32::try_from(nbits) {
> +            // SAFETY: `nbits == 0` is permitted and `nbits <= u32::MAX`.
> +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> +            // Zero-size allocation is ok and yields a dangling pointer.

Maybe it's OK, but I'm not aware of any a correct algorithm that needs
0-sized bitmaps. I already asked for it on previous iteration, right?
So unless you can show me such an example and explain what for you need
0-sized bitmaps, please drop this wording.

> +            let ptr = NonNull::new(ptr).ok_or(AllocError)?;
> +            // INVARIANT: ptr returned by C `bitmap_zalloc` and nbits checked.
> +            Ok(Bitmap { ptr, nbits })
> +        } else {
> +            Err(AllocError)
> +        }
> +    }
> +
> +    /// Returns how many bits this [`Bitmap`] holds.

This 'how many bits' may read wrong like 'how many set bits'. Refer
find_first_bit() for example. Please use the word 'length'.

> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.nbits
> +    }
> +
> +    /// Returns true if this [`Bitmap`] has length `0`.
> +    #[inline]
> +    pub fn is_empty(&self) -> bool {
> +        self.nbits == 0
> +    }

Please no. We already have bitmap_empty() with the meaning: no set bits.
I really don't understand why are you guys so worrying about this very
specific and most likely erroneous case...

This function is not even used in the following patch. Really don't
need it.

> +
> +    /// Returns a mutable raw pointer to the backing [`Bitmap`].
> +    #[inline]
> +    fn as_mut_ptr(&mut self) -> *mut usize {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Returns a raw pointer to the backing [`Bitmap`].
> +    #[inline]
> +    fn as_ptr(&self) -> *const usize {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Sets bit with index `index`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn set_bit(&mut self, index: usize) {

set_bit() is an atomic name, but you wire it to a non-atomic operation.
This is a mess.

> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: Bit `index` is within bounds.
> +        unsafe { bindings::__set_bit(index as u32, self.as_mut_ptr()) };
> +    }
> +
> +    /// Clears bit with index `index`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn clear_bit(&mut self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: Bit `index` is within bounds.
> +        unsafe { bindings::__clear_bit(index as u32, self.as_mut_ptr()) };
> +    }
> +
> +    /// Replaces this [`Bitmap`] with `src` and sets any remaining bits to zero.

Please: replace and set, not replaces and sets.

> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `src` is longer than this [`Bitmap`].
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::Bitmap;
> +    ///
> +    /// let mut long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
> +    /// let short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
> +    /// long_bitmap.copy_from_bitmap_and_extend(&short_bitmap);
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) {

Let's make it a rule: if you pick a function from C code as-is, you
pick the name as-is, too. I'm OK if you will want to drop the 'bitmap'
prefix, because it's a method. But I want to be able to just grep the
name and find its roots in C.

> +        assert!(
> +            src.nbits <= self.nbits,
> +            "Length of `src` must be <= {}, was {}",
> +            self.nbits,
> +            src.nbits
> +        );
> +        // SAFETY: `nbits == 0` is supported and access to `self` and `src` is within bounds.

I don't understand this. If nbits == 0, there's nothing to access. Can
you instead say "handled properly by the C function", or something?

> +        unsafe {
> +            bindings::bitmap_copy_and_extend(
> +                self.as_mut_ptr(),
> +                src.as_ptr(),
> +                src.nbits as u32,
> +                self.nbits as u32,
> +            )
> +        };
> +    }
> +
> +    /// Replaces this bitmap with a prefix of `src` that fits into this [`Bitmap`].
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `src` is shorter than this [`Bitmap`].
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::Bitmap;
> +    ///
> +    /// let mut short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
> +    /// let long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
> +    /// short_bitmap.copy_prefix_from_bitmap(&long_bitmap);
> +    /// # Ok::<(), AllocError>(())

Why don't you make it a real test? I asked for tests on previous
round, but I didn't think that you will make me to construct the
test myself from scattered pieces of commented code in a foreign
language.

> +    /// ```
> +    #[inline]
> +    pub fn copy_prefix_from_bitmap(&mut self, src: &Bitmap) {

Are you sure you need this 2nd function? It's almost the same as the
previous one. If the first one works like a.copy_and_extend(b), then
this one is simply b.copy_and_extend(a). Or I misunderstand this?

And anyways, this 'copy_prefix_from' thing is confusing and
misleading. There are no prefixes in bitmaps.

> +        assert!(
> +            self.nbits <= src.nbits,
> +            "Length of `src` must be >= {}, was {}",
> +            self.nbits,
> +            src.nbits
> +        );
> +        // SAFETY: `nbits == 0` is supported and access to `self` and `src` is within bounds.
> +        unsafe {
> +            bindings::bitmap_copy_and_extend(
> +                self.as_mut_ptr(),
> +                src.as_ptr(),
> +                self.nbits as u32,
> +                self.nbits as u32,
> +            )
> +        };
> +    }
> +
> +    /// Finds the last bit that is set.
> +    #[inline]
> +    pub fn find_last_bit(&self) -> Option<usize> {

You may drop the 'find' prefix because it's a method.

> +        // SAFETY: `nbits == 0` is supported and access is within bounds.

No panics anymore? I recall Alice said you need them for hardening...

> +        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) };
> +        if index == self.nbits {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }
> +
> +    /// Finds the next zero bit, starting from `offset`.
> +    #[inline]
> +    pub fn find_next_zero_bit(&self, offset: usize) -> Option<usize> {
> +        // SAFETY: `nbits == 0` and out-of-bounds offset is supported.

It's not supported. The request with such parameters is ignored,
and >= nbits is returned.

> +        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.nbits, offset) };
> +        if index == self.nbits {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index efbd7be98dab..be06ffc47473 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub use ffi;
>  
>  pub mod alloc;
> +pub mod bitmap;
>  #[cfg(CONFIG_BLOCK)]
>  pub mod block;
>  #[doc(hidden)]
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog


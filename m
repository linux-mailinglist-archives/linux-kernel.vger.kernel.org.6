Return-Path: <linux-kernel+bounces-571574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A2AA6BF01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96171179F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA0221DA1;
	Fri, 21 Mar 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grqgRdja"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444186321;
	Fri, 21 Mar 2025 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573050; cv=none; b=IqJz9iJtRDsQj71lVrGpf5e1Savad6HEEdUEd4PYy09rcTyXn9sBLNBneFVQ6IDE2zbx/m4gzUcb9wPFpV1nJs2lxRRK+ABuRrfwA3/0OEOicFGTArx3z8bx5mBrJTWGVkWJmILzZDqP0ahihD+Zyms15+kDHbL8PIjteQoYSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573050; c=relaxed/simple;
	bh=uYMbOEado+0XiQVPbhCWhVEC6zQXH2eqPhjjBpoVxkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pncuTVuPziK+xOn6bPSAJHSy3hcwJPYOQR7TFusO9xsu8XY991c6LAImP5Jy169r6yrfDHdk+OK6GelmCMF6fnt/klT0riFmKCBxuknUuNncogSERsau2zrLPY1jiBHH2rKY3XiAO/u/hb184sPvrUJPPhshWx8YhKBou+ynoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grqgRdja; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224100e9a5cso42924485ad.2;
        Fri, 21 Mar 2025 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742573045; x=1743177845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyi2Rr9SaOyczZGGMiWNJUBy1cFm9hWX35qovven6VU=;
        b=grqgRdja6Cp8gcOVNZVDVZFwp3dLXu2M0z5DZnZ4pEEjpp1dB9mkfUyeQbZHG+75zS
         /9/pbIuxS0yE+5x56rIzW0zXIrKGm7ABTg21JNqQJd5MlPXSIpW2F+tb4duefTh1MzN6
         L+jGikL8wHtIbzhlH4wri4U+QHlhWkmrbpdBFg/ZfJY7XgpUqoB+PbOSAAQCdL19kvkj
         +m8l2shpiyJwSZGdbst+FtcIEsMk7QY6gVH6L3PUYwfoyseoO4FAYbjOM5ysaScOE8YP
         /KYLjc3mtvGsA5dBpV+K4X2VVg5sGeXHEqH4+BM+eHtT4Vk9fS8LDUpCHwzeI80MgJJa
         SvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573045; x=1743177845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyi2Rr9SaOyczZGGMiWNJUBy1cFm9hWX35qovven6VU=;
        b=urncYhJg0r9mR5jNjMPgIt4B26q5vLtcD4eMEOwp0PeGytiiCe+p+bQkoVlpSrH630
         mntDGeiGkxiZJASA7sWhQLgEUzBbtCOIXyXhO8RralJGsKb65dcAtB07CKJQ92jR88iy
         bnKfhatZXr+TVtveSJYFxmNOeT8j/QU2RiVu+aXdfoR2tUniOrQlsRWiePB5HX4XdvBS
         3FhJJPfm+EULfzzaUhBlOl5zshlAkVEvIGdx5gJm7Vnqgzxlp2VBRfERoHqrPYwzF1gb
         1yv3JixmV+kIXKFMh/duU+wBbseCVxxAwb3RYmErMTd73bJbWLez9AP6tU9zWtDCB/rw
         bs9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo3kYphEsmrOGWqrrU5AJa/prhhzmMHMbbKGfraLSR30L5ukOgavHaMVmxU0aTHUausGFX/BM4/62EJ63x1hY=@vger.kernel.org, AJvYcCWKvK3JM9R3SteWibAC5Je9yyQzJpW8qOju1dPRr9t03za2PUjn3QpOIPoV09oeL8zJhLSTUlc0/6VMrA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FuIu2aXq0pPQkkpRDesJ0lC2J63nvukLMGH1RHChMvKAI9yZ
	wph+bdAIfQtPoidF5bQ0xH8nw1/4+pmg6acdwTH84X3zObr6Wyvd
X-Gm-Gg: ASbGncsyQV/QcYy+NvJdruTdm2oZEQqkmWim2TAEeklpOntcvazYypNjz6Cdvjm6LsA
	5KHmwbULkqA74fuHuB3xdrsqGRScu0nWHaQvK4S1uARHQNqk6wdgwtvw9LkI0g1HNt6LiGj5QyE
	oJkAm08NuW+ZF0TRamgm5A/E60Qy01qgz003U7Ljki/B3wO4EDXGiGAcu3KkdksRjoM/nZdvCWL
	+RHR3ChS7gCOcb4QAz8IerSzyRWGyRbHRMgmG8np9sZFNp6zf6xsWQlKLuRjXhDizAIv88ynMsx
	2okNVtgxgqjnOjsWzqWxSpYABeMBY3D+iQtX+lYKEBXa
X-Google-Smtp-Source: AGHT+IHF0qb/V8nbgK2enXw6+1E7YuoFPMHuoZDz2wHDCOo6rJlF9BhjhSbx0DAr41xP3ahZaba7uw==
X-Received: by 2002:a05:6a21:6494:b0:1f5:520d:fb93 with SMTP id adf61e73a8af0-1fe42f5822bmr7268573637.24.1742573045033;
        Fri, 21 Mar 2025 09:04:05 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618efdbsm2163599b3a.178.2025.03.21.09.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:04:04 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:04:01 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] rust: add bitmap API.
Message-ID: <Z92N8dyIE42ROW2t@thinkpad>
References: <20250321111535.3740332-1-bqe@google.com>
 <20250321111535.3740332-4-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321111535.3740332-4-bqe@google.com>

On Fri, Mar 21, 2025 at 11:15:31AM +0000, Burak Emir wrote:
> Provides an abstraction for C bitmap API and bitops operations.
> Includes enough to implement a Binder data structure that was
> introduced in commit 15d9da3f818c ("binder: use bitmap for faster
> descriptor lookup"), namely drivers/android/dbitmap.h.
> 
> The implementation is optimized to represent the bitmap inline
> if it would take the space of a pointer. This saves allocations.
> We offer a safe API through bounds checks which panic if violated.
> 
> We use the `usize` type for sizes and indices into the bitmap,
> because Rust generally always uses that type for indices and lengths
> and it will be more convenient if the API accepts that type. This means
> that we need to perform some casts to/from u32 and usize, since the C
> headers use unsigned int instead of size_t/unsigned long for these
> numbers in some places.
> 
> Adds new MAINTAINERS section BITMAP API [RUST].
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS           |   7 +
>  rust/kernel/bitmap.rs | 293 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   1 +
>  3 files changed, 301 insertions(+)
>  create mode 100644 rust/kernel/bitmap.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7cd15c25a43c..bc8f05431689 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4114,6 +4114,13 @@ S:	Maintained
>  F:	rust/helpers/bitmap.c
>  F:	rust/helpers/cpumask.c
>  
> +BITMAP API [RUST]
> +M:	Alice Ryhl <aliceryhl@google.com>
> +M:	Burak Emir <bqe@google.com>
> +R:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/kernel/bitmap.rs
> +
>  BITOPS API
>  M:	Yury Norov <yury.norov@gmail.com>
>  R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> new file mode 100644
> index 000000000000..118dceaf2b4b
> --- /dev/null
> +++ b/rust/kernel/bitmap.rs
> @@ -0,0 +1,293 @@
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
> +/// Holds either a pointer to array of `unsigned long` or a small bitmap.
> +#[repr(C)]
> +union BitmapRepr {
> +  bitmap: usize,
> +  ptr: NonNull<usize>
> +}
> +
> +/// Represents a bitmap.
> +///
> +/// Wraps underlying C bitmap API.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +///
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

In C we separate declarations from function body with an empty line.
Can you do that in rust? Can you point to a rust coding style? Do you
guys really use 2-whitespace tabs?

> +/// assert_eq!(Some(1), b.next_zero_bit(0));
> +/// assert_eq!(Some(5), b.next_zero_bit(5));
> +/// assert_eq!(Some(12), b.last_bit());
> +/// # Ok::<(), Error>(())
> +/// ```

I think I already asked to make the test a separate unit. It's amazing
that rust understands scattered commented blocks of code and can turn
them into unit tests. Unfortunately, I'm not.

Please create a separate unit and test everything there, just like we
do with normal C code.

For find_bit functions we have a lib/find_bit_benchmark.c Can you add
a similar rust test, so we'll make sure you're not introducing
performance regressions with your wrappers?

Please don't use KUNITs. It's not ready for benchmarks, and tests built
against it don't run on major distros.

> +///
> +/// Requesting too large values results in [`AllocError`]
> +///
> +/// ```
> +/// use kernel::alloc::flags::GFP_KERNEL;
> +/// use kernel::bitmap::Bitmap;
> +/// assert!(Bitmap::new(1 << 31, GFP_KERNEL).is_err());
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// * `nbits` is `<= i32::MAX - 1` and never changes.

Undershoot this time. It's exactly i32::MAX.

> +/// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a bitmap.
> +/// * otherwise, `repr` holds a non-null pointer that was obtained from a
> +///   successful call to `bitmap_zalloc` and holds the address of an initialized
> +///   array of `unsigned long` that is large enough to hold `nbits` bits.

Are you sure a public method description should bear implementation
details? I'm not. If implementation changes in future, the public API
should stay stable (yes, including comments).

> +pub struct Bitmap {
> +    /// Representation of bitmap.
> +    repr: BitmapRepr,
> +    /// Length of this bitmap. Must be `<= i32::MAX - 1`.
> +    nbits: usize,
> +}
> +
> +impl Drop for Bitmap {
> +    fn drop(&mut self) {
> +        if self.nbits <= bindings::BITS_PER_LONG as _ {
> +            return
> +        }
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
> +    /// If the length `nbits` is small enough to admit inline representation, this

The "length nbits" is a tautology.

> +    /// implementation does not allocate.
> +    ///
> +    /// Fails with [`AllocError`] when the [`Bitmap`] could not be allocated. This
> +    /// includes the case when `nbits` is greater than `i32::MAX - 1`.
> +    #[inline]
> +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
> +        if nbits <= bindings::BITS_PER_LONG as _ {
> +            return Ok(Bitmap { repr: BitmapRepr { bitmap: 0 }, nbits });
> +        }
> +        if nbits <= i32::MAX.try_into().unwrap() {

OK, I'm not a rust professional, but I have a serious question: is
this method chain the simplest way to compare two numbers?

> +            let nbits_u32 = u32::try_from(nbits).unwrap();
> +            // SAFETY: `nbits <= i32::MAX - 1` and the C function handles `nbits == 0`.
> +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> +            let ptr = NonNull::new(ptr).ok_or(AllocError)?;
> +            // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` checked.
> +            return Ok(Bitmap {
> +                repr: BitmapRepr { ptr },
> +                nbits,
> +            });
> +        }
> +        Err(AllocError)

Can you revert the logic and save indentation level?

> +    }
> +
> +    /// Returns length of this [`Bitmap`].
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.nbits
> +    }
> +
> +    /// Returns a mutable raw pointer to the backing [`Bitmap`].
> +    #[inline]
> +    fn as_mut_ptr(&mut self) -> *mut usize {
> +        if self.nbits <= bindings::BITS_PER_LONG as _ {
> +            // SAFETY: Bitmap is represented inline.
> +            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> +        } else {
> +            // SAFETY: Bitmap is represented as array of `unsigned long`.
> +            unsafe { self.repr.ptr.as_mut() }
> +        }
> +    }
> +
> +    /// Returns a raw pointer to the backing [`Bitmap`].
> +    #[inline]
> +    fn as_ptr(&self) -> *const usize {
> +        if self.nbits <= bindings::BITS_PER_LONG as _ {
> +            // SAFETY: Bitmap is represented inline.
> +            unsafe { core::ptr::addr_of!(self.repr.bitmap) }
> +        } else {
> +            // SAFETY: Bitmap is represented as array of `unsigned long`.
> +            unsafe { self.repr.ptr.as_ptr() }
> +        }
> +    }
> +
> +    /// Set bit with index `index`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn set_bit(&mut self, index: usize) {
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
> +    /// Set bit with index `index`, atomically.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.

I think we agreed that if you decide to change set_bit() notation from
atomic to non-atomic, you'll add a beefy paragraph explaining your
choice. Please do so. Please prepend your paragraph with an ATTENTION!
or even WARNING! eye-catcher. Please describe it in cover-letter, commit
message and here, right in the source code. 

Is there any mechanism in rust to enforce the rule: set_bit_atomic() is
never for more than once in a raw on the same bitmap, or together with
a non-atomic bitmap function, like dbitmap.h does? C lacks for it desperately.

> +    #[inline]
> +    pub fn set_bit_atomic(&self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: `index` is within bounds and `set_bit` is atomic.
> +        unsafe { bindings::set_bit(index as u32, self.as_ptr() as *mut usize) };
> +    }
> +
> +    /// Clear bit with index `index`.

Index 'index' is also a tautology. Can you just say:
        Clear 'index' bit

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
> +        // SAFETY: `index` is within bounds.
> +        unsafe { bindings::__clear_bit(index as u32, self.as_mut_ptr()) };
> +    }
> +
> +    /// Clear bit with index `index`, atomically.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn clear_bit_atomic(&self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: `index` is within bounds and `clear_bit` is atomic.
> +        unsafe { bindings::clear_bit(index as u32, self.as_ptr() as *mut usize) };
> +    }
> +
> +    /// Copy `src` into this [`Bitmap`] and set any remaining bits to zero.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::Bitmap;
> +    ///
> +    /// let mut long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
> +    /// assert_eq!(None, long_bitmap.last_bit());
> +    /// let mut short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
> +    /// short_bitmap.set_bit(7);
> +    ///
> +    /// long_bitmap.copy_and_extend(&short_bitmap);
> +    /// assert_eq!(Some(7), long_bitmap.last_bit());
> +    ///
> +    /// long_bitmap.clear_bit(7);
> +    /// assert_eq!(None, long_bitmap.last_bit());
> +    ///
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn copy_and_extend(&mut self, src: &Bitmap) {
> +        let len = core::cmp::min(src.nbits, self.nbits);
> +        // SAFETY: access to `self` and `src` is within bounds.
> +        unsafe {
> +            bindings::bitmap_copy_and_extend(
> +                self.as_mut_ptr(),
> +                src.as_ptr(),
> +                len as u32,
> +                self.nbits as u32,
> +            )
> +        };
> +    }
> +
> +    /// Finds last bit that is set.

Find last set bit, please.

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::Bitmap;
> +    ///
> +    /// let bitmap = Bitmap::new(64, GFP_KERNEL)?;
> +    /// match bitmap.last_bit() {
> +    ///     Some(idx) => {
> +    ///         pr_info!("The last bit has index {idx}.\n");
> +    ///     }
> +    ///     None => {
> +    ///         pr_info!("All bits in this bitmap are 0.\n");
> +    ///     }
> +    /// }
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn last_bit(&self) -> Option<usize> {
> +        // SAFETY: `nbits == 0` is supported and access is within bounds.
> +        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) };
> +        if index == self.nbits {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }
> +
> +    /// Finds next zero bit, starting from `start`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
> +        assert!(
> +            start < self.nbits,
> +            "Offset `start` must be < {}, was {}",

The 'offset' and 'start' here are the same. You can use just 'start'.
Are you sure that rust printing function will handle backquotes properly?

I'm not sure that every user of bitmaps should panic if he goes out of
boundaries. If your assert() is similar to WARN_ON() or BUG_ON(), it's
wrong. You can do that in client code, but not in a generic library.
(Except for hardening reasons under a corresponding config.)

for_each_set_bitrange() is an example where offset >= nbits is an
expected and normal behavior.

> +            self.nbits,
> +            start
> +        );
> +
> +        // SAFETY: access is within bounds.
> +        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.nbits, start) };
> +        if index == self.nbits {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 6b46bc481d94..9f675c0841e6 100644
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
> 2.49.0.395.g12beb8f557-goog


Return-Path: <linux-kernel+bounces-554847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC322A5A1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144C67A1200
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B584233731;
	Mon, 10 Mar 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iuisjxba"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A622206BD;
	Mon, 10 Mar 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630347; cv=none; b=P4ClkKkkBWm0L6vGsoYbq/+9cjNqrs2CsmVRpXR79JzVGCCkBqlzC/GHLA5XXNXo09t5JXcTtWiM602dNrWfEd2PHENMXm61caRp9Bh8M9x2BR5HYKt+IavjAXTuhik0SeUfzLKzUvT5R/dSXriNUaQsKAZ50n9nRPp0j86Yz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630347; c=relaxed/simple;
	bh=NrpJUwzlH6slhIRSki4KNkG9q1W6osL9DdNOx666dIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz6dlIklgqdmMxPkAQlv+4LI9SOMpmCpl/09bCAvPk29wxTpjbkSFkjTOzirPva7uauYJgfBKnKD0q327qyq5dV75YUjbkA9eRO9ZASq3+8L8cmCO8hSWMA9yza/oZZrzBQvaS6p4a54eCzFVNBSFDX3IfnZv/VrMBVJu/ujaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iuisjxba; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6feaa0319d8so32357987b3.2;
        Mon, 10 Mar 2025 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741630344; x=1742235144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ON5FfAmKiR6LKZZSCPcvrPOMgoWs5LpV7rmyLdP1dBQ=;
        b=IuisjxbaGHQcX2n00XlSN1d+Zc9AIXCxtw/wc3caGwNuzpGdn000KllKY9jHJAiBPz
         l2bmMpIBrfEKr9rQJ2BbuI/3qGgsCSjjCG9sAeiu7i0al/gxVf9M75iCpcIgCg7fC4Mz
         g3U/+38A6t8+JHJ5sCH/oN2jYmNzWpcHPa5KvrXU0LuXyPLuf8eJIme7j0CLuAkLyYj8
         B+RETGIpMDa0s99r9431u8opH14KGJo7E/jgbT06iuRSfaiGzZbrj1iZ8iRLqr82i0aR
         /dEEVsOBOR4d2xBYEIvpTM+qdUCEkRzesER6WrzxVOVIeaxR7qwFGwBAAXd7fgXoYngB
         ma3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630344; x=1742235144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON5FfAmKiR6LKZZSCPcvrPOMgoWs5LpV7rmyLdP1dBQ=;
        b=PzeRqEN9tg+o/d2d1Qa40Lag96toxrk9IML9zSZe90Lm/qGNUfcWJZevRzm52CvsSX
         1H9eX0RtX7Ocl0uRHUAFTU3QIwkPDrpvSZ8yR7lY5fRDYh4s7RVSD/4/AlixfUL/R9dh
         adKG/whJd//U+ADt0P2CnLyEFp/cwF0fsoCyBCKVsEioPz2K4Oheeo4Mq/g7sMwi8K0/
         SXi+akn01PWFNasHZ0eln7T5cLE67mX3f6Ewz7gzssUQ5pvc4kc8zCXwZBI/VWbDBdzj
         RHCzlC9ox44J0azR74Tr40B8nGlh32uw9DOI5QaEIPCrA62bqZqblaY7zAhKPK1UrPVO
         oQfw==
X-Forwarded-Encrypted: i=1; AJvYcCXKdN9RKusZzwgTWKFbMxUt991Z7o196hQQYFWHSaE2e0l2KaCVA+WmyWXEd+QB7viNULdbrl8HXzdpCVM=@vger.kernel.org, AJvYcCXwbN/PXMxyhM8kYSvWSf5fL+g7ql5Nb8etxmXVC2Z4f95MCK6sNx5VsSc0dIZVu1C8wf4Pdu0xkBYUCDmJIC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzI+EmpUhwyWwYntcMeVDIEdzLnAyP4BD7LH0Uodjre0JJDwy
	5sl0nr1SYH1IV0Vtu+b5zOZPmeFrfgJsrOvV+1FITfxLbTD1dMJq
X-Gm-Gg: ASbGnct4WQbVPhPYsT7ubwpJkGyncOKh44IF1SoKuoFRSbR5VSq9aZ5lqOsxLXXgcv4
	wRf+Zqd7Fw2qpm2mDQ7wyK6FusqkiOiAp04gcrqPEDuR7CBHCaUnxbAIUIwSPU/DjQb+kb7hA0C
	msd/sjRB8ks7TdNoQKOTzKKfRXB8mPQ2eXq1HlkocWT2enfHAsPsQvur93zEwGStAkcO8AbJd87
	dAq6fkTEE+0r7yqzd6M9nhRLLIUEmkejqpua6V8Y/LL+yTmgaC/rS2pPIAbtmm8XIyOebfNviOc
	mH7iJnDQX4r3K4zn88HRnDvKMvhOjqyVhT3yGf8v3fI0A/x6R7h7AkpzxjSYckbkLnOCqWn+nu1
	CPVBZ
X-Google-Smtp-Source: AGHT+IEa4rx2D135RYmUd8w1mHFSLdS406PhIsqyy6QVJL8QDZHmPFCvbJsDt4/bttco8x4+4PofrA==
X-Received: by 2002:a05:690c:6382:b0:6fb:ab27:5748 with SMTP id 00721157ae682-6febf3aea3bmr195869167b3.33.1741630344045;
        Mon, 10 Mar 2025 11:12:24 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a81179sm22273817b3.52.2025.03.10.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:12:23 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:12:22 -0400
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
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
Message-ID: <Z88rhn5nVbd4-JSE@thinkpad>
References: <20250310161947.1767855-2-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310161947.1767855-2-bqe@google.com>

On Mon, Mar 10, 2025 at 04:19:46PM +0000, Burak Emir wrote:
> Adds a Rust bitmap API and necessary bitmap and bitops bindings.
> These are for porting the approach from commit 15d9da3f818c ("binder:
> use bitmap for faster descriptor lookup") to Rust. The functionality
> in dbitmap.h makes use of bitmap and bitops.

Please add it in the same series that converts dbitmap to rust. This
all is a dead code otherwise, right?

> The Rust bitmap API provides an abstraction to underlying bitmap
> and bitops operations. For now, we only include methods that are
> necessary for reimplementing dbitmap.h. It is straightforward to add
> more methods later, as needed. We offer a safe API through
> bounds checks which panic if violated.
> 
> We introduce bindings for the non-atomic variants __set_bit and
> __clear_bit, and use the _find_* variants instead of the find_*
> wrappers which enable small size optimization in C. These C
> small size optimizations do not carry over to Rust. The
> principle followed is that whenever there are plain variants, we use
> those.
> 
> This series uses the usize type for sizes and indices into the bitmap,
> because Rust generally always uses that type for indices and lengths
> and it will be more convenient if the API accepts that type. This means
> that we need to perform some casts to/from u32 and usize, since the C
> headers use unsigned int instead of size_t/unsigned long for these
> numbers in some places.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
> This is v3 of a patch introducing Rust bitmap API [v2]. Thanks
> for all the helpful comments!
> 
> Changes v2 --> v3:
> - change `bitmap_copy` to `copy_from_bitmap_and_extend` which
>   zeroes out extra bits. This enables dbitmap shrink and grow use
>   cases while offering a consistent and understandable Rust API for
>   other uses (Alice)
> 
> Changes v1 --> v2:
> - Rebased on Yury's v2 patch [1] and Viresh's v2 patch [2]
> - Removed import of `bindings::*`, keeping only prefix (Miguel)
> - Renamed panic methods to make more explicit (Miguel)
> - use markdown in doc comments and added example/kunit test (Miguel)
> - Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
> - Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice)
> - Changed calls from find_* to _find_*, removed helpers (Yury)
> - Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (Yury)
> 
> Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
> Link [2] https://lore.kernel.org/all/cover.1740726226.git.viresh.kumar@linaro.org/
> Link [v2]: https://lore.kernel.org/rust-for-linux/20250303114037.3259804-2-bqe@google.com/
> ---
>  MAINTAINERS                     |   8 ++
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/bitmap.c           |   8 ++
>  rust/helpers/bitops.c           |  13 +++
>  rust/helpers/helpers.c          |   2 +
>  rust/kernel/bitmap.rs           | 190 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +

Please submit rust code in a separate patch.

>  7 files changed, 223 insertions(+)
>  create mode 100644 rust/helpers/bitmap.c
>  create mode 100644 rust/helpers/bitops.c
>  create mode 100644 rust/kernel/bitmap.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d6e55d8593b..8f42fb1f24c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4032,12 +4032,15 @@ F:	tools/lib/find_bit.c
>  BITMAP API BINDINGS [RUST]
>  M:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
> +F:	rust/helpers/bitmap.c
>  F:	rust/helpers/cpumask.c
>  
>  BITMAP API [RUST]
>  M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> +M:	Alice Ryhl <aliceryhl@google.com> (bitmap)
>  R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
> +F:	rust/kernel/bitmap.rs
>  F:	rust/kernel/cpumask.rs
>  
>  BITOPS API
> @@ -4054,6 +4057,11 @@ F:	include/linux/bitops.h
>  F:	lib/test_bitops.c
>  F:	tools/*/bitops*
>  
> +BITOPS API BINDINGS [RUST]
> +M:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/helpers/bitops.c
> +
>  BLINKM RGB LED DRIVER
>  M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
>  S:	Maintained
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 673b1daa9a58..50416c1a3de9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <kunit/test.h>
> +#include <linux/bitmap.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
> new file mode 100644
> index 000000000000..1cc88b34d716
> --- /dev/null
> +++ b/rust/helpers/bitmap.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitmap.h>
> +
> +void rust_helper_bitmap_copy_and_extend(unsigned long *dst, const unsigned long *src, unsigned int count, unsigned int size)

How long is this line? Did you run checkpatch?

> +{
> +	bitmap_copy_and_extend(dst, src, count, size);
> +}
> diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> new file mode 100644
> index 000000000000..986dafb45184
> --- /dev/null
> +++ b/rust/helpers/bitops.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitops.h>
> +
> +void rust_helper___set_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	__set_bit(nr, addr);
> +}
> +
> +void rust_helper___clear_bit(unsigned int nr, volatile unsigned long *addr)

Volatile is only for atomic ops.

> +{
> +	__clear_bit(nr, addr);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index de2341cfd917..541d8cb30195 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -7,6 +7,8 @@
>   * Sorted alphabetically.
>   */
>  
> +#include "bitmap.c"
> +#include "bitops.c"
>  #include "blk.c"
>  #include "bug.c"
>  #include "build_assert.c"
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> new file mode 100644
> index 000000000000..b8fe18dff832
> --- /dev/null
> +++ b/rust/kernel/bitmap.rs
> @@ -0,0 +1,190 @@
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
> +/// Wraps underlying C bitmap structure.
> +///
> +/// # Invariants
> +///
> +/// * `ptr` is obtained from a successful call to `bitmap_zalloc` and
> +///   holds the address of an initialized array of unsigned long
> +///   that is large enough to hold `nbits` bits.
> +pub struct Bitmap {
> +    /// Pointer to an array of unsigned long.
> +    ptr: NonNull<usize>,
> +    /// How many bits this bitmap stores. Must be < 2^32.

Must be < INT_MAX, i.e. 2^32 - 1

> +    nbits: usize,
> +}
> +
> +impl Drop for Bitmap {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.ptr` was returned by bitmap_zalloc.
> +        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
> +    }
> +}
> +
> +#[cold]
> +fn panic_not_in_bounds_lt(arg: &'static str, len: usize, val: usize) -> ! {
> +    panic!("{arg} must be less than length {len}, was {val}");
> +}
> +
> +#[cold]
> +fn panic_not_in_bounds_le(arg: &'static str, len: usize, val: usize) -> ! {
> +    panic!("{arg} must be less than or equal to length {len}, was {val}");
> +}
> +
> +impl Bitmap {
> +    /// Constructs a new [`Bitmap`].
> +    ///
> +    /// Fails with AllocError if `nbits` is greater than or equal to 2^32,
> +    /// or when the bitmap could not be allocated.
> +    ///
> +    /// # Example
> +    ///
> +    /// ```
> +    /// # use kernel::bitmap::Bitmap;
> +    ///
> +    /// fn new_bitmap() -> Bitmap {
> +    ///   Bitmap::new(128, GFP_KERNEL).unwrap()
> +    /// }
> +    /// ```
> +    #[inline]
> +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
> +        if let Ok(nbits_u32) = u32::try_from(nbits) {
> +            // SAFETY: nbits == 0 is permitted and nbits fits in u32.

Different parts of bitmaps API have different types for the 'nbits'
The safe way would be limit it to 32-bit signed INT_MAX.

(This is a historical mess.)

> +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> +            // Zero-size allocation is ok and yields a dangling pointer.

Zero-sized allocation makes no sense, and usually is a sign of a bug.
What for you explicitly allow it?

> +            let ptr = NonNull::new(ptr).ok_or(AllocError)?;
> +            Ok(Bitmap { ptr, nbits })
> +        } else {
> +            Err(AllocError)
> +        }
> +    }
> +
> +    /// Returns how many bits this bitmap holds.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.nbits
> +    }
> +
> +    /// Returns true if this bitmap has length 0.
> +    #[inline]
> +    pub fn is_empty(&self) -> bool {
> +        self.nbits == 0
> +    }
> +
> +    /// Returns a mutable raw pointer to the backing bitmap.
> +    #[inline]
> +    pub fn as_mut_ptr(&mut self) -> *mut usize {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Returns a raw pointer to the backing bitmap.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const usize {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Sets bit with number `nr`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `nr` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn set_bit(&mut self, nr: usize) {
> +        if self.nbits <= nr {
> +            panic_not_in_bounds_lt("nr", self.nbits, nr)
> +        }
> +        // SAFETY: Bit nr is within bounds.
> +        unsafe { bindings::__set_bit(nr as u32, self.as_mut_ptr()) };
> +    }
> +
> +    /// Clears bit with number `nr`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `nr` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn clear_bit(&mut self, nr: usize) {
> +        if self.nbits <= nr {
> +            panic_not_in_bounds_lt("nr", self.nbits, nr);

"nr" what? If you add a message, I believe it should be a somewhat
informative message.

> +        }
> +        // SAFETY: Bit nr is within bounds.
> +        unsafe { bindings::__clear_bit(nr as u32, self.as_mut_ptr()) };
> +    }
> +
> +    /// Copies all bits from `src` and sets any remaining bits to zero.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `src.nbits` has more bits than this bitmap.
> +    #[inline]
> +    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) {
> +        if self.nbits < src.nbits {
> +            panic_not_in_bounds_le("src.nbits", self.nbits, src.nbits);

The _lt usually stands for 'less than', or '<'. And _le is 'less than or
equal', or '<='. But in your code you do exactly opposite. Is that on
purpose?

Also, you can make it similar to BUG_ON() semantics, so that it will
be a single line of code, not 3:

        RUST_PANIC("Copy: out of bonds", self.nbits < src.nbits);

And to that extend, panic message should be available to all rust
subsystems, just like BUG_ON().

> +        }
> +        // SAFETY: nbits == 0 is supported and access to `self` and `src` is within bounds.
> +        unsafe {
> +            bindings::bitmap_copy_and_extend(self.as_mut_ptr(), src.as_ptr(), src.nbits as u32, self.nbits as u32)
> +        };
> +    }
> +
> +    /// Finds the last bit.
> +    #[inline]
> +    pub fn find_last_bit(&self) -> usize {
> +        // SAFETY: nbits == 0 is supported and access is within bounds.
> +        unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) }
> +    }
> +
> +    /// Finds the last bit, searching up to `nbits` bits.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `nbits` is too large for this bitmap.
> +    #[inline]
> +    pub fn find_last_bit_upto(&self, nbits: usize) -> usize {

So this is not a binding, right? This is a new function. In C code we
don't support partial search. Can you confirm you need a partial
search here? What's your use scenario?

Really, this should go with the series that converts dbitmap.
Otherwise it's hard to understand what you're trying to do.

> +        if self.nbits < nbits {
> +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> +        }
> +        // SAFETY: nbits == 0 is supported and access is within bounds.
> +        unsafe { bindings::_find_last_bit(self.as_ptr(), nbits) }
> +    }
> +
> +    /// Finds the next zero bit, searching up to `nbits`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `nbits` is too large for this bitmap.
> +    #[inline]
> +    pub fn find_next_zero_bit_upto(&self, nbits: usize) -> usize {

1. This should be 'find_first_zero_bit'.

2. The same question as to previous function. In this case you will
most likely be OK with plain find_first_zero_bit(). So if it returns a
number greater than 'nbits', it means that first nbits are empty for
sure. Is it a performance trick?

> +        if self.nbits < nbits {
> +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> +        }
> +        // SAFETY: nbits == 0 is supported and access is within bounds.
> +        unsafe {
> +            bindings::_find_next_zero_bit(self.as_ptr(), nbits, 0 /* offset */)

For offset == 0 we have find_first_bit() functions.

> +        }
> +    }
> +
> +    /// Finds the next zero bit, searching up to `nbits` bits, with offset `offset`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `nbits` is too large for this bitmap.
> +    #[inline]
> +    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, offset: usize) -> usize {
> +        if self.nbits < nbits {
> +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> +        }
> +        // SAFETY: nbits == 0 and out-of-bounds offset is supported, and access is within bounds.

find_bit() functions are all safe against nbits == 0 or
offset >= nbits. If you add those panics for hardening reasons - it's
OK. If you add them to make your code safer - you don't need them. The
C version is already safe.

> +        unsafe { bindings::_find_next_zero_bit(self.as_ptr(), nbits, offset) }
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
> 2.49.0.rc0.332.g42c0ae87b1-goog


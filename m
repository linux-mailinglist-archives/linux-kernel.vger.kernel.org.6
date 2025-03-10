Return-Path: <linux-kernel+bounces-554720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333EDA59B89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAB21884CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5DD1C5D5C;
	Mon, 10 Mar 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfgnaLfX"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB612309BE;
	Mon, 10 Mar 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625140; cv=none; b=eDBNnCEVQ7TkoRCJ+pLYeg00W8f8VugHqoKZNDGPYoVYYNCW6oIoeK4weRCbVhYb3cDdB/O8UYZ3e4vU9uU7LkT7BS0LDVE0wOix3ryZXv6HKbamPy3wEakejg5mwvVcJlqo2JfR7V9Aly2Aybypp32bT2rccf3IOcuHZXgAaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625140; c=relaxed/simple;
	bh=dUHJnLuRhQUEp5bATO47cFdOOW5SVrK6Z66j7jfuz/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSlr2XpB6baHc0neVwiyAO57nI+jJ/tcxNYCE1HKxin5lWk5KEwUhQDt5eKVhe3P22i2DyIuGu7QdWW4a2C+KnAInRKh9VjTquHVE5Rve0oXUQiyGpiG92Z7Ugi6zjvUsm4MH1jYc63u0NytGUvfv+kH3dXt/IjoCNyhQhCebwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfgnaLfX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30615661f98so48472211fa.2;
        Mon, 10 Mar 2025 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741625136; x=1742229936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiE+Q7UK47J+dHgiSPPhu0XXxo3OoadMix/FGOTi0rc=;
        b=VfgnaLfXVD1QyNQNckhX6ooD2ttaRbKJeoQEh+jnV1lzicGP5r+r1FaRVm09mdjmvO
         zLsfyojs1vPLDU48B/JvIx7u2Pi9jNli4/FHZSY/euiOh5YxCUxWgi8eOIHar8VGVru3
         TyNVeVZwjUjPXX2We2oRI6OWsw/KxqkVzpdR3jdulfW3DCk2MgJy5iW7DpToZI/jIFCi
         aIsAciAfwlUZMuwlHZws1V6Hms/8wNUg9cdimOSH79686d412RAAuAHGKvDhZeA669EL
         ikRoj9CQaKyHCbPTmVCUtPV9iUBNElynf+cYkruWUE7pj1uHUDTaehC0yf7mO2U0KY5T
         7TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625136; x=1742229936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiE+Q7UK47J+dHgiSPPhu0XXxo3OoadMix/FGOTi0rc=;
        b=M1/TYfQdIdEfp2MIRTxWOQBPzpOIoHPpDsJpk7S/IUNYfHyqmxAojYznS/WvTvZhSf
         OeT+ThYG+gbZyk+13w42hefSpkNVQu9AFAn2GpTxBmFINyRPEtmaeqDUgIIJ0ETDk5Ul
         +zkFjgDFwMbGDIi1eId41qw2UgMD1xUcEZTetLngRRutukdt5K85FdCxvo/NCdXi1LSB
         9UhkKyCyRD0ICnCw3g0qQfT0BxKpHYiPXNgwyXGKTALKqDJLFuxvptLOGCpT03ol7nb8
         aoUQOpb8uay14LKhZzmejNUrnFu1PWQUoJlPakLlL/iShetkRfFt8/efsrvGniozx8aT
         HnFg==
X-Forwarded-Encrypted: i=1; AJvYcCUlgDwtPtYq9LheREajCWIesZ9DzDggxaWxOB7CbfYYy45lFlLhLJNuU+ZE+bhk2aNtRJch5szynPNK9GI=@vger.kernel.org, AJvYcCWYMwhPxKL9n0Sx/D8FI+Ni71wIYqSWYpsHuVQGPUeO/nlTjJkti5VVjGN8SDn58dP0Esi7Olij6OBrWGByXLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LI/OpaxisIXHFzKEVFLoSyF4rDgtVRp4Bj0C4+sQPbVRZwrf
	7UfA/IIj12TayuFTrrwlCEEIJKTivWCqAkOyjtOUFFi3Zc6odwgLdicDDBtIbCgSRS3SzKlyglR
	DikM7oG6P/2ReAlZ4+5Ax4bcHclw=
X-Gm-Gg: ASbGncsBQf9sPV4IRPS39kbX3tT/tcgQDqI7jgR0VW9zttA2bRBAVcqNfZqyu/37P9F
	kLDPAgkOeghrlxhLtvAqD53zPf4dTrU1R162apvLm1V4oTGViFFnSj9Q8SG9d7bJt7r95gapBts
	UBVCF7CRn04K2dU299oQnxlbtA
X-Google-Smtp-Source: AGHT+IGJQCxAdfEa1Hdsay43Kk3Rc0IKMGtk70rtjSL96n1Pnt7d521UpWn64mesGbDkvsgg3Esixerqx34iZi2tY5k=
X-Received: by 2002:a2e:bc23:0:b0:30c:1002:faa8 with SMTP id
 38308e7fff4ca-30c1002ff06mr18067711fa.7.1741625136298; Mon, 10 Mar 2025
 09:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310161947.1767855-2-bqe@google.com>
In-Reply-To: <20250310161947.1767855-2-bqe@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Mar 2025 12:44:59 -0400
X-Gm-Features: AQ5f1JpOXW70_rr9xVy7MfaOMBJM34eSajGvwG59jPIRyfqmzMst5H9lqPw7C-E
Message-ID: <CAJ-ks9nR9AcqK8WfHDshG4h+K9PzEa8Lwr3odn99r34y=zzWgA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Burak, some comments inline. Hopefully I haven't missed important
context from previous versions.

On Mon, Mar 10, 2025 at 12:21=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
>
> Adds a Rust bitmap API and necessary bitmap and bitops bindings.
> These are for porting the approach from commit 15d9da3f818c ("binder:
> use bitmap for faster descriptor lookup") to Rust. The functionality
> in dbitmap.h makes use of bitmap and bitops.
>
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
> Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gma=
il.com/
> Link [2] https://lore.kernel.org/all/cover.1740726226.git.viresh.kumar@li=
naro.org/
> Link [v2]: https://lore.kernel.org/rust-for-linux/20250303114037.3259804-=
2-bqe@google.com/
> ---
>  MAINTAINERS                     |   8 ++
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/bitmap.c           |   8 ++
>  rust/helpers/bitops.c           |  13 +++
>  rust/helpers/helpers.c          |   2 +
>  rust/kernel/bitmap.rs           | 190 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  7 files changed, 223 insertions(+)
>  create mode 100644 rust/helpers/bitmap.c
>  create mode 100644 rust/helpers/bitops.c
>  create mode 100644 rust/kernel/bitmap.rs
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d6e55d8593b..8f42fb1f24c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4032,12 +4032,15 @@ F:      tools/lib/find_bit.c
>  BITMAP API BINDINGS [RUST]
>  M:     Yury Norov <yury.norov@gmail.com>
>  S:     Maintained
> +F:     rust/helpers/bitmap.c
>  F:     rust/helpers/cpumask.c
>
>  BITMAP API [RUST]
>  M:     Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> +M:     Alice Ryhl <aliceryhl@google.com> (bitmap)
>  R:     Yury Norov <yury.norov@gmail.com>
>  S:     Maintained
> +F:     rust/kernel/bitmap.rs
>  F:     rust/kernel/cpumask.rs
>
>  BITOPS API
> @@ -4054,6 +4057,11 @@ F:       include/linux/bitops.h
>  F:     lib/test_bitops.c
>  F:     tools/*/bitops*
>
> +BITOPS API BINDINGS [RUST]
> +M:     Yury Norov <yury.norov@gmail.com>
> +S:     Maintained
> +F:     rust/helpers/bitops.c
> +
>  BLINKM RGB LED DRIVER
>  M:     Jan-Simon Moeller <jansimon.moeller@gmx.de>
>  S:     Maintained
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
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
> +void rust_helper_bitmap_copy_and_extend(unsigned long *dst, const unsign=
ed long *src, unsigned int count, unsigned int size)
> +{
> +       bitmap_copy_and_extend(dst, src, count, size);
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
> +void rust_helper___set_bit(unsigned int nr, volatile unsigned long *addr=
)
> +{
> +       __set_bit(nr, addr);
> +}
> +
> +void rust_helper___clear_bit(unsigned int nr, volatile unsigned long *ad=
dr)
> +{
> +       __clear_bit(nr, addr);
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
> +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h=
).
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bindings;
> +use core::ptr::NonNull;
> +
> +/// Wraps underlying C bitmap structure.

Missing article here.

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
> +    nbits: usize,

How come this isn't held as u32? There's a lot of conversion to u32
sprinkled around.

> +}
> +
> +impl Drop for Bitmap {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.ptr` was returned by bitmap_zalloc.

Ticks around `bitmap_zalloc` for consistency. I think this should also
have an INVARIANT section since after this call the invariant
described on Bitmap is broken.

> +        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
> +    }
> +}
> +
> +#[cold]
> +fn panic_not_in_bounds_lt(arg: &'static str, len: usize, val: usize) -> =
! {
> +    panic!("{arg} must be less than length {len}, was {val}");
> +}

Have you considered using build_error or returning an error?

> +
> +#[cold]
> +fn panic_not_in_bounds_le(arg: &'static str, len: usize, val: usize) -> =
! {
> +    panic!("{arg} must be less than or equal to length {len}, was {val}"=
);
> +}
> +
> +impl Bitmap {
> +    /// Constructs a new [`Bitmap`].
> +    ///
> +    /// Fails with AllocError if `nbits` is greater than or equal to 2^3=
2,
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
> +        if let Ok(nbits_u32) =3D u32::try_from(nbits) {
> +            // SAFETY: nbits =3D=3D 0 is permitted and nbits fits in u32=
.
> +            let ptr =3D unsafe { bindings::bitmap_zalloc(nbits_u32, flag=
s.as_raw()) };
> +            // Zero-size allocation is ok and yields a dangling pointer.
> +            let ptr =3D NonNull::new(ptr).ok_or(AllocError)?;
> +            Ok(Bitmap { ptr, nbits })
> +        } else {
> +            Err(AllocError)
> +        }
> +    }

Similar question to above: why return an error here but panic in the setter=
s?

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
> +        self.nbits =3D=3D 0
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

Could you describe the need for these functions in the commit message?
I would expect that leaking the internal pointer would be an anti-goal
of an abstraction like this.

> +
> +    /// Sets bit with number `nr`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `nr` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn set_bit(&mut self, nr: usize) {
> +        if self.nbits <=3D nr {
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
> +        if self.nbits <=3D nr {
> +            panic_not_in_bounds_lt("nr", self.nbits, nr);
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

 nit: `Bitmap` could be `Self` here.

> +        if self.nbits < src.nbits {
> +            panic_not_in_bounds_le("src.nbits", self.nbits, src.nbits);
> +        }
> +        // SAFETY: nbits =3D=3D 0 is supported and access to `self` and =
`src` is within bounds.
> +        unsafe {
> +            bindings::bitmap_copy_and_extend(self.as_mut_ptr(), src.as_p=
tr(), src.nbits as u32, self.nbits as u32)
> +        };
> +    }
> +
> +    /// Finds the last bit.
> +    #[inline]
> +    pub fn find_last_bit(&self) -> usize {
> +        // SAFETY: nbits =3D=3D 0 is supported and access is within boun=
ds.
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
> +        if self.nbits < nbits {
> +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> +        }
> +        // SAFETY: nbits =3D=3D 0 is supported and access is within boun=
ds.
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
> +        if self.nbits < nbits {
> +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> +        }
> +        // SAFETY: nbits =3D=3D 0 is supported and access is within boun=
ds.
> +        unsafe {
> +            bindings::_find_next_zero_bit(self.as_ptr(), nbits, 0 /* off=
set */)
> +        }
> +    }

How come `find_last_bit` exists but `find_next_zero_bit` does not? I
wonder if the APIs could be unified by taking optional sizes and
offsets.

> +
> +    /// Finds the next zero bit, searching up to `nbits` bits, with offs=
et `offset`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `nbits` is too large for this bitmap.
> +    #[inline]
> +    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, offset: u=
size) -> usize {
> +        if self.nbits < nbits {
> +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> +        }
> +        // SAFETY: nbits =3D=3D 0 and out-of-bounds offset is supported,=
 and access is within bounds.
> +        unsafe { bindings::_find_next_zero_bit(self.as_ptr(), nbits, off=
set) }
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
>
>

Cheers.
Tamir


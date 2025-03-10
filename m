Return-Path: <linux-kernel+bounces-555183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41399A5A69D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F2172F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490931E51F0;
	Mon, 10 Mar 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNJAqoGK"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D691DF24A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644114; cv=none; b=mO6GRMo9g+SBMw4o2c2L3QL0gegDRkkmpNmbVjcYGZMc9ZRA9qR7hamK6Sykw12SNm19cnZg/+aGRjfj2gral4g3WEF6D3jTPIBjPgnt/lPiotLFHB5ywaHAB9N0feSMi/kGIxWu54iddAJ6FoioF44ZFnv6CxmNb/cHOomTC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644114; c=relaxed/simple;
	bh=+eGmmaWMyDg7GFmmOWGAbmdPDUNqeEMOTVtcWBUbmsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cot6aLuEk/lC8gIAv49atsMiF9eEaqAK2ZWKvcevUfk7SSaefPAMOdoYQhlUqOTsA4Gb9SsGySGzJB2tDeFrL2reLJXmduirU2I5FfHC3jEDjNxjV3iqlNIyNhjVJ9JoSLlEX5cFsinmSsrs4un62p6Pvj2R4W5gr5h2BHTzwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QNJAqoGK; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-601c469cce3so13398eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741644110; x=1742248910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcDy5Pq3+r8QYsPj9Tf87S2cv1O96CD0DX33QFoxxo4=;
        b=QNJAqoGKJr1ozHs9dNzqERqxbcOVBNsD81fdCoE1WZCOs/CPlHc9TAGr3OiCZ8PQnA
         yPlHSKULEnVvvIADKSoZ21PX6Tut0o6KBWwdr2HQlIIQWPrCdRAWmHVFXDANPJ6Ci24T
         4ub/29UpJgnGqWLNfEH5DT+Lsv8Ln41TooIl53uxNBy4xFFz2g0z5SPAGYpixDbl9G0d
         /3co6ohBtcwcmXrTV9X1ksBUWdmARwqVagrYneQZubDSqUrAnzD+cX/qPA7F4EqH1LzH
         GWUAoADgjP8Fi70kfLEzjbYMCAtE1INQA+QAPoqRUi25HReaa3H1yvWMgNfeu89ULiuA
         ZEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644110; x=1742248910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcDy5Pq3+r8QYsPj9Tf87S2cv1O96CD0DX33QFoxxo4=;
        b=aelETaO72F0GAibPCzRdQGzfwJv31+MlI8davXS4rGth6l2APboyLdlUrEHxfL26Nu
         y9sKiSbYLJlRuCZYYwlaMfVyLBwUKp5qyUxC0ZIq94hXzewW3pvcIUfHfLqGATjGzx/k
         B5wcpLbhGq8MOQF07G3hLK566rl0q5TZxSF1LJlKkc8QB+MR7Ug8XfuZ5Lm2rpXCWY28
         WxvhMkxg0NT+SQShK/PPTh1DiKqEbPHsIvxiUQxnFDyFs48qL3pj+95E7pKsPdkdVLmn
         /GmApHBY4giHrIICexQkLoiuH9t8bVM8fYBrp4S2WToIPBtMb5+aBM72rcbliYu61rEP
         bTfA==
X-Forwarded-Encrypted: i=1; AJvYcCWSWWVoDJMiddWvuX9j4RtFlSxkqQ7y4bQ2B+fbYUxX+f0Y7w2iIqentKrAJsThbUa92fOLNPVg8N/efhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoybPGTYTMT9N93Bvi0Sd5JsjvJuMd/gwFRhR2YhBDx39FzKjj
	namzLikxYI05FsKz9YGXaOn+MWxveJb0df+I8vE/b1gEstJ9qdpSLTVdvFXMDePWEzSkxPn+4KH
	Dkv8ZWTEikYVnePu4zR4m67ayPVeMqjiLIN7M
X-Gm-Gg: ASbGnctAX5eN+o9a/I5kizfyCmDXo+dY87pAKTs8yFZ9TcKNMcoJqIZSdTE6lhher2u
	9F7+/JDKtx09ONkwhbCkhDoxKUxkl7pxRs1Xexhmt5AU0JTMSk0IhsBdXES46okUJW9ookjzBFH
	Wjag5qkYaqPY27VkO3UdBHAziuHFIeeOoxIoQjAEJcbRHD/D7TYjfbZDs=
X-Google-Smtp-Source: AGHT+IFGqRtNRIPTOBEa2rvZWn9a8Lo4OpDPMJwg3QLoQXrgdX24cfO+Q4AGm4W8pL5htO+2EBwjsJh2IEDKzAnlvrU=
X-Received: by 2002:a05:6808:2390:b0:3f8:498c:9ef7 with SMTP id
 5614622812f47-3f8498ca481mr3472280b6e.24.1741644109629; Mon, 10 Mar 2025
 15:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310161947.1767855-2-bqe@google.com> <Z88rhn5nVbd4-JSE@thinkpad>
In-Reply-To: <Z88rhn5nVbd4-JSE@thinkpad>
From: Burak Emir <bqe@google.com>
Date: Mon, 10 Mar 2025 23:01:37 +0100
X-Gm-Features: AQ5f1JosU1Jn1RAHJYQyDFs82XzwaaW4Rjrof0xWpZU1ONVgC7kJplrvPxVvRNU
Message-ID: <CACQBu=VJNA-BFyxGd6ZLCp3hH19emDZX_TikZb9O=_Amu+BwNQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 7:12=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, Mar 10, 2025 at 04:19:46PM +0000, Burak Emir wrote:
> > Adds a Rust bitmap API and necessary bitmap and bitops bindings.
> > These are for porting the approach from commit 15d9da3f818c ("binder:
> > use bitmap for faster descriptor lookup") to Rust. The functionality
> > in dbitmap.h makes use of bitmap and bitops.
>
> Please add it in the same series that converts dbitmap to rust. This
> all is a dead code otherwise, right?

Will do, after checking with Alice.
Agree it should be much easier to review.

> > The Rust bitmap API provides an abstraction to underlying bitmap
> > and bitops operations. For now, we only include methods that are
> > necessary for reimplementing dbitmap.h. It is straightforward to add
> > more methods later, as needed. We offer a safe API through
> > bounds checks which panic if violated.
> >
> > We introduce bindings for the non-atomic variants __set_bit and
> > __clear_bit, and use the _find_* variants instead of the find_*
> > wrappers which enable small size optimization in C. These C
> > small size optimizations do not carry over to Rust. The
> > principle followed is that whenever there are plain variants, we use
> > those.
> >
> > This series uses the usize type for sizes and indices into the bitmap,
> > because Rust generally always uses that type for indices and lengths
> > and it will be more convenient if the API accepts that type. This means
> > that we need to perform some casts to/from u32 and usize, since the C
> > headers use unsigned int instead of size_t/unsigned long for these
> > numbers in some places.
> >
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Burak Emir <bqe@google.com>
> > ---
> > This is v3 of a patch introducing Rust bitmap API [v2]. Thanks
> > for all the helpful comments!
> >
> > Changes v2 --> v3:
> > - change `bitmap_copy` to `copy_from_bitmap_and_extend` which
> >   zeroes out extra bits. This enables dbitmap shrink and grow use
> >   cases while offering a consistent and understandable Rust API for
> >   other uses (Alice)
> >
> > Changes v1 --> v2:
> > - Rebased on Yury's v2 patch [1] and Viresh's v2 patch [2]
> > - Removed import of `bindings::*`, keeping only prefix (Miguel)
> > - Renamed panic methods to make more explicit (Miguel)
> > - use markdown in doc comments and added example/kunit test (Miguel)
> > - Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
> > - Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice)
> > - Changed calls from find_* to _find_*, removed helpers (Yury)
> > - Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (Yury)
> >
> > Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@g=
mail.com/
> > Link [2] https://lore.kernel.org/all/cover.1740726226.git.viresh.kumar@=
linaro.org/
> > Link [v2]: https://lore.kernel.org/rust-for-linux/20250303114037.325980=
4-2-bqe@google.com/
> > ---
> >  MAINTAINERS                     |   8 ++
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers/bitmap.c           |   8 ++
> >  rust/helpers/bitops.c           |  13 +++
> >  rust/helpers/helpers.c          |   2 +
> >  rust/kernel/bitmap.rs           | 190 ++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |   1 +
>
> Please submit rust code in a separate patch.
>
Will do.

> >  7 files changed, 223 insertions(+)
> >  create mode 100644 rust/helpers/bitmap.c
> >  create mode 100644 rust/helpers/bitops.c
> >  create mode 100644 rust/kernel/bitmap.rs
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6d6e55d8593b..8f42fb1f24c6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4032,12 +4032,15 @@ F:    tools/lib/find_bit.c
> >  BITMAP API BINDINGS [RUST]
> >  M:   Yury Norov <yury.norov@gmail.com>
> >  S:   Maintained
> > +F:   rust/helpers/bitmap.c
> >  F:   rust/helpers/cpumask.c
> >
> >  BITMAP API [RUST]
> >  M:   Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> > +M:   Alice Ryhl <aliceryhl@google.com> (bitmap)
> >  R:   Yury Norov <yury.norov@gmail.com>
> >  S:   Maintained
> > +F:   rust/kernel/bitmap.rs
> >  F:   rust/kernel/cpumask.rs
> >
> >  BITOPS API
> > @@ -4054,6 +4057,11 @@ F:     include/linux/bitops.h
> >  F:   lib/test_bitops.c
> >  F:   tools/*/bitops*
> >
> > +BITOPS API BINDINGS [RUST]
> > +M:   Yury Norov <yury.norov@gmail.com>
> > +S:   Maintained
> > +F:   rust/helpers/bitops.c
> > +
> >  BLINKM RGB LED DRIVER
> >  M:   Jan-Simon Moeller <jansimon.moeller@gmx.de>
> >  S:   Maintained
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 673b1daa9a58..50416c1a3de9 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include <kunit/test.h>
> > +#include <linux/bitmap.h>
> >  #include <linux/blk-mq.h>
> >  #include <linux/blk_types.h>
> >  #include <linux/blkdev.h>
> > diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
> > new file mode 100644
> > index 000000000000..1cc88b34d716
> > --- /dev/null
> > +++ b/rust/helpers/bitmap.c
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitmap.h>
> > +
> > +void rust_helper_bitmap_copy_and_extend(unsigned long *dst, const unsi=
gned long *src, unsigned int count, unsigned int size)
>
> How long is this line? Did you run checkpatch?
>

Fixed. I had edited after running checkpatch.

> > +{
> > +     bitmap_copy_and_extend(dst, src, count, size);
> > +}
> > diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> > new file mode 100644
> > index 000000000000..986dafb45184
> > --- /dev/null
> > +++ b/rust/helpers/bitops.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitops.h>
> > +
> > +void rust_helper___set_bit(unsigned int nr, volatile unsigned long *ad=
dr)
> > +{
> > +     __set_bit(nr, addr);
> > +}
> > +
> > +void rust_helper___clear_bit(unsigned int nr, volatile unsigned long *=
addr)
>
> Volatile is only for atomic ops.
>

Fixed.

> > +{
> > +     __clear_bit(nr, addr);
> > +}
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index de2341cfd917..541d8cb30195 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -7,6 +7,8 @@
> >   * Sorted alphabetically.
> >   */
> >
> > +#include "bitmap.c"
> > +#include "bitops.c"
> >  #include "blk.c"
> >  #include "bug.c"
> >  #include "build_assert.c"
> > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > new file mode 100644
> > index 000000000000..b8fe18dff832
> > --- /dev/null
> > +++ b/rust/kernel/bitmap.rs
> > @@ -0,0 +1,190 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2025 Google LLC.
> > +
> > +//! Rust API for bitmap.
> > +//!
> > +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap=
.h).
> > +
> > +use crate::alloc::{AllocError, Flags};
> > +use crate::bindings;
> > +use core::ptr::NonNull;
> > +
> > +/// Wraps underlying C bitmap structure.
> > +///
> > +/// # Invariants
> > +///
> > +/// * `ptr` is obtained from a successful call to `bitmap_zalloc` and
> > +///   holds the address of an initialized array of unsigned long
> > +///   that is large enough to hold `nbits` bits.
> > +pub struct Bitmap {
> > +    /// Pointer to an array of unsigned long.
> > +    ptr: NonNull<usize>,
> > +    /// How many bits this bitmap stores. Must be < 2^32.
>
> Must be < INT_MAX, i.e. 2^32 - 1
>
Thanks for the catch, using the Rust constant u32::MAX.

> > +    nbits: usize,
> > +}
> > +
> > +impl Drop for Bitmap {
> > +    fn drop(&mut self) {
> > +        // SAFETY: `self.ptr` was returned by bitmap_zalloc.
> > +        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
> > +    }
> > +}
> > +
> > +#[cold]
> > +fn panic_not_in_bounds_lt(arg: &'static str, len: usize, val: usize) -=
> ! {
> > +    panic!("{arg} must be less than length {len}, was {val}");
> > +}
> > +
> > +#[cold]
> > +fn panic_not_in_bounds_le(arg: &'static str, len: usize, val: usize) -=
> ! {
> > +    panic!("{arg} must be less than or equal to length {len}, was {val=
}");
> > +}
> > +
> > +impl Bitmap {
> > +    /// Constructs a new [`Bitmap`].
> > +    ///
> > +    /// Fails with AllocError if `nbits` is greater than or equal to 2=
^32,
> > +    /// or when the bitmap could not be allocated.
> > +    ///
> > +    /// # Example
> > +    ///
> > +    /// ```
> > +    /// # use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// fn new_bitmap() -> Bitmap {
> > +    ///   Bitmap::new(128, GFP_KERNEL).unwrap()
> > +    /// }
> > +    /// ```
> > +    #[inline]
> > +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError>=
 {
> > +        if let Ok(nbits_u32) =3D u32::try_from(nbits) {
> > +            // SAFETY: nbits =3D=3D 0 is permitted and nbits fits in u=
32.
>
> Different parts of bitmaps API have different types for the 'nbits'
> The safe way would be limit it to 32-bit signed INT_MAX.
>
> (This is a historical mess.)
>

As we only need to check bounds here once, we can use `usize`
as is the choice for all indices in Rust.
As above, changed to u32::MAX.

> > +            let ptr =3D unsafe { bindings::bitmap_zalloc(nbits_u32, fl=
ags.as_raw()) };
> > +            // Zero-size allocation is ok and yields a dangling pointe=
r.
>
> Zero-sized allocation makes no sense, and usually is a sign of a bug.
> What for you explicitly allow it?
>

I copied from dbitmap, but more importantly Rust requires that when
memory is accessed, it has to be initialized before. So if I used alloc,
I'd have to initialize manually.

> > +            let ptr =3D NonNull::new(ptr).ok_or(AllocError)?;
> > +            Ok(Bitmap { ptr, nbits })
> > +        } else {
> > +            Err(AllocError)
> > +        }
> > +    }
> > +
> > +    /// Returns how many bits this bitmap holds.
> > +    #[inline]
> > +    pub fn len(&self) -> usize {
> > +        self.nbits
> > +    }
> > +
> > +    /// Returns true if this bitmap has length 0.
> > +    #[inline]
> > +    pub fn is_empty(&self) -> bool {
> > +        self.nbits =3D=3D 0
> > +    }
> > +
> > +    /// Returns a mutable raw pointer to the backing bitmap.
> > +    #[inline]
> > +    pub fn as_mut_ptr(&mut self) -> *mut usize {
> > +        self.ptr.as_ptr()
> > +    }
> > +
> > +    /// Returns a raw pointer to the backing bitmap.
> > +    #[inline]
> > +    pub fn as_ptr(&self) -> *const usize {
> > +        self.ptr.as_ptr()
> > +    }
> > +
> > +    /// Sets bit with number `nr`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `nr` is greater than or equal to `self.nbits`.
> > +    #[inline]
> > +    pub fn set_bit(&mut self, nr: usize) {
> > +        if self.nbits <=3D nr {
> > +            panic_not_in_bounds_lt("nr", self.nbits, nr)
> > +        }
> > +        // SAFETY: Bit nr is within bounds.
> > +        unsafe { bindings::__set_bit(nr as u32, self.as_mut_ptr()) };
> > +    }
> > +
> > +    /// Clears bit with number `nr`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `nr` is greater than or equal to `self.nbits`.
> > +    #[inline]
> > +    pub fn clear_bit(&mut self, nr: usize) {
> > +        if self.nbits <=3D nr {
> > +            panic_not_in_bounds_lt("nr", self.nbits, nr);
>
> "nr" what? If you add a message, I believe it should be a somewhat
> informative message.
>

Changing to "Bit number".

> > +        }
> > +        // SAFETY: Bit nr is within bounds.
> > +        unsafe { bindings::__clear_bit(nr as u32, self.as_mut_ptr()) }=
;
> > +    }
> > +
> > +    /// Copies all bits from `src` and sets any remaining bits to zero=
.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `src.nbits` has more bits than this bitmap.
> > +    #[inline]
> > +    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) {
> > +        if self.nbits < src.nbits {
> > +            panic_not_in_bounds_le("src.nbits", self.nbits, src.nbits)=
;
>
> The _lt usually stands for 'less than', or '<'. And _le is 'less than or
> equal', or '<=3D'. But in your code you do exactly opposite. Is that on
> purpose?
>

Yeah, I realize this is a bit hard to read. Made the check consistent
with the panic message call.

> Also, you can make it similar to BUG_ON() semantics, so that it will
> be a single line of code, not 3:
>
>         RUST_PANIC("Copy: out of bonds", self.nbits < src.nbits);
>
> And to that extend, panic message should be available to all rust
> subsystems, just like BUG_ON().
>

A general bound checking macro BUG_ON sounds interesting
I will have to ask the other folks about this. For now, I'd like
to keep the simpler but more verbose if & panic.

> > +        }
> > +        // SAFETY: nbits =3D=3D 0 is supported and access to `self` an=
d `src` is within bounds.
> > +        unsafe {
> > +            bindings::bitmap_copy_and_extend(self.as_mut_ptr(), src.as=
_ptr(), src.nbits as u32, self.nbits as u32)
> > +        };
> > +    }
> > +
> > +    /// Finds the last bit.
> > +    #[inline]
> > +    pub fn find_last_bit(&self) -> usize {
> > +        // SAFETY: nbits =3D=3D 0 is supported and access is within bo=
unds.
> > +        unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) }
> > +    }
> > +
> > +    /// Finds the last bit, searching up to `nbits` bits.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `nbits` is too large for this bitmap.
> > +    #[inline]
> > +    pub fn find_last_bit_upto(&self, nbits: usize) -> usize {
>
> So this is not a binding, right? This is a new function. In C code we
> don't support partial search. Can you confirm you need a partial
> search here? What's your use scenario?
>
> Really, this should go with the series that converts dbitmap.
> Otherwise it's hard to understand what you're trying to do.
>

Tamir asked about these as well. I think I misunderstood the
C API as supporting partial search, and wanted to make
sure the functionality is preserved.

I now realize that the intention of the size parameter is to always
pass the size. Will remove.

> > +        if self.nbits < nbits {
> > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > +        }
> > +        // SAFETY: nbits =3D=3D 0 is supported and access is within bo=
unds.
> > +        unsafe { bindings::_find_last_bit(self.as_ptr(), nbits) }
> > +    }
> > +
> > +    /// Finds the next zero bit, searching up to `nbits`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `nbits` is too large for this bitmap.
> > +    #[inline]
> > +    pub fn find_next_zero_bit_upto(&self, nbits: usize) -> usize {
>
> 1. This should be 'find_first_zero_bit'.
>
> 2. The same question as to previous function. In this case you will
> most likely be OK with plain find_first_zero_bit(). So if it returns a
> number greater than 'nbits', it means that first nbits are empty for
> sure. Is it a performance trick?
>

No, I just looked at the find_first_zero implementation and thought
that it supports partial search. Removing.

> > +        if self.nbits < nbits {
> > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > +        }
> > +        // SAFETY: nbits =3D=3D 0 is supported and access is within bo=
unds.
> > +        unsafe {
> > +            bindings::_find_next_zero_bit(self.as_ptr(), nbits, 0 /* o=
ffset */)
>
> For offset =3D=3D 0 we have find_first_bit() functions.
>

Good point, I will remove this and expose only the variant with offset.
That is the one used by dbitmap anyways.

> > +        }
> > +    }
> > +
> > +    /// Finds the next zero bit, searching up to `nbits` bits, with of=
fset `offset`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `nbits` is too large for this bitmap.
> > +    #[inline]
> > +    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, offset:=
 usize) -> usize {
> > +        if self.nbits < nbits {
> > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > +        }
> > +        // SAFETY: nbits =3D=3D 0 and out-of-bounds offset is supporte=
d, and access is within bounds.
>
> find_bit() functions are all safe against nbits =3D=3D 0 or
> offset >=3D nbits. If you add those panics for hardening reasons - it's
> OK. If you add them to make your code safer - you don't need them. The
> C version is already safe.
>

I assume you are asking about the SAFETY comment, not the bound check.

The convention with SAFETY comments is in the Rust coding guidelines.
The comments are there to convince the reader that the
immediately-following "unsafe {...}" block can never lead to undefined beha=
vior.
I looked at the C code and documented that it is safe, so the reader
does not have to. The goal
is to enable local reasoning, so the reader can check a piece of code
in isolation.

I call out the nbits =3D=3D 0 case every time, because we are passing a
dangling pointer to C.
It may not be very obvious that this is an ok thing to do, and
explicit is better than implicit.

> > +        unsafe { bindings::_find_next_zero_bit(self.as_ptr(), nbits, o=
ffset) }
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index efbd7be98dab..be06ffc47473 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -36,6 +36,7 @@
> >  pub use ffi;
> >
> >  pub mod alloc;
> > +pub mod bitmap;
> >  #[cfg(CONFIG_BLOCK)]
> >  pub mod block;
> >  #[doc(hidden)]
> > --
> > 2.49.0.rc0.332.g42c0ae87b1-goog


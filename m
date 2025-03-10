Return-Path: <linux-kernel+bounces-555231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EDFA5A72E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA981892C23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D61EB5EA;
	Mon, 10 Mar 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8z3RZkW"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC71E5201
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645724; cv=none; b=dbM8d83QYiZITd5m58bK+4fYnTCkWyNvPxB2VFbk4YCkqt+/scrimp9hFhMGl6G5LhINjjbQEOUf3tYx93oPr0ON8hgSRrSv5ZrtRczE4kTECLUM68zuWvSWibkfadl0Rrf6cqgpT+BjvaiP/bhMrnw13AsARgSmJs9CcJFYUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645724; c=relaxed/simple;
	bh=KC52TounBxThRftITgrb9mdvdopkmnbGeN0LkQix5W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPuUJ5J5UD4+Dh/7kz2uK4gkjHEghQnXMFRoEwOfYDw+3d4GD+fiMxe2FFgkRabT0+Y0b0S71eUkPBH3mMOIB2G8mdGrEeSaGdqWtRR5PBRnx7+awIzGV00515fPhT7SCtCZj8fUpVinJFlfIMbHOLWLvE3hijDpnFkx8nfEcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8z3RZkW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f6a92f2328so1174020b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741645721; x=1742250521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqrPSmaSqRw8SPM21E3nUzcwrkLx6l7w1ihnwr2aK28=;
        b=e8z3RZkWawYO06214XFZRp97b6ef7Nb0EFVcugeICyAW5Vi0aEWorHsCqW/RjBUYaV
         2xh/8vznuNed8S03QP1EBLA0/rM14vK/9HQmDgprNMx0UFcwmNaq1I0v64eBLtMOf6xd
         Ma4KhrDZxFzMiOYLT030dIA1Bjx41Qhg7VQdMCLg2WGNcpdEFp+J3R6vQm3hB6MikP8j
         7a7ECUO2UUxmRXYP8ypvMOitVYBbf+lBdlj2cYgC7sc0AGfp79qoYTM02FC6GvCj0ipP
         Yzs60g++uWobzBPhNYAsWel5N0BPzKuOQJsm0xjXQLRAGBfI6kkPowWp6ZmZUu3b1w5X
         tQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645721; x=1742250521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqrPSmaSqRw8SPM21E3nUzcwrkLx6l7w1ihnwr2aK28=;
        b=wHLhoU6zvRPUwRBIj6pLyXFwv3EEnRqeqZZY07qxa9ScjpgRYwTJAMJckXABoEThuB
         UzmiPsoFvPYxhqfSBMaL+nmJxXwgisYC15ZpbAXcos2CIYwoLc6Zi9k2mT+54D+RTYNS
         pgS6GpMwwy/IhXr8eQzR0pyBl0TFKh3V0a5aUZv7wLGzvqEJ3sjsQyPASVk7ZVVkj+My
         lwqqhB0o1zOa+FWeFmZrdAe/FbenBwrd/yWEY+Ez+j5ymnzO1tW8CE2DYurvg0X4B1NZ
         KTDnJq4K0Xlv+3iW5lku1EU5yL0XLcCuCtrlZqwpreLmRBMfHCKbXaLxBmQZLxEzlmBV
         ckZA==
X-Forwarded-Encrypted: i=1; AJvYcCWI8D2e4/GM/LSmFtIxQ6Echm3FWhUdO375yIxF6Vo1M8G3/WOHxuZlnCEDtO+HT5W80DBxmHcEOL/1yYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBOKtMTxePnAfU+c7mMj+YG1w53VHrfFIMrho2gmrvpoHagX8
	qiTU0wa4XlG7YsGFwX/9T8jfTL+0piJjxGTSF0xMByrLbNjVyfDUaE0qZjF1w3N5KpkPDCUZ5rV
	BHHG7bCjxc/+yOZYHUkUS2XK8aVnw+uBm/JKp
X-Gm-Gg: ASbGncsqWXixrFcErLZYq2B2VpWyHX5Ew4BIdFMdPmSXsFFYvgin9MpGsqDVrkqN9sr
	s06YpK/+Er8etUDAC/du8/Utpt18bLV9vHbg3H8Z6A0sniUvP2CddeXvgk6SNMsajag4Lj7UWCs
	IrqAMFoOFIFdycjwLWgKFLwSpH61GOEGQVpiSY3Pox2BkJ+EW9vXlqFdo=
X-Google-Smtp-Source: AGHT+IFE7WkDYw/fsL0MQwF/vsP0iDWuSJ5GzQYTrEBVNxHGuelMapjdq4Vs5faxrQ6ZI+/h35BFzXQwgh94yQ4ho1w=
X-Received: by 2002:a05:6808:189a:b0:3f3:b5b5:6bb1 with SMTP id
 5614622812f47-3fa2b310a51mr840086b6e.2.1741645720734; Mon, 10 Mar 2025
 15:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310161947.1767855-2-bqe@google.com> <CAJ-ks9nR9AcqK8WfHDshG4h+K9PzEa8Lwr3odn99r34y=zzWgA@mail.gmail.com>
 <CACQBu=UB2etHuSFoCHYWw6YwzHry9rwkV6U3uoNe+E3BBW+NYg@mail.gmail.com>
 <CAJ-ks9nN0MJ5pPS040CKY+aQOwX621TFtS_=L9T3WemJ0kwPdw@mail.gmail.com> <CACQBu=VbcL6bWV2iEH_0bJW4yw0S2F0L7sA97KkBgfzqmOCMLA@mail.gmail.com>
In-Reply-To: <CACQBu=VbcL6bWV2iEH_0bJW4yw0S2F0L7sA97KkBgfzqmOCMLA@mail.gmail.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 10 Mar 2025 23:28:28 +0100
X-Gm-Features: AQ5f1JqLhdJtb4NNeR6SpUCXfWdr6_noEQaVTvvB2yVP2NWvllFAPyYQV2TrTuA
Message-ID: <CACQBu=URkaotPGZbnRWiisYfvTSACua253B+eQb2ixo61Ob+tA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
To: Tamir Duberstein <tamird@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(adding everyone back to cc, sorry.)

On Mon, Mar 10, 2025 at 10:05=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
>
> On Mon, Mar 10, 2025 at 9:42=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > On Mon, Mar 10, 2025 at 4:27=E2=80=AFPM Burak Emir <bqe@google.com> wro=
te:
> > >
> > > On Mon, Mar 10, 2025 at 5:45=E2=80=AFPM Tamir Duberstein <tamird@gmai=
l.com> wrote:
> > > >
> > > > Hi Burak, some comments inline. Hopefully I haven't missed importan=
t
> > > > context from previous versions.
> > >
> > > Thanks for taking a look!
> > >
>
> Somehow I managed to hit Reply instead of Reply-All.
> I now wonder what happens with the threading if I add everyone back to cc=
 :/
>
> > > > On Mon, Mar 10, 2025 at 12:21=E2=80=AFPM Burak Emir <bqe@google.com=
> wrote:
> > > > >
> > > > > Adds a Rust bitmap API and necessary bitmap and bitops bindings.
> > > > > These are for porting the approach from commit 15d9da3f818c ("bin=
der:
> > > > > use bitmap for faster descriptor lookup") to Rust. The functional=
ity
> > > > > in dbitmap.h makes use of bitmap and bitops.
> > > > >
> > > > > The Rust bitmap API provides an abstraction to underlying bitmap
> > > > > and bitops operations. For now, we only include methods that are
> > > > > necessary for reimplementing dbitmap.h. It is straightforward to =
add
> > > > > more methods later, as needed. We offer a safe API through
> > > > > bounds checks which panic if violated.
> > > > >
> > > > > We introduce bindings for the non-atomic variants __set_bit and
> > > > > __clear_bit, and use the _find_* variants instead of the find_*
> > > > > wrappers which enable small size optimization in C. These C
> > > > > small size optimizations do not carry over to Rust. The
> > > > > principle followed is that whenever there are plain variants, we =
use
> > > > > those.
> > > > >
> > > > > This series uses the usize type for sizes and indices into the bi=
tmap,
> > > > > because Rust generally always uses that type for indices and leng=
ths
> > > > > and it will be more convenient if the API accepts that type. This=
 means
> > > > > that we need to perform some casts to/from u32 and usize, since t=
he C
> > > > > headers use unsigned int instead of size_t/unsigned long for thes=
e
> > > > > numbers in some places.
> > > > >
> > > > > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > > > > Signed-off-by: Burak Emir <bqe@google.com>
> > > > > ---
> > > > > This is v3 of a patch introducing Rust bitmap API [v2]. Thanks
> > > > > for all the helpful comments!
> > > > >
> > > > > Changes v2 --> v3:
> > > > > - change `bitmap_copy` to `copy_from_bitmap_and_extend` which
> > > > >   zeroes out extra bits. This enables dbitmap shrink and grow use
> > > > >   cases while offering a consistent and understandable Rust API f=
or
> > > > >   other uses (Alice)
> > > > >
> > > > > Changes v1 --> v2:
> > > > > - Rebased on Yury's v2 patch [1] and Viresh's v2 patch [2]
> > > > > - Removed import of `bindings::*`, keeping only prefix (Miguel)
> > > > > - Renamed panic methods to make more explicit (Miguel)
> > > > > - use markdown in doc comments and added example/kunit test (Migu=
el)
> > > > > - Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
> > > > > - Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice=
)
> > > > > - Changed calls from find_* to _find_*, removed helpers (Yury)
> > > > > - Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (=
Yury)
> > > > >
> > > > > Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.n=
orov@gmail.com/
> > > > > Link [2] https://lore.kernel.org/all/cover.1740726226.git.viresh.=
kumar@linaro.org/
> > > > > Link [v2]: https://lore.kernel.org/rust-for-linux/20250303114037.=
3259804-2-bqe@google.com/
> > > > > ---
> > > > >  MAINTAINERS                     |   8 ++
> > > > >  rust/bindings/bindings_helper.h |   1 +
> > > > >  rust/helpers/bitmap.c           |   8 ++
> > > > >  rust/helpers/bitops.c           |  13 +++
> > > > >  rust/helpers/helpers.c          |   2 +
> > > > >  rust/kernel/bitmap.rs           | 190 ++++++++++++++++++++++++++=
++++++
> > > > >  rust/kernel/lib.rs              |   1 +
> > > > >  7 files changed, 223 insertions(+)
> > > > >  create mode 100644 rust/helpers/bitmap.c
> > > > >  create mode 100644 rust/helpers/bitops.c
> > > > >  create mode 100644 rust/kernel/bitmap.rs
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 6d6e55d8593b..8f42fb1f24c6 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -4032,12 +4032,15 @@ F:      tools/lib/find_bit.c
> > > > >  BITMAP API BINDINGS [RUST]
> > > > >  M:     Yury Norov <yury.norov@gmail.com>
> > > > >  S:     Maintained
> > > > > +F:     rust/helpers/bitmap.c
> > > > >  F:     rust/helpers/cpumask.c
> > > > >
> > > > >  BITMAP API [RUST]
> > > > >  M:     Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> > > > > +M:     Alice Ryhl <aliceryhl@google.com> (bitmap)
> > > > >  R:     Yury Norov <yury.norov@gmail.com>
> > > > >  S:     Maintained
> > > > > +F:     rust/kernel/bitmap.rs
> > > > >  F:     rust/kernel/cpumask.rs
> > > > >
> > > > >  BITOPS API
> > > > > @@ -4054,6 +4057,11 @@ F:       include/linux/bitops.h
> > > > >  F:     lib/test_bitops.c
> > > > >  F:     tools/*/bitops*
> > > > >
> > > > > +BITOPS API BINDINGS [RUST]
> > > > > +M:     Yury Norov <yury.norov@gmail.com>
> > > > > +S:     Maintained
> > > > > +F:     rust/helpers/bitops.c
> > > > > +
> > > > >  BLINKM RGB LED DRIVER
> > > > >  M:     Jan-Simon Moeller <jansimon.moeller@gmx.de>
> > > > >  S:     Maintained
> > > > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bind=
ings_helper.h
> > > > > index 673b1daa9a58..50416c1a3de9 100644
> > > > > --- a/rust/bindings/bindings_helper.h
> > > > > +++ b/rust/bindings/bindings_helper.h
> > > > > @@ -7,6 +7,7 @@
> > > > >   */
> > > > >
> > > > >  #include <kunit/test.h>
> > > > > +#include <linux/bitmap.h>
> > > > >  #include <linux/blk-mq.h>
> > > > >  #include <linux/blk_types.h>
> > > > >  #include <linux/blkdev.h>
> > > > > diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
> > > > > new file mode 100644
> > > > > index 000000000000..1cc88b34d716
> > > > > --- /dev/null
> > > > > +++ b/rust/helpers/bitmap.c
> > > > > @@ -0,0 +1,8 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +#include <linux/bitmap.h>
> > > > > +
> > > > > +void rust_helper_bitmap_copy_and_extend(unsigned long *dst, cons=
t unsigned long *src, unsigned int count, unsigned int size)
> > > > > +{
> > > > > +       bitmap_copy_and_extend(dst, src, count, size);
> > > > > +}
> > > > > diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> > > > > new file mode 100644
> > > > > index 000000000000..986dafb45184
> > > > > --- /dev/null
> > > > > +++ b/rust/helpers/bitops.c
> > > > > @@ -0,0 +1,13 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +#include <linux/bitops.h>
> > > > > +
> > > > > +void rust_helper___set_bit(unsigned int nr, volatile unsigned lo=
ng *addr)
> > > > > +{
> > > > > +       __set_bit(nr, addr);
> > > > > +}
> > > > > +
> > > > > +void rust_helper___clear_bit(unsigned int nr, volatile unsigned =
long *addr)
> > > > > +{
> > > > > +       __clear_bit(nr, addr);
> > > > > +}
> > > > > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > > > > index de2341cfd917..541d8cb30195 100644
> > > > > --- a/rust/helpers/helpers.c
> > > > > +++ b/rust/helpers/helpers.c
> > > > > @@ -7,6 +7,8 @@
> > > > >   * Sorted alphabetically.
> > > > >   */
> > > > >
> > > > > +#include "bitmap.c"
> > > > > +#include "bitops.c"
> > > > >  #include "blk.c"
> > > > >  #include "bug.c"
> > > > >  #include "build_assert.c"
> > > > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > > > new file mode 100644
> > > > > index 000000000000..b8fe18dff832
> > > > > --- /dev/null
> > > > > +++ b/rust/kernel/bitmap.rs
> > > > > @@ -0,0 +1,190 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +// Copyright (C) 2025 Google LLC.
> > > > > +
> > > > > +//! Rust API for bitmap.
> > > > > +//!
> > > > > +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/=
bitmap.h).
> > > > > +
> > > > > +use crate::alloc::{AllocError, Flags};
> > > > > +use crate::bindings;
> > > > > +use core::ptr::NonNull;
> > > > > +
> > > > > +/// Wraps underlying C bitmap structure.
> > > >
> > > > Missing article here.
> > > >
> > > Ack, will reword.
> > >
> > > > > +///
> > > > > +/// # Invariants
> > > > > +///
> > > > > +/// * `ptr` is obtained from a successful call to `bitmap_zalloc=
` and
> > > > > +///   holds the address of an initialized array of unsigned long
> > > > > +///   that is large enough to hold `nbits` bits.
> > > > > +pub struct Bitmap {
> > > > > +    /// Pointer to an array of unsigned long.
> > > > > +    ptr: NonNull<usize>,
> > > > > +    /// How many bits this bitmap stores. Must be < 2^32.
> > > > > +    nbits: usize,
> > > >
> > > > How come this isn't held as u32? There's a lot of conversion to u32
> > > > sprinkled around.
> > > >
> > > On the C side, there is a limitation to a maximum of 2^32 bits. This =
is
> > > unfortunately not consistently used as argument type. Therefore one
> > > needs to cast in a few places. So if we used u32, we'd have to cast t=
o usize.
> > >
> > > Since usize is the idiomatic Rust choice for all sorts of indices, we=
 use usize.
> >
> > On the other hand u32 to usize cannot go out of bounds, while the
> > inverse isn't true.
> >
> > >
> > > > > +}
> > > > > +
> > > > > +impl Drop for Bitmap {
> > > > > +    fn drop(&mut self) {
> > > > > +        // SAFETY: `self.ptr` was returned by bitmap_zalloc.
> > > >
> > > > Ticks around `bitmap_zalloc` for consistency. I think this should a=
lso
> > > > have an INVARIANT section since after this call the invariant
> > > > described on Bitmap is broken.
> > >
> > > Fixed the comment.
> > >
> > > I think I'd agree if there was anything happening after the call.
> > > As it stands, drop() is finished after the call, the value will be go=
ne,
> > > and the stated invariant does not apply anymore.
> > >
> > > Are you worried about future additions to the struct?
> > > I could not find any example of a Drop impl where people bothered
> > >  to talk about invariants.
> >
> > Please see https://lore.kernel.org/all/20250221-rust-xarray-bindings-v1=
8-2-cbabe5ddfc32@gmail.com/.
> >
>
> Thanks, I added a similar text now.
>
> > >
> > > > > +        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +#[cold]
> > > > > +fn panic_not_in_bounds_lt(arg: &'static str, len: usize, val: us=
ize) -> ! {
> > > > > +    panic!("{arg} must be less than length {len}, was {val}");
> > > > > +}
> > > >
> > > > Have you considered using build_error or returning an error?
> > > >
> > >
> > > The bounds checks are done at runtime. There is client
> > > code that constructs bitmaps with an argument that is
> > > only known at runtime.
> >
> > Why not return an error?
> >
>
> A programmer mistake that messes up the bounds is not a recoverable
> situation, but a bug.
>
> > >
> > > > > +
> > > > > +#[cold]
> > > > > +fn panic_not_in_bounds_le(arg: &'static str, len: usize, val: us=
ize) -> ! {
> > > > > +    panic!("{arg} must be less than or equal to length {len}, wa=
s {val}");
> > > > > +}
> > > > > +
> > > > > +impl Bitmap {
> > > > > +    /// Constructs a new [`Bitmap`].
> > > > > +    ///
> > > > > +    /// Fails with AllocError if `nbits` is greater than or equa=
l to 2^32,
> > > > > +    /// or when the bitmap could not be allocated.
> > > > > +    ///
> > > > > +    /// # Example
> > > > > +    ///
> > > > > +    /// ```
> > > > > +    /// # use kernel::bitmap::Bitmap;
> > > > > +    ///
> > > > > +    /// fn new_bitmap() -> Bitmap {
> > > > > +    ///   Bitmap::new(128, GFP_KERNEL).unwrap()
> > > > > +    /// }
> > > > > +    /// ```
> > > > > +    #[inline]
> > > > > +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, Alloc=
Error> {
> > > > > +        if let Ok(nbits_u32) =3D u32::try_from(nbits) {
> > > > > +            // SAFETY: nbits =3D=3D 0 is permitted and nbits fit=
s in u32.
> > > > > +            let ptr =3D unsafe { bindings::bitmap_zalloc(nbits_u=
32, flags.as_raw()) };
> > > > > +            // Zero-size allocation is ok and yields a dangling =
pointer.
> > > > > +            let ptr =3D NonNull::new(ptr).ok_or(AllocError)?;
> > > > > +            Ok(Bitmap { ptr, nbits })
> > > > > +        } else {
> > > > > +            Err(AllocError)
> > > > > +        }
> > > > > +    }
> > > >
> > > > Similar question to above: why return an error here but panic in th=
e setters?
> > >
> > > The reasoning here is that:
> > > - failing bounds check is considered a programming error. Panic is
> > > better than undefined behavior.
> > > - however, memory allocation can fail also when the code is correct.
> >
> > `new` returns an error when the requested size is out of bounds; isn't
> > that a programming error? This doesn't appear to be consistent.
>
> I agree with this. Changing to panicking if nbits is too large.
>
> > >
> > > > > +
> > > > > +    /// Returns how many bits this bitmap holds.
> > > > > +    #[inline]
> > > > > +    pub fn len(&self) -> usize {
> > > > > +        self.nbits
> > > > > +    }
> > > > > +
> > > > > +    /// Returns true if this bitmap has length 0.
> > > > > +    #[inline]
> > > > > +    pub fn is_empty(&self) -> bool {
> > > > > +        self.nbits =3D=3D 0
> > > > > +    }
> > > > > +
> > > > > +    /// Returns a mutable raw pointer to the backing bitmap.
> > > > > +    #[inline]
> > > > > +    pub fn as_mut_ptr(&mut self) -> *mut usize {
> > > > > +        self.ptr.as_ptr()
> > > > > +    }
> > > > > +
> > > > > +    /// Returns a raw pointer to the backing bitmap.
> > > > > +    #[inline]
> > > > > +    pub fn as_ptr(&self) -> *const usize {
> > > > > +        self.ptr.as_ptr()
> > > > > +    }
> > > >
> > > > Could you describe the need for these functions in the commit messa=
ge?
> > > > I would expect that leaking the internal pointer would be an anti-g=
oal
> > > > of an abstraction like this.
> > > >
> > >
> > > Having access to pointers is not a problem, it is
> > > dereferencing of pointers that means leaving behind the
> > > guarantees of static checking and thus requires `unsafe`.
> >
> > I didn't say anything about safety. It is just plain old abstraction br=
eaking.
> >
>
> I see what you mean. Made these private.
>
> > >
> > > As there may be situations where client code may have to
> > > call underlying C methods with this pointers (which will also
> > > requires `unsafe` and safety comments) it should be ok to
> > > enable that.
> >
> > Should it? It would seem to me that such a situation is indicative of
> > an incomplete abstraction.
> >
>
> Agree it would certainly be desirable to hide the pointer. I realize I do
> not have an actual case where the pointer is needed outside
> the trait impl, and when the dbitmap is rewritten in Rust it
> should not have to deal with the pointer. So these are private now.
>
> > >
> > > > > +
> > > > > +    /// Sets bit with number `nr`.
> > > > > +    ///
> > > > > +    /// # Panics
> > > > > +    ///
> > > > > +    /// Panics if `nr` is greater than or equal to `self.nbits`.
> > > > > +    #[inline]
> > > > > +    pub fn set_bit(&mut self, nr: usize) {
> > > > > +        if self.nbits <=3D nr {
> > > > > +            panic_not_in_bounds_lt("nr", self.nbits, nr)
> > > > > +        }
> > > > > +        // SAFETY: Bit nr is within bounds.
> > > > > +        unsafe { bindings::__set_bit(nr as u32, self.as_mut_ptr(=
)) };
> > > > > +    }
> > > > > +
> > > > > +    /// Clears bit with number `nr`.
> > > > > +    ///
> > > > > +    /// # Panics
> > > > > +    ///
> > > > > +    /// Panics if `nr` is greater than or equal to `self.nbits`.
> > > > > +    #[inline]
> > > > > +    pub fn clear_bit(&mut self, nr: usize) {
> > > > > +        if self.nbits <=3D nr {
> > > > > +            panic_not_in_bounds_lt("nr", self.nbits, nr);
> > > > > +        }
> > > > > +        // SAFETY: Bit nr is within bounds.
> > > > > +        unsafe { bindings::__clear_bit(nr as u32, self.as_mut_pt=
r()) };
> > > > > +    }
> > > > > +
> > > > > +    /// Copies all bits from `src` and sets any remaining bits t=
o zero.
> > > > > +    ///
> > > > > +    /// # Panics
> > > > > +    ///
> > > > > +    /// Panics if `src.nbits` has more bits than this bitmap.
> > > > > +    #[inline]
> > > > > +    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) =
{
> > > >
> > > >  nit: `Bitmap` could be `Self` here.
> > > >
> > > Done.
> > >
> > > > > +        if self.nbits < src.nbits {
> > > > > +            panic_not_in_bounds_le("src.nbits", self.nbits, src.=
nbits);
> > > > > +        }
> > > > > +        // SAFETY: nbits =3D=3D 0 is supported and access to `se=
lf` and `src` is within bounds.
> > > > > +        unsafe {
> > > > > +            bindings::bitmap_copy_and_extend(self.as_mut_ptr(), =
src.as_ptr(), src.nbits as u32, self.nbits as u32)
> > > > > +        };
> > > > > +    }
> > > > > +
> > > > > +    /// Finds the last bit.
> > > > > +    #[inline]
> > > > > +    pub fn find_last_bit(&self) -> usize {
> > > > > +        // SAFETY: nbits =3D=3D 0 is supported and access is wit=
hin bounds.
> > > > > +        unsafe { bindings::_find_last_bit(self.as_ptr(), self.nb=
its) }
> > > > > +    }
> > > > > +
> > > > > +    /// Finds the last bit, searching up to `nbits` bits.
> > > > > +    ///
> > > > > +    /// # Panics
> > > > > +    ///
> > > > > +    /// Panics if `nbits` is too large for this bitmap.
> > > > > +    #[inline]
> > > > > +    pub fn find_last_bit_upto(&self, nbits: usize) -> usize {
> > > > > +        if self.nbits < nbits {
> > > > > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > > > > +        }
> > > > > +        // SAFETY: nbits =3D=3D 0 is supported and access is wit=
hin bounds.
> > > > > +        unsafe { bindings::_find_last_bit(self.as_ptr(), nbits) =
}
> > > > > +    }
> > > > > +
> > > > > +    /// Finds the next zero bit, searching up to `nbits`.
> > > > > +    ///
> > > > > +    /// # Panics
> > > > > +    ///
> > > > > +    /// Panics if `nbits` is too large for this bitmap.
> > > > > +    #[inline]
> > > > > +    pub fn find_next_zero_bit_upto(&self, nbits: usize) -> usize=
 {
> > > > > +        if self.nbits < nbits {
> > > > > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > > > > +        }
> > > > > +        // SAFETY: nbits =3D=3D 0 is supported and access is wit=
hin bounds.
> > > > > +        unsafe {
> > > > > +            bindings::_find_next_zero_bit(self.as_ptr(), nbits, =
0 /* offset */)
> > > > > +        }
> > > > > +    }
> > > >
> > > > How come `find_last_bit` exists but `find_next_zero_bit` does not? =
I
> > > > wonder if the APIs could be unified by taking optional sizes and
> > > > offsets.
> > > >
> > >
> > > Yeah, it would be good if a convention would emerge that one could
> > > then follow. This patch bundles pointer and nbits into a struct, so c=
lients
> > > of the Rust API will not have to provide size.
> > >
> > > On the other hand, the C API takes an argument and it could be anythi=
ng,
> > > also a number below size.
> > >
> > > I found it clearest to preserve the full flexibility of the API while=
 giving
> > > convenient alternative for the common case.
> >
> > I don't think this answers my questions.
> >
>
> I also got comments from Yury about these, so will have to think about th=
is.
>
> When I add the dbitmap use case, at least it will be clearer what is used=
.
>
> There is a general issue that C APIs take a size parameter. Maybe the
> intention is to always pass the size, but the implementation also
> supports passing in some number that is smaller than the bitmaps size.
>
> As a reader of the C API, I thought this functionality might be needed.
> If it is not needed, then there is also no need to offer a size parameter
> in the Rust API (since we already have the size).
>
> offset could be an option parameter. As I said, let me see what other
> comments I have, and add the dbitmap client code. Hopefully that
> makes things a bit clearer.
>
> > >
> > > > > +
> > > > > +    /// Finds the next zero bit, searching up to `nbits` bits, w=
ith offset `offset`.
> > > > > +    ///
> > > > > +    /// # Panics
> > > > > +    ///
> > > > > +    /// Panics if `nbits` is too large for this bitmap.
> > > > > +    #[inline]
> > > > > +    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, o=
ffset: usize) -> usize {
> > > > > +        if self.nbits < nbits {
> > > > > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > > > > +        }
> > > > > +        // SAFETY: nbits =3D=3D 0 and out-of-bounds offset is su=
pported, and access is within bounds.
> > > > > +        unsafe { bindings::_find_next_zero_bit(self.as_ptr(), nb=
its, offset) }
> > > > > +    }
> > > > > +}
> > > > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > > > index efbd7be98dab..be06ffc47473 100644
> > > > > --- a/rust/kernel/lib.rs
> > > > > +++ b/rust/kernel/lib.rs
> > > > > @@ -36,6 +36,7 @@
> > > > >  pub use ffi;
> > > > >
> > > > >  pub mod alloc;
> > > > > +pub mod bitmap;
> > > > >  #[cfg(CONFIG_BLOCK)]
> > > > >  pub mod block;
> > > > >  #[doc(hidden)]
> > > > > --
> > > > > 2.49.0.rc0.332.g42c0ae87b1-goog
> > > > >
> > > > >
> > >
> > > Thanks,
> > > Burak


Return-Path: <linux-kernel+bounces-538100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0494A49496
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8B91894EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A3824DFF5;
	Fri, 28 Feb 2025 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38KZo2W+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F31B21AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734219; cv=none; b=ed8gEH9dDdsE+xQiBEXo79O/4tg5Iftm0AE7JXrh44ogdumf/QcF6/R9qwTTpbTU3jnRH6dMHGOZVcRUmkaXlhjDZQHAnCbrgGA+d5J77tKUkZFxxmmaX8t1geJyo/FIRnuGKOmwJtjT2XwRnB7YWoLgRQbig5V6wze4Unxw/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734219; c=relaxed/simple;
	bh=AWlOSmOkjd2pidHdadSFAsCbtYnK0DbZHNntGIE2OyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceknK7E2zPb/wdF5JTwpI5I5QeSgyM2W4LaWcCd/AEsHKYrswGhBS40aF1+hor2p0MGZLPMxAJ/RkUqTHG4b7s3MeQJoVIXJVDHwPIC63w0HpTGLLlcPnocnby6KQFGHT2OZvv9KS7CzpVTP1t54nnIRFInI53jLcYWDtSTViFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38KZo2W+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso19137085e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740734213; x=1741339013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuaVxyDMUNAScl8FlfdpvhJuNw6W7Sdakow95IhLyZA=;
        b=38KZo2W+/0y2m15PF+wT4rIiqhOrJzntE+AXlOLrvLG7XwcCIit2P7zUqi/Gu7SP9u
         LvG7IaqESWN+s1BDC5QEEHyXR4Z6s+aebDdpIcYE0WooLX6yQwufsaxmdhodVRmiGHF0
         8DYeSl2F3rn+Oc+lV2KnOXUQkQniiqLVwHjKcWEVcSjex5NfuH8459reD0RNy+Ev/tki
         BhcdyMEpxW3kDr+yZLbrICfmB3b3lweAnD/xMt3B2X0mZQA96rpVEOfc0A2pO34t9m1P
         vKuNO3Jdj3++fCGj0RLij9i52b2ZlGBWbBft/EtwsRKGhmK7Dd5Lw646GWhEkZEQcdzC
         mLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740734213; x=1741339013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuaVxyDMUNAScl8FlfdpvhJuNw6W7Sdakow95IhLyZA=;
        b=e6Y3l339zB4rIdUI1TjaeCi9tPCTq63FSTXCzI05efoHcw8luaFKhIzrLtKiDgxQtw
         KORPHOD9l6Y1GV5YE4823PAI7X7N7Cyf3S7Z4PEcbbIvYM0UB7yXS8mGBHOwlD4CrCO4
         bXQUX5H6XbZnA5X3QwoDdvGr2QpXaLh6CAI0HVCAGnV0uBPNKMOTsHAY6Ro61kvi4lM2
         x1z8SBt8S1sxZNCnq8sNYTG9bGZrztks4Dgdm3qFr6ApxGcr/J/lToz/ue1gF2md8e5B
         xpGHjR5u7OA++3eSvfCXbwqBFOFF7h+9qoXQXg4hdHQSI9C/5MRZLGyO3/TltV/dWRHe
         tbBA==
X-Forwarded-Encrypted: i=1; AJvYcCWguctuVNNLyqnS5A8Na4xcuZOwxx7RZs9KDIRu49zTeM/kQa4qH9rf4bfUlxisT6a1CmKS9kXSwfnbKws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6X5E17nifaVmTxFywAFFPDAyvKQIFl/BZrjcZGmBZ0wIGssK/
	WFpi1QEkMGjJbORWKRj/rrCtzyfxkPO4MCO1zFtp3ckfg9nLFPkW2NcmT1c3C0BYQZUXg+65v8R
	xba9yWdszpMYmAxv78UzYj09p/0H03BTxaq4T
X-Gm-Gg: ASbGncvXuXaIq/6JEv91EHvZvycIQaL2Cn2H03xVpfBj/wmZUwG6KsBeCm4Nobuj+GG
	5swR+0k1p9mxgZfJeRotnZh504RUt+uTrpwkvcyKiP0SlhZJUk7Wj8hsJQnC5wWYsKzacSuFP9x
	VOFPykfkk5wAj6MwRrhxwvD35L/Nrpbh0snnlT
X-Google-Smtp-Source: AGHT+IHA+7WQ4XrPhFnhvJlLsJWgnrPPtDSkzDTN2TsB342bp0zRvKBL2EVzg8KQlVU/a2qmXVix250GYRtBuKKagWM=
X-Received: by 2002:a05:6000:1ac6:b0:38d:cab2:921a with SMTP id
 ffacd0b85a97d-390ec7c8e9amr2482030f8f.1.1740734213339; Fri, 28 Feb 2025
 01:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227101720.1811578-1-bqe@google.com> <Z8CvLBwKeH2gM-2u@thinkpad>
In-Reply-To: <Z8CvLBwKeH2gM-2u@thinkpad>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 10:16:41 +0100
X-Gm-Features: AQ5f1JqlWufWTIjvxttjREBttJDPgRPCP0Cava6ZfLFBYkDmZ-wg8Bfgy8yDt7Y
Message-ID: <CAH5fLggXT70-V8hddtAobfgYyNOjhSYCsjrHoDWff9FZN5Y5-w@mail.gmail.com>
Subject: Re: [PATCH] rust: add bindings and API for bitmap.h and bitops.h.
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 7:30=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Thu, Feb 27, 2025 at 10:08:41AM +0000, Burak Emir wrote:
> > Adds a bitmap and bitops bindings and bitmap Rust API.
> > These are for porting the approach from commit 15d9da3f818c ("binder:
> > use bitmap for faster descriptor lookup") to Rust. The functionality
> > in dbitmap.h makes use of bitmap and bitops.
> >
> > The Rust bitmap API provides an abstraction to underlying bitmaps
> > and bitops operations. For now, we only include methods that are
> > necessary for reimplementing dbitmap.h. It is straightforward to add
> > more methods later, as needed. We offer a safe API through
> > bounds checks which panic if violated.
> >
> > This series uses the usize type for sizes and indices into the bitmap,
> > because Rust generally always uses that type for indices and lengths
> > and it will be more convenient if the API accepts that type. This means
> > that we need to perform some casts to/from u32 and usize, since the C
> > headers use unsigned int instead of size_t/unsigned long for these
> > numbers in some places.
> >
> > Adds F: entries to MAINTAINERS.
> >
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Burak Emir <bqe@google.com>
> > ---
> > This series adds a Rust abstraction for bitmap, and binding helpers
> > for inline methods of bitmap.h bitops.h.
> >
> > It depends on [1] and [2] which add bitmap helpers, MAINTAINERS entries
> > and an abstraction that is part of the bitmaps Rust API.
> >
> > Question for Yury: What would you like us to do for the MAINTAINERS
> > file? For now I just added the new files as F: entries.
> >
> > [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.=
com/
> > [2] https://lore.kernel.org/all/cover.1740475625.git.viresh.kumar@linar=
o.org/
> >
> >  MAINTAINERS                     |   4 +
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers/bitmap.c           |   8 ++
> >  rust/helpers/bitops.c           |  13 +++
> >  rust/helpers/find.c             |  15 +++
> >  rust/helpers/helpers.c          |   3 +
> >  rust/kernel/bitmap.rs           | 182 ++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |   1 +
> >  8 files changed, 227 insertions(+)
> >  create mode 100644 rust/helpers/bitmap.c
> >  create mode 100644 rust/helpers/bitops.c
> >  create mode 100644 rust/helpers/find.c
> >  create mode 100644 rust/kernel/bitmap.rs
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6d6e55d8593b..359f09e8e2c0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4033,12 +4033,16 @@ BITMAP API BINDINGS [RUST]
> >  M:   Yury Norov <yury.norov@gmail.com>
> >  S:   Maintained
> >  F:   rust/helpers/cpumask.c
> > +F:   rust/helpers/find.c
> > +F:   rust/helpers/bitmap.c
> > +F:   rust/helpers/bitops.c
>
> bitops.c is part of BITOPS API, not the BITMAP one. I think we need a
> new record for it?
>
> >
> >  BITMAP API [RUST]
> >  M:   Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> >  R:   Yury Norov <yury.norov@gmail.com>
> >  S:   Maintained
> >  F:   rust/kernel/cpumask.rs
> > +F:   rust/kernel/bitmap.rs
> >
> >  BITOPS API
> >  M:   Yury Norov <yury.norov@gmail.com>
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
> > index 000000000000..4fa4e4f76110
> > --- /dev/null
> > +++ b/rust/helpers/bitmap.c
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitmap.h>
> > +
> > +void rust_helper_bitmap_copy(unsigned long *dst, const unsigned long *=
src, unsigned int nbits)
> > +{
> > +     bitmap_copy(dst, src, nbits);
> > +}
> > diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> > new file mode 100644
> > index 000000000000..191ef0341fd5
> > --- /dev/null
> > +++ b/rust/helpers/bitops.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitops.h>
> > +
> > +void rust_helper_set_bit(unsigned int nr, volatile unsigned long *addr=
)
> > +{
> > +     set_bit(nr, addr);
> > +}
> > +
> > +void rust_helper_clear_bit(unsigned int nr, volatile unsigned long *ad=
dr)
> > +{
> > +     clear_bit(nr, addr);
> > +}
>
> So you mention that you're rewriting dbitmap, and I took a brief look
> at drivers/android/dbitmap.h.
>
> What I can say is that at least dbitmap_acquire_next_zero_bit() abuses
> the set_bit() API. It should use non-atomic __set_bit(). If you're
> going to re-write it, can you review the existing code and make sure
> you're using the right API in a right way?

Huh, I did not realize the method was atomic. I had assumed it wasn't
from how Binder is using it.

> > diff --git a/rust/helpers/find.c b/rust/helpers/find.c
> > new file mode 100644
> > index 000000000000..3841d3f0330f
> > --- /dev/null
> > +++ b/rust/helpers/find.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/find.h>
> > +
> > +unsigned long rust_helper_find_last_bit(const unsigned long *addr, uns=
igned long size)
> > +{
> > +     return find_last_bit(addr, size);
> > +}
> > +
> > +
> > +unsigned long rust_helper_find_next_zero_bit(const unsigned long *addr=
, unsigned long size,
> > +                              unsigned long offset)
> > +{
> > +     return find_next_zero_bit(addr, size, offset);
> > +}
>
> For those two, the find_*_bit() are the wrappers around _find_*_bit()
> in lib/find_bit.c, with a few exceptions. The reason for having the
> wrappers is an optimization that improves code generation for small
> bitmaps.
>
> In your case, when you wrap a macro, the optimization becomes impossible,
> and the macro is unneeded.
>
> From technical perspective, the underscored _find_*_bit() functions
> should be accessible by rust directly. Can you confirm that? If so,
> maybe just use them and avoid bloating?

That sounds likely.

Alice


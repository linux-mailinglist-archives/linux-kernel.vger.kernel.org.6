Return-Path: <linux-kernel+bounces-544510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD95A4E25C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DBC8844B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAA27932C;
	Tue,  4 Mar 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asPInhEu"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB925FA28
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099826; cv=pass; b=uSrhnLFiZNCGs4oJAgUYrJc5Wcb/PgThWWvhI5Rzu5//FfcmmofcoSe/oAgpIAPwpieQt68BcW6IRcO6oGhkya9Qz/fHE6iOUWjwU5aOqXv+EDVgR6M8bnEzfoSktQAjZAniV7zsR2CdzpwOnWtDrVxyiyf8W5Q/muMIdeR1twY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099826; c=relaxed/simple;
	bh=HdnEfe5V6fpdWb1fUIpP74f1UNnnrJHE/240HBHvte0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU4FIiXCXyVmoVG7nYhqtDMjitXoLYfD47NO4zarmI3dFDIJv7CLaHSVvbEocysd48LMgqPjsExxpQjhFDCYapWsfjZeK17tckfcEbw2KaQYaDONf2qsbFZnIAthgxTyz/UdmxBWpgL0LC1AZU0ruo1EHfbpM2JoMs0/Pnb7puU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asPInhEu; arc=none smtp.client-ip=209.85.128.42; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 7F19D40CEC80
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:50:22 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dpQ0DQGzFxhP
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:48:14 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6DFBA42730; Tue,  4 Mar 2025 17:48:06 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asPInhEu
X-Envelope-From: <linux-kernel+bounces-541751-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asPInhEu
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 3477141F02
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:02:23 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 0AFB33063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:02:23 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF59188B241
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29721147A;
	Mon,  3 Mar 2025 13:02:04 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83252288D2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006920; cv=none; b=aA2Jd+sTOSzvuXgA9BA4yguJHmLzZelN08Isjp3LtkCm1r3QIiZdLyzO0or9cMSEabnb+m4g3X2K3WoM16jFwKQSswTUuYNnCQ+4XTYeSIAct4q7w6Wal9e+9NhNDsyK1ioc4+VGMHc8PLfPbDJihZ8dHVxv0Rw6a7RAcs2yaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006920; c=relaxed/simple;
	bh=HdnEfe5V6fpdWb1fUIpP74f1UNnnrJHE/240HBHvte0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJDt+aVFdRIjKpsRHA9GoC/BivWDK3I41Z+1p0i/liMzQJxGs1M5aKxP3dvJ5B0sepPrK6nfaw4NsJ2+uMHFjFTPc+L07xqjZymMp3i61C6H+z/czAdUqF1CUZpq+HMM+EtPMXUq3x2p0grkoFJacyrHvna623JiLZB29djupyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asPInhEu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bc30adad5so5112675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741006917; x=1741611717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kOjHi3v6WAWn60001RHf4ILCZ1JlrGJikmssONDOQ4=;
        b=asPInhEuvf4jFK1VVDwbnpmf32+b6LjCfNe77TC7TSNaHQzgGXZOSx0ReULhmZNOjO
         tpQUDEv+gVDnnm0+JYHJpYhMu6d+1QsARSykyzWUTw4g9vQHF3zTxnoeRtCkHzgG3UmJ
         d1rOYJfKIo4CysfwNkxaTtJTRlOkI9DOLTS9rtjeW0sjb/UpDQnw7j1w8ytLFGezZbtI
         IqI7y7NtrDrMnz6Cwb8/3fUPFQFZpqMvNq9D8PIAaKdknq2xiQUTGo29BiSvPAmyY1cO
         IRNXfl0PxY+bvXho14yhIJTeB2DOTsrJVVH+lgPDL0rxA+bOnwU1d+CcH9CqI9ejV98z
         h2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741006917; x=1741611717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kOjHi3v6WAWn60001RHf4ILCZ1JlrGJikmssONDOQ4=;
        b=XfFh4wbWD2szBYiBM/XBJrQaYeoY4jN1g5CJRQ8WlgcG0+eC1irk+sJrAEzmr2tBIX
         Lfcoz2PEKUk3EnhroHuUBCj2P5/7vRFF3U331kw0vt+gwiH/yxA3d9ZcxD841xI4Md02
         +W4lgu1rypzxjFQUb8sMCyKB7GARN4dnhuBAuILiCFOaTg57koLozlglKZfj6+CuL78C
         xTee1oCM/QMPohbUkEBlIGEtVApmlIS60nRIih+25l8qy7op2LMs+jJter+vQxW/jPvk
         HH4wboSt59owGl5xNoOiuB6wIo3/ShqBxPgYl7/d4q7NHbc+2jgPjpgDwgzgGmH3gJuH
         +B2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJwsPH3gnGDWgPEh258JbrZ13TOnClQAIjmh6S1/2iz2smvC+xdZLXc0g5pHOJkoRB2KZVL9hxmea8GvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHvA6X9Pm+SMXRmJFoip6D69JH9J6BXqqapzCzX0JsFWTKLTP
	FdOprluv6LXoNiDinxWdJ3m6pQUL6JM1fw2DZxKp7O6EdvNkQmlEFzZzstWW4tPfQ/DskyLGWm6
	ZLJGlgK2mdG3qRqNu6FFtR3R1ho7G2KZ1EaFV
X-Gm-Gg: ASbGncumzhg6xychm5fa48l6VFT4HRD7eFnKYC8JzD6LA7G0rO5CPAORhZNyB3S/znj
	XKYR/Kvc0Qkl7QxFwLpSomqZL7+wZCKeNgeH0IVKVtJb19qzZJJAbG9LJ5MZgp3S2jeP+HQemPT
	T7lf23yzoIjstm1fH3QJWx8Jkd2UoOWiNQPN8d6SJsIPeQfyg7lFnMUk4h
X-Google-Smtp-Source: AGHT+IFF5rgyOnjpuE1IETDDHdPdEmeVkVmiA2FKXzzJZLHbMSUbBYr8y85YibSId3aLy6JEvqWtTaLEUtIRVVROTVc=
X-Received: by 2002:a05:600c:a01:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-43ba66e6c78mr101947425e9.9.1741006916510; Mon, 03 Mar 2025
 05:01:56 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303114037.3259804-2-bqe@google.com> <CAH5fLgjPTvXzcSVDWeYN7nLgxMZgeHUbHiDOv4R=uRBG=50UNQ@mail.gmail.com>
In-Reply-To: <CAH5fLgjPTvXzcSVDWeYN7nLgxMZgeHUbHiDOv4R=uRBG=50UNQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 14:01:44 +0100
X-Gm-Features: AQ5f1JrKmwJHE5JRppZPNxmXXSFGO3YJy1xmDPIaqFBwjsJyB4u89WTHMlrpI90
Message-ID: <CAH5fLgiQkPpMUV0Bvmwd5zUsHy=GHLdoVFjRuAPxpWCbBiD2Jw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add bindings and API for bitmap.h and bitops.h.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dpQ0DQGzFxhP
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704506.16069@9Alcvxev+vBsM4vP1txdDQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025 at 1:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Mon, Mar 3, 2025 at 12:55=E2=80=AFPM Burak Emir <bqe@google.com> wrote=
:
> >
> > Adds a Rust bitmap API and necessary bitmap and bitops bindings.
> > These are for porting the approach from commit 15d9da3f818c ("binder:
> > use bitmap for faster descriptor lookup") to Rust. The functionality
> > in dbitmap.h makes use of bitmap and bitops.
> >
> > The Rust bitmap API provides an abstraction to underlying bitmap
> > and bitops operations. For now, we only include methods that are
> > necessary for reimplementing dbitmap.h. It is straightforward to add
> > more methods later, as needed. We offer a safe API through
> > bounds checks which panic if violated.
> >
> > We introduce bindings for the non-atomic variants __set_bit and
> > __clear_bit, and use the _find_* variants instead of the find_*
> > wrappers. The C optimizations enabled by the wrappers does not carry
> > over to Rust.
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
> > This is v2 of a patch introducing Rust bitmap API [v1]. Thanks
> > for all the helpful comments!
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
> > Question to Yury: we could remove `bitmap_copy` helper and instead do
> > the memcpy in Rust. Should we? If so, should we expose a helper for
> > `bitmap_size` or duplicate the nbits-to-aligned-nlongs logic?
> >
> > [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.=
com/
> > [2] https://lore.kernel.org/all/cover.1740726226.git.viresh.kumar@linar=
o.org/
> > [v1]: https://lore.kernel.org/all/20250227101720.1811578-1-bqe@google.c=
om/
> >
> > Thanks,
> > Burak
> >
> > ---
> >  MAINTAINERS                     |   8 ++
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers/bitmap.c           |   8 ++
> >  rust/helpers/bitops.c           |  13 +++
> >  rust/helpers/helpers.c          |   2 +
> >  rust/kernel/bitmap.rs           | 191 ++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |   1 +
> >  7 files changed, 224 insertions(+)
> >  create mode 100644 rust/helpers/bitmap.c
> >  create mode 100644 rust/helpers/bitops.c
> >  create mode 100644 rust/kernel/bitmap.rs
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6d6e55d8593b..8f42fb1f24c6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4032,12 +4032,15 @@ F:      tools/lib/find_bit.c
> >  BITMAP API BINDINGS [RUST]
> >  M:     Yury Norov <yury.norov@gmail.com>
> >  S:     Maintained
> > +F:     rust/helpers/bitmap.c
> >  F:     rust/helpers/cpumask.c
> >
> >  BITMAP API [RUST]
> >  M:     Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> > +M:     Alice Ryhl <aliceryhl@google.com> (bitmap)
> >  R:     Yury Norov <yury.norov@gmail.com>
> >  S:     Maintained
> > +F:     rust/kernel/bitmap.rs
> >  F:     rust/kernel/cpumask.rs
> >
> >  BITOPS API
> > @@ -4054,6 +4057,11 @@ F:       include/linux/bitops.h
> >  F:     lib/test_bitops.c
> >  F:     tools/*/bitops*
> >
> > +BITOPS API BINDINGS [RUST]
> > +M:     Yury Norov <yury.norov@gmail.com>
> > +S:     Maintained
> > +F:     rust/helpers/bitops.c
> > +
> >  BLINKM RGB LED DRIVER
> >  M:     Jan-Simon Moeller <jansimon.moeller@gmx.de>
> >  S:     Maintained
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
> > +       bitmap_copy(dst, src, nbits);
> > +}
>
> I was about to say that this could just be a memcpy, but ...
>
> > +    /// Copy up to `nbits` bits from this bitmap into another.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `nbits` is too large for this bitmap or destination.
> > +    #[inline]
> > +    pub fn bitmap_copy(&self, dst: &mut Bitmap, nbits: usize) {
> > +        if self.nbits < nbits {
> > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > +        }
> > +        if dst.nbits < nbits {
> > +            panic_not_in_bounds_le("nbits", dst.nbits, nbits);
> > +        }
> > +        // SAFETY: nbits =3D=3D 0 is supported and access to `self` an=
d `dst` is within bounds.
> > +        unsafe { bindings::bitmap_copy(dst.as_mut_ptr(), self.ptr.as_p=
tr(), nbits as u32) };
> > +    }
>
> ... then I realized that we're probably not using it correctly. I
> would expect this to modify the first `nbits` bits in `dst`, leaving
> any remaining bits unmodified. However, if nbits is not divisible by
> BITS_PER_LONG it might modify some bits it shouldn't.
>
> That said, Binder needs this only in the case where the sizes are
> equal. Perhaps we could rename this to `copy_from_bitmap` with this
> signature:
> fn copy_from_bitmap(&mut self, src: Bitmap)

Sorry I meant src: &Bitmap here.

Also, we could rewrite it to just call memcpy rather than go through
bitmap_copy. Though that requires us to have a Rust version of
bitmap_size, which I think it makes sense to avoid using a Rust helper
for.

We could reimplement it by first computing the number of longs and
then computing the number of bytes

const fn bitmap_size(nbits: usize) -> usize {
    nbits.div_ceil(c_ulong::BITS) * size_of::<c_ulong>()
}

Thoughts?

Alice



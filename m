Return-Path: <linux-kernel+bounces-272542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803B945DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5AF1C2150E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5615C1E213C;
	Fri,  2 Aug 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAwqWgBp"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095314A4C8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600531; cv=none; b=TYKRRdwgjfxctdafewi5iGoxdaBcvJ7/LTVKJhs7EtOtfI6KkFbqQfSzsYxyJdCd0V+TEwL6S5UTszpqd6f90EROSNnbFvPVN2lUkX5oe66DTjgLDgkWvw91NTlUXMOyJ+N4bosAD1tedXOaRVvkiESCaTu5s1AL8r7EC/6Sz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600531; c=relaxed/simple;
	bh=FZDHvw2J+46rSZntfdK8zkNwzq7yg5cnEfVjQViUJ2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLjO6QEyxuyIEUqMGsXFbHdzCalwGz0yj67951z0iDochsc9r6tM8a59wnBYmKCR4UzK4FO7jLHJlMZOEGF6XjdjiPIYhppx8tqF2qCP9G9nYFyK2MfGsl9c49DqWlq+Pl9F7QavU64wRni5xKUjWB5FwJkqIYqTDco6yDuj0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAwqWgBp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso4520007f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722600528; x=1723205328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHyWZQCwAzQknHNs/4u2WfWGKffvhQCus1d6fv0WvYY=;
        b=kAwqWgBpeWb5wnnc80C72jAJ2lLmWzJ1VZG73j1G18hBYFazOy//MMBEK7tK+8KI41
         kiY8FuyCqXZ82zRj/jdpyZzd2Nu1BvOSuuoDaMRef84NLnCeUqlNssbqcjcs2FRkvk7E
         lkGpEGxdvGC3kBw2hkFJDKbJJ/TjWX6GPuI9keedchTCWhQwCXzQD4guCcZEspH/vJaH
         n4aEGwYxbTIXc+xRvpZmv8OwnneErAkCs9GzdS2/3hsI6c6jczW6LKg3vL86x8vYgN0P
         yW7e0fm7VK11vvIaChNAFgmxnwfOK+nkGjHc8xTOCtKSTEoO1mhZ77iTpLGwrzUQ/TjA
         lKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722600528; x=1723205328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHyWZQCwAzQknHNs/4u2WfWGKffvhQCus1d6fv0WvYY=;
        b=CZYeD6XDbmHw7uhCNOwxXLbmd5H2ttSRBcWgbeA17pecM+ki9F3TbdRrhheNy6yxgS
         UytW5bNiojv0HYM+JcwJud4xZJ5DXL+zhFyvnjzy+CefzWzcJtrxW+LPSADNMo3eRUAW
         LzBOFcuuR88g8NUrPZD1pD4EnELljXnu8/PLiFPm33xsXJyiBJ4+Hw7owWN/orFhq5rg
         Q1ymAzNvJKgAtMC2tL+GNC3Zt8/o2vxz2PHjG+fOwjYSxCzyQE05Ob0xRhju0XS36wTZ
         T8hGAcCsgeIO+Ku18HbNB9217pB+Bm3JHPzwl8ZMwZr2zkQd2SbI/vdIa2qQ+lEHzcxX
         m8HA==
X-Forwarded-Encrypted: i=1; AJvYcCVPq7XH5HqkvERv/pr4jlBJgCiVP0AupYvdDgYzZEWhewM9zsP3f2aGlSdHl4zJUW27ltZ8hdp12Ss4Dp0RNUoahI5iJ7FnDC8RSGml
X-Gm-Message-State: AOJu0YxmjRq4PlVaxv/TvYqI5fJ60bPa/BeFCUIaFwhksXWp9CCkJa1M
	OTYqw+8Hu72s78rXuHHwzSq5cEFdefoi2kCmGLlaw3TMF0TOtvaYlN36gAJSwCH4O1RF9EXbe7N
	PiTyAXmipgq0WvpEjYtCQLw84irJMh8716l/1
X-Google-Smtp-Source: AGHT+IHUQIoAKU0b17lBQJOOrWix0tX/MFcyLMaAq9Rx+fL6Bj9Um408fLlcoHVSjOpbBU3D1Ra+KK0Y8i6i96gatpw=
X-Received: by 2002:a5d:634d:0:b0:368:5a86:c1b7 with SMTP id
 ffacd0b85a97d-36bbc1c22cbmr1971836f8f.55.1722600527742; Fri, 02 Aug 2024
 05:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-18-dakr@kernel.org>
 <CAH5fLghO8v0wn-uCx1u_zojPLdDH_RMn4BXxLB1ZMJjfpTkbAw@mail.gmail.com>
 <ZqurvdyDD6bH4H7Y@pollux> <CAH5fLgga9TOtZBcJNJBgzRGSrX5JuvdbSrvdYV3w8b7gOAncPA@mail.gmail.com>
 <ZqzK2LeUgX1AQP4E@pollux>
In-Reply-To: <ZqzK2LeUgX1AQP4E@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 2 Aug 2024 14:08:34 +0200
Message-ID: <CAH5fLgiPyEs+zMCmTSQjhBuG8T4SU1j8LWKGBucz_--X-MxY=A@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] rust: alloc: implement `collect` for `IntoIter`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:02=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Fri, Aug 02, 2024 at 09:08:48AM +0200, Alice Ryhl wrote:
> > On Thu, Aug 1, 2024 at 5:37=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> > >
> > > On Thu, Aug 01, 2024 at 05:10:22PM +0200, Alice Ryhl wrote:
> > > > On Thu, Aug 1, 2024 at 2:08=E2=80=AFAM Danilo Krummrich <dakr@kerne=
l.org> wrote:
> > > > >
> > > > > Currently, we can't implement `FromIterator`. There are a couple =
of
> > > > > issues with this trait in the kernel, namely:
> > > > >
> > > > >   - Rust's specialization feature is unstable. This prevents us t=
o
> > > > >     optimze for the special case where `I::IntoIter` equals `Vec`=
's
> > > > >     `IntoIter` type.
> > > > >   - We also can't use `I::IntoIter`'s type ID either to work arou=
nd this,
> > > > >     since `FromIterator` doesn't require this type to be `'static=
`.
> > > > >   - `FromIterator::from_iter` does return `Self` instead of
> > > > >     `Result<Self, AllocError>`, hence we can't properly handle al=
location
> > > > >     failures.
> > > > >   - Neither `Iterator::collect` nor `FromIterator::from_iter` can=
 handle
> > > > >     additional allocation flags.
> > > > >
> > > > > Instead, provide `IntoIter::collect`, such that we can at least c=
onvert
> > > > > `IntoIter` into a `Vec` again.
> > > > >
> > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > >
> > > > I'm not convinced a collect implementation specific to IntoIter is =
necessary?
> > >
> > > For the reasons above, we can't implement `FromIterator`. At some poi=
nt we may
> > > want to implement our own kernel `FromIterator` trait, but that's out=
 of scope
> > > for this series.
> > >
> > > For now, I just want to provide a way to get a `Vec` from `IntoIter` =
again,
> > > which without `Vec::collect` would be impossible.
> >
> > If you have a need for a collect on this particular kind of iterator, t=
hen okay.
>
> Even once we have our own `FromIterator` trait, we probably want to keep =
this
> specific one besides the generic `collect` for optimization. With the gen=
eric
> one we'd otherwise copy into a new `Vec`.
>
> >
> > > > > +
> > > > > +        // SAFETY: `buf` points to the start of the backing buff=
er and `len` is guaranteed to be
> > > > > +        // smaller than `cap`. Depending on `alloc` this operati=
on may shrink the buffer or leaves
> > > > > +        // it as it is.
> > > > > +        ptr =3D match unsafe { A::realloc(Some(buf.cast()), layo=
ut, flags) } {
> > > >
> > > > Why would you shrink it? You can just keep the capacity.
> > >
> > > What if the vector was pretty huge and meanwhile as advanced by a lot=
? I think
> > > we don't want to waste those resources.
> > >
> > > Ideally the corresponding `Allocator` implements a proper heuristic f=
or when to
> > > actually shrink. For instance, krealloc() never shrinks, and it's pro=
bably not
> > > worth it. For vrealloc() though we clearly want to shrink properly (i=
.e. unmap
> > > and free spare pages) at some point.
> >
> > The Rust Vec never shrinks unless explicitly requested. But I guess
> > it's okay either way.
>
> It actually does, see [1]. But Rust's `Vec` does it less efficiently. It =
either
> keeps the `Vec` as it is, or creates a whole new one.
>
> [1] https://github.com/rust-lang/rust/blob/master/library/alloc/src/vec/s=
pec_from_iter.rs#L39

Huh, surprising.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice


Return-Path: <linux-kernel+bounces-564034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B091EA64C77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E1D7A8D58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB452236A84;
	Mon, 17 Mar 2025 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq9/G0IT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950321A436;
	Mon, 17 Mar 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210755; cv=none; b=uw9r3MINIvaBHY5tKnd7wg/KBrXaS7oi+121GEkHXy4qgp1eTFYqHvFgY7KvZ/ZguV/y7yi6qDKoSXs2o1utmKk9xyMTYoWy8gHoiojkpi0co9PWiOJz+VJi219Cl4TaKkq1xKg2R5DKQzfk3G8Us5t058zvqARroHkkZkAKMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210755; c=relaxed/simple;
	bh=OKvjeJyJvWjei5Lx8kyInoO2tpbLHQyAzfWTBMn0ats=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOehoD/uqTrvEEcZev9iF4dARsSAoid4R6+6L1AlLLh5s93dJT+4bi8GJnNm0mLdEEx78Kk4HUEhXSyaNMwMYGYhfMyzJzZjBrS6Rj4rqbDpLCO9T0A2xwmO9dxgys+A+EXSSWYfy4wD8GsRecGz3Lvgfslde8igQG7SSuVr1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq9/G0IT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307c13298eeso49283021fa.0;
        Mon, 17 Mar 2025 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742210751; x=1742815551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWta60ng0TvgBC7h/J0dQc/t2j6Ji1+ASVBtYflqGeQ=;
        b=Xq9/G0ITEwC8ux6a91TvHAw4q+Zp4qFQIzES5yGV+knBblTUrCCpI0etpDE3TmYXXv
         f5umlQZGJTqN3sZC1p2dueZtYvyQQHO0rr4KgbeVd+YIbOTVVcN9+Kf6O++YJzONaQJl
         1Vd3VplPZLFe3ZrhsRVk6a5j8uwXLQk/453iF8mecdpjVPxJexldXhGDYG/OUj9Hp9Q7
         pXeZMEvdwdgR0wi1vMW6aY7j+g+6sc6hwWfZzIHUR3H6ke9L9Zq2ukCZcg5NKQ2pZiqM
         ecMSAyQ2vxI+puIIuqsPzFpHT7H0dHHcHxi8d0+uk36ybB4P5wRTMWZKZ11J2X+4EbrI
         49CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210751; x=1742815551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWta60ng0TvgBC7h/J0dQc/t2j6Ji1+ASVBtYflqGeQ=;
        b=fPdQwYNKrlfBNmBfSwbxJBevf7B+y7ILFlF7wHb7d+kQWthtk63sG+CWH0Y5KBMGjS
         CB7qPmXUU2Gvc2EE0Xd9CVXuBih6IK//VYHsS2CZulx7M83Vjvmy0Kn65jWUY4G0EafE
         2vKyryw+hLvVGMe+2pXOfj+WZwKuCCC9Ik7d5sH/Ti9FwSDkpw1+SPMHJpdU1f79sA2j
         2Y9I6+NUR5BHHixhWqrGaTq0yOViq8H3tV+XRIQ4sqvzasUH3Jwzw9J6xuVpAoGRoBZw
         HgKzRFk7tNPmjDVWAESQfNtn0/vF79fZq0Vg6ofZ5oMSOqq1uXjK/BIluvmCmgZGC+Er
         JKEg==
X-Forwarded-Encrypted: i=1; AJvYcCVH2pQunUh6qgTpUq4a3x9UXhYGpjH2KbQZ10wqKKC0HDnLW0KeJsryzTHrZTCsQIYYbmh8YbWkS6nw/7R7AT0=@vger.kernel.org, AJvYcCVtDuvQeurGXMhP5UXaYXhW/ww47vozEeXScNN9otDtPUZYsaIps8stlg/f3UeICbIhnRA6uwB7LW8NTqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2bPdAPGalDM2BuDpOlmvPU0LHrNPn6pwoLFVPCI7M1bsvwcs
	7GUWSFZx1ZtzyNhl/ffqJBWU6hAK96rzse1f5Xf4UQnOtoFcY26vLA9ut41qS7zAP8yzqC3vInM
	G6BJVGG+89Q9QHuLLFmhKCtWsXso=
X-Gm-Gg: ASbGnctSQBdjPoejm/GA5gWumuXcVz3DiWoRKxYPqomOlKYsrYeEgoqnekwc1ApdBhU
	eO0rMK4jGsBsNXh6a4hYMePbXQTd60mzc6GNaxz5MUDAUd/B2op9y0hwVHQqArKnO5ES7AA7cSb
	qmC6wATUmW+cGxumsm7kRVlXmnv1LAF4g0rvrDAhtwI51Qb+Nr5Py7n5P5kfpn
X-Google-Smtp-Source: AGHT+IEA0sIFmnANZqQBYncljjZZzM26z/T/h//PgkNfGAvQs7f6FBzYEvQ7x2h1OqaXsGFfoEJn/9YP/T/RFTFb/AY=
X-Received: by 2002:a2e:a9a0:0:b0:30b:c328:3cdc with SMTP id
 38308e7fff4ca-30c4aa76f67mr59139191fa.2.1742210751086; Mon, 17 Mar 2025
 04:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com> <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me>
 <Z9f96iXE0xxj8th7@google.com>
In-Reply-To: <Z9f96iXE0xxj8th7@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 07:25:14 -0400
X-Gm-Features: AQ5f1JqpBd691q_PMNx5e47r5ZuTTo76mP-5VtpgEAkOg6UwZRK_FQpIgmpgQUY
Message-ID: <CAJ-ks9nSNweaSCVAruo-zWxMAFKcRxcJRScV06NRNBoeEZggfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:48=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 09:58:35AM +0000, Benno Lossin wrote:
> > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > Rename `set_len` to `inc_len` and simplify its safety contract.
> > > ---
> > >  rust/kernel/alloc/kvec.rs | 19 +++++++++----------
> > >  rust/kernel/str.rs        |  2 +-
> > >  rust/kernel/uaccess.rs    |  2 +-
> > >  3 files changed, 11 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > > index ae9d072741ce..d43a1d609434 100644
> > > --- a/rust/kernel/alloc/kvec.rs
> > > +++ b/rust/kernel/alloc/kvec.rs
> > > @@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
> > >          self.len
> > >      }
> > >
> > > -    /// Forcefully sets `self.len` to `new_len`.
> > > +    /// Increments `self.len` by `additional`.
> >
> > I would keep the "Forcefully".

Why? Is it possible to set it any other way?

> >
> > >      ///
> > >      /// # Safety
> > >      ///
> > > -    /// - `new_len` must be less than or equal to [`Self::capacity`]=
.
> > > -    /// - If `new_len` is greater than `self.len`, all elements with=
in the interval
> > > -    ///   [`self.len`,`new_len`) must be initialized.
> > > +    /// - `self.len + additional` must be less than or equal to [`Se=
lf::capacity`].
> > > +    /// - All elements within the interval [`self.len`,`self.len + a=
dditional`) must be initialized.
> > >      #[inline]
> > > -    pub unsafe fn set_len(&mut self, new_len: usize) {
> > > -        debug_assert!(new_len <=3D self.capacity());
> > > -        self.len =3D new_len;
> > > +    pub unsafe fn inc_len(&mut self, additional: usize) {
> > > +        debug_assert!(self.len() + additional <=3D self.capacity());
> >
> > What if this overflows? Do we always have overflow debugging on when
> > debug assertions are enabled? If yes, then this is fine.
>
> I don't think we do.

Rearranged as

        debug_assert!(additional <=3D self.capacity() - self.len());

It should be impossible for this to underflow because capacity must be
>=3D len. Interestingly this isn't a documented invariant, but it is
relied upon by `spare_capacity_mut`.

> > > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > > index 28e2201604d6..005713839e9e 100644
> > > --- a/rust/kernel/str.rs
> > > +++ b/rust/kernel/str.rs
> > > @@ -840,7 +840,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> =
Result<Self, Error> {
> > >
> > >          // SAFETY: The number of bytes that can be written to `f` is=
 bounded by `size`, which is
> > >          // `buf`'s capacity. The contents of the buffer have been in=
itialised by writes to `f`.
> > > -        unsafe { buf.set_len(f.bytes_written()) };
> > > +        unsafe { buf.inc_len(f.bytes_written()) };
> >
> > This change seems wrong unless the code was wrong to begin with.
> >
> > Otherwise the change looks good.
>
> The buffer has length zero as it was just created with:
>
> let mut buf =3D KVec::with_capacity(size, GFP_KERNEL)?;

Indeed. Added to the commit message.


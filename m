Return-Path: <linux-kernel+bounces-564431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F49A654DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1773E1740B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240F24501E;
	Mon, 17 Mar 2025 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEwLoYyw"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65B21CA00;
	Mon, 17 Mar 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223713; cv=none; b=Mx1aYd2BKOIz9yCSqKnGS65reoiF65gtJHpZB0X/hLLX/lRPv7S65s7EVuKnOC3b9b0a1NNSF+M9Lm6WUuTgT977mqe/8qS0pBGadsWunREABXJQPUP7zHYdnI6Cf+4DivZEwztrfn0AioIaq87c4DUIzta9W/MMdCyJAcjx6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223713; c=relaxed/simple;
	bh=AXvpLJySHjaHvdANor6EkTnAJ5c5+oboD1FFbk+/gHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGn5GqH6c+SBy1gJf39dX5n1dWqOBXXqdEuP4aERPDukoaTMJ9ZrKWQqWpmavMrinjjcW9qFJ6dAdGgpUB4eQORixX+BgWSHOM4tw1xQxoEBENBOg1GQxEC7Mx1lLOXDnZ4RnEnmJoS9jzWNcBDMmvieFK/3xOYUzQ6x/o7r2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEwLoYyw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307325f2436so43938331fa.0;
        Mon, 17 Mar 2025 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742223710; x=1742828510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJvqbnL+npba7SK7psnculfpvebLxNT5k6QcJE5ycFg=;
        b=KEwLoYywl4nU2L5q9EPn0rDIeUnKpm5GXog+q61EX8fsMKv2N0t3WcM2fTKnwj18/G
         MOun2UVv/soFvz6a8RPP7bOWJ8sZLKZZPbgRcK/vlrtoEla8U7xexZL5i1wfwcriSWR4
         mEF4gp7SSb2Jmb7zX2blYnPj8DyvCg5CfOpLiiA4J+E30310ZWabEqqiRhgNlv3zZtH7
         E3CqpN9fb1PJ832OEKFvfWWFXOaOdVR42PAN2VCgSx+2Yd3j1ykHMKNa8/MY1uPMgSWI
         Z6dG3+XoKfbPljSfUEO+QuDW5eNERA0tnPn49qgt93UzLU7WA70lK/I+CTy1One8ym7U
         OzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223710; x=1742828510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJvqbnL+npba7SK7psnculfpvebLxNT5k6QcJE5ycFg=;
        b=e9xmAp+cVG+5qIP24mXJhaHFTDMEHACNa+ucLnsOfRfprzsWGlwyMgUfT4r7pMJtFG
         dKe//P19on8jUI1Bj0WyJFpGI+iV60r4qYSNEl7ZdqtXQGqk7CaEm00mN+Tcgp3YDh6z
         czp/wiNrSJkWibfsColS6JcVqkTI++b6stq/PNnWchOF6FFKcDwgJvj8qkgGQBjJA//Q
         QuzcDgow9SAxN7nmalsZcrNl51HgBcWVks1q8vB4E3k0zwtSPSPEOJWqgms92Mwea02C
         IwSPeiadi/J3q2Y3jdmeNJpAy0D7EgUAvwRcVpZkL2lIydIhxuUNPdkMmkVLR8LVlLJb
         MiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFi5ubL8KK5GPz7aSsEe+uoRjkgMfMEkQX2wsLVIAuWmbRuiBIPALdUY8BLIKna0yNgLaMh2p2MdtQOUA=@vger.kernel.org, AJvYcCW/cR9zgb3A8aRsRuaxXJkesQyCxA7mwBSR4WN6J0mwXXbKd04CIV4arlNspj6CTYc982u17/m/rFKLBBJQ2bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yfm07+Rryks73KHgENCuQMoLtuMzCQNUCbTXwN3pfWP3yBRd
	0n6XIJ8uMPSw8cHh+RpJMkkDj6bP/KUfO89i5uZfBUZcYc72htu759N+Rn+kyuv6jIC8bBI6CuQ
	DCWFq63wg/a9+9PFl2Q2f2UlLPJM=
X-Gm-Gg: ASbGncsTFKDWs6dIxsUZ+UMNE2OzwsnzO2Z0ec+cj2MV+ZPLe3sR8VPFprmnrRuvYFM
	lultY2pX023sIN+dDSddyC982/bOGkDHgjbuDxOLVEXP08IX7rM05D5ekOOYn2EHS57BM7dxewx
	ZPVUdvFROLvNEcNaEveNjq1bemYna1o83Gwbkvr9zxOVQtkAjWszboDLiMJzEZr1Ms9GW4dew=
X-Google-Smtp-Source: AGHT+IFLvB5OzRY2SiI8TQjduv951UepkV/JLmcJquaO3zoZm8qsXg23DceyMqehQehLW+f+qqfFavH5FBN4f/Z9qsU=
X-Received: by 2002:a2e:a454:0:b0:308:fbd5:9d2d with SMTP id
 38308e7fff4ca-30c4a8f5001mr69537651fa.37.1742223709593; Mon, 17 Mar 2025
 08:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com> <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me>
 <Z9f96iXE0xxj8th7@google.com> <CAJ-ks9nSNweaSCVAruo-zWxMAFKcRxcJRScV06NRNBoeEZggfA@mail.gmail.com>
 <D8IMFM8UTOV6.1EYIRMPNAZ7I7@proton.me>
In-Reply-To: <D8IMFM8UTOV6.1EYIRMPNAZ7I7@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 11:01:13 -0400
X-Gm-Features: AQ5f1JqVexNDGpOiULXDl9HtnjUk71EV4WDHDOCyZCEg9YBAWM9wDUrg6mE1BUA
Message-ID: <CAJ-ks9nHdPP+uO7fhedVYBKvifGgEMLcedoqUgNEcUDgfrenVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:46=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Mon Mar 17, 2025 at 12:25 PM CET, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 6:48=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >>
> >> On Mon, Mar 17, 2025 at 09:58:35AM +0000, Benno Lossin wrote:
> >> > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> >> > > Rename `set_len` to `inc_len` and simplify its safety contract.
> >> > > ---
> >> > >  rust/kernel/alloc/kvec.rs | 19 +++++++++----------
> >> > >  rust/kernel/str.rs        |  2 +-
> >> > >  rust/kernel/uaccess.rs    |  2 +-
> >> > >  3 files changed, 11 insertions(+), 12 deletions(-)
> >> > >
> >> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> >> > > index ae9d072741ce..d43a1d609434 100644
> >> > > --- a/rust/kernel/alloc/kvec.rs
> >> > > +++ b/rust/kernel/alloc/kvec.rs
> >> > > @@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
> >> > >          self.len
> >> > >      }
> >> > >
> >> > > -    /// Forcefully sets `self.len` to `new_len`.
> >> > > +    /// Increments `self.len` by `additional`.
> >> >
> >> > I would keep the "Forcefully".
> >
> > Why? Is it possible to set it any other way?
>
> Yeah when `truncate` and `resize` land. It conveys that this is a
> low-level operation.

It's also an unsafe function whose safety section mentions that the
memory must already be initialized. I don't think this word adds any
value.

>
> >> > >      ///
> >> > >      /// # Safety
> >> > >      ///
> >> > > -    /// - `new_len` must be less than or equal to [`Self::capacit=
y`].
> >> > > -    /// - If `new_len` is greater than `self.len`, all elements w=
ithin the interval
> >> > > -    ///   [`self.len`,`new_len`) must be initialized.
> >> > > +    /// - `self.len + additional` must be less than or equal to [=
`Self::capacity`].
> >> > > +    /// - All elements within the interval [`self.len`,`self.len =
+ additional`) must be initialized.
> >> > >      #[inline]
> >> > > -    pub unsafe fn set_len(&mut self, new_len: usize) {
> >> > > -        debug_assert!(new_len <=3D self.capacity());
> >> > > -        self.len =3D new_len;
> >> > > +    pub unsafe fn inc_len(&mut self, additional: usize) {
> >> > > +        debug_assert!(self.len() + additional <=3D self.capacity(=
));
> >> >
> >> > What if this overflows? Do we always have overflow debugging on when
> >> > debug assertions are enabled? If yes, then this is fine.
> >>
> >> I don't think we do.
> >
> > Rearranged as
> >
> >         debug_assert!(additional <=3D self.capacity() - self.len());
>
> LGTM
>
> > It should be impossible for this to underflow because capacity must be
> >>=3D len. Interestingly this isn't a documented invariant, but it is
> > relied upon by `spare_capacity_mut`.
>
> Oh yeah that should be an invariant. Feel free to open an issue or send
> a patch.

Will prepend a patch in this series.


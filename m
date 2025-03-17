Return-Path: <linux-kernel+bounces-564387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A69A653F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311783A509A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE9624501F;
	Mon, 17 Mar 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlad7igY"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1562441A7;
	Mon, 17 Mar 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222385; cv=none; b=rLt9NA5JW6iHIG49V3tDzicaNFEi9GvLF/jXeXZrp12M4/jjQ2ndklA02zuLZS2RFaX6/ARYlBFNefJMMRgq6V2xTsMgeoaLNG0TDsk2wJuhjlAf1h62zEhtB/Weh4l2GXUroxN42TkjdsZhlbOIQSzqJKNXl3LpTNnQuOJP2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222385; c=relaxed/simple;
	bh=jpRejpT5HWaatfO72y6aMmmK2j+bOCOP6s7bDhC0TVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqAPqAgnGFQU5yxLKVgQS61dlLRX5ka6mQ9WRJcXTkgI9lkxll5HDACEDsznh+wFwZRiqL1IJqzT2t4bn1r/ODOKFmgMiY77WdN45N1WY9D7rFNY54A2jd7mftyLCQASBgFpdOaGi3HPztz2CNQ7PU5jMCSNCZNwuonPA6iVKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlad7igY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307c13298eeso51854631fa.0;
        Mon, 17 Mar 2025 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222382; x=1742827182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZZTDYJnWzodGEAZZ7zFDaFFv2pV5qvHdRMtYkMak7s=;
        b=Nlad7igY2KaF55PlgJQF2SHGY1/+Qz1sMFc2q604EgA8SYPFmHt0b6mHrXF0LHNXRy
         KND4QNGIvwkCMwVMqHSyeeMmgAabpC7o13KFirjsnXO1rYXLrymbjOYXx16LNYScepf0
         3S6gOoqAzCT80Kw/SYAx7sJ/qITsPfGTEu9Rx/qb2Gb7ADxuVUsdzcV+OIRnQTgqkHRj
         DXGyjIXGT6uw4Qv1iM9KmObX71tOGq6v+lhK1cTvtyuMun3LnZ2hy7hwZM+JpdQNOnH/
         GXs2+z08NSTAzxKLmOEamQoMob3pbDiH9dAT8kXpb5tko3MPCrTFfdc+aubzH4CAv2He
         aY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222382; x=1742827182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZZTDYJnWzodGEAZZ7zFDaFFv2pV5qvHdRMtYkMak7s=;
        b=ITlt4rKZotzgP6QhisWZ70feEYNbz1IP1EJ2IanXEwNdISLuGOLlWnc1JfGDfvsXbS
         VmvaQ38MHHl95EnNpfVIO5eOkTAKDgPLgWdKhygnyRQIDt1yysvoRiTOKKAU8YznbnzB
         sYptEi9iGkFcFwS578aBmhlATHbLWVrbkKdxEqK7bZcL9J2aRFdw3+Xy6kyMd1cI9l0X
         RwBlZeoPuHTbcT7pJ/1qpRBkkCQIFsHZ8kg3rbxk01gBjYtS8CJsN7gev12ESJuv6E3a
         CiHAQdi2Yq6UmDz3D2pRZFkJf5z1xkCjXJK5BwP8m/V0BEeXYZw5ixIhdtNFLK4rhqc/
         cdgg==
X-Forwarded-Encrypted: i=1; AJvYcCWIVRn6ccx4yyT82POYeHaua4ng90Ps8CmGX8qqAYwwki61zgwXqj0FQNf0UEkbQ1+xax827pnt9Y4KFSgtGRM=@vger.kernel.org, AJvYcCWUZdpMcHI+DBFXmBVrLQW78CN5WSjx37jvWYkp5vuMA05w/k9owUmJXH9Yx04DhTCvoqI5ZuyY1dpn1HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/x6qP+VaeHROEmLi37hC0iz2CwqtmRNWYyYVqSDK8XmsX7wNL
	zNE9gve6x0NBRA0QCPpt+F5AYGnfxgD/j1L1hFgCKtFPhlrIu9Zfzlj6is8i59E5Z4eAQ/wYj/Z
	YKdMPDB/e6+l3EZZqN2E2Fb2M96s=
X-Gm-Gg: ASbGncuqODEBCiPAfb3niAxHod84eFrWW61z3MMDX0h3v/L8oB4uK0axoCxVBt25tTx
	wO/F5ED6H2+gdarV2pUBt3siaZAdCdvXHJG53gXOH/lTkN5XJ//UGrAJTI9aab/5A921rBR4ygk
	zvJdoBN14p1ccXx0lFkme7Tb1gPoFeJFKuq8nLiFlZ80plqHZIkSFeNoO0Yc0N
X-Google-Smtp-Source: AGHT+IGN49ryQeOA4dTk7/oHqn8S1VLc8bEyt2Bbl2KQl13M0wE0Ni/NceUr+ZlyvimC7XAU41P+nsIvvJTTgjY3ius=
X-Received: by 2002:a05:651c:50b:b0:30b:a4f6:bb3f with SMTP id
 38308e7fff4ca-30c4ab12662mr65665901fa.16.1742222381532; Mon, 17 Mar 2025
 07:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com> <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me>
In-Reply-To: <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:39:05 -0400
X-Gm-Features: AQ5f1JoFhidwD_tOTzOryJsJaMynkWFJr4g5abu-m-PjOLDh4UZ7JyAmfnK_Ub4
Message-ID: <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:34=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Mon Mar 17, 2025 at 12:42 PM CET, Tamir Duberstein wrote:
> > Use `spare_capacity_mut` in the implementation of `push` to reduce the
> > use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
> > alloc: implement kernel `Vec` type").
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index ae9d072741ce..d2bc3d02179e 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [Mayb=
eUninit<T>] {
> >      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocErro=
r> {
> >          self.reserve(1, flags)?;
> >
> > -        // SAFETY:
> > -        // - `self.len` is smaller than `self.capacity` and hence, the=
 resulting pointer is
> > -        //   guaranteed to be part of the same allocated object.
> > -        // - `self.len` can not overflow `isize`.
> > -        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) };
> > -
> > -        // SAFETY:
> > -        // - `ptr` is properly aligned and valid for writes.
> > -        unsafe { core::ptr::write(ptr, v) };
> > +        // The call to `reserve` was successful so the spare capacity =
is at least 1.
> > +        self.spare_capacity_mut()[0].write(v);
>
> I think the code uses unsafe to avoid a bounds check, but I'm not 100%
> sure. Danilo might remember more info.

We could use `slice::get_unchecked_mut` here to retain the same
guarantee of no bounds check. That would still be one fewer unsafe
blocks.


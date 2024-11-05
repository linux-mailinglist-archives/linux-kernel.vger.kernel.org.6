Return-Path: <linux-kernel+bounces-396329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1E9BCBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ADE1F245B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649651C231D;
	Tue,  5 Nov 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVhVjUSK"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090611D1E75;
	Tue,  5 Nov 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805910; cv=none; b=YoNNce3jsplYGEdWi70E1matTXdSu+hMpJQMSQWIaG2E9TK4oV2ENzN4fK9SwOMIjT1Euvoy4qevXz/yXa1zG2eruYhJpOAw21dsYRQe9gssUWyuiNcmLKLNYRBiFjlOIzywhKS2Cohsh+CT/6VNvD7CmycJTaFTivbUGO9RUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805910; c=relaxed/simple;
	bh=Z9Hoi3/pS+fdpoPqlVPXH0IroVleNH2MWlsY2E+JQYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9NJHAVVLc0DGDRy3JB2ntk2goIyX6GeqhL3UPz5czlnr8qnBDMitTTvpo7i/bg7bXWm64FICNNbaWPgEpOw8Otah/4EVoe+uNj4iiWl1SgR89WMbAe0dYtfM1aBEgqKBncUnpeQ5nxQ13NM7GzWvjuZM4tnD0bnnv7D/m8nV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVhVjUSK; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb443746b8so46567891fa.0;
        Tue, 05 Nov 2024 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805907; x=1731410707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1EDWbkXrAT1r8+WJE2J8WjLP3sxPTbNb1cos2b4N0M=;
        b=GVhVjUSKgCDFDzn/JCVmhSOPcUFp96aAx1iAH1cLXgOw2MBGCYiD9b06X57xXSQOkm
         DhXMpN7iQ4+Pwygp/AI9FeyJPwECbaX00ThEGHzJU1Q+pXltm3k94sLG8ZayFwvFkn9l
         Efqo0yaeR0ZVa/79Ed+hOL8r2c7DOddhB/xUKW9cODOaZcqRdzSMzaqHrCOHsVQK3Gko
         aAzKKJfFAFfJGCuwOwlBA4ncFN01lcsJMBSAWV+9U93NQnyDSzlknj3/pRp7T0jeQkdA
         vKLoK+7Rm/dVZd3wvHHkGfDtWop1iNSqf3SRqjcOLyGF8cRgMNnfymk3Aeba/IPye6dc
         oFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805907; x=1731410707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1EDWbkXrAT1r8+WJE2J8WjLP3sxPTbNb1cos2b4N0M=;
        b=FDQswBbAj6jyuQBM5WPe/o7pydqhDtis4O6hW+tVE3K8qNXTLHsmBhzRVNNYM1LR+B
         7Sa481tZI2UJ7vGg8uQQw/nMF0c3DhDaJFXuz+hGf4NTpyjS0/3wOOBWTa52Ds9nC/1L
         dJZAAH5Tcy2EEO/75IQh0/JdhQOxV4oXLhFe15d6G4XEQ50UV97kyZBT//UaPn+EzPIr
         esVlp6sJp7+PGbJaZQmg1A6R0v2ZpNWD791mNJ+pgjOBzDb8b286Q4D8DzfTfNVtKC6c
         jk9Wf4WaY2Fa2eujv2fcXws99zBtagpIy2RvSGi4Xh5wQ7LpQ8nsbsHSnbOoJBorxTVt
         Sbtg==
X-Forwarded-Encrypted: i=1; AJvYcCUFgkMcUd0e8x/tz0Zexdr6jCcqfEmnVZM173nmS4+oMgfbFgTaadlCZ/laOwJkrFf95a76c1AQ8R5rexN0pd4=@vger.kernel.org, AJvYcCUjzF0ehMx4UcJpsQr5thod/ZdzvgozwizTEbA8FAY+drmBNc1x+Q6Q57xzeUxVSyrIE3sbDmQN0uLw3OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Cp9JvqSYzZl7imeAC4XH/B1UFomRTORiE5wh2xGzy+4FwoO7
	9DTDlbP2sS2J3lhO8Y7fky6rAvcfC/VOx6gP1UnWU98FGUuDpEjjVAF6IFKWgp9WYZ38Hb2mCo/
	M8+yaUqTPArSP8Qwey1Fqjq2Lxx8=
X-Google-Smtp-Source: AGHT+IHWbdLUzOjMypjvojC5BejsuSfjfWBptWucpiuRIWlk3iRlpoiqNDNJ9G9RzY5sF9Hh3P5MEt8BDZ+Rud/0QHI=
X-Received: by 2002:a05:651c:2209:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2fcbdf689acmr179932591fa.4.1730805906749; Tue, 05 Nov 2024
 03:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com> <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local>
In-Reply-To: <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 5 Nov 2024 07:24:30 -0400
Message-ID: <CAJ-ks9=vUn1LKC12R05LZWwtoKC6QzvXCUyyaB4VKqAHEsGczw@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> Hi Tamir,
>
> On Mon, Nov 04, 2024 at 05:23:44PM -0400, Tamir Duberstein wrote:
> > There's no need for this. The type had the same form when it was first
>
> I believe we need this `PhantomData` to inform drop chec [1] that the
> drop of `Arc` may result into the drop of an `ArcInner<T>`. Rust std
> `Arc` has the similar definition [2], you can find more information
> about PhantomData usage on drop checking at [3].
>
> [1]: https://doc.rust-lang.org/nightly/std/ops/trait.Drop.html#drop-check
> [2]: https://doc.rust-lang.org/src/alloc/sync.rs.html#245
> [3]: https://doc.rust-lang.org/nightly/std/marker/struct.PhantomData.html=
#ownership-and-the-drop-check
>
> Regards,
> Boqun

Thanks for explaining! Withdrawn.

> > introduced, so it seems this was never necessary.
> >
> > Fixed: 9dc043655003 ("rust: sync: add `Arc` for ref-counted allocations=
")
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/sync/arc.rs | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index db9da352d588f65348aa7a5204abbb165b70197f..7e54d31538273d410f80fd6=
5b2070e75e4f69428 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -127,7 +127,6 @@
> >  /// ```
> >  pub struct Arc<T: ?Sized> {
> >      ptr: NonNull<ArcInner<T>>,
> > -    _p: PhantomData<ArcInner<T>>,
> >  }
> >
> >  #[pin_data]
> > @@ -219,7 +218,6 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -=
> Self {
> >          // INVARIANT: By the safety requirements, the invariants hold.
> >          Arc {
> >              ptr: inner,
> > -            _p: PhantomData,
> >          }
> >      }
> >
> >
> > ---
> > base-commit: ae7851c29747fa3765ecb722fe722117a346f988
> > change-id: 20241104-simplify-arc-70c3574b5fac
> >
> > Best regards,
> > --
> > Tamir Duberstein <tamird@gmail.com>
> >


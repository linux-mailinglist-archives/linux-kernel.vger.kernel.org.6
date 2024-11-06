Return-Path: <linux-kernel+bounces-398308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0159BEF60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523F0284871
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242A1FA27F;
	Wed,  6 Nov 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE20lKKz"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A01FA276;
	Wed,  6 Nov 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900709; cv=none; b=J3+iBnsQLU0WCOTqxtTaES+TBgrkTIRCQEpl5/DfPj6PrfXnp2Y4uwTEe1of2YCFmjiak/9v07PnEM+LCQPcM1YU5pRSZ4Fd/7rNG2uydLRes9LWQ+5snvv0nsfuMM2WZNfDMOOtkZZpJJ/b+LVtsLSVeLRmAl9gXgGUl6UOUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900709; c=relaxed/simple;
	bh=PRfP3mrthFXqO8z1UzhBDfaDERwKXLXkFR5QCYXGAq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGEBNZt5vjNM9jcJQoLoU3o0c1037YagW2Ud36gP+5Qznrt55OmGZKb3YMay2e9AKQqHEhrXe0O/Dw4DMmK5YlkgigpOCgwOBQGuYEhztKfZTolfFsJS4TaFaRCLzMY7gJwsh+hdOwhmVXL/gWZ/FMlIjm7vQJRbmuBkXiDNDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE20lKKz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso61857761fa.0;
        Wed, 06 Nov 2024 05:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730900706; x=1731505506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRfP3mrthFXqO8z1UzhBDfaDERwKXLXkFR5QCYXGAq8=;
        b=mE20lKKzhumN6npQ6O05N/5WD+qhS+T/lwG7GFBoPx5Nv/9nKQeMn1yLhaW2D+klcL
         d1uQ1yvh6+LI4RDJJZg/dqbRIUuJxVm6s89+SiodfO2lqgIPxDaXQSckNAu80I94XOTE
         FktVrDrKBriTcJn9zWU24sfPssWqe1h0RKV7UYhiAz/pz9cOYG32B+dCeK58tc/bLtgb
         zb4fQMQK34ZQ5kSu7mbRioZU7cPt5b6LDbTslqXXew6dN252f6nKTD41is0MvygUhiyH
         VBkV34fTRhifZNfUoefgWbYyNOrwHS29z3OpF9QuAIP5pwBqcNGoDAv2diDu/UF4vXXb
         W2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730900706; x=1731505506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRfP3mrthFXqO8z1UzhBDfaDERwKXLXkFR5QCYXGAq8=;
        b=RIdvOiVR71mZyXOCCeecsmUERL5JawezEZL/Kxl+C6w/IOCzwzI+2R33rXbTxIZbcw
         PENRWJPgThiRdC1fx+Rg7JS9Whtdv/6YWWoKtRF2eheckCrO5KlWCh31kV7LvtyxgcDU
         FOkJ4emtbm74MynLzq9aP1pzKVx+dNYNi0m8+FWjMtRkG4zn5XXZLXN1xDY2qPXn5cwp
         Y27IxqfF/3O/zwRuKCZWPfGFte37iSjAWb3QxpKwtQFt4VbuhLrQEZl79gFdu4atdLir
         Hc6YCqU9WCCgt2NVtB6+MMFsL68qkjwFiLHvw9QCiNkyhsGWIMEzEI0vtEbpSOzVzFc1
         LOeg==
X-Forwarded-Encrypted: i=1; AJvYcCUZHZgHGAqeuM76bl3/YRy1zWyJ3jDhNXGzZeQiRGmBEyqbJWnS6SgfzTaTKlOLvYUDh4hxVHvuVFlNh6w=@vger.kernel.org, AJvYcCVz7bYHhdHc8SEOZokkzZvbeixWnq7zj1ArdTs4lpGG481lmIOSVo38f6VpCTn3jhXX/SxLkmSHIY/X73V7yfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkrgbtODuSZtFK/GhZYzO77hS/lzfo/qfS4EpWpSMqRdGA7S4
	CJSp1BIu0w132CtNTLP+TIm629R8T106EmSc50ce5XcWp5g5exQYNsMS2LMc0j1yBneXYH1GEPK
	rAn31jHxXeeMCbMUaYGEil296XlcnWc6Mb/bzDQ==
X-Google-Smtp-Source: AGHT+IELinPh6kMtPZIP+nahufU32K4ML7ul8ABbiKuMB0PqMwTZcIuuGNgfP6rzZ7Nn5cP2Lr7pslHb2Ini0UymVNs=
X-Received: by 2002:a05:651c:510:b0:2fa:f5f1:2539 with SMTP id
 38308e7fff4ca-2fedb79ef0emr107100971fa.24.1730900705695; Wed, 06 Nov 2024
 05:45:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com> <CAH5fLgjXXE32k2VuC9yGrNG7ib5vo7V+fsvRxWG0ijopK7MDCQ@mail.gmail.com>
In-Reply-To: <CAH5fLgjXXE32k2VuC9yGrNG7ib5vo7V+fsvRxWG0ijopK7MDCQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 6 Nov 2024 09:44:29 -0400
Message-ID: <CAJ-ks9=b=UEp9KCZ5_dE5yDKWZ1BEfnTkAtS4LiNQ4wzMgdT4A@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:26=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Tue, Nov 5, 2024 at 9:13=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > On Tue, Nov 5, 2024 at 8:29=E2=80=AFAM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > On Mon, Nov 4, 2024 at 11:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.=
com> wrote:
> > > >
> > > > I believe we need this `PhantomData` to inform drop chec [1] that t=
he
> > > > drop of `Arc` may result into the drop of an `ArcInner<T>`. Rust st=
d
> > > > `Arc` has the similar definition [2], you can find more information
> > > > about PhantomData usage on drop checking at [3].
> > >
> > > Hmm... But they use `may_dangle` in their `Drop` and we don't (and we
> > > have a `Drop` unlike something like `Unique`), no? Or am I confused?
> > > i.e. if I understand correctly, that would have been needed in the
> > > past, but not anymore.
> >
> > Doing a bit of archaeology I found the reasoning for the presence of
> > `PhantomData` in std's `Arc`[0]. The TL;DR is that the presence of a
> > type parameter `T` implies "owns T", but `Arc` owns `ArcInner<T>`
> > rather than `T`. Thus in order to get correct dropck behavior it is
> > necessary to opt out of "owns T" using `may_dangle` and opt into "owns
> > ArcInner<T>" using `PhantomData`.
> >
> > Please check my understanding; I couldn't find detailed documentation
> > of the interaction between `may_dangle` and `PhantomData`. If this
> > sounds correct, should we add `may_dangle` to our dropck? compile-fail
> > tests would be useful here.
>
> We don't *have* to use #[may_dangle]. Using it may allow more stuff,
> but it's not a problem for it to be missing. We probably don't want to
> use it since it's unstable.
>
> Since we don't use #[may_dangle], we don't *need* the PhantomData
> field. Having it doesn't change anything.

In that case, should we reconsider this patch?


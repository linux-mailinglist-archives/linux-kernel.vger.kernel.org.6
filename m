Return-Path: <linux-kernel+bounces-534503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E43A46792
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401523ADDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BA224896;
	Wed, 26 Feb 2025 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4hM2SVU"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3915224AFB;
	Wed, 26 Feb 2025 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589928; cv=none; b=UrTR5FR6sDZLUfSAEAF2KjQ3e2sMnr9C+DnQFXOkL0XTUwXdSlXFaJj3e/pumO4YEkTiOuqeEOxfO9U8T5Q7evSs7eTraDkQcb1rcJNeIa2fSW23Kl8Z7hUDd1hKUcM4oiyydBKpP2MxMjTCbLyIF97CwYCa2yt53ubw1Ass47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589928; c=relaxed/simple;
	bh=CKmL45MF3D/cWpj4NBs+BRN2U4392XMuvZPpdtIhJCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpqlzplO99ePbc3NJWlRoJ/249PbSnSyLHQ9xI5pY4yM5wAfO4rXBV3JxhaYfwEEDW7at4dNU6wIgfY0RTh81WdrETacI+9drQ63gU/9bG1oYHiy03tDoighDIJzzc4POnhfIG8Dvc1mJQQoeX863wkBikaXKb1MLkFlIlOifc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4hM2SVU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fe99d5f1e8so22360a91.1;
        Wed, 26 Feb 2025 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740589926; x=1741194726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0++ssa3KklqvkS2+TUnBgIYo9/l/jr1/yCcC6gaJdo=;
        b=T4hM2SVUH6Nfm3e/6SqQsSIQiRCYd2niSehzvPm4oVtP595BwtzC+TD1lOX+HU3dE/
         2Nt/+L3+z7miUhlbUG1Q2klLQW5eBtOtPenn3NrHZpLWLXmE6D9JtJ3zZSKhVLofz66I
         R6+W6RGKUYqX80gI75nzE0qnNQsb1tV1eIFBjyQBQF7rAaCv1s6PQt7o1gXh3NdgaIJl
         rS6P4U4iUY5dXbysLPQ6CfBEL8IjvhkHkZUG5+BMA9QPxfLGYQZI6ns7YPT8x1GReTeU
         WuVVfcCUeInAbRF5te9r6okUUy4kiXV5mVdzUMotOlNhm3zp+SB8J1nAl7RCJNnkNFiS
         D7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740589926; x=1741194726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0++ssa3KklqvkS2+TUnBgIYo9/l/jr1/yCcC6gaJdo=;
        b=JLAVk3t9LIAbf1Ol69rjr2q8GiBV4K9UW7EdPpMK6mvDMUGl89XGSlkjarLDklTCqa
         aD9ysTJhuNpw5LjMtvjz/Ed8gS3E8LfvuhGp2boOWjuUWyIopesHu1Sg98rntZyKXToW
         Ug59HFbkLruqmRnPTBxvndYuUbvDzS5klrYeC849sJ1OBB9kZpiAQHP9CaeWKzAABfqQ
         rPZZhVPF+uqNWQRhyoY04LgeQWRaQOUJA8eEIkmb+DxYmd4svc9Jtz6LU+9t8IcPEMCw
         Lk6m2iSxpz1k0n/xbSJTdEyuG7/frD2JPszvfzUCozXu6pRUpwK/ZwPTWNr3zQl2c3RP
         92Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWAryk7I3ceoGD9OrhCkmYufqNhFk+ckn6gdxAmrgLkQum7Iux33FRG4rWg0MueYqEOKGDTYnr0xkQjzIo4/k4=@vger.kernel.org, AJvYcCXIF7m3ldsR8NbbIGj02aOqbu+g72kMvhS0XZdwug/rDy2t8kStfdNhjbBASpctRx2hZVOkTNhr/l5/zPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRMgaUcXm+30fZh1K8t4m0YjqsEBy9sTblKnYjtDAENMhGFsV
	QW/RK2HHmyz45U8YFMO+zY58mBH2pkAt9t8PIxphSJwPgzN1V5iljvJWcOcx9hku7NWwgXmbEF7
	05r/PWh5DrYm500Gke18E+fbs43s=
X-Gm-Gg: ASbGnctZkH1ujl4Co8ZkR4aeaMNRXsRMSWdqJ9bhVZlSf5nUAbJq1RPg8cEDvtjyPK7
	AZX/LJ56TXmdasEGNq/MuimxLkRY8glBf0U5oVSSptSkuHF9uPHCDIXBQAVWaMcfb97p05oV5Of
	T7AcCJP4w=
X-Google-Smtp-Source: AGHT+IEviEOnl0xfL1S6XtApmG3cyllnaIXmrMVdQ23v2GjWKaie4K7gOcLYfIO7VYOXTJQe89W5rpmlXx8fxPCy2w0=
X-Received: by 2002:a17:90b:4d0d:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2fce75d75a7mr14266904a91.0.1740589926114; Wed, 26 Feb 2025
 09:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com> <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
 <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com> <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
In-Reply-To: <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Feb 2025 18:11:53 +0100
X-Gm-Features: AQ5f1JomtzOpefkwmwH6LSFqWj2xlKQ1O2v116mBDbHDQFWRjp5xrC2xazyfcR0
Message-ID: <CANiq72=_krDaFaF4t2oCEQQGqO1Z7RrjxD7ZRSL79A4FCLwi=A@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:26=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-02-26 at 14:53 +0100, Miguel Ojeda wrote:
> > On Wed, Feb 26, 2025 at 2:03=E2=80=AFPM Ventura Jack
> > <venturajack85@gmail.com> wrote:
> [...]
> > > Exception/unwind safety may be another subject that increases
> > > the difficulty of writing unsafe Rust.
> >
> > Note that Rust panics in the kernel do not unwind.
>
> I presume someone is working on this, right?  While rust isn't
> pervasive enough yet for this to cause a problem, dumping a backtrace
> is one of the key things we need to diagnose how something went wrong,
> particularly for user bug reports where they can't seem to bisect.

Ventura Jack was talking about "exception safety", referring to the
complexity of having to take into account additional execution exit
paths that run destructors in the middle of doing something else and
the possibility of those exceptions getting caught. This does affect
Rust when built with the unwinding "panic mode", similar to C++.

In the kernel, we build Rust in its aborting "panic mode", which
simplifies reasoning about it, because destructors do not run and you
cannot catch exceptions (you could still cause mischief, though,
because it does not necessarily kill the kernel entirely, since it
maps to `BUG()` currently).

In other words, Ventura Jack and my message were not referring to
walking the frames for backtraces.

I hope that clarifies.

Cheers,
Miguel


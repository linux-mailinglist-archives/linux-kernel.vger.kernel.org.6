Return-Path: <linux-kernel+bounces-523481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72DA3D75C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2321893D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5731EE7B6;
	Thu, 20 Feb 2025 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VABwMt9B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA11C6FE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048757; cv=none; b=XqMi7ejhem0/4fGseiV/pSUDKpZ/76ijGBi3LKXj0VNAkjpiKMafDStEc1zjv2NYPVffbCFXnFoE0+wTOkOLPY3Wtwb7cWgPTPW16EHKyMo6X/R6J3gwck47Zo+5CQEr5kqGQFXvI1vOo8//nX9aiS459rbUQHGFig5LfC2hL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048757; c=relaxed/simple;
	bh=d0FbFIMlbroY4FrF/jdgx1U9OHINxOclg6SrAZCmkgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKoJlVMoHOMq5C7e6d+A6Wxw2B/lbX207pn/IrqCboeX4LPaVew/xzqdoRN19EFcejI5pUjSUGSz9XSZg5aMN6aSKW5gO29WS+OTbtXFO9v5n3CUqOIUinBmr7eZgsyMC5cX2IyYUxtCHaX87HFInBjnDkDmo0PH+YeIgj9CjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VABwMt9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF6C4CEE4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740048756;
	bh=d0FbFIMlbroY4FrF/jdgx1U9OHINxOclg6SrAZCmkgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VABwMt9BUXJ4AQs2Rl8pJx02BdBBO+O3ObO7ydFfspr5JEvjS/dr+1RLj9ftDoeb4
	 scySqoyOmEPDT7Hq/j4tdN1yvPOVZHaPTejLmh2yneKroKK/SBPfzi1i/tBut+FOGP
	 WW6UBLB+Z4coRQWVDtvfeKFRJ7w5cvNFuGfumqibetAWwOLbuwLJk/mTpF8l/z9eN3
	 9iKk1EsnrsdOzjblm2mUyJf2/nHNIL92JPwsgP8VFahVxtrombp62CMG1qhUt0G7t/
	 LM7t4PhN5utb2hd2zxOyJhxNvcPFj4T5irAiauAFfxdBf/y3DuvwjxmYnZDZgY7iRI
	 ubatcmpAh4GdQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54529eeb38aso638546e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:52:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbN9//s0fzIQLpJTCHMMI0TRyX/IqOYM/2+oB328tWV3UbhIQOO9Pubh0QC2O8IRCICbiE8TUlFo08Z4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3rK+R/nXCbSYKTdOa5ToUlluXJD3I67lCRG+wRCJwBgjnKJU
	+3Y/rkeQ8Zd+3XdmznPHG9TiIfLSDhEK0PAnNCYHc6vX86SxAGhFPIwVt060NUYuZcCYaik6Twv
	4sGj4eBWb2fSEzKXo1AlNwZBt/PQ=
X-Google-Smtp-Source: AGHT+IGkbFTpetv+pCCWNPc+krf9Mb+HkkaVVE8MfCzt6odv9tu918rBtGft7I72ftRi55cK45u/U1h5E74/7XcmbQA=
X-Received: by 2002:a05:6512:281b:b0:545:1d96:d6f7 with SMTP id
 2adb3069b0e04-5462ef197d6mr3259244e87.32.1740048754912; Thu, 20 Feb 2025
 02:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
 <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com> <CAFULd4aYjnWzWaN8WA0LetN1Li7F8MY3qnxbhY8=tNFxqHCP1w@mail.gmail.com>
In-Reply-To: <CAFULd4aYjnWzWaN8WA0LetN1Li7F8MY3qnxbhY8=tNFxqHCP1w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 11:52:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com>
X-Gm-Features: AWEUYZkBvTy0wLkCBwjYlf_bns_v1P4pzDzo14JTk7nfgZmLh2JVd0DO1S9-P0o
Message-ID: <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 at 11:46, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Thu, Feb 20, 2025 at 11:05=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > Hi Uros,
> >
> > On Thu, 20 Feb 2025 at 10:51, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 2:18=E2=80=AFPM Brian Gerst <brgerst@gmail.co=
m> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 6:47=E2=80=AFAM Ingo Molnar <mingo@kernel.o=
rg> wrote:
> > > > >
> > > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > > >
> > > > > > I wonder if there would be any benefit if stack canary is put i=
nto
> > > > > > struct pcpu_hot?
> > > > >
> > > > > It should definitely be one of the hottest data structures on x86=
, so
> > > > > moving it there makes sense even if it cannot be measured explici=
tly.
> > > > >
> > > >
> > > > It would have to be done with linker tricks, since you can't make t=
he
> > > > compiler use a struct member directly.
> > >
> >
> > Interesting take. I'd have tried to put the canary at offset 0x0, and
> > simply use pcpu_hot as the guard symbol.
> >
> >
> > > It boots and runs without problems.
> > >
> > > However, when building the kernel, I get "Absolute relocations
> > > present" warning with thousands of locations:
> > >
...
> >
> > The warning is about the type of __ref_stack_chk_guard, not about the
> > type of the relocation.
>
> Thanks, I got distracted by the text of the warning that mentions relocat=
ion.
>
> > $ nm vmlinux |grep \\s__ref_sta
> > ffffffff8350c620 A __ref_stack_chk_guard
> >
> > Without your patch:
> >
> > $ nm vmlinux |grep \\s__ref_sta
> > ffffffff834fba10 D __ref_stack_chk_guard
>
> Is this a problem in our specific case?

I don't think so - the whole notion of absolute ELF symbols is rather
flaky IME, so I don't think we should be pedantic here.

> We can list the symbol in arch/x86/tools/relocs.c to quiet the
> warning, but I would need some help with auditing the symbol itself.
>
> OTOH, we could simply do it your way and put stack canary at the
> beginning of pcpu_hot structure, with
>
> static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0));
>
> for good measure.

I think this would be the most straight-forward if there are no other
locality concerns this might interfere with.


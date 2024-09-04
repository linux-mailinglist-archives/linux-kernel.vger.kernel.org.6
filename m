Return-Path: <linux-kernel+bounces-316077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B796CAD7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9921F28494
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CF17B436;
	Wed,  4 Sep 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eqaWgET"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB114D703
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493027; cv=none; b=CK2/gDYNUtvXslMObsWIrvsdo7ATBpV8R4UgpuwfBZPtYNoEaTMyOn4BeXBEAgRKvA6bd60EHbaKriXLD0KiprEpemzTu/4yzBvUq1uU0bab8NOEQKbLNhCJ5BWy2jd1dtRiJWoodKNbPRg4qNwphKBcn0ysbKYVuojD0v7yeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493027; c=relaxed/simple;
	bh=2i7jdujG8eIGFsZ+R4bmgK7Z9BWm3NOZw8YsCrlObMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5tLaQEbUjSBQQpqnutSzMnKAAU7GFI/1olt9rhV7SBEWgAtvZk2GxtX8z/uY+m/gER169f7DjcfkPiGIoUKhmmUySXDdPzS6Ur7ki59V1uafheMFbDZXknVqA38095X8zTI25VvDzMLRxRWZTDCsqoxTQu+RB17fuQ7BsqP+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eqaWgET; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5353d0b7463so162818e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725493024; x=1726097824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i7jdujG8eIGFsZ+R4bmgK7Z9BWm3NOZw8YsCrlObMA=;
        b=1eqaWgETO1xRo2jo5wr+ZAL33aM3GPaNzGCPaYfo6R5cGxS5v99iPGytYIFxd0QOVH
         p9eRlqYtt+0ASiNsCbSZfZlxu8dKM5yMPquEKPrTlFnNMqP1I5slabllUI/WIBTRegQn
         9njkFdPPLuBHdAPHAlkEcOiBFEpoZ/2jLe9cdjmpq1qmKKr8As8N9xg4Zm6O4qVQBOgy
         XMBayZAw5QvXrwcw4C9rri1U5FRVw/PksguoJB+JsuJwsHCT9qXxLFjE2q4/ZTFOA29Z
         4TJygzfTY5Ou/2HmPoiJtumdkS3zpWWPAST99bDDKUsjza6NIK9lvEPUNsM+ioVjtfY3
         otDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725493024; x=1726097824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i7jdujG8eIGFsZ+R4bmgK7Z9BWm3NOZw8YsCrlObMA=;
        b=j0IOLTPkSIIM4zjKL83xQ2qybtkpbVZh9eB+ZBr3iECz/+Br6nzRSW1Wj+zRKJN0Ts
         NcyGvZRj6iQNbB9MtXSetRGnK32bfvj2KwPrna/xFOqK5HcwjwH5zmbqQTpMPWH5WLDQ
         SKvEPRgBm37gm3JmlUvc9OU6iNNIV1B0AzsRU2ZEloP/3ShGd9Xk9L1wONgZ+ORqzfn4
         vPqOJKJqpIZvbeQsyzEGhwH4rALdM0gU6oSSJNhHQOuZvulsI9Hem8q2/1zJOI6pTPcl
         qcvT9Q6nJG9z38XGnslN4U4eKu1+H1EPdn8u4X5cG+RQgHgxco0bFMl4Eb0fjDCgJfeR
         Wn6g==
X-Forwarded-Encrypted: i=1; AJvYcCVMulFsSP7CSBL+Du3Oai7QkZRvn11IIjEMluBhhy7TiD6EaYg27HulK+xakQ0WrwDaCNZVM3GAhu8XZig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4tFr5F3QyNYCohn4G3q07PQmnRLja81ww3tpInCQ810PnpzXW
	Oay+FF18+U1Ka3OsxTd8VpPO9ZXbk8pASNloOAtmg6y7tZnEyUpYIx+m3Fncm0Bd6LY8YZru7w0
	3OE4DVL/Z2P75cDEw4uocq1eqRCaEKprzDB2G
X-Google-Smtp-Source: AGHT+IFqfOcvoCbUS5vOqB2O1EnmAuLB1CPavvPvZTFX9sDAQaTS7Ezm3gmoT4QSh8MVYb0iQpBoMJ7C62D7EK12AuY=
X-Received: by 2002:a05:6512:3a94:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-53546b345a1mr17100135e87.16.1725493023268; Wed, 04 Sep 2024
 16:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com> <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com> <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com> <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com> <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
 <277CDE7C-7ED8-4840-9C30-533C9327B028@gmail.com> <CAJD7tkaTcnuCFW+dWTzSAuLKBqkkGv9s5uByYm9DaJC=Cp-Xqg@mail.gmail.com>
 <EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com> <CAJD7tkZi8Wg+ZCWMy=2YKZ3hLZZ7JYQaCG+w7y=3Tb8wmHC48g@mail.gmail.com>
 <CAKEwX=PiyvV7AxKESk5zc9TN1n5b0uFR0pr_HGxKsUFUgk0q+Q@mail.gmail.com>
In-Reply-To: <CAKEwX=PiyvV7AxKESk5zc9TN1n5b0uFR0pr_HGxKsUFUgk0q+Q@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 16:36:27 -0700
Message-ID: <CAJD7tkZrf_RVT1+LtBMrpL0T==1757WSjHiSOHp7Pio0T-F5OQ@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Nhat Pham <nphamcs@gmail.com>
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:43=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Tue, Sep 3, 2024 at 10:49=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Mon, Sep 2, 2024 at 1:58=E2=80=AFAM Piotr Oniszczuk
> > <piotr.oniszczuk@gmail.com> wrote:
> > >
> > >
> > >
> > > > Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.c=
om> w dniu 31.08.2024, o godz. 19:23:
> > > >
> > > > On Sat, Aug 31, 2024 at 2:41=E2=80=AFAM Piotr Oniszczuk
> > > > <piotr.oniszczuk@gmail.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >>> Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google=
.com> w dniu 29.08.2024, o godz. 23:54:
> > > >>>
> > > >>> I also noticed that you are using z3fold as the zpool. Is the pro=
blem
> > > >>> reproducible with zsmalloc? I wouldn't be surprised if there's a
> > > >>> z3fold bug somewhere.
> > > >>>
> > > >>
> > > >> Hmm - yesterday i recompiled 6.9.12 with zsmalloc and =E2=80=A6. a=
fter 16h of continuous tests I can=E2=80=99t reproduce issue.
> > > >> With zsmalloc 6.9.12 looks to me like stable.
> > > >
> > > > Interesting, and a little bit what I hoped for tbh.
> > >
> > > :-)
> > >
> > > I tested mainline 6.10.7 with 26h test and also it is stable with zsm=
alloc
> > >
> > > >
> > > >>
> > > >> With this - what will be your advice to move forward?
> > > >
> > > > Well, it's possible that some zswap change was not fully compatible
> > > > with z3fold, or surfaced a dormant bug in z3fold. Either way, my
> > > > recommendation is to use zsmalloc.
> > > > I have been trying to deprecate
> > >
> > > IMHO - isn=E2=80=99t bug in this report + difficulties to reproduce->=
fix enough to depreciate z3fold?
> >
> > I would say this bug report is yet another reason why we should depreca=
te it.
>
> +100000.
>
> This is precisely why I was asking which allocator was being used
> here. We have also accidentally selected z3fold internally a couple
> times in the past, which had bitten us as well.
>
> >
> > >
> > > > z3fold, and honestly you are the only person I have seen use z3fold=
 in
> > > > a while -- which is probably why no one else reported such a proble=
m.
> > >
> > > Well - in fact this is ArchLinux - not me.
> > > I=E2=80=99m using Arch and kernel in builder machine with ArchLinux c=
onfig + packaging
> >
> > According to [1], zsmalloc should be the default allocator for zswap
> > on ArchLinux. Anyway, I initially thought that no one was using z3fold
> > and it was bitrot, but apparently some people are using it and it's
> > actively harming them.
> >
> > [1]https://wiki.archlinux.org/title/Zswap
> >
> > >
> > > >
> > >
> > > I see benefits already: on very memory demanding qtwebkit compile:
> > > z3fold: swap frequently gets 6..8G from 16G available
> > > zsmalloc: can=E2=80=99t see more than 1..2G
>
> Exactly :) zsmalloc is better than z3fold in a lot of workloads that I
> have observed.
>
> > >
> > > > doubt that you (or anyone) wants to spend time debugging a z3fold
> > > > problem :)
> > >
> > > lets depreciate it!
> >
> > I tried deprecating it before [2] and performed some analysis [3], but
> > there was some.. resistance. Maybe I will try again and use this bug
> > report as yet another argument for deprecating z3fold :)
> >
> > [2] https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahme=
d@google.com/
> > [3] https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=3D2Ww13sCj4S=
3i4bNndqF+3+_Vg@mail.gmail.com/
>
> I don't wanna sound like a broken record. But this has been the nth
> time we need to spend extra engineering time and effort unnecessarily
> because we have not deprecated z3fold.
>
> If you need more datapoint - here's our last conversation where z3fold
> was a problem:
>
> https://lore.kernel.org/lkml/CAKEwX=3DMo+EaaxBYcLMTHYADB4WhqC3QmWV3WQ0h2K=
M491FRuQA@mail.gmail.com/

I sent a v2 of the z3fold deprecation attempt:
https://lore.kernel.org/lkml/20240904233343.933462-1-yosryahmed@google.com/=
.


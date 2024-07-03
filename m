Return-Path: <linux-kernel+bounces-239040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B47925550
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA91C22AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B8137C34;
	Wed,  3 Jul 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVe8deiB"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D713A24A;
	Wed,  3 Jul 2024 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995037; cv=none; b=JrG+tj3NbBsFTWQ/6kk0cSaOfECNnD4ky9WZgOTgbpn8XgoXWFl+YAPoZ45M0htgv7R3n37rvloUrLBAEOhbajO2wPeqJaNyqzCchw+btGAFmRUJaSOJ/IHmzRfWSW6pa0i+HT5c7e75CvESVp+qcLZKninB9XZsS21I8kkPGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995037; c=relaxed/simple;
	bh=6705XkaLy00URbcsdcKue3vH2h024J9S4iLZqDyTKCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feoAJOwh3m801bBoPjaj/td62AqJb9KAkyA109YKQbaAD1gg5pQiDVso/ZGIVO8xBYcdtbbQFjxnAfysOq5qAwfDCgB7zjHJpAPO42avWatS3lWr9pKL47vvdqSBE8AWpjZGtyJY1w/w9RvVkn7uw//Yz9P5DtiZFvsvk4Bujjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVe8deiB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fe617966fso457261566b.1;
        Wed, 03 Jul 2024 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719995033; x=1720599833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zCMYXJXadwK61w5sdXjhb6LXfr4ZtVK+ganCBejHY3k=;
        b=QVe8deiBkV/3KEq2IP9CW+FtvLS+PXWuJoAQwOrWbv07BQI/x5Jx52+mpJjtktlWQD
         1GJSdYw2IezAj/qG0dHMPqF3ABVHgA8JVpLBXQv+rXgFUwOetJdXjspIwlEfW9PC1kaR
         fgxsCG3exAP5RtXyThBfFQs3KOMyI4YZJEDWZPW7VcT8Ywn8NqW5bC7Z9HnDxLt7alYs
         uvyRD2GPKSxTKAc0PG9k1F5qaE3MVVSp/P/orpezU4jKZq4kIoyi7IPtyt3Jsf9d369v
         lgRYdOOY8rUT2bk+5JT7W3MQ0T2YiTl/SUhN2v7UJOK/tT4UxWMdWDlYhGC8YiZFDzgz
         nKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995033; x=1720599833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCMYXJXadwK61w5sdXjhb6LXfr4ZtVK+ganCBejHY3k=;
        b=AfK9cK5QoUdUxMaAl5a0BsFD9B/hgOAuKX0vt29vUAVRHvMkq+v7F10/70gUVDnDXQ
         MJXB2qWiUdmFr8gVosqh4Z9/N3aUO6ZBYQ20yZPe4fN8eH7t5G4rW2DT8+1bGKY9e/gg
         dhmdRiiyDkla0ysxMOQdzqn6/6HS6sMgMpM+5PpUf+dLpyHUR1+cb+AbNNfD66gFzHT0
         hHUR7uZhmpHY/qOJ0b3FPKe+QkYhZ+MJAYQkv/nWKJQHiCyqV3Pf4msE/sGsLTtVLwf4
         Pbhcqg/lRBHNg+NSb/snyaDMMiQ7cCGoMd2ib2hEdrsQ2ynX+4kA/CnEcdTGyip7st/X
         HbKA==
X-Forwarded-Encrypted: i=1; AJvYcCUpNMdPCl08IdV8Uq3LuxWTQuNuxrTSmR5fifR2RS0t1PGVZAFNorE+mRuEBQDT/ng7NL6VUOwtvcFRm7PHPUFI/kNfE6h420aIauOfT9PnxbjLJxIaxOMS//HO25k5UUojvuEiWgomyA==
X-Gm-Message-State: AOJu0YxX9MS25otjiy2JZLgaWp89xR/s7qQMCriw3EdNcrgmcipBkgXg
	Y+VPRf5RROakOMkkj3La6zfC3Q9tOj8Til7E1knSRgwEbRkywSH+wMfL4PLQmnbjVHCMfPHDR8p
	JHCsj5/tNq87yIv9MhNv8vtYsKg==
X-Google-Smtp-Source: AGHT+IELcZTIilt/NDQQO1QrB9EIggXdx7nlZ6ejwLcXZXR9gSKZjLqipfoOr74YTbP8BXrqr93Wpl4wY+4zDdSTw8s=
X-Received: by 2002:a17:907:84d:b0:a75:29ea:283f with SMTP id
 a640c23a62f3a-a7529ea28d3mr540210566b.66.1719995033305; Wed, 03 Jul 2024
 01:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org> <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
 <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org> <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
 <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org>
In-Reply-To: <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Wed, 3 Jul 2024 10:23:16 +0200
Message-ID: <CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jaime Liao <jaimeliao@mxic.com.tw>, leoyu@mxic.com.tw, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, Julien Su <juliensu@mxic.com.tw>, 
	Esben Haabendal <esben@geanix.com>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 09:12, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 7/3/24 12:16 AM, Erez wrote:
> > On Tue, 2 Jul 2024 at 07:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >>
> >>
> >>
> >> On 7/1/24 6:08 PM, Erez wrote:
> >>> On Mon, 1 Jul 2024 at 12:15, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/1/24 10:46 AM, Erez wrote:
> >>>>> When using mx25l12805d, we do not read SFDP.
> >>>>> As it uses the no-SFDP flags.
> >>>>> When using mx25l12833f hardware with mx25l12805d driver, it did not
> >>>>> try to read the SFDP.
> >>>>> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
> >>>>> driver fetch the SFDP.
> >>>>>
> >>>>> Secondly SFDP does not contain OTP information.
> >>>>>
> >>>>> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> >>>>> While mx25l12833f has two OTP regions of 512 KiB.
> >>>>>
> >>>>> How do we handle it?
> >>>>
> >>>> You would first try to parse SFDP and initialize the flash based on
> >>>> SFDP. If there's no SFDP then you fallback to the flags declared at
> >>>> flash declaration. Esben had a try recently, see [1]. I don't know if
> >>>> there's any progress in that direction.
> >>>>
> >>>> Also, you haven't mentioned anything about the testing. Do you have the
> >>>> flash?
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/
> >>>
> >>> Looking at "mtd: spi-nor: macronix: workaround for device id re-use"
> >>> I guess it can be applied to all Macronix devices.
> >>
> >> No, no, we're going to do it individually just where it's needed.
> >> Issuing unsupported commands is not that great.
> >
> > Would be nice if we could ask Macronix directly.
>
> we did. They said it's not ideal, but it's okay.
> >
> > Looking on their web site and reading some spec. and status reports.
> > Using the IDs with  'no_sfdp_flags' in drivers/mtd/spi-nor/macronix.c
> > I did not search for new chips reusing IDs of chips at end of life.
> > But we found 3 already:
> > MX25U51245G appears in the table with the same ID as MX66U51235F.
>
> is there an extension ID that differentiate the two?
>
> > Esben Haabendal found MX25L3233F which reuses  MX25L3205D ID.
> > And I found MX25L12833F reuses MX25L12805D ID.
>
> Yes. And we already have a plan for these. We need someone that cares
> about them to implement it.
>
> > Chips that are not in end of life do support SFDP, at least the new
> > versions of the chips according to their spec.
> > It seems quite systematic.
> >
>
> maybe

I check the public spec of all chips, but one, which are in the
Macronix driver table and are still in production.
They all support SFDP. I do not understand the "maybe".
As for the chips in end of life, we found 3 new chips that reuse the
ID, we can find the rest.

>
> > By the way, the chip MX25L2005A part number is 'MX25L2005' without the 'A'.
>
> feel free to propose a patch
>
> >
> > We can support Macronix chips that are not in the table, just by
> > reading the SFDP.
> > In that case we can name them like "mx-szNN".
>
> We don't care about the flash name.

Agree.

>
> If all the flash settings that we care about can be discovered by SFDP
> then one won't need to declare a flash entry at all, and instead rely on
> the driver to setup the flash settings solely based on the SFDP tables.
> See spi-nor-generic handling.

Excellent feature!

>
> >
> > The table below uses fixed width characters.
> >
> > ID      Part.         Size              Status          SFDP status
> > according to spec.
> >                                                         New chip with
> > SFDP for EOL
> > c22012  MX25L2005(A)  SZ_256K =  2Mb    EOL             MX25L2006E
> > c22532  MX25U2033E    SZ_256K =  2Mb    EOL
> > c22013  MX25L4005A    SZ_512K =  4Mb    EOL
> > c22533  MX25U4035     SZ_512K =  4Mb    EOL
> > c22534  MX25U8035     SZ_1M   =  8Mb    EOL
> > c22016  MX25L3205D    SZ_4M   =  32Mb   EOL             MX25L3233F
> > c29e16  MX25L3255E    SZ_4M   =  32Mb   EOL
> > c22017  MX25L6405D    SZ_8M   =  64Mb   EOL
> > c22018  MX25L12805D   SZ_16M  =  128Mb  EOL             MX25L12833F
> > c22538  MX25U12835F   SZ_16M  =  128Mb  EOL
> > c2253a  MX66U51235F   SZ_64M  =  512Mb  EOL             MX25U51245G
> > c22010  MX25L512E     SZ_64K  =  512Kb  NO_REC          Have-SFDP!
> > c22015  MX25L1606E    SZ_2M   =  16Mb   NO_REC          Have-SFDP!
> > c22536  MX25U3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
> > c22816  MX25R3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
> > c22537  MX25U6435F    SZ_8M   =  64Mb   NO_REC          Have-SFDP!
> > c22019  MX25L25635E   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
> > c22539  MX25U25635F   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
> > c2201a  MX66L51235F   SZ_64M  =  512Mb  NO_REC          Have-SFDP!
> > c2261b  MX66L1G55G    SZ_128M =  1Gb    NO_REC          Spec. is not public
> > c22314  MX25V8035F    SZ_1M   =  8Mb    PROD            Have-SFDP!
> > c22815  MX25R1635F    SZ_2M   =  16Mb   PROD            Have-SFDP!
> > c2201b  MX66L1G45G    SZ_128M =  1Gb    PROD            Have-SFDP!
> > c2253c  MX66U2G45G    SZ_256M =  2Gb    PROD            Have-SFDP!
> > c2253a  MX25U51245G   SZ_64M  =  512Mb  PROD            Have-SFDP!
> >
> > EOL     End of Life
> > PROD    Normal Production
> > NO_REC  Not recommend for new design
> >
> >
>
> not sure what you want me to do with these.

That we can read SFDP for all chips from Macronix.
Only old chips before 2010 do not have SFDP.

Erez

>
> Cheers,
> ta


Return-Path: <linux-kernel+bounces-238557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEC924C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55311F236E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA3215921B;
	Tue,  2 Jul 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6RfDDZE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8F1DA30B;
	Tue,  2 Jul 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962235; cv=none; b=cc2NH5O2ckhCecidBRkCq7m30LE05oBsoLuZi507iV50sd9PHxCkM5qHwRIi6hjrQGm7/9F/sF+rm3lTIKTd+nXzuIdxirT/uXx3CknRqhjN2vUsTF9zxywm3c1GLXvQBjCoBpzZiro22Bad/ernTiE6AFU+fmqgAIytnulVhI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962235; c=relaxed/simple;
	bh=zBsihOxvet9/KBL5UEKa0f8z7x+qi7umkg1wBfoaX0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocsqfX+5kkIid0C7iBWo+YK4u8vVTwQ2qiKuQOB8iXWIUjctTDHENntXYW+56/gaCouewAKZ7PYeYgZ0WSLkedrb61mjFoOmlBx1GJUqtqscuMK2AoNxYA3Nk/Jo0hx5tlLDPLuV5GYgQUyb+DW+xG4J3to4j9BWsXpgu3R8ufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6RfDDZE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e96d4986bso115974e87.3;
        Tue, 02 Jul 2024 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719962232; x=1720567032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+WDS3Cw1/CilyNtoq0dIMkfkf+u6o8YFkOYBScGZNQ=;
        b=A6RfDDZEmhRKjQBJXbc3MnWdNOMy7VSc4g4z9boFxZDCARNn5EPZeuivdOi/qoxjBE
         DN8lZGmCmJ9dn38h8REzWelQ3PQfy+zhxrOOV0HLyqq2SXbtX5xWQuUCuDYkxlkliPxJ
         etV6NUBVT1plafpXhCflkBxC3Uq2YfGAXdtS3tZNPzSmGR4/1TatXpOJwZVf3OnvKBKa
         LcrdBy4yjq/RR1b2/F7scqS4DElH4N6LwjYAFiqNiq9IeYWFPhnnyFEum+8Riuk8Xhc0
         48Cbu4GSVgoQoZZ4PNvwbHZZcL17+++oii588u6Vc5xnAa2eIkXuRVzj+o3XJCs6eYFn
         KJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719962232; x=1720567032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+WDS3Cw1/CilyNtoq0dIMkfkf+u6o8YFkOYBScGZNQ=;
        b=cLOJSVAHQ7JixywDW6MFNEXbHfQy9DSPM3K0H0mGSwpJSjdYrlopYWKjax/+cBJlnh
         SvsulCgQZRkcjIMrAMu1zjTZHvNjtqlltQYKUM3rQQYxnuv0crGHvAXO7YFKDIsmm4jk
         lKbHxpUqW6EFkYJSyi04PwN3TNSD5LnOXm6GtteL8YpknVos9Pq9doaTNv2uwywnOpGh
         sEB00Z+fQuqttppLonBA8HcrZ81dSyV9D+Fskt8tGMKOaY4gVMWy1RooGyd43psoXbsZ
         MvEXDc+t1FkXTV107ZYi/ZGmCGfBmNYE3XsP2FUQmbmQ3E8lq0cFmm3NkLxuuTXGnpH3
         AUww==
X-Forwarded-Encrypted: i=1; AJvYcCVF1gay2TSbCeB62BBsZHvwfPIcIMGCisJvu0SCJ42F7ciQ7EdxbcZtIVigIGAQkiKiTGkawa4YnxZxgNzYpHtKqAh9Cgr/WA5QPcJWYPE3VOiP+IKDU7jogPrxFZyg6ZmNBPpgLjgdjg==
X-Gm-Message-State: AOJu0YxJLBYGa3ijdWFW7QqM3i5hbvhBkIz/U6lK8FkDZW6pXj8O9wfG
	uKUVe9pDDRdAPt08iddUBaYgw3b55FD302TmZ6NtXq7Y5VY49zGKw7wV3L7z09Wg19nbExaUw0B
	EEFwQPM19TWOzEFquPAqD+jc7mw==
X-Google-Smtp-Source: AGHT+IGUrAle9P4qHxoMCji91OCZUobXpE4p22u72lr+1KS5uFziGTL4CUHfyGcnvZ5HbXIna8Gf4ZY4TB2Nr/Umdww=
X-Received: by 2002:a05:6512:3194:b0:52e:717c:d8d2 with SMTP id
 2adb3069b0e04-52e8273f721mr6424076e87.63.1719962231685; Tue, 02 Jul 2024
 16:17:11 -0700 (PDT)
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
 <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org>
In-Reply-To: <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Wed, 3 Jul 2024 01:16:34 +0200
Message-ID: <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Esben Haabendal <esben@geanix.com>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 07:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 7/1/24 6:08 PM, Erez wrote:
> > On Mon, 1 Jul 2024 at 12:15, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >>
> >>
> >>
> >> On 7/1/24 10:46 AM, Erez wrote:
> >>> When using mx25l12805d, we do not read SFDP.
> >>> As it uses the no-SFDP flags.
> >>> When using mx25l12833f hardware with mx25l12805d driver, it did not
> >>> try to read the SFDP.
> >>> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
> >>> driver fetch the SFDP.
> >>>
> >>> Secondly SFDP does not contain OTP information.
> >>>
> >>> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> >>> While mx25l12833f has two OTP regions of 512 KiB.
> >>>
> >>> How do we handle it?
> >>
> >> You would first try to parse SFDP and initialize the flash based on
> >> SFDP. If there's no SFDP then you fallback to the flags declared at
> >> flash declaration. Esben had a try recently, see [1]. I don't know if
> >> there's any progress in that direction.
> >>
> >> Also, you haven't mentioned anything about the testing. Do you have the
> >> flash?
> >>
> >> [1]
> >> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/
> >
> > Looking at "mtd: spi-nor: macronix: workaround for device id re-use"
> > I guess it can be applied to all Macronix devices.
>
> No, no, we're going to do it individually just where it's needed.
> Issuing unsupported commands is not that great.

Would be nice if we could ask Macronix directly.

Looking on their web site and reading some spec. and status reports.
Using the IDs with  'no_sfdp_flags' in drivers/mtd/spi-nor/macronix.c
I did not search for new chips reusing IDs of chips at end of life.
But we found 3 already:
MX25U51245G appears in the table with the same ID as MX66U51235F.
Esben Haabendal found MX25L3233F which reuses  MX25L3205D ID.
And I found MX25L12833F reuses MX25L12805D ID.
Chips that are not in end of life do support SFDP, at least the new
versions of the chips according to their spec.
It seems quite systematic.

By the way, the chip MX25L2005A part number is 'MX25L2005' without the 'A'.

We can support Macronix chips that are not in the table, just by
reading the SFDP.
In that case we can name them like "mx-szNN".

The table below uses fixed width characters.

ID      Part.         Size              Status          SFDP status
according to spec.
                                                        New chip with
SFDP for EOL
c22012  MX25L2005(A)  SZ_256K =  2Mb    EOL             MX25L2006E
c22532  MX25U2033E    SZ_256K =  2Mb    EOL
c22013  MX25L4005A    SZ_512K =  4Mb    EOL
c22533  MX25U4035     SZ_512K =  4Mb    EOL
c22534  MX25U8035     SZ_1M   =  8Mb    EOL
c22016  MX25L3205D    SZ_4M   =  32Mb   EOL             MX25L3233F
c29e16  MX25L3255E    SZ_4M   =  32Mb   EOL
c22017  MX25L6405D    SZ_8M   =  64Mb   EOL
c22018  MX25L12805D   SZ_16M  =  128Mb  EOL             MX25L12833F
c22538  MX25U12835F   SZ_16M  =  128Mb  EOL
c2253a  MX66U51235F   SZ_64M  =  512Mb  EOL             MX25U51245G
c22010  MX25L512E     SZ_64K  =  512Kb  NO_REC          Have-SFDP!
c22015  MX25L1606E    SZ_2M   =  16Mb   NO_REC          Have-SFDP!
c22536  MX25U3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
c22816  MX25R3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
c22537  MX25U6435F    SZ_8M   =  64Mb   NO_REC          Have-SFDP!
c22019  MX25L25635E   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
c22539  MX25U25635F   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
c2201a  MX66L51235F   SZ_64M  =  512Mb  NO_REC          Have-SFDP!
c2261b  MX66L1G55G    SZ_128M =  1Gb    NO_REC          Spec. is not public
c22314  MX25V8035F    SZ_1M   =  8Mb    PROD            Have-SFDP!
c22815  MX25R1635F    SZ_2M   =  16Mb   PROD            Have-SFDP!
c2201b  MX66L1G45G    SZ_128M =  1Gb    PROD            Have-SFDP!
c2253c  MX66U2G45G    SZ_256M =  2Gb    PROD            Have-SFDP!
c2253a  MX25U51245G   SZ_64M  =  512Mb  PROD            Have-SFDP!

EOL     End of Life
PROD    Normal Production
NO_REC  Not recommend for new design


Erez





>
> > Adding something like the following in macronix_nor_default_init():
> >
> > if (info>no_sfdp_flags)
> >     info>no_sfdp_flags |= SPI_NOR_TRY_SFDP
> >
> > It seems Macronix did many reuse of IDs.
> > I saw it with "mx25l12833f" reusing "mx25l12805d".
> > And Esben saw it with MX25L3233F reusing "MX25L3205D".
> >
> > The only thing I notice is the flash using the same size.
> > A sort of "backward" compatible.
> >
> > Erez


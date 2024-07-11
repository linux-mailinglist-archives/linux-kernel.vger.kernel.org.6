Return-Path: <linux-kernel+bounces-249744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF192EF40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487031F223E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2E16EB5B;
	Thu, 11 Jul 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNlLmHTl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A874297;
	Thu, 11 Jul 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724317; cv=none; b=JRSBfAQUQzewUNnmJ+n+3hPP1o+0IeUWWpsWtRxThebFg0snYaSkMjfu4xOx3QVR2QHRuC20V2dIkf+ie6zAzLCMY//yOrp6De2+DVZ/SVG1SR55qWlc0EuuGZLx3ymZks+lYkO5boWzu64aFhwj6m0IILV3kSDxfKMq6KyyUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724317; c=relaxed/simple;
	bh=lTJyaO3NRh1SLmZ3yrTny929BvkSro0S61px1Myed5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhoLmtn+JLIdGafX01OiH2g+6GohaDjYOgPi3DDvg8uzAtd0jqRRAJR+8UQ1/Oz3F+g6nM+3fFBH122Gt15rpm2fZpppYYF8rQB2S6StgcPC+oLNnJORMizGVXRuzPk5b8Zkvlsaq3mrrJXaMrsWNSU0Y7wTbgQnUq3LUsOHQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNlLmHTl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so1603651a12.2;
        Thu, 11 Jul 2024 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720724314; x=1721329114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7BPXidIi57y7av2TEkb5R0zgpsgd6KdF8/DSPaJwaQ8=;
        b=hNlLmHTl5r+v24odrwNK2Oug2conLzA6Y9/P2HbintnfFj6UeQvo8daqZfW6MWN2bD
         RWzrtoNinKMB1ozayr0Tut0pJ2/w9tih+cfdpU/JIugJr+hEPIsa14z7cDTh6ZJGliii
         cvWhUPrY40gFbcuwctUUBRSuuuC2Pxkw2+OkiwYekE0GQFkmJoLCvFUzk/A58KVd8O3s
         BvlwcaTNtHXxZ6GC6Yuk8b6O+TTq0IL/V913mMm9vpyHETEGjvw96GTaiOdj2UW6xp5q
         81czuC7FfkVsmIwTSzf8pQ3vDK+wZmWXz7jr7xBAxKG5BmA0kCITJF7ypS3I+4lGl1Tg
         rkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720724314; x=1721329114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BPXidIi57y7av2TEkb5R0zgpsgd6KdF8/DSPaJwaQ8=;
        b=RHibCS5Qe0jUhd0rNh6yIflYhbRadyFF0pq4CwWp3asZBdqLn2IvO5yGZaSjiozRFb
         0O7LVgwyLT8iKCwrmNQ5+ASBDitdNhIiGpotM+FB1+zYPxSsKbo25TQTyXt4Lfq4kRNR
         9wNrrj/aWU5CieZ8CCvJ3nq1TCD+3U1mrxLANULd6QiM72PKlSsrnTmMin20GcDr2eYO
         cl4qVDZP2Bo95mrZwiRIB1JjIL5tI5iaWUKQmMVmIp3HvtrmtOtxxvXqV482fGXeOUeH
         d0UDZKbdBKaabsymeLJLfZqyahngnaEYUBdUnCSNQ1tkllTIooKMHRdZTQy4r/yI3eE4
         JvUw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Rg1f1g1RETKaBGvQ+1xkcfs3x2Lp+6E1qJQBB46A3X4vKGoTghFyZN3RFZzNYx0JtJIAeM8M4DRNJRTbEjOQoT5+KBRSu68G9Gt3FtXOqoVW26JGDhw2rpMLVS8u7RVbSczWkAgOOQ==
X-Gm-Message-State: AOJu0YzujKXwV+tzk0gp0k4Ypkr4kSX86vvR5kEKa6HycPlzZ7ZOe6TA
	ULAikUYY1f7Eem+hzuZT1MLJUfzINHPUPqjBdKXw7BXVP5LuQEMULwjlEIYqhdWZdEkGuT2pBgI
	weuBqE3AOixO3AMei6I+1NHQvKA==
X-Google-Smtp-Source: AGHT+IHUue7KlCkosbibWLlrwqSbPA31mFvvX7MrL47CNXsBcvVqQiOnEkanbSXVw3FeHULhCh5GuIhNrpSRu3Msg64=
X-Received: by 2002:a05:6402:34d5:b0:57c:a49f:ddd4 with SMTP id
 4fb4d7f45d1cf-594b9ee10d4mr6979931a12.17.1720724313998; Thu, 11 Jul 2024
 11:58:33 -0700 (PDT)
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
 <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org> <CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
 <875xtd48ps.fsf@geanix.com>
In-Reply-To: <875xtd48ps.fsf@geanix.com>
From: Erez <erezgeva2@gmail.com>
Date: Thu, 11 Jul 2024 20:57:57 +0200
Message-ID: <CANeKEMNJ3_ET5pQo2wg7_GSLX+vE+dqW-CV=v2DnG10xcgSdzQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Esben Haabendal <esben@geanix.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Jaime Liao <jaimeliao@mxic.com.tw>, leoyu@mxic.com.tw, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, Julien Su <juliensu@mxic.com.tw>, 
	Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Yes, I think we should.

Reading the specification provided publicly by Macronix.
For all the JEDEC IDs with the no SFDP flag in drivers/mtd/spi-nor/macronix.c
All of them have a new version or a new chip with the same JEDEC ID
that supports SFDP.
There are 2 chips that Macronix does not provide spec. in public.
I can ask Macronix technical support on these 2 chips.

Erez

"RDID"    "Part."         "Size"              "Status"          "SFDP
status according to spec. or new chip replacing with same RDID and
SFDP supported according to spec."
c22012  MX25L2005(A)  SZ_256K =  2Mb    EOL             MX25L2006E
c22013  MX25L4005A    SZ_512K =  4Mb    EOL             MX25L4006E
c22533  MX25U4035     SZ_512K =  4Mb    EOL             MX25U4033E
c22534  MX25U8035     SZ_1M   =  8Mb    EOL             MX25U8033E
c22016  MX25L3205D    SZ_4M   =  32Mb   EOL             MX25L3233F
c22017  MX25L6405D    SZ_8M   =  64Mb   EOL             MX25L6406E / MX25L6433F
c22018  MX25L12805D   SZ_16M  =  128Mb  EOL             MX25L12833F
c22538  MX25U12835F   SZ_16M  =  128Mb  EOL             MX25U12832F
c2253a  MX66U51235F   SZ_64M  =  512Mb  EOL             MX25U51245G
c22532  MX25U2033E    SZ_256K =  2Mb    EOL             Have-SFDP!
c22010  MX25L512E     SZ_64K  =  512Kb  NO_REC          Have-SFDP!
c22015  MX25L1606E    SZ_2M   =  16Mb   NO_REC          Have-SFDP!
c22536  MX25U3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
c22816  MX25R3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
c22537  MX25U6435F    SZ_8M   =  64Mb   NO_REC          Have-SFDP!
c22019  MX25L25635E   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
c22539  MX25U25635F   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
c2201a  MX66L51235F   SZ_64M  =  512Mb  NO_REC          Have-SFDP!
c2253a  MX25U51245G   SZ_64M  =  512Mb  PROD            Have-SFDP!
c22314  MX25V8035F    SZ_1M   =  8Mb    PROD            Have-SFDP!
c22815  MX25R1635F    SZ_2M   =  16Mb   PROD            Have-SFDP!
c2201b  MX66L1G45G    SZ_128M =  1Gb    PROD            Have-SFDP!
c2253c  MX66U2G45G    SZ_256M =  2Gb    PROD            Have-SFDP!
c2261b  MX66L1G55G    SZ_128M =  1Gb    NO_REC          Spec. is not public
c29e16  MX25L3255E    SZ_4M   =  32Mb   PROD            Spec. is not public

EOL     End of Life
PROD    Production
NO_REC  Not recommend


On Wed, 10 Jul 2024 at 16:34, Esben Haabendal <esben@geanix.com> wrote:
>
> Erez <erezgeva2@gmail.com> writes:
>
> > On Wed, 3 Jul 2024 at 09:12, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >> On 7/3/24 12:16 AM, Erez wrote:
> >>> On Tue, 2 Jul 2024 at 07:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >>>
> >>> The table below uses fixed width characters.
> >>>
> >>> ID      Part.         Size              Status          SFDP status
> >>> according to spec.
> >>>                                                         New chip with
> >>> SFDP for EOL
> >>> c22012  MX25L2005(A)  SZ_256K =  2Mb    EOL             MX25L2006E
> >>> c22532  MX25U2033E    SZ_256K =  2Mb    EOL
> >>> c22013  MX25L4005A    SZ_512K =  4Mb    EOL
> >>> c22533  MX25U4035     SZ_512K =  4Mb    EOL
> >>> c22534  MX25U8035     SZ_1M   =  8Mb    EOL
> >>> c22016  MX25L3205D    SZ_4M   =  32Mb   EOL             MX25L3233F
> >>> c29e16  MX25L3255E    SZ_4M   =  32Mb   EOL
> >>> c22017  MX25L6405D    SZ_8M   =  64Mb   EOL
> >>> c22018  MX25L12805D   SZ_16M  =  128Mb  EOL             MX25L12833F
> >>> c22538  MX25U12835F   SZ_16M  =  128Mb  EOL
> >>> c2253a  MX66U51235F   SZ_64M  =  512Mb  EOL             MX25U51245G
> >>> c22010  MX25L512E     SZ_64K  =  512Kb  NO_REC          Have-SFDP!
> >>> c22015  MX25L1606E    SZ_2M   =  16Mb   NO_REC          Have-SFDP!
> >>> c22536  MX25U3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
> >>> c22816  MX25R3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
> >>> c22537  MX25U6435F    SZ_8M   =  64Mb   NO_REC          Have-SFDP!
> >>> c22019  MX25L25635E   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
> >>> c22539  MX25U25635F   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
> >>> c2201a  MX66L51235F   SZ_64M  =  512Mb  NO_REC          Have-SFDP!
> >>> c2261b  MX66L1G55G    SZ_128M =  1Gb    NO_REC          Spec. is not public
> >>> c22314  MX25V8035F    SZ_1M   =  8Mb    PROD            Have-SFDP!
> >>> c22815  MX25R1635F    SZ_2M   =  16Mb   PROD            Have-SFDP!
> >>> c2201b  MX66L1G45G    SZ_128M =  1Gb    PROD            Have-SFDP!
> >>> c2253c  MX66U2G45G    SZ_256M =  2Gb    PROD            Have-SFDP!
> >>> c2253a  MX25U51245G   SZ_64M  =  512Mb  PROD            Have-SFDP!
> >>>
> >>> EOL     End of Life
> >>> PROD    Normal Production
> >>> NO_REC  Not recommend for new design
> >>>
> >>>
> >>
> >> not sure what you want me to do with these.
> >
> > That we can read SFDP for all chips from Macronix.
> > Only old chips before 2010 do not have SFDP.
>
> So, should we try and identify new chips (with SFDP) that re-use the ID of all the
> above mentioned EOL chips that does not have SFDP?
>
> As I read the communication from Macronix, then we should expect new
> chips re-using the ID for all of them. It is just a matter of digging.
>
> /Esben


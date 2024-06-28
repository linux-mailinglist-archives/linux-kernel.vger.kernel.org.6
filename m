Return-Path: <linux-kernel+bounces-234286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9691C4AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C370B21FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656F51CF3CB;
	Fri, 28 Jun 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMS1qgSC"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946A1CF3C4;
	Fri, 28 Jun 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595103; cv=none; b=HMxy9zTgv88AtvJirQNztIyKsMWKb6QL5LCwBr00SPjseZg70Hn2bU+tj342ajE1YQkUWhHB9TdVLUHtM+moAzJG2YnURIbzfvPilMzbTAn79rHpsIUTpxbFU2QtuvUdFCaZA5ssuKrxOYUswYy7cJ2h6gHq1/UuOKlATm7OfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595103; c=relaxed/simple;
	bh=0kDYpLaDUluAMzQIp88EZDW06QTvh4nYNM1WCMKD7L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNPrnq9aZzcHbns2KDHRwqgUHdkna2Rs+xFYU9nWliF/0F7zx2OSw0ktRBrN8zKjO1/prOwBKnqFD3VRr8TYS34oGC7xst2iP471UtAke9d4gwdReMxNHodsKZouAxHW1EAXca2uTGl4+sgNKHMfnTOVUoeURb0FA20tAG6AOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMS1qgSC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a724a8097deso105385366b.1;
        Fri, 28 Jun 2024 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719595100; x=1720199900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o3nvsIkFRTprl2veHnwGjNIAA2Gwnu2oo8W5vdGeBr8=;
        b=aMS1qgSCsi7K57kBaSo0vpqpIS1t6Sr4afMde5WrWOChVrCEsBEODP8wfLIyjawjg0
         Oz51N2o5TwP1SwkfrZstjkakePHFp08QEYg7CFmLO6AbF3m5bP3scdrGDjvFH3pbNmnC
         oOLCji2c0B7nDiQ0vIy3ZOFvHUumV3PcITIk6SroziclGu8N6iUVHTsuslsBLY6Zfpla
         TjOTlPP7FFlCYXoTLZhiRH0qexbDHlrfWPXe7Q52Bl5KOHzkrePSezdy/K48i9TpxKlA
         AFbXQD6V9GdndhodRNsRYRVg4MDUmzyQV9TmtJzpWlgtnhwN3R0mjUppCP4oiBNk5VPk
         g6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595100; x=1720199900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3nvsIkFRTprl2veHnwGjNIAA2Gwnu2oo8W5vdGeBr8=;
        b=aTFtFif3Ebb7kpSPEcthy7dUNhmXpSrYXyD1kuS9S8jWPYDQLCyNLMoBC1i6d6LhVR
         OFIZcjpzJN3jhFQlPwfDk9G6XQcs5Cj3pvfN1gpvwihA1UViWQueLSJ9APJ0mlyTJmnD
         e4oL5aLdEyIUJ+P3lsUV23tL3FYcKZhzcc0zhHlvKmih/n0BYLrn2q/9vYU2CgYAZGLd
         YQtPGp5+Usc2vWre5xvJjwtzAV2hXdBMjwUL55nbzVHoMYe2PIqCkG7JABLayp5Pup68
         vxzT78CuEa/ddGF6lmP6blBXuHs+Eyl6l8XikgNoxWuMBwVLp3or1/3U/FkBFsN6kb3S
         lF7w==
X-Forwarded-Encrypted: i=1; AJvYcCURoH/A+Cb9gR0oNKHvMbfvbnmPrp0lybQMOMU6AR4Arq5KXSAQS4hhjemtumsAegcs/tkWgnFr8akEUmi8q9paOE9prMKrqJ5jjn5cC/2XggnQad9kqRVzCouxCJj52t9xD2wfCspaHw==
X-Gm-Message-State: AOJu0YxmV02U8mk59B4GK4k2xuSsNQTR906i0CqRX7jHtBkujykQtDJz
	eRgBDEXBn/wLBTZ6KxLyE7nr5gW2aMplKRsJNhe8nDQQsrcwfmXApL4Mq+fn32+VrlOl1lStuH2
	X1NnDQYxHrcFHPkh5/GUb7NX4uw==
X-Google-Smtp-Source: AGHT+IFTZVskAjk2l5yWcH1+gZhoO6yQpm6ONFChSoLYbpKIhZVBVjX6P7gzsYaRUL4jBvTsbM8BFPkV4wxIIQ+MkWQ=
X-Received: by 2002:a17:907:c78e:b0:a6f:bc02:a008 with SMTP id
 a640c23a62f3a-a7242c4de49mr1349695666b.4.1719595100397; Fri, 28 Jun 2024
 10:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628140328.279792-1-erezgeva@nwtime.org> <20240628140328.279792-4-erezgeva@nwtime.org>
 <20240628-refuse-actress-b76985aa020c@spud> <D2BS0YMA48BG.1PEPFC3KMFV8N@kernel.org>
 <CANeKEMMrXK=mw=n=9DuTnprkTs3ct446oaC2QTJyst8Nd+D6rw@mail.gmail.com> <D2BT0DT9UQ66.2L497FSY7GMAL@kernel.org>
In-Reply-To: <D2BT0DT9UQ66.2L497FSY7GMAL@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Fri, 28 Jun 2024 19:17:42 +0200
Message-ID: <CANeKEMO9hBhBs91nZkZRht9J29iRC2Tgf6ucWq=nbO7XAqzzng@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR chip
To: Michael Walle <mwalle@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jun 2024 at 18:51, Michael Walle <mwalle@kernel.org> wrote:
>
> On Fri Jun 28, 2024 at 6:30 PM CEST, Erez wrote:
> > I do not know why they decided to use the same JEDEC ID for two chips.
> > Your guess is as good as mine.
>
> That's a common pattern and we try hard to figure that out during
> probe time instead of hardcoding it. E.g. by looking at the SFDP
> data. Have a look at various fixups in drivers/mtd/spi-nor/.

That's a good approach.
The obsolete mx25l12805d does not support the SFDP table.
The new mx25l12833f does.

What is the kernel policy regarding obsolete flash chips?
Macronix annonce on end of life of mx25l12805d in 2010.
Perhaps we should remove mx25l12805d,
 and leave the mx25l12833f configuration in mtd/spi-nor/macronix.c?

>
> compatibles are really the last resort to distinguish flash devices.

I totally agree. Use JEDEC ID a lot better.
In this case Macronix decided to reuse an obsolete chip ID.

>
> Next time, please mention such information in the commit message,
> please.

Thanks for the tip.
I did write it in the fourth patch, but I can add it in part 3 as well.

> Also please have a look at
> https://docs.kernel.org/driver-api/mtd/spi-nor.html

The new mx25l12833f supports SFDP, the obsolete mx25l12805d does not.
I did manage to read the SFDP, though I do not have a copy of it (I do
not have the hardware any more).
To my best knowledge SFDP table do not contain information on OTP,

Thanks
  Erez Geva

>
> -michael


Return-Path: <linux-kernel+bounces-236716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE66291E63D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182761C21466
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA116E868;
	Mon,  1 Jul 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC7OWLYS"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529E16C697;
	Mon,  1 Jul 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853779; cv=none; b=utccVIDYc3AXgMwGFZPigx7SMvd7Hobfp7SycOV+kahnQeqdGeOW8vGmLdWsOtnQflZmGWhum4S1mU58FHGOcgWF4F9Z/egMZU0tRj317rkAVI8vWfr+T9C1kjpaeYxNmvDAptAWKXsDiXVCttLMAgOKA4tw/Zqkufv28V5tUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853779; c=relaxed/simple;
	bh=gVhmfdnxbOOPgeFRaCg9Ymh4Zpg0f7AXBtcggt+t08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdMWfm3u5Eey55a/8fhEY2bNuNNFT3AEF/ytekaZK808gY8oXJduRjwIbC5O7exR3/k769DftVUFzUXTzIp9vIh6mm2I5Wtky0XdEzh1ogYIthIJSuOGOBGFA4MrXi41z6zaWYkLTSxMSHeB2xYAJYbLT0U1OLopbQlWJAhwOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC7OWLYS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso4696941e87.1;
        Mon, 01 Jul 2024 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719853776; x=1720458576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2AvaZ/UqlvKRYfAtV7P9vybf13O6HOVkfDtPt1cvUk=;
        b=ZC7OWLYS4TtFg73E4SuJ5mjHxOlo8/FFhf8FcgIqXFZyMVvufjpCT2zhyYLHF/fHoq
         4Mz7hI+NioDVC4Bvnrl7/2aTloAHrkLwQnb3oHFIeiuDjYy9Gi5pjaXFJcZmcmsmXaeV
         UxwHchAsSCdeNRzH2dRTgH3Umcv9ylH0cf+2Obs8YZC6bNc2al4S5qngi4sL870Lym0w
         EEe8JiSY+47fagUZaTxXwd0cd3fLWriRTeySE7DJMcEWMC5lPXArTZEnZpJ8QnTdbJWu
         eZf04YiNw8MRHinqo1/rY6+Se3Z0gZbmseoNqEk2MuYj7WE9kF3C6dpq5PcxSWI00aXa
         JWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719853776; x=1720458576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2AvaZ/UqlvKRYfAtV7P9vybf13O6HOVkfDtPt1cvUk=;
        b=oAaoHDid+9zVzjQSZjLrGi4w+tIyC2/f0FFBxaRBgceiKXFivVDojEs8PznnAjOcq+
         r+KkGxlY8grwCNsqTyzBuDqeZp2kBgIsBk04z5to8CcU1JzZk7vVBWYb6Fv9775xyXdH
         tfYN07F57ChcvxTr7c6/themttXanDAn04nB9IxD+JN1Do/ouJbRegPiEubBbHD3HGq3
         p2HwhQBm6OL+3aZpguOEBvvtLhOfaGxpXUpJgWqbOaCX9Mxh82Ok/XExTGa2EDaFiLx0
         +5Rjqs+s0o65Ne3C8s1Xe94amid8TwxdPRupDJeUtyVOhQyWsKWJMAZg2RKxGvMLIyFj
         b+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUnm2Gc5jgU8oeQRFIA8og1zI3EY/lh6ktKTRuMipW20ATbULFcFsW9NgA/UwK7Y1YAsPatgucLsMzQ3O/38OP7+CQV+ha8D1kGaBKW6QFHpsIFGkEl2IcDLkTijdeRb5USBVFYG+XnPQ==
X-Gm-Message-State: AOJu0YzSVcsiXl5uTmaiN3FgqTidAEGfexpnVgtV7DuKcbFiNxLFrMhZ
	EboFItOI5+2u25zsXjT12YloI6GmJ7q09cE020IP8mM2ZXkzH+Kl9QpqP1VRgBODA/1zJlyF+/F
	kizHSf/qUee0Him+02aeIFkjhHQ==
X-Google-Smtp-Source: AGHT+IGYYNCj47g6ucYfUx88jylfxwmzthcbBunBR6FSqs2Zy9xB27gXOmjZv5e2f+ERX7Yl2NsAnugoE22lg1LI1Pg=
X-Received: by 2002:a05:6512:3b12:b0:52c:e17c:3753 with SMTP id
 2adb3069b0e04-52e82647353mr4096272e87.5.1719853775769; Mon, 01 Jul 2024
 10:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com> <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
In-Reply-To: <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 1 Jul 2024 19:08:57 +0200
Message-ID: <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Esben Haabendal <esben@geanix.com>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 12:15, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 7/1/24 10:46 AM, Erez wrote:
> > When using mx25l12805d, we do not read SFDP.
> > As it uses the no-SFDP flags.
> > When using mx25l12833f hardware with mx25l12805d driver, it did not
> > try to read the SFDP.
> > Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
> > driver fetch the SFDP.
> >
> > Secondly SFDP does not contain OTP information.
> >
> > mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> > While mx25l12833f has two OTP regions of 512 KiB.
> >
> > How do we handle it?
>
> You would first try to parse SFDP and initialize the flash based on
> SFDP. If there's no SFDP then you fallback to the flags declared at
> flash declaration. Esben had a try recently, see [1]. I don't know if
> there's any progress in that direction.
>
> Also, you haven't mentioned anything about the testing. Do you have the
> flash?
>
> [1]
> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/

Looking at "mtd: spi-nor: macronix: workaround for device id re-use"
I guess it can be applied to all Macronix devices.
Adding something like the following in macronix_nor_default_init():

if (info>no_sfdp_flags)
    info>no_sfdp_flags |= SPI_NOR_TRY_SFDP

It seems Macronix did many reuse of IDs.
I saw it with "mx25l12833f" reusing "mx25l12805d".
And Esben saw it with MX25L3233F reusing "MX25L3205D".

The only thing I notice is the flash using the same size.
A sort of "backward" compatible.

Erez


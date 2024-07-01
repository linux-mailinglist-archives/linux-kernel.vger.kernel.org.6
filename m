Return-Path: <linux-kernel+bounces-236617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6091E503
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7251B24A51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE4016D4E4;
	Mon,  1 Jul 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf71lCm7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073C16B750;
	Mon,  1 Jul 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850404; cv=none; b=kQvTM1gLNpckakuT5PbU6CWLDxXNA2J0CWd7L+QEHTVfaHfpEp9vO0WDlL2t1XWrGyeVg2DfyWD5vuwjN/Osd6joPb1pCtW8XHLks93M+YpEaS4cNYalXNKylsHMKsIIX8j4SqF7Ssiyl21rml67NVOA9hqQ+HMkEbzRv2iUcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850404; c=relaxed/simple;
	bh=h63ASooyLFfbDlZsGzT129A1uG/AXvxQbsFrU615LaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQg2dQaPSI8+OKNVX0/+53c8QrEzM/ZkmoxLFFx9KzEvxgsJYxyxBI21MhBYGesT+ZDFgJYP+u1RxNjTTxjyiWe1E3deAIKFOVM0WYWrza96jS6z4pGMbq4f0X26y+UOOlg0wtlyCmpDEfcDioHtQ63Bre3mjXt+B+gJ+z4t9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf71lCm7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so110934a12.2;
        Mon, 01 Jul 2024 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850401; x=1720455201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJORc4y41njo2myTxYBaIZoGdagWJX2FVE52D6Y2Z1U=;
        b=Zf71lCm7xwUi0HP3suy38jHWX8f1EqgI9bRQa6x4ckgRBOHKxX5kfm/rvFyFmAkE5P
         aM3NICNJaScP5Ne8Nafj59xMDfpMP8VzcqxxIT0X/laWGBzcsvnNYE1/W20wQS5nnX/A
         wpnRB8lQO6WMlAy50MjldsQytIB2PhINCZ7cZjnPbxLUAfXtsbmKtgn5GtRtfhVfONLm
         F+10qWYirISjRuOsQJkFKdRK8XMaU/myXB+0kVnM5IwvddLWoC2E9j3Vt6vdC5lrkDmW
         CDXy3NxEYGi2UtfO6T7q9Vi7U5XA+Jm0Ow+p0QsCI0OtRa4Df+20ggQ1W+7pvUy18kTL
         /IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850401; x=1720455201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJORc4y41njo2myTxYBaIZoGdagWJX2FVE52D6Y2Z1U=;
        b=ZcSbck2AizStD7nxnjQ6J3l+JdprAROYEyoNEwNghK7tni+UbS5h4JM1HgnB2bf/Pb
         GCZz1km5DHx/DENZCMy9SGLizRmOyQq4NrCPCzJbYVbuMxz8J0vhWjHtl8V7NkhFhXvP
         CtEpGYg4vTlnI/33IQX28OgbKxFP4riOUEks8Z7cwR+YupNZmguZYTXpI1g3w6hiypNU
         qQBVXqzlwklOnkmjPtodvamlvQffGKqYXbMQk3Y4kLpnhFTKj/avRG0kdLFoGhgBHhzD
         YbD53eKCENLeKYM8aRTz6Iv2Ct9aNIrrWj9YJIu2//dPoFERLZ29681Pk+xNcCDLyIV3
         ysUw==
X-Forwarded-Encrypted: i=1; AJvYcCWEkM14h4TfD9Scjm8NapXqhVFI+qqwNaQl4WKo/gYzqPyRCY6m0U4KQbg3BcgADq2R+ak3w6PmKzf1Qbagj3ITDI3/Djx5s1rKWQHqJq/gFd4qnp89Pbj0p+Sa9SiZg01xqU2kNKEVkA==
X-Gm-Message-State: AOJu0YwZMKSEGoniy7hqjXxLxIJD/pYS0o0Kj6TBqT2HnG1wT7N5KyZ+
	NLVoEk0A0K6xcgWr6O1pK7Y1qg5JhyzNV6uWgGL8SweKbR5kfaUAHtglZkjWUMURpII8gjWxCBZ
	ApYB67nQ7nTzt90LLZCDZg1MY1w==
X-Google-Smtp-Source: AGHT+IGhN32U3cLFjDcl/ZaK+BN5oNiVFeatcJG7osJjACBaeXKS643lckiY3fxmVC9Kln5Tlpu49ktmbd8AO6QKvjs=
X-Received: by 2002:a17:906:a091:b0:a6f:49eb:31a5 with SMTP id
 a640c23a62f3a-a75144b67a4mr312328166b.77.1719850400469; Mon, 01 Jul 2024
 09:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org> <04f5162d-8a95-45ce-a891-3f711b27a469@linaro.org>
 <CANeKEMPAng8K1Gbab-MXP0KodS=r1Bzstsvg4zadWdu1O7wqWg@mail.gmail.com> <be8daf89-14a9-41ad-9403-8e550e5ae284@linaro.org>
In-Reply-To: <be8daf89-14a9-41ad-9403-8e550e5ae284@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 1 Jul 2024 18:12:42 +0200
Message-ID: <CANeKEMMA5L4pu7Vyyv0wU7VcEYK6q2Tk8p4BKPe5E5qXdHzWZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Esben Haabendal <esben@geanix.com>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 14:53, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 7/1/24 12:03 PM, Erez wrote:
> > On Mon, 1 Jul 2024 at 12:23, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >>
> >>
> >>
> >> On 7/1/24 11:15 AM, Tudor Ambarus wrote:
> >>>
> >>>
> >>> On 7/1/24 10:46 AM, Erez wrote:
> >>>> When using mx25l12805d, we do not read SFDP.
> >>>> As it uses the no-SFDP flags.
> >>>> When using mx25l12833f hardware with mx25l12805d driver, it did not
> >>>> try to read the SFDP.
> >>>> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
> >>>> driver fetch the SFDP.
> >>>>
> >>>> Secondly SFDP does not contain OTP information.
> >>>>
> >>>> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> >>>> While mx25l12833f has two OTP regions of 512 KiB.
> >>>>
> >>>> How do we handle it?
> >>>
> >>> You would first try to parse SFDP and initialize the flash based on
> >>> SFDP. If there's no SFDP then you fallback to the flags declared at
> >>> flash declaration. Esben had a try recently, see [1]. I don't know if
> >>> there's any progress in that direction.
> >>>
> >>
> >> And you can then decide which OTP org to use based on whether SFDP is
> >> present or not.
> >
> > That can work, but sound like a hack.
>
> It's not a hack, we're just doing our best to dynamically identify the
> flash.

Call it whatever you want.

>
> > Is that really that important to hack?
>
> we push really hard against new compatibles. Users shouldn't care about
> what SPI NOR flash is there.

I am in. I do not like compatibility.
I do not like to see them in the device tree.
I did not create the mess.
It seems like Macronix likes to reuse JEDEC IDs.
As most new chips have SPDF, the mess is with OTP mainly.
We can think about a different model.
Perhaps allow the user to define the OTP size and number of regions
using a 'flash_otp_set' tool?
I am open to ideas.

>
> > Just for OTP, that very few use?
> > And if in the future Macronix adds a newer one with the same JEDEC ID,
> > but a different OTP size?
>
> we'll compare SFDP data and choose based on the differences. This is not
> encouraged. Instead ask for unique IDs or choose other flash.

That requires additional callback in the SFDP, not a big challenge.
Yet most SFDP tables are not sufficient to determine OTP.
Found only one table with OTP support flag.
No size, offset  and number of regions to work with.
The only hint is do we have SFDP or not.

>
> > Macronix does not consult with the Linux Kernel on these matters.
> >
>
> I'm complaining about unique flash IDs for years now. Hopefully vendors
> have learnt their lesson. I didn't see new flash designs reusing old IDs.

I can not speak in Macronix's name.
I know they did that, not sure if they stop.

>
> > Anyhow as I do not have the hardware anymore, I can not do more
> > changes and test them.
> >
>
> Be aware that we're not queuing patches without some minimal tests. If
> you don't have the hardware, contact mchp and see if they care,
> otherwise we're wasting our time. Here are the minimum testing requirements:
> https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements
> For OTP we'll also need some OTP tests.

OTP as its name can be written once.
So a simple OTP test would be nice.

Anyhow I ordered 3 Macronix's MX25L3233F that have OTP.
The OTP works the same as the other Macronix chips.
The MX25L3233F ID is 0xc22016 same as "mx25l3205d".
Seems Macronix are persistent on reusing IDs.
First revision of MX25L3233F was in 2015,

I will connect to my old BeagleBone-black.
I think I can perform the test with it.

As I say, I am more interested in testing the code.
Less on which Macronix chip we use.

Thanks for your time
 Erez

>
> Cheers,
> ta


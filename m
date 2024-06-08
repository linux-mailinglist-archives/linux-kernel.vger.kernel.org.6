Return-Path: <linux-kernel+bounces-207040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A0C9011A1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F3B1F21DEB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F63178389;
	Sat,  8 Jun 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpxOZDdu"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EF51C58;
	Sat,  8 Jun 2024 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851988; cv=none; b=UrgRMAogu+TekwNBbGOl2r3DU19u18/oA0uukzVtMkD4U3m81+O1UZQDTwB7JMWcM/xSHcXPX4pGr7a/hga921w1pPb1oPt30JbaSMTHtCMA8AvAI69x44iifTPUobHhaez1ZBcBEBQsS6YJzAm4ndC2srF4T49pezV51w8twp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851988; c=relaxed/simple;
	bh=TN1kvEEdJ2M+pRZTCJq7ONE6ALZCSV4Z6Y2gPgnZ9wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bICEMQQG/sR3hsbu2xTCr6JVXPSyPaxDgswuXJ182UfSFT3v0385JCDm6jlVeflRBJwnM6svKcdmcZ7k7gr4UlGhVckSP0r5ml3KEn3QZf34c2rM8NuvoQOQVuvEqQo1XH5IfW0wpKFYS7/LuoQuC9ZCQSsaiu+gCXjet1QmpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpxOZDdu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6c7ae658d0so396873566b.0;
        Sat, 08 Jun 2024 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717851985; x=1718456785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg42zl8j5H1xPlsMsZHdu4pMnpo878RX+aj3VIRhFdk=;
        b=YpxOZDduj7TEBcKFxWfnP6Q9tup0vuue1H3f48GgOaA53LnoYdS/hq21whTvZhQy6L
         upzSUORLUSVnx0YilAA2mMF5PavyYEZ1j2fNvoKvEa5hCE6tUMWhKaplrpWFKhgGP45z
         WwuRcRhNO68vCaNRK+H5p5qTkTodkJi7XuYAnxGtVCN2spIRqHfOu8mzreVD1Uz8UCqU
         utlvjo5vV2VRh/Dn8pBGkglA4OgmhtTvH7pZek6hkY+pJRXD/nC7jBlqlXLyjIEUGFK/
         avTHUTbAKFZVwJtvHOnGCxMJyFXJYA6I6RjmcK9/TWlU1kqJcKzMjxyX7GegSLoi+aXx
         782Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717851985; x=1718456785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg42zl8j5H1xPlsMsZHdu4pMnpo878RX+aj3VIRhFdk=;
        b=OyWF2NDztqn4j+T9hwAes87ZpOWCfZEE1O9lcL2Z4CeRDSuniX3iLTGUnfuaBowXuJ
         KxZqoigKFt3cut0v0Xxkp+DM1VhP1J+QNC2KsrZBY5v5QjpHM2cGgwOPyFjtJty+1tEY
         DW2Yr/pfLJIWAYoknveno3mvH7zpMz0RMi/6Cr+pREBOvvSFqAKJyu88PU2+pp2GfZlv
         pShe+ZG4AuQLS+hcpgysJf7i875N0BWisOFcPd/ElaOpVlmRtMhdoSwGJKsSk3fds6bB
         V4bLrcvI/iYxKjz6E7p8681GXDWTkgJqR2jftsJskF5+sQoufZBBBSUuho1fOwXBSS5U
         elrg==
X-Forwarded-Encrypted: i=1; AJvYcCXSJxnIBmknRvvHbNP1xK55T3/0Lyp9wAvt3ypd0F7dmx0/TOo5oql3p5AX7+rgVYvvL25u2Dx8iscr1xMv4gbMxZsG3TIr+WcvWhTD2OJyc9XJS1ID1qJoHoMo5UKbZVkHLIEZk5YLvQ==
X-Gm-Message-State: AOJu0Yw+JO6Flo9CHp3N4UEZnt2uunYAnB9quremPhTQ4y9RBw+T1Mwx
	kTk1igEg6/tUZe9JhuTt5XNbLPqJvXM5qrmPB2mJNK06URkkxZWYjNCwMA==
X-Google-Smtp-Source: AGHT+IFrAogwWNzpxUM/BWq9US8mV8muU86UEZhjxI2YrpsztyuxmSZBwcqmfveCX2Sfr/7iSPoFtA==
X-Received: by 2002:a17:906:a08e:b0:a68:b73d:30d0 with SMTP id a640c23a62f3a-a6cd560fa28mr446001566b.6.1717851984457;
        Sat, 08 Jun 2024 06:06:24 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6e8803d1aasm195548066b.197.2024.06.08.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 06:06:24 -0700 (PDT)
Date: Sat, 8 Jun 2024 15:06:22 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
Message-ID: <ZmRXTgPxrGZIYjQa@standask-GA-A55M-S2HP>
References: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>

Hi Artur,

thanks for the patches! Some notes below.

On Wed, Jun 05, 2024 at 08:40:11AM +0200, Artur Weber wrote:
> The BCM21664 and BCM23550 are nearly identical to each other in terms
> of register layout. This was verified against a downstream kernel[1] -
> Broadcom's kernel has "RDB" directories which includes headers with
> the full register maps for the included hardware. Running:
> 
>   diff --recursive arch/arm/mach-{hawaii,java}/include/mach/rdb
> 
> reveals that the differences are minuscule - some things related to
> ISP and H264 decoding. Most of the other differences are related to
> the different CPUs in the two chipsets - the BCM21664 has 2x Cortex-A9
> cores, and the BCM23550 has 4x Cortex-A7 cores.
> 
> In mainline, most drivers are also re-used between the two.
> 
> To make development for both platforms easier, split out the common
> nodes into a separate DTSI, bcm21664-common.dtsi. This only leaves
> the device-specific nodes - so, CPU and related things - in the SoC-
> specific DTSIs (bcm21664.dtsi and bcm23550.dtsi).

The name "bcm21664-common" makes me think that it's a DTSI for common
properties of multiple BCM21664 *board* DTs, which is obviously not the
case here. IMO something like "bcm21664-bcm23550-common" makes more sense here.

> 
> The new DTSI is based off the bcm23550.dtsi, with its split into
> busses. Since it's pretty much 99% identical, I kept the licensing
> of the original file (BSD 3-clause). The license for the bcm21664.dtsi
> file remains GPL 2.0 as it originally was.
> 
> make CHECK_DTBS=y on bcm21664-garnet.dtb and bcm23550-sparrow.dtb
> seem to pass fine for me (thanks to Stanislav Jakubek for converting
> the bindings to YAML format!).

:)

> It's worth noting though that some bcm23550 compatibles now go unused,
> since the bcm21664-common.dtsi file uses bcm21664 compatibles.

I don't think this is the way to go. While in these cases the Linux drivers
match only on the generic brcm,kona-* fallback compatible (AFAIK anyway),
the compatibles in DT should still be (SoC-)specific.

I think the common DTSI should omit the compatible values altogether
and instead have the compatible be specified in SoC DTSI. You could keep
a note in the common DTSI saying that the compatible is in SoC DTSI or
something similar.

For example:
- in bcm21664-bcm23550-common.dtsi (or whatever we decide to call it):

gpio: gpio@100300 {
	/* compatible is SoC-specific */
	reg = <0x100300 0x524>;
	...
};

- in bcm21664.dtsi:

&gpio {
	compatible = "brcm,bcm21664-gpio", "brcm,kona-gpio";
};

- in bcm23550.dtsi:

&gpio {
	compatible = "brcm,bcm23550-gpio", "brcm,kona-gpio";
};

Regards,
Stanislav

> 
> [1] https://github.com/knuxdroid/android_kernel_samsung_baffinlite
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Artur Weber (2):
>       ARM: dts: broadcom: bcm21664: Move chosen node into bcm21664-garnet DTS
>       ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BCM23550
> 
>  arch/arm/boot/dts/broadcom/bcm21664-common.dtsi | 334 ++++++++++++++++++++++
>  arch/arm/boot/dts/broadcom/bcm21664-garnet.dts  |   4 +
>  arch/arm/boot/dts/broadcom/bcm21664.dtsi        | 326 +---------------------
>  arch/arm/boot/dts/broadcom/bcm23550.dtsi        | 354 +-----------------------
>  4 files changed, 357 insertions(+), 661 deletions(-)
> ---
> base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> change-id: 20240528-bcm21664-common-14064864a4a7
> 
> Best regards,
> -- 
> Artur Weber <aweber.kernel@gmail.com>
> 


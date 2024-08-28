Return-Path: <linux-kernel+bounces-305354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A877962D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB41F222A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54A51A3BC2;
	Wed, 28 Aug 2024 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdauENqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD21A38FA;
	Wed, 28 Aug 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861518; cv=none; b=cPVyUF8rvKJc54Q2hT+Xm5KABJcYNSpDupBip5l/jbH0jRsX9RlmHLmFit15h6mOgQE7QFFCpqUIQp3LgORX3VhdA3jwxx9y0PDjfk9ChaBHmSQ60iwVLQVX/x0SbvJQyxKdSyvIrj5AQNWpU73+JlpVpFXuZY9lhR7w7dFCcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861518; c=relaxed/simple;
	bh=diZD2GWbBKESSetbD2TM0fA8pWIvhxDQ8Hfp1eGP4Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzpHpnsr90/L0bbLkv6ziHR0AtFRUNadXXPm0yLQFmuyOJFQc4Lco8oi+NyUYhFa05DQzY62iBJVJr0UXG3TKvG4NmqTesZj80//5WL0nLOQvSY4jTOZY39IlD+Yes/Rc6bJgIS7sU4DJc/t/dvtNcUqqh73zGk0ZePx7DOxk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdauENqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA18BC4DDFA;
	Wed, 28 Aug 2024 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861517;
	bh=diZD2GWbBKESSetbD2TM0fA8pWIvhxDQ8Hfp1eGP4Ws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UdauENqGtrvcVeUOtHW771dxcvkSN7kKaW1PQ9SLxyTzhzTd6lK3uflf6hb5Gu6M9
	 HCjWO/fJi2CdL0EQHVPtgh4rLsWHB4h1nyRDA+bRiAotFTyvj5Ok6CFzSubgOijBEJ
	 ZWKjGOrGWHoYVPa09zvl8qsgZ3rKBrBHPoXaDVIw71GdyYupQ3DHBIAlA+fU36ZJYr
	 aM3WghUyLRYSqNl2Chp4eixbFQk3HrOmaeFq63sICdgVyomNYtuD9IwOtebyIX+B95
	 L+BE5J7FLvJRVqv8Ib+E2h0IwRI5bi04Otbmrl28Y2SDYW+1X3APXB8qxF0pH/5tgV
	 5r9rGSsg623bQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533488ffaebso8416830e87.0;
        Wed, 28 Aug 2024 09:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYSshx7llTFsYW7f7nGlXPAhe68BuEtYaL19uthzRdjq4UFQ//11KF96v8bqWXuPD+CxSyi6CGuLhRYgCu@vger.kernel.org, AJvYcCXhRXHVlM+o2zCH1pBwRGSLG/I3igUPoAMhU7X7pY+UP0IlvuGfVJgCymICfaGTpA+Ks8Kkclg4jPMC@vger.kernel.org
X-Gm-Message-State: AOJu0YzEi3XhdFv7ULI0KtpvLuq2Qnm75Z3qYs2qPuCqGQ0WCMw7ldcc
	TlPMoamxCn445qT7lLNgC7qDNWzMX82bF76MFVJxhxJivdLQQ2+HQKlEHcNKY5AuiM3VietjirN
	AkcbINa5j8vteRqJnkGGRnGadLg==
X-Google-Smtp-Source: AGHT+IGz4YxtRtAMkux7jozATIO5b1zf3zLkQWdu6nc1eiZcWtvHWH+xq0dm9Fxvf9Ays6zepA/PrCTmUfQYxLVfxWw=
X-Received: by 2002:a05:6512:308c:b0:530:b76c:65df with SMTP id
 2adb3069b0e04-5343878430bmr12959840e87.35.1724861516055; Wed, 28 Aug 2024
 09:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828112139.2665814-1-lukma@denx.de> <172484936571.3462707.10762753590627002293.robh@kernel.org>
 <20240828160553.53e164c3@wsk>
In-Reply-To: <20240828160553.53e164c3@wsk>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Aug 2024 11:11:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4+=L4hOYWKUBRTHpSMfMNaNvEy0xcjX=fZ4r4KP8x3Q@mail.gmail.com>
Message-ID: <CAL_JsqJ4+=L4hOYWKUBRTHpSMfMNaNvEy0xcjX=fZ4r4KP8x3Q@mail.gmail.com>
Subject: Re: [PATCH] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:12=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> Hi Rob,
>
> > On Wed, 28 Aug 2024 13:21:39 +0200, Lukasz Majewski wrote:
> > > The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> > > some extend similar to already upstreamed XEA devices, hence are
> > > using common imx28-lwe.dtsi file.
> > >
> > > New, btt3.dtsi has been added to embrace common DTS properties for
> > > different HW revisions for this device.
> > >
> > > As a result - changes introduced in btt3-[012].dts are minimal.
> > >
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > ---
> > >  arch/arm/boot/dts/nxp/mxs/Makefile   |   3 +
> > >  arch/arm/boot/dts/nxp/mxs/btt3-0.dts |  12 +
> > >  arch/arm/boot/dts/nxp/mxs/btt3-1.dts |   8 +
> > >  arch/arm/boot/dts/nxp/mxs/btt3-2.dts |  12 +
> > >  arch/arm/boot/dts/nxp/mxs/btt3.dtsi  | 320
> > > +++++++++++++++++++++++++++ 5 files changed, 355 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/nxp/mxs/btt3-0.dts
> > >  create mode 100644 arch/arm/boot/dts/nxp/mxs/btt3-1.dts
> > >  create mode 100644 arch/arm/boot/dts/nxp/mxs/btt3-2.dts
> > >  create mode 100644 arch/arm/boot/dts/nxp/mxs/btt3.dtsi
> > >
> >
> >
> > My bot found new DTB warnings on the .dts files added or changed in
> > this series.
> >
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the
> > warnings are fixed by another series. Ultimately, it is up to the
> > platform maintainer whether these warnings are acceptable or not. No
> > need to reply unless the platform maintainer has comments.
> >
>
> There a few things to clarify after:
> CROSS_COMPILE=3D"arm-none-linux-gnueabihf-"
> ARCH=3Darm make -j4 CHECK_DTBS=3Dy nxp/mxs/btt3-0.dtb
>
> 1. mxs-spi.yaml vs mxs-mmc.yaml -> both refer to the same set of HW - as
> those IP blocks can work as both mmc and SPI.

Sounds like there should be 1 binding then.

>
> 2. For the sound codec:
>  codec@1a: compatible: ['wlf,wm8940', 'wlf,wm8974'] is too long
>
> This is a bit problematic as well - as WM8974 doesn't have ANY ID
> register, so it needs to be probed manually and decided which module
> with sound codec needs to be inserted. The WM8940 is the pin compatible
> replacement.

So if the OS has 2 drivers for these 2 devices, which one does it
pick? The answer for Linux is it is undefined. The expectation is if
there are multiple options, the firmware figures out which one is
present and adjusts the DT.

> 3. The simple-bus.yaml seems to be missing in the Linux kernel tree -
> problem is that imx28 has 'apbx' bus.

simple-bus.yaml lives in dtschema repo.

Node names should be generic, not named for the implementation/type.
The binding is fairly flexible in allowing ".*-bus".

> 4. The fsl,lcdif.yaml doesn't allow the situation when one specify by
> hand (in DTS) display parameters (as different ones can be used by the
> manufacturing site).

Shrug. At the end of the day, the binding and dts have to match. One
(or both) has to be adjusted.

Rob


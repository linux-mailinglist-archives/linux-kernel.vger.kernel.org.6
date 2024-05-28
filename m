Return-Path: <linux-kernel+bounces-192816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CCC8D22A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D792863E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234D446A1;
	Tue, 28 May 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3DE6HtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC938F87;
	Tue, 28 May 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918103; cv=none; b=FDYcsU/lqnGbDVXsmc+L7LxFaH0mbRJglsg/2Yo7iR8Z4gDXN0eOJ+Amgk7dD9DWFu8HQX2JLuzp/de4gi0a6nUlCnisbhQvi/Wi3L76IsNJtTR/N4VoSAedm3MKEQugROgirja2A+5P4tJp5PkDtnSDDPBv4mBwbQhb+DoK1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918103; c=relaxed/simple;
	bh=RBpYwUrOrov4++YqaMsUXwq/82wkQZJD1OxZ4lr6mPU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=I97622stSmgnMKGCIfHjPpN1PAyWpGGEIPjz7E8OvJPdW/Q3/4rzEt5gGJvaBQR2PU0/NM8ivF/De4zYNlvdinHEAZ51x41pTlz7Eo4Qsh5d/4XLjWJGOqOdRuUUKhOFJ4odt5uM3zPzHSTPN+IKO9Fawu7zcczQXb1773h2NJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3DE6HtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3F2C32786;
	Tue, 28 May 2024 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918102;
	bh=RBpYwUrOrov4++YqaMsUXwq/82wkQZJD1OxZ4lr6mPU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=s3DE6HtTk2grBy6f+ooWveg1QYRQhxoI8is4YrM3LWFsW+yszTEOtvDiqXRA4WhGz
	 jz6XMx7/RSwmOU/eo7H0PqakekwVc9gAq5Gmw9igeW51ew7xOp2ZLomVWh7ypzIuRu
	 Pm7cHn6RTLpZmE+Pud/HptpQrQFAQsk+mJNssBMRN3mEhF1HH4D11hkbTPYlHX3Pl3
	 JJWGoVZjfuHlWdhWCjcFxW7j4lNEwKeceudNvyzHTejrH41tNYnfv3nY8Kk3t2yJN1
	 j8Wuq3UAVeVrB91eIT1LhfCRVqjwOc5iEaVxbqY91KKwwOXvmTdQzkTdasF596TKsp
	 HzxuMCwPLTaIA==
Date: Tue, 28 May 2024 12:41:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: hiago.franco@toradex.com, krzk+dt@kernel.org, ye.li@nxp.com, 
 festevam@gmail.com, leoyang.li@nxp.com, bhelgaas@google.com, 
 linux-clk@vger.kernel.org, peng.fan@nxp.com, linux-kernel@vger.kernel.org, 
 abelvesa@kernel.org, frank.li@nxp.com, ping.bai@nxp.com, 
 m.othacehe@gmail.com, kernel@pengutronix.de, devicetree@vger.kernel.org, 
 shawnguo@kernel.org, hvilleneuve@dimonoff.com, imx@lists.linux.dev, 
 conor+dt@kernel.org, aisheng.dong@nxp.com, s.hauer@pengutronix.de, 
 alexander.stein@ew.tq-group.com, Markus.Niebel@ew.tq-group.com, 
 linux-arm-kernel@lists.infradead.org, joao.goncalves@toradex.com, 
 sboyd@kernel.org, gregor.herburger@ew.tq-group.com, mturquette@baylibre.com, 
 tharvey@gateworks.com, m.felsch@pengutronix.de
In-Reply-To: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
Message-Id: <171691793305.1180610.12774136629203985071.robh@kernel.org>
Subject: Re: [PATCH 0/5] arm64: dts: freescale: Add i.MX91 11x11 EVK basic
 support


On Mon, 27 May 2024 16:51:53 -0700, Pengfei Li wrote:
> The design of the i.MX91 platform is very similar to i.MX93.
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core
> 
> Therefore, i.MX91 can reuse i.MX93 dtsi.
> 
> Pengfei Li (5):
>   dt-bindings: clock: Add i.MX91 clock support
>   dt-bindings: clock: Add i.MX91 clock definition
>   arm64: dts: freescale: Add i.MX91 dtsi support
>   dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
>   arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   6 +
>  .../bindings/clock/imx93-clock.yaml           |   1 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 807 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
>  include/dt-bindings/clock/imx93-clock.h       |   7 +-
>  7 files changed, 1657 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y freescale/imx91-11x11-evk.dtb' for 20240527235158.1037971-1-pengfei.li_1@nxp.com:

arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: pinctrl@443c0000: 'eqosgrpsleep', 'pdmgrpsleep', 'sai1grpsleep', 'sai3grpsleep', 'spdifgrpsleep', 'usdhc2gpiogrpsleep', 'usdhc2grpsleep', 'usdhc3grpsleep' do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/fsl,imx9-pinctrl.yaml#
arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: tcpc@50: compatible: ['nxp,ptn5110'] is too short
	from schema $id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#
arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: tcpc@50: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#
arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: tcpc@51: compatible: ['nxp,ptn5110'] is too short
	from schema $id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#
arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: tcpc@51: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#
arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb: mmc@42860000: Unevaluated properties are not allowed ('fsl,cd-gpio-wakeup-disable' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/fsl-imx-esdhc.yaml#







Return-Path: <linux-kernel+bounces-200954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663328FB744
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4CD286A73
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0CB148FED;
	Tue,  4 Jun 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPZHtD1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626C14900F;
	Tue,  4 Jun 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514940; cv=none; b=Nfak+M1j3ZNkKtDFm26od0Ta6OvGrrNCwJ2c51xoGDGBNmcKjgYIJnKm1vArbDq2GkaBj5AdIpL3zBTpymChho2VyjjiPmzZmr69YpwDGbpVW/iy/WlskKpLYPgzGRRataQwWQHNeBKQNBU86dQ83jvXzbCq2fdwUMBIZ+lF3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514940; c=relaxed/simple;
	bh=M9flsdH1rf42KEqaDdDPbhL6x/FMg56h8dxioyYi/dM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=X9qTByalI58CgUxDfAyd9h06HjJ1AECCpqYYzy0lOKsx+sMmIDqRtpgka9sCuBxvyJdXKJ4q2u4MRQ2nW7Mle0WJixUVlGRDYPoM5BWWl038zF/s1E6K170+7xxEUn4hqF7AH7Vzi0myvQ/G9yqmwF23NM8PMQuBlPmJOtV5CAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPZHtD1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E301C2BBFC;
	Tue,  4 Jun 2024 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514940;
	bh=M9flsdH1rf42KEqaDdDPbhL6x/FMg56h8dxioyYi/dM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gPZHtD1siZ06BKU0y6Bplhy60c1vhNUXg2e4hAYniJlLylxUxzXfViP33As9AKseI
	 Xyv9xB7dold8FpqZ89olAn0q/XL+O96EOcMmij8EfjPtCTS5Mdteu3k3ajvd5MQ50n
	 sL5obTKudv/nqcqPps28wVRzF3Tzccgm7mFt4+/Plxtc40VRmgipd5NaNfyW6Kya+S
	 G7xkX4rz3Gc0LDW3YKyIBC0ooOXWP29bSyvaSj/6BckJwx+pm9RGoxB+YLC4ZQnWt+
	 M/nmBtafaZ0RnbayXEZ+3sbb5pyrNsQRAX3Ph7NlEqZST2TGoEyUiU+BNX51z4O8KQ
	 yZXzd/uXBkSUA==
Date: Tue, 04 Jun 2024 10:28:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Priit Laes <plaes@plaes.org>, linux-arm-kernel@lists.infradead.org, 
 Li Yang <leoyang.li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20240604135934.1951189-1-mwalle@kernel.org>
References: <20240604135934.1951189-1-mwalle@kernel.org>
Message-Id: <171751455018.786235.5564969339384632378.robh@kernel.org>
Subject: Re: [PATCH 00/10] ARM: dts: kontron-samx6i: various fixes


On Tue, 04 Jun 2024 15:59:24 +0200, Michael Walle wrote:
> While working on a new PHY support for this board I've noticed quite
> a few errors. Fix these and introduce an actual board for the
> module. For now, there was just a dtsi and no actual user of it.
> 
> Michael Walle (10):
>   ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
>   ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
>   ARM: dts: imx6qdl-kontron-samx6i: fix board reset
>   ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
>   ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
>   ARM: dts: imx6qdl-kontron-samx6i: fix product name
>   ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
>   ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
>   dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
>   ARM: dts: imx6qdl-kontron-samx6i: add actual device trees
> 
>  .../devicetree/bindings/arm/fsl.yaml          |  12 ++
>  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
>  .../nxp/imx/imx6dl-kontron-samx6i-ads2.dts    |  12 ++
>  .../dts/nxp/imx/imx6dl-kontron-samx6i.dtsi    |   2 +-
>  .../dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts |  12 ++
>  .../dts/nxp/imx/imx6q-kontron-samx6i.dtsi     |  25 +---
>  .../nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi  | 121 ++++++++++++++++++
>  .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   |  41 ++++--
>  8 files changed, 190 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
> 
> --
> 2.39.2
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


New warnings running 'make CHECK_DTBS=y nxp/imx/imx6dl-kontron-samx6i-ads2.dtb nxp/imx/imx6q-kontron-samx6i-ads2.dtb' for 20240604135934.1951189-1-mwalle@kernel.org:

arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu1_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu2_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /soc/bus@2000000/pinctrl@20e0000: failed to match any schema with compatible: ['fsl,imx6dl-iomuxc']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/bus@2000000/pinctrl@20e0000: failed to match any schema with compatible: ['fsl,imx6q-iomuxc']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: audio-codec@1a: 'AVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: audio-codec@1a: 'CPVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: audio-codec@1a: 'DBVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: audio-codec@1a: 'DCVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: audio-codec@1a: 'MICVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: audio-codec@1a: 'AVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: audio-codec@1a: 'CPVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: audio-codec@1a: 'DBVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: audio-codec@1a: 'DCVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: audio-codec@1a: 'MICVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: audmux@21d8000: 'audmux_adu3', 'audmux_adu4', 'audmux_ssi1', 'audmux_ssi2' do not match any of the regexes: '^mux-[0-9a-z]*$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/imx-audmux.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: audmux@21d8000: 'audmux_adu3', 'audmux_adu4', 'audmux_ssi1', 'audmux_ssi2' do not match any of the regexes: '^mux-[0-9a-z]*$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/imx-audmux.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /lcd: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: i2c-gpio-intern: $nodename:0: 'i2c-gpio-intern' does not match '^i2c(@.*|-[0-9a-z]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: i2c-gpio-intern: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'pmic@8' were unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: i2c-gpio-lcd: $nodename:0: 'i2c-gpio-lcd' does not match '^i2c(@.*|-[0-9a-z]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /lcd: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: i2c-gpio-cam: $nodename:0: 'i2c-gpio-cam' does not match '^i2c(@.*|-[0-9a-z]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: i2c-gpio-intern: $nodename:0: 'i2c-gpio-intern' does not match '^i2c(@.*|-[0-9a-z]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: i2c-gpio-intern: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'pmic@8' were unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: i2c-gpio-lcd: $nodename:0: 'i2c-gpio-lcd' does not match '^i2c(@.*|-[0-9a-z]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: i2c-gpio-cam: $nodename:0: 'i2c-gpio-cam' does not match '^i2c(@.*|-[0-9a-z]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#







Return-Path: <linux-kernel+bounces-204625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B588FF162
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479591F23B65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CAF1990AA;
	Thu,  6 Jun 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9f4QCXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9583198E8B;
	Thu,  6 Jun 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689377; cv=none; b=CtGVAq3RASYo1EqYF7nDeWFRttbMnD9BRN3+abbBaY4bTCeOLobi7VKEqyw/yrRijIxVsrL+e3nU/rOUXUAjj1n8MvV89zWa8oesr9U0ijFOnG8XyAkRFcTYvGP7srOVQi5fRqD9+ULauvjHZ1uAckIGa2NFg3Ba6DsCiTWKvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689377; c=relaxed/simple;
	bh=z28G5odfgTFCbiNzNSbtdWGfyipoDdUN9lcFVyAkJ3U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Eh+CRpp7XubNL+XFFLKq6+VLhL9YVvu07fv+7N2YKYJfL6zgOh+PG58Mi/1zIELL9j6CMC4YUoYlM1/MsdmM2VkXCKVPyBONQekTEX7EhT7a7DqJffX0590rOoRb8HwFGMhZzoracWybT5S+Gtu0vTHCclQN5p7zDF6Bi8WRTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9f4QCXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D9AC2BD10;
	Thu,  6 Jun 2024 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689377;
	bh=z28G5odfgTFCbiNzNSbtdWGfyipoDdUN9lcFVyAkJ3U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=A9f4QCXuv8GmmpBGCUv8i8euLSi3b/XIpvIH33y1Ytn9Ks2R8rE8Gb5xlCl5cMnt4
	 nxf4pjmhpZN4MzriIbvX9C5CJgN+SF0d4o6/9Dg19wgtkbRcqiCu6whsZDskwJnvrB
	 1KJ6hMooNtuik3DfvRg3D9AEiPgbE0TU5Vy8GCNFQl7W6P+t17KsQOKnwa8FbUQ9tr
	 i2bTp08HdmOzMdm2PQXT1T6X+t/3vkmPu9ztVAKdk2S582zbenKC0CpkRStKF1XUAX
	 aImgEwdL0AjPYy2SAvLxBzOMPRwDsN3QU0HpX+lZmlTpDhSje63wXsfjNmZrgPaQDC
	 KN1gvvWueJlPw==
Date: Thu, 06 Jun 2024 09:56:16 -0600
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
Cc: linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Priit Laes <plaes@plaes.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Marco Felsch <m.felsch@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20240606090206.2021237-1-mwalle@kernel.org>
References: <20240606090206.2021237-1-mwalle@kernel.org>
Message-Id: <171768925669.3793237.5164635523857392329.robh@kernel.org>
Subject: Re: [PATCH v2 00/13] ARM: dts: kontron-samx6i: various fixes


On Thu, 06 Jun 2024 11:01:53 +0200, Michael Walle wrote:
> While working on a new PHY support for this board I've noticed quite
> a few errors. Fix these and introduce an actual board for the
> module. For now, there was just a dtsi and no actual user of it.
> 
> v2:
>  - new patch to fix the node names to make the schema happy
>  - new patch to fix the PCIe reset line polarity
>  - new patch to remove the unused and invalid wake-up-gpio property
>  - add required poperties for the supply voltages to the wm8904 node
>  - enable PCIe in the ADS2 device tree include
> 
> Michael Walle (13):
>   ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
>   ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
>   ARM: dts: imx6qdl-kontron-samx6i: fix board reset
>   ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
>   ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
>   ARM: dts: imx6qdl-kontron-samx6i: fix product name
>   ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
>   ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
>   ARM: dts: imx6qdl-kontron-samx6i: fix node names
>   ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity
>   ARM: dts: imx6qdl-kontron-samx6i: remove wake-up-gpio property
>   dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
>   ARM: dts: imx6qdl-kontron-samx6i: add actual device trees
> 
>  .../devicetree/bindings/arm/fsl.yaml          |  12 ++
>  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
>  .../nxp/imx/imx6dl-kontron-samx6i-ads2.dts    |  12 ++
>  .../dts/nxp/imx/imx6dl-kontron-samx6i.dtsi    |   2 +-
>  .../dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts |  12 ++
>  .../dts/nxp/imx/imx6q-kontron-samx6i.dtsi     |  25 +--
>  .../nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi  | 148 ++++++++++++++++++
>  .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   |  58 ++++---
>  8 files changed, 225 insertions(+), 46 deletions(-)
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


New warnings running 'make CHECK_DTBS=y nxp/imx/imx6dl-kontron-samx6i-ads2.dtb nxp/imx/imx6q-kontron-samx6i-ads2.dtb' for 20240606090206.2021237-1-mwalle@kernel.org:

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
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dtb: /lcd: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dtb: /lcd: failed to match any schema with compatible: ['fsl,imx-parallel-display']







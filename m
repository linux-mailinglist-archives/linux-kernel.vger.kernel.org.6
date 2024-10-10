Return-Path: <linux-kernel+bounces-359295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE359989DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DECE1C2088F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13861CDA19;
	Thu, 10 Oct 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayKPAIkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D41CF29A;
	Thu, 10 Oct 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570605; cv=none; b=TI3F3urrxqrXhyVpxof+vI0dZ0H4O58IVHc94eip1QpWCn3ib88o7Icv+ebtzht8iC1l9/iIbYrLIvs+XA4WL4fQN0wyRX8DFkhHt3CA9IadQ0zT1iLGshRSQ2dtvRVeRC7ZVLG7vlDFpWQM58ScP+jcAsmZnSaL2HZubHFN5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570605; c=relaxed/simple;
	bh=0VvWiFUJjBgbPH/WUQ9vyiznobhDsJg21Hg47rHZGFs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NbzoDGuJ8IfMVFX6gcd/tgypWImTC3j8VdgaeOR3pB4kqRA8/GlZiaJVtYfnSmmdRnbbki3y56Nb0jdZ8d7D+Mawkj/Z3GYkC/FUOcYIpdGHCH2RSVFFUl1dnzm4NFw7ySgLSwKwCK4ZoosDll2BZha4cGD9E4vBRkdZKkKcveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayKPAIkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F153C4CEC5;
	Thu, 10 Oct 2024 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728570605;
	bh=0VvWiFUJjBgbPH/WUQ9vyiznobhDsJg21Hg47rHZGFs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ayKPAIkVxFtsrmDk1NRBZsgRCRj/koZJDRkPfezrQq1vaEyKoOZ0//Bqc2RkK8Fk4
	 iGPM88dr9UZRjZrgal+uB0kc2/x+5vQLu0K0RYvYoOxrWzYTJd8vdE5ZYBeDd5XheX
	 uVHV/nlPy0zaBvx2V9+0tdLWSHsDAl9uRcz2TPft2qIVwSWnqcOPpuq8uJFhtWl2GV
	 hZR5uTaETCVr2HoHub3jWU0W8rPdYg8N92Upnt5ViUPdb/+grMdxuV4iWSIoFeVwdk
	 xdBjiOhGtXqXFWCia69/uEpkUZJW5Xut0mOjSGv2dfspcJydds80ZQCUDQ6YHmY/an
	 CJIjMhb+gdAYA==
Date: Thu, 10 Oct 2024 09:30:04 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Fabio Estevam <festevam@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stefan Wahren <wahrenst@gmx.net>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20241010081719.2993296-1-lukma@denx.de>
References: <20241010081719.2993296-1-lukma@denx.de>
Message-Id: <172857035865.1533160.17822550814540826933.robh@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Document the btt3 i.MX28
 based board


On Thu, 10 Oct 2024 10:17:18 +0200, Lukasz Majewski wrote:
> The imx287 based btt3 board is very similar to xea in terms of used SOM
> module.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
> Changes for v8:
> - None
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y nxp/mxs/imx28-btt3-0.dtb nxp/mxs/imx28-btt3-1.dtb nxp/mxs/imx28-btt3-2.dtb' for 20241010081719.2993296-1-lukma@denx.de:

arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi-en-pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi-en-pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi-en-pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx-bus@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx-bus@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx-bus@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: panel: compatible: ['panel-dpi'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-dpi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: panel: compatible: ['panel-dpi'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-dpi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: panel: compatible: ['panel-dpi'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-dpi.yaml#







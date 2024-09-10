Return-Path: <linux-kernel+bounces-323217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A193A97399C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E6E1C24E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B219004B;
	Tue, 10 Sep 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P13r2NCE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522691946BC;
	Tue, 10 Sep 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977711; cv=none; b=mWMB3/N13mji52/SIaL1KJMua55qLmfc0CCarhR7V5j3kevM5KaOFjTBBA75Z45XeKwJIPb2U7j4De+ArUVJ31SOeTWr7WY6CgPpDfAr1wZR73A42JoalNxzdkMNSbRzDJI2/hktqdleOxft0twnje2QCPn8MuO8L58DncNyN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977711; c=relaxed/simple;
	bh=uae2pF3T0VnHw6NGke95ggHcrg2Kznx30S/ilbeHrXk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=of+8himvqucxDu7mdzkuh9epcYEWM++z2i9Er1ADF+CIWY5eBa4lcaPt/7qDWhu4V5hCjql+ZeKFc74JFljeRZ3T2wYKoa3G1OTD+jcZONftX8uI2N0Y6D7qLBzpbvctjCa1PFnbFCJy7oI6lK7wdIxkpmEjLKXZaldOShCK31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P13r2NCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73BBC4CEC3;
	Tue, 10 Sep 2024 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977710;
	bh=uae2pF3T0VnHw6NGke95ggHcrg2Kznx30S/ilbeHrXk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=P13r2NCEqdOqvhg96ZALQdQNuOf4WaPjPnbOzlsFA+pSRSYHhP5owpKa3SPldEoNO
	 CYptWKP/wylPjrZbjY4aziqsdBbJnrsQfPh28sD9iI+x8ztam4R1cRC4JxNq6iL21M
	 xT7D0DzPq+//YUkSNpFEAxgI+3p89otzA2HmGLoAb+Wz9HJGg42fRu7V426oRLUvEG
	 /YY7fawamVdyH6snAKpL58WFMo3+Ux9BO126Hj51W0iMtZ1NG4S7NfWsjPocjBnvun
	 GYjWB70POloLziVjVZveYBxUgqdd4smgRVarp/7tIjy8SczWUEQGbZtfyYJ5mttXl0
	 YULxiGXmhQ59A==
Date: Tue, 10 Sep 2024 09:15:09 -0500
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240910102326.927544-1-lukma@denx.de>
References: <20240910102326.927544-1-lukma@denx.de>
Message-Id: <172597760899.3917259.2991030678821472228.robh@kernel.org>
Subject: Re: [PATCH v5] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices


On Tue, 10 Sep 2024 12:23:26 +0200, Lukasz Majewski wrote:
> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> some extend similar to already upstreamed XEA devices, hence are
> using common imx28-lwe.dtsi file.
> 
> New, imx28-btt3.dtsi file has been added to embrace common DTS
> properties for different HW revisions for this device.
> 
> As a result - changes introduced in imx28-btt3-[012].dts are
> minimal.
> 
> This patch also adds entry to fsl.yaml for btt3 board.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v2:
> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match current
>   linux kernel naming convention
> - Remove 'wlf,wm8974' from compatible for codec@1a
> 
> Changes for v3:
> - Keep alphabethical order for Makefile entries
> 
> Changes for v4:
> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
> 
> Changes for v5:
> - Combine patch, which adds btt3-[012] with one adding board entry to
>   fsl.yaml
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm/boot/dts/nxp/mxs/Makefile            |   3 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts    |  12 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts    |   8 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts    |  12 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi     | 320 ++++++++++++++++++
>  6 files changed, 356 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
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


New warnings running 'make CHECK_DTBS=y nxp/mxs/imx28-btt3-0.dtb nxp/mxs/imx28-btt3-1.dtb nxp/mxs/imx28-btt3-2.dtb' for 20240910102326.927544-1-lukma@denx.de:

arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi_en_pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi_en_pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi_en_pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh-bus@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: lcdif@80030000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: lcdif@80030000: 'display', 'display0', 'display1', 'lcd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: lcdif@80030000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: lcdif@80030000: 'display', 'display0', 'display1', 'lcd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: lcdif@80030000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: lcdif@80030000: 'display', 'display0', 'display1', 'lcd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx-bus@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx-bus@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx-bus@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx-bus@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']







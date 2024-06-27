Return-Path: <linux-kernel+bounces-232032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45691A1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19036B209A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4667412D214;
	Thu, 27 Jun 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZJ3oWUXH"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742541A94
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478147; cv=none; b=W1fnaIo7tQk8iGIZlVhpkiVHlr+dfnhBkgFwL3I4hocV5s2YBA8rmO/mHxdeQp40T3n1IBGHt3Hg9TU2Bh8faYYgcDFhRyzbFG2WyBH+PuXaxLdmdxiOjyqnO4RRcd0GMj9bo1JgSijLhcB56MB1h5tGcrTVMdugQDcEH2d0Zzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478147; c=relaxed/simple;
	bh=4nfPIA4XuybkZw8ISeYiVQcxB7Y6UFRZfyi9NuCV7kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cW9aycRg/5GbuxTwNyEdutFN/jpOvKzWWtew/aJyKpTwAOauqyeneF/P1T6iUVyDsk63oqPDhgoU3SwYY8ipAA3rlBcmflQ1MTo4gzBV9c88y6eAHNFpyDV8BWYPIEb4uDDv5+gJZRyeZvPpChGaUsg1v+gNpvkiO6FgR/jHT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ZJ3oWUXH; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1719478142; x=1722070142;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4nfPIA4XuybkZw8ISeYiVQcxB7Y6UFRZfyi9NuCV7kQ=;
	b=ZJ3oWUXHpL7BrGIEBuU8PiamTjQ+K5bHPhNgbr3h+eBUFovNj/8mbDMD4cV8Pmda
	gRbEVVb/9VPN8gsb/oROMzE6iCRq9/o1aI4ySIPjRaecXkSW8sgDX2GEPxvFLJ/P
	pnNNQ8l4MbVZvkLcKimxyxV4fIB4zQr47YQ2gQAPiN4=;
X-AuditID: ac14000a-03251700000021bc-a7-667d277e62c5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2D.74.08636.E772D766; Thu, 27 Jun 2024 10:49:02 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 27 Jun
 2024 10:49:01 +0200
Message-ID: <cd3d1e1b-7243-4b51-bb4d-3a5aa2d20bb6@phytec.de>
Date: Thu, 27 Jun 2024 10:49:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: Add basic support for
 phyBOARD-Lyra-AM62Ax
To: Garrett Giordano <ggiordano@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240626155244.3311436-1-ggiordano@phytec.com>
 <20240626155244.3311436-4-ggiordano@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240626155244.3311436-4-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWyRpKBR7dOvTbN4PUiA4s1e88xWcw/co7V
	Yv2W32wWyz/PZrd4Oesem8Wmx9dYLS7vmsNm8ebHWSaL/3t2sFt0v1O3+H/2A7sDt8emVZ1s
	HpuX1Hv0d7ewevy5+I7V4/iN7UwenzfJBbBFcdmkpOZklqUW6dslcGVs+naWvWB/WsWKSxuZ
	GhgvBnQxcnJICJhIbP24k62LkYtDSGAJk8SRFZsYIZy7jBJ3tnWxg1TxCthIdC9/AZTg4GAR
	UJX4MCsVIiwocXLmExYQW1RAXuL+rRlg5cICERI/X59hB5kjIrCEUWJS50KwDcwCbYwSTx4e
	YAapEhLIlbi7/gMbiM0sIC5x68l8JhCbTUBd4s6Gb6wgNifQ4j/77jBD1FhILH5zkB3ClpfY
	/nYO1Bx5iReXlrNAvCMvMe3ca2YIO1TiyKbVTBMYhWchOXYWknWzkIydhWTsAkaWVYxCuZnJ
	2alFmdl6BRmVJanJeimpmxhBESfCwLWDsW+OxyFGJg7GQ4wSHMxKIryhJVVpQrwpiZVVqUX5
	8UWlOanFhxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhi7/u62DTN1aReJqu+oOvI6
	x+ew7AKV+RfslvvGGmf+Knnz7fZ2ma/bFvyd/uPJw4eXeqpjpmj7zX5W/efL5J/9rDPC24R/
	n/Y65qL/3qynWzkzpPFXwou/yTNX/myO13j8f2GNmpG73S5esYrLO9VrypcX/kt7+lW0kaHi
	S+eUupkmfWf4+ycrsRRnJBpqMRcVJwIAYxtI3aYCAAA=



Am 26.06.24 um 17:52 schrieb Garrett Giordano:
> The phyCORE-AM62Ax [1] is a SoM (System on Module) featuring TI's AM62Ax SoC.
> It can be used in combination with different carrier boards.
> This module can come with different sizes and models for
> DDR, eMMC, SPI NOR Flash and various SoCs from the AM62Ax family.
> 
> A development Kit, called phyBOARD-Lyra [2] is used as a carrier board
> reference design with a mapper board being used to allow the phyCORE-AM62Ax
> to fit the phyBOARD-Lyra.
> 
> Supported features:
>    * Debug UART
>    * SPI NOR Flash
>    * eMMC
>    * 2x Ethernet
>    * Micro SD card
>    * I2C EEPROM
>    * I2C RTC
>    * GPIO Expander
>    * LEDs
>    * USB
>    * HDMI
>    * USB-C
>    * Audio
> 
> For more details, see:
> 
> [1] Product page SoM: https://www.phytec.com/product/phycore-am62a
> [2] Product page CB: https://www.phytec.com/product/phyboard-am62a
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm64/boot/dts/ti/Makefile               |   2 +
>   .../boot/dts/ti/k3-am62a-phycore-som.dtsi     | 330 ++++++++++++++++++
>   .../dts/ti/k3-am62a7-phyboard-lyra-rdk.dts    |  18 +
>   3 files changed, 350 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 2c327cc320cf..cd6e14edbbea 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>   
>   # Boards with AM62Ax SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am62a7-phyboard-lyra-rdk.dtb
>   
>   # Boards with AM62Px SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
> @@ -173,6 +174,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>   # Enable support for device-tree overlays
>   DTC_FLAGS_k3-am625-beagleplay += -@
>   DTC_FLAGS_k3-am625-phyboard-lyra-rdk += -@
> +DTC_FLAGS_k3-am62a7-phyboard-lyra-rdk += -@
>   DTC_FLAGS_k3-am625-sk += -@
>   DTC_FLAGS_k3-am62-lp-sk += -@
>   DTC_FLAGS_k3-am62a7-sk += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
> new file mode 100644
> index 000000000000..a5aceaa39670
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2023 - 2024 PHYTEC America LLC
> + * Author: Garrett Giordano <ggiordano@phytec.com>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phycore-am62a
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model = "PHYTEC phyCORE-AM62Ax";
> +	compatible = "phytec,am62a-phycore-som", "ti,am62a7";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		gpio0 = &main_gpio0;
> +		gpio1 = &main_gpio1;
> +		i2c0 = &main_i2c0;
> +		mmc0 = &sdhci0;
> +		rtc0 = &i2c_som_rtc;
> +		spi0 = &ospi0;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default>;
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 2G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* global cma region */
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x00 0x24000000>;
> +			alloc-ranges = <0x00 0xc0000000 0x00 0x24000000>;
> +			linux,cma-default;
> +		};
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c900000 0x00 0x01e00000>;
> +			no-map;
> +		};
> +	};
> +
> +	vcc_5v0_som: regulator-vcc-5v0-som {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_5V0_SOM";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&main_pmx0 {
> +	leds_pins_default: leds-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x034, PIN_OUTPUT, 7) /* (K20) OSPI0_CSN2.GPIO0_13 */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (D17) I2C0_SCL */
> +			AM62AX_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (E16) I2C0_SDA */
> +		>;
> +	};
> +
> +	main_mdio1_pins_default: main-mdio1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
> +			AM62AX_IOPAD(0x15c, PIN_INPUT, 0) /* (V13) MDIO0_MDIO */
> +		>;
> +	};
> +
> +	main_mmc0_pins_default: main-mmc0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (Y6) MMC0_CMD */
> +			AM62AX_IOPAD(0x218, PIN_INPUT_PULLDOWN, 0) /* (AB7) MMC0_CLK */
> +			AM62AX_IOPAD(0x214, PIN_INPUT_PULLUP, 0) /* (AA6) MMC0_DAT0 */
> +			AM62AX_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AB6) MMC0_DAT1 */
> +			AM62AX_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (Y7) MMC0_DAT2 */
> +			AM62AX_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (AA7) MMC0_DAT3 */
> +			AM62AX_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (Y8) MMC0_DAT4 */
> +			AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (W7) MMC0_DAT5 */
> +			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (W9) MMC0_DAT6 */
> +			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AB8) MMC0_DAT7 */
> +		>;
> +	};
> +
> +	main_rgmii1_pins_default: main-rgmii1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x14c, PIN_INPUT, 0) /* (AB16) RGMII1_RD0 */
> +			AM62AX_IOPAD(0x150, PIN_INPUT, 0) /* (V15) RGMII1_RD1 */
> +			AM62AX_IOPAD(0x154, PIN_INPUT, 0) /* (W15) RGMII1_RD2 */
> +			AM62AX_IOPAD(0x158, PIN_INPUT, 0) /* (V14) RGMII1_RD3 */
> +			AM62AX_IOPAD(0x148, PIN_INPUT, 0) /* (AA16) RGMII1_RXC */
> +			AM62AX_IOPAD(0x144, PIN_INPUT, 0) /* (AA15) RGMII1_RX_CTL */
> +			AM62AX_IOPAD(0x134, PIN_OUTPUT, 0) /* (Y17) RGMII1_TD0 */
> +			AM62AX_IOPAD(0x138, PIN_OUTPUT, 0) /* (V16) RGMII1_TD1 */
> +			AM62AX_IOPAD(0x13c, PIN_OUTPUT, 0) /* (Y16) RGMII1_TD2 */
> +			AM62AX_IOPAD(0x140, PIN_OUTPUT, 0) /* (AA17) RGMII1_TD3 */
> +			AM62AX_IOPAD(0x130, PIN_OUTPUT, 0) /* (AB17) RGMII1_TXC */
> +			AM62AX_IOPAD(0x12c, PIN_OUTPUT, 0) /* (W16) RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	ospi0_pins_default: ospi0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
> +			AM62AX_IOPAD(0x02c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
> +			AM62AX_IOPAD(0x038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
> +			AM62AX_IOPAD(0x00c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
> +			AM62AX_IOPAD(0x010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
> +			AM62AX_IOPAD(0x014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */
> +			AM62AX_IOPAD(0x018, PIN_INPUT, 0) /* (H18) OSPI0_D3 */
> +			AM62AX_IOPAD(0x01c, PIN_INPUT, 0) /* (K21) OSPI0_D4 */
> +			AM62AX_IOPAD(0x020, PIN_INPUT, 0) /* (H19) OSPI0_D5 */
> +			AM62AX_IOPAD(0x024, PIN_INPUT, 0) /* (J20) OSPI0_D6 */
> +			AM62AX_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
> +			AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (L21) OSPI0_DQS */
> +		>;
> +	};
> +
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x1f4, PIN_INPUT, 0) /* (D16) EXTINTn */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_rgmii1_pins_default>;
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy1>;
> +};
> +
> +&cpsw3g_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mdio1_pins_default>;
> +
> +	cpsw3g_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +	};
> +};
> +
> +&fss {
> +	status = "okay";
> +};
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	pmic@30 {
> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vcc_5v0_som>;
> +		buck2-supply = <&vcc_5v0_som>;
> +		buck3-supply = <&vcc_5v0_som>;
> +		ldo1-supply = <&vdd_3v3>;
> +		ldo2-supply = <&vdd_1v8>;
> +		ldo3-supply = <&vcc_5v0_som>;
> +		ldo4-supply = <&vcc_5v0_som>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		ti,power-button;
> +		system-power-controller;
> +
> +		regulators {
> +			vdd_3v3: buck1 {
> +				regulator-name = "VDD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_1v8: buck2 {
> +				regulator-name = "VDD_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_lpddr4: buck3 {
> +				regulator-name = "VDD_LPDDR4";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vddshv5_sdio: ldo1 {
> +				regulator-name = "VDDSHV5_SDIO";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allow-bypass;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vddr_core: ldo2 {
> +				regulator-name = "VDDR_CORE";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdda_1v8: ldo3 {
> +				regulator-name = "VDDA_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_2v5: ldo4 {
> +				regulator-name = "VDD_2V5";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		pagesize = <32>;
> +		reg = <0x50>;
> +	};
> +
> +	i2c_som_rtc: rtc@52 {
> +		compatible = "microcrystal,rv3028";
> +		reg = <0x52>;
> +	};
> +};
> +
> +&main_gpio0 {
> +	status = "okay";
> +};
> +
> +&main_gpio1 {
> +	status = "okay";
> +};
> +
> +&main_gpio_intr {
> +	status = "okay";
> +};
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ospi0_pins_default>;
> +	status = "okay";
> +
> +	serial_flash: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <25000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <0>;
> +	};
> +};
> +
> +&sdhci0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc0_pins_default>;
> +	disable-wp;
> +	non-removable;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
> new file mode 100644
> index 000000000000..3b93409b23e7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2023 - 2024 PHYTEC America LLC
> + * Author: Garrett Giordano <ggiordano@phytec.com>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phyboard-am62a
> + */
> +
> +#include "k3-am62a7.dtsi"
> +#include "k3-am62a-phycore-som.dtsi"
> +#include "k3-am62x-phyboard-lyra.dtsi"
> +
> +/ {
> +	compatible = "phytec,am62a7-phyboard-lyra-rdk",
> +		     "phytec,am62a-phycore-som", "ti,am62a7";
> +	model = "PHYTEC phyBOARD-Lyra AM62A7";
> +};


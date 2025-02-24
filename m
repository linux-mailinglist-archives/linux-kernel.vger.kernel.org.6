Return-Path: <linux-kernel+bounces-528772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E4A41C29
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE1E7A6B82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9325A2A6;
	Mon, 24 Feb 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ua8Wk/NR"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D51FC0F8;
	Mon, 24 Feb 2025 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395611; cv=none; b=Z7AIY8uVUCxm9fu7Xut6ITuyGahdwJv3CX4Sda+H9vUJ+YB+HC0WQ3rB1iWfU6phZZZ0u7UekUr/i0JSNhN1dr/gKy+bf4PIoA1ztwwXkFNQGYbOsJKftv3hNCYDmDc9gu+ZURixC/R2mHO581Ed3kS7OujwSEs0oZyZziW0uMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395611; c=relaxed/simple;
	bh=dX8CvM/aLPRaw4WFxsMn8aCteHjX8ekf7fFoUzxCihU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFNc7o4NPqUqEGPaj63oalkQO9KXwj2zR9leUul5UMscHO4IysY1Kc2Iil86oImm81aseBY63xueywQ+1JtkGT7rYqGL/C/JTIh9J+ei5r1ydKoRyAJlBXUEiK1mYn3qA9Vv+sdvKNOuOh7YX1rwCJ3N8bAWr7iLirnlvVMEwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ua8Wk/NR; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OBDKoV1474055
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 24 Feb 2025 05:13:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740395600;
	bh=pQtZo3SIK3aiD8TRehAeANMVimCRRJt+Bvhzi2hA2mM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ua8Wk/NRiGgeBPEOM82LjZqeFMYIkTYzMn4r/i90Kgn5WMgIIJxzjuuaCktiQ7Ae1
	 mG17TwDO5/Ts+Iv9KNJ4bC55YYs+KD0OmYiVXy2Y1Yrlwsm2Q5ZhYoEc3um2B1nS8V
	 EXu81y39jM8AW6Jb7kwNbC12Ddp8JcXArjPCS1i0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OBDKLI018308;
	Mon, 24 Feb 2025 05:13:20 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 05:13:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 05:13:20 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OBDJZT019271;
	Mon, 24 Feb 2025 05:13:19 -0600
Date: Mon, 24 Feb 2025 16:43:18 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Andrew Davis
	<afd@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, Judith Mendez <jm@ti.com>,
        Andrei Aldea
	<a-aldea@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Deepak Khatri
	<lorforlinux@beagleboard.org>,
        Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add k3-am62-pocketbeagle2
Message-ID: <20250224111318.3wlbhpm7pggsbqdb@lcpd911>
References: <20250211181839.1575497-1-robertcnelson@gmail.com>
 <20250211181839.1575497-2-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211181839.1575497-2-robertcnelson@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Feb 11, 2025 at 12:18:39 -0600, Robert Nelson wrote:
> BeagleBoard.org PocketBeagle 2 is an upgraded version of the popular
> PocketBeagle.  It is based on Texas Instruments AM6232 SoC. Its dual
> A53 cores can provide higher performance than classic PocketBeagle.

You can say that classic PB was based on AM335 just for more context,
else it's not clear what the upgrade is w.r.t..

> The new design comes with pre-soldered headers, a 3-pin JST-SH 1.00mm
> UART debug port, a USB-C port, Texas Instruments MSPM0L1105 Cortex-M0+
> MCU for ADC, 512MB RAM, and a LiPo Battery charger.
> 
> https://www.beagleboard.org/boards/pocketbeagle-2
> https://openbeagle.org/pocketbeagle/pocketbeagle-
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Andrew Davis <afd@ti.com>
> CC: Roger Quadros <rogerq@kernel.org>
> CC: Siddharth Vadapalli <s-vadapalli@ti.com>
> CC: Judith Mendez <jm@ti.com>
> CC: Andrei Aldea <a-aldea@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Ayush Singh <ayush@beagleboard.org>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 520 ++++++++++++++++++
>  2 files changed, 521 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 8a4bdf87e2d4..46b9a667bda4 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am62-pocketbeagle2.dtb
>  
>  # Boards with AM62Ax SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> new file mode 100644
> index 000000000000..ef79bd0bf238
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * https://www.beagleboard.org/boards/pocketbeagle-2
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2024 Robert Nelson, BeagleBoard.org Foundation

Nit: Please update copyrights.

> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "k3-am625.dtsi"

Any particular reason we can't inherit from k3-am62x-sk-common.dtsi like
the SK and LP-SK DTS do?

Also, you're calling out in the commit message that this is based on
AM6232 - which has only 2 cores right? Do we not want to delete the
additional 2 cores from the AM625 DT which has 4 cores?

> +
> +/ {
> +	compatible = "beagle,am62-pocketbeagle2", "ti,am625";
> +	model = "BeagleBoard.org PocketBeagle2";
> +
> +	aliases {
> +		serial0 = &wkup_uart0;
> +		serial1 = &main_uart1;
> +		serial2 = &main_uart6;
> +		serial3 = &main_uart3;
> +		serial4 = &main_uart4;
> +		serial5 = &main_uart5;
> +		serial6 = &main_uart2;
> +		serial7 = &main_uart0;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> +		usb0 = &usb0;
> +		usb1 = &usb1;
> +		i2c0 = &main_i2c0;
> +		i2c1 = &wkup_i2c0;
> +		i2c2 = &main_i2c2;
> +	};
> +
> +	chosen {
> +		stdout-path = &main_uart6;
> +	};
> +
> +	memory@80000000 {
> +		/* 512MB RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x20000000>;
> +		device_type = "memory";
> +		bootph-pre-ram;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

Let's try to follow [1] here and elsewhere
[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9db00000 0x00 0xc00000>;
> +			no-map;
> +		};

Nothing for OPTEE/ M4/ etc...?
CMA?
Just trying to compare against sk-common... I understand the DDR is
smaller but we can't just ignore OPTEE / shared DMA pool right?

> +	};
> +
> +	vsys_5v0: regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		bootph-all;
> +	};
> +
> +	vdd_3v3: regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vsys_5v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		bootph-all;
> +	};
> +
> +	vdd_mmc1: regulator-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply = <&vdd_3v3>;
> +		gpio = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
> +		bootph-all;
> +	};
> +
> +	vdd_sd_dv: regulator-4 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "sd_hs200_switch";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vdd_3v3>;
> +		gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +		bootph-all;
> +	};
> +
> +	adc_vref: regulator-5 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "default";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +	};
> +
> +	leds {
> +		bootph-all;

Is this needed? child nodes seem to have bootph-all already right?

> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_default>;
> +
> +		led-1 {
> +			bootph-all;
> +			gpios = <&main_gpio0 6 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			default-state = "on";
> +		};
> +
> +		led-2 {
> +			bootph-all;
> +			gpios = <&main_gpio0 5 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK_ACTIVITY;
> +			linux,default-trigger = "mmc1";
> +		};
> +
> +		led-3 {
> +			bootph-all;
> +			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led-4 {
> +			bootph-all;
> +			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +			default-state = "off";
> +		};
> +	};
> +};
[....]
> +
> +&wkup_uart0 {
> +	/* WKUP UART0 is used by Device Manager firmware */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	bootph-all;
> +	status = "reserved";
> +};

See things like these you get for free from k3-am62x-sk-common.dtsi ;)

> +
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <100000>;
> +	bootph-all;

Child nodes have bootph, no need for their parents to repeat it unless
you've a good cause.

> +	status = "okay";
> +
> +	tps65219: pmic@30 {
> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vsys_5v0>;
> +		buck2-supply = <&vsys_5v0>;
> +		buck3-supply = <&vsys_5v0>;
> +		ldo1-supply = <&vdd_3v3>;
> +		ldo2-supply = <&buck2_reg>;
> +		ldo3-supply = <&vdd_3v3>;
> +		ldo4-supply = <&vdd_3v3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		bootph-all;
> +		system-power-controller;
> +		ti,power-button;
[...]

Overall I think the DT needs a bit of revisiting of which nodes to reuse
from common-DT and what all to delete/ trim. Revisit all the bootph
properties and remove the redundant one's...

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


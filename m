Return-Path: <linux-kernel+bounces-534343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA8A465A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288003A8B38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160021CFEE;
	Wed, 26 Feb 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q6xDfecG"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF4218ACA;
	Wed, 26 Feb 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585012; cv=none; b=A8IRPGCZZBcDoj+BvnUFunSIrJRdrMdd1/UNcGzPKyB75TXk3oR2ksVg3QOerRXhpb1LUO+jIcbpYv7gI0+dtWl4YUo+ibfUJnMfzC6u/NTzR8LQH0zF8BzzR+h8YrzXaqFEgqIeZCQebxMYg/v0VETp1SDoOWEl9FqN7QSmo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585012; c=relaxed/simple;
	bh=jtMVU9DBse/GUZE0tOPY2dHj/3Bxy11Ptn65yODVaYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QzqLcdTCP4jtkScBdtOQkKSPU7bM4PDn07wN7QkmzzU4GYgSjwN7Sjdq4oL8C3jcf8kTAN0bdIGomCgqVfKYmlhRsbdH5L5xeBm4uidYf3DChQ01H3g8xgEehD5R0mLVq7pdm6CZsNDHVgewb9vD826p36GVklViqG/RgA43Nkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q6xDfecG; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QFnxne2112906
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Feb 2025 09:49:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740584999;
	bh=VbW2t9EwpIS5Ha4EesUhK91rBFjcgNiBhbAE8z1q18s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=q6xDfecG+mHPY30GFFkDvARlLSpp6aqSqsceAuiSoMHVfMkYUg8pKycQqI31gduNB
	 anlVKTRgzBcKzolvqiitcmk3z1sZ7HB8Znb8IvJ0O4TNiikUhtmF4CjFtPgv1iUbAS
	 w5HSbAM1OF+Vbzi1r/3nhEJEVwiV1KlDeZBt5Oac=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QFnxjj035621;
	Wed, 26 Feb 2025 09:49:59 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 09:49:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 09:49:58 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QFnvkZ052803;
	Wed, 26 Feb 2025 09:49:57 -0600
Message-ID: <74b85562-15c2-42fc-8ee0-990f5718dcb0@ti.com>
Date: Wed, 26 Feb 2025 09:49:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add k3-am62-pocketbeagle2
To: Dhruva Gole <d-gole@ti.com>, Robert Nelson <robertcnelson@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Judith Mendez
	<jm@ti.com>,
        Andrei Aldea <a-aldea@ti.com>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Deepak Khatri <lorforlinux@beagleboard.org>,
        Ayush Singh <ayush@beagleboard.org>
References: <20250211181839.1575497-1-robertcnelson@gmail.com>
 <20250211181839.1575497-2-robertcnelson@gmail.com>
 <20250224111318.3wlbhpm7pggsbqdb@lcpd911>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250224111318.3wlbhpm7pggsbqdb@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 2/24/25 5:13 AM, Dhruva Gole wrote:
> On Feb 11, 2025 at 12:18:39 -0600, Robert Nelson wrote:
>> BeagleBoard.org PocketBeagle 2 is an upgraded version of the popular
>> PocketBeagle.  It is based on Texas Instruments AM6232 SoC. Its dual
>> A53 cores can provide higher performance than classic PocketBeagle.
> 
> You can say that classic PB was based on AM335 just for more context,
> else it's not clear what the upgrade is w.r.t..
> 
>> The new design comes with pre-soldered headers, a 3-pin JST-SH 1.00mm
>> UART debug port, a USB-C port, Texas Instruments MSPM0L1105 Cortex-M0+
>> MCU for ADC, 512MB RAM, and a LiPo Battery charger.
>>
>> https://www.beagleboard.org/boards/pocketbeagle-2
>> https://openbeagle.org/pocketbeagle/pocketbeagle-
>>
>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>> CC: Rob Herring <robh@kernel.org>
>> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> CC: Conor Dooley <conor+dt@kernel.org>
>> CC: Vignesh Raghavendra <vigneshr@ti.com>
>> CC: Nishanth Menon <nm@ti.com>
>> CC: Andrew Davis <afd@ti.com>
>> CC: Roger Quadros <rogerq@kernel.org>
>> CC: Siddharth Vadapalli <s-vadapalli@ti.com>
>> CC: Judith Mendez <jm@ti.com>
>> CC: Andrei Aldea <a-aldea@ti.com>
>> CC: Jason Kridner <jkridner@beagleboard.org>
>> CC: Deepak Khatri <lorforlinux@beagleboard.org>
>> CC: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |   1 +
>>   .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 520 ++++++++++++++++++
>>   2 files changed, 521 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 8a4bdf87e2d4..46b9a667bda4 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtbo
>> +dtb-$(CONFIG_ARCH_K3) += k3-am62-pocketbeagle2.dtb
>>   
>>   # Boards with AM62Ax SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
>> new file mode 100644
>> index 000000000000..ef79bd0bf238
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
>> @@ -0,0 +1,520 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/*
>> + * https://www.beagleboard.org/boards/pocketbeagle-2
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
>> + * Copyright (C) 2024 Robert Nelson, BeagleBoard.org Foundation
> 
> Nit: Please update copyrights.
> 
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include "k3-am625.dtsi"
> 
> Any particular reason we can't inherit from k3-am62x-sk-common.dtsi like
> the SK and LP-SK DTS do?
> 

Because PocketBeagle 2 is not based on our TI SK boards.. Some
things are common (PMIC, some carveouts), but not nearly enough
to make this a good idea.

Any changes to the SK board DT would have to be checked against
this DTB, which will break things at some point as the DT becomes
more complete.

Andrew

> Also, you're calling out in the commit message that this is based on
> AM6232 - which has only 2 cores right? Do we not want to delete the
> additional 2 cores from the AM625 DT which has 4 cores?
> 
>> +
>> +/ {
>> +	compatible = "beagle,am62-pocketbeagle2", "ti,am625";
>> +	model = "BeagleBoard.org PocketBeagle2";
>> +
>> +	aliases {
>> +		serial0 = &wkup_uart0;
>> +		serial1 = &main_uart1;
>> +		serial2 = &main_uart6;
>> +		serial3 = &main_uart3;
>> +		serial4 = &main_uart4;
>> +		serial5 = &main_uart5;
>> +		serial6 = &main_uart2;
>> +		serial7 = &main_uart0;
>> +		mmc0 = &sdhci0;
>> +		mmc1 = &sdhci1;
>> +		usb0 = &usb0;
>> +		usb1 = &usb1;
>> +		i2c0 = &main_i2c0;
>> +		i2c1 = &wkup_i2c0;
>> +		i2c2 = &main_i2c2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &main_uart6;
>> +	};
>> +
>> +	memory@80000000 {
>> +		/* 512MB RAM */
>> +		reg = <0x00000000 0x80000000 0x00000000 0x20000000>;
>> +		device_type = "memory";
>> +		bootph-pre-ram;
>> +	};
>> +
>> +	reserved_memory: reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> 
> Let's try to follow [1] here and elsewhere
> [1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> 
>> +
>> +		secure_tfa_ddr: tfa@9e780000 {
>> +			reg = <0x00 0x9e780000 0x00 0x80000>;
>> +			no-map;
>> +		};
>> +
>> +		secure_ddr: optee@9e800000 {
>> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
>> +			no-map;
>> +		};
>> +
>> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0x9db00000 0x00 0xc00000>;
>> +			no-map;
>> +		};
> 
> Nothing for OPTEE/ M4/ etc...?
> CMA?
> Just trying to compare against sk-common... I understand the DDR is
> smaller but we can't just ignore OPTEE / shared DMA pool right?
> 
>> +	};
>> +
>> +	vsys_5v0: regulator-1 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vsys_5v0";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		bootph-all;
>> +	};
>> +
>> +	vdd_3v3: regulator-2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		vin-supply = <&vsys_5v0>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		bootph-all;
>> +	};
>> +
>> +	vdd_mmc1: regulator-3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_mmc1";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +		regulator-always-on;
>> +		vin-supply = <&vdd_3v3>;
>> +		gpio = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
>> +		bootph-all;
>> +	};
>> +
>> +	vdd_sd_dv: regulator-4 {
>> +		compatible = "regulator-gpio";
>> +		regulator-name = "sd_hs200_switch";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		vin-supply = <&vdd_3v3>;
>> +		gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
>> +		states = <1800000 0x0>,
>> +			 <3300000 0x1>;
>> +		bootph-all;
>> +	};
>> +
>> +	adc_vref: regulator-5 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "default";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	leds {
>> +		bootph-all;
> 
> Is this needed? child nodes seem to have bootph-all already right?
> 
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&led_pins_default>;
>> +
>> +		led-1 {
>> +			bootph-all;
>> +			gpios = <&main_gpio0 6 GPIO_ACTIVE_HIGH>;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			linux,default-trigger = "heartbeat";
>> +			function = LED_FUNCTION_HEARTBEAT;
>> +			default-state = "on";
>> +		};
>> +
>> +		led-2 {
>> +			bootph-all;
>> +			gpios = <&main_gpio0 5 GPIO_ACTIVE_HIGH>;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			function = LED_FUNCTION_DISK_ACTIVITY;
>> +			linux,default-trigger = "mmc1";
>> +		};
>> +
>> +		led-3 {
>> +			bootph-all;
>> +			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +		};
>> +
>> +		led-4 {
>> +			bootph-all;
>> +			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			function = LED_FUNCTION_INDICATOR;
>> +			default-state = "off";
>> +		};
>> +	};
>> +};
> [....]
>> +
>> +&wkup_uart0 {
>> +	/* WKUP UART0 is used by Device Manager firmware */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&wkup_uart0_pins_default>;
>> +	bootph-all;
>> +	status = "reserved";
>> +};
> 
> See things like these you get for free from k3-am62x-sk-common.dtsi ;)
> 
>> +
>> +&wkup_i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
>> +	clock-frequency = <100000>;
>> +	bootph-all;
> 
> Child nodes have bootph, no need for their parents to repeat it unless
> you've a good cause.
> 
>> +	status = "okay";
>> +
>> +	tps65219: pmic@30 {
>> +		compatible = "ti,tps65219";
>> +		reg = <0x30>;
>> +		buck1-supply = <&vsys_5v0>;
>> +		buck2-supply = <&vsys_5v0>;
>> +		buck3-supply = <&vsys_5v0>;
>> +		ldo1-supply = <&vdd_3v3>;
>> +		ldo2-supply = <&buck2_reg>;
>> +		ldo3-supply = <&vdd_3v3>;
>> +		ldo4-supply = <&vdd_3v3>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_irq_pins_default>;
>> +		interrupt-parent = <&gic500>;
>> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +
>> +		bootph-all;
>> +		system-power-controller;
>> +		ti,power-button;
> [...]
> 
> Overall I think the DT needs a bit of revisiting of which nodes to reuse
> from common-DT and what all to delete/ trim. Revisit all the bootph
> properties and remove the redundant one's...
> 


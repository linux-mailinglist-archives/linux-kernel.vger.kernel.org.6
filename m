Return-Path: <linux-kernel+bounces-378313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A679ACE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863741F212F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D01C9EAC;
	Wed, 23 Oct 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hLBZ3MNS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BB1C231D;
	Wed, 23 Oct 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695967; cv=none; b=EelU2lIs4ASbaUEQQtIwA+O7/jym8RUU3mKKMwp6nTFLy3uyTUoxQyDt1HjGYfcKo3mRDcVa36Cf1d4gpbWhzBu7CZOxizfK0+CmtAPi8bEBQh/uMxmaZ5q8TLaEGpejrt9p9ZOS8LfJhwXp5kOrziPUcNImoLQsHxr/5RpvgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695967; c=relaxed/simple;
	bh=gbHRXINUHt5jI+cN3e0dzhX0jv7PVafUqXfQrep2BLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DsuZLy3oZWJy+baGA9dt89kLhETGJfy0Yxw1rSqR0FbJbpIsqoAynzD+iKkcYb8vcOJOORR2adWI/pYCdv3COYjQ0SnHc4fvszqdr0xLpcMNPTdHQ3RhbJj3eidIPXwy91jtcGOi5IsHhHkmqOaLWtzzX23LfoJ9938GTFoIAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hLBZ3MNS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NF5uvb060575;
	Wed, 23 Oct 2024 10:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729695956;
	bh=V0OHs0H7IhHNUY8ODfZQzfiiqBNGvwZxhUzPRwZ3pR8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hLBZ3MNSbJzm5Bu51JcrwX+E48TUIN6a8uSfXNJF60mZH5o5r/GKwa7ABMRbnBvUx
	 IuGF5XMVDb6aQi2lpjQf0keLjWIuQJxBCkX/PUoJAd9ZQWV+uB1sYO4rrWarWbozkk
	 YafxJJyeWYsg/7BW+ZyiQOu4hCb+AREFIR9u6VqE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NF5uXx058932;
	Wed, 23 Oct 2024 10:05:56 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 10:05:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 10:05:56 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NF5psV073797;
	Wed, 23 Oct 2024 10:05:52 -0500
Message-ID: <577721f5-659e-4a75-bd41-a633c7f67017@ti.com>
Date: Wed, 23 Oct 2024 20:35:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] arm64: dts: ti: k3-j7200-evm*: Add bootph-*
 properties
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Udit
 Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
 <20241023-b4-upstream-bootph-all-v5-12-a974d06370ab@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-12-a974d06370ab@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 23/10/24 12:27, Manorit Chawdhry wrote:
> Adds bootph-* properties to the leaf nodes to enable bootloaders to
> utilise them.
> 
> Following adds bootph-* to:
> - pmic regulator for enabling AVS Support
> - main_uart0, mcu_uart0(DM), wkup_uart0(TIFS) for Traces
> - mmc0, mmc1, usb0, ospi0, ospi1, hbmc for enabling various bootmodes.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 13 +++++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi           |  6 ++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6593c5da82c0..d03690b8d652 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -129,6 +129,7 @@ J721E_WKUP_IOPAD(0x94, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
>   			J721E_WKUP_IOPAD(0x8c, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
>   			J721E_WKUP_IOPAD(0x88, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
>   		>;
> +		bootph-all;
>   	};
>   
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
> @@ -136,6 +137,7 @@ wkup_uart0_pins_default: wkup-uart0-default-pins {
>   			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
>   			J721E_WKUP_IOPAD(0x4c, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
>   		>;
> +		bootph-all;
>   	};
>   
>   	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
> @@ -204,6 +206,7 @@ J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
>   			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
>   			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
>   		>;
> +		bootph-all;
>   	};
>   
>   	main_uart1_pins_default: main-uart1-default-pins {
> @@ -238,6 +241,7 @@ J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
>   			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
>   			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
>   		>;
> +		bootph-all;
>   	};
>   
>   	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> @@ -259,6 +263,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
>   		pinctrl-single,pins = <
>   			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
>   		>;
> +		bootph-all;
>   	};
>   };
>   
> @@ -267,12 +272,14 @@ &wkup_uart0 {
>   	status = "reserved";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	bootph-all;
>   };
>   
>   &mcu_uart0 {
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_uart0_pins_default>;
> +	bootph-all;
>   };
>   
>   &main_uart0 {
> @@ -281,6 +288,7 @@ &main_uart0 {
>   	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_uart0_pins_default>;
> +	bootph-all;
>   };
>   
>   &main_uart1 {
> @@ -379,6 +387,7 @@ &main_sdhci0 {
>   	/* eMMC */
>   	status = "okay";
>   	non-removable;
> +	bootph-all;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
>   };
> @@ -390,6 +399,7 @@ &main_sdhci1 {
>   	pinctrl-names = "default";
>   	vmmc-supply = <&vdd_mmc1>;
>   	vqmmc-supply = <&vdd_sd_dv>;
> +	bootph-all;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
>   };
> @@ -401,11 +411,13 @@ &serdes_ln_ctrl {
>   
>   &usb_serdes_mux {
>   	idle-states = <1>; /* USB0 to SERDES lane 3 */
> +	bootph-all;
>   };
>   
>   &usbss0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_usbss0_pins_default>;
> +	bootph-all;
>   	ti,vbus-divider;
>   	ti,usb2-only;
>   };
> @@ -413,6 +425,7 @@ &usbss0 {
>   &usb0 {
>   	dr_mode = "otg";
>   	maximum-speed = "high-speed";
> +	bootph-all;
>   };
>   
>   &tscadc0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index e78b4622a7d1..291ab9bb414d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -121,6 +121,7 @@ J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
>   			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
>   			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
>   		>;
> +		bootph-all;
>   	};
>   
>   	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
> @@ -137,6 +138,7 @@ J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
>   			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
>   			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
>   		>;
> +		bootph-all;
>   	};
>   };
>   
> @@ -146,6 +148,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
>   			J721E_WKUP_IOPAD(0x98, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
>   			J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
>   		>;
> +		bootph-all;
>   	};
>   };
>   
> @@ -186,6 +189,7 @@ &hbmc {
>   	flash@0,0 {
>   		compatible = "cypress,hyperflash", "cfi-flash";
>   		reg = <0x00 0x00 0x4000000>;
> +		bootph-all;
>   
>   		partitions {
>   			compatible = "fixed-partitions";
> @@ -347,6 +351,7 @@ bucka1: buck1 {
>   				regulator-max-microvolt = <1800000>;
>   				regulator-boot-on;
>   				regulator-always-on;
> +				bootph-all;
>   			};
>   
>   			bucka2: buck2 {
> @@ -520,6 +525,7 @@ partition@800000 {
>   			partition@3fc0000 {
>   				label = "ospi.phypattern";
>   				reg = <0x3fc0000 0x40000>;
> +				bootph-all;
>   			};
>   		};
>   	};
> 


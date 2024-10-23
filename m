Return-Path: <linux-kernel+bounces-377956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8C99AC918
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D29284397
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2C1AB539;
	Wed, 23 Oct 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C1MCYWst"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E851AAE25;
	Wed, 23 Oct 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683303; cv=none; b=IGVhJ1l78dEBEJbEOD+LK/d14h0Nf7GhCmja3ceU/qtNf964J18yPgCNnE514/201G7ro2aukMLeYuf+ZcF4PD+ZZW9VJS9m/9XzXZkelYJji/A1W3x8irlUG8Um8lhHRr+3leX3h7hoYUs9VZcRMxkbdKWC0y7fAQLCCtfGtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683303; c=relaxed/simple;
	bh=tysF3pbK3LQTPrnN635PyUIn7KkoweAqLE9SzYC0a8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MCuYE77lqns5CgWNk5LikTHVGnscOZCJY28acWAnra4F4jYNDcZp5vvmCBCQcH5dbU05v6vsukNZb5N21VIbIF5VuCAGR0lYOFiV1xll+XhK4fnIxD6BO0NhFHD23R+n0fuuH5yI9+IJvwwBaCWcP40YOKCI8c1aIr3oID7x8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C1MCYWst; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NBYtIb110748;
	Wed, 23 Oct 2024 06:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729683295;
	bh=1FiYguMGThHNLA9kFA0q7R/MPGzxBFfJ6/L73aEij8c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=C1MCYWstdBABU7XcD3rpLdWw36KQE7tpoCrmR1WF7FGNYxexKY40g8XdFwJTLqp2P
	 9qscd7CnUXPbJx5WB9Eacv/xm3CEC4dBjiOkVeQhdLDwPPfiV3zcTO4smgxo2ivqPV
	 h3zNK7rkEUrpe74KKHKJ8Iqx1VXMNoq/02nb2p74=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NBYtLQ026165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 06:34:55 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 06:34:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 06:34:54 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NBYocq076796;
	Wed, 23 Oct 2024 06:34:50 -0500
Message-ID: <674deca5-9697-40e2-abce-0d3a2193771c@ti.com>
Date: Wed, 23 Oct 2024 17:04:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] arm64: dts: ti: k3-j721e-sk*: Add bootph-*
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
        <linux-kernel@vger.kernel.org>, Aniket Limaye <a-limaye@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
 <20241023-b4-upstream-bootph-all-v5-11-a974d06370ab@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
Content-Language: en-US
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-11-a974d06370ab@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 23/10/24 12:27, Manorit Chawdhry wrote:
> Adds bootph-* properties to the leaf nodes to enable bootloaders to
> utilise them.
> 
> Following adds bootph-* to:
> - main_uart0, mcu_uart0(DM), wkup_uart0(TIFS) for Traces
> - mmc1, usb0, usb1, ospi0 for enabling various bootmodes.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 6285e8d94dde..69b3d1ed8a21 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -346,6 +346,7 @@ J721E_IOPAD(0x244, PIN_INPUT, 0) /* (R25) MMC1_DAT2 */
>   			J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
>   			J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
>   		>;
> +		bootph-all;
>   	};
>   
>   	main_uart0_pins_default: main-uart0-default-pins {
> @@ -355,6 +356,7 @@ J721E_IOPAD(0x1f4, PIN_OUTPUT, 0) /* (AB1) UART0_RTSn */
>   			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
>   			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
>   		>;
> +		bootph-all;
>   	};
>   
>   	main_uart1_pins_default: main-uart1-default-pins {
> @@ -390,12 +392,14 @@ main_usbss0_pins_default: main-usbss0-default-pins {
>   			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
>   			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
>   		>;
> +		bootph-all;
>   	};
>   
>   	main_usbss1_pins_default: main-usbss1-default-pins {
>   		pinctrl-single,pins = <
>   			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
>   		>;
> +		bootph-all;
>   	};
>   
>   	main_csi_mux_sel_pins_default: main-csi-mux-sel-default-pins {
> @@ -594,6 +598,7 @@ J721E_WKUP_IOPAD(0x24, PIN_INPUT, 0) /* (B22) MCU_OSPI0_D6 */
>   			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 0) /* (G21) MCU_OSPI0_D7 */
>   			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 0) /* (D21) MCU_OSPI0_DQS */
>   		>;
> +		bootph-all;
>   	};
>   
>   	vdd_mmc1_en_pins_default: vdd-mmc1-en-default-pins {
> @@ -622,6 +627,7 @@ J721E_WKUP_IOPAD(0xf4, PIN_OUTPUT, 2)/* (D25) MCU_I3C0_SDA.MCU_UART0_RTSn */
>   			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
>   			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0)/* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
>   		>;
> +		bootph-all;
>   	};
>   
>   	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
> @@ -629,6 +635,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
>   			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
>   			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
>   		>;
> +		bootph-all;
>   	};
>   
>   	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
> @@ -657,6 +664,7 @@ &wkup_uart0 {
>   	status = "reserved";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	bootph-all;
>   };
>   
>   &wkup_i2c0 {
> @@ -821,6 +829,7 @@ &mcu_uart0 {
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_uart0_pins_default>;
> +	bootph-all;
>   };
>   
>   &main_uart0 {
> @@ -829,6 +838,7 @@ &main_uart0 {
>   	pinctrl-0 = <&main_uart0_pins_default>;
>   	/* Shared with ATF on this platform */
>   	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> +	bootph-all;
>   };
>   
>   &main_uart1 {
> @@ -844,6 +854,7 @@ &main_sdhci1 {
>   	vqmmc-supply = <&vdd_sd_dv_alt>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_mmc1_pins_default>;
> +	bootph-all;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
>   };
> @@ -908,6 +919,7 @@ partition@800000 {
>   			partition@3fc0000 {
>   				label = "ospi.phypattern";
>   				reg = <0x3fc0000 0x40000>;
> +				bootph-all;
>   			};
>   		};
>   	};
> @@ -1003,6 +1015,7 @@ &wkup_gpio0 {
>   
>   &usb_serdes_mux {
>   	idle-states = <1>, <1>; /* USB0 to SERDES3, USB1 to SERDES2 */
> +	bootph-all;
>   };
>   
>   &serdes_ln_ctrl {
> @@ -1012,6 +1025,7 @@ &serdes_ln_ctrl {
>   		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
>   		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
>   		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
> +	bootph-all;
>   };
>   
>   &serdes_wiz3 {
> @@ -1050,6 +1064,7 @@ &mhdp {
>   &usbss0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_usbss0_pins_default>;
> +	bootph-all;
>   	ti,vbus-divider;
>   };
>   
> @@ -1058,6 +1073,7 @@ &usb0 {
>   	maximum-speed = "super-speed";
>   	phys = <&serdes3_usb_link>;
>   	phy-names = "cdns3,usb3-phy";
> +	bootph-all;
>   };
>   
>   &serdes2 {
> @@ -1073,6 +1089,7 @@ serdes2_usb_link: phy@1 {
>   &usbss1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_usbss1_pins_default>;
> +	bootph-all;
>   	ti,vbus-divider;
>   };
>   
> @@ -1081,6 +1098,7 @@ &usb1 {
>   	maximum-speed = "super-speed";
>   	phys = <&serdes2_usb_link>;
>   	phy-names = "cdns3,usb3-phy";
> +	bootph-all;
>   };
>   
>   &mcu_cpsw {
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis


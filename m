Return-Path: <linux-kernel+bounces-277473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D75794A1D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811331C2263B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC61B86DE;
	Wed,  7 Aug 2024 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SLky22cU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9681C7B90;
	Wed,  7 Aug 2024 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016264; cv=none; b=NKABCoWD3siheXHHOPICXkNFNJedk/ViDvSEbg+0Sz5WRqFsoQhiRsANTVvnwucSTJdHdau2l3ARl4ff6cvVH7XWIDC3iUURCWUaeBjefAkEItNQDkZwbaT197n/Pq5m3mcnl6InFyIid//Qy+Bdq/TzlrqflEvoLGH9TDnLw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016264; c=relaxed/simple;
	bh=6nKbhKGqU4x760HfR4ycy8xWWlGFEs9QzZNnjphwSkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oVVTf2ihQLh1/m2c6ckYNqnhPkQpCS7Jf4RfCFTDj2qfVmv5arJ2pg9Vr0RQ/0LW6NSlUDmo2o99pReAlZUI++bz8PoEprSRcLDHgJ6qD1UJ+RL6OsXbCzwudyLgB/2a5uQCADIB+dOaWLlUSGG0J23i1QVHPNGUmFbwO0gOqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SLky22cU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4777bZBo059131;
	Wed, 7 Aug 2024 02:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723016255;
	bh=xKov89SVhaZAGqsEwklakJR9H8A3NrcMWQIqof8FtK0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SLky22cUyNYjQnIrRqLpPEZXY9sbIF6NXpOnREpFM1rQjMkBA4kCGSTIAMZUSPKLk
	 cAkPSgj3hueNvLAh9LNpXbd+vc0DvDGku0QAWkw0GPwkIbDoRInrrJvuL3J9OOXo8Q
	 inzvj7VuScq0ZtXkC0bDUzQiwPzlYp2LP7s5y9v0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4777bYD2064881
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 02:37:34 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 02:37:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 02:37:34 -0500
Received: from [172.24.30.93] (lt5cd2489kgj.dhcp.ti.com [172.24.30.93])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4777bUiM088670;
	Wed, 7 Aug 2024 02:37:31 -0500
Message-ID: <f042927d-b502-4124-aaee-4bddd94b8bf2@ti.com>
Date: Wed, 7 Aug 2024 13:07:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: k3-j721e*: Add bootph-* properties
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
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-4-9bc2eccb6952@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240730-b4-upstream-bootph-all-v3-4-9bc2eccb6952@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 7/30/2024 3:23 PM, Manorit Chawdhry wrote:
> Adds bootph-* properties to the leaf nodes to enable U-boot to
> utilise them.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   .../arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 20 ++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi            |  2 ++
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts               | 18 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi          |  5 +++++
>   5 files changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 8230d53cd696..ebc9ab3b6790 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -193,6 +193,7 @@ J721E_IOPAD(0x1c0, PIN_OUTPUT, 1) /* (AA2) SPI0_CS0.UART0_RTSn */
>   			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
>   			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
>   		>;
> [...]
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 0da785be80ff..584badcb796d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -226,6 +226,7 @@ secure_proxy_main: mailbox@32c00000 {
>   			      <0x00 0x32800000 0x00 0x100000>;
>   			interrupt-names = "rx_011";
>   			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			bootph-all;
>   		};
>   
>   		smmu0: iommu@36600000 {
> @@ -2854,5 +2855,6 @@ main_esm: esm@700000 {
>   		compatible = "ti,j721e-esm";
>   		reg = <0x0 0x700000 0x0 0x1000>;
>   		ti,esm-pins = <344>, <345>;
> +		bootph-all;

bootph-all or bootph-pre-ram. Please align with other esm nodes

>   	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 6b6ef6a30614..6ecbf5ee8b78 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> [..]
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 89fbfb21e5d3..b63d48719090 100644
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
> +		bootph-pre-ram;


Please make consistency between pin mux and node.

Here I see pin mux is bootph-pre-ram and mcu_uart is bootph-all

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
> @@ -846,6 +856,7 @@ &main_sdhci1 {
>   	pinctrl-0 = <&main_mmc1_pins_default>;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
> +	bootph-all;
>   };
>   
>   &ospi0 {
> @@ -864,6 +875,7 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <4>;
> +		bootph-all;
>   
>   		partitions {
>   			compatible = "fixed-partitions";


Boot-loader may need to access ospi.phypattern, please add needed tags

> @@ -1003,6 +1015,7 @@ &wkup_gpio0 {
>   
> [...]
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> index 5ba947771b84..86bfc5e21eed 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -151,6 +151,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
>   			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
>   			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
>   		>;
> +		bootph-all;
>   	};
>   
>   	pmic_irq_pins_default: pmic-irq-default-pins {
> @@ -173,6 +174,7 @@ J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
>   			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
>   			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
>   		>;
> +		bootph-all;
>   	};
>   
>   	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-default-pins {
> @@ -192,6 +194,7 @@ J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ5 */
>   			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ6 */
>   			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ7 */
>   		>;
> +		bootph-all;
>   	};
>   };
>   
> @@ -378,6 +381,7 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <0>;
> +		bootph-all;
>   
>   		partitions {
>   			compatible = "fixed-partitions";


Same as above for "ospi.phypattern"

> @@ -440,6 +444,7 @@ &hbmc {
>   	flash@0,0 {
>   		compatible = "cypress,hyperflash", "cfi-flash";
>   		reg = <0x00 0x00 0x4000000>;
> +		bootph-all;
>   
>   		partitions {
>   			compatible = "fixed-partitions";
>


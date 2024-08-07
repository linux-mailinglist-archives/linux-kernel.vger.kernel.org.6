Return-Path: <linux-kernel+bounces-278064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB094AA69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886A81F224B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD181AC6;
	Wed,  7 Aug 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oow3LZcD"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DB8061C;
	Wed,  7 Aug 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041473; cv=none; b=ig4+hEn3NctesyEyxldz5mjMgnNT3ZJvBTSB5ZhHBk2G01Guj21xmRxUYp65Oer3QlmDd9KDRIyfYCtUtUtE7gh8L7K9+WIBTWWpUGHhvdDWmuQRTMxfN5KroHzV+YzxbuJS/SouNOznbghi3Kl+/qRyineQ/JGAcjGwju1A2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041473; c=relaxed/simple;
	bh=GLPYJrPNbqyS8KArfneAWyTtxabMWEXw+EeHsFQAEpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=roIc2aCx47bFehQNkCawmD8nSuk3clTL8jCldYL3Jr+F6TcGneAbcbvV8jlS13CMtz4VybStnHUUKBBB3TU6GoVAW27aK5lFs3Tdi2xpfPQD26JMhGOdfDuT4sl9/CT7rwEbXxv5WGqhXOObUIMKwBg2hJvQ462R6gmvl2FKAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Oow3LZcD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477EbgEX088320;
	Wed, 7 Aug 2024 09:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723041462;
	bh=g9UgdK7bkkvtHzbaL2fuxxfrwV277x/fAkSDFStXMsE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Oow3LZcDSM+ICEcGavaSbbQkWQ1qqr2MHQFV7UElpY0/e1bJJ9iitk6C+YdVLsYuV
	 tyd5QAfkOFE9vhPuTcDmLvaIGmh9a+UptBvxUB27VARMyl+idt4l/gFs65qagxFNTc
	 HiBxLvSz3gRHsRWTLEoaZ38XlsGB0Kh0znTsBAg8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477EbgRS049233
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 09:37:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 09:37:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 09:37:42 -0500
Received: from [172.24.20.129] (lt5cd112gt3k.dhcp.ti.com [172.24.20.129])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477EbbK6004349;
	Wed, 7 Aug 2024 09:37:38 -0500
Message-ID: <1cee1ebf-8281-440a-bf45-baa9b0e3b68f@ti.com>
Date: Wed, 7 Aug 2024 20:07:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j7200*: Add bootph-* properties
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
	<s-vadapalli@ti.com>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-5-9bc2eccb6952@ti.com>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <20240730-b4-upstream-bootph-all-v3-5-9bc2eccb6952@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Manorit,

On 7/30/2024 3:23 PM, Manorit Chawdhry wrote:
> Adds bootph-* properties to the leaf nodes to enable U-boot to
> utilise them.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   .../arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 20 ++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi            |  2 ++
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 10 ++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi          |  7 +++++++
>   4 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6593c5da82c0..ec522595fc83 100644
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
> @@ -159,6 +161,7 @@ wkup_gpio_pins_default: wkup-gpio-default-pins {
>   		pinctrl-single,pins = <
>   			J721E_WKUP_IOPAD(0x70, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_6 */
>   		>;
> +		bootph-all;
>   	};
>   
>   	mcu_mdio_pins_default: mcu-mdio1-default-pins {
> @@ -204,6 +207,7 @@ J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
>   			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
>   			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
>   		>;
> +		bootph-all;
>   	};
>   
>   	main_uart1_pins_default: main-uart1-default-pins {
> @@ -238,6 +242,7 @@ J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
>   			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
>   			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
>   		>;
> +		bootph-all;
>   	};
>   
>   	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> @@ -259,6 +264,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
>   		pinctrl-single,pins = <
>   			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
>   		>;
> +		bootph-all;
>   	};
>   };
>   
> @@ -267,12 +273,14 @@ &wkup_uart0 {
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
> @@ -281,6 +289,7 @@ &main_uart0 {
>   	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_uart0_pins_default>;
> +	bootph-all;
>   };
>   
>   &main_uart1 {
> @@ -310,6 +319,7 @@ &wkup_gpio0 {
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&wkup_gpio_pins_default>;
> +	bootph-all;
>   };
>   
>   &mcu_cpsw {
> @@ -341,6 +351,7 @@ exp1: gpio@20 {
>   		reg = <0x20>;
>   		gpio-controller;
>   		#gpio-cells = <2>;
> +		bootph-all;
>   	};
>   
>   	exp2: gpio@22 {
> @@ -348,6 +359,7 @@ exp2: gpio@22 {
>   		reg = <0x22>;
>   		gpio-controller;
>   		#gpio-cells = <2>;
> +		bootph-all;
>   	};
>   };
>   
> @@ -381,6 +393,7 @@ &main_sdhci0 {
>   	non-removable;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
> +	bootph-all;
>   };
>   
>   &main_sdhci1 {
> @@ -392,15 +405,18 @@ &main_sdhci1 {
>   	vqmmc-supply = <&vdd_sd_dv>;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
> +	bootph-all;
>   };
>   
>   &serdes_ln_ctrl {
>   	idle-states = <J7200_SERDES0_LANE0_PCIE1_LANE0>, <J7200_SERDES0_LANE1_PCIE1_LANE1>,
>   		      <J7200_SERDES0_LANE2_QSGMII_LANE1>, <J7200_SERDES0_LANE3_IP4_UNUSED>;
> +	bootph-all;
>   };
>   
>   &usb_serdes_mux {
>   	idle-states = <1>; /* USB0 to SERDES lane 3 */
> +	bootph-all;
>   };
>   
>   &usbss0 {
> @@ -408,11 +424,13 @@ &usbss0 {
>   	pinctrl-0 = <&main_usbss0_pins_default>;
>   	ti,vbus-divider;
>   	ti,usb2-only;
> +	bootph-all;
>   };
>   
>   &usb0 {
>   	dr_mode = "otg";
>   	maximum-speed = "high-speed";
> +	bootph-all;
>   };
>   
>   &tscadc0 {
> @@ -432,6 +450,7 @@ serdes0_pcie_link: phy@0 {
>   		#phy-cells = <0>;
>   		cdns,phy-type = <PHY_TYPE_PCIE>;
>   		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
> +		bootph-all;
>   	};
>   
>   	serdes0_qsgmii_link: phy@1 {
> @@ -440,6 +459,7 @@ serdes0_qsgmii_link: phy@1 {
>   		#phy-cells = <0>;
>   		cdns,phy-type = <PHY_TYPE_QSGMII>;
>   		resets = <&serdes_wiz0 3>;
> +		bootph-all;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 9386bf3ef9f6..b95656942412 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -136,6 +136,7 @@ secure_proxy_main: mailbox@32c00000 {
>   			      <0x00 0x32800000 0x00 0x100000>;
>   			interrupt-names = "rx_011";
>   			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			bootph-all;
>   		};
>   
>   		hwspinlock: spinlock@30e00000 {
> @@ -1528,5 +1529,6 @@ main_esm: esm@700000 {
>   		compatible = "ti,j721e-esm";
>   		reg = <0x0 0x700000 0x0 0x1000>;
>   		ti,esm-pins = <656>, <657>;
> +		bootph-all;
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 5097d192c2b2..f8a5ad4737da 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -21,16 +21,19 @@ dmsc: system-controller@44083000 {

Referring to the thread from v2 [0], I see that you have removed the 
bootph-all from the parent dmsc node. With current patch j7200-evm fails 
to boot (Stuck somewhere in tispl or right after that) as discussed in 
the same thread [0].

I have boot tested this patch (SD boot) and the device boots with an 
additional bootph-all at dmsc node.

I assume the removal was done intentionally, meaning we intend to fix 
the bug in u-boot or carry the one extra bootph-all there. If NOT, 
please add the same in the parent dmsc node here as well.

So taking care of the above,

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

[0]: https://lore.kernel.org/all/20240709084857.nf7c57mi6miajeau@uda0497581/

>   		k3_pds: power-controller {
>   			compatible = "ti,sci-pm-domain";
>   			#power-domain-cells = <2>;
> +			bootph-all;
>   		};
>   
>   		k3_clks: clock-controller {
>   			compatible = "ti,k2g-sci-clk";
>   			#clock-cells = <2>;
> +			bootph-all;
>   		};
>   
>   		k3_reset: reset-controller {
>   			compatible = "ti,sci-reset";
>   			#reset-cells = <2>;
> +			bootph-all;
>   		};
>   	};
>   
> @@ -45,6 +48,7 @@ mcu_timer0: timer@40400000 {
>   		assigned-clock-parents = <&k3_clks 35 2>;
>   		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
>   		ti,timer-pwm;
> +		bootph-pre-ram;
>   	};
>   
>   	mcu_timer1: timer@40410000 {
> @@ -191,6 +195,7 @@ wkup_conf: bus@43000000 {
>   		chipid: chipid@14 {
>   			compatible = "ti,am654-chipid";
>   			reg = <0x14 0x4>;
> +			bootph-all;
>   		};
>   	};
>   
> @@ -349,6 +354,7 @@ mcu_ringacc: ringacc@2b800000 {
>   			ti,sci = <&dmsc>;
>   			ti,sci-dev-id = <235>;
>   			msi-parent = <&main_udmass_inta>;
> +			bootph-all;
>   		};
>   
>   		mcu_udmap: dma-controller@285c0000 {
> @@ -373,6 +379,7 @@ mcu_udmap: dma-controller@285c0000 {
>   			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
>   						<0x0b>; /* RX_HCHAN */
>   			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
> +			bootph-all;
>   		};
>   	};
>   
> @@ -389,6 +396,7 @@ secure_proxy_mcu: mailbox@2a480000 {
>   		 * firmware on non-MPU processors
>   		 */
>   		status = "disabled";
> +		bootph-pre-ram;
>   	};
>   
>   	mcu_cpsw: ethernet@46000000 {
> @@ -534,6 +542,7 @@ hbmc_mux: mux-controller@47000004 {
>   			reg = <0x00 0x47000004 0x00 0x4>;
>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x0 0x2>; /* HBMC select */
> +			bootph-pre-ram;
>   		};
>   
>   		hbmc: hyperbus@47034000 {
> @@ -652,6 +661,7 @@ wkup_vtm0: temperature-sensor@42040000 {
>   		      <0x00 0x42050000 0x00 0x350>;
>   		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>   		#thermal-sensor-cells = <1>;
> +		bootph-pre-ram;
>   	};
>   
>   	mcu_esm: esm@40800000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 21fe194a5766..d78f86889bf9 100644
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
> @@ -163,6 +166,7 @@ main_i2c0_pins_default: main-i2c0-default-pins {
>   			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
>   			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
>   		>;
> +		bootph-all;
>   	};
>   
>   	main_mcan0_pins_default: main-mcan0-default-pins {
> @@ -186,6 +190,7 @@ &hbmc {
>   	flash@0,0 {
>   		compatible = "cypress,hyperflash", "cfi-flash";
>   		reg = <0x00 0x00 0x4000000>;
> +		bootph-all;
>   
>   		partitions {
>   			compatible = "fixed-partitions";
> @@ -330,6 +335,7 @@ bucka1: buck1 {
>   				regulator-max-microvolt = <1800000>;
>   				regulator-boot-on;
>   				regulator-always-on;
> +				bootph-all;
>   			};
>   
>   			bucka2: buck2 {
> @@ -464,6 +470,7 @@ flash@0 {
>   		cdns,tchsh-ns = <60>;
>   		cdns,tslch-ns = <60>;
>   		cdns,read-delay = <4>;
> +		bootph-all;
>   
>   		partitions {
>   			compatible = "fixed-partitions";
> 


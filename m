Return-Path: <linux-kernel+bounces-277315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6349D949F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852D11C22945
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA0191F93;
	Wed,  7 Aug 2024 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q0ddgFyW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093CB3B7AC;
	Wed,  7 Aug 2024 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008684; cv=none; b=Cp/EFxDtSvVgXaFLfTgJBm6gQ550lkB0a4ze9xKoCDEnYupG8HiJZE2Pmaa5nAKck5rT3u7hx3VsSdISw/FIvdVU8d7IEamyUv2rlVY5VdFDrLReBdd8N67kIxRWmLyPOdPDsPKE6KhZWjkJRz6Av9fhyvHOOdbl91OGDFaa0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008684; c=relaxed/simple;
	bh=/oWiYlkev6nrYYBV/Ni1YKu39qVSVKe7YdkxC3EA0FQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejZ3ZxF31vKLtQbtYWo+T9ddDHE16UPrB7mGaqw6pgJQy1Vzd5ggL0wNhv3CW3HkMJXVmeOuKT1s2fN8zto/qZUQwlUMRORVIzqEpvCFIHBVoP946j/WjjtqsCkRrZtQ4Ja4TLIw7tG5NKr91fOcG8jz8KdGQM2EzjI7FWGcT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q0ddgFyW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4775VFYf062450;
	Wed, 7 Aug 2024 00:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723008675;
	bh=tZgdRmUoY4g/vQpt9tzoVlXnKNWDJKDXAvw6Y/mjlDc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Q0ddgFyWsTSlQXYI2xlDrEgUGM6M/7lMS0BRmnO20KhJXH3yjEMdhpPtwphicNOmY
	 tR6ubwBEc+cyK2NmmbLS2E/RIqRZR2YW+XM0ZroT03JUq0K5Ok+z+3fmUXK7R7VV7t
	 Vh592xYrInESjTtXUx/JjtYvemJi5iqHB6q0HlcQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4775VFF1125664
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 00:31:15 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 00:31:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 00:31:14 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4775VDTn020877;
	Wed, 7 Aug 2024 00:31:14 -0500
Date: Wed, 7 Aug 2024 11:01:13 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240807053113.xy7ghmuttpahzv7n@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 09:43-20240806, Andrew Davis wrote:
> On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > utilise them.
> 
> U-Boot? Let's try to pretend like this is a generic property and
> just say "bootloader" :)
>
> Thinking out loud, what happens when we want to re-use these DT
> source files in Zephyr, or some other software, will we keep adding
> these new metadata tags?.. bootph-* and other "domain info" might
> better belong to some higher level device tree source (System
> Device Tree I'd guess, time to add Lopper to kernel? :D)
> 
> For now, lgtm,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>

Thanks for reviewing! Would update the commit description.

Regards,
Manorit

> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 14 ++++++++++++++
> >   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             |  2 ++
> >   arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 11 +++++++++++
> >   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi           |  2 ++
> >   4 files changed, 29 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> > index c5a0b7cbb14f..6ce14f9e087b 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> > @@ -138,6 +138,7 @@ J721S2_IOPAD(0x044, PIN_OUTPUT, 14) /* (Y26) MCASP0_AXR1.UART8_RTSn */
> >   			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
> >   			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
> >   		>;
> > +		bootph-all;
> >   	};
> >   	main_i2c3_pins_default: main-i2c3-default-pins {
> > @@ -165,6 +166,7 @@ J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
> >   			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
> >   			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
> >   		>;
> > +		bootph-all;
> >   	};
> >   	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> > @@ -177,6 +179,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
> >   		pinctrl-single,pins = <
> >   			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
> >   		>;
> > +		bootph-all;
> >   	};
> >   	main_mcan3_pins_default: main-mcan3-default-pins {
> > @@ -200,6 +203,7 @@ wkup_uart0_pins_default: wkup-uart0-default-pins {
> >   			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
> >   			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
> >   		>;
> > +		bootph-all;
> >   	};
> >   	mcu_uart0_pins_default: mcu-uart0-default-pins {
> > @@ -209,6 +213,7 @@ J721S2_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (D25) WKUP_GPIO0_15.MCU_UART0_RTSn */
> >   			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
> >   			J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
> >   		>;
> > +		bootph-all;
> >   	};
> >   	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
> > @@ -301,6 +306,7 @@ J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
> >   			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
> >   			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
> >   		>;
> > +		bootph-all;
> >   	};
> >   };
> > @@ -316,12 +322,14 @@ &wkup_uart0 {
> >   	status = "reserved";
> >   	pinctrl-names = "default";
> >   	pinctrl-0 = <&wkup_uart0_pins_default>;
> > +	bootph-all;
> >   };
> >   &mcu_uart0 {
> >   	status = "okay";
> >   	pinctrl-names = "default";
> >   	pinctrl-0 = <&mcu_uart0_pins_default>;
> > +	bootph-all;
> >   };
> >   &main_uart8 {
> > @@ -330,6 +338,7 @@ &main_uart8 {
> >   	pinctrl-0 = <&main_uart8_pins_default>;
> >   	/* Shared with TFA on this platform */
> >   	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
> > +	bootph-all;
> >   };
> >   &main_i2c0 {
> > @@ -385,6 +394,7 @@ &main_sdhci0 {
> >   	non-removable;
> >   	ti,driver-strength-ohm = <50>;
> >   	disable-wp;
> > +	bootph-all;
> >   };
> >   &main_sdhci1 {
> > @@ -395,6 +405,7 @@ &main_sdhci1 {
> >   	disable-wp;
> >   	vmmc-supply = <&vdd_mmc1>;
> >   	vqmmc-supply = <&vdd_sd_dv>;
> > +	bootph-all;
> >   };
> >   &mcu_cpsw {
> > @@ -446,11 +457,13 @@ &usbss0 {
> >   	pinctrl-names = "default";
> >   	ti,vbus-divider;
> >   	ti,usb2-only;
> > +	bootph-all;
> >   };
> >   &usb0 {
> >   	dr_mode = "otg";
> >   	maximum-speed = "high-speed";
> > +	bootph-all;
> >   };
> >   &ospi1 {
> > @@ -469,6 +482,7 @@ flash@0 {
> >   		cdns,tchsh-ns = <60>;
> >   		cdns,tslch-ns = <60>;
> >   		cdns,read-delay = <2>;
> > +		bootph-all;
> >   	};
> >   };
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > index 9ed6949b40e9..0ea6817de65c 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > @@ -816,6 +816,7 @@ secure_proxy_main: mailbox@32c00000 {
> >   			      <0x00 0x32800000 0x00 0x100000>;
> >   			interrupt-names = "rx_011";
> >   			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > +			bootph-all;
> >   		};
> >   		hwspinlock: spinlock@30e00000 {
> > @@ -1225,6 +1226,7 @@ usb0: usb@6000000 {
> >   			interrupt-names = "host", "peripheral", "otg";
> >   			maximum-speed = "super-speed";
> >   			dr_mode = "otg";
> > +			bootph-all;
> >   		};
> >   	};
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> > index 8feb42c89e47..8345313f8d94 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> > @@ -21,16 +21,19 @@ sms: system-controller@44083000 {
> >   		k3_pds: power-controller {
> >   			compatible = "ti,sci-pm-domain";
> >   			#power-domain-cells = <2>;
> > +			bootph-all;
> >   		};
> >   		k3_clks: clock-controller {
> >   			compatible = "ti,k2g-sci-clk";
> >   			#clock-cells = <2>;
> > +			bootph-all;
> >   		};
> >   		k3_reset: reset-controller {
> >   			compatible = "ti,sci-reset";
> >   			#reset-cells = <2>;
> > +			bootph-all;
> >   		};
> >   	};
> > @@ -43,6 +46,7 @@ wkup_conf: bus@43000000 {
> >   		chipid: chipid@14 {
> >   			compatible = "ti,am654-chipid";
> >   			reg = <0x14 0x4>;
> > +			bootph-all;
> >   		};
> >   	};
> > @@ -59,6 +63,7 @@ secure_proxy_sa3: mailbox@43600000 {
> >   		 * firmware on non-MPU processors
> >   		 */
> >   		status = "disabled";
> > +		bootph-pre-ram;
> >   	};
> >   	mcu_ram: sram@41c00000 {
> > @@ -170,6 +175,7 @@ mcu_timer0: timer@40400000 {
> >   		ti,timer-pwm;
> >   		/* Non-MPU Firmware usage */
> >   		status = "reserved";
> > +		bootph-pre-ram;
> >   	};
> >   	mcu_timer1: timer@40410000 {
> > @@ -362,6 +368,7 @@ wkup_i2c0: i2c@42120000 {
> >   		clock-names = "fck";
> >   		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
> >   		status = "disabled";
> > +		bootph-all;
> >   	};
> >   	mcu_i2c0: i2c@40b00000 {
> > @@ -474,6 +481,7 @@ mcu_ringacc: ringacc@2b800000 {
> >   			ti,sci = <&sms>;
> >   			ti,sci-dev-id = <272>;
> >   			msi-parent = <&main_udmass_inta>;
> > +			bootph-all;
> >   		};
> >   		mcu_udmap: dma-controller@285c0000 {
> > @@ -497,6 +505,7 @@ mcu_udmap: dma-controller@285c0000 {
> >   			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
> >   						<0x0b>; /* RX_HCHAN */
> >   			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
> > +			bootph-all;
> >   		};
> >   	};
> > @@ -513,6 +522,7 @@ secure_proxy_mcu: mailbox@2a480000 {
> >   		 * firmware on non-MPU processors
> >   		 */
> >   		status = "disabled";
> > +		bootph-pre-ram;
> >   	};
> >   	mcu_cpsw: ethernet@46000000 {
> > @@ -667,6 +677,7 @@ wkup_vtm0: temperature-sensor@42040000 {
> >   		      <0x00 0x42050000 0x0 0x350>;
> >   		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
> >   		#thermal-sensor-cells = <1>;
> > +		bootph-pre-ram;
> >   	};
> >   	mcu_r5fss0: r5fss@41000000 {
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> > index 82aacc01e8fe..dfcc223809e7 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> > @@ -170,6 +170,7 @@ J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
> >   			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
> >   			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
> >   		>;
> > +		bootph-all;
> >   	};
> >   };
> > @@ -445,6 +446,7 @@ flash@0 {
> >   		cdns,tchsh-ns = <60>;
> >   		cdns,tslch-ns = <60>;
> >   		cdns,read-delay = <4>;
> > +		bootph-all;
> >   	};
> >   };
> > 


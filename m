Return-Path: <linux-kernel+bounces-300140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009E795DF47
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55070B219FA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C5056742;
	Sat, 24 Aug 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MvD3kLAY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E06A94A;
	Sat, 24 Aug 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724521974; cv=none; b=HEyoE8Wv2102P7+6wHdGBXXbbWUeIobP5Y+78NHvnrQ/9/3VGKORXCd8qmFPBD3ljYSCxCjm1clg9u/xgFKpvmLQ7S3i7PdQc9DqtXaDawn+6mnYLHd5rB3A8QTOim4/HTSS8c9XSQCjZImUrIfWTIHK7InS3MCZ9Eg2Y6CuydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724521974; c=relaxed/simple;
	bh=pa9gJpGkNK2r8gz9CD/EssdpxFbbCosa7Ga21lfUJYA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwR4VNR/UF21s99Ie7CODpcW4kxnO9A8CFjtaDWjfsS+fhPnoGaE4y3KPdtmqyWgh4Jtr5IIZ1MQSMpD7Dw0js0C5tzn0ZCp3XupXab8jQKWgEIClg44LAEACRBJniYUb8DpUz77BIJQ9lvMeE1CBKDjDJ3SVR2j0GHsqpgly6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MvD3kLAY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OHqkOk070295;
	Sat, 24 Aug 2024 12:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724521966;
	bh=jO0MkAgNMnPyrPnXukhqYUmiGdHESMdj9+wueKhyK/E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MvD3kLAYgUxtSilyPciDtSa2m31VyjT/EVM8pDOBuFtO98LidvZmxuEtYem9peJ8O
	 B2L0fAvKGn/08JTRUrL46CBPgCXepZgcaTEx2sMQIcY9GCiKOwu917U1zyV4wJN265
	 AXXjbIoqEu7CwAWXv+NT2MOywhPnJChTpv2qPXkA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OHqkDs106433
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 12:52:46 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 12:52:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 12:52:46 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OHqk1p028421;
	Sat, 24 Aug 2024 12:52:46 -0500
Date: Sat, 24 Aug 2024 12:52:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: ti: k3-j784s4*: Remove bootph
 properties from parent nodes
Message-ID: <20240824175246.jb6pis4vbx7n2wdp@easter>
References: <20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com>
 <20240814-b4-upstream-bootph-all-v4-2-f2b462000f25@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814-b4-upstream-bootph-all-v4-2-f2b462000f25@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:17-20240814, Manorit Chawdhry wrote:
> Removes bootph-* properties from parent nodes and adds bootph for other
> bootloader nodes.

Why? What is the rationale for the change please?

> 
> Also moves bootph from mcu_timer1 to mcu_timer0 as that is the one that
> is used in bootloader.

Multiple patches please - the above sounds like a specific bug fix.

> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 10 +---------
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 10 ++++++----
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index ffa38f41679d..08f4791a3ee8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -334,7 +334,6 @@ &wkup_gpio0 {
>  };
>  
>  &main_pmx0 {
> -	bootph-all;
>  	main_cpsw2g_default_pins: main-cpsw2g-default-pins {
>  		pinctrl-single,pins = <
>  			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
> @@ -461,7 +460,6 @@ J784S4_IOPAD(0x078, PIN_OUTPUT, 1) /* (AH37) MCAN2_RX.AUDIO_EXT_REFCLK1 */
>  };
>  
>  &wkup_pmx2 {
> -	bootph-all;
>  	wkup_uart0_pins_default: wkup-uart0-default-pins {
>  		bootph-all;
>  		pinctrl-single,pins = <
> @@ -577,7 +575,6 @@ J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
>  };
>  
>  &wkup_pmx0 {
> -	bootph-all;
>  	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
>  		bootph-all;
>  		pinctrl-single,pins = <
> @@ -597,7 +594,6 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
>  };
>  
>  &wkup_pmx1 {
> -	bootph-all;
>  	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
>  		bootph-all;
>  		pinctrl-single,pins = <
> @@ -668,6 +664,7 @@ bucka12: buck12 {
>  				regulator-max-microvolt = <1100000>;
>  				regulator-boot-on;
>  				regulator-always-on;
> +				bootph-pre-ram;
>  			};
>  
>  			bucka3: buck3 {
> @@ -769,18 +766,15 @@ &ufs_wrapper {
>  };
>  
>  &fss {
> -	bootph-all;
>  	status = "okay";
>  };
>  
>  &ospi0 {
> -	bootph-all;
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
>  
>  	flash@0 {
> -		bootph-all;
>  		compatible = "jedec,spi-nor";
>  		reg = <0x0>;
>  		spi-tx-bus-width = <8>;
> @@ -837,13 +831,11 @@ partition@3fc0000 {
>  };
>  
>  &ospi1 {
> -	bootph-all;
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
>  
>  	flash@0 {
> -		bootph-all;
>  		compatible = "jedec,spi-nor";
>  		reg = <0x0>;
>  		spi-tx-bus-width = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index f3a6ed1c979d..6409e702ffd4 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -7,7 +7,6 @@
>  
>  &cbass_mcu_wakeup {
>  	sms: system-controller@44083000 {
> -		bootph-all;
>  		compatible = "ti,k2g-sci";
>  		ti,host-id = <12>;
>  
> @@ -39,7 +38,6 @@ k3_reset: reset-controller {
>  	};
>  
>  	wkup_conf: bus@43000000 {
> -		bootph-all;
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -59,6 +57,8 @@ secure_proxy_sa3: mailbox@43600000 {
>  		reg = <0x00 0x43600000 0x00 0x10000>,
>  		      <0x00 0x44880000 0x00 0x20000>,
>  		      <0x00 0x44860000 0x00 0x20000>;
> +		bootph-pre-ram;
> +
>  		/*
>  		 * Marked Disabled:
>  		 * Node is incomplete as it is meant for bootloaders and
> @@ -172,13 +172,13 @@ mcu_timer0: timer@40400000 {
>  		assigned-clocks = <&k3_clks 35 2>;
>  		assigned-clock-parents = <&k3_clks 35 3>;
>  		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
> +		bootph-all;
>  		ti,timer-pwm;
>  		/* Non-MPU Firmware usage */
>  		status = "reserved";
>  	};
>  
>  	mcu_timer1: timer@40410000 {
> -		bootph-all;
>  		compatible = "ti,am654-timer";
>  		reg = <0x00 0x40410000 0x00 0x400>;
>  		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
> @@ -458,7 +458,6 @@ mcu_spi2: spi@40320000 {
>  	};
>  
>  	mcu_navss: bus@28380000 {
> -		bootph-all;
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -515,6 +514,8 @@ secure_proxy_mcu: mailbox@2a480000 {
>  		reg = <0x00 0x2a480000 0x00 0x80000>,
>  		      <0x00 0x2a380000 0x00 0x80000>,
>  		      <0x00 0x2a400000 0x00 0x80000>;
> +		bootph-pre-ram;
> +
>  		/*
>  		 * Marked Disabled:
>  		 * Node is incomplete as it is meant for bootloaders and
> @@ -632,6 +633,7 @@ wkup_vtm0: temperature-sensor@42040000 {
>  		      <0x00 0x42050000 0x00 0x350>;
>  		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
>  		#thermal-sensor-cells = <1>;
> +		bootph-pre-ram;
>  	};
>  
>  	tscadc0: tscadc@40200000 {
> 
> -- 
> 2.46.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


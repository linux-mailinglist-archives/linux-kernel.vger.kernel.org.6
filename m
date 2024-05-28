Return-Path: <linux-kernel+bounces-191984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D98D16DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62264B20968
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE613D25E;
	Tue, 28 May 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jQyHaL5Z"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0A13CABD;
	Tue, 28 May 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887142; cv=none; b=Ycoi4tgUsFKi0mNcTquEu9TnK0P4/892Wbl7FdMA9Ie7Jrx7rVKg6Z0kQmo2zfIF9NwNGO+ArZ4i43b/h6shTEtvta+NZRsGfsjfZNgKLhbmic1q7pJAWnN3so16zkGPrW8ZKPTPejvz4Bi5AXu71v1DgYhNiCweR5RrI76ry30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887142; c=relaxed/simple;
	bh=8GQkbr4j0tRLacOWO5ZQmZjV2Vmf8J/pLK8dEFNmIBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qlzFxNb3zEVmZMa65qiKi1UQAUxM0kzp59QmU+UigeMVLP+mV0/V19yiUg7OYS2DJ1Y6ltOwIykyFllMBhds+vr8WvlM10llchswK4S9XIJrp+Kxt94Vohh2GUDTDgUhsPfgpevHwkO6OBkqzGAXE3DIPhQfP89Zjb71zcutIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jQyHaL5Z; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S95X0M122830;
	Tue, 28 May 2024 04:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716887133;
	bh=PQBf9VM1JhjW8t0EFmhFYqdOoaoFxuVJWJJ5M4/99UM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jQyHaL5Z5IzT0ZSznpUtB+zIMC3Oid2QwmwAWMUvGvjMwpMyDTkEtqEcO8ufpo/Q4
	 IfvAm3Eg0H1ukLtex5aFCEeaXtOPWvRqNmBNQo/E+HQlTcc3BgazNTMaYWtqYgpa+m
	 8ADJErz1mE3hC8sDO9ZdQPZ7jIqOdkpW+j0agGSU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S95X64074304
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 04:05:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 04:05:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 04:05:33 -0500
Received: from [172.24.27.209] (lt5cd112gt3k.dhcp.ti.com [172.24.27.209])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S95RDu026167;
	Tue, 28 May 2024 04:05:28 -0500
Message-ID: <3e478ecc-33b8-4aa6-b984-67877864e900@ti.com>
Date: Tue, 28 May 2024 14:35:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: ti: k3-j7200*: Add bootph-* properties
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
 Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>
References: <20240507-b4-upstream-bootph-all-v1-0-c6d52651856f@ti.com>
 <20240507-b4-upstream-bootph-all-v1-5-c6d52651856f@ti.com>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <20240507-b4-upstream-bootph-all-v1-5-c6d52651856f@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Manorit,

Had some comments below:
(Re-sending coz I forgot to change to plain-text formatting and the 
mailing-list rejected it)


On 5/7/2024 3:14 PM, Manorit Chawdhry wrote:
> Adds bootph-* properties to the leaf nodes to enable U-boot to
> utilise them.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   .../boot/dts/ti/k3-j7200-common-proc-board.dts     | 23 ++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |  2 ++
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    | 10 ++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  8 ++++++++
>   4 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6593c5da82c0..f7b96e8d6462 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts

[...]

>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 657f9cc9f4ea..111eba71ed33 100644
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
> @@ -1538,5 +1539,6 @@ main_esm: esm@700000 {
>   		compatible = "ti,j721e-esm";
>   		reg = <0x0 0x700000 0x0 0x1000>;
>   		ti,esm-pins = <656>, <657>;
> +		bootph-all;

Should this be bootph-pre-ram?

>   	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 7cf21c99956e..1e346451ee35 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -21,16 +21,19 @@ dmsc: system-controller@44083000 {

Do we need to add bootph-all property to the parent "dmsc" node too?

For some reason, for me, boot is failing without the bootph-all property 
in the parent "dmsc" node here, even though it;s added to the child 
nodes below

Failing logs with current patch (boot gets stuck) : [0]

If I ONLY add the bootph-all property to the dmsc node as well, the 
device boots up just fine.


[0]: https://gist.github.com/aniket-l/a33a2e5d71432f6824310c8658929b40

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
> @@ -187,6 +191,7 @@ wkup_conf: bus@43000000 {
>   		chipid: chipid@14 {
>   			compatible = "ti,am654-chipid";
>   			reg = <0x14 0x4>;
> +			bootph-all;
>   		};
>   	};
>   
> @@ -347,6 +352,7 @@ mcu_ringacc: ringacc@2b800000 {
>   			ti,sci = <&dmsc>;
>   			ti,sci-dev-id = <235>;
>   			msi-parent = <&main_udmass_inta>;
> +			bootph-all;
>   		};
>   
>   		mcu_udmap: dma-controller@285c0000 {
> @@ -371,6 +377,7 @@ mcu_udmap: dma-controller@285c0000 {
>   			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
>   						<0x0b>; /* RX_HCHAN */
>   			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
> +			bootph-all;
>   		};
>   	};
>   
> @@ -387,6 +394,7 @@ secure_proxy_mcu: mailbox@2a480000 {
>   		 * firmware on non-MPU processors
>   		 */
>   		status = "disabled";
> +		bootph-pre-ram;
>   	};
>   
>   	mcu_cpsw: ethernet@46000000 {
> @@ -530,6 +538,7 @@ hbmc_mux: mux-controller@47000004 {
>   			reg = <0x00 0x47000004 0x00 0x4>;
>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x0 0x2>; /* HBMC select */
> +			bootph-all;
>   		};
>   
>   		hbmc: hyperbus@47034000 {
> @@ -648,6 +657,7 @@ wkup_vtm0: temperature-sensor@42040000 {
>   		      <0x00 0x42050000 0x00 0x350>;
>   		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>   		#thermal-sensor-cells = <1>;
> +		bootph-all;

Should this be bootph-pre-ram?

>   	};
>   
>   	mcu_esm: esm@40800000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 7e6a584ac6f0..a875a79e95c6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -15,6 +15,7 @@ memory@80000000 {
>   		/* 4G RAM */
>   		reg = <0x00 0x80000000 0x00 0x80000000>,
>   		      <0x08 0x80000000 0x00 0x80000000>;
> +	  bootph-all;

Can you add the right indentation here?

>   	};
>   
>   	reserved_memory: reserved-memory {
> @@ -120,6 +121,7 @@ J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
>   			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
>   			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
>   		>;
> +		bootph-all;
>   	};
>   
>   	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
> @@ -136,6 +138,7 @@ J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
>   			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
>   			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
>   		>;
> +		bootph-all;
>   	};
>   };
>   
[...]




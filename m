Return-Path: <linux-kernel+bounces-378311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294AB9ACE47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83212814C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E421D3590;
	Wed, 23 Oct 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jvyLBVS8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4601D278A;
	Wed, 23 Oct 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695931; cv=none; b=WyWs0ko55dqoBjPu90EwdUjRrmJsOhydlbwO5Qo0GjIjDIZEtawQsw+u55E87sOZ5RuFD+Gylk/PhUp81fp2sF2pmvW7l4muWURiZVBiNQZLfgtyqvBGFbM+p7P1INOHU8J/Qi5Ye4Y7Wlvlkv6HEPZkP1WRDw7fF7PhulCajDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695931; c=relaxed/simple;
	bh=GnQXAr70wzJVnk/mn57v4kjZEEIUVdMGYwOK2pJ8TbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ODT5ycOgO7xAt9w+TOqFYsYoxb5LqN0V4diEAtk8raH6nZgqbFID8kYODi6iY4eeLHBaAeYVJAwFlCmO8Jh7P7jy0yXp2ByLYD805V3zDiyef978lhHJREd4eGXfcPY7AKY2EJ49vv9QBw32MyTz2Lv6uz2T4ltYHmNQRk8ZGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jvyLBVS8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NF5LMN071286;
	Wed, 23 Oct 2024 10:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729695921;
	bh=cxfnVxjxs+e2TMfqcU/zti9/A8hiBCMmmh5nnYqaFHY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jvyLBVS8exSaB5VCINBrlNUsLaKuPIwkeN/K9p4A9hFhKP2n5Xxz5bwp5Oo9/N2mw
	 pLZ5m6vyBWr0A9Iusqv6QadYEvWvVrqVFlvYclX/tj9zFO8Os95DfkK70x/B7i9OMU
	 JmcvsqQWNBcQPmt6pHNrrqyuKWoF/aMXhUy396oI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NF5LJS006302
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 10:05:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 10:05:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 10:05:21 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NF5GnA065172;
	Wed, 23 Oct 2024 10:05:17 -0500
Message-ID: <942f988f-8228-43e0-9b29-41fccddcaaf1@ti.com>
Date: Wed, 23 Oct 2024 20:35:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] arm64: dts: ti: k3-j7200: Add bootph-*
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
 <20241023-b4-upstream-bootph-all-v5-6-a974d06370ab@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-6-a974d06370ab@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 23/10/24 12:27, Manorit Chawdhry wrote:
> Adds bootph-* properties to the leaf nodes to enable bootloaders to
> utilise them.
> 
> Following adds bootph-* to
> - System controller nodes that allow controlling power domain, clocks, etc.
> - secure_proxy_sa3/secure_proxy_main mboxes for communication with
>    System Controller
> - mcu_ringacc/mcu_udmap for DMA to SMS
> - chipid for detection soc information.
> - mcu_timer0 for bootloader tick-timer.
> - hbmc_mux for enabling Hyperflash support
> - ESM nodes for enabling ESM support.
> - wkup_vtm for enabling Adaptive voltage scaling(AVS) support
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Thanks for the patch!

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       |  2 ++
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 11 +++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 9386bf3ef9f6..ac9c0a939461 100644
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
> @@ -1527,6 +1528,7 @@ main_r5fss0_core1: r5f@5d00000 {
>   	main_esm: esm@700000 {
>   		compatible = "ti,j721e-esm";
>   		reg = <0x0 0x700000 0x0 0x1000>;
> +		bootph-pre-ram;
>   		ti,esm-pins = <656>, <657>;
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 5097d192c2b2..7e9ad2301937 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -21,16 +21,19 @@ dmsc: system-controller@44083000 {
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
> @@ -44,6 +47,7 @@ mcu_timer0: timer@40400000 {
>   		assigned-clocks = <&k3_clks 35 1>;
>   		assigned-clock-parents = <&k3_clks 35 2>;
>   		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
> +		bootph-pre-ram;
>   		ti,timer-pwm;
>   	};
>   
> @@ -191,6 +195,7 @@ wkup_conf: bus@43000000 {
>   		chipid: chipid@14 {
>   			compatible = "ti,am654-chipid";
>   			reg = <0x14 0x4>;
> +			bootph-all;
>   		};
>   	};
>   
> @@ -344,6 +349,7 @@ mcu_ringacc: ringacc@2b800000 {
>   			      <0x00 0x28440000 0x00 0x40000>;
>   			reg-names = "rt", "fifos", "proxy_gcfg",
>   				    "proxy_target", "cfg";
> +			bootph-all;
>   			ti,num-rings = <286>;
>   			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
>   			ti,sci = <&dmsc>;
> @@ -363,6 +369,7 @@ mcu_udmap: dma-controller@285c0000 {
>   				    "tchan", "rchan", "rflow";
>   			msi-parent = <&main_udmass_inta>;
>   			#dma-cells = <1>;
> +			bootph-all;
>   
>   			ti,sci = <&dmsc>;
>   			ti,sci-dev-id = <236>;
> @@ -383,6 +390,8 @@ secure_proxy_mcu: mailbox@2a480000 {
>   		reg = <0x0 0x2a480000 0x0 0x80000>,
>   		      <0x0 0x2a380000 0x0 0x80000>,
>   		      <0x0 0x2a400000 0x0 0x80000>;
> +		bootph-pre-ram;
> +
>   		/*
>   		 * Marked Disabled:
>   		 * Node is incomplete as it is meant for bootloaders and
> @@ -534,6 +543,7 @@ hbmc_mux: mux-controller@47000004 {
>   			reg = <0x00 0x47000004 0x00 0x4>;
>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x0 0x2>; /* HBMC select */
> +			bootph-all;
>   		};
>   
>   		hbmc: hyperbus@47034000 {
> @@ -652,6 +662,7 @@ wkup_vtm0: temperature-sensor@42040000 {
>   		      <0x00 0x42050000 0x00 0x350>;
>   		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>   		#thermal-sensor-cells = <1>;
> +		bootph-pre-ram;
>   	};
>   
>   	mcu_esm: esm@40800000 {
> 


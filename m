Return-Path: <linux-kernel+bounces-277485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6894A204
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA15C1F221E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5581C8227;
	Wed,  7 Aug 2024 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L4I6pX1V"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F33EA64;
	Wed,  7 Aug 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017129; cv=none; b=aEgap/SJ4kfLlgvTAoMrjC5x5UMuDGhP0Kq1UU/NE6CNqhHgMCPKWyYEd+xy432WkqGChERXzzPUc/OIMlTiDyBksh1hErU09pIqwle07ycXKw06HOTR+8GfRtt1tFMTJr0oNIFNVCAox2AgI43TPzTidI6uJBTFnsbAYGu/UB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017129; c=relaxed/simple;
	bh=TAPJZ5h6w1a5FTmmrZGOJISmzpiUh7fEzcCqu0Q+X+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ivrExbboXUM40yk4Xzlpls5D2UUkhGdTxdhnC5Y9JA2WoJWErhEebX7gPCgAgMxKDVxyb5LVqt0I/O2SzRm3e/9F+EGbu7UEobFpRj8j92F5Y0g48WvNS9Ie1K12qRMbCOFrwBDKsR9IBjWeTrvs8vzPw15GvVEDBc7jX81/zzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L4I6pX1V; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4777q2Ib020021;
	Wed, 7 Aug 2024 02:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723017122;
	bh=fzjlbS714oZt+FwiYECCZl2QZkWAjpcYeuFj5G8nowg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L4I6pX1VlWfRmk3GuimLtMHEuRufFacRVWoTjsEDVoNwOIyGW4saei17hPHvT4jGH
	 NmJC2K85iZgOLHt30qmCyoVptnhcFpiKMAzK/FOwbpVUIuCMc9cOucx8RYxuHYC6or
	 OwoYr1SeL2+Z3hd+kM+XIaqelbFfRydRdkr6t3wo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4777q2gv072886
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 02:52:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 02:52:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 02:52:01 -0500
Received: from [172.24.30.93] (lt5cd2489kgj.dhcp.ti.com [172.24.30.93])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4777pv2J116667;
	Wed, 7 Aug 2024 02:51:58 -0500
Message-ID: <1d5252d5-ead1-4551-8723-2eb46d91faf0@ti.com>
Date: Wed, 7 Aug 2024 13:21:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: k3-j784s4*: Remove bootph
 properties from parent nodes
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
 Vadapalli <s-vadapalli@ti.com>, <u-kumar1@ti.com>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-2-9bc2eccb6952@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240730-b4-upstream-bootph-all-v3-2-9bc2eccb6952@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 7/30/2024 3:23 PM, Manorit Chawdhry wrote:
> Removes bootph-* properties from parent nodes and aligns the bootph-* to
> other u-boot.dtsi
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 9 +--------
>   arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 8 ++++----
>   2 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index ffa38f41679d..311844490027 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -461,7 +461,6 @@ J784S4_IOPAD(0x078, PIN_OUTPUT, 1) /* (AH37) MCAN2_RX.AUDIO_EXT_REFCLK1 */
>   };
>   

main_pmx0 has bootph-all in parent node, please consider to clean that 
as well


>   &wkup_pmx2 {
> -	bootph-all;
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -577,7 +576,6 @@ J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
>   };
>   
>   &wkup_pmx0 {
> -	bootph-all;
>   	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -597,7 +595,6 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
>   };
>   
>   &wkup_pmx1 {
> -	bootph-all;
>   	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -668,6 +665,7 @@ bucka12: buck12 {
>   				regulator-max-microvolt = <1100000>;
>   				regulator-boot-on;
>   				regulator-always-on;
> +				bootph-pre-ram;
>   			};
>   
>   			bucka3: buck3 {
> @@ -769,18 +767,15 @@ &ufs_wrapper {
>   };
>   
>   &fss {
> -	bootph-all;
>   	status = "okay";
>   };
>   
>   &ospi0 {
> -	bootph-all;
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
>   
>   	flash@0 {
> -		bootph-all;
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
>   		spi-tx-bus-width = <8>;
> @@ -837,13 +832,11 @@ partition@3fc0000 {
>   };
>   
>   &ospi1 {
> -	bootph-all;
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
>   
>   	flash@0 {
> -		bootph-all;
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
>   		spi-tx-bus-width = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index f3a6ed1c979d..3f89277e3c2c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -7,7 +7,6 @@
>   
>   &cbass_mcu_wakeup {
>   	sms: system-controller@44083000 {
> -		bootph-all;
>   		compatible = "ti,k2g-sci";
>   		ti,host-id = <12>;
>   
> @@ -39,7 +38,6 @@ k3_reset: reset-controller {
>   	};
>   
>   	wkup_conf: bus@43000000 {
> -		bootph-all;
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -65,6 +63,7 @@ secure_proxy_sa3: mailbox@43600000 {
>   		 * firmware on non-MPU processors
>   		 */
>   		status = "disabled";
> +		bootph-pre-ram;
>   	};
>   
>   	mcu_ram: sram@41c00000 {
> @@ -175,10 +174,10 @@ mcu_timer0: timer@40400000 {
>   		ti,timer-pwm;
>   		/* Non-MPU Firmware usage */
>   		status = "reserved";
> +		bootph-all;

both nodes mcu_timer0 and mcu_timer1 as marked as

/* Non-MPU Firmware usage */, Please provide some message added bootph in first and removed from second

>   	};
>   
>   	mcu_timer1: timer@40410000 {
> -		bootph-all;
>   		compatible = "ti,am654-timer";
>   		reg = <0x00 0x40410000 0x00 0x400>;
>   		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
> @@ -458,7 +457,6 @@ mcu_spi2: spi@40320000 {
>   	};
> [..]


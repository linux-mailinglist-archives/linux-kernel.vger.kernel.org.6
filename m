Return-Path: <linux-kernel+bounces-378345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735719ACEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C111C2570C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FF21C304B;
	Wed, 23 Oct 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tLf2YT/n"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4461C3045;
	Wed, 23 Oct 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697146; cv=none; b=GI4/MbB09yMWwRlSrn4n/klDyiSJhU9Cysub59u7UduFL5i/eNcvssCMOUBxWPGB/CmWvVfxHEPxqi7C1KsdfeUUzESDpO9Q0SxbXK4qlfrRMLjv9syjEh18bAYH1mQp45j8kZ0fm+N2mpWXq7RfNTYs0U2o/tabgbPr2ar8RP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697146; c=relaxed/simple;
	bh=DH/2NrMHhTNGIVkHm+IKU4diOxQnM2CBcuGuQsO2Qu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NfxwqJ2RHfWzVPgY8dTDb26G3Qe+RvxnHG0LbGvp9dseTra80I+Jr/XB20gcww0M9hLrbc6/77Khka3lCgtjPxIbbqOgU1GP8vrv/hnaN2UU5MfBA/dHOnM5doHu+k6lDr7e/6GSwsbvIA1HYZeFxz2+Pn9lAiJT+SM4mb5HvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tLf2YT/n; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NFPasY040420;
	Wed, 23 Oct 2024 10:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729697136;
	bh=oAT6kcbQRB/ZOWWrGAXO0TKYP/bnChnk4e/I5SIxR4k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tLf2YT/nvbiZwuxM6OF8iFUIB86Vklfapfch8+Q8Lh3NdyrH0pvWCdidJeEcMAIsm
	 GpxN/MLJE6RZVuvoUowZyLxAtMYr1Fu/4Tgofs6gYayld6oQp+nlg3AulKsepb+fGz
	 JNiMUjLNhH16qph+1PoupAugB9V6tO3H4Dw8TfKg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NFPahc019136
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 10:25:36 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 10:25:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 10:25:35 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NFPVbN087980;
	Wed, 23 Oct 2024 10:25:31 -0500
Message-ID: <a0452ef6-6c79-4eb8-8b25-0857978bbf94@ti.com>
Date: Wed, 23 Oct 2024 20:55:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] arm64: dts: ti: k3-j784s4-j742s2-evm-common:
 Remove parent nodes bootph-*
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
 <20241023-b4-upstream-bootph-all-v5-7-a974d06370ab@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-7-a974d06370ab@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 23/10/24 12:27, Manorit Chawdhry wrote:
> Adding bootph properties on leaf nodes imply that they are applicable to
> the parent nodes as well. Bootloaders can derive the parent nodes when
> bootph is available in the leaf nodes.
> 
> Remove the bootph-* properties from parent nodes as they are redundant.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> index 98453171a179..b2e2b9f507a9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> @@ -305,7 +305,6 @@ &wkup_gpio0 {
>   };
>   
>   &main_pmx0 {
> -	bootph-all;
>   	main_cpsw2g_default_pins: main-cpsw2g-default-pins {
>   		pinctrl-single,pins = <
>   			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
> @@ -432,7 +431,6 @@ J784S4_IOPAD(0x078, PIN_OUTPUT, 1) /* (AH37) MCAN2_RX.AUDIO_EXT_REFCLK1 */
>   };
>   
>   &wkup_pmx2 {
> -	bootph-all;
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -548,7 +546,6 @@ J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
>   };
>   
>   &wkup_pmx0 {
> -	bootph-all;
>   	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -568,7 +565,6 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
>   };
>   
>   &wkup_pmx1 {
> -	bootph-all;
>   	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
>   		bootph-all;
>   		pinctrl-single,pins = <
> @@ -740,18 +736,15 @@ &ufs_wrapper {
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
> @@ -808,13 +801,11 @@ partition@3fc0000 {
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
> 


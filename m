Return-Path: <linux-kernel+bounces-319659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9E970033
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E72B238BB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125966088F;
	Sat,  7 Sep 2024 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QzXUdKU9"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04632C8E;
	Sat,  7 Sep 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725687315; cv=none; b=RfkrYUGA11oAta1CGUvZ9Szjn0wCXN8QXinp0InRwbl7SVLB0BdAguxfol4R2FK3wcxXC8Qi3g56iO0nZ6xZBoV4w9i0+w/5E8foDszpihEPlyHi+gGMpoiH/NNlVqVtYhvPg/eN5rEcSC2HN8EEWEIuqvtDqb858fi9imaQuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725687315; c=relaxed/simple;
	bh=scE/eAxwuT9GKAqGnFvKi5xLoCyNQ1N4mBsUb0aeNJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PvmnUe/Kcq3K+Lw/MUl0zPfYxfRawJR++HvvpvpBk8R3uvdVME/mbKyKviPaGtEHPA9SEpZrj+VHk08JuBuTs+808Ll3fc8tg4VB50qWTIhV7yd+Wdt4xNppJT2cy5GAFQj9mEWqR/9dvr8rhHGILExXLrLeYszjtgM3Rlmrc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QzXUdKU9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4875YtvP012006;
	Sat, 7 Sep 2024 00:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725687295;
	bh=OdIuX3KeOmdjn4QebIIqolo/mrXvIypIqWU/sJBeMSk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QzXUdKU9moPejXNE9LDXEXcPv0HmRj8n2EB3nK7W04tyH6s39LyvZUl1cFItcr9Pu
	 DJfmioSe6BnOFVyA8jDmiHKkzlqEic5cMSq+90Z4C3qJKGVNTlz3AZIPcCldQv1wYY
	 5NBnTaUdtpTGOvovXO/ThH+zt7QwzSl2Jpa1Ec4s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4875YtOp011908
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 7 Sep 2024 00:34:55 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 7
 Sep 2024 00:34:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 7 Sep 2024 00:34:55 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4875YobU054763;
	Sat, 7 Sep 2024 00:34:51 -0500
Message-ID: <bd188c0d-9fa1-4350-8787-36af319c7930@ti.com>
Date: Sat, 7 Sep 2024 11:04:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 1/2] arm64: dts: ti: k3-j784s4-evm: Mark tps659413
 and children as bootph-all
To: Andrew Halaney <ahalaney@redhat.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
        Eric
 Chanudet <echanude@redhat.com>,
        Enric Balletbo <eballetb@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com>
 <20240906-j784s4-tps6594-bootph-v1-1-c5b58d43bf04@redhat.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240906-j784s4-tps6594-bootph-v1-1-c5b58d43bf04@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks for your patch Andrew


On 9/7/2024 2:51 AM, Andrew Halaney wrote:
> In order for the MCU domain to access this PMIC and its children in
> u-boot SPL, the nodes need to be marked appropriately otherwise they
> are not seen by SPL.
>
> This is necessary if the MCU domain is to program the TPS6594 MCU ESM
> state machine, which is required to wire up the watchdog in a manner
> that will reset the board.
>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 6695ebbcb4d0..044a428136df 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -642,6 +642,7 @@ eeprom@50 {
>   	};
>   
>   	tps659413: pmic@48 {
> +		bootph-all;
>   		compatible = "ti,tps6594-q1";
>   		reg = <0x48>;
>   		system-power-controller;
> @@ -662,7 +663,10 @@ tps659413: pmic@48 {
>   		ldo4-supply = <&vsys_3v3>;
>   
>   		regulators {
> +			bootph-all;
> +
>   			bucka12: buck12 {
> +				bootph-all;


Add bootph in on regulator node should be enough,

As I see SPL/u-boot does not need all nodes.


FYI,

Similar series in review

https://lore.kernel.org/all/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com/ 


>   				regulator-name = "vdd_ddr_1v1";
>   				regulator-min-microvolt = <1100000>;
>   				regulator-max-microvolt = <1100000>;
> @@ -671,6 +675,7 @@ bucka12: buck12 {
>   			};
>   
>   			bucka3: buck3 {
> +				bootph-all;
>   				regulator-name = "vdd_ram_0v85";
>   				regulator-min-microvolt = <850000>;
>   				regulator-max-microvolt = <850000>;
> @@ -679,6 +684,7 @@ bucka3: buck3 {
>   			};
>   
>   			bucka4: buck4 {
> +				bootph-all;
>   				regulator-name = "vdd_io_1v8";
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <1800000>;
> @@ -687,6 +693,7 @@ bucka4: buck4 {
>   			};
>   
>   			bucka5: buck5 {
> +				bootph-all;
>   				regulator-name = "vdd_mcu_0v85";
>   				regulator-min-microvolt = <850000>;
>   				regulator-max-microvolt = <850000>;
> @@ -695,6 +702,7 @@ bucka5: buck5 {
>   			};
>   
>   			ldoa1: ldo1 {
> +				bootph-all;
>   				regulator-name = "vdd_mcuio_1v8";
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <1800000>;
> @@ -703,6 +711,7 @@ ldoa1: ldo1 {
>   			};
>   
>   			ldoa2: ldo2 {
> +				bootph-all;
>   				regulator-name = "vdd_mcuio_3v3";
>   				regulator-min-microvolt = <3300000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -711,6 +720,7 @@ ldoa2: ldo2 {
>   			};
>   
>   			ldoa3: ldo3 {
> +				bootph-all;
>   				regulator-name = "vds_dll_0v8";
>   				regulator-min-microvolt = <800000>;
>   				regulator-max-microvolt = <800000>;
> @@ -719,6 +729,7 @@ ldoa3: ldo3 {
>   			};
>   
>   			ldoa4: ldo4 {
> +				bootph-all;
>   				regulator-name = "vda_mcu_1v8";
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <1800000>;
>


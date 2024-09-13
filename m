Return-Path: <linux-kernel+bounces-328039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D5977E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0197728500A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D81A1D86E9;
	Fri, 13 Sep 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lRuityh/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC111D7E5D;
	Fri, 13 Sep 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225106; cv=none; b=nYJKmK7UKpd/w1fSREdUEmswtDULP1/NvX0SZlfg/9FFg5s1jgKNJANW9rHhTGXrBvCdMywvHTTz8/sW1caBZtOOssxN7LV3S+1ZO1Vid0we+k0VYDCR9ZLDso4lGgaqmvZS8RmwgVTwemB0H/MEgSDqU3AhceZAD6sl7yQcsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225106; c=relaxed/simple;
	bh=9p981OvMkywvKsAAD2daezWTgkyDqjWG4EqrhZkATZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e4N/DUS8yMhZtoIEeBaTCF1eELQlfcXa7wmWPLjA1zEZVh1sJG3Mx6BQJLKErYpCxYc+6y1S71CHYKDeiXkl0GahDT9iywWvbxsAO/YGSVtlG8AnIm0i74vu3gcZ5pkWMWuy6tqpAKYsFHUTECN6DxqBolEHGDOf+/vSYHRmde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lRuityh/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48DAvqa6118441;
	Fri, 13 Sep 2024 05:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726225072;
	bh=ViJUQV5fSR++ApNPdcsUD6G3ze85E58ABfaG2Vb7csw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lRuityh/kv1cUyUZaJBXrBaJpsHmh266FGavNzn/pAMzDHfhQPyNf3+zYdpfd4BdF
	 rdHK2ExAdzTOYXV6+vXnVa7+l4JsO0dDUy3OR0yyvB/uKMwXQ6F/czQ62rnMwzj3S6
	 dZTb2z8Qx+2Su+fd1Xfdnv5cA523FGXJK102pu7A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48DAvqld072540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Sep 2024 05:57:52 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Sep 2024 05:57:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Sep 2024 05:57:52 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48DAvlZB128677;
	Fri, 13 Sep 2024 05:57:48 -0500
Message-ID: <c4ace228-ea32-4760-b6af-f7555b68063a@ti.com>
Date: Fri, 13 Sep 2024 16:27:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j784s4-evm: Mark tps659413
 regulators as bootph-all
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
        Enric Balletbo <eballetb@redhat.com>, Udit
 Kumar <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com>
 <20240911-j784s4-tps6594-bootph-v2-1-a83526264ab1@redhat.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20240911-j784s4-tps6594-bootph-v2-1-a83526264ab1@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 11/09/24 22:49, Andrew Halaney wrote:
> In order for the MCU domain to access this PMIC, a regulator
> needs to be marked appropriately otherwise it is not seen by SPL and
> therefore not configured.
>
> This is necessary if the MCU domain is to program the TPS6594 MCU ESM
> state machine, which is required to wire up the watchdog in a manner
> that will reset the board.
>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 6695ebbcb4d0..6ed628c2884e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -663,6 +663,7 @@ tps659413: pmic@48 {
>   
>   		regulators {
>   			bucka12: buck12 {
> +				bootph-all;
>   				regulator-name = "vdd_ddr_1v1";
>   				regulator-min-microvolt = <1100000>;
>   				regulator-max-microvolt = <1100000>;


In my opinion, bootph-all property should come after other standard 
properties like regulator-name etc., as it is least important to Linux. 
Same comment for other nodes wherever applicable. What is your opinion?


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n130


Thanks,

Beleswar

> @@ -671,6 +672,7 @@ bucka12: buck12 {
>   			};
>   
>   			bucka3: buck3 {
> +				bootph-all;
>   				regulator-name = "vdd_ram_0v85";
>   				regulator-min-microvolt = <850000>;
>   				regulator-max-microvolt = <850000>;
> @@ -679,6 +681,7 @@ bucka3: buck3 {
>   			};
>   
>   			bucka4: buck4 {
> +				bootph-all;
>   				regulator-name = "vdd_io_1v8";
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <1800000>;
> @@ -687,6 +690,7 @@ bucka4: buck4 {
>   			};
>   
>   			bucka5: buck5 {
> +				bootph-all;
>   				regulator-name = "vdd_mcu_0v85";
>   				regulator-min-microvolt = <850000>;
>   				regulator-max-microvolt = <850000>;
> @@ -695,6 +699,7 @@ bucka5: buck5 {
>   			};
>   
>   			ldoa1: ldo1 {
> +				bootph-all;
>   				regulator-name = "vdd_mcuio_1v8";
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <1800000>;
> @@ -703,6 +708,7 @@ ldoa1: ldo1 {
>   			};
>   
>   			ldoa2: ldo2 {
> +				bootph-all;
>   				regulator-name = "vdd_mcuio_3v3";
>   				regulator-min-microvolt = <3300000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -711,6 +717,7 @@ ldoa2: ldo2 {
>   			};
>   
>   			ldoa3: ldo3 {
> +				bootph-all;
>   				regulator-name = "vds_dll_0v8";
>   				regulator-min-microvolt = <800000>;
>   				regulator-max-microvolt = <800000>;
> @@ -719,6 +726,7 @@ ldoa3: ldo3 {
>   			};
>   
>   			ldoa4: ldo4 {
> +				bootph-all;
>   				regulator-name = "vda_mcu_1v8";
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <1800000>;
>


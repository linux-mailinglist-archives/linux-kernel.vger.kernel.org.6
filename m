Return-Path: <linux-kernel+bounces-302028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC095F8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2FC2831D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532D81AC1;
	Mon, 26 Aug 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UxDC5wwt"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4197B677;
	Mon, 26 Aug 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696656; cv=none; b=CWbhc2NLxBB68QPe0yDItXd3v7QovQGYNNraF5J/wc/s3iixaiCToxqoGsV7EzN/9cBgyABfhPQPHkeG18oHvWGbL1Gi+iQvAlsL+ZIQ0Gly1mPpgOvideiheWcdB9pPES/ZZhpJuHHTXNnU+dyqjIxjlt1clHvZA5gr2UduadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696656; c=relaxed/simple;
	bh=DyXC+tw0wqVHJTaKkE/Ey7V5jOVQhGLDuuTJJCKil40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mmNc0FljaNDbstRc8SHxcwe/VSLv2PgYdsvtCniYs65NDJsThkNpoUtoiZzwCAj9+4z2r02FC8x9k7ayQMRDYWLXJJS4ewOACX7nsmW0LjitAw77fJAjk3EHSTWtN86Dy3kmzP9L0UkG33Gev2nNuc1Yhh9Rj89k+DT0Q1KEMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UxDC5wwt; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QIO2GT109919;
	Mon, 26 Aug 2024 13:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724696642;
	bh=axph+CVJh6fzdG84jT93tUF99qz3udvt+bZ8lns2okM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UxDC5wwtCRFtga9D4Bfojw2MB4S5JOViviKXcSYt9qA7DoJmds6doX3lGqU85cuGd
	 uq/1xwyXfYrp5jyIcMVyq16rufkl1V7u4Q68WG+ee0ul1hn2XWBcTuYTew+LOMtK4x
	 hYXsnRPgwIsR3KQ/4uyCiXG5dlLQbmw3k/GGNmW0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QIO21D099097
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 13:24:02 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 13:24:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 13:24:01 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QINvei062853;
	Mon, 26 Aug 2024 13:23:58 -0500
Message-ID: <f42f092f-2199-4cbd-8cad-96ccf4f100d0@ti.com>
Date: Mon, 26 Aug 2024 23:53:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: align watchdog clocks
To: Eric Chanudet <echanude@redhat.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, J Keerthi <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        <u-kumar1@ti.com>
References: <20240805174330.2132717-2-echanude@redhat.com>
 <wiyw7h7hkc7u2brehi6zgxykesajtqmwwajo7tpwwvayjtcykw@w7rcmojs62vi>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <wiyw7h7hkc7u2brehi6zgxykesajtqmwwajo7tpwwvayjtcykw@w7rcmojs62vi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Eric

On 8/21/2024 3:31 AM, Eric Chanudet wrote:
> On Mon, Aug 05, 2024 at 01:42:51PM GMT, Eric Chanudet wrote:
>> assigned-clock sets DEV_RTIx_RTI_CLK(id:0) whereas clocks sets
>> DEV_RTIx_RTI_CLK_PARENT_GLUELOGIC_HFOSC0_CLKOUT(id:1)[1]. This does not
>> look right, the timers in the driver assume a max frequency of 32kHz for
>> the heartbeat (HFOSC0 is 19.2MHz on j784s4-evm).
>>
>> With this change, WDIOC_GETTIMELEFT return coherent time left
>> (DEFAULT_HEARTBEAT=60, reports 60s upon opening the cdev).
>>
>> [1] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/clocks.html#clocks-for-rti0-device
>>
>> Fixes: caae599de8c6 ("arm64: dts: ti: k3-j784s4-main: Add the main domain watchdog instances")
>> Suggested-by: Andrew Halaney <ahalaney@redhat.com>
>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> Gentle ping and update to the test comment.
>
>> ---
>> I could not get the watchdog to do more than reporting 0x32 in
>> RTIWDSTATUS. Setting RTIWWDRXCTRL[0:3] to generate a reset instead of an
>> interrupt (0x5) didn't trigger a reset either when the window expired.
> Re-testing using u-boot from the BSP (2023.04) has the board reset as
> expected when the watchdog expires and WDIOC_GETTIMELEFT report the time
> left coherently with this patch until that happens.
>
> I initially had a u-boot with a DT lacking:
> 	"mcu_esm: esm@40800000"
> and I could reproduce the board not resetting by commenting in its
> description:
> 	"ti,esm-pins = <95>;"
>
> I don't understand why that is on the other hand. The TRM says ESM0
> ERR_O drives the SOC_SAFETY_ERRORn pin, which goes to the PMIC GPIO3 on
> the schematic _and_ to MCU_ESM0 as an error input event. The tps6594-esm
> module is probing successfully and it sets both ESM_SOC_EN|ESM_SOC_ENDRV
> and ESM_SOC_START, so I would expect the PMIC to reset the board without
> MCU_ESM0 being described or configured by u-boot.

AFAIK, Keerthy correct me. GPIO-7 of PMIC should reset the boards.

If you see figure 5-27 of TRM then SOC_SAFETY_ERRORn goes to GPIO-3 of 
PMIC (schematic)

Same time this is cascaded to MCU-ESM and WKUP-ESM to generate 
MCU_SAFETY_ERRORn (from Wkup_ESM)

and MCU_SAFETY_ERRORn is connected to GPIO-7.

Unlike other device J721E (for reference)

SOC_SAFETY_ERRORn is generated by Main ESM and MCU_SAFETY_ERRORn can be 
generated by WKUP_ESM and main_ESM.

Please look at schematic of J721E SOM [0], both SOC_SAFETY_ERRZ and 
MCU_SAFETY_ERRZ both are connected to GPIO-7 of PMIC.

So on this device and board, only main ESM configuration is working for us.

[0] https://www.ti.com/tool/J721EXSOMXEVM#tech-docs

> Best,
>
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 38 +++++++++++-----------
>>   1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index f170f80f00c1..6c014d335f2c 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -2429,7 +2429,7 @@ main_esm: esm@700000 {
>>   	watchdog0: watchdog@2200000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2200000 0x00 0x100>;
>> -		clocks = <&k3_clks 348 1>;
>> +		clocks = <&k3_clks 348 0>;
>>   		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 348 0>;
>>   		assigned-clock-parents = <&k3_clks 348 4>;
>> @@ -2438,7 +2438,7 @@ watchdog0: watchdog@2200000 {
>>   	watchdog1: watchdog@2210000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2210000 0x00 0x100>;
>> -		clocks = <&k3_clks 349 1>;
>> +		clocks = <&k3_clks 349 0>;
>>   		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 349 0>;
>>   		assigned-clock-parents = <&k3_clks 349 4>;
>> @@ -2447,7 +2447,7 @@ watchdog1: watchdog@2210000 {
>>   	watchdog2: watchdog@2220000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2220000 0x00 0x100>;
>> -		clocks = <&k3_clks 350 1>;
>> +		clocks = <&k3_clks 350 0>;
>>   		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 350 0>;
>>   		assigned-clock-parents = <&k3_clks 350 4>;
>> @@ -2456,7 +2456,7 @@ watchdog2: watchdog@2220000 {
>>   	watchdog3: watchdog@2230000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2230000 0x00 0x100>;
>> -		clocks = <&k3_clks 351 1>;
>> +		clocks = <&k3_clks 351 0>;
>>   		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 351 0>;
>>   		assigned-clock-parents = <&k3_clks 351 4>;
>> @@ -2465,7 +2465,7 @@ watchdog3: watchdog@2230000 {
>>   	watchdog4: watchdog@2240000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2240000 0x00 0x100>;
>> -		clocks = <&k3_clks 352 1>;
>> +		clocks = <&k3_clks 352 0>;
>>   		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 352 0>;
>>   		assigned-clock-parents = <&k3_clks 352 4>;
>> @@ -2474,7 +2474,7 @@ watchdog4: watchdog@2240000 {
>>   	watchdog5: watchdog@2250000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2250000 0x00 0x100>;
>> -		clocks = <&k3_clks 353 1>;
>> +		clocks = <&k3_clks 353 0>;
>>   		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 353 0>;
>>   		assigned-clock-parents = <&k3_clks 353 4>;
>> @@ -2483,7 +2483,7 @@ watchdog5: watchdog@2250000 {
>>   	watchdog6: watchdog@2260000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2260000 0x00 0x100>;
>> -		clocks = <&k3_clks 354 1>;
>> +		clocks = <&k3_clks 354 0>;
>>   		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 354 0>;
>>   		assigned-clock-parents = <&k3_clks 354 4>;
>> @@ -2492,7 +2492,7 @@ watchdog6: watchdog@2260000 {
>>   	watchdog7: watchdog@2270000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2270000 0x00 0x100>;
>> -		clocks = <&k3_clks 355 1>;
>> +		clocks = <&k3_clks 355 0>;
>>   		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 355 0>;
>>   		assigned-clock-parents = <&k3_clks 355 4>;
>> @@ -2506,7 +2506,7 @@ watchdog7: watchdog@2270000 {
>>   	watchdog8: watchdog@22f0000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x22f0000 0x00 0x100>;
>> -		clocks = <&k3_clks 360 1>;
>> +		clocks = <&k3_clks 360 0>;
>>   		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 360 0>;
>>   		assigned-clock-parents = <&k3_clks 360 4>;
>> @@ -2517,7 +2517,7 @@ watchdog8: watchdog@22f0000 {
>>   	watchdog9: watchdog@2300000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2300000 0x00 0x100>;
>> -		clocks = <&k3_clks 356 1>;
>> +		clocks = <&k3_clks 356 0>;
>>   		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 356 0>;
>>   		assigned-clock-parents = <&k3_clks 356 4>;
>> @@ -2528,7 +2528,7 @@ watchdog9: watchdog@2300000 {
>>   	watchdog10: watchdog@2310000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2310000 0x00 0x100>;
>> -		clocks = <&k3_clks 357 1>;
>> +		clocks = <&k3_clks 357 0>;
>>   		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 357 0>;
>>   		assigned-clock-parents = <&k3_clks 357 4>;
>> @@ -2539,7 +2539,7 @@ watchdog10: watchdog@2310000 {
>>   	watchdog11: watchdog@2320000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2320000 0x00 0x100>;
>> -		clocks = <&k3_clks 358 1>;
>> +		clocks = <&k3_clks 358 0>;
>>   		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 358 0>;
>>   		assigned-clock-parents = <&k3_clks 358 4>;
>> @@ -2550,7 +2550,7 @@ watchdog11: watchdog@2320000 {
>>   	watchdog12: watchdog@2330000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2330000 0x00 0x100>;
>> -		clocks = <&k3_clks 359 1>;
>> +		clocks = <&k3_clks 359 0>;
>>   		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 359 0>;
>>   		assigned-clock-parents = <&k3_clks 359 4>;
>> @@ -2561,7 +2561,7 @@ watchdog12: watchdog@2330000 {
>>   	watchdog13: watchdog@23c0000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x23c0000 0x00 0x100>;
>> -		clocks = <&k3_clks 361 1>;
>> +		clocks = <&k3_clks 361 0>;
>>   		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 361 0>;
>>   		assigned-clock-parents = <&k3_clks 361 4>;
>> @@ -2572,7 +2572,7 @@ watchdog13: watchdog@23c0000 {
>>   	watchdog14: watchdog@23d0000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x23d0000 0x00 0x100>;
>> -		clocks = <&k3_clks 362 1>;
>> +		clocks = <&k3_clks 362 0>;
>>   		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 362 0>;
>>   		assigned-clock-parents = <&k3_clks 362 4>;
>> @@ -2583,7 +2583,7 @@ watchdog14: watchdog@23d0000 {
>>   	watchdog15: watchdog@23e0000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x23e0000 0x00 0x100>;
>> -		clocks = <&k3_clks 363 1>;
>> +		clocks = <&k3_clks 363 0>;
>>   		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 363 0>;
>>   		assigned-clock-parents = <&k3_clks 363 4>;
>> @@ -2594,7 +2594,7 @@ watchdog15: watchdog@23e0000 {
>>   	watchdog16: watchdog@23f0000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x23f0000 0x00 0x100>;
>> -		clocks = <&k3_clks 364 1>;
>> +		clocks = <&k3_clks 364 0>;
>>   		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 364 0>;
>>   		assigned-clock-parents = <&k3_clks 364 4>;
>> @@ -2605,7 +2605,7 @@ watchdog16: watchdog@23f0000 {
>>   	watchdog17: watchdog@2540000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2540000 0x00 0x100>;
>> -		clocks = <&k3_clks 365 1>;
>> +		clocks = <&k3_clks 365 0>;
>>   		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 365 0>;
>>   		assigned-clock-parents = <&k3_clks 366 4>;
>> @@ -2616,7 +2616,7 @@ watchdog17: watchdog@2540000 {
>>   	watchdog18: watchdog@2550000 {
>>   		compatible = "ti,j7-rti-wdt";
>>   		reg = <0x00 0x2550000 0x00 0x100>;
>> -		clocks = <&k3_clks 366 1>;
>> +		clocks = <&k3_clks 366 0>;
>>   		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
>>   		assigned-clocks = <&k3_clks 366 0>;
>>   		assigned-clock-parents = <&k3_clks 366 4>;
>> -- 
>> 2.45.2
>>


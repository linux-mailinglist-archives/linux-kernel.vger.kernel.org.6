Return-Path: <linux-kernel+bounces-302909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153BA9604E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ABD282342
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FF19A296;
	Tue, 27 Aug 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P+/JZRJA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F719581F;
	Tue, 27 Aug 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748518; cv=none; b=FXzMkqi9t1SnCRGkFpknv7Z0p6ay2iu86w5+IaMTlRbeEQEm7/nhmMeKNyDbxHYAnlsZVFuxv1sQaF9tXH+OAs8azbmdAYswZHsTtHOr3bXqjjr9nf23SbOBskVkQjKHRP4R9Dnr2wq/sHevc7ntpaJqCQvvCOSkVZrQHOPW184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748518; c=relaxed/simple;
	bh=DG+H8AdABuWX9jwsNQDjJ+b9gZrYQEcN3c0xZWgxxT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sgsRZOiqeGzfADa8pbahF6j89W4S7pPCEy/X8QmTnC1nJbCgK36R0+U1AWnJGocfS8UvgXV3DO5VJkOZYlHysF/RvqPxryTRgJobuaDY8cNJEDnMSbgKciFpCE1wDPtTICzfLyDQf56D0DKaWy8FkLafUNSf2DweLI/RENqMV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P+/JZRJA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R8mSq4129813;
	Tue, 27 Aug 2024 03:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724748509;
	bh=L+JquZTPY83j4N0gT2lYk1Vo6sp5nIpnnTbZKspydcQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=P+/JZRJASBklv9MusoipmSZHsSVGvf2TYTBqJVE5T+oGm6Bqz7mHYEEp1rWQ85Eil
	 LtRrC1CA0+0l/HAqWw+SuDBdd9Dr7u9obBCj1xTTB67+oY67u/gD5nBJRosa5VJLWK
	 TtUyLMdr3mv8xUb1GEn71RWbQNPQH679DfzclUA8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R8mSae064225
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 03:48:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 03:48:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 03:48:28 -0500
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R8mPHc042874;
	Tue, 27 Aug 2024 03:48:26 -0500
Message-ID: <6b147080-cd58-4430-a17c-4de4e29f1348@ti.com>
Date: Tue, 27 Aug 2024 14:18:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Describe main_uart5
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240822053538.10475-1-b-kapoor@ti.com>
 <20240824181434.53m2ik3ozvc74pjf@dormitory>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240824181434.53m2ik3ozvc74pjf@dormitory>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 24/08/24 11:44 pm, Nishanth Menon wrote:
> On 11:05-20240822, Bhavya Kapoor wrote:
>> main_uart5 in J722S platform is used by the firmware. Thus,
> what platform? what firmware?

Hey Nishanth, it is used by system firmware for its logs

in J722S-EVM.

>
>> describe it for completeness, adding the pinmux and mark
>> it as reserved.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index 24e9f2ea509b..5addf1c0afc2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -20,6 +20,7 @@ / {
>>   	aliases {
>>   		serial0 = &wkup_uart0;
>>   		serial2 = &main_uart0;
>> +		serial3 = &main_uart5;
>>   		mmc0 = &sdhci0;
>>   		mmc1 = &sdhci1;
>>   	};
>> @@ -211,6 +212,13 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
>>   		bootph-all;
>>   	};
>>   
>> +	main_uart5_pins_default: main-uart5-default-pins {
>> +		pinctrl-single,pins = <
>> +			J722S_IOPAD(0x0108, PIN_INPUT, 3)       /* (J27) UART5_RXD */
>> +			J722S_IOPAD(0x010c, PIN_OUTPUT, 3)      /* (H27) UART5_TXD */
>> +		>;
>> +	};
>> +
>>   	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
>>   		pinctrl-single,pins = <
>>   			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
>> @@ -330,6 +338,12 @@ &main_uart0 {
>>   	bootph-all;
>>   };
>>   
>> +&main_uart5 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_uart5_pins_default>;
> Document specifically why reserved.
Will send out v2 for this.
>
>> +	status = "reserved";
>> +};
>> +
>>   &mcu_pmx0 {
>>   
>>   	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
>> -- 
>> 2.34.1
>>


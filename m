Return-Path: <linux-kernel+bounces-524240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D878A3E106
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6149D3B9633
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC220485D;
	Thu, 20 Feb 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fQiaFnZZ"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C51C3BE0;
	Thu, 20 Feb 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069318; cv=none; b=gfxmRlNP6ugcFWtZzQSUWTPMvX2jIN6JU/bjDHT3IihV/1g00Osbiy5/Gt2nWL9R1ZyERsDydsTbbBFRX2PdMuSE5w76MzrGHZ+/FiTQ1pJDSuK2p0+hDgn6v1zIAUpAfi9fjAPUXymh6gyOYUQTFBf3Yzq8Gj4L1l+s5NSs/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069318; c=relaxed/simple;
	bh=1/Y+47l60SNTXrPXr78/DhgdYZrkHWYmn5+XP+2iCIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q5gp28DpzTlHyEIYsZb1jsYTc4uCnET1XrKZl7s7pew4s6/6aNImP2bRgmfrhzz/q8Zw8NlLUMimKBfq5y/8PVVirColhInRYi7E3hqfflCI7bix8aVXnhSJcUM83SP/X1PwK4JLiqNl5XDBjs0g9+gUUIV/Z4VVkSvfLqitrGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fQiaFnZZ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51KGYsQP048123
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 10:34:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740069295;
	bh=Erb1j78Tl39CoDzh9ac30D16Llfa3ooTqJ8erhPUCDY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fQiaFnZZEuGRh4BKYGGwdxs6znPM66osnJsTkoLo35Pzja8pgNJxCffu3LOHPBe8k
	 s/PbIoOQ//sqerTNjmZ4QgQK+791700Zv4W9mtvYL95ZtDFI6F46aenAcrwL58mi8Q
	 DNaKpIH/lEGJbfsZ4YTYcrJkfJ1Q09a+ccifLKhQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51KGYsDQ090117
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 10:34:54 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Feb 2025 10:34:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Feb 2025 10:34:54 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51KGYsa2077700;
	Thu, 20 Feb 2025 10:34:54 -0600
Message-ID: <f8456f1b-b092-44b2-a916-13c4d88c5f83@ti.com>
Date: Thu, 20 Feb 2025 10:34:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] arm64: dts: ti: k3-am62-wakeup: Add wakeup R5F
 node
To: Beleswar Prasad Padhi <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis
	<afd@ti.com>,
        Hari Nagalla <hnagalla@ti.com>
References: <20250210221530.1234009-1-jm@ti.com>
 <20250210221530.1234009-2-jm@ti.com>
 <4740c3f8-5051-4e25-af91-b45735ffef31@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <4740c3f8-5051-4e25-af91-b45735ffef31@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Beleswar,

On 2/19/25 10:30 AM, Beleswar Prasad Padhi wrote:
> Hi Judith,
> 
> On 11/02/25 03:45, Judith Mendez wrote:
>> From: Hari Nagalla <hnagalla@ti.com>
>>
>> AM62 SoC devices have a single core R5F processor in wakeup domain.
>> The R5F processor in wakeup domain is used as a device manager
>> for the SoC.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changes since v4:
>> - No change
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 25 ++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>> index 9b8a1f85aa15c..061819a64300f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>> @@ -106,6 +106,31 @@ wkup_rti0: watchdog@2b000000 {
>>           status = "reserved";
>>       };
>> +    wkup_r5fss0: r5fss@78000000 {
>> +        compatible = "ti,am62-r5fss";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x78000000 0x00 0x78000000 0x8000>,
>> +             <0x78100000 0x00 0x78100000 0x8000>;
>> +        power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
>> +        status = "disabled";
>> +
>> +        wkup_r5fss0_core0: r5f@78000000 {
>> +            compatible = "ti,am62-r5f";
>> +            reg = <0x78000000 0x00008000>,
>> +                  <0x78100000 0x00008000>;
>> +            reg-names = "atcm", "btcm";
>> +            ti,sci = <&dmsc>;
>> +            ti,sci-dev-id = <121>;
>> +            ti,sci-proc-ids = <0x01 0xff>;
>> +            resets = <&k3_reset 121 1>;
>> +            firmware-name = "am62-wkup-r5f0_0-fw";
> 
> 
> Here and everywhere else, 'resets' and 'firmware-name' are standard DT 
> properties and should come before vendor specific properties.

Right, let me fix that, thanks.

~ Judith

> 
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> 
> Thanks,
> Beleswar
> 
>> +            ti,atcm-enable = <1>;
>> +            ti,btcm-enable = <1>;
>> +            ti,loczrama = <1>;
>> +        };
>> +    };
>> +
>>       wkup_vtm0: temperature-sensor@b00000 {
>>           compatible = "ti,j7200-vtm";
>>           reg = <0x00 0xb00000 0x00 0x400>,



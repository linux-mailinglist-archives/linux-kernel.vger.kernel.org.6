Return-Path: <linux-kernel+bounces-265667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E425693F433
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916CB2861A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B7145B21;
	Mon, 29 Jul 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pgGikN7/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E921422C4;
	Mon, 29 Jul 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252991; cv=none; b=OGEQ99v649x7kwdTqDZ3HYByfuE4OXqSxudvL5WKg8gpqp7gVFH4D8KTEkXeir16EA8oExr6QqoQoeD7G82QaYzkO5S7As1siPAoiu+wtyFLwtqjs3Rc5nwZL6IMVGzhjmggm1AgW6aEXGL5sc1zOUum/auNdrZtOsZGmn+a0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252991; c=relaxed/simple;
	bh=+tuXSgaDZ8RGO3seD5DW5hMdkkgy1RKwHbSFQxoigm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ncKzsgNTHiR4G2cn2SFoybgyIfPvXblez7nkzooPrfjVrbLG4LmWCN6vC0M0eavi9nZMIDJz9q5TpKwpTjKMSRJTeaLTOrSqZwy4IAYU3PceQea4RfvmeGEYPy6Sq0lWFtcQcdjY9fg7LHg0uw4X71XavTesAZbzdf5xmhWYc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pgGikN7/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBaME9053008;
	Mon, 29 Jul 2024 06:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252982;
	bh=+AoYLIXuJHhX7GyBvcthGkM227IBSRVEzbRvMaxzd/s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pgGikN7/v9/1R1LFHzpCCFerhCZHNo6Bt2Nt0TzrqCKByu3BPbwhyNUGqiVB/BR5M
	 fng5VNnY+X/xnTl4F0QkNA7gEMaKeEDTQyLTARjsuZE1lwB2P46nkz+f4hLTgSUYeR
	 EEYrjcIt3qOqtqlhsfTGslArknbF6jk8yzW2FknI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBaM5n009263
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:36:22 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:36:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:36:21 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBaHJ8074097;
	Mon, 29 Jul 2024 06:36:17 -0500
Message-ID: <2554962d-236b-4f73-b0a4-10b6c31f74ac@ti.com>
Date: Mon, 29 Jul 2024 17:06:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: soc: ti: pruss: Add documentation for
 PA_STATS support
To: Nishanth Menon <nm@ti.com>
CC: Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240625153319.795665-1-danishanwar@ti.com>
 <20240625153319.795665-3-danishanwar@ti.com>
 <20240627144538.mp7n2l7kupi7gt4l@straddle>
 <cca91f88-d7cd-42e3-a4f3-065d536e623b@ti.com>
 <20240628063423.cprgwhatogc2dapo@stuffing>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240628063423.cprgwhatogc2dapo@stuffing>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishant,

On 28/06/24 12:04 pm, Nishanth Menon wrote:
> On 10:56-20240628, MD Danish Anwar wrote:
>>
>>
>> On 27/06/24 8:15 pm, Nishanth Menon wrote:
>>> On 21:03-20240625, MD Danish Anwar wrote:
>>>> Add documentation for pa-stats node which is syscon regmap for
>>>> PA_STATS registers. This will be used to dump statistics maintained by
>>>> ICSSG firmware.
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>> index c402cb2928e8..3cb1471cc6b6 100644
>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>> @@ -278,6 +278,26 @@ patternProperties:
>>>>  
>>>>      additionalProperties: false
>>>>  
>>>> +  ^pa-stats@[a-f0-9]+$:
>>>> +    description: |
>>>> +      PA-STATS sub-module represented as a SysCon. PA_STATS is a set of
>>>> +      registers where different statistics related to ICSSG, are dumped by
>>>> +      ICSSG firmware. This syscon sub-module will help the device to
>>>> +      access/read/write those statistics.
>>>> +
>>>> +    type: object
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        items:
>>>> +          - const: ti,pruss-pa-st
>>>> +          - const: syscon
>>>> +
>>>> +      reg:
>>>> +        maxItems: 1
>>>> +
>>>
>>> Is this a patch in a driver series? I do not see the driver part..
>>
>> No Nishant, this is not a part of driver series. This binding patch is
>> related to [1] which is merged to net-next. The regmap will not be used
>> by drivers/soc/ti driver instead once both binding are in, the driver
>> changes will be needed in drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> as there is no driver changes needed in drivers/soc/ti, I posted this
>> patch as stand alone. Considering this binding and [1] they both go to
>> different tree, I decided to get the bindings in first and in next
>> kernel cycle when they both are part of mainline linux, I can post the
>> driver changes.
> 
> This is indicating some strong coupling that is sounding a bit
> suspicious. Please add in the full series so that folks can see the
> inter dependencies.
> 

I have posted v4
https://lore.kernel.org/all/20240729113226.2905928-1-danishanwar@ti.com/
as full series containing both driver and device tree changes.

I have explained the dependencies in cover letter. Please have a look.

>>
>>> if this is a memory map, why doesn't bus model work?
>>>
>>
>> I am just trying to maintain consistency here. pa-stats sub-module is
>> similar to mii-g-rt and mii-rt. I am adding pa-stats in the same way as
>> mii-g-rt and mii-rt.
>>
>> All these three modules are eventually mapping a memory region so that
>> the icssg driver can use them and read / configure registers.
> 
> Sounds like mapping a bus is more appropriate? I dont seem to see it
> though.
> 
>>
>>>
>>>>    interrupt-controller@[a-f0-9]+$:
>>>>      description: |
>>>>        PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
>> [1] https://lore.kernel.org/all/20240529115225.630535-1-danishanwar@ti.com/
>>
>> -- 
>> Thanks and Regards,
>> Danish
> 

-- 
Thanks and Regards,
Danish


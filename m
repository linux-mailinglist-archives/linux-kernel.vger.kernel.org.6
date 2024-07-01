Return-Path: <linux-kernel+bounces-235664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04591D81E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B157E1F22C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51569502BD;
	Mon,  1 Jul 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NY2w/azr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D504A0F;
	Mon,  1 Jul 2024 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815775; cv=none; b=TjI9ZXSlIc+fM0X34u1k2yb4Id3yIF/LFDGkR2vjEWa7O8XkMr0UQXcNYJgcgrqJiQBg/kkwu5qX6nSt/D0feLkY+32E/ZFHraeHLlfM3m+kf590LMAXdyyv3qWClZABq7nVO0X0EFN3w5FnlMOZDjlvNxMe9NiVA7/aTzRes+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815775; c=relaxed/simple;
	bh=97QFdb5S2q9ySCY8i3DFvMeRmnRbHMoD70uZaZkMrXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SMyNWemAnNY0g0rrgCn1bd+bY3IKpO1qMeuxTNrF/w6drFL0aRpoACIbDj5HyyLiYYQHzXNfmzcI7qhijGRsrydIkVSaXwp0t5pSk041o9mc/JmGOZZUWed1tOPRfxs07u7ZihjFhh2JjfoFoRc/MQbID70gV5G+9IP/WmzSs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NY2w/azr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4616ZnjJ017990;
	Mon, 1 Jul 2024 01:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719815749;
	bh=CvwQmo24v5IMWKakGQ8zYt5PJMRRdaNL04SdAamtOx8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NY2w/azrxuhgD+z59JdZtxz4ePX0jg4MwzrPs/WpjOjxShncmV6RQvoqrPhQCc+fE
	 ViZ+78UXq2bM2bbrvFGzQZ2oiUOuqroDMsB/GUC0hwRM92Ft91eFudERz2gr+vJK2Z
	 QqVUo3r3qqZvfr0vFm9LU1yZPmiDuQVN5Qi604KQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4616ZnUK120070
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 01:35:49 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 01:35:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 01:35:49 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4616ZiXX047728;
	Mon, 1 Jul 2024 01:35:45 -0500
Message-ID: <2badb65a-f56f-459a-b060-a3a5b624cfee@ti.com>
Date: Mon, 1 Jul 2024 12:05:44 +0530
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

The driver changes will be needed at later point. The PA-STATS registers
dump stats related to TSN / Frame Preemption features for ICSSG drivers.
The TSN support itself is still in progress for ICSSG driver and as a
result I have not added the driver change that uses this register maps
to read / write statistics.

For your reference, I will try to explain the dependency.

The pruss node (named icssg1 in k3-am64-main.dtsi) will have below,

icssg1_pa_stats: pa-stats@2c000 {
	compatible = "ti,pruss-pa-st", "syscon";
	reg = <0x2c000 0x1000>;
};

The icssg1-eth node in k3-am642-evm will have,

icssg1_eth: icssg1-eth {

	...
	...

	ti,pa-stats = <&icssg1_pa_stats>;

	...
	...
}

Now the driver icssg_prueth.c will have the below code in it's probe,

prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
if (IS_ERR(prueth->pa_stats)) {
	dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
	return -ENODEV;
}

The driver can then use regmap_read / write on prueth->pa_stats regmap
do access those registers.

This approach is similar to 'mii-rt' and 'mii-g-rt' reg maps. They have
been implemented and currently used by the icssg_prueth.c driver. You
can have a look on them for your reference.

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


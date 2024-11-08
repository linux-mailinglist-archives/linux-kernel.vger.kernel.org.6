Return-Path: <linux-kernel+bounces-401630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331159C1D16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76CD282034
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D741E882B;
	Fri,  8 Nov 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u11yTsBC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70321E5000;
	Fri,  8 Nov 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069329; cv=none; b=jLA8fCc3us7QgLs7QhVm+XFA9DVinoxzUz4baK89LytLmX/Uth/+zsLZeNEEj5P9Oaaf1G3GbhjQ2AExpyTjPnTIHyQf01irxSEiEIJOihkRdXxznKsLiMz09WaatDrrL+mWxjaNVzt2t76tSq9123xfVDulnB9WST5NE5PJ+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069329; c=relaxed/simple;
	bh=8jlqo1E4M8vcisv6CdLQ5vpJsIWBjsCNBFNXF02BGpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AgBRheQXgetFk2xmDsZlWEjtEj4g4t6JyuESdHIW/6ajzZdVkjmucBF/ODrfzlHbT/FsmqSVpbNeIugsdZOFOkqgcHJGXaQDTd5JhPXb9ZFrJtVh6aSqyK4rGOs8pqcDMTL7aC/sjzoZGqZ2Yymjpgji8ZkEdr3iSGc8VuprZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u11yTsBC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A8CYVfQ065687;
	Fri, 8 Nov 2024 06:34:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731069271;
	bh=OuN++dLfzXhna1qxmErJ0FWUgMTzln4qtKp2RrTbq84=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=u11yTsBC0oUA2BMalASCtqwi9eWE05qGsYJOwG2FCCXXXYroPC00MkmETnS9HQCPc
	 ym8mE3gk9GqX6/COt7mPb+gxnrElGJDCXXQ2YX0kchl9D/gtub3ZFA0AwMwqfK6dXL
	 NMbLbBUk9cgtlOzkdpqs1LQUmwcfjpZYpK3Xhu3g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A8CYVxZ112419
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 06:34:31 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Nov 2024 06:34:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Nov 2024 06:34:31 -0600
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A8CYPgW009281;
	Fri, 8 Nov 2024 06:34:26 -0600
Message-ID: <62f3902e-8ee4-4cdb-864c-cfe57c7e3839@ti.com>
Date: Fri, 8 Nov 2024 18:04:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <ssantosh@kernel.org>,
        <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros
	<rogerq@kernel.org>
References: <20241107104557.1442800-1-danishanwar@ti.com>
 <20241107104557.1442800-2-danishanwar@ti.com>
 <7f0a73c3-9977-4d07-b996-683ed18e4724@kernel.org>
 <8156fd61-c476-4b58-b3b2-e8bc4f93035e@ti.com>
 <2c368f5a-4b58-45de-8140-21b2f7af4d12@kernel.org>
 <4ba0381b-d30a-4469-a7c4-327f6ac20c9c@ti.com>
 <2e7a1eb6-df8f-44d4-9342-1bc6d8b5ad11@ti.com>
 <1fa4323b-4cee-4dfe-9c68-55f4465999cf@kernel.org>
 <2a3c54e8-46fc-48f9-8c01-f3bb0c4907af@ti.com>
 <c7llcnzthr2ydp4zlyk7rhovwauy5cqeqllvmgmyluypxq3opv@c4suatmd7k3w>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <c7llcnzthr2ydp4zlyk7rhovwauy5cqeqllvmgmyluypxq3opv@c4suatmd7k3w>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/8/2024 6:00 PM, Krzysztof Kozlowski wrote:
> On Fri, Nov 08, 2024 at 05:49:54PM +0530, Anwar, Md Danish wrote:
>> Hi Krzysztof,
>>
>> On 11/7/2024 5:51 PM, Krzysztof Kozlowski wrote:
>>> On 07/11/2024 12:58, MD Danish Anwar wrote:
>>>>
>>>>
>>>> On 07/11/24 5:16 pm, MD Danish Anwar wrote:
>>>>>
>>>>>
>>>>> On 07/11/24 5:14 pm, Krzysztof Kozlowski wrote:
>>>>>> On 07/11/2024 12:36, MD Danish Anwar wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 07/11/24 5:01 pm, Krzysztof Kozlowski wrote:
>>>>>>>> On 07/11/2024 11:45, MD Danish Anwar wrote:
>>>>>>>>> Add clocks, assigned-clocks and assigned-clock-parents for ICSSG
>>>>>>>>
>>>>>>>> Why? We see what you are doing from the diff, no point to repeat it. I
>>>>>>>> don't understand why you are doing it.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>>>>> ---
>>>>>>>>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml          | 11 +++++++++++
>>>>>>>>>  1 file changed, 11 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>>>>> index 3cb1471cc6b6..cf4c5884d8be 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>>>>> @@ -92,6 +92,17 @@ properties:
>>>>>>>>>      description: |
>>>>>>>>>        This property is as per sci-pm-domain.txt.
>>>>>>>>>  
>>>>>>>>> +  clocks:
>>>>>>>>> +    items:
>>>>>>>>> +      - description: ICSSG_CORE Clock
>>>>>>>>> +      - description: ICSSG_ICLK Clock
>>>>>>>>> +
>>>>>>>>> +  assigned-clocks:
>>>>>>>>> +    maxItems: 1
>>>>>>>>> +
>>>>>>>>> +  assigned-clock-parents:
>>>>>>>>> +    maxItems: 1
>>>>>>>>
>>>>>>>> Why? This is really not needed, so you need to explain why you are doing
>>>>>>>> things differently than entire Linux kernel / DT bindings.
>>>>>>>>
>>>>>>>
>>>>>>> I need to add this to the device tree node
>>>>>>>
>>>>>>> +		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
>>>>>>> +			 <&k3_clks 81 20>; /* icssg0_iclk */
>>>>>>> +		assigned-clocks = <&k3_clks 81 0>;
>>>>>>> +		assigned-clock-parents = <&k3_clks 81 2>;
>>>>>>>
>>>>>>> But without the above change in the binding I am getting below errors
>>>>>>> while running dtbs check.
>>>>>>>
>>>>>>> /workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30000000:
>>>>>>> 'assigned-clock-parents', 'assigned-clocks' do not match any of the
>>>>>>> regexes: '^(pru|rtu|txpru)@[0-9a-f]+$', '^pa-stats@[a-f0-9]+$',
>>>>>>> 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$', 'interrupt-controller@[a-f0-9]+$',
>>>>>>> 'mdio@[a-f0-9]+$', 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$',
>>>>>>> 'mii-rt@[a-f0-9]+$', 'pinctrl-[0-9]+'
>>>>>>> +/workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30080000:
>>>>>>> 'anyOf' conditional failed, one must be fixed:
>>>>>>>
>>>>>>> To fix this warning I added these in the binding and the warnings were
>>>>>>> fixed.
>>>>>>
>>>>>> nah, cannot reproduce. Just be sure you work on recent kernel (last time
>>>>>> you were sending it on some ancient stuff) and your packages are
>>>>>> updated, including dt schema and other kernel dependencies.
>>>>>>
>>
>> The purpose of this series is to add 'assigned-clock-parents',
>> 'assigned-clocks' to the DT node. Initially I was only trying to add
>> these two nodes to DT and at that time I got the above error. I also got
>>  the below error as well
> 
> So you pasted different error, not related to topic we discussed.
> assigned-clock* depend on clocks. You must have clocks to assign them,
> obviously. Device should no assign rates to clocks which are not its
> inputs. :/
> 
> 
>>
>> /home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
>> icssg@30000000: 'anyOf' conditional failed, one must be fixed:
>>         'clocks' is a required property
>>         '#clock-cells' is a required property
>>         from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
>>
>>
>> To fix this I added 'assigned-clock-parents', 'assigned-clocks' to the
>> binding and at this time I got only the below error,
> 
> To fix this you must add clocks. The error tells you this.
> 
> So again: drop assigned properties. No error msg asked you to add them.
> 

Yes, I will drop assigned properties from binding and post a v2.

> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Md Danish Anwar


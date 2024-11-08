Return-Path: <linux-kernel+bounces-401602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D625C9C1CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9684D283A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902C1E764A;
	Fri,  8 Nov 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XvbQOidz"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E51E47CC;
	Fri,  8 Nov 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068414; cv=none; b=I1UfRGazqejAHUa7wSYZrpCCZXGMOT5H+DeYffvRTahmV1Nfc/yz3u7YGkuphE6+lWvW2fKN9Ulf/23yGn/1xlmHBlGe0uvVsPKfUVPHo1OnJYEn0dR04YHFAooy31YqfjGusEABk399roIjek8uYwG6l3Tyr1YhnjZVqPc6pmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068414; c=relaxed/simple;
	bh=MoTi/dYS7hHyJMOXtzhCKDV+lOAYDaThzUaFOBTiDa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IXQnvuHirDYPuvdwS7z1Ik5LHzkd1BBZKZUMBlz1tubjgh8rOqQQBVifkIwMwlPKGa810MOJN1YG8MQx67etoBzJk1KYqdwYBFX+MhMYlUZaQVKV06hL13NysQd5ifurokq/ciDAPv2dY60keMDnjS7O/zdqd8/MXNvF6sPrfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XvbQOidz; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A8CK2Ie104732;
	Fri, 8 Nov 2024 06:20:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731068402;
	bh=mWj+Y3X9SnOAh3+a4cFNqzSCflZ6mMnuYM7SYahU/ww=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XvbQOidz8W05245Nc/1tJp1BTZSSWiTlBEb8xL0wCDoFztBpO/7WaLxwuGGW7P6Ip
	 QkYrl38vXR+Pmi5Evt7lFNSmgKJAYtbFN0cmuLBcYbjO1V6yRWNAiBukaR6Dkqv8m4
	 XBnTa9h9qvrbL2IJK/cay5O92uAlfTSckv5nWEhw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A8CK29n104549
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 06:20:02 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Nov 2024 06:20:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Nov 2024 06:20:01 -0600
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A8CJtUB123140;
	Fri, 8 Nov 2024 06:19:56 -0600
Message-ID: <2a3c54e8-46fc-48f9-8c01-f3bb0c4907af@ti.com>
Date: Fri, 8 Nov 2024 17:49:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: Krzysztof Kozlowski <krzk@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <ssantosh@kernel.org>,
        <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20241107104557.1442800-1-danishanwar@ti.com>
 <20241107104557.1442800-2-danishanwar@ti.com>
 <7f0a73c3-9977-4d07-b996-683ed18e4724@kernel.org>
 <8156fd61-c476-4b58-b3b2-e8bc4f93035e@ti.com>
 <2c368f5a-4b58-45de-8140-21b2f7af4d12@kernel.org>
 <4ba0381b-d30a-4469-a7c4-327f6ac20c9c@ti.com>
 <2e7a1eb6-df8f-44d4-9342-1bc6d8b5ad11@ti.com>
 <1fa4323b-4cee-4dfe-9c68-55f4465999cf@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <1fa4323b-4cee-4dfe-9c68-55f4465999cf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 11/7/2024 5:51 PM, Krzysztof Kozlowski wrote:
> On 07/11/2024 12:58, MD Danish Anwar wrote:
>>
>>
>> On 07/11/24 5:16 pm, MD Danish Anwar wrote:
>>>
>>>
>>> On 07/11/24 5:14 pm, Krzysztof Kozlowski wrote:
>>>> On 07/11/2024 12:36, MD Danish Anwar wrote:
>>>>>
>>>>>
>>>>> On 07/11/24 5:01 pm, Krzysztof Kozlowski wrote:
>>>>>> On 07/11/2024 11:45, MD Danish Anwar wrote:
>>>>>>> Add clocks, assigned-clocks and assigned-clock-parents for ICSSG
>>>>>>
>>>>>> Why? We see what you are doing from the diff, no point to repeat it. I
>>>>>> don't understand why you are doing it.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml          | 11 +++++++++++
>>>>>>>  1 file changed, 11 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>>> index 3cb1471cc6b6..cf4c5884d8be 100644
>>>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>>> @@ -92,6 +92,17 @@ properties:
>>>>>>>      description: |
>>>>>>>        This property is as per sci-pm-domain.txt.
>>>>>>>  
>>>>>>> +  clocks:
>>>>>>> +    items:
>>>>>>> +      - description: ICSSG_CORE Clock
>>>>>>> +      - description: ICSSG_ICLK Clock
>>>>>>> +
>>>>>>> +  assigned-clocks:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  assigned-clock-parents:
>>>>>>> +    maxItems: 1
>>>>>>
>>>>>> Why? This is really not needed, so you need to explain why you are doing
>>>>>> things differently than entire Linux kernel / DT bindings.
>>>>>>
>>>>>
>>>>> I need to add this to the device tree node
>>>>>
>>>>> +		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
>>>>> +			 <&k3_clks 81 20>; /* icssg0_iclk */
>>>>> +		assigned-clocks = <&k3_clks 81 0>;
>>>>> +		assigned-clock-parents = <&k3_clks 81 2>;
>>>>>
>>>>> But without the above change in the binding I am getting below errors
>>>>> while running dtbs check.
>>>>>
>>>>> /workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30000000:
>>>>> 'assigned-clock-parents', 'assigned-clocks' do not match any of the
>>>>> regexes: '^(pru|rtu|txpru)@[0-9a-f]+$', '^pa-stats@[a-f0-9]+$',
>>>>> 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$', 'interrupt-controller@[a-f0-9]+$',
>>>>> 'mdio@[a-f0-9]+$', 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$',
>>>>> 'mii-rt@[a-f0-9]+$', 'pinctrl-[0-9]+'
>>>>> +/workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30080000:
>>>>> 'anyOf' conditional failed, one must be fixed:
>>>>>
>>>>> To fix this warning I added these in the binding and the warnings were
>>>>> fixed.
>>>>
>>>> nah, cannot reproduce. Just be sure you work on recent kernel (last time
>>>> you were sending it on some ancient stuff) and your packages are
>>>> updated, including dt schema and other kernel dependencies.
>>>>

The purpose of this series is to add 'assigned-clock-parents',
'assigned-clocks' to the DT node. Initially I was only trying to add
these two nodes to DT and at that time I got the above error. I also got
 the below error as well

/home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
icssg@30000000: 'anyOf' conditional failed, one must be fixed:
        'clocks' is a required property
        '#clock-cells' is a required property
        from schema $id: http://devicetree.org/schemas/clock/clock.yaml#


To fix this I added 'assigned-clock-parents', 'assigned-clocks' to the
binding and at this time I got only the below error,

/home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
icssg@30000000: 'anyOf' conditional failed, one must be fixed:
        'clocks' is a required property
        '#clock-cells' is a required property
        from schema $id: http://devicetree.org/schemas/clock/clock.yaml#

So to fix this, I added clocks to the binding as well as DT and after
that all the errors got resolved and I posted the series.

>>>
>>> I have posted this series on the latest kernel. Base commit
>>> 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb
>>>
>>> Let me check if the schema is up to date or not. I will re test and
>>> reply. Thanks for pointing it out.
>>>
>>
>> Krzysztof, I re-checked.
>> I am on the latest kernel (commit
>> 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb (tag: next-20241106,
>> origin/master, origin/HEAD)) and I am using the lastest dtschema v2024.9
>>
>> ❯ python3 -m pip list|grep 'dtschema'
>> dtschema                      2024.9
>>
>> Still I am getting the below dtbs check errors while running `make
>> CHECK_DTBS=y ti/k3-am642-evm.dtb` without the binding change.
>>
>> Let me know if I am missing something else.
>>
>> /home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
>> icssg@30000000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
> 
> Wait, what? That's different error. You have clocks documented. To
> remind: we talk about previous error so only, *only* assigned-clocks.
> 

I agree. This is a different error. I encountered this error when I
dropped the binding patch of this series and tested only the DT patch.

When you commented on Binding patch mentioning it's not needed, I
thought you were referring to the entire diff. So I dropped the patch
and tested the DT patch only. And at this time I got this error.

>> not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
>> '^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
>> 'interrupt-controller@[a-f0-9]+$', 'mdio@[a-f0-9]+$',
>> 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$', 'mii-rt@[a-f0-9]+$',
>> 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
>> /home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
>> icssg@30000000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
>> not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
>> '^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
>> 'interrupt-controller@[a-f0-9]+$', 'mdio@[a-f0-9]+$',
>> 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$', 'mii-rt@[a-f0-9]+$',
>> 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
>> /home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
>> icssg@30080000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
>> not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
>> '^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
>> 'interrupt-controller@[a-f0-9]+$', 'mdio@[a-f0-9]+$',
>> 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$', 'mii-rt@[a-f0-9]+$',
>> 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
>> /home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
>> icssg@30080000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
>> not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
>> '^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
> 
> I don't understand these, either.  All of them have clocks. What are you
> testing? You add clocks to DTS but not to the binding? What would be the
> point of that test?
> 

I did some more testing. Turns out just adding clocks to dt binding is
enough. Clocks will need to be added to binding however
'assigned-clock-parents', 'assigned-clocks' are not needed in the binding.

I will drop the 'assigned-clock-parents', 'assigned-clocks' from
dt-binding and only keep below diff. Where as for DT patch (2/2) - I
will keep it as it is.

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 3cb1471cc6b6..12350409d154 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -92,6 +92,11 @@ properties:
     description: |
       This property is as per sci-pm-domain.txt.

+  clocks:
+    items:
+      - description: ICSSG_CORE Clock
+      - description: ICSSG_ICLK Clock
+
 patternProperties:

   memories@[a-f0-9]+$:

Let me know if this looks ok to you. Thanks for your feedback.

> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Md Danish Anwar


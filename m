Return-Path: <linux-kernel+bounces-399841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 708069C0519
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31E4B210BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD3020C48C;
	Thu,  7 Nov 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EOgOEvrr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AB20C474;
	Thu,  7 Nov 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980742; cv=none; b=YXJIHJ7IrB5ZvTIGeyo2Jqhg2tAm06+XtHDOtfDCDN2XsbupHk0z2D+JIB0VK5CEP2qjkx4X7lEkcl5A7tC5BCRuB4PSSjzMFUv/3fZcUPhGUHUoJkch1FcjdUchLBs3qSJfkPQcqzWe9fODmoOmBYlLcukZxpObP+L7J3Vv140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980742; c=relaxed/simple;
	bh=q3B/2EizewVdg7Ticwc90igwIBS+BkhqBehFPEL2Ytg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rCbmqld28o/y/cOoQwF9/WJ3YMibT4rVRwQMHqfDrqdWH0SLfJvo25uVYF0B+etORk6CjHhp/z2dGoFMJSg8yl1KzL6Mv6jhgBNTQDvE82QDLnywAwgRZXxaRU4g24rTrCsnczEzeR0PE0hq712lJQwjIWRmObEoe5pPX1yFBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EOgOEvrr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7BwhGH029340;
	Thu, 7 Nov 2024 05:58:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730980723;
	bh=pBZllDFIOmH/RzJOjKr84Vsut0PkmIArsmUEJHGaFVQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=EOgOEvrrrpSlNSXlcbrmmNDYIymvXHmWHJnujzhBGWoLLK88N+Tu1k/69iwGNKcyQ
	 iTx9O3k5h4o24lNf5gX2sxIKc/w6FMb/fljqONtjreT6kCpCgZZ+M1ap/UpS0VVnqU
	 gFXlHht+Zqh1wF/lP/ukkYooIStQUqg4B4Zkwlp0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7BwhvC072030;
	Thu, 7 Nov 2024 05:58:43 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 05:58:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 05:58:43 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7BwcNP112985;
	Thu, 7 Nov 2024 05:58:39 -0600
Message-ID: <2e7a1eb6-df8f-44d4-9342-1bc6d8b5ad11@ti.com>
Date: Thu, 7 Nov 2024 17:28:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
From: MD Danish Anwar <danishanwar@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <ssantosh@kernel.org>,
        <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20241107104557.1442800-1-danishanwar@ti.com>
 <20241107104557.1442800-2-danishanwar@ti.com>
 <7f0a73c3-9977-4d07-b996-683ed18e4724@kernel.org>
 <8156fd61-c476-4b58-b3b2-e8bc4f93035e@ti.com>
 <2c368f5a-4b58-45de-8140-21b2f7af4d12@kernel.org>
 <4ba0381b-d30a-4469-a7c4-327f6ac20c9c@ti.com>
Content-Language: en-US
In-Reply-To: <4ba0381b-d30a-4469-a7c4-327f6ac20c9c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 07/11/24 5:16 pm, MD Danish Anwar wrote:
> 
> 
> On 07/11/24 5:14 pm, Krzysztof Kozlowski wrote:
>> On 07/11/2024 12:36, MD Danish Anwar wrote:
>>>
>>>
>>> On 07/11/24 5:01 pm, Krzysztof Kozlowski wrote:
>>>> On 07/11/2024 11:45, MD Danish Anwar wrote:
>>>>> Add clocks, assigned-clocks and assigned-clock-parents for ICSSG
>>>>
>>>> Why? We see what you are doing from the diff, no point to repeat it. I
>>>> don't understand why you are doing it.
>>>>
>>>>>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml          | 11 +++++++++++
>>>>>  1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> index 3cb1471cc6b6..cf4c5884d8be 100644
>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> @@ -92,6 +92,17 @@ properties:
>>>>>      description: |
>>>>>        This property is as per sci-pm-domain.txt.
>>>>>  
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: ICSSG_CORE Clock
>>>>> +      - description: ICSSG_ICLK Clock
>>>>> +
>>>>> +  assigned-clocks:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  assigned-clock-parents:
>>>>> +    maxItems: 1
>>>>
>>>> Why? This is really not needed, so you need to explain why you are doing
>>>> things differently than entire Linux kernel / DT bindings.
>>>>
>>>
>>> I need to add this to the device tree node
>>>
>>> +		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
>>> +			 <&k3_clks 81 20>; /* icssg0_iclk */
>>> +		assigned-clocks = <&k3_clks 81 0>;
>>> +		assigned-clock-parents = <&k3_clks 81 2>;
>>>
>>> But without the above change in the binding I am getting below errors
>>> while running dtbs check.
>>>
>>> /workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30000000:
>>> 'assigned-clock-parents', 'assigned-clocks' do not match any of the
>>> regexes: '^(pru|rtu|txpru)@[0-9a-f]+$', '^pa-stats@[a-f0-9]+$',
>>> 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$', 'interrupt-controller@[a-f0-9]+$',
>>> 'mdio@[a-f0-9]+$', 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$',
>>> 'mii-rt@[a-f0-9]+$', 'pinctrl-[0-9]+'
>>> +/workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30080000:
>>> 'anyOf' conditional failed, one must be fixed:
>>>
>>> To fix this warning I added these in the binding and the warnings were
>>> fixed.
>>
>> nah, cannot reproduce. Just be sure you work on recent kernel (last time
>> you were sending it on some ancient stuff) and your packages are
>> updated, including dt schema and other kernel dependencies.
>>
> 
> I have posted this series on the latest kernel. Base commit
> 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb
> 
> Let me check if the schema is up to date or not. I will re test and
> reply. Thanks for pointing it out.
> 

Krzysztof, I re-checked.
I am on the latest kernel (commit
5b913f5d7d7fe0f567dea8605f21da6eaa1735fb (tag: next-20241106,
origin/master, origin/HEAD)) and I am using the lastest dtschema v2024.9

❯ python3 -m pip list|grep 'dtschema'
dtschema                      2024.9

Still I am getting the below dtbs check errors while running `make
CHECK_DTBS=y ti/k3-am642-evm.dtb` without the binding change.

Let me know if I am missing something else.

/home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
icssg@30000000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
'^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
'interrupt-controller@[a-f0-9]+$', 'mdio@[a-f0-9]+$',
'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$', 'mii-rt@[a-f0-9]+$',
'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
/home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
icssg@30000000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
'^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
'interrupt-controller@[a-f0-9]+$', 'mdio@[a-f0-9]+$',
'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$', 'mii-rt@[a-f0-9]+$',
'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
/home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
icssg@30080000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
'^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
'interrupt-controller@[a-f0-9]+$', 'mdio@[a-f0-9]+$',
'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$', 'mii-rt@[a-f0-9]+$',
'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
/home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
icssg@30080000: 'assigned-clock-parents', 'assigned-clocks', 'clocks' do
not match any of the regexes: '^(pru|rtu|txpru)@[0-9a-f]+$',
'^pa-stats@[a-f0-9]+$', 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$',
'interrupt-controller@[a-f0-9]+$', 'mdio@[a-f0-9]+$',
'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$', 'mii-rt@[a-f0-9]+$',
'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#

> 
> 
>> Best regards,
>> Krzysztof
>>
> 

-- 
Thanks and Regards,
Danish


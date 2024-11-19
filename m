Return-Path: <linux-kernel+bounces-413884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD39D2020
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F69728266E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9302153BD7;
	Tue, 19 Nov 2024 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VETdE85y"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0BE150981;
	Tue, 19 Nov 2024 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996778; cv=none; b=NH8MCyFlf++A2y4/MuSsSmErmjPmAGaj6JploNRa3hMm+kuk90CvIX3NOvbdTTKqVNaWwzia214/HQvC1JaVVlDwsw6Os2p8WJTtlJ5UyIe6OVUibk8VuJZsTd1lPg9L2XPDw7BLVQi5fSgtLuP7+8jDGXMd8V0yENQY0z8VU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996778; c=relaxed/simple;
	bh=U9sbgYHr68hIsWqzRN6WaDTAbChhR302vBJX4i47JGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tmrZP39s897qQQw1M6s2jYKdrw1HFpsxffHOZMoIzDNyhGH2RBMlRdqjminf6iPd9eSSbjLbYhDYAAc7X5SJCoCwFH7UZS9D5m7fzLI3tQVB2JxoM2+Q7AlftC30tMQqi9k/GR1kqadEKTjYzdb/4zCZoMBNeRymOkg974gNAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VETdE85y; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ6CYq3099191;
	Tue, 19 Nov 2024 00:12:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731996754;
	bh=lDdewSiWiOvlIgmH8VJPYwm2861hl32xSAybYxLGNBU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VETdE85ygXVLJILwxsd+hUBR6n0U4zvlSFT8qSpS91Y6cbyl6Pn51b8qjzHF/9BnT
	 jBcHvTZfdtBpasALEpEIbPhuxbrx8PLiFeMVzgVNimInaZq2ZL7fUnoC5y+fibUPlC
	 VuS79+GSbkkvhNRxbfJZCUP2wsJ0mHg8Ek9qoBUg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ6CYaM004366
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Nov 2024 00:12:34 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Nov 2024 00:12:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Nov 2024 00:12:34 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ6CUJd101713;
	Tue, 19 Nov 2024 00:12:31 -0600
Message-ID: <d738bb00-e295-4d74-8ba2-efd82b6df2ea@ti.com>
Date: Tue, 19 Nov 2024 11:42:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-2-danishanwar@ti.com>
 <adcc5aa5-0f51-4c69-b684-a1e0844c5e3f@kernel.org>
 <6e11c85a-5883-4a28-b5bd-98da28f20425@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <6e11c85a-5883-4a28-b5bd-98da28f20425@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 18/11/24 19:22, Roger Quadros wrote:
> 
> 
> On 18/11/2024 15:33, Roger Quadros wrote:
>> Hi,
>>
>> On 13/11/2024 13:09, MD Danish Anwar wrote:
>>> The ICSSG module has 7 clocks for each instance.
>>>
>>> These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
>>> ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
>>> These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.
>>>
>>> Add these clocks to the dt binding of ICSSG.
>>>
>>> Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> index 3cb1471cc6b6..927b3200e29e 100644
>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> @@ -92,6 +92,16 @@ properties:
>>>      description: |
>>>        This property is as per sci-pm-domain.txt.
>>>  
>>> +  clocks:
>>> +    items:
>>> +      - description: ICSSG_CORE Clock
>>> +      - description: ICSSG_IEP Clock
>>> +      - description: ICSSG_RGMII_MHZ_250 Clock
>>> +      - description: ICSSG_RGMII_MHZ_50 Clock
>>> +      - description: ICSSG_RGMII_MHZ_5 Clock
>>> +      - description: ICSSG_UART Clock
>>> +      - description: ICSSG_ICLK Clock
>>> +
>>
>> There are actually many more clocks [1]
>> What is the purpose of adding all these clocks in the DT if driver doesn't
>> use them?
>>

DT should completely describe the HW and not based on what Linux driver
needs. So its valid to describe all clock inputs to a module
irrespective of what driver does with it.

>> Only CORE and IEP clocks parent can be configured via clock muxes.
>> Those are already defined in the icssg?_cfg nodes.
> 
> Actually those clock muxes are internal to ICSSG.
> We still need to be able to set clock parents of CORE and IEP clock.
> 
> So pruss block needs at most 2 clocks like you had in v2 of this patch?
> 
>>
>> [1] - https://software-dl.ti.com/tisci/esd/22_01_02/5_soc_doc/am64x/clocks.html
>>
>>>  patternProperties:
>>>  
>>>    memories@[a-f0-9]+$:
>>
> 

-- 
Regards
Vignesh
https://ti.com/opensource



Return-Path: <linux-kernel+bounces-415789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352CE9D3C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24441F225DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48C1A4F19;
	Wed, 20 Nov 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r80D51hq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A5D2AD00;
	Wed, 20 Nov 2024 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109042; cv=none; b=H4aoVJxBA7csgyfP57pdixXRMUoiOK1I4/jgAl8zzXuVQ7UKOvf7AUhgs85527uFJU35OoUkkQdP9Oy6JcHryVjQ5GtkQKj44HPh7fTnyOwpd68bSxm5rzpS43INWayUIXUK/KCPv7B5AZHBvClUpivX3ILE6tamuYIQcwwtPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109042; c=relaxed/simple;
	bh=GMpwch0dQGvd8JR9hupTeU3RE6+Z14Y3YuH++IcH4wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HAOXxNyUEQdeXVGQoREYM0R4FAl3I7wLKvWWXu+qRkxZg6fyJ5bF/P2CS/0AoAL6yiVayiJxcavd5aG3+gULoxvREzXKXdBa8M9qps2zdCfi/4UpYVD9kuiXk27G/5FMaqU4TCbNXmg5sId6PRS9KMMji5K2akBn7D9kEGirzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r80D51hq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AKDNh4v008580;
	Wed, 20 Nov 2024 07:23:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732109023;
	bh=/cDWTmckm/CkJEDcZQJhRIWR2v+kP8CPV8gAmteQrw0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=r80D51hqBVfb5pyy4I1RpK2mhH2ceTvZfyTyznRgnoj/c+dGtyGQXPbNmM3HWnXZC
	 2fSY6YMFSlwsl0QsoFBlsrQ1zhwyNTrJ5PsyxxJinr6moPtaojUlrduPZ931RStIJi
	 ObVaIP8TLlVf4XHwdaLmDYqGrX/8xouACgR7fCn4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AKDNhwC037109
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Nov 2024 07:23:43 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Nov 2024 07:23:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Nov 2024 07:23:42 -0600
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AKDNcal039209;
	Wed, 20 Nov 2024 07:23:38 -0600
Message-ID: <96ea0c11-e6e7-4801-9c06-2dc80b21b1ab@ti.com>
Date: Wed, 20 Nov 2024 18:53:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: Roger Quadros <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <ssantosh@kernel.org>,
        <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-2-danishanwar@ti.com>
 <adcc5aa5-0f51-4c69-b684-a1e0844c5e3f@kernel.org>
 <6e11c85a-5883-4a28-b5bd-98da28f20425@kernel.org>
 <d738bb00-e295-4d74-8ba2-efd82b6df2ea@ti.com>
 <e633232e-f0ad-43f7-9897-39836e6b98b4@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <e633232e-f0ad-43f7-9897-39836e6b98b4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Roger,

On 11/19/2024 4:15 PM, Roger Quadros wrote:
> 
> 
> On 19/11/2024 08:12, Vignesh Raghavendra wrote:
>>
>>
>> On 18/11/24 19:22, Roger Quadros wrote:
>>>
>>>
>>> On 18/11/2024 15:33, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 13/11/2024 13:09, MD Danish Anwar wrote:
>>>>> The ICSSG module has 7 clocks for each instance.
>>>>>
>>>>> These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
>>>>> ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
>>>>> These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.
>>>>>
>>>>> Add these clocks to the dt binding of ICSSG.
>>>>>
>>>>> Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> index 3cb1471cc6b6..927b3200e29e 100644
>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> @@ -92,6 +92,16 @@ properties:
>>>>>      description: |
>>>>>        This property is as per sci-pm-domain.txt.
>>>>>  
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: ICSSG_CORE Clock
>>>>> +      - description: ICSSG_IEP Clock
>>>>> +      - description: ICSSG_RGMII_MHZ_250 Clock
>>>>> +      - description: ICSSG_RGMII_MHZ_50 Clock
>>>>> +      - description: ICSSG_RGMII_MHZ_5 Clock
>>>>> +      - description: ICSSG_UART Clock
>>>>> +      - description: ICSSG_ICLK Clock
>>>>> +
>>>>
>>>> There are actually many more clocks [1]
>>>> What is the purpose of adding all these clocks in the DT if driver doesn't
>>>> use them?
>>>>
>>
>> DT should completely describe the HW and not based on what Linux driver
>> needs. So its valid to describe all clock inputs to a module
>> irrespective of what driver does with it.
> 
> Fair point. But there are a total 11 clocks instead of 7 in [1]
> 

I took the list of clocks from AM64x TRM [1] Section 6.4.3 Table 6-398.
In the TRM only 7 clocks are mentioned per ICSSG instance which I have
mentioned in the binding.

[1] https://www.ti.com/lit/ug/spruim2h/spruim2h.pdf?ts=1732108738816

>>
>>>> Only CORE and IEP clocks parent can be configured via clock muxes.
>>>> Those are already defined in the icssg?_cfg nodes.
>>>
>>> Actually those clock muxes are internal to ICSSG.
>>> We still need to be able to set clock parents of CORE and IEP clock.
>>>
>>> So pruss block needs at most 2 clocks like you had in v2 of this patch?
>>>
>>>>
>>>> [1] - https://software-dl.ti.com/tisci/esd/22_01_02/5_soc_doc/am64x/clocks.html
>>>>
>>>>>  patternProperties:
>>>>>  
>>>>>    memories@[a-f0-9]+$:
>>>>
>>>
>>
> 

-- 
Thanks and Regards,
Md Danish Anwar


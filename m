Return-Path: <linux-kernel+bounces-180012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A288C68D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFCAB2212B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF8815572E;
	Wed, 15 May 2024 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xY7FT9IP"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70015533B;
	Wed, 15 May 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783693; cv=none; b=spX47dEngclDuK2Afg2e0BFqVNkGiX1J3jtYD7kWJgQavITE2C7/EzUAIcrIYMriWm7fdVz4h0wa0Ec6ACooZ+ZLPngSoBCmQS2tPotuJZzSt/t9qxqu1tJnqqu7+zoymQf8FHCiG4zcpRULcf5InHXHcwoXtOeoXFKGmFtUv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783693; c=relaxed/simple;
	bh=pcZ3tmdh731kSooB4H1TVpxkAiGxEkZhSW1QnaZ8AUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JXHcjjtgt+RQuqJOXI0jIK+BW6t5ZH63fue77PgwPXQ7LqoWU85FiSWYW56VI0+Yb0/riaafg9i8TnRbr2r0Mcf8cHA61KZOBxYJL8Sl9JhZn2L8e14xGZPfXHwXmvitNB2wKPTEZBNoy343jWNeQZdl33mGnK+/FMj/u4Is508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xY7FT9IP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FDCINI002240;
	Wed, 15 May 2024 16:34:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Cc9dLBPQalwD3yYbV6gRE0t8fxv3VP5tkr2ZWiaxNkM=; b=xY
	7FT9IPeanKuVSVs53p/7BqUBuE88tXLELA9q5ovw5wMwSKPLhILYBojWtQhyTFxU
	J71H6koXSd5qPQAR+8K/5nzuAkzzI+tWU28ZWkQeoz1Ln5geAmp89oPRBTrrFfYG
	7SFiymlAw+UH2hFqaXce8c4VMb7O4B2fZGprOrwPmpU9fxSIhb1oH65DWpKt3zgL
	YO0Ut0jzMyczhgHF6UlG4VEg0NDD1qFdEyhnBYB/9YxPL49ssqo7j24x5RRSoHsN
	h6Lmf4KjNp3Z3hCryCq85kZFtII5xs86YcDSl+gyrhoIkzXffD+8rVFMr2qEpFry
	cf4qJeHb8tCSr01FKHlw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4sxvhgbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:34:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E54AF4002D;
	Wed, 15 May 2024 16:34:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA80921F14D;
	Wed, 15 May 2024 16:33:23 +0200 (CEST)
Received: from [10.48.87.205] (10.48.87.205) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 16:33:23 +0200
Message-ID: <0c97408c-422d-46b3-8017-da9ebb0767e1@foss.st.com>
Date: Wed, 15 May 2024 16:33:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
To: Conor Dooley <conor@kernel.org>
CC: Marek Vasut <marex@denx.de>,
        Alexandre TORGUE
	<alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal Paillet <p.paillet@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
 <20240513-stabilize-proofread-81f0f9ee38b9@spud>
 <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>
 <20240514-entryway-idealize-fcd5ed0e1de7@spud>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240514-entryway-idealize-fcd5ed0e1de7@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02

Hi,

On 5/14/24 22:08, Conor Dooley wrote:
> On Mon, May 13, 2024 at 08:02:21PM +0200, Patrick DELAUNAY wrote:
>> Hi,
>>
>> On 5/13/24 17:16, Conor Dooley wrote:
>>> On Mon, May 13, 2024 at 04:34:20PM +0200, Marek Vasut wrote:
>>>> On 5/13/24 11:56 AM, Patrick Delaunay wrote:
>>>>> Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
>>>>>
>>>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>> ---
>>>>>
>>>>> Changes in v3:
>>>>> - Replace oneOf/const by enum; solve the V2 issues for dt_binding_check
>>>>>
>>>>> Changes in v2:
>>>>> - update for Rob review, only add compatible for STM32MP13 family
>>>>>
>>>>>     .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>>>>> index c9586d277f41..c766f0a15a31 100644
>>>>> --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>>>>> +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>>>>> @@ -11,7 +11,9 @@ maintainers:
>>>>>     properties:
>>>>>       compatible:
>>>>> -    const: st,stm32mp1,pwr-reg
>>>>> +    enum:
>>>>> +      - st,stm32mp1,pwr-reg
>>>>> +      - st,stm32mp13-pwr-reg
>>>> Should the st,stm32mp1,pwr-reg be treated as fallback compatible for
>>>> st,stm32mp13-pwr-reg or not ?
>>>>
>>>> In other words, should the DT contain:
>>>> compatible = "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg";
>>>> or
>>>> compatible = "st,stm32mp13-pwr-reg";
>>>> ? Which one is preferable ?
>>>>
>>>> I think the former one, since the MP13 PWR block could also be operated by
>>>> older MP1(5) PWR block driver(s) without any adverse effects, except the SD
>>>> IO domain configuration won't be available, right ?
>>> Aye, the fallback sounds like what should be being used here, especially
>>> if another user of the DT might not need to implement the extra domain.
>>
>> Yes it is the the only difference but I think that type of fallback is no
>> more recommended for different device and
>>
>> the PWR device on STM32MP13 and on STM32MP15 are different.
>>
>>
>> The other user of the non-secure device tree don't use the yet the PWR
>> driver for STM32MP13,
>>
>> so for me the fallback is not needed for non secure world (Linux/U-Boot).
>>
>>
>> So I prefer to introduce a new compatible in Linux kernel before the
>> STM32MP13 PWR node is really used  to avoid ABI break in futur.
> How is it going to break an ABI? If the mp13 implements a functional
> subset of what the mp1 does, then that's what fallback compatibles
> are intended for. Marek's mail suggests that this is the case, and
> therefore a fallback should be used.
>
> If code written for the mp1 would not work on the mp13, then a fallback
> should not be used.
>
> Neither I nor Marek are saying that a new compatible should not be
> created, in case you misunderstood that. This only affects the binding
> patch, and your driver etc are free to use the mp13 compatible.
>
> Thanks,
> Conor.


The IP PWR change with STM32MP13 and it is not just a subset

but for the range used by the compatible <0x50001000 0x10>

I agreed that feature are just added.


Other feature are also removed but for next registers (the associated

registers or bits becomes reserved, for PWR_MCUCR for example).


So I can change in binding to support the DT:


compatible = "st,stm32mp1,pwr-reg";

or for STM32MP13:

compatible = "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg";

with

   compatible:
     oneOf:
         - items:
            - const: st,stm32mp1,pwr-reg
         - items:
            - const: st,stm32mp13-pwr-reg
            - const: st,stm32mp1,pwr-reg


But for me this fallback in device tree is a little confusing for PWR.


Patrick



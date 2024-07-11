Return-Path: <linux-kernel+bounces-249202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A341592E86B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D851F22958
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDB115ECDF;
	Thu, 11 Jul 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TYKoGEZX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AA15D5C7;
	Thu, 11 Jul 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701736; cv=none; b=qDCSgrgrhbacCf1gBAvpJ7jW7MJiUldn/ISRQvIHtPSt4RzDO2yzP8twvyXe6lTVph7/DuggPSp4awQkQsHViDK/pv6vRxSzI4z/OzOjypF5ksrpkXgvdc/1ScfGJPUvCiCFjr/IYmFXc0KAYegeAPwXKsFpP5IIIdDbs1AGLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701736; c=relaxed/simple;
	bh=rJsgesIVzhdyDoHii5bgpKooeyXaE1kjuc//pkbJjDk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=sCLk9cg/oHUJ7A/9v3LE2IX/EdOInI+762eriGZ/OvkJwZRqX98BPa6imNXSKVrggeqxDdYomrhzaP+Bw+9dz1uG6AbNer3xC/Zag3sffD1+1nyPAUnOrrk7Y7yuiEeS3mgT+yfiq4YcfmhZr0gkfUKJf/0pil0A5F6+aeKf9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TYKoGEZX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720701734; x=1752237734;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rJsgesIVzhdyDoHii5bgpKooeyXaE1kjuc//pkbJjDk=;
  b=TYKoGEZXQs00/9nOZI9HADg35d6k3iR5k0zHTQPwYskByI1gWd1d459j
   E0ocPB3uucCsC/6wEjOzdqcsZqmTVvh656ADmyTWxN7p4hqKAY8fpIRzV
   AunwesM1L4iDYz7dOmxtb89VI1eKhASPQ2DvOCt3TLiK1Yk8kD34Oydz7
   o7eV8lsNrCBn/y8eYrMRlL56sp6La8NHowAcfUmFArkHDVVikV5Gdub5f
   /qZ3V79vOt/HrIxq9iJ5yrBmdC6V1PNOeHbhVl7VXzEEkUNzDkAdF30bq
   6es4CKOrLc1Cp3ahmkdhEzDydwiwberDrF0XXTxwjxzEnT/iOy+8uOnU4
   w==;
X-CSE-ConnectionGUID: 4PLxtLmWRACg2xbxAfqrYQ==
X-CSE-MsgGUID: HxPwORIfQxqRqGF1Ct77BQ==
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="31789929"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2024 05:42:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jul 2024 05:41:41 -0700
Received: from [10.180.117.34] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Jul 2024 05:41:38 -0700
Message-ID: <a5b78d97-c646-4915-8d6c-65f134ae08eb@microchip.com>
Date: Thu, 11 Jul 2024 14:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: <Varshini.Rajendran@microchip.com>, <conor@kernel.org>
CC: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Dharma.B@microchip.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <maz@kernel.org>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102814.196063-1-varshini.rajendran@microchip.com>
 <20240703-dentist-wired-bdb063522ef7@spud>
 <a41274c3-fd32-4eba-8240-bf95e41f63d9@microchip.com>
 <82ca4f3d-fa78-4617-823e-69f16a2c3319@microchip.com>
Organization: microchip
In-Reply-To: <82ca4f3d-fa78-4617-823e-69f16a2c3319@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Answering to myself (again) and to Conor...

On 09/07/2024 at 16:06, Nicolas.Ferre@microchip.com wrote:
> On 09/07/2024 at 08:13, Varshini Rajendran - I67070 wrote:
>> On 03/07/24 9:11 pm, Conor Dooley wrote:
>>> On Wed, Jul 03, 2024 at 03:58:14PM +0530, Varshini Rajendran wrote:
>>>> Add the description and conditions to the device tree documentation
>>>> for the property microchip,nr-irqs.
>>>>
>>>> Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.com>
>>> This needs to be part of patch 14.
>>>
>>>> ---
>>>>     .../bindings/interrupt-controller/atmel,aic.yaml     | 12 ++++++++++++
>>>>     1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
>>>> index 9c5af9dbcb6e..06e5f92e7d53 100644
>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
>>>> @@ -54,6 +54,10 @@ properties:
>>>>         $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>         description: u32 array of external irqs.
>>>>     
>>>> +  microchip,nr-irqs:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    description: u32 array of nr_irqs.
>>> This makes no sense, did you just copy from above? Why would the number
>>> of irqs be an array? Why can't you determine this from the compatble?
>>>
>> Sorry for the bad description. I will correct it in the next version.
>>
>> For the second part of the question, this change was done as a step to
>> resolve having a new compatible while having practically the same IP
>> pointed out in the v3 of the series [1]. It is kind of looping back to
>> the initial idea now. Even if this is added as a driver data, it
>> overrides the expectation from the comment in [1]. Please suggest. I
> 
> In your v3 patch, indeed you were extracting the number of IRQs from the
> compatibility string (aka, from device tree...). It's my preferred
> solution as well.
> 
> So, come back to v3 [1] and address what Conor said in v4 "...having
> specific $soc_aic5_of_init() functions for each SoC seems silly when
> usually only the number of interrupts changes. The number of IRQs could
> be in the match data and you could use aic5_of_init in your
> IRQCHIP_DECLARE directly"

Well, after a brief talk with Varshini and a review of the code, I'm not 
so sure it's worth re-writing this part anymore Conor...
It'll need changing 3-4 files (2 drivers and the "common" .h/.c files, 
because of the type change of ".data"); handling the special case of 
sama5d2 (smr_cache thing) and touching lot more code than what is done 
in v3 of this patch series.

Original design was probably not optimal, but well, it's simple, 
understandable and except if there is a big benefit in moving, I would 
prefer to keep it like this.
If you agree, we can ask Varshini to re-post a separated IRQ-focused 
series for handling sam9x75 changes.

Best regards,
   Nicolas

> I think that we can convince Marc/Thomas that it's the best option as it
> prevents introducing another non-standard property to the DT, does not break
> the ABI (and was used happily for years).
> 
> Best regards,
>     Nicolas
> 
> [1]
> https://lore.kernel.org/lkml/87ee1e3c365686bc60e92ba3972dc1a5@kernel.org/
> 
> 
>> also read Rob's concerns on having a device tree property for number of
>> irqs.
>>
>> [1]
>> https://lore.kernel.org/lkml/87ee1e3c365686bc60e92ba3972dc1a5@kernel.org/
>>
>>> Thanks,
>>> Conor.
>>>
>>>> +
>>>>     allOf:
>>>>       - $ref: /schemas/interrupt-controller.yaml#
>>>>       - if:
>>>> @@ -71,6 +75,14 @@ allOf:
>>>>             atmel,external-irqs:
>>>>               minItems: 1
>>>>               maxItems: 1
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: microchip,sam9x7-aic
>>>> +    then:
>>>> +      required:
>>>> +        - microchip,nr-irqs
>>>>     
>>>>     required:
>>>>       - compatible
>>>> -- 
>>>> 2.25.1
>>>>
>>
> 



Return-Path: <linux-kernel+bounces-539498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13431A4A527
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E40C1899F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252C51D9A5D;
	Fri, 28 Feb 2025 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CDn4W0JQ"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51C23F38A;
	Fri, 28 Feb 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778753; cv=none; b=JDCKM46sz79GnuM+O4mT5skE5q3KB3IsVLqFtFMPucOuj38BfrbE3A7pDFvA2ChGKXtN/bo2CaBqjd1Fk6mmW87dBOOjKAC/7w4R+oq4RKfQUNM/lAEeuZM5bYdVYI9+dX8nYjU84DFL0rASZO2VY3/zIheVOwGT1LI6DkMbUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778753; c=relaxed/simple;
	bh=v3sXt3CY02cedb5GqscLy9sHiG8Fcv9G1z+Ha1JSBbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O1CB9dZJz4sKkZSn8BS7KXI7Nydlyht17Jy/JpCLjdNJxHqymgVFEqQ0aR0K38mG0U/S+s4rvKSZIuH4RfCARhM1jzUNRCdlm0JtSnXRuLzcSt4cxvuhrb4SGbv4AKgrY5N1d4Kxp081KEJp7NQorvTdorw3l/wuLEao440uRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CDn4W0JQ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51SLckrU2748647
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 15:38:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740778726;
	bh=dO4Q0rKs3aOccKblhFLjnf6xWDqgH+XFsez+Lbm3iTA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CDn4W0JQyBCbwVL9uwkni4xkmL7EFK02NdreZeCtdMalj0IbxO1nTwEHReIUToyp5
	 kGyRzTSlPZUmi3U9D99ASprxHIougk6jZBDszA2hDXmK05b1GK4l9T2zfMU1K/l45q
	 3w/dBWLlw8bvc7owKhjqfLMdMma+TIU4iPopZvIA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51SLckFb121659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Feb 2025 15:38:46 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Feb 2025 15:38:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Feb 2025 15:38:45 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51SLcerL085241;
	Fri, 28 Feb 2025 15:38:41 -0600
Message-ID: <acde31c5-fe23-4c7b-a823-61ea0958504b@ti.com>
Date: Sat, 1 Mar 2025 03:08:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: Conor Dooley <conor@kernel.org>, Andrew Davis <afd@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250227202206.2551305-1-c-vankar@ti.com>
 <20250227202206.2551305-2-c-vankar@ti.com>
 <f3e69904-92f0-4de8-bfef-a315a6554a1c@ti.com>
 <20250228-recipient-unlinked-271fe63d7335@spud>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <20250228-recipient-unlinked-271fe63d7335@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Conor, Andrew,

On 3/1/2025 12:22 AM, Conor Dooley wrote:
> On Thu, Feb 27, 2025 at 03:26:31PM -0600, Andrew Davis wrote:
>> On 2/27/25 2:22 PM, Chintan Vankar wrote:
>>> DT-binding of reg-mux is defined in such a way that one need to provide
>>> register offset and mask in a "mux-reg-masks" property and corresponding
>>> register value in "idle-states" property. This constraint forces to define
>>> these values in such a way that "mux-reg-masks" and "idle-states" must be
>>> in sync with each other. This implementation would be more complex if
>>> specific register or set of registers need to be configured which has
>>> large memory space. Introduce a new property "mux-reg-masks-state" which
>>> allow to specify offset, mask and value as a tuple in a single property.
>>>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>    .../devicetree/bindings/mux/reg-mux.yaml      | 29 +++++++++++++++++--
>>>    1 file changed, 27 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
>>> index dc4be092fc2f..a73c5efcf860 100644
>>> --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
>>> +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
>>> @@ -32,11 +32,36 @@ properties:
>>>            - description: pre-shifted bitfield mask
>>>        description: Each entry pair describes a single mux control.
>>> -  idle-states: true
>>> +  idle-states:
>>> +    description: Each entry describes mux register state.
>>> +
>>> +  mux-reg-masks-state:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +    items:
>>> +      items:
>>> +        - description: register offset
>>> +        - description: pre-shifted bitfield mask
>>> +        - description: register value to be set
>>> +    description: This property is an extension of mux-reg-masks which
>>> +                 allows specifying register offset, mask and register
>>> +                 value to be set in a single property.
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - reg-mux
>>> +              - mmio-mux
>>
>> These are the only two possible compatibles, is this "if" check needed?
> 
> Aye.
> 
>>> +    then:
>>> +      properties:
>>> +        mux-reg-masks: true
>>> +        mux-reg-masks-state: true
>>
>> You need one, but cannot have both, right? There should be some
>> way to describe that.
>>
>> Also an example added below would be good.
> 
>  From the example schema:
> # if/then schema can be used to handle conditions on a property affecting
> # another property. A typical case is a specific 'compatible' value changes the
> # constraints on other properties.
> #
> # For multiple 'if' schema, group them under an 'allOf'.
> #
> # If the conditionals become too unweldy, then it may be better to just split
> # the binding into separate schema documents.
> allOf:
>    - if:
>        properties:
>          compatible:
>            contains:
>              const: vendor,soc2-ip
>      then:
>        required:
>          - foo-supply
>      else:
>        # If otherwise the property is not allowed:
>        properties:
>          foo-supply: false
> 
> What's missing from here is making one of the properties required,
> so
> oneOf:
>    - required:
>        - masks
>    - required:
>        - masks-state
> 
>>
>> Andrew

Thanks for reviewing this patch.

For the use-case we have following three rules to be followed:
1. "mux-reg-masks" and "mux-reg-masks-state" should be mutually
    exclusive.
2. "mux-reg-masks-state" and "idle-states" should also be mutually
    exclusive.
3. If "mux-reg-masks" is present then "idle-states" might or might not
    be there.

For the above conditions I have tried to write a binding as:

allOf:
   - not:
       required: [mux-reg-masks, mux-reg-masks-state]

   - if:
       required: [mux-reg-masks-state]
     then:
       not:
         required: [idle-states]

   - if:
       required: [mux-reg-masks]
     then:
       properties:
         idle-states:
           description: It can be present with mux-reg-masks, but not 
required

It is passing dt_binding_check and dtbs_check against correct and
incorrect properties provided in device tree node.

Let me know if you find this correct.

Regards,
Chintan.

>>
>>> +      maxItems: 1
>>>    required:
>>>      - compatible
>>> -  - mux-reg-masks
>>>      - '#mux-control-cells'
>>>    additionalProperties: false


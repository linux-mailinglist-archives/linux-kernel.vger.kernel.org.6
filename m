Return-Path: <linux-kernel+bounces-542570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A5A4CB33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404FC175A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A222DFB6;
	Mon,  3 Mar 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ApqiYCDf"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462352153D0;
	Mon,  3 Mar 2025 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027578; cv=none; b=GeTuaCISw0sgSVR4Y0GnGCLAlnGyHsj+Xi5PZnWRBCGVwdla8SMkOitONw6XSMXPMga61GyHLsL1TYjiyyPBrWjL4342Ni5GLlCzQHtz7Syo/i/3pUV+hF79wzYAdHzcbA02iuyPApm2lB9bRWQaZcf5fMmjqS/OG6d+s6d9hcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027578; c=relaxed/simple;
	bh=6FF5AYD1g8CPd4Jwp66WLGpSWhPN/qncW22Sml3xcXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lrd5KahpJyCrcQKCwTxO7RXLD6ULeD1dmuZU7uEz3BeSmNDDBVL+tuGd6kogQxXM2iOYAZolsSFmhB0YKOpfm5FdWtq8oSUzlaQVEh/X4rawoG3DWx2LYkAH74MA9zIYjOBOTjk5ddGtSAESfex+VwozFLMc5zzpgjCHy5oNICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ApqiYCDf; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523IjtCQ2748824
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 12:45:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741027555;
	bh=GGxQAx/6WfzA+lZJ1OXRUAcxwNBBrPtP4XVOLwrjNU8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ApqiYCDfoHzLG9q8ryVf33gxNSF39bvsdCYIQGkXQecSIWyFmrZlEf3fo3lzyNSvv
	 avehR6IFYIen9lT+odBqvI2RCRARlggG29YBzj7/oYahsA/StKYcWrNcjjG16bXgf8
	 OEcDhewX5wol8bAp6X5vjq63vnJE7v1lTQqWStsQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 523IjsqO016421
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 12:45:54 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 12:45:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 12:45:54 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523Ijnl2055567;
	Mon, 3 Mar 2025 12:45:50 -0600
Message-ID: <5ec4e67b-93fd-429e-b93a-838a291a6c7f@ti.com>
Date: Tue, 4 Mar 2025 00:15:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: Conor Dooley <conor@kernel.org>
CC: Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250227202206.2551305-1-c-vankar@ti.com>
 <20250227202206.2551305-2-c-vankar@ti.com>
 <f3e69904-92f0-4de8-bfef-a315a6554a1c@ti.com>
 <20250228-recipient-unlinked-271fe63d7335@spud>
 <acde31c5-fe23-4c7b-a823-61ea0958504b@ti.com>
 <20250303-mummify-mutation-67595b7ceba5@spud>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <20250303-mummify-mutation-67595b7ceba5@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Conor,

On 3/3/2025 10:28 PM, Conor Dooley wrote:
> On Sat, Mar 01, 2025 at 03:08:40AM +0530, Vankar, Chintan wrote:
>> Hello Conor, Andrew,
>>
>> On 3/1/2025 12:22 AM, Conor Dooley wrote:
>>> On Thu, Feb 27, 2025 at 03:26:31PM -0600, Andrew Davis wrote:
>>>> On 2/27/25 2:22 PM, Chintan Vankar wrote:
>>>>> DT-binding of reg-mux is defined in such a way that one need to provide
>>>>> register offset and mask in a "mux-reg-masks" property and corresponding
>>>>> register value in "idle-states" property. This constraint forces to define
>>>>> these values in such a way that "mux-reg-masks" and "idle-states" must be
>>>>> in sync with each other. This implementation would be more complex if
>>>>> specific register or set of registers need to be configured which has
>>>>> large memory space. Introduce a new property "mux-reg-masks-state" which
>>>>> allow to specify offset, mask and value as a tuple in a single property.
>>>>>
>>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>>> ---
>>>>>     .../devicetree/bindings/mux/reg-mux.yaml      | 29 +++++++++++++++++--
>>>>>     1 file changed, 27 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
>>>>> index dc4be092fc2f..a73c5efcf860 100644
>>>>> --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
>>>>> @@ -32,11 +32,36 @@ properties:
>>>>>             - description: pre-shifted bitfield mask
>>>>>         description: Each entry pair describes a single mux control.
>>>>> -  idle-states: true
>>>>> +  idle-states:
>>>>> +    description: Each entry describes mux register state.
>>>>> +
>>>>> +  mux-reg-masks-state:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>>>> +    items:
>>>>> +      items:
>>>>> +        - description: register offset
>>>>> +        - description: pre-shifted bitfield mask
>>>>> +        - description: register value to be set
>>>>> +    description: This property is an extension of mux-reg-masks which
>>>>> +                 allows specifying register offset, mask and register
>>>>> +                 value to be set in a single property.
>>>>> +
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - reg-mux
>>>>> +              - mmio-mux
>>>>
>>>> These are the only two possible compatibles, is this "if" check needed?
>>>
>>> Aye.
>>>
>>>>> +    then:
>>>>> +      properties:
>>>>> +        mux-reg-masks: true
>>>>> +        mux-reg-masks-state: true
>>>>
>>>> You need one, but cannot have both, right? There should be some
>>>> way to describe that.
>>>>
>>>> Also an example added below would be good.
>>>
>>>   From the example schema:
>>> # if/then schema can be used to handle conditions on a property affecting
>>> # another property. A typical case is a specific 'compatible' value changes the
>>> # constraints on other properties.
>>> #
>>> # For multiple 'if' schema, group them under an 'allOf'.
>>> #
>>> # If the conditionals become too unweldy, then it may be better to just split
>>> # the binding into separate schema documents.
>>> allOf:
>>>     - if:
>>>         properties:
>>>           compatible:
>>>             contains:
>>>               const: vendor,soc2-ip
>>>       then:
>>>         required:
>>>           - foo-supply
>>>       else:
>>>         # If otherwise the property is not allowed:
>>>         properties:
>>>           foo-supply: false
>>>
>>> What's missing from here is making one of the properties required,
>>> so
>>> oneOf:
>>>     - required:
>>>         - masks
>>>     - required:
>>>         - masks-state
>>>
>>>>
>>>> Andrew
>>
>> Thanks for reviewing this patch.
>>
>> For the use-case we have following three rules to be followed:
>> 1. "mux-reg-masks" and "mux-reg-masks-state" should be mutually
>>     exclusive.
>> 2. "mux-reg-masks-state" and "idle-states" should also be mutually
>>     exclusive.
>> 3. If "mux-reg-masks" is present then "idle-states" might or might not
>>     be there.
>>
>> For the above conditions I have tried to write a binding as:
>>
>> allOf:
>>    - not:
>>        required: [mux-reg-masks, mux-reg-masks-state]
>>
>>    - if:
>>        required: [mux-reg-masks-state]
>>      then:
>>        not:
>>          required: [idle-states]
> 
> Why'd you pick two different syntax here?
> The normal syntax for mutual exclusion is:
> if:
>    required:
>      - foo
> then:
>    properties:
>      foobar: false
> 
> 
>>
> 
>>    - if:
>>        required: [mux-reg-masks]
>>      then:
>>        properties:
>>          idle-states:
>>            description: It can be present with mux-reg-masks, but not
>> required
> 
> This one here is the default, I don't think it needs an if/else.
> 

Thank you for reviewing the patch. I modified binding according to your
suggestions and that worked for all conditions mentioned above. I will
update it and post v2.


Regards,
Chintan.



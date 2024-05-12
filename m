Return-Path: <linux-kernel+bounces-176943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1248C37AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC112813C9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFC54AEE0;
	Sun, 12 May 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om2bu82u"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256751CD24;
	Sun, 12 May 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715533100; cv=none; b=DvCrHEhA31ESQzPmLXCoqHNBH7SAseiW/HKUY9hKvOrsR3dwlh/Ie+Oj1Axd9MqupCc/rB2PwvP4InReTZWBXVi7+FDk6V2OZjEI09abfX+PO7FGfYM4qMKeW58LYImY9EJUWZcylwkXvsU0JKWXLQHphzzZ1vxb5DjSV/KwtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715533100; c=relaxed/simple;
	bh=m7zS6zcoBMRNZZt7ipKxvhJHQw9YT3Hwmdao/QHQMuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ool9VI0wSJmeXhsjdcaA7w2RrHvHEk7FDQGdMV+YcNTSFLFagEG7mmaHPDi4BJC5Ls+4RsgmMMZzVdmurTb7yD+5I0ji0xw4Oe/gQSL/lS/wuoKdmCXoW5pfDj6W/fziI1k+NOyjMS5pDcF4VlxWSUo5H88HGNczVIDPnxed8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om2bu82u; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f472d550cbso2903419b3a.1;
        Sun, 12 May 2024 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715533098; x=1716137898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=m3bCERVAiYczIXapiys2XXnojSTjvoI2OVt0L+T351I=;
        b=Om2bu82u+vGh4swR+frhwpX9YJwe0aL3gGcTahRUFit2z0WhUNQIZLBH1DSYCtTrDl
         bPxwyYZBO88AA7NcrTVpJDSnlzggxVKIMAgTv59i8lSKkwNC3zWH++JDSe5g1chkf9sD
         S6EpODuj8LfJo8kwYY7sT74skbj0qxx3dTJlFH4uZJKAA/PeSlY3OaPDslwHRwWFhSkA
         FwOfJPy3mCq7eNHhSsVG50Gwh0kY2qJaMnG9coY9peSxlgxzCpdZC2rZr/xmMSlQFy9y
         Pn5BFNFppurDeF+EUozdbXXfFvF5kvhMLx0+oWKrd/RDoTYh4Gy33HHZ3U6LGxLQq0in
         p2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715533098; x=1716137898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3bCERVAiYczIXapiys2XXnojSTjvoI2OVt0L+T351I=;
        b=j/8IJvGXTJmudPXuUHKPZ0pjT8KC0E4GMCtpik+w5RrrdlUii/XfvpoHuOUKy1qBak
         H0k3ScFNXsYEkHiPvfiCSNJYxsKI6Nta5IRw9UJoVk7niRBdDqDjsW/HnQnHBqZyEzub
         h0Y5HYus3Ic8A3Jc+LsmBiA4YCDkCi0ZLUnLhrjxmURpDcVDfvilV9YO1od5LNL2ZYT2
         Zx/mojzVyhKRNHCziZXpsozyBi8rNQjeU/2X+2E4JSo6w2h2D+GWES556Sa8HV28OQ2F
         Q6aDSfiELZ8XFMddf5B2ENbJNuoesRIvqzFfu9oJ+SDvWVaurKZZOT4xZRACkwvWLABw
         QuBg==
X-Forwarded-Encrypted: i=1; AJvYcCWcz3XaYlWxH5HZyIwVI8cZ++6DLd4xplz81zPtQZ/wAkrHnkPYZSHQ5DmMS8EJfY1vSe+l9ZUpadN3Ux4zYkpPFLNOobVAu9JGRwMTdCZcoOY+8X46gGHTGCee2K8stSlb6QCRrbTM83cgKZLbp12wElL6nrKXV6bVN2/7NExQBJL0EU0Z
X-Gm-Message-State: AOJu0Yz9ivv0NCb+5pKoKsAwIEl+vQyLIzDMlRHZvr2rNMAZ9ad4//6B
	Fulx+wzFiaUVYnD5ad8nv9SOIiQif9H0aTS8S8SpaHR5YubywHXbVus0AQ==
X-Google-Smtp-Source: AGHT+IFkHtpL5J0z7ANMLHj1w9xl2e4IUVfW9adgUZc+8s/+KxnAzonAVXTyXBVqyOHuJ+CqXxMddA==
X-Received: by 2002:a05:6a00:2395:b0:6ed:9760:9ba7 with SMTP id d2e1a72fcca58-6f4e0348548mr12637369b3a.22.1715533098064;
        Sun, 12 May 2024 09:58:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b11sm6069304b3a.148.2024.05.12.09.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 09:58:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df40a387-37db-4a4d-b43f-ae22905789b5@roeck-us.net>
Date: Sun, 12 May 2024 09:58:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
 <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
 <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
 <35361786-ef5f-4d81-83e8-e347f47c83ed@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <35361786-ef5f-4d81-83e8-e347f47c83ed@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/24 08:51, Chris Packham wrote:
> 
> On 10/05/24 15:36, Guenter Roeck wrote:
>> Chris,
>>
>> On Thu, May 09, 2024 at 06:19:12PM +0000, Chris Packham wrote:
>>> Hi Krzysztof,
>>>
>>> On 9/05/24 19:06, Krzysztof Kozlowski wrote:
>>>> On 08/05/2024 23:55, Chris Packham wrote:
>>>>> Add documentation for the pwm-initial-duty-cycle and
>>>>> pwm-initial-frequency properties. These allow the starting state of the
>>>>> PWM outputs to be set to cater for hardware designs where undesirable
>>>>> amounts of noise is created by the default hardware state.
>>>>>
>>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>        Changes in v2:
>>>>>        - Document 0 as a valid value (leaves hardware as-is)
>>>>>
>>>>>     .../devicetree/bindings/hwmon/adt7475.yaml    | 27 ++++++++++++++++++-
>>>>>     1 file changed, 26 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>>>>> index 051c976ab711..97deda082b4a 100644
>>>>> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>>>>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>>>>> @@ -51,6 +51,30 @@ properties:
>>>>>           enum: [0, 1]
>>>>>           default: 1
>>>>>     
>>>>> +  adi,pwm-initial-duty-cycle:
>>>>> +    description: |
>>>>> +      Configures the initial duty cycle for the PWM outputs. The hardware
>>>>> +      default is 100% but this may cause unwanted fan noise at startup. Set
>>>>> +      this to a value from 0 (0% duty cycle) to 255 (100% duty cycle).
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>> +    minItems: 3
>>>>> +    maxItems: 3
>>>>> +    items:
>>>>> +      minimum: 0
>>>>> +      maximum: 255
>>>>> +      default: 255
>>>>> +
>>>>> +  adi,pwm-initial-frequency:
>>>> Frequency usually has some units, so use appropriate unit suffix and
>>>> drop $ref.  Maybe that's just target-rpm property?
>>>>
>>>> But isn't this duplicating previous property? This is fan controller,
>>>> not PWM provider (in any case you miss proper $refs to pwm.yaml or
>>>> fan-common.yaml), so the only thing you initially want to configure is
>>>> the fan rotation, not specific PWM waveform. If you you want to
>>>> configure specific PWM waveform, then it's a PWM provider... but it is
>>>> not... Confused.
>>> There's two things going on here. There's a PWM duty cycle which is
>>> configurable from 0% to 100%. It might be nice if this was expressed as
>>> a percentage instead of 0-255 but I went with the latter because that's
>>> how the sysfs ABI for the duty cycle works.
>>>
>>> The frequency (which I'll call adi,pwm-initial-frequency-hz in v3)
>>> affects how that duty cycle is presented to the fans. So you could still
>>> have a duty cycle of 50% at any frequency. What frequency is best
>>> depends on the kind of fans being used. In my particular case the lower
>>> frequencies end up with the fans oscillating annoyingly so I use the
>>> highest setting.
>>>
>> My udnerstanding is that we are supposed to use standard pwm provider
>> properties. The property description is provider specicic, so I think
>> we can pretty much just make it up.
>>
>> Essentially you'd first define a pwm provider which defines all the
>> pwm parameters needed, such as pwm freqency, default duty cycle,
>> and flags such as PWM_POLARITY_INVERTED. You'd then add something like
>>
>> 	pwms = <&pwm index frequency duty_cycle ... flags>;
>>
>> to the node for each fan, and be done.
>>
>> That doesn't mean that we would actually have to register the chip
>> as pwm provider with the pwm subsystem; all we would have to do is to
>> interpret the property values.
> 
> We've already got the pwm-active-state as a separate property so that
> might be tricky to deal with, I guess it could be deprecated in favour
> of something else. Looking at pwm.yaml and fan-common.yaml I can't quite
> see how that'd help here. Were you thinking maybe something like
> 
> pwm: hwmon@2e {
>       compatible = "adi,adt7476";
>       reg = <0x2e>;
>       #pwm-cells = <4>;
>       fan-0 {
>           pwms = <&pwm 0 255 22500 PWM_POLARITY_INVERTED>;
>           pwm-names = "PWM1";
>           tach-ch = <0>;
>       };
>       fan-1 {
>           // controlled by pwm 0
>           tach-ch = <1>
>       };
>       fan-0 {
>           pwms = <&pwm 2 255 22500 PWM_POLARITY_INVERTED>;
>           pwm-names = "PWM3";
>           tach-ch <2>;
>       };
>       fan-1 {
>           // controlled by pwm 2
>           tach-ch = <3>

I think that would have to be

	...
	fan-0 {
		pwms = <&pwm 0 255 22500 PWM_POLARITY_INVERTED>;
		tach-ch = <1 2>;
	};
	fan-1 {
		tach-ch = <3>
	};
	...

Context: pwm-names is optional and does not add value here unless I am missing
something. Also, if I understand the bindings correctly, all tachometer channels
controlled by a single pwm are supposed to be listed in a single node. With the
above, you'd then have fan1, fan2, and fan3 plus pwm1 and pwm3 (pwm2 would be
disabled/unused).

Code-wise, I think you'd then call
	
	struct of_phandle_args args;
	...
	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", 0, &args)

with np pointing to the fan node. This should return the parameters in 'args'.

However, unless you have a use case, I'd suggest not to implement support for
"multiple fans controlled by single pwm" since that would require extra
code and you would not actually be able to test it. A mandatory 1:1 mapping
is fine with me. Support for 1:n mapping can be implemented if / when there
is a use case. The same is true for registering the driver with the pwm
subsystem - that would only be necessary if anyone ever uses one of the
pwm channels for non-fan use.

That makes me wonder if we actually need tach-ch in the first place or if
something like

	fan-0 {
		pwms = <&pwm 0 255 22500 PWM_POLARITY_INVERTED>;
	};
	fan-1 {
		pwms = <&pwm 1 255 22500 0>;
	};
	...
	
would do for this chip.

Thanks,
Guenter



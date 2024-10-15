Return-Path: <linux-kernel+bounces-366025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C999EFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCDB1F218CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413461D514E;
	Tue, 15 Oct 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TbUvN1Bp"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDE1C4A2B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003233; cv=none; b=MWfg966YvRakLNOW7GugpszzZYv7ceMsNPfT9WFMWJDaY5c0j2b+bmgfniH2jpVyf8zjDoRsw8zKcX9AYjlvfOTrzUNzWzFF9Ni4rwT4m/Z7FCyyhxRxj3YdcvAJszNUywtcVrkqk+1EyvotU9OjS8vzZ27yxSkqsV7T3yI5c3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003233; c=relaxed/simple;
	bh=HafF51l0Dw04YR3C4xMW8zz+FNj5C+aYIIfTfhj6UaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CADIksyJ6VNozq3yczrNGEhwGONzh7VlQ4QM99CkHSvaWF+RE4QOAg1CXmy4BEblAxxJb00rZVYDGS80RghRQ6Hm+FD2r56y3Hkb56CnzX0R2SOjnQUrIrrTWEn5pQ0TfKRb1fFTpzoCH9Ll/be5euTlevDDn/zWLEVA0wZqeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TbUvN1Bp; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e800d4e462so3406627eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729003231; x=1729608031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eVyu9tprf37CeRcw5b1zQz8bc1ENAuWIyCm/hiERNI=;
        b=TbUvN1BplliO81wnp5nPviFdhhm6AZQjyxjXtlMaW851vLBEUvqtLKVESkI4nsYo1/
         XxpnwDSIMkjGLV1oRIJUu8fUDEULzICl0wN4w9lB2Gboh7JjvqT4KLFLkhci8vDnXJc1
         UrHe3ejr2pli4fDmUNu25BieEvL9YcJXZBXHj9cse3jacp1G+q79aavj2en46VCSARra
         xgdq43fS0jNP5q2MbrtIAwZ3tdO3P170OWF8PSxR6oHzMg66zR7YCLFSHFO5yXkHNmB5
         NsEC6omtdfJI0PssUJe1FDeO9DVLkhYpIKUHItGsMhzETpNGVLnYP0EkeGSmzR6Wc0ki
         hWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003231; x=1729608031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eVyu9tprf37CeRcw5b1zQz8bc1ENAuWIyCm/hiERNI=;
        b=fBJNn2uS3PaQEVAWdOrd+SWg+fysNOE9eKY3l9HspHewYtfo7qMP3OzCAp46sq+Oyu
         F0dfFcO00eCjmoyKDO9mKqxyESNJ4mNcDmpFHswiRFcJWX2H1OLfTyQrZ2ODd7Hsc6GM
         5q7R1QsPLf7obnMSIBmzuXxJHzdZuq5hNhZ4WpWf/7ZJ2cBu/oIzYbBcnWUKDDj1rsas
         RA+dqoOry3TxekFN7vec95FaiGfb6XQ+g8Y010tSAv7HV5yogJ3E0OIACdf413PAFd2X
         iK8Q99mKW7eGUk1Mv5R13hX81da8hF0PQvKER5F8ih8Nt3pxDv4s74GBR4BJvhHQTNCC
         v1mw==
X-Forwarded-Encrypted: i=1; AJvYcCUL2GLdh5d8crIuq0qJMRzJj+G2fM/h4bYLOvoLs4q/YgLntvgr/2vlniRT9yJdSaAmI9SgMGrqkJwAR3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZHoF4LNDMmWDnG5ZgO/ZwnCgLj0N5YNM2CpyESnhLrYgkSph
	iOq5+kumEmvRwLyS198Mk/8IDWlZ+Y1ik276xhCAXAK/vL3Em759g6IcO+3HiGs=
X-Google-Smtp-Source: AGHT+IEbTJ+IA2/kUITJwQXNvInWKNa0YzYKVAoz67hDrnJqI/0/GA3cU2i57uzu+u79tiGhYwDNMQ==
X-Received: by 2002:a05:6820:22a6:b0:5e5:c073:9ea5 with SMTP id 006d021491bc7-5eb1a1ca9b1mr8904670eaf.6.1729003230954;
        Tue, 15 Oct 2024 07:40:30 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eb4eee7f3csm263487eaf.47.2024.10.15.07.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:40:30 -0700 (PDT)
Message-ID: <776ed45e-7ca8-42e8-9050-86928f223965@baylibre.com>
Date: Tue, 15 Oct 2024 09:40:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
 <a27eb208-0fa1-45cc-bb0c-18a03b6cce4e@baylibre.com>
 <imlhddzkf5eefr64n73pgtbvyax54746v6wzlwngryzzwrbw4h@uaaom7tbod5m>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <imlhddzkf5eefr64n73pgtbvyax54746v6wzlwngryzzwrbw4h@uaaom7tbod5m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 2:44 AM, Angelo Dureghello wrote:
> On 14.10.2024 16:13, David Lechner wrote:
>> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>> Add a new compatible and related bindigns for the fpga-based
>>> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
>>>
>>> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
>>> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
>>> mainly to reach high speed transfer rates using a QSPI DDR
>>> (dobule-data-rate) interface.
>>>
>>> The ad3552r device is defined as a child of the AXI DAC, that in
>>> this case is acting as an SPI controller.
>>>
>>> Note, #io-backend is present because it is possible (in theory anyway)
>>> to use a separate controller for the control path than that used
>>> for the datapath.
>>>
>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
>>>  1 file changed, 53 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>> index a55e9bfc66d7..2b7e16717219 100644
>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>> @@ -19,11 +19,13 @@ description: |
>>>    memory via DMA into the DAC.
>>>  
>>>    https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
>>> +  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>>>  
>>>  properties:
>>>    compatible:
>>>      enum:
>>>        - adi,axi-dac-9.1.b
>>> +      - adi,axi-ad3552r
>>>  
>>>    reg:
>>>      maxItems: 1
>>> @@ -36,7 +38,14 @@ properties:
>>>        - const: tx
>>>  
>>>    clocks:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: s_axi_aclk
>>> +      - const: dac_clk
>>>  
>>>    '#io-backend-cells':
>>>      const: 0
>>> @@ -47,7 +56,16 @@ required:
>>>    - reg
>>>    - clocks
>>>  
>>> -additionalProperties: false
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: adi,axi-ad3552r
>>> +    then:
>>> +      $ref: /schemas/spi/spi-controller.yaml#
>>   +      properties:
>>   +        clocks:
>>   +          minItems: 2
>>   +        clock-names:
>>   +          minItems: 2
>>   +      required:
>>   +        clock-names
>>   +    else:
>>   +      properties:
>>   +        clocks:
>>   +          maxItems: 1
>>   +        clock-names:
>>   +          maxItems: 1
>>
>> We could make the checking of clocks more strict to show
>> the intent:
>>
>> adi,axi-dac-9.1.b only has 1 clock and clock-names is optional.
>>
>> adi,axi-ad3552r always has 2 clocks and clock-names is required.
>>
> is this really necessary ? At v.6 would not fix things
> not reallyh necessary.
>  
It is just a suggestion from me. I will leave it to the maintainers
to say if it is necessary or not. (If they don't say anything, then
we'll take it to mean it isn't necessary.)



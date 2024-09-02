Return-Path: <linux-kernel+bounces-311851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6775968E98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA78B218A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE82205E11;
	Mon,  2 Sep 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OsbFPBeM"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF71C62DE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307141; cv=none; b=shGhYUua7niGUaD8SPfCb2wxrni6HGfyAeX0WO4olIhrfpsKtstl4tSqGoyb6pI1MOtWGGkiCBVt4AZ1mJgRjsRaFYl0+NbTrgGvlqcFUOx/t2IDCy/dLtM4pykzkocRZflREvpCcdyJ//8HgjnrAFpvFcnZQXoJQ6zxZwZ6xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307141; c=relaxed/simple;
	bh=BwxqahULdSizwPJVSw8Q70Qp+MrKvqymtoV6o/RZaBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t98NjbtvPeUOZd2+WjJbyxhFOz1107VwgUHfbcaVSnqtde5QK3AezedzkoxMg+DOrABd5khBmJZ2YOXgoAZacHb3BFzalyIyPHA+LAwkWb7EDouOo7RgYHDS0Xayb7wt7mWQLDO8HCkes5z2WQkKn2PiJoMyStSTcnBBWzhUFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OsbFPBeM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-277e4327c99so939132fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725307138; x=1725911938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNrRj9OEWwXS7/Ii5F9yvEAGtDcXpYbQpO+jVkJw2nQ=;
        b=OsbFPBeMHZXpCQpigZnLrz2k0Utkf+AXHVpcQ8U6ANVc/Z0irpOMqZMjRNirh5t5Fc
         qxczXMJwpIxzoGWJEQ+4ngPghNRPFzBajeeV5hj63GlgYvcl+CaBN9AkRW4GMIvV3EKU
         nqrx1Ehv6Ok4g/BALp/BJZTeveIoVxNnPDioVuXpR6nwvH3rV1+AAmuQP0qu9KfWafK6
         +m+PJC84NxKQcnYDXobz1w0qVNxqQ6rC8KDpZbg2bxwD3bl35ZPA+VbMXxnnkvu3GSOO
         az3ABydfptHYvgzOfiZh6DgMtazMAKpos7tBjw+kfZAmvTwglp/M1g8BnziQAgXF5Yuw
         gxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725307138; x=1725911938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNrRj9OEWwXS7/Ii5F9yvEAGtDcXpYbQpO+jVkJw2nQ=;
        b=no223NrGxABGbKN+rgfBcGK7+9Ak64fdES+jVgQe463ZDnnz7xyEy8/4tZAQeFppSz
         p9Rhp0EA+rEIL+fOP7Ibm7y4h4tWgXAjKQERwFIjUV0dctksie6jRdeIwLtwDKUgER6F
         STU3fYHp+We3gkNv8t0eEV0wQdbPQ2sEkYwbW/mBLO26GryJF7OnXWQzzW7GB2nwE7bh
         Zry8B3W3g5MNRTbJuZaZJzYavnoW7juVWLX/xuToixtgiHxcBMr4qYHZa2ANf+NZW6F9
         myiahH9w5LaSwl5cs+Ixxjxqq8l33uEgl5lPA+uxHNbXcjnxpYekCR8Pdyw4/ZYld5rT
         2/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWDV1yrhc3O0Gt+C5zRfgPmZAiCRoPC3rP9qExXs6xbVrfep+sYL96HTDZjx4kTcPdFq6nWsM91P1n9zoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUZLccgLSHRTXMe9Z3sTXaHjGT8pM2nPGP3hh7XH7B5Fv8r3e
	dbKzHUbLDoxrPDTypbnmjwd3F8snUTwyYGI3HvJquSRdy/fPrW/OOleH1VoqceA=
X-Google-Smtp-Source: AGHT+IFsaUEAvbfS9yCZfI6sbEtSOoGmThw+rj8MCi9eKTvz1FT2KgJBN8CmrO9BcPde4ptYtlffFw==
X-Received: by 2002:a05:6870:239e:b0:25e:d90:fe70 with SMTP id 586e51a60fabf-277d06c6275mr9311658fac.43.1725307138011;
        Mon, 02 Sep 2024 12:58:58 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-277fe2c5577sm546463fac.33.2024.09.02.12.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 12:58:57 -0700 (PDT)
Message-ID: <7cd270b3-9df3-41a6-82ee-43bab78f379b@baylibre.com>
Date: Mon, 2 Sep 2024 14:58:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
To: Alexandru Ardelean <aardelean@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com
References: <20240902103638.686039-1-aardelean@baylibre.com>
 <20240902103638.686039-8-aardelean@baylibre.com>
 <rdk2f6c457k462g5v6s5vumdmhejefyfareio5f6bogslg4wg5@ket4vfwwbyi7>
 <CA+GgBR-aQw+JHky5XwRDQj=6y1pHD=OvBeGW1ocd=ZR6ieBJrw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+GgBR-aQw+JHky5XwRDQj=6y1pHD=OvBeGW1ocd=ZR6ieBJrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/24 1:38 PM, Alexandru Ardelean wrote:
> On Mon, Sep 2, 2024 at 2:55 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Mon, Sep 02, 2024 at 01:36:30PM +0300, Alexandru Ardelean wrote:
>>>    reg:
>>> @@ -114,6 +118,25 @@ properties:
>>>        assumed that the pins are hardwired to VDD.
>>>      type: boolean
>>>
>>> +patternProperties:
>>> +  "^channel@([0-7])$":
>>> +    type: object
>>> +    $ref: adc.yaml
>>> +    unevaluatedProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: The channel number.
>>> +        minimum: 0
>>> +        maximum: 7
>>> +
>>> +      diff-channels: true
>>
>> Shouldn't this be specific?
> 
> Umm.
> Specific how?
> Like if:then check for certain compatible strings?
> 

diff-channels is not a boolean property, it is an array of two
integers that specify the positive and negative pins. So this
should have e.g. minimum: and maximum: constraints for each
item in the array. Even if we only use this like a boolean flag
in the driver, we need to make the bindings use the already
established definition of diff-channels from adc.yaml.

It would look like this in the .dts:

    diff-channels = <1 1>;

The datasheet numbers the pins 1 to 8 instead of 0 to 7,
so it would make sense to have the pin number be reg + 1
(or redefine reg to be minimum: 1, maximum: 8).

We also recently introduced a single-channel property
that can be used when the pin number of of the input
doesn't match the reg number.

>>
>>> +
>>> +      bipolar: true
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -202,4 +225,44 @@ examples:
>>>              standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
>>>          };
>>>      };
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        adc@0 {
>>> +            compatible = "adi,ad7606c-18";
>>> +            reg = <0>;
>>> +            spi-max-frequency = <1000000>;
>>> +            spi-cpol;
>>> +            spi-cpha;
>>> +
>>> +            avcc-supply = <&adc_vref>;
>>> +            vdrive-supply = <&vdd_supply>;
>>> +
>>> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>>> +            interrupt-parent = <&gpio>;
>>> +
>>> +            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
>>> +
>>> +            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
>>> +            reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
>>> +            adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>>> +            standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
>>> +
>>> +            adi,sw-mode;
>>> +
>>> +            channel@1 {
>>> +                reg = <1>;
>>> +                diff-channel;
>>
>> Where is this property defined (which schema)?
>>
>> Did you test it?
> 
> Tested on my board.
> But forgot to update the DT schema docs.
> Though, if you're referring to testing it somehow via some make
> command, I'm a little behind on how all this works now.
> I'll go re-check the "make dtbs_check" and similar commands.
> 
> Maybe I sound a bit old (now), but when I last saw these DT bindings
> going from txt-to-yaml, they seemed relatively simple.
> Now, they're almost like their own programming language.
> I'll search for some quick setup guides for these; any pointers are welcome :)

I can help you with this.




Return-Path: <linux-kernel+bounces-283195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17CB94EE82
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992732819B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B117C22A;
	Mon, 12 Aug 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uccGAWSQ"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9F17C23D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470111; cv=none; b=QOY+MPin8LwtenNEdkVQhfBJugHDH2gFfwi7lO6NAEu/qVoR36Q7X8uGDnnjjD3o13qQ8y/YcQ5d8reQlfOACwPAbMfHOxsQvwL+2DgEiehejieJieDgjJhYIwWzqTpPpjk3L/6phUhZv4RVm06ywhZuQxoSAa04Xqv3e5pwyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470111; c=relaxed/simple;
	bh=PEyKKukDad7GSVDb0CG3ZU0fM7J0jKqyxUBcbGgzGX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aev0v3uBT9M1uyn6f3cbTpenof1SblbV6FyWxWt2xdAfkv/h4bb/wogAxg28/XGhZEswT5ghPefzRB7F8IcRhEvU20b/QhFr3183UuxQBWRzCAJ7wEiFjS8Npi//pczhQey0AQ0U4ZEG6StsBuubjwxEf73U4Eg9tEVm3u1JEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uccGAWSQ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4928fa870a9so1308673137.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723470108; x=1724074908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZdPiM3eHhS0gXqA59iljos4r3z2B3CpNxMTL6TtBWM=;
        b=uccGAWSQ5ek9ShKj1pa75/hA7CBc0MhDjGaF6Jx9vTEhEQUDHxNCuOHni/XFi+3asI
         Y2Pma2fxk6NqejJushapyYUfxzP3owAOHHMC/nvuShxbslofMqdSEOaJEp3o/BgOBItz
         ZCNnqo7WzaXgfw21j2M27S1ZxLq8zmJx9ImXjxtK5g89aVLLXVzn45MQUeJLuk4V6WNk
         xNQ800OHV9c83J5YDd1uau7RMWduheEwBymqWG/vGzF8sN4fcuVovMNzWCpfgSHNkQTq
         8WqAjMGsdq18i35Nj2gHCMUGP/4V/RLNaSoPTVXAPsHi33EZFxwsh8ymXS96N/rtJwcz
         p64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470108; x=1724074908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZdPiM3eHhS0gXqA59iljos4r3z2B3CpNxMTL6TtBWM=;
        b=C3oEAZmblRdZaSRYhpQAE6nHqF2tZC/InCzheQteGR9DNZ9bfa6Y4mu9MYQdOfe/f3
         xQBdmnQ/zhg3dtjvxr/SPD5fT+DuvYU3yMJrVrpNswSZz8V/E4cmPPtWRCrc31p0XPJA
         tJfnSItIxGvyPjcKjUjTXNpENpWrm4OVMtZC0mHr3W3sKNlRg0IPA3ZTYAGkHvDexGNl
         bFXEGo5tLD88Ols8BjJt7rihJ0D8lWLo9Sx54U/c2CYqnnFHABMOTSW62LAE3qDdOq+5
         4oKIw6ikp8Y6Fh64qWRuRjN+Be8cd6cQdsPh9zcfDitkELtBS7i9gw8YsZF5hD2B6rdC
         CoHg==
X-Forwarded-Encrypted: i=1; AJvYcCUGiGdZ/TpulhhjHMArW+vNhcsaUz8G78n6/Ktek7o1q4UXhn5fHeV8nf4MOu/iPZh6zPPFPKOiWaMDvAPbTt99RAzud6rEXT+u8j7c
X-Gm-Message-State: AOJu0Yxaq5ARBK/KlwZlpsuhMN5ag81kFhQ0VZKhoBpKb7xPstq4rr+l
	ceES/Ui+StvnjZSH2s/8Uxyfs5p9BmqHyipWIVPs0J/WEgK2lzklqKSr/hhx8BY=
X-Google-Smtp-Source: AGHT+IEsceJsLwcbe8ZaO6k0uxbmVJqWTyQSzd6+oN/GAqxRjkMASZhkewn/y1mFB5Us3W4ra8JFTg==
X-Received: by 2002:a05:6102:3587:b0:493:e582:70ce with SMTP id ada2fe7eead31-49743a4d67emr546286137.10.1723470108426;
        Mon, 12 Aug 2024 06:41:48 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d65006sm246372685a.1.2024.08.12.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:41:48 -0700 (PDT)
Message-ID: <f8a7754e-0f6b-4802-985b-d8817892ecbb@baylibre.com>
Date: Mon, 12 Aug 2024 09:41:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
 <20240809-ad7625_r1-v2-1-f85e7ac83150@baylibre.com>
 <03eca85c-50d7-4ff0-a5b6-83e3322cb04d@kernel.org>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <03eca85c-50d7-4ff0-a5b6-83e3322cb04d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-08-10 8:10 a.m., Krzysztof Kozlowski wrote:
> On 09/08/2024 20:41, Trevor Gamblin wrote:
>> Add a binding specification for the Analog Devices Inc. AD7625,
>> AD7626, AD7960, and AD7961 ADCs.
>>
> Thank you for your patch. There is something to discuss/improve.
>
>> +allOf:
>> +  - if:
>> +      required:
>> +        - ref-supply
>> +    then:
>> +      # refin-supply is not needed if ref-supply is given
> Not needed or not allowed? Schema says the latter.
Yes, this is poor wording on my part. I will fix it to say "not allowed".
>
>> +      properties:
>> +        refin-supply: false
>> +  - if:
>> +      required:
>> +        - refin-supply
>> +    then:
>> +      # ref-supply is not needed if refin-supply is given
>> +      properties:
>> +        ref-supply: false
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad7625
>> +              - adi,ad7626
>> +    then:
>> +      properties:
>> +        en2-gpios: false
>> +        en3-gpios: false
>> +        adi,en2-always-on: false
>> +        adi,en3-always-on: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad7960
>> +              - adi,ad7961
>> +    then:
>> +      # ad796x parts must have one of the two supplies
>> +      oneOf:
>> +        - required: [ref-supply]
>> +        - required: [refin-supply]
> That's duplicating first and second if. And all three - comment, first
> if:then: and this one here is kind of contradictory so I don't know what
> you want to achieve.

It sounds like there's a better way for me to specify this, but I'm not 
exactly sure how.

The AD762x parts can operate without external references, so the intent 
was that neither REF nor REFIN was required in the bindings, but if one 
is given then the other can't be.

For the AD796x parts, one of REF or REFIN must be provided, but not 
both. If REFIN is provided, then REF doesn't need an input because a 
reference voltage is generated on REF. If REF is provided, then REFIN is 
tied to ground.

Maybe there's a simpler way for me to specify the whole block?

>
>
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    adc {
>> +        compatible = "adi,ad7625";
>> +        vdd1-supply = <&supply_5V>;
>> +        vdd2-supply = <&supply_2_5V>;
>> +        vio-supply = <&supply_2_5V>;
>> +        io-backends = <&axi_adc>;
>> +        clocks = <&ref_clk>;
>> +        pwms = <&axi_pwm_gen 0 0>, <&axi_pwm_gen 1 0>;
>> +        pwm-names = "cnv", "clk_gate";
> Make example complete - en0 or en1 GPIOs or whatever else is applicable.
Will do, thank you.
>
>
> Best regards,
> Krzysztof
>


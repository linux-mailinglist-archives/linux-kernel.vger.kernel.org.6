Return-Path: <linux-kernel+bounces-185860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD058CBC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB64A1F21399
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D07D071;
	Wed, 22 May 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgG7MjSN"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8E7711C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363027; cv=none; b=pTm9VzTFwJ6L58UHY8D1G6NA74Bd2/e8d9BRX4HxDLMcJ5tlrmK4FgR63yLUy6jpcZYt6w+kSxtrl2uX62cQdeBFvWlBh7O/SN3YdxjnkyX3ECkmQQqX7akasvdpWmrEricQT8UF7q8AIHy9/Q/gfe3HHlm/1S8pTot6AJyucHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363027; c=relaxed/simple;
	bh=oFnQJmkxU6zrXZGMN96C8wGpspBAUkA02uGJ/ASV8ys=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pvESRmCbjh+oFL+QrIb0ztc7li2cKPUZe/GDZoKUy0/oeX1cwQPFATRiNQ1vQyvsVyx6FF9op3lglJxDAgUraIe0mLr6wZisl7l2mbAcFewIADzkT7CCrz5zwzE4n+rjxWWI6RdfZzKWxG2yBX1fEWzjtELhBu9mZxHhtqiAryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgG7MjSN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e719bab882so42392781fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716363024; x=1716967824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tkJXObuZ8bzKgibWqMu1hFns0+SNQYqR2IAV8YRh+qw=;
        b=zgG7MjSNuJtht/nGTUyN/zXn3NWPUBq9Lz2EdQSAnTSQIPWxLItln49DVH7KZ5VVZf
         2QkeqhHVael4hWnDlSr0g61wT/Gb/h/g9XT0pcx/ZzTq73m1gX3ar2QdNooqx9B0sk8d
         2GNFNJRl6C4akS2Czq7fJcXiz6Sfw+mVMiYUupjjiG/cPxgMCRA4o53ZJ7tXlgA/fYzc
         SsrQwUaCJonKI/txPRo1vT2AJ/zVJDVWcnWjAXUqyt429T7TpOEPGT/DuJmImOI+bEg4
         jR0oo4TbEf57iddVULd7E85j51ifFaUGXZ9wrWNuDNQl1/MYcnZs0RWYGXvgDRdA2x44
         XUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716363024; x=1716967824;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkJXObuZ8bzKgibWqMu1hFns0+SNQYqR2IAV8YRh+qw=;
        b=npgCcXKjuy5p65lUzz4KWqiRlG6NsTowRZKdNcC1nfiH+SliJm0IWt2Z5jP7N+KlKf
         yl0AZ0BrkyzWe+kImLendiME9C3Y3ZNa6uM9ANxbshDjmW7cw8Fn9KXkuU6QQxYzIJ+p
         hXsL5o9mx18HRHIsTEEvl8jnI2H+mGqiZCg6dbNnPdn+Z6qCJ7mvLGmmHyzu3H4rE0iq
         pyVKhGzmsJoViQrFGLw0KbOHu0bbfr+KF87uzshCk6eGUbirfCsv3EyczqjRpBH9N146
         pWM4PAH80LxiB+zroi1X3qvvpZ+GX6nIGzY8ab/o097xnYyzgmp3CNeSlj3yGwDzKXN3
         9NFg==
X-Forwarded-Encrypted: i=1; AJvYcCWoVqh6ycfvHrPuIlgEivurHBj/eTZawzkmfVJuvZ6M21vrbRI0pMo8m7rEZs6rAazHIhX7kY+JdrIFo4fKIcDpbuSL+qDwT68IZV8+
X-Gm-Message-State: AOJu0Yz+Cr23HHPwgqT537g5ixB5fro4aeTE6MfIXzXRMk22X9cYGCZ+
	9b9n5q5SIUIH35UUFPp+QHJ9Knh/6v4NDkhgfTBL7OPdcZOUGzakEml1/u4Feq0=
X-Google-Smtp-Source: AGHT+IEReon7mu9xNEVqRMovOLZvHsE91aYxCpyK1LIlKQyVpM36zPsDzSEdKkDkYxk3XU1KDKKERg==
X-Received: by 2002:a2e:9858:0:b0:2e9:4c17:9c8e with SMTP id 38308e7fff4ca-2e94c17a021mr3286451fa.44.1716363023678;
        Wed, 22 May 2024 00:30:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25d5sm491678985e9.14.2024.05.22.00.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 00:30:23 -0700 (PDT)
Message-ID: <af72c0c1-144d-4f04-86ba-d85e5125d261@linaro.org>
Date: Wed, 22 May 2024 09:30:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: Add bindings for Cadence I2S-MC
 controller
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Claudiu Beznea <Claudiu.Beznea@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
References: <20240508070406.286159-1-xingyu.wu@starfivetech.com>
 <20240508070406.286159-2-xingyu.wu@starfivetech.com>
 <0e7496c4-7dfc-404d-944c-a1869389722b@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0e7496c4-7dfc-404d-944c-a1869389722b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2024 10:03, Krzysztof Kozlowski wrote:
> On 08/05/2024 09:04, Xingyu Wu wrote:
>> Add bindings for the Multi-Channel I2S controller of Cadence.
>>
>> The Multi-Channel I2S (I2S-MC) implements a function of the
>> 8-channel I2S bus interfasce. Each channel can become receiver
>> or transmitter. Four I2S instances are used on the StarFive
>> JH8100 SoC. One instance of them is limited to 2 channels, two
>> instance are limited to 4 channels, and the other one can use
>> most 8 channels. Add a unique property about
>> 'starfive,i2s-max-channels' to distinguish each instance.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> 
> 
>> +
>> +  starfive,i2s-max-channels:
>> +    description:
>> +      Number of I2S max stereo channels supported on the StarFive
>> +      JH8100 SoC.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [2, 4, 8]
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: starfive,jh8100-i2s
>> +    then:
>> +      required:
>> +        - starfive,i2s-max-channels
>> +    else:
>> +      properties:
>> +        starfive,i2s-max-channels: false
>> +
>> +required:
> 
> I asked to put it after properties: block, not after allOf:. See
> example-schema for preferred order. Why? Because we are used to it and
> it makes reading the schema easier for us.
> 
> Rest looks good, so with the re-order:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Since you do not plan to fix it and already started pinging mark, I
retract my review.

Unreviewed-by.

Implement the feedback I already asked you BEFORE.

Best regards,
Krzysztof



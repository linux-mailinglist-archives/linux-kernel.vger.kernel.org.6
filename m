Return-Path: <linux-kernel+bounces-258043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C176938285
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 20:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DCAB20EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE04E148850;
	Sat, 20 Jul 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWUXVxqe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059221B86E6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721500620; cv=none; b=oRJVPiPkmmpWHp1AJP2n8BH/HL66j9UFX34lQiOk0D8QgbxhS+XJjq6gFm9sVQE4PUcY3PyQGikBGTjT5gCPcM2lNn0CPKIiLeKIIau5Zl7J2Xw8x764n/J+7ZwaI5Gk5m756UbkbOdEO1o70oYAF9/WtBd2Wl+dCnFKJg4MiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721500620; c=relaxed/simple;
	bh=ZKIO3SiHI2aNH3Zza1cA0din4KBtqIg9eGSV4QXGOz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XU0oT9BXrHJtF/onWi5FKR0K7s/laUQNtI81lKd8IRR0nVshNZFl/2th4TLWcTYeXRWv1oLEvayPkggYc+kSZgY1sSJFHScPO6DpR3gOfHuSWnQ+ycChwmjSlYSjzTTytriP/y+VBQTiA3xdvkFsVHEYtdMyXFK+mqimy4zYaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZWUXVxqe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso1998034a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721500616; x=1722105416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qCQtjnXMEUWUTc8hV0IMhc17eAOdlOv66Z2aD9mwVx4=;
        b=ZWUXVxqeASzVpvIT2Hm8pqO+Gb4PkOpPyZaDVYoDjUXLGjWcQvF3vZGaGyuQwtSnTb
         b5XW7FJ8TpYkjYQNg4kSv9MT+Fz/v8IlJh3uBlsOSFAYm6PctX2rCxPYWMUkP5SU+Ad3
         LkLtH6B87xLRXLcsWAkynS/H243pElTEQRJkZCcu4OGSn6lC3i8F8OG6G7haUSoD7XpA
         usbXXQRniKQphSfmxbw3zAgGnIpxGmzAAhXdfxozpaTNevaon+rNpn/5A24qRIAhoM/d
         Ea1MBFLhEp9Xdo38udPe0QUXhqtfbUv/Cck0GMcOICwEDs8jmSaDLbjnSDXrIE8pNQVE
         XDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721500616; x=1722105416;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCQtjnXMEUWUTc8hV0IMhc17eAOdlOv66Z2aD9mwVx4=;
        b=vo6b9ye89DTJyrGj5cGhyxrrWvR3v6ZGnByW7VOtqupSkYqelbfsxbj35ZFGnk/Xgj
         /Zan7HOsC6ULitPhhA55jnGAg1AqD2inXB4Wb0v2TOVtGrOTE6XV9R4PLrvFHdKqP2r8
         IySvrubfrIMrFGsmVRyVprku9W262FKi1TLPlVi/uasHJY4kLtAtVNjunc+2zB3Bvddz
         /woqkZqCdfuI/xe0cObiimlTvkUgprMMmb44My1MmHAZwrx6F3Q9l4Jdr4qWjWwLQVoO
         cd0snibCcBEs8rjW8bjc/qtA4XY6VrkcLC6j4ot68VaYXOoDGUxvMyf7Pgh7BQUjIc0V
         PZVA==
X-Forwarded-Encrypted: i=1; AJvYcCXf4mAH2frQZR0VTH72EZLYaVc9LAbLQeElvLMzFIEJC/pHUz6Vy7CxYQ1qHEScnwyIAdXjmqza3/gYVx+OGAJvao+SLipp/C/RwMFM
X-Gm-Message-State: AOJu0YySaiYndFQg97UBU07o+MEJfhLfwsC9VzAzNgfdvsD35IQWiUnc
	v8S2ozFJ479RAQPDwcnz3wUO/JDfKQjMWmkbkuZE5rqhQuwRQ6FaPuP/BC7Bjsk=
X-Google-Smtp-Source: AGHT+IH83frn1+Gb5cJqtdw5n3MblQU0FABo7yKn6o/OfQE7BVKdzMI8tONJ45eAfTFsSd8mW6gN9A==
X-Received: by 2002:a17:906:578c:b0:a77:b784:dea6 with SMTP id a640c23a62f3a-a7a0111779bmr611047466b.10.1721500616186;
        Sat, 20 Jul 2024 11:36:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7bdc03sm193620766b.54.2024.07.20.11.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 11:36:55 -0700 (PDT)
Message-ID: <eb6ef54c-ab7d-4c15-9109-5da9f8678efd@linaro.org>
Date: Sat, 20 Jul 2024 20:36:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: adding support for PAC194X
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
 robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719173855.53261-1-marius.cristea@microchip.com>
 <20240719173855.53261-2-marius.cristea@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240719173855.53261-2-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/07/2024 19:38, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for
> Microchip PAC194X and PAC195X series of Power Monitors with Accumulator.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1944.yaml   | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> new file mode 100644
> index 000000000000..e997a4d536e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1944.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1944 and PAC1954 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +  This device is part of the Microchip family of Power Monitors with Accumulator.
> +  The datasheet for PAC1941_1, PAC1941_1, PAC1942_1, PAC1942_2, PAC1943_1 and PAC1944_1 can be found here:

Wrap it according to Linux coding style, so at 80.

> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
> +  The datasheet for PAC1951_1, PAC1951_1, PAC1952_1, PAC1952_2, PAC1953_1 and PAC1954_1 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1941_1

Underscores are not allowed.

What does _1 and _2 mean?

> +      - microchip,pac1941_2
> +      - microchip,pac1942_1
> +      - microchip,pac1942_2
> +      - microchip,pac1943_1
> +      - microchip,pac1944_1
> +      - microchip,pac1951_1
> +      - microchip,pac1951_2
> +      - microchip,pac1952_1
> +      - microchip,pac1952_2
> +      - microchip,pac1953_1
> +      - microchip,pac1954_1
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 2

You need to list and describe the items.

> +
> +  slow-io-gpios:

Missing maxItems

> +    description:
> +      A GPIO used to trigger a change is sampling rate (lowering the chip power
> +      consumption). If configured in SLOW mode, if this pin is forced high,
> +      sampling rate is forced to eight samples/second. When it is forced low,
> +      the sampling rate is 1024 samples/second unless a different sample rate
> +      has been programmed.
> +
> +  microchip,gpio:
> +    type: boolean
> +    description:
> +      In default mode, this pin is a GPIO input pin. It can be

Which pin?

> +      configured to be an output pin, as well as the ALERT2

output is also GPIO, so maybe you meant some interrupts? But then you
have interrupts property for that...

> +      function. This pin is an open-drain configuration and
> +      needs a pull-up resistor to VDD.
> +
> +patternProperties:
> +  "^channel@[1-4]+$":
> +    type: object
> +    $ref: adc.yaml
> +    description:
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 1
> +          maximum: 4
> +
> +      shunt-resistor-micro-ohms:
> +        description:
> +          Value in micro Ohms of the shunt resistor connected between
> +          the SENSE+ and SENSE- inputs, across which the current is measured.
> +          Value is needed to compute the scaling of the measured current.
> +
> +      microchip,vbus-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The VBUS could be configured into the following full scale range (FSR)
> +            <0>  -  VBUS has unipolar +32V to 0V FSR (default)
> +            <1>  -  VBUS has bipolar +32V to -32V FSR
> +            <2>  -  VBUS has bipolar +16V to -16V FSR
> +        maximum: 2
> +
> +      microchip,vsense-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The VSENSE could be configured into the following full scale range (FSR)
> +            <0>  -  VSENSE has unipolar +100 mV to 0V FSR (default)
> +            <1>  -  VSENSE has bipolar +100 mV to -100 mV FSR
> +            <2>  -  VSENSE has bipolar +50 mV to -50 mV FSR
> +        maximum: 2
> +
> +      microchip,accumulation-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The Hardware Accumulator could be configured to accumulate
> +          VPOWER, VSENSE or VBUS
> +            <0>  -  Accumulator accumulates VPOWER (default)
> +            <1>  -  Accumulator accumulates VSENSE
> +            <2>  -  Accumulator accumulates VBUS
> +        maximum: 2
> +
> +    required:
> +      - reg
> +      - shunt-resistor-micro-ohms
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        power-monitor@10 {
> +            compatible = "microchip,pac1954_1";
> +            reg = <0x10>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            status = "okay";

Drop



Best regards,
Krzysztof



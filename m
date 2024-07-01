Return-Path: <linux-kernel+bounces-235943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4334E91DB93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEF7281B65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA4129A78;
	Mon,  1 Jul 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyqOYvRj"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359386250
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826568; cv=none; b=sdeeDVpjFoqNaDH/s3EJeCK2Cejps0WNWR07NHPFtmvYPU0M0BKgjXXcZ59/pznq9O6a1b/MKTbpmxFzl4eQqSA5iSaY7hsA/FXpTFEnQbolGIUjBr8k2T0BxQxGHD0UWZax9Z8hZASZFsRYo66DwIakTAhXy1pDH1qUVQ6a7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826568; c=relaxed/simple;
	bh=tY0jDUiKDP/NA4C8P00UMFT9mW6KP80g8OnUL7jr5mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4vu4eG72xWopkp9wzy2+z3Hw8dRP2NAp9yuFpY4+uju2kkPGaW6Ntg1rMKEv+Zaj5N3arT1EmkqaljoD0/8CqJ+l6XD3pBuIy88ju9jk7BjEPZaCM+tRpQ2x47rWYIr4yHFY+l3PZKNmorMMz26YVdhSOKmTXMIwS/bDDBeXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LyqOYvRj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e743307a2so3169058e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 02:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719826565; x=1720431365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=umaxw1Y4QWvbs+IDfNlNYZEXrx+s0jE7sWK8LLWjE0k=;
        b=LyqOYvRjnC4gvq0hWKRk3mQ3fwyXNwjoPqoB7IsagEuhwu74unS8Ag02jL1QIRCBOA
         GrFFruVqmc/dE/jMN+g5kV+b9Gk9RCH1uz+pz7l6iMhKfnWXwbyugHyVkYo86sPbKmxt
         7E2TpO+YPokM9g9+N3ZFwtNLyyWGXskK0S1EC1T++mKoSHC1IGzazdv9z01sCSyOLPGK
         K7dWZ5h3WTKIsOnljB5FGY+CQYm+HPTOYfl9LmMqCG4m1sr6BpO2qSYgZ7bU1cBLEtIM
         bgXaQXoOU9vOZM7eMM3GcYDYh1ZcO4fefcc8AFk1yJfbwf7A3IyCWbFRlhy+ERXjwNod
         /qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719826565; x=1720431365;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umaxw1Y4QWvbs+IDfNlNYZEXrx+s0jE7sWK8LLWjE0k=;
        b=p6eUb3k+FAZyF95k2ROZVBqGMluPXBuCK34wLxDKzzUXLVPwuBCOy3tTDQPbAxoene
         +N77+GQWJC+6/nfNtrRdMwd0WRtOcixrgYoWY4F5oNbOsb1rMduEAgd583HU+xo0uL76
         XlI5mkyiT38+AM+lElZON/R9Dcm8wXBRMn7+y9huZ5kDMfMJIMSSWLnF7mbPbt79Gv//
         DbaJxIyZgudzPrkj5RRUHCjmbhihIp8i9IbnnPzol4CCKqySgMsWBk1s7jqIWnXidWZk
         wSM39oY/QSKTeTippRrvu6Q3znMXfhz90xQE4eIOI7jLIV8LpQ1Gjb0KNDoNC4kzsZRc
         gA3g==
X-Gm-Message-State: AOJu0Yxb/NsIJLUHY0XF74+qsKgWFtNWPmD9JyVrz8mhTTs/+6UpGjVP
	fTaFDiNmos8D1l8vuNUALR3LqoXqpota2g8WLkIELYYvx9BYSepQb7friliWIEU=
X-Google-Smtp-Source: AGHT+IGhh02dUWD3pu4eKVgTusl/xKoK7lHj0jG9AB/Y5RJf8e/uPTru3uksObZxoH7cIkfw3SY/4A==
X-Received: by 2002:a05:6512:2813:b0:52d:215b:9028 with SMTP id 2adb3069b0e04-52e82747e92mr4002791e87.60.1719826565248;
        Mon, 01 Jul 2024 02:36:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d0dsm9526058f8f.104.2024.07.01.02.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 02:36:04 -0700 (PDT)
Message-ID: <a6530511-8195-48da-9796-df207a15ae2d@linaro.org>
Date: Mon, 1 Jul 2024 11:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: dt-bindings: Add Sony IMX728
To: Spencer Hill <shill@d3engineering.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240628-imx728-driver-v2-0-80efa6774286@d3engineering.com>
 <20240628-imx728-driver-v2-1-80efa6774286@d3engineering.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240628-imx728-driver-v2-1-80efa6774286@d3engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 23:17, Spencer Hill wrote:
> Add bindings for Sony IMX728.
> 
> Signed-off-by: Spencer Hill <shill@d3engineering.com>


> +
> +  clocks:
> +    description: Clock frequency from 18 to 30MHz
> +    maxItems: 1
> +
> +  clock-names:
> +    const: inck

clock-names do not seem that useful - name is pretty obvious. Drop.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Specifier for the GPIO connected to the XCLR (System Reset) pin.
> +
> +  avdd-supply:
> +    description: Analog power supply (3.3V)
> +
> +  dvdd-supply:
> +    description: Digital core power supply (1.1V)
> +
> +  ovdd-supply:
> +    description: Digital I/O power supply (1.8V)
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: ../video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            oneOf:
> +              - items:
> +                - const: 1
> +                - const: 2
> +              - items:
> +                - const: 1
> +                - const: 2
> +                - const: 3
> +                - const: 4
> +          link-frequencies: true

Drop, not needed.

> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        clock-frequency = <400000>;

Drop

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        camera@1a {
> +            compatible = "sony,imx728";
> +            reg = <0x1a>;
> +
> +            clocks = <&fixed_clock>;
> +            clock-names = "inck";
> +
> +            reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
> +
> +            avdd-supply = <&camera_vdda_3v3>;
> +            dvdd-supply = <&camera_vddd_1v1>;
> +            ovdd-supply = <&camera_vddo_1v8>;
> +
> +            port {
> +                camera1: endpoint {
> +                    remote-endpoint = <&csi2_phy0>;
> +                    data-lanes = <1 2 3 4>;
> +                    link-frequencies = /bits/ 64 <800000000>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef6be9d95143..a2811249ac8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20589,6 +20589,13 @@ T:     git git://linuxtv.org/media_tree.git
>  F:     Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
>  F:     drivers/media/i2c/imx415.c
> 
> +SONY IMX728 SENSOR DRIVER
> +M:     Spencer Hill <shill@d3engineering.com>
> +L:     linux-media@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/media/i2c/sony,imx728.yaml
> +F:     drivers/media/i2c/imx728.c

There is no such file. Patches must be bisectable.

Best regards,
Krzysztof



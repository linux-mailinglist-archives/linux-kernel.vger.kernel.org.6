Return-Path: <linux-kernel+bounces-189381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA88CEF4E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478D6281839
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A974D9FA;
	Sat, 25 May 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0OO4be3"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7C1C6B9;
	Sat, 25 May 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716647528; cv=none; b=S2CLCZdfaiHQT4qrXVrPutJXbx+90NXNwui3GvtILwmL0Eh39sJoXRpLRqTCppQWcSSf0GmGprIkxZcesKv2JkLsdj8msSj9muoB19eBEdmgwdKTWJ0eB/+/Hm4fWs7Ol8Wfpi7f9o9K/xafYpE/HprFDuN7TkYZuRqulyR8alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716647528; c=relaxed/simple;
	bh=FpozTE8iUcCi8Uh96wsQB0CK5b034+ilyxckkYTG0tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nvPmD26DxijMnS51FTtBUTctXLHtcOkMjmV5+GwK0sN1xB0Vydsw75kVd7tBQFok0sqxUndjs1/YUleoZvdN6yXFYFXWVsVL2W+SpEeI87/2Rs02RTaBwkcTNll1PQeFXXsCDFvg5R+IstBFOdpJTAmvDjyDkhNMiBXmP9aNv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0OO4be3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f5053dc057so5258903b3a.2;
        Sat, 25 May 2024 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716647526; x=1717252326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq7yFXM/W/9NmcYfhRe0JIbRD9gBWcU3pncAQ5w2rUc=;
        b=f0OO4be3X+A9PEemvJ5tfZ7+mKo1JvzJIsVOdWRM8V2SC+sYNpzfN1DDEJmNfd3XuI
         7YpA9ZSaN7hpd6t1jDpWLD0dC2ZQnBx5DRvRMWnnQcija8LoWdwI7+UlRmrn406HrwC0
         mH/6hqLKRjCS7rbW6G3oRZk+O4M20rQFQel9E+tOOI5ZUnC+WVD8Jx+6UtN+3DlivkXc
         9ZiMB7+kkgYITcBQpdI5MF4JWzqpKR8ueono/hXdy/Vj7SFeUbXwlsPbqalXpMjLNCj3
         /2jFFkTsyQM5afod4Q6OwDikNc5fiwaRGALBFnaAiDClI0kfMUh0I7xpvO+FM4RnTZHf
         RVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716647526; x=1717252326;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq7yFXM/W/9NmcYfhRe0JIbRD9gBWcU3pncAQ5w2rUc=;
        b=YVSkkh14YlzMetCHeTKXZOjdZT34hQtpS9drOTYJjwI3TtJuD4CsF06XWK9qTMFZ0G
         RiEIcwdgtU8ssrduV6Q7lMj9tQSdKjS7evJHLoOWnJS3tSYmrFPZb9addmY/f9D+WmWY
         p5WRBsfo0+2wOXTPe7JxW3pp/ZasZHJoaeRSgvl5YOVAzAKhpkEC0+wbDJRiErxgA4AY
         tcSmi5qaI7qI5zXG/RWDuc9wenmNFwoQVRVLluZBMFtIUQuL+Wy4M1lZpPiE5cMmvNo9
         zFZobYQ9vEbV6h6z35wdWHHTsNCtJuj+TJ7sXnXMVRHwdrrew2OnFyEuY3PNkfE4yIbh
         pRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNGWYlBAVo/JHflGSiFXruSpKUBNrlTtfFettaOQXxfRCZ52P+OUrmvk2r85Db8QHCZHFoSq/x5jZwokrPLAM5GYI7cFnZ8Xw7yLC1gj1zGXAh/UuA4vQiwarCmS/h2EKvHvwmoniwELDUF+1JbPLPAtFObZOKoihroJDl3gL0Jhrpwv0y
X-Gm-Message-State: AOJu0YyCGqLwQBl7cgS/47CXCr2g0PusSeoV3+d3BmGgkCQC4GVvmK0O
	sTWlY9v8bJKt8qygbG3pM2MKYvutx6fQ0SR8hJzClutbsIedztJh
X-Google-Smtp-Source: AGHT+IF/qG2DTGJUvpZ5IcFKb6WUQwzAluo2dDB78fxQNHc1+j/ayKpjGnQ4DSs1XFq2s/aMRprDBw==
X-Received: by 2002:a05:6a21:778c:b0:1af:b0d0:281 with SMTP id adf61e73a8af0-1b212ccf907mr6354474637.6.1716647525751;
        Sat, 25 May 2024 07:32:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d4f9esm2516878b3a.185.2024.05.25.07.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 07:32:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22e1daf4-ffce-4fac-be4c-0e7bebd91c88@roeck-us.net>
Date: Sat, 25 May 2024 07:32:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: g76x: Add support for g761
To: Christian Marangi <ansuelsmth@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
 <20240525102914.22634-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240525102914.22634-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/24 03:29, Christian Marangi wrote:
> Add support for g761 PWM Fan controller. This is an exact copy of g763
> with the difference that it does also support an internal clock
> oscillators.
> 
> Add required logic to support this additional feature with the property
> gmt,internal-clock and reject invalid schema that define both
> internal-clock property and external clocks.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 43 +++++++++++++++++--
>   1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> index bfefe49f54bf..d6e80392d045 100644
> --- a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> @@ -4,13 +4,13 @@
>   $id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: GMT G762/G763 PWM Fan controller
> +title: GMT G761/G762/G763 PWM Fan controller
>   
>   maintainers:
>     - Christian Marangi <ansuelsmth@gmail.com>
>   
>   description: |
> -  GMT G762/G763 PWM Fan controller.
> +  GMT G761/G762/G763 PWM Fan controller.
>   
>     If an optional property is not set in DT, then current value is kept
>     unmodified (e.g. bootloader installed value).
> @@ -22,6 +22,7 @@ description: |
>   properties:
>     compatible:
>       enum:
> +      - gmt,g761
>         - gmt,g762
>         - gmt,g763
>   
> @@ -48,10 +49,37 @@ properties:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       enum: [0, 1, 2]
>   
> +  gmt,internal-clock:
> +    description: Use the Internal clock instead of externally attached one
> +      via the CLK pin.
> +    type: boolean
> +
>   required:
>     - compatible
>     - reg
> -  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - gmt,g762
> +              - gmt,g763
> +    then:
> +      properties:
> +        gmt,internal-clock: false
> +
> +      required:
> +        - clocks

Is the new property even necessary ? The absence of an external clock on G761
could be used to imply that the internal clock is used.

Guenter

> +
> +  - if:
> +      required:
> +        - gmt,internal-clock
> +
> +    then:
> +      properties:
> +        clocks: false
>   
>   additionalProperties: false
>   
> @@ -80,4 +108,13 @@ examples:
>               fan_startv = <1>;
>               pwm_polarity = <0>;
>           };
> +
> +        g761@1e {
> +            compatible = "gmt,g761";
> +            reg = <0x1e>;
> +            gmt,internal-clock;
> +            fan_gear_mode = <0>;
> +            fan_startv = <1>;
> +            pwm_polarity = <0>;
> +        };
>       };



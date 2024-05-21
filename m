Return-Path: <linux-kernel+bounces-184804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175E58CAC37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C192F2813CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FC6CDAC;
	Tue, 21 May 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQ8y2gNe"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707521A02
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287360; cv=none; b=Isbg79jtO11yhjrm5UBelIFV5hhSuzyAdcspUnZbPQHLJBkwohg7VG9iSxurWBpt7tTDQIpmaJhnTqfXga5h92PAFLP+Ki2MA7NHRKwDUjU8eXazcP0hVC3rJDhYvK2HSzwIPKh/iU8J6KAi2Apbb2sThp9IPNkCfPwS09rk8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287360; c=relaxed/simple;
	bh=6cDP9PqZbX5zVmeH3VVzeesNNCjgqRnuAIRWdnpMu8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g78nCQXyRITA9GTP2TbUQNZnw+LTVqiRq7K5TFThjQrhuDkzEU8QaL5c6NI4hvE4AL1HMq6zxbiYVR8SlGM9VtH9ODUcjJusnthL+3WeI9eiycBUnUZ0b7bI1KbglkrcDCFiz2BTm1uFe/SWgJMGQpCuRciIJXibmxzg465zeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQ8y2gNe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42011507a54so19197335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716287356; x=1716892156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qi6lBdkdn1x7hzz8lAKSNRz9HZ/NDtP8vPjtnc51KQU=;
        b=JQ8y2gNeHfBqxaEu8uaz7of466wbHwAmHmVI+rm7+vk0WHz4TCc4uX1CkgCmqzQlK9
         jynt/HKsVYcRXHPBRtGuT4SP2uB+ryEgS2jn2pYjC7ni3LndSMRhwb01A2Dva/S+0bSQ
         Kc0NcOiswQKWEaX/m5cEhcXZvjNZPSnw2vuIi9FU3lz8wOmMB6ug6Q926dGA+Zgt8WmC
         o3tNNsAjJf20CW9tmneQtbo/bvqs+SRxNNjdRUlhYHeozi82fqlElCGkDzRmq5QAim/n
         J0A+FNGuaov+5AWf119h70tIsSGH4RBxCFwXY12UJvGLzSMm09QU/6/VPMOkLcRAHnRV
         kRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716287356; x=1716892156;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qi6lBdkdn1x7hzz8lAKSNRz9HZ/NDtP8vPjtnc51KQU=;
        b=s6d/c/r0SaHPpmn5Po7SJroRow+Sxjiy6Lg+0XP13faUnC/eRZTWs1pvHDKx+UmYst
         arOVNOayDX7krICSnY8FGDekMns5xlTVRiqone54VD1Hy9N2Yrzf9sEZc/caM3sTvXIA
         kkw0rJjyRYJGLV8dCWW3yWYoWKHJHiXAMmaumFEmJkbYdqCxqCi8CNozfbX+eeXeWQIw
         0HP6nZOQIeqggGbxZXI//4EyAC4M+MjutqpKRfqjdPV37CJwvksUypDG2opq5oGep6/d
         viPoQ2i+nteayd/NpxUq8c+oM8D9e3S5BeGwGLtNl5WlPHV6rQWIC+ekRX3u+n7+55ca
         NJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUzutGQI5L1PcoL05wxn6Fav2y1AKgS3VsbZDF78YrQP67TYtS861VJC5LVrP4mRMgjvgBCjfFsyPg9+udKIEkTJ5DHbUyQL0Bt7/n4
X-Gm-Message-State: AOJu0YwevXkrNO3YkPKBdUONyvOHo4Akvh9X7IpN80/NOD0C9twG2zSF
	0gPmkv1bsgp8pX352xeO9eCq18RBz8gkBfmDRb4r8CCM/6qZHXzBPy+a9PJzXyM=
X-Google-Smtp-Source: AGHT+IEuALDTJLgAksEc+OW5M8y+Kwdqm97BVjihmA2Akzyi9nRmeA3aJbkkX+2zDKEQVZEcj8g1cA==
X-Received: by 2002:a05:600c:470d:b0:41b:4506:9fd with SMTP id 5b1f17b1804b1-420e19d569bmr71549105e9.6.1716287355795;
        Tue, 21 May 2024 03:29:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420152a2a8asm358758905e9.45.2024.05.21.03.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:29:15 -0700 (PDT)
Message-ID: <70863d5c-65f8-4baa-99ce-8739ce47fac3@linaro.org>
Date: Tue, 21 May 2024 12:29:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] dt-bindings: spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-3-wsadowski@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240509010523.3152264-3-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 03:05, Witold Sadowski wrote:
> Add new bindings for v2 Marvell xSPI overlay:
> mrvl,xspi-nor  compatible string

Where?

Why double space?

subject prefix: spi goes first

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


> New compatible string to distinguish between orginal and modified xSPI
> block
> 
> PHY configuration registers
> Allow to change orginal xSPI PHY configuration values. If not set, and
> Marvell overlay is enabled, safe defaults will be written into xSPI PHY
> 
> Optional base for xfer register set
> Additional reg field to allocate xSPI Marvell overlay XFER block

I have troubles reading this. Is this some sort of one long sentence or
a list?

> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml    | 78 +++++++++++++++----
>  1 file changed, 65 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> index eb0f92468185..094f8b7ffc49 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -17,22 +17,43 @@ description: |
>  
>  allOf:
>    - $ref: spi-controller.yaml#
> +  - if:

Move the allOf after required block.

> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,cn10-xspi-nor
> +    then:
> +      properties:
> +        reg-names:
> +          items:
> +            - const: io
> +            - const: sdma
> +            - const: aux
> +            - const: xferbase
> +        reg:
> +          items:
> +            - description: address and length of the controller register set
> +            - description: address and length of the Slave DMA data port
> +            - description: address and length of the auxiliary registers
> +            - description: address and length of the xfer registers
> +    else:
> +      properties:
> +        reg-names:
> +          items:
> +            - const: io
> +            - const: sdma
> +            - const: aux
> +        reg:
> +          items:
> +            - description: address and length of the controller register set
> +            - description: address and length of the Slave DMA data port
> +            - description: address and length of the auxiliary registers
>  
>  properties:
>    compatible:
> -    const: cdns,xspi-nor
> -
> -  reg:
> -    items:
> -      - description: address and length of the controller register set
> -      - description: address and length of the Slave DMA data port
> -      - description: address and length of the auxiliary registers

Widest constraints stay here.

> -
> -  reg-names:
> -    items:
> -      - const: io
> -      - const: sdma
> -      - const: aux

Widest constraints stay here.

> +    enum:
> +      - cdns,xspi-nor
> +      - marvell,cn10-xspi-nor
>  
>    interrupts:
>      maxItems: 1
> @@ -68,6 +89,37 @@ examples:
>                  reg = <0>;
>              };
>  
> +            flash@1 {
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <75000000>;
> +                reg = <1>;
> +            };
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        spi@d0010000 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "marvell,cn10-xspi-nor";
> +            reg = <0x0 0xa0010000 0x0 0x1040>,
> +                  <0x0 0xb0000000 0x0 0x1000>,
> +                  <0x0 0xa0020000 0x0 0x100>,
> +                  <0x0 0xa0090000 0x0 0x100>;

No need for new example for difference in one property.

Best regards,
Krzysztof



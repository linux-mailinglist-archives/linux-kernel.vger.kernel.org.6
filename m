Return-Path: <linux-kernel+bounces-191829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426268D14C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA64B2141B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B26F079;
	Tue, 28 May 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGaxTv8G"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366C6D1C8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879393; cv=none; b=asv746rCj6YdyaTtmkhIrjw5w/mZxGL2IuMlrGnq2DHw3WpwCdtHXoMQ9dMPc3dHCP5ivwnITIn8bQi148j7ACf7GNFO8AcWzl1iU67MMe4g1V59jCSMm9W1ty0PJI4zAiXtnIbZZR6yutlfcp+lFdJnftXADQPZDQfb8abYJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879393; c=relaxed/simple;
	bh=xy04Y7Cl2ggATvVxFEFaLmatY5KPNXhFK1jAeCXe4uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYh1o5gYcHyg1qcs848Q0uqlGgybLFl6aX3phk9OtNjl8fGYtLq5Dxwgeo9sEjW32/sZjlY+b+RW3MzCl2jcbA0sccqQ+CTKcZ+6YDH/yxd2BNgraVICEzramoq03MrXy0CMs6c0h1yIWYGPvAeC+d4dDKknA58jFBY6ukfdonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IGaxTv8G; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5366so511613a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716879390; x=1717484190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Rb4BnC8a2t0b1yzK8hj7Hksoqy02E3Bi5yA3QhBbns=;
        b=IGaxTv8Gnn/jAe+eI5h3bTY0nUJ+hAPurnfFS3BpJx5iKOqS1zTz6aGV3ZA+v8Wgd1
         HX9cijcPpB5W8XOEA5FBwRvD5LDnTI0TYeOfhWu1jbdwBYxrbgI61/oVmrB6P5dWhoj9
         Jn6VaDujmEye0czfDyYoJtiydcwvbgbqGkG/NLnEmDcrtWV7fHYveEYwL6WA0LKKV8Kj
         s1BRweOOug3SeNhchk004DFcqC+OlYIxTbtsX6BJahKTzoLvI4aLg8cT7N1on/OGaQdc
         OFWSXAx2m5Ke1NynIlpd8d61kFKo0ZZDlTwZkRy167uBNSIjxSpzjUWkFONYrcvAuHQc
         2EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879390; x=1717484190;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Rb4BnC8a2t0b1yzK8hj7Hksoqy02E3Bi5yA3QhBbns=;
        b=G3xPeu7VttYXnxARUkVXUIT1bQRP5v7oeb5AhOQ4OTNev6Q3jRR8bn9a4QbSA+FNM3
         pMMGePyq0x+/4D2Iucu17+RbEO7YdDw3DYqJkHjfrQp3PtVf5Dh6dszE8XAo1mjGc1/G
         /uptVMzoSZVHflFZ8cPxlHfPOxSZh0JWj+1FNBKvByIZpPYaaxcZD8sYz7pvvHAGS6sK
         jsPPcagb0JIH/9w1Z3deTIymKvBIYkHmXfelRYxUm1nGMXjZfGAXGj4E8dYKHdlIQQnE
         tSsE+WW34GhcaFENR/nmJuM/tWszKu7rZg0lSSjoinTTPkZghS6AIvY2EUb4x5anIhxm
         45pw==
X-Forwarded-Encrypted: i=1; AJvYcCUV7z1fRQBkRk3nrilmZZLw3AN5MDQgaAwz9hH6SQCxUwRSWYph5k4NwZOwgAnEAWy2Oc4cMEho55k2tspbUOXmq4/tNLuXK61/bknl
X-Gm-Message-State: AOJu0YyeN/BWtXlQ7i48Au1gyhDPIK01ah2fy+Y9hWoFDqiMm0ONqtY5
	+SwhTGwHP2Iye6fkGeyn5Pe2V8yDD6t0toYOw2YD3L2grVvfbJ8DSp4Ov82XzWw=
X-Google-Smtp-Source: AGHT+IFTXIMK3MGqjw5JBxjVm/t5m+pO925hK73Q5dswKeLkmGeXWf8u2S5zEl60ithy+Er0aizdjg==
X-Received: by 2002:a17:906:314e:b0:a59:c319:f1dc with SMTP id a640c23a62f3a-a62642daa92mr764191366b.4.1716879390492;
        Mon, 27 May 2024 23:56:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda48e6sm573976666b.203.2024.05.27.23.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 23:56:29 -0700 (PDT)
Message-ID: <a9902865-afcb-4d58-934d-05d62a9e995d@linaro.org>
Date: Tue, 28 May 2024 08:56:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] spi: dt-bindings: cadence: Add Marvell overlay
 bindings documentation for Cadence XSPI
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com
References: <20240527084216.667380-1-wsadowski@marvell.com>
 <20240527084216.667380-4-wsadowski@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240527084216.667380-4-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2024 10:42, Witold Sadowski wrote:
> Add new bindings for the v2 Marvell xSPI overlay: marvell,cn10-xspi-nor
> compatible string. This new compatible string distinguishes between the
> original and modified xSPI block.
> 
> Also add an optional base for the xfer register set with an additional
> reg field to allocate the xSPI Marvell overlay XFER block.
> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml    | 38 +++++++++++++++----
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> index eb0f92468185..d6b8b2a2ecf5 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -15,33 +15,57 @@ description: |
>    single, dual, quad or octal wire transmission modes for
>    read/write access to slaves such as SPI-NOR flash.
>  
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
> -    const: cdns,xspi-nor
> +    enum:
> +      - cdns,xspi-nor
> +      - marvell,cn10-xspi-nor
> +
> +  interrupts:
> +    maxItems: 1

Items got re-ordered. Keep previous order which matches expected style
(see also DTS coding style).

>  
>    reg:
>      items:
>        - description: address and length of the controller register set
>        - description: address and length of the Slave DMA data port
>        - description: address and length of the auxiliary registers
> +      - description: address and length of the xfer registers
> +    minItems: 3
>  
>    reg-names:
>      items:
>        - const: io
>        - const: sdma
>        - const: aux
> -
> -  interrupts:
> -    maxItems: 1
> +      - const: xferbase
> +    minItems: 3
>  


Best regards,
Krzysztof



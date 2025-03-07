Return-Path: <linux-kernel+bounces-551633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61051A56EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06001895273
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5923FC4C;
	Fri,  7 Mar 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etX6k/nL"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76C23E22A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368149; cv=none; b=jhjLZhCaCQ35Zwt03aTbgiG02FivW4H2jmxgKKp4JGeICxq+sjnQo2ECULwlZ2pkRtz1E5qxlS+Uo42SnezRmLZOkbT1kOr9gYHxfmNf9f2DWe0AJ1oXfck0xjubJWJu8a+AEtPc5bYO8Q7/FG03EIobYvaH2VUrYmDILI0i+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368149; c=relaxed/simple;
	bh=ghV9ihfmg8YmSosaHyRmZbhBW4iEZyINguG2X264RDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLfbf6QlDIqeLRq4LSe/MWhp858nePXisprpYRzD8mylWAUCQg4cTwhSsNXIxRxK/Zt57q6b4SRCit7vFFPdWAh/V0AtiDPdllMFerswjcg44gHZCBeUzZ97RrMhhDMZ8W+8TK6yTa7hz+EUPgiw54G+sxZpEWFpYZ9iTwkBl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=etX6k/nL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso391711566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741368145; x=1741972945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vse37ndJVrSuVrU7yJGVW1Lu8SXvK77ID0V4XIpDEEM=;
        b=etX6k/nL3xuOeiwQnkjus6WwhhYb/3nJL1rfG3pohQbeX3fnO1MtIKyBBYFDp2nAZW
         KdRAH7Sq+uuj5yRdtzshkvWCWVcRER3j619wBVZ4AUNME3t/2NG5Po4vOH6HF87wUpxK
         QYX3Pf6+Ooe+cvRnVNdGC1pUMVYs9jqLq9u/C+xPx6nAh6slXzlj7HD5uW97IE60Qq/H
         kfDGWyuNSrYxfdJo7uvs/4I5uh73PUx87FqaJJMJRaM60Jj1X6fQB6tGaSYKe60LvzEz
         ET0HU6ezZCcqXSMU9QfRDmzNkfPS/FkhUsskiyZdqwga6ZEyp1+2DShKT+rBDLM1xVTz
         ENsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741368145; x=1741972945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vse37ndJVrSuVrU7yJGVW1Lu8SXvK77ID0V4XIpDEEM=;
        b=cMXEib2NUkl2+HP++apnTIOISsAywkEV8dSM2XzWTG6vhM9q8N3gCFNacKAhTrdyU+
         65b/kF9zR/ikxXnBn87voeSkOyPBLDPuF6a/1yM7vZEZGOg3EAvhWqDzNALSjGXUM+zQ
         XQpo9Z7a6bb/QMdQnmDSVlX7aMv8Lx1+aUGoDpwZknhSVT4UT5raNgj3DGyPMbzwiEDd
         C5kDevsVV20upDFxoxLpkKVz8hKI2eZbGReaAAoWt47z4IeaeAD4xQ/82KkuC6rHqPXC
         niygQm6eTwWXDmQkXhUd2UzJDDc/3AV3uKLGYahSyV/6QTcNkiGlp7WBppG6a8k3gEGy
         UqTA==
X-Forwarded-Encrypted: i=1; AJvYcCVKStxRsYV9kEzAo6Py5rzWcHxqjQqYXiJwTYKsbsMLvQ5MnOr2E7h5vh128EDgjQ7HmaIohIkEwn44v/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7e6CYPLjkyx7CAIQBtsweSBAyHS6lXlGBPT+R+j4EWx2D2Cq
	CbjA/N/BVSmtLGMEcLLqD6J79bwF733IVHmlh8+2qscn6AkdD/yseF/yJpJTf7E=
X-Gm-Gg: ASbGncsyPe1cgXH3AqSajzRBuPMcfGpbJN/OuRuYIJyle0vILlb9uxD1ZWPLq7k2NdW
	gqO+8ccGUuJSwNGS0/aHj4WLMuDmXFn3DhOqM9JPzASiQbkj8hIEugSgOBYFj7IicWIBuYwZqlJ
	YgXDLhwc1KkYQzuFRLrFgRLw0//5ZOAYx9hCSjtU+GZqjCy23IbrTaPNqAuq3ucSF8m2VGTWrdd
	wHjj1DHz0IeDDC1mzhrQTihqttg042ExfO0gV2oG+zFDUUFL3F+sonY1WaY/q0r+i3souV4VrJl
	UF6pgXHq7/Z3GqnoznpuhsBigH+Nff9pOhQYdjpTcp7DyfI9jxaVoSX94DmsDCg=
X-Google-Smtp-Source: AGHT+IGr645XsGNFfy2D7vw+gO6HKk73sp4lP/e3Bd4vMO2M4emrS5p1ZDikAS21V2w6uEA4dxu5ag==
X-Received: by 2002:a17:907:94ce:b0:ac1:e1e1:1f37 with SMTP id a640c23a62f3a-ac25273af3dmr535156566b.10.1741368145070;
        Fri, 07 Mar 2025 09:22:25 -0800 (PST)
Received: from [192.168.68.113] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac2395174c8sm300319266b.85.2025.03.07.09.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 09:22:24 -0800 (PST)
Message-ID: <f662da0e-431f-4e04-b8ee-e8b04a08337d@linaro.org>
Date: Fri, 7 Mar 2025 17:22:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: nvmem: rockchip,otp: Add support for
 rk3562 and rk3568
To: Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20250227110804.2342976-1-kever.yang@rock-chips.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20250227110804.2342976-1-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kever,


On 27/02/2025 11:08, Kever Yang wrote:
> Add compatible entry for the otp controller in rk3562 and rk3568, add schema
> for different clock names for new entry.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---

Am unable to apply this patch, Could you rebase it on top of linux-next 
or 
https://web.git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/log/?h=for-next


--srini

> 
> Changes in v2:
> - Update the commit message and add maxItems in schema.
> 
>   .../bindings/nvmem/rockchip,otp.yaml          | 53 ++++++++++++++++---
>   1 file changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> index a44d44b32809..7572f4a1d73b 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> @@ -14,6 +14,8 @@ properties:
>       enum:
>         - rockchip,px30-otp
>         - rockchip,rk3308-otp
> +      - rockchip,rk3562-otp
> +      - rockchip,rk3568-otp
>         - rockchip,rk3588-otp
>   
>     reg:
> @@ -25,19 +27,15 @@ properties:
>   
>     clock-names:
>       minItems: 3
> -    items:
> -      - const: otp
> -      - const: apb_pclk
> -      - const: phy
> -      - const: arb
> +    maxItems: 4
>   
>     resets:
>       minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>   
>     reset-names:
>       minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>   
>   required:
>     - compatible
> @@ -62,12 +60,45 @@ allOf:
>         properties:
>           clocks:
>             maxItems: 3
> +        clock-names:
> +          items:
> +            - const: otp
> +            - const: apb_pclk
> +            - const: phy
>           resets:
>             maxItems: 1
>           reset-names:
>             items:
>               - const: phy
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3562-otp
> +              - rockchip,rk3568-otp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: usr
> +            - const: sbpi
> +            - const: apb_pclk
> +            - const: phy
> +        resets:
> +          minItems: 4
> +          maxItems: 4
> +        reset-names:
> +          items:
> +            - const: usr
> +            - const: sbpi
> +            - const: apb
> +            - const: phy
> +
>     - if:
>         properties:
>           compatible:
> @@ -78,8 +109,16 @@ allOf:
>         properties:
>           clocks:
>             minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: otp
> +            - const: apb_pclk
> +            - const: phy
> +            - const: arb
>           resets:
>             minItems: 3
> +          maxItems: 3
>           reset-names:
>             items:
>               - const: otp


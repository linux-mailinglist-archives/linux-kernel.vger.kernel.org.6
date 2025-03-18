Return-Path: <linux-kernel+bounces-566410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E7A677B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B261897395
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7020F063;
	Tue, 18 Mar 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbuZiAKi"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0520E706;
	Tue, 18 Mar 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311358; cv=none; b=GMTZowq25Qwwgj9lyKy+xsIP6iSX3mKoWmZaLheobGdyfqaEI465If7tcKLn4uoKyUhe1Bah69SORD+zVUl9qaeaAOAU1DWa1ssoVClIOzatGDZElBZRDbKIk305F+1n5TtQW5P/x4cLMdey2JqwgkIK0Y9AdNJsbgqHfGLc254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311358; c=relaxed/simple;
	bh=davtiVsXx98fsThB+WUnDWoANTiH8sILlfY6buOJYAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpoKak0b4fPbtW/AD41EWKxCoBCD2FDmnxMUadXvowpeNRh2AvdTUJpdwgHxLvga+fenb5Qi2S4VMt9K8q8yiVy1uiYQQe8Znawtv1FqLJ2twFoUWIjqgQ0SgZXiOXzTtJtQbaEXSIHONJcfqfWi7fwcX8c9su3MYyU5qeLIYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbuZiAKi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so4277096a91.2;
        Tue, 18 Mar 2025 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311356; x=1742916156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=b1O+uLM1JS3SDRUPJkFsjl9GIuvpMT2cD+4v/3zBEAA=;
        b=MbuZiAKi3kKG96zKQOHOfqF0jUqj4BJnXEcKYh+l6JdP4v/SO+uDMmAtbiwWhOOAcN
         +K6fZj8zikznHZhVCpMOK5esrO5ja3FCAt7FBIDJH4DuUcYrTDUBBEAfVBqsCGoIeg1z
         nPyUZNEjne4f5Kg0gsPd3CVxEXJcR/kxZq/EZIOIix/17B0pJfLaGheYFfRccMrKdIU5
         B8OAAxqM8udjCXNCqY/tp9s4IOGbsu6FE+NomIQgrX16HrrJNFu/6Xe/bOl7AABNtrdY
         HyzKucRRCOjRolF4+bGUOsf7ddVOpXIHIiFMyH8jFYBjyFt7i+02S0/us319d/Jn3N8E
         Yv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311356; x=1742916156;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1O+uLM1JS3SDRUPJkFsjl9GIuvpMT2cD+4v/3zBEAA=;
        b=mkbF43DbJoaghehuy1IZBkAbfSEmgsu6oWRVzsZtoiFgUGvoekhwMpGW2lzi1fD1i5
         KROF2S1vzLscsyrzgSk0YGhjPFiAMMDxLHOFJibl1ClpJaIHYBgW43vLCwwVHRTCqcDn
         eqYOgiQ19Xzug72owfAjymdqiGDUOQoHnhHFULuL5ttgZfs8zzmBji/npEBqqxmTuIqO
         RaN9btFo/3sD0z8NkzUaIBJmj/SjibNqTJm0vfiyLv/HdRQJdcTbPBvTHCOV7eJkDNB6
         7CTWZzTolE0obk5GfKkd8+22L7tbyHpW41NP6McFqX9sN6GbYjByaekfWil9wnUmDdKA
         E/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl+YkSRrsIJ24j16A94MyKVljwI4GsnM1od96Qefq/J84t2kK/WhECTMsgveMnn3eemMNZKb9eZfba@vger.kernel.org, AJvYcCWm0pDmrbiCqkTmk17aYtIVmAgBiqCSyoOwOE2v8IdJKU2FPrQr6wrVEeIysUqEfJCwGr4xsB/I8x1ShsDK@vger.kernel.org, AJvYcCXOtrrJfk55p3cqDREbROB6sXBTjUH0Hk1eVysrnrrvVnkmTkfu9NS/0s1qsC9hOBLBcBZ+HAVwJ8AsEbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoA1bqUi9L0xBvCBjKubzNoV6uVMbB5Pl06yKaatJcHaEyl6Jn
	ub3G+5l/5vpxEuBFXQ0WBFUYDfjyzlprJZjkDOsgWw40nhyoePdm
X-Gm-Gg: ASbGncs9XI/ZV8c8Oa7v8q2HQpjj2SaTZpXgvfE9U2QoZ75g9dw7n8j4augjKHTgxfL
	JzTn/oN+J6HCQ85SE+ptkEYR77amY5oFhPw3j7py8I/TJBjsn8Y7ZvEHAd43+spIK8Pl8eTNkki
	3s+B26iRjcbZI5cfaogaCctZWghUVEcEefc9SPDadnjkBdMKFYLvw+v4pPlpTNEx7PWXSpF7txS
	8SWbZ4+o6wMg3FpjFkRbfE13Cn5p7TWQlNSvMD8pFFWYRKjssI4SXwiOJyY9ws8uNm0rjleTXXj
	jnEHnBNUpukCE+TOUtstAAalbs5r7QfOj296J8r1+v+frOV2qXZnXpoBbm3Sk+f3iwZZRocfsAM
	5C1IxpLjxpLunnJIjIT4IUfFhGvQc
X-Google-Smtp-Source: AGHT+IHGHiOrC+gOvwxsNgQjXSm+TIRcVXspSDyBsDPgTboUtiOiWHemH4dUn+FSAC6hrpVwEjhvPw==
X-Received: by 2002:a17:90b:1d48:b0:2f9:cf97:56ac with SMTP id 98e67ed59e1d1-301a5489ee0mr5080905a91.0.1742311356544;
        Tue, 18 Mar 2025 08:22:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301a39efc5bsm1492988a91.0.2025.03.18.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 08:22:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7afcd224-1154-4e2f-b383-10f6a89fdae0@roeck-us.net>
Date: Tue, 18 Mar 2025 08:22:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
To: florin.leotescu@oss.nxp.com, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com, carlos.song@nxp.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
 <20250318085444.3459380-2-florin.leotescu@oss.nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250318085444.3459380-2-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/25 01:54, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> Introduce yaml schema for Microchip emc2305 pwm fan controller.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>   .../bindings/hwmon/microchip,emc2305.yaml     | 113 ++++++++++++++++++
>   1 file changed, 113 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> new file mode 100644
> index 000000000000..e61ef97e63af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip EMC2305 SMBus compliant PWM fan controller
> +
> +maintainers:
> +  - Michael Shych <michaelsh@nvidia.com>
> +
> +description:
> +  Microchip EMC2301/2/3/5 pwm controller which supports
> +  up to five programmable fan control circuits.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - microchip,emc2305
> +      - items:
> +          - enum:
> +              - microchip,emc2303
> +              - microchip,emc2302
> +              - microchip,emc2301
> +          - const: microchip,emc2305
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#pwm-cells':
> +    const: 3
> +    description: |
> +      Number of cells in a PWM specifier.
> +      - cell 0: The PWM frequency
> +      - cell 1: The PWM polarity: 0 or PWM_POLARITY_INVERTED
> +      - cell 2: The PWM output config:
> +           - 0 (Open-Drain)
> +           - 1 (Push-Pull)
> +
> +
> +patternProperties:
> +  '^fan@[0-4]$':
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        description:
> +          The fan number used to determine the associated PWM channel.
> +
> +    required:
> +      - reg
> +      - pwms

Is it necessary to make 'pwms' mandatory ? The current code works
just fine with defaults.

Thanks,
Guenter



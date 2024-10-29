Return-Path: <linux-kernel+bounces-386986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3FF9B4A78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297D5B23B06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6D206955;
	Tue, 29 Oct 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBYHkHa5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB31206047;
	Tue, 29 Oct 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206855; cv=none; b=ARhsBYBjTl/BJwv7Vol1Uj8s1nqnZGXA4xitsk0tkB1Vy3/CwLIW5XQ06YWCQvSU+ug897xf7lbQmr9MDJgNNeoPUB3qKMNZOyXvAFGlmJRNWS5v8p+1eME2alY6IR5snFN72npx6jPa/1X/FKd/RSgXgwXSsG1leY3T+ndcWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206855; c=relaxed/simple;
	bh=uacRA8mJm8LnZbCxmbCmUnjDqrxLthDjclqOjyzXNCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL7AJv6P/pY3MkV98fvOrHoqDh8deqB+uWWaUmjBYv8T9AmCnBuCejTm5AZo1eZ6Gt5fxByCmsSoikkn6MQtKdBnE+7L2+Cq0mielnllRvhueFk6oJoYHKelpdNcLiSyo1PjodyqmDIiL6ryVYSMNt8e1YF5fKI+JSNP7N6Ip4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBYHkHa5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so8410981e87.2;
        Tue, 29 Oct 2024 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730206851; x=1730811651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAVsU5g3+MlTQcp010PACKQBUJqBPdIp3WU6iL95VOg=;
        b=MBYHkHa5FyY0VAEBuYFQC7lnI4G3jQmyYyLs+9G09/lbJr7JweWAfnrKY67hfMOxAB
         Ll7QRb0ThL+BYyZ7lfcOaW/OsqY8Jm/T24goaX4i5fPAxxiP+vXVt1ujJrPEWbvAJuCL
         9onhHPGt6uaBORG1M9UDdYT/ilxbTjMJb0W5gWCWsPz2t84pkWdOu+WnccU8OdBtQqCJ
         rqoW9rF7EjS9qcpP7x2YZCRjED13b4DNd1Hk1ansOQKjIxgi89JYK0BYWpI6xFLx1057
         Zo7qwCjjRPDj49wxPO6yHKDqaB2G7Id2CetELhDPQbtSdM1sPKBeI3/SEtINAkK1VjSa
         e+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206851; x=1730811651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAVsU5g3+MlTQcp010PACKQBUJqBPdIp3WU6iL95VOg=;
        b=Qb8+FvT5k8dbi0XliiD77ZsrzqBWGYFkiKoRou65hkhDYPHukuLx5w/bNGS7KiDtNm
         puu0nlbJMHvaNszKtnUpCfzpWXU+1ElyvBd6MJEUxRVrJ4P7LSrsDMJNqWoLzM6EITm+
         PCjsIxkWHdPv9o4iAM2NX8fX/N3hBOYe4P2Iv0zguajRUIbLqmZIDWTWJYa5iCzf6gAV
         5vCxJJYDYJLfjjtMwDp3qqwB/IDy4cC0yGnIQpc9j8x1XrzupdyjOoRF8SYyhCGktSUh
         O+ClslU5uHo93Oe7lHwOGJF+MSYBnGuM8Vi5HhvQGlKP3dsII1lEOZ4DEIFRSVOmKfRm
         BRGg==
X-Forwarded-Encrypted: i=1; AJvYcCWIRwesk1XYVxQ3wa0WrtPhGoE9iTjXVs1Q8BK93dR5QO4gsPKwOfzJjiETSKsU69gXhWd2nNafLS2wobi1@vger.kernel.org, AJvYcCWgW6vCSngYyJkHJyQGMFUby/nfqT+lcMqwzQDtaD3JvDNPh6PRgWCUhpUJ67Oo58Hid38wFPLD53ef@vger.kernel.org
X-Gm-Message-State: AOJu0YxkP/BEf8u6EQG+0gibgfS2GgcyFEwD1hA3wrJGlBddI6RqDfE7
	snM7Hm9vxy69hG71Xuc/47KBwy0Yh9iwbUNN6BgewuWJ+bG8pGPD
X-Google-Smtp-Source: AGHT+IEGnEGBW87aSj5ywZD3JRXQJHCQ+JhLShuDMPdcEC0VIPqm8uq3fnwqVRM+A00VgfQ0ujV5Cw==
X-Received: by 2002:a05:6512:2311:b0:538:9e1e:b06f with SMTP id 2adb3069b0e04-53b348dacd3mr8706950e87.27.1730206848339;
        Tue, 29 Oct 2024 06:00:48 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e124474sm1368629e87.81.2024.10.29.06.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 06:00:47 -0700 (PDT)
Message-ID: <65fbbdec-3746-4f8c-b3a4-46ab29938339@gmail.com>
Date: Tue, 29 Oct 2024 15:00:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: bd71828: Use charger resistor in mOhm
 instead of MOhm
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sre@kernel.org
References: <20241029111112.33386-1-andreas@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241029111112.33386-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 13:11, Andreas Kemnade wrote:
> Apparently there was some confusion regarding milliohm vs. megaohm.
> (m/M). Use microohms to be able to properly specify the charger
> resistor like other drivers do. This is not used yet by mainline code
> yet. Specify a current sense resistor in milliohms range rathes then
> megaohms range in the examples.
> 
> CC: sre@kernel.org
> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Thanks a ton Andreas :) Maybe a
Fixes: 1af5332fcf7c ("dt-bindings: mfd: Document ROHM BD71828 bindings")
as well?

[I just pushed something like this (but untested) in my repo - but I 
missed updating the example!]

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml  | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index fa17686a64f7..09e7d68e92bf 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -55,14 +55,15 @@ properties:
>       minimum: 0
>       maximum: 1
>   
> -  rohm,charger-sense-resistor-ohms:
> -    minimum: 10000000
> -    maximum: 50000000
> +  rohm,charger-sense-resistor-micro-ohms:
> +    minimum: 10000
> +    maximum: 50000
> +    default: 30000
>       description: |
>         BD71827 and BD71828 have SAR ADC for measuring charging currents.
>         External sense resistor (RSENSE in data sheet) should be used. If some
> -      other but 30MOhm resistor is used the resistance value should be given
> -      here in Ohms.
> +      other but 30mOhm resistor is used the resistance value should be given
> +      here in microohms.
>   
>     regulators:
>       $ref: /schemas/regulator/rohm,bd71828-regulator.yaml
> @@ -114,7 +115,7 @@ examples:
>               #gpio-cells = <2>;
>               gpio-reserved-ranges = <0 1>, <2 1>;
>   
> -            rohm,charger-sense-resistor-ohms = <10000000>;
> +            rohm,charger-sense-resistor-micro-ohms = <10000>;
>   
>               regulators {
>                   buck1: BUCK1 {



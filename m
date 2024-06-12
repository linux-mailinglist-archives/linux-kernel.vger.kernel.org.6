Return-Path: <linux-kernel+bounces-211421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232990516C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071DC1F22B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701F16F0C6;
	Wed, 12 Jun 2024 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Es9dlowL"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D515624C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192099; cv=none; b=BzvAqqAdKDaEwcrQtNX4JT39/Dnu1EYWz2zxczbeb1mhMX2sqStk4TqXgvDSGrHsZJL8cn2wWOVozAo0NVPv4f6jxfkjMkxK9TIc7gjrF2w7Jcr+MxTljoraNZEIRljybZgw/QBS7WXFioZ6p5oL9jPVX+kaCPtGGG7WALP591Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192099; c=relaxed/simple;
	bh=MZ0bROeIy+CQjHZ+rRTQWtZgMMK1yDMg4Ruh2BA2+4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=G0iFVrFInr03FoEjT6IzTcjtQVcwWVOlQoa0xGfkVQqYKk/jWEVnaX/+1aCOHciHAA+/WR0WKM5YXW0DxGnrqII+slPIwAsahRDFRyKDaOWXhff6MJpcu0C2plKNzHhB84+8ZCahb+GYC5JLUMXUYUfXNdbAaQTbh2V6nK9NItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Es9dlowL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebed33cbadso26246491fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718192095; x=1718796895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5U7UdpN2UfJDP/46wGRPZr5KWrtreWY0N2ItY8olYtU=;
        b=Es9dlowLnjP/QONCi6Z9g2vUF/LgntDdjI6+dIsRFGiocbJD6SoS1ciipC8MRHE+oe
         4JVvZfpecZSvllV9fSRxWmZeKeA4QMJunnDJbCUw2JS9GuDGpKZ8XxVX9ADOFHQ96zyt
         LJT4voLBfts5PkswvFc4j1vA8MC0ypZSp994P8qaFOQS6DJxtVcc89U2TGk17gsRSHPD
         s+DxA39OJ7/g2fJNYdqdMFzfdl9tbG41tplL/jTS9yWovGG0eNfDO75dlFenBmF8Lc6g
         r7pAa0qVMJ0+KiqzvPpoMxn69nb1hIIX6Ke4WU0clDDusmikYJ9BLYujIC0M9dCB48PU
         ptOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192095; x=1718796895;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5U7UdpN2UfJDP/46wGRPZr5KWrtreWY0N2ItY8olYtU=;
        b=jswefe8oB6skA4cK6D/yPLm4QSZGGZ4D6IlqWd6eqLSfLU0dxKQkUd78UYKc7NyULM
         E6sQrzWLYB6HK18ZgQWBDmpA1m44bfCle8RmLeKWLbm3no/9tMfqsHcURxaOdyryrUVp
         ksVh6hDkBmM2NnWYgnIu3Ma1sGRffJdIKEcfxW/iuIR6GwiMn8MZRkd/tGzWRfuwyCW+
         CvcRFKbuCxlBZsO5CAeN1+Mcvu6RwLnd/Q+fanIVKbt3tMymhzf21JtRKahWOjctutWN
         GgnT4cVmjqKeligng8VCkjLYP+Q0vX9GV+EOhcnKG+f4ddEYY88FArTEja0GAUkFKPD6
         p2EA==
X-Forwarded-Encrypted: i=1; AJvYcCXxQrKh84e3rAMw6N5j6khDTf5OHdr5qVXWD8qZfqx/lq3t/KxzS/MISa7IU7XaKQrdvDNMoWPwgi7rCoZUwZYtC9lfbUYocR5X3JeG
X-Gm-Message-State: AOJu0YwKUUZH6fLgTaS0/AbbO12zD5gND9gU9VA2B4rhR0HYFZL0B10U
	G0IkRwgXQp6u/v4vsavYbEScIh0QUk3N723lgLJDOFd9ltyWnD86eereN2nmuaE=
X-Google-Smtp-Source: AGHT+IH1FWrncntpv/c77frag4GdO+EyR92d48FIIj1Ou8KKpm5o3pPW5TO+GoBcdkGISymABL4kPQ==
X-Received: by 2002:a2e:9ed1:0:b0:2eb:ee24:d5bc with SMTP id 38308e7fff4ca-2ebfc8ffbd4mr9774881fa.8.1718192095565;
        Wed, 12 Jun 2024 04:34:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75e0sm23408775e9.1.2024.06.12.04.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 04:34:55 -0700 (PDT)
Message-ID: <58d0b3ed-582b-4a59-9599-6582d5953f12@linaro.org>
Date: Wed, 12 Jun 2024 13:34:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ARM: dts: imx: align panel timings node name with
 dtschema
To: Shawn Guo <shawnguo@kernel.org>
References: <20240509104838.216773-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Cc: Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240509104838.216773-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 12:48, Krzysztof Kozlowski wrote:
> DT schema expects panel timings node to follow certain pattern,
> dtbs_check warnings:
> 
>   imx6dl-gw54xx.dtb: display-timings: 'hsd100pxn1' does not match any of the regexes: '^timing', 'pinctrl-[0-9]+'
> 
> Linux drivers do not care about node name, so this should not have
> effect on Linux.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Hi Shawn,

Any comments here? Can you pick the series?

Best regards,
Krzysztof



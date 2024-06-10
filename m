Return-Path: <linux-kernel+bounces-208301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A468E902347
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2371C2147D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA0145A01;
	Mon, 10 Jun 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lZeZR7s8"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFB839E2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027620; cv=none; b=oFYnwvNPg+8YuB6cKl81ThmDLrsdJiGH8ks6jEmTFrb9uHMsTQVbwjcsks3AS+ps0a89DzbCfWZiQWlm7yHsNjX/lXmCCtxFYG9nS0MPvCcvgom+p8XRybR5mWksRNDxweq8mjVGuJDiyBtXPLV/ocqIqhWyUXBXKU7ypIbKS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027620; c=relaxed/simple;
	bh=pUwhWLC6cR4vURpqvQ+y+aCC5IaU7/FGQTa28IVLaiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhNlIIbBQkheqcuPhjrONOU+b0FhvVfHhq7+7AdAh2nY0Cjeg1a9awIYYyjPJqtnzjmB8deI2lDjhep2N1rEpk70coOLNna2zcpfqNQPpET/84QBBOpXqv6xmRF7N5ZFVkWMkQHC38P6ZNB4Ox/ZDe3oUcqfMLgEXQNtk5KVkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lZeZR7s8; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ba33b08550so2347194eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718027617; x=1718632417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMGNAPlCBzzHg+7F/6Pguyh8dwXxKCu/BC3Navp4aRA=;
        b=lZeZR7s8Pb50lVkTgUIbnUtEZBDys6iBp0VDvklgaR5nR/OjqDqBlViMyCr+tJRy93
         GzzX3NeFWVpHZhvPq9bgXdQ6dxv7ZmshFdfePTS5U17V6c9W2faZRalsUa5Ny5gAc1LT
         CTeF/a6Dxm1v1GcuDBZ4poEmo8tpXpWvxul3MQFvktUh8ZLpAE7tdYnmpSbEyUZiRYoW
         Mw0ugaaj0tr2z++j0fWWwgTseKgNz5k86p7DrNrVl8p7kBGgLsfN2jDsP4M9VQTvreLq
         GcviiC6+B7a/UDLGIHitUSQVIvDZWBTdbaJjGz2MlU97pjsKh/M1yGQPBoeTxzjZ1pPO
         35lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718027617; x=1718632417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMGNAPlCBzzHg+7F/6Pguyh8dwXxKCu/BC3Navp4aRA=;
        b=r0d2OvFD3YCyNSiBzPykaXfDB5LpGf/InsV1sAxsOp8bZKAzoTOJoapNkaZFGaKdTo
         sAhxFMiGfnj7qRa6QxHhnwXORS06RssdtrglC0BIxHfUkJOclLRoe91/x8wfN0scuvXz
         +1MBOVXKcHkuzfbZPKf8sNdj6eFGeyyblkf3mdY3sWhA4iNQldOjOJFgRK05WivrEB7Y
         lLptprNk83jUTXQrnK8+5W3IhEqocsBPrO9yzQagdypkk1RXgPQURbE7bX6UZemQQj+X
         bV9z5LJcG+X2E7b41GG3DRnFkvyYmR/l9yVJJqKrhxd9qv+Kt5MH14UYW9WNIcV/yL6/
         Dhtg==
X-Forwarded-Encrypted: i=1; AJvYcCUgarBE7h9FxmpBwAT9QVq9T/sIiyVGSub3UN7MR9DNeEJvR/jRvxLJEMQpc3DOpUckvtMBhLLTOhWx/AArssMH1l2mKCGGatorwY9M
X-Gm-Message-State: AOJu0YxDjD4YYK4FMaF4x3csm1xeuHw75lhdZ5RGVrByTPZKFZXRJkUs
	lueeFRlcdfbbkji8H8efjzSxPaLseLxP66usOfQLMWs65IOvEE69tYdnMIR4WM/l2EXNhrOwbHy
	l
X-Google-Smtp-Source: AGHT+IEx1Ddazj3ZOZLiTh7HE72thFf86UuGLsT9yoBsbmv3nlme1jArw/gpLO1XraEeXBrVnu9Dsg==
X-Received: by 2002:a05:6820:2813:b0:5ba:e995:3f03 with SMTP id 006d021491bc7-5bae9955f59mr3363948eaf.6.1718027616859;
        Mon, 10 Jun 2024 06:53:36 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bae9f61bb1sm612751eaf.19.2024.06.10.06.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:53:36 -0700 (PDT)
Message-ID: <e1c7bc9f-3ecd-446f-a6a2-f97d6a8aa78d@baylibre.com>
Date: Mon, 10 Jun 2024 08:53:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ti-eqep: enable clock at probe
To: Judith Mendez <jm@ti.com>, William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com>
 <c08d2d51-e2e1-4b68-a4fb-ebf3a919c1b8@ti.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c08d2d51-e2e1-4b68-a4fb-ebf3a919c1b8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/24 8:44 AM, Judith Mendez wrote:
> Hi David,
> 
> On 6/9/24 3:27 PM, David Lechner wrote:
>> The TI eQEP clock is both a functional and interface clock. Since it is
>> required for the device to function, we should be enabling it at probe.
>>
>> Up to now, we've just been lucky that the clock was enabled by something
>> else on the system already.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>   drivers/counter/ti-eqep.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
>> index 072b11fd6b32..825ae22c3ebc 100644
>> --- a/drivers/counter/ti-eqep.c
>> +++ b/drivers/counter/ti-eqep.c
>> @@ -6,6 +6,7 @@
>>    */
>>     #include <linux/bitops.h>
>> +#include <linux/clk.h>
>>   #include <linux/counter.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mod_devicetable.h>
>> @@ -376,6 +377,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>>       struct counter_device *counter;
>>       struct ti_eqep_cnt *priv;
>>       void __iomem *base;
>> +    struct clk *clk;
>>       int err;
>>         counter = devm_counter_alloc(dev, sizeof(*priv));
>> @@ -415,6 +417,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
>>       pm_runtime_enable(dev);
>>       pm_runtime_get_sync(dev);
>>   +    clk = devm_clk_get_enabled(dev, NULL);
>> +    if (IS_ERR(clk))
> 
> I think it would be nice to have print here in case the we fail to get
> the clock.

Do you mean that we should call devm_clk_get() and clk_prepare_enable()
separately so that we get two different error messages?

The dev_err_probe() below will already print a message on any error
(other that EPROBE_DEFER).

> 
> ~ Judith
> 
>> +        return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
>> +
>>       err = counter_add(counter);
>>       if (err < 0) {
>>           pm_runtime_put_sync(dev);
>>
>> ---
>> base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
>> change-id: 20240609-ti-eqep-enable-clock-91697095ca81
> 



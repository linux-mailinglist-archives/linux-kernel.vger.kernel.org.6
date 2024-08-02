Return-Path: <linux-kernel+bounces-273213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B319465DD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40C61C219A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212A13A3F2;
	Fri,  2 Aug 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB6VJkpm"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634581727
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637222; cv=none; b=Oqh7sCXln3rg8XkaHiq/Y0LpNrVqxZZwR0KnzMF33D/fY+X4wOHHS8sUdsnxyRKQiJ16z2R2LziSfdKKQo54qeJiNEwdwOPLoVp8Av20W+dCli2HSnV/oGFDcii1ybhknMEY9/R/PhPV+Clhu+mWov80el2nZQ8wXCK+AvOPxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637222; c=relaxed/simple;
	bh=h6CpH24tdqZUkuI/1m5niZK8wU/AxOjrnZGKWbWAiZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFOBWU+Q0ZzuFq/zCxbURdR283x9k1vYFW/4p6kItaKTIdOxGZVvW7u103R2YU0iPUHeLyePOXdoQxlzSXRmkf5MBiAiHPwu2pUCrPHrNHWlAFXzdqbjBHxcWdqMLDG5rr17t4z0lEPXax4HBpXQX7ZfpichnxvHMbFuD4/eOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cB6VJkpm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso52393795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722637219; x=1723242019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBNVp3ZIi46qbr/bGlBeHrp1CnYuXuhb4TgdeRcgo2k=;
        b=cB6VJkpmdZZQlpMY3ajwa5LfNVh3Jn/5E/IFfoaT8l+q95YbY9Xe3DFAgmr19zBxYB
         itY4AuKP0UZH0WJS0wvb0w1474qCTWWjMCOp+obP7YD8xMkYCVaHwxajLbFkFCsFiXUa
         389TlWNnDax5p5zPjE+JwQABJ2BdrhlGWtFrbzn6IbuFN5ToSMZ3TqLGiLp8NNot6T7F
         YJKqKVAQ83m+PxyyuNw0STBfpXhy45VtiL5Oi/WuIVYOcb7n0fN5/Ou8w5XPCNUTK+yv
         BMZnrLL52TblQ4uo4vqcw8SAfDp80QGAUePyDbhhzRTLj3LfOQ8ty8JLjihK6BA5MBs4
         KftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722637219; x=1723242019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBNVp3ZIi46qbr/bGlBeHrp1CnYuXuhb4TgdeRcgo2k=;
        b=oRT0wCfVFWy2DJl4Iz6cnU9x7DaoEWTdJ5tgA8ULnWoIoiaVOMqW5fIGxNCTbhLXcp
         ZPpYMvOW52/ZQ+S0GawunGNTMBqtRfxo5pRnP7YYNUggKqeGC6b+7ZecaX8IKzWOpJxk
         mVOpWAshqO2pfbzNnFuu2SkitJBvb9TWpFED9GX0wadiUAOf5nqwDwFGkA068eBCmhbU
         Lyma7shvEOCrVfAccSgGmyeQiG5hgFGEvVzzP9yZevB2gugtKSLs6dQCv61PpuFJSVt3
         dYxz3xeT18tfUU9Hhq5DOwoWKr1jeKB21YrV8/9GDFcOiWcgRUtcR1t3pEFUFgPrP68N
         5pqA==
X-Forwarded-Encrypted: i=1; AJvYcCXFA/fxfLonHBVZIHueZ58yrSf0de7QCYpr0knUoIhTn9sCP9FF1di2wvTqtPEm4NJKsOamZhQRUEOmneNRxy8cUdA09stUpEe4Uzzp
X-Gm-Message-State: AOJu0YzfZakDrnV5xIJmECO/BOckWycIlmflpLDvMO+qCIVE5xyu1Z7B
	A8N/K6HhgpN1GNYemcF/Q6uuSSYv8BpBwuweM7mXMS+dLTi6Gnq9digNOKxrbNE=
X-Google-Smtp-Source: AGHT+IHo0k73aoIX2/peHNzr8OqRlTWFYxoZgSL9K4Bcbccfpi0/KpivbXSc7VaClxpwyzQ2UrYCRA==
X-Received: by 2002:a5d:4749:0:b0:367:326b:f257 with SMTP id ffacd0b85a97d-36bbc130683mr3175357f8f.33.1722637219093;
        Fri, 02 Aug 2024 15:20:19 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1dcdesm2852358f8f.35.2024.08.02.15.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 15:20:18 -0700 (PDT)
Message-ID: <cc737b05-4476-4ded-9d1c-5924cfbce316@linaro.org>
Date: Fri, 2 Aug 2024 23:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] media: camss: Avoid overwriting vfe clock rates
 for 8250
To: Jordan Crouse <jorcrous@amazon.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240802152435.35796-1-jorcrous@amazon.com>
 <20240802152435.35796-3-jorcrous@amazon.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240802152435.35796-3-jorcrous@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2024 16:24, Jordan Crouse wrote:
> On sm8250 targets both the csid and vfe subsystems share a number of
> clocks. Commit b4436a18eedb ("media: camss: add support for SM8250 camss")
> reorganized the initialization sequence so that VFE gets initialized first
> but a side effect of that was that the CSID subsystem came in after and
> overwrites the set frequencies on the shared clocks.
> 
> Empty the frequency tables for the shared clocks in the CSID resources so
> they won't overwrite the clock rates that the VFE has already set.
> 
> Signed-off-by: Jordan Crouse <jorcrous@amazon.com>
> ---
> 
>   drivers/media/platform/qcom/camss/camss.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 51b1d3550421..d78644c3ebe9 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -915,6 +915,15 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
>   	}
>   };
>   
> +/*
> + * Both CSID and VFE use some of the same vfe clocks and both
> + * should prepare/enable them but only the VFE subsystem should be in charge
> + * of setting the clock rates.
> + *
> + * Set the frequency tables for those clocks in the CSID resources to
> + * be empty so the csid subsystem doesn't overwrite the clock rates that the
> + * VFE already set.
> + */
>   static const struct camss_subdev_resources csid_res_8250[] = {
>   	/* CSID0 */
>   	{
> @@ -922,8 +931,8 @@ static const struct camss_subdev_resources csid_res_8250[] = {
>   		.clock = { "vfe0_csid", "vfe0_cphy_rx", "vfe0", "vfe0_areg", "vfe0_ahb" },
>   		.clock_rate = { { 400000000 },
>   				{ 400000000 },
> -				{ 350000000, 475000000, 576000000, 720000000 },
> -				{ 100000000, 200000000, 300000000, 400000000 },
> +				{ 0 },
> +				{ 0 },
>   				{ 0 } },
>   		.reg = { "csid0" },
>   		.interrupt = { "csid0" },
> @@ -939,8 +948,8 @@ static const struct camss_subdev_resources csid_res_8250[] = {
>   		.clock = { "vfe1_csid", "vfe1_cphy_rx", "vfe1", "vfe1_areg", "vfe1_ahb" },
>   		.clock_rate = { { 400000000 },
>   				{ 400000000 },
> -				{ 350000000, 475000000, 576000000, 720000000 },
> -				{ 100000000, 200000000, 300000000, 400000000 },
> +				{ 0 },
> +				{ 0 },
>   				{ 0 } },
>   		.reg = { "csid1" },
>   		.interrupt = { "csid1" },
> @@ -956,7 +965,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
>   		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx", "vfe_lite",  "vfe_lite_ahb" },
>   		.clock_rate = { { 400000000 },
>   				{ 400000000 },
> -				{ 400000000, 480000000 },
> +				{ 0 },
>   				{ 0 } },
>   		.reg = { "csid2" },
>   		.interrupt = { "csid2" },
> @@ -973,7 +982,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
>   		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx", "vfe_lite",  "vfe_lite_ahb" },
>   		.clock_rate = { { 400000000 },
>   				{ 400000000 },
> -				{ 400000000, 480000000 },
> +				{ 0 },
>   				{ 0 } },
>   		.reg = { "csid3" },
>   		.interrupt = { "csid3" },

Hi Jordan.

Thanks for your patch. Just looking at the clocks you are zeroing here, 
I think _probably_ these zeroized clocks can be removed from the CSID 
set entirely.

Could you investigate that ?

Also please add

Fixes: b4436a18eedb ("media: camss: add support for SM8250 camss") and 
cc stable@vger.kernel.org

---
bod


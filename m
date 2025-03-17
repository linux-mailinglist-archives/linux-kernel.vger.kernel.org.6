Return-Path: <linux-kernel+bounces-564010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F1A64BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6BE16A0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7A23644D;
	Mon, 17 Mar 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhY7YsEq"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFA233141
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209867; cv=none; b=NYb7RnLiFJ9Dd2a8siDazIT0JR7sItMO8qazfWUpsSWappBG3Tf3vuFidnag5PLY+pRrvfEXrhitT42OzU1k2NfYHanplDWdjrNXgy2lRyjc6CPGztlVzqsqy2Rk8fKzzB7VYKELFAMHMrR27Tl2qNolUczgHHJ4WehwNVFINWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209867; c=relaxed/simple;
	bh=AnrsQLvHijfeZTAeUyDiBdqlQ/V+KuOhDqmhlYfAtDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUO978dcr7UU0i11uff4Is6KlwlvPtJErbbVsQ0ZjK6IybUyRtrGFuTFDhmkIqPS4tZ9A6Ay2n4PUUYWPpN+L5eVzGiQtze9/DP8iFQ6k4lhRSCgWGjw/woQvxEs7lfd4aON3PZBW6msykmL338U3HtI4+WsIQ9py74KtkH20d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhY7YsEq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390effd3e85so3515487f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742209863; x=1742814663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MR6V4/Niwov3dT1lKEaWV6Yp8Zy1voFzaQ1D9zoTY3k=;
        b=ZhY7YsEqWuYO0n+9UZh0lhWNIrRVuBtA2pDbKrPiX1BIDpSttBPEbrC7IXd40sSDEH
         b2hSvVQPf2iwBVgGKvfSE99esQABwnJ+u8RfD4gKw7kx9CmWzPXRc82RKkUg+T0EA/o4
         dAcVIu6ZtwSGMaiULpEaWjwgqUMO7XQXRKCicX3e0XgxBwjfkxdMHr4m0RBNDbTSf8dV
         C51TK7gWeGCJyCPXN2i7+eCla20fY/zmEhIZJyb3k8WPUmscADeyKJX+CITqJ5HWVP6k
         bnUmGCWmFwe9+DjsXppUP58wud1Oc60ay7zktoKvNADeSEiQ6W6yOGDQVhegmRbziW8O
         wKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209863; x=1742814663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MR6V4/Niwov3dT1lKEaWV6Yp8Zy1voFzaQ1D9zoTY3k=;
        b=Vuxw0dgRvBRYNf4OJXeCJ8nhmg95IQ8E6vfXfXLZHrUoR7Y6vXzOpAPzP4ErMin24n
         jJa0vWqqtJgt2mG5AiAi1Jl8f4QyJGUL2cC1AsIFOpEZqbMXeTxCulezAiMIJoF9+3fu
         UmbB8fvs2Qh56MFMauGH6+9kplP8EK/hqvAsMzMeeJrL2vmLIpFt4w6Nncvfl2Zg3OV1
         0lKrNOwxT/A89SLPK0MSqYRp+/GAfIj+jA54oSwfA0Y/h0Y7QsK++OYlZqEz+NS0McNo
         dm+lFVNExvn42fO96GTx6TZ7XOxo1CzxIz9ocLLq7JwKLsOTBi6bHlskrtJx5TSJ6Mwo
         Rerw==
X-Forwarded-Encrypted: i=1; AJvYcCWry1+WyzmyRAvtfgsMmIu3mc09Yqt0/6RBGdqlnlqWzTPgyKGuntsb9ITQy0ooHOOopvc78KtFuPOTniY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkh0IztK7UbtVINGeE8d0weJREHyBbsz25KUkXQ0I4IR4wc80
	g1DrrIwPeS6wlvfzonaSkw4zMR1pSj2M4izaO4db0XrSRkIOWfJJGhdD3/KjmG0=
X-Gm-Gg: ASbGnct1TH1g17M4BnPDGZJAMrXVEptlyuuTsBwlZp9ca0UJb3SXMaPHDLopBbalGNk
	PkB+jV9mcQPYOQw6ceqVbzfnkFlVJueDZZ/1TKpAshg/IJZTpGdugvx/XPgfdAx6yVGgPtgoT8b
	LrPg4xrQj9Usk9QVmnzp9RqoTNLSAyNxDXZCwN6BZK+KEObpgG13fwJ8e4tTCdvVMRjMLBMqdhA
	/d+JmgtnJmcB6vD78ZjWjoN3Ea3nfqVigwl9E0xs+emvwv07FsWDWRlrTqHXyGB0I/ZSvxvZB7t
	dfXIXNIGpuJWQ08aXoZ0wasn+E8eCddmGY1bkOTyUull7ukZhaVGwcMPvWbKfS51UhVJnJxB0im
	SzTAmYu7Cr/1l4ttnqB4=
X-Google-Smtp-Source: AGHT+IE476SO8H91edeKXZBTAyLprfXCwLhm85dorgsKMjTo5H3Yf/EGW9XVvxTRoJ7VcbN4UEacig==
X-Received: by 2002:a05:6000:1ace:b0:391:41c9:7a87 with SMTP id ffacd0b85a97d-3971fdc6db1mr13823999f8f.51.1742209862843;
        Mon, 17 Mar 2025 04:11:02 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:900a:ff00:eb98:2c37:6a77:39? ([2a02:2f04:900a:ff00:eb98:2c37:6a77:39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318af0sm14702121f8f.73.2025.03.17.04.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 04:11:02 -0700 (PDT)
Message-ID: <75f49e65-5a8a-4a52-bed9-31be4a76d536@linaro.org>
Date: Mon, 17 Mar 2025 11:11:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] firmware: exynos-acpm: convert to dev_err_probe() in
 client API
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
 <20250314-acpm-fixes-v1-3-ab03ca8e723f@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250314-acpm-fixes-v1-3-ab03ca8e723f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/14/25 4:40 PM, André Draszik wrote:
> dev_err_probe() exists to simplify code and unify error messages by
> using its message template.
> 
> Convert the remaining dev_err() in acpm_get_by_phandle() to
> dev_err_probe().
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/firmware/samsung/exynos-acpm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
> index 48f1e3cacaa709ae703115169df138b659ddae44..03f907a95c6acd66d89cd8af2f52e7c6dadf492a 100644
> --- a/drivers/firmware/samsung/exynos-acpm.c
> +++ b/drivers/firmware/samsung/exynos-acpm.c
> @@ -701,12 +701,14 @@ static const struct acpm_handle *acpm_get_by_phandle(struct device *dev,
>  
>  	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
>  	if (!link) {
> -		dev_err(&pdev->dev,
> -			"Failed to create device link to consumer %s.\n",
> -			dev_name(dev));
> +		int ret = -EINVAL;
> +
> +		dev_err_probe(&pdev->dev, ret,
> +			      "Failed to create device link to consumer %s.\n",
> +			      dev_name(dev));
>  		platform_device_put(pdev);
>  		module_put(pdev->dev.driver->owner);
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(ret);
>  	}
>  
>  	return &acpm->handle;
> 

The clients are indeed expected to call this method in their probe
method. Shall we make such assumption? I'm in the middle here, but I
don't mind if this gets queued:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


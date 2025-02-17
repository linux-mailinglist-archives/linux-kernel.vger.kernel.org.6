Return-Path: <linux-kernel+bounces-517403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C886FA38054
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518103A35B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234CF215F75;
	Mon, 17 Feb 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKlMKuYm"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD622155321
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788599; cv=none; b=UIx6w22z8Uc13mDtMJ7TybH24ZjE++9W3QmNqGtCk50g4mG5MXsXB1GncgESFnKh8KFFO9tBIetWumOOBL4L/bINlZxfcl7l+UJO57A0Zzc/CAwXn5rFoug67NOx9WvbSFp7iF6HdGnGT3VAkdyax+YPN5dx0VL88IvMb+uT5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788599; c=relaxed/simple;
	bh=4WZ48YT0MSsLinCjw+MfJuQIAoiu6CuoEfavQporznU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XY/b8UdctI3NXSMYnTgUwaw5P+N53OH8Mrgo2xEioRduQC2VvH+tt2zQ9KhEHQb2wd0hQJl6mkQDrBxXMEERY9VBgeQfkFdufOUJ0kKAQkPC/mK2pJDT120OoovUuQztKF8k/jWi2/VISyopyqoAWiBc+Si7Xd8bWCUWmAbQHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PKlMKuYm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so1812361a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739788596; x=1740393396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPeqxV3v8H4g+Vxay8XkZcl1XNuYQ+5vEQ3ndyeG8ww=;
        b=PKlMKuYmKs3l8/HBWb743ucQT0nrk65EW18AbFRaMm/2Yvvf/GVVl9rTFDQ76riigN
         yflL7bB4iHjRJ1ymlNzCEDDJRARerD5gDlgkPnQh5zUAncwUwBsIOcQvjudE73XrYBVm
         o+1oXjQZTKUNmfqga9BrlYiavoTULbKeYuKXPR4kC3EIE0jgVUsl9cC19sx3fYhiZx8T
         RcPua0EBnTzTjTq4K2BJWuoezjuWtOX6ybawHfKiDiVB5kjlsC1l7vwbP0RNBifQd2a4
         xh6OfBPsCGofeSBrShfG910bki+HI9FSm7eeDv6U8ZyeThiyj/DGEVWOUjXeQ+ArT/DO
         xZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788596; x=1740393396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPeqxV3v8H4g+Vxay8XkZcl1XNuYQ+5vEQ3ndyeG8ww=;
        b=pPMpYCaCkDcXxxE/rrqO1dh7wj4Abi4Jk7yapqlJMgpvASPPhFmDcFGKTHzhwqLr3H
         i+MPuWVGeAcip4Je4QZ8wogWT6a+AJppFfqjCnRWjKFc0frAjt8GpmESn9RP/jYtlJ2r
         HGPLzKr7qau0VPYB0U3F8A4UdxiwOWb8RQpo+neTkvT/WL+T/Lt+VkhW4yPoUl/Bgvpa
         Ofz/0leWd4yOBIm9+w8R/x3qnnIeY6pTPYBigoxhyaCWMAJHR3trIHGaCl8bU+X1o9SB
         rY+AUvWKptIhV6NQRQLswYOEYBgpcZ5ctA8N3Zhx6DNNpzCMNBgvAh3nxQKH+Cz7ChTo
         HmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtyIT0XzTCzGa2RrOKbhKN2Rwy8+eBeLyiGGiJu4GcDYSoDtFfM7PvBm04ijZrZlTU2br1wWUmoz1wDeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5lg9SAUz3wB3jtq77V5+EZhVxamDzRmlz/bMjsWIlEqkC7RR
	ynr3B0dVDjf4srra6bqm4wsfjwYraQ9F+SLM4YuFQA+VlMMbzRj/nAK8VdH2Vyc=
X-Gm-Gg: ASbGncuvVZ9gCPLlSxhZwEiW1UUvdZKN68gu0mH8tejZq9qgKOGh9hRAs2mqkkQWxYK
	7odtM3zkNJPYPV1wa52oYyeUe+5d9hYA9BXd9lNfWm9cp/ZAlKSzHOBM4T9VvMLoI6qgTGCH4Ig
	Lkj4ilCQ8f02Ctv75GBUiGmwAKDWyyxnHoQ8fowjzkzK3fs8Ho3XvhNgDHwu7LJHFY1v7swIw2g
	vG5mXyaiUh3GrCG8yePh/Z5Sb7yC7s0vZiLYMMSBdqnrbwAv/PyzQPJ5yHH4ei8v8mEX2WSly6r
	/QeCVGh+1Ah8i0hncmWFR4vz
X-Google-Smtp-Source: AGHT+IHZ274Des1ePN4oUbKhdVm0Vo5N1Xho1JI8Us9w6PhLudWtJ/YtQif5hVEJjAu8oDNIqvcsnQ==
X-Received: by 2002:a17:907:784b:b0:ab7:c6a2:7a43 with SMTP id a640c23a62f3a-abb70b7c310mr839740066b.31.1739788596142;
        Mon, 17 Feb 2025 02:36:36 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8190d15esm388729366b.16.2025.02.17.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:36:35 -0800 (PST)
Message-ID: <2d3b8404-81cd-44fd-905d-2e6e0b0ceab1@linaro.org>
Date: Mon, 17 Feb 2025 10:36:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] firmware: Exynos ACPM: Fix spelling mistake "Faile"
 -> "Failed"
To: Colin Ian King <colin.i.king@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217091341.297401-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250217091341.297401-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 9:13 AM, Colin Ian King wrote:
> There is a spelling mistake in a dev_err_probe message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks!
> ---
>  drivers/firmware/samsung/exynos-acpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
> index 1201380227e0..a85b2dbdd9f0 100644
> --- a/drivers/firmware/samsung/exynos-acpm.c
> +++ b/drivers/firmware/samsung/exynos-acpm.c
> @@ -620,7 +620,7 @@ static int acpm_probe(struct platform_device *pdev)
>  	match_data = of_device_get_match_data(dev);
>  	if (!match_data)
>  		return dev_err_probe(dev, -EINVAL,
> -				     "Faile to get match data.\n");
> +				     "Failed to get match data.\n");
>  
>  	acpm->shmem = acpm->sram_base + match_data->initdata_base;
>  	acpm->dev = dev;



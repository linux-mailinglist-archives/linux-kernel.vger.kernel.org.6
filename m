Return-Path: <linux-kernel+bounces-245988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BF992BC62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC25B20F0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A8195B28;
	Tue,  9 Jul 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7oRqSVX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A631953AD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533686; cv=none; b=ADhWwUGcr+RKxPOUhR0mlMtp3SNyCeLa8WZut6ovczpOGxHfS/+rhjAJeojTqV/gdIoUzmYyjB/MdJngupAue9Jytq9zgrSimQvjpwTKLkuNt8vnTSFtqqnhUYhIQ4NeDM02RTZZwG93dseVldE9qghAgaKTCbL0ePWpvvUOkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533686; c=relaxed/simple;
	bh=cWksfE0mDrPHGGfr0A1PJv1/l3GTs6C4rc8XVUn8CsM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=unv+aCvh6rAtgUNuQDiaREwgsTrW9riS7/yXz2zeH7Q1Xn3bnFVVU1psVOQwHBlfQIMiZpp0tJKwZvoujiqJTiTR66BKKe9XOnXaQ2w1FKAceC4aKeZNhVvRYdPlVuyIJ20vFkP6qZQ2dx3XWwYu5rqVZrmFqRJPwL8qN9zXt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x7oRqSVX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42679f33fefso4409425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720533683; x=1721138483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odNb0yTiM26VkEoxH1kb0dmkgcjAaMfcLxg2VgA0xjA=;
        b=x7oRqSVXYZ7hiAIq5OIovVu9mQFng0u0iZgGIFPGs4l15dAaQlKt40WeqdgtpEulJH
         J9Hb2d8XHqRQ1eUFrRIGUnqqmW4PtUcsxAIB4ehTfZfa/ABHoosUjjBcOeah1sYlQS+d
         qo6nEaMUGs78z0FuGOFPgueT0cofeVxfv0ifISmSI4gZKfZbmSu5LTQ9sFbnJvzpY8f4
         R75A4qiiu9HomVN8OR2h9j3wOAy1Hcd+X/8V8a9bIedJ9VBUVqliZUh53inDXvcft1tm
         dT/aCnkEX/VhKTaBKHLpgfEHkdZYihwAhPfratfYN9hOZfIyzCMFjcHuVIiMSOLDqruO
         mKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533683; x=1721138483;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=odNb0yTiM26VkEoxH1kb0dmkgcjAaMfcLxg2VgA0xjA=;
        b=Dvc6sisHueZSY8nV0cb9/mmo1nCkLmLzT3rFQXB2vzRIKB6vvnaNz9cBKRNgHYNLjU
         virfZMcH0WY56Ua5KmnJ4k02/qaPhnx6XVUrSLl5zi4tZslg5yLXNPMBCLaCNKZ1g/JJ
         ExQi7AIYapuiwS/H5gezcCiAMGv5NM9KuEVYvw5GVX05Pds/+ttOHW+y4Qew5lHSIWuB
         cAtaQCnWfncRs9blcL4Pq5G5csRdIPf3r5urbD9iqhjR5Q81D1C4/wnp9WGpA6N0f6DL
         ddmIQ8ab/nnWvf5Wy8IfRFhe7yTVxiVyk+DON1zQRGC81Mr3LXr3GvW7hfaiqenrGa5s
         bQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnGEkmOHoqEeybqAwadZpjc0AcbPiew+mpsLOh1bXYWItbFvH+r4Uy/TKymBmho4YgPRfPCFgQF7x6e7xBLqeBz09NLRX1kbN9Tn8k
X-Gm-Message-State: AOJu0Ywh66p0VuVCbBT9nVhohppatGwt2Sm2mFsZfjIU1C81Y/vFuAFt
	iZYLvHnYrU8c4V1CjXhdSj5zSfKDCvnespKmBw1DfaEhTHkeShd+lkfvWzhE1Hk=
X-Google-Smtp-Source: AGHT+IH6C9QFWooOG++C3SeWw1jtlVbKwFW/ns0gKbnvV6nNPBXO3ivbl5NS5izygL+PQjq9pWMBmw==
X-Received: by 2002:a05:600c:1592:b0:426:60d7:d299 with SMTP id 5b1f17b1804b1-426707cf5ecmr15020845e9.7.1720533682768;
        Tue, 09 Jul 2024 07:01:22 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:133f:fb1b:7fc5:f63a:ac6f:62c6? ([2a0d:e487:133f:fb1b:7fc5:f63a:ac6f:62c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab80asm2655664f8f.109.2024.07.09.07.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 07:01:22 -0700 (PDT)
Message-ID: <79774d32-f891-462f-b7b1-2a47c33463b6@linaro.org>
Date: Tue, 9 Jul 2024 16:01:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 2/5] drm/panel: boe-th101mb31ig002: switch to
 devm_gpiod_get_optional() for reset_gpio
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 airlied@gmail.com, mripard@kernel.org, dianders@google.com,
 hsinyi@google.com, awarnecke002@hotmail.com, quic_jesszhan@quicinc.com,
 dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240709134754.28013-3-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240709134754.28013-3-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 15:47, Zhaoxiong Lv wrote:
> Switch the driver to use devm_gpiod_get_optional() on reset_gpio to avoid
> driver probe issues when reset line is not specified.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V6 and V5:
> -  1. No changes.
> v5: https://lore.kernel.org/all/20240704072958.27876-3-lvzhaoxiong@huaqin.corp-partner.google.com/
> ---
>   drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index 8f03920e3503..b92082bfc932 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -286,7 +286,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->enable),
>   				     "Failed to get enable GPIO\n");
>   
> -	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_HIGH);
> +	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(ctx->reset))
>   		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
>   				     "Failed to get reset GPIO\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil


Return-Path: <linux-kernel+bounces-327853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F3977BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9551F21213
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6D1D6DD5;
	Fri, 13 Sep 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fp3h3Gja"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F51D6C62
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218595; cv=none; b=UZtIf5YTlaEUMHPON9uKjiRAerJdfU2YB2Mb4CtccpWt4HDMTsyvrt1RgYk8nwvpKTxHX/t96C9PjyZiAWlXTKge2sW1eEQiSv5N1UHvcqe2JJBZ6/d9H4Lz/nxnTIWt1ysDXU81twH46FZ2zsD0OBR71O/osF7k18wGg4dkJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218595; c=relaxed/simple;
	bh=Jy6svsZA6fXwPySHv6rd19aBAY6PLSFJVUdZS2DsVtI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=okvDaOIMMbCaNhzOGZnLxjUfMbZcmkzas3I/YvUJFzsKV/XinyNoYbbMneSNTtT1K//OhZ750BWaMR7RUNwGVxcVb9736wode2EbX4fMvzO+9YqTs0GJwsNwclxMOyo3GGObX+VuN6o27/LPT66LoqzHkFMn6m2w3Q7wX9nVEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fp3h3Gja; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so5786545e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726218592; x=1726823392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLdIqxoqb5KmhEW9QOZTVpHsg4gXaPJ+uFC0FI+XoTg=;
        b=Fp3h3Gja+1lT//YVkQcUW2ZDxWIGAG6sRR02mikXf3761KdabEr8xYQDb+J3hhjOUn
         MfR+864Aou3QvRZxKyjMLZ/hR8g9ACPW3LnN18yr9os6W5cEnGkQQ6zGFkltxcpifvsQ
         SEEk1EXOe/qmuhuamwzdLxgrmkVN0TXyFlnLLiG346c6bexcU/Leb5IrHz8N3A2ptJTH
         W4sKq9y1naNnJW6hZgwzye9BRYiojro3fRln28W+f+VX3O26ndoLQ1n7GwtOoCr33Sfa
         UgVGXcT+WZz19A+Gvhc5RaYAmNM5gLxbWDz6MO6XoiGEQcv2WRbEoT4VLrcyNONE0g9I
         zskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218592; x=1726823392;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HLdIqxoqb5KmhEW9QOZTVpHsg4gXaPJ+uFC0FI+XoTg=;
        b=U2RgoyHMAUOnovRLqyDClXtcwA4jB9tw6ZAe5zjRfX2/kLQasKWzl0NIUsvWOeOdSH
         OInXQRywXjMls9XdBZmtCY98/9I5UHTQ8Avgcvwp3JnBBPeVK/hgRES11w3zWhanSCXX
         s77cIUAW6J2ALR5DSPLOQnhr4G1RiaO7HqQu187AAgvVrWEUlPr8btT6WyCG3//ADvkS
         1itogDD6X2KrQdEo3/DBpBXW9AEuawMumsifPkRJZGWfNTigpDgCHfz03gP09ql97x1X
         1nrjbNmhX9jO++oWjj0vljNIrrK/UX2BLVs8HYjTtfIry4Qeb8chbaj34RjKU6WFi3bL
         GNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2zEIvK98oHL9VPoMeEEsvon2v8U1/ztI1NKYG96kkBwOgK45m6q00JwibPzsJKXDEfwI+2mJsWslpTTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi89kB4re1oFG8gFSDYeWdAJteJt6WJU93GOKEJY81UkUVxnnN
	WeepKisTMeiLcVPbu2Vdbayvxc+r6FF4QYMxepMynPrC9v7caisbmnTrvciLNHw=
X-Google-Smtp-Source: AGHT+IGMM6FHc1+2pXKvJHwC8ZMUtG/4vrXn88JK9L1ByLH/Gw4r9nZUG93Mmb+5ORn+tb2EgY4CGw==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b949:328e with SMTP id 5b1f17b1804b1-42d964f3455mr12537865e9.31.1726218592165;
        Fri, 13 Sep 2024 02:09:52 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054f97sm17501755e9.4.2024.09.13.02.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 02:09:51 -0700 (PDT)
Message-ID: <c79a615a-ed9b-4768-a1df-e64e2e2c2c48@linaro.org>
Date: Fri, 13 Sep 2024 11:09:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/1] drm/panel: sony-acx565akm: Use %*ph to print small
 buffer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20240911200125.2886384-1-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20240911200125.2886384-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2024 22:01, Andy Shevchenko wrote:
> Use %*ph format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/gpu/drm/panel/panel-sony-acx565akm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
> index 217f03569494..d437f5c84f5f 100644
> --- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
> +++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
> @@ -562,8 +562,7 @@ static int acx565akm_detect(struct acx565akm_panel *lcd)
>   		lcd->enabled ? "enabled" : "disabled ", status);
>   
>   	acx565akm_read(lcd, MIPI_DCS_GET_DISPLAY_ID, lcd->display_id, 3);
> -	dev_dbg(&lcd->spi->dev, "MIPI display ID: %02x%02x%02x\n",
> -		lcd->display_id[0], lcd->display_id[1], lcd->display_id[2]);
> +	dev_dbg(&lcd->spi->dev, "MIPI display ID: %3phN\n", lcd->display_id);
>   
>   	switch (lcd->display_id[0]) {
>   	case 0x10:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Return-Path: <linux-kernel+bounces-244346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0B92A2F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AB91F220E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0280BF3;
	Mon,  8 Jul 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6R8O/mS"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E37E0F1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442371; cv=none; b=WQk4pEamOW+YiMYmWNykLpDjgUimI3OMQiYKHMMTEn6h9WL9U17ZbwdrTZ+tHzu6UEV4EJdVTPX4uS1kdM7gwhNXNzUv5k47bG3HVszGOd4wDtPXK1OkCXJSDx4wiAjUpX/SnrtyQIp9qHXsXgSKex21TA+1b8dK4Clb9ItIMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442371; c=relaxed/simple;
	bh=Nws7U/x/qLfmVWw/mVS7Fim8+94vuM3ZzT8wjPEbUR0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=MKHytlIUftZKSZ6yAztibKJqnEt1XDamjuez5Z66LdN0FopoXhK0Sue2+cqZCtIqCuIKywiwmHO8NjzSCamkpJI8ZC1z47IoyMuZh4iLz+wWhFzrtxd0sS6qvKTdELqi36PujVP/iFbzEvV3c3usdaJGo6pQiGC+sILZ3kwVw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E6R8O/mS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so1712341fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720442368; x=1721047168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7DP3B5JCp9g16byzw5sfW+lU3wXnm8lYUI0ZjUS3To=;
        b=E6R8O/mSAV9SdmZXgZuzg4Ge2IeIw1LaYSr+pwjTK264mcTIv8LdTQsPa6xis1ZbHe
         aPfRjKoWKT2uorgpttPW+EjZT2HSYLUg6BjbMk3sy1hGnIXyS8aci26HqoHhoM55UNVZ
         ySWui3wuV/gERrmqUBy/7CnUfXyQ/w0ORVeuBvpJqmIGm7v8um3kc8Em2G0vf9DshVCJ
         2vnSSsoe8NKwkIV6uR61wSKsvlcFELaA1NXwAs5MrSJqnU4sG9piU5TErhNtP6W66ID7
         d/HmQ6laEZMj9Ur40uSZ7NNnVhYEk4nIStri5iBmAUtKpW8kEEKrUJwZcoJHCwZiwQVN
         W/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442368; x=1721047168;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7DP3B5JCp9g16byzw5sfW+lU3wXnm8lYUI0ZjUS3To=;
        b=bxVapHDdm6WXdQibtDgH3PfrrLFXVELLG5bE7rr7kIsUzCkfdIhAfcQYt2WPgfpMy8
         le9XwYiRNUz+NGTggDy3Hr33ZYwKtG6l/6D7qr9m4AHjr3bBrFX0413WUNoQkQT34XJN
         frqPELAmnElefWlg10Mqxctlyw5mWsZUVMtZ4C8dTcl24lxHY83AXxU7FFj2gJt9O3si
         gnsipUSGjYbLvzQ3PM4XpKbG2D3IvyaXBbfE3ocA4srddIrjAdOYDtleq6vl7YDvs5NO
         nHiFPJjvjOcHmlTnQWebvNjI6LVJqjUOjwt56sfPv0GUagaqHvLinAbav5tLUD7sHjFE
         CKVA==
X-Forwarded-Encrypted: i=1; AJvYcCXMdkDEUM+K0aA0qov70WcsM/0izNKJQ7ad5+/JlSJZZ6cIBQjoObW8JxCRVh02ZRI3vi2UxWksyhaRa4loWYu1+z7K0lMKgtN11MOD
X-Gm-Message-State: AOJu0Yz9CC/xArVJCDBI29zfNp+deWnAb1ENyOgp54gwkqXLtONmc6RB
	5WjjhKIZ9youSDAdejz6OphXhvb1FpKIimXD4QM+BRdTiluHAO4m5zLZjHFzRSE=
X-Google-Smtp-Source: AGHT+IEdrW9FoC/1zN+vWWOe7JF/qxC3DrqGqoBp1+DhNKzcWT6wtDi055Adp5bcaUJWtZI9liT4dw==
X-Received: by 2002:a05:651c:30b:b0:2ec:165a:2254 with SMTP id 38308e7fff4ca-2ee8edd7859mr75969161fa.44.1720442368231;
        Mon, 08 Jul 2024 05:39:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c? ([2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d6d22sm163122115e9.20.2024.07.08.05.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:39:27 -0700 (PDT)
Message-ID: <41d3bf66-620d-4a6a-9cd2-0358fffae2ca@linaro.org>
Date: Mon, 8 Jul 2024 14:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] drm/panel: himax-hx8394: switch to
 devm_gpiod_get_optional() for reset_gpio
To: Manikandan Muralidharan <manikandan.m@microchip.com>, megi@xff.cz,
 javierm@redhat.com, quic_jesszhan@quicinc.com, sam@ravnborg.org,
 airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240701085837.50855-1-manikandan.m@microchip.com>
 <20240701085837.50855-3-manikandan.m@microchip.com>
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
In-Reply-To: <20240701085837.50855-3-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2024 10:58, Manikandan Muralidharan wrote:
> Switch the driver to use devm_gpiod_get_optional() on reset_gpio to avoid
> driver probe issues when reset line is not specified.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx8394.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
> index ff0dc08b9829..d0e44f1f85d9 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
> @@ -487,7 +487,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
>   	if (!ctx)
>   		return -ENOMEM;
>   
> -	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(ctx->reset_gpio))
>   		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>   				     "Failed to get reset gpio\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


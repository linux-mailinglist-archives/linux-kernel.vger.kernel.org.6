Return-Path: <linux-kernel+bounces-203821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A61398FE0E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D0E1F25F67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD813C3CA;
	Thu,  6 Jun 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbsg0Gma"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233075C96
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662363; cv=none; b=lnz/o6n4RXECXUJW7L0UfOdSx/5s9hV6NR9toqKbTpA9QxEIaCPo9RMUDVCRR+jSlDC0CedmfrFwDr85+ue69i6glT8hZzk0wQBG6RWaMFBDxGT7UABqZBc4cnYOoNe54kvC7iFQC4SYXd55giyisQ/pE7gDCRVUMxkQRw1YVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662363; c=relaxed/simple;
	bh=k7fDFFeeLcuoKb7S6VkRyC0GIm3qXuo6E5I65rY7fp8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NRa6wpIImVuvFNFWKf5EJ60xUyRp21GFBgJzk8VedMNy4XQ1h+OMvi/XgI0gtClXhsM2lKz5An5xRu3/HlRU+EX7lhbALLwyRteLV4vmoRk+lP6aaKfXJ7udRqNFBGjl1RPTTzX0OO5qWDrtsQRL/ezD8PLeKIr2+J0rgSvEff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fbsg0Gma; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4214aa43a66so8489375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717662360; x=1718267160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIK7ZRurCp3VUMKrCmmBFEo7JzuHyJlxiXupFh9itNg=;
        b=fbsg0GmaQkdfAUPvYr+/yWg7s01E3QqX32jqmSIhb4Gpn2C+tFXbwsZMQX28H1BeGR
         bMfDvJUSshIUvpt0jtxdUQkqJMtBzwOjhvRbZGGv0uwPcBh3/cfoiwajMn0FoOa5NhoK
         1CtGNE+Ywmavh6FF1o8vPcpm1/tCJjkHGfoD/vhUh32/2g0HjAMkHsS1YZDU3cu7XQD7
         A/T+G7AZ5uLbTmr1y8JC0RfFDlBqP02Ve+ehorvK5d0i5UOoQsZlGm1rh5LXWcdcEEuT
         K9JE5vo6htkeO79MOTAQH9qzuOjEV1+LI2Z2WcpQ1HfYN7s3tCaEYF9phSO4FOZW7WVZ
         gUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662360; x=1718267160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIK7ZRurCp3VUMKrCmmBFEo7JzuHyJlxiXupFh9itNg=;
        b=JWiCJxM4kz/rpZoEHOQ7UOSI2s3DUzQzZSIXFHkUNDpE/rHM6tFBFpbmYEVS5D6heD
         ZknJbGsI+qFtYXGjguQwlbkMQEtgHRwWppG5+QjZXqLyzLVGnnmMZOb3fqyavDHA8YrA
         4QtBrVCVlAn3fObaIeugZTnu68UpVXUTKE2bIzq2vES3doEMlK3PZGg4fEsP0NaYzEY7
         cihORyk0xtINPW2eic6VJ2t4InKfEgmb4JMg5S3457De/4lplR3i6M1d8/y/5kgF17D3
         bH3rbcbARBVFJmG3rDIqjs2FUIc0KFPMTSPhhKoYi45C7ZIGrDiiZj5f+k9G0JFzEvly
         DjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5DwI12VHIn1Dl5AbOsn69xFDIcoHKPlz/Rhp6clb7qk7wvqfmi02P4OX/DU64ZuoUc5vFgP8I0X7H6rIWl2/D5QRRRlrEzYto+2bo
X-Gm-Message-State: AOJu0YySaMkj8+q5OEAxtbJ7hruKccY+8jXGW4Vf1Q0S0e6UL36ocswb
	2n+Vo2GnTubo5rX2Yh1sAvJkUE+wv9pVRqHQbAOfduvQj7z9xyueXDi7PdME03k=
X-Google-Smtp-Source: AGHT+IGD8CDRoGr7gLwFeA2KRHdkZI2ybG//UzckD4ZVgnplhUKkVBRsXPMX3dKrY8nsGsU9Tl8Vag==
X-Received: by 2002:a05:600c:4592:b0:41f:e10f:889a with SMTP id 5b1f17b1804b1-421562c6d2amr42212735e9.7.1717662360385;
        Thu, 06 Jun 2024 01:26:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2? ([2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f64fsm47751845e9.47.2024.06.06.01.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:25:59 -0700 (PDT)
Message-ID: <52d8af51-1af1-400e-9793-2337bd1ff4ea@linaro.org>
Date: Thu, 6 Jun 2024 10:25:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] [drm/meson] meson_plane: Add error handling
 v2(re-aligned)
To: Haoran Liu <liuhaoran14@163.com>, maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231129113405.33057-1-liuhaoran14@163.com>
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
In-Reply-To: <20231129113405.33057-1-liuhaoran14@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2023 12:34, Haoran Liu wrote:
> This patch adds robust error handling to the meson_plane_create
> function in drivers/gpu/drm/meson/meson_plane.c. The function
> previously lacked proper handling for potential failure scenarios
> of the drm_universal_plane_init call.
> 
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>   drivers/gpu/drm/meson/meson_plane.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index 815dfe30492b..b43ac61201f3 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -534,6 +534,7 @@ int meson_plane_create(struct meson_drm *priv)
>   	struct meson_plane *meson_plane;
>   	struct drm_plane *plane;
>   	const uint64_t *format_modifiers = format_modifiers_default;
> +	int ret;
>   
>   	meson_plane = devm_kzalloc(priv->drm->dev, sizeof(*meson_plane),
>   				   GFP_KERNEL);
> @@ -548,12 +549,16 @@ int meson_plane_create(struct meson_drm *priv)
>   	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
>   		format_modifiers = format_modifiers_afbc_g12a;
>   
> -	drm_universal_plane_init(priv->drm, plane, 0xFF,
> -				 &meson_plane_funcs,
> -				 supported_drm_formats,
> -				 ARRAY_SIZE(supported_drm_formats),
> -				 format_modifiers,
> -				 DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
> +	ret = drm_universal_plane_init(priv->drm, plane, 0xFF,
> +					&meson_plane_funcs,
> +					supported_drm_formats,
> +					ARRAY_SIZE(supported_drm_formats),
> +					format_modifiers,
> +					DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
> +	if (ret) {
> +		devm_kfree(priv->drm->dev, meson_plane);
> +		return ret;
> +	}
>   
>   	drm_plane_helper_add(plane, &meson_plane_helper_funcs);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


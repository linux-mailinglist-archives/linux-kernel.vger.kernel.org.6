Return-Path: <linux-kernel+bounces-292468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611C956FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A20D286558
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFF16C87B;
	Mon, 19 Aug 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0uYHoQ7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E552335C7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083720; cv=none; b=OnepbTK7ba2MWntxifN/RyKT3o4rBLqle0shlIUsNyXg77jocRtdnZO8Adq9fm4OsVPZFMzdL9gVGEMSe0KwHfpOSKP9kNcrz+6J9l564Oy6YMHDeBHgKaHpumN+tfj42nRp0h8gv4L2hS+SuV5IrvzCWmtaw5PaF8Nz16Y8My0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083720; c=relaxed/simple;
	bh=bylvFftKS/DVYzpK15b6nBMQQOhh1cso9YgFzNNXn34=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JgtqhnzXpioM5rvg89xyHih95BjI8SIQs+Vn3njQqN6w/kaIAEp3N0epfa3AzCAPOMhtozRQfThwp23nwt3AQvQPJtGWBi4egGrcfMhvnvUXowZPHaSIhgapzGh2uyvKPNYBkL9IfLH/Xpaf8bPLb9cGgs+JG4PXzrcIDAj0D04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0uYHoQ7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428119da952so36078275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724083716; x=1724688516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZXB9eWC3jaAHU2DUNdmRkIBaE/QcD6ULIBMGv3bqxc=;
        b=v0uYHoQ7Xc0DRUXpF59pQtBWlee+vx1BO7iMIL94t6VOzoQUJgjkhoLJAJ5ZTV7prz
         ONp3y8X2FJXQmr9cp3i9h9GpO9/9JKbR/6+9CaDzcrGBCmwQOJM0G0xMFZoy+oMguiEA
         rh4eT3vW5gptU4aIsH3WW4SlBygQsOGDKoWBNdn8bQTEIwGoPY0pyHjqb54dP5UzMdT6
         Y+WZNavQNVAaTWrAvVmIV1QPwbyVOhrDKWv7BM8QbFj7TytcM6729lgOc8U1Ahb5PJKt
         oZIjY2Vp4xakbpygJr8CRgdnUurLTMdyQfcN2jINb5viKRHWT4yjX6OXJnvEZ1cbgRGH
         Mb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083716; x=1724688516;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZXB9eWC3jaAHU2DUNdmRkIBaE/QcD6ULIBMGv3bqxc=;
        b=K4Pgp6poUjxlTyAemdrahXJ4yGZaZZ1+kKJPwITvpSrw3PyBo3KpJD8ne3FrmnjhR3
         4eLEAf02BzVuNWbuQ7b0sB3OZ8yfm4BB/slmB/HyFfgxajFk7Slp/x4c/75N9RSeZ4Od
         /PKc5C0Bc/8Kax7V+MAZi5fyL2U9JGbH3WHfUm/WajcxAQjKjlBDGRp88PjRksHSQM+u
         czyvX/NFlnN5Sfk06F5GnPOQa2m0RLaCb5SmnWjh+JMpko8zQkYPpzROiRTkuM+Guxe/
         1bsGgicBpryPZ+AJ4Km4TVgvVcekOMwHBPjdS7XeaPypPwBXw6onvFcGU+MSCD61Hmig
         7xUw==
X-Forwarded-Encrypted: i=1; AJvYcCWJjQr+1UVtQZSeaUrQ23GoFjdF6L9Z6EkRzbOkgbIXJFcvdTwmNCehGWeSpR/8NHk0smbFWWYYy0mLibEtHf8cMBJwPO6vUtqOQyDO
X-Gm-Message-State: AOJu0Yx8B03LOZ0uiwgi7CqbSUFRkDRsE92/Nx7EGi5E7cqAubvxbhKF
	6yMJqpVF/00eAQni+fISOHd4/8BfhlfQDHqFJtQ98qcYgc/Nd8KgM2Tz9MEP6KQ=
X-Google-Smtp-Source: AGHT+IEctf6m+H+GvqS9ocINagd6WHDY07QHzWWDGizaBipSBKg2CM+6kL3bWVQiaT3seaoGIZrXQA==
X-Received: by 2002:a05:600c:4445:b0:426:60e4:c691 with SMTP id 5b1f17b1804b1-429ed7891demr73947145e9.11.1724083716047;
        Mon, 19 Aug 2024 09:08:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed785708sm114205685e9.37.2024.08.19.09.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:08:35 -0700 (PDT)
Message-ID: <8d49f427-a0f8-44f4-bd46-86fbf385deab@linaro.org>
Date: Mon, 19 Aug 2024 18:08:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/9] drm/meson: dw-hdmi: split resets out of hw init.
To: Jerome Brunet <jbrunet@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240730125023.710237-1-jbrunet@baylibre.com>
 <20240730125023.710237-6-jbrunet@baylibre.com>
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
In-Reply-To: <20240730125023.710237-6-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2024 14:50, Jerome Brunet wrote:
> This prepares the migration to regmap usage.
> 
> To properly setup regmap, the APB needs to be in working order.
> This is easier handled if the resets are not mixed with hw init.
> 
> More checks are required to determine if the resets are needed
> on resume or not. Add a note for this.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 5cd3264ab874..47aa3e184e98 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -581,11 +581,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>   	/* Bring HDMITX MEM output of power down */
>   	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
>   
> -	/* Reset HDMITX APB & TX & PHY */
> -	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
> -	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
> -	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
> -
>   	/* Enable APB3 fail on error */
>   	if (!meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>   		writel_bits_relaxed(BIT(15), BIT(15),
> @@ -675,6 +670,10 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   		return PTR_ERR(meson_dw_hdmi->hdmitx_phy);
>   	}
>   
> +	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
> +	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
> +	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
> +
>   	meson_dw_hdmi->hdmitx = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(meson_dw_hdmi->hdmitx))
>   		return PTR_ERR(meson_dw_hdmi->hdmitx);
> @@ -765,6 +764,11 @@ static int __maybe_unused meson_dw_hdmi_pm_resume(struct device *dev)
>   	if (!meson_dw_hdmi)
>   		return 0;
>   
> +	/* TODO: Is this really necessary/desirable on resume ? */

Yes to reset the HDMI controller to it's default state, not sure if the note is important here.

> +	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
> +	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
> +	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
> +
>   	meson_dw_hdmi_init(meson_dw_hdmi);
>   
>   	dw_hdmi_resume(meson_dw_hdmi->hdmi);



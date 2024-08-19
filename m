Return-Path: <linux-kernel+bounces-292446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D437E956F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525E31F22A12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500981741FD;
	Mon, 19 Aug 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgT369cS"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FD16C841
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083339; cv=none; b=fU75R6Cc1PjS3sWTrj7XMa1wiQwZnizMkkjwQeZBkSBmr1oUd1mXKmOL42vn+AxgYyANSCp7tEBGqXE2oViTm1rfsOFHipW9KtZbNc67LswSHSqC8VucVLjSue0GVK2oWQqnukMxlULStGr/m3Qh5a5hfg9cIFJf0vw++jlPqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083339; c=relaxed/simple;
	bh=hkdJs62nU8SSglKaRIAIHUOKAp6IG+I6ECpk80RAWfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MxuoRbcrKHtguxQBOwJDh5dNV5LReTcj9vUmi+UxCzWpyuYGbJGzc6dJcbpEb86kzyT94Gnwcv2hsIj5r//YHVxbCJz/brL5Z7a1Ck7BzlHtfioZ6qDRi1w1dDLxOKiL8vktSeeJOICRZqam/Eo0u3LKMG+qLgZrM1s05Jj9Myo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IgT369cS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280c55e488so23670635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724083336; x=1724688136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2H5KgBgMPKBbBbgbQMaqWtynMas0Paslh5q5xHBjrg=;
        b=IgT369cSSbkPco9NyGfGhbSjprEXzHIq9OlSwlegd68zr/1S10cPRYdavs2itvWomR
         T1xiJPlegl1liX9m5xGqDEZXUmubAgLEKVL6efygpPR19oMzGUp+qNWEW1cpPpvQMUz8
         GQJTHprG9ObWdOnGZ+frF6Y+M6F25ZvrhVzBATUqUj6Ngtxh/7GXUcZ5pyrubJv9mAkM
         f4s0PJt30xFCMOpsOypT3bUZO5PYnn/xYh38VbSsTjGQBPwJ0FMG8WfcnCFWf5WWBH4G
         Q4KaJdEoOuw7ffF8kPO0vtiMmYa6gcfyFBpjv8SOlBKK6zRI3Q8ya+9hhQMYc1H4SgUW
         32qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083336; x=1724688136;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2H5KgBgMPKBbBbgbQMaqWtynMas0Paslh5q5xHBjrg=;
        b=OUfNBZcP0ysuh3uIowaOi24pc6YtYcnPh/26Quf4nxidBG0axfO/fp4NTOY8GSfLIs
         4sLZY68MKODxxpniSjuW49ahmpTH8su9TBVDtIDHppl6cNSA36sxQgGDz0ue5UMYLua+
         txZJKDgnn+eVd5W7aLNbbrA8Bt9sqmVrHUmk72gWnla2t6ntSJYBbbftl8YVpp6iwgsG
         aGZ+BQ60MYl88EJT+EcDpme7ROsZS2QAHhuH7EXLEbIoLeS9urffGMFw9HAJx7jf+2t2
         vl6OEt9f3fc3DeExY+hoxDbmItgcYrDrzixwfxCfUyiHZjYHL+mxEZmbZWt4T6BKgQU1
         OPVg==
X-Forwarded-Encrypted: i=1; AJvYcCXLKbsgZ2DG6Md9AJSrVR3k6UoMjdpm+YEblwZlwERQPR0Fnz7MmKZqZn8cPTn7yjHkMs7940mfG9t5AqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc59IFnyxkLKQFD0y/dpnX0H7b/idyislKIXOZYFFhzlT2YNwH
	XZjghmFDZJ7KYeRUS7JR6e6LgwzultGUAXviqm7PAIB1FsfimvUAwh+byfpuz8MsoVUn82EBbiR
	M
X-Google-Smtp-Source: AGHT+IEGipZBzPGNFeIKPltBTWern8DK1f4USLWgrkfk2l8Nz1MjsA6Et4venFozTHGa3oZSR1IomQ==
X-Received: by 2002:a05:600c:4fc1:b0:424:8be4:f2c with SMTP id 5b1f17b1804b1-42ab56b7c40mr601885e9.2.1724083335320;
        Mon, 19 Aug 2024 09:02:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed79d9a7sm114346915e9.39.2024.08.19.09.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:02:14 -0700 (PDT)
Message-ID: <4ecb4d18-026c-41f9-b5ab-ae9dafc20887@linaro.org>
Date: Mon, 19 Aug 2024 18:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/9] drm/meson: dw-hdmi: use generic clock helpers
To: Jerome Brunet <jbrunet@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240730125023.710237-1-jbrunet@baylibre.com>
 <20240730125023.710237-4-jbrunet@baylibre.com>
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
In-Reply-To: <20240730125023.710237-4-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2024 14:50, Jerome Brunet wrote:
> The Amlogic HDMI phy driver is not doing anything with the clocks
> besides enabling on probe. CCF provides generic helpers to do that.
> 
> Use the generic clock helpers rather than using a custom one to get and
> enable clocks.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 36 +++------------------------
>   1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index bcf4f83582f2..2890796f9d49 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -619,29 +619,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>   
>   }
>   
> -static void meson_disable_clk(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
> -static int meson_enable_clk(struct device *dev, char *name)
> -{
> -	struct clk *clk;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, name);
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "Unable to get %s pclk\n", name);
> -		return PTR_ERR(clk);
> -	}
> -
> -	ret = clk_prepare_enable(clk);
> -	if (!ret)
> -		ret = devm_add_action_or_reset(dev, meson_disable_clk, clk);
> -
> -	return ret;
> -}
> -
>   static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   				void *data)
>   {
> @@ -651,6 +628,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	struct drm_device *drm = data;
>   	struct meson_drm *priv = drm->dev_private;
>   	struct dw_hdmi_plat_data *dw_plat_data;
> +	struct clk_bulk_data *clks;
>   	int irq;
>   	int ret;
>   
> @@ -701,17 +679,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	if (IS_ERR(meson_dw_hdmi->hdmitx))
>   		return PTR_ERR(meson_dw_hdmi->hdmitx);
>   
> -	ret = meson_enable_clk(dev, "isfr");
> -	if (ret)
> -		return ret;
> -
> -	ret = meson_enable_clk(dev, "iahb");
> +	ret = devm_clk_bulk_get_all_enable(dev, &clks);
>   	if (ret)
> -		return ret;
> -
> -	ret = meson_enable_clk(dev, "venci");
> -	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to enable all clocks\n");
>   
>   	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
>   					      &meson_dw_hdmi_regmap_config);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


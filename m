Return-Path: <linux-kernel+bounces-292443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C2956F95
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C372B268F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F8C16BE12;
	Mon, 19 Aug 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rzfl2Av8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBE54757
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083298; cv=none; b=IVwPf5Vchg6Hy9e57bLL+i0zJmGu0WELLslJUfVOZNMfbBX3qIbkrV9fF4uoCKU5oqFDOi3IzZY5BHj3Mg9zvdqY0aP0PWXvlG7x14CTXFuKTmUNi9NVZTFiKIDhY7EmVqTF/YNFbcdpx4/CcEtojVWkR/hE4GTe0RNOmeL/x6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083298; c=relaxed/simple;
	bh=05+GGk+l5RqAcgzobFmZfRZva40wKcxbTcVXPtw68yQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MDyMcNr0yO5NE4Id9ZR+1iN/I7OFBQcPGKIR6ir5PCRK16udE70wlr/SxAUS1wSVLmFutedvKdWtbUE+8QYgWN6Vmf54XD2+NGQNNwPn1gxNIsOuZNopJClFcIoDLSIZuDxXGGmyil3Pp66VbNCZFz5fkJlgyBUTmoFuk0OY8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rzfl2Av8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso36728435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724083294; x=1724688094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3inI0ECOW5fOemX4PH/fT5PDp4zYtzMO9ksOGbeSD10=;
        b=Rzfl2Av8kzoidMyGxyikQmaXrWLfnwrYdocXvMCkUD/2qcxX1zBUGqFJvV5sD7wMmS
         h2iqtzoGURfQq1egydF4EzB1dgovnlbpb+JbXsb0WLJtVPnBJhQCXiTDFwgZKHslHA5b
         5Z7WT8pKPNpY5eD84Ir989ELyXz9o9xYDdxXJFs8AjDZhpznSbUbXMTbqNWXreND05LG
         e85b5FVOljSSK0OHkIb7YCKdVTi2VnZL6Z47RIE0F0wsWpi8PRKlahkVnzpyloaChhb5
         gBPDuex5p/Cv5ssAKx39rweZiGLowGUTNqq1PGOP0D7PjBYXbdWYNMZtnG8XtQ04NqgG
         +aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083294; x=1724688094;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3inI0ECOW5fOemX4PH/fT5PDp4zYtzMO9ksOGbeSD10=;
        b=Anj1ufuoNujW9sx7lQw1X2zvYRhUfuH56oMByv7V6l9Z3IiBRLWSej6VyEAclJo8WG
         3YW6t09JxQfpyq3HfSQibcNAP90txeVPTbGZogIApv26PPQqFJHC/Sox1qKTU8IU+6jp
         +fvDf06Rbf67HI5AghKOv1Rr2VcMhgIivm9//PUhbBb5IkNqlCRBPIdYC9iPw903i3ip
         D/IDp3dkmGZniWxqFsdReHcFpJZkzeF/dg8CaiIoBzPylKlx6q1k/OO91FHI1MwjXW5w
         SrQsEkCFdXVguQgJbPjpiJupHS0ZVN4q/0TLvOaLcc/eFSxAzpqzCik4P7jpvJnIYNvI
         WVmg==
X-Forwarded-Encrypted: i=1; AJvYcCVgBi5yUYSln3VqN9fNw8xS1Y0I0LVu5I2KxfhO1AU+DEo32NkpD/FOjB+gAZRzOdMFDILZMbqkp0RrzwZopLaaARCX+JNbazFqEHtE
X-Gm-Message-State: AOJu0YzU/2bCrjsKL99WkfBWskXMI+xQ0ZXP0DxqJK2U9n1yOpdxg1nh
	ySmsV1ukUNpPoE6f/L2uEpAMlEhtcSFKcrjq8mzZR0lCRF1OW3huBQYP+AI1ONY=
X-Google-Smtp-Source: AGHT+IHqi+ynv7PNIGrSXPrynHUL4/QS/orobgoM3PsUljd0gTqOfknAgwMfnnGvbolV5NilUOhbng==
X-Received: by 2002:a05:600c:4746:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-429ed7f9852mr65754795e9.37.1724083294044;
        Mon, 19 Aug 2024 09:01:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed784726sm114095855e9.35.2024.08.19.09.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:01:32 -0700 (PDT)
Message-ID: <5c72008c-65b9-4013-bbed-f5462e27b9ac@linaro.org>
Date: Mon, 19 Aug 2024 18:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/9] drm/meson: vclk: drop hdmi system clock setup
To: Jerome Brunet <jbrunet@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240730125023.710237-1-jbrunet@baylibre.com>
 <20240730125023.710237-3-jbrunet@baylibre.com>
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
In-Reply-To: <20240730125023.710237-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2024 14:50, Jerome Brunet wrote:
> Poking the HHI syscon is a way to setup clocks behind CCF's back.
> Also, 2 drm code paths, the encoder and the hdmi-phy, are racing to do the
> same setup of the HDMI system clock.
> 
> This clock is used is used by the HDMI phy and should not be set by the
> encoder, so drop those HHI pokes from vclk.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/gpu/drm/meson/meson_vclk.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
> index 2a942dc6a6dc..bf5cc5d92346 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.c
> +++ b/drivers/gpu/drm/meson/meson_vclk.c
> @@ -813,14 +813,6 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
>   {
>   	unsigned int m = 0, frac = 0;
>   
> -	/* Set HDMI-TX sys clock */
> -	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
> -			   CTS_HDMI_SYS_SEL_MASK, 0);
> -	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
> -			   CTS_HDMI_SYS_DIV_MASK, 0);
> -	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
> -			   CTS_HDMI_SYS_EN, CTS_HDMI_SYS_EN);
> -
>   	/* Set HDMI PLL rate */
>   	if (!od1 && !od2 && !od3) {
>   		meson_hdmi_pll_generic_set(priv, pll_base_freq);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


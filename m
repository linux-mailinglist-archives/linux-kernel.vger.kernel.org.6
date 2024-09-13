Return-Path: <linux-kernel+bounces-327762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284EE977AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC5FB206B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCEF1D67B6;
	Fri, 13 Sep 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfH2ByEJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642A187334
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215611; cv=none; b=ObJv/pIIZ1b6FM1tiz3+/v6V9BboxWLv+8VAO1n2JC8n0jCnzDCBSP3cmlB5fTjPbjZB0NJSmdpY+NtpCBYYlUwu9/ipybIMO4CMQ+L5VrYYTPl+N/MXIG6yMAaKA6cr8/VRMpYIIj4YSCO5Nk834lOHYDa+i4ikw0TQbZ7lDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215611; c=relaxed/simple;
	bh=1cK20s7/DsjaK2SXrFXsbTHXxwjdV3hlYDkPzK/dV4A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TtqeZL1bn5l/5Z0fYfoD/nwuwj5NqZ+1ruSBuxJEGxqEro/dvN4OYheA2HsCvg6dTwbahbgTylLMCR66qv3vpLbbee6Vp8FfoLUxkf0uDylveD+gSvV+1Ivhna93poEv2zyMXgHMGtgUVvg9GjQpGjqfc0xjZ1I58wQ80njMLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfH2ByEJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so16889515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726215608; x=1726820408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xj60F/vgTipeL0hqo1HxxLaiGJUpWyE7XptNLkLY1k=;
        b=sfH2ByEJq3wIcT7r5XPd4kI561N2G70YAx76Z73bzVpXBiZbPVggWzJtUWfCWSlk3+
         t+Q8KvEVZAcr8P5H0jPpaIGL4J6lRMZEOJ3Nq2TcDuNJYxzPxHaCOv1jk+0GWj4AevKF
         IBwUiyVy3gtWOuJu9o9pwjd+rCPwLrGQk9q7MFZL/71NxpPqYhP6s6FQC0VbTqlEHnam
         +FMw6kHXCmSGhNeuDU4nPC+eS9JY3R/A4l5W5g88yjiprNXZXR8qH7fOP/jlbEju3Gsc
         7RvMawBB3MErq8hpQ3MZZzuB+lIRlh7E6n9NWsghQcogw7KkLfGRRjC8DxMGytgf8fxP
         P2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726215608; x=1726820408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1xj60F/vgTipeL0hqo1HxxLaiGJUpWyE7XptNLkLY1k=;
        b=M4CQy+TiJ4d6tM22wghWNTskJllFcUACytnmTgeKLO9YFQmEpay+ewNGZKc6pnBsGN
         xUYBmsjUIToI8stKAbwLTsTKEKKeVFrj5X30wyTGGDsXhfSBIM8E3o3jDkfSLl41Bumt
         WYk+/nlgqNY8/M2fKF0AEWR6TDUGxNsDqZjkKlclc4VR4lAbcLpyAnyk6UozjJJqqMhE
         rFbPH5mWHsGvrqpWT4NjZaGu6xOR38QdGWWbSaKUnd0/PwKyjBhrCr3BadPrWHfQYanQ
         M6Fw0hhETYEpVIT28u244y9J4zlNXYDOWtMPcwJV7MxE4Ytz06ZQ5C4wePuavdnzNHFS
         Hedg==
X-Forwarded-Encrypted: i=1; AJvYcCXhb/xNNWyYBGuIzPxA4+Fe0uhuNYmeGoyRSfxbpKqi9B+QfJgm2XXEnwyZXqzHaKHKexaTGB73Wyu8UFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpw+tPRosyhvpAyC78az4g9fZPs0E+WRAfXevEmzGkvYf+s8Y
	orldbAhSK88/tURCwv/qF3zE32SAQjK51tm+N9Bng7mE/g/c7cVG7ntJ7q1FSbc=
X-Google-Smtp-Source: AGHT+IFeNwe9JE6SnCZa7mE9nYY3JFjm89tRGwX5GCTUN5zeAxBdbp8mQ9PIRuX4eone/RakGWhRhw==
X-Received: by 2002:a05:600c:4e10:b0:42b:a9b4:3f59 with SMTP id 5b1f17b1804b1-42cdb529b15mr44857185e9.14.1726215607430;
        Fri, 13 Sep 2024 01:20:07 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b16c9d7sm15618395e9.30.2024.09.13.01.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:20:07 -0700 (PDT)
Message-ID: <fa108de3-66c3-4dc6-b241-06ee535198f1@linaro.org>
Date: Fri, 13 Sep 2024 10:20:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/5] drm/fsl-dcu: constify regmap_config
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
 <20240908-regmap-config-const-v1-3-28f349004811@linaro.org>
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
In-Reply-To: <20240908-regmap-config-const-v1-3-28f349004811@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 16:21, Krzysztof Kozlowski wrote:
> Mark local static 'struct regmap_config' as const for safer and more
> obvious code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/gpu/drm/fsl-dcu/fsl_tcon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
> index 9eb5abaf7d66..49bbd00c77ae 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
> @@ -29,7 +29,7 @@ void fsl_tcon_bypass_enable(struct fsl_tcon *tcon)
>   			   FSL_TCON_CTRL1_TCON_BYPASS);
>   }
>   
> -static struct regmap_config fsl_tcon_regmap_config = {
> +static const struct regmap_config fsl_tcon_regmap_config = {
>   	.reg_bits = 32,
>   	.reg_stride = 4,
>   	.val_bits = 32,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Return-Path: <linux-kernel+bounces-327710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF3977A25
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11846B2702F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473641BDABC;
	Fri, 13 Sep 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ev0Z2D+Z"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82761D52B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213419; cv=none; b=ls4IL3TRVzd3kTcyWOjO0KMbLb1I9hOwimHxE60CNBh9K1KmeKX2rcqV0e/RG19GDnVD7t9X2MV+YVL5srggSSBcB2E3KArkhEGchxj68n6SJuCmGy60uUin4TCpBG8T5AIj3gFmTvqWeQ11771BnB0AlHuQqg2agC0iFNhp//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213419; c=relaxed/simple;
	bh=q6yM9xYXlYSAVX0PvLMRD2Z9Xv8g2eB5DEBYkXtQ1NI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GkGgsB9gK6vzGuRwLH6xQqhnKIOh4RtmyS+fZxcNZa2e33X2/C9W0LTNBY8T1hUPFV+dgKnIF8Q8ZdvQMKud1URs4JqckMpuztKCcmLR+tljXEC7djJ1kl5f9SKgGzNRTjh37y83I9ErBLjzAb7japPwdbiSW3XmCUc236bvqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ev0Z2D+Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so11053045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726213416; x=1726818216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UD0ZRMJDFziIkPb7Qo198cjwAQhiYKjw+i6aTIIE9aM=;
        b=Ev0Z2D+ZkSDSvyaUyCvg7aEWatgajqdddxENGuKtA7fbgaqmikwYPoK/YvIE2TxqEM
         R/l6qrCCUIBiIguUpV6o/Pbueq6p3BG9M08ah56Mel2ahHo/5+6GcHiBSuO4JLOe5+rC
         zWSnHgqL2CLFRGSnIOawnoYxAMs/J3CVH5mDziIL1piuBpom5ulwuIUH9NocHe/i74Wz
         ax96tX/vOEFguN0qDS+UmKtKsYIdW8XzgWnTMbrKN/pWbJYfLgTpCZ317y/twq+0rnPS
         A7JC2IgLUrPBYZh49PlZAb4MaXYzQ137T6Twi++3IR4lJHpUl3KSpTXOK5OUyXAK8nyF
         Pu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726213416; x=1726818216;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UD0ZRMJDFziIkPb7Qo198cjwAQhiYKjw+i6aTIIE9aM=;
        b=fa9JZRJt00RT3b1b+yNLV5xh/O3PSJVNAcRWw2z0eiKNzSb9Zu13Fxhcs4MOyStVeq
         yqIIrqm3gte2pSiDgrMyg+TICfa62bqemW70IeOlnJD7ILlgJXTrBpKhw1aBWsXcXIl4
         rzlaXofN0cFDcUkkWFO+Ee8bKxISfu366Fy74zMCDfLoeIYUc2JhsW9JYy4jcaqdhk4A
         kXOGkRDKLrsCDQ/yyrdTDigUiZ0uQVeEKDZc9DofvezvwnkJTC0nF4hRhzcILQhButg/
         AMlgykSWyMCcAcpzUjKyBsQexM1Z9VFow6PsCVM4rBQmuLCJ7xaFEPbc9fij6AwdhMLj
         Q+ww==
X-Forwarded-Encrypted: i=1; AJvYcCXHNsmv2Ah88BSv0wRhyWQAKimmi702mii1Ywri9Fmb8cVcXYSnaIGBLBCbk7pYz80RxHkG8UVQJwK+log=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOlCd5kyuGlTcVWyrqLsUwGnbpoWQ1qGNCtLlDgTBrRUNagWX
	F55/pv8eOehGsHQG7S0MxqzstZxUc6+Ss+1rnXsCE1Cieck7O6wQ7YRlZRcsEjY=
X-Google-Smtp-Source: AGHT+IFQpT3+WgWnD0oEwiLVuaeMarSuiM8nnrizagehr22tYPl5NPh/54KJf2rrqFtneqlFLhXkLQ==
X-Received: by 2002:a7b:cc8c:0:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-42d5e245609mr12459585e9.10.1726213415845;
        Fri, 13 Sep 2024 00:43:35 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895649728sm16037309f8f.16.2024.09.13.00.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 00:43:35 -0700 (PDT)
Message-ID: <e455aac1-d7fe-47a3-b3ec-e382b2de9b82@linaro.org>
Date: Fri, 13 Sep 2024 09:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/5] drm/bridge: ti-dlpc3433: constify regmap_config
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
 <20240908-regmap-config-const-v1-5-28f349004811@linaro.org>
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
In-Reply-To: <20240908-regmap-config-const-v1-5-28f349004811@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 16:21, Krzysztof Kozlowski wrote:
> Mark local static 'struct regmap_config' as const for safer and more
> obvious code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/gpu/drm/bridge/ti-dlpc3433.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
> index 6b559e071301..a0a1b5dd794e 100644
> --- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
> +++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
> @@ -94,7 +94,7 @@ static const struct regmap_access_table dlpc_volatile_table = {
>   	.n_yes_ranges = ARRAY_SIZE(dlpc_volatile_ranges),
>   };
>   
> -static struct regmap_config dlpc_regmap_config = {
> +static const struct regmap_config dlpc_regmap_config = {
>   	.reg_bits		= 8,
>   	.val_bits		= 8,
>   	.max_register		= WR_DSI_PORT_EN,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


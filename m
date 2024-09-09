Return-Path: <linux-kernel+bounces-320975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D409712E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D2F285E56
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253201B29CF;
	Mon,  9 Sep 2024 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEN+7gAN"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B08F5A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872683; cv=none; b=eM4zUl0aL0eXDnyrw1vOmZWTAOirE3QIaBKC5ZoEdSMOb0poTJDS4M38bVWIeZCdB67N87Ydn/h/avlrxj7Q3kDvCDqJifkGDDdFjJkaVjp8dmaZ1Ck0cVZxb3ZgWESfUzOZ2pIZ6+THq+G2UnJzkA859RbmvJAGqfOsvdVOK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872683; c=relaxed/simple;
	bh=Rewu0rWpeaq9kuSLDUzF3u43GVDwgPHTp7/q499Gegg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KgupVpSPmG1CB2adoYELFtnyBb2EzHy62KOSCUnkV7V+72TGniPNd+tKS6pp0kavfhCNuy+Oabk42RuqZCZK06OqaFdKXsMY7oDZznLA1NsZabl5WwF35464ZNWhHoxSTTG670Xx96lcL7ZuyiIQXCy5w9yDA4F9AGkfZ2+2h5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEN+7gAN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso47434285e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725872680; x=1726477480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/quyWb8vumcbT1XTiobNYayKAU49ZoNqv4TkV+Bl12Y=;
        b=rEN+7gANEtHwSTDSuZl9cp3h7IAgpEPavIjRYHxK/M9qob1onjQIlMyWw9j4QlYg5t
         SIUVOT5u9v0yAH/icU9TUBP9mxIJx/Lu52Ndji7TO22gWjQoNo6RtonaYa/s0NJiJ4PJ
         p9ZVMtR/O4ujpBbfoxkz9/NT/gdbBa3lkTiDxATK8a8Z9Hy2faNCVvXH7EEtP3PcTCjv
         T2eRkWmlkEf5zOISwwM0xIHt6nVfk+46uF/+HUYJ/KDJIEgMTLtsyncfdXAdLUWBMn6G
         elDczUbvyy0ubfgNDpGJ+nzauA+BWd6HrdWvoiNoPnlunFaSYGALPvAq1diBpfWGRiJ4
         OKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872680; x=1726477480;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/quyWb8vumcbT1XTiobNYayKAU49ZoNqv4TkV+Bl12Y=;
        b=mNAo0C35OOb69DjGeDpX61Q265/dnEudi/YMjJJSlNleZYMwecv7YUdz67m9d057l0
         dMkTk3opEl0KV/+vQkQd2Hg2xY9JlrcCFSfPM8rvoSqVqWpHPRNHiJPgtAE1WAK3HtJ5
         S7PMd4NzPgrKf3EQ4cofe7D/zxnWGR6002YzEGM+QiYRTXFU6GJUU2S2UE3gdwb16Y/8
         oSn692xpTCBT2UMbdQGEunOy9+Hctop+JFjy/SuIkJ4jigdQTb0RiBMrGzwW69OCcfS5
         2bLYpcXoAnf78P3NnStY5H8D7TVCwrq/ovFDpl0KUpKLGe4cZXO35sygOKfVnOTiJnnN
         o/jg==
X-Forwarded-Encrypted: i=1; AJvYcCUDtmoyMb/v59H4EKYOx3wLavvltEMoTNsoNn/3ksrH6ZZFW72144ZxWIFHOAQGiP9E8cbzIgvk0KkuvPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUM52T89VwcQL16OOgh3oah8T0KxwhtoVrS3d+um93kG3+K1IC
	GTRHqwNT+YtYl3ucmDlY8Wd4IgQLPl8NGn13fewqsjVsT3Zw3+oxCjnUYHGGDIM=
X-Google-Smtp-Source: AGHT+IHPyFzNJJ9CK/CbxvRhF0zXZqmiSax9i+YVPGOKwyfg6lpCSe5AQQrFB9PmBhsPgB8jUkq+yA==
X-Received: by 2002:a5d:5081:0:b0:374:c9f0:7533 with SMTP id ffacd0b85a97d-3789243fbb9mr5688124f8f.41.1725872679665;
        Mon, 09 Sep 2024 02:04:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:63a3:6883:a358:b850? ([2a01:e0a:982:cbb0:63a3:6883:a358:b850])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675c40sm5467200f8f.51.2024.09.09.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:04:39 -0700 (PDT)
Message-ID: <b4ac3e8e-1d0c-4a6e-97de-482a77a3a3aa@linaro.org>
Date: Mon, 9 Sep 2024 11:04:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/5] drm/meson: drop unused staitc dw_hdmi_dwc_write_bits
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
 <20240908-regmap-config-const-v1-1-28f349004811@linaro.org>
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
In-Reply-To: <20240908-regmap-config-const-v1-1-28f349004811@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 16:21, Krzysztof Kozlowski wrote:
> static inline dw_hdmi_dwc_write_bits() function is not used at all:
> 
>    drivers/gpu/drm/meson/meson_dw_hdmi.c:276:20: error: unused function 'dw_hdmi_dwc_write_bits' [-Werror,-Wunused-function]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 5565f7777529..b75db829b1da 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -272,20 +272,6 @@ static inline void dw_hdmi_g12a_dwc_write(struct meson_dw_hdmi *dw_hdmi,
>   	writeb(data, dw_hdmi->hdmitx + addr);
>   }
>   
> -/* Helper to change specific bits in controller registers */
> -static inline void dw_hdmi_dwc_write_bits(struct meson_dw_hdmi *dw_hdmi,
> -					  unsigned int addr,
> -					  unsigned int mask,
> -					  unsigned int val)
> -{
> -	unsigned int data = dw_hdmi->data->dwc_read(dw_hdmi, addr);
> -
> -	data &= ~mask;
> -	data |= val;
> -
> -	dw_hdmi->data->dwc_write(dw_hdmi, addr, data);
> -}
> -
>   /* Bridge */
>   
>   /* Setup PHY bandwidth modes */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


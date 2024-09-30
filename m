Return-Path: <linux-kernel+bounces-344231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C498A6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5981F236C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5C1917E9;
	Mon, 30 Sep 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlE19B2H"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCC191484
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706516; cv=none; b=uF8twDKu/XkOddh5hdBS6JN3JXVT5MtXfUCQim4IJImX0DPV6yKiikW/ZhS1VL7BiX1DDfuLi9bOTsncs/XQL+JkKcWmgtHIbotnKHBRyC42R6V64p+BVEFRzMMW3vaMSm0I7VwHcQ39v/LD+QRGRTEqOOba7COnhSQ0ljMGO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706516; c=relaxed/simple;
	bh=dchNBKXVndkAMsiHNZVwWx65eM0qP4qB7dbEU6mL/JI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HBt7XB/rkFEC+lC13evycOlXZEKphLfIxIK1eeQDWv6S6FDzQe83nAYoeCQnWY2mnRygRw7ncthopdIWgqg47AO6KQOujHjirDKnfboIJBaZHcVtmaouA3Ih0NlqndP7SWzxcGOcNZ9ck3Vx10PqeaXUDCGipe1fIrH2waKaIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlE19B2H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso2188126f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727706513; x=1728311313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qs9fqcM4y/62FZTYV45HZ7IoYxEq/8eoOWfouR/4iR0=;
        b=SlE19B2HbfS38e6amX+TDUAv5cWcN1/ljReAMW6vIwoXNrvo/HvfD4hxxdiw1qt9j8
         SfwrlekOZ94ARV4V6kBtnz0YmrKN33YDk5rKpcXsASAPjzU26zJwpwwlMn9RClHTO5wl
         y9zideAgt3ZmimzrRvuOVlFun8wjBl50JXkI+jEPZGQyqFoEYXcnNEML0lVo1AKqbQJe
         Q3pHuKLWI8EMBXEfbmfJrD7iAMvNosL3kNKGmS+n36q2ZcRcyxZZ/k7+DRufpSt9jbLg
         2Z8N0LywbLiOFK9bg1NyTVZOxK/3uF6DzsFRjY0+TUzYAWbuerAJbkfUVhohoswHX1T1
         qnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706513; x=1728311313;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qs9fqcM4y/62FZTYV45HZ7IoYxEq/8eoOWfouR/4iR0=;
        b=vr5tzIxcekSdrqlEU6UCNzyOtzJQhyuCKHDWOl3kihGFRbn3w9GMybsgF3LR5neH1U
         Nxcq1cC+oR1rNCHcoSs8dWnftt70PFKVRYShzEhlh92QMkGGEOYBGNZR4LvEgp37XnxB
         Pfx2lfol3qyDsFci4r5NQ4wIBVNf7mMFUserAz8BujOreg81bhdTHbJrEUmgdpAFfj2X
         bAhSZUy7JIKn6RlLRMonu5AF3NfWeFYy12kLZfCuyrjDD0uaO5uVy3FPSvS4lBp97+Wz
         H1bfE4aNtYYG66k7VmVrrD77L/ipTf1N/iCq4t+n4aw/UaVzfGccPei7gbPQnT8/LzLh
         riLA==
X-Forwarded-Encrypted: i=1; AJvYcCWUYhpcTuh4G4DhZH1QmGPWEai66JgNNq0u7kJFpd6BriFOS6dnep7EB+D5X16he6oZI8wd2artfHqbxCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVXWW7LGlod+YDnaM9bAX6PLaevnMwez04isLhrV9ghBurpEo
	BgaCMA7HUP9XFxfPtBkCiPBAXBaRLS11P8uK+FGQHThtdOPmimrXW7AEnH1PtgE=
X-Google-Smtp-Source: AGHT+IEM2DcMunLEXQ0MqIlR8/rqi0iScdiX8I6h2sTZyeX/CjsYANv0QIzwmOhRTVKq9xpqbrx7lw==
X-Received: by 2002:adf:edc9:0:b0:37c:c5d6:b2d2 with SMTP id ffacd0b85a97d-37cd59df35amr7661374f8f.0.1727706513467;
        Mon, 30 Sep 2024 07:28:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bdc6:abc9:5047:7828? ([2a01:e0a:982:cbb0:bdc6:abc9:5047:7828])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm9123453f8f.100.2024.09.30.07.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 07:28:32 -0700 (PDT)
Message-ID: <76f38f99-79af-4015-b07b-6ff3ec070cdb@linaro.org>
Date: Mon, 30 Sep 2024 16:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/6] drm/panel: ili9322: Constify struct regmap_bus
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
 <20240925-drm-const-regmap-v1-5-e609d502401b@gmail.com>
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
In-Reply-To: <20240925-drm-const-regmap-v1-5-e609d502401b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2024 17:42, Javier Carrasco wrote:
> `ili9322_regmap_bus` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> index 4a6dcfd781e8..94b7dfef3b5e 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> @@ -318,7 +318,7 @@ static int ili9322_regmap_spi_read(void *context, const void *reg,
>   	return spi_write_then_read(spi, buf, 1, val, 1);
>   }
>   
> -static struct regmap_bus ili9322_regmap_bus = {
> +static const struct regmap_bus ili9322_regmap_bus = {
>   	.write = ili9322_regmap_spi_write,
>   	.read = ili9322_regmap_spi_read,
>   	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Return-Path: <linux-kernel+bounces-349280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978598F3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D61B219A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726671A705E;
	Thu,  3 Oct 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmGlk5tI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52B19B3EC
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971952; cv=none; b=cnLsdfTWKiwLReB5kr8xmw88JjXy4mi338oYVocExt83OZQ7EJl21E+d9VM4KZLlF7mWYRlPmPtgGdbKfLkfkqUOrqD9yhu3L3qfJ5wEBDC1MB9kaV0LwsJfglxmroq/zHuJkApXTKBXIxcSB6Zb7pJn9KtbisVUpY6mOQK13cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971952; c=relaxed/simple;
	bh=4hXpDujIOfPcuxU09QppKdGt5X3AylX4OcGKi495L9g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=CBQW1QKWugQm/LSM2FX81NUNjHtoB6gYuqihM3jhSu/mUZtOLK4ykTx0h2fwp35HofC5sHPDt8J5I5ruX2+TUa+ruMUL8OPoiXA5bibh0pxdHRzOHQxzN4Aii8zDEaXzIdbAFRu/w6Iulhk6P3QNXh3efgIdLEA5c3qbcryql9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmGlk5tI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so10623945e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727971948; x=1728576748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9x0kA6Y5xirU8ZKb3vd7ah9xp3oW+AcwIHY8MvPuPSw=;
        b=VmGlk5tITmw8uOymimc5DP0YCq2sZUZCMoyTkhs8AvGCwed6plxYsWdBU8NYCETs6C
         JCB9+rJz1cVYHidSDdUTwz+WxH4NTSjiuetOMdVXXcPUN4/Dwh1XN3bgLsupqj+r/kl3
         b8xgXuyC7C9VFn+qiSicz9VnEzYlXVYIiXROrJARYyNmeWpJBPeHgaOVk7xOWwNIX+Xg
         GI4h0k0ANBBdeRjo6AXo9CrGtmC+v43NVamDx3lWi5aLFNNUYA+otsdqmFeRj5W+wBTg
         M5VbMzc7BWZEGD9C1y5ymfdYjpfXa48E0sdn77T6GyOl6KB3EUgF9RC+Lsayl9BQSnpt
         zsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971948; x=1728576748;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9x0kA6Y5xirU8ZKb3vd7ah9xp3oW+AcwIHY8MvPuPSw=;
        b=m6MmTKxrnFJI6NYl5FQyvAFrhEy1E0zrF73m2bsMI8JbqLqUr8GNxO1aCnyQlpyQxG
         fE9QbjhbXHdIi67kLx7c2qyLqVWaf7rVhW6rFdte2uevkD/Ad2sk5GFrALAfgm3XH0CF
         N8+2eeewcjrMlFt4gsV8QXYr77Z1fYb2pGmsea8VFgS0Sk9drAW2D95E7obfdtZBAbhY
         UQ1yyiVNyYLk7k9N264bI16Ym9I+rTHHfi66bYiElRAr2q5yGdntaj1USQ1ZMPq7JXQA
         1N/X9BXk99fMIVzgAUlOSQldpCGbJXAFvn5Gw1/fCbY5mz7ls9PIYRC+mUnIKFeCwlro
         2fcw==
X-Forwarded-Encrypted: i=1; AJvYcCUifWAS5WNW3UW2TE3/MDgfWbkriVo4PxK8JcF7/Dk8ODuiXPagbgvdyFA16Mlmzcv51+IzBHTmCoea8Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTV3S6G46iBXRZpZEuMhCqewUX54KyMX2J8H7+2XXDeyRKLnVt
	YuvrNrYBdfuoxnL//t736GUEBTtxMnNyB3zenQ72VOHlQnmzBj151JeObLJtbnQ=
X-Google-Smtp-Source: AGHT+IH7XqoTZIRUQjlYMVABAzMAJKn3H7Cg1IhhW5+WLWmS66vcYeXzq7UpCoZZyE94HETXaXNryQ==
X-Received: by 2002:adf:a38a:0:b0:374:ba7a:7d46 with SMTP id ffacd0b85a97d-37cfba04204mr4360586f8f.43.1727971948300;
        Thu, 03 Oct 2024 09:12:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e534:c027:e113:29a1? ([2a01:e0a:982:cbb0:e534:c027:e113:29a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822bc38sm1598885f8f.45.2024.10.03.09.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:12:27 -0700 (PDT)
Message-ID: <4caf21cd-2783-48d3-8e6d-159ad8e89113@linaro.org>
Date: Thu, 3 Oct 2024 18:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/bridge: tc358768: switch to bus-width
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241003133904.69244-1-krzysztof.kozlowski@linaro.org>
 <20241003133904.69244-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20241003133904.69244-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2024 15:39, Krzysztof Kozlowski wrote:
> "data-lines" property is way too similar to "data-lanes".  It is also
> duplicating "bus-width" from video-interfaces.yaml schema.  "data-lines"
> was deprecated in the bindings and "bus-width" is preferred, so parse it
> instead while keeping things backwards compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/gpu/drm/bridge/tc358768.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 0e8813278a2f..fc96fa5aab54 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -443,7 +443,9 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
>   	ret = -EINVAL;
>   	ep = of_graph_get_endpoint_by_regs(host->dev->of_node, 0, 0);
>   	if (ep) {
> -		ret = of_property_read_u32(ep, "data-lines", &priv->pd_lines);
> +		ret = of_property_read_u32(ep, "bus-width", &priv->pd_lines);
> +		if (ret)
> +			ret = of_property_read_u32(ep, "data-lines", &priv->pd_lines);
>   
>   		of_node_put(ep);
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


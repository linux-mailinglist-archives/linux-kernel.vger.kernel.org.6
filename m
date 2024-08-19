Return-Path: <linux-kernel+bounces-292505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841AC957040
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A411F21051
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919A17557E;
	Mon, 19 Aug 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGLBvgO5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EA173357
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084967; cv=none; b=MRmx4KvJJs0rMvbDgKS5GtGpGhBVQRUFAAq2+b3hvDlaViVNHvdcVUa0w/fOKLmdz0H021OFQkI9s/sdlZ1ZreyWCNlo7wf5NYuddFOVPV4qvoVtNlbS/Js72r/+6rE6oQN10DgfEm6IOOOFEnhyB27x5TeiTrZaDf2iqUydK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084967; c=relaxed/simple;
	bh=s52OHKtDl3AmAbau02STsx5Dnlsg+8r1eQiVrSVZJ04=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sW5iKcVGddh42nHvFG8i25Fsss2XtWEJkKsn+Erpjhn/80wd9bAo4WSIJA/l89xE1u0lel/5aAzKQYZy3zlY6V6INXAaSaVFntZ0EpXo+DMecIiPORXZzzyaWpUsOXt40X1smmcg1pwAyUHgqQqOIQ9QpKDrPXIMsxrB9s+y8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGLBvgO5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281faefea9so35559465e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724084964; x=1724689764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5US2fLlCk1Qa8yNz6skTiBfI5hTwUtCqnfiUSm9ZmH8=;
        b=NGLBvgO5zNenjRHC3tdNLZutCuuywP4GaqtRIxWrnAge5tcui/sJxwiNjHkbwHF0L7
         JjNFc2uftphYpEQ/OaDY73dovMNmyUoKhGBtWrHGgt7Xy8wO1W9r4Qw//mxZMn9l25NB
         /0ljP/sAcTqzuDER0JI/aVbaEzDpt6/iZBJfTeI5KXWuP2eQHPy3atgg0PqVll+MVHzI
         bf32mBLBJa3w2Kq2h4NdzqBIuTVf/tCMQzlEbyuTm0ZaGJAlrMsYMljz+TrM8zwANjI0
         0Ly9EcWgbBu76XRYyqj7cwqO+GBD6/9XpsSj9xvPpWNZmkWBFH55GxM6kWAG2vvPsf+q
         fUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084964; x=1724689764;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5US2fLlCk1Qa8yNz6skTiBfI5hTwUtCqnfiUSm9ZmH8=;
        b=gw14za1iToF2V1yoPqpxG15KQpeZnZHzlMJkt43MnjMZDegxW20OiQ/g04sDV+7oPh
         ojs6jHXg7jN8InwKoW5i5L6Fab6VgrDEyUr//bWyFzNJTQYw2dFqQEJ8TknKqR2d7OYc
         9kLvt0nvyk6IvdJrvsyTMmNCqx2okID6EVv8s2WLEERAlt9I91W0iOM3wCD6q0oIRmBP
         qRUql3DEXEjUTkkQ+VVlv/MOWUCglxbzG/07W9bt/xt7AkrokKHyhoF3W4njz2HRIUKe
         UiZ3Yt0OVBv+pB7Zb7dvmtZUMmODAlaAoSlHARMXSatknQvi6jZI59qW8PwfDcsD0N7s
         8Hdw==
X-Gm-Message-State: AOJu0YyurazjU9tRggDdxXCFyvMOgj+Q3c4RUJn2Ul0S5nPWrKZovpMq
	6tClkSjv8/OccAe44StjNTzowEqySeL4U7ATAvTxiqiG5vwDomIbp0mUNF6P4jHw1h/OAZo/46A
	S
X-Google-Smtp-Source: AGHT+IHxfQlj6hZ6qabi9dNFuwSGuRU8pknTTNNcDBW8nTSoVe9O85P9qnLwExtrqcC3QNJEn9lkLA==
X-Received: by 2002:a5d:4cc8:0:b0:371:82e7:6ec0 with SMTP id ffacd0b85a97d-371946d29b5mr7731949f8f.59.1724084963165;
        Mon, 19 Aug 2024 09:29:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898bb588sm10912541f8f.115.2024.08.19.09.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:29:22 -0700 (PDT)
Message-ID: <8cae4536-52ff-4e54-ba15-6376dd9129ca@linaro.org>
Date: Mon, 19 Aug 2024 18:29:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/9] reset: amlogic: use generic data matching function
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
 <20240808102742.4095904-3-jbrunet@baylibre.com>
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
In-Reply-To: <20240808102742.4095904-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2024 12:27, Jerome Brunet wrote:
> There is no need to use the DT specific function to get
> matching data, use the generic one instead
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/reset/reset-meson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index b47431a21b86..820905779acd 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -128,7 +128,7 @@ static int meson_reset_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	data->param = of_device_get_match_data(dev);
> +	data->param = device_get_match_data(dev);
>   	if (!data->param)
>   		return -ENODEV;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


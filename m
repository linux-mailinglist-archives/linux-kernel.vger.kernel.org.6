Return-Path: <linux-kernel+bounces-292466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7E956FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A97C285CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CE16728B;
	Mon, 19 Aug 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhzHkQzr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213C47F46
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083629; cv=none; b=b1ZhnhGPEXW/HOiQ+eB5ATPECnCcznuc4L1vp8pq6zm0bArG+6Y9fjIkRpGWBmFGhAFYoPZZDv+MHhhcgxkmUktCQzQbJCmPVcMZB6PYtgAKOYvsapFdYBLxG7RED92pIQGTmFDYLlBpmhaYorsfA0T5gzxcPs4nEdDM8R61Hhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083629; c=relaxed/simple;
	bh=3dkHNFTl9N6jY3+tkEJVnyFXsNkZb3OvKllpliZ3t0Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GXQp7z0XVMS3sX1etMxIuNzqZ7xQhOVUjto61SkbV4C7sI1xxBgstggjxRFI0oIeqbjSMgTpPRAPM43w59EDH5/VmqelSuVNyQM0zxEPq48aSSJ+AwA4bls3iyt3SFfsmDGmjFCKaFOpsXpFT7G7dxAC6oInbq8JZcIw37aGvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhzHkQzr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42809d6e719so37770575e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724083626; x=1724688426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LNqeb3ZgALy4xdwAEcRE9nVauPSurOEFzQxg2hY7+Y=;
        b=bhzHkQzrLry7HQbEKtaINYQ8ZowseTyne6yoVMESXu2bKiGWja/M7yza0ZOKbjnpQz
         WnNQYl9XTdfZ9Ti6vPUc4wJa9K278+7Z9NTssRq13m68R546+YwvOEyvcP+mIPe/b+NN
         pdL+zSC0I1uIPBvVlv8WfKGBiYYWtkUMXr54gzo2AowJUTSCLzlTgQAKtQA0lDkFVN7g
         t1DUNKmeoW2iFU7X4Mh0eeIOEuqlon9kOatNR+9jyl4jjrv6hi2vx8a+LpPDqN2AhdDl
         b2k0JVeDdIXD7gD3ikfzsOF5nP/+Fh2EGxN4unHp6vLj8RlysdzTXkx3kRTkTsdDaIaj
         IzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083626; x=1724688426;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5LNqeb3ZgALy4xdwAEcRE9nVauPSurOEFzQxg2hY7+Y=;
        b=KjTL+vqy7rcrnr5k9qdqvKLc8mFUYJhNhzHWhWBE+NbopNfaaBDmjUER3iHYoZ2Cu3
         jHO/IAYmr+OFCIIkX2sMlCJ6d9ffXeYQ73BULGUQjCEjXmeT0CHUcPKjQccmOEH3jfbG
         pbhO4awo2Xymt2gwIZOfp4bUjak6sxxgfziLVnjEMY8Gfyz1x6ByELRpNUemmy9Y9tbs
         alYbLUi5oeIMQNx3IE6DD3WK2CHZ6nWLWiDpItH4Hinis7tvnY81+8l8AmOrm+Ub7UuG
         Y2tj00IQLY9FvhVSyUVXKunlNiJiCHi4GjzWx250PiR9+AdGDdknHJhdbrhWA75qME6G
         4Xvg==
X-Forwarded-Encrypted: i=1; AJvYcCVBzbC5p9OJTbrPnX5u5N/DeHjI4sc5ntpGJFkE3Ji3xS5Mn5muBWIqBQMNk5ysgi5eK/kIdJsz6WisCyeYEO6aosMjeikd4W0g+MD0
X-Gm-Message-State: AOJu0YwNYgpMi77mTrRAEgA4YSOv1WccclCMjVp2pdaBVZZtxp9VErFh
	nUsVVYK5W8erdvdyy/uwf3Azw+k6Np3obbDdbFVUd6D1haEksFAIlC1pgDTdTgw=
X-Google-Smtp-Source: AGHT+IEQR4t87/P6PagiJISQ0jKse0XEojnisMOIM3YVNy+F7eNVyZm87ufA5Y7uQKmtDCtIpWVusQ==
X-Received: by 2002:a05:600c:548c:b0:426:55a3:71af with SMTP id 5b1f17b1804b1-42aa8275ea7mr49659035e9.33.1724083625240;
        Mon, 19 Aug 2024 09:07:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d780ba5dsm222433555e9.0.2024.08.19.09.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:07:04 -0700 (PDT)
Message-ID: <004156e5-8dde-45a7-a291-425486e20696@linaro.org>
Date: Mon, 19 Aug 2024 18:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/9] drm/meson: dw-hdmi: fix incorrect comment in suspend
To: Jerome Brunet <jbrunet@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240730125023.710237-1-jbrunet@baylibre.com>
 <20240730125023.710237-5-jbrunet@baylibre.com>
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
In-Reply-To: <20240730125023.710237-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2024 14:50, Jerome Brunet wrote:
> Comment in suspend says TOP is put in suspend, but the register
> poke following is actually de-asserting the reset, like in init.
> 
> It is doing the opposite of what the comment says.
> 
> Align the comment with what the code is doing for now and add
> a FIXME note to sort this out later
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 2890796f9d49..5cd3264ab874 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -751,7 +751,7 @@ static int __maybe_unused meson_dw_hdmi_pm_suspend(struct device *dev)
>   	if (!meson_dw_hdmi)
>   		return 0;
>   
> -	/* Reset TOP */
> +	/* FIXME: This actually bring top out reset on suspend, why ? */
>   	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
>   				       HDMITX_TOP_SW_RESET, 0);
>   

Yes, this is probably useless and should:
meson_dw_hdmi->data->top_write(meson_dw_hdmi,
			       HDMITX_TOP_SW_RESET, 0xffff);

but I think it can be safely removed.

Neil


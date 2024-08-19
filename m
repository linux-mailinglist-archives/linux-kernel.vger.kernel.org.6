Return-Path: <linux-kernel+bounces-292507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E15A0957046
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B88E281072
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76017622D;
	Mon, 19 Aug 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNmyTAYC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F946447
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085007; cv=none; b=qhuxcAVsTG2dOWj048bamCYow71kfEOGi3vuI1x71o/Eep6RtsS9ShEXJf4wGosD4++8fOlZF7/eKAWc/s1JdstEB0NmKwHpaKmehyXzxoRaY4K4bJdsDsrGoGy7oMDdIdNuR7u1ljk8IV9myvTWFQm61srM5sf8z1YvfF2i0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085007; c=relaxed/simple;
	bh=5uQK76DggjvF22mp3e17AZuc5pTrreNqIaDtoupLJW0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KCSoBn1w2hhtZ46fERrgEzqREKEiQ7GJXOAGCiL9v0hZEwVStwBymT+G8E8XJVs3K8ev/dUWxW9bHbgGDEKOsz91gnOHS+6lEOKDhGns1VSqvW7M0jqzp1fjuFMJBnFDpAVWHl+0AUIQNMkxP6MDSvY28WY3Ci/km3Cg8Ebt/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNmyTAYC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e0d18666so35558685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724085003; x=1724689803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7r7S7wRPFk2pSvVl7ZU19q0fOw2MNDRQgJBqWmwGHPQ=;
        b=pNmyTAYCKFu3Ra9LyFwW+9LL6H8v9UvrwsRwtIyrWP1ZN6HG0wsgfb6ED3QoMZHC7p
         QmQuSB31pZVbtWCGAoWzRIGigisVzRoOhcoZpc4GoPtCZEDTD/5WlrNJUjLFyRU8rD0c
         bZzHqYGKlpdlUq8exsqP7TBn8j+kv05kjiY9QsyiHPx4b88vSrUyE4lsGW493RhMOMtB
         ZyGlPLvol4HCIndFTxTwSyRcn6vift/JdSXxsP3M7HlpMqr2gJPmy/dciD/hnDW19Vvu
         KFGKHQefcGVMPNVsaXX45iHTE9xeiK/9XIINlk5Kp072EvA+Ei2qV03y/TnpvAZMpDT7
         HKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085003; x=1724689803;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7r7S7wRPFk2pSvVl7ZU19q0fOw2MNDRQgJBqWmwGHPQ=;
        b=A/ZYKMHUDgVMlu8YDTEQzkDBte5LkrRMFCsbANcUeoYHXCi+AncKTbX1BnVlGaLSLn
         Bemb9ztIAS27ifpZGf5i6Y1yrzbxhhb8ght+DBbYUcFJ2YaGxIdBC5k3hFMuJeKuge87
         CHklguhPu/JW/zTZgsioodEQhRx8kH+XfXccfcV87NYKXkzn3sOVK6EDaDE3pYs373+Z
         4SrxLyfCtdWWGk0DWmXsMpOWSUbTlchPdbnbyynYvSFoisDZyHRpR4qe40HvWGk5z5ik
         RT51KdIUMCLdqWZKlDCNI52vkSuGIoGB+0TuPwE+MSw5Q44gM9gkoAfIK/vkfA9V+XDG
         bDcA==
X-Gm-Message-State: AOJu0YwNPIxwfqPKeXdweEIwhXv4hCdpT4j8e6b4aG3ykK+ZfWjk9PKC
	zuq5Png0c8g/ffPJvkAeNi+er+ZGJhq6kW0fpruZAccfFP8Ni5pmQ7pdXUfMKzk=
X-Google-Smtp-Source: AGHT+IGMIVaSKllyXTJLYfxv8zWfWh7ofv0A8g8baFri8DEHir/qt24CJILAEMd+CXWxYTxmuGPIOw==
X-Received: by 2002:a05:600c:548e:b0:425:69b7:3361 with SMTP id 5b1f17b1804b1-429ed7ae653mr89860125e9.18.1724085003029;
        Mon, 19 Aug 2024 09:30:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed79d9a7sm114992515e9.39.2024.08.19.09.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:30:02 -0700 (PDT)
Message-ID: <a6ca8b79-8b64-4427-a625-abd61ffa7b21@linaro.org>
Date: Mon, 19 Aug 2024 18:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/9] reset: amlogic: use reset number instead of
 register count
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
 <20240808102742.4095904-6-jbrunet@baylibre.com>
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
In-Reply-To: <20240808102742.4095904-6-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2024 12:27, Jerome Brunet wrote:
> The reset driver from audio clock controller may register less
> reset than a register can hold. To avoid making any change while
> switching to auxiliary support, use the number of reset instead of the
> register count to define the bounds of the reset controller.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/reset/reset-meson.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 8addd100e601..5b6f934c0265 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -17,7 +17,7 @@
>   #include <linux/types.h>
>   
>   struct meson_reset_param {
> -	unsigned int reg_count;
> +	unsigned int reset_num;
>   	unsigned int reset_offset;
>   	unsigned int level_offset;
>   	bool level_low_reset;
> @@ -87,21 +87,21 @@ static const struct reset_control_ops meson_reset_ops = {
>   };
>   
>   static const struct meson_reset_param meson8b_param = {
> -	.reg_count	= 8,
> +	.reset_num	= 256,
>   	.reset_offset	= 0x0,
>   	.level_offset	= 0x7c,
>   	.level_low_reset = true,
>   };
>   
>   static const struct meson_reset_param meson_a1_param = {
> -	.reg_count	= 3,
> +	.reset_num	= 96,
>   	.reset_offset	= 0x0,
>   	.level_offset	= 0x40,
>   	.level_low_reset = true,
>   };
>   
>   static const struct meson_reset_param meson_s4_param = {
> -	.reg_count	= 6,
> +	.reset_num	= 192,
>   	.reset_offset	= 0x0,
>   	.level_offset	= 0x40,
>   	.level_low_reset = true,
> @@ -148,8 +148,7 @@ static int meson_reset_probe(struct platform_device *pdev)
>   				     "can't init regmap mmio region\n");
>   
>   	data->rcdev.owner = THIS_MODULE;
> -	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
> -		* regmap_config.reg_stride;
> +	data->rcdev.nr_resets = data->param->reset_num;
>   	data->rcdev.ops = &meson_reset_ops;
>   	data->rcdev.of_node = dev->of_node;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


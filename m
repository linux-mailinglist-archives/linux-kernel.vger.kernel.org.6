Return-Path: <linux-kernel+bounces-324683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDADE974FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92026286791
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB934183CBC;
	Wed, 11 Sep 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IglQfa1q"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E355FDA7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050296; cv=none; b=l85wf74KRIjQbt28U4SiN9eOd/9ClSNXr6L0/z7ts/zIjQ1GM73Ug80I9/swd0ojwcENHlvtgnoq+wERLLBhHL45yxuAahzT/FQDUYe8Lj9g5Sj3K9BNzMXT6EkNrbAP/8fwT4l1xDaMTX1BZvC0gzFQOUdnMkbhqiZK6ZnZBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050296; c=relaxed/simple;
	bh=4qunqzdnlZGx0oVQKZXEtjr5bJLPovTHLq5zBxsC5/A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YZtD1C3V+FH2EeYmFAgBDE62XLMRigSsQ1IzqwwEkmVrWppDh2HHeDh6DGGQaYuzAzxEQdf6KndLvNPmDb2ic4NrV5uPkvLums1hwqcSTW7v8ExTKdF6e+ijSHnxCLak2JZJ9v8OEiofKxvCRcsDpcU8r331Q6R/Wv3vzT8b7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IglQfa1q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c8cef906so4505347f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726050292; x=1726655092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCdy0RdUyCbweijYWRS7Oe+sN0LYefHdLb2bjTmlhOI=;
        b=IglQfa1q/MO9gufwIb3laKR9GKPHr0+C3v4Kr+UWfb7pxXaG7fHNdXeuYpccIk+CHY
         WzEd+JHv37ZN+c72PjEcaeUebltVwKRLgWA3BxY4RBelbBZyFEXLiA5fClYRXdNtt5IQ
         rxzlGY74bJKnIIa7rJ3fg9R7NOVmmQFIEnr9CiMo38UiW9LcZ6SjIPU8LAWf+wZtWsI7
         UtAwnQ57976P0l1FRpX9e72Kx2/9K6aQOYEylMFCSoHNk/AcZ150bmmQb56D/lTHlHXR
         WwQ2My37JmaEeL4VaGCeFr3jmx5Gk+6oWGaTXPDSzS02BT48s62/ojmXw48FynalBjc8
         ojMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050292; x=1726655092;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UCdy0RdUyCbweijYWRS7Oe+sN0LYefHdLb2bjTmlhOI=;
        b=YkbsiBQy+Ia24AMGPek7I/yEjbElBP9lixdGncNXcM1ZCzggmXKSPRd8fVJCJ6hIrm
         DqGM2rz7gg5rbtWxW6rpI1MUnlgDgkhw9qSXqMz1edxmY9R+Y0LFq04F6fM8qLF2YIcf
         JoHuNsF84IhbLy60mumVCFfrHHPuZ3aIuvLQ4aLmih9daejpBKKxzSke7w4p3uk6ChzC
         FRWGyCNDa0uUR42uR0sqxMe4euo/XE+O7iccQhHLmSLYs/6zdm7lgczWMrBHy/dMjhrv
         W6eqakxjCFVQLDjxKGU2XQuN7R31T2EXIGBsSIP7bsaMP6QiC5I8ZZiNh63sP0wlAHvO
         bseg==
X-Forwarded-Encrypted: i=1; AJvYcCXsGfZYpJ2HbI50KXIfeXcE2Xo64UcngZAG+WfjDbkKEnj+zyrmJTlvCvNKCyo1/xdRpXn7JbKhnwyvIfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YNw2CHeYmACAM8WcoMvn1MH1cWBkH2hD7Iaeov+9BAqr+rWf
	WMx/53c/GmjLSysc94OxMDIitspF+gAucnIJsukb3IMEblOms+C/TgIjVbH7QKQ=
X-Google-Smtp-Source: AGHT+IFEFNMXj/YrwUwSkNn9fs/IOdtEP7hEN+0kbQh4bzyWyI1Z98gsKKfyrZjB8tOoy3en2escAg==
X-Received: by 2002:a05:6000:128c:b0:374:c287:929b with SMTP id ffacd0b85a97d-378895c5224mr10490802f8f.4.1726050292245;
        Wed, 11 Sep 2024 03:24:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1680:3625:e94b:7c21? ([2a01:e0a:982:cbb0:1680:3625:e94b:7c21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm54782885e9.0.2024.09.11.03.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 03:24:51 -0700 (PDT)
Message-ID: <9f753151-b908-4585-aae2-4a2ff5dd41af@linaro.org>
Date: Wed, 11 Sep 2024 12:24:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 4/9] reset: amlogic: add driver parameters
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
 <20240910-meson-rst-aux-v5-4-60be62635d3e@baylibre.com>
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
In-Reply-To: <20240910-meson-rst-aux-v5-4-60be62635d3e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2024 18:32, Jerome Brunet wrote:
> To allow using the same driver for the main reset controller and the
> auxiliary ones embedded in the clock controllers, allow to customise
> the reset offset, same as the level offset. Also add an option to make
> the level reset active low or high.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/reset/reset-meson.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 50bd2241ef2f..6a90613c8095 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -18,7 +18,9 @@
>   
>   struct meson_reset_param {
>   	unsigned int reg_count;
> +	unsigned int reset_offset;
>   	unsigned int level_offset;
> +	bool level_low_reset;
>   };
>   
>   struct meson_reset {
> @@ -46,6 +48,7 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
>   	unsigned int offset, bit;
>   
>   	meson_reset_offset_and_bit(data, id, &offset, &bit);
> +	offset += data->param->reset_offset;
>   
>   	return regmap_write(data->map, offset, BIT(bit));
>   }
> @@ -59,9 +62,10 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
>   
>   	meson_reset_offset_and_bit(data, id, &offset, &bit);
>   	offset += data->param->level_offset;
> +	assert ^= data->param->level_low_reset;
>   
>   	return regmap_update_bits(data->map, offset,
> -				  BIT(bit), assert ? 0 : BIT(bit));
> +				  BIT(bit), assert ? BIT(bit) : 0);
>   }
>   
>   static int meson_reset_assert(struct reset_controller_dev *rcdev,
> @@ -84,22 +88,30 @@ static const struct reset_control_ops meson_reset_ops = {
>   
>   static const struct meson_reset_param meson8b_param = {
>   	.reg_count	= 8,
> +	.reset_offset	= 0x0,
>   	.level_offset	= 0x7c,
> +	.level_low_reset = true,
>   };
>   
>   static const struct meson_reset_param meson_a1_param = {
>   	.reg_count	= 3,
> +	.reset_offset	= 0x0,
>   	.level_offset	= 0x40,
> +	.level_low_reset = true,
>   };
>   
>   static const struct meson_reset_param meson_s4_param = {
>   	.reg_count	= 6,
> +	.reset_offset	= 0x0,
>   	.level_offset	= 0x40,
> +	.level_low_reset = true,
>   };
>   
>   static const struct meson_reset_param t7_param = {
>   	.reg_count      = 7,
> +	.reset_offset	= 0x0,
>   	.level_offset   = 0x40,
> +	.level_low_reset = true,
>   };
>   
>   static const struct of_device_id meson_reset_dt_ids[] = {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


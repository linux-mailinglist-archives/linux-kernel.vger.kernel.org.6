Return-Path: <linux-kernel+bounces-405920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E99C58DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711221F21EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB1140E5F;
	Tue, 12 Nov 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImbjOtrY"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50D433CB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417875; cv=none; b=tS8S9jZYZfveKtt+nCPnN3/p5EFgXPEga9EYBbk+RGcpcPQRkiOPdnarAkYy/bNw3dITk+owULfnVhlDrL8NENOneNRTh+aQcjaF/PsQQMh8KrMDVZ6BAFGiSZLcSHshVYVbLOzNSSFgNuzlIQ1JWuCcXG2gegsME7tRyQSMgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417875; c=relaxed/simple;
	bh=WxS7sgkpiiM0bdtTq22/FmqCJRd82p6jniY8C40amTE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sdbHJjgEXaWpapirNQQAgJHD7opcynUN2TzG/QMWWiZCObdAmWKIVViFQ7YE/n19ijFIaRtrimwG92nBLEhUVtlIH7cCKO7bfVqgMELRgOMJBURWD19l/KjJMtvbbXh40dk8XizAbAiLE0B9V+XiKwEVqJMfxH5LFjOmmXAUFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ImbjOtrY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so3758101f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731417872; x=1732022672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op9TisDjuU6SXMVv/j5ec//p11wAht9zab/vpdAa0jE=;
        b=ImbjOtrYVzAMvTPxjadiSjFvlSGq8U+Z+BPqfW41TeqoaeND9P24nNUCOxXp574aG4
         +vInuHvhoETLsvneeyzQR8KW4vJwaBgS8Syc12poKKN5lcFkEiayTNBhQ68F5Zrg0Fro
         TEQtUnPiggCIysnaaYjcPnS+miIBG0J+DsO0ByJybO7tfaesT1j4UzqvMjbvnv5XWhAG
         pumT/lpCQBbA3hWgLXm5MYZvL8WXnGQZGT+74/h8vpGT2NEwXHAg0mcPo91+12FBnrjW
         /guaDiosUrdneNsf9PP9PS244Cy6F9mBiGjrwCfoqPve+vDvZE9vVP1ZN4HmSpBoVlSD
         GWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731417872; x=1732022672;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=op9TisDjuU6SXMVv/j5ec//p11wAht9zab/vpdAa0jE=;
        b=KO2jq4mNGg8AVUKbF1eQNA+L9/Cq2CY+OqcqN9U68lYvGq/KriS//VYlu3YL5DtO3M
         JgfySbDFY+cyfShboj8/RtPOxWFHVyjUikMbaXHCrFBYqaFU/93MFt8KVypdLsM59mxM
         bGpkOYLlMcWTr5mEv5jgqtflcBeehofUfvTR1vwe3zl7QkhSxp5tVrre7BCD5xygnZMV
         hPikYHOPWnw+TaLuCkFpGzfxRQsk98zyqOZowpbeipzOiv4Cmr9w/4xkC2+0pzaksCBB
         DiT1MO1uAbr/juYyVpdSmSIJc+hQc6gLdQrz6l6SHs7QZglMvl/hYZPSEh5sSmolInls
         YKqA==
X-Forwarded-Encrypted: i=1; AJvYcCVR5xfrzCiHXMLn8LH3Ndx4O8apezxUwcDo5XWAEcLpsb+ba1yP5Os1rXHulKx+DYDpjCuWUluikRGptHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFkS70r0YYj9WZBkUeHfevAMqCDiINGl0mJuag9D7rVW9jVw9
	zC9kUZ3esWBwL0SAsgBqErPTvM+5loSVg1H/UJAkPCgkLPJtXFuGZ9tEyjDmfS8=
X-Google-Smtp-Source: AGHT+IFUbvqpp7hxTTTbUnzJmnji9CfW4r3V54ckUUimyAfT0DIrLZ5j+wf8asngwceIIwDWhCpAYw==
X-Received: by 2002:a05:6000:4913:b0:381:ed41:da7a with SMTP id ffacd0b85a97d-381f1848940mr12877952f8f.54.1731417871732;
        Tue, 12 Nov 2024 05:24:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:860c:aff4:d0e9:9db8? ([2a01:e0a:982:cbb0:860c:aff4:d0e9:9db8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05dfcsm15353314f8f.91.2024.11.12.05.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:24:31 -0800 (PST)
Message-ID: <35307d7a-a110-430d-9ba5-808a05450adb@linaro.org>
Date: Tue, 12 Nov 2024 14:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] clk: meson: Fix the determine rate error in
 clk_regmap_divider_ro_ops
To: chuan.liu@amlogic.com, Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jian Hu <jian.hu@amlogic.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Yu Tu <yu.tu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241112-fix_childclk_of_roclk_has_been_tampered_with-v2-1-64f8009cdf2a@amlogic.com>
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
In-Reply-To: <20241112-fix_childclk_of_roclk_has_been_tampered_with-v2-1-64f8009cdf2a@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 13:57, Chuan Liu via B4 Relay wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
> 
> The rate determined by calling clk_regmap_divider_ro_ops with
> clk_regmap_div_determine_rate is not RO, which will result in the
> unexpected modification of the frequency of its children when setting
> the rate of a clock that references clk_regmap_divider_ro_ops.
> 
> Fiexs: ea11dda9e091 ("clk: meson: add regmap clocks")
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Background: During the execution of clk_set_rate(), the function
> clk_core_round_rate_nolock() is called to calculate the matching rate
> and save it to 'core->new_rate'. At the same time, it recalculates and
> updates its 'child->newrate'. Finally, clk_change_rate() is called to
> set all 'new_rates'.
> ---
> Changes in v2:
> - Remove the CLK_DIVIDER_READ_ONLY judgment logic in
> clk_regmap_div_determine_rate().
> - Add clk_regmap_div_ro_determine_rate().
> - Link to v1: https://lore.kernel.org/r/20241111-fix_childclk_of_roclk_has_been_tampered_with-v1-1-f8c1b6ffdcb0@amlogic.com
> ---
>   drivers/clk/meson/clk-regmap.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index 07f7e441b916..edf65ca92c7a 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -80,21 +80,6 @@ static int clk_regmap_div_determine_rate(struct clk_hw *hw,
>   {
>   	struct clk_regmap *clk = to_clk_regmap(hw);
>   	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> -	unsigned int val;
> -	int ret;
> -
> -	/* if read only, just return current value */
> -	if (div->flags & CLK_DIVIDER_READ_ONLY) {

You're breaking current code by no more checking this flag,
the new clk_regmap_div_ro_determine_rate() is fine, but you should call
it from here if CLK_DIVIDER_READ_ONLY is set.

Neil

> -		ret = regmap_read(clk->map, div->offset, &val);
> -		if (ret)
> -			return ret;
> -
> -		val >>= div->shift;
> -		val &= clk_div_mask(div->width);
> -
> -		return divider_ro_determine_rate(hw, req, div->table,
> -						 div->width, div->flags, val);
> -	}
>   
>   	return divider_determine_rate(hw, req, div->table, div->width,
>   				      div->flags);
> @@ -127,9 +112,28 @@ const struct clk_ops clk_regmap_divider_ops = {
>   };
>   EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ops, CLK_MESON);
>   
> +static int clk_regmap_div_ro_determine_rate(struct clk_hw *hw,
> +					    struct clk_rate_request *req)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(clk->map, div->offset, &val);
> +	if (ret)
> +		return ret;
> +
> +	val >>= div->shift;
> +	val &= clk_div_mask(div->width);
> +
> +	return divider_ro_determine_rate(hw, req, div->table, div->width,
> +					 div->flags, val);
> +}
> +
>   const struct clk_ops clk_regmap_divider_ro_ops = {
>   	.recalc_rate = clk_regmap_div_recalc_rate,
> -	.determine_rate = clk_regmap_div_determine_rate,
> +	.determine_rate = clk_regmap_div_ro_determine_rate,
>   };
>   EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ro_ops, CLK_MESON);
>   
> 
> ---
> base-commit: 664988eb47dd2d6ae1d9e4188ec91832562f8f26
> change-id: 20241111-fix_childclk_of_roclk_has_been_tampered_with-61dbcc623746
> 
> Best regards,



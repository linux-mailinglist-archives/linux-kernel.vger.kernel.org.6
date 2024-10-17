Return-Path: <linux-kernel+bounces-369392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7D9A1CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C204B268A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C31D1E96;
	Thu, 17 Oct 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KP7eONNG"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694261CF7C7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152768; cv=none; b=CAMyrXnENrky1flcgrHira4tyQ1EI5rVCMfBt4UeeL70OYgwUwUmVgSMUb5TW54B7GzrpL4dYWhOI2NPwJJOpnA2k12LdZkhbx5ipRaAjAF6HV6CHkBXSt6CCF13MIZ1iLOZT+6t1WT7sWlADTsMOZ8tNG8UcVcTPzFFLSzDd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152768; c=relaxed/simple;
	bh=woaT2J45zVWWUvxNM5Wp6p+L4KbbqgALTKWoNkftqos=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pnc4q/vgEPtTY3LkMi4zmj8kpJ0OKhDM9T4xtIkieGCSJhZyuW+vqktvlBKxqAuh21X8nSsY7c8FUxM/0+LlRVYI6ig9+4WvhQRUVAgMqAzDGOII6syZRFxlXUrBlrs6eMw/IYqaRj+iCuJBeA3qzBbfmBSEAx2D101gWjg9+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KP7eONNG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so754066e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729152763; x=1729757563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85RPwSziFxh/qGea2gBjsg17pflJMJv9MvJZjHpRCKk=;
        b=KP7eONNGrf3qaxokaJDvMTalY1g+l2cN9BvgXHt1NEgG0kBuOZZAukrBGZIshbTzw6
         rVH0nasMQHkKiwpWYLuROrO2Jau6ogtcKmhaiQC+u3cd/DeLis7DPYrJND53I1FyyAbe
         0ws//YkPJK2x1s1W6SRGYFa5XOrmHL+aYS9BszfZFWVGTq4ZMrHJMerRsoAU3002Fsg/
         yRVVv6eX14gJJRnsLwTx/2nfmfyALqJ6lulEDqbMFaJfOW/cKsd4XlY/DSmnVsXzq+pv
         6cc/mbt+R966p6Jke4PR+KLu5YwDKSkWhRtZOqYW5KiLYcyGFM74zNdoQC1Z3VnYrVbq
         Gihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152763; x=1729757563;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=85RPwSziFxh/qGea2gBjsg17pflJMJv9MvJZjHpRCKk=;
        b=GFYJdXnfJK8nSTaIbZnTflsuac4Puny7MEv+16/zBP8h4fhgTyIj6QxWzH7XvUjWsz
         I6C/4W0YGFYqoa78VqSu8wm3v4esRON515LSgFX2VcL+GxvqnbDo4f+lN4yVbgGXER+C
         078eozmGHg+c/qE6s8WgoNmUliDiyJtjdrjsZvJp9CsEY/xBPGX+7G1C9LfbQX8zxH8K
         POXJoqnjQ2KCvj/ty4Q4ZD8DRIXsyMipXmYEiWDyIAUrn4tt/JLD2qViIYj4P95a8k1K
         rFwHK+lNUlundJSovXwMdbpuBBSgE6fLvdqcQKreFcUt/NoSueOGabKHPYQNV/97rCFa
         a1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUsOuhZwRF1VsgE7EMGo6fbgIk2b23vJ7KSSHz42mVhVOwD52uQFHB4ExszgK/fRMOKDq0SfsTxrFLofE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+J1DssZxPQy5XYt5gOD49ZWALUY2PZ1q2WPq0eRbHWCSKCAa7
	snwze1gBf5JLO82IW/Y5rOe9UN6e8licrJNxKDX1SrVEkaijlRUOdH8XGCcsuJ0=
X-Google-Smtp-Source: AGHT+IF4HvDRbWZ701OpZ0aVs0CQKzCEwaD0lVQRRTW4jYUsGFeR4NNUSIABbrcxxUasnWirPst46Q==
X-Received: by 2002:a05:6512:10c4:b0:533:3fc8:43ee with SMTP id 2adb3069b0e04-53a03f1992bmr4441218e87.13.1729152763341;
        Thu, 17 Oct 2024 01:12:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20? ([2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4061bsm17885045e9.25.2024.10.17.01.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:12:42 -0700 (PDT)
Message-ID: <e0ac5665-6460-429d-aadf-beaa9fef8042@linaro.org>
Date: Thu, 17 Oct 2024 10:12:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] ASoC: codecs: tx-macro: correct tx_macro_component_drv
 name
To: Alexey Klimov <alexey.klimov@linaro.org>, linux-sound@vger.kernel.org,
 srinivas.kandagatla@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 linux-kernel@vger.kernel.org
References: <20241016215930.1144527-1-alexey.klimov@linaro.org>
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
In-Reply-To: <20241016215930.1144527-1-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2024 23:59, Alexey Klimov wrote:
> It should be actually TX-MACRO rather than RX-MACRO.
> Rx_macro_component_drv name is RX-MACRO.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>   sound/soc/codecs/lpass-tx-macro.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index a134584acf90..74e69572796b 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -2230,7 +2230,7 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
>   }
>   
>   static const struct snd_soc_component_driver tx_macro_component_drv = {
> -	.name = "RX-MACRO",
> +	.name = "TX-MACRO",
>   	.probe = tx_macro_component_probe,
>   	.controls = tx_macro_snd_controls,
>   	.num_controls = ARRAY_SIZE(tx_macro_snd_controls),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


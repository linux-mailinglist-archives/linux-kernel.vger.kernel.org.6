Return-Path: <linux-kernel+bounces-257175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78EF93763E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA981F24582
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231582C8E;
	Fri, 19 Jul 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiQn2WIq"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46050824AF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383158; cv=none; b=XjldjHGKaqF5wKtuHINmN1OLaCZ0nYYZ5saWaerdNDXn4uJtkEWIODQVuqedprFFkc/VuVp+3UP828tYJkutyB1tO53C6FNwNpmzXsLgDpaaTek9BhugvprMOQRUKj3w09cx5rnaBfSsr46UlR/v/t14zhRDHKS+anSq/t33Clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383158; c=relaxed/simple;
	bh=aVmA+avmUqXiWFPYEm8lwBrN8qK+Wsbxt77EdLdEEjs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ir9OQvVKAOeRtLMJH6n3kui5cjLSuvDqGZyoPUabZ+Vi2xsUtrGbg8J7AnBcFGodVTjvPAweeWZrSdp3f4dkY08Vs8Q9WF7X+MxKwRa9i3qlNR9FYtS4Qvo8U2MjYGtAX8EMT2LoYU2iZp+cytMT0dSpEl4Ax8jS6X/iz6G4sqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KiQn2WIq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3687fd09251so98382f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721383155; x=1721987955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0FPyw9xImHOOOT0F77KVGeWOAXsYnfRWXpu1Qn9tx4=;
        b=KiQn2WIqrz/yeWiZpyszE9WPu3dFttg281HuRcizjz7jeTBZDSoC+C+DJ4NFrskMio
         xVk8YFTyvMp7wSubdGOBkIJZxy5dr/G/oM05zvEWeIpPijOksJ5KoF/w2fTcjfti18RX
         Ara6i70Z/LIm0Lhuks6vrjk+ji/HMNS8irh22Z809O3O/dhf/O7ZbuhIJ32J8f/e7PwF
         T4fBe41qyxFuW0oWc/0GhHv9Ad6X4az0sQxK1b6eHWiHa+O/SebcvfukyVIrbaGAQXqW
         k+p6OBEE5c7un2z43xz1kMJEWRknAh7jACKS6Pm6MEtOMueK7ggd7zhKZ8aRFakDfETC
         PWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383155; x=1721987955;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u0FPyw9xImHOOOT0F77KVGeWOAXsYnfRWXpu1Qn9tx4=;
        b=UzxWUfzIWQus5y3ubjNV706P83g3kZrF7YhVKzdzWnQ1ZLoIOLpKBkkE9D2N0wDIV/
         pZlet9ufgqECKnT5EvcaljHxJSczrSm95aRnf1shNGZ8GMrLEP4q55wRo5zAz6uA4Vuk
         Nu3yurZBjG7NWLXON7QHczMHXrFgrJDyI0YQn52MMCRN+RtEwHrBiQDAqWwqSD6pdlXg
         XlhgsJ6VOqhU13Q+c5D8oOdnKv8gk/WNgSPSzXmJcnWHgkV/FQrm+gwmSfYQw9OnEroC
         h+VT1tzIQpXW5x1O+UTIoImcoH/ndyUyuv7OVc2dzKolu2PrE9KWTcZmitp+MSYrNFd9
         CCvg==
X-Gm-Message-State: AOJu0YzEKhXbU9HCbxVDttic7LIoit7SljDI3cuBu8O+yOgDfAzCnxLF
	ZTQ61WJ/vscf3+/qfx74H7VDrjmnw7Mctyv7Trbk2WYTgu2xdio7OK6DWh9rGeE=
X-Google-Smtp-Source: AGHT+IEW/vrpFybzO18z+EE1eYgzPxmvGwr4RswHCKyvMGlhoo9a2CzS1t/KunO7TkXV0sieu5vNJQ==
X-Received: by 2002:a05:6000:186:b0:368:3717:10c7 with SMTP id ffacd0b85a97d-36837171221mr4656534f8f.4.1721383155186;
        Fri, 19 Jul 2024 02:59:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ec82:adbe:8be7:588d? ([2a01:e0a:982:cbb0:ec82:adbe:8be7:588d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687869447dsm1151425f8f.53.2024.07.19.02.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 02:59:14 -0700 (PDT)
Message-ID: <5c57fbc8-d911-46ee-b421-ec31a00e0f91@linaro.org>
Date: Fri, 19 Jul 2024 11:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] clk: meson: axg-audio: setup regmap max_register
 based on the SoC
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240719093934.3985139-1-jbrunet@baylibre.com>
 <20240719093934.3985139-3-jbrunet@baylibre.com>
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
In-Reply-To: <20240719093934.3985139-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 11:39, Jerome Brunet wrote:
> The register region of axg-audio tends to grow with the addition of
> new supported SoC. Mapping slightly more has not been causing problem
> so far but it is not viable to continue like this long term.
> 
> Setup the max register based on what is necessary on the related SoC.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/clk/meson/axg-audio.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index e03a5bf899c0..2426f3dbb7a2 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -1726,11 +1726,10 @@ static const struct reset_control_ops axg_audio_rstc_ops = {
>   	.status = axg_audio_reset_status,
>   };
>   
> -static const struct regmap_config axg_audio_regmap_cfg = {
> +static struct regmap_config axg_audio_regmap_cfg = {
>   	.reg_bits	= 32,
>   	.val_bits	= 32,
>   	.reg_stride	= 4,
> -	.max_register	= AUDIO_CLK_SPDIFOUT_B_CTRL,
>   };
>   
>   struct audioclk_data {
> @@ -1739,6 +1738,7 @@ struct audioclk_data {
>   	struct meson_clk_hw_data hw_clks;
>   	unsigned int reset_offset;
>   	unsigned int reset_num;
> +	unsigned int max_register;
>   };
>   
>   static int axg_audio_clkc_probe(struct platform_device *pdev)
> @@ -1760,6 +1760,7 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>   	if (IS_ERR(regs))
>   		return PTR_ERR(regs);
>   
> +	axg_audio_regmap_cfg.max_register = data->max_register;
>   	map = devm_regmap_init_mmio(dev, regs, &axg_audio_regmap_cfg);
>   	if (IS_ERR(map)) {
>   		dev_err(dev, "failed to init regmap: %ld\n", PTR_ERR(map));
> @@ -1828,6 +1829,7 @@ static const struct audioclk_data axg_audioclk_data = {
>   		.hws = axg_audio_hw_clks,
>   		.num = ARRAY_SIZE(axg_audio_hw_clks),
>   	},
> +	.max_register = AUDIO_CLK_PDMIN_CTRL1,
>   };
>   
>   static const struct audioclk_data g12a_audioclk_data = {
> @@ -1839,6 +1841,7 @@ static const struct audioclk_data g12a_audioclk_data = {
>   	},
>   	.reset_offset = AUDIO_SW_RESET,
>   	.reset_num = 26,
> +	.max_register = AUDIO_CLK_SPDIFOUT_B_CTRL,
>   };
>   
>   static const struct audioclk_data sm1_audioclk_data = {
> @@ -1850,6 +1853,7 @@ static const struct audioclk_data sm1_audioclk_data = {
>   	},
>   	.reset_offset = AUDIO_SM1_SW_RESET0,
>   	.reset_num = 39,
> +	.max_register = AUDIO_CLK_SPDIFOUT_B_CTRL,
>   };
>   
>   static const struct of_device_id clkc_match_table[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


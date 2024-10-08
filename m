Return-Path: <linux-kernel+bounces-354668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 186499940BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9626B1F21F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2460208220;
	Tue,  8 Oct 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtUJd+d1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDC207A2F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372663; cv=none; b=kg1wJ5rKABTvAdGBiDAADty71DYbmvE04PjUBOv6XrtQTCrNcMDgnQQk/fbUAmh+d1mYI44skzF3T1yar90D779TnAqAa15MchEPKUspobE9OhhTz6/zpna5BhgyrOMMbXEs6j9E4H9mXIvUCTMdW8GsL55pZ7n9g47AWhabnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372663; c=relaxed/simple;
	bh=S1axFPSi2co5rL9BqhMEa1HoKRtSOBfCc2BU7lqrtfw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FKwr0qbrl2t+2WKwgihBrz1V54Z+xBboZsEW6bvemnJ6p7m0maIdrNvOEEs7YgGxNP4/PtkIMTmKITQpMwcwmc1/KOLi43VrZLq4kw7fPBt/4o6VWQmb5dfIt12gDJbjTHTvcqywBWBGbibrwv32k1Kovp781vKRig3lTEzQQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LtUJd+d1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso54549905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728372660; x=1728977460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIsj7vFU+ti15juRCV95G7yXqGY4cixULIvln2kgDKs=;
        b=LtUJd+d1TSS3pzAcUp42VCdoS0++x0oNW/FFb5mvpJSJD3KrkcJNj62SdtE26MSIaU
         xeAfuaJxtVoye7PbYkx9fTmGxEYeTienXpy18eSju3a0GxDiPSJc0MnDZwwV1SIaimTQ
         Tx2E2EpqcQPtgg1AZrpn5iHE47liDPUE5zmlLbrLJAZHGZciK2XMX9k6LJG3dQplvq2R
         sMF/hlcOi2IAZKz/+rctN7JP7loenFpp6xqsVYTz3JlWqgJhVnGLq9/gZQj/gJD8DVJV
         BjROdSQMV7Bpye2nuKy6swJM6A18hQQ36o/uPfwNrUjCwaSBzuzTYz58H/0uACTj2KxZ
         MnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372660; x=1728977460;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pIsj7vFU+ti15juRCV95G7yXqGY4cixULIvln2kgDKs=;
        b=wjjji01C5wSqipgjyRiOoCzPPaHsT9LQY3aSyfju2lz6lFOz+61diz2gGEn2ikY8kx
         tkABPfbT31FM41FW7Da/sbEdfUJa+ohaSR9AN2K8/8rjxCwk5Lc6SXeXRglucAmrsrTX
         Nbwzq6LAncZGJ4iumP+SfVBh+C+O1i0BbozmXn38CpOeQMn3eFKbarY8cCZAzSG/2QLC
         OtjShyVVMTtWioTlOi1QGSitKNQg3AoiEw0ENEUnMUg3swhZN4zUT74G2GL30SjdTWWx
         WWYyLrwY3QyrCHFOsMGX+Fs1NVh3dy8/I+I0E4aPUWX2wYCss51GRQjUopLP12q5bBKa
         /s8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEHHgjOH5XT3uhN63Rj+4RaWtBHhlsczPCWmzGceX0Itec2RxdgcoWdQlAJT+L3rtoLjGOAgwVjaMZ3jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl9oq4xfFE5pIm4Vlx3VFpzAvC4VWyh8ipZyWAG5U4MoOWf1A
	JA/xSIFrnGik7nlkWnPkbAV17ljmwlLofjq220l8d/wPR2pngSWblj1DFb+c1N4=
X-Google-Smtp-Source: AGHT+IEEye3Mpw5XNsLq4JeONQXCqWUOttfon77FTqlVClT66bGon9wfQEoByrAQNFgWjFDOyEuoaw==
X-Received: by 2002:a05:600c:1c19:b0:42c:bae0:f057 with SMTP id 5b1f17b1804b1-42f85aa7f6emr113500445e9.8.1728372659623;
        Tue, 08 Oct 2024 00:30:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b444f1sm117030575e9.38.2024.10.08.00.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:30:59 -0700 (PDT)
Message-ID: <7240d7c7-fc7a-4866-b8f2-bf0180525bce@linaro.org>
Date: Tue, 8 Oct 2024 09:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] pwm: meson: Use separate chip data struct for
 g12a-ee-pwm
To: George Stark <gnstark@salutedevices.com>, u.kleine-koenig@pengutronix.de,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com
References: <20241007193203.1753326-1-gnstark@salutedevices.com>
 <20241007193203.1753326-3-gnstark@salutedevices.com>
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
In-Reply-To: <20241007193203.1753326-3-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2024 21:32, George Stark wrote:
> PWM module of g12a SoC family has different set of features than meson8
> so use separate chip data struct for it.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   drivers/pwm/pwm-meson.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 5d51404bdce3..6701738c55e3 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -578,6 +578,11 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>   };
>   
> +static const struct meson_pwm_data pwm_g12a_ee_data = {
> +	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
> +	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> +};
> +
>   static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
>   	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> @@ -624,7 +629,7 @@ static const struct of_device_id meson_pwm_matches[] = {
>   	},
>   	{
>   		.compatible = "amlogic,meson-g12a-ee-pwm",
> -		.data = &pwm_meson8b_data
> +		.data = &pwm_g12a_ee_data
>   	},
>   	{
>   		.compatible = "amlogic,meson-g12a-ao-pwm-ab",

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


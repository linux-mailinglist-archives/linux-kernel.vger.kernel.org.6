Return-Path: <linux-kernel+bounces-211909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107599058B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA591C211C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393DF181305;
	Wed, 12 Jun 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tV2jylZR"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00601802C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209553; cv=none; b=lCXWz2lRuDfTL/s0TEqjNFZTSaagbW2FiZyGc2sV1boqJ6CVLeqA8fvYW605/+cfG4euLlcpjWPEzqj7XynD3yaibsK+qyDXUMgCIkV8R9v3m8cXU0j9vGh7RUhQMfoa4eN8UCQVAS0Cxv7Nxr7xympNgXM1EcVe+s/Zo77Ylf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209553; c=relaxed/simple;
	bh=kazjMwMPM7+BaE98JZalJ0lO49ZQxBkOr/z5sxs65no=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P/cxaTD3ZN3sGNyhiDWPJNIcubPDbNuRM3owjg8hRJsucT/C377NvFNf6b4KN9jUFDTUinYhAbOhFiFbcK3H8tUHJMJbbxf4NQ30spfaDJtHblNVacPtJdRc07rk9WIPAr3i+FdxymtUhyG01geWq1VbyyS4wxwuj9fP8N4H1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tV2jylZR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso7619875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718209550; x=1718814350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2np9w3QHSPJqnM8MM0Xd2cDLW2LnmlXwKByUrOyRVR8=;
        b=tV2jylZRdVZTDA46kbu2/83HqVU0PQG/mnE9J4JTUMyvcUGIsPdJHdNkdeGz8dFr3z
         WYh4tzAnAvXWKsUemA5uKypxWd7mDxFJsS06z9e0FlzC7pFBcWlasQNbRKeKZmfI2UPF
         BXiO1BcP2dbzMN+JfH8iT4loMUpHOlrOiiCuUI6PFgKAPE50AkpKAYsddIJZlVU1uYuP
         kX9/1lHuafy4XWOD+tC7lEqizxcWu78DiPvZ7Azgf/asxuaqB5IkliPWGvtbDttIzEkG
         tG6DANg7ympzty/ooLL3h71quSeZGdKpbw0Ih7wn0OrJKCRYymw9ROaCd+t2eAd5hhJH
         ixFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209550; x=1718814350;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2np9w3QHSPJqnM8MM0Xd2cDLW2LnmlXwKByUrOyRVR8=;
        b=uumGnlqA9zZumc//26hevpIALe9yIqkf+ffPEP65S3aSFO56GCrMCvoJh+JFcUPqp3
         oSOq8liYZTHV5oR8I8Y2g2iFnyVz+Doy3wIwctLjDfKpRcYCR4Vs75aeOWRU4I9i5mKT
         FDEGUYAdd80X62dz+tevN7CHx9UIafaVhsEjFLiljG4XWnIAShc5jtdTcSkiG6CMHsJJ
         5JdYE+t2kUDVg+sGLspMz98eeOCNBupdc0my3rEePaQQQJQkP0zxokevdfE6aqk5JOyJ
         wD80fws3DSChxaHFINxtEr7AFOzyM2bhhXQQzvuFL04zI2jocyJfixUgk0lBVaGlanDk
         W1ww==
X-Forwarded-Encrypted: i=1; AJvYcCWUABfUmk0eUxer20suIoMERjxjZCUHg1YFP+X9HcFzuZ0ahC91Utnj4cxD4QJWLNYFJGh/b6aG5yRvKnJpNEXFjz2K+feegRK/T+1T
X-Gm-Message-State: AOJu0YwK9L8ZyNMaNTTymTvaFnLw29leCy7uNH4pHr2bIuczOx0L4OSv
	Kar0K16F1Q9FxHEKKbWnGXaiq4/V0YyPvzy/h+f6XkQilvjAIdfA7VN1F+69DHw=
X-Google-Smtp-Source: AGHT+IEoQt3WNR7/jM2T/i1+onUQqJAvvVpdcAZwjdoKF5deS673rFKH/q2DZsR29dudBOG0pHLyAg==
X-Received: by 2002:a05:600c:46cd:b0:422:291:6b3e with SMTP id 5b1f17b1804b1-422b6dc8178mr1963445e9.1.1718209550085;
        Wed, 12 Jun 2024 09:25:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb? ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871f8eb4sm30654665e9.39.2024.06.12.09.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:25:49 -0700 (PDT)
Message-ID: <441e083f-6565-4b75-bb45-a153d2ba439e@linaro.org>
Date: Wed, 12 Jun 2024 18:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 21/23] ASoC: codecs: wcd939x: Constify wcd939x_sdw_ch_info
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
 <20240612-asoc-wcd9xxx-wide-cleanups-v1-21-0d15885b2a06@linaro.org>
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
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-21-0d15885b2a06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/06/2024 18:15, Krzysztof Kozlowski wrote:
> Driver does not modify static wcd939x_sdw_ch_info array, so it can be
> made const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   sound/soc/codecs/wcd939x-sdw.c | 4 ++--
>   sound/soc/codecs/wcd939x.c     | 2 +-
>   sound/soc/codecs/wcd939x.h     | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
> index 8acb5651c5bc..94b1e99a3ca0 100644
> --- a/sound/soc/codecs/wcd939x-sdw.c
> +++ b/sound/soc/codecs/wcd939x-sdw.c
> @@ -23,7 +23,7 @@
>   
>   #define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
>   
> -static struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
> +static const struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
>   	WCD_SDW_CH(WCD939X_HPH_L, WCD939X_HPH_PORT, BIT(0)),
>   	WCD_SDW_CH(WCD939X_HPH_R, WCD939X_HPH_PORT, BIT(1)),
>   	WCD_SDW_CH(WCD939X_CLSH, WCD939X_CLSH_PORT, BIT(0)),
> @@ -36,7 +36,7 @@ static struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
>   	WCD_SDW_CH(WCD939X_HIFI_PCM_R, WCD939X_HIFI_PCM_PORT, BIT(1)),
>   };
>   
> -static struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
> +static const struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
>   	WCD_SDW_CH(WCD939X_ADC1, WCD939X_ADC_1_4_PORT, BIT(0)),
>   	WCD_SDW_CH(WCD939X_ADC2, WCD939X_ADC_1_4_PORT, BIT(1)),
>   	WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_1_4_PORT, BIT(2)),
> diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
> index 1f94f49f9829..66af035bd0e5 100644
> --- a/sound/soc/codecs/wcd939x.c
> +++ b/sound/soc/codecs/wcd939x.c
> @@ -414,7 +414,7 @@ static int wcd939x_io_init(struct snd_soc_component *component)
>   	return 0;
>   }
>   
> -static int wcd939x_sdw_connect_port(struct wcd939x_sdw_ch_info *ch_info,
> +static int wcd939x_sdw_connect_port(const struct wcd939x_sdw_ch_info *ch_info,
>   				    struct sdw_port_config *port_config,
>   				    u8 enable)
>   {
> diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
> index 756f497a337c..a6c9c6cee056 100644
> --- a/sound/soc/codecs/wcd939x.h
> +++ b/sound/soc/codecs/wcd939x.h
> @@ -914,7 +914,7 @@ struct wcd939x_sdw_priv {
>   	struct sdw_stream_config sconfig;
>   	struct sdw_stream_runtime *sruntime;
>   	struct sdw_port_config port_config[WCD939X_MAX_SWR_PORTS];
> -	struct wcd939x_sdw_ch_info *ch_info;
> +	const struct wcd939x_sdw_ch_info *ch_info;
>   	bool port_enable[WCD939X_MAX_SWR_CH_IDS];
>   	int active_ports;
>   	int num_ports;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


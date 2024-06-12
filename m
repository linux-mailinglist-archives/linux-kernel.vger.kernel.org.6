Return-Path: <linux-kernel+bounces-211913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C189058C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9983A1C21CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A8181D1A;
	Wed, 12 Jun 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJb/MuFQ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51F181D14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209567; cv=none; b=ZcDHLrxVtIYoH69YmjZSF6J+zwm6yt3gIQDA0muP8S4xmL6UefKxz1J0TdG+wlBsDW4hSlJWVjPsXmiAoOnywn5lYZW50Xz0618iBAGDK9UBKjL7hNDz0crzdZkzDxPJOFUPz9JkjYI28mPhbCIdpXLFy2RFTPKbUPC7los9GJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209567; c=relaxed/simple;
	bh=KRtJmgKGaGlE/Ies5zn5gjl/1GbwNz2EzvchmHQy87c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lQ/498QgjL2mwvM5prvHt/OJytD7c2r+ovn3ZlfIuq96tPehElaRRbQ16NT8cLtdLL5iY+Z1NpnbG5L5s+Bqbfp5fyFSZDpmoWbsepnv+zwvUQKlSVTe8ekKlhUbIQX5wcaWi8BaLfoZqjyxgek4NQosXg8/RE1juPxEQkuqN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GJb/MuFQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaea28868dso72100631fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718209564; x=1718814364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4CzpWsbxSKz1roonYzk0gRK2GwO4Ov8gCgr8aeKewE=;
        b=GJb/MuFQzYqTU32m0buHCig7VLHwFa1f/Kz6RE7JofryYrlvOwckj7W7EJD4D+ah7t
         ypo+b3bZRxdeRXu3E2UQVYxhSumyhqx2RgfsqWjO4WfoC2jcJ+3BOp7mR+/4gJTlSqJ1
         6TTA0CyYAomtl+pgGnrZhrq56BnZ+gCtIqvoMqHE5SHxDbx2jZ3RbUM0a63AWpQFskoY
         DhFo4tlHNNkg8qjQnloIOcV3AaBCCk39Bv5pSlAN/qeJ6XRiNROsNJaKNXjAoSBT+ySa
         3NtZjeg4dLFO2aaE6/AyhZ5AFEwU03+qONRFvVqDTOulALAACdpzMMQGwpBg0h78AV5t
         /0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209564; x=1718814364;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B4CzpWsbxSKz1roonYzk0gRK2GwO4Ov8gCgr8aeKewE=;
        b=I60xXakCVSIs0WicGirudr3beQjktGmqolK8nQn6I9gUfgcKv5RI6h2dfn0c0F1CWd
         eSuFniFuf/h3EbkoZun4+3/ibD1zceGTh+coQhXu/eX0m1l1Vyfhb4nLp5FRzMKaHeYl
         0QCq2suS7uzyfmt6qBGRTIMX/G2msQPqoQLwCFRUAxRAuI4yw1/Wzjy87sXzq2/Mbdgy
         indLMJ/euFn55S/aUz0t2+K24/jZFgZ9iNTlTjGZx1wpQKDH+FJoNvRDfDYIWhbVoOYq
         VM4uDo54iWUyFRYf35d3sxrhk4UccoDYZ04tZFKIt/La9pJYm2AqInPL7R2DUQkXB5Oo
         CeUw==
X-Forwarded-Encrypted: i=1; AJvYcCWVIAVGqLqmMEUzBAK+VYvq6IZLpgthN6zGehu+EHunEdqjAO8f4GZYdSWQlAUivhlKUv7xV5gwrDmfFYA0lFzmGhfGgweZ7cl9tWj7
X-Gm-Message-State: AOJu0Yzlv+SCO8u29XYG8rlvbdQVOJLChGnqV+LhTzh983YNzl12wToc
	QYCwQQ1ClYwK6pYyJk04vLUvhI47mqNu4DsNWPDpQchN5cbglYEVcehjVJ7nz+8=
X-Google-Smtp-Source: AGHT+IGlKKg9fhb0xZHGfo3tji+wvOb/OIXqd/ZTK5BzeZKQNp3X5O5tIeFGZyOPNdpWG+Yi3le/Ig==
X-Received: by 2002:a2e:9449:0:b0:2eb:fccd:fc12 with SMTP id 38308e7fff4ca-2ebfccdfd24mr17385251fa.2.1718209563913;
        Wed, 12 Jun 2024 09:26:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb? ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870f0c65sm32402695e9.27.2024.06.12.09.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:26:03 -0700 (PDT)
Message-ID: <828ff7cc-462d-4433-ab68-ce139a31fa24@linaro.org>
Date: Wed, 12 Jun 2024 18:26:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 23/23] ASoC: codecs: wcd939x: Drop unused num_ports field
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
 <20240612-asoc-wcd9xxx-wide-cleanups-v1-23-0d15885b2a06@linaro.org>
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
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-23-0d15885b2a06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/06/2024 18:15, Krzysztof Kozlowski wrote:
> The driver does not use few 'num_ports' in 'struct wcd939x_sdw_priv'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   sound/soc/codecs/wcd939x.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
> index 0aa4d9d542c6..1571c2120cfc 100644
> --- a/sound/soc/codecs/wcd939x.h
> +++ b/sound/soc/codecs/wcd939x.h
> @@ -912,7 +912,6 @@ struct wcd939x_sdw_priv {
>   	const struct wcd939x_sdw_ch_info *ch_info;
>   	bool port_enable[WCD939X_MAX_SWR_CH_IDS];
>   	int active_ports;
> -	int num_ports;
>   	bool is_tx;
>   	struct wcd939x_priv *wcd939x;
>   	struct irq_domain *slave_irq;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


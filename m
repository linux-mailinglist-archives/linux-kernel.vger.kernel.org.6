Return-Path: <linux-kernel+bounces-444613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B09F0994
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E571886026
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D221F1B87F8;
	Fri, 13 Dec 2024 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGUe8sxx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6F1B3958
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086078; cv=none; b=RTiI/L2xI9kiJsq+cpWNTTF9E8wMQO36+qVwdGrLnyRsYu8rfLnje/CJXpIlwAnEqGld+HJI/N0FSW4J1MDPa9JwNxHQFR4zzZhfV6aI9mx2k0tPdgTuaEjRFOJAl9qJ/0Z4G0OQ8wuB48B4AK1if7L82VoAxTurB0DOW51QqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086078; c=relaxed/simple;
	bh=vA7NH8o/F4vK4PbMAOETXVFvHlJYHLaG8zCc6moiqr0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QjKaN1H3A5FUxkamqOYRWb4UjjLYjk6Vz9UrMA6Gc8d6eDryXOu16Lz3XmYIX0v5eJKY8OEQAwCHiDzWlARPpCDA3fVbRe80Y2vOCR13aqHBanwo0nB7VCRrw7aewu4obM12/yQdNluQZM5ye3+jcCmguTCJExW2U1lXp7/wcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HGUe8sxx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f664af5so16677885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734086073; x=1734690873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WA6drCMppYdVISfpkuD87PDa0h+Hfy91b3d0JmUIEnc=;
        b=HGUe8sxx4NFRCvxg8UEXk5FFaCQfGU59AHpOOVNAlHdzftn483xukzwL6N8pUTkQD0
         Jergi81k4oUzm7I3eiPiPFMsbNCOGxHK31viB2SpZbuWJpykAvxhiwWFswLCTfwyMltB
         70VbVk+e4nVsaeJ7r2e2z85oMHieo8tlZ4Ht8ob5HX1PG29k2Z6CMbTGut0shdLPctva
         4dJsGuhs/0WzP4da2FC9c1QkaniIZlgV7jlVUebKl9tMMrW2pVaA0louugI9aeI8KUfp
         eMjyQ/1fqfKgQTjX0cG5pg9yMyQW4+XVeXtE4Hq59GZXx5VYrrdW/3Hkz9D3opg7swL5
         PCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086073; x=1734690873;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WA6drCMppYdVISfpkuD87PDa0h+Hfy91b3d0JmUIEnc=;
        b=PwxxY2SrzLAo3nG//nu9Db+tnMElSevYcbdGICFgtpK9nNjRnIgATXIYJ2jmQIcgfC
         +bn3tQGy8n1XtRVaTZapiDGDTyTXFqwjFzm3Ut6+oYFo3gTw3DAnnfgCGFy1WB6AfLEZ
         pjqqa7ezK8dWjw/ssp8XrgjBuQFyT2frIqAUOa1hDsej+G8Gpg+JGOX6UeGOb6kjMRNh
         A6hVP6zavrGfkDXi3dsMUUpeoFP2H2UT/yX3lH/c5wt8yIbKkHRAj0UQVULkem3/UG8G
         +LEto2qu8MPpqpnyASE8D8GY+HssBqmusA09nupwSUoA0BsdyuBxHuXImAjVkDSAuJPu
         /lYA==
X-Forwarded-Encrypted: i=1; AJvYcCXFexKxGYOKjJBzbfcAGUO+T/syurpLhLhRhhx43ozTOPOzro5Yt5U6AoPy7PeTk3W33uoYwS20iJ9Soc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjc4bNBoIgmq1RdVGbW2K+6ayz4bAUwceqQsPpnsXSYxXEhRdS
	jXyWd7EyWqrhsHO4bsVc26cLZMYfxlKtcZKnsBiNT4eYTGBmFyshLi5Q4TLxTJo=
X-Gm-Gg: ASbGncu1z+ks0My5GHiPZpYQ2CGR40fIzEOHfOWxpsJMfd3ivu4W9l30mOE0tFtAmuu
	CENBG7EG39nbBwlQswx/2G4ZkGRo8j8rUh9TMzdumD/gio4mtJyKupsIt+6QjWeYGqvwWcyiJKq
	8zKKH+dilfqsm6feXRB+0YV31Imd2e5uDPFT81U3QfDzZOLuAxFA7Vmi0Bh1+Buxx0xlHPFsiF9
	NT+N+3leP1wO0G560NpUWKXe7h7JkhzjSClM6Dy2zz1qlZ/lEEQ7I01Rg/QACpYoOLfrynlse2/
	IfTCY2yZRwQtkYGS2r9+XYcaLt05uyYhsA==
X-Google-Smtp-Source: AGHT+IE8QIvOjYdMGFe/6r6ILHvAeGLSVV3a3eXEBuyeoNQwwo9IPedJWyk14Nak5HhAqjkv4xRTYQ==
X-Received: by 2002:a05:600c:3503:b0:434:ff25:19a0 with SMTP id 5b1f17b1804b1-4362aa94379mr15608885e9.21.1734086073135;
        Fri, 13 Dec 2024 02:34:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4795:2d16:2587:ed70? ([2a01:e0a:982:cbb0:4795:2d16:2587:ed70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257178e3sm45453865e9.41.2024.12.13.02.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 02:34:32 -0800 (PST)
Message-ID: <cbf51c06-2183-4423-ab61-65a93f903a04@linaro.org>
Date: Fri, 13 Dec 2024 11:34:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] clk: amlogic: g12a: fix mmc A peripheral clock
To: Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jian Hu <jian.hu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241213-amlogic-clk-g12a-mmca-fix-v1-1-5af421f58b64@baylibre.com>
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
In-Reply-To: <20241213-amlogic-clk-g12a-mmca-fix-v1-1-5af421f58b64@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 11:03, Jerome Brunet wrote:
> The bit index of the peripheral clock for mmc A is wrong
> This was probably not a problem for mmc A as the peripheral is likely left
> enabled by the bootloader.
> 
> No issues has been reported so far but it could be a problem, most likely
> some form of conflict between the ethernet and mmc A clock, breaking
> ethernet on init.
> 
> Use the value provided by the documentation for mmc A before this
> becomes an actual problem.
> 
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/clk/meson/g12a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index d3539fe9f7af5538201a78ce560f662ddb3935f2..20be7b037c07535bd2115f6e70404a95a7832756 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -4311,7 +4311,7 @@ static MESON_GATE(g12a_spicc_1,			HHI_GCLK_MPEG0,	14);
>   static MESON_GATE(g12a_hiu_reg,			HHI_GCLK_MPEG0,	19);
>   static MESON_GATE(g12a_mipi_dsi_phy,		HHI_GCLK_MPEG0,	20);
>   static MESON_GATE(g12a_assist_misc,		HHI_GCLK_MPEG0,	23);
> -static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	4);
> +static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	24);
>   static MESON_GATE(g12a_emmc_b,			HHI_GCLK_MPEG0,	25);
>   static MESON_GATE(g12a_emmc_c,			HHI_GCLK_MPEG0,	26);
>   static MESON_GATE(g12a_audio_codec,		HHI_GCLK_MPEG0,	28);
> 
> ---
> base-commit: 52fd1709e41d3a85b48bcfe2404a024ebaf30c3b
> change-id: 20241213-amlogic-clk-g12a-mmca-fix-c9ebacf34d9c
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


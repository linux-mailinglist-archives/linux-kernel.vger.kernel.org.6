Return-Path: <linux-kernel+bounces-253556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984A9322DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F31B2399F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D613C90F;
	Tue, 16 Jul 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAprqOU3"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022D8174E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122278; cv=none; b=it78NaBfR0vX1aCnp83HDeDa+cA+cveaqdfUAVvaofOk8yjtPboSofbvdtDtLQCVlCooyeR+/xk4wzrbdESVNnKhrW/0zmMDjaz1oiMPBYW6z3lj4/oXv8liO36q6K4pyAqD10yeKsxVFDLLgomsuUDhEQKbGdTd1HsREJ8uYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122278; c=relaxed/simple;
	bh=0moHxkUu8Y4OWu2fjZzgyynQDnEnO2bmMxDP6PLC74s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KcuyR/BOAP1OzKlVlCn4mQypVaGVS/+4VxFYtpNtKyKIUPd34sCsf14G4bZ4p8qWWb4VKLFeFgCosbnPczE8ksVaF1NWGO/fFKMFDhbOhJZZYEivhBAnY0vP9p0GCKcxvxtJMIAPWKIyaKvibs/GRK69RjyaC/UyHkCI5TGAKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jAprqOU3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3678aa359b7so3803293f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721122274; x=1721727074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3XPgAt48srnAztLIzuoC1J0XiQCx/jCefxsjT5J7rg=;
        b=jAprqOU3FZjZlf/r30XoJKuRJSH0315D7jOBRphuqvX4FBnXHCqNB21lXtYBWPiBn/
         KaX7hSnkgtD8XaFZiOWfpjx6ZqEsLjQGc/BL3kPWYKkv/kNyx7Lcwy8p6L6+9Y7pPq6W
         0z/iOi/m7CZrx6BKLZEF6Vd60nh2FMOMQEN4OA2YVCuVy62deICeRseXBxpodLWSeI4u
         j2JUw01DgYk+V6kqX8AqkrKza/xWhItufsdv0SYaJqCorWN/yZ4xlbcqt1GfDlz4xqPA
         pztp7/hChFVAl4+vT3sEpn7jGtNjuiNAHl62TYSwOiQ4xejBzp2dD1qN/mJ2q4b8HvBr
         5qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721122274; x=1721727074;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/3XPgAt48srnAztLIzuoC1J0XiQCx/jCefxsjT5J7rg=;
        b=rJYbDxXanQlVKK/5ijPOt6FvZcZz6F3ImP6PIoG1Q+A1fMQ3GDX2OlL9k14GG+lXXy
         5gm11XlL338tbUjb0cGQxaxOJIHt8xmDgBjjXD/W6qCjpOPktTcxy25dfSwitamK2HdX
         VNiS0eNd1MGHtH3BVkQ2bVx4xCIM/dF8qcEJLx2cnv2cQ8SXxX246aWIe2JRfutDc0fz
         DZz/+WcloF0iaGHcMXESZpIddD7KNqpYtXeBjuAfK1LctcG+e0Ym/ahjXMHv9T0daxvX
         hFmxvzgT2ZB0jyeBf/uBZAkbYnAB3hE7swObA0mxymVd1YncPb2vUj/CxG7pdZuKKCpU
         g0xA==
X-Forwarded-Encrypted: i=1; AJvYcCVssG6SGx9s47N6hIrYkEdRTGVKpKO6e4widOKRV6BmhrcbO3IzVOPn+D4iihr7Q+CselyoZ4EL0ZPUSK86Kh6LNV2AsMN7bwgGR/w3
X-Gm-Message-State: AOJu0YxuvX9Gxi4XVPaWRgBSSwV3uDRNj36qqafzy1NrIT5Giv621cbW
	r8WpyZBXFwzyKpvoPBAEQSFwuNSgeZrSYaatTQzWMyaDdMmLAwpCmZaBUmf61hH0xqdVNQpT0qz
	O
X-Google-Smtp-Source: AGHT+IEsoVQDst/Kjz0dNTZ+V2Ucj1q0C8sc7k04Z3Nnr89m+A/TxT974j0Xb0GNVhMDpxtbmTVxlQ==
X-Received: by 2002:a05:6000:1c3:b0:367:42ce:f004 with SMTP id ffacd0b85a97d-3682753bc1bmr957383f8f.23.1721122273957;
        Tue, 16 Jul 2024 02:31:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197? ([2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3e27sm8484413f8f.15.2024.07.16.02.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:31:13 -0700 (PDT)
Message-ID: <56a90ea2-6bba-42ef-b615-61f8c797e09c@linaro.org>
Date: Tue, 16 Jul 2024 11:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] spi: meson-spicc: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, broonie@kernel.org, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 yixun.lan@amlogic.com, sunny.luo@amlogic.com
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240716091151.1434450-1-nichen@iscas.ac.cn>
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
In-Reply-To: <20240716091151.1434450-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2024 11:11, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/spi/spi-meson-spicc.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index 8838a98b04c2..1d05590a7434 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -655,8 +655,8 @@ static int meson_spicc_pow2_clk_init(struct meson_spicc_device *spicc)
>   	}
>   	init.num_parents = 1;
>   
> -	pow2_fixed_div->mult = 1,
> -	pow2_fixed_div->div = 4,
> +	pow2_fixed_div->mult = 1;
> +	pow2_fixed_div->div = 4;
>   	pow2_fixed_div->hw.init = &init;
>   
>   	clk = devm_clk_register(dev, &pow2_fixed_div->hw);
> @@ -674,9 +674,9 @@ static int meson_spicc_pow2_clk_init(struct meson_spicc_device *spicc)
>   	parent_data[0].hw = &pow2_fixed_div->hw;
>   	init.num_parents = 1;
>   
> -	spicc->pow2_div.shift = 16,
> -	spicc->pow2_div.width = 3,
> -	spicc->pow2_div.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	spicc->pow2_div.shift = 16;
> +	spicc->pow2_div.width = 3;
> +	spicc->pow2_div.flags = CLK_DIVIDER_POWER_OF_TWO;
>   	spicc->pow2_div.reg = spicc->base + SPICC_CONREG;
>   	spicc->pow2_div.hw.init = &init;
>   
> @@ -721,8 +721,8 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
>   	}
>   	init.num_parents = 1;
>   
> -	enh_fixed_div->mult = 1,
> -	enh_fixed_div->div = 2,
> +	enh_fixed_div->mult = 1;
> +	enh_fixed_div->div = 2;
>   	enh_fixed_div->hw.init = &init;
>   
>   	clk = devm_clk_register(dev, &enh_fixed_div->hw);
> @@ -740,8 +740,8 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
>   	parent_data[0].hw = &enh_fixed_div->hw;
>   	init.num_parents = 1;
>   
> -	enh_div->shift	= 16,
> -	enh_div->width	= 8,
> +	enh_div->shift	= 16;
> +	enh_div->width	= 8;
>   	enh_div->reg = spicc->base + SPICC_ENH_CTL0;
>   	enh_div->hw.init = &init;
>   
> @@ -761,8 +761,8 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
>   	init.num_parents = 2;
>   	init.flags = CLK_SET_RATE_PARENT;
>   
> -	mux->mask = 0x1,
> -	mux->shift = 24,
> +	mux->mask = 0x1;
> +	mux->shift = 24;
>   	mux->reg = spicc->base + SPICC_ENH_CTL0;
>   	mux->hw.init = &init;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Return-Path: <linux-kernel+bounces-211676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D990553E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7438B2836F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027C17E463;
	Wed, 12 Jun 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLSZLAUt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855417DE1D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202907; cv=none; b=f5DGF8xqPg86e91kRrvUBeASCq5Z6L1n5HBsal7giVZlifSMJvdzKNdHSd5mGC4+oZ48dZNJZZpqHyI+Cb6Mj7+NZUJtxYH0bCwnSMwShdADxsx16Z87c59xklQdqJPqxVBmKfrzdnl6LBD3aXMeevbac6HO3LFfXvn4DgArpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202907; c=relaxed/simple;
	bh=CJF6WXOxjBKKQGfYbRw0AbGXHFxgkGVBGBpz9drwwfs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vCGGi3DE3qeoTdJDg12hAhpQUNKzMdQ1juLfLIAA3tuBMdJYKknfc4uSUGrjmSpxujjDbcRLDuKyPGbIUJzJowJt2/avz2GYTMxv5Xv3FafFpn/6Dl2XKwGIfTCaJJ9xhosG2o2HMmX5NeoQ3MZVah+pulyiAjG1MydArYo3TRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WLSZLAUt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so35696925e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718202904; x=1718807704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0d3nemtLTIlGYr0wQiRJe+hWAQzd6FHXLae79gtynBo=;
        b=WLSZLAUt1+/7Ecpv24IYv2xlsWbtxZ7JyfLEQpmbNf2+8Ezn0yPvoiwuSCgmA5EdVY
         lzRx6KnSa4O5e3KqOIEzaVuoCFBoBquMefBXjJkeNZS1CCN2qHcu2h+Knde1yfW9n0ds
         lSlp6yG9weNKstEOe5fGLODGDSAZM54JFSc6RHaopmUSeolS7QQFD84SsKBek7eV2zem
         iB0pTqFkP9NIPeDkytXWc1d5JBEZliVHZ98Gx1RXQ4mcF4azu1pZPuJJQPyfXmAoAJcw
         TTXji6swQ/kkzqCiCDORS+67OedWRqWPVKMEgkFtxUQc7FOoa8gUX4E9i12WWU19LVJZ
         +ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202904; x=1718807704;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0d3nemtLTIlGYr0wQiRJe+hWAQzd6FHXLae79gtynBo=;
        b=BH95FrGLgdxm9NNo0nq6ZefjSAQw04SBywoWO37z4pma1ZgfhQ6up/oz50yh08v0i8
         gGVDtjWRYdjb2VVsGYEI4rrFIk8QYw9jrwS+3YPIz4Lau32304qXbXql0ihPFrT5IAXS
         pXEu0eJrYLcedPm+VWVoAYUAx5s9AaJhbuiclhIKMacXfWz+27qB4bAv6n/YlByOhx6C
         jzVs30TaBwI/v4smtjMV7Ikdddc/kpEJQaOmC7ZDIoLxS2HonhMgIwgT8XDyq15+otJv
         Q7LK3zGSm7tU87IQ6pAyAVbs2Ykd+NAruw5kgSI1XeWSIpahyHhHEUcYbpgU9tIxiqYf
         t2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Sv7oCCNzPgC04JYkgw6neQpgS7MVZYAIXaQaxyeRJsvOT+8DM7bRdBGUrKgUcFz7MyLP4oMyoqFQYuL707ApSozf029nzkZYJIMN
X-Gm-Message-State: AOJu0Yxc/eJKUKv+7oeJxiVp6A3uFfvgsjl278nmYI+K6zctFroZmbSc
	74cUO+IGWoDHyMzKTESQkP8/ss6V478vpJGOa3F1wrp40k79PpHB98nOd6cYaH0=
X-Google-Smtp-Source: AGHT+IFdR66CEHF3pbbU8fAxsgoAgu2w+lXVGwcwRX1cvGhBLBdMA1CA0IynRV9+5vuANlVWMo80dQ==
X-Received: by 2002:a05:600c:5487:b0:422:1a82:3ebf with SMTP id 5b1f17b1804b1-422867bec26mr19747255e9.35.1718202904586;
        Wed, 12 Jun 2024 07:35:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb? ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de623sm29220775e9.31.2024.06.12.07.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:35:04 -0700 (PDT)
Message-ID: <de0672bc-b75b-48a8-aa01-2ed7b89aeff5@linaro.org>
Date: Wed, 12 Jun 2024 16:35:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] spi: meson-spicc: add spicc loopback mode
To: xianwei.zhao@amlogic.com, Mark Brown <broonie@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sunny Luo <sunny.luo@amlogic.com>
References: <20240612-spi_lbc-v1-1-d52e8c8011bd@amlogic.com>
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
In-Reply-To: <20240612-spi_lbc-v1-1-d52e8c8011bd@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/06/2024 11:44, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add spicc loopback mode for debugging convenience.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/spi/spi-meson-spicc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index 8a4a8ba9dfed..8838a98b04c2 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -514,7 +514,9 @@ static int meson_spicc_prepare_message(struct spi_controller *host,
>   	/* Setup no wait cycles by default */
>   	writel_relaxed(0, spicc->base + SPICC_PERIODREG);
>   
> -	writel_bits_relaxed(SPICC_LBC_W1, 0, spicc->base + SPICC_TESTREG);
> +	writel_bits_relaxed(SPICC_LBC_W1,
> +			    spi->mode & SPI_LOOP ? SPICC_LBC_W1 : 0,
> +			    spicc->base + SPICC_TESTREG);
>   
>   	return 0;
>   }
> @@ -850,7 +852,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
>   
>   	host->num_chipselect = 4;
>   	host->dev.of_node = pdev->dev.of_node;
> -	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
> +	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
>   	host->bits_per_word_mask = SPI_BPW_MASK(32) |
>   				   SPI_BPW_MASK(24) |
>   				   SPI_BPW_MASK(16) |
> 
> ---
> base-commit: ec0d19f2b59699e2e148091debaa0d9d6af5800a
> change-id: 20240611-spi_lbc-0859cebc580e
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


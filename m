Return-Path: <linux-kernel+bounces-198840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075628D7E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3FD1F2468F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3E7829C;
	Mon,  3 Jun 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4qtVCzG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E574297
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405859; cv=none; b=dwBMwkf/AlSUq2+f6S5n9NXEhm3oQS2vPPZ02nlscCN7R8zOdPGLU11NX81p3gE/ZimfXUt7AGaKaCwFUxUBaUHbJCiIGP/ErXSqB065BC2EAmqVucD8TwGpz+5gEBulufK/8vBZvGlMnLrSrj4IfQlFPN2C9gxdPy+6PEQCdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405859; c=relaxed/simple;
	bh=aJp4J53S5SXyq0upH+slFibBT9EgeMWDSyIiWcP7KvI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jddnek68vtKZFkLUNbzeREj+kgPDEwsqgeW0BIrfmnwYZqAYNfdLUR0ayMKYRp0uEMG9mMhn2hSeEFkCrpoPebelYOwF4u5YTGrkfmj7zJSpB59NiL69QvraRd/SliodvSL4tczIW+AxtK/YyNpUCI52ljVul8vonYm0qAnYeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4qtVCzG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354b722fe81so2363211f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717405856; x=1718010656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6wnj3BROg0Hk63KJnLzwIEWekn9hkic0O3qv54gZoI=;
        b=V4qtVCzGNLLuxVZ5N355JFctdjntzkMlEY1JQSWOI57uV59B9D8HcCWHd9b9ehfvbc
         YuNkS4QficpZRTyKns9+ET1RUve9pUFNJbXASjPzF8vVdj+bgYBMot3D2a9AhzhGCabT
         To5zXgIyUJZp2zrSbtmA2+Ivk4fAUyQf0QBkLWpMi5E7PTJf+NvlSMTgvEIJ2hrcCWyM
         jeCCjoXfY3R63mlkzRuPj47tLHJoAF/QOksuytCFf67IvVYt/uW44jTOLde1vD7F+7QR
         QUnmylcsNM0ifGjgDeXv2Or0lx2fr8uNQ3PONswLv6swOJWk9lw7n+bUivJj/S3sarB/
         hnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405856; x=1718010656;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i6wnj3BROg0Hk63KJnLzwIEWekn9hkic0O3qv54gZoI=;
        b=CxzLwSZdfh87FqFpS632SMuLIaUc/+PYd5F8suz4C34iUZb/e1tjiN4xuMBeYfP3xb
         HBU0a6A3a6Up5tGIhi9aEXMWmeShHPJFZhcVXyJwFFC5PZRglTV2EQD6a6hIt6T4PRJr
         DXhFv/1n76Xj1My8+fj7Eq+R3G8I7AOXRlgcGnvwPBZ9naDYotLaM7/FTFX4ENgXEr3a
         qJIwgrfoy0j1KY36PA/k0aNNWishekxlAhF9hshgmpHRKCFtCllSLq1ETxfjUTAv4CkG
         yeraRJMbM+VM4X03ZdrhNIyxHX4g8vLIXOSyb3W81vMMaPYDJHLcEiq6p/FYwiodOPdl
         TPQw==
X-Forwarded-Encrypted: i=1; AJvYcCW1IURdhxoaDsjkGWEKJ+TcFXtCDZRlid6CS5+rA3AYvNSDpUy70dcfg05c2uXQVtmdM413jtFrolJdyTM8s4lKS0Njy/uT46GVXkO7
X-Gm-Message-State: AOJu0Yz0vpbs4A3z9zz4M7FXC3onvOMh+yZI4yFPdALrPCa/6iOpkRMO
	T6U1SK4bF6FD3MdMwX+fZXid7O94GYkkzE2tmJxZNKQiItyy5LXTlfpJXRfJQK8=
X-Google-Smtp-Source: AGHT+IG0lujEB7mTuRVL+Od0z+wBF0VbXE3EUZ/MZ8spiOzPQ7RaB6C1sF+fwPAXJlz0bG0XAMnUKw==
X-Received: by 2002:adf:a194:0:b0:354:fb2a:7daf with SMTP id ffacd0b85a97d-35e0f33627bmr5956251f8f.57.1717405855589;
        Mon, 03 Jun 2024 02:10:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79fe:b764:2b06:ab4b? ([2a01:e0a:982:cbb0:79fe:b764:2b06:ab4b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm8245708f8f.23.2024.06.03.02.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:10:55 -0700 (PDT)
Message-ID: <7c54ed90-538c-4b32-91f4-85bf6c27cd6c@linaro.org>
Date: Mon, 3 Jun 2024 11:10:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/8] spi: Rework DMA mapped flag
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Yang Yingliang <yangyingliang@huawei.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thangaraj Samynathan <thangaraj.s@microchip.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/05/2024 21:42, Andy Shevchenko wrote:
> The first part of the series (patches 1 to 7) is an introduction
> of a new helper followed by the user conversion.
> 
> This consolidates the same code and also makes patch 8 (last one)
> be localised to the SPI core part.
> 
> The last patch is the main rework to get rid of a recently introduced
> hack with a dummy SG list and move to the transfer-based DMA mapped
> flag.
> 
> That said, the patches 1 to 7 may be applied right away since they
> have no functional change intended, while the last one needs more
> testing and reviewing.
> 
> Andy Shevchenko (8):
>    spi: Introduce internal spi_xfer_is_dma_mapped() helper
>    spi: dw: Use new spi_xfer_is_dma_mapped() helper
>    spi: ingenic: Use new spi_xfer_is_dma_mapped() helper
>    spi: omap2-mcspi: Use new spi_xfer_is_dma_mapped() helper
>    spi: pxa2xx: Use new spi_xfer_is_dma_mapped() helper
>    spi: pci1xxxx: Use new spi_xfer_is_dma_mapped() helper
>    spi: qup: Use new spi_xfer_is_dma_mapped() helper
>    spi: Rework per message DMA mapped flag to be per transfer
> 
>   drivers/spi/internals.h       |  8 ++++
>   drivers/spi/spi-dw-core.c     |  4 +-
>   drivers/spi/spi-ingenic.c     |  4 +-
>   drivers/spi/spi-omap2-mcspi.c |  8 ++--
>   drivers/spi/spi-pci1xxxx.c    |  5 ++-
>   drivers/spi/spi-pxa2xx.c      |  6 +--
>   drivers/spi/spi-qup.c         |  9 ++---
>   drivers/spi/spi.c             | 73 +++++++++++++----------------------
>   include/linux/spi/spi.h       | 11 ++++--
>   9 files changed, 59 insertions(+), 69 deletions(-)
> 

I applied the serie on next-20240603, it worked fine:

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Thanks,
Neil


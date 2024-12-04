Return-Path: <linux-kernel+bounces-431201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1009E3A52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E56283D39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDD18BC19;
	Wed,  4 Dec 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zm0LkEDS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F421B6D1B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316593; cv=none; b=kdfwroGfSIaKcmq8VE6SAaJqSL3gprlt6++Elw1gdhCDG7iIlNLsmNsHPwxJdvV/xmlJ49VqPCtXKxqXM2D3jzh0UNpB217+08lKSaJRkxCmqOddI+o2YI8Yd62XNbuL3OnCEXUaYQbGEPY8WTyibHNPoor0wJM1n+QyxbEExkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316593; c=relaxed/simple;
	bh=LjU+4PTgmKYO7SER8mZXoZuR/48UQhxJw3WF09Neb50=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gSR+no8FY0Ax5168+zPiA0eKNgK9/dOtMZApMGGqY5mP5nJBFMISlM+CeM+yecJZr2IuS6d6HC60k2YfJitLAoSJdRL19lbr3undMhlJSQsWb4cmaFmT+oVhRLJpiwXV4zfyN32Kd1mHuWAyO4qSOz26FN3fkxNQ35EYWK0iz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zm0LkEDS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a742481aso55827055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733316588; x=1733921388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW4MeGLsTT8JJUx4EXqikrqOMNn0QgE59/PqCIr6wbg=;
        b=zm0LkEDSMc4KXu/LVKWVYcsDNH+tWHLB84/8r0LqwmQsZb01vgRlcqthlEVpWNFw4L
         6knbKaGyq/AQtiRdh+CRDMdEV/LGL8azT0ZhBL8BByuio5RL/XXZ81m6Dwj/ERkGsh71
         9e+0lH67mdJ3dZ7/cA/qfN8wEgJamOLHDM+Xgj+46kQsieTR8YUTm/gLGNHHH5kpeGFN
         MpQjKXF8Kh/zbJQzbCaYaJ0ei+lfEmRTsoiGGPkx5SiVQPbIioFHXZhWoXyQOtKzhOIe
         30qO8WlNS/MLwcnf7/CnSoDWtWRRubUKzv9BkzrnJuCLBH+xqqqrZVnejg2q960IxG01
         9+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316588; x=1733921388;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UW4MeGLsTT8JJUx4EXqikrqOMNn0QgE59/PqCIr6wbg=;
        b=L5wHVWfrNXLqPpX3zGDQQnM3Hw6D2y/tcSOPb3xGB26egNTuQ9V5oaOnLpitKQrhwe
         zfgTy5ljTz3WspzvJ5DCMNBe2dRvoZRSS5g5XfXsIh1Pau93gJoyb83PAICo7Ns7+pjn
         Q9AsLwIEwJTU6QJ+GLFMoohiT2pY4DnVkP6CU0jmdWo4pRpc5uFzfKcBOT6qbYnDs51P
         VE9IMwv0m7SJPDqrzcLBjefW2VXa0lz7wQKJexYwClXH7JF8csGEVLJPMR2+zesIyEXL
         DDoI/98TYwzFESw1V9LyekSEmq2G+iU71Iw2rrdDpM0jvupXBcD3MiRkYtfFEOPOk6MB
         CcIw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ml4wF41tMgccJMQZAxEBSddYwCMBQ4y+30VOSILg/L4hFfgrfZW38lFA54loUmtHPdOj17tpDdHaOsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZJTywoVNqWOYJXtEkavmX/h1WGFuJrnpEpB0gmHGbno5PHE5
	BLFE2Y1qTFxAeauIY82EWTj4wylSwR2gLx3I1jZ68b7tR9n232j0Vv3iQnaF74c=
X-Gm-Gg: ASbGnctUIDKHxxjWYs+IiDFxMD60P87cgXzk2X2Xj0KzOqBvMRk+MU6pv42onZqTnIR
	r9DECDLtDeksdUPXYu1SYGfn8DgeGcndOUouo+52NAEbmjfw8AJc6nkWgFQZTuzHd++GKnknb+X
	Q6+KHYhWKVR8XvhdE8jei4M71OhnVBGDxdrf+vfk8qXthzsyjC0cENNlVlOCEZSu740vn9q9KtH
	OEtPpyOqfWZPevBpcTMTS+CxypCfS/dZ0oinbEHn7iwo1tDvKzDW+yoB0FLEi6yu/xAhWYdaNrq
	3QWqiKU9dJZZ31MzpaJLIgJx
X-Google-Smtp-Source: AGHT+IFHtUY5nsIGlzmtn6DDr2goL+Qg5wiIt8ITuSi04ugkKKhs1Y0EMbEoIGpvHpmWG4cHMH6TMA==
X-Received: by 2002:a05:600c:3c98:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-434d09b658amr57409455e9.14.1733316588305;
        Wed, 04 Dec 2024 04:49:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:740:b323:3531:5c75? ([2a01:e0a:982:cbb0:740:b323:3531:5c75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5272b78sm23234225e9.9.2024.12.04.04.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:49:47 -0800 (PST)
Message-ID: <2c66c9df-49f1-42d5-8f80-27e36476e19b@linaro.org>
Date: Wed, 4 Dec 2024 13:49:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
 quic_vtanuku@quicinc.com
References: <20241204122059.24239-1-quic_jseerapu@quicinc.com>
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
In-Reply-To: <20241204122059.24239-1-quic_jseerapu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04/12/2024 13:20, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.
> 
> QCOM GPI DMA hardware supports an immediate DMA feature for data
> up to 8 bytes, storing the data directly in the DMA TRE buffer
> instead of the DMA buffer address. This enhancement enables faster
> SPI data transfers.
> 
> This optimization reduces the average transfer time from 25 us to
> 16 us for a single SPI transfer of 8 bytes length, with a clock
> frequency of 50 MHz.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 
> v2-> v3:
>     - When to enable Immediate DMA support, control is moved to GPI driver
>       from SPI driver.
>     - Optimizations are done in GPI driver related to immediate dma changes.
>     - Removed the immediate dma supported changes in qcom-gpi-dma.h file
>       and handled in GPI driver.
> 
>     Link to v2:
> 	https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
> 	https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/
> 
> v1 -> v2:
>     - Separated the patches to dmaengine and spi subsystems
>     - Removed the changes which are not required for this feature from
>       qcom-gpi-dma.h file.
>     - Removed the type conversions used in gpi_create_spi_tre.
>    
>     Link to v1:
> 	https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/
> 
>   drivers/dma/qcom/gpi.c | 32 +++++++++++++++++++++++++++-----
>   1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..35451d5a81f7 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -27,6 +27,7 @@
>   #define TRE_FLAGS_IEOT		BIT(9)
>   #define TRE_FLAGS_BEI		BIT(10)
>   #define TRE_FLAGS_LINK		BIT(11)
> +#define TRE_FLAGS_IMMEDIATE_DMA	BIT(16)
>   #define TRE_FLAGS_TYPE		GENMASK(23, 16)
>   
>   /* SPI CONFIG0 WD0 */
> @@ -64,6 +65,7 @@
>   
>   /* DMA TRE */
>   #define TRE_DMA_LEN		GENMASK(23, 0)
> +#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
>   
>   /* Register offsets from gpi-top */
>   #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>   	dma_addr_t address;
>   	struct gpi_tre *tre;
>   	unsigned int i;
> +	int len;
> +	u8 immediate_dma;

Should be bool

>   
>   	/* first create config tre if applicable */
>   	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>   	tre_idx++;
>   
>   	address = sg_dma_address(sgl);
> -	tre->dword[0] = lower_32_bits(address);
> -	tre->dword[1] = upper_32_bits(address);
> +	len = sg_dma_len(sgl);
>   
> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
> +	immediate_dma = (direction == DMA_MEM_TO_DEV) && len <= 2 * sizeof(tre->dword[0]);

I would have added () around 2 * sizeof(tre->dword[0])

> +
> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
> +	if (immediate_dma) {
> +		/*
> +		 * For Immediate dma, data length may not always be length of 8 bytes,
> +		 * it can be length less than 8, hence initialize both dword's with 0
> +		 */
> +		tre->dword[0] = 0;
> +		tre->dword[1] = 0;
> +		memcpy(&tre->dword[0], sg_virt(sgl), len);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> +	} else {
> +		tre->dword[0] = lower_32_bits(address);
> +		tre->dword[1] = upper_32_bits(address);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
> +	}
>   
>   	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> -	if (direction == DMA_MEM_TO_DEV)
> -		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +	tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);

And you can drop !! if it's a bool

> +	tre->dword[3] |= u32_encode_bits(!!(direction == DMA_MEM_TO_DEV),
> +					 TRE_FLAGS_IEOT);

I thingk you can drop !! here aswell, the check will return a bool

>   
>   	for (i = 0; i < tre_idx; i++)
>   		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],

Otherwise I like the simplification :-)

Thanks,
Neil


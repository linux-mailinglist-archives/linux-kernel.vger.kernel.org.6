Return-Path: <linux-kernel+bounces-431266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335DB9E3B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEA016549A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232671DACA9;
	Wed,  4 Dec 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsDu5u9Z"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD51D5174
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319097; cv=none; b=QfIlQ1SQ3nMxwwSiu+ZAwMVPrMw5Ys61kz1q6n6EnLoCRU5l6UNjEFWM+pJm/dHMkIipWeYT7s+oFRdDTkpiQwS07YKDTD9aG0h8M3EjNVOZ0xnPYDzb5ltl+DJIvYxcVCCiGA2B3HWBEkPUp0d+laeHCYs/l609XU7HBWOkGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319097; c=relaxed/simple;
	bh=28iFSTZwRruE53euSsgm8RvkZEGQpDlQtaSXKnMhZ+k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=drB8JaPf+26Ka1tyC04QECwvvmoSxyJ4fm8MTaad7k1Cn3UFXhFs8l+A/hstJXQxz8oRgERtvSqNO812441w5wac0N1uoNviKRBD4itrL7E78JbgSs15rvYwjpSv20AWt1NTQ5J360KC6meQDAXysWCu7K4mW5tM/hN3UkEqFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsDu5u9Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a752140eso57547485e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733319094; x=1733923894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Nk+W/9n/dfbOcQWB2gTAhMNJxxWvaRoERCBb3ZJHPY=;
        b=wsDu5u9ZqCinm36SEgSmrAinXTgjBMPNp9QkVl3AQu+1DR87dQ2E18ZhKvcs61VoML
         oYFM/5w1cOkBKPzGi48aqlwUmzVbq8U7cQOL4vUuwjkNWjOyTskmV3QJ1f2rrEdmbJce
         QqicyX5ijQ8GefjB8igvbuqDk4fWmn7nTmdPZ+fPa5rvoz3J/jGnQchJw5Z5qYL0I7BB
         W01+AEGAvRh9XrnPt8M0yHGDihh7LBfVswIMlsLxBf2xeZ6Kmq5imAcljABpoQfLUqsy
         WhH3k9aZBd8zO7Hdg8bjM1W7ol0ErHs+nJUC1iK4Llm3xNd2T7ZSG5Ct3uQcsAMQfX7o
         kP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319094; x=1733923894;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Nk+W/9n/dfbOcQWB2gTAhMNJxxWvaRoERCBb3ZJHPY=;
        b=K8fdKOhvLNBvGlqzxd4OweYkO7Kbqk9A8/1eZPPQvWe2e3Y+eBdOOAMPv9C/EyLFpA
         IfXo4+4if1pRHFaCntUNcIo9nSp1P7yTWfvIUqzgzaI6RrdtXtvY3Rlya+0JuP57USjZ
         WZTEPd34WuhGOxIj0tzm7CoIfwCGSYA0oV6+9DbF5X3Vc/cITyedP9BBMTJfZPXOZvma
         TIrK8+0NfW10Nsr8KZZ/nDjIkBmB9pcn0KsiQW0JQeGOd5u0KJHplvIsqGV1GPJMPynM
         fVn/7S9Wn8/07Hl0Y+2b5YBQWnpVsl2TZcsXGILaz4+fb8HxKx4Y8QTtUaGneWTNM1dQ
         ECfA==
X-Forwarded-Encrypted: i=1; AJvYcCV1SEtkcMyJ/WVEhzOIiZ9cvd4hjgt+5Fl5WJLomShiOm4oyLpQNnYcT2GhwThMUTS6noPeUky8IxFZ08Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0kQpJRhorFbSAz5VHeGLCZW5GxgIx5P3Of0o9/DxTU0Q8TzS
	JDVIs1EtAhXzs8AatrnpB+F7fd89vnWj0kZZlqjyrYIqx8XUX4+V+iQedEdmwU0=
X-Gm-Gg: ASbGnctNb6FnZo7OK8/UGEe1zUm2SnTFCH6sQdYSm0Y28ZU6erB1dlB9kqMvOroTn44
	hEH+ZIK+DuBoh38E1cqm0ZTxDyP0S+8roYzxxxxld7VFWuGi/6DajBBFBtDl4Bv7SFz6qiDJ9BE
	ymm9bpbnOR+I/Lh+8f65iU58LkCfskqKc9j8DT12GyCCB1/eKrpUcHTcTPXKbRYNUljkZgyTCBU
	De04hPG3AudgatG2Mg70B3apZczu6Qmk0F9ojv41oazkNtf6+IozkeGXvz3lS4sdVtO+itLDaSu
	1+Bo6JTVV0C7j3f9otow3QgE
X-Google-Smtp-Source: AGHT+IEBYQLjhxtO+L8OBhs3R57kDxdDxVn75SxXJJdCtCxhLqO7EimrFRxhK4aIHAcz/Vno9UyXhg==
X-Received: by 2002:a05:600c:511a:b0:434:a6af:d333 with SMTP id 5b1f17b1804b1-434d09c8e18mr58731045e9.16.1733319093600;
        Wed, 04 Dec 2024 05:31:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:740:b323:3531:5c75? ([2a01:e0a:982:cbb0:740:b323:3531:5c75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0dc8sm24581155e9.27.2024.12.04.05.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:31:33 -0800 (PST)
Message-ID: <02b6b148-90d8-4f9c-9a38-d0796c590d10@linaro.org>
Date: Wed, 4 Dec 2024 14:31:32 +0100
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
 <2c66c9df-49f1-42d5-8f80-27e36476e19b@linaro.org>
 <9c6127e3-17e1-4235-90b6-91f5dfa3166d@quicinc.com>
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
In-Reply-To: <9c6127e3-17e1-4235-90b6-91f5dfa3166d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 04/12/2024 14:29, Jyothi Kumar Seerapu wrote:
> 
> 
> On 12/4/2024 6:19 PM, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 04/12/2024 13:20, Jyothi Kumar Seerapu wrote:
>>> The DMA TRE(Transfer ring element) buffer contains the DMA
>>> buffer address. Accessing data from this address can cause
>>> significant delays in SPI transfers, which can be mitigated to
>>> some extent by utilizing immediate DMA support.
>>>
>>> QCOM GPI DMA hardware supports an immediate DMA feature for data
>>> up to 8 bytes, storing the data directly in the DMA TRE buffer
>>> instead of the DMA buffer address. This enhancement enables faster
>>> SPI data transfers.
>>>
>>> This optimization reduces the average transfer time from 25 us to
>>> 16 us for a single SPI transfer of 8 bytes length, with a clock
>>> frequency of 50 MHz.
>>>
>>> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
>>> ---
>>>
>>> v2-> v3:
>>>     - When to enable Immediate DMA support, control is moved to GPI driver
>>>       from SPI driver.
>>>     - Optimizations are done in GPI driver related to immediate dma changes.
>>>     - Removed the immediate dma supported changes in qcom-gpi-dma.h file
>>>       and handled in GPI driver.
>>>
>>>     Link to v2:
>>>     https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
>>>     https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/
>>>
>>> v1 -> v2:
>>>     - Separated the patches to dmaengine and spi subsystems
>>>     - Removed the changes which are not required for this feature from
>>>       qcom-gpi-dma.h file.
>>>     - Removed the type conversions used in gpi_create_spi_tre.
>>>     Link to v1:
>>>     https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/
>>>
>>>   drivers/dma/qcom/gpi.c | 32 +++++++++++++++++++++++++++-----
>>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>> index 52a7c8f2498f..35451d5a81f7 100644
>>> --- a/drivers/dma/qcom/gpi.c
>>> +++ b/drivers/dma/qcom/gpi.c
>>> @@ -27,6 +27,7 @@
>>>   #define TRE_FLAGS_IEOT        BIT(9)
>>>   #define TRE_FLAGS_BEI        BIT(10)
>>>   #define TRE_FLAGS_LINK        BIT(11)
>>> +#define TRE_FLAGS_IMMEDIATE_DMA    BIT(16)
>>>   #define TRE_FLAGS_TYPE        GENMASK(23, 16)
>>>   /* SPI CONFIG0 WD0 */
>>> @@ -64,6 +65,7 @@
>>>   /* DMA TRE */
>>>   #define TRE_DMA_LEN        GENMASK(23, 0)
>>> +#define TRE_DMA_IMMEDIATE_LEN    GENMASK(3, 0)
>>>   /* Register offsets from gpi-top */
>>>   #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)    (0x20000 + (0x4000 * (n)) + (0x80 * (k)))
>>> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>>       dma_addr_t address;
>>>       struct gpi_tre *tre;
>>>       unsigned int i;
>>> +    int len;
>>> +    u8 immediate_dma;
>>
>> Should be bool
> Hi Neil, Thanks for the review.
> Sure, will change it to bool.
>>
>>>       /* first create config tre if applicable */
>>>       if (direction == DMA_MEM_TO_DEV && spi->set_config) {
>>> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>>       tre_idx++;
>>>       address = sg_dma_address(sgl);
>>> -    tre->dword[0] = lower_32_bits(address);
>>> -    tre->dword[1] = upper_32_bits(address);
>>> +    len = sg_dma_len(sgl);
>>> -    tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
>>> +    immediate_dma = (direction == DMA_MEM_TO_DEV) && len <= 2 * sizeof(tre->dword[0]);
>>
>> I would have added () around 2 * sizeof(tre->dword[0])
> 
> Below condition is fine or should i add brackets ?
> 
> immediate_dma = direction == DMA_MEM_TO_DEV &&
>                  len <= 2 * sizeof(tre->dword[0]);

This is what Dmitry requested, it's fine for me.

Neil

>>
>>> +
>>> +    /* Support Immediate dma for write transfers for data length up to 8 bytes */
>>> +    if (immediate_dma) {
>>> +        /*
>>> +         * For Immediate dma, data length may not always be length of 8 bytes,
>>> +         * it can be length less than 8, hence initialize both dword's with 0
>>> +         */
>>> +        tre->dword[0] = 0;
>>> +        tre->dword[1] = 0;
>>> +        memcpy(&tre->dword[0], sg_virt(sgl), len);
>>> +
>>> +        tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
>>> +    } else {
>>> +        tre->dword[0] = lower_32_bits(address);
>>> +        tre->dword[1] = upper_32_bits(address);
>>> +
>>> +        tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
>>> +    }
>>>       tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>> -    if (direction == DMA_MEM_TO_DEV)
>>> -        tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>>> +    tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);
>>
>> And you can drop !! if it's a bool
> Sure thanks, i will drop !! in V4.
>>
>>> +    tre->dword[3] |= u32_encode_bits(!!(direction == DMA_MEM_TO_DEV),
>>> +                     TRE_FLAGS_IEOT);
>>
>> I thingk you can drop !! here aswell, the check will return a bool
> Sure thanks, i will drop !! in V4.
>>
>>>       for (i = 0; i < tre_idx; i++)
>>>           dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>>
>> Otherwise I like the simplification :-)
> Thanks, i will incorporate the changes in V4.
>>
>> Thanks,
>> Neil



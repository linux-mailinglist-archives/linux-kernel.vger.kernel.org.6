Return-Path: <linux-kernel+bounces-548549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9A5A54657
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C491710C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47AF209F4E;
	Thu,  6 Mar 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iP7wNjbT"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBD20896C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253429; cv=none; b=LVVfZFyJuSLRnOSwt1YDCIhksnV63ioMPobGII+m7zqy5t5/s4KDwLSqvuH3LVTvXW5GXqrHSBkSZUEy6MDp/30aJOBFLSluCQiVuZD9Hjbm7VOzgxKW8jl8EnUNPevRWZdBSGuc5Q55RTliOCcjdQJTVLAQXS+Vl2/xI0PgTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253429; c=relaxed/simple;
	bh=cqXcfoxrQZqouPmo5kRdsyVcRj6anRh2cDEyZOHNWnk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FGxL+T8Av6rl8w4DcQSscKF5nbGCf9u8Ge/hIWOPaVovaz/gjbwBd+auLxBYO59+S2tnXSYEyqnBdKqhM8Yyg+dB5Hm8RhMRYnfyXzN4eWPK1ggJAjiffEDdh+J8+Dt6oAHUMb2DM+f0E9cZCwB0tIj0w5Qs7zeApdpDZ9Vwbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iP7wNjbT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso212865f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741253425; x=1741858225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z79m0LRwylL1TUcFIowHlysw5aOIkiMWOUVmjSLVUX0=;
        b=iP7wNjbTvSf5plXzDCZLMEX3xma8EU9Pdm44e2rOdGwbxRgTSCDcnTjL77i73jcQA/
         9wxGtG0dsTENF3A0yb/ukUZzg6Jr1Glu2+Ggt+edcuIsc933SPif7PKUC/vwWTNtu/v6
         6Nk1NPeAFJnum/pQefzp3fH/suGU/GzzxYCAcMRDwAO5bK7VJE8mbDMdDFvCU38iOvlz
         BW70MiuBoW3lfp+7cbl7nyHOxbT8cnUbcpKWhs3QdXH8UESNDEpiPclI6+AVN3usd6UY
         VT4ot530DOCCompo42t2nMCMY9mCPA9jxaInjwAqj10otH3gyNF/1AJefjFUhW9UR0yJ
         UJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253425; x=1741858225;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z79m0LRwylL1TUcFIowHlysw5aOIkiMWOUVmjSLVUX0=;
        b=OI0PCUiVr0QmazyJUKqhLmPKOBAftUMHBo4xwxO6V24BVUg1e6XcGJTISRXiLLNd6H
         3bMjoup2xMDbcg1Ruz6X8JvM3TKgbFAUdk2pODRcVax2QGweK7G8i4+iME87fw4V5Jgj
         xf45bSY57XhCVeKEzyxaM+TxThLHyaTxDCsOiz+UvyAKCnZMMSuvzMj3JrWiEB29qaWy
         o5Fu5VN4w+op3EACn7ZMAoIuPAYi2vPeiJlo5yLR6STwMj0bghys8XfrHbRm9xS+S/Ro
         bX8V81PY4Y2tkgR4d6VMSAyL8jnfo/XU4UwwsgUfie+2HnzLpQEQgnVG5il1U9Ji0Uc6
         xOUw==
X-Forwarded-Encrypted: i=1; AJvYcCWW5k7gexk+hjyXXrQzaZ1TCl4lKcaL1JGkVzYDqsWNNn5ViyWa94WjPYB8l+Cv/3mcxEATg6zBEvoZwqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9fmiyqYKoNf/5RrIxQrTFgt/keT/Op7XZ1OTCQdcbWoqlwLb
	5SNV+M10piA4fVFvH367+8XRwHbPjAckO5L0ZoGoRjPp5aH0ZtCX/lhmzMtgH7w=
X-Gm-Gg: ASbGncvKtjb/gEMNE/yp9ukac/+u+3AItoSorc2vkfjrRe688B/ZFDzK4QcFdDxtiWs
	+UFDGMKidiZG7S4482upNeqwvQYLR2t9zlTvAlWkQQQhw2Hk+XtJrKLAhQrs3QauDweQqMq+RIm
	2eLDAqnb58eAc5rLfwFAvnIwPOl7kNKy3thrYJGaApftez3RAPH9mnblIj0pG2D6xP336g+Pc9y
	QCJMab34K526pnbG0Kz046jKAzzjal23Hc8Y+Y7lU9wAOXwIWJ0wnLOQcqxauw2kC7V77azoCIs
	NyTeFAzK4mESQXKAfzJjxTo38+uuS2aH04a97kQRP+uljw9M2SQ97qoz
X-Google-Smtp-Source: AGHT+IGnpFmsJBY/qEamoUmfbMXLuOWckaWioHNi22rQde52T2IvnSzLx8zdUb49jRIT4IcdS2vy1A==
X-Received: by 2002:a05:6000:1f88:b0:390:ed04:a676 with SMTP id ffacd0b85a97d-3911f7491a1mr4619791f8f.22.1741253425200;
        Thu, 06 Mar 2025 01:30:25 -0800 (PST)
Received: from [192.168.1.101] ([37.167.199.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b8bsm1440616f8f.64.2025.03.06.01.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:30:24 -0800 (PST)
Message-ID: <16130141-2cb0-4f28-b0ad-fee5be061dd3@linaro.org>
Date: Thu, 6 Mar 2025 10:30:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] mailmap: remap all addresses to kernel.org alias
To: Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306-update-email-v1-0-9a231571e905@kernel.org>
 <20250306-update-email-v1-2-9a231571e905@kernel.org>
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
In-Reply-To: <20250306-update-email-v1-2-9a231571e905@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 23:44, Dmitry Baryshkov wrote:
> Remap all historical and non-historical entries to my kernel.org email.
> 
> Signed-off-by: Dmitry Baryshkov <lumag@kernel.org>
> ---
>   .mailmap | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 01145c078838bf9348e8d0e5e48b7b0954248dc5..a5c80ef0b7800519f3124e0d85294f34d6b275ca 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -198,10 +198,11 @@ Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
>   Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@mips.com>
>   <dev.kurt@vandijck-laurijssen.be> <kurt.van.dijck@eia.be>
>   Dikshita Agarwal <quic_dikshita@quicinc.com> <dikshita@codeaurora.org>
> -Dmitry Baryshkov <dbaryshkov@gmail.com>
> -Dmitry Baryshkov <dbaryshkov@gmail.com> <[dbaryshkov@gmail.com]>
> -Dmitry Baryshkov <dbaryshkov@gmail.com> <dmitry_baryshkov@mentor.com>
> -Dmitry Baryshkov <dbaryshkov@gmail.com> <dmitry_eremin@mentor.com>
> +Dmitry Baryshkov <lumag@kernel.org> <dbaryshkov@gmail.com>
> +Dmitry Baryshkov <lumag@kernel.org> <[dbaryshkov@gmail.com]>
> +Dmitry Baryshkov <lumag@kernel.org> <dmitry_baryshkov@mentor.com>
> +Dmitry Baryshkov <lumag@kernel.org> <dmitry_eremin@mentor.com>
> +Dmitry Baryshkov <lumag@kernel.org> <dmitry.baryshkov@linaro.org>
>   Dmitry Safonov <0x7f454c46@gmail.com> <dima@arista.com>
>   Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
>   Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


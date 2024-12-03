Return-Path: <linux-kernel+bounces-429580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34559E2009
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B47B62E77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCC1F12F0;
	Tue,  3 Dec 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c58VJW03"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786691E1C3F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233618; cv=none; b=Dot294o79tHvu16M+0417unDobp+dK5FjIXneYSY/JaLckGXKrtvyuviHHVieuiaQOUfYoIfa9nJWCZRl/gkFqouBpB2JYKpgnPqvcOI5e5/ll5VB3FTfaBTjTFIo5OwsozEafjxVsw3Cx+6DHcPjU5nJItwJLtHHRtKtCZ9MoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233618; c=relaxed/simple;
	bh=fWA2tPCLl/ES0tlHVWzu++uojHotf7agg7wzoHwW4hM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c3V60AVzwPGqQc5j7LCR94KGJtnRKoqipleL5A71fvWILLe38r/b78gDpmfkoYR+sX4lWDl0BR9+d8fnvhs0arFAN8NEQn0uhbBFKYdA3UCzNDbnNhJTAu3XgsDVzj80nTCqIwo7CqYTskAV2Z4PvzFh3llHR4e8Vo+Ku8i0iBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c58VJW03; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a742481aso45396235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733233614; x=1733838414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mk2Kw/m5YtDRatnRv3x9OtW9dTxfZBESul9L2QNgRng=;
        b=c58VJW03fWQwFC0h6xIZYUB5YPI/7QUsN1mclL3fcX8oa1Ha0Qx3Rc9KtPyJrQyju9
         w4NA5a60aLJE6lqW7L/7prYe1/4xzzUXGCPcLgIfV6JE+TpLXvAQIZynMmMDqq0ci6Y0
         VqEgawuwMWSlp6kJWqQR4WnGxSXvTHWoD/dr+xsJ2x3XZFFTtzxnHeddZQBeD5Htj6iD
         VFuoIgXzMqqXdMV03iitSLWS2v2URLPdL/i0EFAES0+0sh0QzxKJHOeF+z2ML/vtp25/
         ovfGBIXHvTHZEQXJEr2WyuDqhmuvTT70PxeKAPrd6x4uT3lbtVCnvdPKdHpLWtzSgCyF
         CAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233614; x=1733838414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mk2Kw/m5YtDRatnRv3x9OtW9dTxfZBESul9L2QNgRng=;
        b=wbdRUarBzVoL9vI+b2bqhxqzjgF5K/U2yY8k9Snkyp2olw1wOEVL9+C/w7sTQQzv62
         UK7mCo1NQ+vHh2YDl1MB0sHgaB+D/yNlGeMxilQCaFJOSwROxQYlQfEJf6gHtNuxg1eY
         esWvoz0STA3SIDIw0P/P+5X4ErRraBNMAJwhY9YsERroiLIWfTPd2rCkp/Bali6bFKQK
         HOB/hkmpE1F+UC/3VuQiZTBa1aYprD+w1NrAv7fpMOCN2tkbPZVRPcnd3684YEGvBCtm
         fHuD2cRdo+O7oTdGGrAMIyw9L81Fser5xRXi4cGfStGK6yVr7oQiiTVUCAsFHDlYc95D
         EeAA==
X-Forwarded-Encrypted: i=1; AJvYcCVhyb9W923uzgwKG9Es88uMWtqsmORdBG9ef2DkC09XhlJZ/oMlzQGn+qU4uP3zTS4LWs8kWWviRFb/hWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLNGNsoSa6Qo2eZlXN21k6VkFkNzqRwA2smuEQnar0S6bUZLd
	L+LlB21vHBDUaDUsJ8hfmKqukehast0qvWSEEwOTy35mksPVDmUPc7MHA20trRY=
X-Gm-Gg: ASbGncvcYbALK1wd7U3/8sKXlquUqjS0aFWtdRWFOfzoo+OJjT6LzMwSJYavdVwG7+H
	VPrEUVr9IE8ZQUe6//hxIqwlxvg68ngZwIt8H9U79EvdBrbbAEwAlU71oXtMCb2KaOXJacYiIXq
	U7T+2zr2Pe01Ld2f4eikEjJIfQa3PuGBWnjuBfdyCH+kUswnEszYQn2bJNomP0Y7ZDuMbykHgCa
	UUu4BA4YginmEunmAyZJr/IyxXIX7JwF939ztMtnT6j6smUGlDIvEEnJB2F70Igg8xzWwi5xmrX
	nqdwf5rNgXVOSz6ETFzC+S+P
X-Google-Smtp-Source: AGHT+IEXo5W59XeQghjqzdAPoW0OgS7GVomBPYYtKL+q6xkSkB7bH2/jhF2wKg8rpuvM6fG6Rat3/g==
X-Received: by 2002:a05:600c:1ca2:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-434d0a03d92mr21451925e9.25.1733233613893;
        Tue, 03 Dec 2024 05:46:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b668:b88:4ecf:c065? ([2a01:e0a:982:cbb0:b668:b88:4ecf:c065])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e32ee381sm10597471f8f.76.2024.12.03.05.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:46:53 -0800 (PST)
Message-ID: <99f11abf-2417-40b1-a5c5-73c2f87e2eb3@linaro.org>
Date: Tue, 3 Dec 2024 14:46:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/9] crypto: qce - shrink code with devres clk helpers
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-4-c5901d2dd45c@linaro.org>
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
In-Reply-To: <20241203-crypto-qce-refactor-v1-4-c5901d2dd45c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 10:19, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use devm_clk_get_optional_enabled() to avoid having to enable the clocks
> separately as well as putting the clocks in error path and the remove()
> callback.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 29 ++++-------------------------
>   1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index f9ff1dfc1defe..cdcddf8f9f02b 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -212,15 +212,15 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	qce->core = devm_clk_get_optional(qce->dev, "core");
> +	qce->core = devm_clk_get_optional_enabled(qce->dev, "core");
>   	if (IS_ERR(qce->core))
>   		return PTR_ERR(qce->core);
>   
> -	qce->iface = devm_clk_get_optional(qce->dev, "iface");
> +	qce->iface = devm_clk_get_optional_enabled(qce->dev, "iface");
>   	if (IS_ERR(qce->iface))
>   		return PTR_ERR(qce->iface);
>   
> -	qce->bus = devm_clk_get_optional(qce->dev, "bus");
> +	qce->bus = devm_clk_get_optional_enabled(qce->dev, "bus");
>   	if (IS_ERR(qce->bus))
>   		return PTR_ERR(qce->bus);
>   
> @@ -232,21 +232,9 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = clk_prepare_enable(qce->core);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(qce->iface);
> -	if (ret)
> -		goto err_clks_core;
> -
> -	ret = clk_prepare_enable(qce->bus);
> -	if (ret)
> -		goto err_clks_iface;
> -
>   	ret = qce_dma_request(qce->dev, &qce->dma);
>   	if (ret)
> -		goto err_clks;
> +		return ret;
>   
>   	ret = qce_check_version(qce);
>   	if (ret)
> @@ -268,12 +256,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   
>   err_dma:
>   	qce_dma_release(&qce->dma);
> -err_clks:
> -	clk_disable_unprepare(qce->bus);
> -err_clks_iface:
> -	clk_disable_unprepare(qce->iface);
> -err_clks_core:
> -	clk_disable_unprepare(qce->core);
>   
>   	return ret;
>   }
> @@ -285,9 +267,6 @@ static void qce_crypto_remove(struct platform_device *pdev)
>   	tasklet_kill(&qce->done_tasklet);
>   	qce_unregister_algs(qce);
>   	qce_dma_release(&qce->dma);
> -	clk_disable_unprepare(qce->bus);
> -	clk_disable_unprepare(qce->iface);
> -	clk_disable_unprepare(qce->core);
>   }
>   
>   static const struct of_device_id qce_crypto_of_match[] = {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


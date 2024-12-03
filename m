Return-Path: <linux-kernel+bounces-429583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3479E1E30
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF65B28558F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449D2AD02;
	Tue,  3 Dec 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1xMwcNp"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF51F12F2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233804; cv=none; b=aEL5RFwcayrv7rLmEyJ+sxl0kwDhXM0qMEIUVufVaHMxKyY2deTN8hZcs7+v04ueUM4qHlMzOBqMEiVgaNQoC47bBIsNeTHEDsrCnm0yvUNQJttDxfz3mA7RYVKBfLYZPYlvfjuqZ966zJU2/J0Z75n60ed0YbGqEO0uV4gNTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233804; c=relaxed/simple;
	bh=XOBIbK57Lqm+Qdsjjzx2vA7YrEICxtWa2H55+Jb6cpA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gimotWCHU5zAoYkQMsHc5Qzmnujl9E9tdG80HBfp41qs0FfBKRMiit3LfPRz6IrPXUnojYs28zaIQmP0vNmMedF0q1jwB0/t2sOVcDogAnRQCMEeFlBwYgGdamIhk5Ag+6nKHRtQZGHODl+gQN1Yy0zxi8z5gx/hiD4BTGChSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D1xMwcNp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so2013203f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733233800; x=1733838600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7ZVhvMkEckvx4CVyZO/KuVa4o52a6A+0jidqX5kLxg=;
        b=D1xMwcNpprEeoFORldELpuvevi2ecC/fW7yLYg5MQaAU/vevYfdNUrpr0cryabpOqc
         B2Stj0F/XyasaZw6f4ecZ7Z4CnRJ58i0TJq8L4R5V0nr2LCRuK/wYSpoG/wpBG9QWeln
         rfMUCLD94+jSnytghDf0uNhLwFsaO0jwbuSi5oixAqFmNVphHKgflEDjDAwQ7xEC7+Vn
         kz0vCPnThIxqJ64ppWTBi7R+3zrgCw4BUjvtIvWQxgBbSXWjmq9SKRdHTz07wig8vS3K
         AmG9lboWNqE4cZJqsTLW1+ORa1fZoX5sZPthXYhYK0hA/pN0RLNkOZ6tw5hU5Gwvjtxp
         1cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233800; x=1733838600;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7ZVhvMkEckvx4CVyZO/KuVa4o52a6A+0jidqX5kLxg=;
        b=TYvOR0AYTni1qEI31Tz4LnLPnoXcJnjxBjXkozP8TNXHdZsUFSh66qdjHjqYUc61Lz
         qC4qyn2O5eN/UH5LaLFxq4zhgXtdwJtQBh/Gzg+3Md40bxTseZev26XQRP8+CS3YjP8n
         7VTO5dX9RMnve1Y4p8NXoDsru/8GE8IS5fc50RKGaogMg7UELISoTARnxsPC3bRpwgfN
         eobaWT3NEEYpjw8lJ60QscsLvac88xEGk0BIS1i0+FXY2y9dgdFeMYR9RbqyOpcFNjda
         n6Dbd3QF47mE84cOj+Z4DUoF0BCJdAjSDUYruegahxB8ulOApFI31pJ8t/Cge6jYDUa9
         LmQw==
X-Forwarded-Encrypted: i=1; AJvYcCW5OoOwyKH6qYJgjSaXTPo2c+t+jF25IYh75JIOoT64uWJ7DbVkvn0Okn+LCZDn/JBOapw4F/rxF9SHokI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+CihH2W1ahLYhEun0zATr8QRKkvrey+etZ6bXAX2aodXtyEr
	qzbaagIVcbTgSXcoVTDT9htjQ9qLXkY1MZFzdHiZbyZ1BwfLeeJA0U28BTSUrTY=
X-Gm-Gg: ASbGncs1DOuuEK6DbnzqMXjkwxLni+MOctU1HNr0WkaML6hrhtRV4ZtoieUCkeg80XA
	Oo2P+B1na77fMzALlOxDQ4CYTGeQCWOZSfMOIVfC2jQQQfpExnxsyE9hSD7BQtcCAyrtw0uoUyx
	rbznUWTz24h/p+babTLvwrBGGxqWiZO4G1bEp9b/m24LarM6dIiHgMoGbEEqQbYX4w4RWnt7AwT
	1od3c/K2Q0e5HuM13tzbR8kqQDxt6Ga67nlT7OnbaqwkIzMVxm5OWKUCsuDi2Ug39MOGUNwsOH+
	bzjCZwckw5zDfMOeh6lj5Rhq
X-Google-Smtp-Source: AGHT+IFns2fvOnWah4kqIP+pyc4yb58R5STtuxrZAjmn8u5H0mVgyD+T7yFjtMub5is1RfAH6dg4cg==
X-Received: by 2002:a5d:6d0a:0:b0:385:df87:28de with SMTP id ffacd0b85a97d-385fd433607mr2094851f8f.56.1733233800359;
        Tue, 03 Dec 2024 05:50:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b668:b88:4ecf:c065? ([2a01:e0a:982:cbb0:b668:b88:4ecf:c065])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd687c3sm15966443f8f.77.2024.12.03.05.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:50:00 -0800 (PST)
Message-ID: <c23bbf5a-7e1b-491e-9a59-5bf382e4174f@linaro.org>
Date: Tue, 3 Dec 2024 14:49:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/9] crypto: qce - convert qce_dma_request() to use devres
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-5-c5901d2dd45c@linaro.org>
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
In-Reply-To: <20241203-crypto-qce-refactor-v1-5-c5901d2dd45c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 10:19, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Make qce_dma_request() into a managed interface. With this we can
> simplify the error path in probe() and drop another operations from
> remove().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 16 +++-------------
>   drivers/crypto/qce/dma.c  | 22 +++++++++++++---------
>   drivers/crypto/qce/dma.h  |  3 +--
>   3 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index cdcddf8f9f02b..e2cda24960f63 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -232,13 +232,13 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = qce_dma_request(qce->dev, &qce->dma);
> +	ret = devm_qce_dma_request(qce->dev, &qce->dma);
>   	if (ret)
>   		return ret;
>   
>   	ret = qce_check_version(qce);
>   	if (ret)
> -		goto err_dma;
> +		return ret;
>   
>   	spin_lock_init(&qce->lock);
>   	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
> @@ -248,16 +248,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	qce->async_req_enqueue = qce_async_request_enqueue;
>   	qce->async_req_done = qce_async_request_done;
>   
> -	ret = qce_register_algs(qce);
> -	if (ret)
> -		goto err_dma;
> -
> -	return 0;
> -
> -err_dma:
> -	qce_dma_release(&qce->dma);
> -
> -	return ret;
> +	return qce_register_algs(qce);
>   }
>   
>   static void qce_crypto_remove(struct platform_device *pdev)
> @@ -266,7 +257,6 @@ static void qce_crypto_remove(struct platform_device *pdev)
>   
>   	tasklet_kill(&qce->done_tasklet);
>   	qce_unregister_algs(qce);
> -	qce_dma_release(&qce->dma);
>   }
>   
>   static const struct of_device_id qce_crypto_of_match[] = {
> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 46db5bf366b44..1dec7aea852dd 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -3,12 +3,22 @@
>    * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
>    */
>   
> +#include <linux/device.h>
>   #include <linux/dmaengine.h>
>   #include <crypto/scatterwalk.h>
>   
>   #include "dma.h"
>   
> -int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
> +static void qce_dma_release(void *data)
> +{
> +	struct qce_dma_data *dma = data;
> +
> +	dma_release_channel(dma->txchan);
> +	dma_release_channel(dma->rxchan);
> +	kfree(dma->result_buf);
> +}
> +
> +int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
>   {
>   	int ret;
>   
> @@ -31,7 +41,8 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
>   
>   	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
>   
> -	return 0;
> +	return devm_add_action_or_reset(dev, qce_dma_release, dma);
> +
>   error_nomem:
>   	dma_release_channel(dma->rxchan);
>   error_rx:
> @@ -39,13 +50,6 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
>   	return ret;
>   }
>   
> -void qce_dma_release(struct qce_dma_data *dma)
> -{
> -	dma_release_channel(dma->txchan);
> -	dma_release_channel(dma->rxchan);
> -	kfree(dma->result_buf);
> -}
> -
>   struct scatterlist *
>   qce_sgtable_add(struct sg_table *sgt, struct scatterlist *new_sgl,
>   		unsigned int max_len)
> diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
> index 7864021693608..31629185000e1 100644
> --- a/drivers/crypto/qce/dma.h
> +++ b/drivers/crypto/qce/dma.h
> @@ -34,8 +34,7 @@ struct qce_dma_data {
>   	void *ignore_buf;
>   };
>   
> -int qce_dma_request(struct device *dev, struct qce_dma_data *dma);
> -void qce_dma_release(struct qce_dma_data *dma);
> +int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
>   int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
>   		     int in_ents, struct scatterlist *sg_out, int out_ents,
>   		     dma_async_tx_callback cb, void *cb_param);
> 

Nice rework :-)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


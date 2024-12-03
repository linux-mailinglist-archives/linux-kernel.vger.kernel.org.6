Return-Path: <linux-kernel+bounces-429589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D09E1E42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94549287012
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D2D1F1308;
	Tue,  3 Dec 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3ZP0YVZ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFF1EE024
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233966; cv=none; b=ssiRa03oiRO1Tp9YGDsd9hucToHkd/C6sEQXyImdTbIMUoK/0Aag9eRxGsrn6FfyvFgsu9hE5G1L0EiskUMuLRrXTFkx80lszuIxeRa2eUN8O4lR4ptsZHkoyoBVUYJ2gpAvICxIV3/96w+5bRhUW3ftOB8O7ejiStsNXtjwZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233966; c=relaxed/simple;
	bh=v/0nQpVev2ndP6RZXzkRsx1U8+dnE+fNmJFvOBbxGOQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PvakX56OKfezEW38ckqdNc6utV5JIDmy4UeS8Mv6Lf3nQNoNtQECYdWRc72/i+B7pF66m7R35PYDUmL757QB4M/pPFouBf6ZPLtf5Dc005ANgM4SGh1Dn6ANCbL133sLNN7fvTWSGNg9I9Dw+yFsLhhMY/yGb68uQwxC4/AX188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3ZP0YVZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a90fed23so46745685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733233963; x=1733838763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2t8JJMG5582Bls/PacyhFYC1KHsJGdf+sWNf8uRQtgs=;
        b=r3ZP0YVZKBiOghszMLgbEv9Gejx2Zar/lHP4iJutUEOpqCV3OYHx4IZXY67QPU0Pi9
         yM5osPykjyTk4Ld7Wpksif8W74rB0fIR0KStI/LKLBYQs/NQMkCZmnOZdCx5dzeJBJsz
         hXk/Tl4iVgNxMNl4pZKvWfD8shKdv0Yb8xONm8ByvtBw7xGoPnlbqwyOOlM5rqhX0O8x
         GW8OwpofMKM3KNrznzLJn559NUoUvyV6KNVPtMiLh47sN5Ss/L4LMjoYqAalBoHVfxsf
         +G4X711aWkfRdJFh67WohMxmDSh9XfzhSU/di2MiG0ZqhUEydmKh/PnS9facs2Lx3Q2u
         1zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233963; x=1733838763;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2t8JJMG5582Bls/PacyhFYC1KHsJGdf+sWNf8uRQtgs=;
        b=B1hY7q478mEumhcq4K3qJHqAmSuzhyYJIiCkI7+A859rF+lWmcSXu0TrLm+6chfyf4
         BjAimHSnbOr5EgKvgArVRHlpeaxQza0fwn5gcD0cZ7bmaArFaZ+LxrC8tkpongvK59Bg
         HH8X3pc30lsDHErF+SOQL33wh5PwttiI8O/dvKxbKXZNOT65ERVDF2E1JIoFbtoQFD3R
         zhf+eMq/h41D3oJSJIpkppZw6RQzBCJLEbMprswSDr7gjB1RQLEbl9zCN1RKX5tZMfAv
         +gRffBIhQh8+8cp2A0tqhxZloVAunv8NvdiD2wkjlqeWvsQppC7BjqOWorR3YzaYJdc3
         duqw==
X-Forwarded-Encrypted: i=1; AJvYcCW6axZXmYT7X/RkyXujLcoKDxKDCQcfJtCxpFzRLChYtX60xW7Y26ZoWP+SSnQywQZsFvFK/TEOYQ0RfIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8syKpvNXxrgMEf5o58yO0k19kBpU0+EQpsCmAzDFjakgEyt6z
	Zs94Em3bZJDegEt6VY6Sa0aTMKk05jDgXG1Tg56YfhXEEypTJkBMh9uHzC2E5rg=
X-Gm-Gg: ASbGnctlLd2Zwn08ZzBb0FaKCvjpoYolzVFuojyYuALkca4T3YmIz+ZLMbdhrUYKDEE
	nHhsPKFiBaiKiBWIiKPLF3lwAL1e6xEcRoNHs8JnY6f+2umZiq3+JCH39q1rlzBiZEOXFp1B1Lv
	JcdJvPC9lNMG+z/1CUDhHX5D0w2dAgrzWuPx4y2ywve2UvRpYy/iByyXUyfK9BYpsaO35Qh6rOQ
	gswg34C9Hcz0kySC1WeEYBsIK3MsPU/+SaOlo9NLI1vXXN+O2K/jMuNc2fI2JMkdEnC4Y0tGHA8
	7ZFqU8e5W+OBXwZiAzg1JH0g
X-Google-Smtp-Source: AGHT+IHPK/4xK3/T2ubzZ93yNqLxLU2FcxdhQ8xEBhXPCV5/YaFdHDWHRsRFdrg7uI4TyyxceFGmlg==
X-Received: by 2002:a05:600c:3c9b:b0:434:a9a8:ad1d with SMTP id 5b1f17b1804b1-434d09b0013mr20951775e9.7.1733233963271;
        Tue, 03 Dec 2024 05:52:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b668:b88:4ecf:c065? ([2a01:e0a:982:cbb0:b668:b88:4ecf:c065])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d9csm195101175e9.38.2024.12.03.05.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:52:42 -0800 (PST)
Message-ID: <dd630922-b317-4a57-8bf7-a0bb376f794e@linaro.org>
Date: Tue, 3 Dec 2024 14:52:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 8/9] crypto: qce - convert tasklet to workqueue
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-8-c5901d2dd45c@linaro.org>
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
In-Reply-To: <20241203-crypto-qce-refactor-v1-8-c5901d2dd45c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 10:19, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There's nothing about the qce driver that requires running from a
> tasklet. Switch to using the system workqueue.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 20 ++++++--------------
>   drivers/crypto/qce/core.h |  6 ++++--
>   2 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 5e21754c7f822..6de9f1e23e282 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -122,15 +122,16 @@ static int qce_handle_queue(struct qce_device *qce,
>   	err = qce_handle_request(async_req);
>   	if (err) {
>   		qce->result = err;
> -		tasklet_schedule(&qce->done_tasklet);
> +		schedule_work(&qce->done_work);
>   	}
>   
>   	return ret;
>   }
>   
> -static void qce_tasklet_req_done(unsigned long data)
> +static void qce_req_done_work(struct work_struct *work)
>   {
> -	struct qce_device *qce = (struct qce_device *)data;
> +	struct qce_device *qce = container_of(work, struct qce_device,
> +					      done_work);
>   	struct crypto_async_request *req;
>   	unsigned long flags;
>   
> @@ -154,7 +155,7 @@ static int qce_async_request_enqueue(struct qce_device *qce,
>   static void qce_async_request_done(struct qce_device *qce, int ret)
>   {
>   	qce->result = ret;
> -	tasklet_schedule(&qce->done_tasklet);
> +	schedule_work(&qce->done_work);
>   }
>   
>   static int qce_check_version(struct qce_device *qce)
> @@ -243,8 +244,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	spin_lock_init(&qce->lock);
> -	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
> -		     (unsigned long)qce);
> +	INIT_WORK(&qce->done_work, qce_req_done_work);
>   	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
>   
>   	qce->async_req_enqueue = qce_async_request_enqueue;
> @@ -253,13 +253,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	return devm_qce_register_algs(qce);
>   }
>   
> -static void qce_crypto_remove(struct platform_device *pdev)
> -{
> -	struct qce_device *qce = platform_get_drvdata(pdev);
> -
> -	tasklet_kill(&qce->done_tasklet);
> -}
> -
>   static const struct of_device_id qce_crypto_of_match[] = {
>   	{ .compatible = "qcom,crypto-v5.1", },
>   	{ .compatible = "qcom,crypto-v5.4", },
> @@ -270,7 +263,6 @@ MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
>   
>   static struct platform_driver qce_crypto_driver = {
>   	.probe = qce_crypto_probe,
> -	.remove = qce_crypto_remove,
>   	.driver = {
>   		.name = KBUILD_MODNAME,
>   		.of_match_table = qce_crypto_of_match,
> diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
> index 228fcd69ec511..39e75a75a4293 100644
> --- a/drivers/crypto/qce/core.h
> +++ b/drivers/crypto/qce/core.h
> @@ -6,13 +6,15 @@
>   #ifndef _CORE_H_
>   #define _CORE_H_
>   
> +#include <linux/workqueue.h>
> +
>   #include "dma.h"
>   
>   /**
>    * struct qce_device - crypto engine device structure
>    * @queue: crypto request queue
>    * @lock: the lock protects queue and req
> - * @done_tasklet: done tasklet object
> + * @done_work: workqueue context
>    * @req: current active request
>    * @result: result of current transform
>    * @base: virtual IO base
> @@ -29,7 +31,7 @@
>   struct qce_device {
>   	struct crypto_queue queue;
>   	spinlock_t lock;
> -	struct tasklet_struct done_tasklet;
> +	struct work_struct done_work;
>   	struct crypto_async_request *req;
>   	int result;
>   	void __iomem *base;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


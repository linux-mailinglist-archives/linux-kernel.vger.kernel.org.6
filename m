Return-Path: <linux-kernel+bounces-429578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B0A9E1E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7ABB36777
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724AA1F4279;
	Tue,  3 Dec 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Shl3/REX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4481F4282
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233434; cv=none; b=OROTnli53qSrOrkAR2r5JJNgMg0i5U4hQW9Z3zqvIB4SqnaWVy+X8BW45e+96sKV0vG6hFxoaRwqszc6QaBFbzB9j29AXwF1FzbetWtKRWyl421beBpMxRAfOsY7bHwcexr85+wM2jgCifFkzfhXSHFXFHGAQL4lbfCkubS8Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233434; c=relaxed/simple;
	bh=h/H64AjH1resYYh7pSajSeRAMmIf+GNc/QzMRHg5pcU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fYXotu+Jt3BMNRIWz+p+7oxixsr2FhojjocXqIewvss2EDrHOav1jsfUjqSHYCbXgmsUtob8u8Pu3hJtF4bdYy1ZcI9Re+LwpFQZ+Fue77hmO3Pqx4jLMQu70/gw5zX+5WKyI9ctNLSp21r06Ldv+PRb+bXi4slEdjp6C/lpM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Shl3/REX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a766b475so51156845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733233431; x=1733838231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgdXZzkRST/sLdc7nrSWhwokS4E7nABem3RymMknfnU=;
        b=Shl3/REXYe6Vp+IjtQG52B8n6ayXOG5eQJZTrW9Fq6nwchOTVvd+W7zhpJZIwCm4bv
         zGVDs+/Ulj1CBXcbubI+eOG39mrJsUdnMMCO1SRcqkrVRd/fvmC3/L/+N23U9NL0Ksuz
         4hD4knNuY6hyx2JWHR2DxNO/uyuzADfPncIYHe3Xdgqnr0uuTGU8ER55aNOiQ/f7JESD
         djC4logeXyvbrUF+PqbXmkhN1VlGxH5mAXUGUiPos7DjYxyuih+JVJZ9AmpWzfiZHzvf
         qcsr+Yx3rP2Y5kYIlZ8CJXtmlmS4FBV4pfHBnwE7r9GPDEQAIuumNeyTsmI2SHTS88m9
         zLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233431; x=1733838231;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DgdXZzkRST/sLdc7nrSWhwokS4E7nABem3RymMknfnU=;
        b=bUuo7sgFi0tJ9CHZbyZth6W+2FiQ1k480ywxmSVWTKEIKX0Eov57SRa99PAAnxf3FL
         szqovrXmPWm6iIq+CT1pWThoIMd3OAHKe4O4r3qYH0U4vNZMGyz4ekWwl93JX5eRY96t
         wgcnxBjgGyzCWhJMnRm5lcjIC0T30QkD5NpsHLh0LJmY776m3gZknWbeGC3gwIdhIgsq
         lZJiNaY/L2ka1eSY9IhgtAvFKpCcJD4nmrVluUA9QWdfz00Wuab7ogeaG5pmwhNLcJgt
         Gj7jbOnePLZ0O6+QCZsTGBiwn6W11tgPYVvvpuWxZ/SSegzTy4XEtKYGoDfrgH6lNWJu
         vg3A==
X-Forwarded-Encrypted: i=1; AJvYcCV0PVWqN3h4cHMVZDn2Xk+c8dOAjpmmlaksBiJwuZZMdlcgdXU9N5eTvLydvNJbqa5EP+pwXpbZABTmOPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIW7Sd/B8NsDafSbANw5acUC91eBECb2oK8Jh4EbMFiIhJ8VM
	0l0eljpuGbno4Y/tnS/oKjPeXCLfX/NwaIsVgz7fYKbWj9kGmkiZBKUSlmXycbE=
X-Gm-Gg: ASbGnctWs6QgWVoUmO1C6YUKZB739KT/gD6Xbetr0EuOe+iO1F895e4d8weRlKeiNEz
	/onowZRsmvZ+EpTRG8UXRpcHXpnXdrmnLUtX5FkxvPqRAmFUIJyCDeOXEYOT9+YSwYSBirMQQlH
	XPqMU58AyLpOeYG9ByN0mnJtciZlaiZCs2k7Zps7DFGQ9xlEyguH30W+9wkaYNOUgILz0ozbNRa
	Pj9tBjnOVo0ZC2ZZ9uLpL6Dd2F7H+psmCJvkBmLhqDjQXjyiuPQjbUhJcIqLP2/XvF0GtwsgDJL
	v3GKZmc//giDR7WfBVl/gpj+
X-Google-Smtp-Source: AGHT+IGbWePKnUO3Kq9oBel6RKE1Sq780i2MRlsxxW+cGbXtoJO2MzF/5XoVky0eO3VG0u70U6nKtQ==
X-Received: by 2002:a05:600c:4fc9:b0:434:a0bf:98ea with SMTP id 5b1f17b1804b1-434d09c0b88mr23428935e9.9.1733233431323;
        Tue, 03 Dec 2024 05:43:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b668:b88:4ecf:c065? ([2a01:e0a:982:cbb0:b668:b88:4ecf:c065])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70ea8sm196319275e9.40.2024.12.03.05.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:43:50 -0800 (PST)
Message-ID: <2a799583-3d19-4517-aa7f-347a05d02e0b@linaro.org>
Date: Tue, 3 Dec 2024 14:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/9] crypto: qce - fix goto jump in error path
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-1-c5901d2dd45c@linaro.org>
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
In-Reply-To: <20241203-crypto-qce-refactor-v1-1-c5901d2dd45c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 10:19, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> If qce_check_version() fails, we should jump to err_dma as we already
> called qce_dma_request() a couple lines before.
> 
> Cc: stable@vger.kernel.org
> Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index e228a31fe28dc..58ea93220f015 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -247,7 +247,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   
>   	ret = qce_check_version(qce);
>   	if (ret)
> -		goto err_clks;
> +		goto err_dma;
>   
>   	spin_lock_init(&qce->lock);
>   	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


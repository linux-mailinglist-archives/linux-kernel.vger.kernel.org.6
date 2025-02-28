Return-Path: <linux-kernel+bounces-538023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCBA493AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB88218862E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE32505A4;
	Fri, 28 Feb 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMWGDOU7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324EF2512C1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731729; cv=none; b=ZFN5gkrhVJtd9AZzwu01ZcMrWQLhAFeU20iBvKqjydJKULvC3yf7jOpsAN+Y9R5FXm8q71v/r5mdzuJEQQC7T4QmwF2ltojXFcDnDBj65faoKEoxF19KTvsAcbS/TNf2PGsqtgpkDcI+duqs+zHqqgzmiphUDU678DhF0d8X61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731729; c=relaxed/simple;
	bh=FP3XUZefBHYp1T0ogEGz2yfokrmVIpKRcgOO9jCDPtc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kt/iCvq/BfTrc832AiZKuyY7tjVE1mJ4nfdVP6Z16uHjsQ4N2gkkivLAcAYaK0PYBXCY7ftJ/vqavTkzdGkwEH/nrtYCynHwUsRttIF7Fg0hkRUR//o0Bj+dFRzkMxA+Pu/HeBOQCSTBjF5svTRgBJYeZb70MunTGCUdwywO+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMWGDOU7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4397dff185fso16254335e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731725; x=1741336525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMK2CgxEdhkGHeCsjcFaZfx3mtGOXWIMlSnBy6fFrmY=;
        b=JMWGDOU7S0lqUPCMMD0PRC8M1jhvkAb2j6UIFOb3VPyFthAr8UNALX1wkb1snBOGCN
         hPhHvUU5Kz9clsR/UnD+b4tR6nofeWaB75HMZLID27enrXdnCWDV0f44e1hVmRwb1Hj4
         KA0vsgcoN8Z0Pl4mh2A3K6dln/FSUpslytsDyCd1hNNH17oBzj9Lj/6WnBiNV5zSJbqU
         yJCF3RkDoykHPAGD7+0wwAje1a+QvXtRniJiYv7op3Yi7G25UTFImQCxKeXK8B2rDunc
         zikkUDty9xUyfD5RFC09lRxJzRPdD2alMPlh/aJ2bJDf4mc969rOSHUODzd8UWb65B/A
         wGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731725; x=1741336525;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JMK2CgxEdhkGHeCsjcFaZfx3mtGOXWIMlSnBy6fFrmY=;
        b=KdiRsnk/yX4H2OpTQ/ERfssHFbUu2yUHkm9L5XezXTUyenHBJkfwfu0xXB6Sa9zOVE
         6pIjLNnODJRutCt/CBKf784/GPxamJop6h638gSc+Aik2WIY+Dw20yzJSs801IrqUbFz
         ed0u903eCy15O0UlLAwqoJuajZx0HosX3vLEtUHZqM1PsMZ9Kcf91jAXGF3n1Twka7Hz
         8VraT3sYV3xydwtIr8kpKjsK98AyhLXJ1cKqjyEPqVd0iwf8zlYmt9cif85ZhFSWXFGi
         atUuN9kOWEsoQUII5R8dLvNtedcSQhep18WYxjrmOQc6yywQIMKL4RGdglR6XewgEiLr
         yRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWdLdmNl551oSWWPeTjO2CW9dUB+awvh7yaGoQg/B4+TD5B7Cphsx7xQANUovwgExXNvW1U2rFh2ro11LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh08VaRINLaUKG7mnGHH0tifAJb5t7DwmQHgmGYGo2DaLglpfS
	Ik2IcA3rDfCNVKC6YjK04ES3AAepfwNgGsCSlHBxZGh9HAqjqEEDq2WD4QErmJ4=
X-Gm-Gg: ASbGncv3rh1ZRdeoTKR5MPacf3bbPmgJUobMdjoqbQAgrxDVMeEZ+aS0WRNL2lJ9xdm
	OrYCB370CcfFd+PY+15GjzGn4ZLfdyeLkkPuG8JpgxFfT/LHMIQnpZ71sl4iNebdl6PGf9D4oFe
	k4hTi/hxJcqThppvs2ya0MsQYz4S/RG9xdA+rlpbzQs1jcbpwv8ZaSHGSxLBYSeTVQYRapAMsZm
	l1j5YpxC2/2iEI7HWqy7MecBl6DFczsFDsuaW5MEaQKm2whoh96iFj9X9+VjiQBkwIsFhFVIEnV
	gqcWBB/AO9Z4GyzhQLbkB3lzyfAPFH1GQRmwNTzGhgbXCnXZ+yBwlyXG6psXIYlSfBesjro23kj
	ctLM=
X-Google-Smtp-Source: AGHT+IGW9PqgGpxHry7vRzkOBmK3anMdXC7hKXVPOKcyGeLAA+8YnheUo9+++1+lotLjt0c1mZFQrw==
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-390eca815a6mr1759817f8f.50.1740731725519;
        Fri, 28 Feb 2025 00:35:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c728:ed22:3bb8:f351? ([2a01:e0a:982:cbb0:c728:ed22:3bb8:f351])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844892sm4521223f8f.64.2025.02.28.00.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 00:35:24 -0800 (PST)
Message-ID: <8e7bac41-71aa-42c1-a0dc-09a5d9e5693e@linaro.org>
Date: Fri, 28 Feb 2025 09:35:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] thermal/drivers/qcom-spmi-temp-alarm: drop unused driver
 data
To: Johan Hovold <johan+linaro@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228082936.5694-1-johan+linaro@kernel.org>
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
In-Reply-To: <20250228082936.5694-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 09:29, Johan Hovold wrote:
> The platform device driver data has not been used since commit
> 7a4ca51b7040 ("thermal/drivers/qcom-spmi: Use devm_iio_channel_get") so
> drop the unnecessary assignment.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> I noticed this when doing some rework for pm8008 last year that I have
> yet to finish.
> 
> This can go in meanwhile.
> 
> Johan
> 
> 
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index c2d59cbfaea9..a81e7d6e865f 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -360,7 +360,6 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   	if (!chip)
>   		return -ENOMEM;
>   
> -	dev_set_drvdata(&pdev->dev, chip);
>   	chip->dev = &pdev->dev;
>   
>   	mutex_init(&chip->lock);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


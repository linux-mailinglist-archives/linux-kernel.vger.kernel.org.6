Return-Path: <linux-kernel+bounces-513521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A250BA34B25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F9B18872B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E028A2C6;
	Thu, 13 Feb 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOSN0Acs"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BD28A2A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465784; cv=none; b=gER/LvWUO6iFjfP/LMws1Z8oO0x8RqsSRRPpfmpU3HTFvcn1txo4YGwG1YrjOziPlTw447K/RJWaBnljcGCaAufDn1zfGrLWtR85Tyf0PD+PMLf3QxHfM2NB92N6R/71nAowvkUbnszwHVHI+AuX+z3gklOCmP+mS8hmZxzRCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465784; c=relaxed/simple;
	bh=74gtV/p5YwvrWhM7X4MHQP+eyAb1Paw/CMsuE3aPm5E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V4Jt/JDKog326atnT0xIRPOrX44P1jzQl2amWzrCynLwqQc47w20vosN+tK6ZgIqRd20tDux2TJQaUHNxlhfmgo/Ywys9ajTWzLzPD1JKca2czhSNwXPgMnwQw6NM7lgtlBAL9vdAs48xYgN0Bz2JxRHldQQ1VCSoDGswmNNjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zOSN0Acs; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5450681b606so1147736e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739465780; x=1740070580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/envL72wMRKdikgn0jlOsIdrQo3kgOjkSiUW09bvDSc=;
        b=zOSN0AcsdORjaFx2Zt7JllyL+kFdZiLfMUdM1mJjq6ZVGrbZTy8SUhCvG4tkf+Aj+z
         u4RG2Qb21qv/APD8YV3E/Uj88BpRA7r9K03+xc9B8wEQqmWLnpSYxZ7VpBa2G2pE0wvq
         kE1Lom78dYd3L2airyxiBsGVm6ueiEA/cY/Dn+Ml0b+6JCqz5KATNPkOU/vo5lY6VVom
         TQ7kc+jElwxlR03lrkDUknTyVp/SDkOlJmgSThOhcd6btGISB6PYhCcnXBR+ZfmfQyvs
         walSojYxqcndfLlzULiLIqpsj6wr6MgTW7v3eAnm+7KQeCU/72CY2lyj9BPVANpKk9jc
         8yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465780; x=1740070580;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/envL72wMRKdikgn0jlOsIdrQo3kgOjkSiUW09bvDSc=;
        b=V44dJE51JMgfTzmcGdi5eij5azhifedCCCG9HWGjFQ3ng8j/rKrKllJ6eAKCSZdUP1
         An6ivEgl/9Hmbv1IWZZEpCRiQVmBRS3y/1Tg1vwEMSzJ8PsJGQph6PHTZFiMUgUBTE4Q
         S1Azti4D6VV4N93LrEF994mLKX95gxejv/iienlgs+qse7OXRtV+kbF31DDgPAsLLrIU
         t4B0Tc+KJ7YdwRDqDLSm09ZVAadr1hsDWDfNIw6elojHG8AsyAmCsY0Xe8D1RNA43In5
         f2Q2T3MM/MbNLmJepooZJgZ56xsVAXCJpjbt/KUNQzydd2asn9t7pHZALvy5aTCjTU5P
         xOvw==
X-Forwarded-Encrypted: i=1; AJvYcCXYa7qRKjw8sOP3PDJKHbXS+lgB655P3Lj2JYxXow6OZwtpXZaOEaZ1Av/PUyT8UImnjefWHZSRm5eYgsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLLiyYZ8m/ai2SaBC+uPQB6uBwdSbTsk6O64key9otfujyCy3
	uG1ARDQychZTnW/8liDfzYxMmV6fFxabg1n0z964iz4o7gYrevMKEosFzWUwfy4=
X-Gm-Gg: ASbGncuCfwT6JRLMJaPli2ugerhhkebZRGc5ZZSRhQjiggH01W85wVhG5YTyBEnpzL2
	D8/0MKsDg8RrR82qr4bMVyZ1Qzn4osD0ovmEeNAm+4f2C0/ivlf9YwCpETApzTswXlaB0ws0e/g
	HZUah2rrpNi+95WqPBzaW/3GY5+51bdSPMke3KP0Q+VgPHjc/9a7ebSvjLEb124Pmirx1F80zaO
	4T2lqSjOBMhobCj9sq9jG6jGHOJsmFWYMdTD5DdiNwAg5mQaiyuv8eUXYOJ+EwRJ/6VMs3usw1y
	2SdBRw3ubjPk/Nz8UiRVC7K5zFewJD+MPs2vj+ip1mY5WE96NAi5769qqvNjqNDbu3cW
X-Google-Smtp-Source: AGHT+IHnDme1A09aFbNagSefdEV+h90f4ZlM9hLHk8vhRV/RdAImC8Xub2lJ0Glyh4NPgqmQceNBkQ==
X-Received: by 2002:a05:6512:b08:b0:545:8cb:218d with SMTP id 2adb3069b0e04-545181551b6mr2616230e87.41.1739465780168;
        Thu, 13 Feb 2025 08:56:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b065:478c:3f8f:ac1b? ([2a01:e0a:982:cbb0:b065:478c:3f8f:ac1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105f28sm219002e87.118.2025.02.13.08.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:56:19 -0800 (PST)
Message-ID: <489c405a-b2c1-4252-b170-ef77b5a90ca2@linaro.org>
Date: Thu, 13 Feb 2025 17:56:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/msm/a6xx: Only print the GMU firmware version once
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Abel Vesa <abel.vesa@linaro.org>, Rob Clark <robdclark@chromium.org>
References: <20250213-topic-gmu_no_spam-v1-1-1e4afdd898b6@oss.qualcomm.com>
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
In-Reply-To: <20250213-topic-gmu_no_spam-v1-1-1e4afdd898b6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2025 17:44, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> We only fetch it once from userland, so let's also only notify the
> user once and not on every runtime resume.
> 
> As you can notice by the tags chain, more than one user found this
> annoying.
> 
> Reported-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Suggested-by: Abel Vesa <abel.vesa@linaro.org>
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 65d38b25c0707a3c7fff08d110b4ac2b9d410473..699b0dd34b18f0ec811e975779ba95991d485098 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -813,10 +813,10 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
>   	}
>   
>   	ver = gmu_read(gmu, REG_A6XX_GMU_CORE_FW_VERSION);
> -	DRM_INFO("Loaded GMU firmware v%u.%u.%u\n",
> -		 FIELD_GET(A6XX_GMU_CORE_FW_VERSION_MAJOR__MASK, ver),
> -		 FIELD_GET(A6XX_GMU_CORE_FW_VERSION_MINOR__MASK, ver),
> -		 FIELD_GET(A6XX_GMU_CORE_FW_VERSION_STEP__MASK, ver));
> +	DRM_INFO_ONCE("Loaded GMU firmware v%u.%u.%u\n",
> +		      FIELD_GET(A6XX_GMU_CORE_FW_VERSION_MAJOR__MASK, ver),
> +		      FIELD_GET(A6XX_GMU_CORE_FW_VERSION_MINOR__MASK, ver),
> +		      FIELD_GET(A6XX_GMU_CORE_FW_VERSION_STEP__MASK, ver));
>   
>   	return 0;
>   }
> 
> ---
> base-commit: df5d6180169ae06a2eac57e33b077ad6f6252440
> change-id: 20250213-topic-gmu_no_spam-4fc4c459755d
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


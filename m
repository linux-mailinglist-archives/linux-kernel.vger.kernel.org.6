Return-Path: <linux-kernel+bounces-219124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3690CA25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E751F22028
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E8158DD0;
	Tue, 18 Jun 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iff/+Dct"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5E158DCE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709196; cv=none; b=rRPJBYDmb1XocZhUNmVLoGDzfvEyJWv7YdlDSBHYrCLbRvGTRZW914At0RV5fVK7zykeoZom6k7+9WbTJmQ6GtT+2CbQ1k93VjahnCqLP/wEZS9GbjbQorC8W35XsGfPVV18xsNorCn+DnXjahdPjBYBRon9iEo7zxtrc3Ti2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709196; c=relaxed/simple;
	bh=ygTqAmSf0IfPNGq1Shs18IB+YIEVcTNMo1JV/OBncAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9AJqlxZUc/JZ2BpJCZvroIzdsgHnb15EDBZbjvQyAb7nr74gEvqrJF8kYFw5VsaX3WESpz1FgDygBGeuIa+oiAxZlPq0l6PPdJ5neh37xvuSeUYn/3UQNlb4NXbA+zTtoniPcgJzBI1Zz64MCiX/n8AlB3spmMsNFTeidYdqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iff/+Dct; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cc1528c83so1062881e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718709193; x=1719313993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZUe7gF67J9gDxOaoNUrJWpHp/2/v3KlOF4371wquz0=;
        b=Iff/+DctX2C8u060DPaW5Ae9G0SgfAFh/WdUObvWJAw1LTIMIQSTXD72gSDy07veK6
         mFTU50XZwD6bkKvQlanhExsmAS+3Ir/MBN3t0azcnLOl1SYfCKIGlqcOp5czLjFUOGsK
         khpOUITl6zJxzNXBH9wmINluZwfTHOx29/U6AGuMjM9M3TOBgTFFuMbgg4GXBf2ibMhW
         umzBOej+RK3ePC0Vas70Q6RfQkWnjqG0k8p5fLHZFGFwEBHO4g94UCKrqgew0OyfWU+H
         5xzmWDyP/cijUHsYUfzf+thQHgFsWFls2yFP0MqTa4mDs8lzbDr+Yuh1Sx8yYM/ZjIDV
         kUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709193; x=1719313993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZUe7gF67J9gDxOaoNUrJWpHp/2/v3KlOF4371wquz0=;
        b=T9jkiU96BSLALt7mdhAQpmh6avMbftT6YkfVr+STQH3RfhKsg0fnZuEH5j8PaxiLfm
         4BVpWgk1fDRTJE1wi7e1JQ5Z2heuiwpfFNIlM0YjMfs2dKWvwDSqk3X5XEh4FpT0oH9S
         LlZyvfc2m+b8jWH87biu7iMdvp9EVlq9vZ+lNcH2Vmd2jdUTDPZ9/qDQ36xzTt9IJfSI
         3HJZUqj2AP6FKMFBuHwrC3r/7PIW+mtwsCshNRL4zLwzcO3oNDGjrnbcHNt6ffxDj3ha
         f3eWFJ0I3Bl5HTZLVKowgiN/sKucVBhfreIesN32OSJTnt+ude4Y9i4sI9Nsk04ggAh2
         41gw==
X-Forwarded-Encrypted: i=1; AJvYcCVNUJlc66ijJuLlCPRm3HPAUqDDLvRFh+J8MMJZGacFW2a4zgpQCnE9VAbnBE0g+kSQ4sEN3F4+ta6v9ihmrUjBcixQO5ZL9jRnZka7
X-Gm-Message-State: AOJu0Yz5F5j1bd5LdP2mo1eTVgNAOkwh5H/mPSmGuo29oE0ruXyDe2t8
	MEGqcvK5McZyNzqAbi2BYqT6zQxb6JC1shOtEI1IlLXmz+5LmrL9kziis0gH9wk=
X-Google-Smtp-Source: AGHT+IFvHh/ds3YGzEZJqogwunAMiM1SJOHwoExwr3tTrv56ocyHxKE2bN01RmdOChtzhx+k1jIP3g==
X-Received: by 2002:a05:6512:15a:b0:52c:958a:4afa with SMTP id 2adb3069b0e04-52ca6e65889mr6824542e87.23.1718709192614;
        Tue, 18 Jun 2024 04:13:12 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cbb24b860sm652495e87.191.2024.06.18.04.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:13:12 -0700 (PDT)
Message-ID: <c3ab8619-2842-4e90-883a-04e45fb18394@linaro.org>
Date: Tue, 18 Jun 2024 13:13:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/msm/adreno: Move hwcg table into a6xx specific
 info
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-5-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617225127.23476-5-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 00:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Introduce a6xx_info where we can stash gen specific stuff without
> polluting the toplevel adreno_info struct.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 65 +++++++++++++++++------
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  6 +--
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  9 ++++
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  6 ++-
>   4 files changed, 67 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index bcc2f4d8cfc6..96d93251fdd6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include "adreno_gpu.h"
> +#include "a6xx_gpu.h"
>   #include "a6xx.xml.h"
>   #include "a6xx_gmu.xml.h"
>   
> @@ -465,7 +466,9 @@ static const struct adreno_info a6xx_gpus[] = {
>   		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>   		.init = a6xx_gpu_init,
>   		.zapfw = "a610_zap.mdt",
> -		.hwcg = a612_hwcg,
> +		.a6xx = &(struct a6xx_info) {

const

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


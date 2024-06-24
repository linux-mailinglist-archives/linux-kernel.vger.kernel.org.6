Return-Path: <linux-kernel+bounces-227311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A4914F35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B081F22F73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0532B141987;
	Mon, 24 Jun 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl3KhjHb"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8A1411E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237237; cv=none; b=adLeszjcIdqvuH/PzhQa3O4/CEAhjT+ZWAEXwtBegcE45Soiw7sLu6egYelfvbrT5oVAJCgY7H2nCCFRgwmV21ukKrrFxjGjx710rg5Wb6a8KHf/pr7Dx/HN0saNOafm9XX7NxUNZO6IHwjVBLM0l0fFwe7cRR1mPifrByM7a3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237237; c=relaxed/simple;
	bh=k2kNvre2Me0LAngo+HM9BUoQeYsmECvhu4GbqQWpJTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpfDsHbQmzonbH+KF8d4QV6c+5oEGsnq4plrLoGUIgccVGU5d4ptJqWK2cgoqHQ9dzd8bmH9sl/ujd4cbe5mZmtzSA1Whkl0ruzAOmrzUoM04uWjrHYY2nsPfUdhzYLvlpIBj+cexMGJjgYZoXtPDD6Vwl1+aI+hKF9Jl1KA/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gl3KhjHb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so53104911fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719237234; x=1719842034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S10zLLSMGCffMYd/h+/RimKZkqJmO/jBCyUz/wexOY=;
        b=Gl3KhjHbwZqtHAzZ4el7rCBtXTYlg47WVzN8kIIaHmESFqdySdfK1EWaGg+GQqIX0l
         bcXET+QIC2dBTWH2rF6nvMfvq+qcnWBs58IzzXJ/00rUXkCKdPV4h01JR15L/1YYJX7w
         geV5M27VpSwvDIPHNdzf0TE3ZLb69KR5IW08/xCJ/n/CAfhT5/pEsejkUmpO6kHWbK3w
         Vuf9kZRQIZ/ggMAl2qieqGYWKf4Tm6SkBr4OpBQl/wVOPjDDWVwKaHIXMUj9f41pdnyd
         gnypJWFRzTDPYOghfOg9oRrIIYsp/5JpCOa5Bppnc0PvbqlLHp29WTmH5uDBUM/vbttn
         KKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237234; x=1719842034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S10zLLSMGCffMYd/h+/RimKZkqJmO/jBCyUz/wexOY=;
        b=Ud2afuStMhYPbRyy0fZl8MnlZOR+PKsjgLXp4OoB6H7A0qUL7F6Lpy3z+54A0dlPiA
         M7QX5nhj1nZFPbIvvDFSxLT4zxrd8TjcBKrzc9ovx+EjaPVA+EplnkRNL5KU+D+FOxc1
         HN+M1oZprK67kkuVk6qQhoTUDAz//YmAH8pqIJrYR/8pHrKyhXwmIMo2MQwOPCFliqDk
         7A22/0uYTUFvGzCM6Yx0tb3D/QCnBJGrHlcA0t2DzYoaOE/zxkM701pSRsWaVUyoswMM
         en/NdSbG6RgTTkfKPhBU625ui/osxqTYNCXxxVxkeTt1MQXugMe8XUqUg3DBPFJKw6zW
         A5RA==
X-Forwarded-Encrypted: i=1; AJvYcCXFKvCC2CqsJj4XyWHmqfw+1tVZ932YoJDUR3LowCchYjiQFAkqVNm+ryC2JHjd8bYIMxJPxFr09AvphWz55U9do8+Z7ufARGOFPwvN
X-Gm-Message-State: AOJu0YxgnaDNgudueog81aeizrSkosRwuWt5sZZwADkRdOEWKgAv/DEF
	MDRApxlcqJHeQ9B2K1Qjldlo+Xvvn7t3b4ak8e6MCd7zGC42/lqK1yuS1oRd3KU=
X-Google-Smtp-Source: AGHT+IF7G8yRO1cSo8vqHH5UaeNqcbHw+S8TNtA0Ju96Wb3SODipWZSK3i2ngTmztbBS/byXZ+YJCA==
X-Received: by 2002:a2e:9b55:0:b0:2ec:50dc:af8d with SMTP id 38308e7fff4ca-2ec5b29fc03mr26068691fa.12.1719237233248;
        Mon, 24 Jun 2024 06:53:53 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c03:9198:7df:6a16:3e8e:ed7b? ([2a00:f41:c03:9198:7df:6a16:3e8e:ed7b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30534e35sm4701537a12.62.2024.06.24.06.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 06:53:52 -0700 (PDT)
Message-ID: <5947559d-30dd-4da1-93cc-a15dc65cb77d@linaro.org>
Date: Mon, 24 Jun 2024 15:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drm/msm/adreno: Add support for X185 GPU
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
 freedreno <freedreno@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>,
 linux-kernel@vger.kernel.org
References: <20240623110753.141400-1-quic_akhilpo@quicinc.com>
 <20240623110753.141400-3-quic_akhilpo@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240623110753.141400-3-quic_akhilpo@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/24 13:06, Akhil P Oommen wrote:
> Add support in drm/msm driver for the Adreno X185 gpu found in
> Snapdragon X1 Elite chipset.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 19 +++++++++++++++----
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  6 ++----
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 14 ++++++++++++++
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 +++++
>   4 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 0e3dfd4c2bc8..168a4bddfaf2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -830,8 +830,10 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
>   	 */
>   	gmu_write(gmu, REG_A6XX_GMU_CM3_CFG, 0x4052);
>   
> +	if (adreno_is_x185(adreno_gpu)) {
> +		chipid = 0x7050001;

What's wrong with using the logic below?

>   	/* NOTE: A730 may also fall in this if-condition with a future GMU fw update. */
> -	if (adreno_is_a7xx(adreno_gpu) && !adreno_is_a730(adreno_gpu)) {
> +	} else if (adreno_is_a7xx(adreno_gpu) && !adreno_is_a730(adreno_gpu)) {
>   		/* A7xx GPUs have obfuscated chip IDs. Use constant maj = 7 */
>   		chipid = FIELD_PREP(GENMASK(31, 24), 0x7);
>   
> @@ -1329,9 +1331,18 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
>   	if (!pri_count)
>   		return -EINVAL;
>   
> -	sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
> -	if (IS_ERR(sec))
> -		return PTR_ERR(sec);
> +	/*
> +	 * Some targets have a separate gfx mxc rail. So try to read that first and then fall back
> +	 * to regular mx rail if it is missing
> +	 */
> +	sec = cmd_db_read_aux_data("gmxc.lvl", &sec_count);
> +	if (PTR_ERR_OR_ZERO(sec) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(sec)) {
> +		sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
> +		if (IS_ERR(sec))
> +			return PTR_ERR(sec);
> +	}

I assume GMXC would always be used if present, although please use the
approach Dmitry suggested


The rest looks good!

Konrad


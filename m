Return-Path: <linux-kernel+bounces-513459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3878A34A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C3A1899E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D428A2D0;
	Thu, 13 Feb 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/Bx2Yfx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144C28A2AC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464535; cv=none; b=HAh9ZtNORWKwu6WvAjoSNcYKn+fpxkOZt/bpmNX5wqhBUjZKEsC/JKT92G2BcJg8MAeX0+U+hpVYcjIpMXkkvWpfzACmsg5C+db+5vQLKKQoXhdKe8EIOvpkCbMJSAS+bsykRf2sZdNam8OwdpYE4rSuGoRNejvTEA/pFZEXz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464535; c=relaxed/simple;
	bh=QkAlt2M1y0TiCkTxu4i1QewxxzLmHX9YtjLRB1QK7S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNir2AAbdlSGUN+0j0y5skl16lcqERe0EdL0AHizPfY3BArLZEY0O7TuQd0bHFuvFDKqD9Q5GiPGwi6XqG1W81wQQ1PdMTQG88RtBYRXqaz0mbRfEdQOs8UVUi8RBPWf86c0l43lGIGEzOqM7XrR6BPIMshMXvTICrllykfHLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/Bx2Yfx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4395817a7f2so7583585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464532; x=1740069332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkUcjMmDcjBIWHZCqAgxZp7FU0Fk/ys2zKA4pFxdyX4=;
        b=A/Bx2YfxJ3H/HP/rdLfR4EWreTMMX4HLrpxh8w5yfkvmBqyLggDUaecnulXLr3LrCe
         XW7sodE6WsNXqO5hRSTLEoH6rztJcV7hJ1+9rCGMI6NqSBA8NCpiHQOKHPvsagvnPixy
         T/nPCCnBkHDOMHkaroOXBbAnpLX2wJ1bzkEVKj6rk4Rt425NfxqU6eqzyvAee4842V12
         Fd7WJ4Eu7IQF1trsQjMyz9VLJq/qtPhYCufStk4rdNer4eFHrdMgZqY0cJ8nCFbtGZG9
         NVEuMzyhFFMa8YIV1SNn+RlvWMvKNBHqf1aUgov9etwHygegGUjir0ozWls4xlNG5S7S
         ShjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464532; x=1740069332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkUcjMmDcjBIWHZCqAgxZp7FU0Fk/ys2zKA4pFxdyX4=;
        b=a3s5b9oyQJg5VIgfJB8PG1wWJOyuESwAMIuoLaDJ8dc2RgCfR/qeE+mKAl2V2xu/69
         xI2mT3ZeQxCoEkj+qw2TCGmfzClc3wSjd0fCFjgKhsh/kcZp253KkWxR2zmlA6g3dXIr
         fpkVJaK4X4DsF0i90apHzbiz+9vP7wLDuJwDjHQEHgEWYY6nsTTQtwTXwLgx+tWlVTC1
         x7mxFclErbbHtZOtvQkR9XDpIkrm546jslzapuj+4Z5jyH5lez4KxGcqxSK1SFfw8xdi
         CefoJCFtbtkBRZ7QorbKLh76PAq4ch6caBqMan4UwJStf8eb/PmI97DRys+MjL3SOF9C
         wMKA==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZfANf1jeGIuKc5pLINSM87Ilt+IFFrsaOznpSGhzfUDEpsm3sV5d0s2w12e7yMnSZwiSbIl5f8CLI/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIBgGNXmD9v3in2M17CIpsPYRofktRdjn9FNpcBpk0GconXjW
	7KacR5GGPxLE3swrBc48DLTISCo84NqbLGp6c/60aNJM5QO0mJWmbSsgItjS6K8=
X-Gm-Gg: ASbGncvXVsUowSfDf5MwFHWyVO0DBuMZexGBCoCKk3Lpn3cgq28pFfIwSvfe0i1T3IN
	0kV6b64hiaNJxs2jW+XI4z1eaw3YmJsfhh44IgH1pwA5Ba3OiE3yNabrJtjNBJqFrY6gZO1wXQZ
	sJ9SGVY5M7hs5HwY2ELzELZjnneYIoBNXzbKd8Vr0LqsJ37jubcdDgLth25oNeIIP9KXqiLaZOp
	rKHJ3oK45luSdqW/0IthMEkUaf9AjZNi7uislvjyPw4duSFg1ZLlN+nMAGkls7YoTxkSs9jwOst
	jkiWY6MPKcb2cA==
X-Google-Smtp-Source: AGHT+IFM1kxdJteFvAGtFfb2y2uOiPSqES4FB6gOuR+NQII0SSEfN8Pt53ab+u81k2xRmqiGXbaHxQ==
X-Received: by 2002:a7b:cbc7:0:b0:439:65c5:f28a with SMTP id 5b1f17b1804b1-43965c5f2f4mr12621705e9.16.1739464532321;
        Thu, 13 Feb 2025 08:35:32 -0800 (PST)
Received: from linaro.org ([86.123.96.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439653f0556sm7049395e9.1.2025.02.13.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:35:31 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:30 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Print GMU core firmware version at boot
Message-ID: <Z64fUjIfFzs4R8Im@linaro.org>
References: <20241219-topic-gmu_fw_ver-v1-0-d403a70052d8@oss.qualcomm.com>
 <20241219-topic-gmu_fw_ver-v1-2-d403a70052d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-topic-gmu_fw_ver-v1-2-d403a70052d8@oss.qualcomm.com>

On 24-12-19 23:36:56, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Log the version for informational purposes, such as for keeping track
> of possible GMU fw-related failures in crash / CI logs.
> 
> Intentionally not implemented on the if (gmu->legacy) codepath, as
> these registers seem not to be used on there.
> 
> Downstream additionally warns if the firmware version is too old for
> a given GPU, but we already pair the binary to a given GPU, so let's
> not go there at the moment.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 14db7376c712d19446b38152e480bd5a1e0a5198..a7ea2b2af1dc3816906236df929df36e37d8f606 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -729,6 +729,7 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
>  	const struct firmware *fw_image = adreno_gpu->fw[ADRENO_FW_GMU];
>  	const struct block_header *blk;
>  	u32 reg_offset;
> +	u32 ver;
>  
>  	u32 itcm_base = 0x00000000;
>  	u32 dtcm_base = 0x00040000;
> @@ -775,6 +776,12 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
>  		}
>  	}
>  
> +	ver = gmu_read(gmu, REG_A6XX_GMU_CORE_FW_VERSION);
> +	DRM_INFO("Loaded GMU firmware v%u.%u.%u\n",
> +		 FIELD_GET(A6XX_GMU_CORE_FW_VERSION_MAJOR__MASK, ver),
> +		 FIELD_GET(A6XX_GMU_CORE_FW_VERSION_MINOR__MASK, ver),
> +		 FIELD_GET(A6XX_GMU_CORE_FW_VERSION_STEP__MASK, ver));

I get the following spam:

[  109.928924] [drm] Loaded GMU firmware v3.1.10
[  110.301295] [drm] Loaded GMU firmware v3.1.10
[  110.472620] [drm] Loaded GMU firmware v3.1.10
[  111.164303] [drm] Loaded GMU firmware v3.1.10
[  111.864830] [drm] Loaded GMU firmware v3.1.10
...

Stacktrace shows this being called from runtime resume:

[   19.380390] Call trace:
[   19.380391]  show_stack+0x18/0x24 (C)
[   19.380399]  dump_stack_lvl+0x40/0x84
[   19.380403]  dump_stack+0x18/0x24
[   19.380405]  a6xx_gmu_resume+0x450/0xc44 [msm]
[   19.380426]  a6xx_gmu_pm_resume+0x34/0x220 [msm]
[   19.380437]  adreno_runtime_resume+0x28/0x34 [msm]
[   19.380446]  pm_generic_runtime_resume+0x28/0x3c
[   19.380451]  __rpm_callback+0x84/0x390
[   19.380453]  rpm_resume+0x3d0/0x5c0
[   19.380455]  __pm_runtime_resume+0x4c/0x94
[   19.380457]  adreno_get_param+0xdc/0x274 [msm]
[   19.380466]  msm_ioctl_get_param+0x5c/0x68 [msm]
[   19.380475]  drm_ioctl_kernel+0xd4/0x10c [drm]
[   19.380491]  drm_ioctl+0x26c/0x40c [drm]
[   19.380499]  __arm64_sys_ioctl+0x90/0xcc
[   19.380503]  invoke_syscall+0x40/0xf8
[   19.380505]  el0_svc_common+0xac/0xdc
[   19.380506]  do_el0_svc+0x1c/0x28
[   19.380508]  el0_svc+0x34/0x7c
[   19.380512]  el0t_64_sync_handler+0x84/0x108
[   19.380513]  el0t_64_sync+0x198/0x19c

So maybe DRM_INFO_ONCE instead ?

> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.47.1
> 
> 


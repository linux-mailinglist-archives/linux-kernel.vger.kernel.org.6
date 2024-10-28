Return-Path: <linux-kernel+bounces-384917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A79B301D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210BC282350
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77EC188733;
	Mon, 28 Oct 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRwgHpkM"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DD1D7E3E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118280; cv=none; b=HoOxyUdcCDEnYwcR9fVyYOuhpqiWCDoMWUiNvtmwSQEH59z2fsflH3oCzZ5QP9gqwZS70ccP03ikfA9NFAZmedcs1zm7SQ09Xq2YLK0z1Y3C0XoOsY6GI5sW8dEtKgHDaPfdJhqx4U+cq7nQXL6xEw4LJ2zQd+rskD8zKscLg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118280; c=relaxed/simple;
	bh=mSaHE3v21lE8qms03Sk8jUDId6PqNL+b81JWEpgodG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hijg0jfVouhieLE96n0g1kETjuKaL6oOGykrbJETgmi4+5X6n7kuJfh8q5mt1SavVCDbV/kSZFjeCwuL7nfPLZ0mS1F+2vTnfTHaoejekBNBqU8DTXDASfVTgHRyL2O93ju6VU7C284dm2ZIzGkd8P0z3Y1SpZYtretmYX2ivyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vRwgHpkM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so41864661fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730118276; x=1730723076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiakvBu5HWQteUMkqul4SIcxvJVDyv5yRsVh32mSkGg=;
        b=vRwgHpkMIychKQjrSM3B/hC5AW//ktjoHTV2hbxDOd82osibbGeNUHBU/x4POSw6v4
         0F1bFkgb8SlSBeATSvbO1/huR6OuhmJYp2Gr/znwnaWBVQlJIUqH6D5qAgNCtQP6LaSo
         kbSfvFZR4/LQ+/NrZbGLUz+iWpkBwqCoCZBJADzvpbcTg30SwNnPEZCiWVFf2fgs4/ev
         8Tn9fkVO6UIVOhwwq9o9Dk9RUBTwceyckXZ+CBT10mn/DwGAMAw/dZU/ZVXLuQfYKigv
         KJtlR1HwU54CcOJy0QWpaBxZLgeAnmr+qyOFzsIsPv0lIDv3nOVN02/wkZKotqRRCr2O
         fivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730118276; x=1730723076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiakvBu5HWQteUMkqul4SIcxvJVDyv5yRsVh32mSkGg=;
        b=lCXEwORKiQ9DtIn6lWmRZAztNcCWH65OaR22w7S4Mu41M0KhLgHUYGp3j6xjRnmwTe
         TIfRjF3QwlyFCv2daan3nopX+WnGfeDkQzpq3v2D3SNoPS+U+h3Qcxml6tG7Yfft8Y0w
         uBf8GVlmwH7tRPwbsv5D+Y8B1SyCAEdDDQ5X9a7x78jJ4psmZJmfnREIgj5NNvvYyiF7
         EkbMb5S32rudx0OkotPD578MXulCuE15UmiD7HQFBxrW2KXANhoaWcBgNfSqkm6nmQmZ
         NI2+bVmKoRk6VTI4Joq1xjuXIAs3+w81AfjN377LFQ0wmUUcQ3S3vooIWdBCDb8KtHG9
         5vyg==
X-Forwarded-Encrypted: i=1; AJvYcCUGAIcUrCLBZifgzOXxUtIbvERpSe6woVTP6aysE7shyiaUBmVKrCAvOIo6JKKGt9fQFjWRsDzgW6Efd/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIG4kUaAUwqr8utdv8P4kNaw4MRFsD3u/8RVKmok2uCaav+ii
	qJQiutb9mpIr72Ky17MSBD6uVHia5z42mg/QJ0CZfGAGjdhwvWnFwkRbEyX+8bU=
X-Google-Smtp-Source: AGHT+IHMzvTbKsXQiE7Sg+SLUe/8P7mNRx/fVvevQS58dQwaGnRtlPzMwEtJenkdv8S3A7kBzaWS/w==
X-Received: by 2002:a2e:b8c3:0:b0:2fb:3445:a4af with SMTP id 38308e7fff4ca-2fcbdfe8b81mr29076191fa.21.1730118275722;
        Mon, 28 Oct 2024 05:24:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb451a043sm11549741fa.46.2024.10.28.05.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 05:24:34 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:24:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] drm/msm/a6xx: Fix excessive stack usage
Message-ID: <qvi32futhcoe4tklfsdffhpkorpxjqxyjsajrlyuxega6o2fzn@p37z7llhr7c2>
References: <20241027-stack-size-fix-v1-1-764e2e3566cb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027-stack-size-fix-v1-1-764e2e3566cb@quicinc.com>

On Sun, Oct 27, 2024 at 11:35:47PM +0530, Akhil P Oommen wrote:
> Clang-19 and above sometimes end up with multiple copies of the large
> a6xx_hfi_msg_bw_table structure on the stack. The problem is that
> a6xx_hfi_send_bw_table() calls a number of device specific functions to
> fill the structure, but these create another copy of the structure on
> the stack which gets copied to the first.
> 
> If the functions get inlined, that busts the warning limit:
> 
> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:631:12: error: stack frame size (1032) exceeds limit (1024) in 'a6xx_hfi_send_bw_table' [-Werror,-Wframe-larger-than]
> 
> Fix this by kmalloc-ating struct a6xx_hfi_msg_bw_table instead of using
> the stack. Also, use this opportunity to skip re-initializing this table
> to optimize gpu wake up latency.
> 
> Cc: Arnd Bergmann <arnd@kernel.org>
> 

Please no empty lines between tags.

> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

After all the discussions:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 34 ++++++++++++++++++++++------------
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 94b6c5cab6f4..b4a79f88ccf4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -99,6 +99,7 @@ struct a6xx_gmu {
>  	struct completion pd_gate;
>  
>  	struct qmp *qmp;
> +	struct a6xx_hfi_msg_bw_table *bw_table;
>  };
>  
>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index cdb3f6e74d3e..55e51c81be1f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -630,32 +630,42 @@ static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>  
>  static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>  {
> -	struct a6xx_hfi_msg_bw_table msg = { 0 };
> +	struct a6xx_hfi_msg_bw_table *msg;
>  	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>  
> +	if (gmu->bw_table)
> +		goto send;
> +
> +	msg = devm_kzalloc(gmu->dev, sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
>  	if (adreno_is_a618(adreno_gpu))
> -		a618_build_bw_table(&msg);
> +		a618_build_bw_table(msg);
>  	else if (adreno_is_a619(adreno_gpu))
> -		a619_build_bw_table(&msg);
> +		a619_build_bw_table(msg);
>  	else if (adreno_is_a640_family(adreno_gpu))
> -		a640_build_bw_table(&msg);
> +		a640_build_bw_table(msg);
>  	else if (adreno_is_a650(adreno_gpu))
> -		a650_build_bw_table(&msg);
> +		a650_build_bw_table(msg);
>  	else if (adreno_is_7c3(adreno_gpu))
> -		adreno_7c3_build_bw_table(&msg);
> +		adreno_7c3_build_bw_table(msg);
>  	else if (adreno_is_a660(adreno_gpu))
> -		a660_build_bw_table(&msg);
> +		a660_build_bw_table(msg);
>  	else if (adreno_is_a690(adreno_gpu))
> -		a690_build_bw_table(&msg);
> +		a690_build_bw_table(msg);
>  	else if (adreno_is_a730(adreno_gpu))
> -		a730_build_bw_table(&msg);
> +		a730_build_bw_table(msg);
>  	else if (adreno_is_a740_family(adreno_gpu))
> -		a740_build_bw_table(&msg);
> +		a740_build_bw_table(msg);
>  	else
> -		a6xx_build_bw_table(&msg);
> +		a6xx_build_bw_table(msg);

Note for the future improvement: this begs to be migrated to the catalog
data, adding device-specific callback instead of this if/else series.


> +
> +	gmu->bw_table = msg;
>  
> -	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_BW_TABLE, &msg, sizeof(msg),
> +send:
> +	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_BW_TABLE, gmu->bw_table, sizeof(*(gmu->bw_table)),
>  		NULL, 0);
>  }
>  
> 
> ---
> base-commit: 74c374648ed08efb2ef339656f2764c28c046956
> change-id: 20241024-stack-size-fix-28af7abd3fab
> 
> Best regards,
> -- 
> Akhil P Oommen <quic_akhilpo@quicinc.com>
> 

-- 
With best wishes
Dmitry


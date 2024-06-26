Return-Path: <linux-kernel+bounces-230245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD2917A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0191C22AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9F15F30B;
	Wed, 26 Jun 2024 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LTiBrCW+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556515E5CB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388785; cv=none; b=EfX2zFAkq38PrOkB+AnNjNgRY4xDgGhxr4YBAapris8notx5YlTmjtj940NygZERGmIEpjmOLdztK9B+dDBt5tkBdDGsUlxrxBoHJZ8GwtdZBHfajAuoeclBHeX+b/yMMAXvn1WK/QDZys8i+sdDJ2DVwyGk4d8RR+9UpolfI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388785; c=relaxed/simple;
	bh=UFcACGqxiuT8v7X+3Me/nx5E98iD5BFlwqaiy2cJxEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9Z8qtiK9xPyB7RgIVL+QUPt03tnXUPsmkPSZc0qGsus4DbQdAXAb+CvHMZDJOAF3Jssh6VSYaqt5LwJiZ0Y5Em781EEFQ3/nNZXhWoj7s8GwcpKEiJ/KYMXKZRitkjCAdmYq/V39sX9aHZqLc5u1k1tTPyQrOm2oFaGfP4v8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=LTiBrCW+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so8072605e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719388782; x=1719993582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKC9JWwz9mDZFJPWKIzZ35FYqwpsv8ltyyUAlB5rNg4=;
        b=LTiBrCW+GXlJeS/TpkF5cRN7slPn+qwJo0SxZ22Fgw++VhfznTkxYXft4D6ZMOitql
         r0ahvzWLCSjEodG9cDqTRvL8AQm39GYDtKLnNk1P52WbC8GP2dSlji9nnO7nI7fC2/uH
         SFLcQOFWCEMQy7ZH01d4JoT7QJC3K/Hvn9lAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388782; x=1719993582;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKC9JWwz9mDZFJPWKIzZ35FYqwpsv8ltyyUAlB5rNg4=;
        b=WUp4bUARoIrg7NKBG9EEHhH0iiHfKyuERd/njbMi3gwOJ/i/+PyUMbOMzLHD1j3XNE
         XwgZoWZkfmXl99zpdm9iEXkdbj/Lwi8wytl8XHiXBwjfuYgFgoQceWbXe7aeFH7TMHSv
         JBNqYOFosWt44Ay6B2WLjcy24VibXQuKg76mXmmdUVJ1ZpIm7vRfbys/hWKwP2ZQWBTg
         JtsChm+1F1H3DpIPOInyYT6Nqhlom3og3KQa12jqfuYBCpasM/32iq2V9YiU8yKIaQeg
         fEBbzL7lrRL0nZYSiinm6P7UUqHeIKQA92iAmqsVMLiq/PoRIAXIr8GYNUpljkoQHQeu
         obww==
X-Forwarded-Encrypted: i=1; AJvYcCX1do1LTGChq6nc5fRFTp8ga8j6hnc5ztA2TtketIzyz4KIXYitx9jTauXYAgr6fu2koPRU7Ut6HG8mLtVOBMpWSRjw3SNcfp2s6YuP
X-Gm-Message-State: AOJu0YwFR7hLJSF54/nouYYVGQZTqz96+VzBOWwuTMrtih/qTiSNTChW
	Q72kRir747DvrVLAYG6+dLbpTRGy2afGC4tUmVFk68LCwmS2/0BRBUCZ95JsUtA=
X-Google-Smtp-Source: AGHT+IG4EVOkrn1Y0XT/ql2oK40G3v2KP3e4L4gODD12bYa8V2Qg23ovSXufw0iA+4BOJcA67yWlig==
X-Received: by 2002:a5d:6d8f:0:b0:366:eb60:bcf2 with SMTP id ffacd0b85a97d-366eb60bd9amr6081538f8f.4.1719388781876;
        Wed, 26 Jun 2024 00:59:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9c158sm15120701f8f.56.2024.06.26.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:59:41 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:59:39 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Akhil P Oommen <quic_akhilpo@quicinc.com>
Subject: Re: [PATCH v2 1/2] drm/msm/adreno: De-spaghettify the use of memory
 barriers
Message-ID: <ZnvKa29EceUyZ62U@phenom.ffwll.local>
Mail-Followup-To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Akhil P Oommen <quic_akhilpo@quicinc.com>
References: <20240625-adreno_barriers-v2-0-c01f2ef4b62a@linaro.org>
 <20240625-adreno_barriers-v2-1-c01f2ef4b62a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-adreno_barriers-v2-1-c01f2ef4b62a@linaro.org>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Tue, Jun 25, 2024 at 08:54:41PM +0200, Konrad Dybcio wrote:
> Memory barriers help ensure instruction ordering, NOT time and order
> of actual write arrival at other observers (e.g. memory-mapped IP).
> On architectures employing weak memory ordering, the latter can be a
> giant pain point, and it has been as part of this driver.
> 
> Moreover, the gpu_/gmu_ accessors already use non-relaxed versions of
> readl/writel, which include r/w (respectively) barriers.
> 
> Replace the barriers with a readback (or drop altogether where possible)
> that ensures the previous writes have exited the write buffer (as the CPU
> must flush the write to the register it's trying to read back).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Some in pci these readbacks are actually part of the spec and called
posting reads. I'd very much recommend drivers create a small wrapper
function for these cases with a void return value, because it makes the
code so much more legible and easier to understand.
-Sima

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  4 +---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 0e3dfd4c2bc8..09d640165b18 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -466,9 +466,7 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
>  	int ret;
>  	u32 val;
>  
> -	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
> -	/* Wait for the register to finish posting */
> -	wmb();
> +	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
>  
>  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
>  		val & (1 << 1), 100, 10000);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index c98cdb1e9326..4083d0cad782 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -855,14 +855,16 @@ static int hw_init(struct msm_gpu *gpu)
>  	/* Clear GBIF halt in case GX domain was not collapsed */
>  	if (adreno_is_a619_holi(adreno_gpu)) {
>  		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> +		gpu_read(gpu, REG_A6XX_GBIF_HALT);
> +
>  		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
> -		/* Let's make extra sure that the GPU can access the memory.. */
> -		mb();
> +		gpu_read(gpu, REG_A6XX_RBBM_GPR0_CNTL);
>  	} else if (a6xx_has_gbif(adreno_gpu)) {
>  		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> +		gpu_read(gpu, REG_A6XX_GBIF_HALT);
> +
>  		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
> -		/* Let's make extra sure that the GPU can access the memory.. */
> -		mb();
> +		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
>  	}
>  
>  	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
> 
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


Return-Path: <linux-kernel+bounces-183061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C48C93F8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9019A281799
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288918C08;
	Sun, 19 May 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KI/GbEZN"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2EF168DC
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716107473; cv=none; b=X3GDEZxecwwUnxD9yRQ6i4RhwDkofbdDB+Q1yiyQ4doZGaGovNihUlzQRGTj9p4CAkGAxzWNlDl111+hSwyGgegLpsAfNlhlgZs+vTCYC4HBkMnxu+/ViZjwnssJlL8MQCm+DeUZKQohJVDKmR5tbjSzBM83EQQwLLtEX18kE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716107473; c=relaxed/simple;
	bh=F0LBOMZDJVE+xbmnqDNWkHm61GJlkhpnSs7Nz8Y6szM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI+BZmR4vMqqLxHjFZD6oB5gmSIVLYIE4dbLZMUnOOkBL6OopiZtl5fUFIuYAJB7XHBuVm6GlcArjvGWqs1NMicueGLUoE/EKx1xQsWw9ghpUOkugSZkiNvpLnnmpSoGGGJIu+KikScUs1S7jPKaIW0+AEUcrPRCG8CM+o+nYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KI/GbEZN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-523b017a5c6so5032592e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716107470; x=1716712270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3x30n4rUJq1+J/cwi02KSucHGfHRmh38wGSJ7vLBLs=;
        b=KI/GbEZNVrWmHAg32qInwZeg6owzZBa02pGKm9eYRhtJhowuJo2YrVtPpIE8ijNdAZ
         M0p0WOnATQ8vwmYUaUpfRR9QkzIYHnHte1ULSMGSuRZnnszOFlOznwsXpVW1ptrcr9b9
         D7Y9tsi2Np3Hnqd73HXG8BTj9ugh/9mFvlR9w3aC4ddFho70MkzVupnX6TWtVryl7JGS
         8wmf6cqhaSF+a2ZJ2MoTvonjWq77XOjQcFUiDywUtTqhg02bzFNKUBcSsGjOLpGW/MbZ
         nW7SJHitmnJvp3qxP8cO+ORE8GF/j/sFCk4p5aXqasqfBnRssrGUzB94vHl0zD2rRcDh
         p+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716107470; x=1716712270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3x30n4rUJq1+J/cwi02KSucHGfHRmh38wGSJ7vLBLs=;
        b=VBDHZrLSQl0Oe2HoUiClidmlGnpEM0KuNwxSbXSYtprwCjTgABXFAc2HETYlocqPhL
         9z6zU4ZOYUkgo0Y4dlAF2asIrXwEGY8FWv3i4Dvv+oB3JbQZ2TT6OZALQQzp5YQPK+KO
         /Sv4oNgopTT9WPmr/0dUrOIz3ZZVVOOlfzYXOF650QVwJbJFmUBdbj7PXUtchF6BvZkG
         7CMeaODH64q5rtqoS+KIOhNK5iYy6yYrxl1FqmmuWYeh7i9QX+d6PkxGNRCmVt7KcIkx
         5kyH3tLc2wjAKXJrIY0bbZdHO0vkDIvAZy1DASKejTmLMyvKkDd0EwHMmJUoNc1611Pu
         vIFw==
X-Forwarded-Encrypted: i=1; AJvYcCVVOXh12ZKeBEOloEb8bz0G13Knxqc1+Sl165pllib80ThA4L/FJlID+yQSqIjf8bN/h622FlZlWoO9LfoMiTIeDjVOk81JU0oZEI21
X-Gm-Message-State: AOJu0YxDPvyIY4q1nAPpk2PS8HCwDNdBtTDm1KokjqVYIYMffe2VLpQY
	03GXYnjcGHBDmLjphZcj0VJvv8CFKbWhqjZ4sJlE57pSI99ODYXs1UYMU5OWjsE=
X-Google-Smtp-Source: AGHT+IERJwac+d8XpIpGcOzehZBQ8zzZtThV/IUxxI/UfebWaSGBVYpY+oyFYOdhW5bfzMUQPlo0Hg==
X-Received: by 2002:a05:6512:3e17:b0:51d:605e:f0ce with SMTP id 2adb3069b0e04-52210278698mr30114392e87.50.1716107470416;
        Sun, 19 May 2024 01:31:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba5d5sm3779923e87.77.2024.05.19.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 01:31:10 -0700 (PDT)
Date: Sun, 19 May 2024 11:31:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	seanpaul@chromium.org, swboyd@chromium.org, dianders@chromium.org, 
	quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] drm/msm: register a fault handler for display
 mmu faults
Message-ID: <cwo63ra2ogrdr3ywmiuxewzuxzsyozyqfcict7xs5kp6uwy2qp@7e6fgb7oyszc>
References: <20240517233801.4071868-1-quic_abhinavk@quicinc.com>
 <20240517233801.4071868-2-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517233801.4071868-2-quic_abhinavk@quicinc.com>

On Fri, May 17, 2024 at 04:37:56PM -0700, Abhinav Kumar wrote:
> In preparation to register a iommu fault handler for display
> related modules, register a fault handler for the backing
> mmu object of msm_kms.
> 
> Currently, the fault handler only captures the display snapshot
> but we can expand this later if more information needs to be
> added to debug display mmu faults.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index af6a6fcb1173..62c8e6163e81 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -200,6 +200,28 @@ struct msm_gem_address_space *msm_kms_init_aspace(struct drm_device *dev)
>  	return aspace;
>  }
>  
> +static int msm_kms_fault_handler(void *arg, unsigned long iova, int flags, void *data)
> +{
> +	struct msm_kms *kms = arg;
> +	struct msm_disp_state *state;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&kms->dump_mutex);
> +	if (ret)
> +		return ret;
> +
> +	state = msm_disp_snapshot_state_sync(kms);
> +
> +	mutex_unlock(&kms->dump_mutex);
> +
> +	if (IS_ERR(state)) {
> +		DRM_DEV_ERROR(kms->dev->dev, "failed to capture snapshot\n");
> +		return PTR_ERR(state);
> +	}
> +
> +	return 0;
> +}
> +
>  void msm_drm_kms_uninit(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -261,6 +283,9 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
>  		goto err_msm_uninit;
>  	}
>  
> +	if (kms->aspace)
> +		msm_mmu_set_fault_handler(kms->aspace->mmu, kms, msm_kms_fault_handler);
> +

Can we move this to msm_kms_init_aspace() instead of checking for
kms->aspace?

>  	drm_helper_move_panel_connectors_to_head(ddev);
>  
>  	drm_for_each_crtc(crtc, ddev) {
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry


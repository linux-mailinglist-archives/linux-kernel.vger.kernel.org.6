Return-Path: <linux-kernel+bounces-309256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80432966830
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3EB1F237E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075DA1BB6B4;
	Fri, 30 Aug 2024 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pwf3xXJ1"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0B1C6A5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039589; cv=none; b=NkL3n1EilRV7VnPxjjm2oSlXNng1OcHH6kh3q61nhccUItWcl+2rpz1AZk2HcymVUwere9bnR4HXwKKDxNQkpQtGnB7PWH77oF6ZFG27zInWP+ke3VIh+CITJep9nLDK+eTph4ZKVCKVsGIFBAehDdLT8Ckn0jXKyfmdsVrZanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039589; c=relaxed/simple;
	bh=ra2Qb8WuWJCBh0iw6WIXHbxAIIitOVx6Hlm9YwxlSVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRZpE4wgXE9QY7SgoODaFiWd/XrZq6lxYYtwzQOT6vH60umOoDoQJm3E1YmrSYOxd2SOkgr7XGqg/D/uxouLriyGWGiaSk4y86J4nsh8YJU0UPeP1YSODggp+UUycVJtMbiOgHJrfZK0eHcivVOOlKt5h+a3qCPYlgAaAjCOwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pwf3xXJ1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f401b2347dso18915581fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725039585; x=1725644385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9RLqmZuPgkSZGcw3aqWvhJSnLmhE6YOvXyNpIJT4cs=;
        b=Pwf3xXJ1PXiwux/RwSsJO/vbDFBSGzmr8FXOquWGhHMUDVa4YuV6ToaXK7KGKbEYak
         VLbpJ0NLYUXobZaMjqubjsvpxRyGVl1QDXWig5SOxsJI9JtVVJrKClTsgP3yfH3It6W4
         D3kJcNOuVwei+YrfPBAKZ5RFwsTe9J88z8lzWAmTZamvxv6PGPTh1wQDY1ykAZUF2Kar
         kk6tHutZXlp1w8bDNbWOVvsermQ7P/U1UI/b9z3gbwhhY2TMQ0VAT95Vpxc+ZHZt7kcS
         h2QXMllCnj0WKoR54Sc9P/icrtzaBvbiWgaGUcM4DWaWImeQtlq7Wm7kS2H/6waTmhCE
         Zb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039585; x=1725644385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9RLqmZuPgkSZGcw3aqWvhJSnLmhE6YOvXyNpIJT4cs=;
        b=G09IvsJYl5AZKdc3Qfcwviv8wYf8UD7/A96eqn4kQgMN6YtMTR/uILus6z0I7B2RVH
         WAX9+NYApyxM4oLuNer1PIRR7dI/9Kis2mr3k14xspMbMebCICOmTuWGur2XmX1rzJAm
         Fz1R43OSywOO2Oc7b9D+OLprgdPS+/GHI0fUib5qREd0nwhfvFUxVvhlXG2vSLZ7wVF/
         MwdtD1nmnXho3tY3tCr7QaCRZ+haoX1gqBqTP9tjuaZVONBEJYzXJAPf8ZJlfRkrGjvV
         vsTzbJJzj1lbuZBdp61/kBg9iERfUViDMY+vizkmLnL6Q833clmh3YUoGH5/gpHqqZAx
         e6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXa86EY7XNLoX3DJk4U24ySscyE1IYW/hWJZG3SDSBXIRZEv1mqgAmlAGVs+M/VlKzSJtqcxNvDGAIRzQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiXxU+BT+8QNJSRfjEzOD1krOmK1Gg0XuTN6UzKuG2r6PG2D/
	tbdunuLCXe8KYtKz9T6tlVp1iig9vsEW4w6DpXIkxErTPye8n+VBmmd0eW4/nENSbuWwIxhmhyB
	i
X-Google-Smtp-Source: AGHT+IF6eoaBd3HfbZeeshXOGgUNf1X6KWPZzAHPqGgbnCdZT/fK0C7fYa4u01FRCsQjwzF8NT9EEw==
X-Received: by 2002:a2e:a587:0:b0:2ef:290e:4a30 with SMTP id 38308e7fff4ca-2f61e0adff2mr11666591fa.16.1725039584657;
        Fri, 30 Aug 2024 10:39:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f61517190dsm7568951fa.78.2024.08.30.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:39:44 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:39:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 21/21] drm/msm/dpu: Set possible clones for all encoders
Message-ID: <mg6wfuvfsdbewoacnd3vuidlgslbfmx5nhvy7ulwxolevt56at@ae2x3jd34d24>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-21-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-21-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:42PM GMT, Jessica Zhang wrote:
> Set writeback encoders as possible clones for non-writeback encoders and
> vice versa.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 27 +++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  7 +++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  7 +++++--
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 47b5a5994234..aad659e6d35b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2352,6 +2352,33 @@ static int dpu_encoder_virt_add_phys_encs(
>  	return 0;
>  }
>  

Docs should go here.

> +uint32_t dpu_encoder_get_clones(struct drm_encoder *drm_enc)
> +{
> +	struct drm_encoder *curr;
> +	int type = drm_enc->encoder_type;
> +	uint32_t clone_mask = drm_encoder_mask(drm_enc);
> +
> +	/*
> +	 * Set writeback as possible clones of real-time encoders and real-time
> +	 * encoders as clones of writeback.
> +	 *
> +	 * Writeback encoders can't be clones of each other and real-time
> +	 * encoders can't be clones of each other.
> +	 */
> +	drm_for_each_encoder(curr, drm_enc->dev) {
> +		if (type == DRM_MODE_ENCODER_VIRTUAL &&
> +				curr->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
> +			continue;
> +		if (type != DRM_MODE_ENCODER_VIRTUAL &&
> +				curr->encoder_type != DRM_MODE_ENCODER_VIRTUAL)

Align to opening brackets.

> +			continue;
> +
> +		clone_mask |= drm_encoder_mask(curr);
> +	}
> +
> +	return clone_mask;
> +}
> +
>  static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
>  				 struct dpu_kms *dpu_kms,
>  				 struct msm_display_info *disp_info)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 7ab5f9380bf5..70eda127488a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -98,6 +98,13 @@ enum dpu_intf_mode dpu_encoder_get_intf_mode(struct drm_encoder *encoder);
>   */
>  void dpu_encoder_virt_runtime_resume(struct drm_encoder *encoder);
>  
> +/**
> + * dpu_encoder_get_clones - set possible_clones for DPU encoder
> + * @drm_enc:        DRM encoder pointer
> + * Returns:         possible_clones mask
> + */
> +uint32_t dpu_encoder_get_clones(struct drm_encoder *drm_enc);
> +
>  /**
>   * dpu_encoder_init - initialize virtual encoder object
>   * @dev:        Pointer to drm device structure
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 87526d3c224a..1a82aa61d217 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (C) 2013 Red Hat
>   * Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   *
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
> @@ -793,8 +793,11 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>  		return ret;
>  
>  	num_encoders = 0;
> -	drm_for_each_encoder(encoder, dev)
> +	drm_for_each_encoder(encoder, dev) {
>  		num_encoders++;
> +		if (catalog->cwb_count > 0)
> +			encoder->possible_clones = dpu_encoder_get_clones(encoder);
> +	}
>  
>  	max_crtc_count = min(catalog->mixer_count, num_encoders);
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


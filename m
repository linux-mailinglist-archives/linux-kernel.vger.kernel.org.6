Return-Path: <linux-kernel+bounces-309208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2F966780
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F331F25871
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92216C68F;
	Fri, 30 Aug 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNSm38fU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B31509AE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037263; cv=none; b=DlEopcBql1R5D+VDL1sxX8k5aqAu0sGVYQ6PbWTywRc8hxYtsCvPADVSxrDXgQS/QjCJlPkEscQK9XRPrCNyyXtJBLY/xb9DyMRqMcAGlM+CANm6cfEAldgdwZPvQbfnNldPioqpER6fU8C50UGqGwn57zfqQaXEBIHKcmNuWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037263; c=relaxed/simple;
	bh=2ev9hNS+0zkgEAP608vXp8qFL47CuGNbUg3sxLS5ri0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgP+bvy3OME8kw5lrRzmgexf76t+vEzU9lkLGXBUK91tUi4rRhYZGtIpsmhU87dr6ntaPFr7lhh7dP+ItgiJUa4PQ3YzhCRa9gmoDU3h6pJkUSwL5J5p/8o89obWv4uhg5LTYLZCZ51H3DoHbWhRMwz5w1Do3kcaClyGI8f3hfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNSm38fU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f01b8738dso1512584e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725037259; x=1725642059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyuzVMuh/pclBHjeTifeYUKcalShwXXF1JsCaZjhr8U=;
        b=oNSm38fUbPbzjG3/BxCs0SlDJbFf3Q881NSO3WLfyTnENmsJgn2DmdYTRl36gdce2x
         jqMBz5Ta8K+FenZs/19xSmBUEXDKqqGchEo+q6OBbyDnT9qj2RKzksTMp62fmJCADiUx
         B4nhPO8E98YusKc9tBwNgmIl2wtnjGCg2zYlJrQIHYSLPvpWCcAnWIMwIHftLqkDZBod
         zWRqKQZrxnRPX3Gcb4gmg7Z8t4NNdWJbaKw3B37JzhDDhUNPB9nu88XarfByv904L3gM
         PgyoCDgiZflnGTUbxTaQlvRyt75o4PfgcrvEdIw2DIwlPi09lccq3SdoslwgT2qZy2i5
         OwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725037259; x=1725642059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyuzVMuh/pclBHjeTifeYUKcalShwXXF1JsCaZjhr8U=;
        b=Py2SwJiN7UQFGFdxomCu/optbzK7v1gBpoRtqWefOyjVfB51oan6pqNK23XTtdwsri
         nRDddIY3lrWL6pG/PbWSZYWQYhZgEx3vDar/edjQ046qioe/MYoch8yo9sSQBtIUSrEU
         1mM2TC2I0cH2MlFf2eIBnGQfGVaJNP6G76tE56IouqETd1SaM1Lc4hkKzxj+6EyLG1bE
         BAj4clp1QVuc6nyOUqM44x+zrEMLlZhxs4skVFUK5gPhuuTFqVRlfz+7yOJHPnpVmFaB
         H/dgE1zhwTDwbx0b1MCEcb5GLKKwExLwSAdhGHqVmPBp++sJGtgCgE+ysuhXk91rktkl
         WXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5J+Yp++1xibaOGxcxkSmL19pJLNey6/PphIwZl/8BdHuTghmklRkOBmF35WGefJwUd8xs3QPyFqAQCnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIWgRZAmh4ifj0ypO0Hg8Go0BNqHDS7Jciv3XU33GKfNRA/qD
	IHm+Nbv9TfLYPILskz5wEYY1x5DJDaPVisn70cHy+YVxvmkQw7jYoSXfH0n4fC8=
X-Google-Smtp-Source: AGHT+IGfsWr29CZq7zFPXPe35gykwJrno7dzUDJ8NIv9QSBL6Rohbmv/iEfu754VwWaVnHFGaag8Hw==
X-Received: by 2002:a05:6512:3e1d:b0:530:ea2b:1a92 with SMTP id 2adb3069b0e04-53546b93fa8mr2032468e87.43.1725037258492;
        Fri, 30 Aug 2024 10:00:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407abdb9sm685041e87.72.2024.08.30.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:00:58 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:00:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 07/21] drm/msm/dpu: Check CRTC encoders are valid clones
Message-ID: <uqtlpynjdszqyyikj64uxwuqnk3lmzma7kd2vwxipnj4fg2eje@7toj5kww7vk7>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-7-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-7-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:28PM GMT, Jessica Zhang wrote:
> Check that each encoder in the CRTC state's encoder_mask is marked as a
> possible clone for all other encoders in the encoder_mask and that only
> one CRTC is in clone mode at a time
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 36 +++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 5ec1b5a38922..bebae365c036 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   * Copyright (c) 2014-2021 The Linux Foundation. All rights reserved.
>   * Copyright (C) 2013 Red Hat
>   * Author: Rob Clark <robdclark@gmail.com>
> @@ -1204,6 +1204,36 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  	return topology;
>  }
>  
> +static bool dpu_crtc_has_valid_clones(struct drm_crtc *crtc,
> +		struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_encoder *drm_enc;
> +	struct drm_crtc *temp_crtc;
> +	int num_cwb_sessions = 0;
> +
> +	drm_for_each_crtc(temp_crtc, crtc->dev)
> +		if (drm_crtc_in_clone_mode(temp_crtc->state))

No, get the state from drm_atomic_state. temp_crtc->state might be
irrelevant.

> +			num_cwb_sessions++;

Even simpler:
if (temp_crtc != crtc && drm_crtc_in_clone_mode(...))
	return false;

> +
> +	/*
> +	 * Only support a single concurrent writeback session running
> +	 * at a time

If it is not a hardware limitation, please add:
FIXME: support more than one session

> +	 */
> +	if (num_cwb_sessions > 1)
> +		return false;
> +
> +	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
> +		if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
> +				crtc_state->encoder_mask) {

Align to opening bracket, please. Granted that other drivers don't
perform this check, is it really necessary? Doesn't
validate_encoder_possible_clones() ensure the same, but during the
encoder registration?

> +			DPU_ERROR("crtc%d failed valid clone check for mask 0x%x\n",

DPU_DEBUG, don't let users spam dmesg.

> +				crtc->base.id, crtc_state->encoder_mask);
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  static int dpu_crtc_assign_resources(struct drm_crtc *crtc, struct drm_crtc_state *crtc_state)
>  {
>  	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_CRTC];
> @@ -1287,6 +1317,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  			return rc;
>  	}
>  
> +	if (drm_crtc_in_clone_mode(crtc_state) &&
> +			!dpu_crtc_has_valid_clones(crtc, crtc_state))

Align to opening bracket.

> +		return -EINVAL;
> +
>  	if (!crtc_state->enable || !drm_atomic_crtc_effectively_active(crtc_state)) {
>  		DRM_DEBUG_ATOMIC("crtc%d -> enable %d, active %d, skip atomic_check\n",
>  				crtc->base.id, crtc_state->enable,
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


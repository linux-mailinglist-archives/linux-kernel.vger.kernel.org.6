Return-Path: <linux-kernel+bounces-311426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F606968901
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8524AB22349
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64FF20FA8B;
	Mon,  2 Sep 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="U8JD3QvR"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4A20012E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284178; cv=none; b=Jpz6je7Dvm6ocb0Pke3A1b+r698X1bs5kvJsOnJV3Ai1eRR6dvLfh53qLrPBnUl8neGXGvIH+lrs5BADvDS7xBc8iOtejURQf56KJsEtPCag00zTu7nZKGLBlwC6jSp+eXOS73rZF63Y1lLPArp1a0NUBB7EtcACCqTIrf4AZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284178; c=relaxed/simple;
	bh=E/VZ7GrHjsNixiI5+URY2Wc2RKp6Poy1SHD9++Jjmv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE6u+SCQQ//Mgb6fC06ADAz5JQ4T8VRg1WguHYrIm+a1tii5ozYIqjbP/UyX0cXGZ5fKjwhpN+VrpKYRNmqsLL/s0E+9tKGMu52VGJl6/X8l8/5nRmLdft6IdKY8nrpzDaTH9UGXf6rz9NT7rGVHUIBePQui003feyB47AGnmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=U8JD3QvR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so19970735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1725284175; x=1725888975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6v3FtktqquHZEtnfmY82ilNEJb6ksXTawePio7XooLM=;
        b=U8JD3QvR0plnR/9zQ8J4RcZYvy9OhWenwuPO8WX/tyJoff+w971/fq45JRB3iUB1bS
         7HplsRTnr9LZOIGI185oB3tt9O56ths50KPECvRrcO0Xm/ZSt6ypbGcmlz2AGPTsNH6y
         LGzRz2t9me1D6vJ5ST/p+GGdV0Z8hpF++SWZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725284175; x=1725888975;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6v3FtktqquHZEtnfmY82ilNEJb6ksXTawePio7XooLM=;
        b=Ie/HyuxsCy7ly346NrBIoMebLP6+Is4wFF2g4VkSyHiugzf6KnLTZ1UyjsBFfsv4I+
         qYifUK4v3GK2W8LwMJtgSeCh5jPU6crxHGDeVxZmV2rf54ec8R3H7nMSue1E0/sAEKWR
         s6yiKjcQ9v4Ko0Sft97rPNu0NPSToCwq5sZOKnp+7tmncowSz7rjQY2IHPL/X+7kmibV
         rePoCyfpvyAzmIjEynxe8O7w3pxpSRHONPlf6+R0/nGqETRFWnzwCUsw9cPgRrTNReVZ
         HMKSmg+RuVwvMdJR1G4vArverYynqfhapd+6BIgc7Xino+c2M+dqomWPvDKgekfZloZ0
         Kn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYHBjH6h2/ARc0tKGhG52DJmOOh4KP/pvyg4AfyT5m/y20BmijOH0/NLp4tRJrc1LCoH25cnReZSwlbSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysbiZnCgDGI3jzOUn9euiFSSyE408dbdO7cvaTMsMQHcPSjOm
	3vfLEethz95pvoM7wUanpp6VXPn5sT6/rNwRnya7/ulzSggFJqXLXMDXs1b5ngU=
X-Google-Smtp-Source: AGHT+IFmCAd/UKn+8RiDLAzhiVps6I/r8wIzIThrxAPcZIbCaz99pcPpBKWDT6e22RdxtT79ulMxyg==
X-Received: by 2002:a05:600c:3b11:b0:429:a05:32fb with SMTP id 5b1f17b1804b1-42bb01b4428mr88808955e9.10.1725284174404;
        Mon, 02 Sep 2024 06:36:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c7fa443esm4065467f8f.41.2024.09.02.06.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:36:14 -0700 (PDT)
Date: Mon, 2 Sep 2024 15:36:11 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	quic_abhinavk@quicinc.com, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 13/21] drm/msm/dpu: Require modeset if clone mode status
 changes
Message-ID: <ZtW_S0j5AEr4g0QW@phenom.ffwll.local>
Mail-Followup-To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	quic_abhinavk@quicinc.com, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-13-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-13-502b16ae2ebb@quicinc.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Thu, Aug 29, 2024 at 01:48:34PM -0700, Jessica Zhang wrote:
> If the clone mode enabled status is changing, a modeset needs to happen
> so that the resources can be reassigned
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 1b0cc899e8c1..99eaaca405a4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1306,6 +1306,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  	int rc = 0;
>  
>  	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
> +	bool clone_mode_requested = drm_crtc_in_clone_mode(crtc->state);
> +	bool clone_mode_enabled = drm_crtc_in_clone_mode(crtc_state);
>  
>  	/* there might be cases where encoder needs a modeset too */
>  	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
> @@ -1313,6 +1315,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  			crtc_state->mode_changed = true;
>  	}
>  
> +	if ((clone_mode_requested && !clone_mode_enabled) ||
> +			(!clone_mode_requested && clone_mode_enabled))
> +		crtc_state->mode_changed = true;

So two things, and kinda about the overall patch series:

- msm is confused about crtc_state->mode_changed, e.g. it sets it if
  crtc_state->active_changed, which is wrong. Or msm dpu code doesn't use
  drm_atomic_crtc_needs_modeset() correctly.

- changing crtc_state->mode_changed from your crtc or plane callbacks
  means you cannot use drm_atomic_helper_check directly, but need to roll
  your own that calls drm_atomic_helper_check_modesets again as needed.
  See the kerneldoc comment for drm_atomic_helper_check_modesets()

- the same holds if you set mode_changed from your encoder or bridge
  functions, but I think this doesn't apply here for this patch.

I think it'd be really good to

- review existing kerneldoc and please submit patches where it's not clear
  or detailed enough

- add checks to the atomic helper code to catch this. I think the best way
  would be to check if drm_atomic_crtc_needs_modeset() changes outside of
  areas where the helper code allows it already (essentially connector
  functions setting ->connectors_changed), and set a new
  drm_atomic_state->dirty_needs_modeset. Which
  drm_atomic_helper_check_modeset would clear, and which would result in a
  WARN_ON in drm_atomic_check if it's not yet cleared when the driver
  returns with success.

  Otherwise there's just no way I think to make sure drivers get this
  right.

Can I please sign you up for these patches?

Thanks, Sima

> +
>  	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>  		rc = dpu_crtc_assign_resources(crtc, crtc_state);
>  		if (rc < 0)
> 
> -- 
> 2.34.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


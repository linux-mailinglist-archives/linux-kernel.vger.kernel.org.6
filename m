Return-Path: <linux-kernel+bounces-521645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D44A3C032
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A4D7A3F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11D11E7C23;
	Wed, 19 Feb 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lOqoTwCJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC919CD01
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972515; cv=none; b=qIMKoBglLhljI72G5d95vLT6qaiCzLXKnfYZT1qbt7MkLTdmwPgVITL8WlvkE0xhAflmj4m5j2ZTiXigfA/Vjz79WWwd3CNXawVh8oYHlsu3G7p14QiQmfklGrNLXI6eyN6k1h87HPcXNjGj5uAey75KOPGiDt3cRG9KrmMfKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972515; c=relaxed/simple;
	bh=MSbo5OyVwpx0ccYvcjvrWMHWauQADeNmshAHT3OzVbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd/urwcEWAbw7RIfOM5WI8UYiJ3qIYGIcbnbupIwljvdo6qo7PPEVWjnCX3iNnHjbRQ6oi82ufcCxkOR5s8wavoikSNGUivIrczL1uajq8+Stnv9TkUZ9d5wNedCuQsgqErpc+Eroqgnn4fQEB0fAOLcM8PFelhkm0FaDQcmzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lOqoTwCJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so22425345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739972512; x=1740577312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhEsWoeyFhMZ+H0YbRGARkl/BdUesonQu+oufx1Ijlo=;
        b=lOqoTwCJEGXEtQKjj3/sVEyB7DN/AlPyo4iCEwin2HXxKZdRTyGCDUrFV81/G9kQyj
         wEa6qdaQVbah3EIng4teYj0IffTE/koDURkId7Up3XNouicYilxGUg6p58eCzOV1g3l1
         +a1orOZWVjhE0ilPHaMqhDpirQyt9GsqL8qBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972512; x=1740577312;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhEsWoeyFhMZ+H0YbRGARkl/BdUesonQu+oufx1Ijlo=;
        b=a0JpzwbY7id07om8Y9JRWerzb6hNFLJdqzs8f+6A6aYyh6a+GK33fgGe27VLPEz9yJ
         8kTF3AHzSd0CcBssNgxAgghzTy0cTQWwoVsskS5cmUeKd7UGWImF1IYGLzFTxNpXv/77
         2hV8bzbSU7RwGNTjU6qCao+yPS726KB1/6MM7y4IlF88NvZ7kSZ3NeIIYDyNpiY+Q21u
         HQKBvbwbNxVoQItvzfPaGJChrjknjIpy044ZbWExfTSeil8CchdYpupep7p5PCnFdYtw
         MyXIrODiOQn+ufGOElSLrJHERhHqEvp5av1UlN7g1oOX2zXG0wr0Up8uWmdKOQBQi7x+
         79LA==
X-Forwarded-Encrypted: i=1; AJvYcCURESKOuLscwlaysCIYCjqVDRRXKpeKPEeXcLCwkT1hvY/TecVB7h77+tUJBVFZP9oMtP4KSBbpygPPU7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcE+/wLy6VGWLlV3T4YI4hxRs+6fbKvRKV32lcayCAgqwdfJW
	cUeKVDAln7F2DnaknQx9JWo5ZTj0ovZbEuD3hMseh5GQJH6Kj8ocbxWKMg6uaTQ=
X-Gm-Gg: ASbGnctp1J+aJFBNQVZINk7rTAmtplUc30pSZ4CF8AAUMGH1oIrUBr4tjRIarJGjUUI
	NYaRigDgEUwF7XP0CwtUAJOSMo+wRqO6cWTBvF+/vd58B5KN7qQoMdook41FzMatEZqirj6zgak
	HfSPm4UVdwvOnBiCK5EXNrVzKvVlZpOdC+TjzDCIUD4HExVmcfkK1K7MrEXHMGjljJ9sCdy6tql
	+b+X5rmYV5s2F2CiIa0eCdNzFQ0ihnXJjJLeElwLFEF7/VyJn6xlz5wTBS9pCoxuQvrH7QHO85P
	nY7oiLEH0sjZ8TcEZc1fZlQqyt8=
X-Google-Smtp-Source: AGHT+IH5SPDJC9pS46sc9lnXQknme1kBqPSFPC97vyzoPEWE/sFG6YIJSWi/4TZyqRhIbFPVeJg7KA==
X-Received: by 2002:a05:600c:1c12:b0:439:9a5a:d3c4 with SMTP id 5b1f17b1804b1-4399a5ad56amr28220925e9.2.1739972511749;
        Wed, 19 Feb 2025 05:41:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4491sm17570552f8f.7.2025.02.19.05.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:41:51 -0800 (PST)
Date: Wed, 19 Feb 2025 14:41:48 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/4] drm/atomic-helper: Introduce
 drm_atomic_helper_reset_crtc()
Message-ID: <Z7XfnPGDYspwG42y@phenom.ffwll.local>
Mail-Followup-To: Herve Codina <herve.codina@bootlin.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250203145824.155869-1-herve.codina@bootlin.com>
 <20250203145824.155869-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203145824.155869-3-herve.codina@bootlin.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Mon, Feb 03, 2025 at 03:58:21PM +0100, Herve Codina wrote:
> drm_atomic_helper_reset_crtc() allows to reset the CRTC active outputs.
> 
> This resets all active components available between the CRTC and
> connectors.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 41 +++++++++++++++++++++++++++++
>  include/drm/drm_atomic_helper.h     |  2 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 8ed186ddaeaf..cac807df8a86 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3363,6 +3363,47 @@ int drm_atomic_helper_disable_all(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_disable_all);
>  
> +/**
> + * drm_atomic_helper_reset_crtc - reset the active outputs of a CRTC
> + * @crtc: DRM CRTC
> + * @ctx: lock acquisition context
> + *
> + * Reset the active outputs by indicating that connectors have changed.
> + * This implies a reset of all active components available between the CRTC and
> + * connectors.

I think you definitely want a

	Note: This relies on resetting &drm_crtc_state.connectors_changed.
	For drivers which optimize out unnecessary modesets this will
	result in a no-op commit, achieving nothing.

> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_atomic_helper_reset_crtc(struct drm_crtc *crtc,
> +				 struct drm_modeset_acquire_ctx *ctx)

So this is pretty close to DP drivers doing link-retraining when
reconnecting a cable. Would be really nice if that could also be rolled
out there where it fits, and maybe augment the documentation accordingly
so that dp helpers point at this?

Either way would be good to extend the kerneldoc a bit to explain what
this is good for. Either way.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima
> +{
> +	struct drm_atomic_state *state;
> +	struct drm_crtc_state *crtc_state;
> +	int ret;
> +
> +	state = drm_atomic_state_alloc(crtc->dev);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	state->acquire_ctx = ctx;
> +
> +	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +	if (IS_ERR(crtc_state)) {
> +		ret = PTR_ERR(crtc_state);
> +		goto out;
> +	}
> +
> +	crtc_state->connectors_changed = true;
> +
> +	ret = drm_atomic_commit(state);
> +out:
> +	drm_atomic_state_put(state);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
> +
>  /**
>   * drm_atomic_helper_shutdown - shutdown all CRTC
>   * @dev: DRM device
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index 9aa0a05aa072..53382fe93537 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -139,6 +139,8 @@ int drm_atomic_helper_set_config(struct drm_mode_set *set,
>  
>  int drm_atomic_helper_disable_all(struct drm_device *dev,
>  				  struct drm_modeset_acquire_ctx *ctx);
> +int drm_atomic_helper_reset_crtc(struct drm_crtc *crtc,
> +				 struct drm_modeset_acquire_ctx *ctx);
>  void drm_atomic_helper_shutdown(struct drm_device *dev);
>  struct drm_atomic_state *
>  drm_atomic_helper_duplicate_state(struct drm_device *dev,
> -- 
> 2.47.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


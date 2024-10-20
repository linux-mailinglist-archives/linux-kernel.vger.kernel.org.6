Return-Path: <linux-kernel+bounces-373215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321219A53DD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7EB1F21BA6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A019146E;
	Sun, 20 Oct 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwyaErZE"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1AD26D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729424875; cv=none; b=ZMYa4YCa9ZRRWqa/cu+GzhZUx3oydOfsbMuLmJMF72MSEEaIeqnXtGSTf9ZEDuDxuXIVC6GznkLnNTHTw+TyMI8WOv/xD3bBDULAzyuzozvaEYuTbsjH9722FFm//j/wQhFMtjgjLTMkfUQnxY6ErO/NzQo+byJoK4Rzhit/1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729424875; c=relaxed/simple;
	bh=/9/nYY+hbbFJwS03Zm4eK2Q/QgjUw75Ctus0lU9TiSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo0Xm+eFc525tlkHFmr+63NSmBJegENBS5Cq/fwlj0mjrUrLjJpRCLBuZ/lF6V35oJ+nenkShc6/2yQZJTBE8t6KvBlOZuIW8PDt59R4vMtvqWn6Qa15JnpgdXl/yYhDI7biTISOCDTwOfSVHTOE+2kKV7EJzPYlD7grwtRwKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SwyaErZE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so31665221fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729424871; x=1730029671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3MwemwtOnXFXWvxYPsTpfeerKMKatzArLCCx5itR1A=;
        b=SwyaErZEu+t+yRxxGQOtlq6liqUNJYW00vIMrFJw42w4V2xXB4BktgGVyzglBqxzBA
         C3FVLS37HSQO02B0ZLcvW3caN1aOj6/0gpM8ZMHtYx1okIiO8NdJbplyM9HcNAsBwSVi
         fyMSBWI5pwbXZntSkI+N+33efOdP8RHHw1ZBT14+dJCvxqIEsmRDQIZeKXSy3tl1w/j9
         QXCSm0+ta7HOcXvqR+Sx7x1srh/sdpyUJMfnfLNRA+wiNwIaR1iZrliWrkfvAXjSl4I/
         lswNQjHB8yYw8PcXIRoV3bn+lA4wKW66h3S6nZJH29Y0ZeYPIMFDTjl+LIOYMCeaWXg1
         Pz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729424871; x=1730029671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3MwemwtOnXFXWvxYPsTpfeerKMKatzArLCCx5itR1A=;
        b=S0T2EefO1Xa3m/BKO+nmVOtwermChpb0oM6l5PJ5TiL2NIquzb4d6/cc5lX7DfGggP
         RLt/v9LUxmOJXwfIA0aFgGGbif78zejox4MTrjJA3k5OXC05C7rS9XpTXxPccPUHkpZf
         J5b2kaFf8m7R8ZThLIr2uV8kBhEBCI3O10Xc+3WRzzIKG1M03qRxzSZxfxzl74IIVEwI
         X49JcxNpqCkLi4fCW23fHjGglXi3zRvW+KrtSysB5Zzd3SviQ69oXW6IgnKi7BenMTY3
         Bfx3ngeO7UqSZQWWYJPyCeTXM3pDr7jeqOHvFL8tPU1/uY0aP1Rkbr9l5ok1aRarmCVg
         wPmw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQ/5scipAdYQRpWzinvOPVtwG6qqFGelUcvbiU9zHHOIJ5pMCXf9q2ATe0J6+d9fCIcy3IBa8OPk2eCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLL45YWjHFPf80/rAiTE/YB9fNTLYF40yLQ8Z77/1qufHm7CRx
	xFLLAdkgHo+J+QvWAlwj6j8XoJ47WmE5ZzX+9I8Mxb9gOU9RIhZcK/gUY6DQ5wA=
X-Google-Smtp-Source: AGHT+IFiUWIYUPRBLqRq5jEiHwazU34w60+UrA+qWxSb7DwqSwwF4F0Sdu4M/kprqUWv3jTXpdksqg==
X-Received: by 2002:a2e:851:0:b0:2fb:3a78:190a with SMTP id 38308e7fff4ca-2fb83262a78mr25135511fa.29.1729424871024;
        Sun, 20 Oct 2024 04:47:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad4b804sm2117621fa.1.2024.10.20.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:47:49 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:47:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 11/13] drm/atomic-helper: Separate out Encoder-Bridge
 enable and disable
Message-ID: <d3odg42cw2zg6jf3zrjtmquq4fyrvb5stnzptexv7auwvtq3yf@ljohsfvp4uhq>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-4-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019200530.270738-4-aradhya.bhatia@linux.dev>

On Sun, Oct 20, 2024 at 01:35:28AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> The way any singular display pipeline, in need of a modeset, gets
> enabled is as follows -
> 
> 	CRTC Enable
> 	All Bridge Pre-Enable
> 	Encoder Enable
> 	All Bridge Enable
> 
> - and the disable path is exactly the reverse of this.
> 
> The CRTC enable/disable occurs by looping over the old and new CRTC
> states, while the bridge pre-enable, encoder enable, and bridge enable
> occur by looping through the new connector states of the display
> pipelines.
> 
> At the moment, the encoder and bridge operations are grouped together
> and occur under the same loops.
> 
> Separate out the enable/disable loops of the encoder and bridge
> operations into a different function, to make way for the re-ordering of
> the enable and disable sequence of all these display elements.
> 
> This patch doesn't alter in any way the ordering of CRTC/encoder/bridge
> enable and disable, but merely helps to cleanly set up for the next
> patch and to make sure that the bisectibility remains intact.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 97 +++++++++++++++++------------
>  1 file changed, 57 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 5186d2114a50..7741fbcc8fc7 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1122,11 +1122,10 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
>  }
>  
>  static void
> -disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> +encoder_bridge_chain_disable(struct drm_device *dev, struct drm_atomic_state *old_state)
>  {
>  	struct drm_connector *connector;
>  	struct drm_connector_state *old_conn_state, *new_conn_state;
> -	struct drm_crtc *crtc;
>  	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>  	int i;
>  
> @@ -1189,6 +1188,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  
>  		drm_atomic_bridge_chain_post_disable(bridge, old_state);
>  	}
> +}
> +
> +static void
> +disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	int i;
> +
> +	encoder_bridge_chain_disable(dev, old_state);
>  
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
>  		const struct drm_crtc_helper_funcs *funcs;
> @@ -1445,6 +1454,51 @@ static void drm_atomic_helper_commit_writebacks(struct drm_device *dev,
>  	}
>  }
>  
> +static void
> +encoder_bridge_chain_enable(struct drm_device *dev, struct drm_atomic_state *old_state)
> +{
> +	struct drm_connector *connector;
> +	struct drm_connector_state *new_conn_state;
> +	int i;
> +
> +	for_each_new_connector_in_state(old_state, connector, new_conn_state, i) {
> +		const struct drm_encoder_helper_funcs *funcs;
> +		struct drm_encoder *encoder;
> +		struct drm_bridge *bridge;
> +
> +		if (!new_conn_state->best_encoder)
> +			continue;
> +
> +		if (!new_conn_state->crtc->state->active ||
> +		    !drm_atomic_crtc_needs_modeset(new_conn_state->crtc->state))
> +			continue;
> +
> +		encoder = new_conn_state->best_encoder;
> +		funcs = encoder->helper_private;
> +
> +		drm_dbg_atomic(dev, "enabling [ENCODER:%d:%s]\n",
> +			       encoder->base.id, encoder->name);
> +
> +		/*
> +		 * Each encoder has at most one connector (since we always steal
> +		 * it away), so we won't call enable hooks twice.
> +		 */
> +		bridge = drm_bridge_chain_get_first_bridge(encoder);
> +		drm_atomic_bridge_chain_pre_enable(bridge, old_state);
> +
> +		if (funcs) {
> +			if (funcs->atomic_enable)
> +				funcs->atomic_enable(encoder, old_state);
> +			else if (funcs->enable)
> +				funcs->enable(encoder);
> +			else if (funcs->commit)
> +				funcs->commit(encoder);
> +		}
> +
> +		drm_atomic_bridge_chain_enable(bridge, old_state);
> +	}
> +}
> +
>  /**
>   * drm_atomic_helper_commit_modeset_enables - modeset commit to enable outputs
>   * @dev: DRM device
> @@ -1465,8 +1519,6 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *old_crtc_state;
>  	struct drm_crtc_state *new_crtc_state;
> -	struct drm_connector *connector;
> -	struct drm_connector_state *new_conn_state;
>  	int i;
>  
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> @@ -1491,42 +1543,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		}
>  	}

I'd say, if you want for it to be cleaner, split both loops from
drm_atomic_helper_commit_modeset_enables() and call them separately.
This save you from the code move, which is harder to review (and also
helps with the function complexity).

>  
> -	for_each_new_connector_in_state(old_state, connector, new_conn_state, i) {
> -		const struct drm_encoder_helper_funcs *funcs;
> -		struct drm_encoder *encoder;
> -		struct drm_bridge *bridge;
> -
> -		if (!new_conn_state->best_encoder)
> -			continue;
> -
> -		if (!new_conn_state->crtc->state->active ||
> -		    !drm_atomic_crtc_needs_modeset(new_conn_state->crtc->state))
> -			continue;
> -
> -		encoder = new_conn_state->best_encoder;
> -		funcs = encoder->helper_private;
> -
> -		drm_dbg_atomic(dev, "enabling [ENCODER:%d:%s]\n",
> -			       encoder->base.id, encoder->name);
> -
> -		/*
> -		 * Each encoder has at most one connector (since we always steal
> -		 * it away), so we won't call enable hooks twice.
> -		 */
> -		bridge = drm_bridge_chain_get_first_bridge(encoder);
> -		drm_atomic_bridge_chain_pre_enable(bridge, old_state);
> -
> -		if (funcs) {
> -			if (funcs->atomic_enable)
> -				funcs->atomic_enable(encoder, old_state);
> -			else if (funcs->enable)
> -				funcs->enable(encoder);
> -			else if (funcs->commit)
> -				funcs->commit(encoder);
> -		}
> -
> -		drm_atomic_bridge_chain_enable(bridge, old_state);
> -	}
> +	encoder_bridge_chain_enable(dev, old_state);
>  
>  	drm_atomic_helper_commit_writebacks(dev, old_state);
>  }
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


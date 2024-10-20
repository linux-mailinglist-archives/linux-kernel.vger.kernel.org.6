Return-Path: <linux-kernel+bounces-373223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E959A53F2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826C1B20CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0776192589;
	Sun, 20 Oct 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXnVs3aB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E970191F6F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729425506; cv=none; b=XkXsAIZJnGPjOoydBk1vUZpZ7xq0jRBsVZWcn9N5ok2ww2lLP2ddwjzwQyLNb1+B+xqQ1tGD+ODiBtHOFd8N7FdMeAXfN2JskaRFlE+wKWH/I734jnW3AJ6TRLWrgyvOHBH9H2aQytHObXwx3lCM00QxXd8XVuZR/YVmK7lHz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729425506; c=relaxed/simple;
	bh=6ESxqHnWXWsxiSlgtIXVssldzEbrQpzGcVxEif2JXUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCiY9OlMjzJ/8BkLZ9kjvX6GyvH3tK9eqIzzeYWzmqtkK+WA+pPufMne4RgE/rIlTCVCeOp55ciu+fKJUEbTEJEv36UiaDoE81nTeXIWDZRAD6usQqLR+pJ2P+ixHI8hi//5CF6IEQXEl/70tnsFD/2gmBbboHquneEFF/1fHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXnVs3aB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e690479cso3761271e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729425502; x=1730030302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvxitRgV6VUAAKQyOIlw2aRDIACkF3PRk5qsE1SfV5g=;
        b=OXnVs3aBXu0uOkmaCEh/pTSkaA5GGqL3qwPrPWvAb3wRiSaaLbDkkUKnqJpbKBo+U8
         W5cMNWNCdoHbFmlBa+H0SoE6vleLdkbbDlLBwFWmTX59RIBdwZDpA3CijuDnfM6vrrok
         WPx6tovwCg+FEJmcypLsC6ARHZ/TX0ZPkI3aWFfsH5jZ0hbVpc6OTaMVb6Qm9lzWjNSO
         rPyRmeFpYxF2zbCNy2SigP0EyUcpNjokJcuzwMxMJSfZBRD0BhtyRj7EG6l9fghvfsaP
         yN+tuYyHlIELosiCi0/h3k738c6a8U+V2fvYa9ynmWK/x+tjS2rbgQxdZAi37G467Rxd
         Hj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729425502; x=1730030302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvxitRgV6VUAAKQyOIlw2aRDIACkF3PRk5qsE1SfV5g=;
        b=T8llZyrNnIUCW5luUa+76Ga6SkQwZ1+Embyzu8NTdR1Y64psPyz3I1ws9y3sPsWD4a
         LOaJX4SQY5nz0rddl2JjNHOJHQmz5MVWXOucTeJwkijT/e0NJ43iaQD65vrpmf6cp4N+
         GUwH/iqZ5Q2ZVA3XpL7hp4iufRdg6TOxYDmf3UOJn/de2gzZf6ab7X4hwsHbVoCyIzG+
         AL2E5ipGxZQTryTY0Z4GG6OlEYWtodo3ob7neesiY42445WiPwW0VvaQrJJBNpL5iVzh
         VVP6vzp5K/7wG+O2ZuMRGdAB7jmxNXrx6qE9tUcNMIkyMBGjZKjJ50fx7A5CG7v9dmEO
         iEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVjNbaxEajl/A9l5Yg+FQRMPwjT+ZVr7gTRx7lsHqy+dWNMafpgUN3Xz+h5smNqK+/jYrLNXCYJTmRYOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypUi/ZWqHNo0iFRsA0g6s2bjMrXjgY/JvqSJ7bpPDx62z/Owbf
	Btu/3/soh+KaaUQ93NZawsgvF3JDF9Lv9Ejma7CZIm9JwZS4rSNTCsXhV1mkOdM=
X-Google-Smtp-Source: AGHT+IG6UYfXiwKJAOMTkmWJfJNPL/iBzD+SqazQREv4a0iw7hvCTyDG4u2C2cRbwjqQd1ya1gKXNQ==
X-Received: by 2002:a05:6512:3049:b0:535:d4e9:28bf with SMTP id 2adb3069b0e04-53a154f903dmr3835223e87.46.1729425501503;
        Sun, 20 Oct 2024 04:58:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420257sm203220e87.147.2024.10.20.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:58:21 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:58:18 +0300
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
Subject: Re: [PATCH v5 12/13] drm/atomic-helper: Re-order bridge chain
 pre-enable and post-disable
Message-ID: <vso7eistcemnv7hyk6nj27imqtckpqwglkpuidpzt4cfyluklj@42lci2ecv7sk>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-5-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019200530.270738-5-aradhya.bhatia@linux.dev>

On Sun, Oct 20, 2024 at 01:35:29AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> Move the bridge pre_enable call before crtc enable, and the bridge
> post_disable call after the crtc disable.
> 
> The sequence of enable after this patch will look like:
> 
> 	bridge[n]_pre_enable
> 	...
> 	bridge[1]_pre_enable
> 
> 	crtc_enable
> 	encoder_enable
> 
> 	bridge[1]_enable
> 	...
> 	bridge[n]_enable
> 
> and vice-versa for the bridge chain disable sequence.
> 
> The definition of bridge pre_enable hook says that,
> "The display pipe (i.e. clocks and timing signals) feeding this bridge
> will not yet be running when this callback is called".
> 
> Since CRTC is also a source feeding the bridge, it should not be enabled
> before the bridges in the pipeline are pre_enabled. Fix that by
> re-ordering the sequence of bridge pre_enable and bridge post_disable.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 102 ++++++++++++++++++----------
>  include/drm/drm_atomic_helper.h     |   5 ++
>  2 files changed, 71 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 7741fbcc8fc7..6ebd869df79b 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1122,7 +1122,8 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
>  }
>  
>  static void
> -encoder_bridge_chain_disable(struct drm_device *dev, struct drm_atomic_state *old_state)
> +encoder_bridge_chain_disable(struct drm_device *dev, struct drm_atomic_state *old_state,
> +			     enum bridge_chain_operation_type op_type)
>  {
>  	struct drm_connector *connector;
>  	struct drm_connector_state *old_conn_state, *new_conn_state;
> @@ -1162,31 +1163,43 @@ encoder_bridge_chain_disable(struct drm_device *dev, struct drm_atomic_state *ol
>  		if (WARN_ON(!encoder))
>  			continue;
>  
> -		funcs = encoder->helper_private;
> -
> -		drm_dbg_atomic(dev, "disabling [ENCODER:%d:%s]\n",
> -			       encoder->base.id, encoder->name);
> -
>  		/*
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call disable hooks twice.
>  		 */
>  		bridge = drm_bridge_chain_get_first_bridge(encoder);
> -		drm_atomic_bridge_chain_disable(bridge, old_state);
>  
> -		/* Right function depends upon target state. */
> -		if (funcs) {
> -			if (funcs->atomic_disable)
> -				funcs->atomic_disable(encoder, old_state);
> -			else if (new_conn_state->crtc && funcs->prepare)
> -				funcs->prepare(encoder);
> -			else if (funcs->disable)
> -				funcs->disable(encoder);
> -			else if (funcs->dpms)
> -				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
> -		}
> +		switch (op_type) {
> +		case DRM_BRIDGE_ENABLE_DISABLE:
> +			funcs = encoder->helper_private;
> +
> +			drm_dbg_atomic(dev, "disabling [ENCODER:%d:%s]\n",
> +				       encoder->base.id, encoder->name);
> +
> +			drm_atomic_bridge_chain_disable(bridge, old_state);
> +
> +			/* Right function depends upon target state. */
> +			if (funcs) {
> +				if (funcs->atomic_disable)
> +					funcs->atomic_disable(encoder, old_state);
> +				else if (new_conn_state->crtc && funcs->prepare)
> +					funcs->prepare(encoder);
> +				else if (funcs->disable)
> +					funcs->disable(encoder);
> +				else if (funcs->dpms)
> +					funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
> +			}
>  
> -		drm_atomic_bridge_chain_post_disable(bridge, old_state);
> +			break;
> +
> +		case DRM_BRIDGE_PRE_ENABLE_POST_DISABLE:
> +			drm_atomic_bridge_chain_post_disable(bridge, old_state);
> +			break;
> +
> +		default:
> +			drm_err(dev, "Unrecognized Encoder/Bridge Operation (%d).\n", op_type);
> +			break;
> +		}
>  	}
>  }
>  
> @@ -1197,7 +1210,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>  	int i;
>  
> -	encoder_bridge_chain_disable(dev, old_state);
> +	encoder_bridge_chain_disable(dev, old_state, DRM_BRIDGE_ENABLE_DISABLE);
>  
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
>  		const struct drm_crtc_helper_funcs *funcs;
> @@ -1243,6 +1256,8 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  		if (ret == 0)
>  			drm_crtc_vblank_put(crtc);
>  	}
> +
> +	encoder_bridge_chain_disable(dev, old_state, DRM_BRIDGE_PRE_ENABLE_POST_DISABLE);
>  }
>  
>  /**
> @@ -1455,7 +1470,8 @@ static void drm_atomic_helper_commit_writebacks(struct drm_device *dev,
>  }
>  
>  static void
> -encoder_bridge_chain_enable(struct drm_device *dev, struct drm_atomic_state *old_state)
> +encoder_bridge_chain_enable(struct drm_device *dev, struct drm_atomic_state *old_state,
> +			    enum bridge_chain_operation_type op_type)
>  {
>  	struct drm_connector *connector;
>  	struct drm_connector_state *new_conn_state;
> @@ -1474,28 +1490,40 @@ encoder_bridge_chain_enable(struct drm_device *dev, struct drm_atomic_state *old
>  			continue;
>  
>  		encoder = new_conn_state->best_encoder;
> -		funcs = encoder->helper_private;
> -
> -		drm_dbg_atomic(dev, "enabling [ENCODER:%d:%s]\n",
> -			       encoder->base.id, encoder->name);
>  
>  		/*
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call enable hooks twice.
>  		 */
>  		bridge = drm_bridge_chain_get_first_bridge(encoder);
> -		drm_atomic_bridge_chain_pre_enable(bridge, old_state);
>  
> -		if (funcs) {
> -			if (funcs->atomic_enable)
> -				funcs->atomic_enable(encoder, old_state);
> -			else if (funcs->enable)
> -				funcs->enable(encoder);
> -			else if (funcs->commit)
> -				funcs->commit(encoder);
> -		}
> +		switch (op_type) {
> +		case DRM_BRIDGE_PRE_ENABLE_POST_DISABLE:
> +			drm_atomic_bridge_chain_pre_enable(bridge, old_state);
> +			break;
> +
> +		case DRM_BRIDGE_ENABLE_DISABLE:
> +			funcs = encoder->helper_private;
> +
> +			drm_dbg_atomic(dev, "enabling [ENCODER:%d:%s]\n",
> +				       encoder->base.id, encoder->name);
>  
> -		drm_atomic_bridge_chain_enable(bridge, old_state);
> +			if (funcs) {
> +				if (funcs->atomic_enable)
> +					funcs->atomic_enable(encoder, old_state);
> +				else if (funcs->enable)
> +					funcs->enable(encoder);
> +				else if (funcs->commit)
> +					funcs->commit(encoder);
> +			}
> +
> +			drm_atomic_bridge_chain_enable(bridge, old_state);
> +			break;
> +
> +		default:
> +			drm_err(dev, "Unrecognized Encoder/Bridge Operation (%d).\n", op_type);
> +			break;
> +		}
>  	}
>  }
>  
> @@ -1521,6 +1549,8 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  	struct drm_crtc_state *new_crtc_state;
>  	int i;
>  
> +	encoder_bridge_chain_enable(dev, old_state, DRM_BRIDGE_PRE_ENABLE_POST_DISABLE);
> +
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
>  		const struct drm_crtc_helper_funcs *funcs;
>  
> @@ -1543,7 +1573,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		}
>  	}
>  
> -	encoder_bridge_chain_enable(dev, old_state);
> +	encoder_bridge_chain_enable(dev, old_state, DRM_BRIDGE_ENABLE_DISABLE);
>  
>  	drm_atomic_helper_commit_writebacks(dev, old_state);
>  }
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index 9aa0a05aa072..92a5812adc6c 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -43,6 +43,11 @@
>   */
>  #define DRM_PLANE_NO_SCALING (1<<16)
>  
> +enum bridge_chain_operation_type {
> +	DRM_BRIDGE_PRE_ENABLE_POST_DISABLE,
> +	DRM_BRIDGE_ENABLE_DISABLE,
> +};
> +

The enum doesn't need to be public, does it?

>  struct drm_atomic_state;
>  struct drm_private_obj;
>  struct drm_private_state;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


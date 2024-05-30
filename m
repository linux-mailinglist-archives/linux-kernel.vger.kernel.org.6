Return-Path: <linux-kernel+bounces-196031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA18D5644
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C6C283344
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54881836CE;
	Thu, 30 May 2024 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjI/dAlB"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F4548E0
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111728; cv=none; b=HjpqEGvNjMq2f/i9oCAriE22jh0xn3xhjStcv0t5W3mcEToByvPu7oQI96QnyOcP7ajGG7Ypg9WrFSIsSlOqJ3op/2I24yKmHx4SNvKQwfdvTyl5tj+BorWB2lMEgYlXeoIGJFX/FFI5gUofY2HbaLgibWZY6N9JL2Ut4VJgJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111728; c=relaxed/simple;
	bh=RIABYRcYixUaE+nYQ3b+8JyX2TmFsDbNaT4r/ftmIT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY2ysvCviA/0SaPVPaHolacSazc+ZQfvYAphbtXE8KIS2FcZxGdHOYLBAXp4+1aekfdUFVFD40WR4jq3DMZK14sfLBbHYDtbPImHdlQxPQutTFh5UQRLaJh6aCVDRxFHFh4UnhG5m0E7K1VnUO8980qIyi8Hq4SZu4DjBCjhqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjI/dAlB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5241b49c0daso1751993e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717111725; x=1717716525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LUpNqpykyyYuvmP0uLho5gdKJeFweCzQq7EBpg3+34=;
        b=DjI/dAlBhnxstS8q6OvGoN033Zqp5SkLa3DkltQCJosIkEXdlSnPJcDca8CsVnjls5
         nUaP00fSTodkUhoXqosSUCTdpznO3tLlnnDqLHtNzeQziwayhBhJ0TOAQcWk9aFdlC6E
         QRG5iM7jEtnV0doXnoEAo5IebxREr+hcytVC4H+XUBd7XRS1gyIm5/mnc9Yf34bs7ZrR
         HU3zF3y4fBuaSltUZGO3z//MwtuNs60+65/8zsuctGEys+ZeOmolkEXDNKvufIZ33wYZ
         Y5cG1aRur8CqQOYssezpVbaujpGCoDg22IifthldympGMNGDro7Vv8RDulqhStbKGfbO
         uhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717111725; x=1717716525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LUpNqpykyyYuvmP0uLho5gdKJeFweCzQq7EBpg3+34=;
        b=fnld7phwndxfX5g638WmrbpLZvkfQIt/S3x/wkMRvp/QQR3DwEEQStaRlfHSOPYSmo
         9oGz6+CXoanQZUzlyg7h4B5sf9yn2SpGkshkQhlZbdtAdClx+k1rwgAyvtZ9RGqd2+ZE
         qz2QeJ0UH2BIPrjjrGPZjuUuLe9ara4BNNxoNl1U7aoCp2QnHmNdMeGLAx0AE24d+FzE
         OhAsNZrz+YEGyZik3o3YrgwItB0F5qf/06v0aGdY7un/1gp02dFg5K6rL9LlAoFVtmch
         6fMn0iLA2lKttFwLVV2hdUzalLZAl39MMkfoQnaJ+5n1/6babuFLj08J13h5b6YSzne1
         M1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEhg/PDecklYKSFzWQw4zH1jKPPFAeOmvT9mrwxQXp+yiFzZQStvQSi3khuuepzpd9loR6oepF9OYbffKt/z0jG/m7Wpa7jQTU+CMu
X-Gm-Message-State: AOJu0YzbWUPIFfvxt2Ldmbaoai1JM06kFx9gB2z8PEnLZvmGtjLbpE37
	9+0ssWJGoih58T3h1dT9anPH9FITIeF2tluHE1gBq+PzU0hpdWGBWD0RNxz58Jk=
X-Google-Smtp-Source: AGHT+IGa/ojKXc66wpAfWuxk4HgYGFgTZnQfXpj5AA1rgr0wmFDvVEGQhLhftSzOtCB14seoOdZnGQ==
X-Received: by 2002:a05:6512:3694:b0:51d:aae8:646 with SMTP id 2adb3069b0e04-52b89569467mr64620e87.11.1717111724861;
        Thu, 30 May 2024 16:28:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d828a1sm120108e87.221.2024.05.30.16.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:28:44 -0700 (PDT)
Date: Fri, 31 May 2024 02:28:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thierry Reding <treding@nvidia.com>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v2 8/9] drm/atomic-helper: Re-order bridge chain
 pre-enable and post-disable
Message-ID: <b4khibg3mcj3c4lssh2qrhaz76eb4j6nu6in6vq3chyacnfkcj@2jnfyr2g5n2k>
References: <20240530093621.1925863-1-a-bhatia1@ti.com>
 <20240530093621.1925863-9-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530093621.1925863-9-a-bhatia1@ti.com>

On Thu, May 30, 2024 at 03:06:20PM +0530, Aradhya Bhatia wrote:
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
> 	bridge[n]__enable
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
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 70 +++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index fb97b51b38f1..02e093950218 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1186,8 +1186,6 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  			else if (funcs->dpms)
>  				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
>  		}
> -
> -		drm_atomic_bridge_chain_post_disable(bridge, old_state);
>  	}
>  
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> @@ -1234,6 +1232,49 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  		if (ret == 0)
>  			drm_crtc_vblank_put(crtc);
>  	}
> +
> +	for_each_oldnew_connector_in_state(old_state, connector, old_conn_state,
> +					   new_conn_state, i) {
> +		struct drm_encoder *encoder;
> +		struct drm_bridge *bridge;
> +
> +		/*
> +		 * Shut down everything that's in the changeset and currently
> +		 * still on. So need to check the old, saved state.
> +		 */
> +		if (!old_conn_state->crtc)
> +			continue;
> +
> +		old_crtc_state = drm_atomic_get_old_crtc_state(old_state, old_conn_state->crtc);
> +
> +		if (new_conn_state->crtc)
> +			new_crtc_state = drm_atomic_get_new_crtc_state(old_state,
> +								       new_conn_state->crtc);
> +		else
> +			new_crtc_state = NULL;
> +
> +		if (!crtc_needs_disable(old_crtc_state, new_crtc_state) ||
> +		    !drm_atomic_crtc_needs_modeset(old_conn_state->crtc->state))
> +			continue;
> +
> +		encoder = old_conn_state->best_encoder;
> +
> +		/* We shouldn't get this far if we didn't previously have
> +		 * an encoder.. but WARN_ON() rather than explode.
> +		 */
> +		if (WARN_ON(!encoder))
> +			continue;
> +
> +		drm_dbg_atomic(dev, "disabling [ENCODER:%d:%s]\n",
> +			       encoder->base.id, encoder->name);

This duplicates the code in the loop around
drm_atomic_bridge_chain_disable(). Can it be extracted to a separate
function? Code duplication is nearly always a bad idea.

The same comment applies to the next chunk too.

> +
> +		/*
> +		 * Each encoder has at most one connector (since we always steal
> +		 * it away), so we won't call disable hooks twice.
> +		 */
> +		bridge = drm_bridge_chain_get_first_bridge(encoder);
> +		drm_atomic_bridge_chain_post_disable(bridge, old_state);
> +	}
>  }
>  
>  /**

-- 
With best wishes
Dmitry


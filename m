Return-Path: <linux-kernel+bounces-533123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D363A455E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F8B17735C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553326A1B4;
	Wed, 26 Feb 2025 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQlohq2k"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74026A1C1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552121; cv=none; b=aOp+jUDKzuCpbw2USZJ6W9L25XRLamIz6QyLJtOyCj/JHKwrBGnazgcg15EoAMF1wrfzcBE/Ji1GGfo/bYZQqvJaiQ0FKV644ex3h4KB8w7W2a8o60Lk6YDCRV4ZhKDD6dEz9+SWUTSvdVIOcL0mbRlLG4buywSdiNPsr8rq8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552121; c=relaxed/simple;
	bh=n+Yt3bSNARsv2zVZr7WU5SJ470AOo235Hu+RaCY2aO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJlBxsXyJ7zJ+UTAyxFliCPS5fbuml2pDNvelj6+r/PWSWVjG+GwlcOfZZPfpAMJjFJ9yG2YRSYOLfIt9aYfPrZCqcyeXo0csWmXfLYP1QVavOBw+nl4WU6ThGlZZ+fwZWeGU+DC1ZpqP/bePkcpK+5BG7aBlajFerYwOW9yFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HQlohq2k; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54622e97753so572503e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552117; x=1741156917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=slhhH1OWDPhNxuUWfIi9e2TTyh07XT8L5EcIfOsNnAc=;
        b=HQlohq2kWSx7qY/hlRJ4QOXprHjqrGZyzuB4iRk5iWOkm1vVv81PnAgw8GoCIKzYpg
         aO5fW+swOJOzJVXpyjrDFmmwLtqgc5tuZuq9pg7N0Y8pocayvujEc8BjAGO2Yfiw3zXP
         n7EiAAgU6RGtxYzzjaOfYg8pc4gUDW39Olawh6Xfjdwj4gfaCHWlrTuilzU+tdHbh/so
         Mm7MT498Z1tga+vlMvDjlUh7apCt/ElaHluBuYjjrBOPbadSSp0D7efYqxEaQxbckhWS
         JYbG7fTgjaFHlpA7yqP/4qPDptqL4g6P+s26CEFmoPfK9CegSU2rDziOhGVVVdWkSbmr
         CXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552117; x=1741156917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slhhH1OWDPhNxuUWfIi9e2TTyh07XT8L5EcIfOsNnAc=;
        b=eoI9wPOLwSlDDg6brKtn9rvCvlLLRfYKWp0mRuoHtshM5JzwSTT8+jXc4aeFNd0Zeu
         BtVEiI7oQ6MGzCYI06rwebD2DKaBlXNA3LdnRNoAhu+LHZnL5Mc3AJdR/kiZ2XAILGfH
         B6A6MJlClKva3ex1uA76tfGNfuFUj+1TvlM2dlySby28OQ8Toabvhnj84z2fKkyOG7A/
         UhTCTPSG3ySg02SYMGfd09xF0DzTQRcvqlbFP35NZWQ6wdWkHLRwJVM1AYEPJnaGKoDR
         j0/9VjhPvKJdvGUyJ+2JMNg7UJIl3M5fhbMibtSdrL/kYfBlj9FDRSFufLhCsf3J9ZDu
         26MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBb7BBDc4Xz4HZ1UvVxKFZ6i1x8X7twRp2qvrNniHQKaPAZCvUSxLfDGrhiE4BAlvb2+PPcWIEX66MgJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEwTsho5B/BFD1D/VDuX81VTWISwB5h5ZgmUh8OwFhrhH32R3
	OYAoE0rjzuA7/SvvUv3TJt2/5xfwgk+YHdipGVOphgcDodjjYxr1Uf7/AVDB8N4=
X-Gm-Gg: ASbGnctfiI39O/mIOngo3M50VCgFzXAFT9y5faoYVTA3zC2bbp6blJqn7lqZPOXh9Jn
	MyFB2cZnZj4k8wZ1TP9C2PVwoY9lCpSEqqpCxRKWfdIGdOLrz5kxloFBdUhiAY+lf+Op+nTpdMt
	3FTRN32kqMaaJL0pGoQwwg7kkiRqyXMkHFMuJ8Nj+9nqcyS0uAjeVJvjWw1kFVf8uP4vJuMjqVh
	VbyYpPSzEfdHymJyAvULDHRVivy4tzTuJ8+5DOllTyfcz6WS3oiZeGSCxU0dVOor5424BZ7ksqj
	MIAWEIp4YtSRdZ5mK/L3NvidiC2RHOPcfbZKHEpCXgqSwZzzTlxNa6qlz6tgK9PMuXq79iGpzY0
	QJEwJrA==
X-Google-Smtp-Source: AGHT+IF8CNQ53YpP1ppilap6LhhTVanQkQOb2cwMukzGWQfv2mevxc1ON9jFy4KyLi6x6nClDMW1fw==
X-Received: by 2002:a05:6512:e8b:b0:545:dc8:9376 with SMTP id 2adb3069b0e04-546e3c9c979mr9782380e87.5.1740552117486;
        Tue, 25 Feb 2025 22:41:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514fa052sm359461e87.228.2025.02.25.22.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:41:57 -0800 (PST)
Date: Wed, 26 Feb 2025 08:41:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v4 07/15] drm/bridge: Add helper to reset bridge pipeline
Message-ID: <sqsk3ievl3kujkljqosww233yio4uke5met7zqhzssmehzdck5@doaikab7bggr>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-7-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-7-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:55PM +0100, Maxime Ripard wrote:
> Let's provide an helper to make it easier for bridge drivers to
> power-cycle their bridge.
> 
> Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  2 ++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 8241c00e4506eceeb9bb4ba74a38d8f360c65d38..ca894531a2042fc9296c40a1f51a6cdea6e97ed7 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -24,10 +24,11 @@
>  #include <linux/err.h>
>  #include <linux/media-bus-format.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_atomic_state_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
> @@ -1269,10 +1270,53 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
>  		bridge->hpd_cb(bridge->hpd_data, status);
>  	mutex_unlock(&bridge->hpd_mutex);
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
>  
> +/**
> + * drm_bridge_reset_crtc - Reset the pipeline feeding a bridge
> + * @bridge: DRM bridge to reset
> + * @ctx: lock acquisition context
> + *
> + * Reset a @bridge pipeline. It will power-cycle all active components
> + * between the CRTC and connector that bridge is connected to.
> + *
> + * Returns:
> + *
> + * 0 on success or a negative error code on failure. If the error
> + * returned is EDEADLK, the whole atomic sequence must be restarted.
> + */
> +int drm_bridge_reset_crtc(struct drm_bridge *bridge,
> +			  struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_connector *connector;
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_device *dev = encoder->dev;
> +	struct drm_crtc *crtc;
> +	int ret;
> +
> +	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> +	if (ret)
> +		return ret;
> +
> +	connector = drm_atomic_get_connector_for_encoder(encoder, ctx);
> +	if (IS_ERR(connector)) {
> +		ret = PTR_ERR(connector);
> +		goto out;
> +	}
> +

Should there be a check for connector->state before accessing
connector->state->crtc ?

> +	crtc = connector->state->crtc;
> +	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
> +	if (ret)
> +		goto out;
> +
> +out:
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_bridge_reset_crtc);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node in
>   *			the global bridge list
>   *
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 6fb1da7c195e99143a67a999d16fe361c1e3f4ab..32169e62463bb268a281a5903c0c9f448a1042b3 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1085,10 +1085,12 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
>  				      enum drm_connector_status status),
>  			   void *data);
>  void drm_bridge_hpd_disable(struct drm_bridge *bridge);
>  void drm_bridge_hpd_notify(struct drm_bridge *bridge,
>  			   enum drm_connector_status status);
> +int drm_bridge_reset_crtc(struct drm_bridge *bridge,
> +			  struct drm_modeset_acquire_ctx *ctx);
>  
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>  bool drm_bridge_is_panel(const struct drm_bridge *bridge);
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
>  struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry


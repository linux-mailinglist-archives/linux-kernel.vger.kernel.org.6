Return-Path: <linux-kernel+bounces-549239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE799A54F71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9113A8421
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0A18DF81;
	Thu,  6 Mar 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YMxlLSko"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692F148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275987; cv=none; b=O/XOZ16mZ029EZMbqSym3JuqbhU/2t3NKOEhUySVgYiX1i6NOwgbz6AY5CggSdRBOhH169MzVEhqUJgHm7nHghDppr/wVkO5LZq/D/LL0QFAiBuBaIzZeXCH402RjiqqJigNDCHX0owt2lv+eFZQ10bEF+HTwpK/epKB1F6P/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275987; c=relaxed/simple;
	bh=JDbhHWOSOA7i+KbN8GCYy54C3W/IhmBSCVyuqB1fyfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDu/yxMOF/scRmVecseGnDILQLRL3A5g1RG6toaI/gWKaytZPADhIk9hq8v6veIZzbsJHLcJt5Bh8i4CJYSmgaia4BDy7gYFD3Qq4zzWT2notdjE1D3G4huSs857A/3MlcWaV5aMSqLCszIfN9smjM+kB4Hn9qUlyyvQQfPbo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=YMxlLSko; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so9670855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741275984; x=1741880784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOewatoKYHf39n5I/gBakpchgBZgxuefOyKrDhg+irg=;
        b=YMxlLSkoJZOu3pDRPRWi+3pi2oBLga5IHEBr6oPLCAr1uB0KTXLycqY6LY45fAp+YA
         hFUo6CDyx16YnHYmGyaz8q1o3HdtnXYLnf4icUXnGm3nmQRer7ZtnMTjAnlkYrm8XUQz
         yN3oCjQ+xsuLRh+uGaV2uGKr1isCmoqG4oyxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275984; x=1741880784;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOewatoKYHf39n5I/gBakpchgBZgxuefOyKrDhg+irg=;
        b=TD7GG98uwswUlKrBvE5lmGZRRQv/M9VeYW4GgIIBfjJzglb3MiiKLqGKbkyvaMWBCP
         x/N1sjPM6H3csfBVuk81qNcF880V8CZOl9sx+HgCd4/0hJzB/2aYGHPxCLK5MJh5/9Jz
         mLIa5wYEAgigiFujaWkWmNU9jGcUvJA9/HCBNrAYEWvosG2zHAxiXr+E+XeZDqwgaKUD
         A/Y428x1EF/feO7Z2bXn7d9TL+x9wcL+rt6wY5OpiOsot3Dw38ONCFda1da77FsKgvrj
         Rk2i+REdWHUE/H5f+bFNtA3i2pgNATcPICSmrfYejHrgbefWX6AXi5sdCbllv3UnV3+e
         PntQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjPitK9zv2badCwZyPKwN/cJb+QSFNnF2ssUxhxskX+iE38NGhQNpJc2sKMeOGgnr10Q4Y+y11wXpXT/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlfnfXmhiA/pHPxuoqHmKLqanxxHwcizgvUThfVKur/RrCMbz
	PcmBhpRtQMU3xKiXLyhEh7poceuYgvn5yiSzopg6nkhsigezrfyZydRq1D7u/wk=
X-Gm-Gg: ASbGncvZ115AkvN4lCVlDZVisJXekFiSY0mAww9U6DicmrCz7vARowXZTXTBLwM9bvR
	1kBYe359FXFGckhD0z33yxywBPFUCS5jhy+YVPJcj4VSfhz9a7Rs5ru+Zu4b/xgO962ZVvr0YuA
	KOFPaTluQwCSXO6V6yOEy5JcttujRYuYt9/s9DnmniKm9EQ9OnuKorTUK0tw1ZMplELl+xEbFNe
	TilgoQFAozimI3fMhXRRUqgeDxha785cp/zO3+bCXkWxqyTbe/sejbGvgf9Aez3vKqBgW+6wbxF
	zH1p0bSg4aS55YsrgyLlCrwxXZDMjIYRt1Bofk/tu0o04A+5dOqFD7Kn
X-Google-Smtp-Source: AGHT+IEleCsxq8XUaIidU8IaWiDtE2BKMf9XcERDyGpucqoDTck67pGcLD/bIIWyInB/FTtB5CBCgw==
X-Received: by 2002:a05:6000:1447:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-3911f7beb20mr7168916f8f.47.1741275984072;
        Thu, 06 Mar 2025 07:46:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f4fsm2357683f8f.77.2025.03.06.07.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:46:23 -0800 (PST)
Date: Thu, 6 Mar 2025 16:46:21 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v5 08/16] drm/bridge: Add helper to reset bridge pipeline
Message-ID: <Z8nDTfYqfn1utDaH@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
 <20250304-bridge-connector-v5-8-aacf461d2157@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-bridge-connector-v5-8-aacf461d2157@kernel.org>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Mar 04, 2025 at 12:10:51PM +0100, Maxime Ripard wrote:
> Let's provide an helper to make it easier for bridge drivers to
> power-cycle their bridge.
> 
> In order to avoid a circular dependency between that new helper and
> drm_atomic_helper_reset_crtc(), this new helper will be in a
> drm_bridge_helper.c file to follow the pattern we have for other
> objects.
> 
> Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/Makefile            |  1 +
>  drivers/gpu/drm/drm_bridge_helper.c | 55 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge_helper.h     | 12 ++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 4cd054188faf0b3dec442efd99ae52604541bce1..5a332f7d3ecccb6e5e1fb9fb811eab7aa5a84a21 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -131,10 +131,11 @@ obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
>  #
>  
>  drm_kms_helper-y := \
>  	drm_atomic_helper.o \
>  	drm_atomic_state_helper.o \
> +	drm_bridge_helper.o \
>  	drm_crtc_helper.o \
>  	drm_damage_helper.o \
>  	drm_flip_work.o \
>  	drm_format_helper.o \
>  	drm_gem_atomic_helper.o \
> diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_bridge_helper.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..521df9d5dcb3fef842a95cdb2865a8b8d09b0fbe
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_bridge_helper.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_helper.h>
> +#include <drm/drm_modeset_lock.h>
> +
> +/**
> + * drm_bridge_helper_reset_crtc - Reset the pipeline feeding a bridge
> + * @bridge: DRM bridge to reset
> + * @ctx: lock acquisition context
> + *
> + * Reset a @bridge pipeline. It will power-cycle all active components
> + * between the CRTC and connector that bridge is connected to.

You need to minimally add that the same caveats and limitations of
drm_atomic_helper_reset_crtc() apply to this function here.

Might also be good to link from that kerneldoc to here so people can find
stuff easier, or maybe the overview section I've asked for once that's
landed.

With the kerneldoc polished:

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Simona Vetter <simona.vetter@intel.com>

> + *
> + * Returns:
> + *
> + * 0 on success or a negative error code on failure. If the error
> + * returned is EDEADLK, the whole atomic sequence must be restarted.
> + */
> +int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
> +				 struct drm_modeset_acquire_ctx *ctx)
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
> +	if (!connector->state) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	crtc = connector->state->crtc;
> +	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
> +	if (ret)
> +		goto out;
> +
> +out:
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_bridge_helper_reset_crtc);
> diff --git a/include/drm/drm_bridge_helper.h b/include/drm/drm_bridge_helper.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6c35b479ec2a84aa43283351a6f18e49a9f9c177
> --- /dev/null
> +++ b/include/drm/drm_bridge_helper.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifndef __DRM_BRIDGE_HELPER_H_
> +#define __DRM_BRIDGE_HELPER_H_
> +
> +struct drm_bridge;
> +struct drm_modeset_acquire_ctx;
> +
> +int drm_bridge_helper_reset_crtc(struct drm_bridge *bridge,
> +				 struct drm_modeset_acquire_ctx *ctx);
> +
> +#endif // __DRM_BRIDGE_HELPER_H_
> 
> -- 
> 2.48.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


Return-Path: <linux-kernel+bounces-211225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63932904EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D757D1F2667C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBA16D4DF;
	Wed, 12 Jun 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Vy/JOrux"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7418E02
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182735; cv=none; b=Gvf3bRHtlebYXbt2H1h1Vv+PJHu1p4jhC3ImZdzXRXg4ey0hdmsGPOwtE+5ZmCtJJNJjmhtXKADQmfBL6V6oI0TTu0VGV3uNqqVG3cElMrPcgxSrlAglSkI6AS/Ef4LyApw3+dJ/aLDuGVGzqceYq7xqXSPKjUG/FHngVULTf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182735; c=relaxed/simple;
	bh=8ZJe+ZgAlmDSk6ZCkAEEHYDSTaSxuqLYh+zf3YbFgyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOgbYxic++VMWT44LQ60RaMhfNEBYyWgFWuLgulohGDLeZdZVUYQEI6qB1m+mWySXY8A0EL/8wSEMoPufYFTqIdEw3PTL+H5goxn+6tpo+wD932ueDN4LI1fr2gvmeLckCl+egqOtQXUU5MPfekLr/xthnYxdIT9vtBFC9oabI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Vy/JOrux; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eae70fb324so5953501fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718182731; x=1718787531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud4xmDmRV183zyld9JfrTjCSef6nKd1cubXXIHFriQg=;
        b=Vy/JOrux1xPCMdDOdBy28wKYV5tHjwdP43kpEA+e9ZjUUNa5DViNulSdXqZFmejc3G
         cmkCr5GiNAipkkPgSvW/mFN+kZVRmxL+NkgUXi7q1meTNSdqeFiQDSfJ9AO9vBER9sVD
         Rrdq2V+t3VaHTg3MQy9DoTi86DBxsvjwGbwek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182731; x=1718787531;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ud4xmDmRV183zyld9JfrTjCSef6nKd1cubXXIHFriQg=;
        b=vObdVgkO6k5dk4VDMDale6ttTtGrt+DexCfy0h+noTAOYj+4zanHeyjhBCnb4+MzPh
         jw6Mt1tuoXEQSCK9bJXR9AUhd+ldWMquSSNO2APnfvat4+qWhprWdjhQIbMl/xJD5/Uf
         ejYU8WavXfYkbMki8PKtndh48ePrUlx7OTh/DU0WME3U44kXvRVxjj2AfVsb8QrlOVCi
         s9iFZabM+UeewBYccZTnVHq/5wys6OhN7ZLQepnDZ+nxZLLCEMgrhB+dcvtdiyW3Vvfo
         P+NdiF3ycbqZiPptjVbNeo7ufQCojZcysCeZ3ck9rXBHDQ/T7Q+T2Cjz5h99WMCqPHST
         KsGA==
X-Forwarded-Encrypted: i=1; AJvYcCXpxIhDalERvX0gNAfS8GxvTCELDHUA6B6sRoM3BK4HGv9+yn5vsRcL4I+TxNOcqnYno9OweOljJjKUG9M4DZT0hlAV0Z8YVM0+7hcv
X-Gm-Message-State: AOJu0YwfnMRPMGD56dZwLO1ZvHxHCkCuMLUfnqrDGGEyxDf0Ev8Z7GxB
	EWbBDDvjYQp+A4eMXr0CMkfha1Uu2+kPxFMCHUscBtOQqqNXc5DpYHSuMD7kb/yVBWkyN6+cDEs
	K
X-Google-Smtp-Source: AGHT+IESe7iSv2iXtKFNjsvBjGHCB1B7laaPK1zNVgIlNTvf4a5ijCQSxaJoTker/g2b0roe8eQdXg==
X-Received: by 2002:a05:600c:358b:b0:422:ce5:2a3f with SMTP id 5b1f17b1804b1-422867cdc32mr8541475e9.4.1718182710704;
        Wed, 12 Jun 2024 01:58:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871fac87sm17119455e9.48.2024.06.12.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:58:30 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:58:28 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at
 shutdown
Message-ID: <ZmljNHteJ9L5EdE9@phenom.ffwll.local>
Mail-Followup-To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Tue, Jun 11, 2024 at 07:48:51AM -0700, Douglas Anderson wrote:
> At shutdown if you've got a _properly_ coded DRM modeset driver then
> you'll get these two warnings at shutdown time:
> 
>   Skipping disable of already disabled panel
>   Skipping unprepare of already unprepared panel
> 
> These warnings are ugly and sound concerning, but they're actually a
> sign of a properly working system. That's not great.
> 
> It's not easy to get rid of these warnings. Until we know that all DRM
> modeset drivers used with panel-simple and panel-edp are properly
> calling drm_atomic_helper_shutdown() or drm_helper_force_disable_all()
> then the panel drivers _need_ to disable/unprepare themselves in order
> to power off the panel cleanly. However, there are lots of DRM modeset
> drivers used with panel-edp and panel-simple and it's hard to know
> when we've got them all. Since the warning happens only on the drivers
> that _are_ updated there's nothing to encourage broken DRM modeset
> drivers to get fixed.
> 
> In order to flip the warning to the proper place, we need to know
> which modeset drivers are going to shutdown properly. Though ugly, do
> this by creating a list of everyone that shuts down properly. This
> allows us to generate a warning for the correct case and also lets us
> get rid of the warning for drivers that are shutting down properly.
> 
> Maintaining this list is ugly, but the idea is that it's only short
> term. Once everyone is converted we can delete the list and call it
> done. The list is ugly enough and adding to it is annoying enough that
> people should push to make this happen.
> 
> Implement this all in a shared "header" file included by the two panel
> drivers that need it. This avoids us adding an new exports while still
> allowing the panel drivers to be modules. The code waste should be
> small and, as per above, the whole solution is temporary.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I came up with this idea to help us move forward since otherwise I
> couldn't see how we were ever going to fix panel-simple and panel-edp
> since they're used by so many DRM Modeset drivers. It's a bit ugly but
> I don't hate it. What do others think?

I think it's terrible :-)

Why does something like this now work?

drm_panel_shutdown_fixup(panel)
{
	/* if you get warnings here, fix your main drm driver to call
	 * drm_atomic_helper_shutdown()
	 */
	if (WARN_ON(panel->enabled))
		drm_panel_disable(panel);

	if (WARN_ON(panel->prepared))
		drm_panel_unprepare(panel);
}

And then call that little helper in the relevant panel drivers? Also feel
free to bikeshed the name and maybe put a more lengthly explainer into the
kerneldoc for that ...

Or am I completely missing the point here?
-Sima

> 
> This is at the end of the series so even if folks hate it we could
> still land the rest of the series.
> This was a "bonus" extra patch I added at the end of v3 of the series
> ("drm/panel: Remove most store/double-check of prepared/enabled
> state") [1]. There, I had the note: "I came up with this idea to help
> us move forward since otherwise I couldn't see how we were ever going
> to fix panel-simple and panel-edp since they're used by so many DRM
> Modeset drivers. It's a bit ugly but I don't hate it. What do others
> think?"
> 
> As requested by Neil, now that the rest of the series has landed I'm
> sending this as a standalone patch so it can get more attention. I'm
> starting it back at "v1". There is no change between v1 and the one
> sent previously except for a typo fix in an error message: Can't't =>
> Can't
> 
> [1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chromium.org
> 
>  drivers/gpu/drm/drm_panel.c                   |  12 ++
>  .../gpu/drm/panel/panel-drm-shutdown-check.h  | 151 ++++++++++++++++++
>  drivers/gpu/drm/panel/panel-edp.c             |  19 +--
>  drivers/gpu/drm/panel/panel-simple.c          |  19 +--
>  4 files changed, 169 insertions(+), 32 deletions(-)
>  create mode 100644 drivers/gpu/drm/panel/panel-drm-shutdown-check.h
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index cfbe020de54e..df3f15f4625e 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -161,6 +161,12 @@ int drm_panel_unprepare(struct drm_panel *panel)
>  	if (!panel)
>  		return -EINVAL;
>  
> +	/*
> +	 * If you're seeing this warning, you either need to add your driver
> +	 * to "drm_drivers_that_shutdown" (if you're seeing it with panel-edp
> +	 * or panel-simple) or you need to remove the manual call to
> +	 * drm_panel_unprepare() in your panel driver.
> +	 */
>  	if (!panel->prepared) {
>  		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n");
>  		return 0;
> @@ -245,6 +251,12 @@ int drm_panel_disable(struct drm_panel *panel)
>  	if (!panel)
>  		return -EINVAL;
>  
> +	/*
> +	 * If you're seeing this warning, you either need to add your driver
> +	 * to "drm_drivers_that_shutdown" (if you're seeing it with panel-edp
> +	 * or panel-simple) or you need to remove the manual call to
> +	 * drm_panel_disable() in your panel driver.
> +	 */
>  	if (!panel->enabled) {
>  		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
>  		return 0;
> diff --git a/drivers/gpu/drm/panel/panel-drm-shutdown-check.h b/drivers/gpu/drm/panel/panel-drm-shutdown-check.h
> new file mode 100644
> index 000000000000..dfa8197e09fb
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-drm-shutdown-check.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2024 Google Inc.
> + *
> + * This header is a temporary solution and is intended to be included
> + * directly by panel-edp.c and panel-simple.c.
> + *
> + * This header is needed because panel-edp and panel-simple are used by a
> + * wide variety of DRM drivers and it's hard to know for sure if all of the
> + * DRM drivers used by those panel drivers are properly calling
> + * drm_atomic_helper_shutdown() or drm_helper_force_disable_all() at
> + * shutdown/remove time.
> + *
> + * The plan for this header file:
> + * - Land it and hope that the warning print will encourage DRM drivers to
> + *   get fixed.
> + * - Eventually move to a WARN() splat for extra encouragement.
> + * - Assume that everyone has been fixed and remove this header file.
> + */
> +
> +#ifndef __PANEL_DRM_SHUTDOWN_CHECK_H__
> +#define __PANEL_DRM_SHUTDOWN_CHECK_H__
> +
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_drv.h>
> +
> +/*
> + * This is a list of all DRM drivers that appear to properly call
> + * drm_atomic_helper_shutdown() or drm_helper_force_disable_all() at
> + * shutdown and remove time.
> + *
> + * We can't detect this dynamically and are stuck with a list because the panel
> + * driver's shutdown() call might be called _before_ the DRM driver's
> + * shutdown() call.
> + *
> + * NOTE: no verification has been done to confirm that the below drivers
> + * are actually _used_ with panel-simple or panel-edp, only that these drivers
> + * appear to be shutting down properly. It doesn't hurt to have extra drivers
> + * listed here as long as the list doesn't contain any drivers that are
> + * missing the shutdown calls.
> + */
> +static const char * const drm_drivers_that_shutdown[] = {
> +	"armada-drm",
> +	"aspeed-gfx-drm",
> +	"ast",
> +	"atmel-hlcdc",
> +	"bochs-drm",
> +	"cirrus",
> +	"exynos",
> +	"fsl-dcu-drm",
> +	"gm12u320",
> +	"gud",
> +	"hdlcd",
> +	"hibmc",
> +	"hx8357d",
> +	"hyperv_drm",
> +	"ili9163",
> +	"ili9225",
> +	"ili9341",
> +	"ili9486",
> +	"imx-dcss",
> +	"imx-drm",
> +	"imx-lcdc",
> +	"imx-lcdif",
> +	"ingenic-drm",
> +	"kirin",
> +	"komeda",
> +	"logicvc-drm",
> +	"loongson",
> +	"mali-dp",
> +	"mcde",
> +	"meson",
> +	"mgag200",
> +	"mi0283qt",
> +	"msm",
> +	"mxsfb-drm",
> +	"omapdrm",
> +	"panel-mipi-dbi",
> +	"pl111",
> +	"qxl",
> +	"rcar-du",
> +	"repaper",
> +	"rockchip",
> +	"rzg2l-du",
> +	"ssd130x",
> +	"st7586",
> +	"st7735r",
> +	"sti",
> +	"stm",
> +	"sun4i-drm",
> +	"tidss",
> +	"tilcdc",
> +	"tve200",
> +	"vboxvideo",
> +	"zynqmp-dpsub",
> +	""
> +};
> +
> +static void panel_shutdown_if_drm_driver_needs_fixing(struct drm_panel *panel)
> +{
> +	struct drm_bridge *bridge;
> +	const struct drm_driver *driver;
> +	const char * const *driver_name;
> +
> +	/*
> +	 * Look for a bridge that shares the DT node of this panel. That only
> +	 * works if we've been linked up with a panel_bridge.
> +	 */
> +	bridge = of_drm_find_bridge(panel->dev->of_node);
> +	if (bridge && bridge->dev && bridge->dev->driver) {
> +		/*
> +		 * If the DRM driver for the bridge is known to be fine then
> +		 * we're done.
> +		 */
> +		driver = bridge->dev->driver;
> +		for (driver_name = drm_drivers_that_shutdown; *driver_name; driver_name++) {
> +			if (strcmp(*driver_name, driver->name) == 0)
> +				return;
> +		}
> +
> +		/*
> +		 * If you see the message below then:
> +		 * 1. Make sure your DRM driver is properly calling
> +		 *    drm_atomic_helper_shutdown() or drm_helper_force_disable_all()
> +		 *    at shutdown time.
> +		 * 2. Add your driver to the list.
> +		 */
> +		dev_warn(panel->dev,
> +			 "DRM driver appears buggy; manually disable/unprepare\n");
> +	} else {
> +		/*
> +		 * If you see the message below then your setup needs to
> +		 * be moved to using a panel_bridge. This often happens
> +		 * by calling devm_drm_of_get_bridge(). Having a panel without
> +		 * an associated panel_bridge is deprecated.
> +		 */
> +		dev_warn(panel->dev,
> +			 "Can't find DRM driver; manually disable/unprepare\n");
> +	}
> +
> +	/*
> +	 * If we don't know if a DRM driver is properly shutting things down
> +	 * then we'll manually call the disable/unprepare. This is always a
> +	 * safe thing to do (in that it won't cause you to crash), but it
> +	 * does generate a warning.
> +	 */
> +	drm_panel_disable(panel);
> +	drm_panel_unprepare(panel);
> +}
> +
> +#endif
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 67ab6915d6e4..26f89858df9d 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -42,6 +42,8 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_panel.h>
>  
> +#include "panel-drm-shutdown-check.h"
> +
>  /**
>   * struct panel_delay - Describes delays for a simple panel.
>   */
> @@ -948,22 +950,7 @@ static void panel_edp_shutdown(struct device *dev)
>  {
>  	struct panel_edp *panel = dev_get_drvdata(dev);
>  
> -	/*
> -	 * NOTE: the following two calls don't really belong here. It is the
> -	 * responsibility of a correctly written DRM modeset driver to call
> -	 * drm_atomic_helper_shutdown() at shutdown time and that should
> -	 * cause the panel to be disabled / unprepared if needed. For now,
> -	 * however, we'll keep these calls due to the sheer number of
> -	 * different DRM modeset drivers used with panel-edp. The fact that
> -	 * we're calling these and _also_ the drm_atomic_helper_shutdown()
> -	 * will try to disable/unprepare means that we can get a warning about
> -	 * trying to disable/unprepare an already disabled/unprepared panel,
> -	 * but that's something we'll have to live with until we've confirmed
> -	 * that all DRM modeset drivers are properly calling
> -	 * drm_atomic_helper_shutdown().
> -	 */
> -	drm_panel_disable(&panel->base);
> -	drm_panel_unprepare(&panel->base);
> +	panel_shutdown_if_drm_driver_needs_fixing(&panel->base);
>  }
>  
>  static void panel_edp_remove(struct device *dev)
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 8345ed891f5a..f505bc27e5ae 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -42,6 +42,8 @@
>  #include <drm/drm_panel.h>
>  #include <drm/drm_of.h>
>  
> +#include "panel-drm-shutdown-check.h"
> +
>  /**
>   * struct panel_desc - Describes a simple panel.
>   */
> @@ -720,22 +722,7 @@ static void panel_simple_shutdown(struct device *dev)
>  {
>  	struct panel_simple *panel = dev_get_drvdata(dev);
>  
> -	/*
> -	 * NOTE: the following two calls don't really belong here. It is the
> -	 * responsibility of a correctly written DRM modeset driver to call
> -	 * drm_atomic_helper_shutdown() at shutdown time and that should
> -	 * cause the panel to be disabled / unprepared if needed. For now,
> -	 * however, we'll keep these calls due to the sheer number of
> -	 * different DRM modeset drivers used with panel-simple. The fact that
> -	 * we're calling these and _also_ the drm_atomic_helper_shutdown()
> -	 * will try to disable/unprepare means that we can get a warning about
> -	 * trying to disable/unprepare an already disabled/unprepared panel,
> -	 * but that's something we'll have to live with until we've confirmed
> -	 * that all DRM modeset drivers are properly calling
> -	 * drm_atomic_helper_shutdown().
> -	 */
> -	drm_panel_disable(&panel->base);
> -	drm_panel_unprepare(&panel->base);
> +	panel_shutdown_if_drm_driver_needs_fixing(&panel->base);
>  }
>  
>  static void panel_simple_remove(struct device *dev)
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


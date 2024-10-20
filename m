Return-Path: <linux-kernel+bounces-373221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB279A53ED
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80401F21D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A61922FD;
	Sun, 20 Oct 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9y4Jkxl"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73AD26D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729425460; cv=none; b=o8+qZiMMkUTrUeAdZdaBV8hwDVR+aUq9c1QBR+vNWLNbh9/jYoRtoG2kCFFzCu+pQPjh+qSIGpYZ2Ru6uUU+OUp5gjhjfca1imr3MhAL9C8L+0PVFbuS+6IG8uSeufTjjF8bkEdcIfQG9FfRNTB4QX76sMfbH8Q/GcphzLlqSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729425460; c=relaxed/simple;
	bh=ZneFbZA475LQk7C2f2FNx/vXUVoqXm12nuUQ+1A7irg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eghcz0vQKxUbOTLx2fopYw6CL6nyn8rszpirEfceg9PUD1QeJFK/dJ/1iNbeuLUOyAYYj7yELeuf7IKu3LVoClcT3XUGjuQQZXAXAlVztJlyllUMrmp+YgMO3nF2R1vnHo39O6amare1iqxwlxEbliu/t7t6cs4ErL8tIMwZKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9y4Jkxl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3479941e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729425456; x=1730030256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5O0yOz3cWb1IQD7Tg15vbiZe6MI3K0GYtKBYpCEEezg=;
        b=y9y4Jkxl/R/W+i5kcLruINohyJmegrgl3QHoJxdpsPhTiQKdHE9HzmeMnubAX1IygS
         OYXCG+BW2Ybd1sJQHyA8PHW+MHt8VvC1jcMJhL8sNI4sA3+ShjSusa1i5LAV3xO8kIdp
         vAfFSbhVb481qKp6ME4DbEiRM66cv5YDbGc7j4bswF67+cX3Ln6M8KIFISLuMa1EEOjO
         CDE/2HA4QmJdS/iFicugHA6j5IUexIz6H8DawHD/YgIzDRTPlu+pA/TrDSm+zgYKHpob
         PjrZPbVKT6BJUhcD31LxPA0LRUz923wWHNnqJetD4Sg6+HuF0UCfp5QPVvydqAftup08
         dH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729425456; x=1730030256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O0yOz3cWb1IQD7Tg15vbiZe6MI3K0GYtKBYpCEEezg=;
        b=lUn6m0cqbR7kVuxwM0c4WAcD/yEJp+W29U8dGCbBhfKVsAzYF//tPyB4US/bc/WyGW
         U3mNqEbNJc9IDPtBTsNh6T8PBikOwPqTNAghJumOGJlsms6I47WCxYbGAnSfSFSt6JFr
         aRE3jNkEG04lArz0592Q7Fx0xQcr3zomelz8aPtBEj6QwWk9CPhF4rldj3qPvRCtzl+/
         UkkNNoe6UY7xKEkPghrQIPnnHEwjX/pKPbLk2H0Il0YFlTGtucB0w/cm9y0P67uhw362
         sgA7+Uu+jjEY2yWT5fw+v1gKgWKsQ9fovy4bXBJe9DQRj9WRsGGESzRHLpfs71bLoPcc
         67QA==
X-Forwarded-Encrypted: i=1; AJvYcCXMmj0f6qDkExptLzziU4Ar4C68fJkzW16UKP709HdzOX/jR6OUXFGhA1ONqn9iJTF+JOD/iVDPEodT0uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CrMUTC4nX0FFf2cdLmQpGf018/3h4r/ZBLbqah4Ul4uh4bwe
	k4XimJ8kwQrOGZ+Tsee9BDDIIlnTHbx81ppxpwYXIhp/lVGHFdPnyocj5+he8VE=
X-Google-Smtp-Source: AGHT+IHHy9TnC1ymBfAe1E716Oluk0OiwxHzPTwEx+CT7cluP5ONLkyX701HDnwlr4hgRXnCLaOyIw==
X-Received: by 2002:a05:6512:3185:b0:539:f65b:3d1 with SMTP id 2adb3069b0e04-53a152198c9mr4193710e87.21.1729425455844;
        Sun, 20 Oct 2024 04:57:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224319besm202236e87.215.2024.10.20.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:57:35 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:57:33 +0300
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
Subject: Re: [PATCH v5 13/13] drm/bridge: cdns-dsi: Use
 pre_enable/post_disable to enable/disable
Message-ID: <m7t4hsa3lcszjbipxlypf655uspoxw3xfyy5jo3n3bnmqaiqcf@6wti5f477gve>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-6-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019200530.270738-6-aradhya.bhatia@linux.dev>

On Sun, Oct 20, 2024 at 01:35:30AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> The cdns-dsi controller requires that it be turned on completely before
> the input DPI's source has begun streaming[0]. Not having that, allows
> for a small window before cdns-dsi enable and after cdns-dsi disable
> where the previous entity (in this case tidss's videoport) to continue
> streaming DPI video signals. This small window where cdns-dsi is
> disabled but is still receiving signals causes the input FIFO of
> cdns-dsi to get corrupted. This causes the colors to shift on the output
> display. The colors can either shift by one color component (R->G, G->B,
> B->R), or by two color components (R->B, G->R, B->G).
> 
> Since tidss's videoport starts streaming via crtc enable hooks, we need
> cdns-dsi to be up and running before that. Now that the bridges are
> pre_enabled before crtc is enabled, and post_disabled after crtc is
> disabled, use the pre_enable and post_disable hooks to get cdns-dsi
> ready and running before the tidss videoport to get pass the color shift
> issues.
> 

Not being an expert in the TI DSS driver, would it be more proper to
handle that in the TI driver instead? I mean, sending out DPI signals
isn't a part of the CRTC setup, it's a job of the encoder.

> [0]: See section 12.6.5.7.3 "Start-up Procedure" in J721E SoC TRM
>      TRM Link: http://www.ti.com/lit/pdf/spruil1
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---
>  .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 62 ++++++++++---------
>  1 file changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 79d8c2264c14..dfeb53841ebc 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -658,13 +658,28 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	return MODE_OK;
>  }
>  
> -static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					   struct drm_bridge_state *old_bridge_state)
> +static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> +						struct drm_bridge_state *old_bridge_state)
>  {
>  	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>  	struct cdns_dsi *dsi = input_to_dsi(input);
>  	u32 val;
>  
> +	/*
> +	 * The cdns-dsi controller needs to be disabled after it's DPI source
> +	 * has stopped streaming. If this is not followed, there is a brief
> +	 * window before DPI source is disabled and after cdns-dsi controller
> +	 * has been disabled where the DPI stream is still on, but the cdns-dsi
> +	 * controller is not ready anymore to accept the incoming signals. This
> +	 * is one of the reasons why a shift in pixel colors is observed on
> +	 * displays that have cdns-dsi as one of the bridges.
> +	 *
> +	 * To mitigate this, disable this bridge from the bridge post_disable()
> +	 * hook, instead of the bridge _disable() hook. The bridge post_disable()
> +	 * hook gets called after the CRTC disable, where often many DPI sources
> +	 * disable their streams.
> +	 */
> +
>  	val = readl(dsi->regs + MCTL_MAIN_DATA_CTL);
>  	val &= ~(IF_VID_SELECT_MASK | IF_VID_MODE | VID_EN | HOST_EOT_GEN |
>  		 DISP_EOT_GEN);
> @@ -683,15 +698,6 @@ static void cdns_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
>  	pm_runtime_put(dsi->base.dev);
>  }
>  
> -static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -						struct drm_bridge_state *old_bridge_state)
> -{
> -	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> -	struct cdns_dsi *dsi = input_to_dsi(input);
> -
> -	pm_runtime_put(dsi->base.dev);
> -}
> -
>  static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
>  {
>  	struct cdns_dsi_output *output = &dsi->output;
> @@ -760,8 +766,8 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
>  	dsi->link_initialized = true;
>  }
>  
> -static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					  struct drm_bridge_state *old_bridge_state)
> +static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +					      struct drm_bridge_state *old_bridge_state)
>  {
>  	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>  	struct cdns_dsi *dsi = input_to_dsi(input);
> @@ -776,6 +782,21 @@ static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
>  	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
>  		return;
>  
> +	/*
> +	 * The cdns-dsi controller needs to be enabled before it's DPI source
> +	 * has begun streaming. If this is not followed, there is a brief window
> +	 * after DPI source enable and before cdns-dsi controller enable where
> +	 * the DPI stream is on, but the cdns-dsi controller is not ready to
> +	 * accept the incoming signals. This is one of the reasons why a shift
> +	 * in pixel colors is observed on displays that have cdns-dsi as one of
> +	 * the bridges.
> +	 *
> +	 * To mitigate this, enable this bridge from the bridge pre_enable()
> +	 * hook, instead of the bridge _enable() hook. The bridge pre_enable()
> +	 * hook gets called before the CRTC enable, where often many DPI sources
> +	 * enable their streams.
> +	 */
> +
>  	if (dsi->platform_ops && dsi->platform_ops->enable)
>  		dsi->platform_ops->enable(dsi);
>  
> @@ -912,19 +933,6 @@ static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
>  	writel(tmp, dsi->regs + MCTL_MAIN_EN);
>  }
>  
> -static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					      struct drm_bridge_state *old_bridge_state)
> -{
> -	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> -	struct cdns_dsi *dsi = input_to_dsi(input);
> -
> -	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
> -		return;
> -
> -	cdns_dsi_init_link(dsi);
> -	cdns_dsi_hs_init(dsi);
> -}
> -
>  static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
>  					       struct drm_bridge_state *bridge_state,
>  					       struct drm_crtc_state *crtc_state,
> @@ -968,9 +976,7 @@ static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
>  static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
>  	.attach = cdns_dsi_bridge_attach,
>  	.mode_valid = cdns_dsi_bridge_mode_valid,
> -	.atomic_disable = cdns_dsi_bridge_atomic_disable,
>  	.atomic_pre_enable = cdns_dsi_bridge_atomic_pre_enable,
> -	.atomic_enable = cdns_dsi_bridge_atomic_enable,
>  	.atomic_post_disable = cdns_dsi_bridge_atomic_post_disable,
>  	.atomic_check = cdns_dsi_bridge_atomic_check,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


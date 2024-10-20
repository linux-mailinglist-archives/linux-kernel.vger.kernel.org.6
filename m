Return-Path: <linux-kernel+bounces-373213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DC9A53D9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031ED1C21550
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25D186E58;
	Sun, 20 Oct 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGAxzlxO"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB584E0A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729424543; cv=none; b=c3w1GnSkHs21tu2K5PVN/k2ea4p96kehUKB2HWTQL1cjw0ZGsLrLxeZ5iJqhHTYhEFHmcjObqESruT2pFKrMVEHIWv55t33XIh70+MTVp0h0Y6XQAfavIZHt0pvO1P1zJiUhUeDCjabbaULadecv3o3NSVgI1UJeyjptv+MU97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729424543; c=relaxed/simple;
	bh=ABc1vdBE3cCo1eZxugZ9rTg2b2MZ9WK5T+LOHspMDzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYCtRLYacW7l3ABEPilY5951/ZBvxpwctpvVUjEYnklZl66gPsDrRXWpvRHZix0Joj5JJ/tObkXwMt+yYc/5kMzFmmpiAbdrYHtUxPkKzmN/Vo7u/9Lu6vKH3cwzGnbuleo9ZIS1nfGtIatpYTgC1oLm4yzT8pSwpmSvc6Oe/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGAxzlxO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e4b7409fso3538173e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729424539; x=1730029339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Re9ea2Fbhj4sQlgiUBc5/pgSXFotaCfmOVOUipxA6Uk=;
        b=zGAxzlxO1CVr3Gt3vDJyfWdOCOFXM08if0yZjzhshSFrfDPWtQuj4BTyAjsKdKF7rP
         ntD1UZFDppPHfVg0eQnYgW3dm6iD7xg1EM9/nmiB+1X/E0Np1e2147T1JUafxOntdcaF
         hzsWQpZeBuCgMHepJ/Hh9e3utB9IuHFLpvuHHVJhvXOGne14r/z10t0iIrk7kM/G35Cf
         Xu9nbzsSwuk+SYP/zSblL8PBmdWgdxYSMGn4z5XoIdR5OWw0HIKqmcK9PLo7qDsLQNp3
         +sdG9Prhg2jJl+ybv13rSsI+viETKMtyktzelhh1OtfCWPYpt0XSHKLiv7eT2QHQyFZA
         S1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729424539; x=1730029339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re9ea2Fbhj4sQlgiUBc5/pgSXFotaCfmOVOUipxA6Uk=;
        b=KbJcZOjp/En5kc3Q2lcaWbwQycxIwVkpjbl/41lI32NmRupLHKAuqB41pIRo2fia8v
         ZxF/KIoTBvJypPDid518DbzFmdBHLqtHX8IQuDABte/EMGgszplrdPCGTBgx9Du9qQr5
         MJp66o/sQG5jtsPGCj4OjTdSzvLmFzNBgCmvV6+0dUl4H5HASXNkj54jq+RCYl9xku59
         9TJ15YJMKkevWN1Pe0psMoh4clJv3h0TdPUkF4gIH55K23l/G9csFQu0CrXmARGBMHyO
         JlmGJx0aCrb66ZA1DMaYaL3owYI5RMWqxGE1BcMy4hSgCOiGoeU+kJEmPbsjs65nlz1Z
         ZVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXli1vn9KXpsFLXQoq+OXCCYP5zzM2rjeiOIUMANGE7EyfYnD0jjXFAQ52onS6OS+BPPvfQRShqT1O4uN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4uu9YFf94Y69mOi7Y4cdrz8fnT2kreaf6OAJ/srd6oNsoWza8
	hp78X6Yf+2LekvtBQmjMntvDMObiYQXJoMZvwTFfKLVmWjdB4QC3dq0xyTPnOjk=
X-Google-Smtp-Source: AGHT+IFwVJWScHOxNtIO9jOkti32TUNVgSQPzSh0Yn+npLDF7bD3R90ZUdOqYrxAaAALCV2JubLUvw==
X-Received: by 2002:a05:6512:23a5:b0:539:f922:bd3a with SMTP id 2adb3069b0e04-53a0c7525aamr3841505e87.25.1729424538590;
        Sun, 20 Oct 2024 04:42:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224202d5sm198065e87.136.2024.10.20.04.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:42:18 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:42:15 +0300
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
Subject: Re: [PATCH v5 10/13] drm/bridge: cdns-dsi: Move DSI mode check to
 _atomic_check()
Message-ID: <wgxqkelcwum4y7ggc36avwcnnsdyu3nfjj7lp4mvopws6p23f5@h22uk464s62t>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-3-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019200530.270738-3-aradhya.bhatia@linux.dev>

On Sun, Oct 20, 2024 at 01:35:27AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> At present, the DSI mode configuration check happens during the
> _atomic_enable() phase, which is not really the best place for this.
> Moreover, if the mode is not valid, the driver gives a warning and
> continues the hardware configuration.
> 
> Move the DSI mode configuration check to _atomic_check() instead, which
> can properly report back any invalid mode, before the _enable phase even
> begins.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 18 +++++++++++++++---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h |  1 +
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 7341e609dc8b..79d8c2264c14 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -769,7 +769,7 @@ static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
>  	struct drm_display_mode *mode;
>  	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
>  	unsigned long tx_byte_period;
> -	struct cdns_dsi_cfg dsi_cfg;
> +	struct cdns_dsi_cfg dsi_cfg = dsi->dsi_cfg;
>  	u32 tmp, reg_wakeup, div, status;
>  	int nlanes;
>  
> @@ -782,8 +782,6 @@ static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
>  	mode = &bridge->encoder->crtc->state->adjusted_mode;
>  	nlanes = output->dev->lanes;
>  
> -	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, false));
> -
>  	cdns_dsi_init_link(dsi);
>  	cdns_dsi_hs_init(dsi);
>  
> @@ -954,6 +952,19 @@ static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
>  	return input_fmts;
>  }
>  
> +static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state)
> +{
> +	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> +	struct cdns_dsi *dsi = input_to_dsi(input);
> +	struct drm_display_mode *mode = &crtc_state->mode;
> +	struct cdns_dsi_cfg *dsi_cfg = &dsi->dsi_cfg;

This makes .atomic_check store data in the non-state structure. However
it is not guaranteed that each atomic_check() will result in the
atomic_commit(). So in addition to moving the check to the
atomic_check() callback you also have to move the cdns_dsi_cfg and all
other structures written during the check to the new structure, wrapping
drm_bridge_state.

> +
> +	return cdns_dsi_check_conf(dsi, mode, dsi_cfg, false);
> +}
> +
>  static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
>  	.attach = cdns_dsi_bridge_attach,
>  	.mode_valid = cdns_dsi_bridge_mode_valid,
> @@ -961,6 +972,7 @@ static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
>  	.atomic_pre_enable = cdns_dsi_bridge_atomic_pre_enable,
>  	.atomic_enable = cdns_dsi_bridge_atomic_enable,
>  	.atomic_post_disable = cdns_dsi_bridge_atomic_post_disable,
> +	.atomic_check = cdns_dsi_bridge_atomic_check,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_reset = drm_atomic_helper_bridge_reset,
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
> index 5db5dbbbcaad..b785df45bc59 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
> @@ -77,6 +77,7 @@ struct cdns_dsi {
>  	bool link_initialized;
>  	bool phy_initialized;
>  	struct phy *dphy;
> +	struct cdns_dsi_cfg dsi_cfg;
>  };
>  
>  #endif /* !__CDNS_DSI_H__ */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


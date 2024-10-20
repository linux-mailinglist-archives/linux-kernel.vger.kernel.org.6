Return-Path: <linux-kernel+bounces-373209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53AA9A53CD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78034282172
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015B18CBFE;
	Sun, 20 Oct 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oM6hX1Hz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE16186E58
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729424077; cv=none; b=kdSGWvjbhqtjt5nZcoePMx+cle1sNdCRMjyy7UQscuxQhcGt9eqjsqFywJ9YAv6ZT/qKGOeq+oj6HQ5nhXpmJSm1oEQ1RrA0fyHANESg1NZGp6LlJ2U9dPiSUIj4IbGsGQRhLv3UtoIc4kMstoGu8+UMPaslLSSpqI6KxFH5qGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729424077; c=relaxed/simple;
	bh=U7Nnx8qEFXv4ilrBECogt/6SzJ11VbXNa/hFI7sQ7pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmKCBWVYDS4a0cP51TFrBdos/g72Ko2PBxiS/hlK++IoBO9YWBEtIhWrwjHaX4ChpQiLvvvfDmNs+W7fLWq/rn8IwSejLE5VCebpxrwuxM1x1GXN1BBIxA2PzxJb1r6ayaBZQNsQ/jFNXEuMWgapKlf+p0snruqSF5pyZpY0qok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oM6hX1Hz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f8490856so3773179e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729424073; x=1730028873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QC0KnB6o2h4mn/hVK+dZGyuz3d5o2C5KLZTYulXkdRQ=;
        b=oM6hX1Hz/Pziy8q42flaarm3r7qRso+4COPFyWMiJUNr6zTUVh2/7X620T7uWRneNU
         2lR0wGurCNrbSVJ+PmExIgwjYK2mv1a2tLhpXdG6x8byZTIHFXhniM7ZHDNeEsj6+eUk
         Ar5gk2uYx9tODeu0eF55nLRUzwmnIECHDp3GhPnRWO7i14cVhfepT/2TTZbAe8dVxxCC
         mlLpJTe75M7wCFkBt/xIiz5IwebMJTijPXzVTxUQqJAQaHctnaO8EI4PTuxDKpatY7Ox
         HGwFeJE9jGbC8Jhdt1FGgC3JZrzZ7FlSzy6wXagrEljjQcl6/gfny1ZUVv+rFZ5Ed/FJ
         1WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729424073; x=1730028873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC0KnB6o2h4mn/hVK+dZGyuz3d5o2C5KLZTYulXkdRQ=;
        b=g4EVxpuqGADIm8OjeTF0LIuguub4nSQALWWO/ddEq1wZNlyk3nZf0RWv1FmmImdygJ
         w6WKobh8UPCUEGvpvm9teSe6fIUYhjrI4omrR3X1N9D2ECzj+IgW3S+/l5C6djzpE0sm
         YB/hfs1ttaxctvSrI/xfBTwhEIiEwyDdVomqCXAG0rZhldKKa0BLq+lFw+eJYOoAFpJm
         evpagyiRyC2D779ubALTxXXzzZBXTBJPwgl5WWw9dDB/03Jvz821nNBQOL6DRhZsDjGG
         2Cl70mR0pI384+4rnjtpHw7icLjQlNnqKQruvVYoZNR62hzOVz2p09IEMW5anU/s07ey
         B8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdvLJzzcMYrRZWwM8XGp6PerlOSnK1f/R0h9JdOdA9f4em/t7ogWQ0pYM7oWkBjCK5rEI44TAu6WS1AWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+0Psngo1z48+5kK9Qw45uVey++h8Rro3N4/ZjqVOti7BgZIJ
	7UhPtR6Aj831np0kH00+DU8mD2+gbHFBI3QlV3W8jrSuHLoCuTIavJ8SRwH1YN0=
X-Google-Smtp-Source: AGHT+IHw7JUxCsHiCWKAeBC9lGrE1QOYEOuzwLBF37sN/Bov8L27eTs6yeqUaRmGDeoT/SoNNTNn6w==
X-Received: by 2002:a05:6512:1384:b0:536:55a9:4b6c with SMTP id 2adb3069b0e04-53a1545338fmr4077961e87.13.1729424073213;
        Sun, 20 Oct 2024 04:34:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243edb9sm195178e87.274.2024.10.20.04.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:34:32 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:34:30 +0300
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
Subject: Re: [PATCH v5 03/13] drm/bridge: cdns-dsi: Fix Phy _init() and
 _exit()
Message-ID: <i5o65ui4psc7b4hsqq5hl7t2hvf43xc7pmvlrcstjhqp2okwx3@izezpdd7tmk2>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
 <20241019195411.266860-4-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019195411.266860-4-aradhya.bhatia@linux.dev>

On Sun, Oct 20, 2024 at 01:24:01AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> Initialize the Phy during the cdns-dsi _resume(), and de-initialize it
> during the _suspend().
> 
> Also power-off the Phy from bridge_disable.

Please describe why, not what. Especially, if it is considered a fix.

> 
> Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 5159c3f0853e..d89c32bae2b9 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -672,6 +672,10 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
>  	if (dsi->platform_ops && dsi->platform_ops->disable)
>  		dsi->platform_ops->disable(dsi);
>  
> +	phy_power_off(dsi->dphy);
> +	dsi->link_initialized = false;
> +	dsi->phy_initialized = false;
> +
>  	pm_runtime_put(dsi->base.dev);
>  }
>  
> @@ -698,7 +702,6 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
>  	       DPHY_CMN_PDN | DPHY_PLL_PDN,
>  	       dsi->regs + MCTL_DPHY_CFG0);
>  
> -	phy_init(dsi->dphy);

This moves the call order, moving phy_init() before
platform_ops->enable(). It should be documented with the clear pointer
that it considered to be safe.

>  	phy_set_mode(dsi->dphy, PHY_MODE_MIPI_DPHY);
>  	phy_configure(dsi->dphy, &output->phy_opts);
>  	phy_power_on(dsi->dphy);
> @@ -1120,6 +1123,8 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
>  	clk_prepare_enable(dsi->dsi_p_clk);
>  	clk_prepare_enable(dsi->dsi_sys_clk);
>  
> +	phy_init(dsi->dphy);
> +
>  	return 0;
>  }
>  
> @@ -1127,10 +1132,11 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
>  {
>  	struct cdns_dsi *dsi = dev_get_drvdata(dev);
>  
> +	phy_exit(dsi->dphy);
> +
>  	clk_disable_unprepare(dsi->dsi_sys_clk);
>  	clk_disable_unprepare(dsi->dsi_p_clk);
>  	reset_control_assert(dsi->dsi_p_rst);
> -	dsi->link_initialized = false;
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


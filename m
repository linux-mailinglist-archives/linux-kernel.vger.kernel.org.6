Return-Path: <linux-kernel+bounces-218949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7E90C816
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343911F24E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0715821D;
	Tue, 18 Jun 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kF+aDvLh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B313B587
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703279; cv=none; b=bp0EzpyZ/Qdm1yzv+Z4NFcIgvzZuoJE9ckcwN1bIdd0UZF7LhowQYEEjJT4alj1+jdbQUzn2AScqLouwKCPUkNUeAvU5lhZLpHuf4lv+pHLF5vRJlh8vSGOqct1JRJZo2Hf5aXFp3K0Hy2Q9Cbl/pFNpe8qp0ZfCoH/mHVs9kxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703279; c=relaxed/simple;
	bh=OwBXLxTgIxhAvEWHZw59Np1NM6d7ZgJiEzitI93blL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sv9MRhiBnCGjRyAT2CQ3WCXB0jouxgMNjlWt9T4Q5iLtc4M+RVYPHbDRnC3WdM2hhR3JWunQrbv3A9AOmSBFEU98EQh3J7CgRlbx26NEsmLU2sxPp4ngVR0+15FWz0IAlXEkgJGiUinDyLlhSWCxVYP4bZfYGoAIpyj55VwiGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kF+aDvLh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so49211031fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718703276; x=1719308076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OtPQx/Pu4izNrX/Re5hWMRulfkvuWWXAK3KKNMzu7g=;
        b=kF+aDvLhde4JkYi3rCKkxUD4K8OiLz/i6+/l8oD0Z7ZQJQI1MqN0ohZYJyL7VP4YSy
         EeNbjb3Cr3RYPiLV4EZ+pir/WeF3vdWFtD/6DbDmBQwXJ+z544pgmDU5gKp3pGAuPkFu
         R9uVoohSAv938mkWrpQodb4jLifYmmuE5F9icAg+Lig9Z1w9jRNoVGAMUHQtWrQSCW08
         gTvI8TGdv2ug/uQMUPWfjeOwFOiwIBhPkMhJA25loyOi8vnUh4Y7ApJ/+a0Pw3/hpsHf
         i+nYj37B0OZkRo6Wx6QQ7amjWAPyM5eJX7TkqMDgK0aHzCOIu5URjYmzmYcjM8aJypvD
         uMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703276; x=1719308076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OtPQx/Pu4izNrX/Re5hWMRulfkvuWWXAK3KKNMzu7g=;
        b=pKyXiNLqNg2Ee/X0c+mzk4AAniqw3v6nznToix8JfDpZOP8vhlkf9thv53qWalOzFR
         45FyE5yDneIjTqdFK8OYssmjtLUUlSWXAeovVdgot5VHM6dz2Lz3j2AzIIZb+Yj4TsfA
         RB13T128ai+xRdPxTFhDgtdpmGF0QDYipvCqPOZZCri5ou74ifxtpV+QevRpGFS24x2T
         mD5RiGYyBhhD96GYu3LcpVxIl/tg0U2HkX37DRmBHisRkq5kTkuiUPxQNvi0psadnerE
         9IGtS6jPIGE9aDDGjRQoogo+JgsopoWecbn/XDBbtSuVAOgG226e3CODAvWSTJJs1hNT
         JEgw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0bAoBOEn8c03ef74DOyUJYHAuGEIVYnE24MGQXysXtMAd9KUEzND7UlUw5CTzLvtOOygoeyUgmz9E16x82OaI8Fb4vpD8GLVN9lX
X-Gm-Message-State: AOJu0YwP8cwM8wlkLGK9zbQ0rw5bO7S2JjFmCJj10F4AKcTAL1CW/5i8
	rlo2r6ceprVZvqFanUL90USJ23tCxD0dbUf8DG9tJuS+WdiNUQiJCcIMaE+BNjo=
X-Google-Smtp-Source: AGHT+IGV3fdRHGz8W6Ml8JMRCptiBjlFKzjIcCxhI6Uj5qvvYAKo3j/iWUDBncEItZIdRBsrs9DQOg==
X-Received: by 2002:a2e:8609:0:b0:2eb:fb9c:5a85 with SMTP id 38308e7fff4ca-2ec0e47b5c6mr68554821fa.23.1718703275629;
        Tue, 18 Jun 2024 02:34:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c78422sm16495521fa.95.2024.06.18.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:34:35 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:34:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] drm/bridge: lt9611: switch to using the DRM HDMI
 codec framework
Message-ID: <fal5jtesucasboygxde2uiamq6fhycwuhor6g4uqi54jx3sis7@gw5im7xxss6n>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-5-d59fc7865ab2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615-drm-bridge-hdmi-connector-v1-5-d59fc7865ab2@linaro.org>

On Sat, Jun 15, 2024 at 08:53:34PM GMT, Dmitry Baryshkov wrote:
> Make the Lontium LT9611 DSI-to-HDMI bridge driver use the DRM HDMI Codec
> framework. This enables programming of Audio InfoFrames using the HDMI
> Connector interface and also enables support for the missing features,
> including the ELD retrieval and better hotplug support.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 207 ++++++++++++++++----------------
>  1 file changed, 104 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index 4fa0dfc5539a..02953468cb76 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -45,7 +45,6 @@ struct lt9611 {
>  	struct device_node *dsi1_node;
>  	struct mipi_dsi_device *dsi0;
>  	struct mipi_dsi_device *dsi1;
> -	struct platform_device *audio_pdev;
>  
>  	bool ac_mode;
>  
> @@ -688,15 +687,22 @@ lt9611_bridge_atomic_enable(struct drm_bridge *bridge,
>  
>  	/* Enable HDMI output */
>  	regmap_write(lt9611->regmap, 0x8130, 0xea);
> +
> +	drm_connector_hdmi_codec_plugged_notify(connector, true);
>  }
>  
>  static void
>  lt9611_bridge_atomic_disable(struct drm_bridge *bridge,
>  			     struct drm_bridge_state *old_bridge_state)
>  {
> +	struct drm_atomic_state *state = old_bridge_state->base.state;
> +	struct drm_connector *connector;
>  	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
>  	int ret;
>  
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);

Of course this should have been
drm_atomic_get_old_connector_for_encoder(), otherwise it crashes because
connector is NULL.

> +	drm_connector_hdmi_codec_plugged_notify(connector, false);
> +
>  	/* Disable HDMI output */
>  	ret = regmap_write(lt9611->regmap, 0x8130, 0x6a);
>  	if (ret) {

-- 
With best wishes
Dmitry


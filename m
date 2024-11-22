Return-Path: <linux-kernel+bounces-418180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D69D5E40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3592E1F228D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F341DE8B3;
	Fri, 22 Nov 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGooyY9r"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590E1D0143
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275326; cv=none; b=oQk41nVbBvuc+PEmaj3djzY8iBBy9mD9r/7P8W92WLwNd+x1Ab9pEs1q8kZT06ZMAyzyZAP+/AoXIwpQ2nVIbmpHAWRk97PS2nsHSH9070c2Q4VOSohU5xqn5YeVZz71jbjY6B5Ogcl8p1p7nXO8llD8PwWKs+Ue8VOe8MCWEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275326; c=relaxed/simple;
	bh=6Xd7rJOb08RMaqyYb/dd6a9HoYlps8DyV1OZBY6cLOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YohLo4zc1kzNH7oOFw+wRDP32flh6IUNgcPo4oV8Ht0ELauES2WEbz/Whr2UUA6YmLCKniFC8hSSCQp4HesTO4NifkKbMVVGeuOvm0DUbLoUB+YenG4LiB+pTyOM9hHwXf3ZaL16l8nfe10R6bGPTSCQU46fcjVvFkKFhC2GeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGooyY9r; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3405213e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732275323; x=1732880123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krxMhaTOFP6KQfuRozKR1NNs6wdGoTjqof+u9BiFDsk=;
        b=rGooyY9rZyj2FYZ0mDfR0hvGn5g/BsiydIW6qk1ixiCTewn6or268/rpKR7n4XwRrr
         GUY7fVFUHcvJWyeJg7HJBeI0mKxx63yVSELWcWt09g23PHMS12qOIwm7bkkRGTBg3o68
         aBdxu0xsGW0NAo1mjcqtnPl/zGj12G06DQbEdXPMN2jYF+brA7krc9NE/VV7wosVstIz
         GF2hIIDV+jfJL1a9cQfK6pWxz5j3kKIMZ8ASHMDqOCBEM2504eXDjy2XwomWRZza8lrc
         jZalEHiPTEMP+CMf5kx4dnHCH5CHW/bfAMab4iJGdLmHcqcFAIs3f6wnP2Kdlyt0yK7F
         iFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275323; x=1732880123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krxMhaTOFP6KQfuRozKR1NNs6wdGoTjqof+u9BiFDsk=;
        b=nrez7EkhAdXy2Zda/o8Xzv+yP5958HF3EE3/pGgvC90kSaSKEvKOU8MgaxdYRYuLgC
         /WQZ51jJlrltgLFp+fA168RZYiuyrIKJYAu3KiDrIRlerxHpd51/UKk+rW4v82wK5DrP
         PhArgJ9Xdl/FjFju9NrJB4UjSL+NPG/VQJF3PsBD01OzYXwDTLikW+819tGH40rO5cFX
         u/PA5mAsa6PxYBNy8cUKLzyTAETjaURQJHosfC4qMn2xnwYhKXOj6PUOclzP3kyDsV72
         Wnv5QJ+Mm67z1kMuAQp4Caj2Vd50Rk7wPqcyI60N7grQJSqn+hdEJbOWVyc+LLDny92F
         YT7g==
X-Forwarded-Encrypted: i=1; AJvYcCXepj+fdO5IXdKuODLemJuca4hK60r77bOuKwf+vhr5OzIP/hb1OA4/gzLudlA/cBsJjt3+mzm0vh2ETdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3OUX1mBAXPFytUbG6il/w6cDe+HPGAaIsphgqjycwHUb/9GQ
	pO9Pwbs/xiObd6abMpXc5Ve1+ESgFyYArteHQN6Yxljm+wtXCXSQNPvxB7XSGE4=
X-Gm-Gg: ASbGncva5vOdpneMk0bAbnatDj7afPaaLqQyFkp9Br2whIHU7cZjMtyz2kqmQPh43eZ
	GUgPhSDY9koDSlVjeLNDBi7KDqUszyrrX/krZuR07dMh3G2caKPpI8EpZ9tIY45QdWRADG+ece/
	avVHMtSpUwO4AC2ziskUxXBhI3xSxSaC0acfbt+Yt3H88Qnz30qktJgZAfNMZ53fB9OAhQRhjQA
	QtTRS06/nqzDhtXZYk5R0b4ZR16Yca+6hjH8Bk24uYtQOojoRoJ333MImSCIlH9Jh1yLz5Ou5Ni
	Hz/mE7tFud6l4RJZtsL7pgImSZ4icA==
X-Google-Smtp-Source: AGHT+IHcS5D0tQAmLEPHu7UajYtNpfZvhiuBwDM25QDIUqbvD9w+ge3SD7yoJlUUHrhodq7JCz8ehA==
X-Received: by 2002:ac2:5eda:0:b0:53d:d3ff:7874 with SMTP id 2adb3069b0e04-53dd3ff78e0mr1407682e87.29.1732275323001;
        Fri, 22 Nov 2024 03:35:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd3f12809sm270502e87.38.2024.11.22.03.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:35:21 -0800 (PST)
Date: Fri, 22 Nov 2024 13:35:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Phong LE <ple@baylibre.com>, 
	Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 3/7] drm/connector: implement generic HDMI codec
 helpers
Message-ID: <altuhp26ntnpltvfdmikggdmibyizdwnrmwshte7sa2btmbgvj@mbhlvwb4xrzj>
References: <20241122-drm-bridge-hdmi-connector-v4-0-b4d69d6e3bd9@linaro.org>
 <20241122-drm-bridge-hdmi-connector-v4-3-b4d69d6e3bd9@linaro.org>
 <87ed33zf5e.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed33zf5e.fsf@intel.com>

On Fri, Nov 22, 2024 at 01:22:53PM +0200, Jani Nikula wrote:
> On Fri, 22 Nov 2024, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > index b2b6a8e49dda46f1cb3b048ef7b28356dd3aaa4e..8ed58e482fac4662b659276e8bc17690e1fdb9b7 100644
> > --- a/drivers/gpu/drm/drm_internal.h
> > +++ b/drivers/gpu/drm/drm_internal.h
> > @@ -280,4 +280,9 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
> >  				const struct drm_framebuffer *fb);
> >  void drm_framebuffer_debugfs_init(struct drm_device *dev);
> >  
> > +/* drm_connector_hdmi_codec.c */
> > +
> > +int drm_connector_hdmi_codec_init(struct drm_connector *connector);
> > +void drm_connector_hdmi_codec_cleanup(struct drm_connector *connector);
> > +
> >  #endif /* __DRM_INTERNAL_H__ */
> 
> Better fit in drm_crtc_internal.h or drm_crtc_helper_internal.h?
> 
> Maybe we could use an internal header inside display/. Or just 1:1
> drm_foo_internal.h for every drm_foo.c to keep things simple and have
> fewer interdependencies.

Sounds like drm_connector_hdmi_codec_internal.h. Most likely we should
also split or rename drm_crtc_*_internal.h, but that's a separate topic.

-- 
With best wishes
Dmitry


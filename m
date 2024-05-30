Return-Path: <linux-kernel+bounces-196025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A18D5631
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324971C24EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188417E450;
	Thu, 30 May 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPD+sFml"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F34D8C3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111274; cv=none; b=c6VE/4JPLXq3CGS4Zv9YseaSo+S2KF9JGKK0Jkw6pt0JMMcMaQL+v8cPUkETghpOKR/x/NygSmrNHrOdS/8cCKdvv7bhBgIPHffJTI/nW2cjJpFCeaPcM7li18/0aFEEu5ya9qaxk51uowzC7PDg4d73ecNHGmFzNw5hG6F8GO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111274; c=relaxed/simple;
	bh=0DuLBq2hPeHv+UcOyW3LvpkU0d5LnKtIu6WxqV1OaLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuujuNSgh1OA1045aZhy/swu838heY9fpFud3MyNjr1lxsaawMrOe2BQchc3UKPZ3ABqUhpMjWxLhELMqiKIQFMd72KByQ6vEofQeia0G70k2LcrYAh31RW2AtT2TADDwHLqPSzaEcJpFD2NwoJtimYyl32le4a+yoahAeJ6TTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BPD+sFml; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso627532e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717111270; x=1717716070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YE7nBWRP2r6qptkkjnhfqlN+45c+PRv7G0Q2JOIxAzQ=;
        b=BPD+sFml7NkcYg3bh5W+vOWkTNXhCFrsF3F26sSLBhvuH4NQT88wEy4g/JMbtCoAoT
         FO9jBFT5WhRNQb1g/bKTbqzf4ZX9QjnG5Of7nBVRjeXRbeisvOsPhABIZ0+h2eP0BKCv
         J1IME0mITZVaC5xmEnafcxfgA4R0lL+/9UsTzS1zfvIkS8btyzAIcN7iG81mWf58YLYD
         kwk6X9IB6f5wa22azkYAPwcLbql4WMDNPh+OfZZmdhQ3wiABdrnd6vOJbXBUkOuuEu3a
         H80F76J0W7UZ3qW4jdtKK2EF12NJWgxqFXItzYThVrES8iVW9Pl8ifblPBVZuQu2S3Lv
         zU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717111270; x=1717716070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE7nBWRP2r6qptkkjnhfqlN+45c+PRv7G0Q2JOIxAzQ=;
        b=QFMqevZSmCKV/TL4AX2m/caRAVXqiVnELPgr5ZRIguxoaXgz8XDZ+0LW5VUWxaGi2g
         4NJTYA6umwHTio6GyLVlBu1BgVqc1/TKBhwokUdSIZEP0/zIhhInfpnwrTExipaK4U0V
         gDdgq5uGBbZCuSpPUJOylShQv4QjQ1CPNGCl9sX3T7BETM3P+W/2fUlYXqBEB8/FocpW
         1UvCq26H9d11WilTj6wpCoZrSaLlDd7ke73CbAMpGQqBCBQt5zMa2g961ZHovl9GmPeb
         lat8ioNi6mEreXfjgIGFqLCOsB3OFSmD2HhX4t/EkJG1iYagfmhiSIQZWoH0/v8TKbyD
         UsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIpOIl03EpRyFLETdDRLinZQ1EsOe2aLlTfQr++oW0hW0kgzfFhWdMIoPESYH0tinRZttE/6+mYYytCnajBMfYPo0zCvDfflsReBcc
X-Gm-Message-State: AOJu0Yy6rzRoSw3UyyyFpYYtWxNFv73af6ZYEPEOU9m6zPcGzwZsk6p6
	T+BFKaAapW9ZRNzj78e8y9sommr/KFNOOr9Z4E1Eetve/yGDgTXK4r6+Qsy5ejQ=
X-Google-Smtp-Source: AGHT+IGSYTyCk7NZstVbr2ZMY+F7VW77DKpKIwwwGH/JGXdol+c9u1s5nysiBUlt9LCyDxtOBxQSfg==
X-Received: by 2002:a19:6a09:0:b0:523:8a14:9149 with SMTP id 2adb3069b0e04-52b8956b5c9mr47305e87.21.1717111270420;
        Thu, 30 May 2024 16:21:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d89c2dsm121896e87.258.2024.05.30.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:21:10 -0700 (PDT)
Date: Fri, 31 May 2024 02:21:08 +0300
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
Subject: Re: [PATCH v2 7/9] drm/bridge: cdns-dsi: Support atomic bridge APIs
Message-ID: <4fsu5fa5zbrqgc5bepxscoenrax5c6p5b4eyomavioy3bhwuq3@rjjbur3v52e3>
References: <20240530093621.1925863-1-a-bhatia1@ti.com>
 <20240530093621.1925863-8-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530093621.1925863-8-a-bhatia1@ti.com>

On Thu, May 30, 2024 at 03:06:19PM +0530, Aradhya Bhatia wrote:
> Change the existing (and deprecated) bridge hooks, to the bridge
> atomic APIs.
> 
> Add drm helpers for duplicate_state, destroy_state, and bridge_reset
> bridge hooks.
> 
> Further add support for the input format negotiation hook.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 70 ++++++++++++++++---
>  1 file changed, 62 insertions(+), 8 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below.

> 
> @@ -915,13 +920,62 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
>  	cdns_dsi_hs_init(dsi);
>  }
>  
> +static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
> +					       struct drm_bridge_state *bridge_state,
> +					       struct drm_crtc_state *crtc_state,
> +					       struct drm_connector_state *conn_state,
> +					       u32 output_fmt,
> +					       unsigned int *num_input_fmts)
> +{

This code below looks pretty generic. Would be logical to extract it to
a helper and allow it to be used by other DSI host bridges?

> +	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> +	struct cdns_dsi *dsi = input_to_dsi(input);
> +	struct cdns_dsi_output *output = &dsi->output;
> +	u32 *input_fmts;
> +
> +	*num_input_fmts = 0;
> +
> +	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	switch (output->dev->format) {
> +	case MIPI_DSI_FMT_RGB888:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +
> +	case MIPI_DSI_FMT_RGB666:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
> +		break;
> +
> +	case MIPI_DSI_FMT_RGB666_PACKED:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
> +		break;
> +
> +	case MIPI_DSI_FMT_RGB565:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
> +
> +	default:
> +		/* Unsupported DSI Format */
> +		return NULL;
> +	}
> +
> +	*num_input_fmts = 1;
> +
> +	return input_fmts;
> +}
> +

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-438669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7249EA421
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5060418838A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E917A2AD16;
	Tue, 10 Dec 2024 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zlez7y3v"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC834C81
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793168; cv=none; b=KZI5NuxZWSAaLS3wptvZ5g1DOZ6yx6j5mYj5/23xD73wzMFikNoFjCw5lWGNw4NbzqcZXnSGhGCdO4/udDTROFxyK2WeNKU8dsEwX41dH7rnlIfR8gzZEEYqLhym8BO7xkM8cXzRwon8664F7G4Yw1jES4WkaEA2+aoskvf4ayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793168; c=relaxed/simple;
	bh=BShOFr7Zc+uEQt0Kr3ND93sJ8NZ5S2Zht736NqynF+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shl7C1wGd1J8rRouqET4wFoB1cCvjKNDRTeNrZzKzokoSS1akyyoE0fB+tksh9QSNHoYs/SuzcF0wDj5C2Uj05k7n9fmT1RDzWhZ6o83Z1264Sz35tgQ8KMO4lWSM4qXT7/qy2QeGHfRZOX/ZhDvngTlLUS/pFnbOfTfrLOfDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zlez7y3v; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso2551471e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 17:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733793164; x=1734397964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QNfRzHxDC2/cm0Ugw4yVvaaGGlerGaNvv9c6fJmImY=;
        b=Zlez7y3vrBgGhqFT7YBHZ5P0NkjVeJeXpgDNNcJdTYsnGQKDJQ5yXGpFpk1KzCCUBJ
         CenRn3+sQurePwCWTqJvt4opYyqqVZbDspfeDGATkYzxWWmtAfs0LPt0gGuNxMf6jR+7
         p77ldeRgQkI6s5OZBK4UmKAT7F2LeXcKHkB3uqn+4d2vexoeB2GmsyP8gNlO/Fb+gi8W
         TUzDfQxVMCW+8JA7Xto6g0Yc/+cINq7uuwWtRUehLbeCgGwr/q/BKoCN/dxvTTr1VziG
         f2ENFMUZZl+yGfwZInzMrZLXcB0YRWUL/UHGJBpVfE4BZ5YQGgpRjcpKI6+fXJ5E+CqN
         i4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793164; x=1734397964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QNfRzHxDC2/cm0Ugw4yVvaaGGlerGaNvv9c6fJmImY=;
        b=Eo82lCD9KqmLhW6jCYbapQdFbfBrzEOX3V0sGY9xTaoG/QUfvy9aTUuS2GQx79F6BE
         uUPS3nxPhW3BmV/1yBDZPHT6J7QQLHYtQv0den2z0+fJKbsA00q4jRG80Z8GhAHmaOt2
         gtEct2Yvjm/l979dChBBjMF1V5QfkuO05LSMw8Rp5J2qBrXSV0KwndE66ej/g+yOYcw+
         6IhX8SBiC4Au8J4TLOq+/QG0tz+WT1gKiBfQizDSYUEaMKYp7eC04ESBbiDnC2QrteNc
         BGPLUYUpL2At6vsIAmYXvHlfis2EX5Uwo0CLUUf2KJgDgVFxHvY9EPiUurOGm27SWyQr
         O/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCyfXeCZ1ZRCjvElQBOJae/xeoy3WjJ6mxSQ5xndwgr/onlsAW8jf3jVNB7Pa7HtYVsVaiNkI/2U+EEBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfR7CITyCnaml6z5AHEeV2MhvmscBNmpVpeZsyeJeKjMrRdUm
	X1f83f+XjyLsNcV5BjMlDeCE0QnOYJ94Ga4QJsYQ4sWVcuS4TV/8RTScZwHMUbg=
X-Gm-Gg: ASbGncskfWbmygTfCqbhAtRDbUkuzDvKpZviQXpOOj7GQOQ8FzlY/xscsE+ZRHaCRuV
	9PAIFnZIrccIu08xpJ3DNP9PJTOLlDpdg5VzTLQhG94MKGEOXdhxjoWDnF4IT9fmwcO7aahSK9W
	flNnQ//Ot4olcqR6qvGe/0xmhj9ABaJSZWA3yaV1yBLOwe6q06aSsGLlhr7J4n3hyfPBXCl92bV
	xokjYevk/qI3hgr6FG2QLfB7MLnYHzpG3dwFbVBB58f75WlwOqtepPnKK3snKwNlETczny8ztzh
	SfepKJ5Xic2Zrr/I/6m1/yIGhjD1Dgi0Og==
X-Google-Smtp-Source: AGHT+IFeGVhuwlz8YbbARcWMz2AW/kzh60cS9g2mSnu2qLNh4HtWzelhCxg85jSiE86SJS+2GICamQ==
X-Received: by 2002:ac2:51cd:0:b0:53d:f769:14cb with SMTP id 2adb3069b0e04-540251e571amr455241e87.9.1733793164271;
        Mon, 09 Dec 2024 17:12:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e387a42dfsm1070755e87.90.2024.12.09.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:12:42 -0800 (PST)
Date: Tue, 10 Dec 2024 03:12:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge-connector: Prioritize supported_formats
 over ycbcr_420_allowed
Message-ID: <uw7uqw6zsmoe2cyxe3mqm3ok43afut47jms37nny6ecl44b5xe@byagwnayplse>
References: <20241206-bridge-conn-fmt-prio-v2-1-85c817529b88@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-bridge-conn-fmt-prio-v2-1-85c817529b88@collabora.com>

On Fri, Dec 06, 2024 at 10:00:46PM +0200, Cristian Ciocaltea wrote:
> Bridges having the DRM_BRIDGE_OP_HDMI flag set in drm_bridge->ops are
> supposed to rely on drm_bridge->supported_formats bitmask to advertise
> the supported colorspaces, including HDMI_COLORSPACE_YUV420.  Therefore,
> the newly introduced drm_bridge->ycbcr_420_allowed flag becomes
> redundant in this particular context.
> 
> Moreover, when drm_bridge_connector gets initialised, only
> drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
> the equivalent property of the base drm_connector, which effectively
> discards the formats advertised by the HDMI bridge.

I think this should be handled in a different way: during HDMI connector
init verify that HDMI_COLORSPACE_YUV420 matches the
drm_connector->ycbcr_420_allowed value and rejects incompatible
connectors.

> Handle the inconsistency by ignoring ycbcr_420_allowed for HDMI bridges
> and, instead, make use of the supported_formats bitmask when setting up
> the bridge connector.
> 
> Additionally, ensure the YUV420 related bit is removed from the bitmask
> passed to drmm_connector_hdmi_init() when the final ycbcr_420_allowed
> flag for the connector ends up not being set (i.e. the case of having at
> least one non-HDMI bridge in the pipeline that didn't enable it).
> 
> Fixes: 3ced1c687512 ("drm/display: bridge_connector: handle ycbcr_420_allowed")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v2:
> - Wrapped HDMI_COLORSPACE_YUV420 flag in the BIT() macro to properly
>   check its presence in supported_formats
> - Ensured YUV420 gets removed from the bitmask passed to
>   drmm_connector_hdmi_init() when ycbcr_420_allowed is not set
> - Link to v1: https://lore.kernel.org/r/20241130-bridge-conn-fmt-prio-v1-1-146b663f17f3@collabora.com
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 320c297008aaa8b6ef5b1f4c71928849b202e8ac..1f05278b8683a25a845f943720c76faeed24c2e2 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -414,7 +414,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  	drm_for_each_bridge_in_chain(encoder, bridge) {
>  		if (!bridge->interlace_allowed)
>  			connector->interlace_allowed = false;
> -		if (!bridge->ycbcr_420_allowed)
> +		if (!bridge->ycbcr_420_allowed && !(bridge->ops & DRM_BRIDGE_OP_HDMI))
>  			connector->ycbcr_420_allowed = false;
>  
>  		if (bridge->ops & DRM_BRIDGE_OP_EDID)
> @@ -436,6 +436,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  
>  			if (bridge->supported_formats)
>  				supported_formats = bridge->supported_formats;
> +
> +			if (!(bridge->supported_formats & BIT(HDMI_COLORSPACE_YUV420)))
> +				connector->ycbcr_420_allowed = false;
> +
>  			if (bridge->max_bpc)
>  				max_bpc = bridge->max_bpc;
>  		}
> @@ -459,7 +463,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (bridge_connector->bridge_hdmi)
> +	if (bridge_connector->bridge_hdmi) {
> +		if (!connector->ycbcr_420_allowed)
> +			supported_formats &= ~BIT(HDMI_COLORSPACE_YUV420);
> +
>  		ret = drmm_connector_hdmi_init(drm, connector,
>  					       bridge_connector->bridge_hdmi->vendor,
>  					       bridge_connector->bridge_hdmi->product,
> @@ -468,10 +475,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  					       connector_type, ddc,
>  					       supported_formats,
>  					       max_bpc);
> -	else
> +	} else {
>  		ret = drmm_connector_init(drm, connector,
>  					  &drm_bridge_connector_funcs,
>  					  connector_type, ddc);
> +	}
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> 
> ---
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
> change-id: 20241130-bridge-conn-fmt-prio-c517c1407ed5
> 

-- 
With best wishes
Dmitry


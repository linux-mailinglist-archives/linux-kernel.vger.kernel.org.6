Return-Path: <linux-kernel+bounces-177021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9E8C388A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B96D1F216F4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C55B54BFE;
	Sun, 12 May 2024 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l4kXLLvT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535F548E3
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548640; cv=none; b=nIeoV6ULlvds2uCY7cKhABEuC0rq9nUsbaOwjifNMy0L1ka7/LjUr3AJB92APKt+qTLInWY5uThSYRU75EcrUcUm7NoJTPbtAp0cwiDlLskLfPhrYOS/KAqrn9+IeJWWGp5PiAHuzOlgkNkEGTo4UOf+iFJD+NBYJg+xkmIFJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548640; c=relaxed/simple;
	bh=MRyWWUPY5N6LugFfdbbNEPZzSMPg+lWFp0PRfAukxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijIZRAKHP3TswRCS7KGoXPVtR9XyWCUCtbI7U03M17n1pOh3o+gfUSiTHV9pYOqeaQC4wg15BZQ25Duna4TwnHQMD+lvD65g0Q8Pudras5fGauNuY5cY6wDKG5n7yFhzEE7/bwriWFh1fYPAfQH2wQfBmT/PlIk4wFTVwFQuDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=l4kXLLvT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A6D3F8BE;
	Sun, 12 May 2024 23:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548631;
	bh=MRyWWUPY5N6LugFfdbbNEPZzSMPg+lWFp0PRfAukxV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4kXLLvTYNraD7nZbEdLrEp+cO/1LSOX+35iq3WsZGSA2DXojpOb7O9qVnBBmcqFs
	 T+oVThyu9djFuOirT8U14orsl2KtnM56tpH5wBf+h53hXZAtMc6hxawk8y7k/B1R3d
	 QHY+TUGanZKNZikS/TwWU3ZS5G4v/6sQxt1bqsts=
Date: Mon, 13 May 2024 00:17:09 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx: Remove redundant checks on existence of
 bridge->encoder
Message-ID: <20240512211709.GO17158@pendragon.ideasonboard.com>
References: <20240511150816.326846-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511150816.326846-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 11:08:16PM +0800, Sui Jingfeng wrote:
> The check on the existence of bridge->encoder on the implementation layer
> of drm bridge driver is not necessary, as it has already been done in the
> drm_bridge_attach() function. It is guaranteed that the .encoder member
> of the drm_bridge instance is not NULL when various imx_xxx_bridge_attach()
> function gets called.
> 
> Remove the redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/imx/imx-ldb-helper.c         | 5 -----
>  drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c | 5 -----
>  drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c     | 5 -----
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c        | 5 -----
>  4 files changed, 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> index 6967325cd8ee..9b5bebbe357d 100644
> --- a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> +++ b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> @@ -116,11 +116,6 @@ int ldb_bridge_attach_helper(struct drm_bridge *bridge,
>  		return -EINVAL;
>  	}
>  
> -	if (!bridge->encoder) {
> -		DRM_DEV_ERROR(ldb->dev, "missing encoder\n");
> -		return -ENODEV;
> -	}
> -
>  	return drm_bridge_attach(bridge->encoder,
>  				ldb_ch->next_bridge, bridge,
>  				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> index d0868a6ac6c9..e6dbbdc87ce2 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> @@ -119,11 +119,6 @@ static int imx8qxp_pc_bridge_attach(struct drm_bridge *bridge,
>  		return -EINVAL;
>  	}
>  
> -	if (!bridge->encoder) {
> -		DRM_DEV_ERROR(pc->dev, "missing encoder\n");
> -		return -ENODEV;
> -	}
> -
>  	return drm_bridge_attach(bridge->encoder,
>  				 ch->next_bridge, bridge,
>  				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> index ed8b7a4e0e11..1d11cc1df43c 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> @@ -138,11 +138,6 @@ static int imx8qxp_pixel_link_bridge_attach(struct drm_bridge *bridge,
>  		return -EINVAL;
>  	}
>  
> -	if (!bridge->encoder) {
> -		DRM_DEV_ERROR(pl->dev, "missing encoder\n");
> -		return -ENODEV;
> -	}
> -
>  	return drm_bridge_attach(bridge->encoder,
>  				 pl->next_bridge, bridge,
>  				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> index 4a886cb808ca..fb7cf4369bb8 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> @@ -58,11 +58,6 @@ static int imx8qxp_pxl2dpi_bridge_attach(struct drm_bridge *bridge,
>  		return -EINVAL;
>  	}
>  
> -	if (!bridge->encoder) {
> -		DRM_DEV_ERROR(p2d->dev, "missing encoder\n");
> -		return -ENODEV;
> -	}
> -
>  	return drm_bridge_attach(bridge->encoder,
>  				 p2d->next_bridge, bridge,
>  				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);

-- 
Regards,

Laurent Pinchart


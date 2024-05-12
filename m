Return-Path: <linux-kernel+bounces-177024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578248C3890
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B9E1C20C4A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05745467F;
	Sun, 12 May 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RNNvYzjQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36303233
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548849; cv=none; b=Sz0INXqgEPygo3GVVnaqmO+kIVc/MADpikmt6Repkkf5RHKq0nTJvhMIiRYb4lFmFf5mGHVai3+9liEvlPiWmVXF1I3Hkw2fgNnohrS7UHTWZ06L0g6t4gQ5iNcE5hrEmFfg1yYJjzK+rfHpu1F2e6fZgH7Zv+0mwvhp6yQqJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548849; c=relaxed/simple;
	bh=IYYvknnK9tyMIPvkrRHEIHoGdP9l9/eZ68/Kr7wpv+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAi+1LnJQCTWLwoBPzbiT+bhyMsGisWZJlrOsVIaYvxVukFYuJNqKnYjd31zcWil8dNfA/HOcQJGLwlSiRLV/KITV70Z7zYPH2Isb4Ue1vzEuiIkHvdiJTjob/E/UYg5KCx0v20tNhJq028KuHKvKycK6YUlSiKYfFKFI6juXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RNNvYzjQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95FD38BE;
	Sun, 12 May 2024 23:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548840;
	bh=IYYvknnK9tyMIPvkrRHEIHoGdP9l9/eZ68/Kr7wpv+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNNvYzjQXug1DRkE6BuFngaOZSHvkHanbsF/RB7Ls1Z7jDo2P+cijEs1UoyCEyU1C
	 bqjd1aubB7jMFzvGOJXNC83LOWTJ5TdyHFHyJv+ebf7xwV7778smezW7F9yvhCLlHg
	 rPAKhpwHPpHV/SJkd0jGtSVLObWWPBM7mijIsiM0=
Date: Mon, 13 May 2024 00:20:38 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: synopsys: dw-mipi-dsi: Remove a redundant
 check on existence of bridge->encoder
Message-ID: <20240512212038.GR17158@pendragon.ideasonboard.com>
References: <20240511144713.325156-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511144713.325156-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 10:47:13PM +0800, Sui Jingfeng wrote:
> In the dw_mipi_dsi_bridge_attach() function, the check on the existence
> of bridge->encoder is not necessary, as it has already been done in the
> drm_bridge_attach() function. And the check on the drm bridge core
> happens before check in the implementation. Hence, it is guaranteed that
> the .encoder member of the struct drm_bridge is not NULL when
> dw_mipi_dsi_bridge_attach() function gets called.
> 
> Remove the redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 824fb3c65742..c4e9d96933dc 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -1071,11 +1071,6 @@ static int dw_mipi_dsi_bridge_attach(struct drm_bridge *bridge,
>  {
>  	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
>  
> -	if (!bridge->encoder) {
> -		DRM_ERROR("Parent encoder object not found\n");
> -		return -ENODEV;
> -	}
> -
>  	/* Set the encoder type as caller does not know it */
>  	bridge->encoder->encoder_type = DRM_MODE_ENCODER_DSI;
>  

-- 
Regards,

Laurent Pinchart


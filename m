Return-Path: <linux-kernel+bounces-177018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5EF8C3883
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C15B280DFE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C455E73;
	Sun, 12 May 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OVf1pBUr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67055E48
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548476; cv=none; b=HE13RUCkV7bGACplMKPBFaQ9Gw2M26+IGLHN9sEeQDZl1BtXwjuN5/ENtM+lpwGFitsTRNZJgsg4I1Z6oa0p1a+Rk9mxU1dxE682ivs5GMfV9OrMYYkPAx7CwHKXWkfwJZcEMrGOk1ZPqZb5kJi5wnZa+/NkyOIOI2wEt0sxZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548476; c=relaxed/simple;
	bh=FG6iKX2wYIDzAZO1I+hGEmxBg8st+4S4h3rD+0EIdPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itl2mPxERWIwnoAsoMQLEX2IoFuagOE67UqZ4sEz7WZ4CeVcrkw96O3LxIecXt5IpTt1mLaCBkudJpNYmgy8oJQa4K1eXzM7SE9OcWr6vYr9C7/DayiXlc4WRg8TuJ3KJigs3JyHCVxKg7y62sTOtJ6E9jWhQlsOEPlyLHvrAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OVf1pBUr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C6D38BE;
	Sun, 12 May 2024 23:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548467;
	bh=FG6iKX2wYIDzAZO1I+hGEmxBg8st+4S4h3rD+0EIdPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVf1pBUrQ3+ReIvEpXYckwu1PKGSeSbmzPcp8TgSMlMRqZyrqyT4t7PDTX8bx8+Bj
	 O5wneKOyBWUey0VJV5wTZMi1HEdsToGMSwbq1rng8Q4NmT8F/R3SrMqmea+Q75w2ww
	 gw6+tHULeVflFJl8VHtc8VB4gfsSxiJmlRzdLg5g=
Date: Mon, 13 May 2024 00:14:25 +0300
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
Subject: Re: [PATCH] drm/bridge: panel: Remove a redundant check on existence
 of bridge->encoder
Message-ID: <20240512211425.GL17158@pendragon.ideasonboard.com>
References: <20240511140316.318080-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511140316.318080-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 10:03:16PM +0800, Sui Jingfeng wrote:
> In panel_bridge_attach(), the check on the existence of bridge->encoder
> has already been done in the implementation of drm_bridge_attach(). And
> it is done before the bridge->funcs->attach hook is called. Hence, it is
> guaranteed that the .encoder member of the struct drm_bridge is not NULL
> when the panel_bridge_attach() is called.
> 
> There is no need to check the existence of bridge->encoder another time
> at the implementation layer, therefore remove the redundant checking codes
> "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/panel.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 7f41525f7a6e..762402dca6dd 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -65,11 +65,6 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>  	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>  		return 0;
>  
> -	if (!bridge->encoder) {
> -		DRM_ERROR("Missing encoder\n");
> -		return -ENODEV;
> -	}
> -
>  	drm_connector_helper_add(connector,
>  				 &panel_bridge_connector_helper_funcs);
>  

-- 
Regards,

Laurent Pinchart


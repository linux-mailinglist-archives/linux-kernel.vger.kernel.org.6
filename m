Return-Path: <linux-kernel+bounces-177023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45A8C388E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06E91F21706
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6245467F;
	Sun, 12 May 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l1krWNOQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92E3233
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548754; cv=none; b=sy0bXJH+XQhbvsUUVhL9/z05wOsVD9GbmZk5m+bLpoNc3/0kHD5EjMKj4f2kq7N8g7/Db11D2YRFpd/smvK35bjU/eH8gmKY0UaniEtj66oSQyN4Uco90dbUR+jdYlZioFt3qMvs5UYVQctTSG22wD6uyWEttF876JbWyUapK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548754; c=relaxed/simple;
	bh=W5wIChAYZ5UvL2GEo9zFX6SQxx9WytPsTIt3oj8gUuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USNdY3JhyjnzZE5CMswbXbl4+DRS7dNqIYQHi6i5YS4ksreCLuosOi3CwauKmxjnR563bk1AMtX+zWG54qbd8KWVyYL3Hsjt66pGFmd5Fq3hwNg8FdP2CGHAPA7fxNhL7dEM6WZNpUcefzAeDrEHfgd38pCIhGRz8INf2rZhQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=l1krWNOQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C355C8BE;
	Sun, 12 May 2024 23:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548746;
	bh=W5wIChAYZ5UvL2GEo9zFX6SQxx9WytPsTIt3oj8gUuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1krWNOQ04OrDPabstuawxD40jtbNzuAX7l9xF3TivsxgQSAm3byLtkF5aYL+8B9n
	 vWtl/gB8j6D4xcpFJ7QXNJ8gjgsyK63rP29wGSHp86uEyEUX8kQwmjlaJ5XSGVWQ8u
	 NxtQSKdT3XpADAw4dqeRyd8H55O5uKRRgtqT7N8g=
Date: Mon, 13 May 2024 00:19:03 +0300
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
Subject: Re: [PATCH] drm/bridge: lt9611uxc: Remove a redundant check on
 existence of bridge->encoder
Message-ID: <20240512211903.GQ17158@pendragon.ideasonboard.com>
References: <20240511145549.325852-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511145549.325852-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 10:55:49PM +0800, Sui Jingfeng wrote:
> In the lt9611uxc_connector_init() function, the check on the existence
> of bridge->encoder is not necessary, as it has already been done in the
> drm_bridge_attach() function. And the check on the drm bridge core
> happens before check in the implementation. Hence, it is guaranteed that
> the .encoder member of the struct drm_bridge is not NULL when
> lt9611uxc_connector_init() function gets called.
> 
> Remove the redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index f4f593ad8f79..f1fccfe6c534 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -339,11 +339,6 @@ static int lt9611uxc_connector_init(struct drm_bridge *bridge, struct lt9611uxc
>  {
>  	int ret;
>  
> -	if (!bridge->encoder) {
> -		DRM_ERROR("Parent encoder object not found");
> -		return -ENODEV;
> -	}
> -
>  	lt9611uxc->connector.polled = DRM_CONNECTOR_POLL_HPD;
>  
>  	drm_connector_helper_add(&lt9611uxc->connector,

-- 
Regards,

Laurent Pinchart


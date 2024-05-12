Return-Path: <linux-kernel+bounces-177025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F088C3892
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CD11F21758
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B15467F;
	Sun, 12 May 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q0Zgd6n1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B213233
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548889; cv=none; b=SN/myZc6+0PBqZNOqUPumanXO6hdX6dmMkjhm/Ht/8FLJ15IfvtQV3umX4WcGsGFYAbTxGmZKkvDgFj2/M9mZhdjn2MD1d9ZeCztVj4pNEyD1Cpydth0iT4BirN6bg5flqBNVCEMLyen9SmFhbmG4NaWomW0ixDY+XKlLPbeqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548889; c=relaxed/simple;
	bh=5liMwDMQqGwgDBOeSGRvPnrNGvH2XDVoxgQf1n5jyxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDwFywcQ04Qobs48sgE3fS+L7pcCxb4zxInOYnh87xhi+qDua9cabCY032ozaq24n4WZ/A9sRXbNgyRbqGPLL4ut59Tz0ZTKlR8aYgzUxMadjjnv4/hv24XSJAEMZ5XhNMUa6ZkAsqHj/WEluZfpJX3Ux/QuXtKPryXnpejl1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=q0Zgd6n1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9485B8BE;
	Sun, 12 May 2024 23:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548880;
	bh=5liMwDMQqGwgDBOeSGRvPnrNGvH2XDVoxgQf1n5jyxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0Zgd6n1KxI+ollROOJQX004ZWu0/657VKEUFRgLE1wZzHEWcrEfyd328HCMPuj/P
	 fvUmFwMmBzXkurYRoA/mAIzR8j3tpgvmTJFAx4ugGLHjieH2Gwc2WmAO3+7H1X8lq/
	 igBpPqeezrPMsaKbcNIHaYEkSGDMeKz1A6XAre00=
Date: Mon, 13 May 2024 00:21:18 +0300
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
Subject: Re: [PATCH] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Remove a
 redundant check on existence of bridge->encoder
Message-ID: <20240512212118.GS17158@pendragon.ideasonboard.com>
References: <20240511143820.324369-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511143820.324369-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 10:38:20PM +0800, Sui Jingfeng wrote:
> In the ge_b850v3_lvds_create_connector function, the check on the existence
> of bridge->encoder is not necessary, as it has already been done in the
> drm_bridge_attach() function. And the check on the drm bridge core
> happens before check in the implementation. Hence, it is guaranteed that
> the .encoder member of the struct drm_bridge is not NULL when
> ge_b850v3_lvds_attach() function gets called.
> 
> Remove the redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index 4480523244e4..37f1acf5c0f8 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -165,11 +165,6 @@ static int ge_b850v3_lvds_create_connector(struct drm_bridge *bridge)
>  	struct drm_connector *connector = &ge_b850v3_lvds_ptr->connector;
>  	int ret;
>  
> -	if (!bridge->encoder) {
> -		DRM_ERROR("Parent encoder object not found");
> -		return -ENODEV;
> -	}
> -
>  	connector->polled = DRM_CONNECTOR_POLL_HPD;
>  
>  	drm_connector_helper_add(connector,

-- 
Regards,

Laurent Pinchart


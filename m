Return-Path: <linux-kernel+bounces-172139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F102E8BEE04
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2F01C2328C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFE18734A;
	Tue,  7 May 2024 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eJn2f38I"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11152187343
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113303; cv=none; b=jGU5wRePOzJq1LeahkutQ927aBZ7IFB33GsKBcpOkX51GiJT169TTzM0TUjw8yE7zlITkNvcKcPcJpOm2qSnEzr10U/1J7ZH4vgZb8wSWL3Hiu8vhZe9XYoGP5bn5NUeLS+YY6+VO7iCcMbHvT2XzSUcPgVQCIPvo2v6xV9VrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113303; c=relaxed/simple;
	bh=qnFkKVTP+o//0MobSjb1ptmrlHIH+f6uJ/IOr5bJrH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt+udofr9/d1Y9MLK1xCFHeuoEJ3nQ4dh83QsT+8Nqulv6JZ9teO+dh/hOHPCcXjp/p7A5jBGn5Ea3474XGNwIn846lq1+pT/GDEZeOTlLKyjLF7hstcoMS0g86lSrmtyUj0HdFkfKpM5JZDfXQBPP+R7R+1ypNxJ6ZtXmD+c8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eJn2f38I; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD5A4DFB;
	Tue,  7 May 2024 22:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715113298;
	bh=qnFkKVTP+o//0MobSjb1ptmrlHIH+f6uJ/IOr5bJrH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJn2f38IciskKjGoUsWEFqR08CSxOqqeyhTCurgnYSb92k3fopsbbA+MhNdvgr2BA
	 yU+GR05PEhk3eMlYiLThHwGD7DTc/F/bij2tVLGupzu+Kv6Wl+lc/tnteNSk57zEJy
	 RgLYE5U+Ai8Emz6drdQafZ2rJmKJwT+/cLGThob8=
Date: Tue, 7 May 2024 23:21:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/drm-bridge.c: Drop conditionals around of_node
 pointers
Message-ID: <20240507202131.GD2012@pendragon.ideasonboard.com>
References: <20240507180001.1358816-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507180001.1358816-1-sui.jingfeng@linux.dev>

On Wed, May 08, 2024 at 02:00:00AM +0800, Sui Jingfeng wrote:
> Having conditional around the of_node pointer of the drm_bridge structure
> is not necessary, since drm_bridge structure always has the of_node as its
> member.
> 
> Let's drop the conditional to get a better looks, please also note that
> this is following the already accepted commitments. see commit d8dfccde2709
> ("drm/bridge: Drop conditionals around of_node pointers") for reference.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

It looks like this was forgotten in commit d8dfccde2709 ("drm/bridge:
Drop conditionals around of_node pointers").

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_bridge.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 30d66bee0ec6..a6dbe1751e88 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -352,13 +352,8 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	bridge->encoder = NULL;
>  	list_del(&bridge->chain_node);
>  
> -#ifdef CONFIG_OF
>  	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
>  		  bridge->of_node, encoder->name, ret);
> -#else
> -	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> -		  encoder->name, ret);
> -#endif
>  
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart


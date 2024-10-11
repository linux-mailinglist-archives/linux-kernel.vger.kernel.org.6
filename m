Return-Path: <linux-kernel+bounces-360825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1E99A03D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1040F1F2414C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBDE20CCD0;
	Fri, 11 Oct 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GoFfH3pX"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA02030A;
	Fri, 11 Oct 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639405; cv=none; b=RQEUCsec/Vl6frjdvYaEsI0JLe7yfpYkO/06SZ8z4nOq6ZqLfGqVCyfXSv0tHQ3MywUe3d68Kx6ZlIs0hPWZ3rhiz8OX49EdyU+CXWhv+nOUAQ0FKf7hIUS0Cc9LfbRN8lpkUSyyi58wbyuwFxr3sUTo9UIF0nOHOqZW2EGJudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639405; c=relaxed/simple;
	bh=iU+RjTF2OHKKaMZg6XwXqwPEfJ9ZZTGwXVAlRTh2tvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1L7SEPLIIg3lvixOWyIphzPS5XhPpcHI0909MYJLVq8n5WC7qogTL478TercauLFDiA+l2fUwbrSG8sp/rnTZhikIjnQYvfIkk1KXyDRmZxn8VnPLTqqENsVQCRi2x5c95tZvqVelRVA00BJXwGAmLT30OIxaXqmmOi/fX2eDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GoFfH3pX; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 778932000A;
	Fri, 11 Oct 2024 09:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728639400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOr1y6bkl2ESGBEAuDHnJepThp32G9brhsEAe/glmCw=;
	b=GoFfH3pXCxEQ4cP0HBtTb/GeVfzPsPexPQ9F04GQ7cdvz7gVeh6Oanb3JYxWTGyNAdK1KX
	9z7BVCEvmenpF+fYTIc7Zx4T0hkBQ6Bmc+HES5JROGHQS6OI/2wdC+5QGF7uqXey19YJv6
	Os2QsSuL1KJhpMXzLbdpflFV9HfZ6I4J9eJcEVfOAKwWZfKCdW61ggBKc2/YzhEbVnxjjG
	+dK3T7LoAUViCGsMTGz2DAoZkEKHzHmX6/SU1DI7hXlDpoNacFP6X73CGR2PHyDncpe6B9
	gABvipThp1v5nyYyolUdX5dwNhkk6WQ+zUdQWiHqKfCh2Thppou4rt7YD0jMEw==
Date: Fri, 11 Oct 2024 11:36:35 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maaara Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v12 09/15] drm/vkms: Remove useless drm_rotation_simplify
Message-ID: <Zwjxo2TEAR3PelO9@louis-chauvet-laptop>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maaara Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-9-01c1ada6fec8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-yuv-v12-9-01c1ada6fec8@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com


Hi all,

Until this point, this series has not received any major comments since 
v9. I will commit patches 1-9 next week if there are no further comments.

For patches 10-15, I am currently waiting for feedback from Maxime to 
send the next iteration with a fix for kunit tests.

Thanks,
Louis Chauvet

On 07/10/24 - 18:10, Louis Chauvet wrote:
> As all the rotation are now supported by VKMS, this simplification does
> not make sense anymore, so remove it.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 8875bed76410..5a028ee96c91 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>  	frame_info->fb = fb;
>  	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
>  	drm_framebuffer_get(frame_info->fb);
> -	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
> -									  DRM_MODE_ROTATE_90 |
> -									  DRM_MODE_ROTATE_270 |
> -									  DRM_MODE_REFLECT_X |
> -									  DRM_MODE_REFLECT_Y);
> -
> +	frame_info->rotation = new_state->rotation;
>  
>  	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
>  }
> 
> -- 
> 2.46.2
> 


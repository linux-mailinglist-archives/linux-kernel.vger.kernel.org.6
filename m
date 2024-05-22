Return-Path: <linux-kernel+bounces-186434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD3C8CC422
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414041F24B76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2213D60A;
	Wed, 22 May 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lbaO7fln"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4157811E9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391925; cv=none; b=BgwMsDfK+pRYay3dWg0GqBl6TNv7THg6zFhF4PkLC4B1RTv/JL1il1a2pXuCRMRSjlCj3QSz3orDEPqwGmy7brZ+hHN6s1i+6ciJugAOCYgO/uLvj/9g6G35awl8FbNPmz81IcfM4L834pOycVZg0TUWvFjx65715d0SY2CmR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391925; c=relaxed/simple;
	bh=3osedL4iCLeNFkMsPPLEDVo5aE+WG8KSP7dzZMbevEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uscy2Fdlk6hq1tXpjL1SrS2kTr1bAr2VIt/TYYIHn58BfEFU5yC8vNtB/zJ1QQF512rvrJ7pqaiw0xInYlEyffK6cCgbyVvVShwbQsXl+SE4rusYYV/MQqTk7X3lsCPVqSOYmdiV8SrSdC6v+iSnn/WkLailqlPJYsTCHMbNyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lbaO7fln; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9392DC67;
	Wed, 22 May 2024 17:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716391908;
	bh=3osedL4iCLeNFkMsPPLEDVo5aE+WG8KSP7dzZMbevEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbaO7flnIi4BGgU3rEwJGHHVz1UzS/K8diJEkbMx+XFmBhp7anHWM9h5A9UAeDI5U
	 zOErv3TDgTT5OiepgqzrVMNruJUYjLUQdpvfvi6n9UcpRS4f6bOGXk6V9qkdnKiYeX
	 CFD18xO4OffVl+8E34px8cWbnhQIc4qnF712KyMw=
Date: Wed, 22 May 2024 18:31:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: Enable plane in atomic update
Message-ID: <20240522153151.GB9789@pendragon.ideasonboard.com>
References: <20240520-dp-layer-enable-v1-1-c9b481209115@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240520-dp-layer-enable-v1-1-c9b481209115@amd.com>

Hi Anatoliy,

Thank you for the patch.

On Mon, May 20, 2024 at 08:22:31PM -0700, Anatoliy Klymenko wrote:
> Unconditionally enable the DPSUB layer in the corresponding atomic plane
> update callback. Setting the new display mode may require disabling and
> re-enabling the CRTC. This effectively resets DPSUB to the default state
> with all layers disabled.

Ah, I went through the code and I see that. Oops.

> The original implementation of the plane atomic
> update enables the corresponding DPSUB layer only if the framebuffer
> format has changed. This would leave the layer disabled after switching to
> a different display mode with the same framebuffer format.

Do we need a Fixes: tag or has this issue been there since the beginning
?

> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_kms.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> index 43bf416b33d5..c4f038e34814 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> @@ -120,9 +120,8 @@ static void zynqmp_dpsub_plane_atomic_update(struct drm_plane *plane,
>  		zynqmp_disp_blend_set_global_alpha(dpsub->disp, true,
>  						   plane->state->alpha >> 8);
>  
> -	/* Enable or re-enable the plane if the format has changed. */
> -	if (format_changed)
> -		zynqmp_disp_layer_enable(layer);
> +	/* Enable or re-enable the plane. */
> +	zynqmp_disp_layer_enable(layer);

This should be safe for now, as the function will just write the plane
registers with identical values. The waste of CPU cycles may not be a
big issue, even if it would be best to avoid it.

What bothers me more is that we may be working around a larger problem.
Resetting the CRTC when disabling it affects the hardware state of the
whole device, and thus the state of all software DRM objects. The
hardware and software states lose sync. Maybe this patch is all that is
needed for now, but other similar issues could pop up in the future.

Would it be possible, at atomic check time, to detect the objects whose
hardware state will need to be synced, and marked that in their state ?
Then in zynqmp_dpsub_plane_atomic_update() you could re-enable the layer
based on that. You may need to subclass the drm_plane_state if there's
no field in that structure that is suitable to store the information.
The format_changed local variable would move there.

>  }
>  
>  static const struct drm_plane_helper_funcs zynqmp_dpsub_plane_helper_funcs = {
> 
> ---
> base-commit: 673087d8b023faf34b84e8faf63bbeea3da87bab
> change-id: 20240520-dp-layer-enable-7b561af29ca8

-- 
Regards,

Laurent Pinchart


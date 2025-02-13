Return-Path: <linux-kernel+bounces-513891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9DA34FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30070188682F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698B271282;
	Thu, 13 Feb 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ioaBjtSc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66005271263
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479567; cv=none; b=ht0O70uUSVuwJVRV/4iLjn9j4fishJuIfu66w9/cna2nxfQzeK63FX21VNSJRQ26Ic+BoJ5Tmb5+09WnsEtCzOSCamSCqh3bIzs5zBtXEadBqqy+gcItepMCSDy5APt1ciEbtqyhXnvRvey2bHua1jDljlAS3hOo1PxpBDs5vwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479567; c=relaxed/simple;
	bh=OGxeZxl9MlwMBKkNj3NJO7s7b1UlFvhoi6keYgIvf9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIz/EedBCbZkJO+IGNBEEGx/CWYBmp9+QKr8zgPVB1HoOfCvIKEfe2SNcEGnQC2jf+/BHgzkWUFvgQtFU8zrppaYopYDFGWBWZqK6WcIHMso207eigS20cyJG3nihnUQKcVGoSNAQeSSPvaHkBxNjVVp7MwKw6qYz3k/vZWs79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ioaBjtSc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 06597166A;
	Thu, 13 Feb 2025 21:44:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739479482;
	bh=OGxeZxl9MlwMBKkNj3NJO7s7b1UlFvhoi6keYgIvf9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioaBjtSc7MDjGl3dQR4Kx1hSh/TmsnvJdmvkucmS7hSHcLNjqz6y9wJXSQNQp2RWW
	 EmEtkCGUsvGEvw8rIONwKz2DREMybjg7g5d/hB+VODfHp8ReodmB1ydGjGLuW/K3l1
	 yCpN7crRSLCe7EELvwuZMOAgOK1HLKawU20L2xCo=
Date: Thu, 13 Feb 2025 22:45:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 07/11] drm: xlnx: zynqmp: Use drm helpers when
 calculating buffer sizes
Message-ID: <20250213204549.GC22998@pendragon.ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-7-90d0fe106995@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212-xilinx-formats-v3-7-90d0fe106995@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Feb 12, 2025 at 04:56:11PM +0200, Tomi Valkeinen wrote:
> Use drm helpers, drm_format_info_plane_width(),
> drm_format_info_plane_height() and drm_format_info_min_pitch() to
> calculate sizes for the DMA.
> 
> This cleans up the code, but also makes it possible to support more
> complex formats (like XV15, XV20).
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 80d1e499a18d..3d4ade571f0f 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -1116,16 +1116,18 @@ int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
>  		return 0;
>  
>  	for (i = 0; i < info->num_planes; i++) {
> -		unsigned int width = state->crtc_w / (i ? info->hsub : 1);
> -		unsigned int height = state->crtc_h / (i ? info->vsub : 1);
>  		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
>  		struct dma_async_tx_descriptor *desc;
> +		unsigned int width, height;

I'd got with one variable per line.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  		dma_addr_t dma_addr;
>  
> +		width = drm_format_info_plane_width(info, state->crtc_w, i);
> +		height = drm_format_info_plane_height(info, state->crtc_h, i);
> +
>  		dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, i);
>  
>  		dma->xt.numf = height;
> -		dma->sgl.size = width * info->cpp[i];
> +		dma->sgl.size = drm_format_info_min_pitch(info, i, width);
>  		dma->sgl.icg = state->fb->pitches[i] - dma->sgl.size;
>  		dma->xt.src_start = dma_addr;
>  		dma->xt.frame_size = 1;

-- 
Regards,

Laurent Pinchart


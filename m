Return-Path: <linux-kernel+bounces-353899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDB993427
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971C5B237F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714201DC725;
	Mon,  7 Oct 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hvsJOJ6E"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B51DC040
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319882; cv=none; b=KltcCcviH1EPWK+1TlgibCkSE0fDzYDPL8LfPrmWZGBoKD0cwJrJrwgEIDQPcepuO9y/DEgWy6r7tSpczAOzXFYMLtqSKIOHGR7F2+101yo5Cr8T3P9/3plEa+migHjwssceEKbsdW8Kvktzie/5xfrK9t0pYqr47VnHy1YxfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319882; c=relaxed/simple;
	bh=uJKVVbnpPdVU5dbEIsKt8mYPh1IhVs6NNbTa0IGyKGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0VsA270nEhMImsdhL7F/JfPozPKgCZ2pbLr/fIL1boH/xW9J088b8lFfypbeDwrA2U2GVVDzFuIRVNECNAqP7ZZyh19NjCwECNb3jYWNYjyFa5t2l8cji9N/O8uuAr3VcwuwUSS4KfSiV4CBkPtkwthVPCQim70G8Mf31tquZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hvsJOJ6E; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62C81E0006;
	Mon,  7 Oct 2024 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRZMTR1n/c5WTha8acx2XuOAYRFLJCXcobXPAU05IwM=;
	b=hvsJOJ6EE7PFjP9GabrrJ0wgvzPInnhglw+nh/p+QObBGGFDXpE6riy8SnHUQ62h/ZkJ8J
	Og1zSCK6QfGbE0S/D4zxkYUGmN2SKX7mRRFtAsyc8juD3b93dq8FjsYNMdWQt7yq1gSSh0
	GA30FDbxOuf2pxzvFZcEspTpL2Ay01nZt3Ek3ksk/VZYlP7SpMqSX+8y0L/zysT89l/Ed+
	MmG1LfvqX1vU2b9EDdb1dXxNwcAKZsXOEJcrbxBatUAyoTxOjXO5NIOCkV3KtFL9D8Hr/R
	2/fzAlSuZPfkB4ZdrDn2rKE5WlvUVFkbvFg4JQjGMjH5MD6JX3xNvvS1TBaxKw==
Date: Mon, 7 Oct 2024 18:51:16 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Paz Zcharya <pazz@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paz Zcharya <pazz@google.com>,
	David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Maaara Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: Add support for ABGR8888 pixel format
Message-ID: <ZwQRhKHZuK4AgWuy@fedora>
Mail-Followup-To: Paz Zcharya <pazz@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, Paz Zcharya <pazz@google.com>,
	David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Maaara Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
References: <20241007142814.4037157-1-pazz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007142814.4037157-1-pazz@google.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 07/10/24 - 14:27, Paz Zcharya wrote:
> Add support for pixel format ABGR8888, which is the default format
> on Android devices. This will allow us to use VKMS as the default
> display driver in Android Emulator (Cuttlefish) and increase VKMS
> adoption.

Hi Paz,

Thank you for your contribution!

I am very happy to see new users for VKMS, and I will be glad to add new 
formats to VKMS!

However, as you can see [1], there is a significant rework of the VKMS 
formats and composition that should be merged soon.

This series introduces two key improvements: performance enhancements and 
YUV support. These changes involve substantial modifications to the 
vkms_format.c file, which may conflict with your work.

Additionally, I wrote a few patches [2] and [3] a few months ago to 
practice with VKMS, and they did not receive any comments, so I believe I 
will be able to merge them quickly after [1].

In [2], I added many new formats: ABGR, BGRA, RGBA, XBGR, RGBX, BGRX, 
BGR565, P010, P012, P016. 
Would you mind testing this version to see if it meets your needs?

In [3], I did similar work for writeback, but it is not as complete, so I 
need to add a patch, almost identical to your code:

	static void argb_u16_to_ABGR8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
		[...]

Added:	WRITE_LINE(XBGR8888_write_line, argb_u16_to_XBGR8888)

I need to send a v2 of [3] anyway because of conflicts, do you mind if I 
take your argb_u16_to_ABGR8888 to integrate it (with your signed-off-by 
obviously)?

In any case, if you have time to test, or even better review [1], [2] or 
[3], it could be amazing!

Thank you,
Louis Chauvet

[1]:https://lore.kernel.org/all/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com/
[2]:https://lore.kernel.org/all/20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com/
[3]:https://lore.kernel.org/all/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com/

> Signed-off-by: Paz Zcharya <pazz@chromium.org>
> ---
> 
>  drivers/gpu/drm/vkms/vkms_formats.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_plane.c     |  1 +
>  drivers/gpu/drm/vkms/vkms_writeback.c |  1 +
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 040b7f113a3b..9e9d7290388e 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -73,6 +73,14 @@ static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
>  	out_pixel->b = (u16)src_pixels[0] * 257;
>  }
>  
> +static void ABGR8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> +{
> +	out_pixel->a = (u16)src_pixels[3] * 257;
> +	out_pixel->b = (u16)src_pixels[2] * 257;
> +	out_pixel->g = (u16)src_pixels[1] * 257;
> +	out_pixel->r = (u16)src_pixels[0] * 257;
> +}
> +
>  static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>  {
>  	__le16 *pixels = (__force __le16 *)src_pixels;
> @@ -176,6 +184,14 @@ static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
>  	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
>  }
>  
> +static void argb_u16_to_ABGR8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> +{
> +	dst_pixels[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
> +	dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
> +	dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
> +	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
> +}
> +
>  static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>  {
>  	__le16 *pixels = (__force __le16 *)dst_pixels;
> @@ -234,6 +250,8 @@ void *get_pixel_conversion_function(u32 format)
>  		return &ARGB8888_to_argb_u16;
>  	case DRM_FORMAT_XRGB8888:
>  		return &XRGB8888_to_argb_u16;
> +	case DRM_FORMAT_ABGR8888:
> +		return &ABGR8888_to_argb_u16;
>  	case DRM_FORMAT_ARGB16161616:
>  		return &ARGB16161616_to_argb_u16;
>  	case DRM_FORMAT_XRGB16161616:
> @@ -252,6 +270,8 @@ void *get_pixel_write_function(u32 format)
>  		return &argb_u16_to_ARGB8888;
>  	case DRM_FORMAT_XRGB8888:
>  		return &argb_u16_to_XRGB8888;
> +	case DRM_FORMAT_ABGR8888:
> +		return &argb_u16_to_ABGR8888;
>  	case DRM_FORMAT_ARGB16161616:
>  		return &argb_u16_to_ARGB16161616;
>  	case DRM_FORMAT_XRGB16161616:
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index e5c625ab8e3e..8efd585fc34c 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -15,6 +15,7 @@
>  static const u32 vkms_formats[] = {
>  	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ABGR8888,
>  	DRM_FORMAT_XRGB16161616,
>  	DRM_FORMAT_ARGB16161616,
>  	DRM_FORMAT_RGB565
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index bc724cbd5e3a..04cb9c58e7ad 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -17,6 +17,7 @@
>  static const u32 vkms_wb_formats[] = {
>  	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ABGR8888,
>  	DRM_FORMAT_XRGB16161616,
>  	DRM_FORMAT_ARGB16161616,
>  	DRM_FORMAT_RGB565
> -- 
> 2.47.0.rc0.187.ge670bccf7e-goog
> 


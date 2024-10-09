Return-Path: <linux-kernel+bounces-356555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DD39962F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D361F262FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107EE18E052;
	Wed,  9 Oct 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M0qDHa0N"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D118DF75
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462805; cv=none; b=peqAx6lZljmW/2PK/KMtq2JtN1wf7a/ix5g9A6jvtUvxjfOxvPNAp/YnKLCcB5Iwo+HSvkUwh1KeC4HkTO23Pa/hxybbJcR5I+e78wrcdFjCC70ld37AH6bPm2DJQy4hdUcCYZGghvPjmT90tMAQ6LpWHc/rBYRCJKeI43UY1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462805; c=relaxed/simple;
	bh=Ryf35tvfF83VDaPTIrZxmZNZ3OrsFQJrFUI5iLLRkIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k18FnWDGJTw82q8+x8mPE7Rg8koeJnpV/m8TBJwYt2cee29ycRSG5gGVb0WCKML0/OOhJ4zU06e3AnVOFKtL+97Exp4/mvFHLl97/dfeZCUZASH/RM5fTsis44S0bs9aqBK41FyBEiBNXPGProMFcupCGuhz1EtzPSOPfIqCrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M0qDHa0N; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4583083d019so44711501cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728462802; x=1729067602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnxUKUa13w6tl42fc3nnF2dJEBWkq6juB+0sXuyGbc0=;
        b=M0qDHa0N+q+jSE9tMWuRCJmduE2ZnqSAU7tGpNi5O5/bsVcwdZBZmWdzaZ7Haf61ex
         kfugQ1LEQSX1YT6eahH70j4wVgwK5LscN7EGhho0rhn6xeOL73MZS5vE5+si0Hut0cJN
         2edurFSAHbcCrXG+YV+9fZzy5LlIBiBoZbTPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462802; x=1729067602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnxUKUa13w6tl42fc3nnF2dJEBWkq6juB+0sXuyGbc0=;
        b=YdAKR7F83AcoDhJh2+g1KrfPUBlzmuCVIZgz7JvznIqswFWiWgg+NbMc/HEhJhjIca
         kjqaHSlstRM1KiCzIAwf9ku3QH0yNQFjJKgcNma/axVXnbyI1LJQyW8cHo09ptYZH9+L
         IzbetjUxwrK3CJeo+0AVdV9E+V58Sf6K0e8qQOZTTuqTjHdwxXW7W4f9+S/RbLA1Kyhl
         7RL8XVd4Ggkj181PnThsX7xUypEqUPZREuJae7KMb4LwOhZ6qiQfkec0Bag4DcbuUO3O
         ubw3OfBpIJtta1f1ybAKlxKw3XAGRYlDlet9zBg9vDWJ0v0R5v5EkDlLAsbqG/vIOjkg
         vNnA==
X-Gm-Message-State: AOJu0YwjV87LGUr3sK5hPbjILAjgdIbVI5Xn5zCOHwwQgpRs+l07fYrw
	37mvDPTU4B21bxJ6xY2ffT0r3mGTf8bu2cRvBMBTqbqBqWa7755DIhXLzVITDA==
X-Google-Smtp-Source: AGHT+IGrtcW5X9UCaKvtPP8MDxfWOnVzjW0YyKKeEVN2RHVfP/cLidzTH7KTA/WBR2DMJagUDfTRQQ==
X-Received: by 2002:a05:6214:3b86:b0:6cb:8339:3443 with SMTP id 6a1803df08f44-6cbc942fdd0mr28167736d6.7.1728462802142;
        Wed, 09 Oct 2024 01:33:22 -0700 (PDT)
Received: from google.com (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cde41sm44169356d6.14.2024.10.09.01.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:33:21 -0700 (PDT)
Date: Wed, 9 Oct 2024 08:33:20 +0000
From: Paz Zcharya <pazz@chromium.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@gmail.com>,
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
Message-ID: <ZwY_0H-NWm_cHI0K@google.com>
References: <20241007142814.4037157-1-pazz@google.com>
 <ZwQRhKHZuK4AgWuy@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQRhKHZuK4AgWuy@fedora>

On Mon, Oct 07, 2024 at 06:51:16PM +0200, Louis Chauvet wrote:
> On 07/10/24 - 14:27, Paz Zcharya wrote:
> > Add support for pixel format ABGR8888, which is the default format
> > on Android devices. This will allow us to use VKMS as the default
> > display driver in Android Emulator (Cuttlefish) and increase VKMS
> > adoption.
> 
> Hi Paz,
> 
> Thank you for your contribution!
> 
> I am very happy to see new users for VKMS, and I will be glad to add new 
> formats to VKMS!
> 
> However, as you can see [1], there is a significant rework of the VKMS 
> formats and composition that should be merged soon.
> 
Thank you for highlighting this. Great work!

> This series introduces two key improvements: performance enhancements and 
> YUV support. These changes involve substantial modifications to the 
> vkms_format.c file, which may conflict with your work.
> 
> Additionally, I wrote a few patches [2] and [3] a few months ago to 
> practice with VKMS, and they did not receive any comments, so I believe I 
> will be able to merge them quickly after [1].
> 
> In [2], I added many new formats: ABGR, BGRA, RGBA, XBGR, RGBX, BGRX, 
> BGR565, P010, P012, P016. 
> Would you mind testing this version to see if it meets your needs?
> 
Yep, this is perfect!

> In [3], I did similar work for writeback, but it is not as complete, so I 
> need to add a patch, almost identical to your code:
> 
> 	static void argb_u16_to_ABGR8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
> 		[...]
> 
> Added:	WRITE_LINE(XBGR8888_write_line, argb_u16_to_XBGR8888)
> 
> I need to send a v2 of [3] anyway because of conflicts, do you mind if I 
> take your argb_u16_to_ABGR8888 to integrate it (with your signed-off-by 
> obviously)?
> 
Yeah, that would be very helpful. Thank you so much!

> In any case, if you have time to test, or even better review [1], [2] or 
> [3], it could be amazing!
> 
Patches look great. I tested them locally after adding ABGR8888
support, and things seem to be working.

Let me know if I can assist you with anything else.

Thanks,
Paz Zcharya
> Thank you,
> Louis Chauvet
> 
> [1]:https://lore.kernel.org/all/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com/
> [2]:https://lore.kernel.org/all/20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com/
> [3]:https://lore.kernel.org/all/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com/
> 
> > Signed-off-by: Paz Zcharya <pazz@chromium.org>
> > ---
> > 
> >  drivers/gpu/drm/vkms/vkms_formats.c   | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/vkms/vkms_plane.c     |  1 +
> >  drivers/gpu/drm/vkms/vkms_writeback.c |  1 +
> >  3 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 040b7f113a3b..9e9d7290388e 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -73,6 +73,14 @@ static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
> >  	out_pixel->b = (u16)src_pixels[0] * 257;
> >  }
> >  
> > +static void ABGR8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> > +{
> > +	out_pixel->a = (u16)src_pixels[3] * 257;
> > +	out_pixel->b = (u16)src_pixels[2] * 257;
> > +	out_pixel->g = (u16)src_pixels[1] * 257;
> > +	out_pixel->r = (u16)src_pixels[0] * 257;
> > +}
> > +
> >  static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> >  {
> >  	__le16 *pixels = (__force __le16 *)src_pixels;
> > @@ -176,6 +184,14 @@ static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
> >  	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
> >  }
> >  
> > +static void argb_u16_to_ABGR8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> > +{
> > +	dst_pixels[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
> > +	dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
> > +	dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
> > +	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
> > +}
> > +
> >  static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> >  {
> >  	__le16 *pixels = (__force __le16 *)dst_pixels;
> > @@ -234,6 +250,8 @@ void *get_pixel_conversion_function(u32 format)
> >  		return &ARGB8888_to_argb_u16;
> >  	case DRM_FORMAT_XRGB8888:
> >  		return &XRGB8888_to_argb_u16;
> > +	case DRM_FORMAT_ABGR8888:
> > +		return &ABGR8888_to_argb_u16;
> >  	case DRM_FORMAT_ARGB16161616:
> >  		return &ARGB16161616_to_argb_u16;
> >  	case DRM_FORMAT_XRGB16161616:
> > @@ -252,6 +270,8 @@ void *get_pixel_write_function(u32 format)
> >  		return &argb_u16_to_ARGB8888;
> >  	case DRM_FORMAT_XRGB8888:
> >  		return &argb_u16_to_XRGB8888;
> > +	case DRM_FORMAT_ABGR8888:
> > +		return &argb_u16_to_ABGR8888;
> >  	case DRM_FORMAT_ARGB16161616:
> >  		return &argb_u16_to_ARGB16161616;
> >  	case DRM_FORMAT_XRGB16161616:
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index e5c625ab8e3e..8efd585fc34c 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -15,6 +15,7 @@
> >  static const u32 vkms_formats[] = {
> >  	DRM_FORMAT_ARGB8888,
> >  	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_ABGR8888,
> >  	DRM_FORMAT_XRGB16161616,
> >  	DRM_FORMAT_ARGB16161616,
> >  	DRM_FORMAT_RGB565
> > diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> > index bc724cbd5e3a..04cb9c58e7ad 100644
> > --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> > +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> > @@ -17,6 +17,7 @@
> >  static const u32 vkms_wb_formats[] = {
> >  	DRM_FORMAT_ARGB8888,
> >  	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_ABGR8888,
> >  	DRM_FORMAT_XRGB16161616,
> >  	DRM_FORMAT_ARGB16161616,
> >  	DRM_FORMAT_RGB565
> > -- 
> > 2.47.0.rc0.187.ge670bccf7e-goog
> > 


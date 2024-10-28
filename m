Return-Path: <linux-kernel+bounces-384588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8AF9B2BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439EEB219CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8F1D89EF;
	Mon, 28 Oct 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W6aQO6tI"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDA1D5CDB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109051; cv=none; b=LofLBX/M7IHDr2yrGPD0nRqKg0fu+P4m3THLK5/jf7xMwruxr0owDTLfaMJmwyjjA67e3VlHZb6IvL3H89wivsv7FcWO9gKruTfWODGWoCUG1JJad/qgisS0gkIFu0s9i5mQBcG7PUYJs4AGoMpgSblryqHXEfMAZYZYodvbSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109051; c=relaxed/simple;
	bh=gQYfa5S6EEe5LDjgzisqxSHHIBKU04vASPdUL5a04ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1MyCFEzNL5m1SsosfV3XrmaHwMhesMrmJ4mOg/6hfxI5Zh1hc8WMhbau2jNJ3mdyAmnwih5eLex6rnDjt8KOt5DimblOyKMh+IDC3cyFzaq01VPN+0G/uh2WeA7I5rmRtWe+CsnbxtwQHLA7jOI8GfysxwM5OmkP1Bw/x8xuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W6aQO6tI; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B9FF1C0006;
	Mon, 28 Oct 2024 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeaOMU1TZIhIRYQ0x1moayff8wABo4up92bIIy3XXRs=;
	b=W6aQO6tI46OHCFqyHWD8hWHzWAdWXb2/R+GKXVlXM8fCybdcDK7H92P0HGSvGwhFerZzv2
	pOFhc6elvWm+QZxoe5sjaxAxMdQ5XVKiFYw5uBYoX9Rezg1aUL32juzhcye7kevGnTsNxQ
	0VYtFZke6fB0jeqKNeJQn7CvU3gEZ0j1s23lNpDCMOYxCMaq+TMH0CjIAkl8KM4eam8AJK
	8f/u3vda02F90WxEWFSI9C64Xy5aFqWUdjiyKOsOCLNTAx8zeh2uml4xSa9TOC6r8g9caI
	kqAmx4j0IxRpRoWpVyHcmiTS2h1baay7qTE859fVsSj7dCUimAbMW0iMua+DJQ==
Date: Mon, 28 Oct 2024 10:50:39 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
Subject: Re: [PATCH RESEND v2 4/8] drm/vkms: Add support for RGB565 formats
Message-ID: <Zx9eby4wpmnYPc7Y@fedora>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
References: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
 <20241007-b4-new-color-formats-v2-4-d47da50d4674@bootlin.com>
 <63f0bf12-4df8-48d1-b8c8-2ed27a860937@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63f0bf12-4df8-48d1-b8c8-2ed27a860937@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 11:17, Maíra Canal wrote:
> Hi Louis,
> 
> On 07/10/24 13:46, Louis Chauvet wrote:
> > The format RGB565 was already supported. Add the support for:
> > - BGR565
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_formats.c | 25 ++++++++++++++++++++++++-
> >   drivers/gpu/drm/vkms/vkms_plane.c   |  1 +
> >   2 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index c03a481f5005..e34bea5da752 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -249,7 +249,7 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
> >   	return out_pixel;
> >   }
> > -static struct pixel_argb_u16 argb_u16_from_gray8(u16 gray)
> > +static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
> 
> Again, fix the issue in the patch that introduce it.

Will do for the v2!

Thanks,
Louis Chauvet
 
> Best Regards,
> - Maíra
> 
> >   {
> >   	return argb_u16_from_u8888(255, gray, gray, gray);
> >   }
> > @@ -259,6 +259,26 @@ static struct pixel_argb_u16 argb_u16_from_grayu16(u16 gray)
> >   	return argb_u16_from_u16161616(0xFFFF, gray, gray, gray);
> >   }
> > +static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
> > +{
> > +	struct pixel_argb_u16 out_pixel;
> > +
> > +	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> > +	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> > +
> > +	u16 rgb_565 = le16_to_cpu(*pixel);
> > +	s64 fp_b = drm_int2fixp((rgb_565 >> 11) & 0x1f);
> > +	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
> > +	s64 fp_r = drm_int2fixp(rgb_565 & 0x1f);
> > +
> > +	out_pixel.a = (u16)0xffff;
> > +	out_pixel.b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
> > +	out_pixel.g = drm_fixp2int_round(drm_fixp_mul(fp_g, fp_g_ratio));
> > +	out_pixel.r = drm_fixp2int_round(drm_fixp_mul(fp_r, fp_rb_ratio));
> > +
> > +	return out_pixel;
> > +}
> > +
> >   VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> >   							    const struct conversion_matrix *matrix)
> >   {
> > @@ -447,6 +467,7 @@ READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0])
> >   READ_LINE_16161616(XBGR16161616_read_line, px, 0xFFFF, px[0], px[1], px[2])
> >   READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
> > +READ_LINE(BGR565_read_line, px, __le16, argb_u16_from_BGR565, px)
> >   READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
> > @@ -668,6 +689,8 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
> >   		return &XBGR16161616_read_line;
> >   	case DRM_FORMAT_RGB565:
> >   		return &RGB565_read_line;
> > +	case DRM_FORMAT_BGR565:
> > +		return &BGR565_read_line;
> >   	case DRM_FORMAT_NV12:
> >   	case DRM_FORMAT_NV16:
> >   	case DRM_FORMAT_NV24:
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index 1e971c7760d9..a243a706459f 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -26,6 +26,7 @@ static const u32 vkms_formats[] = {
> >   	DRM_FORMAT_ARGB16161616,
> >   	DRM_FORMAT_ABGR16161616,
> >   	DRM_FORMAT_RGB565,
> > +	DRM_FORMAT_BGR565,
> >   	DRM_FORMAT_NV12,
> >   	DRM_FORMAT_NV16,
> >   	DRM_FORMAT_NV24,
> > 


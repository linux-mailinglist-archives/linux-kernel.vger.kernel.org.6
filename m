Return-Path: <linux-kernel+bounces-384578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218949B2BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441781C21FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A01D079F;
	Mon, 28 Oct 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f8jaX2Sf"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299B1CC890
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109043; cv=none; b=UDYeXqzC0L9oevJwAn1b/eSCIXoXML1hib+YPtPjOiHqHe8MW2xh+EY0khGEXHHm6CzvkWyEZAmoXiaidZ3Tk2RZiI7rwDd5XCe9Di5iz+r4D+86A3+TXbITHvt6q6RXOW74gQCJhQe7qKQCuI/L4nbYL3kRKXDua2Lo9DqMU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109043; c=relaxed/simple;
	bh=eg5NddVvSS9tONraIxzxM9y4kKPiQ3XdvqW+Ci40mrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0Yv5+ECUM3qi+NkUz+B6nDTy3zreIQTTybLyi6sBAH98KiHL3J6sEWf9L295LndzTi4PSAHxX9nPC9y4KnH8e6084vBgJjyftM3D4DjJpQKSTuKdBuCy80zaSy4P8R/YVWHMpuI60vLM6TjZNnPt67XyfmzpwVMjp0EnvOpytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f8jaX2Sf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79FAF60007;
	Mon, 28 Oct 2024 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fi6pq1NACgWnfMa0+CNbK0vFieEFrjbAN/bOLYefu4M=;
	b=f8jaX2Sfp9dwpsG5JUXlrHJGU3snaYBsr8HmAW/8KtTBRFMWZ5QKXB38oc2pfmN9wIxOQs
	YS0LAA4LKHNXP8vWIkxPhqCK4QsXDYlT494jKapS5EcxvsvHF2xWeBxPVleFBFR0cL8/UN
	LssiVoCTMWWZHe0y8tn9S+/e5pZQRuVEVGt7AjdGMgyZSZSXLUTkB1hiGMk6BkowkNcLBZ
	u1AOGKBEgbweXpoaHAeEP/5oIzPftZBinZjNU25XmBj2Rqn3s+qqUyHKkpmX+79MqLMu7t
	+cVfPRB0Z38fJAX4V/MWsjUs/2VpTrlwVNXq3jgv3U3FiG01vv5s9bayJHZ6JQ==
Date: Mon, 28 Oct 2024 10:50:37 +0100
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
Subject: Re: [PATCH RESEND v2 5/8] drm/vkms: Add support for RGB888 formats
Message-ID: <Zx9ebXIlkCAKz52F@fedora>
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
 <20241007-b4-new-color-formats-v2-5-d47da50d4674@bootlin.com>
 <53d04022-7199-4880-9b41-1ee7abdad997@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53d04022-7199-4880-9b41-1ee7abdad997@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 11:51, Maíra Canal wrote:
> Hi Louis,
> 
> On 07/10/24 13:46, Louis Chauvet wrote:
> > Add the support for:
> > - RGB888
> > - BGR888
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_formats.c | 7 +++++++
> >   drivers/gpu/drm/vkms/vkms_plane.c   | 2 ++
> >   2 files changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index e34bea5da752..2376ea8661ac 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -461,6 +461,9 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
> >   READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
> >   READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
> > +READ_LINE_ARGB8888(RGB888_read_line, px, 255, px[2], px[1], px[0])
> > +READ_LINE_ARGB8888(BGR888_read_line, px, 255, px[0], px[1], px[2])
> > +
> >   READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
> >   READ_LINE_16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2])
> >   READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0])
> > @@ -679,6 +682,10 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
> >   		return &RGBX8888_read_line;
> >   	case DRM_FORMAT_BGRX8888:
> >   		return &BGRX8888_read_line;
> > +	case DRM_FORMAT_RGB888:
> > +		return RGB888_read_line;
> 
> Shouldn't it be &RGB888_read_line?

According to [1], &function, function, ***function are understood the 
same by gcc.

But this is ugly and I will change to use & everywhere, thanks!

[1]:https://stackoverflow.com/questions/6893285/why-do-function-pointer-definitions-work-with-any-number-of-ampersands-or-as

Thanks,
Louis Chauvet
 
> > +	case DRM_FORMAT_BGR888:
> > +		return BGR888_read_line;
> 
> Same.
> 
> Best Regards,
> - Maíra
> 
> >   	case DRM_FORMAT_ARGB16161616:
> >   		return &ARGB16161616_read_line;
> >   	case DRM_FORMAT_ABGR16161616:
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index a243a706459f..0fa589abc53a 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -21,6 +21,8 @@ static const u32 vkms_formats[] = {
> >   	DRM_FORMAT_XBGR8888,
> >   	DRM_FORMAT_RGBX8888,
> >   	DRM_FORMAT_BGRX8888,
> > +	DRM_FORMAT_RGB888,
> > +	DRM_FORMAT_BGR888,
> >   	DRM_FORMAT_XRGB16161616,
> >   	DRM_FORMAT_XBGR16161616,
> >   	DRM_FORMAT_ARGB16161616,
> > 


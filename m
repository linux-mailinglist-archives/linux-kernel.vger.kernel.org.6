Return-Path: <linux-kernel+bounces-384585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6819B2BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2701C21F53
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A111CF2AB;
	Mon, 28 Oct 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bTjVV2dS"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDA1D1E96
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109048; cv=none; b=MYvAk3NI7xxgkpxONrrX06HoGOBpP9btyqHWfM71l4sA+ZzdwL69DTyOnskA8WEs+szpkWVuBV7Uv6NDhGVh3ZVZ5jpMkxd3VC/8EBzKHeP7uhYmtuU5kfPyIRQkkX7epl8G+aJpJRq55lYYuHVQIpvDMHjVUBTgVzi6XN+T2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109048; c=relaxed/simple;
	bh=MUv/eoYLTVm8wi9mfQ5KccHtJLiu1kqyuab9XlAz7cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHT+JkgnUipdxdffaWmt9MmZ0bhNnqZR5ZbSCreBuN+MtAKd7mNY3/QLnYbE/vZdZLia/L37ERETrvRngR/W6CHbrQ9Zc9aXhlnwfotPO9zhqn+1X4zh2ma/ATmcRS+qGroC4+Olu5Jap4FSpG5WoKegqSpdYh03tOszRueNbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bTjVV2dS; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B0C2E0002;
	Mon, 28 Oct 2024 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbdtTtCcCk9RaJY1Kj8VuSOKAfBOoXQ8tDcw4QSkt3I=;
	b=bTjVV2dSpZucobWmf1h9UsPM1359PHCJ3CONTkTqaXtV5nVfmOpmcPAyLo5V/U2+OSSGYq
	iNX22mlAwRU8NNSU3YNHB0+O3DGjU9Dn4ZPWzzPZk8AOFjltty9XHg3NlV2YX/Ut4UpBfr
	Tc8HWIzdzf+fceT4eVottkGiUKO3qlOjoFPqiugk2qcSZJ1li7/TjpYqXQeZ1ZlBKmwDqD
	jZMaXBA0OPrcLAExD1i/aMDPZ8Wp/CD7itf0ekOhre/0rgYdRExOoAVCnt0HHNLweh3oez
	fUAoRX2ojsm5U2zkZK9vZmBhTZk0ZuFUdDni5pJlcDZBeiVINznqzXv0HERJqg==
Date: Mon, 28 Oct 2024 10:50:34 +0100
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
Subject: Re: [PATCH RESEND v2 2/8] drm/vkms: Add support for ARGB8888 formats
Message-ID: <Zx9eateq0ylJGvS_@fedora>
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
 <20241007-b4-new-color-formats-v2-2-d47da50d4674@bootlin.com>
 <40c85513-6c57-4b9c-87f6-2ca56c556462@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40c85513-6c57-4b9c-87f6-2ca56c556462@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 11:11, Maíra Canal wrote:
> Hi Louis,
> 
> On 07/10/24 13:46, Louis Chauvet wrote:
> > The formats XRGB8888 and ARGB8888 were already supported.
> > Add the support for:
> > - XBGR8888
> > - RGBX8888
> > - BGRX8888
> > - ABGR8888
> > - RGBA8888
> > - BGRA8888
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_formats.c | 18 ++++++++++++++++++
> >   drivers/gpu/drm/vkms/vkms_plane.c   |  6 ++++++
> >   2 files changed, 24 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 8f1bcca38148..b5a38f70c62b 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -432,8 +432,14 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
> >   READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
> > +READ_LINE_ARGB8888(XBGR8888_read_line, px, 255, px[0], px[1], px[2]) > +READ_LINE_ARGB8888(RGBX8888_read_line, px, 255, px[3], px[2], px[1])
> 
> I'm not expert in colors, but is this correct? From what I understand,
> it should be:

Yes, this is correct, READ_LINE_ARGB8888 take the parameters as A, R, G, 
B, so here 0xFF, px[2], px[1], px[0]
 
> READ_LINE_ARGB8888(RGBX8888_read_line, px, px[2], px[1], px[0], 255)
>                                            ^R     ^G     ^B     ^X
> 
> > +READ_LINE_ARGB8888(BGRX8888_read_line, px, 255, px[1], px[2], px[3])
> 
> Again, is this correct?
>
> Best Regards,
> - Maíra
> 
> >   READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
> > +READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
> > +READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
> > +READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
> >   READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
> > @@ -637,8 +643,20 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
> >   	switch (format) {
> >   	case DRM_FORMAT_ARGB8888:
> >   		return &ARGB8888_read_line;
> > +	case DRM_FORMAT_ABGR8888:
> > +		return &ABGR8888_read_line;
> > +	case DRM_FORMAT_BGRA8888:
> > +		return &BGRA8888_read_line;
> > +	case DRM_FORMAT_RGBA8888:
> > +		return &RGBA8888_read_line;
> >   	case DRM_FORMAT_XRGB8888:
> >   		return &XRGB8888_read_line;
> > +	case DRM_FORMAT_XBGR8888:
> > +		return &XBGR8888_read_line;
> > +	case DRM_FORMAT_RGBX8888:
> > +		return &RGBX8888_read_line;
> > +	case DRM_FORMAT_BGRX8888:
> > +		return &BGRX8888_read_line;
> >   	case DRM_FORMAT_ARGB16161616:
> >   		return &ARGB16161616_read_line;
> >   	case DRM_FORMAT_XRGB16161616:
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index 67f891e7ac58..941a6e92a040 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -14,7 +14,13 @@
> >   static const u32 vkms_formats[] = {
> >   	DRM_FORMAT_ARGB8888,
> > +	DRM_FORMAT_ABGR8888,
> > +	DRM_FORMAT_BGRA8888,
> > +	DRM_FORMAT_RGBA8888,
> >   	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_XBGR8888,
> > +	DRM_FORMAT_RGBX8888,
> > +	DRM_FORMAT_BGRX8888,
> >   	DRM_FORMAT_XRGB16161616,
> >   	DRM_FORMAT_ARGB16161616,
> >   	DRM_FORMAT_RGB565,
> > 


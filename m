Return-Path: <linux-kernel+bounces-180928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B533B8C74FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3081F2448D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4170145355;
	Thu, 16 May 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BkWzfcQ7"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915D143747
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857673; cv=none; b=sSGC/lIpwIVKgKyfmCfNuk4ljo16ms/PlGnQ4vZ5ID0Xq0XbUFslkc51ek9UYjTwP0pAwnqH6DQhouF//nEhJBdpAGbv+Pu4pu4dwzuSsRW12MBTEfViIajzayMoLswYuXv7C2hNl2DT0KcpwWghBiNX1dbih2FquZztjv+kRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857673; c=relaxed/simple;
	bh=9gqLELpHR2tt/0FJipOBxt4jbmFVHB33Z58NxCkuqmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox4ghR7mmU4FxndY1/zvSYVIV0IH6agQoddJxQdo/Bn38LB8K4EaVkSrk6MLKQhHyNRYn+IUFUUFsJVy+usXqcalGb50SPsWXHaXkCyvTzf1GPFe+xndpszx0D42RPKXyDZHoNZQj/6mAVox/x1eijKOBlCY5TAg9Ku1EYaZPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BkWzfcQ7; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B1ECE0003;
	Thu, 16 May 2024 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715857662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPzwo8GURkKv057NaSVRyjsaXMP54tiK1Z3Jjq48Yh8=;
	b=BkWzfcQ7jwfOAqnwEdzMCpV9fr07ChPRZSb7kTF/ShveC6Dx+b9FkN0yLPVQN3cfp+LBeK
	zSXaZ2OSQHX/Cutzewl1nFTcmBEx9Wjae8YPyZA6jSYOzXNPTtAg2W7HKOWiUk8h8dhO2e
	RBb9ur7Pk80QXoKNTVB0888jsFMaO9OyecR7Aku7dMpewKrKseU6h6g8XScCIiXR+95hd0
	P709tiRf4nf7+V/ocl/QqXM9Ou8y2EyUwDh1LoGnlQaq1XJI/c3Vf/D/a0yaCqaQPg7/h0
	lURTKtaMZAcWLEiBK0gbp6CBJHJxoA2tPbzO8TcamimWXhMlVLBPag5scD003w==
Date: Thu, 16 May 2024 13:07:36 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v7 11/17] drm/vkms: Remove useless drm_rotation_simplify
Message-ID: <ZkXo-CSQwErOYQX9@localhost.localdomain>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
 <20240513-yuv-v7-11-380e9ffec502@bootlin.com>
 <c83255f4-745e-43e6-98e0-2e89c31d569a@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c83255f4-745e-43e6-98e0-2e89c31d569a@igalia.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 16/05/24 - 07:43, Maíra Canal a écrit :
> Hi Louis,
> 
> On 5/13/24 04:50, Louis Chauvet wrote:
> > As all the rotation are now supported by VKMS, this simplification does
> > not make sense anymore, so remove it.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> I'd like to push all commits up to this point to drm-misc-next. Do you
> see a problem with it? Reason: I'd like Melissa to take a look at the
> YUV patches and patches 1 to 11 fix several composition errors.
> 
> Let me know your thoughts about it.

Hi,

This version is missing performance numbers and one fix from Pekka, so 
please don't merge v7.

I will push a v8 today (if I have the time to fetch all the performance 
numbers), with the performance numbers and the fix.

Thanks,
Louis Chauvet

> Best Regards,
> - Maíra
> 
> > ---
> >   drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
> >   1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index 8875bed76410..5a028ee96c91 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
> >   	frame_info->fb = fb;
> >   	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
> >   	drm_framebuffer_get(frame_info->fb);
> > -	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
> > -									  DRM_MODE_ROTATE_90 |
> > -									  DRM_MODE_ROTATE_270 |
> > -									  DRM_MODE_REFLECT_X |
> > -									  DRM_MODE_REFLECT_Y);
> > -
> > +	frame_info->rotation = new_state->rotation;
> >   
> >   	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
> >   }
> > 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


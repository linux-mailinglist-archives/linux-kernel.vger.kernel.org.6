Return-Path: <linux-kernel+bounces-347923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C183F98E04C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8047A282F88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2071D1304;
	Wed,  2 Oct 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OdJC7C1U"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF31940B0;
	Wed,  2 Oct 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885526; cv=none; b=Uzv2JMPxOWOAm2u+Kj9NgRPuP1zt7MLei3Mdas5Gne0mKRH78lMycGzr7nsKrdpBXwD5t51RyZUdc0z97gVkm52QMY8X3rD7o5LRk18USjrg8ltWwlS2Ih80LHtDFN+O6fWZBc8J67oGSriA70Arm3/T8boSK7uP1j7TtIXeQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885526; c=relaxed/simple;
	bh=NQ7dqyhAYAqkH0hxLTpCFpNIb7wXeshyn7k8LqySt6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRJ0NMVXmPy0NP5AHXMXcDIqgV2NepiV3wWbFTgDv3XDYUJb1LeEzHAcK7ZqWUestxVa2fW8Wx5bWek4JnOtP/Csuc3VlclQZPD3AECHDO9wpOi5GbZ/js+4JKrwxVTNvXqiWRhRcYCJiTDrz8+lZ8X7o4TQTbPSWG75f97k/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OdJC7C1U; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 709461BF207;
	Wed,  2 Oct 2024 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z+dMCKpcaMRVlGjanl5ywtRCtMH81yJkm6jVM3c7Ysc=;
	b=OdJC7C1U1OGJX0MSJSmoEWjtNtlDlQsrgRbFk2tRiplu4pq+8S+0ITI8viGzHCPrJqbT6R
	UoiSS9XinySKbML9/D1JnNa1EB7TUQOvU3JiH2B5ZKd3w+waobQnxjkbnX23Ma/7sTQ7br
	SOSCgdO4AAQMWRAvyg4a+1QqVwqi7uiKa2EGhVaIpEZ9xxKf6u7zZPSydzMqAHKOqt4Kl3
	prQOT4vlMO/LR+aQFyncvJVvKm6EwIeodiDem8dAOrMLbKmuYZi75eBrSGEJO1ZLGiBuNC
	GLHjAtX6nKhYUnyn1JAOktTd1/yfeTuHFUFFv984ZkjuzqPvC2nd24Lnfwa6mQ==
Date: Wed, 2 Oct 2024 18:11:59 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maaara Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, arthurgrillo@riseup.net,
	pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v11 06/15] drm/vkms: Avoid computing blending limits
 inside pre_mul_alpha_blend
Message-ID: <Zv1wz-TNT36McwXp@louis-chauvet-laptop>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maaara Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, arthurgrillo@riseup.net,
	pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
 <20240930-yuv-v11-6-4b1a26bcfc96@bootlin.com>
 <30573f5a-d3dd-4aa4-ac5a-cf6df77b79dc@infradead.org>
 <Zv0LBo8OtRHJM029@louis-chauvet-laptop>
 <509aa67d-5bfa-4f37-aae6-ce3786e35596@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509aa67d-5bfa-4f37-aae6-ce3786e35596@infradead.org>
X-GND-Sasl: louis.chauvet@bootlin.com

On 02/10/24 - 08:49, Randy Dunlap wrote:
> Hi Louis,
> 
> On 10/2/24 1:57 AM, Louis Chauvet wrote:
> > On 01/10/24 - 20:54, Randy Dunlap wrote:
> >> Hi--
> >>
> >> On 9/30/24 8:31 AM, Louis Chauvet wrote:
> >>> The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
> >>> different concepts (coordinate calculation and color management), extract
> >>> the x_limit and x_dst computation outside of this helper.
> >>> It also increases the maintainability by grouping the computation related
> >>> to coordinates in the same place: the loop in `blend`.
> >>>
> >>> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> >>> ---
> >>>  drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++-------------------
> >>>  1 file changed, 19 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> >>> index 931e214b225c..4d220bbb023c 100644
> >>> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> >>> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> >>> @@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
> >>>  
> >>>  /**
> >>>   * pre_mul_alpha_blend - alpha blending equation
> >>> - * @frame_info: Source framebuffer's metadata
> >>>   * @stage_buffer: The line with the pixels from src_plane
> >>>   * @output_buffer: A line buffer that receives all the blends output
> >>> + * @x_start: The start offset
> >>> + * @pixel_count: The number of pixels to blend
> >>
> >> so is this actually pixel count + 1; or
> >>
> >>>   *
> >>> - * Using the information from the `frame_info`, this blends only the
> >>> - * necessary pixels from the `stage_buffer` to the `output_buffer`
> >>> - * using premultiplied blend formula.
> >>> + * The pixels 0..@pixel_count in stage_buffer are blended at @x_start..@x_start+@pixel_count in
> >>
> >> should these ranges include a "- 1"?
> >> Else please explain.
> > 
> > Hi Randy,
> > 
> > For the next version, I will use standard mathematical notation to clarify 
> > the "inclusiveness" of the interval: [0;pixel_count[
> 
> Hm, I can read that after a second or two.
> 
> My math classes always used:  [0,pixel_count)
> for that range, and that is what most of the internet says as well.

I'm french, and we use ]a;b[ notation at school :-)

Both are valids according to ISO80000-2, but I will change it for the next 
revision.
 
> or you could just stick with
>   The pixels from 0 through @pixel_count - 1 in stage_buffer are blended at @x_start
>   through @x_start through @x_start + @pixel_count - 1.
> 
> but after writing all of that, I think using range notation is better.

I also prefer ranges, way shorter to write, and easier to understand at 
first sight. 

> thanks.


Return-Path: <linux-kernel+bounces-347197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA6F98CF59
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A16287610
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F55198836;
	Wed,  2 Oct 2024 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fymJGdAi"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E6197A7B;
	Wed,  2 Oct 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859469; cv=none; b=CA7OW9lkbA3aK8CcpPlr5DDAqugeY/5NOXPM1yjTXOefT39+OwPiXfALM/fs4K8J49wZv9w5xjfAEaHVeGL0yEr5/V+CaQtYWvYjoDfOzoNCHX+BGASA73RtoLbkqcV/loiSvqtvd3aZY7O56PhEWQ2UBTJuezlIvQ/2R+G3fjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859469; c=relaxed/simple;
	bh=DLpshHk5ianUTjQTNJYW4mvpc6wkWwDfCMubRuj2RZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsK2AiyzF8rh3NVFQ6vonJPIfDXgoAz0rdIyGj/PkNtWT7PTWqkpLBe6LoML/2Nj3gT/oiYghlzva0eWY/dYBYMUCbS6mjR+XTzlvTcTBSrupIBZzo4xN4MEBjplN/sTHjVToKKx8F5z2Q3lQcGHnF0+nC2iuUe4tzov3lc2mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fymJGdAi; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87469240002;
	Wed,  2 Oct 2024 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727859465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=38iADGjAlQ+R0YlTGLDUaomdoi9nXjm7ob6OZct28gE=;
	b=fymJGdAiSXGnPND7ldeS8HDljOKYrQ5BSbA5J8Q57lRICPwVT0uel8ByC2SX5UA+eb7EWA
	oDGFPZYXTZH1WwHgYLBUFMRceMDUcbK3S7mXglBpko2jC2AXiCgDMo8M55xb3M91rNkQR0
	e2uwgGRleJaMTyQY9IsAykS0chymyJsVGhMMkg23FcxkAdIj9RH6HALQigjFLwxLSphra+
	OyXCiZaIrqgwMiwEzMT3YkoiufMYuqwIY8+AZpEfzgmLAxthFLS7CQQ8KGw+y9lLiFo4fT
	GblWfyqFUrtLwnGvGHSToTpHcQ069l3O84hgLOddzu7EzbcDf7YZ8WhRj17AWw==
Date: Wed, 2 Oct 2024 10:57:42 +0200
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
Message-ID: <Zv0LBo8OtRHJM029@louis-chauvet-laptop>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30573f5a-d3dd-4aa4-ac5a-cf6df77b79dc@infradead.org>
X-GND-Sasl: louis.chauvet@bootlin.com

On 01/10/24 - 20:54, Randy Dunlap wrote:
> Hi--
> 
> On 9/30/24 8:31 AM, Louis Chauvet wrote:
> > The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
> > different concepts (coordinate calculation and color management), extract
> > the x_limit and x_dst computation outside of this helper.
> > It also increases the maintainability by grouping the computation related
> > to coordinates in the same place: the loop in `blend`.
> > 
> > Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index 931e214b225c..4d220bbb023c 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
> >  
> >  /**
> >   * pre_mul_alpha_blend - alpha blending equation
> > - * @frame_info: Source framebuffer's metadata
> >   * @stage_buffer: The line with the pixels from src_plane
> >   * @output_buffer: A line buffer that receives all the blends output
> > + * @x_start: The start offset
> > + * @pixel_count: The number of pixels to blend
> 
> so is this actually pixel count + 1; or
> 
> >   *
> > - * Using the information from the `frame_info`, this blends only the
> > - * necessary pixels from the `stage_buffer` to the `output_buffer`
> > - * using premultiplied blend formula.
> > + * The pixels 0..@pixel_count in stage_buffer are blended at @x_start..@x_start+@pixel_count in
> 
> should these ranges include a "- 1"?
> Else please explain.

Hi Randy,

For the next version, I will use standard mathematical notation to clarify 
the "inclusiveness" of the interval: [0;pixel_count[

Thanks,
Louis Chauvet
 
> > + * output_buffer.
> 


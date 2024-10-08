Return-Path: <linux-kernel+bounces-354890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18507994424
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4571C23108
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0EC15B12F;
	Tue,  8 Oct 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TOrGLOgZ"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E25762D2;
	Tue,  8 Oct 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379411; cv=none; b=os8vOA8InbcEbKtp4H5wVGIcmGfPuu6izxGsjYI8euf/I2NJYpQ4zZxrDC/9ux6OwjI5TsAJig30AVd7aINFXU9ZmM2EkqVOgmqluh1Nah/lRiWReAsfIPwgTLkA3zmjSzsfZWuUsEvGzcpfnbEKiLz0mBnAshlnJVyLIttW30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379411; c=relaxed/simple;
	bh=NpUeqk0ogRvN7pN4/dg+vnbZUOUv3txbjWs5a9eDpTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX1IBIkQohhgxlY+5m3EaakHNKFHjBUQgYcQwkqyhfRDaXdhkE7jO/XaccgVumViISbnHwPLphQIFWRzUDfLLnu6Cm9GPlYzBhz/dzee1HoEPNhZ81XPHcPv02IXgYliGuXykG8gwKFW0L9zHbg+9M+3Q/W7VQ5XPQ5QhjKZdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TOrGLOgZ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECAED40009;
	Tue,  8 Oct 2024 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728379405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4aRvABwDkeC3buxJWP1DSdNmC41HRG0mMSMai6hCo0=;
	b=TOrGLOgZNKppyNFh82S3g+skZpzMX92a7kFUxZ6z10guzlPby2MAHCiu+evrNfVmBq+GU8
	iE7spZxbx0A9zFkQWn3oS6k6ueuH5MqjfL01p9TpxDTLocbOpuvrJ5k4T++mfE1jH+5Nvt
	gx3MEbffhJkU/+5dgA92GhmvjTcohrr/o5nGH0bgSXHiXySvvQrxggE/KEPrzhEP1glI3P
	3njdntGZKLQe6Xol9vYrlbzWjsgohFH/rb83xlT6yUNOdcntC9R7nayzcih86xeneBaFkN
	Xzy0qWhRCS4+aLtJ0fDT80oICzobKYJ9xPl2EddvqRfamCjkIUyRX9g5XeJQ1Q==
Date: Tue, 8 Oct 2024 11:23:22 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maaara Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v12 13/15] drm/vkms: Create KUnit tests for YUV
 conversions
Message-ID: <ZwT6CnyYRKS9QxIS@louis-chauvet-laptop>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maaara Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>
 <20241008-ingenious-calm-silkworm-3e99ba@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-ingenious-calm-silkworm-3e99ba@houat>
X-GND-Sasl: louis.chauvet@bootlin.com


Hi, 

> > + * The YUV color representation were acquired via the colour python framework.
> > + * Below are the function calls used for generating each case.
> > + *
> > + * For more information got to the docs:
> > + * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_YCbCr.html
> > + */
> > +static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
> > +	/*
> > +	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
> > +	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
> > +	 *                     in_bits = 16,
> > +	 *                     in_legal = False,
> > +	 *                     in_int = True,
> > +	 *                     out_bits = 8,
> > +	 *                     out_legal = False,
> > +	 *                     out_int = True)
> > +	 */
> 
> We should really detail what the intent and expected outcome is supposed
> to be here. Relying on a third-party python library call for
> documentation isn't great.
> 
> Maxime

This was requested by Pekka in the [v2] of this series.

I can add something like this before each tests, but I think having the 
exact python code used may help people to understand what should be the 
behavior, and refering to the python code to understand the conversion.

I can add something like this before each tests to clarify the tested 
case:

	Test cases for conversion between YUV BT601 limited range and 
	RGB using the ITU-R BT.601 weights.

Or maybe just documenting the structure yuv_u8_to_argb_u16_case:

	@encoding: Encoding used to convert RGB to YUV
	@range: Range used to convert RGB to YUV
	@n_colors: Count of test colors in this case
	@format_pair.name: Name used for this color conversion, used to 
			   clarify the test results
	@format_pair.rgb: RGB color tested
	@format_pair.yuv: Same color as @format_pair.rgb, but converted to 
			  YUV using @encoding and @range.

What do you think?

Thanks,
Louis Chauvet

[v2]:https://lore.kernel.org/all/20240229141238.51891cad.pekka.paalanen@collabora.com/
[v5]:https://lore.kernel.org/all/20240328152631.63af0e8c.pekka.paalanen@collabora.com/


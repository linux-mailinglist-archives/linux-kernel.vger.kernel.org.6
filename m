Return-Path: <linux-kernel+bounces-361292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 770BF99A659
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD878B23B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF55219CBE;
	Fri, 11 Oct 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k4Gr/qNY"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B38219C91;
	Fri, 11 Oct 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656973; cv=none; b=TYG2nVlcfrENv8oXrManYIMWLmDfiWh/j7MJCRx9t/alnSeQWVHl3/CzeS3uP5L3cJe7962AqizcRQGg7Yr6xx640hMjzIcVYr5q56repDtxQ5sLA0QWLkY0L/7o8KtyEHo3JhkqXMZT2xV6qcAogfAFosgjAnIYRThq0+tLwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656973; c=relaxed/simple;
	bh=eASTqqWN/RbwvBq6aSE6zKDgJt8fvUtaBJXivcUldxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFj7yWqGPDUfUXVqone2YPS02P1Vr5HbPZY2HU8/CvyCj0abYlHkh+YiYXGhA7zaaqydSuUZHnTyl+kEh3bQEKkEk7hq+u1b8B4bm9CtjNM58set21EYUkX/aTV6By9tFXT26G9aLDV3jd3AQqInH5o91t/3BTsCCCauls1Ru8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k4Gr/qNY; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92379E0002;
	Fri, 11 Oct 2024 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728656968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxooFsfSP5WcF10uZh9IA27LMTRQH7j6L0q8CNYDpNM=;
	b=k4Gr/qNYHdODpez3/DCHZupSvlEjfo3N4RAaY2HahSkuKqldVKtl7BPPO0MxrtN+LPZ7EA
	5Gyf6RhX+P9oR4YAZAl8jWTRWAjKTgrZvnwx3nENZKDgfVIHsht1LUiaUXostuQ6NvKCkK
	WcJ8nS4pmpvqKlBglmcfPAjOMKNKdG299UNBOGJmEe8f+j10Tn9ijloFpvcKup2pwaYujJ
	AOwLMi0Wk80drqgtOTS6j6tSft0exOSpgYuj7bnQYi3OTsrSm6+kKCYzOEpzpzaamOBmTP
	oLcfBeSUbuWOvQ/bhMTGyS8YGWRzFIHsSER4FwQW5Tvi1wesvYIoa1md7cxCzQ==
Date: Fri, 11 Oct 2024 16:29:25 +0200
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
Message-ID: <Zwk2RSgfV75LVLpR@louis-chauvet-laptop>
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
 <ZwT6CnyYRKS9QxIS@louis-chauvet-laptop>
 <20241011-shiny-skua-of-authority-998ad3@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-shiny-skua-of-authority-998ad3@houat>
X-GND-Sasl: louis.chauvet@bootlin.com

On 11/10/24 - 12:49, Maxime Ripard wrote:
> On Tue, Oct 08, 2024 at 11:23:22AM GMT, Louis Chauvet wrote:
> > 
> > Hi, 
> > 
> > > > + * The YUV color representation were acquired via the colour python framework.
> > > > + * Below are the function calls used for generating each case.
> > > > + *
> > > > + * For more information got to the docs:
> > > > + * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_YCbCr.html
> > > > + */
> > > > +static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
> > > > +	/*
> > > > +	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
> > > > +	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
> > > > +	 *                     in_bits = 16,
> > > > +	 *                     in_legal = False,
> > > > +	 *                     in_int = True,
> > > > +	 *                     out_bits = 8,
> > > > +	 *                     out_legal = False,
> > > > +	 *                     out_int = True)
> > > > +	 */
> > > 
> > > We should really detail what the intent and expected outcome is supposed
> > > to be here. Relying on a third-party python library call for
> > > documentation isn't great.
> >
> > This was requested by Pekka in the [v2] of this series.
> 
> Ok.
> 
> > I can add something like this before each tests, but I think having the 
> > exact python code used may help people to understand what should be the 
> > behavior, and refering to the python code to understand the conversion.
> 
> Help, sure. Be the *only* documentation, absolutely not.
> 
> Let's turn this around. You run kunit, one of these tests fail:
> 
>  - It adds cognitive load to try to identify and make sense of an
>    unknown lib.
> 
>  - How can we check that the arguments you provided there are the one
>    you actually wanted to provide, and you didn't make a typo?
> 
> > I can add something like this before each tests to clarify the tested 
> > case:
> > 
> > 	Test cases for conversion between YUV BT601 limited range and 
> > 	RGB using the ITU-R BT.601 weights.
> > 
> > Or maybe just documenting the structure yuv_u8_to_argb_u16_case:
> > 
> > 	@encoding: Encoding used to convert RGB to YUV
> > 	@range: Range used to convert RGB to YUV
> > 	@n_colors: Count of test colors in this case
> > 	@format_pair.name: Name used for this color conversion, used to 
> > 			   clarify the test results
> > 	@format_pair.rgb: RGB color tested
> > 	@format_pair.yuv: Same color as @format_pair.rgb, but converted to 
> > 			  YUV using @encoding and @range.
> > 
> > What do you think?
> 
> That it's welcome, but it still doesn't allow to figure out what your
> intent was with this test 2 years from now.

I don't really understand what you want to add. Can you explain what you 
expect here? Did you mean you want a description like this above the test 
function?

/*
 * vkms_format_test_yuv_u8_to_argb_u16 - Testing the conversion between YUV
 * colors to ARGB colors in VKMS
 *
 * This test will use the functions get_conversion_matrix_to_argb_u16 and
 * argb_u16_from_yuv888 to convert YUV colors (stored in
 * yuv_u8_to_argb_u16_cases) into ARGB colors.
 *
 * As there is a different range between YUV input (8 bits) and RGB output (16
 * bits), the values are not checked exactly but ensured that they are within
 * the uncertainty range.
 */

Thanks,
Louis Chauvet

> Maxime




Return-Path: <linux-kernel+bounces-186448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB38CC450
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4141F212E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A36EB5D;
	Wed, 22 May 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MijpRaPT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201D28EA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392741; cv=none; b=e5UQIdP8AFJKAZJSNJrn/VJG0WmBelzuEQEvMF1hlJXnyexnwbaIDtfHttPnVTCDTDWsHk2ul/0VgHFadJpsbJ8FE/y7wuGvyBecFw5+jO3U7NvFHcUeOE4e0b9K90c7Gd3g0Cr+a/k4E6r1fcwzLTP6xPUWwsQNr0Jg1b6F8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392741; c=relaxed/simple;
	bh=fKcCOsO4NNeLFnYkRnTn7t5xMARBcbBgiNAr8ZKdLj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcStWWEJkuYJjPjvxks3Jhwbhl6jQ23AjrQBC4R6cAOb3X+7H2WEEFpTD0wV3h2u8PstiXDMfVEy8yW1qZRZ0Yrdg2pJ4GZYaFHWe6+6Pmx41W4QEw4tUn+SipXTYP9PTiR/b2BB/p5iPOyD84nHX6ECrEmMOHETHa9jawn1xsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MijpRaPT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2F18C67;
	Wed, 22 May 2024 17:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716392724;
	bh=fKcCOsO4NNeLFnYkRnTn7t5xMARBcbBgiNAr8ZKdLj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MijpRaPT8SEi4hN1+goFLDZp29Rl64oVy52jvnwYBbNG1gSWCelpwX0I1L0v/KWOX
	 uRYejZOU9lAcj/oTXVden6YncFRkhkw/iLwfgjVehN+C1I1X2f7eTJhvfIXFlkmVW9
	 mpk4YubWRGNL1QoVux3OPtH4ILlCGnvlFh22WmE8=
Date: Wed, 22 May 2024 18:45:28 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, michal.simek@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Subject: Re: [PATCH] drm: xlnx: zynqmp_disp: Fix WARN_ON build warning
Message-ID: <20240522154528.GA15832@pendragon.ideasonboard.com>
References: <20240521142814.32145-2-palmer@rivosinc.com>
 <20240522144401.GA9789@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522144401.GA9789@pendragon.ideasonboard.com>

On Wed, May 22, 2024 at 05:44:02PM +0300, Laurent Pinchart wrote:
> Hi Palmer,
> 
> (CC'ing Anatoliy)
> 
> Thank you for the patch.
> 
> On Tue, May 21, 2024 at 07:28:15AM -0700, Palmer Dabbelt wrote:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> > 
> > Without this I get warnings along the lines of
> > 
> >     drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
> >       949 |         if (WARN_ON(!layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
> >           |                     ^            ~~
> >     arch/s390/include/asm/bug.h:54:25: note: expanded from macro 'WARN_ON'
> >        54 |         int __ret_warn_on = !!(x);                      \
> >           |                                ^
> >     drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: note: add parentheses after the '!' to evaluate the comparison first
> >     drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: note: add parentheses around left hand side expression to silence this warning
> > 
> > which get promoted to errors in my test builds.  Adding the suggested
> > parens elides those warnings.
> 
> I think this should have
> 
> Fixes: b0f0469ab662 ("drm: xlnx: zynqmp_dpsub: Anounce supported input formats")
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202405080553.tfH9EmS8-lkp@intel.com/
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> > I couldn't find a patch for this in Linus' tree or on the lists, sorry
> > if someone's already fixed it.  No rush on my end, I'll just stash this
> > in a local branch for the tester.
> > ---
> >  drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > index 13157da0089e..d37b4a9c99ea 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > @@ -981,7 +981,7 @@ u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
> >  	unsigned int i;
> >  	u32 *formats;
> >  
> > -	if (WARN_ON(!layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
> > +	if (WARN_ON((!layer->mode) == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
> 
> That doesn't seem right. layer->mode isn't a boolean, it's an enum. The
> right fix seems to be
> 
> 	if (WARN_ON(layer->mode != ZYNQMP_DPSUB_LAYER_NONLIVE)) {
> 
> Anatoliy, could you check this ? Palmer, do you plan to submit a new
> version of the patch, or should I send the right fix separately ?

I see a fix is already present in the drm-misc-fixes branch. Please
ignore my previous e-mail.

> >  		*num_formats = 0;
> >  		return NULL;
> >  	}

-- 
Regards,

Laurent Pinchart


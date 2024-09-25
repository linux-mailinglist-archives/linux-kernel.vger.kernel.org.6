Return-Path: <linux-kernel+bounces-339426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC549864ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878001F252B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED53446DC;
	Wed, 25 Sep 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p1BvZ1VZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3073A1BA
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282175; cv=none; b=I6eJPjE9ERlr4iCJtL0yi8Yxdnxy8lUtBFUCudeEAKOMlMR/t6kkMUq59XlZlwo5g7n92Dx8S3Pr6bSDZwlR/5flDEDqyoHMQ6AO+ZipgFLNdi/q7tcEKmYIAlnzrHUUwXzmxwICfxcg3BHe2OioxoIsNwkTTXQmv2JEQumeEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282175; c=relaxed/simple;
	bh=w8SJ75PMeCgEFuEGe+d801zRh1FiK0RxpW5UvU9+MMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9YTsGBIAFBMT3TJDjW7dTfwcxzdXJtYvVC51qauSKk66931vPmwIhy9V2p9OqlIDw9YQWWuZnseSklA/3/XP5GeWgkwLlVLP4Iyrrx/BaSXoRhIpnEpvYohsTQeRHF/fOdj1iPGTmfSyfZ+P7+KEkJottgBLD5WN66T+GqUVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=p1BvZ1VZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 375C77E2;
	Wed, 25 Sep 2024 18:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1727282084;
	bh=w8SJ75PMeCgEFuEGe+d801zRh1FiK0RxpW5UvU9+MMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1BvZ1VZU8NqNvU4usiN0aUF0oWWNqsE/HUYKw+oINfkcwWDuPYJo/XVySWlz4lNN
	 MmR+tDYjMazIuUVgltKcW5gCKH4zq7BVExqxHdlM5tIDhMRFgSW3ReEjP7iqb4EwbB
	 dFn7qKR2uWG7q7solOzlcCDPjRfIqn0pMe+0Vv34=
Date: Wed, 25 Sep 2024 19:36:09 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: also call
 drm_helper_hpd_irq_event
Message-ID: <20240925163609.GD27666@pendragon.ideasonboard.com>
References: <20240923074803.10306-1-lists@steffen.cc>
 <20240924184335.GJ30551@pendragon.ideasonboard.com>
 <e4626c1d3b28613d1d219c735bcd8525be0f0d9e.camel@dirkwinkel.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4626c1d3b28613d1d219c735bcd8525be0f0d9e.camel@dirkwinkel.cc>

Hi Steffen,

On Wed, Sep 25, 2024 at 09:54:18AM +0200, Steffen Dirkwinkel wrote:
> On Tue, 2024-09-24 at 21:43 +0300, Laurent Pinchart wrote:
> > On Mon, Sep 23, 2024 at 09:48:03AM +0200, lists@steffen.cc wrote:
> > > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > 
> > > With hpd going through the bridge as of commit eb2d64bfcc17
> > > ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
> > > we don't get hotplug events in userspace on zynqmp hardware.
> > > Also sending hotplug events with drm_helper_hpd_irq_event works.
> > 
> > Why does the driver need to call both drm_helper_hpd_irq_event() and
> > drm_bridge_hpd_notify() ? The latter should end up calling
> > drm_kms_helper_connector_hotplug_event(), which is the same function
> > that drm_helper_hpd_irq_event() calls.
> 
> I don't know why we need drm_helper_hpd_irq_event.
> I'll try to trace what happens on hotplug.

Thank you. Let's try to find the best solution based on your findings.

> > > Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through
> > > the bridge")
> > > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > ---
> > >  drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > index 1846c4971fd8..cb823540a412 100644
> > > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > @@ -17,6 +17,7 @@
> > >  #include <drm/drm_fourcc.h>
> > >  #include <drm/drm_modes.h>
> > >  #include <drm/drm_of.h>
> > > +#include <drm/drm_probe_helper.h>
> > >  
> > >  #include <linux/clk.h>
> > >  #include <linux/delay.h>
> > > @@ -1614,6 +1615,9 @@ static void zynqmp_dp_hpd_work_func(struct
> > > work_struct *work)
> > >  					    hpd_work.work);
> > >  	enum drm_connector_status status;
> > >  
> > > +	if (dp->bridge.dev)
> > > +		drm_helper_hpd_irq_event(dp->bridge.dev);
> > > +
> > >  	status = zynqmp_dp_bridge_detect(&dp->bridge);
> > >  	drm_bridge_hpd_notify(&dp->bridge, status);
> > >  }

-- 
Regards,

Laurent Pinchart


Return-Path: <linux-kernel+bounces-292421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0C956F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956801C22034
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4FE12EBD6;
	Mon, 19 Aug 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuFiZOcx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFB3BBF2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082566; cv=none; b=lkqYQfzeUUp3i7bVZlCbAlKFTJxiVxuTbAEtA+yA7o0Shf0OI1eWV7RE+WqmBMv3PyAKBpleRiBiPbpKJe3S6XKlAX0Gyp6vmJh2uG8IZVE/xv84Wl0/EvSjrH+oUXt13N7MWKjfncsTN1F+jnKSLPutyiqGh7PltC2846Smpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082566; c=relaxed/simple;
	bh=mpgtfZwkltRJnDE0vHDGt4EakdGQxqTVlLn+LHT0GCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYZQ3gov/2TTZvWaxJ+GifeqYv48VKUcrLeL/1wnC+FybV7EHDfuElbDVwJNMlr7iiTxcFzFgucOl4ojA8rbLD36LzDUHI9xAjv1HY6WeSHqYZs1+OzPha+qCtHW5OCbuIbgpBvybVmWHlGsV2Tp3n82BbO9LVjlrGX5KZRCG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuFiZOcx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724082565; x=1755618565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mpgtfZwkltRJnDE0vHDGt4EakdGQxqTVlLn+LHT0GCY=;
  b=EuFiZOcx1r7BKlVccoAA53EyQbebWfzSALNKqfQ0Ysd0DzoZ8V4Nhs9j
   ZDO2iAMXXbzLBFzLLFSCa6XATeiiWqqAnMwSaA4FwnpmeY7d9beL7eY6t
   aQA3Ukvq2mtM5uVBHWIVGGkRtUvzZiTdzDzpdHDcI6vyOmgjqjI4YRtDG
   g5MvMdzr9C/NwtHQqjlEVOQFzeku93GkO+rST+Lp4G1E5OhzGrA4CxCw/
   2aQnd9EvY6RBCM62+KV6nZ+TjcxLjkK8eOBVJ/9U0Tk6C3r+qm6Dd8vEl
   muIYbv4G44Z+3ju5x1FueXNHQD757wwX54Ik9TW3v5s+4BKM+vZ17rhJp
   g==;
X-CSE-ConnectionGUID: XAHB+qnjQy2EcObuo9eyiA==
X-CSE-MsgGUID: mYSqk2ISRCiraOC4k5Jlsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26204474"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="26204474"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:49:24 -0700
X-CSE-ConnectionGUID: xuc9agqnRzCKBBjaKhL80Q==
X-CSE-MsgGUID: 7X0Zf9fzSNOtrzWwOZM+7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="61192834"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.73])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:49:18 -0700
Date: Mon, 19 Aug 2024 17:49:13 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: use dev_err_probe when failing
 to get panel bridge
Message-ID: <ZsNpefhKhj4nXh0_@ashyti-mobl2.lan>
References: <20240808-ti-sn65dsi83-dev_err_probe-v1-1-72417aa275ab@bootlin.com>
 <ZrSfayN4U6Lk3UCj@ashyti-mobl2.lan>
 <20240813101643.5bf8d245@booty>
 <ZrtuksiarZNS8L79@ashyti-mobl2.lan>
 <20240819133840.26045152@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819133840.26045152@booty>

Hi Luca,

On Mon, Aug 19, 2024 at 01:38:40PM +0200, Luca Ceresoli wrote:
> On Tue, 13 Aug 2024 16:32:50 +0200
> > On Tue, Aug 13, 2024 at 10:16:43AM +0200, Luca Ceresoli wrote:
> > > On Thu, 8 Aug 2024 11:35:23 +0100
> > > Andi Shyti <andi.shyti@linux.intel.com> wrote:  
> > > > On Thu, Aug 08, 2024 at 12:26:14PM +0200, Luca Ceresoli wrote:  
> > > > > When devm_drm_of_get_bridge() fails, the probe fails silently. Use
> > > > > dev_err_probe() instead to log an error or report the deferral reason,
> > > > > whichever is applicable.
> > > > > 
> > > > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > > > ---
> > > > >  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > > index 57a7ed13f996..60b9f14d769a 100644
> > > > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > > @@ -606,7 +606,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
> > > > >  
> > > > >  	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> > > > >  	if (IS_ERR(panel_bridge))
> > > > > -		return PTR_ERR(panel_bridge);
> > > > > +		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel bridge\n");    
> > > > 
> > > > patch looks good, but the message is a bit misleading. You are
> > > > not failing to get the panel bridge, but you are failing to find
> > > > a panel bridge in a DT node. Right?  
> > > 
> > > As I can see from both the documentation and the code,
> > > devm_drm_of_get_bridge() is really returning a pointer to a panel
> > > bridge, potentially allocating and adding it in case it was not present
> > > before. Navigating the device tree is only a part of what it does.
> > > 
> > > Do you think I am missing something?  
> > 
> > No, maybe it's me being a bit pedantic. In the sense that we are
> > not really failing to get the panel, but most probably the panel
> > is not installed.
> 
> The panels I'm used to, which I believe to be the most common in
> embedded systems just have no way of being detected, so the operating
> system cannot detect a "panel not installed" condition.
> 
> However I went back to the code and realized your initial remark ("you
> are failing to find a panel bridge in a DT node") is more correct than
> I initially thought. Indeed there are two failure reasons for
> devm_drm_of_get_bridge() to fail: DT lookup and panel bridge creation
> failures. The latter however can be due to -ENOMEM (unlikely) or
> (panel->connector_type == DRM_MODE_CONNECTOR_Unknown), which in turn
> can be due to either a panel driver error or again a DT error in case
> the driver gets the panel type from DT, as panel-simple.c does.
> 
> That said, the role of devm_drm_of_get_bridge() is to provide a panel
> bridge object. If it fails, that means it is unable to provide such an
> object for whatever reason. Reasons currently include DT issues (the
> most likely), driver bug and -ENOMEM. There could be more reasons in
> future versions of the implementation.
> 
> I'm afraid I'm unable to express all the above logic in a single commit
> title line. However, should you have a better commit title or message
> to suggest, I'm still open to improvements. I value good commit
> messages.

yes, that's all correct... I'm just assuming that we don't fail
for enomem's or similar. But if you want to include them, then a
generic "get" might work.

To be honest, I wouldn't know how to write it better :-D
Writing error messages is skill per se.

Maybe something like

  ... "Failed to get panel bridge from DT (%pe)", panel_bridge);

Fact is that an error message should immidiately tell you what is
failing and you understand without browsing the code. A generic
"Failed to get..." says very little.

A use case can be if you receive a bug report. If someone tells
you "Failed to get..." you will need to start diggin on the
report. While if someone tells you "Failed to get panel bridge
from DT (-ENODEV)" you would immediately tell him to add the
panel in the configuration.

But... as I said...

> > I'm not strong on this comment, though, so that
> > feel free to add:

... this is a nitpick, feel free to ignore it.

> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> 
> Otherwise, I'm sending v2 with your review tag by the end of the week.

Thanks,
Andi


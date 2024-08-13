Return-Path: <linux-kernel+bounces-284986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CBB9507B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57941C21886
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B805E19D077;
	Tue, 13 Aug 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2afW7Nj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6E125AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559581; cv=none; b=MYIzgbNZ4Ho3kndt97vnY/MPNNE6a4M6b3AKgvjtyHG9TMj/xWGGQyjslTwaVJSll7eAMolmm6nAzz+cr6J/pRqJ7gkyi4jZ/YsJX9TNMIFX8es5t52pTMLVTtyhz4kHYWLTokMMDv+8Krv6OFTu90+r6DArMdirum64vDQfXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559581; c=relaxed/simple;
	bh=yYmSADZI5opGeLzpfk5KFVFuK9V4rm2ESSze6SWYrc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhiwXQFNrXA3k2R45q3uMQ5ZBBvlpNy1sfH0zoiRR9RXSNWqZfJBuCMQHpSUs2lyo8BbYzTqV2l7gMSZZ8xplyWB9uqpWvW6kUUuzxUvHhLTOpY02oQURZ/OuLg0lHWH79HhvFs6Amn3FUH19HryyEo6aQwrseIwJUbxc52U0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2afW7Nj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723559580; x=1755095580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yYmSADZI5opGeLzpfk5KFVFuK9V4rm2ESSze6SWYrc0=;
  b=c2afW7NjuV1h4pBiL5GFApql6tAe92jRjcM8+jvWs4GZ4reg2DRA5zLK
   Ap0kSnhWjw80xBQ2H8roK8WfszwHOu+fMxNEc47lG9fihi18YjZRtXfti
   weT3ErPs7Wk3yBEdDKUIzUfuGWuGErLylef9KML9kBjXYxJIWaFugOsPE
   mMQnPZy66EPir3nYz1athmcRf9YLNK3HWIgACkfRJLb8xcfMG78VTVym8
   BnWWcyTSMnXDl5sMIP3JjH4Fziln7j23STqPE5TtOg9X3CqWQznIBydg1
   7ioiSgb1fxZvBJCmHKAAXDCHeEitb5jH8jkYJgQq+NZZf801gVSnvFzLI
   g==;
X-CSE-ConnectionGUID: aF3kJMsZTUGEXHO2QwoxiA==
X-CSE-MsgGUID: T2n1q2P8T7eiVWgYREVrMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25490177"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="25490177"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:32:59 -0700
X-CSE-ConnectionGUID: 96evE7TcQXy6fBhvy5nVQw==
X-CSE-MsgGUID: JtW4SInQStyxOwsut3YheA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58561914"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO intel.com) ([10.245.246.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:32:54 -0700
Date: Tue, 13 Aug 2024 16:32:50 +0200
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
Message-ID: <ZrtuksiarZNS8L79@ashyti-mobl2.lan>
References: <20240808-ti-sn65dsi83-dev_err_probe-v1-1-72417aa275ab@bootlin.com>
 <ZrSfayN4U6Lk3UCj@ashyti-mobl2.lan>
 <20240813101643.5bf8d245@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813101643.5bf8d245@booty>

Hi Luca,

On Tue, Aug 13, 2024 at 10:16:43AM +0200, Luca Ceresoli wrote:
> On Thu, 8 Aug 2024 11:35:23 +0100
> Andi Shyti <andi.shyti@linux.intel.com> wrote:
> > On Thu, Aug 08, 2024 at 12:26:14PM +0200, Luca Ceresoli wrote:
> > > When devm_drm_of_get_bridge() fails, the probe fails silently. Use
> > > dev_err_probe() instead to log an error or report the deferral reason,
> > > whichever is applicable.
> > > 
> > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > index 57a7ed13f996..60b9f14d769a 100644
> > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > @@ -606,7 +606,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
> > >  
> > >  	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> > >  	if (IS_ERR(panel_bridge))
> > > -		return PTR_ERR(panel_bridge);
> > > +		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel bridge\n");  
> > 
> > patch looks good, but the message is a bit misleading. You are
> > not failing to get the panel bridge, but you are failing to find
> > a panel bridge in a DT node. Right?
> 
> As I can see from both the documentation and the code,
> devm_drm_of_get_bridge() is really returning a pointer to a panel
> bridge, potentially allocating and adding it in case it was not present
> before. Navigating the device tree is only a part of what it does.
> 
> Do you think I am missing something?

No, maybe it's me being a bit pedantic. In the sense that we are
not really failing to get the panel, but most probably the panel
is not installed. I'm not strong on this comment, though, so that
feel free to add:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi


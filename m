Return-Path: <linux-kernel+bounces-291968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B295697A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C887281719
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB87166F0D;
	Mon, 19 Aug 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aL5nPNyw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE815B140
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067536; cv=none; b=KnFkAzwgZhV+LnV1gZ6RrttHVz+5a7637Pk6u5QT0ROtJy5QoK+/hcF6JalQdWS2nFjmJB0P8eiUvuR6e6o1AEg1hMEdwM66K5IyupLSdixxNmGl3lYRJJsg1HIx2oy/ZBen3FTws5DBBROh8lqGNBXE9KHbJtJw5oE0CiGwc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067536; c=relaxed/simple;
	bh=fDHgl/Q0vd//GJ7pRbdKoDHc7tmcY7zDo66XvTaXccs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2rkyu6FlN2tJDYKoljybgdDsqxfG/m9nsAAW5sS7ekMJywQKxs6FZIuuL1fbH29ee5zWoq9HUJfouw0Mc7lNEXcvBj3bOmjE7Aug/4P4qDr6y2mNX6caJV8PJd+wjGUELf9IkGHmYUJ3iz+dClGAV9ffabHHXH276ljHumCmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aL5nPNyw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9DF1C0003;
	Mon, 19 Aug 2024 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724067525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi25+xcJfrO7nLXZ6nqh00qEFioKK3pAMkYDoRraxek=;
	b=aL5nPNyweFQC+1Fdl4ZDP+opbjLoTmuAsy8mnCool/vUtMrQT0y+vmzoC9r1P1IYhRiqAi
	foCJyBdjyU5EqLcn8XyjMO658Ms4PTiQdWUBUYy6m137yHqFLlyMtSmIW4myg6SiyJr/Dn
	Y/2gq2tQHF4qbR4PYhqEgzy6quBQP/Pw0ARmVnpAp8h5x92ue/bz+EBlEfnhx+ZHpjxceo
	s6XXVyF+zabBgn54ztcM3O/MAuWA2Je4YnLsrUI22Dqw6LHKW3KOYtfX5DJ1uqPAVmNXL6
	COKvHNJl/AvfMMqBTtGKwUFhUuGb8Zc75xZdE+gXM6rZFgqp2/0fw7Jf/coyCQ==
Date: Mon, 19 Aug 2024 13:38:40 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: use dev_err_probe when
 failing to get panel bridge
Message-ID: <20240819133840.26045152@booty>
In-Reply-To: <ZrtuksiarZNS8L79@ashyti-mobl2.lan>
References: <20240808-ti-sn65dsi83-dev_err_probe-v1-1-72417aa275ab@bootlin.com>
	<ZrSfayN4U6Lk3UCj@ashyti-mobl2.lan>
	<20240813101643.5bf8d245@booty>
	<ZrtuksiarZNS8L79@ashyti-mobl2.lan>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Andi,

thanks for your additional comments.

On Tue, 13 Aug 2024 16:32:50 +0200
Andi Shyti <andi.shyti@linux.intel.com> wrote:

> Hi Luca,
> 
> On Tue, Aug 13, 2024 at 10:16:43AM +0200, Luca Ceresoli wrote:
> > On Thu, 8 Aug 2024 11:35:23 +0100
> > Andi Shyti <andi.shyti@linux.intel.com> wrote:  
> > > On Thu, Aug 08, 2024 at 12:26:14PM +0200, Luca Ceresoli wrote:  
> > > > When devm_drm_of_get_bridge() fails, the probe fails silently. Use
> > > > dev_err_probe() instead to log an error or report the deferral reason,
> > > > whichever is applicable.
> > > > 
> > > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > index 57a7ed13f996..60b9f14d769a 100644
> > > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > @@ -606,7 +606,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
> > > >  
> > > >  	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> > > >  	if (IS_ERR(panel_bridge))
> > > > -		return PTR_ERR(panel_bridge);
> > > > +		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel bridge\n");    
> > > 
> > > patch looks good, but the message is a bit misleading. You are
> > > not failing to get the panel bridge, but you are failing to find
> > > a panel bridge in a DT node. Right?  
> > 
> > As I can see from both the documentation and the code,
> > devm_drm_of_get_bridge() is really returning a pointer to a panel
> > bridge, potentially allocating and adding it in case it was not present
> > before. Navigating the device tree is only a part of what it does.
> > 
> > Do you think I am missing something?  
> 
> No, maybe it's me being a bit pedantic. In the sense that we are
> not really failing to get the panel, but most probably the panel
> is not installed.

The panels I'm used to, which I believe to be the most common in
embedded systems just have no way of being detected, so the operating
system cannot detect a "panel not installed" condition.

However I went back to the code and realized your initial remark ("you
are failing to find a panel bridge in a DT node") is more correct than
I initially thought. Indeed there are two failure reasons for
devm_drm_of_get_bridge() to fail: DT lookup and panel bridge creation
failures. The latter however can be due to -ENOMEM (unlikely) or
(panel->connector_type == DRM_MODE_CONNECTOR_Unknown), which in turn
can be due to either a panel driver error or again a DT error in case
the driver gets the panel type from DT, as panel-simple.c does.

That said, the role of devm_drm_of_get_bridge() is to provide a panel
bridge object. If it fails, that means it is unable to provide such an
object for whatever reason. Reasons currently include DT issues (the
most likely), driver bug and -ENOMEM. There could be more reasons in
future versions of the implementation.

I'm afraid I'm unable to express all the above logic in a single commit
title line. However, should you have a better commit title or message
to suggest, I'm still open to improvements. I value good commit
messages.

> I'm not strong on this comment, though, so that
> feel free to add:
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Otherwise, I'm sending v2 with your review tag by the end of the week.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


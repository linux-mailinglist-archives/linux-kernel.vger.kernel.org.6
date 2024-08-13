Return-Path: <linux-kernel+bounces-284296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48F194FF77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C78B1F2568F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0C137C35;
	Tue, 13 Aug 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OxUsEIZg"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE95225AF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537011; cv=none; b=kWfznRUg6Ljyj9CSJLr07XSkKNq8HhyVxzylRiglt7NQXoo7HIkR9yVEw1KDeMjQPop2ondXgvveAL/BkQhD2ssd4drDFHL/hJ/mhgSmnJRFuBurIaoQDveq/YbngBsjSdpfmUP8alfWIQHw0bxbAi5sGfpaE778Z85fkEjiyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537011; c=relaxed/simple;
	bh=WFwhYDxYBaOGeQ8CMV5holJIQQKBn25qEFTsw/4c374=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyHTBguzqXFGvRjoYgcCvHUK3RgvIGJsvlbCastiXLW96VzVgz745j4tdavw3gRijpaVre/f1dYb2XfE9U144AJf/phtHw1Jv0nMZWkhccbHm0oBJ1kODuhZVTheJvKLVftnIhb4CaXZkpD6eCMyHkY6tLzd8++f0f7NtcnKQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OxUsEIZg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 228ABFF806;
	Tue, 13 Aug 2024 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723537006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoFDc4QC+GO77T0FrZWIwuTaCRzddzoUcuaa2caP/EI=;
	b=OxUsEIZg03mC6cSxQjOuBuYpr5R7079AZFQECISMAxFCOb8RA3mh6Bo4CMxPnNVAtDkJaA
	jMesPvC5NnXoHE4SME0m3r31YdZf4g5vS1fcFpTNH7Gcp/AsktsSaRMB/Ub8EcvhCKnLWe
	JCVaB3Spvzu0VVVEb3ZPC6T8eEWDE0AjLNZ0UUt5ydTk69asKDbTBQIbZCmUhK/+UOddLx
	wUbD+lXYx7OWrkPbd0pAxb52Qj/4Eu6qAC0Hg7A68QKScNCDX5JLiXowI4m60rn2XG1sut
	clXsVZRwYuvs7SJvBMpsI908B0AFCl4NN9vHiw8PZ5cJ2b13oR0353GUgzQsXQ==
Date: Tue, 13 Aug 2024 10:16:43 +0200
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
Message-ID: <20240813101643.5bf8d245@booty>
In-Reply-To: <ZrSfayN4U6Lk3UCj@ashyti-mobl2.lan>
References: <20240808-ti-sn65dsi83-dev_err_probe-v1-1-72417aa275ab@bootlin.com>
	<ZrSfayN4U6Lk3UCj@ashyti-mobl2.lan>
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

On Thu, 8 Aug 2024 11:35:23 +0100
Andi Shyti <andi.shyti@linux.intel.com> wrote:

> Hi Luca,
> 
> On Thu, Aug 08, 2024 at 12:26:14PM +0200, Luca Ceresoli wrote:
> > When devm_drm_of_get_bridge() fails, the probe fails silently. Use
> > dev_err_probe() instead to log an error or report the deferral reason,
> > whichever is applicable.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > index 57a7ed13f996..60b9f14d769a 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > @@ -606,7 +606,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
> >  
> >  	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> >  	if (IS_ERR(panel_bridge))
> > -		return PTR_ERR(panel_bridge);
> > +		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel bridge\n");  
> 
> patch looks good, but the message is a bit misleading. You are
> not failing to get the panel bridge, but you are failing to find
> a panel bridge in a DT node. Right?

As I can see from both the documentation and the code,
devm_drm_of_get_bridge() is really returning a pointer to a panel
bridge, potentially allocating and adding it in case it was not present
before. Navigating the device tree is only a part of what it does.

Do you think I am missing something?

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


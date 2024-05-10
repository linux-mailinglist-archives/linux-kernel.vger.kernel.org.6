Return-Path: <linux-kernel+bounces-175607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F88C2288
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230B4281A93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26316C69C;
	Fri, 10 May 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k5pEdecO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61421340;
	Fri, 10 May 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338466; cv=none; b=F3WYCxhVUm/99mzcwPuApzADFvWQN17lzPqAKxvV2xZ3jaXoxq37k8MSySdrFnJl5bEAQwwrO0LvYc7pt02/2crsmgv7/8ZtYutUfBYhflyhqRASUgnarFbq/+1yqfHk9pVKxKl+zNm0h2K+asERqEhIm9QCJpvN+HHI9973xEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338466; c=relaxed/simple;
	bh=oDcASLDIQZmkAxp59zD2E0JKAISSCjIY9zshHMuu5fY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je09BAXw3QlejYEdSJz/27DXlmNjTR0uYw+3/PwvlIrqoVPdsq/XKSULouVm85b11MXX8+NEyk9NQs4Jcka57p2Vkfrx1S+Dvt77C+FKiLDsgcyjfPskkXtcUa5WAiuhiTH8/WJ1gRZ7+oCIuAxAvCkbM/dSFFGD9PTrhT0lNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k5pEdecO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D47EE240009;
	Fri, 10 May 2024 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715338461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZbeSwH31KNLEzlZsbO4/BJQ+b20T9k5ad6GKPN2gJ0=;
	b=k5pEdecOUcjybWCXmSFnjzR2CYToQByRP4ODnln3OHE+UVrMjMLae7UoSm9r3YSBC0Y6sI
	5eQbvi5Upp9AZp2kPwFHWvDQ8h/EC/NizbYtyf5h7SdAjlg+wiNqo1vJ26NnWl3CkVbplT
	NsH/SDZ2FL2GVASwKo+CN04ay1WfrEy+SZOHg6zT0p71CjsTU/aICRRyIiTK5Agf+zwKD7
	aao99eKmih9JYGZVIggxYhPr7S2rvTii0wXBJ4DcoAtLcYJY0KgLnJXxJ6Aub28Xn/Y0E9
	IIyo04oxzuREiWWuEXRNI7vBh9XX7iA81QkjHBEVWJ/1k+fyjE+IVEu/D+ulGg==
Date: Fri, 10 May 2024 12:54:17 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Saravana Kannan <saravanak@google.com>, Paul Kocialkowski
 <contact@paulk.fr>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Paul
 Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 5/5] misc: add ge-addon-connector driver
Message-ID: <20240510125417.1dddfd5c@booty>
In-Reply-To: <2024051039-decree-shrimp-45c6@gregkh>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
	<20240510-hotplug-drm-bridge-v2-5-ec32f2c66d56@bootlin.com>
	<2024051039-decree-shrimp-45c6@gregkh>
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

Hello Greg,

thanks for reviewing.

On Fri, 10 May 2024 08:55:29 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, May 10, 2024 at 09:10:41AM +0200, Luca Ceresoli wrote:
> > Add a driver to support the runtime hot-pluggable add-on connector on the
> > GE SUNH device. This connector allows connecting and disconnecting an
> > add-on to/from the main device to augment its features. Connection and
> > disconnection can happen at runtime at any moment without notice.
> > 
> > Different add-on models can be connected, and each has an EEPROM with a
> > model identifier at a fixed address.
> > 
> > The add-on hardware is added and removed using device tree overlay loading
> > and unloading.
> > 
> > Co-developed-by: Herve Codina <herve.codina@bootlin.com>
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > ---
> > 
> > This commit is new in v2.
> > ---
> >  MAINTAINERS                      |   1 +
> >  drivers/misc/Kconfig             |  15 ++
> >  drivers/misc/Makefile            |   1 +
> >  drivers/misc/ge-sunh-connector.c | 464 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 481 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 672c26372c92..0bdb4fc496b8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9905,6 +9905,7 @@ F:	drivers/iio/pressure/mprls0025pa*
> >  HOTPLUG CONNECTOR FOR GE SUNH ADDONS
> >  M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
> >  S:	Maintained
> > +F:	drivers/misc/ge-sunh-connector.c
> >  F:	Documentation/devicetree/bindings/connector/ge,sunh-addon-connector.yaml
> >  
> >  HP BIOSCFG DRIVER
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..99ef2eccbbaa 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -574,6 +574,21 @@ config NSM
> >  	  To compile this driver as a module, choose M here.
> >  	  The module will be called nsm.
> >  
> > +config GE_SUNH_CONNECTOR
> > +	tristate "GE SUNH hotplug add-on connector"
> > +	depends on OF
> > +	select OF_OVERLAY
> > +	select FW_LOADER
> > +	select NVMEM
> > +	select DRM_HOTPLUG_BRIDGE  
> 
> Can these be depends instead of select?  'select' causes dependencies
> that are hard, if not almost impossible, to detect at times why
> something is being enabled.

(see reply to Arnd's follow-up e-mail for this)

> > +	help
> > +	  Driver for the runtime hot-pluggable add-on connector on the GE SUNH
> > +	  device. This connector allows connecting and disconnecting an add-on
> > +	  to/from the main device to augment its features. Connection and
> > +	  disconnection can be done at runtime at any moment without
> > +	  notice. Different add-on models can be connected, and each has an EEPROM
> > +	  with a model identifier at a fixed address.  
> 
> Module name?

OK, will add.

> > +static void sunh_conn_reset(struct sunh_conn *conn, bool keep_reset)
> > +{
> > +	dev_dbg(conn->dev, "reset\n");  
> 
> ftrace is your friend.

ACK.

> > +static int sunh_conn_handle_event(struct sunh_conn *conn, bool plugged)
> > +{
> > +	int err;
> > +
> > +	if (plugged == conn->plugged)
> > +		return 0;
> > +
> > +	dev_info(conn->dev, "%s\n", plugged ? "connected" : "disconnected");  
> 
> Please remove debugging code from stuff you want to see merged.
> 
> Same for all dev_info() calls here, when drivers work properly, they are
> quiet.

While agree for other dev_info() calls, this one seems quite similar in
principle to the link up/down messages that get logged by the MII code
at [0]:

  [347229.872315] asix 1-1.3.2:1.0 enx000cf616fecb: link up, 100Mbps,
  full-duplex, lpa 0xC5E1 [347229.920449] asix 1-1.3.2:1.0 enx000cf616fecb: link down

In my case it is logging that a removable part of the hardware has been
added or removed, which appears useful. Do you think it make sense in
this scenario?

Luca

[0] https://elixir.bootlin.com/linux/v6.8.9/source/drivers/net/mii.c#L557

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-175608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B622C8C228C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B831F22638
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A2516D4FE;
	Fri, 10 May 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K8/osNAe"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0B21340;
	Fri, 10 May 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338472; cv=none; b=IY98tqi25mcn+V6kr+BopmACCTOpfDqP80trBgYL1tI8S+VdHtHwZVjyeyN2mTDJlzjAzM/Zcw8x0i+uUDS4yQ+2GiX9GlwDlwKniIP+GyQF+98s2lMGqBogwyq7tbTcOGAexCkhff6YAg7cvJzf0fu5lbokoHJlBguftQgMjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338472; c=relaxed/simple;
	bh=dNw1Wr2Av5DW4mueAwQ+s5X4+nf5AQYXYvvohA5R6Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qnn7viifnP9lnylQZK+1AMsGKJNAIFlW8F3FYvmWk9lTbWiMMEQdk/h/QMHTip00RvuZVZWxIi6tneVjs+7AUTvr+rkfGU2jG3tTgHUBGIjcOhYrfhaP8qoMwc6ZJuHqltd1jg/D3v3lvR4ZdgEazNzz+iLnPHYZ8o5HI6fag4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K8/osNAe; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C3521BF209;
	Fri, 10 May 2024 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715338468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOtPKmgchyWmbrYBxXPn7lnbrTTGQ4uEd2Sa5ZRuwlA=;
	b=K8/osNAe6yE6WlZSa8kDL76s6DRm+Pr287W3LpLbtgxSpsaDIxWdGDgQ7rtcfdvMoj6sW3
	6smdCd36av8J2gBSTZyDfllC3FC9b0Wye2UHk3DPoifHiB+u6jKIOTxm+iP2pHt59JhJ07
	1MnbmnZ0yQzUPunOD0uEG1bYasiPNrOAt7PYxtZD8vXm/bta91ynh+X1fqvtN1Gba7lq5S
	SahPpF3qSwHSNJ/MYWLI160fLR2sAchbNfaXYYw4JpaCChKQ288Pej96+ZxCQd6m4aW0ig
	S67GjXdksqWDSDSZSHcEvS/fXRs5W9T8mAz/+mtEH0Xi9GLymQBAdiETwpf93A==
Date: Fri, 10 May 2024 12:54:23 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "laurent.pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie"
 <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>, "dragan.cvetic@amd.com"
 <dragan.cvetic@amd.com>, "Saravana Kannan" <saravanak@google.com>, "Paul
 Kocialkowski" <contact@paulk.fr>, "Herve Codina"
 <herve.codina@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Paul
 Kocialkowski" <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 5/5] misc: add ge-addon-connector driver
Message-ID: <20240510125423.25d4b3ed@booty>
In-Reply-To: <a1970921-f00b-411d-832d-5289f9812ba0@app.fastmail.com>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
	<20240510-hotplug-drm-bridge-v2-5-ec32f2c66d56@bootlin.com>
	<2024051039-decree-shrimp-45c6@gregkh>
	<a1970921-f00b-411d-832d-5289f9812ba0@app.fastmail.com>
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

Hello Greg, Arnd,

On Fri, 10 May 2024 12:24:06 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, May 10, 2024, at 09:55, Greg Kroah-Hartman wrote:
> > On Fri, May 10, 2024 at 09:10:41AM +0200, Luca Ceresoli wrote:  
> >>  
> >> +config GE_SUNH_CONNECTOR
> >> +	tristate "GE SUNH hotplug add-on connector"
> >> +	depends on OF
> >> +	select OF_OVERLAY
> >> +	select FW_LOADER
> >> +	select NVMEM
> >> +	select DRM_HOTPLUG_BRIDGE  
> >
> > Can these be depends instead of select?  'select' causes dependencies
> > that are hard, if not almost impossible, to detect at times why
> > something is being enabled.  
> 
> I think FW_LOADER needs to be 'select' since it is normally
> a hidden symbol and gets selected by its users, all the other
> ones should be 'depends on'.

I see, makes sense.

And as you pointed that out, I realize perhaps DRM_HOTPLUG_BRIDGE could
become a hidden symbol as it's not expected to be used alone.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


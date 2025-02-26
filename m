Return-Path: <linux-kernel+bounces-534980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9905A46D90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D446416C5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246825A655;
	Wed, 26 Feb 2025 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h/qjkjlG"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF402745E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605781; cv=none; b=ua3E8FFc1XEhGE1zprtyZOsn0lmu+WlofVTGwrwXif76n/+ZR3Rnu8X0gsr+le9GIbD5K7TNRULJg0xBO+2gdvlG7qBD5k5Qdzaw0Xo25d7vXaE5WSdw0SPp8aH6I0+J69eVaBE2JoL6CdwhWkQSetBKauP4+qyE3Ud86HKCFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605781; c=relaxed/simple;
	bh=X/XZm41tWS9h0qiv5kaYE+gLY+G43wf8AROkkArq2R8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfA9pAvyYQN7LqZ/cgNkvANX+sXAcG0KWKhDqV4AElCR4fvFX3lQdRnGW+I1BbFDdOK54Pz5Tr3KsJOj4mrzBCALgQPa4U/6ukhYRs6dMkhYQJyRoIYBQIItGsE7Sj8u1BfBCo5mBgmjtzulDo0CFhPB5rRCqyQrQSzWxFG3LPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h/qjkjlG; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 62EB5581849
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:24:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D59444356;
	Wed, 26 Feb 2025 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740605087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV38PQTzP4LsTI2fWnjmoilBe+AerYXnM0qzYdZcLiA=;
	b=h/qjkjlGD45ZR2ZZFpAetj+erMRQhiGf2YyXSlVOz0WYSsqL/1+sVmvTIX+ZdYWqo54juT
	GHUssJ60vjltqmlJTc6AZ6BsOwxo24p2kLZ5SaQjtbN6R3OMjYAAsjuoZzliYUQgaEc3vg
	A+Bcwv5iaX0OeMO7BYnzftEWyavfx+aLD/gkM1HJEWzRvWh4DUv8vLltb2DQGius2m9amc
	UaQQg0X+88d9tsTXh4lxR53pMv27+RzTX65GB847ZZJDcar7fehmTrpIsEZqxETpxwSkTX
	atm17Wf0PZhjiM1zGXABQActJfHF+TkZeJ4XgprO1FLHvvjZMJQK+zw5BIMHUQ==
Date: Wed, 26 Feb 2025 22:24:42 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] drm/bridge: move bridges_show logic from
 drm_debugfs.c
Message-ID: <20250226222442.2a32d706@booty>
In-Reply-To: <87mse851um.fsf@intel.com>
References: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
	<20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
	<878qpu56cm.fsf@intel.com>
	<20250225183621.6b33684b@booty>
	<871pvl6g1t.fsf@intel.com>
	<20250226123208.272e7766@booty>
	<87mse851um.fsf@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehjrghnihdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhro
 hhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Jani,

On Wed, 26 Feb 2025 14:26:09 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> > Moving the last 2 lines to drm_bridge.c and into a new function we'd
> > have:
> >
> > drm_encoder_register_all()                             [drm_encoder.c]  
> >  -> drm_debugfs_encoder_add [*]                        [drm_debugfs.c]
> >   -> drm_bridge_debugfs_add_encoder_bridges_file (NEW) [drm_bridge.c]
> >    -> debugfs_create_file("bridges"...  &bridges_fops) [drm_bridge.c]  
> >                                     [bridges_fops is in drm_bridge.c]
> >
> > Potentially [*] could be moved to drm_encoder.c, but that is not bridge
> > related and can be done as a future step.
> >
> > Is this what you had in mind?  
> 
> Yes!
> 
> (Though I'd give drm_bridge_debugfs_add_encoder_bridges_file() a shorter
> and more generic name.)

Thanks, done. v8 on its way.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-511376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7653CA32A21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190C816694E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9A20C486;
	Wed, 12 Feb 2025 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NMytQNfm"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524120D509
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374407; cv=none; b=QiGsYtP0Rvcn7V+qduvfRmqctkY01xCls1ohFIv/B5drSt7SOus4ZA3dxQU5gM2X73NXuY7yQK9y2fC8dJnYRrTDS31mRpEIOtU//u5Xq+l5MIcAmo7AD1unDmk7g2lo+bkM7fCXqZblJQ9f0PTz33KQYdVUPHiv0LGO7yrUVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374407; c=relaxed/simple;
	bh=JXG+RfqFAbtXcQChbe0MvtTrnZbnYIl8KTVyk/CxLO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3cZenyGwZBaKfRMYrM3GMNVUi/8bZrYg0jZHmmnMPsdgtlQ5dmu7AyWzZuq2YbwUAST4y37kUYjdEB79G3e9EbRhPNlqW1DYnVq7kNvVXgTyFm2+mN1X+lZ/hBG/RxjW2xyZKTWa/taSB3E54LsF3aki4wnsR5FiYtk4sBTPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NMytQNfm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAD5A442F1;
	Wed, 12 Feb 2025 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739374403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0VUGdc/xFtFd8Ja/DjDXHACeZEGbJdUwJWsHxCdaFI=;
	b=NMytQNfmAgTkvF2UA7Rv/VW4W+bjhDy/LlskQUe4SbxNIOU8pOqyF32b60Rzbz1XQYZRvo
	r1GAJBxI+KNcxOJ/oEC1wt9nYIrUoGOJYLt2Psyp6Hx5W53JS0RaZxlfqJz/Ij9U2mhFwY
	74lOZhWctvn/fnvRF01ssiTZKLfJ9CP/ttWFRQCGQ+PH3i2u4NlT1F4i3CFK6q5rT8OENG
	cwA14DtNKV+J4aKKJUIgTqNI7yLNOeoMKahAOSZqM8GSU6U2SHWmk2GDZxPjIHsNwLLUlH
	taESzJqCiBX1hoFag3CH33u3GgLsmkadJOvSqNMzCjTtX7MqJUhUNUC+3k2PLQ==
Date: Wed, 12 Feb 2025 16:33:20 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Francesco <francesco.dolcini@toradex.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley
 <conor@kernel.org>, =?UTF-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize
 cycle detection logic
Message-ID: <20250212163320.24d30adb@booty>
In-Reply-To: <20241206103143.755f5e87@booty>
References: <20241030171009.1853340-1-saravanak@google.com>
	<20241204124826.2e055091@booty>
	<20241206103143.755f5e87@booty>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtleejjeduvddutefftdduleefudfgudeltdeuffeuudefgfdugeekgedtieehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrv
 ghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgrnhgtvghstghordguohhltghinhhisehtohhrrgguvgigrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepthhomhhirdhvrghlkhgvihhnvghnsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsegrnhgurhhoihgurdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

On Fri, 6 Dec 2024 10:31:43 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> > After rebasing my work for the hotplug connector driver using device
> > tree overlays [0] on v6.13-rc1 I started getting these OF errors on
> > overlay removal:
> > 
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-connector/devices/panel-dsi-lvds
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-connector/devices/backlight-addon
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-connector/devices/battery-charger
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-connector/devices/regulator-addon-5v0-sys
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-connector/devices/regulator-addon-3v3-sys
> > 
> > ...and many more. Exactly one per each device in the overlay 'devices'
> > node, each implemented by a platform driver.
> > 
> > Bisecting found this patch is triggering these error messages, which
> > in fact disappear by reverting it.
> > 
> > I looked at the differences in dmesg and /sys/class/devlink/ in the
> > "good" and "bad" cases, and found almost no differences. The only
> > relevant difference is in cycle detection for the panel node, which was
> > expected, but nothing about all the other nodes like regulators.
> > 
> > Enabling debug messages in core.c also does not show significant
> > changes between the two cases, even though it's hard to be sure given
> > the verbosity of the log and the reordering of messages.
> > 
> > I suspect the new version of the cycle removal code is missing an
> > of_node_get() somewhere, but that is not directly visible in the patch
> > diff itself.  
> 
> I collected some more info by adding a bit of logging for one of the
> affected devices.
> 
> It looks like the of_node_get() and of_node_put() in the overlay
> loading phase are the same, even though not completely in the same
> order. So after overlay insertion we should have the same refcount with
> and without your patch.
> 
> There is a difference on overlay removal however: an of_node_put() call
> is absent with 6.13-rc1 code (errors emitted), and becomes present by
> just reverting your patch (the "good" case). Here's the stack trace of
> this call:
> 
>  Call trace:
>   show_stack+0x20/0x38 (C)
>   dump_stack_lvl+0x74/0x90
>   dump_stack+0x18/0x28
>   of_node_put+0x50/0x70
>   platform_device_release+0x24/0x68
>   device_release+0x3c/0xa0
>   kobject_put+0xa4/0x118
>   device_link_release_fn+0x60/0xd8
>   process_one_work+0x158/0x3c0
>   worker_thread+0x2d8/0x3e8
>   kthread+0x118/0x128
>   ret_from_fork+0x10/0x20
> 
> So for some reason device_link_release_fn() is not leading to a
> of_node_put() call after adding your patch.
> 
> Quick code inspection did not show any useful info for me to understand
> more.

I just sent a patch fixing
this: https://lore.kernel.org/20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


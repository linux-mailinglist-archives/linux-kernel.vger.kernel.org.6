Return-Path: <linux-kernel+bounces-431122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B537A9E3934
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9650168C31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EA71B395F;
	Wed,  4 Dec 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Eiabl8mJ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919C1B393A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312914; cv=none; b=XGjF/U1mFzuVYkUtv0cIfSZ4wxBBK8Cd/bg08MWg6JEuVJ6gsgUDBR9bjjVi7DWcSPUO4W/FOGbVkp0d/9q3xckYXg71veoAUUknrLA3UVrYhIIj1TZSErzYsRpweT+raSoh8tkU7a9K/GtRxDZn2T0RSb1ME9Q42YGVuzbMAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312914; c=relaxed/simple;
	bh=4r0p1BOG67VHgM5UWaGYXDCZt5TDFsUUNnk5813gz2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/zCKQVunqimReZS8/4qK+jhIEd1brMQIJfTrwQ9Mybp2RfKNfIq4mh5SJIpkRnZeF6PeRjhf2sZDSxXX9x2Shc0fAmSw+WmrmKjpRx9Lj1gPl8LoP6UyLb4UKSpBuijD87kmibiZ6O3X2eKyf/cpXhFJxXCgL3Bpo5XIvXGmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Eiabl8mJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6E76E0008;
	Wed,  4 Dec 2024 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733312909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r0p1BOG67VHgM5UWaGYXDCZt5TDFsUUNnk5813gz2I=;
	b=Eiabl8mJKkEzMn4lRypudyvJL3uHutZ8oEfKKPGAyx51LgiSZQTIltEvf0jgR67PaN91CO
	/QJwkCYCNGm5oqbcYbhyohTXDzdB3bhdyVplJjqB2y+bgtXfAKxGkyttQnUBLdx5C6txnS
	qDkK1416ESTJ8C+k/KHZh6c61jx67tUV0bBVVmly4a4kLJM5+4vXfiYRuqCtFIK50Acjku
	YBOmORcZvt9AWJestLyYVmtmg0Z4Xk88zqjt5uE8DInFFKhseAgqKdQwlu9hxBRPbr6xIU
	DZ3cPOELCvE4l0P4C8QzU8IND77C12kqGDi4Itr8PPt7qeeSovLjnVVnligoLA==
Date: Wed, 4 Dec 2024 12:48:26 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Francesco <francesco.dolcini@toradex.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley
 <conor@kernel.org>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize
 cycle detection logic
Message-ID: <20241204124826.2e055091@booty>
In-Reply-To: <20241030171009.1853340-1-saravanak@google.com>
References: <20241030171009.1853340-1-saravanak@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Saravana,

+Cc. DT maintainers, Herv=C3=A9

On Wed, 30 Oct 2024 10:10:07 -0700
Saravana Kannan <saravanak@google.com> wrote:

> In attempting to optimize fw_devlink runtime, I introduced numerous cycle
> detection bugs by foregoing cycle detection logic under specific
> conditions. Each fix has further narrowed the conditions for optimization.
>=20
> It's time to give up on these optimization attempts and just run the cycle
> detection logic every time fw_devlink tries to create a device link.
>=20
> The specific bug report that triggered this fix involved a supplier fwnode
> that never gets a device created for it. Instead, the supplier fwnode is
> represented by the device that corresponds to an ancestor fwnode.
>=20
> In this case, fw_devlink didn't do any cycle detection because the cycle
> detection logic is only run when a device link is created between the
> devices that correspond to the actual consumer and supplier fwnodes.
>=20
> With this change, fw_devlink will run cycle detection logic even when
> creating SYNC_STATE_ONLY proxy device links from a device that is an
> ancestor of a consumer fwnode.
>=20
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@=
ideasonboard.com/
> Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of overl=
apping cycles")
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

After rebasing my work for the hotplug connector driver using device
tree overlays [0] on v6.13-rc1 I started getting these OF errors on
overlay removal:

OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_=
node_put() unbalanced - destroy cset entry: attach overlay node /addon-conn=
ector/devices/panel-dsi-lvds
OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_=
node_put() unbalanced - destroy cset entry: attach overlay node /addon-conn=
ector/devices/backlight-addon
OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_=
node_put() unbalanced - destroy cset entry: attach overlay node /addon-conn=
ector/devices/battery-charger
OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_=
node_put() unbalanced - destroy cset entry: attach overlay node /addon-conn=
ector/devices/regulator-addon-5v0-sys
OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_=
node_put() unbalanced - destroy cset entry: attach overlay node /addon-conn=
ector/devices/regulator-addon-3v3-sys

...and many more. Exactly one per each device in the overlay 'devices'
node, each implemented by a platform driver.

Bisecting found this patch is triggering these error messages, which
in fact disappear by reverting it.

I looked at the differences in dmesg and /sys/class/devlink/ in the
"good" and "bad" cases, and found almost no differences. The only
relevant difference is in cycle detection for the panel node, which was
expected, but nothing about all the other nodes like regulators.

Enabling debug messages in core.c also does not show significant
changes between the two cases, even though it's hard to be sure given
the verbosity of the log and the reordering of messages.

I suspect the new version of the cycle removal code is missing an
of_node_get() somewhere, but that is not directly visible in the patch
diff itself.

Any clues?

[0] https://lore.kernel.org/all/20240917-hotplug-drm-bridge-v4-0-bc4dfee61b=
e6@bootlin.com/

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


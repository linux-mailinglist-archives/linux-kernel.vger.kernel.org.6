Return-Path: <linux-kernel+bounces-434718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665E9E6A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2D6188487D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CAE1DB551;
	Fri,  6 Dec 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LP5Y9LRR"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE03D6B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477510; cv=none; b=mcAgJMmJVhWhKmZn1JjAbglY1I2QgcS/bReIUn+yDZkkhQ4tjV8QzL9ey6XWegFah1RzVJKBZ71AK2CP2pCHPWQKAedgPFBJ3CtWjafPWScSNB7UbiaAjUQh6MUTKeueuIcXqzyfViUeUjHBsxG9+h8w/IdNGuieZ/IvoWzELA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477510; c=relaxed/simple;
	bh=V8irdec3eL7VvywghhwB6Wc1IbiKFbg6LDHZ/X6y6iA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk6dReno4tTOA4utDZrzpbhD0X5y5mEGf6/+6DPSBc0OqQyNL7JPrjzqIlukZV1Z8aInEMgLbbPqnghVw4jLM56OVWGjN+JWo7iZG6++VZ8gOUmbSMn0QftDgLtfxz/AxLGy+mHsaYvkLQaEWHAMFOnJkX/M4nw6veY7Vpn5X7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LP5Y9LRR; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB4FD20004;
	Fri,  6 Dec 2024 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733477505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhl1glo23kEyaFy/pfMI3lEQzBsfPSd7YOkvafJRzls=;
	b=LP5Y9LRRIPLgtvbA4mwZt1RNAcZeItRy+LPWRtoEC3s3mfZvNg9aFiQrZ9v6y1urbYFkxq
	v/fhFrGF7kYVo+ZmcVS+oCWKfsNqd/Hh3hhVJkeLuiM4jkxdW5L5v8YR723fbljQwkzDjH
	AJIDpUa/QbqAR5+qLqYVQIP9ZupWsiWhxBrWkIyRzOsLNU3BStH45XST+e2tRUyy7hRByG
	oLBkymrXCYDDUMJeIvrTunnc4nOvG4tNSx8/0F/Wf6YhmWArNEvytBaPTz1uSpyMpiQifX
	7DuPQuSTAP7WPJa6Urk+2DuSAXqVZp8ChrtDmn+TRfNdm1Po1Ek9qpj1W3yhsg==
Date: Fri, 6 Dec 2024 10:31:43 +0100
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
Message-ID: <20241206103143.755f5e87@booty>
In-Reply-To: <20241204124826.2e055091@booty>
References: <20241030171009.1853340-1-saravanak@google.com>
	<20241204124826.2e055091@booty>
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

Hi Saravana,

On Wed, 4 Dec 2024 12:48:26 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Hello Saravana,
>=20
> +Cc. DT maintainers, Herv=C3=A9
>=20
> On Wed, 30 Oct 2024 10:10:07 -0700
> Saravana Kannan <saravanak@google.com> wrote:
>=20
> > In attempting to optimize fw_devlink runtime, I introduced numerous cyc=
le
> > detection bugs by foregoing cycle detection logic under specific
> > conditions. Each fix has further narrowed the conditions for optimizati=
on.
> >=20
> > It's time to give up on these optimization attempts and just run the cy=
cle
> > detection logic every time fw_devlink tries to create a device link.
> >=20
> > The specific bug report that triggered this fix involved a supplier fwn=
ode
> > that never gets a device created for it. Instead, the supplier fwnode is
> > represented by the device that corresponds to an ancestor fwnode.
> >=20
> > In this case, fw_devlink didn't do any cycle detection because the cycle
> > detection logic is only run when a device link is created between the
> > devices that correspond to the actual consumer and supplier fwnodes.
> >=20
> > With this change, fw_devlink will run cycle detection logic even when
> > creating SYNC_STATE_ONLY proxy device links from a device that is an
> > ancestor of a consumer fwnode.
> >=20
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d27=
6@ideasonboard.com/
> > Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of ove=
rlapping cycles")
> > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com> =20
>=20
> After rebasing my work for the hotplug connector driver using device
> tree overlays [0] on v6.13-rc1 I started getting these OF errors on
> overlay removal:
>=20
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/panel-dsi-lvds
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/backlight-addon
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/battery-charger
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/regulator-addon-5v0-sys
> OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/o=
f_node_put() unbalanced - destroy cset entry: attach overlay node /addon-co=
nnector/devices/regulator-addon-3v3-sys
>=20
> ...and many more. Exactly one per each device in the overlay 'devices'
> node, each implemented by a platform driver.
>=20
> Bisecting found this patch is triggering these error messages, which
> in fact disappear by reverting it.
>=20
> I looked at the differences in dmesg and /sys/class/devlink/ in the
> "good" and "bad" cases, and found almost no differences. The only
> relevant difference is in cycle detection for the panel node, which was
> expected, but nothing about all the other nodes like regulators.
>=20
> Enabling debug messages in core.c also does not show significant
> changes between the two cases, even though it's hard to be sure given
> the verbosity of the log and the reordering of messages.
>=20
> I suspect the new version of the cycle removal code is missing an
> of_node_get() somewhere, but that is not directly visible in the patch
> diff itself.

I collected some more info by adding a bit of logging for one of the
affected devices.

It looks like the of_node_get() and of_node_put() in the overlay
loading phase are the same, even though not completely in the same
order. So after overlay insertion we should have the same refcount with
and without your patch.

There is a difference on overlay removal however: an of_node_put() call
is absent with 6.13-rc1 code (errors emitted), and becomes present by
just reverting your patch (the "good" case). Here's the stack trace of
this call:

 Call trace:
  show_stack+0x20/0x38 (C)
  dump_stack_lvl+0x74/0x90
  dump_stack+0x18/0x28
  of_node_put+0x50/0x70
  platform_device_release+0x24/0x68
  device_release+0x3c/0xa0
  kobject_put+0xa4/0x118
  device_link_release_fn+0x60/0xd8
  process_one_work+0x158/0x3c0
  worker_thread+0x2d8/0x3e8
  kthread+0x118/0x128
  ret_from_fork+0x10/0x20

So for some reason device_link_release_fn() is not leading to a
of_node_put() call after adding your patch.

Quick code inspection did not show any useful info for me to understand
more.

Ideas?

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


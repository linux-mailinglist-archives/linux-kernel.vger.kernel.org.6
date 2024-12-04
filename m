Return-Path: <linux-kernel+bounces-431897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9C9E45E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D266ABC735A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D571239195;
	Wed,  4 Dec 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NrB/wZga"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFD211489
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332452; cv=none; b=Sa3HQYu9dFWIRo5O2lwzdbMOx1TUvQxFpglyiL/B+rLnx9K1HnUDc0+UYsrDXJiM8DmdIwL9noVVBMJ36yaSgtUSKub7ZcKayA9mlrQ9XLCk6QYpm9JJtx5s5TdKD1Bb4+UTrsUEvub29epG+Tm2F4ibBwWxDHtfcp91OpZyEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332452; c=relaxed/simple;
	bh=Ew39j4rptFmnjXHKC0iR2M1IneuhRBmz1EbEqrrGU0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru1nXe9K2WgT6Ej7rsiRidBAntyoTggDrPtXFt8+FtqIya30BqzcYi9gz6tC36h/bhr41TnHWcglc2L7jophhWwOM0jqGxbpjQ5lhmmqHBaJCFIy+bbxI0Juo5DrT4yI3xLL2VfID4BZwzJ4G8KGccQJCtT8CTWdzdb7RXVRYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NrB/wZga; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C2F34000A;
	Wed,  4 Dec 2024 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733332448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ew39j4rptFmnjXHKC0iR2M1IneuhRBmz1EbEqrrGU0A=;
	b=NrB/wZgaik00gmlgN1/tNVZh79DyQB1fsObYlOucrNizVYlhzZOqKzkyU3SDKA7SO9INVl
	9SePLUFQo3Teczb9XUb9kGxltxmBYU0Wnj4le0nB93EBvtOyyqjTGLjUo2O+YLdQ65pNqm
	Pbb8Vcq8QbM1AwDwHY/7G/XeSUiWCupeLRVr9YCRqGTIXbAhEcz98Yp8ST5OgIG0VVyXpJ
	AxPHYy1X/l5eoBx0f9e72DjE7NbqxL7y+QKwHHaa4pOxRzDGKoIkVUdhj+ljV3QR0fhcWd
	pcQBCzbIH3JarQ3CPoqKRlnl8v/Mj6rgYfdzS0VcwNW+gI5zX8DCZneuBueT7Q==
Date: Wed, 4 Dec 2024 18:14:05 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Francesco <francesco.dolcini@toradex.com>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley
 <conor@kernel.org>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize
 cycle detection logic
Message-ID: <20241204181405.2ff902c1@booty>
In-Reply-To: <CAMuHMdWaBn9PuEqiH2dekDzOLXeqn1KTT_x3qq7Zk_KUxg2qeQ@mail.gmail.com>
References: <20241030171009.1853340-1-saravanak@google.com>
	<20241204124826.2e055091@booty>
	<CAMuHMdWaBn9PuEqiH2dekDzOLXeqn1KTT_x3qq7Zk_KUxg2qeQ@mail.gmail.com>
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

Hi Geert,

thanks for your feedback.

On Wed, 4 Dec 2024 13:52:56 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Luca,
>=20
> On Wed, Dec 4, 2024 at 12:48=E2=80=AFPM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> > On Wed, 30 Oct 2024 10:10:07 -0700
> > Saravana Kannan <saravanak@google.com> wrote:
> > =20
> > > In attempting to optimize fw_devlink runtime, I introduced numerous c=
ycle
> > > detection bugs by foregoing cycle detection logic under specific
> > > conditions. Each fix has further narrowed the conditions for optimiza=
tion.
> > >
> > > It's time to give up on these optimization attempts and just run the =
cycle
> > > detection logic every time fw_devlink tries to create a device link.
> > >
> > > The specific bug report that triggered this fix involved a supplier f=
wnode
> > > that never gets a device created for it. Instead, the supplier fwnode=
 is
> > > represented by the device that corresponds to an ancestor fwnode.
> > >
> > > In this case, fw_devlink didn't do any cycle detection because the cy=
cle
> > > detection logic is only run when a device link is created between the
> > > devices that correspond to the actual consumer and supplier fwnodes.
> > >
> > > With this change, fw_devlink will run cycle detection logic even when
> > > creating SYNC_STATE_ONLY proxy device links from a device that is an
> > > ancestor of a consumer fwnode.
> > >
> > > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d=
276@ideasonboard.com/
> > > Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of o=
verlapping cycles")
> > > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com> =20
> >
> > After rebasing my work for the hotplug connector driver using device
> > tree overlays [0] on v6.13-rc1 I started getting these OF errors on
> > overlay removal:
> >
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()=
/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-=
connector/devices/panel-dsi-lvds
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()=
/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-=
connector/devices/backlight-addon
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()=
/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-=
connector/devices/battery-charger
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()=
/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-=
connector/devices/regulator-addon-5v0-sys
> > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()=
/of_node_put() unbalanced - destroy cset entry: attach overlay node /addon-=
connector/devices/regulator-addon-3v3-sys
> >
> > ...and many more. Exactly one per each device in the overlay 'devices'
> > node, each implemented by a platform driver. =20
>=20
> FTR, I am not seeing that when loading/removing
> r8a77990-ebisu-cn41-msiof0-25lc040.dtso
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git=
/commit/?h=3Dtopic/renesas-overlays&id=3Ddd998e8db58b67744eb91f11f13544401c=
975470

This overlay is adding an SPI device. In my overlay I don't have any
SPI devices, but I have I2C and other devices and I'm getting those
errors only about devices implemented by platform drivers. Not sure
that matters, but that's the first difference that came to mind.

Best regards,
Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


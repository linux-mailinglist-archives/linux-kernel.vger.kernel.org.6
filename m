Return-Path: <linux-kernel+bounces-412147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BDA9D0467
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 16:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B521F2184E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288E1D88D5;
	Sun, 17 Nov 2024 15:04:13 +0000 (UTC)
Received: from sundtek.de (sundtek.de [85.10.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95B38DE0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731855853; cv=none; b=L8bEyaYRJBtjZqlr/igq5MHPwNNu3bMv1owyopKR+c5Kasit5ng1GgigYijIdeA1SFtcd4GvN7ZWG4l9p6NkNT01MvPkwo/oMaoe1hE3nuwkgZYTFwqWXwLWJzp8QaUmxjLU2Vz9+LPKtUPzBFv0smUzLj8W9Jrd5Q811rSSHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731855853; c=relaxed/simple;
	bh=A0Nf2h4bLGg3F7hEgVsjh9jEs+/osPSwh4jUOq90zdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXHMh1pY0DptaL2flyBFdOWvajedXp4V/etd6LyiDy+PFz2V4m7YpitZ335irCPUD7acNyaP6LqNJkGtGLYYkXmKayd9DnqfVXiDrMVj+3msBM26grRLv/kWd/Vpley2WZPxQMofYkOcmJvm51smoKMPvIqSu7WPUY4pxMct9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de; spf=pass smtp.mailfrom=sundtek.de; arc=none smtp.client-ip=85.10.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sundtek.de
Received: from Debian-exim by sundtek.de with spam-scanned (Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCgop-005HCt-D0
	for linux-kernel@vger.kernel.org;
	Sun, 17 Nov 2024 16:04:09 +0100
Received: from 1-175-135-24.dynamic-ip.hinet.net ([1.175.135.24] helo=[192.168.2.197])
	by sundtek.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCgom-005HCe-2I;
	Sun, 17 Nov 2024 16:04:04 +0100
Message-ID: <a4199978d55410911a2f51fb8d63bbeb072c227e.camel@sundtek.de>
Subject: Re: Highly critical bug in XHCI Controller
From: Markus Rechberger <linuxusb.ml@sundtek.de>
To: =?UTF-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date: Sun, 17 Nov 2024 23:03:59 +0800
In-Reply-To: <20241117153507.4daaa9f0@foxbook>
References: <20241117153507.4daaa9f0@foxbook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: linuxusb.ml@sundtek.de
X-SA-Exim-Scanned: No (on sundtek.de); SAEximRunCond expanded to false

On Sun, 2024-11-17 at 15:35 +0100, Micha=C5=82 Pecio wrote:
> Hi,
>=20
> > Basically the issue comes from hub_port_connect.
> >=20
> > drivers/usb/core/hub.c
> >=20
> > hub_port_init returns -71 -EPROTO and jumps to loop
> > https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5=
450
> >=20
> > I'd question if usb_ep0_reinit is really required in loop which is
> > running following functions:
> > =C2=A0=C2=A0=C2=A0 usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
> > =C2=A0=C2=A0=C2=A0 usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
> > =C2=A0=C2=A0=C2=A0 usb_enable_endpoint(udev, &udev->ep0, true);
> >=20
> > this is something only experience over the past decades can tell?
> >=20
> > usb_enable_endpoint will trigger xhci_endpoint_reset which doesn't
> > do
> > much, but crashes the entire system with the upstream kernel when
> > it
> > triggers xhci_check_bw_table).
> >=20
> > I removed usb_ep0_reinit here and devices are still workable under
> > various conditions (again I shorted and pulled D+/D- to ground for
> > testing).
>=20
> xHCI isn't the only host controller supported by Linux, and
> usb_ep0_reinit() predates it. Maybe it's pointless today, maybe
> it isn't, but it's not the root cause of your problem anyway.
>=20

exactly, but it shouldn't go there anyway. This section of the code is
only for 'in case an error already happened'.
That's why I'm asking if anyone knows a practical situation where this
is really needed - and did it ever help?
I'm working with USB across many systems for nearly 2 decades and I
never saw any of those fallbacks succeeding. Usually the way to recover
a device which had connection issues was to reconnect the device
completely.

> > The NULL PTR check in xhci_check_bw_table would be a second line
> > of defense but as indicated in the first mail it shouldn't even get
> > there.
>=20
> It's an xHCI bug that BW calculation is attempted on an uninitialized
> device and crashes. Looks like a NULL check somewhere is exactly what
> is needed, or maybe avoid it completely on EP0 (it's probably no-op).
>=20

Yes this would be the second line of defense as indicated in my email
before.
I'm preparing 2 small patches with comments in the code.
One commenting out usb_ep0_reinit and the other one a simple NULL PTR
check - but
again the code shouldn't be executed at all when bw_table =3D=3D NULL
something already
went wrong, the issue should be handled earlier in the code already.

bw_table is not setting itself to NULL or not at all.

Since it's infrastructure code it's a sensitive part.

This issue fully crashed my Asus notebook at least 3 times when working
with a USB ethernet adapter and a USB harddisk. Not only faulty
hardware is causing that problem also simple hotplug connection
problems.

> Other similar bug recently:
> https://lore.kernel.org/linux-usb/D3CKQQAETH47.1MUO22RTCH2O3@matfyz.cz/T/=
#u
>=20
> Yours too should be unique to those Intel Panther Point chipsets.

This is exactly the same problem yes.
The problem will happen with all systems which use the xhci driver.


Best Regards,
Markus

>=20
> > As a second issue I found in usb_reset_and_verify device=20
> > https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L6=
131
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hub_port_init(parent=
_hub, udev, port1, i,
> > &descriptor);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D 0 || ret =3D=3D=
 -ENOTCONN || ret =3D=3D -ENODEV) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > hub_port_init can also return -71 / -EPROTO, the cases should be
> > very
> > rare when usb_reset_and_verify_device is triggered and that
> > happens.
>=20
> Right, and the intent seems to be to simply retry in this case.
>=20
> Regards,
> Michal



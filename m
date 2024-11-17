Return-Path: <linux-kernel+bounces-412155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537539D048E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 16:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19652282646
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC691DA10E;
	Sun, 17 Nov 2024 15:48:13 +0000 (UTC)
Received: from sundtek.de (sundtek.de [85.10.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048CA937
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731858492; cv=none; b=CpfQ8R56yc8LSY9M8vCbUw57frhOP8O/yI/EJr+hILx6Hpi9kwsMqzpQja8LG5GrMJPYVk00zOobqpt9uJ8KptQEymp84B4wKxQlzSEgaloMgsO+w+3uK6zSfDfArEVoiS1lcQXncacC0OiX+1pS8TGv5c3Re4w0osCPrQYsHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731858492; c=relaxed/simple;
	bh=/IHDsnjgxUR494sXeK1ztTpHDUu02FUHdLigtizqgFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/rxlRutH11NmFmxlbztazSUJe/1G7vf499iSnDmpfBELgdHfbPWukSiru4H69yqh8fCVLHQeWmzzRxIV2UH6idwCXzpGZQ4TLp7wxn8tnQJvPN+AYxmlT8SOan/JtqJbPigX+ZIcz7yRF0gFZb55pktMy4eny221EYT44DdN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de; spf=pass smtp.mailfrom=sundtek.de; arc=none smtp.client-ip=85.10.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sundtek.de
Received: from Debian-exim by sundtek.de with spam-scanned (Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tChVP-005Hjz-Hl
	for linux-kernel@vger.kernel.org;
	Sun, 17 Nov 2024 16:48:09 +0100
Received: from 1-175-135-24.dynamic-ip.hinet.net ([1.175.135.24] helo=[192.168.2.197])
	by sundtek.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tChVE-005HjS-GA;
	Sun, 17 Nov 2024 16:47:56 +0100
Message-ID: <35c051354414ae9ef6e6b32b1a15a5dedf471176.camel@sundtek.de>
Subject: Re: Highly critical bug in XHCI Controller
From: Markus Rechberger <linuxusb.ml@sundtek.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 17 Nov 2024 23:47:52 +0800
In-Reply-To: <50f730ae-4918-4dac-88ec-b3632bee67e7@rowland.harvard.edu>
References: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
	 <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>
	 <50f730ae-4918-4dac-88ec-b3632bee67e7@rowland.harvard.edu>
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

On Sun, 2024-11-17 at 10:18 -0500, Alan Stern wrote:
> On Sun, Nov 17, 2024 at 08:44:16PM +0800, Markus Rechberger wrote:
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
>=20
> You mean that usb_ep0_reinit() runs the following, not that the loop=20
> does.
>=20
> > =C2=A0=C2=A0=C2=A0 usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
> > =C2=A0=C2=A0=C2=A0 usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
> > =C2=A0=C2=A0=C2=A0 usb_enable_endpoint(udev, &udev->ep0, true);
> >=20
> > this is something only experience over the past decades can tell?
>=20
> It _is_ necessary, because the maxpacket size of ep0 may change from
> one loop iteration to the next.=C2=A0 Therefore the endpoint must be
> disabled=20
> and re-enabled each time the loop repeats.
>=20
> [Now that I go back through the git log, it appears the only reason
> for=20
> exporting usb_ep0_reinit was so that the WUSB driver could call it --
> see commit fc721f5194dc ("wusb: make ep0_reinit available for
> modules").=C2=A0=20
> Since the kernel doesn't support WUSB any more, we should be able to=20
> stop exporting that function.]

This should only go down there in case an error happened earlier no?
In case the hardware signed up correctly it should not even enter that
code.

My experience is just - reconnect the device in case an error happened
those
workarounds did not work properly for the device I deal with (but yes
that's
why I'm asking - maybe someone else has different hardware with
different
experience).

>=20
> > usb_enable_endpoint will trigger xhci_endpoint_reset which doesn't
> > do
> > much, but crashes the entire system with the upstream kernel when
> > it
> > triggers xhci_check_bw_table).
> >=20
> > I removed usb_ep0_reinit here and devices are still workable under
> > various conditions (again I shorted and pulled D+/D- to ground for
> > testing).
> > The NULL PTR check in xhci_check_bw_table would be a second line of
> > defense but as indicated in the first mail it shouldn't even get
> > there.
> >=20
> >=20
> >=20
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
> If that happens, the loop which this code sits inside will simply=20
> perform another iteration.=C2=A0 That's what=C2=A0 it's supposed to do, n=
ot an=20
> issue at all.
>=20

It doesn't cause any issue yes but it's not correct either.
-EPROTO will be returned if I disconnect or short the device here. So
initially someone
thought he should check for -ENODEV/-ENOTCONN (which should also
indicate that=C2=A0the=C2=A0device is gone), so -EPROTO should also be chec=
ked in
that case.
Otherwise just remove all those error checks.

> Alan Stern
>=20



Return-Path: <linux-kernel+bounces-412101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B09D03E1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B298FB22D48
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3E019049B;
	Sun, 17 Nov 2024 12:44:34 +0000 (UTC)
Received: from sundtek.de (sundtek.de [85.10.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4C17DE2D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731847474; cv=none; b=YECffHTIJtkjl4LhrfyRKHw2w6JBPfIFbXEn7V/9pqwYmFrQx1ccmfrVENPgxutVUiYE0FCH+rQD9EVBVZtgZq33RJpEgQtL4Ztk2aKsjcQ62eW7gxTaIodb49tTWat6LleubAm9eRACzW9ehDMeF4uvtU6dmIQ99ALxAE7hr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731847474; c=relaxed/simple;
	bh=asKngflOHg3AqXqmk3MqCmzpudsM0vyxWdmpokAUyis=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pO/MDTaISk2q581BP6jSVieuHT7422XUqDEdlT+q9zs6C3kodURgpBneMz1xBZ5f0bve3tudUa/r5zDqk8fIvuX2pu5pU+30JWwJiAPflLXz3hTdm0SRssug85nqtoxzfcktvcX1OGqQE6pHdh3DZZVIQno+fulJ28h6yNJAofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de; spf=pass smtp.mailfrom=sundtek.de; arc=none smtp.client-ip=85.10.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sundtek.de
Received: from Debian-exim by sundtek.de with spam-scanned (Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCedg-005FN2-Av
	for linux-kernel@vger.kernel.org;
	Sun, 17 Nov 2024 13:44:30 +0100
Received: from 1-175-135-24.dynamic-ip.hinet.net ([1.175.135.24] helo=[192.168.2.197])
	by sundtek.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCedY-005FMm-TT;
	Sun, 17 Nov 2024 13:44:21 +0100
Message-ID: <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>
Subject: Re: Highly critical bug in XHCI Controller
From: Markus Rechberger <linuxusb.ml@sundtek.de>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 17 Nov 2024 20:44:16 +0800
In-Reply-To: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
References: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
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

Basically the issue comes from hub_port_connect.

drivers/usb/core/hub.c

hub_port_init returns -71 -EPROTO and jumps to loop
https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5450

I'd question if usb_ep0_reinit is really required in loop which is
running following functions:
    usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
    usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
    usb_enable_endpoint(udev, &udev->ep0, true);

this is something only experience over the past decades can tell?

usb_enable_endpoint will trigger xhci_endpoint_reset which doesn't do
much, but crashes the entire system with the upstream kernel when it
triggers xhci_check_bw_table).

I removed usb_ep0_reinit here and devices are still workable under
various conditions (again I shorted and pulled D+/D- to ground for
testing).
The NULL PTR check in xhci_check_bw_table would be a second line of
defense but as indicated in the first mail it shouldn't even get there.



As a second issue I found in usb_reset_and_verify device=20
https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L6131

        ret =3D hub_port_init(parent_hub, udev, port1, i, &descriptor);
        if (ret >=3D 0 || ret =3D=3D -ENOTCONN || ret =3D=3D -ENODEV) {
            break;
        }

hub_port_init can also return -71 / -EPROTO, the cases should be very
rare when usb_reset_and_verify_device is triggered and that happens.


I'm just waiting for comments now since this is some critical piece of
infrastructure code before proceeding with a patch.

On Sun, 2024-11-17 at 15:33 +0800, Markus Rechberger wrote:
> Hi,
>=20
>=20
> the issue was first reported at vdr-portal.de
> https://www-vdr--portal-de.translate.goog/forum/index.php?thread/136541-e=
mpfehlung-dvb-s2-tuner-oder-satip/&postID=3D1376196&_x_tr_sl=3Dde&_x_tr_tl=
=3Den&_x_tr_hl=3Dde&_x_tr_pto=3Dwapp#post1376196
>=20
> we've got around a highly critical bug in the xhci driver.
>=20
> https://sundtek.de/support/uxvd32.txt
>=20
> In xhci.c
>=20
> The bug is still active in Mainline:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/xhci.c#L23=
82
>=20
> static int xhci_check_bw_table(struct xhci_hcd *xhci,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xhci_virt_device *virt_=
dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int old_active_eps)
>=20
> bw_table can end up with a NULL pointer.
>=20
> This problem will lead to a complete kernel crash, rendering the
> entire
> system unusable without any access to the actual linux system.
>=20
> How to trigger the problem?
> Short D+/D- or pull them to ground on a USB device while connecting
> the
> device.
>=20
> The problem can happen due to following cases:
> * a device is getting suddenly disconnected during enumeration
> * a faulty cable
> * a faulty device=20
> * a malicious device triggers this issue on purpose
> * if there are electrical issues during connecting a device.
>=20
> A quick hotfix would be to check if bw_table is NULL in
> xhci_check_bw_table, however the check should be performed earlier -
> in
> the area where bw_table is supposed to be assigned.
>=20
> Best Regards,
> Markus



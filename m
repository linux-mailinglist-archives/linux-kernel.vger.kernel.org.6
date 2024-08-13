Return-Path: <linux-kernel+bounces-284441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74169500FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A28285375
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957818787F;
	Tue, 13 Aug 2024 09:10:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F0186E30
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540259; cv=none; b=shYXej054d4uiR7Srh7ioiCp0N8CDpLg1mhQUtqXdq73i4j1ivsqbz9AqwudmXOZ27fu5G4glCNJi9DFFdNRN3qRHBlI5z/KIHOhBNYA1AwlpM7/BIymn5hlk0G3kwYLPwm3GGkqDQ2KJF68y3eeZ4V+qP9yKw7X9fBnbAMWvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540259; c=relaxed/simple;
	bh=uq+T3EINNxRTXSs8/aHYthjMxmBKRzZAf7Kll6Pufg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ/bQCncgHNs11bHQuo3DoIwc5rpASztRQSwQRl8+cHYsH3NyCw5OuQnRzorEmYAZ4qOyV/U6uTYa61CcnDFsY0OFELTHqX9Ms2K8FbwL+dPVmhS+nVzCvCNLGok4kDGGNRVGc1Ig+nFQcqYAgdUoJIdGpC5e8rqgDaZSxdKGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sdnYK-0002Q5-1M; Tue, 13 Aug 2024 11:10:52 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sdnYJ-0005pK-KQ; Tue, 13 Aug 2024 11:10:51 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sdnYJ-000cGA-1b;
	Tue, 13 Aug 2024 11:10:51 +0200
Date: Tue, 13 Aug 2024 11:10:51 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] usb: gadget: uvc: remove pump worker and
 enqueue all buffers per frame in qbuf
Message-ID: <ZrsjG0b3XFeSRefH@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v3-3-4da7033dd488@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8j8oXWU2QAY203fW"
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v3-3-4da7033dd488@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--8j8oXWU2QAY203fW
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, Jul 27, 2024 at 12:02:38AM +0200, Michael Grzeschik wrote:
>Since we now have at least the amount of requests to fill every frame
>into the isoc queue that is requested with the REQBUFS ioctl, we can
>directly encode all incoming frames into the available requests.
>
>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>
>---
>v1 -> v3: new patch
>---
> drivers/usb/gadget/function/f_uvc.c     |  4 ---
> drivers/usb/gadget/function/uvc.h       |  5 +---
> drivers/usb/gadget/function/uvc_queue.c |  3 +++
> drivers/usb/gadget/function/uvc_v4l2.c  |  3 ---
> drivers/usb/gadget/function/uvc_video.c | 46 +++++-----------------------=
-----
> drivers/usb/gadget/function/uvc_video.h |  1 +
> 6 files changed, 12 insertions(+), 50 deletions(-)
>

This patch is introducing a bug that I have queued in the next series.

I just saw that you picked this series. Could you please drop it and
pick v4 instead? I will just send it out now.

https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v4-0-ca22=
f334226e@pengutronix.de

Besid the mentioned fix, the series is identical.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--8j8oXWU2QAY203fW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAma7IxgACgkQC+njFXoe
LGTXGg//RXAC8POR52MgotKY/b2f79a4B9XRIJCOFtcK5H+xRJ/ZUEzNyagprS5B
b8GptQ4iu+fXOK3p/V9oJ+ywiOsJK4Qq/3JGtgntEr+WCsK/Yat7/xa1WrB4PstD
gGri0S0DARZgu+J/w4WLR5NO8wcqr/2b8KXe6U+jjJ7NRqeP67mV+RTFbCkKdZ/G
ylnf/sWWJ/ZoKXKsKGb53bKufClgiBU8qxes8mfZueauvmUpsEzTYf2sNXFW1iSO
9kmC5RzI1XrzG5bmw88Btp1U2tyYZqnaKq+X99bs+th7Qa2cy1IvzBQ9SgPrLAbB
mJIPpDHcIJHyDtljmnO7Cl+8PdUmXReV561PtEpcI7v5UlQisP4EAHoXp69pDRQZ
xjznDO7ej0M5NBRIzsZ1d/fNmDj0ODTIUy7Q3o9H97Fw4+1ZtAyENrU3lPL4F5PJ
poAfSodkR0tjq4hjKlPzuJU/m+5MgB27g+UtbOSt0LGxSygLKvCM4Ee2u7re43yZ
C2lwC6SYH5e2BFWFcu38SHZZAqOvks6I5zpep9Z5FXwopzH19oX5iqYryM5bXJue
qrEx6tw5hl5C3C1issTTOLBi0Zgccv8/bxt6k587XXxz00wPpYvkRF5ZRZINI9r5
DmR44iWywWSdeGyFFfaTQpj9XA2et8XAo5YY8qnlIZFLNHa9OT0=
=X5Qu
-----END PGP SIGNATURE-----

--8j8oXWU2QAY203fW--


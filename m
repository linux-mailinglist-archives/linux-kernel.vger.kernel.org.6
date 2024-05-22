Return-Path: <linux-kernel+bounces-186563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762028CC5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7776C1C215FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2518143C5B;
	Wed, 22 May 2024 17:38:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2682862
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399500; cv=none; b=Q0nF7rIcRmGHQHDrvhmpY+qd6yco3/Mi8fXg7/ox7QsYtFH6UZ7/i2mj8NLFDAQ1WfdNqHygvCXQh6Uwfp2IV+GRiNz5G2jj3V1TRJY2wC/6Axbw5gnL9lyJwdsjSVcJM7AHdXGMkDRaUbWiE0JPHT0aM9OgbMlAnwEwH0PjeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399500; c=relaxed/simple;
	bh=2C1MrL6VrEGrQifZYSpph07toGJPn6imKhGMsEe1EaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2jHMqhGjya3uuVpnFENUQQhzc5b/gWA7AnnDhx1nH9W7C/OkL1+2GKWloJUUwO5mY+LcFJXxtZ8IdIz2DuUuNOcZ46USwn9KJuaRFZnQZc3V5REb7tSg7wZ7pJaE6L9SbpztUBsU6Oq1jjWC4CwaqHRXvj3QKHRrKqbOTr03aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9pub-0005XM-1A; Wed, 22 May 2024 19:38:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9puZ-002YUa-Af; Wed, 22 May 2024 19:37:59 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9puZ-0081fV-0l;
	Wed, 22 May 2024 19:37:59 +0200
Date: Wed, 22 May 2024 19:37:59 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Avichal Rakesh <arakesh@google.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jayant Chowdhary <jchowdhary@google.com>,
	"etalvala@google.com" <etalvala@google.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Message-ID: <Zk4td_0RR0cMJKro@pengutronix.de>
References: <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KlD9DUoS1lZZbWhj"
Content-Disposition: inline
In-Reply-To: <20240522171640.iuol4672rnklc35g@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--KlD9DUoS1lZZbWhj
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>On Wed, May 22, 2024, Alan Stern wrote:
>> On Wed, May 22, 2024 at 01:41:42AM +0000, Thinh Nguyen wrote:
>> > On Wed, May 22, 2024, Michael Grzeschik wrote:
>> > > On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>> > > > For isoc endpoint IN, yes. If the host requests for isoc data IN w=
hile
>> > > > no TRB is prepared, then the controller will automatically send 0-=
length
>> > > > packet respond.
>> > >
>> > > Perfect! This will help a lot and will make active queueing of own
>> > > zero-length requests run unnecessary.
>> >
>> > Yes, if we rely on the current start/stop isoc transfer scheme for UVC,
>> > then this will work.
>>
>> You shouldn't rely on this behavior.  Other device controllers might not
>> behave this way; they might send no packet at all to the host (causing a
>> USB protocol error) instead of sending a zero-length packet.
>
>I agree. The dwc3 driver has this workaround to somewhat work with the
>UVC. This behavior is not something the controller expected, and this
>workaround should not be a common behavior for different function
>driver/protocol. Since this behavior was added a long time ago, it will
>remain the default behavior in dwc3 to avoid regression with UVC (at
>least until the UVC is changed). However, it would be nice for UVC to
>not rely on this.

With "this" you mean exactly the following commit, right?

(f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the active=
 xfer)

When we start questioning this, then lets dig deeper here.

With the fast datarate of at least usb superspeed shouldn't they not all
completely work asynchronous with their in flight trbs?

In my understanding this validates that, with at least superspeed we are
unlikely to react fast enough to maintain a steady isoc dataflow, since
the driver above has to react to errors in the processing context.

This runs the above patch (f5e46aa4) a gadget independent solution
which has nothing to do with uvc in particular IMHO.

How do other controllers and their drivers work?

>Side note, when the dwc3 driver reschedules/starts isoc transfer again,
>the first transfer will be scheduled go out at some future interval and
>not the next immediate microframe. For UVC, it probably won't be a
>problem since it doesn't seem to need data going out every interval.

It should not make a difference. [TM]

>>
>> On the other hand, it may not make any difference.  The host's UVC
>> driver most likely won't care about the difference between no packet and
>> a 0-length packet.  :-)
>>
>> Alan Stern

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--KlD9DUoS1lZZbWhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZOLXMACgkQC+njFXoe
LGTrlw//acfVnAqXm30yItASBO4NznjTsgBCE37biI3jt0FeeUjN8IG1K5uSTyme
yRs7UsOhZE9Me82unKkoyKtv66lTfoWmC7CExQ5jk1WQLX+mYhEj5SaGvHMawH29
w7WhxbO/8VeeQxcLC/GBP9KYn+bPWtkw4HgUo729EZbAPHPi1G6XDGYbMlAqM56R
nKAtE00l5HNMXqAGIjpbiz+NVkQGMjvawhWbuqDTGZKP1eBtug6b7WSkno8OO0NP
Y42jtmRMhftj19KeXepFGD7Mgj4+YiaOUjtLxV2RdQ9i4VW9WJrCEdXApt1yaN3Z
UBFR5p9JyGEKFcTGX8sNETAUvAVEI2bNbg1kmiP83owosR+Bsw5srkaV7vic8HHB
u50xxeVjVAAa3D3lo6ZQ+QGCbH5fIYxSjWtRTANRAETSIUS1M6yCRRVm00AiuY0J
KVVzRYeeZiqqOB1JwXB8egv3eAuM8sVgkWBWZWkkqqNjsXTxaVZvHxSbT648+mJ3
O3lfQTxkQD0E3wowqi3bcLR6seXQXMYl3ecnWsV8Kg83svk0NKTPS4Yq/e3HfBFr
XbqvQnc10TFPr+2Bk6HXYjAq4Vhc07P4rN8r+OKLiKCLwod6YJX0BwNET1vQ2WQH
QahUngNv7o+h5uT6QKVM7vBVkMqESbvi1JDOoofdXmAyUlZf6Pk=
=UQf6
-----END PGP SIGNATURE-----

--KlD9DUoS1lZZbWhj--


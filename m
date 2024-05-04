Return-Path: <linux-kernel+bounces-168849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 591FF8BBED7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8FC1C20B88
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577C84FC5;
	Sat,  4 May 2024 23:45:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED084A52
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714866315; cv=none; b=AVFCQBeLUsX6CxmYUze4hVEkuxocPC7WA5/Segczkox1nFRcPI4WUj2WdWoQEXT+jSMQf7UVVzkuk7i3FCq9paM93P+gCPB7/mxW3gDYibR80uz1tjbpTw24hdpkCtq605d1MrM95CA9eHOjrW/2TWFKW9LrKHo2bdy1/ZzxGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714866315; c=relaxed/simple;
	bh=6NRranRUZtEu76ufx1GqSpQk/+a7exiuutmo9+O/V4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs66w/K7VG1XPUpDoOjmxFj4Jkb7XX5P75Lv8EsEONcELXHWO1LjzCGvgYzKLmovHUjQME8JAp25SnOx/i3cwFmcGqLKh0bKKlHoINj8bNbEnBz6+6gQXU4cRsYR1NvKyO78CblI6Bb+vyhGG+s9Wxd+LZGREYzpWtFES2oUZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s3P3s-0005PE-2i; Sun, 05 May 2024 01:45:00 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s3P3q-00FzBb-UE; Sun, 05 May 2024 01:44:58 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s3P3q-00BjLU-2k;
	Sun, 05 May 2024 01:44:58 +0200
Date: Sun, 5 May 2024 01:44:58 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Message-ID: <ZjbIeib2UMta7FbY@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
 <Zie5sN473m2rgNTK@pengutronix.de>
 <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pLoVn6qsK0dxz8GE"
Content-Disposition: inline
In-Reply-To: <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--pLoVn6qsK0dxz8GE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 01:51:01AM +0000, Thinh Nguyen wrote:
>On Tue, Apr 23, 2024, Michael Grzeschik wrote:
>> Hi Thinh,
>>
>> On Thu, Apr 04, 2024 at 12:29:14AM +0000, Thinh Nguyen wrote:
>> > On Tue, Apr 02, 2024, Thinh Nguyen wrote:
>> > > On Tue, Apr 02, 2024, Thinh Nguyen wrote:
>> > > > My concern here is for the case where transfer_in_flight =3D=3D tr=
ue and
>> > >
>> > > I mean transfer_in_flight =3D=3D false
>> > >
>> > > > list_empty(started_list) =3D=3D false. That means that the request=
s in the
>> > > > started_list are completed but are not given back to the gadget dr=
iver.
>> > > >
>> > > > Since they remained in the started_list, they will be resubmitted =
again
>> > > > on the next usb_ep_queue. We may send duplicate transfers right?
>> >
>> > Actually, since the requests are completed, the HWO bits are cleared,
>> > nothing is submitted and no duplicate. But since the requests are not
>> > given back yet from the started_list, then the next Start_Transfer
>> > command will begin with the TRB address of the completed request
>> > (HWO=3D0), the controller may not process the next TRBs. Have you test=
ed
>> > this scenario?
>> >
>> > > >
>> > > > You can try to cleanup requests in the started_list, but you need =
to be
>> > > > careful to make sure you're not out of sync with the transfer comp=
letion
>> > > > events and new requests from gadget driver.
>> > > >
>> >
>> > Was the problem you encounter due to no_interrupt settings where the
>> > it was set to the last request of the uvc data pump?
>> >
>> > if that's the case, can UVC function driver make sure to not set
>> > no_interrupt to the last request of the data pump from the UVC?
>>
>> Actually no. What I want to do is to ensure that the dwc3 stream
>> is stopped when the hardware was drained. Which is a valid point
>> in my case. Since we are actually potentially enqueueing new request
>> in the complete handler, be it zero length or real transfers.
>>
>> Calling kick_transfer on an drained hw will absolutely run into
>> missed isocs if the irq thread was called late. We saw this on real hard=
ware,
>> where another irq_thread was scheduled with the same priority as the
>> dwc3 irq_thread but was running so long that the HW was running dry in
>> between the hw irq and the actual dwc3_irq_thread run.
>>
>
>Right. Unfortunately, dwc3 can only "guess" when UVC function stops
>pumping more request or whether it's due to some large latency. The
>logic to workaround this underrun issue will not be foolproof. Perhaps
>we can improve upon it, but the solution is better implement at the UVC
>function driver.

Yes, the best way to solve this is in the uvc driver.

>I thought we have the mechanism in UVC function now to ensure queuing
>enough zero-length requests to account for underrun/latency issue?
>What's the issue now?

This is actually only partially true. Even with the zero-length packages
it is possible that we run into underruns. This is why we implemented
this patch. This has happened because another interrupt thread with the
same prio on the same CPU as this interrupt thread was keeping the CPU
busy. As the dwc3 interrupt thread get to its call, the time was already
over and the hw was already drained, although the started list was not
yet empty, which was causing the next queued requests to be queued to
late. (zero length or not)

Yes, this needed to be solved on the upper level first, by moving the
long running work of the other interrupt thread to another thread or
even into the userspace.

However I thought it would be great if we could somehow find out in
the dwc3 core and make the pump mechanism more robust against such
late enqueues.

This all started with that series.

https://lore.kernel.org/all/20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0b=
a2b7@pengutronix.de/

And patch 2 of this series did work well so far. The next move was this
patch.

Since the last week debugging we found out that it got other issues.
It is not allways save to read the HWO bit, from the driver.

Turns out that after an new TRB was prepared with the HWO bit set
it is not save to read immideatly back from that value as the hw
will be doing some operations on that exactly new prepared TRB.

We ran into this problem when applying this patch. The trb buffer list
was actually filled but we hit a false positive where the latest HWO bit
was 0 (probably due to the hw action in the background) and therefor
went into end transfer.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--pLoVn6qsK0dxz8GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmY2yHgACgkQC+njFXoe
LGRSaxAAxhBtE6gNRWYO1/UABS9K/sdIsmrSKNvVz9fOIYkEbrulPeJkOG/jJal4
rWsVidfcLmgcOIJqn1kQG/K6qxWnojSURVSnhYueHPfIim/lakNyDspMfUwnf3nh
gm3vaoGR7J3bX0wBIIIHAq8v3Js1qoeMHGgq/sw54OLqkIMn1s8nF2AID6PUxU7H
CZtXz3YtcO5uWd4BK6krSrZd8+4jDRmab40iSMfOHYX79/a9hsy85gXuSOUV+wuz
XVgeujs0iQnK8CY1hY3M9lAU6iE/ftUiQOqu70fmqASz6x7v3OYiwxrdc8bnjfKO
5w44jXALoTjiyXDXsHH6/SwjdsT1zcgta0Xf6wKZSEp075c/LJ4w1dlb1Syh4k5H
c7P10eO7xEogcd0uvYhCTDYAM1HlYU5MHt33+5KX88zlpIrbcy0t/mXiWnB8Hfdf
BomDWOUskARk5S9EH7hobUEQSHYpEQT66WoJlhNVsf57GsAlxhoxraHbJ6ByDr9W
fYgAA71tG9agpcFWWwxtQ9RDQ/kg3qp5euA8HbC5TGkAXKXYy6TfsrVpLIlk+tB8
maR/dm2UBWQ9Wrlgn2F9Xb3DXhaszNkHi8SlBgMN/mvNcXg7luxYMg6yuCl+XLTK
sLxDy5gdxqpqdbuIeWo591ZCrRyIjeh6F2aF/QuHIzgRTqFmwAM=
=Uzn2
-----END PGP SIGNATURE-----

--pLoVn6qsK0dxz8GE--


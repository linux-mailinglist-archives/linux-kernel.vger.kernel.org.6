Return-Path: <linux-kernel+bounces-193029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E532D8D25C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D7A1C23116
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F02178CF2;
	Tue, 28 May 2024 20:22:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0682FB2
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927743; cv=none; b=JblxUQLRGdxVrLrWpu9BiRhI3Y7kwD3REMh+qaPpu6BGyzlN7HzhbFrv5OrRWwwpDrG4XTEx3ofuEfr/SNVE48sTMnVo8ZvZCHeieoMIbBTRlD4NIJMNn0HU3hvdGWCryLv0J5I3cKVBPBWz4Q7JBqgBvO7rHROOwoqBQS/8/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927743; c=relaxed/simple;
	bh=foz55xSb6MbyEbShSXhvbOWfI0jZsQ4O3qOoukESY3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAOJmyRMGYkSzb95oCLiuZBGOsg4N+nC/mV+rRK4O8jciABU7c0gVsuyFpfcHFv0puGDtyZR7EGtkc9Rya1+xpyC4EmOspOwIS987udJjnsXQnQldOLFMYRGHvlXzDDlID+s+pLWCJo9ZulHnauahnEka9A0JOC8stT2pKLSNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sC3Kj-0006kY-Hs; Tue, 28 May 2024 22:22:09 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sC3Ki-003N8c-7X; Tue, 28 May 2024 22:22:08 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sC3Ki-001SGY-0S;
	Tue, 28 May 2024 22:22:08 +0200
Date: Tue, 28 May 2024 22:22:08 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Avichal Rakesh <arakesh@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jayant Chowdhary <jchowdhary@google.com>,
	"etalvala@google.com" <etalvala@google.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Message-ID: <ZlY88BebTEZs6urD@pengutronix.de>
References: <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
 <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MrAzwjbS8yyZ58K2"
Content-Disposition: inline
In-Reply-To: <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--MrAzwjbS8yyZ58K2
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 10:30:30AM -0700, Avichal Rakesh wrote:
>
>
>On 5/22/24 10:37, Michael Grzeschik wrote:
>> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>>> On Wed, May 22, 2024, Alan Stern wrote:
>>>> On Wed, May 22, 2024 at 01:41:42AM +0000, Thinh Nguyen wrote:
>>>> > On Wed, May 22, 2024, Michael Grzeschik wrote:
>>>> > > On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>>>> > > > For isoc endpoint IN, yes. If the host requests for isoc data IN=
 while
>>>> > > > no TRB is prepared, then the controller will automatically send =
0-length
>>>> > > > packet respond.
>>>> > >
>>>> > > Perfect! This will help a lot and will make active queueing of own
>>>> > > zero-length requests run unnecessary.
>>>> >
>>>> > Yes, if we rely on the current start/stop isoc transfer scheme for U=
VC,
>>>> > then this will work.
>>>>
>>>> You shouldn't rely on this behavior.=A0 Other device controllers might=
 not
>>>> behave this way; they might send no packet at all to the host (causing=
 a
>>>> USB protocol error) instead of sending a zero-length packet.
>>>
>>> I agree. The dwc3 driver has this workaround to somewhat work with the
>>> UVC. This behavior is not something the controller expected, and this
>>> workaround should not be a common behavior for different function
>>> driver/protocol. Since this behavior was added a long time ago, it will
>>> remain the default behavior in dwc3 to avoid regression with UVC (at
>>> least until the UVC is changed). However, it would be nice for UVC to
>>> not rely on this.
>>
>> With "this" you mean exactly the following commit, right?
>>
>> (f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the act=
ive xfer)
>>
>> When we start questioning this, then lets dig deeper here.
>>
>> With the fast datarate of at least usb superspeed shouldn't they not all
>> completely work asynchronous with their in flight trbs?
>>
>> In my understanding this validates that, with at least superspeed we are
>> unlikely to react fast enough to maintain a steady isoc dataflow, since
>> the driver above has to react to errors in the processing context.
>>
>> This runs the above patch (f5e46aa4) a gadget independent solution
>> which has nothing to do with uvc in particular IMHO.
>>
>> How do other controllers and their drivers work?
>>
>>> Side note, when the dwc3 driver reschedules/starts isoc transfer again,
>>> the first transfer will be scheduled go out at some future interval and
>>> not the next immediate microframe. For UVC, it probably won't be a
>>> problem since it doesn't seem to need data going out every interval.
>>
>> It should not make a difference. [TM]
>>
>
>
>Sorry for being absent for a lot of this discussion.
>
>I want to take a step back from the details of how we're
>solving the problem to what problems we're trying to solve.
>
>So, question(s) for Michael, because I don't see an explicit
>answer in this thread (and my sincerest apologies if they've
>been answered already and I missed it):
>
>What exactly is the bug (or bugs) we're trying to solve here?
>
>So far, it looks like there are two main problems being
>discussed:
>
>1. Reducing the bandwidth usage of individual usb_requests
>2. Error handling for when transmission over the wire fails.
>
>Is that correct, or are there other issues at play here?

That is correct.

>(1) in isolation should be relatively easy to solve: Just
>smear the encoded frame across some percentage
>(prefereably < 100%) of the usb_requests in one
>video frame interval.

Right.

>(2) is more complicated, and your suggestion is to have a
>sentinel request between two video frames that tells the
>host if the transmission of "current" video frame was
>successful or not. (Is that correct?)

Right.

>Assuming my understanding of (2) is correct, how should
>the host behave if the transmission of the sentinel
>request fails after the video frame was sent
>successfully (isoc is best effort so transmission is
>never guaranteed)?

If we have transmitted all requests of the frame but would only miss the
sentinel request to the host that includes the EOF, the host could
rather show it or drop it. The drop would not be necessary since the
host did see all data of the frame. The user would not see any
distortion in both cases.

If we have transmitted only partial data of the frame it would be
preferred if the host would drop the frame that did not finish with an
proper EOF tag.

AFAIK the linux kernel would still show the frame if the FID of the
currently handled request would change and would take this as the end of
frame indication. But I am not totally sure if this is by spec or
optional.

One option to be totally sure would be to resend the sentinel request to
be properly transmitted before starting the next frame. This resend
polling would probably include some extra zero-length requests. But also
if this resend keeps failing for n times, the driver should doubt there
is anything sane going on with the USB connection and bail out somehow.

Since we try to tackle case (1) to avoid transmit errors and also avoid
creating late enqueued requests in the running isoc transfer, the over
all chance to trigger missed transfers should be minimal.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--MrAzwjbS8yyZ58K2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZWPOwACgkQC+njFXoe
LGTvhBAAy9AMYMKC2c7DAvrCWYPZmgN9LGzTAIDAl74Q8Y0o0hXnjNCu39aUhHHi
2eTBrhONO8fL5yxo+g2UyPLvGo2alitUjeNtVTW7A7cjI6T9yw/fyeDabI5R5ZR2
s99M6MsqebgtoyYN2qE2/YyXGZ5evu89OMIUpTUg2a0fwhP41A18s345XQvoKvCA
dRYLOAcZsyFxACQrsEsBJ1v5nn/ik5x96AP2xwxxw12MgMYWhIeeAc6rm7fWLfsZ
GVTMPNQmGv1NM2RYpGEHu3gohxP/vAQM0c992cOd3PjcBZpJ4GRRP8JWowbGzMLo
NkNBsorwOvorPyZn0ZCiZAJXgWV3wXW8YXwNkM8RVrYyfl0S3syE7K65JJAnJEiA
CAAk35AWyqWFx6rYA32eno7L0EjO0onpqjZCylwWOv2IKGs8tBrmFLiJHOhrXeal
BWRrapEFkRItE0VSVeg2zuZXwZhK5c87xC8AD3P9YmNm4JaM1n+3FCBr/Fts+fWN
P7LFIgmmzCMf2wilVecdZEZWYWXdD0WugUcC+9XOcjxNKgVBItYTEuzE+F4wYKDm
gPfyRVG7PHvFS7MPVFSRgCz0KhJ/7JKB7zylD5391aAxKxjkhzBEZulJjKuMo2tE
aV4uKpKmxjwf00gnWqv2Nwj0nxEP7fkxRgA62w1kbuXGi/ZJHxc=
=IBV5
-----END PGP SIGNATURE-----

--MrAzwjbS8yyZ58K2--


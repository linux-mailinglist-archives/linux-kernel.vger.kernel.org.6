Return-Path: <linux-kernel+bounces-173938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E918C07E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75B9283FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4413340B;
	Wed,  8 May 2024 23:42:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AC7D3E0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211741; cv=none; b=rwF/Lminz5R9LE+KAO9lVP+6bOoAzZZV8Wu3FuNgEpmurogatStQfrmNFzdK4xYPkV0YKGrgzE+kEth3Te21VTVNK8X2y8Rh8eyJpyv2C7LKVv9jR34jVp/DH9vkuIQt/lgXZ3fJlXacatKVoBxQMn8kEX/DXkkn/TBmsBa5CKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211741; c=relaxed/simple;
	bh=U5l9NaVPQYYnsjO5onFdxkn95B+7N+E4Z8nCr6buJlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3/7iUUqlrUtIv7g5c/htR3K6yNF1cX0t7x1wNBw4gn9eJ0Bn15IK9d6QPrss7Nrb13UTFIn/GleNUR7xpJZ6PsUj14Teo+BPDlPkQDMHS/TFwWR4SJkkeYfpFMzywGouNiyII/Dt+kITnoQLvfHpuzVtyH+fmznkuLKTSR/YL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4qvL-0001p6-Fz; Thu, 09 May 2024 01:42:11 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4qvJ-000MCM-EU; Thu, 09 May 2024 01:42:09 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4qvJ-000k4g-19;
	Thu, 09 May 2024 01:42:09 +0200
Date: Thu, 9 May 2024 01:42:09 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"michael.riesch@wolfvision.net" <michael.riesch@wolfvision.net>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Message-ID: <ZjwN0Zp03a1XuQij@pengutronix.de>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
 <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
 <ZjvuoVpVTnEcHRIH@pengutronix.de>
 <20240508231950.ifyawl6bfy6bzvk7@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="is7zaTMiC0FWMD1P"
Content-Disposition: inline
In-Reply-To: <20240508231950.ifyawl6bfy6bzvk7@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--is7zaTMiC0FWMD1P
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 11:20:03PM +0000, Thinh Nguyen wrote:
>On Wed, May 08, 2024, Michael Grzeschik wrote:
>> On Tue, May 07, 2024 at 11:57:36AM -0700, Wesley Cheng wrote:
>> > Hi Michael,
>> >
>> > On 5/6/2024 4:06 PM, Michael Grzeschik wrote:
>> > > This patch is splitting up the interrupt event handling from one
>> > > interrupt thread to separate per endpoint interrupt threads.
>> > >
>> >
>> > I assume that the incentive from doing this is to improve overall
>> > throughput numbers.  Would you be able to share some data on the
>> > benefits of moving to per EP event management?
>>
>> The main benefit is to make it possible to use high demanding usb
>> endpoints simultaneously. In our special case we saw that streaming
>> via uac and streaming via uvc was producing noise in the audio
>> stream. This was due to the fact, that the isoc feedback endpoint
>> that would adjust the samplerate was not being called fast enough
>> when there was heavy a lot of traffic in the uvc endpoint context.
>>
>> By moving the endpoints into their own thread handlers the short
>> feedback requests are at least able to be scheduled in between the bursts
>> of the uvc packages. The next step is to have all threads running on
>> different cpu cores, without interfering each other. However, as we
>> still have not matrix irq allocator for arm, there still is no direct
>> benefit from that yet.
>>
>>
>> > > To achieve this we create a new dwc3 interrupt domain in which
>> > > we map all claimed interrupts to individual interrupt threads.
>> > >
>> > > Although the gadget layer is preparing the claimed parameter
>> > > of each usb_ep which could be checked if the endpoint is
>> > > to used or not, the claimed value was 0 for each ep in gadget_start.
>> > > This was tested when describing some composite gadget using configfs.
>> > >
>> >
>> > yeah... the claimed flag is cleared by the USB gadget, ie USB configfs
>> > (not sure if you're using this) whenever it adds a USB config.  This is
>> > to handle multi config situations, so subsequent USB configs can be
>> > assigned (resuse) endpoints, since only one config is active at a time
>> > for a USB device.
>> >
>> > This was a struggle for me as well when adding the TXFIFO resizing
>> > logic.  We won't actually know which EPs are going to be used until the
>> > host issues the set configuration packet to select a config, and the
>> > set_alt() callback issues usb_ep_enable().  So the implementation
>> > (TXFIFO resizing) is currently based on the maximum potential endpoints
>> > used by any USB configuration.
>> >
>> > Not sure if having 31 (potentially) different IRQ entries would be ok,
>> > but maybe it would be simpler to just to request IRQ for dwc->num_eps
>> > always?
>> >
>> > Have you tried this on a multi config device?
>>
>> No, I didn't. I doubt that this will work after your explanation. So
>> thanks for the insides!
>>
>> I tried putting the request_threaded_irq into the ep_enable function
>> but this does not work as I see a lot of schedule while atomic
>> errors. This is possible as ep_enable is called from an set alt
>> coming from ep0 interrupt thread context.
>>
>> So there is probably now no other option left to have exact endpoint
>> interrupt threads. I will rework this back to request a kthread for each
>> endpoint even as we will probably would not be using them.
>>
>
>Do you have any data on latency here?

I don't have the exact numbers for the uac feedback isoc endpoint
at the moment. But without the patch applied, it was reproducably
returning with EXDEV when we started uvc streaming and therefor
increased the amount of events per interrupt thread cycle.

With the patch applied however, we are able to only route the events to
the corresponding soft irqs and leave the moment of truth to the
scheduler.

>I don't see how introducing more soft interrupts would improve on
>latency, if anything, it should be worse?

Why should explicit handling of coherent ep events on one cpu core
introduce more latency then by interleaving different events for
arbitrary ep all in one thread?

>This is making the driver way more complicated and potentially
>introduce many bugs.

Possible, but not unsolvable.

>I may be wrong here, but I suspect that by multiplying the interrupt
>handlings, you _may_ see improvement due to the a higher chance being
>selected by the scheduler. However, the overall latency will probably
>be worse. (correct me if I'm wrong).

I doubt that it will be worse if each softirq can be handled on
different cpus at the same time.

>This will affect other applications.

Let's make sure we will not break anything on the way. Okay? :)

>Let's not do this.

I actually thought that this is even requested:

https://docs.kernel.org/usb/dwc3.html

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--is7zaTMiC0FWMD1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmY8Dc4ACgkQC+njFXoe
LGSSug//QXxA/BTR70eG6UNSPPLvi4kZldJ8qCOqHp86o/4vRaTUa1pRky4TVQb+
C59ik7ZvMHMS83nGjqA9T+MK5UmTAfr48PJSla3PAIyr/O8t6vgjYyjeCQNx7yMT
abvjd+xJAkKl0yY0QwXvNPgdrdH+cqWYwPKS6XxY9d3GYomIujYL3lkzXyeP24gt
0DKnpR6T0RX6v/UeqBxQcsF6zJHBqh56Vgl4IuWizCuTdC1ZuumCzw8/u99qFbed
4WLh6p0sbeMkSTEEKOMi9HyvdiEvWK1CpuAkgkASs9deTYDZDzZzDL+ayIg1dVfb
wC/ya2ohhBPX+TAB+nudloyTaqfb9NLlvrvB6Uh2cAz76I96LOnOk0ALnMmF3ebW
Kanj4/TjmIl8SXH5LWWdZ8tYj4IL5pacE1wUMDcPzAfmXQeQmmQtZQPXfZfabK8y
lT07VJOb4cXkMFr1XZUQqQXvlrGj9Qw35HSbLvJ1iiY4sFnDNFkyFiINgt/zIEma
DcFakD/JszCdT0XDdBJEYxO0tK4HrA2gv1f4pAB15Zv4fNzRg3mMx+sPwDcZlh/z
wc9tOzHzBSyTwPCoZ6Uo6js+hoObbcDCgDSLOXLPiYjoLVvqjxqKE4lIm9KzHON+
iP5whUcmsuEX09fMRhs7WB0/93yC3bsbq0JuFBzZuQYpMLS//aA=
=Hx5X
-----END PGP SIGNATURE-----

--is7zaTMiC0FWMD1P--


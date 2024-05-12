Return-Path: <linux-kernel+bounces-177029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D098C389C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D97281D60
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583D54F87;
	Sun, 12 May 2024 21:33:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF034D5B0
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715549591; cv=none; b=QwpmNuI7z1qAO5Qq5zs1hZzaNLFL3IG8S9QD5Zq8INMl5ShQAwTItb+dqdknN9NH5bde0dZ6QDg06xFHU+pC3OaQj++75mXwZpBvpIIkbLvUwvQ5p+ZL/SQTLMN0+jlHxdTfZ8QIb2d5wt1FUdyFFHbQk8LmUdVFwHgH5Yyra74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715549591; c=relaxed/simple;
	bh=qyD64g+gtTWIb6C3r4S6GDbkc52+8LYEktIp3sL18CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edf+93QLBmyJ8Sskh0LgIUE921Ukst1K5dRAT9nSXXhC1Tfaxa3MPHmXgLAWmqKC9NJlE/lEVP1qjEv0XGI569IVuyw2ulu3pfj7ynPde0Ke4oAg4yBp9v7eSFVf7w1q5FSNKcJVxOwJD6SSqnUuojVilm6+j9et/dPTyJaU1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6Gob-0008Lu-7B; Sun, 12 May 2024 23:33:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6GoZ-00135J-Ul; Sun, 12 May 2024 23:33:03 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6GoZ-007la7-2m;
	Sun, 12 May 2024 23:33:03 +0200
Date: Sun, 12 May 2024 23:33:03 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Message-ID: <ZkE1j2DH1TfUGoGi@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
 <Zie5sN473m2rgNTK@pengutronix.de>
 <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
 <ZjbIeib2UMta7FbY@pengutronix.de>
 <20240508230252.wauttsgkp63fpife@synopsys.com>
 <ZjwQkIBUlhl-4ScO@pengutronix.de>
 <20240511005148.zqighnpv2zxboogf@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qg65i6hvpnGuBTbU"
Content-Disposition: inline
In-Reply-To: <20240511005148.zqighnpv2zxboogf@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--Qg65i6hvpnGuBTbU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 12:51:57AM +0000, Thinh Nguyen wrote:
>On Thu, May 09, 2024, Michael Grzeschik wrote:
>> On Wed, May 08, 2024 at 11:03:00PM +0000, Thinh Nguyen wrote:
>> > On Sun, May 05, 2024, Michael Grzeschik wrote:
>> > > On Wed, Apr 24, 2024 at 01:51:01AM +0000, Thinh Nguyen wrote:
>> > > > >
>> > > >
>> > > > Right. Unfortunately, dwc3 can only "guess" when UVC function stops
>> > > > pumping more request or whether it's due to some large latency. The
>> > > > logic to workaround this underrun issue will not be foolproof. Per=
haps
>> > > > we can improve upon it, but the solution is better implement at th=
e UVC
>> > > > function driver.
>> > >
>> > > Yes, the best way to solve this is in the uvc driver.
>> > >
>> > > > I thought we have the mechanism in UVC function now to ensure queu=
ing
>> > > > enough zero-length requests to account for underrun/latency issue?
>> > > > What's the issue now?
>> > >
>> > > This is actually only partially true. Even with the zero-length pack=
ages
>> > > it is possible that we run into underruns. This is why we implemented
>> > > this patch. This has happened because another interrupt thread with =
the
>> > > same prio on the same CPU as this interrupt thread was keeping the C=
PU
>> >
>> > Do you have the data on the worst latency?
>>
>> It was something a bit more then around 2ms AFAIR. Since with one frame
>> enqueued we only trigger the interrupt every 16 requests (16*125us =3D 2=
ms)
>>
>> So with at least 2ms latency we did hit the sweet spot in several cases.
>
>For 2ms, we should be able to handle this with the zero-length requests.

When the interrupt thread is the one that is enqueuing also the
zero-requests (like the uvc_video gadget) is doing now, we won't be able
to do that.

>>
>> > Can this other interrupt thread lower its priority relative to UVC? For
>> > isoc endpoint, data is time critical.
>>
>> The details are not that important. Sure the is a bug, that needed to be
>> solved. But all I wanted is to improve the overal dwc3 driver.
>>
>> > Currently dwc3 can have up to 255 TRBs per endpoint, potentially 255
>> > zero-length requests. That's 255 uframe, or roughly ~30ms. Is your wor=
st
>> > latency more than 30ms? ie. no handling of transfer completion and
>> > ep_queue for the whole 255 intervals or 30ms. If that's the case, we
>> > have problems that cannot just be solved in dwc3.
>>
>> Yes. But as mentioned above, this was not the case. Speaking of, there
>> is currently a bug in the uvc_video driver, that is not taking into
>> acount that actually every zero-length request should without exception
>> need to trigger an interrupt.
>
>Not necessarily, you can send multiple set of zero-length requests
>where, for example, IOC on the last request of the set.

Right. But for this we have to know if the last request that will be
enqueued will be followed by an actual data request. As the uvc_video
gadget is implemented now, we can not do this.

It is only checking if the prepared list is empty and then it is
enqueueing zero or data requests from the complete handler depending
=66rom the outcome. It does not know if on the next enqueue the prepared
list will have some requests ready.

>> Currently we also only scatter them over
>> the 16ms period, like with the actual payload. But since we feed the
>> video stream with the interrupts, we loose 2ms of potential ep_queue
>> calls with actual payload in the worst case.
>>
>> My patch is already in the stack and will be send today.
>>
>> > > busy. As the dwc3 interrupt thread get to its call, the time was alr=
eady
>> > > over and the hw was already drained, although the started list was n=
ot
>> > > yet empty, which was causing the next queued requests to be queued to
>> > > late. (zero length or not)
>> > >
>> > > Yes, this needed to be solved on the upper level first, by moving the
>> > > long running work of the other interrupt thread to another thread or
>> > > even into the userspace.
>> >
>> > Right.
>> >
>> > >
>> > > However I thought it would be great if we could somehow find out in
>> > > the dwc3 core and make the pump mechanism more robust against such
>> > > late enqueues.
>> >
>> > The dwc3 core handling of events and ep_queue is relatively quick. I'm
>> > all for any optimization in the dwc3 core for performance. However, I
>> > don't want to just continue looking for workaround in the dwc3 core
>> > without looking to solve the issue where it should be. I don't want to
>> > sacrifice complexity and/or performance to other applications for just
>> > UVC.
>>
>> I totally understand this. And as we already found out more and more
>> about the underlying complexity of the dwc3 driver I see more and more
>> clearer how we have to handle the corner cases. I just started this
>> conversation with Avichal and you in the other thread.
>>
>> https://lore.kernel.org/all/17192e0f-7f18-49ae-96fc-71054d46f74a@google.=
com/
>>
>> I think there is some work to come. As to be sure that everybody is on
>> the same page I will prepare a roadmap on how to proceed and what to
>> discuss. There are many cases interfering with each other which make the
>> solution pretty complex.
>
>That's great. Let's do that so we can resolve this issue.

Good

>> > > This all started with that series.
>> > >
>> > > https://lore.kernel.org/all/20240307-dwc3-gadget-complete-irq-v1-0-4=
fe9ac0ba2b7@pengutronix.de/
>> > >
>> > > And patch 2 of this series did work well so far. The next move was t=
his
>> > > patch.
>> > >
>> > > Since the last week debugging we found out that it got other issues.
>> > > It is not allways save to read the HWO bit, from the driver.
>> > >
>> > > Turns out that after an new TRB was prepared with the HWO bit set
>> > > it is not save to read immideatly back from that value as the hw
>> > > will be doing some operations on that exactly new prepared TRB.
>> > >
>> > > We ran into this problem when applying this patch. The trb buffer li=
st
>> > > was actually filled but we hit a false positive where the latest HWO=
 bit
>> > > was 0 (probably due to the hw action in the background) and therefor
>> > > went into end transfer.
>> > >
>> >
>> > Thanks for the update.
>>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Qg65i6hvpnGuBTbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZBNYgACgkQC+njFXoe
LGTQlhAA1KrYj8curg6vjJNRmuuBOzP4+enFXjLdJQANcM511UCavg4oSlF8c/iW
AV7kI7vNzwRYg2EqYUBgreIXZWl4JKSc871te3ZOVxe7D9iEVLU2yJAJYC1fLscr
TjH+Sp61V5oQ1igwaqfe9F4Zp2rbFhyqOfKfcWs0T8dxrtt4uLf2vdNh1IcTClFO
wqU9O/6CTS+/8MTJOs30NqasvsdRmFzpKqnS6htUzPAPZzJ4mCNd5/22pXroHuAv
hZcD8rMTgOMgw0B6i7usFuP4bz1etbswvThsqQKBNlvzatv0pAfGThx4WJuJ2vNT
Fp+QSvEDE6CuHtfp5y3nFTfdCraAEY10wD26YLBZTEZuIxxaIiAe5hletcHfGmNQ
WJkzAFXGVwQp1LYkofB8UPh/HP4XliroelHheP1t3SsT7RDRYSmD5LcDE3wwzvXC
hMCng227KYNghELcEywbPTC60NCfWoktHj/VhzKg4+uYtJCtPW+1P2zKeia5vBl1
oLSsQgQmuJ4dm+6JzJQBHswEuHU5CVQDkM4aJoK6sXOPAUJr60oHIuh/qzQwcoeY
LIX5ngk5yFmwGr/80aC620ZhzNJ7rdCgl4UXDuIeKxN6mIVmiO2ZaX2J2jYBFo2P
Ydy59NPo1f5MLbxJ0RSjXEuzYuqOpVEKilqycZSInjxJG207ybg=
=pMov
-----END PGP SIGNATURE-----

--Qg65i6hvpnGuBTbU--


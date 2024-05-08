Return-Path: <linux-kernel+bounces-173951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A98C0824
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F463B21CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B31339AB;
	Wed,  8 May 2024 23:54:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13D1327F2
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212440; cv=none; b=VP/J+oA/VV88/vXR7fkTIGtSAdMUvC/BpMpAoZSD9udq8o1+1S9VX4bCN2YTlwh0+573l674n4uX26IhE/zdGfavrYFnvP7BoodSrfVslr2ctCkjJjiuVHqP3HY6NuFdY6lYhxpw1IFYQ+bkBoK7kXNq7B5K4zhPEDCfQb3pq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212440; c=relaxed/simple;
	bh=sw7/cyRA0+8F6bdwISmbc5OkCJdAWouQOnOBHriBSbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1bigjxPxlaEub296MMBRVlzrFizJ2PNtGbVB1oQ51WTAqmNHfFQIKqjmjiFFP10SUDDu64Dmb5K2ktkhNapdZLGqAJR1w0tfNidn2utnM4/Xj0uOMKO3Zaak8jZu77P01WYzfQ/4Y2ZKT2nMT2KpJuXl4WCCEq04Ush3pkJ4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4r6f-00032N-MT; Thu, 09 May 2024 01:53:53 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4r6f-000MDQ-2h; Thu, 09 May 2024 01:53:53 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4r6f-002HCQ-00;
	Thu, 09 May 2024 01:53:53 +0200
Date: Thu, 9 May 2024 01:53:52 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Message-ID: <ZjwQkIBUlhl-4ScO@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
 <Zie5sN473m2rgNTK@pengutronix.de>
 <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
 <ZjbIeib2UMta7FbY@pengutronix.de>
 <20240508230252.wauttsgkp63fpife@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z7LlYPAU/B3cdMx8"
Content-Disposition: inline
In-Reply-To: <20240508230252.wauttsgkp63fpife@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--Z7LlYPAU/B3cdMx8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 11:03:00PM +0000, Thinh Nguyen wrote:
>On Sun, May 05, 2024, Michael Grzeschik wrote:
>> On Wed, Apr 24, 2024 at 01:51:01AM +0000, Thinh Nguyen wrote:
>> > >
>> >
>> > Right. Unfortunately, dwc3 can only "guess" when UVC function stops
>> > pumping more request or whether it's due to some large latency. The
>> > logic to workaround this underrun issue will not be foolproof. Perhaps
>> > we can improve upon it, but the solution is better implement at the UVC
>> > function driver.
>>
>> Yes, the best way to solve this is in the uvc driver.
>>
>> > I thought we have the mechanism in UVC function now to ensure queuing
>> > enough zero-length requests to account for underrun/latency issue?
>> > What's the issue now?
>>
>> This is actually only partially true. Even with the zero-length packages
>> it is possible that we run into underruns. This is why we implemented
>> this patch. This has happened because another interrupt thread with the
>> same prio on the same CPU as this interrupt thread was keeping the CPU
>
>Do you have the data on the worst latency?

It was something a bit more then around 2ms AFAIR. Since with one frame
enqueued we only trigger the interrupt every 16 requests (16*125us =3D 2ms)

So with at least 2ms latency we did hit the sweet spot in several cases.

>Can this other interrupt thread lower its priority relative to UVC? For
>isoc endpoint, data is time critical.

The details are not that important. Sure the is a bug, that needed to be
solved. But all I wanted is to improve the overal dwc3 driver.

>Currently dwc3 can have up to 255 TRBs per endpoint, potentially 255
>zero-length requests. That's 255 uframe, or roughly ~30ms. Is your worst
>latency more than 30ms? ie. no handling of transfer completion and
>ep_queue for the whole 255 intervals or 30ms. If that's the case, we
>have problems that cannot just be solved in dwc3.

Yes. But as mentioned above, this was not the case. Speaking of, there
is currently a bug in the uvc_video driver, that is not taking into
acount that actually every zero-length request should without exception
need to trigger an interrupt. Currently we also only scatter them over
the 16ms period, like with the actual payload. But since we feed the
video stream with the interrupts, we loose 2ms of potential ep_queue
calls with actual payload in the worst case.

My patch is already in the stack and will be send today.

>> busy. As the dwc3 interrupt thread get to its call, the time was already
>> over and the hw was already drained, although the started list was not
>> yet empty, which was causing the next queued requests to be queued to
>> late. (zero length or not)
>>
>> Yes, this needed to be solved on the upper level first, by moving the
>> long running work of the other interrupt thread to another thread or
>> even into the userspace.
>
>Right.
>
>>
>> However I thought it would be great if we could somehow find out in
>> the dwc3 core and make the pump mechanism more robust against such
>> late enqueues.
>
>The dwc3 core handling of events and ep_queue is relatively quick. I'm
>all for any optimization in the dwc3 core for performance. However, I
>don't want to just continue looking for workaround in the dwc3 core
>without looking to solve the issue where it should be. I don't want to
>sacrifice complexity and/or performance to other applications for just
>UVC.

I totally understand this. And as we already found out more and more
about the underlying complexity of the dwc3 driver I see more and more
clearer how we have to handle the corner cases. I just started this
conversation with Avichal and you in the other thread.

https://lore.kernel.org/all/17192e0f-7f18-49ae-96fc-71054d46f74a@google.com/

I think there is some work to come. As to be sure that everybody is on
the same page I will prepare a roadmap on how to proceed and what to
discuss. There are many cases interfering with each other which make the
solution pretty complex.

>> This all started with that series.
>>
>> https://lore.kernel.org/all/20240307-dwc3-gadget-complete-irq-v1-0-4fe9a=
c0ba2b7@pengutronix.de/
>>
>> And patch 2 of this series did work well so far. The next move was this
>> patch.
>>
>> Since the last week debugging we found out that it got other issues.
>> It is not allways save to read the HWO bit, from the driver.
>>
>> Turns out that after an new TRB was prepared with the HWO bit set
>> it is not save to read immideatly back from that value as the hw
>> will be doing some operations on that exactly new prepared TRB.
>>
>> We ran into this problem when applying this patch. The trb buffer list
>> was actually filled but we hit a false positive where the latest HWO bit
>> was 0 (probably due to the hw action in the background) and therefor
>> went into end transfer.
>>
>
>Thanks for the update.

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Z7LlYPAU/B3cdMx8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmY8EI4ACgkQC+njFXoe
LGS01hAAhUG5/Of+XNj3OmLS7wXs3oYCQEAwjttD8+FrH2GTe8qIZ6R9WziBRQ68
nmT4o9NbmADJ7a8wjLxUNZGhUANm5OVnRfc/bo4OP90/nR1FnREDpBPZC2gL7b1G
hvhPhRVOcHdGoJ50c/kgW5KczOUwDunhZx+r6n8SZ74MH3KvbExJMMCk+782YpqD
Ky7hxxx338OsnC4cNNX5w3CNSmG5JmUGja96ygvuM31s89kqzEPQVqrMlE0ycq09
54xvHkzo4P3h9FYAJ+LW16U520IIMqezc+b7LLjgQQAlOm7G1gWCxaWt2Pm0un8f
8opE8V2/lxr/bLbUjnN7q8bCjB0HTbtwcIUszxDU1gcyi2QHk59M2KwIAHA29RBK
Y9bo6qmlix9GRs74kMFHFiszV+lm/+FQ+td7U6HYeiXWlPmlCTc2yI5cKrMVP9WU
3zCBZv0x1QOkXmOiDTa+2gHxyOmB0AONo60wnrFMLIjgTOfHcDROmTLL1M8Wsbrc
0W63gguIHEcYn3g7vA2+hqnGT+B0CB8TCr4DgqiteLacUQFeTcC/qvC1Cd0Gw3K7
3rkJVI8m5/bEmwon8DvE0nAF7I21X23i6YDEoGrTWxXbz3+xssjAi4I93rzmSGOk
oCyBGJRyUDYiFVDOUAaUrNxklFUm/QIB3SRQaxPlumgbXLtkCB4=
=YPfe
-----END PGP SIGNATURE-----

--Z7LlYPAU/B3cdMx8--


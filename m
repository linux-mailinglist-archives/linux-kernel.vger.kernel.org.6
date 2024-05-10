Return-Path: <linux-kernel+bounces-175958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A298C27DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A162C1F25AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76AD172BAD;
	Fri, 10 May 2024 15:30:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7017107F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355007; cv=none; b=KOeeQ/78B5tc10HS6k5GIRawu2Mbf4Qv0ekZIqdpluXaCb+3hC1/smsqibgfypcP4qhJQykalbG+EEeXngXA+5LWuRP++A5oqixPRTI8kvk0TFNyluxPq+DZ4Oye0Kl3CbVseV5hQa0lXEq3aDp4CSvBgKdSVd3yTyQZu19+T6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355007; c=relaxed/simple;
	bh=24vuFK3ao8q1vBbzy+xHl14Jn3UYr5EtZwVuoZ2nxW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHG2dCWijd5tUCQ7dX867lPGWwBkz0YlbBV7CI68XKAdtBgA6y7fDD6ZiAf9JYB2bfKDKer1YKXFKSklugJ0tZ32wnEpyYpcVsuFl+LFODeyO5azaIELh8hxh2yIlYCKzkwKuTw2vEGjA8qU1uNHR3Q6hQSXGhhuj1lW4AgBMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s5SC5-00084O-1R; Fri, 10 May 2024 17:29:57 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s5SC2-000ejR-2W; Fri, 10 May 2024 17:29:54 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s5SC1-004DF9-3C;
	Fri, 10 May 2024 17:29:54 +0200
Date: Fri, 10 May 2024 17:29:53 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"michael.riesch@wolfvision.net" <michael.riesch@wolfvision.net>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Message-ID: <Zj49cYCdFuCGCXdU@pengutronix.de>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
 <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
 <ZjvuoVpVTnEcHRIH@pengutronix.de>
 <20240508231950.ifyawl6bfy6bzvk7@synopsys.com>
 <ZjwN0Zp03a1XuQij@pengutronix.de>
 <20240509002256.7grpmpnmlghft4gf@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WXDW2QR3hDPULxba"
Content-Disposition: inline
In-Reply-To: <20240509002256.7grpmpnmlghft4gf@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--WXDW2QR3hDPULxba
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 12:23:09AM +0000, Thinh Nguyen wrote:
>On Thu, May 09, 2024, Michael Grzeschik wrote:
>> On Wed, May 08, 2024 at 11:20:03PM +0000, Thinh Nguyen wrote:
>> > On Wed, May 08, 2024, Michael Grzeschik wrote:
>> > > On Tue, May 07, 2024 at 11:57:36AM -0700, Wesley Cheng wrote:
>> > > > Hi Michael,
>> > > >
>> > > > On 5/6/2024 4:06 PM, Michael Grzeschik wrote:
>> > > > > This patch is splitting up the interrupt event handling from one
>> > > > > interrupt thread to separate per endpoint interrupt threads.
>> > > > >
>> > > >
>> > > > I assume that the incentive from doing this is to improve overall
>> > > > throughput numbers.  Would you be able to share some data on the
>> > > > benefits of moving to per EP event management?
>> > >
>> > > The main benefit is to make it possible to use high demanding usb
>> > > endpoints simultaneously. In our special case we saw that streaming
>> > > via uac and streaming via uvc was producing noise in the audio
>> > > stream. This was due to the fact, that the isoc feedback endpoint
>> > > that would adjust the samplerate was not being called fast enough
>> > > when there was heavy a lot of traffic in the uvc endpoint context.
>> > >
>> > > By moving the endpoints into their own thread handlers the short
>> > > feedback requests are at least able to be scheduled in between the b=
ursts
>> > > of the uvc packages. The next step is to have all threads running on
>> > > different cpu cores, without interfering each other. However, as we
>> > > still have not matrix irq allocator for arm, there still is no direct
>> > > benefit from that yet.
>> > >
>> > >
>> > > > > To achieve this we create a new dwc3 interrupt domain in which
>> > > > > we map all claimed interrupts to individual interrupt threads.
>> > > > >
>> > > > > Although the gadget layer is preparing the claimed parameter
>> > > > > of each usb_ep which could be checked if the endpoint is
>> > > > > to used or not, the claimed value was 0 for each ep in gadget_st=
art.
>> > > > > This was tested when describing some composite gadget using conf=
igfs.
>> > > > >
>> > > >
>> > > > yeah... the claimed flag is cleared by the USB gadget, ie USB conf=
igfs
>> > > > (not sure if you're using this) whenever it adds a USB config.  Th=
is is
>> > > > to handle multi config situations, so subsequent USB configs can be
>> > > > assigned (resuse) endpoints, since only one config is active at a =
time
>> > > > for a USB device.
>> > > >
>> > > > This was a struggle for me as well when adding the TXFIFO resizing
>> > > > logic.  We won't actually know which EPs are going to be used unti=
l the
>> > > > host issues the set configuration packet to select a config, and t=
he
>> > > > set_alt() callback issues usb_ep_enable().  So the implementation
>> > > > (TXFIFO resizing) is currently based on the maximum potential endp=
oints
>> > > > used by any USB configuration.
>> > > >
>> > > > Not sure if having 31 (potentially) different IRQ entries would be=
 ok,
>> > > > but maybe it would be simpler to just to request IRQ for dwc->num_=
eps
>> > > > always?
>> > > >
>> > > > Have you tried this on a multi config device?
>> > >
>> > > No, I didn't. I doubt that this will work after your explanation. So
>> > > thanks for the insides!
>> > >
>> > > I tried putting the request_threaded_irq into the ep_enable function
>> > > but this does not work as I see a lot of schedule while atomic
>> > > errors. This is possible as ep_enable is called from an set alt
>> > > coming from ep0 interrupt thread context.
>> > >
>> > > So there is probably now no other option left to have exact endpoint
>> > > interrupt threads. I will rework this back to request a kthread for =
each
>> > > endpoint even as we will probably would not be using them.
>> > >
>> >
>> > Do you have any data on latency here?
>>
>> I don't have the exact numbers for the uac feedback isoc endpoint
>> at the moment. But without the patch applied, it was reproducably
>> returning with EXDEV when we started uvc streaming and therefor
>> increased the amount of events per interrupt thread cycle.
>>
>> With the patch applied however, we are able to only route the events to
>> the corresponding soft irqs and leave the moment of truth to the
>> scheduler.
>
>Basically you're trying increase the priority of dwc3 by the greater
>number of soft interrupts.

Possible. Never thought about this.

>> > I don't see how introducing more soft interrupts would improve on
>> > latency, if anything, it should be worse?
>>
>> Why should explicit handling of coherent ep events on one cpu core
>> introduce more latency then by interleaving different events for
>> arbitrary ep all in one thread?
>
>Because we are only using a single interrupt line, the sequence of
>events need to be handled 1 set at a time. The amount of time saved from
>handling interrupts of different endpoint should be miniscule. There's
>latency to switching context and locking, which I think would offset and
>introduce more latency than what you can potentially save.
>
>I'd like to see data on the improvement on the net latency here.

If this is the case. Then we are currently dealing with way to much
durtion in the complete handler of the endpoints. I can't really
tell for the uac endpoints. But the uvc complete endpoint is going
through this roundtrip.

With no_interupt =3D 0 at every 16 request:

dwc3_endpoint_interrupt
   dwc3_gadget_endpoint_trbs_complete
     dwc3_gadget_ep_cleanup_completed_requests
~16 * {
         dwc3_gadget_ep_cleanup_completed_request
	  dwc3_gadget_giveback
	    usb_gadget_giveback_request
	      usb_ep_queue
	        __dwc3_gadget_ep_queue
		  dwc3_prepare_trbs
~ *	            {
                       dwc3_prepare_trbs_sg/dwc3_prepare_trbs_linear
		    }
		  dwc3_send_gadget_ep_cmd
       }

I think this is a lot of stack for an interrupt thread to handle if you
really want to pipeline this in one irqthread run and leave and make
sure that the other endpoints will also be handled soon enough.

>>
>> > This is making the driver way more complicated and potentially
>> > introduce many bugs.
>>
>> Possible, but not unsolvable.
>>
>> > I may be wrong here, but I suspect that by multiplying the interrupt
>> > handlings, you _may_ see improvement due to the a higher chance being
>> > selected by the scheduler. However, the overall latency will probably
>> > be worse. (correct me if I'm wrong).
>>
>> I doubt that it will be worse if each softirq can be handled on
>> different cpus at the same time.
>
>See comment above.

To solve this issue I see two options:

We could either do this by having different interrupt threads per ep
like in this patch.

Or we ensure that the complete handler is not running that long.

This could be ensured by providing an interface that is similar to the
threaded interrupt interface. The complete handler should then only
wake up the corresponding complete thread.

This policy of a short running complete handler also should be commented
somewhere in the kernel.

Which brings me back to the open discussion with avichal, where I
already ment that it should be possible to completely remove the
usb_ep_queue callback from the complete handler. We there should only
update the buffer state and make sure that the pump worker would take
care of queueing the right buffers to the dwc3 driver. I will go more
into the details in this thread:

https://lore.kernel.org/all/17192e0f-7f18-49ae-96fc-71054d46f74a@google.com/

>> > This will affect other applications.
>>
>> Let's make sure we will not break anything on the way. Okay? :)
>>
>> > Let's not do this.
>>
>> I actually thought that this is even requested:
>>
>> https://docs.kernel.org/usb/dwc3.html
>>
>
>That's a very old and outdate TODO list.

We should ensure that this chapter will be removed then.

>We don't use wait_for_completion_timeout in the commands. During
>transfers, we're using Update Transfer command, and it completes almost
>immediately. The only time where a command may take a longer time is
>when we need to bring the device down for reset/disconnect and stop
>transfers, but that's not what contributes to the problem here.
>
>Internal tests show that we can achieve very close theoretical USB
>speeds with the current dwc3 implementation.

Granted, but only if we ensure that the complete() callback is not
destroing the runtime duration and probably no usb_ep_queue is never
called from the complete callback.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--WXDW2QR3hDPULxba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmY+PW8ACgkQC+njFXoe
LGRMow/+I2hOzutbQcpN2n3pxrBuF/7dR3hR8cgBx5PnUAzWrb1nQsEJZhnVrMhD
ANfTSTYYmujxso7H2YmHY3uXr1uSqtyvOndZEEncGgiUsS4qO21/u7+k8AIXXr6K
8HTlnar/5uHP0ajFeb5RKeNp3bjUfXTayzHaIgSUuFH04okFgp9Lw3+LgMPy1udG
2GhY/J+Ja3ruje5AQpmqQHAHhxoErNLmWyQ7XgGKJByGgXVN5ZkuVzghNje5owmr
gIbukZDSMQ3a+P4xbW4eO4ZFp1lM3gI1Wy22aSr1+CFnypykX4EdPV/bpnVM21ru
9PIFWbYZ2Ac+o/flj6aGlvJgzcUi6VKpqZ01NTf7QPViauqEbKCvTzA92W/Ea2RE
dL/vNEdglIez9w2c22wd73e+0l+ch12rKw8yboqWhiyDGq2bEomc2reXjhKPLrHS
xNDLMQOjHNl0LtpO+m5/zR3y3DTOhZXfwEum07OSCgEk0ixLP63dAdh3qIhOZbdR
T5RxwzcQBOKGDWJ+mRQ2QzxcFEnZRJMre3Jxc+JvhKBOIUm1FrxvfiU3xiWJuEbe
WfpkaGcYsNxr8hrXDSdTGWuv4A62ieSrojdGefgcthGjdP886vqmE8oFtZ16WjOp
bkltLfXOwU39Y4OirkOfoLH7z4jBeImofXuSOibifVu/E7AQDYY=
=idKe
-----END PGP SIGNATURE-----

--WXDW2QR3hDPULxba--


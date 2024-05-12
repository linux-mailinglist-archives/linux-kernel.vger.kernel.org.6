Return-Path: <linux-kernel+bounces-177027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9E8C3896
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD91C20AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2D554BE7;
	Sun, 12 May 2024 21:27:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF2535A8
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715549241; cv=none; b=Ub9z8CiHyQyO8GMG4soHc6yNUUMZ+K9CJj6g1ksqQm8ba/EgyYkYO+tqotFvLVFlT3fd/AkOcoi8gmHhY+kpENuqZZrSZ+6iCEwJgPsKzPj77iOXxAfqXwZ10ODane8EcgIssWz/3ymOOhG/W8dYROdfTjzO3YuP6i2BgauX2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715549241; c=relaxed/simple;
	bh=/SmCLc+51nZ7Qh9NIdIdGgRo8cOJ3eYudHiueR7zgtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTNFaDp3+J360lHNr44Ie3sCt7nZ2zYadbpOPbcdVJeVcc7eDRa0UxBZJGIOd/4Ek77lvD8qe2iDHpd2INTCe6Dr4mWi6RUzcsp1jYcfqf/f3TD6OjXnGhvGb0TSzpo+cFz11nM8E+mYgblrW85Zxl+gnxZ1R5m2lCRXAWefCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6Giq-0006BB-Nz; Sun, 12 May 2024 23:27:08 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6Gio-00134c-U5; Sun, 12 May 2024 23:27:06 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6Gio-007lUv-2j;
	Sun, 12 May 2024 23:27:06 +0200
Date: Sun, 12 May 2024 23:27:06 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"michael.riesch@wolfvision.net" <michael.riesch@wolfvision.net>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Message-ID: <ZkE0KkFNTMqVT8SP@pengutronix.de>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
 <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
 <ZjvuoVpVTnEcHRIH@pengutronix.de>
 <20240508231950.ifyawl6bfy6bzvk7@synopsys.com>
 <ZjwN0Zp03a1XuQij@pengutronix.de>
 <20240509002256.7grpmpnmlghft4gf@synopsys.com>
 <Zj49cYCdFuCGCXdU@pengutronix.de>
 <20240511001123.egbqumpzogk2mhxf@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Dl1TMHoq2g/nDDc"
Content-Disposition: inline
In-Reply-To: <20240511001123.egbqumpzogk2mhxf@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--2Dl1TMHoq2g/nDDc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 12:11:31AM +0000, Thinh Nguyen wrote:
>On Fri, May 10, 2024, Michael Grzeschik wrote:
>> On Thu, May 09, 2024 at 12:23:09AM +0000, Thinh Nguyen wrote:
>> > On Thu, May 09, 2024, Michael Grzeschik wrote:
>> > > On Wed, May 08, 2024 at 11:20:03PM +0000, Thinh Nguyen wrote:
>> > > > On Wed, May 08, 2024, Michael Grzeschik wrote:
>> > > > > On Tue, May 07, 2024 at 11:57:36AM -0700, Wesley Cheng wrote:
>> > > > > > Hi Michael,
>> > > > > >
>> > > > > > On 5/6/2024 4:06 PM, Michael Grzeschik wrote:
>> > > > > > > This patch is splitting up the interrupt event handling from=
 one
>> > > > > > > interrupt thread to separate per endpoint interrupt threads.
>> > > > > > >
>> > > > > >
>> > > > > > I assume that the incentive from doing this is to improve over=
all
>> > > > > > throughput numbers.  Would you be able to share some data on t=
he
>> > > > > > benefits of moving to per EP event management?
>> > > > >
>> > > > > The main benefit is to make it possible to use high demanding usb
>> > > > > endpoints simultaneously. In our special case we saw that stream=
ing
>> > > > > via uac and streaming via uvc was producing noise in the audio
>> > > > > stream. This was due to the fact, that the isoc feedback endpoint
>> > > > > that would adjust the samplerate was not being called fast enough
>> > > > > when there was heavy a lot of traffic in the uvc endpoint contex=
t.
>> > > > >
>> > > > > By moving the endpoints into their own thread handlers the short
>> > > > > feedback requests are at least able to be scheduled in between t=
he bursts
>> > > > > of the uvc packages. The next step is to have all threads runnin=
g on
>> > > > > different cpu cores, without interfering each other. However, as=
 we
>> > > > > still have not matrix irq allocator for arm, there still is no d=
irect
>> > > > > benefit from that yet.
>> > > > >
>> > > > >
>> > > > > > > To achieve this we create a new dwc3 interrupt domain in whi=
ch
>> > > > > > > we map all claimed interrupts to individual interrupt thread=
s.
>> > > > > > >
>> > > > > > > Although the gadget layer is preparing the claimed parameter
>> > > > > > > of each usb_ep which could be checked if the endpoint is
>> > > > > > > to used or not, the claimed value was 0 for each ep in gadge=
t_start.
>> > > > > > > This was tested when describing some composite gadget using =
configfs.
>> > > > > > >
>> > > > > >
>> > > > > > yeah... the claimed flag is cleared by the USB gadget, ie USB =
configfs
>> > > > > > (not sure if you're using this) whenever it adds a USB config.=
  This is
>> > > > > > to handle multi config situations, so subsequent USB configs c=
an be
>> > > > > > assigned (resuse) endpoints, since only one config is active a=
t a time
>> > > > > > for a USB device.
>> > > > > >
>> > > > > > This was a struggle for me as well when adding the TXFIFO resi=
zing
>> > > > > > logic.  We won't actually know which EPs are going to be used =
until the
>> > > > > > host issues the set configuration packet to select a config, a=
nd the
>> > > > > > set_alt() callback issues usb_ep_enable().  So the implementat=
ion
>> > > > > > (TXFIFO resizing) is currently based on the maximum potential =
endpoints
>> > > > > > used by any USB configuration.
>> > > > > >
>> > > > > > Not sure if having 31 (potentially) different IRQ entries woul=
d be ok,
>> > > > > > but maybe it would be simpler to just to request IRQ for dwc->=
num_eps
>> > > > > > always?
>> > > > > >
>> > > > > > Have you tried this on a multi config device?
>> > > > >
>> > > > > No, I didn't. I doubt that this will work after your explanation=
=2E So
>> > > > > thanks for the insides!
>> > > > >
>> > > > > I tried putting the request_threaded_irq into the ep_enable func=
tion
>> > > > > but this does not work as I see a lot of schedule while atomic
>> > > > > errors. This is possible as ep_enable is called from an set alt
>> > > > > coming from ep0 interrupt thread context.
>> > > > >
>> > > > > So there is probably now no other option left to have exact endp=
oint
>> > > > > interrupt threads. I will rework this back to request a kthread =
for each
>> > > > > endpoint even as we will probably would not be using them.
>> > > > >
>> > > >
>> > > > Do you have any data on latency here?
>> > >
>> > > I don't have the exact numbers for the uac feedback isoc endpoint
>> > > at the moment. But without the patch applied, it was reproducably
>> > > returning with EXDEV when we started uvc streaming and therefor
>> > > increased the amount of events per interrupt thread cycle.
>> > >
>> > > With the patch applied however, we are able to only route the events=
 to
>> > > the corresponding soft irqs and leave the moment of truth to the
>> > > scheduler.
>> >
>> > Basically you're trying increase the priority of dwc3 by the greater
>> > number of soft interrupts.
>>
>> Possible. Never thought about this.
>>
>> > > > I don't see how introducing more soft interrupts would improve on
>> > > > latency, if anything, it should be worse?
>> > >
>> > > Why should explicit handling of coherent ep events on one cpu core
>> > > introduce more latency then by interleaving different events for
>> > > arbitrary ep all in one thread?
>> >
>> > Because we are only using a single interrupt line, the sequence of
>> > events need to be handled 1 set at a time. The amount of time saved fr=
om
>> > handling interrupts of different endpoint should be miniscule. There's
>> > latency to switching context and locking, which I think would offset a=
nd
>> > introduce more latency than what you can potentially save.
>> >
>> > I'd like to see data on the improvement on the net latency here.
>>
>> If this is the case. Then we are currently dealing with way to much
>> durtion in the complete handler of the endpoints. I can't really
>> tell for the uac endpoints. But the uvc complete endpoint is going
>> through this roundtrip.
>>
>> With no_interupt =3D 0 at every 16 request:
>>
>> dwc3_endpoint_interrupt
>>   dwc3_gadget_endpoint_trbs_complete
>>     dwc3_gadget_ep_cleanup_completed_requests
>> ~16 * {
>>         dwc3_gadget_ep_cleanup_completed_request
>> 	  dwc3_gadget_giveback
>> 	    usb_gadget_giveback_request
>> 	      usb_ep_queue
>> 	        __dwc3_gadget_ep_queue
>> 		  dwc3_prepare_trbs
>> ~ *	            {
>>                       dwc3_prepare_trbs_sg/dwc3_prepare_trbs_linear
>> 		    }
>> 		  dwc3_send_gadget_ep_cmd
>>       }
>>
>> I think this is a lot of stack for an interrupt thread to handle if you
>> really want to pipeline this in one irqthread run and leave and make
>> sure that the other endpoints will also be handled soon enough.
>>
>
>The usb_ep_queue ops should be relatively quick, I think you mean the
>request process and/or preparation at the function driver before queuing
>a new request? For usb_ep_queue(), the dwc3 driver doesn't need to do
>much except telling the controller that "new TRBs are prepared, go cache
>and process them when possible" in usb_ep_queue().

What you refer is the call of prepare_trbs and ep_cmd. This is probably
pretty fast. But we still do this up to 16 times on one interrupt run.
To really tell the weight in that case we will have to come back with
numbers.

>> > >
>> > > > This is making the driver way more complicated and potentially
>> > > > introduce many bugs.
>> > >
>> > > Possible, but not unsolvable.
>> > >
>> > > > I may be wrong here, but I suspect that by multiplying the interru=
pt
>> > > > handlings, you _may_ see improvement due to the a higher chance be=
ing
>> > > > selected by the scheduler. However, the overall latency will proba=
bly
>> > > > be worse. (correct me if I'm wrong).
>> > >
>> > > I doubt that it will be worse if each softirq can be handled on
>> > > different cpus at the same time.
>> >
>> > See comment above.
>>
>> To solve this issue I see two options:
>>
>> We could either do this by having different interrupt threads per ep
>> like in this patch.
>
>I'd like to avoid this.
>
>>
>> Or we ensure that the complete handler is not running that long.
>
>This should be the way to go. At the upper layer, you know what takes
>longer to prepare and what priority the work of each request/endpoint
>should be.

Good.

>From the dwc3 driver, we currently don't handle the controller with
>"Multiple Interrupt Support" configuration where each interrupt line is
>associated with a separate event buffer and endpoint. So, it doesn't
>make sense to create different interrupt threads for each endpoint. For
>applications that have many endpoints, discounting the latency
>introduces by the function driver, we will have more latency from
>handling, scheduling, and waking up interrupt threads.

I was not aware that this mode (Multiple Interrupt Support) is even possible
with dwc3. So if I really want to get the per ep hanlder patch to be mainli=
ne
it really needs to make use of that feature.

>> This could be ensured by providing an interface that is similar to the
>> threaded interrupt interface. The complete handler should then only
>> wake up the corresponding complete thread.
>>
>> This policy of a short running complete handler also should be commented
>> somewhere in the kernel.
>>
>> Which brings me back to the open discussion with avichal, where I
>> already ment that it should be possible to completely remove the
>> usb_ep_queue callback from the complete handler. We there should only
>> update the buffer state and make sure that the pump worker would take
>> care of queueing the right buffers to the dwc3 driver. I will go more
>> into the details in this thread:
>>
>> https://lore.kernel.org/all/17192e0f-7f18-49ae-96fc-71054d46f74a@google.=
com/
>>
>> > > > This will affect other applications.
>> > >
>> > > Let's make sure we will not break anything on the way. Okay? :)
>> > >
>> > > > Let's not do this.
>> > >
>> > > I actually thought that this is even requested:
>> > >
>> > > https://docs.kernel.org/usb/dwc3.html
>> > >
>> >
>> > That's a very old and outdate TODO list.
>>
>> We should ensure that this chapter will be removed then.
>
>Sure, we can remove that.

Good.

>>
>> > We don't use wait_for_completion_timeout in the commands. During
>> > transfers, we're using Update Transfer command, and it completes almost
>> > immediately. The only time where a command may take a longer time is
>> > when we need to bring the device down for reset/disconnect and stop
>> > transfers, but that's not what contributes to the problem here.
>> >
>> > Internal tests show that we can achieve very close theoretical USB
>> > speeds with the current dwc3 implementation.
>>
>> Granted, but only if we ensure that the complete() callback is not
>> destroing the runtime duration and probably no usb_ep_queue is never
>> called from the complete callback.
>>
>
>Right, we have tests that prepare/process requests within the completion
>callbacks, and we have tests that prepare/process requests in a separate
>work. Depending on the amount of work/latency needed, we implement in a
>certain way. e.g. for UASP tests, the processing of the request is on a
>separate work than completion callback.

So we really need to come up with some interface for the user of the
complete handlers. So the upper layers won't be informed that the
amount of work is critical and therefor could need a separate thread.

(At least this should be documented)

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2Dl1TMHoq2g/nDDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZBNCgACgkQC+njFXoe
LGSlvxAAphaRI9w8mm9MpkVyy19qjiZpyzIPZntcxodOIoMpoSzvDiNnNwRT7vFG
TaOCAz52NxJyEjagwO2myEWCAjOErHacdtb7w3Gw48khvi+JwdlEqiHwyEy/hxzK
J5zU0m7C1o5XP2aEnXKhvGdWNmSvPhS/5YA+pb6mV7Y+43Q7giaI5dVi9FvIVPx2
VcHddzTh0FuZ4dxRs7a/siWyMgOsUmKTV20W0Z6TqrDywvBxgSpngW9xUZ2IBQ2m
jLmniMjGR7ojBWvPC/OwCW8IKhTMHOdbo7NtlgMyUsw50K3c8vZ+wmu9Fy5sT7jd
iEnjQL2KYo2GJz3jR9GmM6D4hfnV1tEGMaltAndf6eJZNOZI4D7xwkSD4e6RWngJ
HQ3vgX0IZRH3/BOHBRujfk4SJErYKOyzXACwDEon1qbhQUL80bRZLR9gi7F/rOIe
iNzHH3LLrkIH1g+wKQB9i28ZkWspbdTZ+ZDqub/SVllac5cJiYYGxg0prxwg9TOs
vh1+zzov+xxaAWIOW9lP48m3weoWtO8W/tLlsRan5R8IqK+lU9a/CFTEXrR1FzWD
hi3efEq9VaaVChsFXIhUsMIYewdMVMu7Fmz1DgmBkbJiGLBNhuZS0/pjDGy9qNIZ
5wMNDl0OrvkHsuwGt8NgnUi0DDGPWSfFCCC2y9Xj5Dm0rj8Ek80=
=QACj
-----END PGP SIGNATURE-----

--2Dl1TMHoq2g/nDDc--


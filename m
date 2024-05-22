Return-Path: <linux-kernel+bounces-185539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6F8CB675
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF111C20FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75517F3;
	Wed, 22 May 2024 00:08:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBC368
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716336502; cv=none; b=SV20FRUlr3VGOFUKzXawR572ugr4rj6kXjAthGqYztdPiDvro/nxLYzwjlB7+pQcoH0uo7wPtYM+/8U/PNMKFyfpM90mK76Sks8WY4yuufIG5oUJoaevwRxL6TVvG5yYFuCkX8FQqvgsyd8iaGywCfNPQvmvXIibpapOOUdMZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716336502; c=relaxed/simple;
	bh=9HsyJVgv0upEiigP2Jga9c2Tlm6NtmtYXmCe7XwkN5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hht8B73N0DdXFihqqJJQf+LOT8+JEjMR25iR4K4+eyILNFJfIp5cci6c8abuqaVM1j/tei1IFy86jif4QhPEMVCCyQstWga5f49aE9MHMOiXQpgTWxfreVmUXqnKO5wP2zEjAvURWftydlLgs+H1zRu5xfyJ7yQpUuWU9wU2Y9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9ZWW-00070C-Tj; Wed, 22 May 2024 02:08:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9ZWU-002SIM-U7; Wed, 22 May 2024 02:08:02 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9ZWU-007oDU-2h;
	Wed, 22 May 2024 02:08:02 +0200
Date: Wed, 22 May 2024 02:08:02 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Avichal Rakesh <arakesh@google.com>,
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
Message-ID: <Zk03Ys1rA0I5yiZy@pengutronix.de>
References: <ZiWga5Kqno1ICv97@pengutronix.de>
 <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJN5bpTf2Oav326M"
Content-Disposition: inline
In-Reply-To: <20240517014359.p2s44ypl4bix4odm@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--FJN5bpTf2Oav326M
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>On Mon, May 13, 2024, Michael Grzeschik wrote:
>> On Wed, Apr 24, 2024 at 02:28:10AM +0000, Thinh Nguyen wrote:
>> > On Tue, Apr 23, 2024, Avichal Rakesh wrote:
>> > >
>> > >
>> > > On 4/23/24 07:25, Michael Grzeschik wrote:
>> > > > Ccing:
>> > > >
>> > > > Michael Riesch <michael.riesch@wolfvision.net>
>> > > > Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> > > >
>> > > > On Mon, Apr 22, 2024 at 05:21:09PM -0700, Avichal Rakesh wrote:
>> > > >> On 4/21/24 16:25, Michael Grzeschik wrote:
>> > > >>> On Tue, Apr 09, 2024 at 11:24:56PM +0200, Michael Grzeschik wrot=
e:
>> > > >>>> This patch series is improving the size calculation and allocat=
ion
>> > > >>>> of the uvc requests. Using the currenlty setup frame duration o=
f the
>> > > >>>> stream it is possible to calculate the number of requests based=
 on the
>> > > >>>> interval length.
>> > > >>>
>> > > >>> The basic concept here is right. But unfortunatly we found out t=
hat
>> > > >>> together with Patch [1] and the current zero length request pump
>> > > >>> mechanism [2] and [3] this is not working as expected.
>> > > >>>
>> > > >>> The conclusion that we can not queue more than one frame at once=
 into
>> > > >>> the hw led to [1]. The current implementation of zero length req=
eusts
>> > > >>> which will be queued while we are waiting for the frame to finish
>> > > >>> transferring will enlarge the frame duration. Since every zero-l=
ength
>> > > >>> request is still taking up at least one frame interval of 125 us.
>> > > >>
>> > > >> I haven't taken a super close look at your patches, so please fee=
l free
>> > > >> to correct me if I am misunderstanding something.
>> > > >>
>> > > >> It looks like the goal of the patches is to determine a better nu=
mber
>> > > >> and size of usb_requests from the given framerate such that we se=
nd exactly
>> > > >> nreqs requests per frame where nreqs is determined to be the exac=
t number
>> > > >> of requests that can be sent in one frame interval?
>> > > >
>> > > > It does not need to be the exact time, actually it may not be exac=
t.
>> > > > Scattering the data over all requests would not leave any headroom=
 for
>> > > > any latencies or overhead.
>> > >
>> > > IIUC, patch 3/3 sets the number of requests to frameinterval / 125 u=
s,
>> > > which gives us the number of requests we can send in exactly one fra=
me interval,
>> > > and then sets the size of the request as max framesize / nreq, which=
 means the
>> > > frames will be evenly divided up into all available requests (with a=
 little
>> > > fuzz factor here and there).
>> > >
>> > > This effectively means that (assuming no other delays) one frame wil=
l take
>> > > ~one frameinterval to be transmitted?
>> > >
>> > > >
>> > > >> As the logic stands, we need some 0-length requests to be circula=
ting to
>> > > >> ensure that we don't miss ISOC deadlines. The current logic uncon=
ditionally
>> > > >> sends half of all allocated requests to be circulated.
>> > > >>
>> > > >> With those two things in mind, this means than video_pump can at =
encode
>> > > >> at most half a frame in one go, and then has to wait for complete
>> > > >> callbacks to come in. In such cases, the theoretical worst case f=
or
>> > > >> encode time is
>> > > >> 125us * (number of requests needed per frame / 2) + scheduling de=
lays
>> > > >> as after the first half of the frame has been encoded, the video_=
pump
>> > > >> thread will have to wait 125us for each of the zero length reques=
ts to
>> > > >> be returned.
>> > > >>
>> > > >> The underlying assumption behind the "queue 0-length requests" ap=
proach
>> > > >> was that video_pump encodes the frames in as few requests as poss=
ible
>> > > >> and that there are spare requests to maintain a pressure on the
>> > > >> ISOC queue without hindering the video_pump thread, and unfortuna=
tely
>> > > >> it seems like patch 3/3 is breaking both of them?
>> > > >
>> > > > Right.
>> > > >
>> > > >> Assuming my understanding of your patches is correct, my question
>> > > >> is: Why do we want to spread the frame uniformly over the requests
>> > > >> instead of encoding it in as few requests as possible. Spreading
>> > > >> the frame over more requests artificially increases the encode ti=
me
>> > > >> required by video_pump, and AFAICT there is no real benefit to it?
>> > > >
>> > > > Thinh gave me the advise that it is better to use the isoc stream
>> > > > constantly filled. Rather then streaming big amounts of data in the
>> > > > beginning of an frameinterval and having then a lot of spare time
>> > > > where the bandwidth is completely unsused.
>> > > >
>> > > > In our reallife scenario streaming big requests had the impact, th=
at
>> > > > the dwc3 core could not keep up with reading the amount of data
>> > > > from the memory bus, as the bus is already under heavy load. When =
the
>> > > > HW was then not able to transfer the requested and actually availa=
ble
>> > > > amount of data in the interval, the hw did give us the usual missed
>> > > > interrupt answer.
>> > > >
>> > > > Using smaller requests solved the problem here, as it really was
>> > > > unnecessary to stress the memory and usb bus in the beginning as
>> > > > we had enough headroom in the temporal domain.
>> > >
>> > > Ah, I see. This was not a consideration, and it makes sense if USB
>> > > bus is under contention from a few different streams. So the solution
>> > > seems to be to spread the frame of as many requests as we can transm=
it
>> > > in one frameinterval?
>> > >
>> > > As an experiment, while we wait for others to respond, could you try
>> > > doubling (or 2.5x'ing to be extra safe) the number of requests alloc=
ated
>> > > by patch 3/3 without changing the request's buffer size?
>> > >
>> > > It won't help with the error reporting but should help with ensuring
>> > > that frames are sent out in one frameinterval with little to no
>> > > 0-length requests between them.
>> > >
>> > > The idea is that video_pump will have enough requests available to f=
ully
>> > > encode the frame in one burst, and another frame's worth of request =
will be
>> > > re-added to req_free list for video_pump to fill up in the time that=
 the next
>> > > frame comes in.
>> > >
>> > > >
>> > > > Which then led to the conclusion that the number of needed requests
>> > > > per image frame interval is calculatable since we know the usb
>> > > > interval length.
>> > > >
>> > > > @Thinh: Correct me if I am saying something wrong here.
>> >
>> > Right, if you max out the data rate per uframe, there's less opportuni=
ty
>> > for the host to schedule everything for that interval (e.g. affected
>> > from other endpoint/device traffics, link commands etc). It also
>> > increases the latency of DMA. In many cases, many other vendor hosts
>> > can't handle 48KB/uframe for SuperSpeed and 96KB/uframe for SuperSpeed
>> > Plus. So, you'd need to test your platform find the optimal request si=
ze
>> > so it can work for most hosts.
>> >
>> > > >
>> > > >>> Therefor to properly make those patches work, we will have to ge=
t rid of
>> >
>> > Sorry if I may have missed the explaination, but why do we need to rid
>> > of this?
>>
>>
>> The uvc_video gadget is queueing requests with ep_queue whenever they
>> are prepared. However for uvc we may not send EOF to the host until
>> we know that the frame was transmitted correct or wrong.
>>
>> To ensure this the gadget is waiting for the last request to be
>> completed from dwc3. Until this request was not received, the current
>> workflow is to enqueue zero-length requests into the dwc3 hw. With that,
>> the final EOF request for the frame will be transmitted after the
>> zero-length requests have passed the hw. (They have no data, but they
>> still take one frameinterval durtion). This sparsed frame with
>> zero-requests inbetween will interfere with the precalculation for
>> request data we fill every request with based on the expected frame
>> duration.
>>
>> I know this seems very interlocked. It is very complex indeed. Tell
>> me if you still have questions and I will come up with some more
>> details to the current uvc_video driver.
>>
>> > > >>> the zero length pump mechanism again and make sure that the whole
>> > > >>> business logic of what to be queued and when will only be done i=
n the
>> > > >>> pump worker. It is possible to let the dwc3 udc run dry, as we a=
re
>> > > >>> actively waiting for the frame to finish, the last request in the
>> > > >>> prepared and started list will stop the current dwc3 stream and=
=A0 for
>> > > >>> no underruns will occur with the next ep_queue.
>> > > >>
>> > > >> One thing to note here: The reason we moved to queuing 0-length r=
equests
>> > > >> from complete callback was because even with realtime priority, v=
ideo_pump
>> > > >> thread doesn't always meet the ISOC queueing cadence. I think sto=
pping and
>> > > >> starting the stream was briefly discussed in our initial discussi=
on in
>> > > >> https://urldefense.com/v3/__https://lore.kernel.org/all/202304190=
01143.pdxflhzyecf4kvee@synopsys.com/__;!!A4F2R9G_pg!ZmfvrPq4rs7MIhxNrrEqmgG=
rlYTJ12WgdzaqQhfEehKfjKqxPr2bC1RzUqaa9tvdBtAvXdyK2GpxYzvslpV6$
>> > > >> and Thinh mentioned that dwc3 controller does it if it detects an=
 underrun,
>> > > >> but I am not sure if starting and stopping an ISOC stream is good=
 practice.
>> >
>> > There's a workaround specific for UVC in dwc3 to "guess" when underrun
>> > happen. It's not foolproof. dwc3 should not need to do that.
>> >
>> > Isoc data is periodic and continuous. We should not expect this
>> > unconventional re-synchronization.
>>
>> I think we have to discuss what is ment by resynchronization here. If
>> the trb ring buffer did run dry and the software is aware of this
>> (elemnt in the started and prepared list) then the interrupt handler
>> already is calling End Stream Command.
>
>The driver only aware of this when the controller tells it, which may be
>already too late.

In our special case there should not be any too late any more. Since we
ensure that all requests will be enqueued for one transfer (which will
represent one frame) in time and we are not dependent on the complete
handler for nothing else than telling the uvc driver that the last
request came back or if there was some error in the current active
frame.

As already stated we also have to wait with enqueueing the next frame
to the hardware and only are allowed to enqueue one frame at a time.
Otherwise it is not possible to tell the host if the frame was broken or
not.

I have the following scheme in my mind. It is simplified to take frames
of only 4 requests into account. (>80 chars warning)


frameinterval:                |       125 us       |       125 us       |  =
     125 us       |       125 us       |       125 us       |       125 us =
      |       125 us       |
                               |                    |                    | =
                   |                    |                    |             =
       |                    |
pump thread:   queue          |rqA1 rqA2 rqA3 rqA4'|                    |  =
                  |                    |                    |rqB0 rqB1 rqB2=
 rqB3 |rqB4'               |
irq  thread:   complete       |                    |rqA1                |rq=
A2                |rqA3                |rqA4'               |              =
      |rqB0                | rqB1
qbuf thread:   encode         |rqB1 rqB2 rqB3 rqB4'|                    |  =
                  |                    |                    |rqA1 rqA2 rqA3=
 rqA4'|                    |

dwc3 thread:   Hardware                            < Start Transfer        =
                                               End Transfer >              =
      < Start Transfer      ....

legend:
- rq'  : last request of a frame
- rqB0 : first request of the next transfer with no payload but the header =
only
          telling the host that the last frame was ok/broken

assumption:

- pump thread is never interrupted by a kernel thread but only by some shor=
t running irq
- if one request comes back with -EXDEV the rest of the enqueued requests s=
hould be flushed

In the no_interrupt case we would also only generate the interrupt for
the last request and giveback all four requests in the last interval.
This should still work fine.

We also only start streaming when one frame is totally available to be
enqueued in one run. So in case frames with rqA and rqB both did come back
with errors the start of the next frame will only begin after the next
frame was completely and fully encoded.

>> When the stream is stopped, what implications does this have on the bus?
>>
>> When the Endpoint is enabled, will the hardware then send zero-length
>> requests on its own?
>
>For isoc endpoint IN, yes. If the host requests for isoc data IN while
>no TRB is prepared, then the controller will automatically send 0-length
>packet respond.

Perfect! This will help a lot and will make active queueing of own
zero-length requests run unnecessary.

>> With the next ep_queue we start another stream and when we keep up with
>> this stream there is no underruns, right?
>>
>> I picture this scenario in my mind:
>>
>> thread 1: uvc->queue_buf is called:
>>   - we encode the frame buffer data into all available requests
>>     and put them into the per uvc_buffer perpared list
>>     (as we precalculated the amount of requests properly to the expected
>>      frame duration and buffer size there will be enough requests
>>      available)
>>   - wake up the pump thread
>>
>> thread 2: pump_worker is triggered
>>   - take all requests from the prepared available buffer and enqueue them
>>     into the hardware
>>     (The pump worker is running with while(1) while it finds requests in
>>      the per buffer prepared list) and therefor will have a high chance
>>      to finish the pumping for one complete frame.
>>   - check for any errors reported from the complete handlers
>>     - on error
>>       - stop enqueing new requests from current frame
>>       - wait for the last request from errornous frame has returned
>>   - only start pumping new requests from the next buffer when the last
>>     request from the active frame has finished
>>   - In the beginning of the next frame send one extra request with
>>     EOF/ERR tag so the host knows that the last one was ok or not.
>>
>> thread 3: complete handler (interrupt)
>>   - give back the requests into the empty_list
>>   - report EXDEV and errors
>>   - wake up the pump thread
>>
>> With this method we will continously drain the hw trb stream of the dwc3
>> controller per frame and therefor will not shoot into one window where
>> the current stream could be missed. With the data spreading over the
>> many requests we also avoid the missed requests when the DMA was to
>> slow.
>>
>
>This sounds good.
>
>As long as we can maintain more than X number of requests enqueued to
>accomodate for the worst latency, then we can avoid underrun. The driver
>should monitor how many requests are enqueued and hopefully can keep up
>the queue with zero-length requests.

Except I totally misunderstood something or did oversimplify to much,
the above explanation should run this unnecessary.

Although we are able to track the amount of enqueued requests in the udc
driver and compare that with the amount of completed requests.

Also we have the usb_gadget_frame_number callback to the udc controller
to ask in which frame it is operating at the moment. This way we would
be able to calculate not to enqueue requests into a transfer that did
not come back yet completely but would run into missed transfers.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--FJN5bpTf2Oav326M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZNN18ACgkQC+njFXoe
LGQkXRAAvf2PS6WGbXqYYFZekKfZNID7RmWsKD2fPAaGS7HrREZKYmwecjXlcOPt
RB8iXc3rz3azCKAfFgcOchkGoJdJTMjWmz7bUgKJ/v1fOpVlGN6kWEpzKQP8tHuR
ecNIYDo7KtbEqQapttUR4x5nDqGplpts0APntLFq30DJp9GwPsPnz2M2STSy21Ah
mneACn+FUMNLa/OYVRcqBIe33rbdn/ksSNAaJZmj7j0e08Lxu0hu/ALw9kg+HLL3
lkWSEH3jDmOgXZgjn2WFbWGlhaPj8XwLdt4lLWejz99UXtMrrx4iZAo+VPNXtxe4
t05GN6azx/HWBSPNTA8pIAhxohIybgBh2BD2GGKufXm+93K8l66cxud1eoZSd35N
yFG1mKl+ozagowWcTETbNAOSpkRSCMBHbT460tR+yPKgYPi1j/wnPEuqqWFs44DP
J5iDxIBWWTS8zk38VIBXJ2pAF6i/Dd8IeprduP99nyZnkDkDf6waGLcVUr+gYFNF
QwRdosirq7G63M6s38gUuTqnXpIFyiER+1YEoOEObbF2ixGqWdvkyGdFx9I3z6/3
4dNByTJtMWi441PMNnq/W4z4/N6LT+GM1h7gMQMKdrSpkL2584RjZoPF2RQ2LIb1
u0qNEeRfYM0JacV4l+E+96L3PLfxLa0c17N+yN8vlVuLW2eup2c=
=7biu
-----END PGP SIGNATURE-----

--FJN5bpTf2Oav326M--


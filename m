Return-Path: <linux-kernel+bounces-177035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C228C38F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3420FB20FF4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1E55C3A;
	Sun, 12 May 2024 22:10:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5256750
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715551819; cv=none; b=SsJEX4uacgepP+0xRNd7+Lwkik26a/u2ZvY//Leb7AFFQc3Hj7+Yy5xPq3m8AMkGiE5AYI2mwfAsT1uuPHxe7g1ShZ4/XRbpMCMbKPnbd4cA9vknMPPPnuPmw70x58324utfAIyG4fw77CMF5YOk4sky7rNHU8FE31wehn8VTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715551819; c=relaxed/simple;
	bh=7GNiHiyJMCc14BEJmu617PiZxyGP2KecnFrx009A7Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLNqmKkgOrZMUG/FJ8Ua6V25q9oDueZLXx5x0sb5q+whTjo3z3FrqEQkT2cVeuH7O9bxkkM7zfyAyJHwcWUlFOJTCH+pYssbB1MhfjTmxuoo87NjpBuquY5zZ+lB7pL2ABQnz3kYSBQ0ztkZGoCIe42DmvrXAqnSfWnf3awczdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6HOP-0002QD-CV; Mon, 13 May 2024 00:10:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6HON-0013DH-S3; Mon, 13 May 2024 00:10:03 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s6HON-007ltE-2S;
	Mon, 13 May 2024 00:10:03 +0200
Date: Mon, 13 May 2024 00:10:03 +0200
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
Message-ID: <ZkE-O0yJ33T9hWa0@pengutronix.de>
References: <ZiWga5Kqno1ICv97@pengutronix.de>
 <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xJdUWAcFD0bnMbji"
Content-Disposition: inline
In-Reply-To: <20240424022806.uo73nwpeg63vexiv@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--xJdUWAcFD0bnMbji
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 02:28:10AM +0000, Thinh Nguyen wrote:
>On Tue, Apr 23, 2024, Avichal Rakesh wrote:
>>
>>
>> On 4/23/24 07:25, Michael Grzeschik wrote:
>> > Ccing:
>> >
>> > Michael Riesch <michael.riesch@wolfvision.net>
>> > Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> >
>> > On Mon, Apr 22, 2024 at 05:21:09PM -0700, Avichal Rakesh wrote:
>> >> On 4/21/24 16:25, Michael Grzeschik wrote:
>> >>> On Tue, Apr 09, 2024 at 11:24:56PM +0200, Michael Grzeschik wrote:
>> >>>> This patch series is improving the size calculation and allocation
>> >>>> of the uvc requests. Using the currenlty setup frame duration of the
>> >>>> stream it is possible to calculate the number of requests based on =
the
>> >>>> interval length.
>> >>>
>> >>> The basic concept here is right. But unfortunatly we found out that
>> >>> together with Patch [1] and the current zero length request pump
>> >>> mechanism [2] and [3] this is not working as expected.
>> >>>
>> >>> The conclusion that we can not queue more than one frame at once into
>> >>> the hw led to [1]. The current implementation of zero length reqeusts
>> >>> which will be queued while we are waiting for the frame to finish
>> >>> transferring will enlarge the frame duration. Since every zero-length
>> >>> request is still taking up at least one frame interval of 125 us.
>> >>
>> >> I haven't taken a super close look at your patches, so please feel fr=
ee
>> >> to correct me if I am misunderstanding something.
>> >>
>> >> It looks like the goal of the patches is to determine a better number
>> >> and size of usb_requests from the given framerate such that we send e=
xactly
>> >> nreqs requests per frame where nreqs is determined to be the exact nu=
mber
>> >> of requests that can be sent in one frame interval?
>> >
>> > It does not need to be the exact time, actually it may not be exact.
>> > Scattering the data over all requests would not leave any headroom for
>> > any latencies or overhead.
>>
>> IIUC, patch 3/3 sets the number of requests to frameinterval / 125 us,
>> which gives us the number of requests we can send in exactly one frame i=
nterval,
>> and then sets the size of the request as max framesize / nreq, which mea=
ns the
>> frames will be evenly divided up into all available requests (with a lit=
tle
>> fuzz factor here and there).
>>
>> This effectively means that (assuming no other delays) one frame will ta=
ke
>> ~one frameinterval to be transmitted?
>>
>> >
>> >> As the logic stands, we need some 0-length requests to be circulating=
 to
>> >> ensure that we don't miss ISOC deadlines. The current logic unconditi=
onally
>> >> sends half of all allocated requests to be circulated.
>> >>
>> >> With those two things in mind, this means than video_pump can at enco=
de
>> >> at most half a frame in one go, and then has to wait for complete
>> >> callbacks to come in. In such cases, the theoretical worst case for
>> >> encode time is
>> >> 125us * (number of requests needed per frame / 2) + scheduling delays
>> >> as after the first half of the frame has been encoded, the video_pump
>> >> thread will have to wait 125us for each of the zero length requests to
>> >> be returned.
>> >>
>> >> The underlying assumption behind the "queue 0-length requests" approa=
ch
>> >> was that video_pump encodes the frames in as few requests as possible
>> >> and that there are spare requests to maintain a pressure on the
>> >> ISOC queue without hindering the video_pump thread, and unfortunately
>> >> it seems like patch 3/3 is breaking both of them?
>> >
>> > Right.
>> >
>> >> Assuming my understanding of your patches is correct, my question
>> >> is: Why do we want to spread the frame uniformly over the requests
>> >> instead of encoding it in as few requests as possible. Spreading
>> >> the frame over more requests artificially increases the encode time
>> >> required by video_pump, and AFAICT there is no real benefit to it?
>> >
>> > Thinh gave me the advise that it is better to use the isoc stream
>> > constantly filled. Rather then streaming big amounts of data in the
>> > beginning of an frameinterval and having then a lot of spare time
>> > where the bandwidth is completely unsused.
>> >
>> > In our reallife scenario streaming big requests had the impact, that
>> > the dwc3 core could not keep up with reading the amount of data
>> > from the memory bus, as the bus is already under heavy load. When the
>> > HW was then not able to transfer the requested and actually available
>> > amount of data in the interval, the hw did give us the usual missed
>> > interrupt answer.
>> >
>> > Using smaller requests solved the problem here, as it really was
>> > unnecessary to stress the memory and usb bus in the beginning as
>> > we had enough headroom in the temporal domain.
>>
>> Ah, I see. This was not a consideration, and it makes sense if USB
>> bus is under contention from a few different streams. So the solution
>> seems to be to spread the frame of as many requests as we can transmit
>> in one frameinterval?
>>
>> As an experiment, while we wait for others to respond, could you try
>> doubling (or 2.5x'ing to be extra safe) the number of requests allocated
>> by patch 3/3 without changing the request's buffer size?
>>
>> It won't help with the error reporting but should help with ensuring
>> that frames are sent out in one frameinterval with little to no
>> 0-length requests between them.
>>
>> The idea is that video_pump will have enough requests available to fully
>> encode the frame in one burst, and another frame's worth of request will=
 be
>> re-added to req_free list for video_pump to fill up in the time that the=
 next
>> frame comes in.
>>
>> >
>> > Which then led to the conclusion that the number of needed requests
>> > per image frame interval is calculatable since we know the usb
>> > interval length.
>> >
>> > @Thinh: Correct me if I am saying something wrong here.
>
>Right, if you max out the data rate per uframe, there's less opportunity
>for the host to schedule everything for that interval (e.g. affected
>from other endpoint/device traffics, link commands etc). It also
>increases the latency of DMA. In many cases, many other vendor hosts
>can't handle 48KB/uframe for SuperSpeed and 96KB/uframe for SuperSpeed
>Plus. So, you'd need to test your platform find the optimal request size
>so it can work for most hosts.
>
>> >
>> >>> Therefor to properly make those patches work, we will have to get ri=
d of
>
>Sorry if I may have missed the explaination, but why do we need to rid
>of this?


The uvc_video gadget is queueing requests with ep_queue whenever they
are prepared. However for uvc we may not send EOF to the host until
we know that the frame was transmitted correct or wrong.

To ensure this the gadget is waiting for the last request to be
completed from dwc3. Until this request was not received, the current
workflow is to enqueue zero-length requests into the dwc3 hw. With that,
the final EOF request for the frame will be transmitted after the
zero-length requests have passed the hw. (They have no data, but they
still take one frameinterval durtion). This sparsed frame with
zero-requests inbetween will interfere with the precalculation for
request data we fill every request with based on the expected frame
duration.

I know this seems very interlocked. It is very complex indeed. Tell
me if you still have questions and I will come up with some more
details to the current uvc_video driver.

>> >>> the zero length pump mechanism again and make sure that the whole
>> >>> business logic of what to be queued and when will only be done in the
>> >>> pump worker. It is possible to let the dwc3 udc run dry, as we are
>> >>> actively waiting for the frame to finish, the last request in the
>> >>> prepared and started list will stop the current dwc3 stream and=A0 f=
or
>> >>> no underruns will occur with the next ep_queue.
>> >>
>> >> One thing to note here: The reason we moved to queuing 0-length reque=
sts
>> >> from complete callback was because even with realtime priority, video=
_pump
>> >> thread doesn't always meet the ISOC queueing cadence. I think stoppin=
g and
>> >> starting the stream was briefly discussed in our initial discussion in
>> >> https://urldefense.com/v3/__https://lore.kernel.org/all/2023041900114=
3.pdxflhzyecf4kvee@synopsys.com/__;!!A4F2R9G_pg!ZmfvrPq4rs7MIhxNrrEqmgGrlYT=
J12WgdzaqQhfEehKfjKqxPr2bC1RzUqaa9tvdBtAvXdyK2GpxYzvslpV6$
>> >> and Thinh mentioned that dwc3 controller does it if it detects an und=
errun,
>> >> but I am not sure if starting and stopping an ISOC stream is good pra=
ctice.
>
>There's a workaround specific for UVC in dwc3 to "guess" when underrun
>happen. It's not foolproof. dwc3 should not need to do that.
>
>Isoc data is periodic and continuous. We should not expect this
>unconventional re-synchronization.

I think we have to discuss what is ment by resynchronization here. If
the trb ring buffer did run dry and the software is aware of this
(elemnt in the started and prepared list) then the interrupt handler
already is calling End Stream Command.

When the stream is stopped, what implications does this have on the bus?

When the Endpoint is enabled, will the hardware then send zero-length
requests on its own?

With the next ep_queue we start another stream and when we keep up with
this stream there is no underruns, right?

I picture this scenario in my mind:

thread 1: uvc->queue_buf is called:
   - we encode the frame buffer data into all available requests
     and put them into the per uvc_buffer perpared list
     (as we precalculated the amount of requests properly to the expected
      frame duration and buffer size there will be enough requests
      available)
   - wake up the pump thread

thread 2: pump_worker is triggered
   - take all requests from the prepared available buffer and enqueue them
     into the hardware
     (The pump worker is running with while(1) while it finds requests in
      the per buffer prepared list) and therefor will have a high chance
      to finish the pumping for one complete frame.
   - check for any errors reported from the complete handlers
     - on error
       - stop enqueing new requests from current frame
       - wait for the last request from errornous frame has returned
   - only start pumping new requests from the next buffer when the last
     request from the active frame has finished
   - In the beginning of the next frame send one extra request with
     EOF/ERR tag so the host knows that the last one was ok or not.

thread 3: complete handler (interrupt)
   - give back the requests into the empty_list
   - report EXDEV and errors
   - wake up the pump thread

With this method we will continously drain the hw trb stream of the dwc3
controller per frame and therefor will not shoot into one window where
the current stream could be missed. With the data spreading over the
many requests we also avoid the missed requests when the DMA was to
slow.

>> > The realtime latency aspect is not an issue anymore if we ensure that =
we
>> > always keep only one frame in the hw ring buffer. When the pump worker
>> > ensure that it will always run through one full frame the scheduler has
>> > no chance to break our running dwc3 stream. Since the pump is running
>> > under a while(1) this should be possible.
>>
>> I'll wait for your patch to see, but are you saying that we should have =
the
>> pump worker busy spinning  when there are no frames available? Cameras c=
annot
>> produce frames fast enough for video_pump to be constantly encoding fram=
es.
>> IIRC, "encoding" a frame to usb_requests took less than a ms or two on my
>> device, and frame interval is 33ms for a 30fps stream, so the CPU would =
be
>> busy spinning for ~30ms which is an unreasonable time for a CPU to be
>> idling.
>>
>> >
>> > Also with the request amount precalculation we can always encode the
>> > whole frame into all available requests and don't have to wait for
>> > requests to be available again.
>> >
>> > Together with the latest knowladge about the underlying hw we even nee=
d to only
>> > keep one frame in the HW ring buffer. Since we have some interrupt lat=
ency,
>> > keeping more frames in the ring buffer, would mean that we are not abl=
e to tag
>> > the currently streamed frame properly as errornous if the dwc3 hw ring=
 buffer
>> > is already telling the host some data about the next frame. And as we =
already
>> > need to wait for the end of the frame to finish, based on the assumpti=
on that
>> > only one frame is enqueued in the ring buffer the hw will stop the str=
eam and
>> > the next requst will start a new stream. So there will no missed under=
runs be
>> > happening.
>> >
>> > So the main fact here is, that telling the host some status about a
>> > frame in the past is impossible! Therefor the first request of the next
>> > hw stream need to be the one that is telling the Host if the previous =
frame
>> > is ment to be drawn or not.
>>
>> This is a fair point, but the timing on this becomes a little difficult =
if
>> the frame is sent over the entire frameinterval. If we wait for the enti=
re
>> frame to be transmitted, then we have 125us between the last request of a
>> frame being transmitted and the first request of the next frame being
>> queued. The userspace app producing the frames will have timing variatio=
ns
>> larger than 125us, so we cannot rely on a frame being available exactly =
as
>> one frame is fully transmitted, or of us being notified of transmission
>> status by the time the next frame comes in.
>>
>> >
>> >> Someone better versed in USB protocol can probably confirm, but it se=
ems
>> >> somewhat hacky to stop the ISOC stream at the end of the frame and re=
start
>> >> with the next frame.
>> >
>> > All I know is that the HW mechanism that is reading from the trb ring =
buffer is
>> > started or stopped I don't know if really the ISOC stream is stopped a=
nd
>> > restarted here or what that means on the real wire. And if so, I am un=
sure if
>> > that is really a problem or not. Thinh?
>
>For isoc IN endpoint, if the host requests for data while there's no TRB
>prepared, the controller would respond with 0-length data. When we stop
>and start again, we reschedule the prepared isoc data to go out on a new
>interval.
>
>>
>> Oh? That's great! If the controller can keep the ISOC stream from underr=
uning
>> without the gadget feeding it 0-length requests, then we can simplify the
>> gadget side implementation quite a bit!

>I'm not entirely clear on why we cannot use 0-length requests now. I
>hope we can resolve this from UVC function driver as it seems to be a
>proper place to handle this issue.

See above.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--xJdUWAcFD0bnMbji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZBPjgACgkQC+njFXoe
LGSwQxAAyEgYBlFxoGm2DV3b2VJymfpvQeJARVMZE+Nqcx4ZMsO1/idEFvoY1RQR
d9yEI1Xy8ANihpFliloKZJhp7rw8U6g9VGBNY/RkpZCiCaJnaBtoniVd1qD1A/+1
s3AL8Vh9SJlMNeuIF8Naf7h9er1x29hNRxD3rHRm9g2VMfJmUBkhhZuTVhIzba07
T8B89SBR47qkar/JieuuHtekaeBBtNCyqUqFx6YS7+7RoX63BGAZ7d14SVpi9LO8
pkeos9RLqi4vrAWoidk6nv619HgsxcwW0aOJVvPt35ozARseq2KinRispiPyKl9p
SgIo5R1u2YYV9PqASDo46ZVRY7g4wIqBvH3wxakuDLZf5apaWD96bJDpg1hEjnWy
1AIthgMgf8zszxDlZAdLF2h/i9jA9ZXjTJZCm8Q2vcPph076eOOJqN2gKd6TFutq
SCXxQXhaaLnxL0YSKP39PGh5rj9TKO6uJ513SqaItrjXuV/0QvMfs0kL/hlgAXnv
q8nz511FDXa6XXun0HwPUSxGpeQ2VmXF9a1eXEkZKxBM4lscOUUWG5IfsVfJOMEe
z1y9E9ouDhxPScD3sXFVzBXaDJdTy7PvVhFTo04+qI8nC22x943x9wGCSs6dAcFW
KCk4A02rdJb3ph6+7H8cp35I3125m/Sv48bMLXQsHXl8tS4Qyqs=
=XoCa
-----END PGP SIGNATURE-----

--xJdUWAcFD0bnMbji--


Return-Path: <linux-kernel+bounces-186122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6518CC00D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FDA281440
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79442824B5;
	Wed, 22 May 2024 11:16:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49915FBB3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376576; cv=none; b=c8mHd4Hl4WtglWmNrGiRk0i+7w0nRW1Yc29y34DfeTmECAV0KRVvfvhniaasG4oegprDB8U2QmkVqwfAto0gRBOUU+eWQoIdaJ7QDUO15QKrv1cryDnu9eF2eFxA2j/Jb5KHwwYpSEcQ7Ve2lkh52snCjNo1NfilQpYOgogCpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376576; c=relaxed/simple;
	bh=2qrHJvxFGgkj1C+F34SCxiJvCJwo/0Xy3ijXWINUAgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3VqAIX6Ah528dS/+nlkGRSD97Jz3xjHEZ8vke0HVZEjRG2B9Tofwro2DvbyqBbuwHmVviJTYtM3hSGFeeH12P/b4npDYer+GjibrwYAl0L1Z7UwugoppX+rZibpUCYCClsTnLwSgqUmaKFbVoJwhMmTXHi052B5T/bbKYozyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9jwx-0005Pf-9r; Wed, 22 May 2024 13:16:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9jww-002W5k-Ck; Wed, 22 May 2024 13:16:02 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s9jww-007vQD-0v;
	Wed, 22 May 2024 13:16:02 +0200
Date: Wed, 22 May 2024 13:16:02 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Avichal Rakesh <arakesh@google.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jayant Chowdhary <jchowdhary@google.com>, etalvala@google.com,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Message-ID: <Zk3T8pR3AUL1_mOD@pengutronix.de>
References: <ZiWga5Kqno1ICv97@pengutronix.de>
 <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Icf4SCcOPSanp+ek"
Content-Disposition: inline
In-Reply-To: <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--Icf4SCcOPSanp+ek
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 04:23:23PM -0700, Avichal Rakesh wrote:
>
>
>On 4/23/24 07:25, Michael Grzeschik wrote:
>> Ccing:
>>
>> Michael Riesch <michael.riesch@wolfvision.net>
>> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>
>> On Mon, Apr 22, 2024 at 05:21:09PM -0700, Avichal Rakesh wrote:
>>> On 4/21/24 16:25, Michael Grzeschik wrote:
>>>> On Tue, Apr 09, 2024 at 11:24:56PM +0200, Michael Grzeschik wrote:
>>>>> This patch series is improving the size calculation and allocation
>>>>> of the uvc requests. Using the currenlty setup frame duration of the
>>>>> stream it is possible to calculate the number of requests based on the
>>>>> interval length.
>>>>
>>>> The basic concept here is right. But unfortunatly we found out that
>>>> together with Patch [1] and the current zero length request pump
>>>> mechanism [2] and [3] this is not working as expected.
>>>>
>>>> The conclusion that we can not queue more than one frame at once into
>>>> the hw led to [1]. The current implementation of zero length reqeusts
>>>> which will be queued while we are waiting for the frame to finish
>>>> transferring will enlarge the frame duration. Since every zero-length
>>>> request is still taking up at least one frame interval of 125 us.
>>>
>>> I haven't taken a super close look at your patches, so please feel free
>>> to correct me if I am misunderstanding something.
>>>
>>> It looks like the goal of the patches is to determine a better number
>>> and size of usb_requests from the given framerate such that we send exa=
ctly
>>> nreqs requests per frame where nreqs is determined to be the exact numb=
er
>>> of requests that can be sent in one frame interval?
>>
>> It does not need to be the exact time, actually it may not be exact.
>> Scattering the data over all requests would not leave any headroom for
>> any latencies or overhead.
>
>IIUC, patch 3/3 sets the number of requests to frameinterval / 125 us,
>which gives us the number of requests we can send in exactly one frame int=
erval,
>and then sets the size of the request as max framesize / nreq, which means=
 the
>frames will be evenly divided up into all available requests (with a little
>fuzz factor here and there).
>
>This effectively means that (assuming no other delays) one frame will take
>~one frameinterval to be transmitted?

In theory yes. But we have to add some headroom delay into the
calculation. The worst case we have to takle here is to leave the
encoding thread enough time to encode one full frame.

>>> As the logic stands, we need some 0-length requests to be circulating to
>>> ensure that we don't miss ISOC deadlines. The current logic uncondition=
ally
>>> sends half of all allocated requests to be circulated.
>>>
>>> With those two things in mind, this means than video_pump can at encode
>>> at most half a frame in one go, and then has to wait for complete
>>> callbacks to come in. In such cases, the theoretical worst case for
>>> encode time is
>>> 125us * (number of requests needed per frame / 2) + scheduling delays
>>> as after the first half of the frame has been encoded, the video_pump
>>> thread will have to wait 125us for each of the zero length requests to
>>> be returned.
>>>
>>> The underlying assumption behind the "queue 0-length requests" approach
>>> was that video_pump encodes the frames in as few requests as possible
>>> and that there are spare requests to maintain a pressure on the
>>> ISOC queue without hindering the video_pump thread, and unfortunately
>>> it seems like patch 3/3 is breaking both of them?
>>
>> Right.
>>
>>> Assuming my understanding of your patches is correct, my question
>>> is: Why do we want to spread the frame uniformly over the requests
>>> instead of encoding it in as few requests as possible. Spreading
>>> the frame over more requests artificially increases the encode time
>>> required by video_pump, and AFAICT there is no real benefit to it?
>>
>> Thinh gave me the advise that it is better to use the isoc stream
>> constantly filled. Rather then streaming big amounts of data in the
>> beginning of an frameinterval and having then a lot of spare time
>> where the bandwidth is completely unsused.
>>
>> In our reallife scenario streaming big requests had the impact, that
>> the dwc3 core could not keep up with reading the amount of data
>> from the memory bus, as the bus is already under heavy load. When the
>> HW was then not able to transfer the requested and actually available
>> amount of data in the interval, the hw did give us the usual missed
>> interrupt answer.
>>
>> Using smaller requests solved the problem here, as it really was
>> unnecessary to stress the memory and usb bus in the beginning as
>> we had enough headroom in the temporal domain.
>
>Ah, I see. This was not a consideration, and it makes sense if USB
>bus is under contention from a few different streams. So the solution
>seems to be to spread the frame of as many requests as we can transmit
>in one frameinterval?

Right.

>As an experiment, while we wait for others to respond, could you try
>doubling (or 2.5x'ing to be extra safe) the number of requests allocated
>by patch 3/3 without changing the request's buffer size?
>
>It won't help with the error reporting but should help with ensuring
>that frames are sent out in one frameinterval with little to no
>0-length requests between them.

This is okay, but will not help since we have to wait for the frame to
finish.

>The idea is that video_pump will have enough requests available to fully
>encode the frame in one burst, and another frame's worth of request will be
>re-added to req_free list for video_pump to fill up in the time that the n=
ext
>frame comes in.

Right but because of the zero requests between the frame finish request
we will unnecessary blow up the frame duration. Although there are not
many zero-requests.

>> Which then led to the conclusion that the number of needed requests
>> per image frame interval is calculatable since we know the usb
>> interval length.
>>
>> @Thinh: Correct me if I am saying something wrong here.
>>
>>>> Therefor to properly make those patches work, we will have to get rid =
of
>>>> the zero length pump mechanism again and make sure that the whole
>>>> business logic of what to be queued and when will only be done in the
>>>> pump worker. It is possible to let the dwc3 udc run dry, as we are
>>>> actively waiting for the frame to finish, the last request in the
>>>> prepared and started list will stop the current dwc3 stream and=A0 for
>>>> no underruns will occur with the next ep_queue.
>>>
>>> One thing to note here: The reason we moved to queuing 0-length requests
>>> from complete callback was because even with realtime priority, video_p=
ump
>>> thread doesn't always meet the ISOC queueing cadence. I think stopping =
and
>>> starting the stream was briefly discussed in our initial discussion in
>>> https://lore.kernel.org/all/20230419001143.pdxflhzyecf4kvee@synopsys.co=
m/
>>> and Thinh mentioned that dwc3 controller does it if it detects an under=
run,
>>> but I am not sure if starting and stopping an ISOC stream is good pract=
ice.
>>
>> The realtime latency aspect is not an issue anymore if we ensure that we
>> always keep only one frame in the hw ring buffer. When the pump worker
>> ensure that it will always run through one full frame the scheduler has
>> no chance to break our running dwc3 stream. Since the pump is running
>> under a while(1) this should be possible.
>
>I'll wait for your patch to see, but are you saying that we should have the
>pump worker busy spinning  when there are no frames available? Cameras can=
not
>produce frames fast enough for video_pump to be constantly encoding frames.
>IIRC, "encoding" a frame to usb_requests took less than a ms or two on my
>device, and frame interval is 33ms for a 30fps stream, so the CPU would be
>busy spinning for ~30ms which is an unreasonable time for a CPU to be
>idling.

I hope the whole Idea got much clearer to you while I was discussing the
topic and the roadmap with Thinh the last days.

>> Also with the request amount precalculation we can always encode the
>> whole frame into all available requests and don't have to wait for
>> requests to be available again.
>>
>> Together with the latest knowladge about the underlying hw we even need =
to only
>> keep one frame in the HW ring buffer. Since we have some interrupt laten=
cy,
>> keeping more frames in the ring buffer, would mean that we are not able =
to tag
>> the currently streamed frame properly as errornous if the dwc3 hw ring b=
uffer
>> is already telling the host some data about the next frame. And as we al=
ready
>> need to wait for the end of the frame to finish, based on the assumption=
 that
>> only one frame is enqueued in the ring buffer the hw will stop the strea=
m and
>> the next requst will start a new stream. So there will no missed underru=
ns be
>> happening.
>>
>> So the main fact here is, that telling the host some status about a
>> frame in the past is impossible! Therefor the first request of the next
>> hw stream need to be the one that is telling the Host if the previous fr=
ame
>> is ment to be drawn or not.
>
>This is a fair point, but the timing on this becomes a little difficult if
>the frame is sent over the entire frameinterval. If we wait for the entire
>frame to be transmitted, then we have 125us between the last request of a
>frame being transmitted and the first request of the next frame being
>queued. The userspace app producing the frames will have timing variations
>larger than 125us, so we cannot rely on a frame being available exactly as
>one frame is fully transmitted, or of us being notified of transmission
>status by the time the next frame comes in.
>
>>
>>> Someone better versed in USB protocol can probably confirm, but it seems
>>> somewhat hacky to stop the ISOC stream at the end of the frame and rest=
art
>>> with the next frame.
>>
>> All I know is that the HW mechanism that is reading from the trb ring bu=
ffer is
>> started or stopped I don't know if really the ISOC stream is stopped and
>> restarted here or what that means on the real wire. And if so, I am unsu=
re if
>> that is really a problem or not. Thinh?
>
>Oh? That's great! If the controller can keep the ISOC stream from underrun=
ing
>without the gadget feeding it 0-length requests, then we can simplify the
>gadget side implementation quite a bit!

Exactly that is the case.

Can you followup to my discussion with Thinh and add your thougts
to the whole idea.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Icf4SCcOPSanp+ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZN0+8ACgkQC+njFXoe
LGRdDw/+LWgLqw7x5Op6Lxf4p3h+Rp4mIYT51EGHhSoL6ZOYuqDvKz1lTeQgAdCN
Y4UEEQC/FExA9dWpC4vYwc/21qyF+kyE3l6RIz6TFmTAhrFPRf41eB0c+Lb33Vy2
6TAsbh8Ci57LJAwJN998CNZbO3G4UO5lcc7+YDEwHiAYVZmhRGd6ys0eCr106xtl
FuEaTOtLg+5471SFwWOKc7NmAiGBAW6vTt1ZyLZ/wYnwlG01gceG6XvXrY8uQ4Tb
wqjYSuMEPSt3eNe2GBhGsGEVn+SJ+V8wezvYNmGxRPHCoflXAhWx5WM61xKjvje1
CfePS2aC/mmx+CgMedvdifJZrZM3zZYLgeFvjamwZP/vdGjjV17EGAZqqfvq23EZ
geh+JRrSu9OsflBB/nVMLfhEIKce+xP18rvlxgl+3cdHRMV47nRciMtBNttHySU0
GaaJKPIZpUfEsj1sqxx7OLUJdp7j5AaX3rYdUIs5Xc6Y8De4cx9+S+cqHUwl5yy6
28MZJjRPxF6D1347np2WzuVTg6JagE6tvYfZSaVkaZMQP4NP/s13TWTDoUranxIq
pNxxRNV/SoxvhsXZxi/DKSDrqw54rkeB0U6Rhh8kAxeHOxRoyL/QEghaglmEhbwc
MiHbZjad6c2FSTY87AgGwSnS4+btY3QHmOIW03c/iC4GjNv1xbA=
=3m3t
-----END PGP SIGNATURE-----

--Icf4SCcOPSanp+ek--


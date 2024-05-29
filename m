Return-Path: <linux-kernel+bounces-194703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE568D403E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AFFB2452C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D881C9EA7;
	Wed, 29 May 2024 21:24:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221461C6884
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017875; cv=none; b=qhS9cGcwHCpRu6P83MijQwkAa0OgcdxdAc/bokt5ULa5m+PRg5AnxkkKN39Leo7v6eow2GHlMjcBIA6Lee9XOatJsWJTVgldm7EV9+riKqhU1EX9kZLcUbh55onmzkX7mwoM3uN265qNRVbAIU3tL/T9L+SPD+F31As3wjJS/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017875; c=relaxed/simple;
	bh=AiobMrGQILT4QrzJcMsxFSTQflVP48dyRLKT6RFHuZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXJJoqjeAkPlx3BrkncrzytA6fLC0YLCm9fD8J3kb+0KW/vPa10yBiPdk/r51Ai7yxoidaV7QsHpPV+YgHQBo24E71wji3mt2RS8zQGxZ7uc1mfSc2+LkF1XPC8B7zI0H/Ud92snB1AVQtdJ62zj78QLGMg3nckj8Ro6wmI+69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sCQmS-0007MA-ME; Wed, 29 May 2024 23:24:20 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sCQmQ-003Vmo-MZ; Wed, 29 May 2024 23:24:18 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sCQmQ-003IbX-1w;
	Wed, 29 May 2024 23:24:18 +0200
Date: Wed, 29 May 2024 23:24:18 +0200
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
Message-ID: <ZledAuxYrxZlJ0ow@pengutronix.de>
References: <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
 <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
 <ZlY88BebTEZs6urD@pengutronix.de>
 <0642b7a2-0982-4529-b742-3310f34d16b9@google.com>
 <ZlZeHLmKnw1mApKM@pengutronix.de>
 <adabc6f5-1b87-4bbe-9070-984f0acc8e75@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ybq4RvHIPSf7f10"
Content-Disposition: inline
In-Reply-To: <adabc6f5-1b87-4bbe-9070-984f0acc8e75@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--5ybq4RvHIPSf7f10
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 05:33:46PM -0700, Avichal Rakesh wrote:
>
>
>On 5/28/24 15:43, Michael Grzeschik wrote:
>> On Tue, May 28, 2024 at 02:27:34PM -0700, Avichal Rakesh wrote:
>>>
>>>
>>> On 5/28/24 13:22, Michael Grzeschik wrote:
>>>> On Tue, May 28, 2024 at 10:30:30AM -0700, Avichal Rakesh wrote:
>>>>>
>>>>>
>>>>> On 5/22/24 10:37, Michael Grzeschik wrote:
>>>>>> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>>>>>>> On Wed, May 22, 2024, Alan Stern wrote:
>>>>>>>> On Wed, May 22, 2024 at 01:41:42AM +0000, Thinh Nguyen wrote:
>>>>>>>> > On Wed, May 22, 2024, Michael Grzeschik wrote:
>>>>>>>> > > On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>>>>>>>> > > > For isoc endpoint IN, yes. If the host requests for isoc dat=
a IN while
>>>>>>>> > > > no TRB is prepared, then the controller will automatically s=
end 0-length
>>>>>>>> > > > packet respond.
>>>>>>>> > >
>>>>>>>> > > Perfect! This will help a lot and will make active queueing of=
 own
>>>>>>>> > > zero-length requests run unnecessary.
>>>>>>>> >
>>>>>>>> > Yes, if we rely on the current start/stop isoc transfer scheme f=
or UVC,
>>>>>>>> > then this will work.
>>>>>>>>
>>>>>>>> You shouldn't rely on this behavior.=A0 Other device controllers m=
ight not
>>>>>>>> behave this way; they might send no packet at all to the host (cau=
sing a
>>>>>>>> USB protocol error) instead of sending a zero-length packet.
>>>>>>>
>>>>>>> I agree. The dwc3 driver has this workaround to somewhat work with =
the
>>>>>>> UVC. This behavior is not something the controller expected, and th=
is
>>>>>>> workaround should not be a common behavior for different function
>>>>>>> driver/protocol. Since this behavior was added a long time ago, it =
will
>>>>>>> remain the default behavior in dwc3 to avoid regression with UVC (at
>>>>>>> least until the UVC is changed). However, it would be nice for UVC =
to
>>>>>>> not rely on this.
>>>>>>
>>>>>> With "this" you mean exactly the following commit, right?
>>>>>>
>>>>>> (f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the=
 active xfer)
>>>>>>
>>>>>> When we start questioning this, then lets dig deeper here.
>>>>>>
>>>>>> With the fast datarate of at least usb superspeed shouldn't they not=
 all
>>>>>> completely work asynchronous with their in flight trbs?
>>>>>>
>>>>>> In my understanding this validates that, with at least superspeed we=
 are
>>>>>> unlikely to react fast enough to maintain a steady isoc dataflow, si=
nce
>>>>>> the driver above has to react to errors in the processing context.
>>>>>>
>>>>>> This runs the above patch (f5e46aa4) a gadget independent solution
>>>>>> which has nothing to do with uvc in particular IMHO.
>>>>>>
>>>>>> How do other controllers and their drivers work?
>>>>>>
>>>>>>> Side note, when the dwc3 driver reschedules/starts isoc transfer ag=
ain,
>>>>>>> the first transfer will be scheduled go out at some future interval=
 and
>>>>>>> not the next immediate microframe. For UVC, it probably won't be a
>>>>>>> problem since it doesn't seem to need data going out every interval.
>>>>>>
>>>>>> It should not make a difference. [TM]
>>>>>>
>>>>>
>>>>>
>>>>> Sorry for being absent for a lot of this discussion.
>>>>>
>>>>> I want to take a step back from the details of how we're
>>>>> solving the problem to what problems we're trying to solve.
>>>>>
>>>>> So, question(s) for Michael, because I don't see an explicit
>>>>> answer in this thread (and my sincerest apologies if they've
>>>>> been answered already and I missed it):
>>>>>
>>>>> What exactly is the bug (or bugs) we're trying to solve here?
>>>>>
>>>>> So far, it looks like there are two main problems being
>>>>> discussed:
>>>>>
>>>>> 1. Reducing the bandwidth usage of individual usb_requests
>>>>> 2. Error handling for when transmission over the wire fails.
>>>>>
>>>>> Is that correct, or are there other issues at play here?
>>>>
>>>> That is correct.
>>>>
>>>>> (1) in isolation should be relatively easy to solve: Just
>>>>> smear the encoded frame across some percentage
>>>>> (prefereably < 100%) of the usb_requests in one
>>>>> video frame interval.
>>>>
>>>> Right.
>>>>
>>>>> (2) is more complicated, and your suggestion is to have a
>>>>> sentinel request between two video frames that tells the
>>>>> host if the transmission of "current" video frame was
>>>>> successful or not. (Is that correct?)
>>>>
>>>> Right.
>>>>
>>>>> Assuming my understanding of (2) is correct, how should
>>>>> the host behave if the transmission of the sentinel
>>>>> request fails after the video frame was sent
>>>>> successfully (isoc is best effort so transmission is
>>>>> never guaranteed)?
>>>>
>>>> If we have transmitted all requests of the frame but would only miss t=
he
>>>> sentinel request to the host that includes the EOF, the host could
>>>> rather show it or drop it. The drop would not be necessary since the
>>>> host did see all data of the frame. The user would not see any
>>>> distortion in both cases.
>>>>
>>>> If we have transmitted only partial data of the frame it would be
>>>> preferred if the host would drop the frame that did not finish with an
>>>> proper EOF tag.
>>>>
>>>> AFAIK the linux kernel would still show the frame if the FID of the
>>>> currently handled request would change and would take this as the end =
of
>>>> frame indication. But I am not totally sure if this is by spec or
>>>> optional.
>>>>
>>>> One option to be totally sure would be to resend the sentinel request =
to
>>>> be properly transmitted before starting the next frame. This resend
>>>> polling would probably include some extra zero-length requests. But al=
so
>>>> if this resend keeps failing for n times, the driver should doubt there
>>>> is anything sane going on with the USB connection and bail out somehow.
>>>>
>>>> Since we try to tackle case (1) to avoid transmit errors and also avoid
>>>> creating late enqueued requests in the running isoc transfer, the over
>>>> all chance to trigger missed transfers should be minimal.
>>>
>>> Gotcha. It seems like the UVC gadget driver implicitly assumes that EOF
>>> flag will be used although the userspace application can technically
>>> make it optional.
>>
>> That is not all. The additional UVC_STREAM_ERR tag on the sentinel
>> request can be set optional by the host driver. But by spec the
>> userspace application has to drop the frame when the flag was set.
>
>Looking at the UVC specs, the ERR bit doesn't seem to refer to actual
>transmission error, only errors in frame generation (Section 4.3.1.7
>of UVC 1.5 Class Specification). Maybe "data discontinuity" can be
>used but the examples given are bad media, and encoder issues, which
>suggests errors at higher level than the wire.

Oh! That is a new perspective I did not consider.

With the definition of UVC_STREAM_ERR by spec, the uvc_video driver
would in no case set this header bit for the current frame on its own?
Is that correct?

>> With my proposal this flag will be set, whenever we find out that
>> the currently transferred frame was erroneous.
>>
>>> Summarizing some of the discussions above:
>>> 1. UVC gadget driver should _not_ rely on the usb controller to
>>> =A0 enqueue 0-length requests on UVC gadget drivers behalf;
>>> 2. However keeping up the backpressure to the controller means the
>>> =A0 EOF request will be delayed behind all the zero-length requests.
>>
>> Exactly, this is why we have to somehow finetune the timedelay between
>> requests that trigger interrupts. And also monitor the amount of
>> requests currently enqueued in the hw ringbuffer. So that our drivers
>> enqueue dequeue mechanism is virtually adding only the minimum amount
>> of necessary zero-length requests in the hardware. This should be
>> possible.
>>
>> I am currently thinking through the remaining steps the pump worker has
>> to do on each wakeup to maintain the minimum threshold while waiting
>> with submitting requests that contain actual image payload.
>>
>>> Out of curiosity: What is wrong with letting the host rely on
>>> FID alone? Decoding the jpeg payload _should_ fail if any of the
>>> usb_requests containing the payload failed to transmit.
>>
>> This is not totally true. We saw partially rendered jpeg frames on the
>> host stream. How the host behaves with broken data is totally undefined
>> if the typical uvc flags EOF/ERR are not used as specified. Then think
>> about uncompressed formats. So relying on the transferred image format
>> to solve our problems is just as wrong as relying on the gadgets
>> hardware behavior.
>
>Do you know if the partially rendered frames were valid JPEGs, or
>if the host was simply making a best effort at displaying a broken
>JPEG? Perhaps the fix should go to the host instead?

I can fully reproduce this with linux and windows hosts. For linux
machines I saw that the host was taking the FID change as a marker
to see the previous frame as ready and just rendered what got through.
This did not lead to garbage but only to partially displayed frames
with jpeg macroblock alignment.

>Following is my opinion, feel free to disagree (and correct me if
>something is factually incorrect):
>
>The fundamental issue here is that ISOC doesn't guarantee
>delivery of usb_requests or even basic data consistency upon delivery.
>So the gadget driver has no way to know the state of transmitted data.
>The gadget driver is notified of underruns but not of any other issues,
>and ideally we should never have an underrun if the zero-length
>backpressure is working as intended.
>
>So, UVC gadget driver can reduce the number of errors, but it'll never be
>able to guarantee that the data transmitted to the host isn't somehow
>corrupted or missing unless a more reliable mode of transmission
>(bulk, for example) is used.
>
>All of this to say: The host absolutely needs to be able to handle
>all sorts of invalid and broken payloads. How the host handles it
>might be undefined, but the host can never rely on perfect knowledge
>about the transmission state. In cases like these, where the underlying
>transport is unreliable, the burden of enforcing consistency moves up
>a layer, i.e. to the encoded payload in this case. So it is perfectly
>fine for the host to rely on the encoding to determine if the payload
>is corrupt and handle it accordingly.

Right.

>As for uncompressed format, you're correct that subtle corruptions
>may not be caught, but outright missing usb_requests can be easily
>checked by simply looking at the number of bytes in the payload. YUV
>frames are all of the same (predetermined) size for a given resolution.

That was also my thought about five minutes after I did send you the
previous mail. So sure, this is no real issue for the host.

>So my recommendation is the following:
>1. Fix the bandwidth problem by splitting the encoded video frame
>   into more usb_requests (as your patch already does) making sure
>   there are enough free usb_request to encode the video frame in
>   one burst so we don't accidentally inflate the transmission
>   duration of a video frame by sneaking in zero-length requests in
>   the middle.

Ack. This should already solve a lot of issues.

For this I would still suggest to move the usb_ep_queue to be done in
the pump worker again. Its a bit back and forth, but IMHO its worth the
extra mile since only this way we would respect the dwc3 interrupt
threads assumption to run *very* short.

>2. Unless there is an unusually high rate of transmission failures
>   when using the UVC gadget driver, it might be worth fixing the
>   host side driver to handle broken frames better instead (assuming
>   host is linux as well).

Agreed, but this needs a separate scoped undestanding of the host side
behaviour over all layers.

>2. Tighten up the error checking in UVC gadget driver -- We drop the
>   current frame whenever an EXDEV happens which is wrong. We should
>   only be dropping the current frame if the EXDEV corresponds to the
>   frame currently being encoded.

What do you mean by drop?

I would suggest to immediatly switch the uvc_buffer that is being
enqueued and start queueing prepared requests from the next buffers prep
list. As suggested, the idea is to have per uvc_buffer prep_list
requests which would make this task easy.

>   If the frame is already fully queued to the usb controller, the host
>   can handle missing payload as it sees fit.

Ack

This roadmap sounds like a good one.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5ybq4RvHIPSf7f10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZXnP8ACgkQC+njFXoe
LGSq5Q//WUknvXh7uLTVJLzkjy1O09hNKS6z5lk5GMuIdlOYRBOBR3Kpr5xcVVOE
YudCL2TCdECY/yCq+BCtm3XeXCvXHFGLUHxzjsl/5X1CDNNGTrbRluH/pBQIMzBB
9jmicboVogS1U8fzDqhYbDhhnt/qe1PzaLWbg0H6+H8SPpwKlbjCvkCwO41pG4DO
TLe/k9kDfn/RZcpqyac0V9UQSmvruIJfZKJfk7qrB0z76vOK/uWDlTYkyYN4s8Kk
MKuvLI420C9SbnkPj5vYNzB+SPWWx1xz3WnIQkjOpp3wY4a1oyEr+znai1s/eS3k
zjB3e0Lcus3cm08Ef/Ic+riGEGBNFscyEBpmMsnz+njC4E5z5uc0Zj5YZ635/NBl
Spzcf/pNcVWoXvXXsDkggNC/imTyg4stxjnIDMsuhC/7McZjxIfHIbjbvvh0zYvy
y/SWmG9MpfpeJcjxQQNQ/OJOZu89H1Drs4uEpPLBaEOzh2COCilStyNez/mwvhOq
72GwFyl8DwN4IljZh3bZq7U/UN/mmTG7mERbIhfdSinbruSYiEkWqiOK86wZufjp
MPqz4m8X4pK2B7KFvtCI538/Rj30rJyHNQmK7Amgcs7nQ4g5vue3ilTiyEK6M5bp
9SIUb/yBW1gGRiQWIJiOUzW4tdoTlayPMAI8yA4A4l7eER055w0=
=SqTy
-----END PGP SIGNATURE-----

--5ybq4RvHIPSf7f10--


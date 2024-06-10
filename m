Return-Path: <linux-kernel+bounces-208934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A87902AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26209284A80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B114E2E2;
	Mon, 10 Jun 2024 21:44:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A1823A3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055880; cv=none; b=Lw2C1VGATP/+MuA8wmMp3YPAu+ZKp0b4YxSFszZKjYMeuUsJxrQKdzjPvzK/LzO6OkRr5eZ/2fiPbIeQgx43PK8Vvb2bYc5rZq1Ge66eK5rZRP4gmMh4oclp5pXloa5ZtiD7YRjWyEbEeDCIFL0eYL1OBIBdie2afx7DI/CnBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055880; c=relaxed/simple;
	bh=SsqwOiCAFRYmqiIjDvkBL6Xul8RRA+1DQbRsyFKzs8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0H3vRAVs3/UcYu0AwhMq4/wyDlMrFmKEphZIZOqPNeB8cM5fkZxFfXqzMaV/Ez8fUB6HS+ZxjmdD/HsdkO8+rqPb7l2nT99//LDY1idy5BPYRRxu44F/ypD+14h98B819+wsyda0W6lai2bIAFYj9lpuqRzQIPaG8xcYLyF0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sGmoS-0005yZ-5m; Mon, 10 Jun 2024 23:44:24 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sGmoP-001Odf-JX; Mon, 10 Jun 2024 23:44:21 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sGmoP-002uHB-1d;
	Mon, 10 Jun 2024 23:44:21 +0200
Date: Mon, 10 Jun 2024 23:44:21 +0200
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
Message-ID: <ZmdztaLmv5YWl3c1@pengutronix.de>
References: <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
 <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
 <ZlY88BebTEZs6urD@pengutronix.de>
 <0642b7a2-0982-4529-b742-3310f34d16b9@google.com>
 <ZlZeHLmKnw1mApKM@pengutronix.de>
 <adabc6f5-1b87-4bbe-9070-984f0acc8e75@google.com>
 <ZledAuxYrxZlJ0ow@pengutronix.de>
 <6b0421e0-8c5a-409b-8f34-3a041c838748@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qgDXMBDKtCgkpbIs"
Content-Disposition: inline
In-Reply-To: <6b0421e0-8c5a-409b-8f34-3a041c838748@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--qgDXMBDKtCgkpbIs
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 03:32:15PM -0700, Avichal Rakesh wrote:
>
>
>On 5/29/24 14:24, Michael Grzeschik wrote:
>> On Tue, May 28, 2024 at 05:33:46PM -0700, Avichal Rakesh wrote:
>>>
>>>
>>> On 5/28/24 15:43, Michael Grzeschik wrote:
>>>> On Tue, May 28, 2024 at 02:27:34PM -0700, Avichal Rakesh wrote:
>>>>>
>>>>>
>>>>> On 5/28/24 13:22, Michael Grzeschik wrote:
>>>>>> On Tue, May 28, 2024 at 10:30:30AM -0700, Avichal Rakesh wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 5/22/24 10:37, Michael Grzeschik wrote:
>>>>>>>> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>>>>>> One option to be totally sure would be to resend the sentinel reques=
t to
>>>>>> be properly transmitted before starting the next frame. This resend
>>>>>> polling would probably include some extra zero-length requests. But =
also
>>>>>> if this resend keeps failing for n times, the driver should doubt th=
ere
>>>>>> is anything sane going on with the USB connection and bail out someh=
ow.
>>>>>>
>>>>>> Since we try to tackle case (1) to avoid transmit errors and also av=
oid
>>>>>> creating late enqueued requests in the running isoc transfer, the ov=
er
>>>>>> all chance to trigger missed transfers should be minimal.
>>>>>
>>>>> Gotcha. It seems like the UVC gadget driver implicitly assumes that E=
OF
>>>>> flag will be used although the userspace application can technically
>>>>> make it optional.
>>>>
>>>> That is not all. The additional UVC_STREAM_ERR tag on the sentinel
>>>> request can be set optional by the host driver. But by spec the
>>>> userspace application has to drop the frame when the flag was set.
>>>
>>> Looking at the UVC specs, the ERR bit doesn't seem to refer to actual
>>> transmission error, only errors in frame generation (Section 4.3.1.7
>>> of UVC 1.5 Class Specification). Maybe "data discontinuity" can be
>>> used but the examples given are bad media, and encoder issues, which
>>> suggests errors at higher level than the wire.
>>
>> Oh! That is a new perspective I did not consider.
>>
>> With the definition of UVC_STREAM_ERR by spec, the uvc_video driver
>> would in no case set this header bit for the current frame on its own?
>> Is that correct?
>
>It would indeed seem so. The way gadget driver is architected makes
>is impossible for the userspace application to notify the host of
>any errors.
>
>>
>>>> With my proposal this flag will be set, whenever we find out that
>>>> the currently transferred frame was erroneous.
>>>>
>>>>> Summarizing some of the discussions above:
>>>>> 1. UVC gadget driver should _not_ rely on the usb controller to
>>>>> =A0 enqueue 0-length requests on UVC gadget drivers behalf;
>>>>> 2. However keeping up the backpressure to the controller means the
>>>>> =A0 EOF request will be delayed behind all the zero-length requests.
>>>>
>>>> Exactly, this is why we have to somehow finetune the timedelay between
>>>> requests that trigger interrupts. And also monitor the amount of
>>>> requests currently enqueued in the hw ringbuffer. So that our drivers
>>>> enqueue dequeue mechanism is virtually adding only the minimum amount
>>>> of necessary zero-length requests in the hardware. This should be
>>>> possible.
>>>>
>>>> I am currently thinking through the remaining steps the pump worker has
>>>> to do on each wakeup to maintain the minimum threshold while waiting
>>>> with submitting requests that contain actual image payload.
>>>>
>>>>> Out of curiosity: What is wrong with letting the host rely on
>>>>> FID alone? Decoding the jpeg payload _should_ fail if any of the
>>>>> usb_requests containing the payload failed to transmit.
>>>>
>>>> This is not totally true. We saw partially rendered jpeg frames on the
>>>> host stream. How the host behaves with broken data is totally undefined
>>>> if the typical uvc flags EOF/ERR are not used as specified. Then think
>>>> about uncompressed formats. So relying on the transferred image format
>>>> to solve our problems is just as wrong as relying on the gadgets
>>>> hardware behavior.
>>>
>>> Do you know if the partially rendered frames were valid JPEGs, or
>>> if the host was simply making a best effort at displaying a broken
>>> JPEG? Perhaps the fix should go to the host instead?
>>
>> I can fully reproduce this with linux and windows hosts. For linux
>> machines I saw that the host was taking the FID change as a marker
>> to see the previous frame as ready and just rendered what got through.
>> This did not lead to garbage but only to partially displayed frames
>> with jpeg macroblock alignment.
>
>I was aware of linux doing so, but I only ever saw this behavior on
>Windows if there were a lot of invalid frames back to back.
>
>I am not super familiar with the guarantees of JPEG, but I suppose
>it is possible to have a "valid" JPEG with some middle blocks
>missing as long the EOI bits make it through? I am not sure how we
>go about solving that.

It is even worse. Since we don't necessary need the EOF tag set but the
host will draw the content that it got after the FID has changed. It is
always possible that an frame that was errornous and therefor dropped
on the sendin side, will be shown on the host to the last macroblock it
received. So these partially drawn frames are more common then expected.

>>> Following is my opinion, feel free to disagree (and correct me if
>>> something is factually incorrect):
>>>
>>> The fundamental issue here is that ISOC doesn't guarantee
>>> delivery of usb_requests or even basic data consistency upon delivery.
>>> So the gadget driver has no way to know the state of transmitted data.
>>> The gadget driver is notified of underruns but not of any other issues,
>>> and ideally we should never have an underrun if the zero-length
>>> backpressure is working as intended.
>>>
>>> So, UVC gadget driver can reduce the number of errors, but it'll never =
be
>>> able to guarantee that the data transmitted to the host isn't somehow
>>> corrupted or missing unless a more reliable mode of transmission
>>> (bulk, for example) is used.
>>>
>>> All of this to say: The host absolutely needs to be able to handle
>>> all sorts of invalid and broken payloads. How the host handles it
>>> might be undefined, but the host can never rely on perfect knowledge
>>> about the transmission state. In cases like these, where the underlying
>>> transport is unreliable, the burden of enforcing consistency moves up
>>> a layer, i.e. to the encoded payload in this case. So it is perfectly
>>> fine for the host to rely on the encoding to determine if the payload
>>> is corrupt and handle it accordingly.
>>
>> Right.
>>
>>> As for uncompressed format, you're correct that subtle corruptions
>>> may not be caught, but outright missing usb_requests can be easily
>>> checked by simply looking at the number of bytes in the payload. YUV
>>> frames are all of the same (predetermined) size for a given resolution.
>>
>> That was also my thought about five minutes after I did send you the
>> previous mail. So sure, this is no real issue for the host.
>>
>>> So my recommendation is the following:
>>> 1. Fix the bandwidth problem by splitting the encoded video frame
>>> =A0 into more usb_requests (as your patch already does) making sure
>>> =A0 there are enough free usb_request to encode the video frame in
>>> =A0 one burst so we don't accidentally inflate the transmission
>>> =A0 duration of a video frame by sneaking in zero-length requests in
>>> =A0 the middle.
>>
>> Ack. This should already solve a lot of issues.
>>
>> For this I would still suggest to move the usb_ep_queue to be done in
>> the pump worker again. Its a bit back and forth, but IMHO its worth the
>> extra mile since only this way we would respect the dwc3 interrupt
>> threads assumption to run *very* short.
>
>The main reason for queuing the requests from the complete handler
>was to have a single point of usb_ep_queue call, which made reasoning
>through the locking simpler. But if you find a way to do so from
>the video_pump thread without making the locking a nightmare, then go
>for it!
>
>>
>>> 2. Unless there is an unusually high rate of transmission failures
>>> =A0 when using the UVC gadget driver, it might be worth fixing the
>>> =A0 host side driver to handle broken frames better instead (assuming
>>> =A0 host is linux as well).
>>
>> Agreed, but this needs a separate scoped undestanding of the host side
>> behaviour over all layers.
>
>Agreed!
>
>>
>>> 2. Tighten up the error checking in UVC gadget driver -- We drop the
>>> =A0 current frame whenever an EXDEV happens which is wrong. We should
>>> =A0 only be dropping the current frame if the EXDEV corresponds to the
>>> =A0 frame currently being encoded.
>>
>> What do you mean by drop?
>>
>> I would suggest to immediatly switch the uvc_buffer that is being
>> enqueued and start queueing prepared requests from the next buffers prep
>> list. As suggested, the idea is to have per uvc_buffer prep_list
>> requests which would make this task easy.
>
>Currently, if uvc gadget driver receives an EXDEV complete callback
>all it does is set the UVC_QUEUE_DROP_INCOMPLETE flag.
>
>So let's say that we receive an EXDEV for a usb_request containing data
>for video frame N. With how video_pump is currently configured, chances
>are that all usb_requests containing data for video frame N has already
>been queued to the controller.
>
>When the next video frame (N+1) comes in, video_pump's encode methods
>will look at the UVC_QUEUE_DROP_INCOMPLETE flag and incorrectly
>determine that "current" frame needs to be dropped, and stop encoding
>video frame N+1 even though the error was for video frame N. So the
>encode methods incorrectly drop video frame N+1 which isn't needed.
>
>The encode methods should only be dropping the video frame if we
>received an EXDEV for a usb_request for the video frame currently
>being encoded.
>
>I hope that makes sense!

This totally makes sense. I just wanted to make sure that this does not
involve any UVC_STREAM_ERR tagging from your understanding.

I totally agree with this concept. So now we "only" have to implement
this. :)

First I will review and update my patches that will increase the amount
of requests per frame.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--qgDXMBDKtCgkpbIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZnc7IACgkQC+njFXoe
LGSkCRAAurtodO8feJaL34PwQTDiphOmd/dAUVo07xtLhe8qkkinwRU3TiNvvROW
DGUSL/tefdlWu2qarzLsJlUxWdnxKtaiuI7YGVDlYGsoJHxO54SRkN16jwmvp0UE
kNiuJXl9jeb1xzKg+cuL4zD7mz8qonOUOHQgtL6i6GO2viXZaMwf1WXY3TU7Ufmk
Jmn3pt/7h6LG9QM5zeOUeyOJKm7nCizkXorb6S0fZ9erY8qAUpKApU1aavRjvCGh
aCvMP6CINYnQIaoJ+eUOHJYT4fQ/lHROOQTbqgLykXws7huwTz3QYnbRO4lojxdA
bT8iMqmfST8u+eYnSyCsWS8Ln7zE+KdYpgJmS7+joCb9PoMFAdBNp10iFiQkyVwQ
wjDZq6ensw7+D4UyHir3mWl2UmqlxqWGBoENSVzrYGyNq+T/LaxSqo1k05NJatTn
bzfVKMEPSQWwB6ZIk6focK0TdjqXXLv2MHQirvvKH6RTSMQpRWACz79/h4UmPtxE
enmELFbDadJ80L24kqXJMQFl79cqqn6OCQVat5tDHPZHz5jcSGKNYlM2JgEH23Ff
Ip46K23hveXYF+swcFJm0Xp/3lJoLMu0FozZhQugVWL5bXngA/7iSivHnVfjEuJD
Du1ZLIjni2TW4oURDUyuXiYHskn7wnqbU8+ZhTszhPXNDrTqt8k=
=uh1t
-----END PGP SIGNATURE-----

--qgDXMBDKtCgkpbIs--


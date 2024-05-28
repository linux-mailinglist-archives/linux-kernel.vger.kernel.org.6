Return-Path: <linux-kernel+bounces-193197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B68D282F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A58B22353
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46B13E40D;
	Tue, 28 May 2024 22:43:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B913E043
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936236; cv=none; b=VQlhTVRnxbeJDdF1l/b0/09ir8tgqTFxikc3N1LjRar963KYh6/h9N3l646reYQS6D6DDCvN2ZrVH1F4h4xiVwKa66PB+YFakaBBn6yvGTH1msbAQ972JGFciRJVEeWC7cciQoyJ3ZyklIkfFAKqbYiyfHCRrVFQcXfTWnYX3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936236; c=relaxed/simple;
	bh=8M0ZstMbuXmwBRCfry8PQHsTEJtxnfBv1quhdJ855PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARffhUN8/5mOJOKQZb+kGT519O62uqLT7exuARUNc4h/R7xm6n9hH+PuO2UR97fygN7eDhdlWMBs/ek8x9O6rLNt4FZUlYdnTc+6Dl/VaRbIk6xztYpkZgnbh95igyCO4ZOMDGAegxUfsqkjnzCVEtlXVn2Q/xMQ9aA2RHKqVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sC5Xi-0001J4-GN; Wed, 29 May 2024 00:43:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sC5Xg-003Nst-F1; Wed, 29 May 2024 00:43:40 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sC5Xg-001To6-1E;
	Wed, 29 May 2024 00:43:40 +0200
Date: Wed, 29 May 2024 00:43:40 +0200
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
Message-ID: <ZlZeHLmKnw1mApKM@pengutronix.de>
References: <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
 <f4f0b38a-1f8e-4cf5-8cf1-6da337a1c3c0@google.com>
 <ZlY88BebTEZs6urD@pengutronix.de>
 <0642b7a2-0982-4529-b742-3310f34d16b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GobLxoySpi6oEJkN"
Content-Disposition: inline
In-Reply-To: <0642b7a2-0982-4529-b742-3310f34d16b9@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--GobLxoySpi6oEJkN
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 02:27:34PM -0700, Avichal Rakesh wrote:
>
>
>On 5/28/24 13:22, Michael Grzeschik wrote:
>> On Tue, May 28, 2024 at 10:30:30AM -0700, Avichal Rakesh wrote:
>>>
>>>
>>> On 5/22/24 10:37, Michael Grzeschik wrote:
>>>> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
>>>>> On Wed, May 22, 2024, Alan Stern wrote:
>>>>>> On Wed, May 22, 2024 at 01:41:42AM +0000, Thinh Nguyen wrote:
>>>>>> > On Wed, May 22, 2024, Michael Grzeschik wrote:
>>>>>> > > On Fri, May 17, 2024 at 01:44:05AM +0000, Thinh Nguyen wrote:
>>>>>> > > > For isoc endpoint IN, yes. If the host requests for isoc data =
IN while
>>>>>> > > > no TRB is prepared, then the controller will automatically sen=
d 0-length
>>>>>> > > > packet respond.
>>>>>> > >
>>>>>> > > Perfect! This will help a lot and will make active queueing of o=
wn
>>>>>> > > zero-length requests run unnecessary.
>>>>>> >
>>>>>> > Yes, if we rely on the current start/stop isoc transfer scheme for=
 UVC,
>>>>>> > then this will work.
>>>>>>
>>>>>> You shouldn't rely on this behavior.=A0 Other device controllers mig=
ht not
>>>>>> behave this way; they might send no packet at all to the host (causi=
ng a
>>>>>> USB protocol error) instead of sending a zero-length packet.
>>>>>
>>>>> I agree. The dwc3 driver has this workaround to somewhat work with the
>>>>> UVC. This behavior is not something the controller expected, and this
>>>>> workaround should not be a common behavior for different function
>>>>> driver/protocol. Since this behavior was added a long time ago, it wi=
ll
>>>>> remain the default behavior in dwc3 to avoid regression with UVC (at
>>>>> least until the UVC is changed). However, it would be nice for UVC to
>>>>> not rely on this.
>>>>
>>>> With "this" you mean exactly the following commit, right?
>>>>
>>>> (f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the a=
ctive xfer)
>>>>
>>>> When we start questioning this, then lets dig deeper here.
>>>>
>>>> With the fast datarate of at least usb superspeed shouldn't they not a=
ll
>>>> completely work asynchronous with their in flight trbs?
>>>>
>>>> In my understanding this validates that, with at least superspeed we a=
re
>>>> unlikely to react fast enough to maintain a steady isoc dataflow, since
>>>> the driver above has to react to errors in the processing context.
>>>>
>>>> This runs the above patch (f5e46aa4) a gadget independent solution
>>>> which has nothing to do with uvc in particular IMHO.
>>>>
>>>> How do other controllers and their drivers work?
>>>>
>>>>> Side note, when the dwc3 driver reschedules/starts isoc transfer agai=
n,
>>>>> the first transfer will be scheduled go out at some future interval a=
nd
>>>>> not the next immediate microframe. For UVC, it probably won't be a
>>>>> problem since it doesn't seem to need data going out every interval.
>>>>
>>>> It should not make a difference. [TM]
>>>>
>>>
>>>
>>> Sorry for being absent for a lot of this discussion.
>>>
>>> I want to take a step back from the details of how we're
>>> solving the problem to what problems we're trying to solve.
>>>
>>> So, question(s) for Michael, because I don't see an explicit
>>> answer in this thread (and my sincerest apologies if they've
>>> been answered already and I missed it):
>>>
>>> What exactly is the bug (or bugs) we're trying to solve here?
>>>
>>> So far, it looks like there are two main problems being
>>> discussed:
>>>
>>> 1. Reducing the bandwidth usage of individual usb_requests
>>> 2. Error handling for when transmission over the wire fails.
>>>
>>> Is that correct, or are there other issues at play here?
>>
>> That is correct.
>>
>>> (1) in isolation should be relatively easy to solve: Just
>>> smear the encoded frame across some percentage
>>> (prefereably < 100%) of the usb_requests in one
>>> video frame interval.
>>
>> Right.
>>
>>> (2) is more complicated, and your suggestion is to have a
>>> sentinel request between two video frames that tells the
>>> host if the transmission of "current" video frame was
>>> successful or not. (Is that correct?)
>>
>> Right.
>>
>>> Assuming my understanding of (2) is correct, how should
>>> the host behave if the transmission of the sentinel
>>> request fails after the video frame was sent
>>> successfully (isoc is best effort so transmission is
>>> never guaranteed)?
>>
>> If we have transmitted all requests of the frame but would only miss the
>> sentinel request to the host that includes the EOF, the host could
>> rather show it or drop it. The drop would not be necessary since the
>> host did see all data of the frame. The user would not see any
>> distortion in both cases.
>>
>> If we have transmitted only partial data of the frame it would be
>> preferred if the host would drop the frame that did not finish with an
>> proper EOF tag.
>>
>> AFAIK the linux kernel would still show the frame if the FID of the
>> currently handled request would change and would take this as the end of
>> frame indication. But I am not totally sure if this is by spec or
>> optional.
>>
>> One option to be totally sure would be to resend the sentinel request to
>> be properly transmitted before starting the next frame. This resend
>> polling would probably include some extra zero-length requests. But also
>> if this resend keeps failing for n times, the driver should doubt there
>> is anything sane going on with the USB connection and bail out somehow.
>>
>> Since we try to tackle case (1) to avoid transmit errors and also avoid
>> creating late enqueued requests in the running isoc transfer, the over
>> all chance to trigger missed transfers should be minimal.
>
>Gotcha. It seems like the UVC gadget driver implicitly assumes that EOF
>flag will be used although the userspace application can technically
>make it optional.

That is not all. The additional UVC_STREAM_ERR tag on the sentinel
request can be set optional by the host driver. But by spec the
userspace application has to drop the frame when the flag was set.

With my proposal this flag will be set, whenever we find out that
the currently transferred frame was erroneous.

>Summarizing some of the discussions above:
>1. UVC gadget driver should _not_ rely on the usb controller to
>   enqueue 0-length requests on UVC gadget drivers behalf;
>2. However keeping up the backpressure to the controller means the
>   EOF request will be delayed behind all the zero-length requests.

Exactly, this is why we have to somehow finetune the timedelay between
requests that trigger interrupts. And also monitor the amount of
requests currently enqueued in the hw ringbuffer. So that our drivers
enqueue dequeue mechanism is virtually adding only the minimum amount
of necessary zero-length requests in the hardware. This should be
possible.

I am currently thinking through the remaining steps the pump worker has
to do on each wakeup to maintain the minimum threshold while waiting
with submitting requests that contain actual image payload.

>Out of curiosity: What is wrong with letting the host rely on
>FID alone? Decoding the jpeg payload _should_ fail if any of the
>usb_requests containing the payload failed to transmit.

This is not totally true. We saw partially rendered jpeg frames on the
host stream. How the host behaves with broken data is totally undefined
if the typical uvc flags EOF/ERR are not used as specified. Then think
about uncompressed formats. So relying on the transferred image format
to solve our problems is just as wrong as relying on the gadgets
hardware behavior.

>Was there a situation where usb_requests were failing but jpeg
>decoding succeeded  (i.e. the host was unaware of failure)? Looking at
>the error handling on the gadget driver side, I see there is space to
>improve it, but maybe we can do it in a way that doesn't add more time
>constraints!

I think there is no way around time constraints. Since the gadget
hardware is introducing interrupt latency, we have to address with
the sentinel request and some well adjusted amount of zero-length
requests.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--GobLxoySpi6oEJkN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZWXhkACgkQC+njFXoe
LGSHARAAs6F3kXxv1G9i1HR3M1cg3/EEI1IK31K5q9KbpKoYOTAeE/Y1EUcNGMId
YkFhabXAruoAZmWmMC3q1QAvRlIgkYUQDAltgKoNsMmYvtqZbjb4nd2FsN4s0GLR
Yb92u1aydnfv+89WdJQptj0oyra0+Ao01YCcKmcANLwhiLcBkdxM2Bd8SSrzLh36
LnnRUY+n0+NhCRvJP9VHuwg3b1kEeoGjVAq80JdQDKyOiqcYaW0jRFa7z9wzXOY4
4YQdwFV7B4VITY97onIV+5zcrtviW7iViwfTpjl+M3jApM4cBDAGV3qL4XTPGK0A
tI5ZDHvOJa6CwskkFPvPVPX5FeNbPQk4Y/upZW6iNF1vOCvFJ6puUe4OM676STdp
m5L7Va26/bjlUO2y10RehX0HzDIO2TQMPJDz/ynQDG8UU/Lt0D0Qwv6bKcqQeIAH
h4/iHDJwlqD3LDjZ1gPyGcHRR1vD61iZ+nOzY3PSeuRdfEZsO/CuX3uUe/w6FF3v
DX/mbBQMNna1Owg8+aN96V+0GdZC2uQIOh9+B+d6ecYHW1YFrvNBJQ4XwIroOPzO
uxDUgs7U2zka5IkVlMmV3wRnGaKHGALmL85PdMYYrNiP/DwuPtXvbyOVnWupctrS
bEqXD3fYM5FoPVVtcSDNHtlNlzX9oaIAX2J0yLu0WSWHJRpeujI=
=KAxe
-----END PGP SIGNATURE-----

--GobLxoySpi6oEJkN--


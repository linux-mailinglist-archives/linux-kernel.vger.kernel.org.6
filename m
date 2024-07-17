Return-Path: <linux-kernel+bounces-255754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FC9344B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D72B21C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319DF48CDD;
	Wed, 17 Jul 2024 22:19:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60F44C76
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254796; cv=none; b=RKeJ9UuaDg+Axa6nA8ZBPO75l0bG8eBMRWN1Q7My7eowdkHjMyUCpAPVrHjRZCQgNs9/x8EeBNLH8Qa4XZDCOhV+AeqgE7Ij/5+brLlC8lU9D0NdfQ6e16WzL1SwqgX6VTqiZPkednKjEIVDzAI3fnQ6t329sNkjLz3hsDUh2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254796; c=relaxed/simple;
	bh=yOxsQHgwafEikNBdrNkr52FtTFRITb4wFVGgylZvN2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwqBtdTtwP1t5Uf4vhgGzxrW/mYbf1UrWpG8PXAfRJD9oRurpMx+iPFTBHbcfXKHbUGDISu1f2KAbB3iPE7b9iqjqhvMPZ9HbWa4D/chFa7GTf92zg9uzYu7aERfyFFIN2k/vOIaYM0NWQ/DEyzgjjSOM6eh6k88ya+KQQd1txM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sUCzz-00022C-II; Thu, 18 Jul 2024 00:19:47 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sUCzy-000JCs-V8; Thu, 18 Jul 2024 00:19:46 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sUCzy-002FbJ-2l;
	Thu, 18 Jul 2024 00:19:46 +0200
Date: Thu, 18 Jul 2024 00:19:46 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Avichal Rakesh <arakesh@google.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: gadget: uvc: set req_size and n_requests
 based on the frame interval
Message-ID: <ZphDghvKXEV54GuU@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v2-3-12690f7a2eff@pengutronix.de>
 <80f15515-9050-480c-bbeb-f2b8369326eb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zcSkiPONBCu3XBa2"
Content-Disposition: inline
In-Reply-To: <80f15515-9050-480c-bbeb-f2b8369326eb@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zcSkiPONBCu3XBa2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Avichal,

On Wed, Jun 26, 2024 at 11:57:42AM -0700, Avichal Rakesh wrote:
>
>
>On 6/22/24 4:48 PM, Michael Grzeschik wrote:
>> With the information of the interval frame length it is now possible to
>> calculate the number of usb requests by the frame duration. Based on the
>> request size and the imagesize we calculate the actual size per request.
>> This has calculation has the benefit that the frame data is equally
>> distributed over all allocated requests.
>>
>> We keep the current req_size calculation as a fallback, if the interval
>> callbacks did not set the interval property.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> ---
>> v1 -> v2: - add headersize per request into calculation
>> ---
>>  drivers/usb/gadget/function/uvc_queue.c | 30 +++++++++++++++++++++++---=
----
>>  drivers/usb/gadget/function/uvc_video.c |  2 +-
>>  2 files changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadge=
t/function/uvc_queue.c
>> index ce51643fc4639..141e52e34c610 100644
>> --- a/drivers/usb/gadget/function/uvc_queue.c
>> +++ b/drivers/usb/gadget/function/uvc_queue.c
>> @@ -44,7 +44,7 @@ static int uvc_queue_setup(struct vb2_queue *vq,
>>  {
>>  	struct uvc_video_queue *queue =3D vb2_get_drv_priv(vq);
>>  	struct uvc_video *video =3D container_of(queue, struct uvc_video, queu=
e);
>> -	unsigned int req_size;
>> +	unsigned int req_size, max_req_size, header_size;
>>  	unsigned int nreq;
>>
>>  	if (*nbuffers > UVC_MAX_VIDEO_BUFFERS)
>> @@ -54,15 +54,31 @@ static int uvc_queue_setup(struct vb2_queue *vq,
>>
>>  	sizes[0] =3D video->imagesize;
>>
>> -	req_size =3D video->ep->maxpacket
>> +	nreq =3D DIV_ROUND_UP(video->interval, video->ep->desc->bInterval * 12=
50);
>
>This seems problematic? I am not very well versed in the different USB spe=
eds,
>but IIRC fullspeed and highspeed enpoints have different bus intervals, and
>treat bInterval in different units (in frames for fs and in microframes fo=
r hs).
>
>We likely need some speed specific logic when calculating nreq.

Fair point! I did not think about that yet and will fix it in v3.

>Assuming this logic is for >=3D hs, this allocates the exact number of
>usb_requests needed to stream a frame over to the host in one video
>frame interval. With the zero length backpressure still in place, this
>would mean that the actual video frame is sent over a period longer than
>on video frame interval. I will try these patches locally, but if you
>haven't already, please do check if you run into the problem you
>brought up in https://lore.kernel.org/all/ZiWga5Kqno1ICv97@pengutronix.de/.
>My guess is that the problem will show up here as well.

Yes. With this current patchset there is not enough requests to keep
enqueueing requests fast enough since the interrupt handler will have to
wait for ready requests to show up while it uses the finishing requests
to fill zero length requests instead of giving them back to the free
pool. So just having the exact amount of requests for one frame interval
available is way to less.

I fixed that by creating at least four times the amount of available
requests. Just the way you already suggested in an earlier mail :) .

I also added an threshold that will only enqueue zero length requests
if the currently enqueued amount of requests is undercut.

However this is not enough to fulfill the requirements for the dwc3
gadget driver. We also have to ensure that the interrupt handler is not
running too long. To solve this I made additional changes. I sort them
this week and send a next version of it.

I hope you could review and test them soon.

Regards,
Michael

>> +
>> +	header_size =3D nreq * UVCG_REQUEST_HEADER_LEN;
>> +
>> +	req_size =3D DIV_ROUND_UP(video->imagesize + header_size, nreq);
>> +
>> +	max_req_size =3D video->ep->maxpacket
>>  		 * max_t(unsigned int, video->ep->maxburst, 1)
>>  		 * (video->ep->mult);
>>
>> -	/* We divide by two, to increase the chance to run
>> -	 * into fewer requests for smaller framesizes.
>> -	 */
>> -	nreq =3D DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
>> -	nreq =3D clamp(nreq, 4U, 64U);
>> +	if (!req_size) {
>> +		req_size =3D max_req_size;
>> +
>> +		/* We divide by two, to increase the chance to run
>> +		 * into fewer requests for smaller framesizes.
>> +		 */
>> +		nreq =3D DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
>> +		nreq =3D clamp(nreq, 4U, 64U);
>> +	} else if (req_size > max_req_size) {
>> +		/* The prepared interval length and expected buffer size
>> +		 * is not possible to stream with the currently configured
>> +		 * isoc bandwidth
>> +		 */
>> +		return -EINVAL;
>> +	}
>>
>>  	video->req_size =3D req_size;
>>  	video->uvc_num_requests =3D nreq;
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadge=
t/function/uvc_video.c
>> index 95bb64e16f3da..d197c46e93fb4 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -304,7 +304,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video=
 *video,
>>  		 */
>>  		if (list_empty(&video->req_free) || ureq->last_buf ||
>>  			!(video->req_int_count %
>> -			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>> +			clamp(DIV_ROUND_UP(video->uvc_num_requests, 4), 4U, 16U))) {
>>  			video->req_int_count =3D 0;
>>  			req->no_interrupt =3D 0;
>>  		} else {
>>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--zcSkiPONBCu3XBa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmaYQ30ACgkQC+njFXoe
LGQpFQ//YNtIBqRoa235xKP87B1urjzuUQnvs0tzoJoyzisy7wFJDZ2GiPFYJgLx
XsRhSDqMRUu1pcTTcwu25MQNnjYu9h/lWkNOfg7TpoPJN6A2MHYNHXB0xRqODl9D
aJaoZhaeBTdXYpPT/dkgu43hdEXz99BEm9lzoqRtr3yZat1VVkmJ+RyllFuKGQza
6tpuXWpaJ1CIA9hu+//KN2YE5VFLVbbYNyvkfpwmuLQLfm8CquImuxap5AD7A/+T
yNbYaU23sLJGTBD9gL7rjGIlq/cFy/wWY2JW7a6m50Q08JBgcAoKNP8DgMBAoep7
KuERJ4x6teHFgeGc7DjLtc6xJ+d/CaKXrk8FO+GNFHWNY5L4h8jLz/C65ftiJmy+
DVHqd7bRfG5iTJgRkdsl0aEs6I0xurIWfdat0bJgjv+dovqL88vxbdnLmn+HZNM1
JbEk1ct5xIXUokCRofRHdFaoVciKoFmWetzGeixFJVjpVCx2I3JqzUDXWLFs64fX
43tTbOTCn6O+5vaaO2InsU32WKMbE9AOsaJVDS2CuD3LWtd/QvX2yC0Qq0wzxwF/
ZPICsFss5we7coep+XLulSDv6aRP0Q3X2g/InMNvaJwTe97ALOumZUJ2sTbo/hIF
oDmHUuOVDvO+SHvOmHA19VJddAsLKqE+1JErFYy6VV4GE0xFDPc=
=lJ6C
-----END PGP SIGNATURE-----

--zcSkiPONBCu3XBa2--


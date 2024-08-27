Return-Path: <linux-kernel+bounces-304069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895896199E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F094D1F21E21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329351D4171;
	Tue, 27 Aug 2024 21:59:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DA1D365B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795943; cv=none; b=MZ68WGoUMNLb2p8bekaDZS0dqRfz00jDdYztBRGwEnih5KrxpYwwHvrDkr7BfKEHNTLgtkSYsr4+lNzsmaTXqtgl4Aj+O88M6BxgObEQ8aHFoCd7BmJFMVkvDjMCGW82M6zNTr7PQWpUl/AmKQ8kwUGZTNvfejIrZYxgWOkeeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795943; c=relaxed/simple;
	bh=tWkv+tmBTsHMDebuP3GI88RlQKiZY7ghVItyKRcI20E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpwyXt228fx5I0+FKhpIRIJ+M9+4eAGycNCGaJo1797sTeeOCHf14QEFnERSrPHx1eDKTWQtF1/6NQORqVfH9I3OpwO1Xy6CIKy6Q4jAiAChGE1pWW5wu0CkcC2UJucES6lyo4Sxs77cbi2K3eZRk+jfxm+d71F6P1yr1yLSaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sj4DG-0005ju-Iy; Tue, 27 Aug 2024 23:58:54 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sj4DF-003Wbc-SP; Tue, 27 Aug 2024 23:58:53 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sj4DF-0094vM-2V;
	Tue, 27 Aug 2024 23:58:53 +0200
Date: Tue, 27 Aug 2024 23:58:53 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] usb: gadget: uvc: set req_size once when the
 vb2 queue is calculated
Message-ID: <Zs5MHRMe1b3qDuRJ@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v4-6-ca22f334226e@pengutronix.de>
 <20240813094110.GE19716@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4p2Ycn+XDBv1e9O8"
Content-Disposition: inline
In-Reply-To: <20240813094110.GE19716@pendragon.ideasonboard.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--4p2Ycn+XDBv1e9O8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:41:10PM +0300, Laurent Pinchart wrote:
>On Tue, Aug 13, 2024 at 11:09:30AM +0200, Michael Grzeschik wrote:
>> The uvc gadget driver is calculating the req_size on every
>> video_enable/alloc_request and is based on the fixed configfs parameters
>> maxpacket, maxburst and mult.
>>
>> As those parameters can not be changed once the gadget is started and
>> the same calculation is done already early on the
>> vb2_streamon/queue_setup path its save to remove one extra calculation
>> and reuse the calculation from uvc_queue_setup for the allocation step.
>
>Avoiding double calculations is good, but then don't compute the value
>in uvc_queue_setup(). That will also be called multiple times, and its
>timing will be controlled by userspace. Move it to a better location.

I think I was unclear regarding the avoidance of double calculations.

Actually this is the right place to calculate this, since the
resulting req_size will be dependent on the expected imagesize
and the frameduration, we have to calculate it in every queue_setup.

Since this patch is an preperation for the next change, I will leave the
codebase as is but will add the details in the patch description.

Michael

>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> ---
>> v3 -> v4: -
>> v2 -> v3: -
>> v1 -> v2: -
>> ---
>>  drivers/usb/gadget/function/uvc_queue.c |  2 ++
>>  drivers/usb/gadget/function/uvc_video.c | 15 ++-------------
>>  2 files changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadge=
t/function/uvc_queue.c
>> index 7995dd3fef184..2414d78b031f4 100644
>> --- a/drivers/usb/gadget/function/uvc_queue.c
>> +++ b/drivers/usb/gadget/function/uvc_queue.c
>> @@ -63,6 +63,8 @@ static int uvc_queue_setup(struct vb2_queue *vq,
>>  	 */
>>  	nreq =3D DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
>>  	nreq =3D clamp(nreq, 4U, 64U);
>> +
>> +	video->req_size =3D req_size;
>>  	video->uvc_num_requests =3D nreq;
>>
>>  	return 0;
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadge=
t/function/uvc_video.c
>> index 259920ae36843..a6786beef91ad 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -480,7 +480,6 @@ uvc_video_free_requests(struct uvc_video *video)
>>  	INIT_LIST_HEAD(&video->ureqs);
>>  	INIT_LIST_HEAD(&video->req_free);
>>  	INIT_LIST_HEAD(&video->req_ready);
>> -	video->req_size =3D 0;
>>  	return 0;
>>  }
>>
>> @@ -488,16 +487,9 @@ static int
>>  uvc_video_alloc_requests(struct uvc_video *video)
>>  {
>>  	struct uvc_request *ureq;
>> -	unsigned int req_size;
>>  	unsigned int i;
>>  	int ret =3D -ENOMEM;
>>
>> -	BUG_ON(video->req_size);
>> -
>> -	req_size =3D video->ep->maxpacket
>> -		 * max_t(unsigned int, video->ep->maxburst, 1)
>> -		 * (video->ep->mult);
>> -
>>  	for (i =3D 0; i < video->uvc_num_requests; i++) {
>>  		ureq =3D kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
>>  		if (ureq =3D=3D NULL)
>> @@ -507,7 +499,7 @@ uvc_video_alloc_requests(struct uvc_video *video)
>>
>>  		list_add_tail(&ureq->list, &video->ureqs);
>>
>> -		ureq->req_buffer =3D kmalloc(req_size, GFP_KERNEL);
>> +		ureq->req_buffer =3D kmalloc(video->req_size, GFP_KERNEL);
>>  		if (ureq->req_buffer =3D=3D NULL)
>>  			goto error;
>>
>> @@ -525,12 +517,10 @@ uvc_video_alloc_requests(struct uvc_video *video)
>>  		list_add_tail(&ureq->req->list, &video->req_free);
>>  		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
>>  		sg_alloc_table(&ureq->sgt,
>> -			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
>> +			       DIV_ROUND_UP(video->req_size - UVCG_REQUEST_HEADER_LEN,
>>  					    PAGE_SIZE) + 2, GFP_KERNEL);
>>  	}
>>
>> -	video->req_size =3D req_size;
>> -
>>  	return 0;
>>
>>  error:
>> @@ -663,7 +653,6 @@ uvcg_video_disable(struct uvc_video *video)
>>  	INIT_LIST_HEAD(&video->ureqs);
>>  	INIT_LIST_HEAD(&video->req_free);
>>  	INIT_LIST_HEAD(&video->req_ready);
>> -	video->req_size =3D 0;
>>  	spin_unlock_irqrestore(&video->req_lock, flags);
>>
>>  	/*
>
>--=20
>Regards,
>
>Laurent Pinchart
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--4p2Ycn+XDBv1e9O8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmbOTBsACgkQC+njFXoe
LGSw7Q//QsgkF3Fjy683TJZq2W6AU43xuNQm02iVtcjLlJzF5b27wpAjkX2WdBCQ
NGobf03hWTH47b7is/7mHg0QvXITD3LOtmTK6PipHGTM3JO37uWECD+XOHypYfGc
WObcnqA5x/j/enoChfj18IdQ76o2rSO5DZcXCRITQzfE9Vz9aLRqDtyseGxL9sEY
IcSlRCE29EdC3wL7O4DqNLgtxYdFraxqg70pALPu7bEfwpxpF0wACXXS2MxHzyCY
iYyQcSZvXtPpTZ2FxLdTu2sshx8hySoFgxkdV2O/jea2WpEMw3/NwyDZDtQvQgBv
P/Ghr/YwMf9fHO0adrFDHnuAQE+wCrz4eYr/IHA8HxZMcdqGFYFTYCZetNwZh2Kr
D6knFCbQD2OeH6ZKLnKCS1wbzFSGAefE3W8xTGwg/piSDpy4Jc9QgENWTUf/Hiw7
OxkTzp40FhBOXsslzZO23eBRAqEk9KCTzEbtBh9pvtB8BFMBOT8/KQNYe00CY6KN
lH3NZS78Xwo6btrbNWspzaxwXn2+Ab230cR1CV+bykCl/M907UrvkeCXlr2BUax1
vVyVdVyK58AHnwrXDE1pxE7+kE6Mt7rjbX7RtblUQL5L/0ZPCCe03MB2mDTP8o1f
TEMHVAbomYxPH/u3No5HwcXaUow+dCuXNN+WDPCroGPLLBapF2w=
=IlZs
-----END PGP SIGNATURE-----

--4p2Ycn+XDBv1e9O8--


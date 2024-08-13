Return-Path: <linux-kernel+bounces-284561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385CF95027A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECEDB272C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A219149E;
	Tue, 13 Aug 2024 10:27:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1E189918
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544872; cv=none; b=IvTts0EgJnw0Xr/OOOLRRLHWZvWSMzMdPLg5KB5UE/IyHGfh8HPNTu+nIBi2ibCwSnD9z/fZop7oOxyagOIfLh81CyFC0cEWcEIfzun6oLtEhVZQmf8h/iVJiGsFGSeq78WAQ2kybC67SFlhr80bvKzVgP25yUEi82J74QZKNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544872; c=relaxed/simple;
	bh=+4zpDIvmo7m8mge0BRl+spY0/iPXTDu4xWLM49DNuN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crImA0tK8zknES0ZOoleeJdomd0htlmnnyTwn8pWUv1csAKOwbjy5WQhmy7LAv7Dpn9WK6KYUTvtCpImCnonO+jXfy+uOQ6FM0DFZ+gTGxEQeljF1WgKAm4CsrwTBbmGTrwytwuYuFdmHHtV21sa+CRfY3tkZSAVArOKFR18r84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sdokg-0000Lw-Uf; Tue, 13 Aug 2024 12:27:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sdokg-0006WA-Fn; Tue, 13 Aug 2024 12:27:42 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sdokg-000cyt-0v;
	Tue, 13 Aug 2024 12:27:42 +0200
Date: Tue, 13 Aug 2024 12:27:42 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/10] usb: gadget: uvc: add g_parm and s_parm for
 frame interval
Message-ID: <Zrs1HhLLkun6_0jD@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v4-7-ca22f334226e@pengutronix.de>
 <20240813092253.GB19716@pendragon.ideasonboard.com>
 <20240813092820.GC19716@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pCnE4S7EaTs2hXjB"
Content-Disposition: inline
In-Reply-To: <20240813092820.GC19716@pendragon.ideasonboard.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--pCnE4S7EaTs2hXjB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:28:20PM +0300, Laurent Pinchart wrote:
>On Tue, Aug 13, 2024 at 12:22:55PM +0300, Laurent Pinchart wrote:
>> On Tue, Aug 13, 2024 at 11:09:31AM +0200, Michael Grzeschik wrote:
>> > The uvc gadget driver is lacking the information which frame interval
>> > was set by the host. We add this information by implementing the g_parm
>> > and s_parm callbacks.
>>
>> As I've said countless times, this kind of hack is not the right way to
>> pass information that the kernel has no use for between two userspace
>> components. Please stop butchering this driver.
>
>Reading further patches in the series I see that you would like to get
>more precise bandwidth information from userspace. That is fine, but I
>don't think s_parm is the right option. This is not a regular V4L2
>driver, pass it the exat information it needs instead, through a
>dedicated API that will provide all the needed data.

We have an API, where we can handover the framerate. Why invent
something new. All we need to fix is also patch you uvc-gadget
implementation.

What other API do you suggest then? Come up with something super new and
special, only dedicated for UVC then?

Regards,
Michael

>> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> > ---
>> > v3 -> v4: -
>> > v2 -> v3: -
>> > v1 -> v2: -
>> > ---
>> >  drivers/usb/gadget/function/uvc.h      |  1 +
>> >  drivers/usb/gadget/function/uvc_v4l2.c | 52 +++++++++++++++++++++++++=
+++++++++
>> >  2 files changed, 53 insertions(+)
>> >
>> > diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/fu=
nction/uvc.h
>> > index b3a5165ac70ec..f6bc58fb02b84 100644
>> > --- a/drivers/usb/gadget/function/uvc.h
>> > +++ b/drivers/usb/gadget/function/uvc.h
>> > @@ -100,6 +100,7 @@ struct uvc_video {
>> >  	unsigned int width;
>> >  	unsigned int height;
>> >  	unsigned int imagesize;
>> > +	unsigned int interval;
>> >  	struct mutex mutex;	/* protects frame parameters */
>> >
>> >  	unsigned int uvc_num_requests;
>> > diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadg=
et/function/uvc_v4l2.c
>> > index de41519ce9aa0..392fb400aad14 100644
>> > --- a/drivers/usb/gadget/function/uvc_v4l2.c
>> > +++ b/drivers/usb/gadget/function/uvc_v4l2.c
>> > @@ -307,6 +307,56 @@ uvc_v4l2_set_format(struct file *file, void *fh, =
struct v4l2_format *fmt)
>> >  	return ret;
>> >  }
>> >
>> > +static int uvc_v4l2_g_parm(struct file *file, void *fh,
>> > +			    struct v4l2_streamparm *parm)
>> > +{
>> > +	struct video_device *vdev =3D video_devdata(file);
>> > +	struct uvc_device *uvc =3D video_get_drvdata(vdev);
>> > +	struct uvc_video *video =3D &uvc->video;
>> > +	struct v4l2_fract timeperframe;
>> > +
>> > +	if (parm->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> > +		return -EINVAL;
>> > +
>> > +	/* Return the actual frame period. */
>> > +	timeperframe.numerator =3D video->interval;
>> > +	timeperframe.denominator =3D 10000000;
>> > +	v4l2_simplify_fraction(&timeperframe.numerator,
>> > +		&timeperframe.denominator, 8, 333);
>> > +
>> > +	uvcg_dbg(&uvc->func, "Getting frame interval of %u/%u (%u)\n",
>> > +		timeperframe.numerator, timeperframe.denominator,
>> > +		video->interval);
>> > +
>> > +	parm->parm.output.timeperframe =3D timeperframe;
>> > +	parm->parm.output.capability =3D V4L2_CAP_TIMEPERFRAME;
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int uvc_v4l2_s_parm(struct file *file, void *fh,
>> > +			    struct v4l2_streamparm *parm)
>> > +{
>> > +	struct video_device *vdev =3D video_devdata(file);
>> > +	struct uvc_device *uvc =3D video_get_drvdata(vdev);
>> > +	struct uvc_video *video =3D &uvc->video;
>> > +	struct v4l2_fract timeperframe;
>> > +
>> > +	if (parm->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> > +		return -EINVAL;
>> > +
>> > +	timeperframe =3D parm->parm.output.timeperframe;
>> > +
>> > +	video->interval =3D v4l2_fraction_to_interval(timeperframe.numerator,
>> > +		timeperframe.denominator);
>> > +
>> > +	uvcg_dbg(&uvc->func, "Setting frame interval to %u/%u (%u)\n",
>> > +		timeperframe.numerator, timeperframe.denominator,
>> > +		video->interval);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> >  static int
>> >  uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
>> >  		struct v4l2_frmivalenum *fival)
>> > @@ -577,6 +627,8 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops =3D=
 {
>> >  	.vidioc_dqbuf =3D uvc_v4l2_dqbuf,
>> >  	.vidioc_streamon =3D uvc_v4l2_streamon,
>> >  	.vidioc_streamoff =3D uvc_v4l2_streamoff,
>> > +	.vidioc_s_parm =3D uvc_v4l2_s_parm,
>> > +	.vidioc_g_parm =3D uvc_v4l2_g_parm,
>> >  	.vidioc_subscribe_event =3D uvc_v4l2_subscribe_event,
>> >  	.vidioc_unsubscribe_event =3D uvc_v4l2_unsubscribe_event,
>> >  	.vidioc_default =3D uvc_v4l2_ioctl_default,
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

--pCnE4S7EaTs2hXjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAma7NRsACgkQC+njFXoe
LGT4GA//cTsUBnXQ98Sk+yIYqx8HYSf4OH1QQHaAkSsFEp7JzKiAzJ0gI3lVEmaC
/P6NHuTef2ogVwh8GkAHYQm0OlmRDo8Xa3SLtQjcWaOyVWMk7CYNrDCrRA4MVeFn
3ugSD0LLhpTvTwffMlwE7y5twxa6FN0jN3JAlOY3kmWGx4ICvTQnIONWlROvASef
a+FraRgs59nzkRc8wdtUj321rnn2gtVcoPYQlVTF3ID39ylhNLi/7WWO/hEjQoDL
rM7V1qCj5HPq2Ejw1CGta1Wt01iCmsRqgB6x+L86z1vu88L8lYIzS6rBGlk5kbXf
v6PcVay24l4YehiVHXBzrU7PaZ9QAgixIYakJb4H0xNNygxnhyVRVG2T11XRdHTu
oVs5qanzsu0B1akxxmlLx36FYrgtP0It3Eu5jDydo8hrlxg74hEs0hGCiG18lkRe
vzEWyOMoCehlb+6FKby7PiX+sxkFcr+9/ZJFmk3+ehn3aGFEDyuYlYYk9vsWuz0g
ZcH+z1IunYJx0ddXV2pyrRlDyNAOTqu1FBHRy2J0RJyenH0IRU/C3yV2gV6z2erV
A3kJSJtDYAJyTAVBxx8M0XIs+/AKenUUrKKjf45yS1+H4mlaPbLtwYmdYXyuMaYh
U6VJVh9q4hek9ZtW1ehQ1j90XMQRiNbZyP3rY16Y9pKjUmK+v8U=
=VH8x
-----END PGP SIGNATURE-----

--pCnE4S7EaTs2hXjB--


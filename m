Return-Path: <linux-kernel+bounces-284566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D26B95028A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE351C218EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403C1922CC;
	Tue, 13 Aug 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mMkkUi9t"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF6208AD;
	Tue, 13 Aug 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545322; cv=none; b=UhQ2eEspzmbkqDOd9yBZAoyXRr6R54wJ7N8h8ZSOsXlnwO1GpcYcarZC2NsIB6sBUNhnAHYvhbiDe3N8tnhNZYO3KveX43EUFrZ3WH3igfPLRYIJxUEY3iwtXjBsqs5DHnyQIDew1OfAMBA/DeghMk/2tgVWtenxVLYSqF9/xbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545322; c=relaxed/simple;
	bh=5Ddr9zEmzKA62RWgMeC9rfxF6M4XE97FHNy0W3h7od0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li1MJ+KTv3MKEuMFZw5hV1AUKQZcg7QR7SHvC/PJ1BV3APlFbP6+iCV7tT7B0DEPOB/nnl4akgg3GxO2b2Lb0spoFyxx5bokF3P0KwWSP7MVj6ufFLaXcJv4B5sdXb5U0BzFaBrqyz9VpZbDdourdopJPeRgBpVmps/WOXm58sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mMkkUi9t; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC72D220;
	Tue, 13 Aug 2024 12:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723545262;
	bh=5Ddr9zEmzKA62RWgMeC9rfxF6M4XE97FHNy0W3h7od0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMkkUi9t1Swgk17NZZcqDK7RVSQGH7AAuh6eycGZbsJ5cv8pR8i7Ct6Iy+5lSg2ly
	 32tc3aQJjWhU1ucCa6H2xhuUlXs+raU2EBkfDbKMVzhz9dXPTibIGMJFpMxNig0F5P
	 u0amBZazrff7jwhcF2I2Jwg1ZX6hJGB31f2YQFIY=
Date: Tue, 13 Aug 2024 13:34:55 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/10] usb: gadget: uvc: add g_parm and s_parm for
 frame interval
Message-ID: <20240813103455.GC24634@pendragon.ideasonboard.com>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v4-7-ca22f334226e@pengutronix.de>
 <20240813092253.GB19716@pendragon.ideasonboard.com>
 <20240813092820.GC19716@pendragon.ideasonboard.com>
 <Zrs1HhLLkun6_0jD@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zrs1HhLLkun6_0jD@pengutronix.de>

On Tue, Aug 13, 2024 at 12:27:42PM +0200, Michael Grzeschik wrote:
> On Tue, Aug 13, 2024 at 12:28:20PM +0300, Laurent Pinchart wrote:
> >On Tue, Aug 13, 2024 at 12:22:55PM +0300, Laurent Pinchart wrote:
> >> On Tue, Aug 13, 2024 at 11:09:31AM +0200, Michael Grzeschik wrote:
> >> > The uvc gadget driver is lacking the information which frame interval
> >> > was set by the host. We add this information by implementing the g_parm
> >> > and s_parm callbacks.
> >>
> >> As I've said countless times, this kind of hack is not the right way to
> >> pass information that the kernel has no use for between two userspace
> >> components. Please stop butchering this driver.
> >
> > Reading further patches in the series I see that you would like to get
> > more precise bandwidth information from userspace. That is fine, but I
> > don't think s_parm is the right option. This is not a regular V4L2
> > driver, pass it the exat information it needs instead, through a
> > dedicated API that will provide all the needed data.
> 
> We have an API, where we can handover the framerate. Why invent
> something new. All we need to fix is also patch you uvc-gadget
> implementation.
> 
> What other API do you suggest then? Come up with something super new and
> special, only dedicated for UVC then?

Yes, and that's what should have been done instead of adding support for
the V4L2 format-related ioctls.

We can't change the past, but I'm tired and sad to see the driver
evolving in a direction I don't think is right. I however don't have
much time to maintain it these days, and it's obviously not fair to
block progress, even if I believe that good progress would have taken an
entirely different direction.

I will submit a patch to remove myself from MAINTAINERS for this driver.
Come what may.

> >> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >> > ---
> >> > v3 -> v4: -
> >> > v2 -> v3: -
> >> > v1 -> v2: -
> >> > ---
> >> >  drivers/usb/gadget/function/uvc.h      |  1 +
> >> >  drivers/usb/gadget/function/uvc_v4l2.c | 52 ++++++++++++++++++++++++++++++++++
> >> >  2 files changed, 53 insertions(+)
> >> >
> >> > diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> >> > index b3a5165ac70ec..f6bc58fb02b84 100644
> >> > --- a/drivers/usb/gadget/function/uvc.h
> >> > +++ b/drivers/usb/gadget/function/uvc.h
> >> > @@ -100,6 +100,7 @@ struct uvc_video {
> >> >  	unsigned int width;
> >> >  	unsigned int height;
> >> >  	unsigned int imagesize;
> >> > +	unsigned int interval;
> >> >  	struct mutex mutex;	/* protects frame parameters */
> >> >
> >> >  	unsigned int uvc_num_requests;
> >> > diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> >> > index de41519ce9aa0..392fb400aad14 100644
> >> > --- a/drivers/usb/gadget/function/uvc_v4l2.c
> >> > +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> >> > @@ -307,6 +307,56 @@ uvc_v4l2_set_format(struct file *file, void *fh, struct v4l2_format *fmt)
> >> >  	return ret;
> >> >  }
> >> >
> >> > +static int uvc_v4l2_g_parm(struct file *file, void *fh,
> >> > +			    struct v4l2_streamparm *parm)
> >> > +{
> >> > +	struct video_device *vdev = video_devdata(file);
> >> > +	struct uvc_device *uvc = video_get_drvdata(vdev);
> >> > +	struct uvc_video *video = &uvc->video;
> >> > +	struct v4l2_fract timeperframe;
> >> > +
> >> > +	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> >> > +		return -EINVAL;
> >> > +
> >> > +	/* Return the actual frame period. */
> >> > +	timeperframe.numerator = video->interval;
> >> > +	timeperframe.denominator = 10000000;
> >> > +	v4l2_simplify_fraction(&timeperframe.numerator,
> >> > +		&timeperframe.denominator, 8, 333);
> >> > +
> >> > +	uvcg_dbg(&uvc->func, "Getting frame interval of %u/%u (%u)\n",
> >> > +		timeperframe.numerator, timeperframe.denominator,
> >> > +		video->interval);
> >> > +
> >> > +	parm->parm.output.timeperframe = timeperframe;
> >> > +	parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
> >> > +
> >> > +	return 0;
> >> > +}
> >> > +
> >> > +static int uvc_v4l2_s_parm(struct file *file, void *fh,
> >> > +			    struct v4l2_streamparm *parm)
> >> > +{
> >> > +	struct video_device *vdev = video_devdata(file);
> >> > +	struct uvc_device *uvc = video_get_drvdata(vdev);
> >> > +	struct uvc_video *video = &uvc->video;
> >> > +	struct v4l2_fract timeperframe;
> >> > +
> >> > +	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> >> > +		return -EINVAL;
> >> > +
> >> > +	timeperframe = parm->parm.output.timeperframe;
> >> > +
> >> > +	video->interval = v4l2_fraction_to_interval(timeperframe.numerator,
> >> > +		timeperframe.denominator);
> >> > +
> >> > +	uvcg_dbg(&uvc->func, "Setting frame interval to %u/%u (%u)\n",
> >> > +		timeperframe.numerator, timeperframe.denominator,
> >> > +		video->interval);
> >> > +
> >> > +	return 0;
> >> > +}
> >> > +
> >> >  static int
> >> >  uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
> >> >  		struct v4l2_frmivalenum *fival)
> >> > @@ -577,6 +627,8 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops = {
> >> >  	.vidioc_dqbuf = uvc_v4l2_dqbuf,
> >> >  	.vidioc_streamon = uvc_v4l2_streamon,
> >> >  	.vidioc_streamoff = uvc_v4l2_streamoff,
> >> > +	.vidioc_s_parm = uvc_v4l2_s_parm,
> >> > +	.vidioc_g_parm = uvc_v4l2_g_parm,
> >> >  	.vidioc_subscribe_event = uvc_v4l2_subscribe_event,
> >> >  	.vidioc_unsubscribe_event = uvc_v4l2_unsubscribe_event,
> >> >  	.vidioc_default = uvc_v4l2_ioctl_default,

-- 
Regards,

Laurent Pinchart


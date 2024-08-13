Return-Path: <linux-kernel+bounces-284476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A683950165
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388A3B22655
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31508BF3;
	Tue, 13 Aug 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JqVRHKIM"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091D17C235;
	Tue, 13 Aug 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542097; cv=none; b=KV25aeWQVenSDni+H6RB0BwZSVMg6HnxICgR5CSPqalSkgj7dS0yr+qK81o2KqGWDegngjM/BFz7noowWviDKfJ0dTzK6uox+GMGOYxBsivSA+jT+P0kbtBFbCOZ3f/2/XkWt/rgPYT0F5buaBJ9xaviTA6P90VtZUo4YqcUZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542097; c=relaxed/simple;
	bh=RMcpIOQ0ymYnoKkcNFMupgiGlXhWnCIh0k47zr/oHzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpwMQNdS1D7l4gcUui56+1NVl3o5R7wGTeCLd5rIwieHToqu2Ex+TCr+V+nUz/YBuWrD+5uyp2lq6juT2gFHHaVERgDiHZ5v1NGSeRHujbSkcv5/pLJ7hhGUgGuR5HsaKaZ1G+Vn1gj+TSluEoO8kM6Sdzaz2KmurRSUse/txkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JqVRHKIM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35FBEE4;
	Tue, 13 Aug 2024 11:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723542037;
	bh=RMcpIOQ0ymYnoKkcNFMupgiGlXhWnCIh0k47zr/oHzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqVRHKIMdfEBO8t1x/twlV46Ap/qBgRaZWeEMhY6FcL0i21E2vdNvMxLlKxu7L86E
	 HimxcLH9/au4q9Nkw/2mKJyesw0zdLA22juy4mH3tasaxI9QsSNEJaJ/TtdrS0AdV9
	 2Z2S7wPYUuF49BQ9yKHc9WSDoGNT82zcSd2w+j5U=
Date: Tue, 13 Aug 2024 12:41:10 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] usb: gadget: uvc: set req_size once when the
 vb2 queue is calculated
Message-ID: <20240813094110.GE19716@pendragon.ideasonboard.com>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v4-6-ca22f334226e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-6-ca22f334226e@pengutronix.de>

On Tue, Aug 13, 2024 at 11:09:30AM +0200, Michael Grzeschik wrote:
> The uvc gadget driver is calculating the req_size on every
> video_enable/alloc_request and is based on the fixed configfs parameters
> maxpacket, maxburst and mult.
> 
> As those parameters can not be changed once the gadget is started and
> the same calculation is done already early on the
> vb2_streamon/queue_setup path its save to remove one extra calculation
> and reuse the calculation from uvc_queue_setup for the allocation step.

Avoiding double calculations is good, but then don't compute the value
in uvc_queue_setup(). That will also be called multiple times, and its
timing will be controlled by userspace. Move it to a better location.

> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> ---
> v3 -> v4: -
> v2 -> v3: -
> v1 -> v2: -
> ---
>  drivers/usb/gadget/function/uvc_queue.c |  2 ++
>  drivers/usb/gadget/function/uvc_video.c | 15 ++-------------
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
> index 7995dd3fef184..2414d78b031f4 100644
> --- a/drivers/usb/gadget/function/uvc_queue.c
> +++ b/drivers/usb/gadget/function/uvc_queue.c
> @@ -63,6 +63,8 @@ static int uvc_queue_setup(struct vb2_queue *vq,
>  	 */
>  	nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
>  	nreq = clamp(nreq, 4U, 64U);
> +
> +	video->req_size = req_size;
>  	video->uvc_num_requests = nreq;
>  
>  	return 0;
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 259920ae36843..a6786beef91ad 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -480,7 +480,6 @@ uvc_video_free_requests(struct uvc_video *video)
>  	INIT_LIST_HEAD(&video->ureqs);
>  	INIT_LIST_HEAD(&video->req_free);
>  	INIT_LIST_HEAD(&video->req_ready);
> -	video->req_size = 0;
>  	return 0;
>  }
>  
> @@ -488,16 +487,9 @@ static int
>  uvc_video_alloc_requests(struct uvc_video *video)
>  {
>  	struct uvc_request *ureq;
> -	unsigned int req_size;
>  	unsigned int i;
>  	int ret = -ENOMEM;
>  
> -	BUG_ON(video->req_size);
> -
> -	req_size = video->ep->maxpacket
> -		 * max_t(unsigned int, video->ep->maxburst, 1)
> -		 * (video->ep->mult);
> -
>  	for (i = 0; i < video->uvc_num_requests; i++) {
>  		ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
>  		if (ureq == NULL)
> @@ -507,7 +499,7 @@ uvc_video_alloc_requests(struct uvc_video *video)
>  
>  		list_add_tail(&ureq->list, &video->ureqs);
>  
> -		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
> +		ureq->req_buffer = kmalloc(video->req_size, GFP_KERNEL);
>  		if (ureq->req_buffer == NULL)
>  			goto error;
>  
> @@ -525,12 +517,10 @@ uvc_video_alloc_requests(struct uvc_video *video)
>  		list_add_tail(&ureq->req->list, &video->req_free);
>  		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
>  		sg_alloc_table(&ureq->sgt,
> -			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
> +			       DIV_ROUND_UP(video->req_size - UVCG_REQUEST_HEADER_LEN,
>  					    PAGE_SIZE) + 2, GFP_KERNEL);
>  	}
>  
> -	video->req_size = req_size;
> -
>  	return 0;
>  
>  error:
> @@ -663,7 +653,6 @@ uvcg_video_disable(struct uvc_video *video)
>  	INIT_LIST_HEAD(&video->ureqs);
>  	INIT_LIST_HEAD(&video->req_free);
>  	INIT_LIST_HEAD(&video->req_ready);
> -	video->req_size = 0;
>  	spin_unlock_irqrestore(&video->req_lock, flags);
>  
>  	/*

-- 
Regards,

Laurent Pinchart


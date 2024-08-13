Return-Path: <linux-kernel+bounces-284470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F83950151
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBAD28404E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1C17E919;
	Tue, 13 Aug 2024 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vVQoBBM+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD317BB35;
	Tue, 13 Aug 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541752; cv=none; b=uID5+th/DH69hiKcBeYesDWMZTP/EJZLggJjuDivheTtosr1jhHpnBhlD176pBJ0qw356zlAR8lsIKTAv4DXY6CbMleuJWi1rsjcdTkHFwS92kROWvOtXeDq7LUIxL3xPHwRVCl4d+/p5xHDrd0F6JBaoU6rOJ2KQH1UX6WfJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541752; c=relaxed/simple;
	bh=2fPJ4mZTRiTW1FkV/uqfRrVx7sxOLLvs4wZF1NDYsOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNhsbPTsmG6PEpndhvrAOu4dRI8avfWaAHrLCyPk2/KWvXGruSuknXNL2ayfNt7kHdgdu603ktnU1e50ppubWLYkwi44G2931N78KU4LOixv+caYBAXr5lQpu9j31cTVsPEy2dYruoB/goYx6kokes9bZz5rNsE5RweeNP33D84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vVQoBBM+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 586B6E4;
	Tue, 13 Aug 2024 11:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723541692;
	bh=2fPJ4mZTRiTW1FkV/uqfRrVx7sxOLLvs4wZF1NDYsOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vVQoBBM+/txQtFLwSSf/Y02nVpZ2aAyHeSxA0Dx+Akeguhb9OsmAGUbZHGCzIVr7h
	 3ZCq/sIZNvbrvWvYYyf3XdNCM+k0Qkvx2MHTyzFEehKtIebCQywE1Ch/7eQ/7afG9x
	 oiBKIDqAY99R3CIaEYQgEsV8id2/5bqeAkhAXP8w=
Date: Tue, 13 Aug 2024 12:35:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] usb: gadget: uvc: add min g_ctrl vidioc and set
 min buffs to 4
Message-ID: <20240813093525.GD19716@pendragon.ideasonboard.com>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v4-10-ca22f334226e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-10-ca22f334226e@pengutronix.de>

On Tue, Aug 13, 2024 at 11:09:34AM +0200, Michael Grzeschik wrote:
> We increase the minimum amount of v4l2 buffers that will be possibly
> enqueued into the hardware and allocate at least
> UVCG_STREAMING_MIN_BUFFERS amount of requests. This way the driver has
> also more requests available to prefill the isoc hardware with.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> ---
> v3 -> v4: -
> v1 -> v3: new patch
> ---
>  drivers/usb/gadget/function/uvc.h       |  2 ++
>  drivers/usb/gadget/function/uvc_queue.c |  3 ++-
>  drivers/usb/gadget/function/uvc_v4l2.c  | 13 +++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index f6bc58fb02b84..e0b1f78fdbc65 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -71,6 +71,8 @@ extern unsigned int uvc_gadget_trace_param;
>  
>  #define UVCG_REQUEST_HEADER_LEN			12
>  
> +#define UVCG_STREAMING_MIN_BUFFERS		4
> +

4 is a large number that drastically increases latency.

>  /* ------------------------------------------------------------------------
>   * Structures
>   */
> diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
> index e33ce72325031..157e7f7d49c7a 100644
> --- a/drivers/usb/gadget/function/uvc_queue.c
> +++ b/drivers/usb/gadget/function/uvc_queue.c
> @@ -21,6 +21,7 @@
>  #include <media/videobuf2-vmalloc.h>
>  
>  #include "uvc.h"
> +#include "uvc_video.h"
>  
>  /* ------------------------------------------------------------------------
>   * Video buffers queue management.
> @@ -86,7 +87,7 @@ static int uvc_queue_setup(struct vb2_queue *vq,
>  	}
>  
>  	video->req_size = req_size;
> -	video->uvc_num_requests = nreq;
> +	video->uvc_num_requests = nreq * UVCG_STREAMING_MIN_BUFFERS;
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index 392fb400aad14..f96074f2c2824 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -357,6 +357,18 @@ static int uvc_v4l2_s_parm(struct file *file, void *fh,
>  	return 0;
>  }
>  
> +static int uvc_g_ctrl(struct file *file, void *priv, struct v4l2_control *vc)
> +{
> +	int ret = -EINVAL;
> +
> +	if (vc->id == V4L2_CID_MIN_BUFFERS_FOR_OUTPUT) {
> +		vc->value = UVCG_STREAMING_MIN_BUFFERS;
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int
>  uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
>  		struct v4l2_frmivalenum *fival)
> @@ -629,6 +641,7 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops = {
>  	.vidioc_streamoff = uvc_v4l2_streamoff,
>  	.vidioc_s_parm = uvc_v4l2_s_parm,
>  	.vidioc_g_parm = uvc_v4l2_g_parm,
> +	.vidioc_g_ctrl = uvc_g_ctrl,
>  	.vidioc_subscribe_event = uvc_v4l2_subscribe_event,
>  	.vidioc_unsubscribe_event = uvc_v4l2_unsubscribe_event,
>  	.vidioc_default = uvc_v4l2_ioctl_default,

-- 
Regards,

Laurent Pinchart


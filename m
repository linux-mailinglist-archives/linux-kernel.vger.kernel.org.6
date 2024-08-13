Return-Path: <linux-kernel+bounces-284452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E59950117
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910C71F224AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA517B43F;
	Tue, 13 Aug 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kfyH5I+y"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F5339A1;
	Tue, 13 Aug 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540661; cv=none; b=t7RhHEYlAMJnWtYtYA+vFgtntrnqxNxkwAOxjlD/FWJMkThzp688Cd+L6/1HC3D0SMaLNlHbvNdZvLotg9O9ebOwiDo7jF6yt2zWIcqh3tmJbpp/GUARm1eDfgZNMxEPQTUKiulUUGnrY8EMq0jGmhXG1wgYTAfRZOFZCqAs4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540661; c=relaxed/simple;
	bh=PhEhqK/WoPT5oxW0wo4BhgDQ5PM+ThHLGT3xQ1Fq6c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaoVZzGW69ikvx2F48/07FC1ZbPXopjMwWfLFShOGO57Miq+2df8qJGr2vBpOyiJPF1m4VkWEbai2SjvErjiWQxvzPi/8Ubhli3gK2OlJr2SyvwzB3uvW4n6XVDzYMCrB9D+WS+UkqrFiKIw0HGAJBrMeMN9Zj5BIxL5u56YEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kfyH5I+y; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 30F0FA1A;
	Tue, 13 Aug 2024 11:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723540601;
	bh=PhEhqK/WoPT5oxW0wo4BhgDQ5PM+ThHLGT3xQ1Fq6c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfyH5I+yi1G3wAU7xUOEFibMiP5CjuZaTpY0z4fECjZqolmTq+QBSpw29TYf5+wa8
	 9L1tRArJ988dILlzjsTksDej+GZMwNaDExAIOvuIhv2jQzI8UThv4sYc8Mg6WOVMqE
	 dOhDAF6aowQpsvK8RLGSHRBA6X8M1sh7KKSfSdz4=
Date: Tue, 13 Aug 2024 12:17:14 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] usb: gadget: uvc: always set interrupt on zero
 length requests
Message-ID: <20240813091714.GA19716@pendragon.ideasonboard.com>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v4-1-ca22f334226e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-1-ca22f334226e@pengutronix.de>

Hi Michael,

Thank you for the patch.

On Tue, Aug 13, 2024 at 11:09:25AM +0200, Michael Grzeschik wrote:
> Since the uvc gadget is depending on the completion handler to
> properly enqueue new data, we have to ensure that the requeue mechanism
> is always working. To be safe we always create an interrupt
> on zero length requests.

What do you mean "to be safe" ? Either there's an issue, and then the
commit message should describe it, or there's no issue, and this isn't
needed.

> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> ---
> v3 -> v4: -
> v1 -> v3: new patch
> ---
>  drivers/usb/gadget/function/uvc_video.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index d41f5f31dadd5..03bff39cd4902 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -303,6 +303,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
>  		 *   between latency and interrupt load.
>  		 */
>  		if (list_empty(&video->req_free) || ureq->last_buf ||
> +				!req->length ||
>  			!(video->req_int_count %
>  			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>  			video->req_int_count = 0;

-- 
Regards,

Laurent Pinchart


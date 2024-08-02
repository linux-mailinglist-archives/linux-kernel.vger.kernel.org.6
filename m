Return-Path: <linux-kernel+bounces-272966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD49462E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E167282C8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E4415C12C;
	Fri,  2 Aug 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="r4Nfx163"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA11AE02D;
	Fri,  2 Aug 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622754; cv=none; b=P8IATEQpUYl7hh0Cct2Cptw4cwNMMtfF0eCpcpfu/J6Y1warTzaQqBfowBlR8eZ7CSN/pcggr3ZCdmmKBqiqFTmGPD39Ic2eYKqp2mMnnDRqHne9328HDQQr9i2akcoQKjkMhSaX3LshYgHlmaIi3Q6UH25oHCr9jDU6JOTtV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622754; c=relaxed/simple;
	bh=zON6RjPTf5MmxXUFZfGeVjEEpkp2eWNiZ+51r8kW1qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUGjXmV4UHhuWllc1CC3v3DtpgpUzZdqFKyyB4nRDGy/kBxrfZjnW91/u7JC5J+k+RLb5eX/YLx8pekL0DOqjkXfna7mj70g6TiHOnfobdGpxjqFWHdc5gqjE5c1GdjKOMs+L62MKMqVhhJkqLJlW2fjdEUoMcD2gGL1y74tLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=r4Nfx163; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9142496;
	Fri,  2 Aug 2024 20:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722622694;
	bh=zON6RjPTf5MmxXUFZfGeVjEEpkp2eWNiZ+51r8kW1qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4Nfx163YkaYMr/xLWiOvqsD+iE0uj/YrfS2NTL5ebnKMOkghmTQst3xVmpGhbPqK
	 roZHoSE1wdrpl8WdxdGCM4DOU04S2AKyUcWmADG52fPDHNkSEhcdXaPYCpGNMiEHRz
	 briRU5UGeuKkwFyIkzvnzZGXY+3LxY8ihUYQEEB4=
Date: Fri, 2 Aug 2024 21:18:41 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org, dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Message-ID: <20240802181841.GA21917@pendragon.ideasonboard.com>
References: <20240802180247.519273-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802180247.519273-1-abhishektamboli9@gmail.com>

Hi Abhishek,

(CC'ing Michael Grzeschik)

Thank you for the patch.

On Fri, Aug 02, 2024 at 11:32:47PM +0530, Abhishek Tamboli wrote:
> Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> and uvc_v4l2_enum_format().
> 
> Fix the following smatch errors:
> 
> drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  drivers/usb/gadget/function/uvc_v4l2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index a024aecb76dc..9dd602a742c4 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -121,6 +121,9 @@ static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
>  	list_for_each_entry(format, &uvc->header->formats, entry) {
>  		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);
> 
> +		if (IS_ERR(fmtdesc))
> +			continue;
> +
>  		if (fmtdesc->fcc == pixelformat) {
>  			uformat = format->fmt;
>  			break;
> @@ -389,6 +392,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  		return -EINVAL;
> 
>  	fmtdesc = to_uvc_format(uformat);
> +	if (IS_ERR(fmtdesc))
> +		return -EINVAL;
> +
>  	f->pixelformat = fmtdesc->fcc;
> 
>  	return 0;

Michael, you authored this, I'll let you review the patch and decide if
this is a false positive.

-- 
Regards,

Laurent Pinchart


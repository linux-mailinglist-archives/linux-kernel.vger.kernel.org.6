Return-Path: <linux-kernel+bounces-287640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C0952A45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2F51C20F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C1A199398;
	Thu, 15 Aug 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3B6z3IO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C901EB31;
	Thu, 15 Aug 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708789; cv=none; b=pR8FLvITRI8mqcTpE/AmL1HzMf+QEnnszkGCfizpjEPB/2rqbOEP0eZ8bYCLltwwMhHL0IXf9xgAYzeYKHZJ2hCAA9PhWQ5pVnKGBl7/5HgJ7unnOxjnuhUOcHE01/DqypwjjSMERcA68o06FV8qgCONPJUHRssQKP8LTLxMfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708789; c=relaxed/simple;
	bh=Zod0gbsi9YzsV+5+kT02BUtMJKBboJ3kJnWsCc2wn3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuiNrlOtegGZgCanGz0r95uCfz8fJdwzOF23sKHEsfoyyS0VRBsOblLAKOD31+QsBbjGVaX5h0PkD4VI9BSosV9TLvfmEnPCDIsF6rGULBTFYZCMhyugFDlZc/RCa4DxRz3h396/Y5Q/TwxdWQGDUKY6C3gjc6CHZh8Qs724rU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s3B6z3IO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A6C32786;
	Thu, 15 Aug 2024 07:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723708789;
	bh=Zod0gbsi9YzsV+5+kT02BUtMJKBboJ3kJnWsCc2wn3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3B6z3IOyBjkUzRYQ6V2qwyhaKEBSs1nUDqThOEasMyXrkFHKxE2hArjmUBhSzMpc
	 O2/tF6VjbgkU9lIXCbx2Brtq1Wwx3xJBzNE4jk48nHYEOYbg5g7cBZamndgALMgMjn
	 qKdujhaOfOsU0jIVtE0zC+uyfNu0bbs7o/RJof+0=
Date: Thu, 15 Aug 2024 09:59:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in
 uvc_v4l2.c
Message-ID: <2024081536-unfrozen-childless-9139@gregkh>
References: <20240815071416.585559-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815071416.585559-1-abhishektamboli9@gmail.com>

On Thu, Aug 15, 2024 at 12:44:16PM +0530, Abhishek Tamboli wrote:
> Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> and uvc_v4l2_enum_format().
> 
> Fix the following smatch errors:
> 
> drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> 
> drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> 
> Also, fix similar issue in uvc_v4l2_try_format() for potential
> dereferencing of ERR_PTR().
> 
> Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
> Fixes: e219a712bc06 ("usb: gadget: uvc: add v4l2 try_format api call")
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
> Changes in v2:
> - Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format()
> 
>  drivers/usb/gadget/function/uvc_v4l2.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index a024aecb76dc..8bb88c864b60 100644
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
> @@ -240,6 +243,7 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
>  	struct uvc_video *video = &uvc->video;
>  	struct uvcg_format *uformat;
>  	struct uvcg_frame *uframe;
> +	const struct uvc_format_desc *fmtdesc;
>  	u8 *fcc;
> 
>  	if (fmt->type != video->queue.queue.type)
> @@ -277,7 +281,10 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
>  		fmt->fmt.pix.height = uframe->frame.w_height;
>  		fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
>  		fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
> -		fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
> +		fmtdesc = to_uvc_format(uformat);
> +		if (IS_ERR(fmtdesc))
> +			return -EINVAL;
> +		fmt->fmt.pix.pixelformat = fmtdesc->fcc;
>  	}
>  	fmt->fmt.pix.field = V4L2_FIELD_NONE;
>  	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
> @@ -389,6 +396,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  		return -EINVAL;
> 
>  	fmtdesc = to_uvc_format(uformat);
> +	if (IS_ERR(fmtdesc))
> +		return -EINVAL;
> +
>  	f->pixelformat = fmtdesc->fcc;
> 
>  	return 0;
> --
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


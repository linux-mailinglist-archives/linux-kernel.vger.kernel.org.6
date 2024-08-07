Return-Path: <linux-kernel+bounces-277751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F3794A5D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3855C2814CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276831DD3BF;
	Wed,  7 Aug 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="seCxJTGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3B1D6DD9;
	Wed,  7 Aug 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027213; cv=none; b=Eo9mwUevNIn2466HohBfPAxQO0vfoT4yNq2cUox/GaddY56IEDJlW2CX1hUXgl8HKwvi/NbT0wa+mODPND12uCmFkK8DAMT/K8VrYMHOoKPuGHSw3XstWiDeT9mQx74lb3gnBD5RrrMn3Y7nL6yJZ+aNFsPUR5D0I5QkaR3HzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027213; c=relaxed/simple;
	bh=PTLeRXFWgE3Eo577ykjeu8qqsQfwG6wdG3Ko3EDsRVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht0l2admzUgoeYVesrbcyxwB6TZ+70ZSsvhbRgENIPn5SPObTZTlCF00sGjiCAyn3GCuN1pseipA0m1VPfGViAAZ9SZb6eqkQQoV+YUZM61zcI8OCLWwScD+PoYyuHjtqs75BKbveNMHzIER8eF6QdlqqlRPcksZLgBd5SqtciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=seCxJTGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609EAC32782;
	Wed,  7 Aug 2024 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723027212;
	bh=PTLeRXFWgE3Eo577ykjeu8qqsQfwG6wdG3Ko3EDsRVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seCxJTGHkogOpySAbMM5Q5AK3qKZXNjoEDkf6YStY2dQwFTRdoGl5oOZTP9mOSzFt
	 bYNwq2EEQ/EZM9Wjsa60zcnP3zRlIL5SsCBkcjr+WlRFL5MRPeEPnPx2rMdBQe6YXM
	 2z1YKY3c4CR9CE3dRextAt/exL//JWMm4CBe8hos=
Date: Wed, 7 Aug 2024 12:40:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: hgajjar@de.adit-jv.com, willmcvicker@google.com, paul@crapouillou.net,
	brauner@kernel.org, christian.koenig@amd.com, jlayton@kernel.org,
	kees@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org
Subject: Re: [PATCH 1/2] usb: gadget: f_fs: restore ffs_func_disable()
 functionality
Message-ID: <2024080701-driveway-majorette-d1d5@gregkh>
References: <20240802140428.2000312-1-tudor.ambarus@linaro.org>
 <20240802140428.2000312-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802140428.2000312-2-tudor.ambarus@linaro.org>

On Fri, Aug 02, 2024 at 02:04:27PM +0000, Tudor Ambarus wrote:
> The blamed commit made ffs_func_disable() always return -EINVAL as the
> method calls ffs_func_set_alt() with the ``alt`` argument being
> ``(unsigned)-1``, which is always greater than MAX_ALT_SETTINGS.
> Use the MAX_ALT_SETTINGS check just in the f->set_alt() code path,
> f->disable() doesn't care about the ``alt`` parameter.
> 
> Make a surgical fix, but really the f->disable() code shall be pulled
> out from ffs_func_set_alt(), the code will become clearer. A patch will
> follow.
> 
> Note that ffs_func_disable() always returning -EINVAL made pixel6 crash
> on USB disconnect.
> 
> Fixes: 2f550553e23c ("usb: gadget: f_fs: Add the missing get_alt callback")
> Reported-by: William McVicker <willmcvicker@google.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/usb/gadget/function/f_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index d8b096859337..0bfed1741b3e 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -3731,10 +3731,10 @@ static int ffs_func_set_alt(struct usb_function *f,
>  	struct ffs_data *ffs = func->ffs;
>  	int ret = 0, intf;
>  
> -	if (alt > MAX_ALT_SETTINGS)
> -		return -EINVAL;
> -
>  	if (alt != (unsigned)-1) {
> +		if (alt > MAX_ALT_SETTINGS)
> +			return -EINVAL;
> +
>  		intf = ffs_func_revmap_intf(func, interface);
>  		if (intf < 0)
>  			return intf;
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
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


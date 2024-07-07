Return-Path: <linux-kernel+bounces-243602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC592984E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478041C21187
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703A23741;
	Sun,  7 Jul 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gxwI7lpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD6210EC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720361288; cv=none; b=XDs3uVXCx8qJr8Se3oHtCaqnjFyl0f8Sb0Bb9NnGoPdT4u2+JHB2CIZ1SXIEWMsq6D+bUV7shHl19yv4ob0pNXq/6L38+rcj9xlYFEMbIVLUGjXMlMIuyh6bkYjqMj/EA7WvsDm6qI+wX3gK1nJthjiS/UDKYAOevubajeIDgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720361288; c=relaxed/simple;
	bh=UBBejCskMwiweLFvq4TWVEauBudtJYIo09WM/lahxNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0muoGF7LVy0PqaWaXtzOYMmwpsC4x5pDt5xYSi/CZ0oUsPo6uTbKhNKKdistl/QVXok0kx2VsDhCorOBKnX09tgJOVE7Zrox7HAHEtaa5Si4ZHF6LEDBJoJ+9OiOB45Mbaoge786aSHLedKj7Aku+eZ3LIWccJMGC4qrYgLMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gxwI7lpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A00C3277B;
	Sun,  7 Jul 2024 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720361287;
	bh=UBBejCskMwiweLFvq4TWVEauBudtJYIo09WM/lahxNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxwI7lpehNI3/Dlj+4wbd4YUxtR9CGmYb+feA5labmrxfA5A4iQgAXxTY4oM6gvdX
	 6JJlpjDK3w3BFRjPB35N0T/0u+Y4oxUtIcBLnTlVWy7EEYZ58Kf+hWA4mEpv7Xbsgk
	 y1jNGUcQk7Zk3vMVkC2Rdsch46LPcdZOHqmX+f/4=
Date: Sun, 7 Jul 2024 16:08:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver:core: no need to invert the return value of
 the call_driver_probe()
Message-ID: <2024070750-given-unkempt-c896@gregkh>
References: <20240707112738.3380-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707112738.3380-1-sensor1010@163.com>

On Sun, Jul 07, 2024 at 04:27:38AM -0700, Lizhe wrote:
> If drv->probe() or drv->bus->probe() returns EPROBE_DEFER,
> then there is no need to invert the sign. Similarly,
> if it returns -EPROBE_DEFER, no sign inversion is needed either
> 
> In the probe function (either bus->probe() or drv->probe()),
> there is no return value of EPROBE_DEFER.
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/base/dd.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 83d352394fdf..cbf7fe6aa8e0 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -664,11 +664,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		if (link_ret == -EAGAIN)
>  			ret = -EPROBE_DEFER;
>  
> -		/*
> -		 * Return probe errors as positive values so that the callers
> -		 * can distinguish them from other errors.
> -		 */
> -		ret = -ret;
>  		goto probe_failed;
>  	}
>  
> -- 
> 2.17.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


Return-Path: <linux-kernel+bounces-268786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79644942944
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3635D283EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B51A8BEF;
	Wed, 31 Jul 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cBiaV14n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C41A7F86;
	Wed, 31 Jul 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414858; cv=none; b=tP0mvJQ4Wm38yStuLDh45Qgqo2sBexq0e7I3f+XHssZuyxay/f+DxlCbOvXXcB0cjc5bmyT+ik83HaYA/bDQEkONCrlp3r7ZdwWQDEREmv/Q6YAVp8sOnpATPcpUYjAbbYhj6u0d+YpVu1jzXVQwdzaAz6875KNxQVViyxc1xJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414858; c=relaxed/simple;
	bh=8+E4Mx6nsvQdhnv7jB7tqDc4lCt4yb/9UOa+s297XNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPjoGzq3Ej9PUlhdNn2KdhktLOCEs4qh5AAjC03940umsh/vBDP/Cy1pdQR0Bp/xJF2nJNvCSvODs1tYvEFwImFndVJeXMVR7GpDu14bxfbSLQyRPF63voM1p4wJmwXh40UYE/aeOIekxCoPAOqsIXMLcOSg23583WNBQCCmcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cBiaV14n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74327C4AF09;
	Wed, 31 Jul 2024 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722414857;
	bh=8+E4Mx6nsvQdhnv7jB7tqDc4lCt4yb/9UOa+s297XNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBiaV14nHYc6s6VsYITJu5KaTaND7A+yUt2pxHnlCgrctD+bEyovKK9gh54uvDbM1
	 4FMo5eAGQaRxD7vm1F7ydwm47jxYymyheech1ZO1L3JW00kI0cGBWMA0xTkjQ9Eq2h
	 BF/QLpsFT1TB/AT86cO551Ppvn2JpU5fd/+E3bEs=
Date: Wed, 31 Jul 2024 10:34:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: skhan@linuxfoundation.org, dan.carpenter@linaro.org,
	rbmarliere@gmail.com, christophe.jaillet@wanadoo.fr,
	Chris.Wulff@biamp.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_audio: Use C99 syntax for array
 initializers
Message-ID: <2024073102-calculate-disabled-8700@gregkh>
References: <20240729174639.446105-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729174639.446105-1-abhishektamboli9@gmail.com>

On Mon, Jul 29, 2024 at 11:16:39PM +0530, Abhishek Tamboli wrote:
> Convert array initializers to C99 syntax by adding the '=' after each
> designated initializer. This change resolves warnings from smatch
> about obsolete array initializers.
> 
> drivers/usb/gadget/function/u_audio.c:1117:20:warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1124:28:warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1131:19:warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1138:27:warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1145:25:warning: obsolete array initializer, use C99 syntax
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  drivers/usb/gadget/function/u_audio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
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


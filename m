Return-Path: <linux-kernel+bounces-327010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966D9976FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D90F287CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D81BE86D;
	Thu, 12 Sep 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="12pvVjgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792B450FA;
	Thu, 12 Sep 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163271; cv=none; b=lBzNqTSMAiVVnJgYASF6OpTe57ObB8QiRvz559T1CvoxQ9q/pdjPjqRJo7Gbm1wE37osQj/pG7UXpVwF0DeMUTixHeXDpZcEGJMxvsdvd7hHsLMYt1cOfU4jW2nOxBAWHwfVRL5qWewZ2g7N8vuFOm4eFrHVJhNsYYhPmUAjG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163271; c=relaxed/simple;
	bh=V59tfk+p83hYWl3xIBeXykYvxSNMAPxX7texZ0OBgqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxbPnNFgkBEe8OgvAW8LOHMEmPi/bT1cAGkAjH/jBVPekIeJqDl/9RXhDtxk5UJtagcyr9rvgsNF+CschzBP6HufqA+JWhHYeGFIMQ6BcpKcwlBQFROYQjQ8TiWo61Bz6NwkMH24KnEApOTNXWR8W/VUk4KMRHb6dwbRrc0yX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=12pvVjgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491A9C4CEC3;
	Thu, 12 Sep 2024 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726163270;
	bh=V59tfk+p83hYWl3xIBeXykYvxSNMAPxX7texZ0OBgqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=12pvVjgMWiIJ0lGyWL5xbf3d/VWZrJNpHNKjgcP3kb29RuOmbtUoyibSDUlMOdHaD
	 bky3FSTY+Uo/nj+SRFdCNz4mwIHlFt0DoULYiU8CD4H0com5e/DWhdzEnnTRQNTt1i
	 l7CB0LpMLJlMpKVy48tUC46p5CBsEgPowwD03R3M=
Date: Thu, 12 Sep 2024 19:47:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Roy Luo <royluo@google.com>, Alan Stern <stern@rowland.harvard.edu>,
	Chris Wulff <crwulff@gmail.com>, yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: core: force synchronous registration
Message-ID: <2024091239-wildly-caucus-1a67@gregkh>
References: <20240912164502.2134084-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912164502.2134084-1-jkeeping@inmusicbrands.com>

On Thu, Sep 12, 2024 at 05:45:00PM +0100, John Keeping wrote:
> Registering a gadget driver is expected to complete synchronously and
> immediately after calling driver_register() this function checks that
> the driver has bound so as to return an error.
> 
> Set PROBE_FORCE_SYNCHRONOUS to ensure this is the case even when
> asynchronous probing is set as the default.
> 
> Fixes: fc274c1e99731 ("USB: gadget: Add a new bus for gadgets")
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> ---
> v2:
> - Add "Fixes" trailer
> 
>  drivers/usb/gadget/udc/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index cf6478f97f4a3..a6f46364be65f 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1696,6 +1696,7 @@ int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
>  	driver->driver.bus = &gadget_bus_type;
>  	driver->driver.owner = owner;
>  	driver->driver.mod_name = mod_name;
> +	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
>  	ret = driver_register(&driver->driver);
>  	if (ret) {
>  		pr_warn("%s: driver registration failed: %d\n",
> -- 
> 2.46.0
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


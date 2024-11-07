Return-Path: <linux-kernel+bounces-399512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FC9C000C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FBDB22AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A031D9A5F;
	Thu,  7 Nov 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUsIgnM8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5B1922D8;
	Thu,  7 Nov 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968492; cv=none; b=HJhtCTNtH9sPY/hbOSDo7TgbqJffBQYFG5TejNmIW15xNByI2fZZzaLW77m4yrDwJE3BgTKk22Z/ABr8FmrIMzQV7p7TrHSci1Emq7bINJPHnzz/R7F02x6EMxm1ag9SYED2z2YbKQFITGwsKt2l0LWhkzV0JnwKi8P/shCjB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968492; c=relaxed/simple;
	bh=zaSp5Zi/JERPJYX+Ul60OjcFfQieL/7nqYIMSUDALZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKz7qxndifmwOIkBnM57tnsYSb3zdwkUhQTivbWohamKg6apBjPvfnKSRRN1jHYfHCpPc2p2rHxXMKHgQbwQ7ZZtWVpGkyvjm1xqzypaLuRrgpELkrrIc7FGLuSOBneSj3SrTRCbJbQ58av5ePaxuUlPCmD45XZcnfxMkl4kGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUsIgnM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA653C4CECC;
	Thu,  7 Nov 2024 08:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730968492;
	bh=zaSp5Zi/JERPJYX+Ul60OjcFfQieL/7nqYIMSUDALZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUsIgnM82rVj45U0NrV7UJDdsWLgoKuEOSZVeb+YvlyMTQ4T6cCUDKehbp4LZiEzI
	 YJ+VyO3ZVL1Dm2Srm7qNyXkjKsauyfBOMWO/L6nMpJ4MTgYfgbT7s+2HVzq7wPURhk
	 hIeRSAyVYMx8QyW/eoMsB+TBgpR0ARokK7p1xlAA=
Date: Thu, 7 Nov 2024 09:29:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH v2] greybus/uart: Fix atomicity violation in
 get_serial_info()
Message-ID: <2024110754-rewind-relish-c476@gregkh>
References: <20241106095819.15194-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106095819.15194-1-chenqiuji666@gmail.com>

On Wed, Nov 06, 2024 at 05:58:19PM +0800, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but 
> get_serial_info() does not. Fortunately, the impact of this is relatively 
> minor. It doesn't cause a crash or any other serious issues. However, if a 
> race condition occurs between set_serial_info() and get_serial_info(), 
> there is a chance that the data returned by get_serial_info() will be 
> meaningless.
> 
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")
> ---
> V2:
> Modified the patch description to make it more concise and easier to understand.
> Changed the fix code to ensure the logic is correct.
> Thanks to Johan Hovold and Dan Carpenter for helpful suggestion.
> ---
>  drivers/staging/greybus/uart.c | 2 ++
>  1 file changed, 2 insertions(+)

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


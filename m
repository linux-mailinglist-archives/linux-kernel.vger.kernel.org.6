Return-Path: <linux-kernel+bounces-332061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B697B4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614061C21BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83FE1917E6;
	Tue, 17 Sep 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJFmL2pS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7427470;
	Tue, 17 Sep 2024 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606367; cv=none; b=FDKcW1gEVecQ4E9uTMEzB48e+V/5TFXMfchmTycpomJsegFLafWCtzO1jB/vEU2SHBT3ca4d0/guSycPvQlcbaMgoztwDS/wtcZPHk2Z1lkGP68mNHbDmYe/I2cG+C7xuY6uC8J9d+pSXKrzXi5kFd2qAZ2yQ/BBBCnXoJQNjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606367; c=relaxed/simple;
	bh=MihfQfGY4t38NvosXuHtawOewr8RJbkv4jxSbju8Jv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHqCp0a8lrIRkFjjddJq11V/kYMP2OnYwMcVxzinfDARyIC+aq38U0VECEM32XrGoge8ZGe7EF9JGnE5DDEj6WMTN7+dLwjvWOAzrUwZcM11qlLgb/JvazMEXb8qOQO6/51tE6qwf2bxhzWUlhUuumkrNoff5kigjbZMm301CZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJFmL2pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4754BC4CEC5;
	Tue, 17 Sep 2024 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726606366;
	bh=MihfQfGY4t38NvosXuHtawOewr8RJbkv4jxSbju8Jv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJFmL2pSCzN2MD1mO1hs/Np4+opJWOXqz1p+CZTyEy63txS3tSSbo5xS8oWob0kl+
	 Y/yPvBZyfuxtv28h3ohytM8d7sLWhfVD3S0GLOa0eyv6/bX1ge9m5sB4RPiEXIvlnA
	 NLdhNSHVjSJIeUsglowVFcEpjVpWjQGFQ4QcQiNY=
Date: Tue, 17 Sep 2024 22:52:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: oneukum@suse.com, colin.i.king@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: using mutex lock and supporting O_NONBLOCK flag in
 iowarrior_read()
Message-ID: <2024091730-reporter-clause-80b4@gregkh>
References: <20240917164820.143197-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917164820.143197-1-aha310510@gmail.com>

On Wed, Sep 18, 2024 at 01:48:20AM +0900, Jeongjun Park wrote:
> iowarrior_read() uses the iowarrior dev structure, but does not use any 
> lock on the structure. This can cause various bugs including data-races,
> so it is more appropriate to use a mutex lock to safely protect the 
> iowarrior dev structure. When using a mutex lock, you should split the
> branch to prevent blocking when the O_NONBLOCK flag is set.
> 
> In addition, it is unnecessary to check for NULL on the iowarrior dev 
> structure obtained by reading file->private_data. Therefore, it is 
> better to remove the check.
> 
> Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 10 deletions(-)

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


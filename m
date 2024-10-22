Return-Path: <linux-kernel+bounces-375818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BCA9A9B37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE301281F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1914F9F8;
	Tue, 22 Oct 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IMjpGfIS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA2126C15;
	Tue, 22 Oct 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582720; cv=none; b=TbmybpE6KVOKzFV3ra8P1DuKD+EelmSPyd84nTijW281zXSd4g5i9Rz1wKdhBKTIza0mADzr6Ag6ZZBPSznvNFbGNaGVRVIJZxCz71qkgafAgBsaA4iuoQI2dlbKKWJGsXoVKZgy/vedSdIFyx18z/9z54ul9RMHxDpKgk1aCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582720; c=relaxed/simple;
	bh=NuYHRssbn2VoQj3UaNnHErap6gN1yg76AcGsYZ11iIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu8Q8GtaoxwTPBi3gyI3uXINJcw7gI2k3Wo102GmVhHxa6BUhlkBExUn307O+qraVnMhWKcflchoIV4TbGRLPWaLY7YK1gf2hxjfbkfRhcOqKIaUPt6PyoAHzLOOAI5BcigJOEv1rkEHL1Hk9rY2A5J9oZXovQtcNz6y6zdIoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IMjpGfIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B90C4CEC3;
	Tue, 22 Oct 2024 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729582720;
	bh=NuYHRssbn2VoQj3UaNnHErap6gN1yg76AcGsYZ11iIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMjpGfISphmRAnJBAfaK69TMkq6eN6JCxSoxyvX8TZR3u8Z77nG++JfZ2l7jRrXJd
	 P1+Sj/UaihuytmXdcMNhuPblNzr7IIAMpV2ykG3XcCMFBxadxGNUfpHArvcEY6vcs8
	 LT/SrDOnhfZhoOpx9ror5Ardqk3k1urir8ZdzPrE=
Date: Tue, 22 Oct 2024 09:38:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: huanglei814 <huanglei814@163.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: Re: [PATCH v2] usb: core: adds support for PM control of specific
 USB dev skip suspend.
Message-ID: <2024102223-multitude-buckle-7035@gregkh>
References: <20241022073322.6150-1-huanglei814@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022073322.6150-1-huanglei814@163.com>

On Tue, Oct 22, 2024 at 03:33:22PM +0800, huanglei814 wrote:
> From: huanglei <huanglei@kylinos.cn>
> 
> All USB devices are brought into suspend power state after system suspend.
> It is desirable for some specific manufacturers buses to keep their devices
> in normal state even after system suspend.
> 
> Signed-off-by: huanglei <huanglei@kylinos.cn>
> ---
>  drivers/usb/core/Kconfig     | 11 +++++++++++
>  drivers/usb/core/driver.c    | 14 ++++++++++++++
>  drivers/usb/host/xhci-plat.c |  7 +++++++
>  include/linux/usb.h          |  9 +++++++++
>  4 files changed, 41 insertions(+)

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


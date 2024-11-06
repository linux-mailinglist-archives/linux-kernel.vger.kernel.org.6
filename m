Return-Path: <linux-kernel+bounces-397622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E869BDE28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6891C22510
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E592191478;
	Wed,  6 Nov 2024 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KI97yrkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4962F50;
	Wed,  6 Nov 2024 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730869549; cv=none; b=t5Luucnf75tOv1iJfd0TzEu5lHeOTwViKe/fTZ+O9DkzH/JoY0q9DTcMDWDcUUuEqUs3LXeHJ2PA7zxfapAoNBeAOiIjItmZszbiO+l+xXbJ+SEysvYT8Ea11RPtJUeqvDVr+uyLb+1vvaNgnG/r5XJyACiey8mjSpQ2Qeendic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730869549; c=relaxed/simple;
	bh=r5+V6O8KvZg6st/Kb+eZvvE2eU3/E8D/N8KaYGPUADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh8Mf/1n4QLk9BxPUHrpa4Y4XINPOKslpJYZmzxYvgjYr2Uc0W5emv1nrgwaa75jPLnbE5AvbRfMTclSuE3XieP/x4idAFGorENocAVWOfOByL6nh5RM62LEEZ/7LX9o5t/gjCLJgYK0rtqRxN9jK7adN5NOUqfQUQwC06bUwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KI97yrkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8DBC4CECD;
	Wed,  6 Nov 2024 05:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730869549;
	bh=r5+V6O8KvZg6st/Kb+eZvvE2eU3/E8D/N8KaYGPUADU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KI97yrkNDg6s/xnIZzIGOYPjvS7IF09Lr0qGq4OTo43wICY3Q0KToAHRCF2tAF8Sc
	 I82+bEE0gMsjlEv+e29xaUk7089f0I4ZybKjEbYeGFSrVF1Mab1+BGVFNwzA46BZTT
	 5NMgCxopuIyGslwS7KYglR9lGikAFCzpjTIspXfQ=
Date: Wed, 6 Nov 2024 06:05:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: andreyknvl@gmail.com, viro@zeniv.linux.org.uk,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu, skhan@linuxfoundation.org,
	syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: raw_gadget: Add debug logs to a troubleshoot a
 double-free bug in raw_release.
Message-ID: <2024110657-tummy-decaf-66ee@gregkh>
References: <Zyrsg3bvNu1rswqb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyrsg3bvNu1rswqb@gmail.com>

On Tue, Nov 05, 2024 at 08:11:47PM -0800, Chang Yu wrote:
> syzkaller reported a double free bug
> (https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c) in
> raw_release.
> 
> >From the stack traces it looks like either raw_release was invoked
> twice or there were some between kref_get in raw_ioctl_run and
> kref_put raw_release. But these should not be possible. We need
> more logs to understand the cause.
> 
> Make raw_release and raw_ioctl_run report the ref count before
> and after get/put to help debug this.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index 112fd18d8c99..ac4e319c743f 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -194,6 +194,8 @@ static struct raw_dev *dev_new(void)
>  		return NULL;
>  	/* Matches kref_put() in raw_release(). */
>  	kref_init(&dev->count);
> +	dev_dbg(dev->dev, "%s kref count initialized: %d\n",
> +		__func__, kref_read(&dev->count));

Please note that you never need to add a __func__ to a dev_dbg() call,
as it is already present automatically for you.

thanks,

greg k-h


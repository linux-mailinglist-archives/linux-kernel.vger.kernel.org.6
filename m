Return-Path: <linux-kernel+bounces-330145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCFD979A46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4803F1F21FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010CB38DE4;
	Mon, 16 Sep 2024 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0wFdXFLz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA521340;
	Mon, 16 Sep 2024 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726460125; cv=none; b=jGchs0cF38t1v8WJPNe8a4sou1VyaBaUMZwqOBuBUk4DFSX6RPCfqZvlXgYMGz2fWdFgacGhw3dPUOAG5KuUAuUVJl7A/C9ozJ7SUsg79OUkotCpVWp8lsj9QGVgFnEljRwL8dSU0kX0xduGSb2fDxJJdyC22Luv62DbJK4HQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726460125; c=relaxed/simple;
	bh=a5hgv+YgAEVp5ILOEpcTymGTtUAKiZp8dVDg618Ildw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKpPZPRUIbp/akVZZqJ3MneGsAMR9e+Gm0S0lXqa5onzN4JavH8gemsnITO9qdDRnvJ5dxxvrfQEMiaaTStLDuNG53qYR8EiK4c+WjlJXDVjXJ3tT2DF01KeAcpwi7vQc6PTIPOfmVxr3ncrzwRTepPbQNREuidBEp+FflP2ZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0wFdXFLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79356C4CEC5;
	Mon, 16 Sep 2024 04:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726460123;
	bh=a5hgv+YgAEVp5ILOEpcTymGTtUAKiZp8dVDg618Ildw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0wFdXFLzqVMdpbc6VAb7dIkGi8q3ZVXnm9QMKclwMI3e5vJvWeqXkO81XmKkWztce
	 aAg/TPQAwt6fuV2IyWX8TQR7T6Q8hgpbgvztQL0anmaOsNePdsjK8W2PZHN3C4iYu4
	 rWG2RwwUcbBhci2E0DbfpAB1g119UUd9ah4dA6gE=
Date: Mon, 16 Sep 2024 06:15:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: colin.i.king@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
Message-ID: <2024091648-excusable-unfilled-83de@gregkh>
References: <20240916040629.28750-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916040629.28750-1-aha310510@gmail.com>

On Mon, Sep 16, 2024 at 01:06:29PM +0900, Jeongjun Park wrote:
> Currently, iowarrior_read() does not provide any protection for the
> iowarrior structure, so the iowarrior structure is vulnerable to data-race.
> 
> Therefore, I think it is appropriate to protect the structure using
> mutex_lock in iowarrior_read().
> 
> Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/usb/misc/iowarrior.c | 42 +++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index 6d28467ce352..7f3d37b395c3 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -277,28 +277,41 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>  	struct iowarrior *dev;
>  	int read_idx;
>  	int offset;
> +	int retval = 0;
>  
>  	dev = file->private_data;
>  
> +	if (!dev) {

How can this happen?  How was this tested?

And you didn't mention this in your changelog, why?

> +		retval = -ENODEV;
> +		goto exit;
> +	}

What prevents dev from becoming invalid after it is checked here?

> +
> +	mutex_lock(&dev->mutex);

Please use the guard() form here, it makes the change much simpler and
easier to review and maintain.

thanks,

greg k-h


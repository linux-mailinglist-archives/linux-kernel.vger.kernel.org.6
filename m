Return-Path: <linux-kernel+bounces-187273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50938CCF58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5241F23112
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895A13D538;
	Thu, 23 May 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dxujooKk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7513D28E;
	Thu, 23 May 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456745; cv=none; b=QITQyFwwG93x5SJmLRVcmaag836vh20Jgvp0IKeZMEfAkblBl8O74ib3H5yLnjqzRymsIAq73XSiaSBzXAHK3IQ/whPVQKkDz1BqMBgkjzVsJVw3ZnjKpjQPs8m4b31lCmbw26d943fFlMQz1mdibCebRzzTkoskLIXvWnj4y/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456745; c=relaxed/simple;
	bh=i/suwIO2X+IkJLPKjmWkqmwdbwnnIhI4At/U51qCpdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piktVr98Anj6MFtix8sn6TWWgjk0ZnhuQdSnZhNWWOZsN22nQq7Q4YY91Ezkz7QYcq6J8Ex9g/5yE1uxApyJYqM3s9WbJXP14BRCn7xZ9jxalKPGgP0P0yGpkBfuHgZI9NYrBjGFNS5Hg0a9Uz4Hg6y+PiZSgpPddIpGArKrEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dxujooKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061B2C3277B;
	Thu, 23 May 2024 09:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716456743;
	bh=i/suwIO2X+IkJLPKjmWkqmwdbwnnIhI4At/U51qCpdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxujooKkOt81xkww9E/rCw7M2kqEcQL/edR+l4TEIrFph3a+zIcB8ZzfXbvkRkOdu
	 w1UAN/ewE6XhixSlj4Js8iCvNMW1bnfE+hqGFmZtGrgUfb0nt+6uBOmVXvYZrL9z/Y
	 t7U2rGdrLWOENswfM1n+jz4CXRo6wnGX4x8Sf6Ug=
Date: Thu, 23 May 2024 11:32:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shichao Lai <shichaorai@gmail.com>
Cc: stern@rowland.harvard.edu, oneukum@suse.com, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCHv2] Check whether divisor is non-zero before division
Message-ID: <2024052359-clothes-plentiful-c320@gregkh>
References: <20240523092608.874986-1-shichaorai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523092608.874986-1-shichaorai@gmail.com>

On Thu, May 23, 2024 at 05:26:08PM +0800, Shichao Lai wrote:
> Since uzonesize may be zero, so judgements for non-zero are nessesary in both place.
> Previous check is moved out of loop, and one more check is added in alauda_write_lba.
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
>  drivers/usb/storage/alauda.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..a6e60ef5cb0d 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -818,6 +818,8 @@ static int alauda_write_lba(struct us_data *us, u16 lba,
>  	unsigned int blocksize = MEDIA_INFO(us).blocksize;
>  	unsigned int lba_offset = lba % uzonesize;
>  	unsigned int new_pba_offset;
> +	if (!uzonesize)
> +		return USB_STOR_TRANSPORT_ERROR;
>  	unsigned int zone = lba / uzonesize;
>  
>  	alauda_ensure_map_for_zone(us, zone);
> @@ -923,6 +925,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
>  	unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
>  	struct scatterlist *sg;
>  	int result;
> +	if (!uzonesize)
> +		return USB_STOR_TRANSPORT_ERROR;
>  
>  	/*
>  	 * Since we only read in one block at a time, we have to create
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

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


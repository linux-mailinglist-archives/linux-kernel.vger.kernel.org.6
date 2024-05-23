Return-Path: <linux-kernel+bounces-187414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B98CD179
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C8D1F21CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B813BAFB;
	Thu, 23 May 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NMmYC3WZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC53307B;
	Thu, 23 May 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464864; cv=none; b=WlQWxvgjoX8D6iNN37flF+LoHUJHFtUMVk2VWgkgvVgqvM0nDz3Kz7w79rqts5q/vqzpU3OPfSo7zyVj8lJp+/gPWiH6+ycefUnn0/Svm2Aj83UNklam4qt/4SgFg16PEUn4M1MIDhUGVbPhn9HY+E2GC9pTFByAymizkF+cNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464864; c=relaxed/simple;
	bh=3xbtnJwok+zrcbye3vysIdYFag8LyyseDL1qlml8khc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIubNPDHFHKP+dN338Ws6GeTGiP43apyoskXmDKvEw/1mnTBLeaM70P9x8JD0xKbM8+qmaGgVqegpbf/SZvuaJRp+B3ftmvkWq1Cq8NPKmFLxesmiKVwchoYSyO7Vcb4VJn44gsHOEH5k6M06MfKBRneJIPR+MF1Wwg/JzZ8qNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NMmYC3WZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F219C3277B;
	Thu, 23 May 2024 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716464864;
	bh=3xbtnJwok+zrcbye3vysIdYFag8LyyseDL1qlml8khc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMmYC3WZAWpmW6xYQmR70bKA5gQiFRjQyPCYC3hNWsRwhWemQneADLGWG0c/O7ZLq
	 EtmwpAOJOpIC7h1ykeAIMpXpflbVEEijS4DXHeqym8XVN8Q9x/2MXiAzp6QYoq199R
	 3s7kWsSuLjpvRTOmBHpCnilH3S5zeBzaGchiW/oU=
Date: Thu, 23 May 2024 13:47:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shichao Lai <shichaorai@gmail.com>
Cc: stern@rowland.harvard.edu, oneukum@suse.com, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v2] usb-storage: Check whether divisor is non-zero before
 division
Message-ID: <2024052351-demote-gangly-74b0@gregkh>
References: <20240523113410.983875-1-shichaorai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523113410.983875-1-shichaorai@gmail.com>

On Thu, May 23, 2024 at 07:34:10PM +0800, Shichao Lai wrote:
> Since uzonesize may be zero, so judgements for non-zero
> are nessesary in both place.
> 
> Changes since v1:
> - Add one more check in alauda_write_lba().
> - Move check ahead of loop in alauda_read_data().

Nit, this changes list should go below the --- line, as the
documentation asks for.


> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
>  drivers/usb/storage/alauda.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..17c73acd3b02 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -813,6 +813,8 @@ static int alauda_write_lba(struct us_data *us, u16 lba,
>  	unsigned char ecc[3];
>  	int i, result;
>  	unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
> +	if (!uzonesize)
> +		return USB_STOR_TRANSPORT_ERROR;

Check after the list of variables please, not in the middle of them.  I
think checkpatch will complain about this, right?


>  	unsigned int zonesize = MEDIA_INFO(us).zonesize;
>  	unsigned int pagesize = MEDIA_INFO(us).pagesize;
>  	unsigned int blocksize = MEDIA_INFO(us).blocksize;
> @@ -921,6 +923,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
>  	unsigned int blocksize = MEDIA_INFO(us).blocksize;
>  	unsigned int pagesize = MEDIA_INFO(us).pagesize;
>  	unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
> +	if (!uzonesize)
> +		return USB_STOR_TRANSPORT_ERROR;

Same here, at the end of the variable list please.

thanks,

greg k-h


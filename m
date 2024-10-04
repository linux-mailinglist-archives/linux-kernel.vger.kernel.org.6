Return-Path: <linux-kernel+bounces-350319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265B990366
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23621C221C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F720FAA7;
	Fri,  4 Oct 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fwh8uVgw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E269D2B;
	Fri,  4 Oct 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046725; cv=none; b=SpfxrFN9gxsyDOV8AdgbIMdaD1MZkyfjYDJSHMwgt+QHO2O+uwjeJbumJyv9bmFdO8hAljrKhiVtUY5uJVWjl0i/OLdodcetkYpmmJiTqyL1P7bSSHyrMAXJiUxpTMVeHfLvLPQVBw67dYDSHOaJfah6FRnjF3bLAPFMrrLIT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046725; c=relaxed/simple;
	bh=8zprOAacVeILdhEy4RFDOUPtFBD2SkQh0UJOidOIk/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcr3a9+bmVdjLYm1ERe1sWkp/LU9cdfUUUHNoL428pIqoIOy03oPBLBUZky9VlO8IMDIGOwFOag40fVMk1Q2MI0WaMdvy/O3oqnuW+QiZeKU0YnWNpGQAHTstxpS0SWRtrMlRRQC67Yc9rmDFbrqHLB2RcCatPvKFs7LpjA1wKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fwh8uVgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94991C4CEC6;
	Fri,  4 Oct 2024 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728046725;
	bh=8zprOAacVeILdhEy4RFDOUPtFBD2SkQh0UJOidOIk/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fwh8uVgwv8aLAaWVCsdnBLnk6DUebSrkn0aFO1aj1RKMhCsRBYeJ2n9D3/volqyQt
	 Hnwg+O6adB192izynehf76EufnSWNnozv1MGTKDaYtOsxKuWzj8Vxq2Wm7EUpxMJRY
	 lDzGhGaHRnXhPgwIrmaYGEOF6CAb+GuERmPse14c=
Date: Fri, 4 Oct 2024 14:58:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pimyn@web.codeaurora.org, Girgis@web.codeaurora.org,
	bemenboshra2001@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, nogikh@google.com,
	glider@google.com, dvyukov@google.com, elver@google.com,
	pimyn@google.com,
	syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: usbtmc: initialize memory written to device
Message-ID: <2024100421-emerald-player-e331@gregkh>
References: <20241004123313.2463701-1-bemenboshra2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004123313.2463701-1-bemenboshra2001@gmail.com>

On Fri, Oct 04, 2024 at 12:33:13PM +0000, Pimyn@web.codeaurora.org wrote:
> Avoid kernel-usb-infoleak by initializing all memory written to device.
> The buffer length uses 32bit alignment which might cause some buffer
> data to be read without any initialization.
> 
> Reported-by: syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000006f6622061eb52dba@google.com/T/
> Signed-off-by: Pimyn Girgis <bemenboshra2001@gmail.com> (Google)
> ---
>  drivers/usb/class/usbtmc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index ffc9c6fdd7e1..d79a08dfb54d 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -21,6 +21,7 @@
>  #include <linux/usb.h>
>  #include <linux/compat.h>
>  #include <linux/usb/tmc.h>
> +#include <linux/string.h>
>  
>  /* Increment API VERSION when changing tmc.h with new flags or ioctls
>   * or when changing a significant behavior of the driver.
> @@ -1169,6 +1170,8 @@ static ssize_t usbtmc_generic_write(struct usbtmc_file_data *file_data,
>  		 * (size + 3 & ~3) rounds up and simplifies user code
>  		 */
>  		aligned = (this_part + 3) & ~3;
> +		/* Initialize the remaining part of the buffer */
> +		memzero_explicit(buffer + this_part, aligned - this_part);

Why "explicit"?

Also, what about commit 625fa77151f0 ("USB: usbtmc: prevent
kernel-usb-infoleak"), doesn't that solve the issue here?

thanks,

greg k-h


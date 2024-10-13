Return-Path: <linux-kernel+bounces-362789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3867A99B950
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E55E1C2037D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAA14037F;
	Sun, 13 Oct 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KUs6IFh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CF13AD0F;
	Sun, 13 Oct 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821036; cv=none; b=rVozAB1wxnT9yZL/jMei9cEcXNdcYB6mb295VNQjsifwStcYljpk6silI3+ZDU9mJjA0WsFJdbfkVYTFfEdBHrllWHogm+cHcuf0bY2UtZ9YgE0rx+70hQN/fvpKEi09QWatzpoXXcLR2QzPHdRbPdNJksbxDqoJM1r2Z9s9DWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821036; c=relaxed/simple;
	bh=GXhoBn8G3dY7XSzGK0FJllzywqPAP+aarGbodaM40WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/fLaqkh628Ibkh1rDV9hlqXhzJc4UxjghDohD4KiAnesjMOX4kXiedM2RMsCvK3tuyd50alq6JOlg/z+8qIKYjTwkKQonHNs68l3+gb25X+Z2SzXExGDxnCta/ONJ6DAK7nGhDIt/CXDIJ6J8R1ffBWle1C0li8qOjCCQULIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KUs6IFh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E1EC4CEC5;
	Sun, 13 Oct 2024 12:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728821035;
	bh=GXhoBn8G3dY7XSzGK0FJllzywqPAP+aarGbodaM40WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUs6IFh0j5SzhKAECbba9AyRoNFAagcZjrD/L8RihoLhmGoXW8Pus6Vjkb4M5gjak
	 R0GIOQlez8DSTFyy7dmetGAoToYq70ZzgDCbXvDt5IW33eUVRO26+PdK81r/2zqh4W
	 eN789HnqFC0idrjmO5d2q7Qg9DEC2+6gbj8Bhsx0=
Date: Sun, 13 Oct 2024 14:03:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Oliver Neukum <oneukum@suse.com>, Keith Packard <keithp@keithp.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] USB: chaoskey: fix deadlock in release
Message-ID: <2024101330-atom-womanhood-456a@gregkh>
References: <8c34cb8d-faaf-4134-851d-78db678d535f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c34cb8d-faaf-4134-851d-78db678d535f@stanley.mountain>

On Fri, Oct 11, 2024 at 10:43:50PM +0300, Dan Carpenter wrote:
> This lock should was intended to be an unlock.  It will lead to a hang.
> 
> Fixes: 422dc0a4d12d ("USB: chaoskey: fail open after removal")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> >From static analysis.  Not tested.
> 
>  drivers/usb/misc/chaoskey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
> index e8b63df5f975..4025f386ba6b 100644
> --- a/drivers/usb/misc/chaoskey.c
> +++ b/drivers/usb/misc/chaoskey.c
> @@ -319,7 +319,7 @@ static int chaoskey_release(struct inode *inode, struct file *file)
>  bail:
>  	mutex_unlock(&dev->lock);
>  destruction:
> -	mutex_lock(&chaoskey_list_lock);
> +	mutex_unlock(&chaoskey_list_lock);
>  	usb_dbg(interface, "release success");
>  	return rv;
>  }
> -- 

The commit at:
	https://lore.kernel.org/r/tencent_84EB865C89862EC22EE94CB3A7C706C59206@qq.com
was tested, so I'll take that one :)

thanks,

greg k-h


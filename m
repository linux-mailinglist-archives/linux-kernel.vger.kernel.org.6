Return-Path: <linux-kernel+bounces-269194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70BA942F17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA261F27318
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2821B14F8;
	Wed, 31 Jul 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+mKZXh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F11B0137
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430172; cv=none; b=hV55wWF1x2vxRjByDEc+LsDwyj7v/xpeTGAfyaPsjtssajAAOselgGLL3NjzqUAR9mmUnCWwqjorfBx51kFtR2B/IrnMREOOvCuNsgLq4kUJaX8C+cC9iO4wapLNQwD7WDgz3pPxSxZL9GhsBkbEMu0c0Gd0V+LC9mdRIkwVdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430172; c=relaxed/simple;
	bh=o8dxmA9NvH0xfgNm/9WDIWVMrgCIGSbX5Dh/Ewh0snU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCHlncp9qScrMc4MaOV01lsPUMPu4A3b1CSrOwcYcx0ACQK9Hv6OSD2387xDhgNUZ1ZFmxnWV/j1VDsuvtvmIHPcvglA+IXL+KLZdSSIY0JnBtr4KpN32nYDmTQ4lOD+HvpYTBENhTpRBMVXAOQabK1xzHqSnJ6St/A1qwuDvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+mKZXh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA17C116B1;
	Wed, 31 Jul 2024 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722430171;
	bh=o8dxmA9NvH0xfgNm/9WDIWVMrgCIGSbX5Dh/Ewh0snU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+mKZXh1blGqGEE2Tm3r+3j404kZ+gY9qK/9Oy+2+y9A2Zh6rnr7iWpRugvHlFiPM
	 QKdvhnkL6uKUS5CjRkTxHZ9mipkquZ3JD8NThNrZxxI/ohgZBlCV5D2Lx371rIR2/P
	 yUkTd6qMYQeGO8F4qNNpLc7lqEOqcWiGloBWGULI=
Date: Wed, 31 Jul 2024 14:49:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver:core:  NO need to determine whether the driver is
 asynchronous
Message-ID: <2024073156-litter-antennae-a9d9@gregkh>
References: <20240714050507.2505-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240714050507.2505-1-sensor1010@163.com>

On Sat, Jul 13, 2024 at 10:05:07PM -0700, 李哲 wrote:
> When rescanning the device, there is no need to determine
> whether the driver is asynchronous.
> 
> Signed-off-by: 李哲 <sensor1010@163.com>
> ---
>  drivers/base/dd.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 47351d98f6e1..41fd4b1b4779 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -915,7 +915,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>  {
>  	struct device_attach_data *data = _data;
>  	struct device *dev = data->dev;
> -	bool async_allowed;
> +	bool async_allowed = false;
>  	int ret;
>  
>  	ret = driver_match_device(drv, dev);
> @@ -936,12 +936,14 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>  		return ret;
>  	} /* ret > 0 means positive match */
>  
> -	async_allowed = driver_allows_async_probing(drv);
> +	if (data->check_async) {
> +		async_allowed = driver_allows_async_probing(drv);
>  
> -	if (async_allowed)
> -		data->have_async = true;
> +		if (async_allowed)
> +			data->have_async = true;
> +	}
>  
> -	if (data->check_async && async_allowed != data->want_async)
> +	if (async_allowed != data->want_async)
>  		return 0;
>  

I'm sorry, but I don't see what this is making simpler or cleaner.  It's
increasing the lines of code, and just moving things around?

What issue is this fixing?  What logic is changing?  Why is this needed?

thanks,

greg k-h


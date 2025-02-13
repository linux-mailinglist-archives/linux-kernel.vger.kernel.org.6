Return-Path: <linux-kernel+bounces-512620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCEEA33BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82BB188CE73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C020FA9B;
	Thu, 13 Feb 2025 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cldpDhZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7220E6E4;
	Thu, 13 Feb 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440172; cv=none; b=M3aHpS5n8wB0DXcFFIL+HcnBhPm+7V1PXfTyS+IE1CDvb8r3kez/rTdMbKwDVTJ4bD8FMdz/tT+0WedW8hfGHdOZx7NKu+jI7f5ohwXXZNzrOlfXbt/IOl4wYLVOWwkUGwuwgx6cCCJiRJWdytf8w6Jnbgu8Mz9w5CqQDRvlyrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440172; c=relaxed/simple;
	bh=ZUUe17h+1ph0NJ36IGXSutFrUjXudo4tr3NI+HFzifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxMhKeaDkEgEJVTcV1K010c4+3/uacjAEM92/nsCzs6Wx02MLhOB4Hqjgs0HwK1p0LQwLZr/KxQ1lA/u0XqVOH/7ev60M3R/9NohncaGM2zIKLidxYqEJ6eSCJRZe2X2uZzyORq9pdIJ2fXiuQq1aqIjBrA10fn//lUW60Z9EmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cldpDhZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7A0C4CED1;
	Thu, 13 Feb 2025 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739440171;
	bh=ZUUe17h+1ph0NJ36IGXSutFrUjXudo4tr3NI+HFzifQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cldpDhZ5r0jc3XyH45YleFT5nTMC/P4i3yqPxsskCZMVbExWdbuv/obqB9gpHVBCv
	 BGFqMRVyNBhGb9D8Tmy2sLvEgrkyf0/t+M2XcPD+vLmNkPAkcRy0tAKtGXvGBHWJkw
	 2INWmmxThzS1LaodE8lk+UZz6BrsMohORbmrFmoI=
Date: Thu, 13 Feb 2025 10:49:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: 412574090@163.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH] usb: fix error while OF and ACPI all config Y
Message-ID: <2025021343-diner-online-45c1@gregkh>
References: <20250213091553.198050-1-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213091553.198050-1-412574090@163.com>

On Thu, Feb 13, 2025 at 05:15:53PM +0800, 412574090@163.com wrote:
> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> When both OF and ACPI are configured as Y simultaneously，this may
> cause error while install os with usb disk，while reading data from
> the usb disk, the onboard_ hub driver will reinitialize the
> hub, causing system installation exceptions.
> 
> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> ---
>  drivers/usb/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 6497c4e81e95..94e75e7adcc1 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
>  
>  config USB_ONBOARD_DEV
>  	tristate "Onboard USB device support"
> -	depends on OF
> +	depends on OF && !ACPI
>  	help
>  	  Say Y here if you want to support discrete onboard USB devices
>  	  that don't require an additional control bus for initialization,
> -- 
> 2.25.1
> 

What commit id does this fix?

And why did this just show up now?  Also, this feels very odd, why not
fix the driver to work properly here instead of attempting to just not
build it at all?  Building code with OF and ACPI enabled should be
allowed.

thanks,

greg k-h


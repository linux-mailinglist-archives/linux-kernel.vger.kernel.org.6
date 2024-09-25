Return-Path: <linux-kernel+bounces-338065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E447B9852FA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C24FB229A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1F1553A7;
	Wed, 25 Sep 2024 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mhKFVCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22613D508;
	Wed, 25 Sep 2024 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246000; cv=none; b=gri0FKyfID/uZeICz8jC3o/JNxhRnz+RUFneAStvwLU3eOcT4YEns/8/ODqfgwZvU66kcM6q5T0umpBCUGn9+A1OVMxG8DBXcDP+rgBWBTf+zoOvpAFZuVBtYmmACDGliiWS89srtO3xGYgZW7wU1nOG5tR3iui2ITq+ABYX/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246000; c=relaxed/simple;
	bh=y9G0C2SMaTaMUO5hy0HPIGvfCwhhJGHDIxI2Up6CPGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qoiajr4ZLHCmw4tYGwuPD8XNOE3lG6b8+icBbzkFHOM1ADQ6fKxU6JulPmBl1at9LWVjKQJmiSUn+R2ax8iuc0v6lCaYofVFZwnTRxxdsphtaweiJHUpXGdmY/R1YXO2FmoOWzIy+CZ8AEAJIP2QR9WVmcflU77iW5u/3cCn7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0mhKFVCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49877C4CEC3;
	Wed, 25 Sep 2024 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727245998;
	bh=y9G0C2SMaTaMUO5hy0HPIGvfCwhhJGHDIxI2Up6CPGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0mhKFVCvSG/DxAMBggBKP8SnPMFh/btOWPIl6l3MD8j7TvIvNRHwORq23GXjXR4zX
	 6nHUbk01N25Bm+x1C3s1oOGk2+qs6Qlbp4lqyqmMxz6yoJT/otGkVu3fIvtAml8SSv
	 LsG6/K8btmiI0eoh+P9NNakWlGzpUezifbxacQS0=
Date: Wed, 25 Sep 2024 08:33:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: mka@chromium.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, wentong.wu@intel.com, oneukum@suse.com,
	javier.carrasco@wolfvision.net, matthias@kaehlcke.net,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, git@amd.com
Subject: Re: [PATCH] usb: misc: onboard_usb_dev: introduce new config symbol
 for usb5744 SMBus support
Message-ID: <2024092551-fiddle-flatterer-e643@gregkh>
References: <1727187551-3772897-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727187551-3772897-1-git-send-email-radhey.shyam.pandey@amd.com>

On Tue, Sep 24, 2024 at 07:49:11PM +0530, Radhey Shyam Pandey wrote:
> Introduce new kernel config symbol for Microchip usb5744 SMBus programming
> support. Since usb5744 i2c initialization routine uses i2c SMBus APIs these
> APIs should only be invoked when kernel has I2C support. This new kernel
> config describes the dependency on I2C kernel support and fix the below
> build issues when USB_ONBOARD_DEV=y and CONFIG_I2C=m.
> 
> riscv64-linux-ld: drivers/usb/misc/onboard_usb_dev.o:
> undefined reference to `i2c_find_device_by_fwnode'
> drivers/usb/misc/onboard_usb_dev.c:408:(.text+0xb24): undefined
> reference to `i2c_smbus_write_block_data'
> <snip>
> 
> Parsing of the i2c-bus bus handle is not put under usb5744 kernel config
> check as the intention is to report an error when DT is configured for
> usb5744 SMBus support and kernel has USB_ONBOARD_DEV_USB5744 disabled.
> 
> Fixes: 6782311d04df ("usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Suggested-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409140539.3Axwv38m-lkp@intel.com/
> ---
>  drivers/usb/misc/Kconfig           | 11 +++++++++++
>  drivers/usb/misc/onboard_usb_dev.c |  6 ++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 50b86d531701..29976a93f122 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -331,3 +331,14 @@ config USB_ONBOARD_DEV
>  	  this config will enable the driver and it will automatically
>  	  match the state of the USB subsystem. If this driver is a
>  	  module it will be called onboard_usb_dev.
> +
> +config USB_ONBOARD_DEV_USB5744
> +	bool "Onboard USB Microchip usb5744 hub with SMBus support"
> +	depends on (USB_ONBOARD_DEV && I2C=y) || (USB_ONBOARD_DEV=m && I2C=m)
> +	default y

"default y" is if you can not boot without this option enabled for all
Linux systems.  I doubt that is the case here :(

thanks,

greg k-h


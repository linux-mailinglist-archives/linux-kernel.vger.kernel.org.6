Return-Path: <linux-kernel+bounces-312236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E679693E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EAD1F23D42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5821D54CC;
	Tue,  3 Sep 2024 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FdT4n9Im"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E191CDFBE;
	Tue,  3 Sep 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345633; cv=none; b=c4RqUGwN0ts8t94wxnsrMz7CQkowvMex6jA4wCziKt8l3b1xXKhHPFBIz6gN7ZumHdxj3A4v1tmk5ptfsSGxZD7qtupmUtDzpQlUGlJnwkQjAWaNcR1XXJTxzpTB428NP2frVCIhbC5EMBe0SsyqxiicpqtJXOPMQMEXzEchyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345633; c=relaxed/simple;
	bh=b4WA8ZXIW9OBTO0FeutoKz7fM9YZQnuDj/mEmVfaXPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnJ++x+HKgX5FI6kJGCl5ro9e0gAgpio7IQCbQtL/+UdBNc2PCHjdqRYvMBUagDhMuNFlQYrawYHvKK5E2Zy9Zv4hs8q1igfw0blxjggOtzE5qHDjEHGRIzVjpKILBTEX4YtTVOOi1a2MsxADd3VX9hWgqc7RxliF4BuD8gkT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FdT4n9Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62C0C4CEC5;
	Tue,  3 Sep 2024 06:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725345631;
	bh=b4WA8ZXIW9OBTO0FeutoKz7fM9YZQnuDj/mEmVfaXPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdT4n9ImKvxSD0jI6VQSUJ4qoedxpt+qJK77IWsfQNJJ3HSbufKRNO+O00dEKL+5J
	 SDFtQD2FadTIC42reKjNgXv/xFkHVf8iLZo0Zce+rPb8c0vJdgPceTjBettVJMSwuZ
	 DO3Ej/DSG66DVPddc0GhwbmFibAdxy7AVc5KjI/k=
Date: Tue, 3 Sep 2024 08:40:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: mka@chromium.org, sakari.ailus@linux.intel.com, wentong.wu@intel.com,
	javier.carrasco@wolfvision.net, stefan.eichenberger@toradex.com,
	francesco.dolcini@toradex.com, jbrunet@baylibre.com,
	macpaul.lin@mediatek.com, frieder.schrempf@kontron.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Message-ID: <2024090312-stool-ergonomic-f2fe@gregkh>
References: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1725192519-3867920-3-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725192519-3867920-3-git-send-email-radhey.shyam.pandey@amd.com>

On Sun, Sep 01, 2024 at 05:38:39PM +0530, Radhey Shyam Pandey wrote:
> usb5744 supports SMBus Configuration and it may be configured via the
> SMBus slave interface during the hub start-up configuration stage.
> 
> To program it driver uses i2c-bus phandle (added in commit '02be19e914b8
> dt-bindings: usb: Add support for Microchip usb5744 hub controller') to
> get i2c client device and then based on usb5744 compatible check calls
> usb5744 i2c default initialization sequence.
> 
> Apart from the USB command attach, prevent the hub from suspend.
> when the USB Attach with SMBus (0xAA56) command is issued to the hub,
> the hub is getting enumerated and then it puts in a suspend mode.
> This causes the hub to NAK any SMBus access made by the SMBus Master
> during this period and not able to see the hub's slave address while
> running the "i2c probe" command.
> 
> Prevent the MCU from putting the HUB in suspend mode through register
> write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2
> register at address 0x411D controls this aspect of the hub. The
> BYPASS_UDC_SUSPEND bit in register 0x411Dh must be set to ensure that the
> MCU is always enabled and ready to respond to SMBus runtime commands.
> This register needs to be written before the USB attach command is issued.
> 
> The byte sequence is as follows:
> Slave addr: 0x2d           00 00 05 00 01 41 1D 08
> Slave addr: 0x2d           99 37 00
> Slave addr: 0x2d           AA 56 00
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes for v4:
> - Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
>   introducing a dependency on I2C_CONFIG. This error is reported
>   by kernel test on v3 series and usb:usb-testing 20/25 branch.
>   https://lore.kernel.org/all/2024082503-uncoated-chaperone-7f70@gregkh
> 
> Changes for v3:
> - Add comment for UDC suspend sequence.
> - Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES and replace
>   it with literal + comment.
> - Move microchip defines to source file.
> 
> Changes for v2:
> - Move power on reset delay to separate patch.
> - Switch to compatible based check for calling usb5755
>   onboard_dev_5744_i2c_init(). This is done to make
>   onboard_dev_5744_i2c_init() as static.
> - Fix subsystem "usb: misc: onboard_usb_dev:..."
> - Use #define for different register bits instead of magic values.
> - Use err_power_off label name.
> - Modified commit description to be in sync with v2 changes.
> ---
>  drivers/usb/misc/Kconfig           |  2 +-
>  drivers/usb/misc/onboard_usb_dev.c | 73 ++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 50b86d531701..cb5e47d439ab 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
>  
>  config USB_ONBOARD_DEV
>  	tristate "Onboard USB device support"
> -	depends on OF
> +	depends on OF && I2C

This feels wrong.

While a single device that this driver supports might need i2c, not all
of the devices do, so you have the potential to drag in a bunch of code
here for devices that do not have/need i2c at all, right?

Any way to "split this out" into a smaller chunk?  Or better yet, just
detect at runtime if you need/want to call those i2c functions (and they
should have no-ops for when i2c is not enabled, right?)

thanks,

greg k-h


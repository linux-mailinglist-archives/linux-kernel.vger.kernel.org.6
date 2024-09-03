Return-Path: <linux-kernel+bounces-312416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6596969656
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F15D280C34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96D200124;
	Tue,  3 Sep 2024 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SpFixkDZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40A1CE6E9;
	Tue,  3 Sep 2024 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350338; cv=none; b=tWTOka9rEhNucOuc8wxsMLx7v3zamnZeHnPOQGQfvULPO6r/LqCDX9KAOsmZDVu4+QYVp3Bkwu1KTOnO2ZRqPpxHmJI9umHTdo/5qk4w0DK7erciHNO1EVQbBfKvefki22xSYim5jb18Wx4+F2uV0AlBv0hskeaTeseV/IjX4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350338; c=relaxed/simple;
	bh=6LkGfDukTeDvJyN9XbH2ffD60Em9IOaawF323/6dw84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK/tYCTzYYyli79pGnMKwt/164V6VPn2LSaun5kH2WN1TU8x4BkJ/MaOw/eigAUuDqD/zF6aKuuymW+BMoyb1bnEsudVuWlb75GpfZN8Qf+NoAXogznjsy1KWDhObzuc4RWeot1E4R5+9cHhj7BQag3ggtx9r7KcA8u0sizLOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SpFixkDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA02C4CEC5;
	Tue,  3 Sep 2024 07:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725350337;
	bh=6LkGfDukTeDvJyN9XbH2ffD60Em9IOaawF323/6dw84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpFixkDZxdJRAdBVupoPVU/fTgXmTqbobfDcPQwDivoS0WWeWPovDxQUaV056XWQc
	 +rNV00OspwNiNgrDJFeDZPnPd9ZbYSNuxQ8rmmlN3zoj1wBHSBWfqTVvHkzhxaWh/+
	 +rBlPj/O9o01j7dvxdDBK75wBVTqyI/fuxnHqDqE=
Date: Tue, 3 Sep 2024 09:58:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "mka@chromium.org" <mka@chromium.org>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"wentong.wu@intel.com" <wentong.wu@intel.com>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"stefan.eichenberger@toradex.com" <stefan.eichenberger@toradex.com>,
	"francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"macpaul.lin@mediatek.com" <macpaul.lin@mediatek.com>,
	"frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Message-ID: <2024090324-phonics-angler-64c2@gregkh>
References: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1725192519-3867920-3-git-send-email-radhey.shyam.pandey@amd.com>
 <2024090312-stool-ergonomic-f2fe@gregkh>
 <MN0PR12MB5953AD101E185462A6CC61BBB7932@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB5953AD101E185462A6CC61BBB7932@MN0PR12MB5953.namprd12.prod.outlook.com>

On Tue, Sep 03, 2024 at 07:19:09AM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, September 3, 2024 12:10 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Cc: mka@chromium.org; sakari.ailus@linux.intel.com;
> > wentong.wu@intel.com; javier.carrasco@wolfvision.net;
> > stefan.eichenberger@toradex.com; francesco.dolcini@toradex.com;
> > jbrunet@baylibre.com; macpaul.lin@mediatek.com;
> > frieder.schrempf@kontron.de; linux-usb@vger.kernel.org; linux-
> > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip
> > usb5744 SMBus programming support
> > 
> > On Sun, Sep 01, 2024 at 05:38:39PM +0530, Radhey Shyam Pandey wrote:
> > > usb5744 supports SMBus Configuration and it may be configured via the
> > > SMBus slave interface during the hub start-up configuration stage.
> > >
> > > To program it driver uses i2c-bus phandle (added in commit '02be19e914b8
> > > dt-bindings: usb: Add support for Microchip usb5744 hub controller') to
> > > get i2c client device and then based on usb5744 compatible check calls
> > > usb5744 i2c default initialization sequence.
> > >
> > > Apart from the USB command attach, prevent the hub from suspend.
> > > when the USB Attach with SMBus (0xAA56) command is issued to the hub,
> > > the hub is getting enumerated and then it puts in a suspend mode.
> > > This causes the hub to NAK any SMBus access made by the SMBus Master
> > > during this period and not able to see the hub's slave address while
> > > running the "i2c probe" command.
> > >
> > > Prevent the MCU from putting the HUB in suspend mode through register
> > > write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2
> > > register at address 0x411D controls this aspect of the hub. The
> > > BYPASS_UDC_SUSPEND bit in register 0x411Dh must be set to ensure that
> > the
> > > MCU is always enabled and ready to respond to SMBus runtime
> > commands.
> > > This register needs to be written before the USB attach command is issued.
> > >
> > > The byte sequence is as follows:
> > > Slave addr: 0x2d           00 00 05 00 01 41 1D 08
> > > Slave addr: 0x2d           99 37 00
> > > Slave addr: 0x2d           AA 56 00
> > >
> > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > > ---
> > > Changes for v4:
> > > - Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
> > >   introducing a dependency on I2C_CONFIG. This error is reported
> > >   by kernel test on v3 series and usb:usb-testing 20/25 branch.
> > >   https://lore.kernel.org/all/2024082503-uncoated-chaperone-
> > 7f70@gregkh
> > >
> > > Changes for v3:
> > > - Add comment for UDC suspend sequence.
> > > - Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES and
> > replace
> > >   it with literal + comment.
> > > - Move microchip defines to source file.
> > >
> > > Changes for v2:
> > > - Move power on reset delay to separate patch.
> > > - Switch to compatible based check for calling usb5755
> > >   onboard_dev_5744_i2c_init(). This is done to make
> > >   onboard_dev_5744_i2c_init() as static.
> > > - Fix subsystem "usb: misc: onboard_usb_dev:..."
> > > - Use #define for different register bits instead of magic values.
> > > - Use err_power_off label name.
> > > - Modified commit description to be in sync with v2 changes.
> > > ---
> > >  drivers/usb/misc/Kconfig           |  2 +-
> > >  drivers/usb/misc/onboard_usb_dev.c | 73
> > ++++++++++++++++++++++++++++++
> > >  2 files changed, 74 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > > index 50b86d531701..cb5e47d439ab 100644
> > > --- a/drivers/usb/misc/Kconfig
> > > +++ b/drivers/usb/misc/Kconfig
> > > @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
> > >
> > >  config USB_ONBOARD_DEV
> > >  	tristate "Onboard USB device support"
> > > -	depends on OF
> > > +	depends on OF && I2C
> > 
> > This feels wrong.
> > 
> > While a single device that this driver supports might need i2c, not all
> > of the devices do, so you have the potential to drag in a bunch of code
> > here for devices that do not have/need i2c at all, right?
> > 
> > Any way to "split this out" into a smaller chunk?  Or better yet, just
> > detect at runtime if you need/want to call those i2c functions (and they
> > should have no-ops for when i2c is not enabled, right?)
> 
> In onboard driver I am calling onboard_dev_5744_i2c_init() by
> detecting at runtime if "i2c-bus" phandle is present. But the 
> problem is i2c_smbus_* APIs are declared and defined only for 
> #if IS_ENABLED(CONFIG_I2C).
> 
> Do you think we should implement no-ops for I2C smbus APIs
> (in linux/i2c.h)? OR a simpler alternative would be to
> add #if IS_ENABLED(CONFIG_I2C) check in the onboard_*_i2c_init()
> and return error code if CONFIG_I2C is not defined ? 
> Did a grep on #if IS_ENABLED(CONFIG_I2C) and find couple of 
> drivers using this approach.

Yes, try doing this with simpler way first and see what that looks like.

thanks,

greg k-h


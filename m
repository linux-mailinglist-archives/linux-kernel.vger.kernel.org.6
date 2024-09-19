Return-Path: <linux-kernel+bounces-333389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E997C7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AAAB22EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220A19B5A5;
	Thu, 19 Sep 2024 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b="R0MmtBmx"
Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273C199E93;
	Thu, 19 Sep 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740754; cv=pass; b=Aq36nlRqjKWwf1jH0TwoN5fjP5mvTbCpuPQIBRGftduITdkbFA6ZopdJQWoukVk+P1AxE5WnY6mfzE7L6Hv2Wbb40DH2Ph/k0Xq/II4Bp+ZCmYngghHZoynUfhxVzdp9OmGjFR+EucIjyPj5h0Zl/7WrTh+LX+d+FNlVOD1Q82E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740754; c=relaxed/simple;
	bh=9toxh2QugKeZQNHG1W/nM5ymUyMfx7tQmikOfUvG+Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmhlTLO1qgvBRyUTxGtSOVF0Jyic6nTVOfRYjHAKeOIGukxqXwfLpU3ktwNMg6790Ofuh1MBK9CPJZz7tnbmK5vCywB6zlFWnQ87xp3KoeCSEgQeLiKsOZ0rsU/s0oF0LA+hWYGvImYjr4bM5O3lmkvP+UJMJocCkReNs1WIxjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net; spf=pass smtp.mailfrom=kaehlcke.net; dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b=R0MmtBmx; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B75AB507944;
	Thu, 19 Sep 2024 10:12:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a280.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4BEF6507914;
	Thu, 19 Sep 2024 10:12:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1726740750; a=rsa-sha256;
	cv=none;
	b=go5DNKDdZdCq24Z1bU/sjNxroATr/IjTYXeuXBVvOu6c4LMqVEQfzT4BmyKxdlj0ynit8J
	pWaf+KwX6dY47k5HxZDXaeXNAbLjwMHRkSUImiZn4OepCDNmfBFAMixQIv8+uCzbEA8g5Z
	E554HjBmyh1uIPwIFyfXWLsNhPpup5XWXNcYFnaW1ZV2uaAp4hHeJH2CC9UcD+G7kv3wrI
	kfSE/hYZ+pqj4UfIOii0ClopfVhMSreYAl17iljLrW1fFR/nZXlKu7xeDQ0yVm8c7Zvf1X
	J6zjCm8HQ3Ca+fKj6DHxtd0UszgKDFTip5yhB3GPnWrDAdPwXDkBxBegczYalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1726740750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nhl3N5PZbkc1mh3ZRvOT4Ai3aK5Mz0r510ySNMfKxpQ=;
	b=a1FHoK3hNKLln+zvYnRCpT27fhoDp4u4dACLKg2G64LDh9/V/RSYBImN9aWOEHxnkNHbkA
	ISXIzbXDqfJrmpeCC4TawUKRO/eyTn3ucsJQHOKp9EjoHm/YcC3HV7Tpqw03B0WMWAkBjm
	JfTz331/zP/s+/pYSVWV7/emr+o4dAPuGnKvVFh7fWHiyrlAyl/FarHuAAyJ/Ue3Xs1OVi
	to+QjPmqajls/yUCglOVb6RmDFLSB7wV5p2WUfJRlDZ3DWpxGoODeHW5se7H3vmXxOgvIz
	D2x5h8ApLMMd3QoDMgiRzYuC5wgoh8NRkmQNt3lFCv0v5uBNr7pcIaYWsLr5PQ==
ARC-Authentication-Results: i=1;
	rspamd-b5ccff48b-7smdh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=matthias@kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matthias@kaehlcke.net
X-MailChannels-Auth-Id: dreamhost
X-Army-Befitting: 5f4b2a004af54268_1726740750654_733918822
X-MC-Loop-Signature: 1726740750654:3827263465
X-MC-Ingress-Time: 1726740750653
Received: from pdx1-sub0-mail-a280.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.77.248 (trex/7.0.2);
	Thu, 19 Sep 2024 10:12:30 +0000
Received: from curie.home (unknown [86.127.233.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: matthias@kaehlcke.net)
	by pdx1-sub0-mail-a280.dreamhost.com (Postfix) with ESMTPSA id 4X8WXs62qCzCv;
	Thu, 19 Sep 2024 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaehlcke.net;
	s=dreamhost; t=1726740750;
	bh=nhl3N5PZbkc1mh3ZRvOT4Ai3aK5Mz0r510ySNMfKxpQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=R0MmtBmxuykLF8zz0C1AEfUrC0ZJqKsCYpWCwd3XyWMU/+PHMEtN4zh62mKf5Wb4o
	 JffVGNqJqxzvs8o2lebtbwStKudj3zSsAUBL+2u0eQj5189AReiqEGot27GXoo9Xyn
	 Lt15YgWn8HeYpVm8HL9zZggACP2L2ng9JUqIKE2y+AJDEzAB1qyom3mYbJpoLMhdLq
	 TSf07RyuWw2btigDp1cxck1HsiGqS4XFyvoy27CgBdCLLlhuiZTIVtRX06YqQPzbJr
	 Tq9kBBE4xSquPikkGVyrqOzOJYk0C1p0KznGcwkWQM16pUnnILNfi04UkhqDDhYnfY
	 Aey0iEMl7hEpw==
Received: by curie.home (Postfix, from userid 1000)
	id 5F8CB106F6E; Thu, 19 Sep 2024 12:12:26 +0200 (CEST)
Date: Thu, 19 Sep 2024 10:12:26 +0000
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"mka@chromium.org" <mka@chromium.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, 
	"wentong.wu@intel.com" <wentong.wu@intel.com>, 
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>, 
	"stefan.eichenberger@toradex.com" <stefan.eichenberger@toradex.com>, "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>, 
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>, "macpaul.lin@mediatek.com" <macpaul.lin@mediatek.com>, 
	"frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Message-ID: <5ibu7s3ycks6wgchkjvvmf22w3rpx6ngyuiw6aoj5joj672piz@sfardf5qf4a5>
Mail-Followup-To: Matthias Kaehlcke <matthias@kaehlcke.net>, 
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Greg KH <gregkh@linuxfoundation.org>, 
	"mka@chromium.org" <mka@chromium.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, 
	"wentong.wu@intel.com" <wentong.wu@intel.com>, 
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>, 
	"stefan.eichenberger@toradex.com" <stefan.eichenberger@toradex.com>, "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>, 
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>, "macpaul.lin@mediatek.com" <macpaul.lin@mediatek.com>, 
	"frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
References: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1725192519-3867920-3-git-send-email-radhey.shyam.pandey@amd.com>
 <2024090312-stool-ergonomic-f2fe@gregkh>
 <MN0PR12MB5953AD101E185462A6CC61BBB7932@MN0PR12MB5953.namprd12.prod.outlook.com>
 <cnzcqfkqrrs5jv3asmyw54ee2wtztxufariwtj2cjsexuzt7th@fh4htlnlmyae>
 <MN0PR12MB5953A5341E4E17A08FABCEFDB7622@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB5953A5341E4E17A08FABCEFDB7622@MN0PR12MB5953.namprd12.prod.outlook.com>

El Wed, Sep 18, 2024 at 07:22:42PM GMT Pandey, Radhey Shyam ha dit:

> > -----Original Message-----
> > From: Matthias Kaehlcke <matthias@kaehlcke.net>
> > Sent: Wednesday, September 18, 2024 10:37 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Cc: Greg KH <gregkh@linuxfoundation.org>; mka@chromium.org;
> > sakari.ailus@linux.intel.com; wentong.wu@intel.com;
> > javier.carrasco@wolfvision.net; stefan.eichenberger@toradex.com;
> > francesco.dolcini@toradex.com; jbrunet@baylibre.com; macpaul.lin@mediatek.com;
> > frieder.schrempf@kontron.de; linux-usb@vger.kernel.org; linux-
> > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
> > SMBus programming support
> > 
> > El Tue, Sep 03, 2024 at 07:19:09AM GMT Pandey, Radhey Shyam ha dit:
> > 
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Tuesday, September 3, 2024 12:10 PM
> > > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > > > Cc: mka@chromium.org; sakari.ailus@linux.intel.com;
> > > > wentong.wu@intel.com; javier.carrasco@wolfvision.net;
> > > > stefan.eichenberger@toradex.com; francesco.dolcini@toradex.com;
> > > > jbrunet@baylibre.com; macpaul.lin@mediatek.com;
> > > > frieder.schrempf@kontron.de; linux-usb@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > > > Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add
> > > > Microchip
> > > > usb5744 SMBus programming support
> > > >
> > > > On Sun, Sep 01, 2024 at 05:38:39PM +0530, Radhey Shyam Pandey wrote:
> > > > > usb5744 supports SMBus Configuration and it may be configured via
> > > > > the SMBus slave interface during the hub start-up configuration stage.
> > > > >
> > > > > To program it driver uses i2c-bus phandle (added in commit
> > > > > '02be19e914b8
> > > > > dt-bindings: usb: Add support for Microchip usb5744 hub
> > > > > controller') to get i2c client device and then based on usb5744
> > > > > compatible check calls
> > > > > usb5744 i2c default initialization sequence.
> > > > >
> > > > > Apart from the USB command attach, prevent the hub from suspend.
> > > > > when the USB Attach with SMBus (0xAA56) command is issued to the
> > > > > hub, the hub is getting enumerated and then it puts in a suspend mode.
> > > > > This causes the hub to NAK any SMBus access made by the SMBus
> > > > > Master during this period and not able to see the hub's slave
> > > > > address while running the "i2c probe" command.
> > > > >
> > > > > Prevent the MCU from putting the HUB in suspend mode through
> > > > > register write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the
> > > > > RuntimeFlags2 register at address 0x411D controls this aspect of
> > > > > the hub. The BYPASS_UDC_SUSPEND bit in register 0x411Dh must be
> > > > > set to ensure that
> > > > the
> > > > > MCU is always enabled and ready to respond to SMBus runtime
> > > > commands.
> > > > > This register needs to be written before the USB attach command is issued.
> > > > >
> > > > > The byte sequence is as follows:
> > > > > Slave addr: 0x2d           00 00 05 00 01 41 1D 08
> > > > > Slave addr: 0x2d           99 37 00
> > > > > Slave addr: 0x2d           AA 56 00
> > > > >
> > > > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > > > > ---
> > > > > Changes for v4:
> > > > > - Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
> > > > >   introducing a dependency on I2C_CONFIG. This error is reported
> > > > >   by kernel test on v3 series and usb:usb-testing 20/25 branch.
> > > > >   https://lore.kernel.org/all/2024082503-uncoated-chaperone-
> > > > 7f70@gregkh
> > > > >
> > > > > Changes for v3:
> > > > > - Add comment for UDC suspend sequence.
> > > > > - Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES
> > and
> > > > replace
> > > > >   it with literal + comment.
> > > > > - Move microchip defines to source file.
> > > > >
> > > > > Changes for v2:
> > > > > - Move power on reset delay to separate patch.
> > > > > - Switch to compatible based check for calling usb5755
> > > > >   onboard_dev_5744_i2c_init(). This is done to make
> > > > >   onboard_dev_5744_i2c_init() as static.
> > > > > - Fix subsystem "usb: misc: onboard_usb_dev:..."
> > > > > - Use #define for different register bits instead of magic values.
> > > > > - Use err_power_off label name.
> > > > > - Modified commit description to be in sync with v2 changes.
> > > > > ---
> > > > >  drivers/usb/misc/Kconfig           |  2 +-
> > > > >  drivers/usb/misc/onboard_usb_dev.c | 73
> > > > ++++++++++++++++++++++++++++++
> > > > >  2 files changed, 74 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > > > > index 50b86d531701..cb5e47d439ab 100644
> > > > > --- a/drivers/usb/misc/Kconfig
> > > > > +++ b/drivers/usb/misc/Kconfig
> > > > > @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
> > > > >
> > > > >  config USB_ONBOARD_DEV
> > > > >  	tristate "Onboard USB device support"
> > > > > -	depends on OF
> > > > > +	depends on OF && I2C
> > > >
> > > > This feels wrong.
> > > >
> > > > While a single device that this driver supports might need i2c, not
> > > > all of the devices do, so you have the potential to drag in a bunch
> > > > of code here for devices that do not have/need i2c at all, right?
> > > >
> > > > Any way to "split this out" into a smaller chunk?  Or better yet,
> > > > just detect at runtime if you need/want to call those i2c functions
> > > > (and they should have no-ops for when i2c is not enabled, right?)
> > >
> > > In onboard driver I am calling onboard_dev_5744_i2c_init() by
> > > detecting at runtime if "i2c-bus" phandle is present. But the problem
> > > is i2c_smbus_* APIs are declared and defined only for #if
> > > IS_ENABLED(CONFIG_I2C).
> > >
> > > Do you think we should implement no-ops for I2C smbus APIs (in
> > > linux/i2c.h)? OR a simpler alternative would be to add #if
> > > IS_ENABLED(CONFIG_I2C) check in the onboard_*_i2c_init() and return
> > > error code if CONFIG_I2C is not defined ?
> > > Did a grep on #if IS_ENABLED(CONFIG_I2C) and find couple of drivers
> > > using this approach.
> > 
> > I expect using IS_ENABLED(CONFIG_I2C) would cause issues when
> > USB_ONBOARD_DEV=y and CONFIG_I2C=m.
> > 
> > Another option could be adding an option USB_ONBOARD_DEV_USB5744 (or
> > similar) and make that dependent on CONFIG_I2C.
> 
> Yes, theoretically this can also be valid build configuration.
> 
> I assume your suggestion is something like below:
> 
> +config USB_ONBOARD_DEV_USB5744
> +       tristate "Onboard USB Microchip usb5744 hub with SMBus support"
> +       depends on USB_ONBOARD_DEV && I2C
> +       help
> +         Say Y here if you want to support onboard USB Microchip usb5744
> +         hub that requires SMBus initialization.
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index 560591e02d6a..6169780a18d9 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -311,7 +311,7 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
> 
>  static int onboard_dev_5744_i2c_init(struct i2c_client *client)
>  {
> -#if IS_ENABLED(CONFIG_I2C)
> +#if IS_ENABLED(CONFIG_USB_ONBOARD_DEV_USB5744)
> 
> 
> <*>   Onboard USB device support                                                               
>   <M>     Onboard USB Microchip usb5744 hub with SMBus support

Yes, something along these lines

> Here IS_ENABLED will report true either onboard usb5744 is module/in-built.
>
> So, we hit same issue as USB_ONBOARD_DEV=y and I2C=m.

Right, the problem is that USB_ONBOARD_DEV_USB5744 isn't an actual module,
otherwise Kconfig would prevent it from being builtin when I2C=m.

I think CONFIG_USB_ONBOARD_DEV_USB5744 should be boolean. It should only
be selectable when CONFIG_I2C=y or CONFIG_USB_ONBOARD_DEV=m and
CONFIG_I2C=m. That can be achieved with:

  depends on USB_ONBOARD_DEV && (I2C=y || I2C=USB_ONBOARD_DEV)

or

  depends on (USB_ONBOARD_DEV && I2C=y) || (USB_ONBOARD_DEV=m && I2C=m)

This doesn't look particularly elegant but should do the trick.

> FYI, as this series merged to -next based on our discussion

Ah, thanks for letting me know. Sorry for the delayed reply, I went
through an intercontinental relocation and it took some time to
get things settled.

> I will send another series fixing this particular build configuration and
> other coding style changes based on v4 review comments.

Thanks!


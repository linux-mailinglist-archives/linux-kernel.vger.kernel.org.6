Return-Path: <linux-kernel+bounces-332859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9174497BFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C192D1C217E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D11C9DEF;
	Wed, 18 Sep 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b="PEiTxz0X"
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE2291E;
	Wed, 18 Sep 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681537; cv=pass; b=svgk93PTr9auRhLmX2/2DjBd0bXkAx3uLBIX9h7oV3W1BsA7dUE0XqfHg4pfdyaWSnLho9QC4wcA+Ynk7/Nuov6AGd6VwGpTtKqdhaNaAU/Zxf3YXqnbrNWxYR7MBYZ35QCz77FGONRnbHsC7t0yK1O0WuO5qv9BQnMD+cyFUig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681537; c=relaxed/simple;
	bh=b5l6ketZ83cLc4plyE9bYBnzNNH5qFvL6pSzvIn9MuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXfdXSpCf8DvLCV8NhYx5ZnWaeEcmkod0MsC3zqrBqk5XdZw9aZnhAVqYnH+fdyjkn8yVGYyFkeFWOt3BTe7aqdusUNsGRIXq5DCG5xWGPM/H+3g/rqYzw+bu0BQoyjwzyAfq/oR1GE1jBWaYwigWNw7L95vyf7lxlbQJ2K+a+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net; spf=pass smtp.mailfrom=kaehlcke.net; dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b=PEiTxz0X; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BA2F85C762B;
	Wed, 18 Sep 2024 17:07:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 688935C733F;
	Wed, 18 Sep 2024 17:07:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1726679232; a=rsa-sha256;
	cv=none;
	b=E+S4CZ3WGN3l0B+nE+OesjvE4VSTiqzWlFjbXNTENh64mICytulbRX7CJgS13XMMUi02Kk
	MUr2kx6Fyd4e3wqVns9U4TXlZrMbsuAejhDXAlfhLw0pOE7tFvKcLAtLxzT/mlyDDoMiDF
	w7va4D0v2lFPNtAsBp2vYTSSNu1Uq2+YIAgOKQ8y68skLl+DHsk4qO6s/kiJSrI1Qd3S0f
	SAHRVirqJVtGUadjs0TRubrGa3lKFTeWJeyyXG1oPoy78A488HzM7OK5///Q/KQ2rb9hJN
	3l475WZpEDEQ7fUoafjVxaKbGsu+5ZEGkm8c1hR8c0eOgQzTXMzr0ItcPueZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1726679232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SCzWKLSu2oFNO5v/KqTvrgoKYIqJa4PrpAIYgJi/NZM=;
	b=3MohaWzkmOjJ55L2D7m7XDmCrJTv/LwOfS/AbjOQAianiQSFJ2JK1UTUIAVuP810H7jdWT
	JJ7o4zlxHnoRatACdJ7QP2DfUj5BA1J/1NucmsvtV0PKb4A0Hpx4R6a/2B869Sjlht7dYP
	nO04LJDtQcVP90moVXFqgPew7WCX8oe3CTOqklXr/H0O9UJayeKiW44UaUTXFd23UA4aIW
	85nI0JeaYaqj14FXoTpQ38Lx2529QZIL72pr6qQk+clBYWGVQTGCSotSxbTFl05uP1ekNv
	Dj1rJtQAHmmvKgOrZ5StNzU+LV9iPm06oWmrP4rRfvx0od+nk/CbZPVqpOhSmQ==
ARC-Authentication-Results: i=1;
	rspamd-b5ccff48b-lt2xl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=matthias@kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matthias@kaehlcke.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Zesty: 6f545c8f3c14632f_1726679233529_3418208342
X-MC-Loop-Signature: 1726679233529:3610256479
X-MC-Ingress-Time: 1726679233529
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.150.113 (trex/7.0.2);
	Wed, 18 Sep 2024 17:07:13 +0000
Received: from curie.home (unknown [86.127.233.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: matthias@kaehlcke.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4X84nr0dYgz98;
	Wed, 18 Sep 2024 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaehlcke.net;
	s=dreamhost; t=1726679232;
	bh=SCzWKLSu2oFNO5v/KqTvrgoKYIqJa4PrpAIYgJi/NZM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=PEiTxz0XBXUOdEKpciZMha3KO+b4qrkxaYsH2YOSQlgX4VeKgFtwwKsEs7XCMH8yp
	 9cNYIJtk1x6ZfNhnnHZvXbK+Kiy+EpjtBxeSOuDVJ7LEfR9/1RMTFkuBBAv28sN99z
	 hVfoh0mTGswhwiIkxrx4+gXKS2ct4D7nGu5Yb5HQlk83AiL2xrjZi6NvWhXUoZG4XA
	 q9KWrHM2vRViiT9sbG6k2mw9IyHZ2JaaEo2AC2vcpYiDdvFbqv6BVGYV6xgiuqcczq
	 +b8vUGDi7NWH7XobinI5C5b0TfThY31VLC4YxQl2iy0wAFR0kqQR6WcWTZwMDOaUY0
	 FJfHjSfHqdDlQ==
Received: by curie.home (Postfix, from userid 1000)
	id AEA6B10559A; Wed, 18 Sep 2024 19:07:08 +0200 (CEST)
Date: Wed, 18 Sep 2024 17:07:08 +0000
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
Message-ID: <cnzcqfkqrrs5jv3asmyw54ee2wtztxufariwtj2cjsexuzt7th@fh4htlnlmyae>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB5953AD101E185462A6CC61BBB7932@MN0PR12MB5953.namprd12.prod.outlook.com>

El Tue, Sep 03, 2024 at 07:19:09AM GMT Pandey, Radhey Shyam ha dit:

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

I expect using IS_ENABLED(CONFIG_I2C) would cause issues when
USB_ONBOARD_DEV=y and CONFIG_I2C=m.

Another option could be adding an option USB_ONBOARD_DEV_USB5744
(or similar) and make that dependent on CONFIG_I2C.


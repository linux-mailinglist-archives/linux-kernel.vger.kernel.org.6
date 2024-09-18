Return-Path: <linux-kernel+bounces-332867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8197C00A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FB52833F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044461C9EDC;
	Wed, 18 Sep 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b="m0tipB0T"
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FC1C986B;
	Wed, 18 Sep 2024 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683543; cv=pass; b=sFOaBqGOko5Q5C17eIf3avll8vYqZOyyGdU4oifF/Py3PXYaPOCocEXwVqb89gq9WFUTv6DEf+esBurYQ65SuHUFpdwn/9japmGRIOV5q8gxEiLV+jK+lfBFRSRDI6kka15dwkJz7sNPl7KVZRUqOEXrFcRVnuuMzLaYTZyk5T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683543; c=relaxed/simple;
	bh=SoNEih3EMtBpHrbsz8wgnuznWGc1Q0LH/YV5Z9yIGv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0252DeRwyE9og8L+ccQPkDzcgAykFCJbRwd7cCtZqkh+Cuv2oO+SHbfcN7fXdEzA4aRdhzAJD2Ud+JFzkPL4MTvkMmI4xN1DbRsVyg+avKyPfK3c6VwDE4e5InUbYju1zMgsAePZ3BTVwCbiHJ3xBGexjSh1+R+yejzXwW3YB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net; spf=pass smtp.mailfrom=kaehlcke.net; dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b=m0tipB0T; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 00067903206;
	Wed, 18 Sep 2024 17:39:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (100-99-68-57.trex-nlb.outbound.svc.cluster.local [100.99.68.57])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 89986903340;
	Wed, 18 Sep 2024 17:39:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1726681181; a=rsa-sha256;
	cv=none;
	b=nQgLQpBKsNLf4z5SMHHz88Pua2p3hYZTjqFyBjZQKYaI2nJTgOdQUDSCCx/Pf1tj/z0fY/
	d+4TaNgpp1vxsDel54cNsw4BL9M1Ro/69qfPorON93gH4CK2ctecwIwXrUR2LrG6rej7Gi
	4jvrKz8DP+njrHtblbtYlxzEGj+yxCjtRkDd6+VnY9SJPA0BOdukIWHIk5UESnLvq1ET+N
	NZphJIaauhwqwXW6cvGzBXdECE2MxzUqTSvwcw5i32V8VhS3alAqU0aawSBJPHqpUX5MUp
	o6gbxA/cjAKRWbVNqefWctQH2fA2RTBzWAxEHZFF4RxAuFgVGcmyj5XKFCrQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1726681181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FRmVjepWEas5w+yD6pYUkxBUTagjEWAe1L+pdXUbYVQ=;
	b=jZTNkMchGwC2TjoLDAh4PojOzSeSRb99SDgl1337hUlpZwzvWyW197JJHXPalsektEKMLQ
	mYK/CmJ0y+0Z+LWDi99bC9NrAOiExt1X+R43sg47n6MfQdURbpJg+49K39bqC+a6LzRWov
	69gq8+8p9xbOts3LT7UaCeQm60KxFPDAgu3oBCbuJ0vtBrFXBFhYhMSaPAQt/7OgvMLgO9
	uQZeNacYh/K8ToHyIiy4bzO8tCViBBVN5VnX1bQjZNr0J++APq8/4Pf4KMaJ66d761wrFe
	SM6OxPQvo6HCduIP3lWu7fQduloWit53tXkRDaflYG8IkYwyjDFBvdvntPdbgw==
ARC-Authentication-Results: i=1;
	rspamd-5b46bcd97f-2pssd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=matthias@kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matthias@kaehlcke.net
X-MailChannels-Auth-Id: dreamhost
X-Broad-Vacuous: 33aed79b17850533_1726681181880_2520722122
X-MC-Loop-Signature: 1726681181880:2892786580
X-MC-Ingress-Time: 1726681181880
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.68.57 (trex/7.0.2);
	Wed, 18 Sep 2024 17:39:41 +0000
Received: from curie.home (unknown [86.127.233.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: matthias@kaehlcke.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4X85WK19x3z98;
	Wed, 18 Sep 2024 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaehlcke.net;
	s=dreamhost; t=1726681181;
	bh=FRmVjepWEas5w+yD6pYUkxBUTagjEWAe1L+pdXUbYVQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=m0tipB0TlEG7DXxSmjwETwK/Bp/DFAiQYP7WCm0PjdgSrPTR3ceW20chhCGE1RSQp
	 uYgRFdd5dSAhBi+/4obyX4FGtguO5wJ68TOU+t2zEH90RQjYZzqOeg17zNyrqLRfXV
	 55oGs63XCH08r23uyOi35ylu+6FkLRG53UPWMdOnf/Axpaudk2AQsI/+xTpj/jj1dm
	 knkWeEDfGPlbSrvGmHJvF762M54sztCscyx2wmSacS8I5YT0PtNhnuVPrYeHtPi8gv
	 EyQBzDJe3TQySFpE6DEsi42160c0uLZ/Any9NXE6jaGDForzyWuYZGaGr4yY5X7HyK
	 FEMX6PYSfx5Ww==
Received: by curie.home (Postfix, from userid 1000)
	id 693FD105D9E; Wed, 18 Sep 2024 19:39:37 +0200 (CEST)
Date: Wed, 18 Sep 2024 17:39:37 +0000
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, mka@chromium.org, 
	sakari.ailus@linux.intel.com, wentong.wu@intel.com, javier.carrasco@wolfvision.net, 
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com, jbrunet@baylibre.com, 
	macpaul.lin@mediatek.com, frieder.schrempf@kontron.de, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Message-ID: <fuqswrm4wzqnf7x2ybcxbyo723cv2fyk2hqmyhplcmkzc62h74@iubwb27kg3k2>
Mail-Followup-To: Matthias Kaehlcke <matthias@kaehlcke.net>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, gregkh@linuxfoundation.org, mka@chromium.org, 
	sakari.ailus@linux.intel.com, wentong.wu@intel.com, javier.carrasco@wolfvision.net, 
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com, jbrunet@baylibre.com, 
	macpaul.lin@mediatek.com, frieder.schrempf@kontron.de, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, git@amd.com
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

El Sun, Sep 01, 2024 at 05:38:39PM GMT Radhey Shyam Pandey ha dit:

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
>  	help
>  	  Say Y here if you want to support discrete onboard USB devices
>  	  that don't require an additional control bus for initialization,
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index da27c48fc11d..247600015bca 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -11,6 +11,7 @@
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/init.h>
> +#include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -29,6 +30,17 @@
>  
>  #include "onboard_usb_dev.h"
>  
> +/* USB5744 register offset and mask */
> +#define USB5744_CMD_ATTACH			0xAA
> +#define USB5744_CMD_ATTACH_LSB			0x56
> +#define USB5744_CMD_CREG_ACCESS			0x99
> +#define USB5744_CMD_CREG_ACCESS_LSB		0x37
> +#define USB5744_CREG_MEM_ADDR			0x00
> +#define USB5744_CREG_WRITE			0x00
> +#define USB5744_CREG_RUNTIMEFLAGS2		0x41
> +#define USB5744_CREG_RUNTIMEFLAGS2_LSB		0x1D
> +#define USB5744_CREG_BYPASS_UDC_SUSPEND		BIT(3)
> +
>  static void onboard_dev_attach_usb_driver(struct work_struct *work);
>  
>  static struct usb_device_driver onboard_dev_usbdev_driver;
> @@ -297,10 +309,46 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
>  		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
>  }
>  
> +static int onboard_dev_5744_i2c_init(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	/*
> +	 * Set BYPASS_UDC_SUSPEND bit to ensure MCU is always enabled
> +	 * and ready to respond to SMBus runtime commands.
> +	 * The command writes 5 bytes to memory and single data byte in

nit: s/in/to the/

> +	 * configuration register.
> +	 */
> +	char wr_buf[7] = {USB5744_CREG_MEM_ADDR, 5,
> +			  USB5744_CREG_WRITE, 1,
> +			  USB5744_CREG_RUNTIMEFLAGS2,
> +			  USB5744_CREG_RUNTIMEFLAGS2_LSB,
> +			  USB5744_CREG_BYPASS_UDC_SUSPEND};
> +
> +	ret = i2c_smbus_write_block_data(client, 0, sizeof(wr_buf), wr_buf);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
> +
> +	ret = i2c_smbus_write_word_data(client, USB5744_CMD_CREG_ACCESS,
> +					USB5744_CMD_CREG_ACCESS_LSB);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Configuration Register Access Command failed\n");

nit: s/Command/command/

Uppercase for the register name is ok, but command isn't a name.

> +
> +	/* Send SMBus command to boot hub. */

nit: from the code it's obvious that an SMBus command is sent,
no need to spell that out. I suggest to change the comment to
"Attach/boot the hub".

> +	ret = i2c_smbus_write_word_data(client, USB5744_CMD_ATTACH,
> +					USB5744_CMD_ATTACH_LSB);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "USB Attach with SMBus command failed\n");

nit: s/.../USB Attach command failed/

> +
> +	return ret;

    return 0;

> +}


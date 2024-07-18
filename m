Return-Path: <linux-kernel+bounces-256796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025E937054
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820121F228AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A3146593;
	Thu, 18 Jul 2024 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UTAhKufj"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E05145B1F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339842; cv=none; b=e1NqQwFj8QMasYyy+USEvRhWILVlvt8Xeej4Dbs4Sy/TiQl068vCsn3/xyu9Rz/Bz1zSoP5A3ANvos/Ly2icxwoPDcMr82+tAuT8/raRx7JwrFuvZ2BH5hyI4gD6IwKT38dJe8ToiSWFuTCpbcwmc9mDB4upi99ePIG+k8B4xZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339842; c=relaxed/simple;
	bh=VkQpN60GcRBqBD4ybwlP2k2+Vn+Caes8BT6nK9Loess=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1wrg0mhUrpt8jzsqafaDhwFOZatfJHDTc9fRUUFa7SVFqsrMnJd5RZyeap7NZPBaiXVx6w+Ol0i67wsIErVk+eGnveYefTns1f+NJnksXYAS3kIi+eW5lV+MQp1HPNw6vXQsgyEPSnf0dLKSCYGgeiFEIeJCUZNMqloWVMbVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UTAhKufj; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-80a2939265cso40596539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721339838; x=1721944638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESReBtfRYbWAFdqZsiENsIRpb4yAg4v5BmBq8aEhHNc=;
        b=UTAhKufjD+aRC1s/ocxQSEPt7eBXf8t/e2UViV1fFYkJDNe8SJlX9RHjRTxuIJZkuD
         /jjXRXGrW2B06pklbGUQu4e5Gz21wUB0BFIvlNTxhnrVGpYt712Sce6E011lNeqMCQKw
         XcWvEDf4wlCx28udFqR/xyclg/HSvV3U/+1og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339838; x=1721944638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESReBtfRYbWAFdqZsiENsIRpb4yAg4v5BmBq8aEhHNc=;
        b=Ih399Tm8JCglPZes3n/q3TZ3tnRt0qMbaU7MNZ2T+1xguTSUvilRt7XwC1CSPuPggF
         m+2CTx9ivJ/UafmKXXqZ4q82xSJ3c8ArY5fiLTRT/Dx+hBArF4RvXjD2OIWjYCG7ilD1
         Hjr2mJ+iW5/AzzGyVu0X6PmvQQwRMHBdSiMv5VJnMx5iJ6a6Y6a48TOm8/LCaGnPf8fo
         mJQaRaGx6iXIbhbZ0DCyrwWKoZ17TYlpEUqAkrvmjUcFjZV/zvvsmvVtPqBtSG6xcXsU
         H4bh3xKOH/Oqwl54DcxJT9I4/Th/pxvtSt2Fg2iTku0D2k5tT/0KV4gUU7zZEKsYzcKh
         rU9A==
X-Forwarded-Encrypted: i=1; AJvYcCW/bUI3JHB6KsWuBHXNiHDt29ICFvSOAmkqLBMWurOszCBYqCvjsYu5HnNQOq5rtCCCcF5Wz0oTZX5sC9/u68IkvtYjrzXaIE+GFrwp
X-Gm-Message-State: AOJu0Yxe6mvhjMEWMWHaAFpNaeBgnjHAWor4eGsnA2WlFvlqVzzw2Eyg
	e+DcRjrkZEr4fq0NUcij48+aEWu5MJalCbPL5yCXrIFArqsCfE5gVPrv6a7crw==
X-Google-Smtp-Source: AGHT+IEAXH4Y2cTf5yDjSgxvPlXvU2z3xqhyqDWVlhaZnNGznQBBP9bqXzFNgQppD3BxzBsvfarEwg==
X-Received: by 2002:a05:6602:6422:b0:7f6:76f2:e359 with SMTP id ca18e2360f4ac-81710040e70mr906632339f.4.1721339838507;
        Thu, 18 Jul 2024 14:57:18 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-4c2342bf50asm40510173.5.2024.07.18.14.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 14:57:18 -0700 (PDT)
Date: Thu, 18 Jul 2024 21:57:17 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco@wolfvision.net,
	benjamin.bara@skidata.com, macpaul.lin@mediatek.com,
	linux.amoon@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v2 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Message-ID: <ZpmPvaknDw2cGnOQ@google.com>
References: <1721244223-3194869-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1721244223-3194869-3-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1721244223-3194869-3-git-send-email-radhey.shyam.pandey@amd.com>

Hi,

On Thu, Jul 18, 2024 at 12:53:43AM +0530, Radhey Shyam Pandey wrote:
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
> Prevent the MCU from the putting the HUB in suspend mode through
> register write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2
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
>  drivers/usb/misc/onboard_usb_dev.c | 56 ++++++++++++++++++++++++++++++
>  drivers/usb/misc/onboard_usb_dev.h | 12 +++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index 94d5424841fd..4f3845f35ac4 100644
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
> @@ -297,10 +298,40 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
>  		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
>  }
>  
> +static int onboard_dev_5744_i2c_init(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	int ret;
> +

Please explain what the purpose of this sequence is. It is described
in the commit message, however that is not directly available to a
reader of the code.

> +	char wr_buf[7] = {USB5744_CREG_MEM_ADDR, USB5744_CREG_MEM_NBYTES,

IIUC USB5744_CREG_MEM_NBYTES is the number of registers written to the
configuration register by this specific command, it could be different
for other commands. If that is correct then I think this shouldn't be
a constant but a literal plus a comment.

> +			  USB5744_CREG_WRITE, USB5744_CREG_NBYTES,

Similar as above, USB5744_CREG_NBYTES should be a literal + comment, or
alternatively something like USB5744_CREG_SIZE, assuming the width of
all registers is one byte.

It would also be an option to add a wrapper onboard_dev_5744_write_creg(),
that encapsulates writing a configuration register. Not strictly need
since currently only one register is written.

> +			  USB5744_CREG_RUNTIMEFLAGS2,
> +			  USB5744_CREG_RUNTIMEFLAGS2_LSB,
> +			  USB5744_CREG_BYPASS_UDC_SUSPEND};
> +
> +	ret = i2c_smbus_write_block_data(client, 0, sizeof(wr_buf), wr_buf);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
> +
> +	ret = i2c_smbus_write_word_data(client, USB5744_CREG_ACCESS,
> +					USB5744_CREG_ACCESS_LSB);

This is a command ("Configuration Register Access command", this should be
reflected in the name, as for USB5744_CMD_ATTACH.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Configuration Register Access Command failed\n");
> +
> +	/* Send SMBus command to boot hub. */
> +	ret = i2c_smbus_write_word_data(client, USB5744_CMD_ATTACH,
> +					USB5744_CMD_ATTACH_LSB);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "USB Attach with SMBus command failed\n");
> +
> +	return ret;

	return 0;
> +}
> +
>  static int onboard_dev_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct onboard_dev *onboard_dev;	
> +	struct device_node *i2c_node;
>  	int err;
>  
>  	onboard_dev = devm_kzalloc(dev, sizeof(*onboard_dev), GFP_KERNEL);
> @@ -340,6 +371,27 @@ static int onboard_dev_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	i2c_node = of_parse_phandle(pdev->dev.of_node, "i2c-bus", 0);
> +	if (i2c_node) {
> +		struct i2c_client *client;
> +
> +		client = of_find_i2c_device_by_node(i2c_node);
> +		of_node_put(i2c_node);
> +
> +		if (!client) {
> +			err = -EPROBE_DEFER;
> +			goto err_power_off;
> +		}
> +
> +		if (of_device_is_compatible(pdev->dev.of_node, "usb424,2744") ||
> +		    of_device_is_compatible(pdev->dev.of_node, "usb424,5744"))
> +			err = onboard_dev_5744_i2c_init(client);
> +
> +		put_device(&client->dev);
> +		if (err < 0)
> +			goto err_power_off;
> +	}
> +
>  	/*
>  	 * The USB driver might have been detached from the USB devices by
>  	 * onboard_dev_remove() (e.g. through an 'unbind' by userspace),
> @@ -351,6 +403,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
>  	schedule_work(&attach_usb_driver_work);
>  
>  	return 0;
> +
> +err_power_off:
> +	onboard_dev_power_off(onboard_dev);
> +	return err;
>  }
>  
>  static void onboard_dev_remove(struct platform_device *pdev)
> diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
> index 82c76a0b3346..5744c589b90f 100644
> --- a/drivers/usb/misc/onboard_usb_dev.h
> +++ b/drivers/usb/misc/onboard_usb_dev.h
> @@ -8,6 +8,18 @@
>  
>  #define MAX_SUPPLIES 2
>  
> +#define USB5744_CMD_ATTACH			0xAA
> +#define USB5744_CMD_ATTACH_LSB			0x56
> +#define USB5744_CREG_ACCESS			0x99
> +#define USB5744_CREG_ACCESS_LSB			0x37
> +#define USB5744_CREG_MEM_ADDR			0x00
> +#define USB5744_CREG_MEM_NBYTES			0x05
> +#define USB5744_CREG_WRITE			0x00
> +#define USB5744_CREG_NBYTES			0x01
> +#define USB5744_CREG_RUNTIMEFLAGS2		0x41
> +#define USB5744_CREG_RUNTIMEFLAGS2_LSB		0x1D
> +#define USB5744_CREG_BYPASS_UDC_SUSPEND		BIT(3)
> +

These defines are specific to the Microchip 5744 hub, there is no need
for them to be defined in the include of the onboard_usb_dev driver.
Please move them to the .c file

Thanks

Matthias


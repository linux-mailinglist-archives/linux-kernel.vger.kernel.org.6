Return-Path: <linux-kernel+bounces-376552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339ED9AB32F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19332851DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A11A1A2C04;
	Tue, 22 Oct 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Zl++sZGc"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C11BDAA1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612801; cv=none; b=t+liBLjGdzsMcGQEo0L10nFfqna5+bIw92abfoedlkMVaF16rYJfQ8I7hYDXgmO0l70toFfwohPZqUVrPZDMG1Cov48Gn2jXDlFhREewMWdhJem33G4It8bCP9qRygVkEEdqUy8ju1/ZXNHJXR9rYY7a4HqymOUmUGXxrEKdB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612801; c=relaxed/simple;
	bh=Y/LX8W9dqrr6ALxZ8wGr5EDNPV1IjW1SCOSfcQnQQtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilj/UbUtqtEk+AHtYca3huvhdLZ6X6JPqA3fjpqOtUBPuW5t071f+cSl68yDywedTD1C+NqzrvOLHycj/HNU9sY2d5xzyN6K6CypJUH+X3Xgk+2RB3rfHo90PiW86axOvLM9mq4Qm18rSLxEv94kXt2i+F2Fp4QjohUrf4IZzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Zl++sZGc; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a47c20b162so1557978137.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1729612798; x=1730217598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJnNbaojXN4c6BbsBJATwMXWi0Si+n6hGv93cDOPn88=;
        b=Zl++sZGc5TMYLcfzlIxpz5ouqF9usNMwCNTLVbm3Zt0hjeaLe5V2QbIkUndMQW3Yy6
         2tPQGzOKvwZ2M9jKYHa5dSLQsMg/VUuNbwacWArUC8CD6AbR8N7kiY9MZtTXTDl8Gfgb
         ZQlLooFyWWSPqCxO05DvFizqeEMCZBBB47xIN+r2QraOaCB6CZxm7X4HU3mMAtXcd4CN
         /VT9tOEwnpPbz56m0rOW0t3mY4ZcDH7FzrIG4TvxoQeyC2J+DVP6p9OFH7l2D7F0s6bZ
         T7iwQvRBr8xPg6bWPxJ0WOBZPxj0TsWPZypMEActggkK08uUOB6lhZrtYBD7sNIh7eLl
         VUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612798; x=1730217598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJnNbaojXN4c6BbsBJATwMXWi0Si+n6hGv93cDOPn88=;
        b=phuHrStVlc/LE+379Dg2YaQeiUAIHQoeeiWFPlkkuwdujjmxE89iJVR8roGuioXYDI
         mCYw3VkXSER/QKRax5dF4Qdi2zIuvpDczaKxRTq8XM0sCNj6GUOCGJmGDTItEj8UwWbY
         9OylRKGP7eILrEeCQktThydRO5VZJQ+imX0aGweuLT0I2XeQ8Ae0dTXWUMCb5luoFwj4
         //88V3zuCtiIfx+Rrhu6T9PiHmOOg3PwwlMQcpBMP52K6uZNTLYfKuDq4v/RcAiPSRmk
         skDWs26Zuvdf9Z2GfRClWUK7sqslj5NhoP65dw/IgOUByzsXAclu+QcuVa8rIeWgzUQX
         o2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm24/0XlYbfQ23h135Y2oTFhpga8EnCnNx5fnDoq+PvcSi84WpmQ+ZAz1p9n+ivzoPx/BMjzpEv3LiAP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyuou+4NsHzafFKwdvbrMCjUWdoyI/jPXj9yAFcyJI+bayzPK8
	ywg7rAtj0ejAeHqQnLzZWqEVwQy6zOWMf/3MfJ7D92oQpJBzBgLRtOspiot++A==
X-Google-Smtp-Source: AGHT+IHz/1R5EH1N0X+mlRH1neLqyF7ZpErCrujYzG9Gm9PrcwwIZC6JljjI4sApXWeBIzcjrW5OWQ==
X-Received: by 2002:a05:6102:3710:b0:4a4:6ec4:7d31 with SMTP id ada2fe7eead31-4a5d6bb234cmr13851852137.20.1729612797824;
        Tue, 22 Oct 2024 08:59:57 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::35fc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c7248fsm30729551cf.36.2024.10.22.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:59:57 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:59:54 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: huanglei814 <huanglei814@163.com>
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: Re: [PATCH v3] usb: core: adds support for PM control of specific
 USB dev skip suspend.
Message-ID: <bcd902e0-3744-47f6-9d19-3d712ba3fece@rowland.harvard.edu>
References: <20241022090905.9806-1-huanglei814@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022090905.9806-1-huanglei814@163.com>

On Tue, Oct 22, 2024 at 05:09:05PM +0800, huanglei814 wrote:
> From: huanglei <huanglei@kylinos.cn>
> 
> All USB devices are brought into suspend power state after system suspend.
> It is desirable for some specific manufacturers buses to keep their devices
> in normal state even after system suspend.

Why is it desirable for devices on these buses to remain at full power 
during system suspend?

What about wakeup requests?  If the device isn't suspended, it won't be 
able to send a wakeup request if it needs to tell the system to return 
to full power.

What about runtime suspend?  Are the devices on these buses supposed to 
remain at full power all the time, or only during system suspend?

> v2: Change to bool type for skip_suspend.
> v3: Rebase and update commit message.
> 
> Signed-off-by: huanglei <huanglei@kylinos.cn>
> ---
>  drivers/usb/core/Kconfig     | 11 +++++++++++
>  drivers/usb/core/driver.c    | 14 ++++++++++++++
>  drivers/usb/host/xhci-plat.c |  7 +++++++
>  include/linux/usb.h          |  9 +++++++++
>  4 files changed, 41 insertions(+)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index 58e3ca7e4793..69778aa7b913 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -143,3 +143,14 @@ config USB_DEFAULT_AUTHORIZATION_MODE
>  	  ACPI selecting value 2 is analogous to selecting value 0.
>  
>  	  If unsure, keep the default value.
> +
> +config USB_SKIP_SUSPEND
> +	bool "Vendor USB support skip suspend"
> +	depends on USB
> +	help
> +	  Select this the associate USB devices will skip suspend when pm control.
> +
> +	  This option adds support skip suspend for PM control of USB devices
> +	  in specific manufacturers platforms.
> +
> +	  If unsure, keep the default value.

Why does this need to be a Kconfig option?  Why can't it be enabled 
all the time?

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 0c3f12daac79..05fe921f8297 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1583,6 +1583,15 @@ int usb_suspend(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int r;
>  
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_SUSPEND)) {
> +		if (udev->state != USB_STATE_SUSPENDED)
> +			dev_err(dev, "abort suspend\n");

You should not use dev_err() because this isn't an error.  It is the 
expected behavior.

Why do you test for PM_EVENT_SUSPEND?  Don't you want the device to 
remain at full power during other sorts of PM events also?

Why do you test udev->state?  Don't you already know that udev is not 
going to be in the SUSPENDED state?

> +
> +		return 0;
> +	}
> +#endif
> +
>  	unbind_no_pm_drivers_interfaces(udev);
>  
>  	/* From now on we are sure all drivers support suspend/resume
> @@ -1619,6 +1628,11 @@ int usb_resume(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int			status;
>  
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_RESUME))
> +		return 0;
> +#endif
> +
>  	/* For all calls, take the device back to full power and
>  	 * tell the PM core in case it was autosuspended previously.
>  	 * Unbind the interfaces that will need rebinding later,
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index ecaa75718e59..8cbc666ab5c6 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -265,6 +265,13 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>  		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
>  			xhci->quirks |= XHCI_SKIP_PHY_INIT;
>  
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +		if (device_property_read_bool(tmpdev, "usb-skip-suspend")) {
> +			hcd_to_bus(hcd)->skip_suspend = true;
> +			hcd_to_bus(xhci->shared_hcd)->skip_suspend = true;
> +		}
> +#endif

"usb-skip-suspend" is an odd name for this.  "usb-never-suspend" 
would be better, in my opinion.

> +
>  		device_property_read_u32(tmpdev, "imod-interval-ns",
>  					 &xhci->imod_interval);
>  	}
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 672d8fc2abdb..3074c89ed921 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -487,6 +487,15 @@ struct usb_bus {
>  	struct mon_bus *mon_bus;	/* non-null when associated */
>  	int monitored;			/* non-zero when monitored */
>  #endif
> +
> +#ifdef CONFIG_USB_SKIP_SUSPEND
> +	bool skip_suspend;		/* All USB devices are brought into suspend
> +					 * power state after system suspend. It is
> +					 * desirable for some specific manufacturers
> +					 * buses to keep their devices in normal
> +					 * state even after system suspend.
> +					 */
> +#endif
>  };

This patch will prevent the USB devices on the bus from being suspended.  
But what about the host controller?  Don't you need to prevent it from 
suspending?  After all, a USB-2 device will go into low-power suspend 
mode whenever the host controller stops sending packets -- even if it's 
connected to a USB-3 host controller.

Alan Stern


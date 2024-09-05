Return-Path: <linux-kernel+bounces-316668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E696D28A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36F21C234DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93619538D;
	Thu,  5 Sep 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlkVsBNb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311A194C62
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526572; cv=none; b=T16Imd33YVkzi4KsAtqAGfukdr6FTOTJc+EpUFxw34PA9k10AO/u8NPybVjla2knY2nBH7l4fxFES1ejxeXDVFOw3xF7IhkEiIrJYdJdpMUE5apyf6losZvpHQeABmimtKwKmRCIT62OihGp8H6O8nl6v6KUB1dhQu9tTcFsOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526572; c=relaxed/simple;
	bh=I8KKgKeQUVtp+oZAdHzxgWYY8xd2Hr6y2X8k0FDr3lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYQujqMSDcgynsFvqLj1BBHXWtN6lO0tan08h63Y8Qb/kP9PLsNTpPMIpuzqajYUUsk1hyUJCqxZGb4ttr/kz0I5HbrjuvBFLXcBJ7Tl77dZoqo16YM5monVz9uS9HsXy+wi+8TQT0Co+sOmaDzCrvptvRgTt1w9dNXgYJw5OTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlkVsBNb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725526567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCRNllYqBtGzqObg9g39uxxJwI2WY4VlxJaE2fzg3LQ=;
	b=HlkVsBNbHCH1Q4vOpPmGvNhlE6bqfa8HeGCUD/GMw/0V7FIVdOBVVlBlXG6ee7UnLqw9gT
	gRQLbze0/es4FEP1Ma6V6eWZtjg4RMuhhhVVttP1X9hcm3qARMDDnTs1+yCnmL9CCsuVAs
	nSp3KNSzP4W8sYzLLw+0fRlRCzn8fpo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-MepoCAoePomWmjz_NDatAA-1; Thu, 05 Sep 2024 04:56:06 -0400
X-MC-Unique: MepoCAoePomWmjz_NDatAA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a86860c87a8so60214366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725526565; x=1726131365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCRNllYqBtGzqObg9g39uxxJwI2WY4VlxJaE2fzg3LQ=;
        b=pNgw1fi9PUuUeM29tJIo5ZyDMLaEl/NaOXd1DGDHBWcL80Hl2aeGoF6Tr6lXp/beKO
         Fi2TEWqe/dhHQx7FH9zNdCBqZFIinthPocLAPP3x7KJPBoBuzim4WxJcnebvdm4Iomsc
         C80eapXh25GMqzPWRGhUh7p1RdQnt/HqiLDF8p3tIZ4LmvJSgSnTtrf6xFl6r/FSRBKK
         9Z77D6rqOnAe56rnHSK0oJfmHDHLeIZnD08NuwJUXftF9R9g7JS/5+LJojhs31I47P+m
         o4Hq2MCDo2nQb1T22cQYTwSjeEtUVEcPanSh3SWBJ+CLqn4bsCgiohsJIzZlXtY91VVW
         3X9w==
X-Forwarded-Encrypted: i=1; AJvYcCUE3eqfUcU5H2OtHGiOYK5o/h82f53IMFgufrEOSMI9DZ3g/ZptZmEcBUh671AeObdUFV+JGxPHd/WQPC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEHcj2l3XtATMqDFwFSHODLd3yncdpaHsMc1OodbYiHM9niaX
	sLHCjpZKIYBtSUc3zYl4/8XSEIUcyNXtDfd2jmhugDxV/WCv6C++XXOpBJY7nBwJ1g6HOnrwbxc
	180AC7aMP3MTvL/98zLVnZ7i2mzG6C0WGtqmgC5prqPR1CYeGEFYA46rPZuYV1pdIZ8iJwg==
X-Received: by 2002:a17:907:7e9c:b0:a77:cca9:b212 with SMTP id a640c23a62f3a-a897fa751e1mr1774617466b.45.1725526565112;
        Thu, 05 Sep 2024 01:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAMG2vbjagSZHFNowL4wH1G5nsXrqphynWdZ+SgABd0lHS1ZNCGypsbmYwwqkKtblg3WAAwA==
X-Received: by 2002:a17:907:7e9c:b0:a77:cca9:b212 with SMTP id a640c23a62f3a-a897fa751e1mr1774614866b.45.1725526564486;
        Thu, 05 Sep 2024 01:56:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e5c76sm104066466b.204.2024.09.05.01.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 01:56:04 -0700 (PDT)
Message-ID: <5544d302-9480-4cca-9cfd-ed56cecf6bd3@redhat.com>
Date: Thu, 5 Sep 2024 10:56:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
 jorge.lopez2@hp.com
Cc: acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240905042447.418662-1-kai.heng.feng@canonical.com>
 <20240905042447.418662-2-kai.heng.feng@canonical.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240905042447.418662-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kai-Heng Feng,

On 9/5/24 6:24 AM, Kai-Heng Feng wrote:
> The HP ProOne 440 has a power saving design that when the display is
> off, it also cuts the USB touchscreen device's power off.
> 
> This can cause system early wakeup because cutting the power off the
> touchscreen device creates a disconnect event and prevent the system
> from suspending:
> [  445.814574] hub 2-0:1.0: hub_suspend
> [  445.814652] usb usb2: bus suspend, wakeup 0
> [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
> [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
> [  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1 port polling.
> [  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x20 returns -16
> [  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1c0 returns -16
> [  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
> [  446.276101] PM: Some devices failed to suspend, or early wake event detected
> 
> So add a quirk to make sure the following is happening:
> 1. Let the i915 driver suspend first, to ensure the display is off so
>    system also cuts the USB touchscreen's power.
> 2. If the touchscreen is present, wait a while to let the USB disconnect
>    event fire.
> 3. Since the disconnect event already happened, the xhci's suspend
>    routine won't be interrupted anymore.

You only set the suspend-handler from the dmi-quirk callback, so it
is only ever set on the affected laptop-model. So this can be simplified
by simply always doing the msleep(200) on suspend, instead of poking at
USB system internals to find out if the touchscreen is there on suspend.

I guess there may be versions of this specific laptop with/without
the touchscreen, but I'm not overly worried about adding a 200 ms delay
on just 1 model laptop for the versions which don't have a touchscreen.

A bigger worry which I have is that we are going to see the same problem
on other vendor's laptops. So I think in the end we may need something
done in a more generic manner, in e.g. the drm subsystem (since this
is display related). For now lets go with this fix and when we hit similar
cases we can figure out what a generic fix will look like.

One more comment inline below.


> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 104 ++++++++++++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 876e0a97cee1..80fc3ee4deaf 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -30,6 +30,9 @@
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
>  #include <linux/dmi.h>
> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/usb.h>
>  
>  MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>  MODULE_DESCRIPTION("HP laptop WMI driver");
> @@ -1708,6 +1711,52 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
>  		platform_profile_remove();
>  }
>  
> +static int hp_wmi_suspend_handler(struct device *device)
> +{
> +	acpi_handle handle;
> +	struct acpi_device *adev;
> +	struct device *physdev;
> +	struct usb_port *port_dev;
> +	struct usb_device *udev;
> +	acpi_status status;
> +	bool found = false;
> +
> +	/* The USB touchscreen device always connects to HS11 */
> +	status = acpi_get_handle(NULL, "\\_SB.PC00.XHCI.RHUB.HS11", &handle);
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	adev = acpi_fetch_acpi_dev(handle);
> +	if (!adev)
> +		return 0;
> +
> +	physdev = get_device(acpi_get_first_physical_node(adev));
> +	if (!physdev)
> +		return 0;
> +
> +	port_dev = to_usb_port(physdev);
> +	if (port_dev->state == USB_STATE_NOTATTACHED)
> +		return 0;
> +
> +	udev = port_dev->child;
> +
> +	if (udev) {

This is racy. Often desktop environments will turn off the display
before doing a system-suspend, so the touchscreen is already disconnected
at this point but the USB subsystem may not have processed it yet.

What if the USB subsystem processes the disconnect exactly at this point?

Then your port_dev->child pointer is no longer valid and your passing
a pointer to free-ed mem to usb_get_dev()

As I said above since this code only runs on 1 model based on a DMI
match just simplify this entire function to a single "msleep(200)"
and be done with it.

Regards,

Hans


> +		usb_get_dev(udev);
> +		if (le16_to_cpu(udev->descriptor.idVendor) == 0x1fd2 &&
> +		    le16_to_cpu(udev->descriptor.idProduct) == 0x8102) {
> +			dev_dbg(&hp_wmi_platform_dev->dev, "LG Melfas touchscreen found\n");
> +			found = true;
> +		}
> +		usb_put_dev(udev);
> +
> +		/* Let the xhci have time to handle disconnect event */
> +		if (found)
> +			msleep(200);
> +	}
> +
> +	return 0;
> +}
> +
>  static int hp_wmi_resume_handler(struct device *device)
>  {
>  	/*
> @@ -1745,7 +1794,7 @@ static int hp_wmi_resume_handler(struct device *device)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops hp_wmi_pm_ops = {
> +static struct dev_pm_ops hp_wmi_pm_ops = {
>  	.resume  = hp_wmi_resume_handler,
>  	.restore  = hp_wmi_resume_handler,
>  };
> @@ -1871,6 +1920,57 @@ static int hp_wmi_hwmon_init(void)
>  	return 0;
>  }
>  
> +static int lg_usb_touchscreen_quirk(const struct dmi_system_id *id)
> +{
> +	struct pci_dev *vga, *xhci;
> +	struct device_link *vga_link, *xhci_link;
> +
> +	vga = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
> +
> +	xhci = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
> +
> +	if (vga && xhci) {
> +		xhci_link = device_link_add(&hp_wmi_platform_dev->dev, &xhci->dev,
> +				      DL_FLAG_STATELESS);
> +		if (xhci_link)
> +			dev_info(&hp_wmi_platform_dev->dev, "Suspend before %s\n",
> +				 pci_name(xhci));
> +		else
> +			return 1;
> +
> +		vga_link = device_link_add(&vga->dev, &hp_wmi_platform_dev->dev,
> +					   DL_FLAG_STATELESS);
> +		if (vga_link)
> +			dev_info(&hp_wmi_platform_dev->dev, "Suspend after %s\n",
> +				 pci_name(vga));
> +		else {
> +			device_link_del(xhci_link);
> +			return 1;
> +		}
> +	}
> +
> +
> +	/* During system bootup, the display and the USB touchscreen device can
> +	 * be on and off several times, so the device may not be present during
> +	 * hp-wmi's probe routine. Try to find the device in suspend routine
> +	 * instead.
> +	 */
> +	hp_wmi_pm_ops.suspend = hp_wmi_suspend_handler;
> +
> +	return 1;
> +}
> +
> +static const struct dmi_system_id hp_wmi_quirk_table[] = {
> +	{
> +		.callback = lg_usb_touchscreen_quirk,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProOne 440 23.8 inch G9 All-in-One Desktop PC"),
> +		},
> +	},
> +	{}
> +};
> +
>  static int __init hp_wmi_init(void)
>  {
>  	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
> @@ -1909,6 +2009,8 @@ static int __init hp_wmi_init(void)
>  			goto err_unregister_device;
>  	}
>  
> +	dmi_check_system(hp_wmi_quirk_table);
> +
>  	return 0;
>  
>  err_unregister_device:



Return-Path: <linux-kernel+bounces-316352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E3196CE5C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE33A1F234D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2199A156676;
	Thu,  5 Sep 2024 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/bGPOw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF31372;
	Thu,  5 Sep 2024 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513499; cv=none; b=p9+eLFCBJUjWndRDhQVOywneOhOhy1d6dq/rVi/xU0kWmSgsifKSpYzebPNBOn7mGUSziCZ5CcjdLcQNgL+LBNnjTQvQRlIxNlznmyR5gE7yjYfFWOS/9PNFv9LUQ+VQlG6XIq40A56YnJV6rE+cNiNEQLBfBZ3+QKwxKCLGd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513499; c=relaxed/simple;
	bh=xtIkfUy4hTlC/FKrRENn52PpHcU6UfejqdvtDUAQQhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMeBiqAps7Tguhtne6t1MXXra2juJQgtYbrlYkNEg+S60tx4nBPr3d94xpy/Ek4nREDMl1diaj+jB6N0hv3SNmo7DBdAez7V0al3b8CviyGcVWTanvEXN4oGkW4CCvmkpi+UcA0GVsjdimDssCIGVatoURlFF+UNS3F49iaTlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/bGPOw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ABCC4CEC4;
	Thu,  5 Sep 2024 05:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725513498;
	bh=xtIkfUy4hTlC/FKrRENn52PpHcU6UfejqdvtDUAQQhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/bGPOw3m4qXtRnauouPMk6XW69KDRJ7QCGzl++e3REOQGrBkyL4W6gO6S/eKIiKw
	 4NYj0sv4jNOJkFXx20WwMPqUsGSvtZ535nE2zyD6VfFKttKeA9ZG62REzrPExLu/Ms
	 uLKgygUZSBFRyoBN4gUY3ClNnHE+6a8Op/3CWozY=
Date: Thu, 5 Sep 2024 07:18:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jorge.lopez2@hp.com,
	acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
Message-ID: <2024090510-repaying-disrupt-e568@gregkh>
References: <20240905042447.418662-1-kai.heng.feng@canonical.com>
 <20240905042447.418662-2-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905042447.418662-2-kai.heng.feng@canonical.com>

On Thu, Sep 05, 2024 at 12:24:47PM +0800, Kai-Heng Feng wrote:
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

That's a brave cast, how do you "know" this is this device type?

> +	if (port_dev->state == USB_STATE_NOTATTACHED)
> +		return 0;
> +
> +	udev = port_dev->child;
> +
> +	if (udev) {
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

why 200?

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

When drivers work properly, they are quiet, was this ment to be
dev_dbg()?

> +		else
> +			return 1;
> +
> +		vga_link = device_link_add(&vga->dev, &hp_wmi_platform_dev->dev,
> +					   DL_FLAG_STATELESS);
> +		if (vga_link)
> +			dev_info(&hp_wmi_platform_dev->dev, "Suspend after %s\n",
> +				 pci_name(vga));

Same here.

thanks,

greg k-h


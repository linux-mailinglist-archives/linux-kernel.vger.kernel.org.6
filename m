Return-Path: <linux-kernel+bounces-318131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80996E8CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF1DB23194
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EAE5B216;
	Fri,  6 Sep 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wd2ciHKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF8D2FF;
	Fri,  6 Sep 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598585; cv=none; b=d0asGzp2ajjl+Kh27uvOeMD0ZtvfWuk1gh5SUQstoJPq/0IgotViBMo+EVkfPPuN34pOS0DzRXV7Ch7TQCd/JbjVqQDyMD1CFFcXktTncjhKi1n/PzhKhS1RjY8vUnNLgGIbsruRFKiFHKEHHUcxr7KgvvnH/dmNE/KWvCys+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598585; c=relaxed/simple;
	bh=6O9RTUqnf8rZnB5mgGGElziB2u87cY4eq77n2OtqU18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3k6avifJfvkRrQ/VojUv7I/Ta6CO4NIPTjt+Eg5INMo7MD2xy4+NpYLVl6LlLgkRM5rpHKmfB7zRnucS/zH18syFImtxVWHkjPIo4188YWTlBwe1TwuDFYs4lXAJ6xgkGni3wvUd4GQdiZv5DN+YQxHm4s1XigXH1irbKE7uyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wd2ciHKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A648CC4CEC6;
	Fri,  6 Sep 2024 04:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725598584;
	bh=6O9RTUqnf8rZnB5mgGGElziB2u87cY4eq77n2OtqU18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd2ciHKEVLsifoEo02K5JZ60c1ge9bCNVgUiLOFh/VTWz8qE0GTzaqKEisjaY/Rm9
	 3+s/d43mWequs+4I19hO0SxP5KYMHCsOSf775M7n0V0TDVEKqzezdu1aZ5EVTu5oD4
	 +6grQGVYveRHZTRByRe4+vx5yjI+rODHMspMYvrk=
Date: Fri, 6 Sep 2024 06:56:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jorge.lopez2@hp.com,
	acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
Message-ID: <2024090601-chess-stonewall-c558@gregkh>
References: <20240906030300.442110-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906030300.442110-1-kai.heng.feng@canonical.com>

On Fri, Sep 06, 2024 at 11:03:00AM +0800, Kai-Heng Feng wrote:
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
> 2. Wait a while to let the USB disconnect event fire and get handled.
> 3. Since the disconnect event already happened, the xhci's suspend
>    routine won't be interrupted anymore.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Remove the part that searching for the touchscreen device.
>  - Wording.
> 
>  drivers/platform/x86/hp/hp-wmi.c | 59 +++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 876e0a97cee1..7c239d8d02fd 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -30,6 +30,8 @@
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
>  #include <linux/dmi.h>
> +#include <linux/delay.h>
> +#include <linux/pci.h>
>  
>  MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>  MODULE_DESCRIPTION("HP laptop WMI driver");
> @@ -1708,6 +1710,14 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
>  		platform_profile_remove();
>  }
>  
> +static int hp_wmi_suspend_handler(struct device *device)
> +{
> +	/* Let the xhci have time to handle disconnect event */
> +	msleep(200);
> +
> +	return 0;
> +}
> +
>  static int hp_wmi_resume_handler(struct device *device)
>  {
>  	/*
> @@ -1745,7 +1755,7 @@ static int hp_wmi_resume_handler(struct device *device)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops hp_wmi_pm_ops = {
> +static struct dev_pm_ops hp_wmi_pm_ops = {
>  	.resume  = hp_wmi_resume_handler,
>  	.restore  = hp_wmi_resume_handler,
>  };
> @@ -1871,6 +1881,51 @@ static int hp_wmi_hwmon_init(void)
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

Again, please turn these into dev_dbg() calls.

thanks,

greg k-h


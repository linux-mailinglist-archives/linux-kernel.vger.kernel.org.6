Return-Path: <linux-kernel+bounces-318345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF096EC14
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF565286CC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A811547DD;
	Fri,  6 Sep 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCPRsMHw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF1514BF8F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608155; cv=none; b=LYZO4qJFufcHx+OW0lTxKVqON/+OCYvOcnxbk9D1CBBKWnusIHB+A1LkKT4+hoEevd7gySzzO6dVFEpQGPFAWRxqQJCwMaRTVamp4vIJvOG0afT88grF7LX8jFCdXs+O+Jxj/YiYu9t2hAucYIoh+ThrLJVcRgoMkZbRY2/H6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608155; c=relaxed/simple;
	bh=nDPVjiB2sY6jBl+bAwv7wDSsuxTgIU1K4DHTBn3/MNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE5z5Tqmg53AX20PnXmuIp9Sjhg+FWWH68O2pxhNqeVxsx+W13CyALqjRmNRWNCDQVhgkPUMYKiaa/DzWkWWFhTund7oWtS8AXZH1V1j9tBYXO92ldp0QdAM5ivy6MsUhoblJYOh1YKA+XzLum4759dPZGSoApU1IHzzAcPmQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCPRsMHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725608149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blft9IP0BzWdJp3TaH4Zg3FpZbJCoe4Kn/C+T0s0wEg=;
	b=BCPRsMHwHyOKojrMHm+pI9c/wBEQwP8ZYOapxSoDe4sERFoGtkgy0gHD1VZeF5NFSy/8j+
	kxGYz/cI4qdM+vV53joUxfgmGecFajouD3tCg7hx+3Wz5IS72zgL1QGHg/jNjzYYfbag6p
	gnW35vEPQ/ZMzQRDa+FdQpl061Rj/Wk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-teEkvrAKPauyvlmQ2i5pmA-1; Fri, 06 Sep 2024 03:35:48 -0400
X-MC-Unique: teEkvrAKPauyvlmQ2i5pmA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8691010836so157976366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608147; x=1726212947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blft9IP0BzWdJp3TaH4Zg3FpZbJCoe4Kn/C+T0s0wEg=;
        b=TBRWXMGZdTgVokc9JNHIcKeoVuvO9Ons/i//I7MD2D8h/UmDGNBEyhBOyV+e9AG+Gf
         eRjWjPufdHyI+n+WeLPoCKvhiTEzj+/AeMqvuBVtI/8QbAVsXbTikxy4rDRkCx5Wrzis
         7wxLymIk1zyakuA/04PcEb/q+19XNQY7Jqw6xh2TSJ04/8CS8ST+nFGp564dRpSFnwNW
         eORHpnwWE60bIEyFbTQk3I6dqrhHfjk/dc9XzDfX01anmXOvHJ3IQFpwSjOy+UfWTBfu
         bU2gpWELEJGOsU10APHm6YXXZffRPaYgZw0NQvM45dZ8poWUKEA6rBJd16KRXCzSYpMK
         k3wg==
X-Forwarded-Encrypted: i=1; AJvYcCWH3/EXx5EshOt7fRTE1fUkhq2tdTPv6Oz4bxHTG1zgZIq5OtVtEVdpGc9muiW465wfMxVoQDwodgR1TQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1t+1UAB+U2ahqYkc2hheTKwvJ9ypqfxiuJntqBr6cr+pqH8Yz
	a3XXnYkaBLO7oIHSF/Dss6P0JowTm0ApfT+fL2N7KrLON5K29cnWaQ3EgDnZ+NwfIc+ZS10B5GN
	e/IFQhR6DkzSXaJmzWII+qIVnQmB//uUtWIULTpDbahG/HGaBrv5eOLaN2RWpMRQ1FvPi2A==
X-Received: by 2002:a17:907:7f03:b0:a86:b18e:bb7a with SMTP id a640c23a62f3a-a8a887fce23mr100747466b.42.1725608146857;
        Fri, 06 Sep 2024 00:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzyyOx82bBwEQKvoCTfe+4kLAZtCsdRQ+cWVMKBnF9FQq+tY2HKzQmH1DprT/M3pMOFnG3+A==
X-Received: by 2002:a17:907:7f03:b0:a86:b18e:bb7a with SMTP id a640c23a62f3a-a8a887fce23mr100745366b.42.1725608146360;
        Fri, 06 Sep 2024 00:35:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038d4dsm237426266b.51.2024.09.06.00.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:35:45 -0700 (PDT)
Message-ID: <3e12ef27-30e4-4b5a-acd6-5d3023a82941@redhat.com>
Date: Fri, 6 Sep 2024 09:35:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
 jorge.lopez2@hp.com
Cc: acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240906053047.459036-1-kai.heng.feng@canonical.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240906053047.459036-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/6/24 7:30 AM, Kai-Heng Feng wrote:
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Ilpo, do you plan to do another fixes pull-request for 6.11,
or shall I add this to for-next to target 6.12-rc1 ?

Either way works for me. If you plan to do another fixes
pull-request, note that I plan to post a v2 of the panasonic
patches this Monday.

Regards,

Hans



> ---
> v3:
>  - Use dev_dbg() instead of dev_info().
> 
> v2:
>  - Remove the part that searching for the touchscreen device.
>  - Wording.
> 
>  drivers/platform/x86/hp/hp-wmi.c | 59 +++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 876e0a97cee1..92cb02b50dfc 100644
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
> +			dev_dbg(&hp_wmi_platform_dev->dev, "Suspend before %s\n",
> +				 pci_name(xhci));
> +		else
> +			return 1;
> +
> +		vga_link = device_link_add(&vga->dev, &hp_wmi_platform_dev->dev,
> +					   DL_FLAG_STATELESS);
> +		if (vga_link)
> +			dev_dbg(&hp_wmi_platform_dev->dev, "Suspend after %s\n",
> +				 pci_name(vga));
> +		else {
> +			device_link_del(xhci_link);
> +			return 1;
> +		}
> +	}
> +
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
> @@ -1909,6 +1964,8 @@ static int __init hp_wmi_init(void)
>  			goto err_unregister_device;
>  	}
>  
> +	dmi_check_system(hp_wmi_quirk_table);
> +
>  	return 0;
>  
>  err_unregister_device:



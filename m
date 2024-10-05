Return-Path: <linux-kernel+bounces-351894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7408991753
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A751F21C3A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A51547D5;
	Sat,  5 Oct 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiLzValL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F346D520
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138310; cv=none; b=MJ7TKG6S85Ij4mI68UtKOFYlwswAYuJo3kofO7AUmixUHwM9GaAURJBPOua+wAWSi8iYhaAQZyDtrVfHTrq3d+BXoVH2B6H4VLqOJfFF3CiCO8onUFavsIm88xW+k6NUF+64VOWoXertRepxeIgEvk3aojxvVhtC7pXS+gQgqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138310; c=relaxed/simple;
	bh=pkph1iPyIODe1Sz/0WxdkJA30jq5yMomp3w6xQC33Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QT65W5vpy4FTMddbadCW3LmG4fOaU1mJhSf2mBxRR83D5cpNITplyAx+t3V2KghGF1EBBDB7cO5206+i2f0dYlkKJpZa5tVZhB1p1q4Y19cPKc8OpfH9afuDWuwG2zLNxlnPioRDVvZS9kgXQk4Z0LlnfAmPvukDHL8Pd7hvQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiLzValL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728138307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhK/pesZSBOa6zlYwUsiAg8PkkE7aF+Vxmqvu6r4InA=;
	b=SiLzValL5KuE8QCsCbggUvQ6Q736Jftho2FucNRIhsKOTIwNtmgl834O/uN6cOv1DbOqwY
	1JbExrA8pdfdxv90O47ceZcud6ptloXTHffWW0uuxgkb9d7tGu/ZuSH5KR49L1RsuymRjZ
	wTkpBZRozIBJ2L8iBVV/ywKEXIcnPAc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-SNcwIINqMK2cYRPiQsom3w-1; Sat, 05 Oct 2024 10:25:06 -0400
X-MC-Unique: SNcwIINqMK2cYRPiQsom3w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c88d49ac78so3024865a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728138305; x=1728743105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhK/pesZSBOa6zlYwUsiAg8PkkE7aF+Vxmqvu6r4InA=;
        b=Xr7d5U2xbrGdunguUl3m2Mx05U+B73fftmtYiw66NmoHXNUzBPHxpAFliubpLrzkNG
         zZewkqNcs1xc4kgenpvK2u5DfZsdKMLSLCYeM8SrGItb2IuxBh56BBusw7BOCJZlGs84
         dz/k9PHeCMAH8djBEixCfSxrbcD+y3YyCqc+DKm8EJU397hKbwTUkFv6IE63STqrZTzm
         JEzQDGRtTScgit2/DRnF5gUI9GmYJKRjUI7HH7UaeFVylwAdMlUhbtOcV4umlJabvLcH
         ZDWru92NxlP/hdVl2FzLFWN7H7DAnW/tt/IZlPVnbuFgeU8PMSFYZE7AhHm/KriRdwEs
         JnYw==
X-Forwarded-Encrypted: i=1; AJvYcCXvr8fQZS/zjDUw8sxEorpwOtEA0ronJC88FU0yKchdwhkRGkzMsrABND10dq7o9IGPvAu0Zmsz1mhumQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3GjWgf1N4/N7FW5afUJFXtYtiTD/LOmHY4LQrKTAafmdksGm
	EE0+rf8gMbskfEaKJt6rSdu/S8KMyqmpqGzRmbdg4cdUhaHFUizHNdaxX0CTkwCkiLksyyT8phe
	8dt8MZ+tpEH4m85KwPgHoe3eH21WJZaYRk0GgbBaw5hC45QpvbfDA4g1HtxrXudWfDK3hVvl8
X-Received: by 2002:a05:6402:381a:b0:5c8:8d5e:18ad with SMTP id 4fb4d7f45d1cf-5c8d2e2c9ccmr4334285a12.18.1728138304704;
        Sat, 05 Oct 2024 07:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOLH3E9euc3m6txZZ6pSksvQJlU9CdVm0LlE8Lq+Ckf7uLdImchrTvZ96rTcIoJ2eIQX2ebg==
X-Received: by 2002:a05:6402:381a:b0:5c8:8d5e:18ad with SMTP id 4fb4d7f45d1cf-5c8d2e2c9ccmr4334259a12.18.1728138304109;
        Sat, 05 Oct 2024 07:25:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bd4e7sm1059778a12.47.2024.10.05.07.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:25:03 -0700 (PDT)
Message-ID: <87d40775-9bd4-4f22-81da-4e670236c15e@redhat.com>
Date: Sat, 5 Oct 2024 16:25:02 +0200
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

Hi Kai-Heng,

On 6-Sep-24 7:30 AM, Kai-Heng Feng wrote:
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

I was wondering if there is any progress in trying to come up with
a more generic fix at the USB hub level for this as discussed in
other emails in this thread ?

Also have you seen this series:

[PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls outside suspend (fixes ROG Ally suspend)
https://lore.kernel.org/platform-driver-x86/20240922172258.48435-1-lkml@antheas.dev/

?

I wonder if that is relevant. If the touchscreen gets turned off when
the GPU enters D3 then this will not help, but if it gets turned off
by the system wide Display Off call as described in that series then
that series + extending patch 3 to maybe also include the HP ProOne 440
might be another (cleaner) way to fix this ?

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



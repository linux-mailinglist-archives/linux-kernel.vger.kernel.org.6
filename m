Return-Path: <linux-kernel+bounces-192008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2178D172B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1196D1F244FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A513E037;
	Tue, 28 May 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUDBHVDN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6871422BB;
	Tue, 28 May 2024 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887924; cv=none; b=WleXz25XoGurGx/EdzmS+YBd3rONq7pibdsg321rgGjMxjSUIejS2K9LCFuAikyCJ/KAuhNqfhBndmwlAzSWsnottQe3hbUQrClfk+OaBd+jQSIxexar5Yf3VYtyNBgpPKpcWIrB8jdkrlGqK+0Iino+eeYQxUw8yokQceLyMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887924; c=relaxed/simple;
	bh=fjXuULyy5Y/sjvulIMAievLOG8n0fxU/rSx0mXSkkec=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uLIWuj7G8EtptEwFk9+L+s32tAnr84TFPUShdOALiA4nJCDT/vfd3PnWsSYdXVj7PPlU2VPgRM41Q4PVdyCcMKvT19nmYCl4zAsiJv1lZgDApmuCRE8FXaSqC8Nn9TuYsypC0zpboihR7J4GFYdj1paeu5iRiQer+MUTlEJF5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUDBHVDN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716887922; x=1748423922;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fjXuULyy5Y/sjvulIMAievLOG8n0fxU/rSx0mXSkkec=;
  b=hUDBHVDN7myMdz9IiNRxjuz0yOy+Gx6eJmR/DGhXp0unCZXpO7ylVJCm
   iA7kgxrRfFT2XTEKXkQEeEyI5DyJfk1VrjtKOgieUR4u1+KjVffSQlDts
   A4yV519HD7aVIki8sp/qGslJftB/3aSiIls9KFfhLVZk5DHlr3R5eSdoO
   cdQ4Oo/r42CA9la7Lqj89rPwVhy55oYJLebBBNYF8VXGMVsUKUWae0efZ
   UjGYpp02t/SaJ9c4hQ6gCLqaasRwRvUf2QV6AvgzRAMpYIpPgU6qfNSub
   urV1eDmbVBcklRRg80k2bGZFNQpetG62eI7iEtJVYhxjXb6OBg6UgaznK
   Q==;
X-CSE-ConnectionGUID: XctFG2DcTY+PcGJzmZ9sGQ==
X-CSE-MsgGUID: 2pnUC5agRQCVM/okhPaIgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16168746"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="16168746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:18:41 -0700
X-CSE-ConnectionGUID: xvnUlviMT0+SCqDIzXJeyw==
X-CSE-MsgGUID: 1Xf21UPRTdiAZr5Mr4TPjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35088581"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:18:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 12:18:35 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] platform/x86: asus-wmi: add panel-fhd
 functionality
In-Reply-To: <20240528013626.14066-7-luke@ljones.dev>
Message-ID: <53da23e6-deb5-dc4f-057f-afafaa9455aa@linux.intel.com>
References: <20240528013626.14066-1-luke@ljones.dev> <20240528013626.14066-7-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Luke D. Jones wrote:

> Exposes the FHD panel toggle avavilable on new ASUS Duo laptops.

available

> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  9 +++++++++
>  drivers/platform/x86/asus-wmi.c               | 20 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 984a04f32fd0..3b4eeea75b7b 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -217,3 +217,12 @@ Description:
>  		Set if the MCU can go in to low-power mode on system sleep
>  			* 0 - False,
>  			* 1 - True
> +
> +What:		/sys/devices/platform/<platform>/panel_fhd
> +Date:		Apr 2024
> +KernelVersion:	6.11
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set panel to UHD or FHD mode
> +			* 0 - UHD,
> +			* 1 - FHD

I'd prefer this to be more forward-looking, the filename is based on fhd, 
which is one of the options and the values seem "wrong way" around too 
(FHD < UHD but here you have FHD=1 after UHD=0).

> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 260548aa6a42..4b045f1828f1 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -798,6 +798,23 @@ WMI_ATTR_SIMPLE_RW(panel_od, 0, 1, ASUS_WMI_DEVID_PANEL_OD);
>  WMI_ATTR_SIMPLE_RW(boot_sound, 0, 1, ASUS_WMI_DEVID_BOOT_SOUND);
>  WMI_ATTR_SIMPLE_RO(charge_mode, ASUS_WMI_DEVID_CHARGE_MODE);
>  
> +static ssize_t panel_fhd_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = rog_tunable_store(asus, &attr->attr, buf, count,
> +				0, 1, -1, NULL, ASUS_WMI_DEVID_PANEL_FHD);
> +	if (err < 0)
> +		return err;
> +
> +	pr_info("Panel UHD/FHD display mode changed, reboot required\n");
> +	return count;
> +}
> +WMI_SIMPLE_SHOW(panel_fhd, "%d\n", ASUS_WMI_DEVID_PANEL_FHD);
> +static DEVICE_ATTR_RW(panel_fhd);
> +
>  /* Tablet mode ****************************************************************/
>  
>  static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
> @@ -4040,6 +4057,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_mcu_powersave.attr,
>  	&dev_attr_boot_sound.attr,
>  	&dev_attr_panel_od.attr,
> +	&dev_attr_panel_fhd.attr,
>  	&dev_attr_mini_led_mode.attr,
>  	&dev_attr_available_mini_led_mode.attr,
>  	NULL
> @@ -4111,6 +4129,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		devid = ASUS_WMI_DEVID_BOOT_SOUND;
>  	else if (attr == &dev_attr_panel_od.attr)
>  		devid = ASUS_WMI_DEVID_PANEL_OD;
> +	else if (attr == &dev_attr_panel_fhd.attr)
> +		devid = ASUS_WMI_DEVID_PANEL_FHD;
>  	else if (attr == &dev_attr_mini_led_mode.attr)
>  		ok = asus->mini_led_dev_id != 0;
>  	else if (attr == &dev_attr_available_mini_led_mode.attr)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 79a50102440d..6c51d41ffc20 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -72,6 +72,7 @@
>  #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
>  #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
>  #define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
> +#define ASUS_WMI_DEVID_PANEL_FHD	0x0005001C
>  
>  /* Storage */
>  #define ASUS_WMI_DEVID_CARDREADER	0x00080013
> 

-- 
 i.



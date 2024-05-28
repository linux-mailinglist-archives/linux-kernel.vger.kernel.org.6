Return-Path: <linux-kernel+bounces-192014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154AC8D1742
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F341C21BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A20154BFF;
	Tue, 28 May 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTXnT+O3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97552154450;
	Tue, 28 May 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888454; cv=none; b=SRb1Fh0csp0kgzEg+cQtoRdt0p6fe0J1cNgORFGQaZhylWQrl4XfKX4TuB27PZsqmaLOr2vUe3JAM0wOuHNXNOeKxWAvZ4tlcWGQZTm4WHRLAiU5qgeMASOmGSRDXSjeLiw/TLpuLl8dXSTsrZvaenGfecENsid6ZkW6tQIVECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888454; c=relaxed/simple;
	bh=Ox5OkVtIPeoJlCBHYNB1yqDcFh8GZpA14ru1JHkYhE4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TS8NE0I9j0C5o02MrqPWgh7/BlXc2+QMsA3ypDYgTQGZJTwjryyVNsgfqfRzo3iWlL4FfsujYMIPgCDQuaAtAKFch6ACWQ4q7wsrCoRZ7XU4iuNXnnEKj6RYrLyxCD++gZa/1c75OB3Zu+LM4CZWFdW9LWebzu4pLlp2W5rMVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTXnT+O3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716888453; x=1748424453;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ox5OkVtIPeoJlCBHYNB1yqDcFh8GZpA14ru1JHkYhE4=;
  b=aTXnT+O3oTFuPWaACP2BeM4uWY1StPmYlMjEummbtKD5nT1i/7nSWxQr
   tvR6NEXhHIN9+FY4leycnI47CmK7TWScNXevElr3dj6RdwjhoXmI4uoXi
   tjo2Gs8L6r8ZEUaXuSbls7OlAMdMw0pvQYQuvS+VJ6I1O6Pg3pTaOoPga
   ov3I2hy15ZSt7X7odHWQ45keDqg2zb1NJZy0Qz978/QkP5i4Y6Eb7dAYG
   XIDxY/KnevmroyKUyyB7o4wkoy+LzblP1On62zCSglh/z8VEfrfAO/8+C
   Ytx/Q2Gs+zXbQdaONf+X056bxjH9Y66+L85QBxoWbyB34NtXOLqlpVGoi
   g==;
X-CSE-ConnectionGUID: ptrLDzK/RCmP4Cvhv3iQ7Q==
X-CSE-MsgGUID: 4u7Qj8ULSBiYy+teADGmyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24634586"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="24634586"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:27:33 -0700
X-CSE-ConnectionGUID: cddHyDsoSQi6j3vX3R0stw==
X-CSE-MsgGUID: yjivfThfSLaom1C40XMl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="66217238"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:27:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 12:27:26 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>
cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] platform/x86: asus-wmi: add enable/disable CPU
 cores
In-Reply-To: <20240528013626.14066-8-luke@ljones.dev>
Message-ID: <4660daf1-f42f-9b65-eaf5-30daf2931058@linux.intel.com>
References: <20240528013626.14066-1-luke@ljones.dev> <20240528013626.14066-8-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

Hans, please check my question below.

On Tue, 28 May 2024, Luke D. Jones wrote:

> Exposes the WMI functions for enable/disable of performance and
> efficiency cores on some laptop models (largely Intel only).
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---

> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 3b4eeea75b7b..ac881e72e374 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -226,3 +226,22 @@ Description:
>  		Set panel to UHD or FHD mode
>  			* 0 - UHD,
>  			* 1 - FHD
> +
> +What:		/sys/devices/platform/<platform>/cores_enabled
> +Date:		Jun 2024
> +KernelVersion:	6.11
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Enable/disable efficiency and performance cores. The format is
> +		0x[E][P] where [E] is the efficiency core count, and [P] is
> +		the perfromance core count. If the core count is a single digit

performance

> +		it is preceded by a 0 such as 0x0406; E=4, P=6, 0x1006; E=10, P=6
> +
> +What:		/sys/devices/platform/<platform>/cores_max
> +Date:		Jun 2024
> +KernelVersion:	6.11
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Show the maximum performance and efficiency core countin format
> +		0x[E][P] where [E] is the efficiency core count, and [P] is
> +		the perfromance core count.

performance

> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 4b045f1828f1..f62a36dfcd4b 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -815,6 +815,46 @@ static ssize_t panel_fhd_store(struct device *dev,
>  WMI_SIMPLE_SHOW(panel_fhd, "%d\n", ASUS_WMI_DEVID_PANEL_FHD);
>  static DEVICE_ATTR_RW(panel_fhd);
>  
> +/* Efficiency and Performance core control **********************************/
> +static ssize_t cores_enabled_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int result, err;
> +	u32 cores, max;
> +
> +	result = kstrtou32(buf, 16, &cores);
> +	if (result)
> +		return result;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CORES_MAX, &max);
> +	if (err < 0)
> +		return err;
> +
> +	if (cores > max) {

This only checks one part of it and the P part can contain whatever 
garbage as long as E is small enough?

But I'm not sure if it's good idea to have these two changed through the 
same sysfs file, I'm leaning more on that it would be better to split the 
interface for P and E.

Hans, what you think about this?

> +		pr_warn("Core count 0x%x exceeds max: 0x%x\n", cores, max);
> +		return -EIO;
> +	}
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES_SET, cores, &result);
> +	if (err) {
> +		pr_warn("Failed to set cores_enabled: %d\n", err);
> +		return err;
> +	}
> +
> +	pr_info("Enabled core count changed, reboot required\n");
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "cores_enabled");
> +
> +	return count;
> +}

> @@ -4131,6 +4173,9 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		devid = ASUS_WMI_DEVID_PANEL_OD;
>  	else if (attr == &dev_attr_panel_fhd.attr)
>  		devid = ASUS_WMI_DEVID_PANEL_FHD;
> +	else if (attr == &dev_attr_cores_enabled.attr
> +		|| attr == &dev_attr_cores_max.attr)

Wrong alignment.

-- 
 i.



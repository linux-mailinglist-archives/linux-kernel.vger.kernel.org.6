Return-Path: <linux-kernel+bounces-436094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08F19E8115
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1EE281E1D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A335A7B8;
	Sat,  7 Dec 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="cmugPwes"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBC14B086
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590215; cv=none; b=OOYNj/clx1rZTuOetzTld+ihg0+lTz2NbdZvXCrEN6/o1Je7myGZKtehJvTYnv2O2acJWEUxu7Wvi9kshB1v3Vz8GkyOzFbn6Gte0JvoG9/PEudooj+FNTDFVCFQjQmPuRC7mzRIAIIDsFcQuyl67YbijNOmeNaWXE8ZuFnTNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590215; c=relaxed/simple;
	bh=pUGAdIFOwkxMtf9eIba7OzlGkTI8gQww8SmIAuKyYgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAzjlALbJnOGsNtOtQ1S44InYsi6GLmo99rKwfSRrp2oG41E926S+zXbDj1pGX0QcRG1PSmA++cPyNU60tcKSCIHdAAq0olbk37ZYjKjpUlIDfi3HvwkZs0i0JQZCKIwkucC6iiE9TLAeJjTB6wkVk6QVB3TW5N+ipiD5bwZ9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=cmugPwes; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f2ae985cc4so15149eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1733590211; x=1734195011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/eDwHXj41T/9wHSfkTmpdBkrFhRbpWjoica3xMLtNQ=;
        b=cmugPwesKK34V0ThBR26fWge3YfcFP+LzbyAWWctP3vaSWSzaS4Ky144mrBP8ACt6K
         VPS/jqScazfYXzETX1MArK/5/6Y7Gxuqv4yJ9BgVdhRJkKMhmFIfmnI9zqIjLgXptZPe
         fD7Ea8JXvUYOIcPlhFMhGWvnnoa1cEG0SSXuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733590211; x=1734195011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/eDwHXj41T/9wHSfkTmpdBkrFhRbpWjoica3xMLtNQ=;
        b=Y057S1SVZkO6G9QrR2rBzrxMbHMpUiznf0L5ldFsFhEOkv2lt6tcXWml0q152lhZJb
         W+KTmw73KFRpFy7oMgIFxWkVW4b7/TLR0mFsDDVSlt3LoLZB1WnmfRGFRo9ZRTSkdx/j
         /lO46ChGzDcWtqVg68Og12qyV94Fo/QrRIFiN/0yLqyFcm7NYBm1ZoQKyH+rXBh1kWf5
         2fXvYB1ehOZJ0G1AblUnxhnS9JHxawheZIOH9AVhX8SBeGuarYGy8EUew8g6SytIxdRs
         Vtala9Pwv8BxTXlOiL4AmhU5kS12gKhJXKBu4soJXXK3jX7pvWdZdISbN8yQOb8NtPVY
         v6bQ==
X-Gm-Message-State: AOJu0YxNQ7DnHL3ZRSmXKYIavN7BVPLcxD0vZ43nYx2qyt5x3Z1L4ZDy
	tV0jlWq3DFfTazYt7hICxTMAWOBdDkHax7ZD2zPHBFF5yUyitvq1+zGP+q7pBg==
X-Gm-Gg: ASbGncuqlhwF6l+AXrsLsZx5GMmce5gKbK3GxDiJFi73oG0HgFUvK97lTC7320jiPSe
	XuZ6bQddojO35/nfw7TJh8fqPrxvS/S/PDqAjDE3tTwsJkgAoXfeyBow8ChZ7xfUYrm2eulnJYc
	1cxi3eJBX/z4wwMx5kvM+onlIM3HoNVXuJykks12yLu0aA1L/BigchcAUFXY1Dk0qAeewuFHWtB
	J/m//85DuTBmndjq0UGuR55SaOSP92KFo1Pgtmk5/GSqgc7IqyCe9Ca+JRSdg6WNHyexmDjFkI+
	eSq4SQ94
X-Google-Smtp-Source: AGHT+IG6lXdjIBigiRKixfD8c+pvzyWpTZ2LWoCF8SB02lBtLBHvqL3i22P7hZhKfw+RDxL/GgbUsQ==
X-Received: by 2002:a05:6870:7e16:b0:29e:3e6f:c102 with SMTP id 586e51a60fabf-29f731b28f6mr6509460fac.6.1733590211079;
        Sat, 07 Dec 2024 08:50:11 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm590951fac.24.2024.12.07.08.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 08:50:09 -0800 (PST)
Message-ID: <c9f3e8a8-7a95-49dd-8b13-04a4d29eddaa@ieee.org>
Date: Sat, 7 Dec 2024 10:50:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: hisilicon: kunpeng_hbmcache: Add support for
 online and offline the hbm cache
To: Zhang Zekun <zhangzekun11@huawei.com>, xuwei5@hisilicon.com,
 lihuisong@huawei.com, Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
References: <20241206112812.32618-1-zhangzekun11@huawei.com>
 <20241206112812.32618-3-zhangzekun11@huawei.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20241206112812.32618-3-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 5:28 AM, Zhang Zekun wrote:
> Add a driver for High Bandwidth Memory (HBM) cache, which provides user
> space interfaces to power on/off the HBM cache. Use HBM as a cache can
> take advantage of the high bandwidth of HBM in normal memory access, and
> OS does not need to aware of the existence of HBM cache. For workloads
> which does not require a high memory access bandwidth, power off the HBM
> cache device can help save energy.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>   MAINTAINERS                              |   3 +-
>   drivers/soc/hisilicon/Kconfig            |  11 ++
>   drivers/soc/hisilicon/Makefile           |   1 +
>   drivers/soc/hisilicon/kunpeng_hbmcache.c | 136 +++++++++++++++++++++++
>   4 files changed, 150 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hbmcache.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e8b4cf7d7162..4819d04badd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10283,10 +10283,11 @@ F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
>   F:	drivers/soc/hisilicon/kunpeng_hccs.c
>   F:	drivers/soc/hisilicon/kunpeng_hccs.h
>   
> -HISILICON KUNPENG SOC KUNPENG HBMDEV DRIVER
> +HISILICON KUNPENG SOC KUNPENG HBM DRIVER
>   M:	Zhang Zekun <zhangzekun11@huawei.com>
>   S:	Maintained
>   F:	drivers/soc/hisilicon/kunpeng_hbm.h
> +F:	drivers/soc/hisilicon/kunpeng_hbmcache.c
>   F:	drivers/soc/hisilicon/kunpeng_hbmdev.c
>   
>   HISILICON LPC BUS DRIVER
> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
> index b3ca7d6f5d01..f12f3e42d908 100644
> --- a/drivers/soc/hisilicon/Kconfig
> +++ b/drivers/soc/hisilicon/Kconfig
> @@ -21,6 +21,17 @@ config KUNPENG_HCCS
>   	  health status and port information of HCCS, or reducing system
>   	  power consumption on Kunpeng SoC.
>   
> +config KUNPENG_HBMCACHE
> +	tristate "HBM cache memory device"
> +	depends on ACPI
> +	help
> +	  This driver provids methods to control the power of High Bandwidth

s/provids/provides/

> +	  Memory (HBM) cache device in Kunpeng SoC. Use HBM as a cache can

If there can be more than one:
s/device/devices/

s/in Kunpeng/in the Kunpeng/
s/Use HBM/Using HBM/

> +	  take advantage of the high bandwidth of HBM in normal memory access.
> +
> +	  To compile the driver as a module, choose M here:
> +	  the module will be called kunpeng_hbmcache.
> +
>   config KUNPENG_HBMDEV
>   	bool "add extra support for hbm memory device"
>   	depends on ACPI_HOTPLUG_MEMORY
> diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
> index 08048d73586e..b7c7c1682979 100644
> --- a/drivers/soc/hisilicon/Makefile
> +++ b/drivers/soc/hisilicon/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_KUNPENG_HCCS)	+= kunpeng_hccs.o
>   obj-$(CONFIG_KUNPENG_HBMDEV)	+= kunpeng_hbmdev.o
> +obj-$(CONFIG_KUNPENG_HBMCACHE)	+= kunpeng_hbmcache.o
> diff --git a/drivers/soc/hisilicon/kunpeng_hbmcache.c b/drivers/soc/hisilicon/kunpeng_hbmcache.c
> new file mode 100644
> index 000000000000..32eb7e781fd7
> --- /dev/null
> +++ b/drivers/soc/hisilicon/kunpeng_hbmcache.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024. Huawei Technologies Co., Ltd
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +
> +#include "kunpeng_hbm.h"
> +
> +#define MODULE_NAME            "hbm_cache"
> +
> +static struct kobject *cache_kobj;
> +static struct mutex cache_lock;
> +
> +static ssize_t state_store(struct device *d, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(d);
> +	const int type = online_type_from_str(buf);
> +	acpi_handle handle = adev->handle;
> +	acpi_status status = AE_OK;
> +
> +	if (!mutex_trylock(&cache_lock))
> +		return restart_syscall();
> +
> +	switch (type) {
> +	case STATE_ONLINE:
> +		status = acpi_evaluate_object(handle, "_ON", NULL, NULL);
> +		break;
> +	case STATE_OFFLINE:
> +		status = acpi_evaluate_object(handle, "_OFF", NULL, NULL);
> +		break;
> +	default:
> +		break;
> +	}
> +	mutex_unlock(&cache_lock);
> +
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(state);

Here too, could this just be defined as a Boolean attribute instead?
Do you anticipate an HBM cache device being in more than two possible
states someday?  Also, this is a write-only property?  Who is expected
to write this file?  Can it be written while the device is open?

> +
> +static ssize_t socket_id_show(struct device *d, struct device_attribute *attr,
> +				char *buf)
> +{
> +	int socket_id;
> +
> +	if (device_property_read_u32(d, "socket_id", &socket_id))
> +		return -EINVAL;

So an HBM cache device has a (required?) socket ID property in
its DTB? Did you define this in a binding document somewhere?
(I might just be jumping in late, without proper context, so
I apologize if I've just missed something.)

Does the socket ID affect/define/restrict something about
the functionality provided by a HBM cache device?

					-Alex

> +
> +	return sysfs_emit(buf, "%d\n", socket_id);
> +}
> +static DEVICE_ATTR_RO(socket_id);
> +
> +static struct attribute *attrs[] = {
> +	&dev_attr_state.attr,
> +	&dev_attr_socket_id.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group = {
> +	.attrs = attrs,
> +};
> +
> +static int cache_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &attr_group);
> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_link(cache_kobj,
> +				&pdev->dev.kobj,
> +				kobject_name(&pdev->dev.kobj));
> +	if (ret) {
> +		sysfs_remove_group(&pdev->dev.kobj, &attr_group);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cache_remove(struct platform_device *pdev)
> +{
> +	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
> +	sysfs_remove_link(&pdev->dev.kobj,
> +			  kobject_name(&pdev->dev.kobj));
> +}
> +
> +static const struct acpi_device_id cache_acpi_ids[] = {
> +	{"HISI04A1", 0},
> +	{"", 0},
> +};
> +
> +static struct platform_driver hbm_cache_driver = {
> +	.probe = cache_probe,
> +	.remove = cache_remove,
> +	.driver = {
> +		.name = MODULE_NAME,
> +		.acpi_match_table = ACPI_PTR(cache_acpi_ids),
> +	},
> +};
> +
> +static int __init hbm_cache_module_init(void)
> +{
> +	int ret;
> +
> +	cache_kobj = kobject_create_and_add("hbm_cache", kernel_kobj);
> +	if (!cache_kobj)
> +		return -ENOMEM;
> +
> +	mutex_init(&cache_lock);
> +
> +	ret = platform_driver_register(&hbm_cache_driver);
> +	if (ret) {
> +		kobject_put(cache_kobj);
> +		return ret;
> +	}
> +	return 0;
> +}
> +module_init(hbm_cache_module_init);
> +
> +static void __exit hbm_cache_module_exit(void)
> +{
> +	kobject_put(cache_kobj);
> +	platform_driver_unregister(&hbm_cache_driver);
> +}
> +module_exit(hbm_cache_module_exit);
> +MODULE_LICENSE("GPL");



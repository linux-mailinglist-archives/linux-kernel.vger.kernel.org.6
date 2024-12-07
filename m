Return-Path: <linux-kernel+bounces-436093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA39E8114
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C4C281E35
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50914A0BC;
	Sat,  7 Dec 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="SliPTGqP"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAC288DB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590210; cv=none; b=h7iHwWSZIWHomo1DqlvlO/vpXBDgoGy0vyvN2rt6J0MEv3oWYv+Qsk5Ul+r6GCtXA+11lUV/R6YPiLsaUlHBVmxLQSEzrCtVH9cEa7xbmdVj5IeAx4IQX5s8VyJm8horuH8MCWdaCzyuKDmThK+qadTYe4WUU4bYOxGR3Ur5s0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590210; c=relaxed/simple;
	bh=CeuEE6NddZvqu3SmpdjqFHL0ySySgjHHwP7ojD44oRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQ/+07RAj8ZCkxGmr3rSlH0uIX4Ml9HUq/3jdXF9EB7+BQ6GbWBjhDPfJcC3xkeU9W/Xl9nJ5VpUerSqF1AD/orTtYOIEG/nLpOuNB4EcHGCiEs9tv0InRSO8923wh7+7PCm1uLUspXjc42YSbPNr2dLmC4Wvf8JsbpAMfyypAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=SliPTGqP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46727cc31ecso31205591cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1733590206; x=1734195006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFm28P36svfcTImjkItwRJEmr3jVhs9Tmk3fs0ZS2kM=;
        b=SliPTGqPqEpfhYc3SGSL1LQuldK0GSFAAudCqH4hCIojKX1YYR10b8ArC7TJNxFkLo
         gerdvlQ90K8OW9Gkbja0odVMkWXSYs7tvuwkfQAD8D84hWK7w9DNZWi/RFlfLdf6ZDrs
         X5s/FrPQFsnuWY+WLgXYTdwoJ5hqOL7eXqFKsj+4hyfSLn3DdWEDL617ZTDObgMXwSG0
         CiQwUKNL5wgHSjRAPfq8VUXfDJG5aUscLmf2hI7k5NL019D/q4KHhf2x9T1KYAnrCJn/
         iC1D5bGfFQAqeI8hijC+Gpla4mmtPO4hCbtQ2ewF+0manHo3+pVdrEbGF0f1r6d4Vxg5
         Jlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733590206; x=1734195006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFm28P36svfcTImjkItwRJEmr3jVhs9Tmk3fs0ZS2kM=;
        b=OUDiro7Meb09C5IYnk64+BxHnKoX+0CfelRRb1d51Mlr0KBy8B8fzWRlurXMmWxi2y
         0IzpLGb8bd6yR5+eHtlC/qbIRbpe+u9KEHOTPaLovr4wwdaPiwAsM0AWNJVGFY46f8yr
         ZVOzCNVNpkWQylFVyhhQ6vvfq/cN6s8+WcnOEsYt79y4eNtZvKis2CrsB9BSqEg/rMPn
         pimmyeCpgPgwSiUjYCby8LeYD6n757ZWwKy+TzCUzeLqENCCbbm9hxisMeS5roaT3KBz
         QrsKtTQXIdLTq8VnjoP67r64LwFnqKXKkKl/mS1g/2khN8qWkO4gOcSbAP075ETEvC0L
         FCUw==
X-Gm-Message-State: AOJu0YzkDOLu7FjfVKN7KY/Z+f0/VZAxtjXPOB/gsHzHxyMfzotdL30k
	vZO55gUIVqGP+TzvhOA1FUk97nktiOmy/S+Ia+UdjE35EtN0UvP3zfoxnnchk4u21GoJowJDzH1
	jQjI=
X-Gm-Gg: ASbGncv0bMQbV1367tl8xKaR0Zib2ukDG0IgrOHzzbiMXXLsTq9H3z8FqRZ5fyrdVJY
	Wccf03M9z/V/ujN8Zks7oZzreWcw59/1FuwajSxSv7PNZAyZz93uYkmDMaFN/Xe/oSRG2cXMp9u
	btFKtGfewwy2rQR2rtWYbgA8Df0XYq5AlYV//FjAMwBsT72uqqRIKpv3TByuHdVpzCya0WobyFp
	IVjdXyV7N3ZnI9ykAgGywf9ifBSGZgLYpJL07OZWdGCeIYtEKZAfKT/F6BzfNIjac18HfvheMYe
	vkNkxF6U0vwJbg==
X-Google-Smtp-Source: AGHT+IFSVEpO3kE6OeBtUPxv03vW/+N/p/2/yYj0gAKnI65PWF8uctbEuhT06KQlJ6TKCIOotoGuHg==
X-Received: by 2002:a05:622a:58e:b0:466:948e:bef6 with SMTP id d75a77b69052e-46734deb2c5mr134782151cf.43.1733590206571;
        Sat, 07 Dec 2024 08:50:06 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4672971b9c5sm33093761cf.53.2024.12.07.08.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 08:50:06 -0800 (PST)
Message-ID: <a0723caf-cd01-4ff3-b85c-d0e5a4c345ff@riscstar.com>
Date: Sat, 7 Dec 2024 10:50:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: hisilicon: kunpeng_hbmdev: Add support for
 controling the power of hbm memory
To: Zhang Zekun <zhangzekun11@huawei.com>, xuwei5@hisilicon.com,
 lihuisong@huawei.com, Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
References: <20241206112812.32618-1-zhangzekun11@huawei.com>
 <20241206112812.32618-2-zhangzekun11@huawei.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20241206112812.32618-2-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 5:28 AM, Zhang Zekun wrote:
> Add a driver for High Bandwidth Memory (HBM) devices, which will provide
> user space interfaces to power on/off the HBM devices. In Kunpeng servers,
> we need to control the power of HBM devices which can be power consuming
> and will only be used in some specialized scenarios, such as HPC. HBM
> memory devices in a socket are in the same power domain, and should be
> power off/on together.
> 
> HBM devices will be configured with ACPI device id "PNP0C80", and be used
> as a cpuless numa node. HBM devices in the same power domain will be put
> into the same container. ACPI function "_ON" and "_OFF" are reponsible
> for power on/off the HBM device, and notify the OS to fully online/offline
> the HBM memory.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>   MAINTAINERS                            |   6 +
>   drivers/soc/hisilicon/Kconfig          |  12 ++
>   drivers/soc/hisilicon/Makefile         |   1 +
>   drivers/soc/hisilicon/kunpeng_hbm.h    |  31 ++++
>   drivers/soc/hisilicon/kunpeng_hbmdev.c | 210 +++++++++++++++++++++++++
>   5 files changed, 260 insertions(+)
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hbm.h
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hbmdev.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0456a33ef657..e8b4cf7d7162 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10283,6 +10283,12 @@ F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
>   F:	drivers/soc/hisilicon/kunpeng_hccs.c
>   F:	drivers/soc/hisilicon/kunpeng_hccs.h
>   
> +HISILICON KUNPENG SOC KUNPENG HBMDEV DRIVER
> +M:	Zhang Zekun <zhangzekun11@huawei.com>
> +S:	Maintained
> +F:	drivers/soc/hisilicon/kunpeng_hbm.h
> +F:	drivers/soc/hisilicon/kunpeng_hbmdev.c
> +
>   HISILICON LPC BUS DRIVER
>   M:	Jay Fang <f.fangjian@huawei.com>
>   S:	Maintained
> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
> index 6d7c244d2e78..b3ca7d6f5d01 100644
> --- a/drivers/soc/hisilicon/Kconfig
> +++ b/drivers/soc/hisilicon/Kconfig
> @@ -21,4 +21,16 @@ config KUNPENG_HCCS
>   	  health status and port information of HCCS, or reducing system
>   	  power consumption on Kunpeng SoC.
>   
> +config KUNPENG_HBMDEV
> +	bool "add extra support for hbm memory device"

s/add extra/Add/
s/hbm/HBM

Can there be more than one HBM memory device?  If so:
s/device/devices/

> +	depends on ACPI_HOTPLUG_MEMORY
> +	select ACPI_CONTAINER
> +	help
> +	  The driver provides methods for userpace to control the power
> +	  of HBM memory devices on Kunpeng soc, which can help to save

Perhaps you can expand "HBM" here to be "high-bandwidth memory (HBM)".

> +	  energy. The functionality of the driver would require dedicated
> +	  BIOS configuration.
> +
> +	  If not sure, say N.
> +
>   endmenu
> diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
> index 226e747e70d6..08048d73586e 100644
> --- a/drivers/soc/hisilicon/Makefile
> +++ b/drivers/soc/hisilicon/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_KUNPENG_HCCS)	+= kunpeng_hccs.o
> +obj-$(CONFIG_KUNPENG_HBMDEV)	+= kunpeng_hbmdev.o
> diff --git a/drivers/soc/hisilicon/kunpeng_hbm.h b/drivers/soc/hisilicon/kunpeng_hbm.h
> new file mode 100644
> index 000000000000..ef306c888480
> --- /dev/null
> +++ b/drivers/soc/hisilicon/kunpeng_hbm.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024. Huawei Technologies Co., Ltd
> + */
> +
> +#ifndef _HISI_INTERNAL_H
> +#define _HISI_INTERNAL_H
> +
> +enum {
> +	STATE_ONLINE,

While it technically doesn't matter, I would rather see 0 mean
offline, 1 mean online.  It suggests that the default state is
most likely offline as well.

> +	STATE_OFFLINE,

Do you anticipate that the state of an HBM device will be
anything other than online or offline?  (For example, it
could be in error state, or some other degraded state or
something.)  If not, this would be better implemented
simply as a Boolean attribute instead (with a name that
makes sense, such as "online" rather than "state").  It
would eliminate the need for the function defined below.

> +};
> +
> +static const char *const online_type_to_str[] = {
> +	[STATE_ONLINE] = "online",
> +	[STATE_OFFLINE] = "offline",
> +};
> +
> +static inline int online_type_from_str(const char *str)

Why is this inlined here, rather than just making it a
proper function?

> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(online_type_to_str); i++) {
> +		if (sysfs_streq(str, online_type_to_str[i]))
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +#endif
> diff --git a/drivers/soc/hisilicon/kunpeng_hbmdev.c b/drivers/soc/hisilicon/kunpeng_hbmdev.c
> new file mode 100644
> index 000000000000..1945676ff502
> --- /dev/null
> +++ b/drivers/soc/hisilicon/kunpeng_hbmdev.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Huawei Technologies Co., Ltd
> + */
> +
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/nodemask.h>
> +#include <linux/acpi.h>
> +#include <linux/container.h>
> +
> +#include "kunpeng_hbm.h"
> +
> +#define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
> +#define ACPI_GENERIC_CONTAINER_DEVICE_HID	"PNP0A06"
> +
> +struct cdev_node {
> +	struct device *dev;
> +	struct list_head clist;
> +};
> +
> +struct cdev_node cdev_list;

This should be defined with private (static) scope.

Why isn't this just a struct list_head?  You don't ever use
the dev field in this list header, right?.  And in that case
you could define this with:

     static LIST_HEAD(cdev_list);

> +
> +static int get_pxm(struct acpi_device *acpi_device, void *arg)
> +{
> +	acpi_handle handle = acpi_device->handle;
> +	nodemask_t *mask = arg;
> +	unsigned long long sta;
> +	acpi_status status;
> +	int nid;
> +
> +	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
> +	if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_ENABLED)) {
> +		nid = acpi_get_node(handle);
> +		if (nid != NUMA_NO_NODE)
> +			node_set(nid, *mask);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t pxms_show(struct device *dev,
> +			 struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	nodemask_t mask;
> +
> +	nodes_clear(mask);
> +	acpi_dev_for_each_child(adev, get_pxm, &mask);
> +
> +	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&mask));
> +}
> +static DEVICE_ATTR_RO(pxms);
> +
> +static int memdev_power_on(struct acpi_device *adev)
> +{
> +	acpi_handle handle = adev->handle;
> +	acpi_status status;
> +
> +	/* Power on and online the devices */
> +	status = acpi_evaluate_object(handle, "_ON", NULL, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_warn(handle, "Power on failed (0x%x)\n", status);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hbmdev_check(struct acpi_device *adev, void *arg)
> +{
> +	const char *hid = acpi_device_hid(adev);
> +
> +	if (!strcmp(hid, ACPI_MEMORY_DEVICE_HID)) {
> +		bool *found = arg;
> +		*found = true;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int memdev_power_off(struct acpi_device *adev)
> +{
> +	acpi_handle handle = adev->handle;
> +	acpi_status status;
> +
> +	/* Eject the devices and power off */
> +	status = acpi_evaluate_object(handle, "_OFF", NULL, NULL);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	const int type = online_type_from_str(buf);
> +	int ret = -EINVAL;

This assignment is overwritten immediately, so don't bother.

> +
> +	/*
> +	 * Take the lock to avoid race on underlying PCC operation region
> +	 * used in ACPI function "_ON" and "_OFF".
> +	 */
> +	ret = lock_device_hotplug_sysfs();
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case STATE_ONLINE:
> +		ret = memdev_power_on(adev);
> +		break;
> +	case STATE_OFFLINE:
> +		ret  = memdev_power_off(adev);
> +		break;
> +	default:

		ret = -EINVAL;

> +		break;
> +	}
> +	unlock_device_hotplug();
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(state);
> +
> +static bool has_hbmdev(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	const char *hid = acpi_device_hid(adev);
> +	bool found = false;
> +
> +	if (strcmp(hid, ACPI_GENERIC_CONTAINER_DEVICE_HID))
> +		return found;

		return false;

OR maybe better, just do this:

     if (!strcmp(hid, ACPI_GENERIC_CONTAINER_DEVICE_HID))
         acpi_dev_for_each_child(adev, hbmdev_check, &found);

     return found;

> +
> +	acpi_dev_for_each_child(adev, hbmdev_check, &found);
> +	return found;
> +}
> +
> +static int container_add(struct device *dev, void *data)
> +{
> +	struct cdev_node *cnode;
> +
> +	if (!has_hbmdev(dev))
> +		return 0;
> +
> +	cnode = kmalloc(sizeof(struct cdev_node), GFP_KERNEL);
> +	if (!cnode)
> +		return -ENOMEM;
> +
> +	cnode->dev = dev;
> +	list_add_tail(&cnode->clist, &cdev_list.clist);
> +
> +	return 0;
> +}
> +
> +static void container_remove(void)

You add just one device in container_add(), but remove all devices
in this function.  Maybe differentiate the names, e.g. use
container_add_one() or container_remove_all() or something.

					-Alex

> +{
> +	struct cdev_node *cnode, *tmp;
> +
> +	list_for_each_entry_safe(cnode, tmp, &cdev_list.clist, clist) {
> +		device_remove_file(cnode->dev, &dev_attr_state);
> +		device_remove_file(cnode->dev, &dev_attr_pxms);
> +		list_del(&cnode->clist);
> +		kfree(cnode);
> +	}
> +}
> +
> +static int container_init(void)
> +{
> +	struct cdev_node *cnode;
> +
> +	INIT_LIST_HEAD(&cdev_list.clist);
> +
> +	if (bus_for_each_dev(&container_subsys, NULL, NULL, container_add)) {
> +		container_remove();
> +		return -ENOMEM;
> +	}
> +
> +	if (list_empty(&cdev_list.clist))
> +		return -ENODEV;
> +
> +	list_for_each_entry(cnode, &cdev_list.clist, clist) {
> +		device_create_file(cnode->dev, &dev_attr_state);
> +		device_create_file(cnode->dev, &dev_attr_pxms);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct acpi_platform_list kunpeng_hbm_plat_info[] = {
> +	{"HISI  ", "HIP11   ", 0, ACPI_SIG_IORT, all_versions, NULL, 0},
> +	{ }
> +};
> +
> +static int __init hbmdev_init(void)
> +{
> +	if (acpi_match_platform_list(kunpeng_hbm_plat_info) < 0)
> +		return 0;
> +
> +	return container_init();
> +}
> +module_init(hbmdev_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhang Zekun <zhangzekun11@huawei.com>");



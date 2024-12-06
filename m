Return-Path: <linux-kernel+bounces-434958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0199E6D72
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32F328101B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C701FF612;
	Fri,  6 Dec 2024 11:34:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FF17E4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484874; cv=none; b=NYdZzfWEGjE2YOXmzeC2WWkeNyghjBjrtOSUyeQV/eyo8Y2dE8OH85b/Z6sPnXP5B6T4VimcvLh1EmGMLmYPmTh5c2pMsga/RCY5MyKxqT6YEUCLOy2R1fDVe/6DpmOOmj7NjrD8npzxUmhb3GkBA2CtmVjyRVLsvsWEhAEacpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484874; c=relaxed/simple;
	bh=b5DtsCuTsjGEzom/MhfXDqShQZWcfcQKHHns/CXIM1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlMxLTqG2aUS+2iqfP0Khi77czk+Wg67L87KjrHfrk6eN7R2YWc2ripVXhZtiyF3i1yl+W1QMzvd7rY8YivqZL+Ynyy1rYHcWF/nGZAh16WW8WX76opntAp2CU3Hx+6ZpsIFNZbhCw/0PuyhpU+Gg96OFzL2EoyMOYQfF46e6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y4Tcn4QCfzhZPg
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:32:09 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id DA448180102
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:34:28 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 19:34:28 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <xuwei5@hisilicon.com>, <lihuisong@huawei.com>,
	<Jonathan.Cameron@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: [PATCH 1/2] soc: hisilicon: kunpeng_hbmdev: Add support for controling the power of hbm memory
Date: Fri, 6 Dec 2024 19:28:11 +0800
Message-ID: <20241206112812.32618-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241206112812.32618-1-zhangzekun11@huawei.com>
References: <20241206112812.32618-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Add a driver for High Bandwidth Memory (HBM) devices, which will provide
user space interfaces to power on/off the HBM devices. In Kunpeng servers,
we need to control the power of HBM devices which can be power consuming
and will only be used in some specialized scenarios, such as HPC. HBM
memory devices in a socket are in the same power domain, and should be
power off/on together.

HBM devices will be configured with ACPI device id "PNP0C80", and be used
as a cpuless numa node. HBM devices in the same power domain will be put
into the same container. ACPI function "_ON" and "_OFF" are reponsible
for power on/off the HBM device, and notify the OS to fully online/offline
the HBM memory.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 MAINTAINERS                            |   6 +
 drivers/soc/hisilicon/Kconfig          |  12 ++
 drivers/soc/hisilicon/Makefile         |   1 +
 drivers/soc/hisilicon/kunpeng_hbm.h    |  31 ++++
 drivers/soc/hisilicon/kunpeng_hbmdev.c | 210 +++++++++++++++++++++++++
 5 files changed, 260 insertions(+)
 create mode 100644 drivers/soc/hisilicon/kunpeng_hbm.h
 create mode 100644 drivers/soc/hisilicon/kunpeng_hbmdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0456a33ef657..e8b4cf7d7162 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10283,6 +10283,12 @@ F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
 F:	drivers/soc/hisilicon/kunpeng_hccs.c
 F:	drivers/soc/hisilicon/kunpeng_hccs.h
 
+HISILICON KUNPENG SOC KUNPENG HBMDEV DRIVER
+M:	Zhang Zekun <zhangzekun11@huawei.com>
+S:	Maintained
+F:	drivers/soc/hisilicon/kunpeng_hbm.h
+F:	drivers/soc/hisilicon/kunpeng_hbmdev.c
+
 HISILICON LPC BUS DRIVER
 M:	Jay Fang <f.fangjian@huawei.com>
 S:	Maintained
diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
index 6d7c244d2e78..b3ca7d6f5d01 100644
--- a/drivers/soc/hisilicon/Kconfig
+++ b/drivers/soc/hisilicon/Kconfig
@@ -21,4 +21,16 @@ config KUNPENG_HCCS
 	  health status and port information of HCCS, or reducing system
 	  power consumption on Kunpeng SoC.
 
+config KUNPENG_HBMDEV
+	bool "add extra support for hbm memory device"
+	depends on ACPI_HOTPLUG_MEMORY
+	select ACPI_CONTAINER
+	help
+	  The driver provides methods for userpace to control the power
+	  of HBM memory devices on Kunpeng soc, which can help to save
+	  energy. The functionality of the driver would require dedicated
+	  BIOS configuration.
+
+	  If not sure, say N.
+
 endmenu
diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
index 226e747e70d6..08048d73586e 100644
--- a/drivers/soc/hisilicon/Makefile
+++ b/drivers/soc/hisilicon/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_KUNPENG_HCCS)	+= kunpeng_hccs.o
+obj-$(CONFIG_KUNPENG_HBMDEV)	+= kunpeng_hbmdev.o
diff --git a/drivers/soc/hisilicon/kunpeng_hbm.h b/drivers/soc/hisilicon/kunpeng_hbm.h
new file mode 100644
index 000000000000..ef306c888480
--- /dev/null
+++ b/drivers/soc/hisilicon/kunpeng_hbm.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024. Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HISI_INTERNAL_H
+#define _HISI_INTERNAL_H
+
+enum {
+	STATE_ONLINE,
+	STATE_OFFLINE,
+};
+
+static const char *const online_type_to_str[] = {
+	[STATE_ONLINE] = "online",
+	[STATE_OFFLINE] = "offline",
+};
+
+static inline int online_type_from_str(const char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(online_type_to_str); i++) {
+		if (sysfs_streq(str, online_type_to_str[i]))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+#endif
diff --git a/drivers/soc/hisilicon/kunpeng_hbmdev.c b/drivers/soc/hisilicon/kunpeng_hbmdev.c
new file mode 100644
index 000000000000..1945676ff502
--- /dev/null
+++ b/drivers/soc/hisilicon/kunpeng_hbmdev.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Huawei Technologies Co., Ltd
+ */
+
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/nodemask.h>
+#include <linux/acpi.h>
+#include <linux/container.h>
+
+#include "kunpeng_hbm.h"
+
+#define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
+#define ACPI_GENERIC_CONTAINER_DEVICE_HID	"PNP0A06"
+
+struct cdev_node {
+	struct device *dev;
+	struct list_head clist;
+};
+
+struct cdev_node cdev_list;
+
+static int get_pxm(struct acpi_device *acpi_device, void *arg)
+{
+	acpi_handle handle = acpi_device->handle;
+	nodemask_t *mask = arg;
+	unsigned long long sta;
+	acpi_status status;
+	int nid;
+
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_ENABLED)) {
+		nid = acpi_get_node(handle);
+		if (nid != NUMA_NO_NODE)
+			node_set(nid, *mask);
+	}
+
+	return 0;
+}
+
+static ssize_t pxms_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	nodemask_t mask;
+
+	nodes_clear(mask);
+	acpi_dev_for_each_child(adev, get_pxm, &mask);
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&mask));
+}
+static DEVICE_ATTR_RO(pxms);
+
+static int memdev_power_on(struct acpi_device *adev)
+{
+	acpi_handle handle = adev->handle;
+	acpi_status status;
+
+	/* Power on and online the devices */
+	status = acpi_evaluate_object(handle, "_ON", NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_warn(handle, "Power on failed (0x%x)\n", status);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int hbmdev_check(struct acpi_device *adev, void *arg)
+{
+	const char *hid = acpi_device_hid(adev);
+
+	if (!strcmp(hid, ACPI_MEMORY_DEVICE_HID)) {
+		bool *found = arg;
+		*found = true;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int memdev_power_off(struct acpi_device *adev)
+{
+	acpi_handle handle = adev->handle;
+	acpi_status status;
+
+	/* Eject the devices and power off */
+	status = acpi_evaluate_object(handle, "_OFF", NULL, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+static ssize_t state_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	const int type = online_type_from_str(buf);
+	int ret = -EINVAL;
+
+	/*
+	 * Take the lock to avoid race on underlying PCC operation region
+	 * used in ACPI function "_ON" and "_OFF".
+	 */
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case STATE_ONLINE:
+		ret = memdev_power_on(adev);
+		break;
+	case STATE_OFFLINE:
+		ret  = memdev_power_off(adev);
+		break;
+	default:
+		break;
+	}
+	unlock_device_hotplug();
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(state);
+
+static bool has_hbmdev(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	const char *hid = acpi_device_hid(adev);
+	bool found = false;
+
+	if (strcmp(hid, ACPI_GENERIC_CONTAINER_DEVICE_HID))
+		return found;
+
+	acpi_dev_for_each_child(adev, hbmdev_check, &found);
+	return found;
+}
+
+static int container_add(struct device *dev, void *data)
+{
+	struct cdev_node *cnode;
+
+	if (!has_hbmdev(dev))
+		return 0;
+
+	cnode = kmalloc(sizeof(struct cdev_node), GFP_KERNEL);
+	if (!cnode)
+		return -ENOMEM;
+
+	cnode->dev = dev;
+	list_add_tail(&cnode->clist, &cdev_list.clist);
+
+	return 0;
+}
+
+static void container_remove(void)
+{
+	struct cdev_node *cnode, *tmp;
+
+	list_for_each_entry_safe(cnode, tmp, &cdev_list.clist, clist) {
+		device_remove_file(cnode->dev, &dev_attr_state);
+		device_remove_file(cnode->dev, &dev_attr_pxms);
+		list_del(&cnode->clist);
+		kfree(cnode);
+	}
+}
+
+static int container_init(void)
+{
+	struct cdev_node *cnode;
+
+	INIT_LIST_HEAD(&cdev_list.clist);
+
+	if (bus_for_each_dev(&container_subsys, NULL, NULL, container_add)) {
+		container_remove();
+		return -ENOMEM;
+	}
+
+	if (list_empty(&cdev_list.clist))
+		return -ENODEV;
+
+	list_for_each_entry(cnode, &cdev_list.clist, clist) {
+		device_create_file(cnode->dev, &dev_attr_state);
+		device_create_file(cnode->dev, &dev_attr_pxms);
+	}
+
+	return 0;
+}
+
+static struct acpi_platform_list kunpeng_hbm_plat_info[] = {
+	{"HISI  ", "HIP11   ", 0, ACPI_SIG_IORT, all_versions, NULL, 0},
+	{ }
+};
+
+static int __init hbmdev_init(void)
+{
+	if (acpi_match_platform_list(kunpeng_hbm_plat_info) < 0)
+		return 0;
+
+	return container_init();
+}
+module_init(hbmdev_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zhang Zekun <zhangzekun11@huawei.com>");
-- 
2.17.1



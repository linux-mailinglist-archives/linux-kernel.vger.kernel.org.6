Return-Path: <linux-kernel+bounces-434960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EDC9E6D73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7871884714
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C2200124;
	Fri,  6 Dec 2024 11:34:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1B1FC10D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484874; cv=none; b=ZMW2mRk771KzpRYfIJo9cI+ePZOzvkvQfH3svAa6txes50clfg3aX2BWf8iT7oPAGliRtxTyfzVlBLrCuAtFVX+kNjc4UMQk5QfW/6hc8kk3NO/6fZ+nlxyaScUhPutcWyXqQFR+uDXvvasjUiXzGlMev6pdSMt0uwf/O2Sx2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484874; c=relaxed/simple;
	bh=Tn34KyaGLpcxh2ks7RJY5yhaVAyPtm8N19I39u7IGdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2uWom9F6Y55o2aR+lS6DRwxLgYOIf2RroG/Z3PAkzy5mA/OlyydpcFjCywjFz8JbnSY6d5hcrabn/cTgS9y6LKurjXMSegIC5EWAxQwOEOJj5s95qQ+BYFGUfhxzH2ciyXcuSWrgl9ZFmuXyVkPUJi3T4+3Prxsk6a0ORzqTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y4Tc209rqz11M1L
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:31:30 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 7252C180064
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:34:29 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 19:34:28 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <xuwei5@hisilicon.com>, <lihuisong@huawei.com>,
	<Jonathan.Cameron@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: [PATCH 2/2] soc: hisilicon: kunpeng_hbmcache: Add support for online and offline the hbm cache
Date: Fri, 6 Dec 2024 19:28:12 +0800
Message-ID: <20241206112812.32618-3-zhangzekun11@huawei.com>
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

Add a driver for High Bandwidth Memory (HBM) cache, which provides user
space interfaces to power on/off the HBM cache. Use HBM as a cache can
take advantage of the high bandwidth of HBM in normal memory access, and
OS does not need to aware of the existence of HBM cache. For workloads
which does not require a high memory access bandwidth, power off the HBM
cache device can help save energy.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 MAINTAINERS                              |   3 +-
 drivers/soc/hisilicon/Kconfig            |  11 ++
 drivers/soc/hisilicon/Makefile           |   1 +
 drivers/soc/hisilicon/kunpeng_hbmcache.c | 136 +++++++++++++++++++++++
 4 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/hisilicon/kunpeng_hbmcache.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e8b4cf7d7162..4819d04badd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10283,10 +10283,11 @@ F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
 F:	drivers/soc/hisilicon/kunpeng_hccs.c
 F:	drivers/soc/hisilicon/kunpeng_hccs.h
 
-HISILICON KUNPENG SOC KUNPENG HBMDEV DRIVER
+HISILICON KUNPENG SOC KUNPENG HBM DRIVER
 M:	Zhang Zekun <zhangzekun11@huawei.com>
 S:	Maintained
 F:	drivers/soc/hisilicon/kunpeng_hbm.h
+F:	drivers/soc/hisilicon/kunpeng_hbmcache.c
 F:	drivers/soc/hisilicon/kunpeng_hbmdev.c
 
 HISILICON LPC BUS DRIVER
diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
index b3ca7d6f5d01..f12f3e42d908 100644
--- a/drivers/soc/hisilicon/Kconfig
+++ b/drivers/soc/hisilicon/Kconfig
@@ -21,6 +21,17 @@ config KUNPENG_HCCS
 	  health status and port information of HCCS, or reducing system
 	  power consumption on Kunpeng SoC.
 
+config KUNPENG_HBMCACHE
+	tristate "HBM cache memory device"
+	depends on ACPI
+	help
+	  This driver provids methods to control the power of High Bandwidth
+	  Memory (HBM) cache device in Kunpeng SoC. Use HBM as a cache can
+	  take advantage of the high bandwidth of HBM in normal memory access.
+
+	  To compile the driver as a module, choose M here:
+	  the module will be called kunpeng_hbmcache.
+
 config KUNPENG_HBMDEV
 	bool "add extra support for hbm memory device"
 	depends on ACPI_HOTPLUG_MEMORY
diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
index 08048d73586e..b7c7c1682979 100644
--- a/drivers/soc/hisilicon/Makefile
+++ b/drivers/soc/hisilicon/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_KUNPENG_HCCS)	+= kunpeng_hccs.o
 obj-$(CONFIG_KUNPENG_HBMDEV)	+= kunpeng_hbmdev.o
+obj-$(CONFIG_KUNPENG_HBMCACHE)	+= kunpeng_hbmcache.o
diff --git a/drivers/soc/hisilicon/kunpeng_hbmcache.c b/drivers/soc/hisilicon/kunpeng_hbmcache.c
new file mode 100644
index 000000000000..32eb7e781fd7
--- /dev/null
+++ b/drivers/soc/hisilicon/kunpeng_hbmcache.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024. Huawei Technologies Co., Ltd
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+
+#include "kunpeng_hbm.h"
+
+#define MODULE_NAME            "hbm_cache"
+
+static struct kobject *cache_kobj;
+static struct mutex cache_lock;
+
+static ssize_t state_store(struct device *d, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct acpi_device *adev = ACPI_COMPANION(d);
+	const int type = online_type_from_str(buf);
+	acpi_handle handle = adev->handle;
+	acpi_status status = AE_OK;
+
+	if (!mutex_trylock(&cache_lock))
+		return restart_syscall();
+
+	switch (type) {
+	case STATE_ONLINE:
+		status = acpi_evaluate_object(handle, "_ON", NULL, NULL);
+		break;
+	case STATE_OFFLINE:
+		status = acpi_evaluate_object(handle, "_OFF", NULL, NULL);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&cache_lock);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return count;
+}
+static DEVICE_ATTR_WO(state);
+
+static ssize_t socket_id_show(struct device *d, struct device_attribute *attr,
+				char *buf)
+{
+	int socket_id;
+
+	if (device_property_read_u32(d, "socket_id", &socket_id))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%d\n", socket_id);
+}
+static DEVICE_ATTR_RO(socket_id);
+
+static struct attribute *attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_socket_id.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = attrs,
+};
+
+static int cache_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &attr_group);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(cache_kobj,
+				&pdev->dev.kobj,
+				kobject_name(&pdev->dev.kobj));
+	if (ret) {
+		sysfs_remove_group(&pdev->dev.kobj, &attr_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cache_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
+	sysfs_remove_link(&pdev->dev.kobj,
+			  kobject_name(&pdev->dev.kobj));
+}
+
+static const struct acpi_device_id cache_acpi_ids[] = {
+	{"HISI04A1", 0},
+	{"", 0},
+};
+
+static struct platform_driver hbm_cache_driver = {
+	.probe = cache_probe,
+	.remove = cache_remove,
+	.driver = {
+		.name = MODULE_NAME,
+		.acpi_match_table = ACPI_PTR(cache_acpi_ids),
+	},
+};
+
+static int __init hbm_cache_module_init(void)
+{
+	int ret;
+
+	cache_kobj = kobject_create_and_add("hbm_cache", kernel_kobj);
+	if (!cache_kobj)
+		return -ENOMEM;
+
+	mutex_init(&cache_lock);
+
+	ret = platform_driver_register(&hbm_cache_driver);
+	if (ret) {
+		kobject_put(cache_kobj);
+		return ret;
+	}
+	return 0;
+}
+module_init(hbm_cache_module_init);
+
+static void __exit hbm_cache_module_exit(void)
+{
+	kobject_put(cache_kobj);
+	platform_driver_unregister(&hbm_cache_driver);
+}
+module_exit(hbm_cache_module_exit);
+MODULE_LICENSE("GPL");
-- 
2.17.1



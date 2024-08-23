Return-Path: <linux-kernel+bounces-298192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30495C3AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A991C223D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C994CB37;
	Fri, 23 Aug 2024 03:21:00 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE12BAE8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383260; cv=none; b=Wu3L2uOC7r6LbfuellOMG7Asc2UOWvlDW77DswSFUFdO77QMUKnuxIRQDaYI4WZO/H1a20Ml2X8vhp9AEAyVUNRSiGM/szy961bu/WZteq45jtnjdbGfcHYvYbrxnLnBJtppqPo/NVa+sr0P1IEhi4PSrFXSaYG5R+gpF/dVjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383260; c=relaxed/simple;
	bh=ZTdXaFQAKfVbq+jsAW5QAtqYB7uhOvB1+SU1poiIj7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7XIBfg9KGIddrxJXvWIjRKEGUyIhkniAxPkAET5+C9TrjB8tHdd1iY+sEI8PemXrhtqCIqYQiuy6yL41HNeTqvMWvdDQfbS7ddEhDLgS+vgDeZngtkaKNIgTWxrh5zYmGbssIpripDbpabiaYfcEQjSsQhzK6T+3MeRmUZfUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqlhM2llrz2Cn6n;
	Fri, 23 Aug 2024 11:20:51 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id D4FE91A016C;
	Fri, 23 Aug 2024 11:20:55 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:20:55 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 5/6] soc: hisilicon: kunpeng_hccs: Add used HCCS types sysfs
Date: Fri, 23 Aug 2024 11:10:58 +0800
Message-ID: <20240823031059.32579-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240823031059.32579-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240823031059.32579-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Current, to find which HCC types are used on the platform the user needs
to scan the type attribute of all ports, which is unfriendly to the user.
So add the sysfs to show all HCCS types used on the platform.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../sysfs-devices-platform-kunpeng_hccs       |   8 ++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 102 +++++++++++++++++-
 drivers/soc/hisilicon/kunpeng_hccs.h          |  15 +++
 3 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
index 1666340820f7..d4c355e0e0bb 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
+++ b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
@@ -79,3 +79,11 @@ Description:
 			           indicates a lane.
 		crc_err_cnt:  (RO) CRC err count on this port.
 		============= ==== =============================================
+
+What:		/sys/devices/platform/HISI04Bx:00/used_types
+Date:		August 2024
+KernelVersion:	6.12
+Contact:	Huisong Li <lihuisong@huawei.com>
+Description:
+		This interface is used to show all HCCS types used on the
+		platform, like, HCCS-v1, HCCS-v2 and so on.
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 418e4ee5d9e5..623e7b7ed39a 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -21,11 +21,14 @@
  *    - if all enabled ports are in linked
  *    - if all linked ports are in full lane
  *    - CRC error count sum
+ *
+ * - Retrieve all HCCS types used on the platform.
  */
 #include <linux/acpi.h>
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <acpi/pcc.h>
 
@@ -53,6 +56,15 @@ static struct hccs_chip_info *kobj_to_chip_info(struct kobject *k)
 	return container_of(k, struct hccs_chip_info, kobj);
 }
 
+static struct hccs_dev *device_kobj_to_hccs_dev(struct kobject *k)
+{
+	struct device *dev = container_of(k, struct device, kobj);
+	struct platform_device *pdev =
+			container_of(dev, struct platform_device, dev);
+
+	return platform_get_drvdata(pdev);
+}
+
 struct hccs_register_ctx {
 	struct device *dev;
 	u8 chan_id;
@@ -670,6 +682,55 @@ static int hccs_get_hw_info(struct hccs_dev *hdev)
 	return 0;
 }
 
+static u16 hccs_calc_used_type_num(struct hccs_dev *hdev,
+				   unsigned long *hccs_ver)
+{
+	struct hccs_chip_info *chip;
+	struct hccs_port_info *port;
+	struct hccs_die_info *die;
+	u16 used_type_num = 0;
+	u16 i, j, k;
+
+	for (i = 0; i < hdev->chip_num; i++) {
+		chip = &hdev->chips[i];
+		for (j = 0; j < chip->die_num; j++) {
+			die = &chip->dies[j];
+			for (k = 0; k < die->port_num; k++) {
+				port = &die->ports[k];
+				set_bit(port->port_type, hccs_ver);
+			}
+		}
+	}
+
+	for_each_set_bit(i, hccs_ver, HCCS_IP_MAX + 1)
+		used_type_num++;
+
+	return used_type_num;
+}
+
+static int hccs_init_type_name_maps(struct hccs_dev *hdev)
+{
+	DECLARE_BITMAP(hccs_ver, HCCS_IP_MAX + 1) = {};
+	unsigned int i;
+	u16 idx = 0;
+
+	hdev->used_type_num = hccs_calc_used_type_num(hdev, hccs_ver);
+	hdev->type_name_maps = devm_kcalloc(hdev->dev, hdev->used_type_num,
+					    sizeof(struct hccs_type_name_map),
+					    GFP_KERNEL);
+	if (!hdev->type_name_maps)
+		return -ENOMEM;
+
+	for_each_set_bit(i, hccs_ver, HCCS_IP_MAX + 1) {
+		hdev->type_name_maps[idx].type = i;
+		sprintf(hdev->type_name_maps[idx].name,
+			"%s%u", HCCS_IP_PREFIX, i);
+		idx++;
+	}
+
+	return 0;
+}
+
 static int hccs_query_port_link_status(struct hccs_dev *hdev,
 				       const struct hccs_port_info *port,
 				       struct hccs_link_status *link_status)
@@ -830,7 +891,7 @@ static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	const struct hccs_port_info *port = kobj_to_port_info(kobj);
 
-	return sysfs_emit(buf, "HCCS-v%u\n", port->port_type);
+	return sysfs_emit(buf, "%s%u\n", HCCS_IP_PREFIX, port->port_type);
 }
 static struct kobj_attribute hccs_type_attr = __ATTR_RO(type);
 
@@ -1134,6 +1195,33 @@ static const struct kobj_type hccs_chip_type = {
 	.default_groups = hccs_chip_default_groups,
 };
 
+
+static ssize_t used_types_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	struct hccs_dev *hdev = device_kobj_to_hccs_dev(kobj);
+	int len = 0;
+	u16 i;
+
+	for (i = 0; i < hdev->used_type_num - 1; i++)
+		len += sysfs_emit(&buf[len], "%s ", hdev->type_name_maps[i].name);
+	len += sysfs_emit(&buf[len], "%s\n", hdev->type_name_maps[i].name);
+
+	return len;
+}
+static struct kobj_attribute used_types_attr =
+		__ATTR(used_types, 0444, used_types_show, NULL);
+
+static void hccs_remove_misc_sysfs(struct hccs_dev *hdev)
+{
+	sysfs_remove_file(&hdev->dev->kobj, &used_types_attr.attr);
+}
+
+static int hccs_add_misc_sysfs(struct hccs_dev *hdev)
+{
+	return sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
+}
+
 static void hccs_remove_die_dir(struct hccs_die_info *die)
 {
 	struct hccs_port_info *port;
@@ -1168,6 +1256,8 @@ static void hccs_remove_topo_dirs(struct hccs_dev *hdev)
 
 	for (i = 0; i < hdev->chip_num; i++)
 		hccs_remove_chip_dir(&hdev->chips[i]);
+
+	hccs_remove_misc_sysfs(hdev);
 }
 
 static int hccs_create_hccs_dir(struct hccs_dev *hdev,
@@ -1263,6 +1353,12 @@ static int hccs_create_topo_dirs(struct hccs_dev *hdev)
 		}
 	}
 
+	ret = hccs_add_misc_sysfs(hdev);
+	if (ret) {
+		dev_err(hdev->dev, "create misc sysfs interface failed, ret = %d\n", ret);
+		goto err;
+	}
+
 	return 0;
 err:
 	for (k = 0; k < id; k++)
@@ -1313,6 +1409,10 @@ static int hccs_probe(struct platform_device *pdev)
 	if (rc)
 		goto unregister_pcc_chan;
 
+	rc = hccs_init_type_name_maps(hdev);
+	if (rc)
+		goto unregister_pcc_chan;
+
 	rc = hccs_create_topo_dirs(hdev);
 	if (rc)
 		goto unregister_pcc_chan;
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index 5e12a1e1474e..401df4694aec 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -10,6 +10,19 @@
  * | P0 | P1 | P2 | P3 | P0 | P1 | P2 | P3 | P0 | P1 | P2 | P3 |P0 | P1 | P2 | P3 |
  */
 
+enum hccs_port_type {
+	HCCS_V1 = 1,
+	HCCS_V2,
+};
+
+#define HCCS_IP_PREFIX	"HCCS-v"
+#define HCCS_IP_MAX		255
+#define HCCS_NAME_MAX_LEN	9
+struct hccs_type_name_map {
+	u8 type;
+	char name[HCCS_NAME_MAX_LEN + 1];
+};
+
 /*
  * This value cannot be 255, otherwise the loop of the multi-BD communication
  * case cannot end.
@@ -74,6 +87,8 @@ struct hccs_dev {
 	u64 caps;
 	u8 chip_num;
 	struct hccs_chip_info *chips;
+	u16 used_type_num;
+	struct hccs_type_name_map *type_name_maps;
 	u8 chan_id;
 	struct mutex lock;
 	struct hccs_mbox_client_info cl_info;
-- 
2.22.0



Return-Path: <linux-kernel+bounces-256078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D59348B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC9E282B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A946874429;
	Thu, 18 Jul 2024 07:20:58 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0C7D41D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287257; cv=none; b=D0VY3PlYPPixYwj39A3oobEMuSaMXXUGgZ9j0TrjHa6+NilKWSRNblMzuH3Ljzo0w3mlRib+6fISFTNAsXCEQ2YOYUqboJzWoRG5tD7sWWeGG63euG0oZDax0az9eIWk7NOrAmKNbquUF5gK960iZYYiLXYc1nfKjyc4WKuWDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287257; c=relaxed/simple;
	bh=sy+uvs9GzCONsiI3uaMOpvAXN3X1BmQj3+M25VK2arI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA9fHSDy44iPvRTzxEQes87Jj9HojkfKscvkQCvi9gzvP2aHcybCelaIrVSjMSRqDOTXbWamnZX/9jq/g8s8zmNP3q8C0QShgZ5ms4fxs273BhhhxBs1eD5fhqTgpARi9Jfq56WCSMFekWdxyAO1RvyAMs4pnpOB66jjvhn0RxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WPkgw5BjHz20lS9;
	Thu, 18 Jul 2024 15:19:08 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 0420C14035F;
	Thu, 18 Jul 2024 15:20:48 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:20:47 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 4/5] soc: hisilicon: kunpeng_hccs: support low power feature for specified HCCS
Date: Thu, 18 Jul 2024 15:11:33 +0800
Message-ID: <20240718071134.31155-5-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240718071134.31155-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)

This patch add the low power feature for specified HCCS by increasing
and decrasing the lane number of these HCCS ports on platform.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/Kconfig        |   7 +-
 drivers/soc/hisilicon/kunpeng_hccs.c | 377 ++++++++++++++++++++++++++-
 drivers/soc/hisilicon/kunpeng_hccs.h |  14 +
 3 files changed, 394 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
index 4b0a099b28cc..6d7c244d2e78 100644
--- a/drivers/soc/hisilicon/Kconfig
+++ b/drivers/soc/hisilicon/Kconfig
@@ -13,9 +13,12 @@ config KUNPENG_HCCS
 	  interconnection bus protocol.
 	  The performance of application may be affected if some HCCS
 	  ports are not in full lane status, have a large number of CRC
-	  errors and so on.
+	  errors and so on. This may support for reducing system power
+	  consumption if there are HCCS ports supported low power feature
+	  on platform.
 
 	  Say M here if you want to include support for querying the
-	  health status and port information of HCCS on Kunpeng SoC.
+	  health status and port information of HCCS, or reducing system
+	  power consumption on Kunpeng SoC.
 
 endmenu
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 2d68ec49e1d6..97422159fa30 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -23,10 +23,18 @@
  *    - CRC error count sum
  *
  * - Retrieve all used HCCS types on platform.
+ *
+ * - Support low power feature for specified HCCS type ports, and provide the
+ *   following interface:
+ *    - query HCCS types supported PM
+ *    - decreasing lanes for all specified HCCS type ports on idle status
+ *    - increasing lanes for all specified HCCS type ports
  */
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -65,6 +73,33 @@ static struct hccs_dev *device_kobj_to_hccs_dev(struct kobject *k)
 	return platform_get_drvdata(pdev);
 }
 
+static char *hccs_port_type_to_name(struct hccs_dev *hdev, u8 type)
+{
+	u16 i;
+
+	for (i = 0; i < hdev->used_type_num; i++) {
+		if (hdev->type_name_maps[i].type == type)
+			return hdev->type_name_maps[i].name;
+	}
+
+	return NULL;
+}
+
+static int hccs_name_to_port_type(struct hccs_dev *hdev,
+				  const char *name, u8 *type)
+{
+	u16 i;
+
+	for (i = 0; i < hdev->used_type_num; i++) {
+		if (strcmp(hdev->type_name_maps[i].name, name) == 0) {
+			*type = hdev->type_name_maps[i].type;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 struct hccs_register_ctx {
 	struct device *dev;
 	u8 chan_id;
@@ -1193,6 +1228,309 @@ static const struct kobj_type hccs_chip_type = {
 	.default_groups = hccs_chip_default_groups,
 };
 
+static int hccs_parse_pm_port_type(struct hccs_dev *hdev, const char *buf,
+				   u8 *port_type)
+{
+	char hccs_name[HCCS_NAME_MAX_LEN + 1] = "";
+	u8 type;
+	int ret;
+
+	ret = sscanf(buf, "%" __stringify(HCCS_NAME_MAX_LEN) "s", hccs_name);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = hccs_name_to_port_type(hdev, hccs_name, &type);
+	if (ret) {
+		dev_err(hdev->dev, "input invalid, please get the available types from 'used_types'.\n");
+		return ret;
+	}
+
+	if (type == HCCS_V2 && hdev->caps & HCCS_CAPS_HCCS_V2_PM) {
+		*port_type = type;
+		return 0;
+	}
+
+	dev_err(hdev->dev, "%s doesn't support for increasing and decreasing lane.\n",
+		hccs_name);
+
+	return -EOPNOTSUPP;
+}
+
+static int hccs_query_port_idle_status(struct hccs_dev *hdev,
+				       struct hccs_port_info *port, u8 *idle)
+{
+	const struct hccs_die_info *die = port->die;
+	const struct hccs_chip_info *chip = die->chip;
+	struct hccs_port_comm_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_port_comm_req_param *)desc.req.data;
+	req_param->chip_id = chip->chip_id;
+	req_param->die_id = die->die_id;
+	req_param->port_id = port->port_id;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_GET_PORT_IDLE_STATUS, &desc);
+	if (ret) {
+		dev_err(hdev->dev,
+			"get port idle status failed, ret = %d.\n", ret);
+		return ret;
+	}
+
+	*idle = *((u8 *)desc.rsp.data);
+	return 0;
+}
+
+static int hccs_get_all_spec_port_idle_sta(struct hccs_dev *hdev, u8 port_type,
+					   bool *all_idle)
+{
+	struct hccs_chip_info *chip;
+	struct hccs_port_info *port;
+	struct hccs_die_info *die;
+	int ret = 0;
+	u8 i, j, k;
+	u8 idle;
+
+	*all_idle = false;
+	for (i = 0; i < hdev->chip_num; i++) {
+		chip = &hdev->chips[i];
+		for (j = 0; j < chip->die_num; j++) {
+			die = &chip->dies[j];
+			for (k = 0; k < die->port_num; k++) {
+				port = &die->ports[k];
+				if (port->port_type != port_type)
+					continue;
+				ret = hccs_query_port_idle_status(hdev, port,
+								  &idle);
+				if (ret) {
+					dev_err(hdev->dev,
+						"hccs%u on chip%u/die%u get idle status failed, ret = %d.\n",
+						k, i, j, ret);
+					return ret;
+				} else if (idle == 0) {
+					dev_info(hdev->dev, "hccs%u on chip%u/die%u is busy.\n",
+						k, i, j);
+					return 0;
+				}
+			}
+		}
+	}
+	*all_idle = true;
+
+	return 0;
+}
+
+static int hccs_get_all_spec_port_full_lane_sta(struct hccs_dev *hdev,
+						u8 port_type, bool *full_lane)
+{
+	struct hccs_link_status status = {0};
+	struct hccs_chip_info *chip;
+	struct hccs_port_info *port;
+	struct hccs_die_info *die;
+	int ret = 0;
+	u8 i, j, k;
+
+	*full_lane = false;
+	for (i = 0; i < hdev->chip_num; i++) {
+		chip = &hdev->chips[i];
+		for (j = 0; j < chip->die_num; j++) {
+			die = &chip->dies[j];
+			for (k = 0; k < die->port_num; k++) {
+				port = &die->ports[k];
+				if (port->port_type != port_type)
+					continue;
+				ret = hccs_query_port_link_status(hdev, port,
+								  &status);
+				if (ret || status.lane_num != port->lane_mode)
+					goto out;
+			}
+		}
+	}
+	*full_lane = true;
+
+out:
+	return ret;
+}
+
+static int hccs_prepare_inc_lane(struct hccs_dev *hdev, u8 type)
+{
+	struct hccs_inc_lane_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_inc_lane_req_param *)desc.req.data;
+	req_param->port_type = type;
+	req_param->opt_type = HCCS_PREPARE_INC_LANE;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_PM_INC_LANE, &desc);
+	if (ret)
+		dev_err(hdev->dev, "prepare for increasing lane failed, ret = %d.\n",
+			ret);
+
+	return ret;
+}
+
+static int hccs_wait_serdes_adapt_completed(struct hccs_dev *hdev, u8 type)
+{
+#define HCCS_MAX_WAIT_CNT_FOR_ADAPT	10
+#define HCCS_QUERY_ADAPT_RES_DELAY_MS	100
+#define HCCS_SERDES_ADAPT_OK		0
+
+	struct hccs_inc_lane_req_param *req_param;
+	u8 wait_cnt = HCCS_MAX_WAIT_CNT_FOR_ADAPT;
+	struct hccs_desc desc;
+	u8 adapt_res;
+	int ret;
+
+	do {
+		hccs_init_req_desc(&desc);
+		req_param = (struct hccs_inc_lane_req_param *)desc.req.data;
+		req_param->port_type = type;
+		req_param->opt_type = HCCS_GET_ADAPT_RES;
+		ret = hccs_pcc_cmd_send(hdev, HCCS_PM_INC_LANE, &desc);
+		if (ret) {
+			dev_err(hdev->dev, "query adapting result failed, ret = %d.\n",
+				ret);
+			return ret;
+		}
+		adapt_res = *((u8 *)&desc.rsp.data);
+		if (adapt_res == HCCS_SERDES_ADAPT_OK)
+			break;
+
+		msleep(HCCS_QUERY_ADAPT_RES_DELAY_MS);
+	} while (--wait_cnt);
+
+	if (adapt_res != HCCS_SERDES_ADAPT_OK) {
+		dev_err(hdev->dev, "wait for adapting completed timeout.\n");
+		return -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static int hccs_start_hpcs_retraining(struct hccs_dev *hdev, u8 type)
+{
+	struct hccs_inc_lane_req_param *req_param;
+	struct hccs_desc desc;
+	int ret;
+
+	hccs_init_req_desc(&desc);
+	req_param = (struct hccs_inc_lane_req_param *)desc.req.data;
+	req_param->port_type = type;
+	req_param->opt_type = HCCS_START_RETRAINING;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_PM_INC_LANE, &desc);
+	if (ret)
+		dev_err(hdev->dev, "start hpcs retraining failed, ret = %d.\n",
+			ret);
+
+	return ret;
+}
+
+static int hccs_start_inc_lane(struct hccs_dev *hdev, u8 type)
+{
+	int ret;
+
+	ret = hccs_prepare_inc_lane(hdev, type);
+	if (ret)
+		return ret;
+
+	ret = hccs_wait_serdes_adapt_completed(hdev, type);
+	if (ret)
+		return ret;
+
+	return hccs_start_hpcs_retraining(hdev, type);
+}
+
+static int hccs_start_dec_lane(struct hccs_dev *hdev, u8 type)
+{
+	struct hccs_desc desc;
+	u8 *port_type;
+	int ret;
+
+	hccs_init_req_desc(&desc);
+	port_type = (u8 *)desc.req.data;
+	*port_type = type;
+	ret = hccs_pcc_cmd_send(hdev, HCCS_PM_DEC_LANE, &desc);
+	if (ret)
+		dev_err(hdev->dev, "start to decrease lane failed, ret = %d.\n",
+			ret);
+
+	return ret;
+}
+
+static ssize_t dec_lane_store(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct hccs_dev *hdev = device_kobj_to_hccs_dev(kobj);
+	u8 port_type;
+	bool all_in_idle;
+	int ret;
+
+	ret = hccs_parse_pm_port_type(hdev, buf, &port_type);
+	if (ret)
+		return ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_get_all_spec_port_idle_sta(hdev, port_type, &all_in_idle);
+	if (ret)
+		goto out;
+	else if (!all_in_idle) {
+		ret = -EOPNOTSUPP;
+		dev_err(hdev->dev, "please don't decrese lanes on high load with %s, ret = %d.\n",
+			hccs_port_type_to_name(hdev, port_type), ret);
+		goto out;
+	}
+	ret = hccs_start_dec_lane(hdev, port_type);
+out:
+	mutex_unlock(&hdev->lock);
+
+	return ret == 0 ? count : ret;
+}
+static struct kobj_attribute dec_lane_attr =
+		__ATTR(dec_lane, 0200, NULL, dec_lane_store);
+
+static ssize_t inc_lane_store(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct hccs_dev *hdev = device_kobj_to_hccs_dev(kobj);
+	bool full_lane;
+	u8 port_type;
+	int ret;
+
+	ret = hccs_parse_pm_port_type(hdev, buf, &port_type);
+	if (ret)
+		return ret;
+
+	mutex_lock(&hdev->lock);
+	ret = hccs_get_all_spec_port_full_lane_sta(hdev, port_type, &full_lane);
+	if (ret || full_lane)
+		goto out;
+
+	ret = hccs_start_inc_lane(hdev, port_type);
+out:
+	mutex_unlock(&hdev->lock);
+	return ret == 0 ? count : ret;
+}
+static struct kobj_attribute inc_lane_attr =
+		__ATTR(inc_lane, 0200, NULL, inc_lane_store);
+
+static ssize_t support_pm_types_show(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     char *buf)
+{
+	struct hccs_dev *hdev = device_kobj_to_hccs_dev(kobj);
+	int len = 0;
+
+	if (hdev->caps & HCCS_CAPS_HCCS_V2_PM)
+		len += sysfs_emit(buf, "%s\n",
+				    hccs_port_type_to_name(hdev, HCCS_V2));
+	else
+		len += sysfs_emit(buf, "%s\n", "none");
+
+	return len;
+}
+static struct kobj_attribute pm_types_attr =
+		__ATTR(support_pm_types, 0444, support_pm_types_show, NULL);
 
 static ssize_t used_types_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -1213,11 +1551,46 @@ static struct kobj_attribute used_types_attr =
 static void hccs_remove_misc_sysfs(struct hccs_dev *hdev)
 {
 	sysfs_remove_file(&hdev->dev->kobj, &used_types_attr.attr);
+	sysfs_remove_file(&hdev->dev->kobj, &pm_types_attr.attr);
+
+	if (!(hdev->caps & HCCS_CAPS_HCCS_V2_PM))
+		return;
+
+	sysfs_remove_file(&hdev->dev->kobj, &dec_lane_attr.attr);
+	sysfs_remove_file(&hdev->dev->kobj, &inc_lane_attr.attr);
 }
 
 static int hccs_add_misc_sysfs(struct hccs_dev *hdev)
 {
-	return sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
+	int ret;
+
+	ret = sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_file(&hdev->dev->kobj, &pm_types_attr.attr);
+	if (ret)
+		goto used_types_remove;
+
+	if (!(hdev->caps & HCCS_CAPS_HCCS_V2_PM))
+		return 0;
+
+	ret = sysfs_create_file(&hdev->dev->kobj, &dec_lane_attr.attr);
+	if (ret)
+		goto pm_types_remove;
+	ret = sysfs_create_file(&hdev->dev->kobj, &inc_lane_attr.attr);
+	if (ret)
+		goto dec_lane_remove;
+
+	return 0;
+
+dec_lane_remove:
+	sysfs_remove_file(&hdev->dev->kobj, &dec_lane_attr.attr);
+pm_types_remove:
+	sysfs_remove_file(&hdev->dev->kobj, &pm_types_attr.attr);
+used_types_remove:
+	sysfs_remove_file(&hdev->dev->kobj, &used_types_attr.attr);
+	return ret;
 }
 
 static void hccs_remove_die_dir(struct hccs_die_info *die)
@@ -1353,7 +1726,7 @@ static int hccs_create_topo_dirs(struct hccs_dev *hdev)
 
 	ret = hccs_add_misc_sysfs(hdev);
 	if (ret) {
-		dev_err(hdev->dev, "create global sysfs interface failed, ret = %d\n", ret);
+		dev_err(hdev->dev, "create misc sysfs interface failed, ret = %d\n", ret);
 		goto err;
 	}
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index fe8b4089a9c7..6e2f7383c9a0 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -80,10 +80,13 @@ struct hccs_verspecific_data {
 	bool has_txdone_irq;
 };
 
+#define HCCS_CAPS_HCCS_V2_PM	BIT_ULL(0)
+
 struct hccs_dev {
 	struct device *dev;
 	struct acpi_device *acpi_dev;
 	const struct hccs_verspecific_data *verspec_data;
+	/* device capabilities from firmware, like HCCS_CAPS_xxx. */
 	u64 caps;
 	u8 chip_num;
 	struct hccs_chip_info *chips;
@@ -106,6 +109,9 @@ enum hccs_subcmd_type {
 	HCCS_GET_DIE_PORTS_LANE_STA,
 	HCCS_GET_DIE_PORTS_LINK_STA,
 	HCCS_GET_DIE_PORTS_CRC_ERR_CNT,
+	HCCS_GET_PORT_IDLE_STATUS,
+	HCCS_PM_DEC_LANE,
+	HCCS_PM_INC_LANE,
 	HCCS_SUB_CMD_MAX = 255,
 };
 
@@ -149,6 +155,14 @@ struct hccs_port_comm_req_param {
 	u8 port_id;
 };
 
+#define HCCS_PREPARE_INC_LANE	1
+#define HCCS_GET_ADAPT_RES	2
+#define HCCS_START_RETRAINING	3
+struct hccs_inc_lane_req_param {
+	u8 port_type;
+	u8 opt_type;
+};
+
 #define HCCS_PORT_RESET         1
 #define HCCS_PORT_SETUP         2
 #define HCCS_PORT_CONFIG        3
-- 
2.22.0



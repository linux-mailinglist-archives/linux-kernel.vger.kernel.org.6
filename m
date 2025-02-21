Return-Path: <linux-kernel+bounces-525635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA8A3F293
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D655516E96F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D6207A15;
	Fri, 21 Feb 2025 10:54:44 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6720102C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135284; cv=none; b=ZOXMBWrc5y070fTxFIb5YKEVy/d3rzURmRm6pSufg7dCdqFyTpgcirBjMRcxQ0sH/yzuTl6X1yOPtmavTssuRcRj3pcgwsYIqNMEpMgPvPyP2OXItF43YyD4UVm1lHDSbJz8tCt0nI5UuZRHIV7WMeSiV4WsT+DcwxAuYL9+HM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135284; c=relaxed/simple;
	bh=+nf6EkVyuqBxAPQJOfjGJo4CTW87TwhHGYBAflrbPWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PMZ3LrRmnaTGk93Sespq4xOG0c5kvrWKyrwpcuPt1yrOMdLOaUAUrAaWXrfhaC41A/W8f/bXNXsyZerBHsf9Wmhb2mLjKglV6mMZCFoRN18jyzsoGX6M7t1EZgJX2ASMhBwLMhXgYtr36Dik2u1YIASw/u3bET3jP302J3I8GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Yzn2c018bz1GDfg;
	Fri, 21 Feb 2025 18:49:59 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DECE180087;
	Fri, 21 Feb 2025 18:54:38 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Feb 2025 18:54:37 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
	<linux-kernel@vger.kernel.org>
CC: <shenyang39@huawei.com>, <moubingquan@huawei.com>,
	<prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] hwtracing: hisi_ptt: Initialize the filter sysfs attribute when allocation
Date: Fri, 21 Feb 2025 18:54:49 +0800
Message-ID: <20250221105449.64892-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

The filter sysfs attribute is initialized when creating to the sysfs.
This is unnecessary and could be done when allocation without
distinguishing the filter type.

After the changes above, we don't need a wrapper for initializing and
registering the filter's sysfs attributes. Remove them and call the
sysfs creating/removing functions in place.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 92 ++++++++++----------------------
 1 file changed, 29 insertions(+), 63 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 3090479a2979..83cf84cc6df9 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -368,6 +368,19 @@ static void hisi_ptt_del_free_filter(struct hisi_ptt *hisi_ptt,
 	kfree(filter);
 }
 
+static ssize_t hisi_ptt_filter_show(struct device *dev, struct device_attribute *attr,
+				    char *buf)
+{
+	struct hisi_ptt_filter_desc *filter;
+	unsigned long filter_val;
+
+	filter = container_of(attr, struct hisi_ptt_filter_desc, attr);
+	filter_val = hisi_ptt_get_filter_val(filter->devid, filter->is_port) |
+		     (filter->is_port ? HISI_PTT_PMU_FILTER_IS_PORT : 0);
+
+	return sysfs_emit(buf, "0x%05lx\n", filter_val);
+}
+
 static struct hisi_ptt_filter_desc *
 hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, u16 devid, bool is_port)
 {
@@ -396,6 +409,11 @@ hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, u16 devid, bool is_port)
 	filter->is_port = is_port;
 	filter->devid = devid;
 
+	sysfs_attr_init(&filter->attr.attr);
+	filter->attr.attr.name = filter->name;
+	filter->attr.attr.mode = 0400; /* DEVICE_ATTR_ADMIN_RO */
+	filter->attr.show = hisi_ptt_filter_show;
+
 	if (filter->is_port) {
 		list_add_tail(&filter->list, &hisi_ptt->port_filters);
 
@@ -408,74 +426,18 @@ hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, u16 devid, bool is_port)
 	return filter;
 }
 
-static ssize_t hisi_ptt_filter_show(struct device *dev, struct device_attribute *attr,
-				    char *buf)
-{
-	struct hisi_ptt_filter_desc *filter;
-	unsigned long filter_val;
-
-	filter = container_of(attr, struct hisi_ptt_filter_desc, attr);
-	filter_val = hisi_ptt_get_filter_val(filter->devid, filter->is_port) |
-		     (filter->is_port ? HISI_PTT_PMU_FILTER_IS_PORT : 0);
-
-	return sysfs_emit(buf, "0x%05lx\n", filter_val);
-}
-
-static int hisi_ptt_create_rp_filter_attr(struct hisi_ptt *hisi_ptt,
-					  struct hisi_ptt_filter_desc *filter)
-{
-	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
-
-	sysfs_attr_init(&filter->attr.attr);
-	filter->attr.attr.name = filter->name;
-	filter->attr.attr.mode = 0400; /* DEVICE_ATTR_ADMIN_RO */
-	filter->attr.show = hisi_ptt_filter_show;
-
-	return sysfs_add_file_to_group(kobj, &filter->attr.attr,
-				       HISI_PTT_RP_FILTERS_GRP_NAME);
-}
-
-static void hisi_ptt_remove_rp_filter_attr(struct hisi_ptt *hisi_ptt,
-					  struct hisi_ptt_filter_desc *filter)
-{
-	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
-
-	sysfs_remove_file_from_group(kobj, &filter->attr.attr,
-				     HISI_PTT_RP_FILTERS_GRP_NAME);
-}
-
-static int hisi_ptt_create_req_filter_attr(struct hisi_ptt *hisi_ptt,
-					   struct hisi_ptt_filter_desc *filter)
-{
-	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
-
-	sysfs_attr_init(&filter->attr.attr);
-	filter->attr.attr.name = filter->name;
-	filter->attr.attr.mode = 0400; /* DEVICE_ATTR_ADMIN_RO */
-	filter->attr.show = hisi_ptt_filter_show;
-
-	return sysfs_add_file_to_group(kobj, &filter->attr.attr,
-				       HISI_PTT_REQ_FILTERS_GRP_NAME);
-}
-
-static void hisi_ptt_remove_req_filter_attr(struct hisi_ptt *hisi_ptt,
-					   struct hisi_ptt_filter_desc *filter)
-{
-	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
-
-	sysfs_remove_file_from_group(kobj, &filter->attr.attr,
-				     HISI_PTT_REQ_FILTERS_GRP_NAME);
-}
-
 static int hisi_ptt_create_filter_attr(struct hisi_ptt *hisi_ptt,
 				       struct hisi_ptt_filter_desc *filter)
 {
+	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
 	int ret;
 
 	if (filter->is_port)
-		ret = hisi_ptt_create_rp_filter_attr(hisi_ptt, filter);
+		ret = sysfs_add_file_to_group(kobj, &filter->attr.attr,
+					      HISI_PTT_RP_FILTERS_GRP_NAME);
 	else
-		ret = hisi_ptt_create_req_filter_attr(hisi_ptt, filter);
+		ret = sysfs_add_file_to_group(kobj, &filter->attr.attr,
+					      HISI_PTT_REQ_FILTERS_GRP_NAME);
 
 	if (ret)
 		pci_err(hisi_ptt->pdev, "failed to create sysfs attribute for filter %s\n",
@@ -487,10 +449,14 @@ static int hisi_ptt_create_filter_attr(struct hisi_ptt *hisi_ptt,
 static void hisi_ptt_remove_filter_attr(struct hisi_ptt *hisi_ptt,
 					struct hisi_ptt_filter_desc *filter)
 {
+	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
+
 	if (filter->is_port)
-		hisi_ptt_remove_rp_filter_attr(hisi_ptt, filter);
+		sysfs_remove_file_from_group(kobj, &filter->attr.attr,
+					     HISI_PTT_RP_FILTERS_GRP_NAME);
 	else
-		hisi_ptt_remove_req_filter_attr(hisi_ptt, filter);
+		sysfs_remove_file_from_group(kobj, &filter->attr.attr,
+					     HISI_PTT_REQ_FILTERS_GRP_NAME);
 }
 
 static void hisi_ptt_remove_all_filter_attributes(void *data)
-- 
2.24.0



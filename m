Return-Path: <linux-kernel+bounces-298191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA8595C3AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AB128352E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6A3F9D2;
	Fri, 23 Aug 2024 03:21:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D472B9DA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383259; cv=none; b=sfoK7O4025ZOh64sUOOot0f41CpMQmomsluncvS3ubXEw5mdxSfBs9V7QQuQ2sJn8qR5yoIaGWfQNOQ2p+uCJS8G7b7fA03B1WUlQ6alykLPqxkPFx/+yppfvYapQRn1r2HVHbHJEXtt0JJat8DptvoOSqVuz35DEuYqYenLQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383259; c=relaxed/simple;
	bh=9WERZ42wK+3p92KX1Otusmd8V4PqWNKUrFjS1k0eemI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAJZUvs7mq5YUbTAqjB/FwwL4o5+AZpio5w1LzuvZ7wXNOMU1lFVwbEbLSd6BS4unFc+WaTpe0SmNrPqTz6T3cQ3ubCQeGBu+OnVb2Gud3cPgaF5aKaEjfhhhZCw6J8URWSnGp5lWnm8rC+oEiDv40iKgkE2sDoaVcvGxplsk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wqlfd3bbCzpTNv;
	Fri, 23 Aug 2024 11:19:21 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 7016F1401F1;
	Fri, 23 Aug 2024 11:20:55 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:20:54 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 4/6] soc: hisilicon: kunpeng_hccs: Fix the 'lane_mode' field name in port info structure to 'max_lane_num'
Date: Fri, 23 Aug 2024 11:10:57 +0800
Message-ID: <20240823031059.32579-5-lihuisong@huawei.com>
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

The lane mode of HCCS port is an information to user, and actually comes
from the maximum lane number. But it is good and easy for driver to use
the maximum lane number. So fix the 'lane_mode' field name in port info
structure to 'max_lane_num'.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
 drivers/soc/hisilicon/kunpeng_hccs.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 6055e5091cbd..418e4ee5d9e5 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -594,7 +594,7 @@ static int hccs_get_all_port_info_on_die(struct hccs_dev *hdev,
 		port = &die->ports[i];
 		port->port_id = attrs[i].port_id;
 		port->port_type = attrs[i].port_type;
-		port->lane_mode = attrs[i].lane_mode;
+		port->max_lane_num = attrs[i].max_lane_num;
 		port->enable = attrs[i].enable;
 		port->die = die;
 	}
@@ -839,7 +839,7 @@ static ssize_t lane_mode_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	const struct hccs_port_info *port = kobj_to_port_info(kobj);
 
-	return sysfs_emit(buf, "x%u\n", port->lane_mode);
+	return sysfs_emit(buf, "x%u\n", port->max_lane_num);
 }
 static struct kobj_attribute lane_mode_attr = __ATTR_RO(lane_mode);
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index c3adbc01b471..5e12a1e1474e 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -19,7 +19,7 @@
 struct hccs_port_info {
 	u8 port_id;
 	u8 port_type;
-	u8 lane_mode;
+	u8 max_lane_num;
 	bool enable; /* if the port is enabled */
 	struct kobject kobj;
 	bool dir_created;
@@ -113,7 +113,7 @@ struct hccs_die_info_rsp_data {
 struct hccs_port_attr {
 	u8 port_id;
 	u8 port_type;
-	u8 lane_mode;
+	u8 max_lane_num;
 	u8 enable : 1; /* if the port is enabled */
 	u16 rsv[2];
 };
-- 
2.22.0



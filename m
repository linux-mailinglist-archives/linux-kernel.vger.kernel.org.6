Return-Path: <linux-kernel+bounces-522915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE5A3D00E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04DC189C8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6A1DF75D;
	Thu, 20 Feb 2025 03:21:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940F1D5AB9;
	Thu, 20 Feb 2025 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021669; cv=none; b=IKdfSnzRA47YyqERVxqI0lrEzdrwMz756JovRkhbHZgcIoXwrQecYRPT/jURFWY4i/MR0FuRJ+RBiBtofI6pR2Tcldbeb6NlhQBr4+hY55urhQKUZZ0B0b/XMK6tvZBPct39R4K1mxCOi27RTWuPdN9PA2rATWkr3D32MXd+H/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021669; c=relaxed/simple;
	bh=Qy2N8oC+a7tGQLAD4iW0NcTrv1a6+NZUXNIZOzhwdqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OENFVVoEo/gILs2GRWxpDM9mjLRWVNnWdFJmqHJkUl6Mq/tU6znsAZ7Pmubi3NkO2bucZbFqn20xIBZM3OVJsUgLv5m0F438s6JQ691NCKRcST5yQp/R8wLbB9gv6ASA766OZvk+SSPM5G40j3R/GwPvkMmSiltj4WVOAKU1FIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yyz3T48Hbz233Gd;
	Thu, 20 Feb 2025 11:17:57 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B51F9180044;
	Thu, 20 Feb 2025 11:20:58 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 11:20:58 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 11:20:57 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] hwmon: (acpi_power_meter) Fix the fake power alarm reporting
Date: Thu, 20 Feb 2025 11:08:32 +0800
Message-ID: <20250220030832.2976-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

We encountered a problem that a fake power alarm is reported to
user on the platform unsupported notifications at the second step
below:
1> Query 'power1_alarm' attribute when the power capping occurs.
2> Query 'power1_alarm' attribute when the power capping is over
   and the current average power is less then power cap value.

The root cause is that the resource->power_alarm is set to true
at the first step. And power meter use this old value to show
the power alarm state instead of the current the comparison value.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 44afb07409a4..f05986e4f379 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -437,9 +437,13 @@ static ssize_t show_val(struct device *dev,
 			ret = update_cap(resource);
 			if (ret)
 				return ret;
+			resource->power_alarm = resource->power > resource->cap;
+			val = resource->power_alarm;
+		} else {
+			val = resource->power_alarm ||
+				 resource->power > resource->cap;
+			resource->power_alarm = resource->power > resource->cap;
 		}
-		val = resource->power_alarm || resource->power > resource->cap;
-		resource->power_alarm = resource->power > resource->cap;
 		break;
 	case 7:
 	case 8:
-- 
2.22.0



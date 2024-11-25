Return-Path: <linux-kernel+bounces-420742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57C9D82C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4564B2832BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85964192D73;
	Mon, 25 Nov 2024 09:45:44 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106E191F7E;
	Mon, 25 Nov 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527944; cv=none; b=DS+QNourDExRaM5JKTLbMAPcBb5Scvai/OlLV181Ndj7jXujtn0u5McLcCELX8bxXx/LyCMfPaeNhv5ph/+OXhLezNYR3Kwn192CsonFtiLAtPZgoExOMZuw5W89NsaDtoaLyw2R7zSS5J7nT06ak3L99pvW+yMnOEQECUI7arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527944; c=relaxed/simple;
	bh=OueQ8T1Get/NkPFc17S5qekxUTbUZiC2H/WWHnKWs2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltB3jBbQMV0JWnw6gj25invoi5L6Hz+E5+oGwynmrlNnrPmrgHN1HmgGrPCGiAMheQDB4OMRxsSUpEOyP2pN9eL/+hVV8KklTzc2f+OLfrMhvj9D3lqmWFlVCjpuF8qkYepovTMjQLSA/yVTwqLDeS2Iii67RYcWTqsINM1rRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xxgn76WYdz1yqxG;
	Mon, 25 Nov 2024 17:45:47 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 09535140138;
	Mon, 25 Nov 2024 17:45:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 17:45:33 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 17:45:33 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <liuyonglong@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 3/4] hwmon: (acpi_power_meter) Remove redundant 'sensors_valid' variable
Date: Mon, 25 Nov 2024 17:34:14 +0800
Message-ID: <20241125093415.21719-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20241125093415.21719-1-lihuisong@huawei.com>
References: <20241125093415.21719-1-lihuisong@huawei.com>
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

The 'sensors_valid' in acpi_power_meter_resource structure is always one
after querying power once. The default value of this variable is zero which
just ensure user can query power successfully without any time requirement
at first time. We can get power and fill the 'sensors_last_updated' field
at probing phase to make sure that a valid value is returned to user at
first query within the sampling interval. Then this redundant variable can
be safely removed.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 95da73858a0b..3500859ff0bf 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -84,7 +84,6 @@ struct acpi_power_meter_resource {
 	u64		power;
 	u64		cap;
 	u64		avg_interval;
-	int			sensors_valid;
 	unsigned long		sensors_last_updated;
 	struct sensor_device_attribute	sensors[NUM_SENSORS];
 	int			num_sensors;
@@ -316,15 +315,14 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
 }
 
 /* Power meter */
-static int update_meter(struct acpi_power_meter_resource *resource)
+static int update_meter(struct acpi_power_meter_resource *resource, bool check)
 {
 	unsigned long long data;
 	acpi_status status;
 	unsigned long local_jiffies = jiffies;
 
-	if (time_before(local_jiffies, resource->sensors_last_updated +
-			msecs_to_jiffies(resource->caps.sampling_time)) &&
-			resource->sensors_valid)
+	if (check && time_before(local_jiffies, resource->sensors_last_updated +
+			msecs_to_jiffies(resource->caps.sampling_time)))
 		return 0;
 
 	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PMM",
@@ -336,7 +334,6 @@ static int update_meter(struct acpi_power_meter_resource *resource)
 	}
 
 	resource->power = data;
-	resource->sensors_valid = 1;
 	resource->sensors_last_updated = jiffies;
 	return 0;
 }
@@ -349,7 +346,7 @@ static ssize_t show_power(struct device *dev,
 	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
 
 	mutex_lock(&resource->lock);
-	update_meter(resource);
+	update_meter(resource, true);
 	mutex_unlock(&resource->lock);
 
 	if (resource->power == UNKNOWN_POWER)
@@ -429,7 +426,7 @@ static ssize_t show_val(struct device *dev,
 			val = 0;
 		break;
 	case 6:
-		ret = update_meter(resource);
+		ret = update_meter(resource, true);
 		if (ret)
 			return ret;
 		ret = update_cap(resource);
@@ -699,6 +696,10 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 		return res;
 
 	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
+		res = update_meter(resource, false);
+		if (res)
+			goto error;
+
 		res = register_attrs(resource, meter_attrs);
 		if (res)
 			goto error;
@@ -890,7 +891,6 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	if (!resource)
 		return -ENOMEM;
 
-	resource->sensors_valid = 0;
 	resource->acpi_dev = device;
 	mutex_init(&resource->lock);
 	strcpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
-- 
2.22.0



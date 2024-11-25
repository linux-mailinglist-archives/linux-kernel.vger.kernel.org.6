Return-Path: <linux-kernel+bounces-420740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12A9D82C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779B5163F59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0781192580;
	Mon, 25 Nov 2024 09:45:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A141190067;
	Mon, 25 Nov 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527939; cv=none; b=fj+jJ8Ee4/WF+HLTITPKNbABe2KryiDJ6igDNKM8YOM4mOUnQcmvtsuZ6hoLcxuIxTp9naXvz1tbQAiAXs2crB1OQmFfqSiIAbXRXQBKVxFNaPAyZG2nVJBhI7JZWGaaknEYueb5sGkW3eF6J7CCXfMdsOFAS5WXMaFBbEYypPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527939; c=relaxed/simple;
	bh=ECpuQOq5aCnq3HC1tu2bZ5lPTloU6TfNh8V1/IDwyhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3Bx8jg7I9jBb+q1kbpstNUutNRUqwm2pvzNBv71hXdI62D9B0FGAc9mTMJEtf2VxG4BzJ5HI6QzZ7wDqvpXbdUxep8iS09CDMpyhvjDYu2enURJX1iC5+9jiWS54cwbT4twoJ8ar2zE5o+3eVJ9sOrPSqFIeW2aRaCXSpJm/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XxglB0XPLzRhmY;
	Mon, 25 Nov 2024 17:44:06 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CA4AD140393;
	Mon, 25 Nov 2024 17:45:33 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 17:45:33 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 17:45:32 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <liuyonglong@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 2/4] hwmon: (acpi_power_meter) Fix update the power trip points on failure
Date: Mon, 25 Nov 2024 17:34:13 +0800
Message-ID: <20241125093415.21719-3-lihuisong@huawei.com>
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

The power trip points maintained in local should not be updated when '_PTP'
method fails to evaluate.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 4c3314e35d30..95da73858a0b 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -292,8 +292,8 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
+	unsigned long temp, trip_bk;
 	int res;
-	unsigned long temp;
 
 	res = kstrtoul(buf, 10, &temp);
 	if (res)
@@ -302,8 +302,11 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
 
 	mutex_lock(&resource->lock);
+	trip_bk = resource->trip[attr->index - 7];
 	resource->trip[attr->index - 7] = temp;
 	res = set_acpi_trip(resource);
+	if (!res)
+		resource->trip[attr->index - 7] = trip_bk;
 	mutex_unlock(&resource->lock);
 
 	if (res)
-- 
2.22.0



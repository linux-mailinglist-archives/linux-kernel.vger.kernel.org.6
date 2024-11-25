Return-Path: <linux-kernel+bounces-420741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019F9D82C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91A5282E29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151AB19258E;
	Mon, 25 Nov 2024 09:45:40 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036618C03F;
	Mon, 25 Nov 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527939; cv=none; b=CoqxS+B8u+qqqhN4aUGN8rFk8sWQjPI5dAosPylFuZuhlqqzD/jgpVZXN6KIsgypIeeE2aNFYvM/LuVwzF+hJ8Qva62AFO93f8gzAqz6KW4o/IPq+vaCoeVvDafmMos7m8CFUXdPeMI8XVYg/qYYbKtbeu46Tixhbcgj3hYPPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527939; c=relaxed/simple;
	bh=GmBeP+FVpvt08+uBd4UcADx9KPChCc6lrKoEKJiy9Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVbVrqH4iMihAXfZo+ixWgc1hbunkDRUoluwlFkEFjiJiC2l+K9+1U+ibbLxNCGi3tUb9/W+Yp+pfSdLt1GX/T6w1LsC9SXyjvV4qobQoc4jqzYu4gZ/RXrBYYQp/swOTq7QVjrQjUEEYg7JrSjbiL/H01y7nyznqlBhYpW3yZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XxgkS1gLGz1k0BK;
	Mon, 25 Nov 2024 17:43:28 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 60B951A016C;
	Mon, 25 Nov 2024 17:45:33 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
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
Subject: [PATCH v1 1/4] hwmon: (acpi_power_meter) Fix using uninitialized variables
Date: Mon, 25 Nov 2024 17:34:12 +0800
Message-ID: <20241125093415.21719-2-lihuisong@huawei.com>
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

The 'power1_alarm' attribute uses the 'power' and 'cap' in the
acpi_power_meter_resource structure. However, these two fields are just
updated when user query 'power' and 'cap' attribute, or hardware enforced
limit. If user directly query the 'power1_alarm' attribute without queryng
above two attributes, driver will use the uninitialized variables to judge.
In addition, the 'power1_alarm' attribute needs to update power and cap to
show the real state.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 2f1c9d97ad21..4c3314e35d30 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -396,6 +396,9 @@ static ssize_t show_val(struct device *dev,
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
 	u64 val = 0;
+	int ret;
+
+	guard(mutex)(&resource->lock);
 
 	switch (attr->index) {
 	case 0:
@@ -423,6 +426,13 @@ static ssize_t show_val(struct device *dev,
 			val = 0;
 		break;
 	case 6:
+		ret = update_meter(resource);
+		if (ret)
+			return ret;
+		ret = update_cap(resource);
+		if (ret)
+			return ret;
+
 		if (resource->power > resource->cap)
 			val = 1;
 		else
-- 
2.22.0



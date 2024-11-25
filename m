Return-Path: <linux-kernel+bounces-420743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAEB9D82C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9279D28341C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D57193425;
	Mon, 25 Nov 2024 09:45:45 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32818FDCC;
	Mon, 25 Nov 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527945; cv=none; b=ZtWQxqnigXNEoGMtAtnEaARmfjHR7ONiSXMB8Fbmg7cd2sUVpPa0+KVoHnj9uj1ka/rhfNwNOT7KxrYYe+8Mf52ecVAXow64a/BzL2zt1ebXSJfCT4MfZekJgU0eFgVgA16OkWUaRyLOIATfMES7VzpFWGrRZCnnld6nbIY4UN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527945; c=relaxed/simple;
	bh=7vH7tYyL6BlYXxoUVeJHgaS5gYbRQQP4StN4V2vcqP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiWCt4zDvEHXYsezsm952QmRRlCukY+v6+DlubTYdlwcjyjjVstMw3vaaznJtVTYZa58MtnH77Ztn1t3439aMkiUC5peXJAgqYYMhb0Juojb3DrQNY/lsf1W62uJfwqmXbNCrLPwpUMrQwtpGDyUWUI3xUCM53V2JeHsdLe/QU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xxgn83QMGz1yqxY;
	Mon, 25 Nov 2024 17:45:48 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 96671140202;
	Mon, 25 Nov 2024 17:45:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 17:45:34 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 17:45:33 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <liuyonglong@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 4/4] hwmon: (acpi_power_meter) Add the print of no notification that hardware limit is enforced
Date: Mon, 25 Nov 2024 17:34:15 +0800
Message-ID: <20241125093415.21719-5-lihuisong@huawei.com>
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

As ACPI spec said, the bit3 of the supported capabilities in _PMC indicates
that the power meter supports notifications when the hardware limit is
enforced. If one platform doesn't report this bit, but support hardware
forced limit through some out-of-band mechanism. Driver wouldn't receive
the related notifications to notify the OSPM to re-read the hardware limit.
So add the print of no notifcation that hardware limit is enforced.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 3500859ff0bf..d3f144986fae 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -712,6 +712,10 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 			goto skip_unsafe_cap;
 		}
 
+		if (resource->caps.flags & POWER_METER_CAN_NOTIFY == 0)
+			dev_info(&resource->acpi_dev->dev,
+				 "no notifcation when the hardware limit is enforced.\n");
+
 		if (resource->caps.configurable_cap)
 			res = register_attrs(resource, rw_cap_attrs);
 		else
-- 
2.22.0



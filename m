Return-Path: <linux-kernel+bounces-405061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0BA9C4C96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A31B25A65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9F19E96A;
	Tue, 12 Nov 2024 02:23:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF17F50F;
	Tue, 12 Nov 2024 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378218; cv=none; b=OVUVh9UFHekm7JXXQOwtk5o08X3Wo4tMMm9DLEpFwSU7//5Zf6CsCXUfzGJoClRqPyGD6mQDmKqHTzQqhKcgnoa3zbVTtove0kSM6ogJczKvbfoHDjXLo7He6b5EZPzE/qtgDIWha21XMdBxLQt0Qc6tm74mo/4wUXAQUvCy0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378218; c=relaxed/simple;
	bh=NwOubgdHIIpjYC991G4+DrMfD8Gc/C2T1lYTvXvcmLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fb8JcUOuXbHrGQhj4CSV6ijPNoV1y76yIRdl0QuSPZ0YDL0k0WNozMi5tVBSxLY7T3Ex32TUxI3PhMhvGq8YMECABL2ZLtrgw2YsIDXAgaa44XgskIzMxvhmJP9RZrDensuVaeuOSq1T25XspOOm4fRuubmIabuOZvXrv6uDERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XnVYR2Jq4zQsv0;
	Tue, 12 Nov 2024 10:22:19 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 918251800A5;
	Tue, 12 Nov 2024 10:23:32 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 10:23:32 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Nov 2024 10:23:31 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH] hwmon: (acpi_power_meter) Fix fail to load module on platform without _PMD method
Date: Tue, 12 Nov 2024 10:12:28 +0800
Message-ID: <20241112021228.22914-1-lihuisong@huawei.com>
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

As ACPI spec said, _PMD method is optional. The acpi_power_meter
shouldn't fail to load when the platform hasn't _PMD method.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 6c8a9c863528..2f1c9d97ad21 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -680,8 +680,9 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 {
 	int res = 0;
 
+	/* _PMD method is optional. */
 	res = read_domain_devices(resource);
-	if (res)
+	if (res != -ENODEV)
 		return res;
 
 	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
-- 
2.22.0



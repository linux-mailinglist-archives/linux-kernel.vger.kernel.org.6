Return-Path: <linux-kernel+bounces-543425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05689A4D56C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D167A9399
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBE1F8736;
	Tue,  4 Mar 2025 07:54:28 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB081F55F8;
	Tue,  4 Mar 2025 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074867; cv=none; b=nRDowyNGOkUpAYBYJK8fSZrmnSWQKRUAsGO7txFVg6wSmwuYYq9QvD0IT2MbiVqiVw8hdyJ4uGElFKK9mC7kyeRvfPdD5Gaz9wjJCKgmnM8YZQTGXVJqW7JfVxUKAD0cJ+inHH8WhZW+n7Tn+tWc6WPJ6qEe85ya6ZtGvjFZiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074867; c=relaxed/simple;
	bh=iRL1xqpVHtKl17cWCTJwB5wPeu43QyomPaKN1qB2UTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTyu8fM2NDtTLmoFaXuRMDURJf7Ys7VqkPD4NAVq59t8aA1WZeZGTpFSjA6GR+CrBX0HqwJYv+uCv59r4SM8kyvuXH/NovlQHoAkMHSt8Oxdry5mtIk1/GjFGeTeLiYktkvZl3P5VkVlQ8/i9+6dnUd2hPMH5gJtSzaY6mYQzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z6SWw4SsYz1dyjv;
	Tue,  4 Mar 2025 15:50:04 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E1821A0188;
	Tue,  4 Mar 2025 15:54:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 15:54:16 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 15:54:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux@roeck-us.net>, <jdelvare@suse.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] hwmon: Fix the missing of 'average' word in hwmon_power_attr_templates
Date: Tue, 4 Mar 2025 15:46:40 +0800
Message-ID: <20250304074640.2770353-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The string "power%d_interval_max" and "power%d_interval_min" in the
hwmon_power_attr_templates[] are corresponding to the sysfs interface name
of hwmon_power_average_interval_max and hwmon_power_average_interval_min.
But the 'average' word is missing in two strings. Fortunately, there is
no driver to use it yet.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 9703d60e9bbf..1688c210888a 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -646,8 +646,8 @@ static const char * const hwmon_power_attr_templates[] = {
 	[hwmon_power_enable] = "power%d_enable",
 	[hwmon_power_average] = "power%d_average",
 	[hwmon_power_average_interval] = "power%d_average_interval",
-	[hwmon_power_average_interval_max] = "power%d_interval_max",
-	[hwmon_power_average_interval_min] = "power%d_interval_min",
+	[hwmon_power_average_interval_max] = "power%d_average_interval_max",
+	[hwmon_power_average_interval_min] = "power%d_average_interval_min",
 	[hwmon_power_average_highest] = "power%d_average_highest",
 	[hwmon_power_average_lowest] = "power%d_average_lowest",
 	[hwmon_power_average_max] = "power%d_average_max",
-- 
2.33.0



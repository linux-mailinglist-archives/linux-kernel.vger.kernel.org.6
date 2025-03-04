Return-Path: <linux-kernel+bounces-543965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F281CA4DBE9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD7188DCA1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9141FF5E9;
	Tue,  4 Mar 2025 11:09:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE621FF1C5;
	Tue,  4 Mar 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086544; cv=none; b=kLtyrexi+yQ+QoDBK05Fi2JJH/GO5sMVDTxg+UCXcK5K/6Hx5/EV8Y+12H5xzB1TfbfhNWLqtjPw9ireH4QFqUs59MvX5HkdzVbL0qDvBf1P9AJ6169dC59rEPtSzZ6eylGK6ooJGQ5HcvqihtpUrz0xICk5honuLdlFtQq2nBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086544; c=relaxed/simple;
	bh=iRL1xqpVHtKl17cWCTJwB5wPeu43QyomPaKN1qB2UTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s3OkmfrPvxZLXQba02//RV737wYpZiFTvno1MBxg7ttTmXiUnBfVCtd3uNFHiUKLJlun/H8uFVFycCeAfJcz6n2rBAkKMQIKYQ6yYgIJWFOkF4hu3pbEHxAD0d7h2fAdsEX2aqdbq6f6qjWY5HCWMThKzXfqHp27inwzXi7fCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z6XvY4JQLz1R64Y;
	Tue,  4 Mar 2025 19:07:21 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CF8F1A0188;
	Tue,  4 Mar 2025 19:08:59 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 19:08:58 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 19:08:58 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux@roeck-us.net>, <jdelvare@suse.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] hwmon: Fix the missing of 'average' word in hwmon_power_attr_templates
Date: Tue, 4 Mar 2025 19:01:27 +0800
Message-ID: <20250304110127.845408-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



Return-Path: <linux-kernel+bounces-287679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B66952B42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290E0B20E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3F119FA92;
	Thu, 15 Aug 2024 08:37:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9796CA62;
	Thu, 15 Aug 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711076; cv=none; b=snvy0VytwLYyoOez2HXT5TNx9PJeNK3YyF/QUADACt2rzmsLA/IXoIun3Y/znYaksgf1IfWDAw2h1e/NLYMbo4hrNjaxoXoj4o5bTyfrbZvLhzWJfybwhKqFA7Nf/yVIImVDJNWmzMYyIuxKvXMyKcC4SwrnGS3piUlBHQSSYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711076; c=relaxed/simple;
	bh=aLHWZ+prH1yu7gUoS2IujOE5Dd6NcAM8G7JOrptmwF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rli4jD+kKN4raUXDvViG1ERB7FBdV7u5JB45D2rOu1jOI5uqB/oUmTxaHMWYGLl8Pu1FSt7BwLIIzECL9k36OfYSfkLkOKMb7hRG6mJX5UtCw+XoS1m3jC2OY24VFAhTSqm+Lb7ZFweaeCExYyRYvRmXu5sFkfiAfCdAMVzUKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wkz4D0FcxzpTSp;
	Thu, 15 Aug 2024 16:36:28 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 29F1414037E;
	Thu, 15 Aug 2024 16:37:50 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 16:37:49 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <ch.naveen@samsung.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
	<liuyuntao12@huawei.com>
Subject: [PATCH] hwmon: ntc_thermistor: fix module autoloading
Date: Thu, 15 Aug 2024 08:30:21 +0000
Message-ID: <20240815083021.756134-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Fixes: 9e8269de100dd (hwmon: (ntc_thermistor) Add DT with IIO support to NTC thermistor driver)
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 drivers/hwmon/ntc_thermistor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index ef75b63f5894..b5352900463f 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -62,6 +62,7 @@ static const struct platform_device_id ntc_thermistor_id[] = {
 	[NTC_SSG1404001221]   = { "ssg1404_001221",  TYPE_NCPXXWB473 },
 	[NTC_LAST]            = { },
 };
+MODULE_DEVICE_TABLE(platform, ntc_thermistor_id);
 
 /*
  * A compensation table should be sorted by the values of .ohm
-- 
2.34.1



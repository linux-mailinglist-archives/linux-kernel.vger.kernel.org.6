Return-Path: <linux-kernel+bounces-314014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E0B96ADAF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E35BB2436F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D9944E;
	Wed,  4 Sep 2024 01:15:49 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4118C1F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412549; cv=none; b=XOzGPZgIPnI1z8tPLBUGV7ymN5b01+dbcrC1BUh037217G+FI5qlmdMJUVi5GVV49ZMfXxHf+6Y9mNnNJj8/ea0uNeFAbxpGF+7bR2+DcHfuAj+7gSlDoHx/sLGpL6CoPseRtOjznPs0NGVVkReGM8MZ9QTsLbuHaAKZjVcOiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412549; c=relaxed/simple;
	bh=tUpifkJtYAFIsEU9sUhmUFRLKm/S4l6kkl4fQfrCinM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M6staxRi01WI6mgWSdZFE40e994UOwbxyXslas1T3tnn5gk5vMfOq6HX1B7tKPFKPFIdAvYahQi4BOOKHfp9kN0MXKukztRHFtWha8Z58QiE7nvzpQ0mUXP+zuyPXIiVxY517uvbw0/b3PK15LyEKwWVvk+IP2N/xZIpMX5Alis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wz4GS5Gnhz1HJ2n;
	Wed,  4 Sep 2024 09:12:16 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C37F4140158;
	Wed,  4 Sep 2024 09:15:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:15:43 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>
CC: <lihongbo22@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] bus/fsl-mc: Convert sprintf()/snprintf() to sysfs_emit()
Date: Wed, 4 Sep 2024 09:24:15 +0800
Message-ID: <20240904012415.2022473-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

As Documentation/filesystems/sysfs.rst suggested, show()
should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

sysfs_emit validates assumptions made by sysfs and is the correct
mechanism to format data for sysfs. So we can do this conversion.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index dd68b8191a0a..f5c98fe6c879 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -175,8 +175,8 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return sprintf(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
-		       mc_dev->obj_desc.type);
+	return sysfs_emit(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
+			  mc_dev->obj_desc.type);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -202,7 +202,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.34.1



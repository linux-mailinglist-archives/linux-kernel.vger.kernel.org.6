Return-Path: <linux-kernel+bounces-314017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF3F96ADB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944DE1F21921
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0633E7;
	Wed,  4 Sep 2024 01:18:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFE63C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412721; cv=none; b=gYux2WV3cz9UY1A1cG6wSzhJQHMrY+NQWOq81G2eFRwiZ7E4TKo7jRNrfkmWgiSOueuYT7EjLFpbCL5SejbaDJXcHvdWxYpCoZ0FmLv+rM7NNGS3XAqBCXXIiQySWXgrl0YnvNK7FwUcJWSBdv3/PZJAqmDPfBNaxsiNi3VSYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412721; c=relaxed/simple;
	bh=tUpifkJtYAFIsEU9sUhmUFRLKm/S4l6kkl4fQfrCinM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oh+yaaCL7k9fX94TFwvtfP2TfllVjDtIsc1xTejUraM7BefBMXzPpZnuPKncNDGTyLN+3BO2O5WFUGBbezCBzqPtxmnnub/RVlxz869pZ9fDP4tGhJ9Ev1hu4z4W7vV3FZMcnPJDO4mELeR1EL0zDxhZf1Srqsu35FbceUb83RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wz4Mc1yBHzpVMB;
	Wed,  4 Sep 2024 09:16:44 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 54FB51403D2;
	Wed,  4 Sep 2024 09:18:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:18:36 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <parthiban.veerasooran@microchip.com>, <christian.gromm@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] bus/fsl-mc: Convert sprintf()/snprintf() to sysfs_emit()
Date: Wed, 4 Sep 2024 09:27:09 +0800
Message-ID: <20240904012709.2022574-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



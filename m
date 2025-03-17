Return-Path: <linux-kernel+bounces-564184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389E4A64FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DB9171152
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB623A9BA;
	Mon, 17 Mar 2025 12:48:51 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931D156F20
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215731; cv=none; b=ZlhSOEX464PnkxfQJ8v+DtZmD6FWMgNMBMmhYPSt0PaTWU0Ei262Eqlx00J2x51xhmgnxANkXiT5hTDMkl+OrSlyP151B8DMcVxUMSJ7zwI688MrtRkXd1pYnT5ilo3SCGYlJlP8clKmx/udJjZcDzTJ45LvOeFSfNxoZEd1hcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215731; c=relaxed/simple;
	bh=TGfuq/mvWmbAkTPeHZHr4vDXUR/V20kicyYAANurWXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSnek2Lwf8BR1D+nPA3V1FT4f51LmQUxEJsujflhCjbE5s6Rc/MIVE2WNclCWz0mmS8FsYkw09ilX4RTnlgt3ucFhQ5Bqv+jDAoRlkNihD+fmTWvnZxkncc+mBg5MbqcuQw601lUYK6VG+Yxp906UPWk/hzPCikUMgcAHuLGg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZGZSr2rM8z2Ccln;
	Mon, 17 Mar 2025 20:45:32 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 727A91400FD;
	Mon, 17 Mar 2025 20:48:45 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Mar 2025 20:48:45 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Mar 2025 20:48:44 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <suzuki.poulose@arm.com>, <james.clark@arm.com>,
	<anshuman.khandual@arm.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2] coresight: Fixes device's owner field for registered using coresight_init_driver()
Date: Mon, 17 Mar 2025 20:41:06 +0800
Message-ID: <20250317124106.271374-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn500004.china.huawei.com (7.202.194.145)

The coresight_init_driver() of the coresight-core module is called from
the sub coresgiht device (such as tmc/stm/funnle/...) module. It calls
amba_driver_register() and Platform_driver_register(), which are macro
functions that use the coresight-core's module to initialize the caller's
owner field.  Therefore, when the sub coresight device calls
coresight_init_driver(), an incorrect THIS_MODULE value is captured.

The sub coesgiht modules can be removed while their callbacks are
running, resulting in a general protection failure.

User a macro to automatically add the THIS_MODULE param to
coresight_init_driver() to fix this.

Fixes: 075b7cd7ad7d ("coresight: Add helpers registering/removing both AMBA and platform drivers")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
Changes in v2:
- even a macro to automatically add the THIS_MODULE param for coresight_init_driver();
- Link to v1: https://lore.kernel.org/lkml/c3744062-f7c1-82df-2fa1-591da3b2dc5e@huawei.com/T/
---
 drivers/hwtracing/coresight/coresight-core.c | 11 ++++++-----
 include/linux/coresight.h                    |  7 +++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0a9380350fb5..abf2e4fd4de0 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1486,18 +1486,19 @@ static void __exit coresight_exit(void)
 module_init(coresight_init);
 module_exit(coresight_exit);
 
-int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
-			  struct platform_driver *pdev_drv)
+int coresight_init_driver_owner(const char *drv, struct amba_driver *amba_drv,
+				struct platform_driver *pdev_drv,
+				struct module *owner)
 {
 	int ret;
 
-	ret = amba_driver_register(amba_drv);
+	ret = __amba_driver_register(amba_drv, owner);
 	if (ret) {
 		pr_err("%s: error registering AMBA driver\n", drv);
 		return ret;
 	}
 
-	ret = platform_driver_register(pdev_drv);
+	ret = __platform_driver_register(pdev_drv, owner);
 	if (!ret)
 		return 0;
 
@@ -1505,7 +1506,7 @@ int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
 	amba_driver_unregister(amba_drv);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(coresight_init_driver);
+EXPORT_SYMBOL_GPL(coresight_init_driver_owner);
 
 void coresight_remove_driver(struct amba_driver *amba_drv,
 			     struct platform_driver *pdev_drv)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 17276965ff1d..b07455956f7a 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -689,8 +689,11 @@ coresight_find_output_type(struct coresight_platform_data *pdata,
 			   enum coresight_dev_type type,
 			   union coresight_dev_subtype subtype);
 
-int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
-			  struct platform_driver *pdev_drv);
+int coresight_init_driver_owner(const char *drv, struct amba_driver *amba_drv,
+				struct platform_driver *pdev_drv, struct module *owner);
+
+#define coresight_init_driver(name, amba_drv, pdev_drv)	\
+	coresight_init_driver_owner(name, amba_drv, pdev_drv, THIS_MODULE)
 
 void coresight_remove_driver(struct amba_driver *amba_drv,
 			     struct platform_driver *pdev_drv);
-- 
2.33.0



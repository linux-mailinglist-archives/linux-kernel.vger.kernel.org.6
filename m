Return-Path: <linux-kernel+bounces-517941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB13A387DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62909189933E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE03226171;
	Mon, 17 Feb 2025 15:39:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633A225A31
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806778; cv=none; b=agdbt1dyx2aSm/vZoolsoil30rCDdmp/lPUC195PQT3v/q6BrhmpdXZwHSlPOOneYnWp0Q5CL0X3jP+peRTx7j9RCRkRlkKzCfhy1J5oZ1D/AEL8ZET1wWyiK71zzfXz+dCsDTUozyV7EdHkDWN88U4t54KcYa8QLN+8f3FR1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806778; c=relaxed/simple;
	bh=CA2RijW3yPILwx1/OXMstwMKjb68ASRuKWZ5cgdYTQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=TJfUIZBPC9NVH7yQ33nd6nlIspvhR71z08DnP1mNdJNtFPHIuBWdb+EU1rUIjaSUQGPZY2bP+ETd6oNFfnCcuZWkL57bOyv37eRGJiKBelYd7fzoy+OTtroPl8KZ3IAHz0gNYcLK8bL4FzDqMv95PXSNKFZEkUReGKTtnv3HE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF0E1692;
	Mon, 17 Feb 2025 07:39:56 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56CF93F6A8;
	Mon, 17 Feb 2025 07:39:36 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:49 +0000
Subject: [PATCH v3 08/19] firmware: arm_ffa: Unregister the FF-A devices
 when cleaning up the partitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-8-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=CA2RijW3yPILwx1/OXMstwMKjb68ASRuKWZ5cgdYTQs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1guyFPoPxfC649z/cShDaUBytdN/cFh7Om9t
 q5vMrXbLhmJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mMyYEACuESYGrK9KRhjys6cOVqqLW/jAYRg/LwHwJhd9ot3ZD+MFCPOtC+LqXemzo/0S2Yx7qFB
 /ndyi7IiC/PuVNvVpKHbm9gzKfDp2DZsezHD3cZO//V+yaiK89qJjDx/i8uBXbckCS/+f8ozmdx
 bgDF4z05j/GXIwk/kK9jvDEhVG5Qje3J638qPSc3b4O1jSXHP57lOJRN2oZt///hH+mgCPmPz4/
 tusFTbCdhVd0HBWiSh8Q/EAgNY1hqMx/bUhw9IZ/BrjUc8QE4IGtRuxiWiDfAE7L//a6FAnf1Wx
 +eM/pDneWpqZE4jxPhNem8wjGGUGLme0CigUk3tgWbUGn0FTdDd3yERR1ktZFLE2p+3roD1sXm2
 jP3TBBq3WeKs5S8dMLxqQCNrNtLK4CAt3pf1izRN9ShjEmUv2dUE1m75ySTehd60ty9gtnBTCNj
 xB6mMNqmWaxSTkWNMCEvPpLKphQW8FwRDSE5J29V1/TVPIYiG/UVbsaAI7oW33K5VxPsGSuGkja
 twI6oibVzAw7suI019KhCWVCxreKt2pWV36/0paIVe9ba+Fb3yaK0tC5GQaKckDeCcLKeVrmmI9
 PronMylys9uSbAD/Ikpns2nECa399A44lovmL5COCS4XdSEfI1oLZNl1qymjihO8LG+QrE1WUU+
 3HVjghivFojaIkA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Both the FF-A core and the bus were in a single module before the
commit 18c250bd7ed0 ("firmware: arm_ffa: Split bus and driver into distinct modules").

The arm_ffa_bus_exit() takes care of unregistering all the FF-A devices.
Now that there are 2 distinct modules, if the core driver is unloaded and
reloaded, it will end up adding duplicate FF-A devices as the previously
registered devices weren't unregistered when we cleaned up the modules.

Fix the same by unregistering all the FF-A devices on the FF-A bus during
the cleaning up of the partitions and hence the cleanup of the module.

Fixes: 18c250bd7ed0 ("firmware: arm_ffa: Split bus and driver into distinct modules")
Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c    | 3 ++-
 drivers/firmware/arm_ffa/driver.c | 7 ++++---
 include/linux/arm_ffa.h           | 3 +++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index a90e2faa990219574ff20b8f573dbb7ca76137d9..98118823cf84969480fc25c937881f9b773a38c2 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -160,11 +160,12 @@ static int __ffa_devices_unregister(struct device *dev, void *data)
 	return 0;
 }
 
-static void ffa_devices_unregister(void)
+void ffa_devices_unregister(void)
 {
 	bus_for_each_dev(&ffa_bus_type, NULL, NULL,
 			 __ffa_devices_unregister);
 }
+EXPORT_SYMBOL_GPL(ffa_devices_unregister);
 
 bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 {
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 320ae654cb968ef573995764d9d35c027d74a33b..15305920ca9f2bcc72ac7453080f5c10430a3e26 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1494,10 +1494,8 @@ static int ffa_setup_partitions(void)
 
 	/* Allocate for the host */
 	ret = ffa_xa_add_partition_info(drv_info->vm_id);
-	if (ret) {
-		/* Already registered devices are freed on bus_exit */
+	if (ret)
 		ffa_partitions_cleanup();
-	}
 
 	return ret;
 }
@@ -1507,6 +1505,9 @@ static void ffa_partitions_cleanup(void)
 	struct ffa_dev_part_info *info;
 	unsigned long idx;
 
+	/* Clean up/free all registered devices */
+	ffa_devices_unregister();
+
 	xa_for_each(&drv_info->partition_info, idx, info) {
 		xa_erase(&drv_info->partition_info, idx);
 		kfree(info);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index e8b8ae8b192ab11d5550c16fd33fa9d192b07f67..ca2ad5b0ac4309052d55dcf546d29423bbd40a67 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -176,6 +176,7 @@ void ffa_device_unregister(struct ffa_device *ffa_dev);
 int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
 void ffa_driver_unregister(struct ffa_driver *driver);
+void ffa_devices_unregister(void);
 bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 
 #else
@@ -188,6 +189,8 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 
 static inline void ffa_device_unregister(struct ffa_device *dev) {}
 
+static inline void ffa_devices_unregister(void) {}
+
 static inline int
 ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 		    const char *mod_name)

-- 
2.34.1



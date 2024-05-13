Return-Path: <linux-kernel+bounces-178017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3838C4778
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9ED7B22242
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F839535A5;
	Mon, 13 May 2024 19:27:02 +0000 (UTC)
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182B1BDD0;
	Mon, 13 May 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628422; cv=none; b=rXCo99cUB0DJ4JJaDztNBcTvF8l07Ow+itUOCdy7CWSVwuwuxquNJlCpT9C5dYEv5uodRHcvjrmyQptCoHOFwpp41hey4+WJdrqqlgVHYlzbJzGJM812bgUkJBI06OKZdUj2UALVTLt564KGR9qQ+AQ44iTfUT0LEqb+kKzBfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628422; c=relaxed/simple;
	bh=Os/20LJpK8mq5UlfbPRK0OKmNWkPSYyz3PqqnlzK64A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7+dxHY6mGOpKAlZ12w1o1kZ5XAh1Rxvff23iSI2r0YFwWSkruLNKe9AXdi530T5JxpE+T8TU6in1c//AxXfpaRE9JmKAkyLbC3NQVbsNy13J3NR3qb8WS/+0L+M8f7xD6c66vaXLvxJ+epzlzn9zrih/XK23Vc/PyhcT4pG4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from [2.211.228.80] (helo=marius.fritz.box)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mail@mariuszachmann.de>)
	id 1s6bK2-007PBn-Dv;
	Mon, 13 May 2024 21:26:54 +0200
From: Marius Zachmann <mail@mariuszachmann.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marius Zachmann <mail@mariuszachmann.de>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon: (corsair-cpro) Add firmware and bootloader information
Date: Mon, 13 May 2024 21:25:38 +0200
Message-ID: <20240513192538.40144-2-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 241080
X-Con-U: 0-mail

Add support for reporting firmware and bootloader version using debugfs.
Update documentation accordingly.

Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---
Changes in v4:
- split get_fw_version into get_fw_version and get_bl_version
- only create debugfs file, when the reading succeeded

Changes in v3:
- use different debugfs directory name for each device

Changes in v2:
- better patch description
- Documentation uses "Firmware version" and "Bootloader version"
- removed conditional CONFIG_DEBUG_FS
- get_fw_version gets called from ccp_debugfs_init
- get_fw_version does print a hid_notice when an error occurs
  instead of failing.
---
 Documentation/hwmon/corsair-cpro.rst |  8 +++
 drivers/hwmon/corsair-cpro.c         | 88 ++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
index 751f95476b57..15077203a2f8 100644
--- a/Documentation/hwmon/corsair-cpro.rst
+++ b/Documentation/hwmon/corsair-cpro.rst
@@ -39,3 +39,11 @@ fan[1-6]_target		Sets fan speed target rpm.
 pwm[1-6]		Sets the fan speed. Values from 0-255. Can only be read if pwm
 			was set directly.
 ======================= =====================================================================
+
+Debugfs entries
+---------------
+
+======================= ===================
+firmware_version	Firmware version
+bootloader_version	Bootloader version
+======================= ===================
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 3e63666a61bd..29ccf67b2066 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -10,11 +10,13 @@
 
 #include <linux/bitops.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -28,6 +30,8 @@
 #define LABEL_LENGTH		11
 #define REQ_TIMEOUT		300
 
+#define CTL_GET_FW_VER		0x02	/* returns the firmware version in bytes 1-3 */
+#define CTL_GET_BL_VER		0x06	/* returns the bootloader version in bytes 1-2 */
 #define CTL_GET_TMP_CNCT	0x10	/*
 					 * returns in bytes 1-4 for each temp sensor:
 					 * 0 not connected
@@ -78,6 +82,7 @@
 struct ccp_device {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
+	struct dentry *debugfs;
 	/* For reinitializing the completion below */
 	spinlock_t wait_input_report_lock;
 	struct completion wait_input_report;
@@ -88,6 +93,8 @@ struct ccp_device {
 	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
 	DECLARE_BITMAP(fan_cnct, NUM_FANS);
 	char fan_label[6][LABEL_LENGTH];
+	u8 firmware_ver[3];
+	u8 bootloader_ver[2];
 };
 
 /* converts response error in buffer to errno */
@@ -496,6 +503,83 @@ static int get_temp_cnct(struct ccp_device *ccp)
 	return 0;
 }
 
+/* read firmware version */
+static int get_fw_version(struct ccp_device *ccp)
+{
+	int ret;
+
+	ret = send_usb_cmd(ccp, CTL_GET_FW_VER, 0, 0, 0);
+	if (ret) {
+		hid_notice(ccp->hdev, "Failed to read firmware version.\n");
+	} else {
+		ccp->firmware_ver[0] = ccp->buffer[1];
+		ccp->firmware_ver[1] = ccp->buffer[2];
+		ccp->firmware_ver[2] = ccp->buffer[3];
+	}
+
+	return ret;
+}
+
+/* read bootloader version */
+static int get_bl_version(struct ccp_device *ccp)
+{
+	int ret;
+
+	ret = send_usb_cmd(ccp, CTL_GET_BL_VER, 0, 0, 0);
+	if (ret) {
+		hid_notice(ccp->hdev, "Failed to read bootloader version.\n");
+	} else {
+		ccp->bootloader_ver[0] = ccp->buffer[1];
+		ccp->bootloader_ver[1] = ccp->buffer[2];
+	}
+
+	return ret;
+}
+
+static int firmware_show(struct seq_file *seqf, void *unused)
+{
+	struct ccp_device *ccp = seqf->private;
+
+	seq_printf(seqf, "%d.%d.%d\n",
+		   ccp->firmware_ver[0],
+		   ccp->firmware_ver[1],
+		   ccp->firmware_ver[2]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(firmware);
+
+static int bootloader_show(struct seq_file *seqf, void *unused)
+{
+	struct ccp_device *ccp = seqf->private;
+
+	seq_printf(seqf, "%d.%d\n",
+		   ccp->bootloader_ver[0],
+		   ccp->bootloader_ver[1]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(bootloader);
+
+static void ccp_debugfs_init(struct ccp_device *ccp)
+{
+	char name[32];
+	int ret;
+
+	scnprintf(name, sizeof(name), "corsaircpro-%s", dev_name(&ccp->hdev->dev));
+	ccp->debugfs = debugfs_create_dir(name, NULL);
+
+	ret = get_fw_version(ccp);
+	if (!ret)
+		debugfs_create_file("firmware_version", 0444,
+				    ccp->debugfs, ccp, &firmware_fops);
+
+	ret = get_bl_version(ccp);
+	if (!ret)
+		debugfs_create_file("bootloader_version", 0444,
+				    ccp->debugfs, ccp, &bootloader_fops);
+}
+
 static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ccp_device *ccp;
@@ -542,6 +626,9 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = get_fan_cnct(ccp);
 	if (ret)
 		goto out_hw_close;
+
+	ccp_debugfs_init(ccp);
+
 	ccp->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsaircpro",
 							 ccp, &ccp_chip_info, NULL);
 	if (IS_ERR(ccp->hwmon_dev)) {
@@ -562,6 +649,7 @@ static void ccp_remove(struct hid_device *hdev)
 {
 	struct ccp_device *ccp = hid_get_drvdata(hdev);
 
+	debugfs_remove_recursive(ccp->debugfs);
 	hwmon_device_unregister(ccp->hwmon_dev);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
-- 
2.45.0



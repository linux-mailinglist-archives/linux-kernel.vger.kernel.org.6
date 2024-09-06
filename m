Return-Path: <linux-kernel+bounces-318724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22A96F21A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C311F2566E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0E1CB33E;
	Fri,  6 Sep 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ORP2VeGI"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B51CB328;
	Fri,  6 Sep 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620450; cv=fail; b=eTyqTJBcZaZsi6alwcHZOzMM/OXjaoURHyD/COrICxIcT4Y1rzcUIEDOpydIQx1A2GHOz9zI7wEtw/5O4fecdyS0WNQxrWQ7dC0dmufSo4i8Kb0zABVqBQSu5mgdVqCPEA96fuLqeHN4vueGy2UVI3PGOwp6+9dlD07bHJvd5LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620450; c=relaxed/simple;
	bh=/sH2HVzCJBSvfmx68YXx5nlsYRNtVuBRyQZBPOKGFOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I28nIss0RCi5FF+kD+HbkBUFka5cnnVES4DOzrxvbYHtbCu8ltX99FladSeSHSMBcy/8dL/6V1v47qjQ2z0A7cepW2BPiWQWFolEku5Wotr9VEUErUc2PdW/sApvZM7O3hY4e1yU56yomz2uykQS5wm0mFtA/uhteV+1jmATmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ORP2VeGI; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR9yAJqCLQbAWpzm9mRp5OK0RKTnHTZeng/dbhJwQxo1SpHBHhjluWWQPV5AabpamDgIkvPrIiRFtmLs0hqL3k/Wg7mLn6NGEU5gAu8Yo1HPv01lX1u8veckKFi6shy8vDRRYuRsJBPPY+9i8C18IbJRCCNF/p0FZq94Kwjuead01gPCCpXUqxWXF7IvUsPRTwdqpxSpwlBb0TOT9gZN8D/I7CyRJSxnMTx63935JSlr9t09n2vGmzqn0NBVsOVWNgvUSSupnD518d2/Qsazd1lk+3erAhuT0iQNVQmu3A5f42jUSTBGT6gqTdyDgRzuf0hecoAljCPz70qk4wVHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1WvseWLnscFaORs0UX3Ksr7JLqZgR+JpN/14+gcdhc=;
 b=uZ1UuBW6/D1pJRJK13dtRG/oRQG7zTNI41FyPN6WXiTOi94pJKaKF70UiPt3ib0K1deDT8cwjGjF5MS/keXL5+FuLzbwEsRu0emmvaL+P6CvD/XURg2Ia21pNcxjWnYmQo1RPV4ihu9If5QTSVD87O4qipOr79CVHZtyPhvTeBugUgH9bHvJhpHwBqrdV6dtWg3nnmC89XSBxkSXEde4Zj6wZOjYbpScGkzPJpsXMRYII7Aj1FJCyf1NeP8ALegqPKgM+TiT3LNOO9W2fopX8DgcvQr0nm36QECD0NnPBiqZlgYwcMzvtNCUaNCPw/ru0o0RmAt1Vt4alBtZsoEy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1WvseWLnscFaORs0UX3Ksr7JLqZgR+JpN/14+gcdhc=;
 b=ORP2VeGI12Q/nUf4+MYhP7bX/dqotKYGMBZhMsb9GPOjbNzHMvvjTxjLupzZMIwgoHlGsNOuUANCtMTxj/Js5S6DyYr4nQOwVaNtFKwm/YfHWLpxd0yNyOqb896amtpsCKbLVPO2yGALcSWbu4ROo9d1dEd7PCkALYB8v6YW3tY=
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 11:00:43 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::e4) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 11:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Fri, 6 Sep 2024 11:00:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 06:00:41 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 06:00:38 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <jbrunet@baylibre.com>,
	<angelogioacchino.delregno@collabora.com>, <macpaul.lin@mediatek.com>,
	<frieder.schrempf@kontron.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v5 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support
Date: Fri, 6 Sep 2024 16:30:23 +0530
Message-ID: <1725620423-1758964-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1725620423-1758964-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1725620423-1758964-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5caebf4a-a293-43a1-1b1e-08dcce632707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8mdWxlcB4umXkP+6kDDn9XtTTOjBlVyvMiOckpY2OdLRk7a+Dlw0B5dsf+Hw?=
 =?us-ascii?Q?1qZ/CREObB6paDI9uRxGM6Wq5RHVeQTD2+5/S6HH3YAxEaPbn1gLnySaiDTQ?=
 =?us-ascii?Q?6NJ1WJGcU3QK/eBiY0WSeXjuBNhYZaxsDL1Ft7lAghK+YVJjIoHaA7vnC3dx?=
 =?us-ascii?Q?K0+fakHavLYXhrA5nZIJ4RMR3VzYPq8MgKcSMbLKsNw2bljvI6lMNC4WEpVK?=
 =?us-ascii?Q?feuRKCrgX+jeGf0wMqnhzG6aWq36nOEDj2Jxk2zVsCkhkRUFT/SM7xIc/XH+?=
 =?us-ascii?Q?GaAOQafTAlISbBpqKiDx8GdTWCawUKWE5oacIfvf6BLXfxkZvqFwdhSwbIP8?=
 =?us-ascii?Q?ihPR8HVtrGX+SaZPiMuw2o30Ge/xcSEEDNJDgVAf5wTafr7Ehq95al7EgU+y?=
 =?us-ascii?Q?Vh7+f0GRJPORR83lHBckRoBwsuBdiLKd3vxW4WZQY7r0pBpWaZ11qAdaZLCa?=
 =?us-ascii?Q?GBPEnE7qw4ZojCH2D+S+gp0LWS4FlXh9LnzU7Jmyq0smDUc5ZuBQBiV/Ox65?=
 =?us-ascii?Q?gqaHMstkZg6ooZJO49kFkZRxBj7YeqCFvXemVOBnMRnOzQryWfzuMqh3bz02?=
 =?us-ascii?Q?KOOsNyDErxYgZ0V+M9qMnvh/+igXMbQiKA1KmR4ennIHT+676K+um01NNTnL?=
 =?us-ascii?Q?k7uV45k9t2NdbQi4aIjYvrPwHHSFAqVzHjl7aOnx7/GNecF4UllNap4sRdXI?=
 =?us-ascii?Q?QTT3fg9ov4k/m1ASq8It4iSjOM4J27Jihe+xifwMUMG5eOOH/pckN7PIcV3Z?=
 =?us-ascii?Q?S7BHetXlU3zs0FKQcNKuSlddbFv16aqOg8w753Bg2wJo2HVDlxZlhUB/L2/3?=
 =?us-ascii?Q?qJ8M8Xug8lvfS6w/PhkMeF6InAtCu6fNl5uSedyGtmLJBwflraJpqP0b9LOV?=
 =?us-ascii?Q?rVYN/BIWU06E+RLSI2imbCr1CX/3JuTSJcvrCgQkl8lRPkJIDl5CtLsZv8hj?=
 =?us-ascii?Q?sXtmvAHTdBRrm6tPrdoqWu9m4Sn5NKytPsKocybN8qFojVDiiQDT0HBsoOta?=
 =?us-ascii?Q?cOX02wZ9Q4UHne2/otj8f2zLuSADMUygxOhy3hZV8txto5vlJGHSvgZlR5+f?=
 =?us-ascii?Q?MfrH/W0koGG6YJAyc2sxDevii6VHQ59jfLHCpluC+Cwn4GY2lssBU0uAE0bj?=
 =?us-ascii?Q?JOBvi37+BXPYN3MI9z02MQ+vUBKPjGXU3ri6H6H3DsuAeyBXzPsgG6rESD4O?=
 =?us-ascii?Q?p1aTLbAa0DFS0Hl7PcRt4O3osS7jf2nLR9qObNsznSEKyfiUysOx0voLS5Cq?=
 =?us-ascii?Q?jJ/4DK6wlnsmvaVDHPA+0/0re3IND/ORgbtAvuLwlFuIrHSsUwhuTk4q+rt+?=
 =?us-ascii?Q?gJCbmFhGToCPP0xbtkPkqgR6WiBRCaCghLmWUCtaxBUXwfltBX+1sNEzKcp3?=
 =?us-ascii?Q?gYwThBpwQXG3dhxB4VuAhn1TBodJDCrsFbN/680645kQqajoP0V2aciQxMHD?=
 =?us-ascii?Q?Dp5XjPer7dzmhKR0bus3HKy7TMWi3ZOI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:00:42.9754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caebf4a-a293-43a1-1b1e-08dcce632707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961

usb5744 supports SMBus Configuration and it may be configured via the
SMBus slave interface during the hub start-up configuration stage.

To program it driver uses i2c-bus phandle (added in commit '02be19e914b8
dt-bindings: usb: Add support for Microchip usb5744 hub controller') to
get i2c client device and then based on usb5744 compatible check calls
usb5744 i2c default initialization sequence.

Apart from the USB command attach, prevent the hub from suspend.
when the USB Attach with SMBus (0xAA56) command is issued to the hub,
the hub is getting enumerated and then it puts in a suspend mode.
This causes the hub to NAK any SMBus access made by the SMBus Master
during this period and not able to see the hub's slave address while
running the "i2c probe" command.

Prevent the MCU from putting the HUB in suspend mode through register
write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2
register at address 0x411D controls this aspect of the hub. The
BYPASS_UDC_SUSPEND bit in register 0x411Dh must be set to ensure that the
MCU is always enabled and ready to respond to SMBus runtime commands.
This register needs to be written before the USB attach command is issued.

The byte sequence is as follows:
Slave addr: 0x2d           00 00 05 00 01 41 1D 08
Slave addr: 0x2d           99 37 00
Slave addr: 0x2d           AA 56 00

Also since usb5744 i2c initialization routine uses i2c SMBus APIs invoke
these APIs only when i2c driver is enabled in the kernel configuration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- Drop Kconfig I2C_CONFIG dependency and instead put the _i2c_init()
  implementation inside IS_ENABLED(CONFIG_I2C) check. Also a note
  that check for get i2c-bus phandle and find i2c device is not
  guarded by CONFIG_I2C check as we want to return error when i2c-bus
  phandle is present and CONFIG_I2C is not enabled in kernel
  configuration.

Changes for v4:
- Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
  introducing a dependency on I2C_CONFIG. This error is reported
  by kernel test on v3 series and usb:usb-testing 20/25 branch.
  https://lore.kernel.org/all/2024082503-uncoated-chaperone-7f70@gregkh

Changes for v3:
- Add comment for UDC suspend sequence.
- Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES and replace
  it with literal + comment.
- Move microchip defines to source file.

Changes for v2:
- Move power on reset delay to separate patch.
- Switch to compatible based check for calling usb5755
  onboard_dev_5744_i2c_init(). This is done to make
  onboard_dev_5744_i2c_init() as static.
- Fix subsystem "usb: misc: onboard_usb_dev:..."
- Use #define for different register bits instead of magic values.
- Use err_power_off label name.
- Modified commit description to be in sync with v2 changes.
---
 drivers/usb/misc/onboard_usb_dev.c | 75 ++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index da27c48fc11d..578cb4b2bf62 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
+#include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -29,6 +30,17 @@
 
 #include "onboard_usb_dev.h"
 
+/* USB5744 register offset and mask */
+#define USB5744_CMD_ATTACH			0xAA
+#define USB5744_CMD_ATTACH_LSB			0x56
+#define USB5744_CMD_CREG_ACCESS			0x99
+#define USB5744_CMD_CREG_ACCESS_LSB		0x37
+#define USB5744_CREG_MEM_ADDR			0x00
+#define USB5744_CREG_WRITE			0x00
+#define USB5744_CREG_RUNTIMEFLAGS2		0x41
+#define USB5744_CREG_RUNTIMEFLAGS2_LSB		0x1D
+#define USB5744_CREG_BYPASS_UDC_SUSPEND		BIT(3)
+
 static void onboard_dev_attach_usb_driver(struct work_struct *work);
 
 static struct usb_device_driver onboard_dev_usbdev_driver;
@@ -297,10 +309,48 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
 		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
 }
 
+static int onboard_dev_5744_i2c_init(struct i2c_client *client)
+{
+#if IS_ENABLED(CONFIG_I2C)
+	struct device *dev = &client->dev;
+	int ret;
+
+	/*
+	 * Set BYPASS_UDC_SUSPEND bit to ensure MCU is always enabled
+	 * and ready to respond to SMBus runtime commands.
+	 * The command writes 5 bytes to memory and single data byte in
+	 * configuration register.
+	 */
+	char wr_buf[7] = {USB5744_CREG_MEM_ADDR, 5,
+			  USB5744_CREG_WRITE, 1,
+			  USB5744_CREG_RUNTIMEFLAGS2,
+			  USB5744_CREG_RUNTIMEFLAGS2_LSB,
+			  USB5744_CREG_BYPASS_UDC_SUSPEND};
+
+	ret = i2c_smbus_write_block_data(client, 0, sizeof(wr_buf), wr_buf);
+	if (ret)
+		return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
+
+	ret = i2c_smbus_write_word_data(client, USB5744_CMD_CREG_ACCESS,
+					USB5744_CMD_CREG_ACCESS_LSB);
+	if (ret)
+		return dev_err_probe(dev, ret, "Configuration Register Access Command failed\n");
+
+	/* Send SMBus command to boot hub. */
+	ret = i2c_smbus_write_word_data(client, USB5744_CMD_ATTACH,
+					USB5744_CMD_ATTACH_LSB);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "USB Attach with SMBus command failed\n");
+
+	return ret;
+#endif
+}
+
 static int onboard_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct onboard_dev *onboard_dev;
+	struct device_node *i2c_node;
 	int err;
 
 	onboard_dev = devm_kzalloc(dev, sizeof(*onboard_dev), GFP_KERNEL);
@@ -340,6 +390,27 @@ static int onboard_dev_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	i2c_node = of_parse_phandle(pdev->dev.of_node, "i2c-bus", 0);
+	if (i2c_node) {
+		struct i2c_client *client;
+
+		client = of_find_i2c_device_by_node(i2c_node);
+		of_node_put(i2c_node);
+
+		if (!client) {
+			err = -EPROBE_DEFER;
+			goto err_power_off;
+		}
+
+		if (of_device_is_compatible(pdev->dev.of_node, "usb424,2744") ||
+		    of_device_is_compatible(pdev->dev.of_node, "usb424,5744"))
+			err = onboard_dev_5744_i2c_init(client);
+
+		put_device(&client->dev);
+		if (err < 0)
+			goto err_power_off;
+	}
+
 	/*
 	 * The USB driver might have been detached from the USB devices by
 	 * onboard_dev_remove() (e.g. through an 'unbind' by userspace),
@@ -351,6 +422,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
 	schedule_work(&attach_usb_driver_work);
 
 	return 0;
+
+err_power_off:
+	onboard_dev_power_off(onboard_dev);
+	return err;
 }
 
 static void onboard_dev_remove(struct platform_device *pdev)
-- 
2.34.1



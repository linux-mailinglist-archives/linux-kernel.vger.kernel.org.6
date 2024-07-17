Return-Path: <linux-kernel+bounces-255590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B63934291
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555CC1F231AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3289F1822CE;
	Wed, 17 Jul 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OrUhHPMJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC97185089;
	Wed, 17 Jul 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244259; cv=fail; b=WieaBuL23lPOEy4RKpnGyW1jW4QFFDRK2T2pXFQkBAuWAmWfbk17KAUySSid0UDKMNj1PLjI1G4UKE/DsnSsFJ3FynPOp04WnfjfaBByLjzoO5H/HR9IzVGYdAnGUSXEiztPeLindmHDe8NALm+xW2yTA5/GSioRP/OYezajykA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244259; c=relaxed/simple;
	bh=GCwGmcpoDQv7DvEVQjGMco25zYr/MX1Eqq1Wa8TezKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zkh7pjXjQBtgxpjrO5inBgOT18oxgeZT+9uP3Hr+Bux0JqWIW1Gzfvzp9AYSeGwxz/eprEPCD4rLXcMODmyxBfOfGYbQtlzSwu4LaVyxuA3CZ6n/ppElB+fYMg7VVx7NNu55AOmDvxY1N9huNuvrjeN1yrj2P75Yck3WOY1Ft5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OrUhHPMJ; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi38X3XNTr0dtXryztBGpt29Va7qNclW1JvxTGLKVmDdcFRF2tAWukJsR9ypso2Pc+5LgFIh2m/N9NjUYQwL3EdQWuq7gWiB0nTxs8Ji3lqfqaTw9GGOsF06WSIKrI17N0B/ckmTKPNyFdoQYuqL16d5BEXZOOAaZHVd6pINp7O+IpTUJZUA0lVouN99PvAqkr/7qdcPVcVtiBsfCNSY/qsI2wxs1TY1nDbb0YlZc6mJe0Twqp6YsPDx43GdZh734WIs0JMWNrwlzQD373Yt00njCZq5ldeBCiDyzkg2K2hd+hIhR8CDgil7JXE/468whxifBjXi0Ulk305ZSDgxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkILCyhoEvn4wvQCpUOW648SecjwAzWaeyu2NP166u0=;
 b=ZeRNZ0FNJ75T23JD1VYql8gezyXXpW52PLVEGVijBWZrovjmRR0f8CGl4dvlIm+5oeDCuenYu0+LW4Ek19Jt2r4+damdTyq8jSdIY70Fx9vguR8dvoNUWirDs2n1wpPun727N10TpZbCM63KmcrXGkAbW2IHbRcndPx5rkz6F0/3Ml1KcVXIhpTkQSE4F32FTXU4LRY62bb8VWGL2R9eI6C0VLAeE8ptaiC74WtRRYkHNu/Ly2ZYen3s+v4Ifl6UZ9aSZRhl++xs75zCwUc5SKe4MQub5c2sPt+uWxOkf7jA0+Fl2RK8sR9EhfKJLQzUihzprCI5CkT1ZtBW/2IDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkILCyhoEvn4wvQCpUOW648SecjwAzWaeyu2NP166u0=;
 b=OrUhHPMJyF8joaplhkB87FIpoaQv5V6ncgW0h7ii1b5Royert1HsScRq1aynNEiwluv0J94GN+8L/Lg+MTZEltKsVyKVg7TP1k5TMCwhail8U1kSg8saZ8i5UUa3XveHOfXDICwQJukBjlmPJgIX4PMZpVaqAiUlayeet3HidLI=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 19:24:12 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::b6) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 17 Jul 2024 19:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:24:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:24:11 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:24:09 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <benjamin.bara@skidata.com>,
	<macpaul.lin@mediatek.com>, <linux.amoon@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support
Date: Thu, 18 Jul 2024 00:53:43 +0530
Message-ID: <1721244223-3194869-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1721244223-3194869-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1721244223-3194869-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: bed58de3-06ac-4be0-ffa8-08dca6960a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s9qXGFaJTQn73AAvsIXioBIkqmJ70tX0w12wC7IGgQpQRxI9t33vMknko+bo?=
 =?us-ascii?Q?736xIgh60x7vcGS+l2BH0QuhFCb9r4TJq3iGV6LNZlRbuTCRICE7xa+BOGdK?=
 =?us-ascii?Q?+5e9k2k9/9t05M808gCXeVbBEch9dH+KbkmifXsJp8eArucSYCdtBRaEm0ZD?=
 =?us-ascii?Q?0Jbm47B3imqFbRIkjYdkPYGfQIer2Q6KrcX9Qfku5pwQG/xsbl4bTFtU5v/H?=
 =?us-ascii?Q?OFmXMXK15ZWJ3fDfkS5jkJ67NEXcU0q0QHruLZWy6blGgURr6amey2AZjvho?=
 =?us-ascii?Q?0G5eKTNsoM1UBsJ3OolKEfs38gB3gTcAbObZDdP1K3KxS8TtaGRlYXpnmUX3?=
 =?us-ascii?Q?qv66ZUbXVEe4utcRp9LYu/N7VMBpwKrBc93oNB20Pd1gET4wtC3LwQ1lC2Na?=
 =?us-ascii?Q?QoUrFkO76FrJB7B+oQTCcTBM79xcHCdik5ESHzb2c17ZpTFLqcFDoeB3s18W?=
 =?us-ascii?Q?r/QPPxWDXDzT7H0of94pes3Ot7EULZ2ciljVxQEUCYj3TkFRkZyJtzQ1zY9E?=
 =?us-ascii?Q?9XL8yZhtbErqdijYgmi3dup2tyFs4NQaXYTTW1hbxS9SbAaRVEski3CRobk0?=
 =?us-ascii?Q?vK8QWWUDEcjo1UaMcR9FkLEj1uN6iaqtu/rc7htXN87PSnNV3jERbZfl9H5C?=
 =?us-ascii?Q?qQ+Ql54v1uee6xJCahyWuMhsMLes66h20VXpmQwT6gH3KuI9PdJiTOGD0Xmh?=
 =?us-ascii?Q?6f8HvrIjojAALArJl9YAOs4PQFqo/+el665xGegA66Iq7BD14QSQmEDJHdSZ?=
 =?us-ascii?Q?j+egN9q6W0oQOsQorAcASKO1Eoj/H4xT+Rew9bU/JXkCawBHXmx4BTvZBal1?=
 =?us-ascii?Q?5CJULKGmblv+IC2YJLSuHNj1TtZgpsHblte/Fb8sdpI5//AIAwQa6S1YdKW6?=
 =?us-ascii?Q?m/J5Az2lyySBLw1jFKzwJy6BxLkqPafMdq1M94wwUtI/QOSo++DfxgynH3C5?=
 =?us-ascii?Q?EO4SM5kc2dV7E12Dyo24ByF6d9tRAYCef0JjQTnMq1VToX6yPiXrlQJatQZK?=
 =?us-ascii?Q?aiECsfWdXiA7Rl6nEh4uwrxQ9P/3KdT6Pwg0Qp7oZmZr3R2ujh5jzr4BFgGe?=
 =?us-ascii?Q?8SFHKkn+oBKhA8vdnobAeQauWI2lJtfiwICggjhWrdl5qbzgm8lsL5BriAi1?=
 =?us-ascii?Q?kfIIMdBqwMlcgLmCQpDIp5I+kVn/vgywj39aG7M43pdNMcoJmxBU1LVICVgg?=
 =?us-ascii?Q?LlkKyIwzEdGPHqOlJ16xo5/Hqr89VdhnyQOtmNGoeV7jiL9jiF3bBq7vePfW?=
 =?us-ascii?Q?/VdsNPH3qLo720oGQ3c4NV6MWB1mciwAH+buz8+vehKBYEsnOLFscW4o2Yzk?=
 =?us-ascii?Q?VHSB2hF4oQNh6j/mfitEW2cqUiCRSnusBXdn+6ezaFE27X80PbJxHoZpMmWl?=
 =?us-ascii?Q?4F3t82BkWaL/D4p7iw1iNwOSKeQvZxf8HyJ59zJwQUbYy9ySVbc9nzisUfzW?=
 =?us-ascii?Q?NnVjOAjgcHo2ehvCVCLPWJT0F5ac+Td0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:24:12.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed58de3-06ac-4be0-ffa8-08dca6960a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

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

Prevent the MCU from the putting the HUB in suspend mode through
register write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2
register at address 0x411D controls this aspect of the hub. The
BYPASS_UDC_SUSPEND bit in register 0x411Dh must be set to ensure that the
MCU is always enabled and ready to respond to SMBus runtime commands.
This register needs to be written before the USB attach command is issued.

The byte sequence is as follows:
Slave addr: 0x2d           00 00 05 00 01 41 1D 08
Slave addr: 0x2d           99 37 00
Slave addr: 0x2d           AA 56 00

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
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
 drivers/usb/misc/onboard_usb_dev.c | 56 ++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h | 12 +++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 94d5424841fd..4f3845f35ac4 100644
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
@@ -297,10 +298,40 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
 		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
 }
 
+static int onboard_dev_5744_i2c_init(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	int ret;
+
+	char wr_buf[7] = {USB5744_CREG_MEM_ADDR, USB5744_CREG_MEM_NBYTES,
+			  USB5744_CREG_WRITE, USB5744_CREG_NBYTES,
+			  USB5744_CREG_RUNTIMEFLAGS2,
+			  USB5744_CREG_RUNTIMEFLAGS2_LSB,
+			  USB5744_CREG_BYPASS_UDC_SUSPEND};
+
+	ret = i2c_smbus_write_block_data(client, 0, sizeof(wr_buf), wr_buf);
+	if (ret)
+		return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
+
+	ret = i2c_smbus_write_word_data(client, USB5744_CREG_ACCESS,
+					USB5744_CREG_ACCESS_LSB);
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
+}
+
 static int onboard_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct onboard_dev *onboard_dev;
+	struct device_node *i2c_node;
 	int err;
 
 	onboard_dev = devm_kzalloc(dev, sizeof(*onboard_dev), GFP_KERNEL);
@@ -340,6 +371,27 @@ static int onboard_dev_probe(struct platform_device *pdev)
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
@@ -351,6 +403,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
 	schedule_work(&attach_usb_driver_work);
 
 	return 0;
+
+err_power_off:
+	onboard_dev_power_off(onboard_dev);
+	return err;
 }
 
 static void onboard_dev_remove(struct platform_device *pdev)
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index 82c76a0b3346..5744c589b90f 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -8,6 +8,18 @@
 
 #define MAX_SUPPLIES 2
 
+#define USB5744_CMD_ATTACH			0xAA
+#define USB5744_CMD_ATTACH_LSB			0x56
+#define USB5744_CREG_ACCESS			0x99
+#define USB5744_CREG_ACCESS_LSB			0x37
+#define USB5744_CREG_MEM_ADDR			0x00
+#define USB5744_CREG_MEM_NBYTES			0x05
+#define USB5744_CREG_WRITE			0x00
+#define USB5744_CREG_NBYTES			0x01
+#define USB5744_CREG_RUNTIMEFLAGS2		0x41
+#define USB5744_CREG_RUNTIMEFLAGS2_LSB		0x1D
+#define USB5744_CREG_BYPASS_UDC_SUSPEND		BIT(3)
+
 struct onboard_dev_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
 	unsigned long power_on_delay_us; /* power on pulse width in us */
-- 
2.34.1



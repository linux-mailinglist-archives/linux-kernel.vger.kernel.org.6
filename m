Return-Path: <linux-kernel+bounces-269502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E28943392
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE142826B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9271BD028;
	Wed, 31 Jul 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zAuT00pc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB01BD002;
	Wed, 31 Jul 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440568; cv=fail; b=iUAykoAdqk5r5KlnSQsfh1Qjiv16/jShS0b/KgbXLzJsBZBuYfJtO4WpaQXxyoZ6Im/1eUhjkHXiXmj+hW6p0alOVoTIbd18tk6ZxdSg374HBm8j0i8KhHNDzAgu6r6q2dOCTYrhDbGow0RWYOVFiHyh3XEftexzVSC0+Wu9fKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440568; c=relaxed/simple;
	bh=5amGSm0P+IV+nCfKwiNwhDK8V6xhvw+nyeFHN2zH3sA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/5ESEQhomsfo8X5DevLexJMHG62cErfG8X/7BPehmowxYmjBMvlNT19DurSeBT1cdN6lcuJIx6dhq22F9EvHxfMFqwWdajCAhKzrrPAIMFSF1k37e0ohmQ9zcazBCoTXLrerQQpvVroZfglK5N+R4n+y+7fgAlZfnBeSoRqwcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zAuT00pc; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rp2JVeZKsp1U/0Mpw7s15iv9eqzTKhNFKwHZgnGzUSZHUIkHdIdpwH2jSkJbz3o2zBTEUPrN3XHhGvv4mwiiw/qd64JGUpQoK3VTJnEkyhtYD5jlc5rY9lDwfRjCZ2S1CCnzuqzDidwB/yd4H3ePmLMlr8EMOzPVzBmhKwy4jngWdiKG2ggxwiKKTMcBlAuxrw1YyqUYYlqxkuQ0tNI18MColrnehtUAXpaCXQHnToa2ysDVBgVg5lZ7JIYULyX7hicJWQ94k4TaG+4i5WIdeAShlDNs2iEXBtl30BYVGnyzb+gRAIXkigjJrQDHtFLIqWD/AqMbZYaXGZeEBB3Uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQA1ljYmHTKiXu0J18FhMdsiGiWgL829U2IHwXIHUy0=;
 b=PtbO8RJBOuVMpAGiuTcg+XVoUfm4Rfwuqsyx5KRnTn6JY9VOQAtraz8zf16Np5r5kD4quP1ml8HDQ5l7Qp61tOcZ/uBsqv5lXsZKxgPAdN9B7JReBDkHeCw1UzbGC3wfz1VO293wDV2hDyO3Wi93ky2t1T1bFo+kI/4kySIEYXYPC98suNtiMj/9Cu917tJU0iFd/fvMyl5ojeebhj3d5e2ygjrK4/fvCdU++iA7/mj1g2XMe7CZOSsRd9bmYz5LZgUgPtqmHKzy9m5S0zkMQbVTu0HMwSqxfNVU70H5QIPzvHrpT2CFbvI02Ue6n7onMbBCAcip6pWyleNYryNEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQA1ljYmHTKiXu0J18FhMdsiGiWgL829U2IHwXIHUy0=;
 b=zAuT00pcUnQNj9b50Mr+w9NZ+EczwJ7LDe6LnrhPbctfKRpbp/TWR3sssPxiqyNoS6TwCWEUzbyzbyCYmSjRQLScfpeLjUoFT77S9OCer3vzdPgLSxmSe1CcAs+K1mMuhan6T8CKQvEXqYc88FzTBcvTw1nDc0n0uJ8WbF0m5KM=
Received: from PH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:5::26)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 15:42:41 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::14) by PH0PR07CA0021.outlook.office365.com
 (2603:10b6:510:5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 15:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 15:42:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 10:42:40 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 10:42:37 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <macpaul.lin@mediatek.com>,
	<jbrunet@baylibre.com>, <stefan.eichenberger@toradex.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v3 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support
Date: Wed, 31 Jul 2024 21:12:28 +0530
Message-ID: <1722440548-107682-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1722440548-107682-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1722440548-107682-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d10d39-dbdc-44ff-26c8-08dcb17769d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jkvX/aLq+/+CC6LzFctSc4CSrAzuEXbdjKa3XU+ItG57uxXqYux9H7IofszE?=
 =?us-ascii?Q?q0Y+RUTT1halxE62Y1G8ruuAHE+4gL0/GPjpKrOuadkBDjCZ+HVK8ouFG/bL?=
 =?us-ascii?Q?jSIgHZaR57qM8eoyxMh6LIMChMLm2fTtWmRe+n4oJ8eg1gxZtF3pCTaJQM1y?=
 =?us-ascii?Q?9W0n39FH17NkiE4EUkCgMsHNgXGIcUYy77XZB5L2DJAcm8BsMzrGUTUZX2MZ?=
 =?us-ascii?Q?8111NNz35mI7sYKhRoc7kh6+y5LOtsEyQhtll0UCYW3OsqXDm9KVJXo3CArx?=
 =?us-ascii?Q?SnsOveuB+SRUWN3sz8TZpHJpiy7LOmIlSBTb+H68lyxrCZ8PWPd26C4xRs1F?=
 =?us-ascii?Q?NCHJHQmZH6sYU39mfbxNUTgFzSu0gP5F4bYyFBgsHwJBgrBeRhzdqxpvHfUp?=
 =?us-ascii?Q?DTcQUzfGehepw5eN4LTdlxQjUvUlAgQ4DKHCk5mZWihav7nBtBQMHpa99iH+?=
 =?us-ascii?Q?EDjRiVYTF3fv28yzC6R67WqpN/FL+LhK3dgolDHHm+57VbShlD4a3CLyUOY3?=
 =?us-ascii?Q?pmKi+BpcH8xCQwmFMmPYKH8AW2KMfrg/EAonMLSjGGehJOa0xGPYJRDxKSNx?=
 =?us-ascii?Q?NMXc4qZLMbXdDNeSJtBcnGfWMswE1NAHcL/LY8U2mzeZsjkdpXk0pkkNBki3?=
 =?us-ascii?Q?mt4eDcXrziaSjqasR/6kjrt0RsWI6e3Lbf1aXms0iro6vRXaug3iojcoOFvH?=
 =?us-ascii?Q?H+tidLUX1vhikEFv6vCPIDA2Y6fWRyun/1KHIeB3vHBM4hTjIdrk1oDmrGt5?=
 =?us-ascii?Q?yYtrBZRo/mvdyHTGpq8c7Yi+X/Q3xRWfqe4a85ev62rHLPnCaOwRQAMBE+7w?=
 =?us-ascii?Q?ckVoiNDhxUZrBUQ7q7J0FT1+UpNdq4D/VqqzMGM+ubgp7QbewL1oCoYYj2ey?=
 =?us-ascii?Q?wEi3QU4nOkHo6e/3G4tzNLmn7W5S3pfoHMy2mFHTunxu2+qO+2MGBpaFyh0d?=
 =?us-ascii?Q?rjYeBOk+DniQ6i05pVKIR3A4T5AEvZDfX/uTfArk+PGibgo7S8YnYMZfLw9X?=
 =?us-ascii?Q?OWml5ffqnYsLYnyLeUlBwtWGp9CNlrLo8xINraQTBpC+CZGVsikPcijjEwW6?=
 =?us-ascii?Q?NGERO80fWAY1Wz9aVKOIRCqk4IXLpg9IGO3C6xpdh5hHVB6/881AYDyLKVh9?=
 =?us-ascii?Q?Km5CLSbDqxAhxuMLEe0I5E9J5dQYtLE6TfS52cXDAXDKTGke8LkosZMj9dxK?=
 =?us-ascii?Q?HZSYJd3XYHt/mol28UAZ0P+ny1mj2PJIs95EiPF6o68moKw1ZoxRAmOsQp7h?=
 =?us-ascii?Q?eR/x1/sELr0Y9b4Ht6gNPXDArpjM1JZqsqX/ZfEdKYQn5Nehbd8IoYN7mfsB?=
 =?us-ascii?Q?Y6Rn9pNdbhM/6NM6Va0mD9D7m7GZIduPyXGgB4J+/XN9Gx+HhWNSW+LlauEe?=
 =?us-ascii?Q?2S2EqushQ539d5AW+HwLeTPlns+RXRNjPfLhqChfKy2912kQSYoWEwVaVBsJ?=
 =?us-ascii?Q?LHtXUghS9xR6UHOpmbearP5tIL8MmRNN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:42:41.3787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d10d39-dbdc-44ff-26c8-08dcb17769d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

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

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
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
 drivers/usb/misc/onboard_usb_dev.c | 73 ++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index da27c48fc11d..247600015bca 100644
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
@@ -297,10 +309,46 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
 		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
 }
 
+static int onboard_dev_5744_i2c_init(struct i2c_client *client)
+{
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
+}
+
 static int onboard_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct onboard_dev *onboard_dev;
+	struct device_node *i2c_node;
 	int err;
 
 	onboard_dev = devm_kzalloc(dev, sizeof(*onboard_dev), GFP_KERNEL);
@@ -340,6 +388,27 @@ static int onboard_dev_probe(struct platform_device *pdev)
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
@@ -351,6 +420,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
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



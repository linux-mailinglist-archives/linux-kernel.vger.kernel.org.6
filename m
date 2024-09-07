Return-Path: <linux-kernel+bounces-319895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7C970381
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A21C21756
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117716131C;
	Sat,  7 Sep 2024 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDI9MqEg"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A915E5BA;
	Sat,  7 Sep 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732220; cv=fail; b=NcFIgpUf/NTqCIBUFYrbXskniMNaYdIzoFRKKMKYtDMR8JfPXu+458zHmlWKz4RJmmHW/VJo1wFIhiIX5aFgXULOhnC6PZAk7/HsbZDEZ8lEjRIzw1e//o6ID2peSDSU4fEz2BBxWCr+aKWisPlez1HpD6gzwYompwrqZGNnrak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732220; c=relaxed/simple;
	bh=8gvurG0pk0PLhtOwuk/P8FNSiBORvNrB+qIASBM4QBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuMDhfxhPB0BXTubfFZMC0l5Zty0Xn12T9oky0B0QUn+3WA4Ebu+jo0ilH0ZfaD5pH1fd+yeWOSqxsy2jLReqmLloZ+KfF2gV2rpap2qxi1p2YOIzlvmqgPqWJxItWK8WG1+S+7qlIgV/FxfaXp9sTWO5lPZ4v9VWqhEXOUTUE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDI9MqEg; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xErTvWsiArxa8ymyBqug5Or+7qAZ+YXAT5xzBoLg79TywlgDI+gaN+rfNN7fTh6BS0UXs4A8/Ktb0lLMfXI+M2HwxvjDRP3qkJ+uZNMHIoExwpVe/SLgahY2WsxxBPWbIHaLAmhiCLpiq6KWx8xAm4y2NjYF/1X/uQDbDulEicFv843Pfh3l2Tvt/3FDbPoxYybWHdyxwidklWA6/Xc8qT9hxJ4nw3/Oa2vHrBk99HnkNMvMY4VmZqM2G4h0lO1AVyqL4KASnnTLibsL6u6RanzpiQtuPbjdN93ooTXJAA1s83LuYyuZirRwhgzOleMBb3niocqvlHn5L22KXsB8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq9nHp7JM/c1RuzM1VpRsh34OZ9zK5qM4c6E5tjiVKY=;
 b=YOS5yk1OpZcQBn/H4CmMOhHNDemUwiqk78ZnLU4AgCJLbVceKjvwwhIMeDBJcH4hOdnf+gwVSs/pcl3h7AIwAC5ShDAIbG0cAbbVJ1lS0eYsCWYBCgTqGOOwZFu8R+klZwbQta4PSPqBLhsSbV9c3rLkofgLGEVqNfbjZC18l4sm2VHtSyMUzz6PfxV5gjCqQuaSN0LTPtamdziR78wr5fisMzkJWpUf2ouTSB2hLc7G/sqELfUs7rhWD6ujbrHZWqP66sTldP+tNNeYF8FS+u769JBH4DATZnnvLZAadEqIJq7shmSVOKCFJQRT3RuTTA8ncC5Ap5wogaJ1if2zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq9nHp7JM/c1RuzM1VpRsh34OZ9zK5qM4c6E5tjiVKY=;
 b=PDI9MqEgBVtMoo7cI6WFRpfHrb61M++cBUsede7l99CNqYocL77GSg2K14r7dRx65KwOYJWazdSEVIMV7dbNHkOuB/2TlomZxDeoEjbBGrecfOA02y/NnVe3KnYPAb3lUFQsveWzbYell651gzj8kj1JjNUanMHLLdHdmmVTox4=
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 18:03:31 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::59) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Sat, 7 Sep 2024 18:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 18:03:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 13:03:29 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Sep 2024 13:03:26 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <frieder.schrempf@kontron.de>,
	<macpaul.lin@mediatek.com>, <stefan.eichenberger@toradex.com>,
	<jbrunet@baylibre.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v6 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support
Date: Sat, 7 Sep 2024 23:33:16 +0530
Message-ID: <1725732196-70975-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1725732196-70975-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1725732196-70975-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: d123a800-b887-4016-f78b-08dccf6761a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MbU9QtabZtXpUQOwNQ4obLnhgIvxEUkhGUOrmNNm7boAzQi7TUd2wNuMCco/?=
 =?us-ascii?Q?+lQFwIyMys6zojg1V4pCmYicunPlmJUm0tQpmOAJWw7XvZpDCi1FKSkG4v0+?=
 =?us-ascii?Q?BWQFoWjYjHprXhRQE9kmcM7BK9CWETFcStW5NQ/hU+fTRql+D4q+g7FsRURL?=
 =?us-ascii?Q?WUrPgKoZSzwk0hu45oJAoAGIGdLlYKDjsexiaKqIxWPVGFEkt30cd/Q90V7a?=
 =?us-ascii?Q?90/xbjyFnmiLtAHFI5OdYgQvAK222Sdd8xdebrxtpSYZuWI9YLnmi7N5oy+n?=
 =?us-ascii?Q?M/Xna7mpqJ6ioQ3VDKMiahF/Skbu5abTAv2Qf5bHbtWsO1k+SyVciY1Gvr8+?=
 =?us-ascii?Q?3/HJv6sVR5AKNyrY1f3PjTQPhW4Nr1huEPuQvnuRcoU9MvpompiQmUmAFNG3?=
 =?us-ascii?Q?F+VUfFLf9Jb0jAhOVyEfDHJ+lDufOvHJtHKo/r0Ubm1gBKLrB/4qcfHCuB5s?=
 =?us-ascii?Q?IdzGqMeqMVCu8Pdka2PSJscWXGqPXbC5OEG6v2B45G2+o/lJYSW+7JVKOek6?=
 =?us-ascii?Q?HdOhUDpYDulHCGAvFKpAgzxn1/vpI5BihBqyzk17hTc5x7N5ZN+kPdb0z0TD?=
 =?us-ascii?Q?hdFk0bGfMt3bCfvmxuNMD90PqTS7Qpss8IU5YP3nqEuXxnNzm5f2xOq8saIL?=
 =?us-ascii?Q?YKhaJx4/S3ADQStJ69XkQmImfapXIF0SDWI8UBNtjZqHuka0s4B6I75y9dSY?=
 =?us-ascii?Q?a/0TKN1O8TuO9VXG+x+cuP980HYRj0T45caBhOxWIzd513tbZGvPq7iKMvqo?=
 =?us-ascii?Q?U5h4xMCJPZR026n8A4l8O5uGPg2p53dJUOBqIU4QHR8XcQR4OShYpgd84jhT?=
 =?us-ascii?Q?NIUQiJn1yLZ8uYThjavE8Z7Gvzw9Edkb2VjFtXaiFU0Sk1+pF/fC1qIHxOnt?=
 =?us-ascii?Q?w6lYVwCdJ7l0BNs1W02YbK/vsxqlHNZv3TlOxx6EpSiZI3nxc1ru/+LY0IFL?=
 =?us-ascii?Q?WjzMVGVcckzoh74o30Ltn2RXU/fgLvXNzN8eBZ2oT4P9bBydTdJqf/jfZM3+?=
 =?us-ascii?Q?5+kEHwJJUdmyDRjM8a3Drt95W/hVtmHzikM3Y7ToAFFJkBqvYqr55s+VoPuS?=
 =?us-ascii?Q?5QuMCyN2Z+sWb93uxGN6AfXaHVtu4skjWgYD+HAg4IjLxwX+k5yj2Nk4aksC?=
 =?us-ascii?Q?CdE+4bJYeLoqTpdL4J22qjhnSPkEZSvmk3R/gwN1Q3+kC84v9D8f+/6kkS5H?=
 =?us-ascii?Q?egrxjnKZcHNZPDo1MwrCqHqiDJR+F3eVvzPrmnPrbNqpOD3D6XIzvTXc5zIQ?=
 =?us-ascii?Q?W2bPkUNccAnnyMjr0lmKuCKCxQGqDI81usd5j9nOW/xO9GE0yr77QK6zU2aZ?=
 =?us-ascii?Q?GtlIhEU6xnQcpegBYNNtGC8nDHgboyMOlTT/4gESpNTvWXG1SaylAUOX+U+X?=
 =?us-ascii?Q?O5CxUTcB6djAddoB0RbGBmMUSEe6V/YzXmIL+p7rhJKTrURiZ3I/W83GJ3GC?=
 =?us-ascii?Q?XfFR2FqYIxaFRSSvn/R8RcUeouWnZh62?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 18:03:30.5325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d123a800-b887-4016-f78b-08dccf6761a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975

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
Changes for v6:
- Return -ENODEV in _i2c_init() if I2C_CONFIG is not defined.

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
 drivers/usb/misc/onboard_usb_dev.c | 77 ++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index da27c48fc11d..560591e02d6a 100644
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
@@ -297,10 +309,50 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
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
+#else
+	return -ENODEV;
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
@@ -340,6 +392,27 @@ static int onboard_dev_probe(struct platform_device *pdev)
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
@@ -351,6 +424,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
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



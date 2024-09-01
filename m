Return-Path: <linux-kernel+bounces-310213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61AC96765D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1907B216FF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4656175D5F;
	Sun,  1 Sep 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ltSd1k29"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDA166F28;
	Sun,  1 Sep 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725192546; cv=fail; b=BnUaqahPxP/KZ8hSV6Bo2ThSYOWxHqG21fQJNXi5QmHPJ1L5+wsIXun3l/9NoJsBzT2WW9MleBligOACLWX6KsNL3mu9LsH1uPDPUHSwJ+aRGwch5Aml3MCn1YtJskmU14heRIK2cwCmihTrK4OjIaipwiDshvuS1NPM53Gl3lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725192546; c=relaxed/simple;
	bh=rTf5h/JBKa28eI3xi2c56nyXYUlttdfsfNSuQnlTBm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeqmRbPAHs8In6JI/ZL9D9KAHy5jALDDzUr6J/5yFIjR6QNshWZ99BJSu5YAD8hxcaCmwPTmANw5F2QRl1X3TtP3agIJjBugIr0xoutafSO9+H+rR8BUKkzBq+VoxDYfVi/iAOO0Wmp060/PiibXEpy4sC++ohPY4mV389siNGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ltSd1k29; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/J/Uv9Pr2BZGNS0WeGes6IPAY1xeADnmr//LRzHKzxRnCXqp03r4uQQVIKltCOO5o2iTxHAMHgCtPXFdYpmv43DtSJB3Drn3rkqM5BeXgXBlKxJwLuDRzL60U/XWTB4xJPsZsWy2/tOmEKBFElPT6OPsTKEY25hJC6FmNNSAYJKTniscXHumntRW0hlScvtAAjDxmpquWpJOmFZeZr3CMloZ86cRPAXxf4QF2EHgtN9IfwMxV2ho/v5xeQCJyxizKfHLj4ZDWlU/EdXhEcbUUvsnsFAuxELvgxXPntpwyuhfV7iGnjdbsUMZ8wnsXfT+Mut1ylZvB3u4pZwNwyrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVnUAY4XHoBPZe3Wgn9Hp7aaHS3rl2xGyvH3ftQB2jU=;
 b=KOMZMjWeXwDl7Y3uSazAHXjCKSd1QBRzuPAoVZGIvWruhLGqgE+96d27ETrT6DuS1LSpsnK5ec/pN0LkAxevyawJ+5pvIXyn0/HMyaXWBseRtb7o5rqutGtQ44aUDuCUWNpktHfY9Jk6m9uoFewOZEmYuy6//Ty4dLacCLZn+1angalYonT0luz6zsvYV0xCd1fKpwfmIoksBKsDQRhWBH8mjoTVE0fvwbtThXbLGxhfL/WtImhS345+Mlqk1bs8MXx9aUG6cDb/wbzo+LlqtrRAbvZTygBINlTE9ctiS2tm+EuzCjr8hPZfHkC65W1wMDHYe+M/LE25H8itx4LdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVnUAY4XHoBPZe3Wgn9Hp7aaHS3rl2xGyvH3ftQB2jU=;
 b=ltSd1k29zLPg29WEIsc1JidlZpKWBVu/oqvNLCI3bfiFFdzT7pdRkJIaEnznWyj7hWYs6z0bKkwwjJW9YjT7bxGpqjHC6dynx5nuLG8IR1PjwAFvh8ti5Yqv1olD1LCytCjjXUjChosk2JSYALNVM7RReXqwfdcgAlc2HEV96tc=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 12:08:56 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::75) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 12:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 12:08:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Sep
 2024 07:08:55 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 1 Sep 2024 07:08:51 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <mka@chromium.org>,
	<sakari.ailus@linux.intel.com>, <wentong.wu@intel.com>,
	<javier.carrasco@wolfvision.net>, <stefan.eichenberger@toradex.com>,
	<francesco.dolcini@toradex.com>, <jbrunet@baylibre.com>,
	<macpaul.lin@mediatek.com>, <frieder.schrempf@kontron.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support
Date: Sun, 1 Sep 2024 17:38:39 +0530
Message-ID: <1725192519-3867920-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: d22e308a-3bdd-48a5-d5ae-08dcca7edade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8N11+BTuQ7L4nXQvC+ihwuk8smfyOPuAwJphIVWOzsQUCadWwnBVijAltLd+?=
 =?us-ascii?Q?s3iWp2VS5wEupt2HtKPTfWaFltrwn0At4KblM5ozxiTbG0c6/I5Fy2aiimjj?=
 =?us-ascii?Q?njG5i3XDNOVHuD2j2JwohaNPXCU2F0gUpI677u1UVyhGUfA9c4wwfMQKd1dW?=
 =?us-ascii?Q?FPj8adRj4covl+fPAnqaAB/h1053AkfHJdNGMZYxXc/SadjBpWJj/i47kI5u?=
 =?us-ascii?Q?7bLqwJmItB90ggXubZSNpiFSsu2WmCg97ncb4JxeKt9wT2blSipA1elPm0SZ?=
 =?us-ascii?Q?36kyYvRgpSc0MgRYuOrgvuWk5bBWzmceXkNpDsesvRbupH2DTrm4IM0299yZ?=
 =?us-ascii?Q?wL8KK+eJVzk3MM29cmC77UdaRIzdJYcgxJDtLWJzTTb8V8jA/7O6LduQJYWF?=
 =?us-ascii?Q?xiDmLjf6CDinbAEfcQTNB2W1ilNZhcARieXsfHpbLIkuH7yQMVLxK+6fZfAp?=
 =?us-ascii?Q?nfwfX0fgMyMnsDJz4niS771EoCu7wyfdfeG6OVUD3wWO7tgVZanGThPzc/UN?=
 =?us-ascii?Q?wJKNaxaXvKxyGi+fgT1u0begVMVJAUO6MggvUp90IwD2/E0744Fd+DF04eOw?=
 =?us-ascii?Q?wwoQkwr10OHN60cM7BK31INY4MUIzJoMbKXeh8TuCL6WECXPKYhHvLPLGgkN?=
 =?us-ascii?Q?DYJ9EKwbU9ZQzHxXtNINcHTQNAbFAcsz6Gw+G8Id3oe02TSaOaXHh2Nc7w31?=
 =?us-ascii?Q?adrLQup7z2Z+PVt0Tsm6v3pyd5CSrkQzG7uU818uB/2Ze3Dnicsh6UGjNcff?=
 =?us-ascii?Q?U8teItwktjyQhm7nLGt2FHT2BoyWJ2nEZq+QHjEeVPFyGj/xZAgjrSHl/t5Q?=
 =?us-ascii?Q?rRcpyJX3IPp4iWYVs4un9nf3466HzjhlV0MUlPWz+65+o85jONnuB5aZ+hMx?=
 =?us-ascii?Q?EgARw9rviFeBQ5ym8b7RoXf/SpIO9skT7lsFNJK0zzWPbIeCS+076qqUXgoj?=
 =?us-ascii?Q?RrIGoLHM0zz8vAqOUkzFHaQkcCEN7lDYLzldEteLEy5dp5Rc1GGupTfeyttC?=
 =?us-ascii?Q?G9txK4LyFXYIw3T6ihsjEatUdPgc9lRmP6M1A4aztoYEKMegawD4I6+tBo/B?=
 =?us-ascii?Q?gznq17RavZJuTjP0ykLc/00lggI2+FX9NIwpuZXk9MZwFLlC7VSeqQbWUewt?=
 =?us-ascii?Q?JjYlH5PrJUeFSOIWVNFJ7+nJKZXeBlLLb2W7lfcHfVFiFCw3TF/qQGTilz/1?=
 =?us-ascii?Q?hpsg71rouCioGNDR8Nx19JM2TO8WwJ4AG7J3vrIz7wmnpElE8wxi85XpYIE/?=
 =?us-ascii?Q?4V8VtfuUHWB5L3uUK6WBcKaM9fE0C7r9BfjVzBoOgWLXH5qSSL73gwvxkD9M?=
 =?us-ascii?Q?rM+wkyl8mqyy43r3uT70eFAq82CA/x9cjzFhEZSrlKDOvef4MWl24QQ5r9nn?=
 =?us-ascii?Q?rVSuUR0OG4nl2vzQH7vehY3VgVGfmOUqx9pGeIOKHXwviy7Xt8B2KPIpSAvL?=
 =?us-ascii?Q?2ZQr6W7hvNxhOG9JRB4ZqqD2zwRbnqHjN8x3vH7XD3pL0Q8mtaHYxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 12:08:56.4463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22e308a-3bdd-48a5-d5ae-08dcca7edade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773

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
 drivers/usb/misc/Kconfig           |  2 +-
 drivers/usb/misc/onboard_usb_dev.c | 73 ++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 50b86d531701..cb5e47d439ab 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
 
 config USB_ONBOARD_DEV
 	tristate "Onboard USB device support"
-	depends on OF
+	depends on OF && I2C
 	help
 	  Say Y here if you want to support discrete onboard USB devices
 	  that don't require an additional control bus for initialization,
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



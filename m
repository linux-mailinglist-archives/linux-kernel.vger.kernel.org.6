Return-Path: <linux-kernel+bounces-342470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC939988F64
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41E6B21B09
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE531885B4;
	Sat, 28 Sep 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KW53hQ08"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62EF18756A;
	Sat, 28 Sep 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727530010; cv=fail; b=o8TKZ5d9e4r4TqPao+oiqOyreYmmSPvP61UwIP4+HNoAoyEpbMP1UNeWe3kzcVt6MkAoOEuKgam2MYjfawN5Xsn5g3T1B37jXIpE7q2Wq7LPJjCO7i2rvI6/9mW7lYL24bcXMuV3rT5WvEmdH+HQ747AK3+Itf+CrZtljakfcdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727530010; c=relaxed/simple;
	bh=eFkF0XYK/JMFr0yDlwt0ayqy5xSUGYLoyrerhl+TcKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogmBNWKQTTmU90qDfwbXeXrTiUtnfKoI6rzaJowpVTtoA0OiCtG9fxCiFpdLufgGwX9UzNDOGkh0TvJAFW/rHybJh4tw6aJ/+l8+/7kB7qjtptZnrtEopM+xWo3cZWInyEYfnxEPkvPIdfZ/dWSklG6YN+mP9FEkFifQ6dC5OPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KW53hQ08; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSar+s87i8VH+HExzhVz8rAX8TH0QQjfU23Ru2a61ExpeDVBxvDHMq9zYb5akRddkjR6Lwe4qSxhGGCuwHJDUAnrT7v5OwUjUafJzVNDu+rz81FEEFAHUWFx45lXr9PsKa2T9pAPAvi25Z/6mI8+r0LgbjbVIt8l4Rx78k1rqpJegZ4uPzuW6yZLu/fy90HYQI033UGyL0DgnaTmG1SV6xV29ksJSxCNCVjLwh1lgpuw806HaGly3Dz/W5v19VRp2MxkHQm7SEM2nXrDo4OYTLnLLM11MYa0R2meOQjgSW03C1Rw9/21YbvyJ5nCFiKyzV7SRDuQWTFGz/QYY4XUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FY0t2JjIEJ+DRZVbd1lplZrBDF08qeQlTgWSoilHAk=;
 b=C0Y5fWFGD0uUatUtAIoGSLkDIYeHhbzgsPbDL6Jp6CzyQEFSa1EQ/tIUcDUUH+zBizVIDPlyl0mdHgSgnAU57r+qSetFDgZIKpG6EGJT+jsTrDgcvEUP+q/qutF02oTO3fwMSivTuQ8xv/PzQP+B1bXjqOBxEVGdd6UDTq5iwzmSjhrV+94SHgSDdcabkd2jxi3DgSWDqiOUdTvCYkgP1+qFptafrNjk4Mxif7Iq66fJ9FhvW3EgZ9MKtSWuGV/arQA/xvWhUzbB1+0ifTpqUaIW6ZwmxnKBGuDmyPKkFujqvLGBumScVKIdvpWOcWzImSBiLMMtKPbe5thp7cMh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FY0t2JjIEJ+DRZVbd1lplZrBDF08qeQlTgWSoilHAk=;
 b=KW53hQ080EUhw+Kn8Ql5J+yN1QTbRAYA9nPyvv4PD03GtgdYEZQ5xwc6dysOFI0LS6jAqPcT0xIzwDsnvrVia+FYk5MaPQlVFUjZSM5C9dwCVTws1pn4EIrH7+vVOZezUC5tZ3VLMEGFMH7U4Nd6KBfMRCoxCH18vQr68IPwFO0=
Received: from PH8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:2cf::6)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 13:26:42 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::19) by PH8PR07CA0032.outlook.office365.com
 (2603:10b6:510:2cf::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25 via Frontend
 Transport; Sat, 28 Sep 2024 13:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Sat, 28 Sep 2024 13:26:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 28 Sep
 2024 08:26:40 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 28 Sep 2024 08:26:36 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <mka@chromium.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<wentong.wu@intel.com>, <sakari.ailus@linux.intel.com>,
	<javier.carrasco@wolfvision.net>, <matthias@kaehlcke.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] usb: misc: onboard_usb_dev: introduce new config symbol for usb5744 SMBus support
Date: Sat, 28 Sep 2024 18:56:32 +0530
Message-ID: <1727529992-476088-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4627a3b9-43e6-4b1e-9fad-08dcdfc130fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03a57x29ruawYyjskInkBGvc9JD9uO7L+HPjWBxEiIG42A+fTnrDwU3Uaspo?=
 =?us-ascii?Q?ap0I18+GZqr6ySQHrC5u1AumKonPzEuLr4qa39XkRJfDS2KZ3FNnAaohZDKK?=
 =?us-ascii?Q?QidaLnuYi74Q8o4GCTkKNB7EHWnOw9eiEN6G5trTByktHMqAXXxlU89BpoH+?=
 =?us-ascii?Q?THuj/af4f8IabMowzmU/dOBQ8PGNJG/LlOC6s/RHjjZiuPN7Ccz4S5iir7sf?=
 =?us-ascii?Q?CbaLRDD5nwxEN9IDIGgEKS5nN4GipEtI+XFVnD2iZZqEmnS0GWe6kqqAKMLU?=
 =?us-ascii?Q?nQUJzDaOUmAX2rgv75q43O2e2fWM7lI0HvM9KFG4NU0/RlG9C6/35jvGgSLY?=
 =?us-ascii?Q?Ouwdoi9tlDH9ZKSl3DIUbXlKe+vvg1ZJv7lC9v7vizPGGcOfSfMKRRGAcoRC?=
 =?us-ascii?Q?ryq6pL0snL/xiWp13NBuf5Dot5O1XTNcSzDIHzm7m8nOjd+E34MthxQ0AqrA?=
 =?us-ascii?Q?yL1Ma50OuXU7ncg9/gqNQf1cNYM2OoMMTiyYrt4bhN70pKY0K3LyjDBzb9kh?=
 =?us-ascii?Q?VdQB7PZf7ycOJpyXkjdTVE9wvLiCVeN2+QBGonjmn/JxAwT+FraYo6QbmW/P?=
 =?us-ascii?Q?7QQJKjDb6m8ocMJQlpqyt+/YASzXPMsYQP6jsfKcDe7O02nzYkphbTdrZ4at?=
 =?us-ascii?Q?aoMU/v8uzSrSdkDUih0BfDkth3/+VevX7OxHFUnSNLkpjz+qybPoyY8N7vCo?=
 =?us-ascii?Q?ve+T8wcN80DsNj9roOCSozsBA4/JOHY3e8m3lnmfHHpYp9nZijBpY863Js6d?=
 =?us-ascii?Q?MipAbH4wa6FpNCLeP6s1C5mpTwuIgvpJuN2ifWaoBNHuAiIbuFQvIP8aOGMo?=
 =?us-ascii?Q?WoTInvx3t1MjpvI7A1Qnkn7keUmO4WbhJOtAg1vR8cd7NIh6/QlL9i3aR3We?=
 =?us-ascii?Q?nQfjDND3nv4XL7Uk1NJy3QXaPKjghM8QycOhcYL7/MnLgUOgSgRWdl9iwWyW?=
 =?us-ascii?Q?eRAc2yHTC14frQKxpedtHPPMEly91ByY/AhNFwqMgp6pxBEXLu7AzQ5QsBH4?=
 =?us-ascii?Q?W/T1Q/6MJn7RoS5XBssF5tG2UWybkcaUiD0nOhePACM5nUpNBfrbzDucq/LU?=
 =?us-ascii?Q?5Zga8WmN3uLdGRQuLdqEU95K8L/uZ0NLFmlb6r6ANnAyP3RLHwSRvoS2bOwt?=
 =?us-ascii?Q?LAQgNJIrctA1f21Cl9n2QrXARDyFwnjosmxvsnf72Z08IHO+AbDlKSInR+Tg?=
 =?us-ascii?Q?cYwKUV5k00ExLTE3nfpnLTQp9ym7f0uLiT4PVEYpi5DWt2datbE8ZlM5sNL3?=
 =?us-ascii?Q?N/N6HF/B/8ezOtXNvmuxTbE9NMx2Yzeai1iL8jxB7im8FWltHPHSsgUJiCkM?=
 =?us-ascii?Q?U0DCUkHUarN8zQjN+mqwiW4zh+diATj3Wqpq77YampPuTfg7xtvdPsPLYi5l?=
 =?us-ascii?Q?wwJs4dpTprtKginzzI0vkcM30fKaUa7zL9VqBog9RMIHJGqCg39/jFUIwU1X?=
 =?us-ascii?Q?yU2chTeCPvrJwMNc4EFxtqFVUZwGE9oY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 13:26:42.1437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4627a3b9-43e6-4b1e-9fad-08dcdfc130fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

Introduce new kernel config symbol for Microchip usb5744 SMBus programming
support. Since usb5744 i2c initialization routine uses i2c SMBus APIs these
APIs should only be invoked when kernel has I2C support. This new kernel
config describes the dependency on I2C kernel support and fix the below
build issues when USB_ONBOARD_DEV=y and CONFIG_I2C=m.

riscv64-linux-ld: drivers/usb/misc/onboard_usb_dev.o:
undefined reference to `i2c_find_device_by_fwnode'
drivers/usb/misc/onboard_usb_dev.c:408:(.text+0xb24): undefined
reference to `i2c_smbus_write_block_data'
<snip>

Parsing of the i2c-bus bus handle is not put under usb5744 kernel config
check as the intention is to report an error when DT is configured for
usb5744 SMBus support and kernel has USB_ONBOARD_DEV_USB5744 disabled.

Fixes: 6782311d04df ("usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Suggested-by: Matthias Kaehlcke <matthias@kaehlcke.net>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409140539.3Axwv38m-lkp@intel.com/
Acked-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
Changes for v2:
- As suggested by Greg drop default 'y' and instead describe the
  constraints in the kconfig description.
---
 drivers/usb/misc/Kconfig           | 12 ++++++++++++
 drivers/usb/misc/onboard_usb_dev.c |  6 ++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 50b86d531701..6497c4e81e95 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -331,3 +331,15 @@ config USB_ONBOARD_DEV
 	  this config will enable the driver and it will automatically
 	  match the state of the USB subsystem. If this driver is a
 	  module it will be called onboard_usb_dev.
+
+config USB_ONBOARD_DEV_USB5744
+	bool "Onboard USB Microchip usb5744 hub with SMBus support"
+	depends on (USB_ONBOARD_DEV && I2C=y) || (USB_ONBOARD_DEV=m && I2C=m)
+	help
+	  Say Y here if you want to support onboard USB Microchip usb5744
+	  hub that requires SMBus initialization.
+
+	  This options enables usb5744 i2c default initialization sequence
+	  during hub start-up configuration stage. It is must to enable this
+	  option on AMD Kria KR260 Robotics Starter Kit as this hub is
+	  connected to USB-SD converter which mounts the root filesystem.
diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 560591e02d6a..75dfdca04ff1 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -311,7 +311,7 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
 
 static int onboard_dev_5744_i2c_init(struct i2c_client *client)
 {
-#if IS_ENABLED(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_USB_ONBOARD_DEV_USB5744)
 	struct device *dev = &client->dev;
 	int ret;
 
@@ -394,9 +394,11 @@ static int onboard_dev_probe(struct platform_device *pdev)
 
 	i2c_node = of_parse_phandle(pdev->dev.of_node, "i2c-bus", 0);
 	if (i2c_node) {
-		struct i2c_client *client;
+		struct i2c_client *client = NULL;
 
+#if IS_ENABLED(CONFIG_USB_ONBOARD_DEV_USB5744)
 		client = of_find_i2c_device_by_node(i2c_node);
+#endif
 		of_node_put(i2c_node);
 
 		if (!client) {

base-commit: 40e0c9d414f57d450e3ad03c12765e797fc3fede
-- 
2.34.1



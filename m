Return-Path: <linux-kernel+bounces-240931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7D9274C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0720286359
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC21ABCAB;
	Thu,  4 Jul 2024 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uW4BgKi5"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9B1ABC53;
	Thu,  4 Jul 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091832; cv=fail; b=MX69Wfz9FrSbQfFGXdBILUYmYyAYBhe1La9FIfcgdCEQjcy1Fi93+u/kqJBrSa5sx2P+ClZ7PYrN0+dflVohzr8FFVTWTnazoPA3BORQ9lisneUikmboS1eX5HiBKvm3yCgdBwvmg1pXVx+O8k3fjt/2GRoKiQ2sN2qZ5l5AeAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091832; c=relaxed/simple;
	bh=seFlGdU1ty1i+Vk4bQkcERUDvZ42dLmOU6Nuv0ApTGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmhTJlxIOkDw5iFYc8SYrg/hULYwN23Uts0chZjOPTJM03NaMH9+9gM7xJd2a+uoxshljjKZQsx+VLqFa3MpWs/1RciXndd7Tyw5mLohpT/0+3U1buksfl4Jrjw6hb+ZNYC1zkVPOzlwZ4q6lbvtihwtvESjX6JVJeNLtX/vJ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uW4BgKi5; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdvHdgeFOzfAGTa9G1BpYmhTyj5u1W/GMnkRo/X6WMqYV7MS0Pnaxkx6bBJ2jdbk+ayPVgFWmYp70/W3U85XMLcuIOPaPmcq2pO/I6we3hLcC5YNz1A1IYdRsXDyxiOOQEjytDAoPGoVHanqL3sCcwOI9iCZLAqKgmtLHZIFh9XqnwXXypEwrKOmI8wzNDsqk/rJLoxbpdA4IAhSVQFJ+RFW6QK7Ms++975BrCG5OXtbW9NrjZvXOhsQSYTXyyHte+ZtYNrA4bYfnrGLhTN4F2qWwhH7z5yA/jXjL4I8oBnqSTZHlA6spmHoLL6kXG2/lCLBrxj8tTsoHIxq7aZPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rTHDq37eKsr2hsWIeVdWrCSrov0T+BYLEb+qLNSegQ=;
 b=l/jadAihlfYef5RwGyUP6eAhX1n41mMQEvVphaMRzjuOyPtfn3vtcewWMZhQ9b8j+1AA5/NjMI5dl4ENRMVdvExgMA8nASUn2rmCGyvVdo0ZmdhJePqFzpzSCtpM7QZZ8BtTRT5rkD7H2fUL0ketQaNU/EoFBv1Mp093Nws3ZaikvLvIVawvpOegYf7VbBL3HVWPwgo2hok/dy58DSa2m4o7Wd6JjcWEuUV3qIMIOjlxwStzVvrTefLRWD3IA0FxxZu4l54qQ/aD+vJgFJ7Ic+EAWDF2+UZ32Ps14R/w/h3H72cPz7CKEgQtpC8KdHJJAa3f64TMX9qytI+7Q2rHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rTHDq37eKsr2hsWIeVdWrCSrov0T+BYLEb+qLNSegQ=;
 b=uW4BgKi5vnfQ+dNAFLCk+kRPVX/X5OQNx1cpWo4HSaUCwfJsUJ/fDQBHsB5MUONd8VBDPStpvVOIi4YQzlKbml/SFyWJojH7SccMlTQ0GLU1vWV68p/3Y9sOMqLptbh1yIisVWFsjh055Gnc9S2m07QyQQXJr+aRlg3KuTuFbuE=
Received: from DM6PR10CA0031.namprd10.prod.outlook.com (2603:10b6:5:60::44) by
 MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Thu, 4 Jul
 2024 11:17:04 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::f6) by DM6PR10CA0031.outlook.office365.com
 (2603:10b6:5:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 4 Jul 2024 11:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 11:17:04 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 06:17:01 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH 1/6] hwmon/misc sbrmi: Move core sbrmi from hwmon to misc
Date: Thu, 4 Jul 2024 11:16:19 +0000
Message-ID: <20240704111624.1583460-2-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704111624.1583460-1-akshay.gupta@amd.com>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d89871-4c3a-48e0-6baf-08dc9c1ad56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzGdqMrfQdWftv7joFSPfS4r/ojG6dHIBum5DmnHPQF9Fw7s+d3/dhWABJ+D?=
 =?us-ascii?Q?rBfiW/DgfbK5He5oN8c6vj4rNZ7V+S7KuGQOrFSzJ6x0KtQ5h0v3CM2Qkvvk?=
 =?us-ascii?Q?uCNREdlllUGJTua4Wco2dFFRxvvrqBWb1ZSHrlv15L00blFJ+XHGvNpVyxqR?=
 =?us-ascii?Q?ZD8dIF/SvgzXS0B8FXVQfiUj6q8NGcNCSMrf/YP4R2uEpaMpmthfveb7FfLy?=
 =?us-ascii?Q?/mAZy9XDUXecIH1vgAPiupCwNlauCHdNYOarlMWgOGgx56ZrO6HcAdaOU8yI?=
 =?us-ascii?Q?aWlWDNJ0s9kyyjmH1yunEFpWYV5f9knDNyu6RgVSZbiIwkBeifoBROsEp/pn?=
 =?us-ascii?Q?x5agSH8KKIwIq+fbvW8ea01SKxJfi2WA56lqB79TluVByddT1tSuULKfGeMe?=
 =?us-ascii?Q?eRsnllvSzKKKJcLTk34AWXWvQbRoNrwbiVerV4hnutK8ytz11OBj3xbYEZ/x?=
 =?us-ascii?Q?BS+GiQ5A66/IR6UvxzcGwmiiEUSsUsusOIFLxtc2vUtK7+9xuWM75yf00ALe?=
 =?us-ascii?Q?2lazrEl3cMxqQ6RocgcRDE9itcB0V/7dAhChZgA4LD90uqPIc+5vbGI7Dbam?=
 =?us-ascii?Q?n1RiPhRU2HByOtaZCsoBtL2IAbyaYBA+fNhockl3v6frZOy2tQlp7i27pRt1?=
 =?us-ascii?Q?4Rk1uIvI/NTUP7o1dolBsF/y+0zivBT0G8RqnW7Q9gxwSFQcV01nRJUcoHhY?=
 =?us-ascii?Q?yvqyxi83f+ccPsEE9cUcusTjKSMLaOmmXjP/eWGnYfSSWAaf5gFnE4FexKX6?=
 =?us-ascii?Q?7buRUcNeF9ctPsYahOzidkxYpK7JatcREeC7nPTNdFE/Zj+cCxQFJdc25vAT?=
 =?us-ascii?Q?k1KjAetgcuWQVRgt7GcO5B2D/UniCKcT/Q1p0qx0jskVXaoTXFt+yPZ1wr6x?=
 =?us-ascii?Q?FVCT0+D5lNY6qeHeM3vj/CSpJ9+Tbtrp36lx55U6rHhtq21mv003tcxz5HHn?=
 =?us-ascii?Q?4lkV4Z4tEAmtiyhbH+T7gfMqTzJfO7MZwrkWAe/2hR4p4I6X0vez23frWiVf?=
 =?us-ascii?Q?qGZaeuywNShDyc78KhRghT46YQrny6tcwxdUtXtRLrdYBasQ5CICk60t4kLI?=
 =?us-ascii?Q?8Mwbhhe+gT9KYqggJnLwHJke+wvMWHwKQu1VN11nGURctPDt9e5/2CVUVpjx?=
 =?us-ascii?Q?2xdtDYT3T2dDm9eVpX3cUe2awKv0GW630MoTMg5nmld5lAxw7NzYx6mBBX81?=
 =?us-ascii?Q?3dznnmU3ZV5QHjGq7Qn/HYwZBIKGwdoqPZfZxKPt9SIKCNBiQhVveQrS8v8E?=
 =?us-ascii?Q?BcivDlKNf2Eto7SmiO54SKe6YulOnDGKuPOV14uu2ERbI2wsNX4eXSH71AUg?=
 =?us-ascii?Q?kes1CV/U+4a7/lguojHo2xTfwUk2v8/C4C6v741Co2EdCwL6yH9fRxCV+3ea?=
 =?us-ascii?Q?5b6h4QKWr4BAjiY7vvHDW8Box+un7Rovdv3q2cI/AYNioJarUIdePu5Swx5Q?=
 =?us-ascii?Q?00kQviA3HnU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:17:04.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d89871-4c3a-48e0-6baf-08dc9c1ad56b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

This is done to support other functionality provided by the SBRMI, which
does not fit in the hwmon subsystem.

- Move the SBRMI core functionality and I2C device probing part to misc.
- Modify hwmon/sbrmi.c sensor to be probed as a platform device.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
 drivers/hwmon/Kconfig            |   1 +
 drivers/hwmon/sbrmi.c            | 251 +++----------------------------
 drivers/misc/Kconfig             |   1 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/amd-sb/Kconfig      |   9 ++
 drivers/misc/amd-sb/Makefile     |   3 +
 drivers/misc/amd-sb/sbrmi-core.c | 137 +++++++++++++++++
 drivers/misc/amd-sb/sbrmi-i2c.c  | 106 +++++++++++++
 include/misc/amd-sb.h            |  45 ++++++
 9 files changed, 326 insertions(+), 228 deletions(-)
 create mode 100644 drivers/misc/amd-sb/Kconfig
 create mode 100644 drivers/misc/amd-sb/Makefile
 create mode 100644 drivers/misc/amd-sb/sbrmi-core.c
 create mode 100644 drivers/misc/amd-sb/sbrmi-i2c.c
 create mode 100644 include/misc/amd-sb.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e14ae18a973b..1d8716815630 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1839,6 +1839,7 @@ config SENSORS_SBTSI
 config SENSORS_SBRMI
 	tristate "Emulated SB-RMI sensor"
 	depends on I2C
+	depends on AMD_SBRMI_I2C
 	help
 	  If you say yes here you get support for emulated RMI
 	  sensors on AMD SoCs with APML interface connected to a BMC device.
diff --git a/drivers/hwmon/sbrmi.c b/drivers/hwmon/sbrmi.c
index d48d8e5460ff..90b8f94a43fa 100644
--- a/drivers/hwmon/sbrmi.c
+++ b/drivers/hwmon/sbrmi.c
@@ -3,190 +3,18 @@
  * sbrmi.c - hwmon driver for a SB-RMI mailbox
  *           compliant AMD SoC device.
  *
- * Copyright (C) 2020-2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2020-2024 Advanced Micro Devices, Inc.
  */
 
-#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
-#include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <misc/amd-sb.h>
 
 /* Do not allow setting negative power limit */
 #define SBRMI_PWR_MIN	0
-/* Mask for Status Register bit[1] */
-#define SW_ALERT_MASK	0x2
-
-/* Software Interrupt for triggering */
-#define START_CMD	0x80
-#define TRIGGER_MAILBOX	0x01
-
-/*
- * SB-RMI supports soft mailbox service request to MP1 (power management
- * firmware) through SBRMI inbound/outbound message registers.
- * SB-RMI message IDs
- */
-enum sbrmi_msg_id {
-	SBRMI_READ_PKG_PWR_CONSUMPTION = 0x1,
-	SBRMI_WRITE_PKG_PWR_LIMIT,
-	SBRMI_READ_PKG_PWR_LIMIT,
-	SBRMI_READ_PKG_MAX_PWR_LIMIT,
-};
-
-/* SB-RMI registers */
-enum sbrmi_reg {
-	SBRMI_CTRL		= 0x01,
-	SBRMI_STATUS,
-	SBRMI_OUTBNDMSG0	= 0x30,
-	SBRMI_OUTBNDMSG1,
-	SBRMI_OUTBNDMSG2,
-	SBRMI_OUTBNDMSG3,
-	SBRMI_OUTBNDMSG4,
-	SBRMI_OUTBNDMSG5,
-	SBRMI_OUTBNDMSG6,
-	SBRMI_OUTBNDMSG7,
-	SBRMI_INBNDMSG0,
-	SBRMI_INBNDMSG1,
-	SBRMI_INBNDMSG2,
-	SBRMI_INBNDMSG3,
-	SBRMI_INBNDMSG4,
-	SBRMI_INBNDMSG5,
-	SBRMI_INBNDMSG6,
-	SBRMI_INBNDMSG7,
-	SBRMI_SW_INTERRUPT,
-};
-
-/* Each client has this additional data */
-struct sbrmi_data {
-	struct i2c_client *client;
-	struct mutex lock;
-	u32 pwr_limit_max;
-};
-
-struct sbrmi_mailbox_msg {
-	u8 cmd;
-	bool read;
-	u32 data_in;
-	u32 data_out;
-};
-
-static int sbrmi_enable_alert(struct i2c_client *client)
-{
-	int ctrl;
-
-	/*
-	 * Enable the SB-RMI Software alert status
-	 * by writing 0 to bit 4 of Control register(0x1)
-	 */
-	ctrl = i2c_smbus_read_byte_data(client, SBRMI_CTRL);
-	if (ctrl < 0)
-		return ctrl;
-
-	if (ctrl & 0x10) {
-		ctrl &= ~0x10;
-		return i2c_smbus_write_byte_data(client,
-						 SBRMI_CTRL, ctrl);
-	}
-
-	return 0;
-}
-
-static int rmi_mailbox_xfer(struct sbrmi_data *data,
-			    struct sbrmi_mailbox_msg *msg)
-{
-	int i, ret, retry = 10;
-	int sw_status;
-	u8 byte;
-
-	mutex_lock(&data->lock);
-
-	/* Indicate firmware a command is to be serviced */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_INBNDMSG7, START_CMD);
-	if (ret < 0)
-		goto exit_unlock;
-
-	/* Write the command to SBRMI::InBndMsg_inst0 */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_INBNDMSG0, msg->cmd);
-	if (ret < 0)
-		goto exit_unlock;
-
-	/*
-	 * For both read and write the initiator (BMC) writes
-	 * Command Data In[31:0] to SBRMI::InBndMsg_inst[4:1]
-	 * SBRMI_x3C(MSB):SBRMI_x39(LSB)
-	 */
-	for (i = 0; i < 4; i++) {
-		byte = (msg->data_in >> i * 8) & 0xff;
-		ret = i2c_smbus_write_byte_data(data->client,
-						SBRMI_INBNDMSG1 + i, byte);
-		if (ret < 0)
-			goto exit_unlock;
-	}
-
-	/*
-	 * Write 0x01 to SBRMI::SoftwareInterrupt to notify firmware to
-	 * perform the requested read or write command
-	 */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
-	if (ret < 0)
-		goto exit_unlock;
-
-	/*
-	 * Firmware will write SBRMI::Status[SwAlertSts]=1 to generate
-	 * an ALERT (if enabled) to initiator (BMC) to indicate completion
-	 * of the requested command
-	 */
-	do {
-		sw_status = i2c_smbus_read_byte_data(data->client,
-						     SBRMI_STATUS);
-		if (sw_status < 0) {
-			ret = sw_status;
-			goto exit_unlock;
-		}
-		if (sw_status & SW_ALERT_MASK)
-			break;
-		usleep_range(50, 100);
-	} while (retry--);
-
-	if (retry < 0) {
-		dev_err(&data->client->dev,
-			"Firmware fail to indicate command completion\n");
-		ret = -EIO;
-		goto exit_unlock;
-	}
-
-	/*
-	 * For a read operation, the initiator (BMC) reads the firmware
-	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
-	 * {SBRMI_x34(MSB):SBRMI_x31(LSB)}.
-	 */
-	if (msg->read) {
-		for (i = 0; i < 4; i++) {
-			ret = i2c_smbus_read_byte_data(data->client,
-						       SBRMI_OUTBNDMSG1 + i);
-			if (ret < 0)
-				goto exit_unlock;
-			msg->data_out |= ret << i * 8;
-		}
-	}
-
-	/*
-	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
-	 * ALERT to initiator
-	 */
-	ret = i2c_smbus_write_byte_data(data->client, SBRMI_STATUS,
-					sw_status | SW_ALERT_MASK);
-
-exit_unlock:
-	mutex_unlock(&data->lock);
-	return ret;
-}
 
 static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
@@ -195,6 +23,9 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 	struct sbrmi_mailbox_msg msg = { 0 };
 	int ret;
 
+	if (!data)
+		return -ENODEV;
+
 	if (type != hwmon_power)
 		return -EINVAL;
 
@@ -228,6 +59,9 @@ static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
 	struct sbrmi_data *data = dev_get_drvdata(dev);
 	struct sbrmi_mailbox_msg msg = { 0 };
 
+	if (!data)
+		return -ENODEV;
+
 	if (type != hwmon_power && attr != hwmon_power_cap)
 		return -EINVAL;
 	/*
@@ -282,76 +116,37 @@ static const struct hwmon_chip_info sbrmi_chip_info = {
 	.info = sbrmi_info,
 };
 
-static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
+static int sbrmi_probe(struct platform_device *pdev)
 {
-	struct sbrmi_mailbox_msg msg = { 0 };
-	int ret;
-
-	msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
-	msg.read = true;
-	ret = rmi_mailbox_xfer(data, &msg);
-	if (ret < 0)
-		return ret;
-	data->pwr_limit_max = msg.data_out;
-
-	return ret;
-}
-
-static int sbrmi_probe(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
+	struct device *dev = &pdev->dev;
 	struct device *hwmon_dev;
-	struct sbrmi_data *data;
-	int ret;
+	struct sbrmi_data *data  = dev_get_drvdata(pdev->dev.parent);
 
-	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
 	if (!data)
-		return -ENOMEM;
-
-	data->client = client;
-	mutex_init(&data->lock);
-
-	/* Enable alert for SB-RMI sequence */
-	ret = sbrmi_enable_alert(client);
-	if (ret < 0)
-		return ret;
-
-	/* Cache maximum power limit */
-	ret = sbrmi_get_max_pwr_limit(data);
-	if (ret < 0)
-		return ret;
-
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
+		return -ENODEV;
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sbrmi", data,
 							 &sbrmi_chip_info, NULL);
-
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static const struct i2c_device_id sbrmi_id[] = {
-	{"sbrmi"},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, sbrmi_id);
-
-static const struct of_device_id __maybe_unused sbrmi_of_match[] = {
+static const struct platform_device_id sbrmi_id[] = {
 	{
-		.compatible = "amd,sbrmi",
+		.name = "sbrmi-hwmon",
 	},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, sbrmi_of_match);
+MODULE_DEVICE_TABLE(platform, sbrmi_id);
 
-static struct i2c_driver sbrmi_driver = {
+static struct platform_driver amd_sbrmi_hwmon_driver = {
+	.probe = sbrmi_probe,
 	.driver = {
-		.name = "sbrmi",
-		.of_match_table = of_match_ptr(sbrmi_of_match),
+		.name = "amd-sbrmi",
 	},
-	.probe = sbrmi_probe,
 	.id_table = sbrmi_id,
 };
-
-module_i2c_driver(sbrmi_driver);
+module_platform_driver(amd_sbrmi_hwmon_driver);
 
 MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
+MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
 MODULE_DESCRIPTION("Hwmon driver for AMD SB-RMI emulated sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index faf983680040..48df5757af96 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -602,4 +602,5 @@ source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
+source "drivers/misc/amd-sb/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 153a3f4837e8..561e0d635b4f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-y				+= amd-sb/
diff --git a/drivers/misc/amd-sb/Kconfig b/drivers/misc/amd-sb/Kconfig
new file mode 100644
index 000000000000..d47bdd26a871
--- /dev/null
+++ b/drivers/misc/amd-sb/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_SBRMI_I2C
+        tristate "APML SBRMI support"
+        depends on I2C
+        help
+          APML RMI core support for AMD out of band management.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called apml-sbrmi.
diff --git a/drivers/misc/amd-sb/Makefile b/drivers/misc/amd-sb/Makefile
new file mode 100644
index 000000000000..0f9277e7335a
--- /dev/null
+++ b/drivers/misc/amd-sb/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+apml-sbrmi-objs  		:= sbrmi-i2c.o sbrmi-core.o
+obj-$(CONFIG_AMD_SBRMI_I2C)	+= apml-sbrmi.o
diff --git a/drivers/misc/amd-sb/sbrmi-core.c b/drivers/misc/amd-sb/sbrmi-core.c
new file mode 100644
index 000000000000..5ca0a9ec8341
--- /dev/null
+++ b/drivers/misc/amd-sb/sbrmi-core.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sbrmi-common.c - file defining SB-RMI protocols
+ *		    compliant AMD SoC device.
+ *
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <misc/amd-sb.h>
+
+/* Mask for Status Register bit[1] */
+#define SW_ALERT_MASK	0x2
+
+/* Software Interrupt for triggering */
+#define START_CMD	0x80
+#define TRIGGER_MAILBOX	0x01
+
+/* SB-RMI registers */
+enum sbrmi_reg {
+	SBRMI_CTRL		= 0x01,
+	SBRMI_STATUS,
+	SBRMI_OUTBNDMSG0	= 0x30,
+	SBRMI_OUTBNDMSG1,
+	SBRMI_OUTBNDMSG2,
+	SBRMI_OUTBNDMSG3,
+	SBRMI_OUTBNDMSG4,
+	SBRMI_OUTBNDMSG5,
+	SBRMI_OUTBNDMSG6,
+	SBRMI_OUTBNDMSG7,
+	SBRMI_INBNDMSG0,
+	SBRMI_INBNDMSG1,
+	SBRMI_INBNDMSG2,
+	SBRMI_INBNDMSG3,
+	SBRMI_INBNDMSG4,
+	SBRMI_INBNDMSG5,
+	SBRMI_INBNDMSG6,
+	SBRMI_INBNDMSG7,
+	SBRMI_SW_INTERRUPT,
+};
+
+int rmi_mailbox_xfer(struct sbrmi_data *data,
+		     struct sbrmi_mailbox_msg *msg)
+{
+	int i, ret, retry = 10;
+	int sw_status;
+	u8 byte;
+
+	mutex_lock(&data->lock);
+
+	/* Indicate firmware a command is to be serviced */
+	ret = i2c_smbus_write_byte_data(data->client,
+					SBRMI_INBNDMSG7, START_CMD);
+	if (ret < 0)
+		goto exit_unlock;
+
+	/* Write the command to SBRMI::InBndMsg_inst0 */
+	ret = i2c_smbus_write_byte_data(data->client,
+					SBRMI_INBNDMSG0, msg->cmd);
+	if (ret < 0)
+		goto exit_unlock;
+
+	/*
+	 * For both read and write the initiator (BMC) writes
+	 * Command Data In[31:0] to SBRMI::InBndMsg_inst[4:1]
+	 * SBRMI_x3C(MSB):SBRMI_x39(LSB)
+	 */
+	for (i = 0; i < 4; i++) {
+		byte = (msg->data_in >> i * 8) & 0xff;
+		ret = i2c_smbus_write_byte_data(data->client,
+						SBRMI_INBNDMSG1 + i, byte);
+		if (ret < 0)
+			goto exit_unlock;
+	}
+
+	/*
+	 * Write 0x01 to SBRMI::SoftwareInterrupt to notify firmware to
+	 * perform the requested read or write command
+	 */
+	ret = i2c_smbus_write_byte_data(data->client,
+					SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
+	if (ret < 0)
+		goto exit_unlock;
+
+	/*
+	 * Firmware will write SBRMI::Status[SwAlertSts]=1 to generate
+	 * an ALERT (if enabled) to initiator (BMC) to indicate completion
+	 * of the requested command
+	 */
+	do {
+		sw_status = i2c_smbus_read_byte_data(data->client,
+						     SBRMI_STATUS);
+		if (sw_status < 0) {
+			ret = sw_status;
+			goto exit_unlock;
+		}
+		if (sw_status & SW_ALERT_MASK)
+			break;
+		usleep_range(50, 100);
+	} while (retry--);
+
+	if (retry < 0) {
+		dev_err(&data->client->dev,
+			"Firmware fail to indicate command completion\n");
+		ret = -EIO;
+		goto exit_unlock;
+	}
+
+	/*
+	 * For a read operation, the initiator (BMC) reads the firmware
+	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
+	 * {SBRMI_x34(MSB):SBRMI_x31(LSB)}.
+	 */
+	if (msg->read) {
+		for (i = 0; i < 4; i++) {
+			ret = i2c_smbus_read_byte_data(data->client,
+						       SBRMI_OUTBNDMSG1 + i);
+			if (ret < 0)
+				goto exit_unlock;
+			msg->data_out |= ret << i * 8;
+		}
+	}
+
+	/*
+	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
+	 * ALERT to initiator
+	 */
+	ret = i2c_smbus_write_byte_data(data->client, SBRMI_STATUS,
+					sw_status | SW_ALERT_MASK);
+
+exit_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+EXPORT_SYMBOL(rmi_mailbox_xfer);
diff --git a/drivers/misc/amd-sb/sbrmi-i2c.c b/drivers/misc/amd-sb/sbrmi-i2c.c
new file mode 100644
index 000000000000..c4903d9e9f0f
--- /dev/null
+++ b/drivers/misc/amd-sb/sbrmi-i2c.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sbrmi.c - hwmon driver for a SB-RMI mailbox
+ *           compliant AMD SoC device.
+ *
+ * Copyright (C) 2020-2024 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <misc/amd-sb.h>
+
+#define SBRMI_CTRL	0x1
+
+static int sbrmi_enable_alert(struct i2c_client *client)
+{
+	int ctrl;
+
+	/*
+	 * Enable the SB-RMI Software alert status
+	 * by writing 0 to bit 4 of Control register(0x1)
+	 */
+	ctrl = i2c_smbus_read_byte_data(client, SBRMI_CTRL);
+	if (ctrl < 0)
+		return ctrl;
+
+	if (ctrl & 0x10) {
+		ctrl &= ~0x10;
+		return i2c_smbus_write_byte_data(client,
+						 SBRMI_CTRL, ctrl);
+	}
+
+	return 0;
+}
+
+static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
+{
+	struct sbrmi_mailbox_msg msg = { 0 };
+	int ret;
+
+	msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
+	msg.read = true;
+	ret = rmi_mailbox_xfer(data, &msg);
+	if (ret < 0)
+		return ret;
+	data->pwr_limit_max = msg.data_out;
+
+	return ret;
+}
+
+static int sbrmi_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sbrmi_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->lock);
+
+	/* Enable alert for SB-RMI sequence */
+	ret = sbrmi_enable_alert(client);
+	if (ret < 0)
+		return ret;
+
+	/* Cache maximum power limit */
+	return sbrmi_get_max_pwr_limit(data);
+}
+
+static const struct i2c_device_id sbrmi_id[] = {
+	{"sbrmi-i2c"},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, sbrmi_id);
+
+static const struct of_device_id __maybe_unused sbrmi_of_match[] = {
+	{
+		.compatible = "amd,sbrmi",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sbrmi_of_match);
+
+static struct i2c_driver sbrmi_driver = {
+	.driver = {
+		.name = "sbrmi-i2c",
+		.of_match_table = of_match_ptr(sbrmi_of_match),
+	},
+	.probe = sbrmi_i2c_probe,
+	.id_table = sbrmi_id,
+};
+
+module_i2c_driver(sbrmi_driver);
+
+MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
+MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
+MODULE_DESCRIPTION("Hwmon driver for AMD SB-RMI emulated sensor");
+MODULE_LICENSE("GPL");
diff --git a/include/misc/amd-sb.h b/include/misc/amd-sb.h
new file mode 100644
index 000000000000..e1a012fcdff9
--- /dev/null
+++ b/include/misc/amd-sb.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _AMD_SB_H_
+#define _AMD_SB_H_
+
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+/*
+ * SB-RMI supports soft mailbox service request to MP1 (power management
+ * firmware) through SBRMI inbound/outbound message registers.
+ * SB-RMI message IDs
+ */
+enum sbrmi_msg_id {
+	SBRMI_READ_PKG_PWR_CONSUMPTION = 0x1,
+	SBRMI_WRITE_PKG_PWR_LIMIT,
+	SBRMI_READ_PKG_PWR_LIMIT,
+	SBRMI_READ_PKG_MAX_PWR_LIMIT,
+};
+
+/* Each client has this additional data */
+struct sbrmi_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u32 pwr_limit_max;
+};
+
+struct sbrmi_mailbox_msg {
+	u8 cmd;
+	bool read;
+	u32 data_in;
+	u32 data_out;
+};
+
+#if IS_ENABLED(CONFIG_AMD_SBRMI_I2C)
+int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *msg);
+#else
+int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *msg)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#endif /*_AMD_SB_H_*/
-- 
2.25.1



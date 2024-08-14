Return-Path: <linux-kernel+bounces-286216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1E951823
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5A91C20ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88F1AD9E3;
	Wed, 14 Aug 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fR+iP5fi"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A51AD9C8;
	Wed, 14 Aug 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629634; cv=fail; b=jwHff/hxqAB/5aCzmgnilxZJcLt03UwK/jnNgaEqRvAOQ4F5csHY9xxXJoR2zvSvngkHOa6d6CCoAR9ss1OGQ9pl0kPAr+ApqihpU/FMmzo73PNxEwLLN1gjIo1X6VV1tMZHIXcSPn+T6rl535rFp6W2PVvE7gcgDo89zXB7m38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629634; c=relaxed/simple;
	bh=wustc/l8vYYXD769t7HhzQv4OF8jQerjsMFNEoiMbi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAaBHHpzT8Ro1f6AfdiTtpYv6x7SXN24BktSzXQNuzzQQ/CnsBoxcO/ceJtY3zHlmQCscVWIr4Aq2j9L137dY7RfzOItwTu7XKxjWo2Q7jvhVRHrvrbapTQiAYFtgrEibRatr2QWiRH45ygmK2iNv6LmRPQE7gGAKBQbYWsM7Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fR+iP5fi; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaZQOD7Q+ZHy/sNByCf+r1BdhkqMiVZsZl+22NbxePEVpPtZk4FqyVciuSb2oxPviICWDTsSAppf6RVsysiHHXuWLwyVvFGgi+DojFrEggY3l1TENAu7bI7l9WuIDiN0cKEY/l4evKly5LCqNYKLXAL5Nk6oCtdPJjriorj8cD3vngLpw30WnjonOkJ39Is3o3HSRsk2Q+Ktt43JxtoSJ+U2O0kLFunwUjEtrPGYW+P0P54Wxb3j6eR9tON8AujzqV8vDBNioLftY5/6lWnW9RZhldrVjKH+og3q95FiTsSHoi9/4bQ462VTXw6c/eHPXna0nv5qKzORCtlxdH4uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glXmd0dS6gDHYKexD1/NobGNX3r1KqnnkIkJaSDTbJ4=;
 b=EpYSOMsfRm5bUI1bYQC0e7WZqm7+Pyct9uy7t7DUYs7QlmY6+dlB7AoL7PJQg+YwSZAd6x8JuzDK33YSU+o8H5rADxrhpShf6UfJ9xeH7U9nHHM7bWgGzw7jGe1aThBpXGZFheXdPOSoRht9DnYoT7vZmavg9DwmIkTenazvUZILDs2vpZZ+PJ0T65xSxxDRa9ZnAZzfG7rE2IflPlboMrsps16BQzvTy01p+/DmNnsHjR3ln/IR4kM3BYoVETb4rtQ5mOE1oRtNGqbyMzLeSG0cORlv2UuKWPDbgMuD3RYE0NE7Eo/WeeYz+wox5vi+sdLqN923RMm5Zvs1BCHANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glXmd0dS6gDHYKexD1/NobGNX3r1KqnnkIkJaSDTbJ4=;
 b=fR+iP5fiNWdoA957wfjozVwKjHGcdbrHcNtFHRfEJNvxigAXqAAHwdMKkZYw/FW+Vri+fIXX6EYZw6AGd/Zb3oRfzP2SXkFQzXdGleystwMDBO8gOjXBNRubsJ6Cr8n3Wjgvt8sPbv1pDM04BTmgwEl2+dCPtKMc9z2BLuLy8Sw=
Received: from CH5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610:1f0::25)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:25 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::64) by CH5PR05CA0023.outlook.office365.com
 (2603:10b6:610:1f0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:25 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:20 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 1/8] hwmon/misc: amd-sbi: Move core sbrmi from hwmon to misc
Date: Wed, 14 Aug 2024 09:59:46 +0000
Message-ID: <20240814095954.2359863-2-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240814095954.2359863-1-akshay.gupta@amd.com>
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fed0ba-a573-4d14-7716-08dcbc47eb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	5Ol4vjHY5AqOQm7au7jyeAQOneL5gzbZOP4vqLqbvb1K3gRMaI7bGb8ePWqUHfgob92cGZzQt1NoEGEM8XaWD9m9UElD4gOthRgwt/TXxBV7Bqsf7+ToJvoY4NMrMorXMbaha852sLadbviUWGftOsKR5bCZhWcyWD6Pdc9m1NBXJ2657JQa3k8P7ctl+5Tmfk0tzXgfvWr+S3aNkvC2NaZtaEgE6OCeR5rrJVoEohLENFWyoicDZPqmxNp8LPNVdnbyiN8AP1JCdswiz0AcWCeS6jrI3lZahS8Mg8/1YNh5q2vvONZBE//thN3yIowbyhi917Q1dePTZAk7oc7Euw0QDjBI4MoXXcVZ6MaGlV+ycL2ohw6OfypjnIQpwsOyrD/5J0ZYFwpsmsDdtbasE6K4ksAM6Z4Nqno40VY4ezMzoQ8Wwqri2UHt6UcYc+OGJhn+ddLEE8/skH9Io/wdcSJnIndMwbTi23m8KOTKUZCX6CTAFW03lA4Y0k9vfgZN5ijOsLKcggig9RBSOZESs3nrTKDdD4n55gr4wOoX12L0+aQzj0/fFbRrsb7Gbj5Fa/rRGfsoyeY3hrGHmi8QWPltggvSJnu929Zk90bBFTvre7U815zkrzEZvDeweKNr9yWeOxtYRXupzAv2Wp/6aXrWyIIGvM8SfuAmsvbserfyucNzdQkiZ8im0NMu/v+GmE5aoC+7Ep5y5hKk413puiHMupgGYJYDZPsbr6Vl4HsnBMTzV1lTVXsSpombIqY/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:25.0599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fed0ba-a573-4d14-7716-08dcbc47eb06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

This is done to support other functionality provided by the SBRMI, which
does not fit in the hwmon subsystem.

- Move the SBRMI core functionality and I2C device probing part to misc.
- Move hwmon device sensor to misc as only power is reported through
  hwmon sensor.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v2:
Rebase the patch

Changes since v1:
- File name update
- Add hwmon sensor registration in this patch
- Update Copyright year

 drivers/hwmon/Kconfig            |  10 -
 drivers/hwmon/sbrmi.c            | 357 -------------------------------
 drivers/misc/Kconfig             |   1 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/amd-sbi/Kconfig     |   9 +
 drivers/misc/amd-sbi/Makefile    |   3 +
 drivers/misc/amd-sbi/rmi-core.c  | 115 ++++++++++
 drivers/misc/amd-sbi/rmi-core.h  |  65 ++++++
 drivers/misc/amd-sbi/rmi-hwmon.c | 121 +++++++++++
 drivers/misc/amd-sbi/rmi-i2c.c   | 111 ++++++++++
 10 files changed, 426 insertions(+), 367 deletions(-)
 delete mode 100644 drivers/hwmon/sbrmi.c
 create mode 100644 drivers/misc/amd-sbi/Kconfig
 create mode 100644 drivers/misc/amd-sbi/Makefile
 create mode 100644 drivers/misc/amd-sbi/rmi-core.c
 create mode 100644 drivers/misc/amd-sbi/rmi-core.h
 create mode 100644 drivers/misc/amd-sbi/rmi-hwmon.c
 create mode 100644 drivers/misc/amd-sbi/rmi-i2c.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..20bd7126362c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1823,16 +1823,6 @@ config SENSORS_SBTSI
 	  This driver can also be built as a module. If so, the module will
 	  be called sbtsi_temp.
 
-config SENSORS_SBRMI
-	tristate "Emulated SB-RMI sensor"
-	depends on I2C
-	help
-	  If you say yes here you get support for emulated RMI
-	  sensors on AMD SoCs with APML interface connected to a BMC device.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called sbrmi.
-
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/hwmon/sbrmi.c b/drivers/hwmon/sbrmi.c
deleted file mode 100644
index d48d8e5460ff..000000000000
--- a/drivers/hwmon/sbrmi.c
+++ /dev/null
@@ -1,357 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * sbrmi.c - hwmon driver for a SB-RMI mailbox
- *           compliant AMD SoC device.
- *
- * Copyright (C) 2020-2021 Advanced Micro Devices, Inc.
- */
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/hwmon.h>
-#include <linux/i2c.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
-
-/* Do not allow setting negative power limit */
-#define SBRMI_PWR_MIN	0
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
-
-static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
-		      u32 attr, int channel, long *val)
-{
-	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
-	int ret;
-
-	if (type != hwmon_power)
-		return -EINVAL;
-
-	msg.read = true;
-	switch (attr) {
-	case hwmon_power_input:
-		msg.cmd = SBRMI_READ_PKG_PWR_CONSUMPTION;
-		ret = rmi_mailbox_xfer(data, &msg);
-		break;
-	case hwmon_power_cap:
-		msg.cmd = SBRMI_READ_PKG_PWR_LIMIT;
-		ret = rmi_mailbox_xfer(data, &msg);
-		break;
-	case hwmon_power_cap_max:
-		msg.data_out = data->pwr_limit_max;
-		ret = 0;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if (ret < 0)
-		return ret;
-	/* hwmon power attributes are in microWatt */
-	*val = (long)msg.data_out * 1000;
-	return ret;
-}
-
-static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
-		       u32 attr, int channel, long val)
-{
-	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
-
-	if (type != hwmon_power && attr != hwmon_power_cap)
-		return -EINVAL;
-	/*
-	 * hwmon power attributes are in microWatt
-	 * mailbox read/write is in mWatt
-	 */
-	val /= 1000;
-
-	val = clamp_val(val, SBRMI_PWR_MIN, data->pwr_limit_max);
-
-	msg.cmd = SBRMI_WRITE_PKG_PWR_LIMIT;
-	msg.data_in = val;
-	msg.read = false;
-
-	return rmi_mailbox_xfer(data, &msg);
-}
-
-static umode_t sbrmi_is_visible(const void *data,
-				enum hwmon_sensor_types type,
-				u32 attr, int channel)
-{
-	switch (type) {
-	case hwmon_power:
-		switch (attr) {
-		case hwmon_power_input:
-		case hwmon_power_cap_max:
-			return 0444;
-		case hwmon_power_cap:
-			return 0644;
-		}
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static const struct hwmon_channel_info * const sbrmi_info[] = {
-	HWMON_CHANNEL_INFO(power,
-			   HWMON_P_INPUT | HWMON_P_CAP | HWMON_P_CAP_MAX),
-	NULL
-};
-
-static const struct hwmon_ops sbrmi_hwmon_ops = {
-	.is_visible = sbrmi_is_visible,
-	.read = sbrmi_read,
-	.write = sbrmi_write,
-};
-
-static const struct hwmon_chip_info sbrmi_chip_info = {
-	.ops = &sbrmi_hwmon_ops,
-	.info = sbrmi_info,
-};
-
-static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
-{
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
-	struct device *hwmon_dev;
-	struct sbrmi_data *data;
-	int ret;
-
-	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
-	if (!data)
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
-							 &sbrmi_chip_info, NULL);
-
-	return PTR_ERR_OR_ZERO(hwmon_dev);
-}
-
-static const struct i2c_device_id sbrmi_id[] = {
-	{"sbrmi"},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, sbrmi_id);
-
-static const struct of_device_id __maybe_unused sbrmi_of_match[] = {
-	{
-		.compatible = "amd,sbrmi",
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, sbrmi_of_match);
-
-static struct i2c_driver sbrmi_driver = {
-	.driver = {
-		.name = "sbrmi",
-		.of_match_table = of_match_ptr(sbrmi_of_match),
-	},
-	.probe = sbrmi_probe,
-	.id_table = sbrmi_id,
-};
-
-module_i2c_driver(sbrmi_driver);
-
-MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
-MODULE_DESCRIPTION("Hwmon driver for AMD SB-RMI emulated sensor");
-MODULE_LICENSE("GPL");
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41c3d2821a78..add70bc22fee 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -618,4 +618,5 @@ source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
 source "drivers/misc/keba/Kconfig"
+source "drivers/misc/amd-sbi/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c2f990862d2b..5e70d2b34a11 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -71,3 +71,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
 obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
 obj-y				+= keba/
+obj-y				+= amd-sbi/
diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
new file mode 100644
index 000000000000..be2d9e495eb7
--- /dev/null
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_SBRMI_I2C
+        tristate "AMD side band RMI support"
+        depends on I2C
+        help
+          Side band RMI over I2C support for AMD out of band management.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called sbrmi-i2c.
diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
new file mode 100644
index 000000000000..eac90a7635de
--- /dev/null
+++ b/drivers/misc/amd-sbi/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sbrmi-i2c-objs  		:= rmi-i2c.o rmi-core.o rmi-hwmon.o
+obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi-i2c.o
diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
new file mode 100644
index 000000000000..5d93fb703fa0
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sbrmi-core.c - file defining SB-RMI protocols compliant
+ *		  AMD SoC device.
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include "rmi-core.h"
+
+/* Mask for Status Register bit[1] */
+#define SW_ALERT_MASK	0x2
+/* Do not allow setting negative power limit */
+#define SBRMI_PWR_MIN	0
+
+/* Software Interrupt for triggering */
+#define START_CMD	0x80
+#define TRIGGER_MAILBOX	0x01
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
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-core.h
new file mode 100644
index 000000000000..3d600e450e08
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _SBRMI_CORE_H_
+#define _SBRMI_CORE_H_
+
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
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
+	struct platform_device *pdev;
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
+int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *msg);
+int create_hwmon_sensor_device(struct device *dev, struct sbrmi_data *data);
+#endif /*_SBRMI_CORE_H_*/
diff --git a/drivers/misc/amd-sbi/rmi-hwmon.c b/drivers/misc/amd-sbi/rmi-hwmon.c
new file mode 100644
index 000000000000..36913f105eef
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-hwmon.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * rmi-hwmon.c - hwmon sensor support for side band RMI
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include "rmi-core.h"
+
+/* Do not allow setting negative power limit */
+#define SBRMI_PWR_MIN  0
+
+static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val)
+{
+	struct sbrmi_data *data = dev_get_drvdata(dev);
+	struct sbrmi_mailbox_msg msg = { 0 };
+	int ret;
+
+	if (!data)
+		return -ENODEV;
+
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	msg.read = true;
+	switch (attr) {
+	case hwmon_power_input:
+		msg.cmd = SBRMI_READ_PKG_PWR_CONSUMPTION;
+		ret = rmi_mailbox_xfer(data, &msg);
+		break;
+	case hwmon_power_cap:
+		msg.cmd = SBRMI_READ_PKG_PWR_LIMIT;
+		ret = rmi_mailbox_xfer(data, &msg);
+		break;
+	case hwmon_power_cap_max:
+		msg.data_out = data->pwr_limit_max;
+		ret = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (ret < 0)
+		return ret;
+	/* hwmon power attributes are in microWatt */
+	*val = (long)msg.data_out * 1000;
+	return ret;
+}
+
+static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long val)
+{
+	struct sbrmi_data *data = dev_get_drvdata(dev);
+	struct sbrmi_mailbox_msg msg = { 0 };
+
+	if (!data)
+		return -ENODEV;
+
+	if (type != hwmon_power && attr != hwmon_power_cap)
+		return -EINVAL;
+	/*
+	 * hwmon power attributes are in microWatt
+	 * mailbox read/write is in mWatt
+	 */
+	val /= 1000;
+
+	val = clamp_val(val, SBRMI_PWR_MIN, data->pwr_limit_max);
+
+	msg.cmd = SBRMI_WRITE_PKG_PWR_LIMIT;
+	msg.data_in = val;
+	msg.read = false;
+
+	return rmi_mailbox_xfer(data, &msg);
+}
+
+static umode_t sbrmi_is_visible(const void *data,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+		case hwmon_power_cap_max:
+			return 0444;
+		case hwmon_power_cap:
+			return 0644;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info * const sbrmi_info[] = {
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_CAP | HWMON_P_CAP_MAX),
+	NULL
+};
+
+static const struct hwmon_ops sbrmi_hwmon_ops = {
+	.is_visible = sbrmi_is_visible,
+	.read = sbrmi_read,
+	.write = sbrmi_write,
+};
+
+static const struct hwmon_chip_info sbrmi_chip_info = {
+	.ops = &sbrmi_hwmon_ops,
+	.info = sbrmi_info,
+};
+
+int create_hwmon_sensor_device(struct device *dev, struct sbrmi_data *data)
+{
+	struct device *hwmon_dev;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sbrmi", data,
+							 &sbrmi_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
new file mode 100644
index 000000000000..ae968cf3c29c
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * rmi-i2c.c - Side band RMI over I2C support for AMD out
+ *             of band management
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include "rmi-core.h"
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
+	ret = sbrmi_get_max_pwr_limit(data);
+	if (ret < 0)
+		return ret;
+
+	dev_set_drvdata(dev, data);
+	return create_hwmon_sensor_device(dev, data);
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
-- 
2.44.0



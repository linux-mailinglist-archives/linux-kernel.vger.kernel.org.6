Return-Path: <linux-kernel+bounces-573882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08226A6DD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C4A3A391B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E6261367;
	Mon, 24 Mar 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VBES5q6U"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10732261394;
	Mon, 24 Mar 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828331; cv=fail; b=HUwqoKbjEj/w9j355VeAbWn1cbgLvcDwRvQOlWw8fcK/YEkqfEFczjBVH4gBJwHs8EnWUFITXJOHblTDp5H9AxZWKPKFd0GCOReaafbCb9qXEc9NFdbRl7NNMH6VYuw8rCzl8HV0dBGOwm0LDAtB0YIuQnxo2cUW3dO9qWycGPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828331; c=relaxed/simple;
	bh=viFp8DbKGwC6MbB6WRy4nLVumQuCbWfOyus6jNSr6qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPhvK6s2ghKOuDt86EigEbGO2lW29avZhiuKG0KDft/fiePgyBwBOxqCMKurppiMaHFx3QALzBg+wV4BsqbVBRCnidH6H+nLSOxQUMwFsK4VxSAvuCIHm/+O65LLPSD0gC8fUOtN6m3xdP9X0vp4oURdIJ3gajZkbg3b6yyewLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VBES5q6U; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+A2kIKevR7dsBL+Nv4SLcITXFgMclwDWRqWApltzJkpre3my4zTafoq0Y+kFQMDbbM3gjGEsVWv/fEu5Voi6SZIlIp4gJbdqyfI6y3Nnjb/tPP91a0G58OSolqKHKWXBrr7GLn2i+prs8OCT58ODnP9mvxVThSRgmL1+EEKu+Dn9MmuvMnupRuzWCm5Um3gybpbg/di6I9nl49KX7GCBrwyqFP3p9IQlgsMCPYSs/JwxzU/INq+74dEXJvvdL+GaonAWhs3A30WUUfIwROW+78u2/nVoEUx9vFfJ846z7rizfCqqDUuNQ6ZOy9Dt74scW1sAujJYsOa9zmK8yBdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+1U5lUHtH5HwC928X+ElB+vphiFG8FQtIFYYOtg50o=;
 b=pbVI6kmosyVarFcCRdMHRPr6jp3YaYuzO+KGpXBPYDRRELRGevO2OKY53Eo2c11NglN2ds1kRS4FeCIdwUkzGLJShxlXzazFTFB+inAgsEHH7SA0p5Kz918Aow+c7f6PT9Rpj5T99X3Kl+OSElC9Vs6X+zEBiHip5gv5ZOHHfN3sdmt//a5K+XT9sW9MEue/eKF5+GwyAIIp3QmMLY95N6QO9XxlRrjpd5vYMsVlOHoMIe4vUk9JQhCvJ2HGlA52MhGEXGpXvH/ny4R/B0w2jziAgXLW2OSNr3/Z9Ua+UaXzLeA4WRSL1skJPTLZrga1VDNpbSjTbCcHbfujUgkXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+1U5lUHtH5HwC928X+ElB+vphiFG8FQtIFYYOtg50o=;
 b=VBES5q6UM047wn+QHbcDy8oaAnNRDtIijNv0AaHwKzbSW6Jzjbr5NF7X9d0ISq3c9Vxk5aWo04FtBfphz+BvNCM4giM07AQwQs2txxp3Agr6oMitD5GAAcxWpsG7wm9hG8txyRrFlMsW+gTi1n2kJaj20Ur0SwV49UgLHqyoDn0=
Received: from CY5PR19CA0031.namprd19.prod.outlook.com (2603:10b6:930:1a::23)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:58:43 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::3b) by CY5PR19CA0031.outlook.office365.com
 (2603:10b6:930:1a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:58:43 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:40 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 02/11] misc: amd-sbi: Move protocol functionality to core file
Date: Mon, 24 Mar 2025 14:58:06 +0000
Message-ID: <20250324145815.1026314-3-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324145815.1026314-1-akshay.gupta@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: b86cedce-7f7c-4c8b-86d2-08dd6ae45f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0smDECGv4iSowwGThceTyxNPYlg+XPtzMNm85LwSzSRDst8K/ijUv/rgsIUk?=
 =?us-ascii?Q?Oitgcio7EF6XpiYE5o5Lg0pKor+esU/U0sVpz8HC2KtPaKJU0MDVd2ESScuM?=
 =?us-ascii?Q?va4Wb2CIwaKs0oDtndRY9y4wwrBYdjaq5qpQFi9Q3z1bfT4+1eXuKYgnoUr+?=
 =?us-ascii?Q?CsomzmZ8feyXPuXW0cnofgfBzQbOrKeuNlZC6juux2203e1eyvfR5Wg3mqw7?=
 =?us-ascii?Q?QT+nS4E2Vv0EYgo32VhikHlMB9iCKwVvj4820cOPOYUxfco9Evjd297mQsto?=
 =?us-ascii?Q?xwhLTv46n55YKi3TJGcO3tDXxsbSf6tX95sfDez72hKTl/GzhzY/HWN4fLbL?=
 =?us-ascii?Q?oDiqN60TS5i9B9loiFw0kL8JJS32dUuHeY3QY75xZMzPdtRoP7VxW9uIgKwZ?=
 =?us-ascii?Q?bO2fFhDWP1z0Nzde7tYyUJVNDCbERMmWfEbFxutq7JfTQNZ9Zvk/g6sD0GeX?=
 =?us-ascii?Q?oT1yCFzzFWhAVvphLy1eHng2XXSiY6vc2ApbyqAuyUe9Ox6EJOVj8awec4Qa?=
 =?us-ascii?Q?YK2/9XfbtwP/K+JTCGaDMO7J/nGaPKaLSEmvTw13KcufpG9UXksu6FxhA1F/?=
 =?us-ascii?Q?jC+H7cIoV+u1ZJbFs1nPLbOZboCR0zRT4RoLEHb6ZVuKr2wxwM/ykyskHVuR?=
 =?us-ascii?Q?jC8PF5hGVyXXICq+5pWIK+PhfEI4rF8MSmG24W3PtV8Q9xTC15TRypTm5Gkt?=
 =?us-ascii?Q?A/oaqQqfnLReeGSC0BTxmuoS56hTMiPNr22yA7LdMRGwkY/mMNzrj5xXuyJ4?=
 =?us-ascii?Q?KtVr3vXOXyjmIo5eGu2u6TkXe+kPtY7+RJqF8pd5fVQDFL8SaRSdqP2xJ/Rz?=
 =?us-ascii?Q?Spi9sxHb1Pe/i/eZoDwA8kKseWcbbh3RgPtw1gDB9hCIFWRDtzoB1jLOpPQD?=
 =?us-ascii?Q?jR8cx9AMp/UkFF8aevlvnomB9WR6Vc/6r2s9XlRrnaV7ZDYVISnDLglDLZbN?=
 =?us-ascii?Q?58bolMEuGMfppy1oPfHdgZfXPvfWk0+xu4HvETbdInJqtWatp5E+OF/47mbf?=
 =?us-ascii?Q?R+u7HcqDHjxFsu+ROmaUPADNww5YWh1FVbfotzQA3Wzqaaym+rCIeLjQWTH7?=
 =?us-ascii?Q?tANwc62UakgXc1lJyW9vvklr3O/H+X8tEh8PM8/H/8W+ga45sOyVE9wbbMow?=
 =?us-ascii?Q?EOlKWx8SSuC6+IOzqG+0jqr3WdRJeZOfhgwkZToMCR+XOHI213qfUVl/uukz?=
 =?us-ascii?Q?GtX4aIKMOqgNgyd7rqdAt66maopS667euQj75cPC6pJQJVqAQeW1oifKY38+?=
 =?us-ascii?Q?GIyNYoyC+TQGprxQTBQ2aDyd6DzNBVl+LhEmaMfFevZZM+xtyGiS1ua2YI7+?=
 =?us-ascii?Q?IopHzc/5Ev2wNWPBY4FEFYBYzYfwzBAhayAmstqYxDsz4wyMuRCvXgaNOFqf?=
 =?us-ascii?Q?7ROiY6URr9T4evB+q17ZbHiF69RDz5RiamjNNqfBST9A81zPJBU7wAVtAMPJ?=
 =?us-ascii?Q?EI+71RHqVcuCMS4eLzeM0HDYEzqsonBLJffPxL3x8c0l7iSzRVCzlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:58:43.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b86cedce-7f7c-4c8b-86d2-08dd6ae45f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

- This is done to utilize the protocol functionality into
  other domains.
- Increase the scalability of the module with different bus(i2c/i3c)

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v5:
- Address kernel test robot error:
 - undefined reference to `devm_hwmon_device_register_with_info'
Changes since v4:
New patch: Patch split from v4 patch 1/9
- Update Copyright year to 2025

 drivers/misc/amd-sbi/Makefile               |   3 +-
 drivers/misc/amd-sbi/rmi-core.c             | 113 +++++++++++++
 drivers/misc/amd-sbi/rmi-core.h             |  63 +++++++
 drivers/misc/amd-sbi/{sbrmi.c => rmi-i2c.c} | 175 ++------------------
 4 files changed, 193 insertions(+), 161 deletions(-)
 create mode 100644 drivers/misc/amd-sbi/rmi-core.c
 create mode 100644 drivers/misc/amd-sbi/rmi-core.h
 rename drivers/misc/amd-sbi/{sbrmi.c => rmi-i2c.c} (52%)

diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
index 304394bf5e59..7cd8e0a1aa5d 100644
--- a/drivers/misc/amd-sbi/Makefile
+++ b/drivers/misc/amd-sbi/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi.o
+sbrmi-i2c-objs  		:= rmi-i2c.o rmi-core.o
+obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi-i2c.o
diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
new file mode 100644
index 000000000000..74456756270c
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sbrmi-core.c - file defining SB-RMI protocols compliant
+ *		  AMD SoC device.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include "rmi-core.h"
+
+/* Mask for Status Register bit[1] */
+#define SW_ALERT_MASK	0x2
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
index 000000000000..8e30a43ec714
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
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
+#endif /*_SBRMI_CORE_H_*/
diff --git a/drivers/misc/amd-sbi/sbrmi.c b/drivers/misc/amd-sbi/rmi-i2c.c
similarity index 52%
rename from drivers/misc/amd-sbi/sbrmi.c
rename to drivers/misc/amd-sbi/rmi-i2c.c
index d48d8e5460ff..49049ce5bd02 100644
--- a/drivers/misc/amd-sbi/sbrmi.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * sbrmi.c - hwmon driver for a SB-RMI mailbox
- *           compliant AMD SoC device.
+ * rmi-i2c.c - Side band RMI over I2C support for AMD out
+ *             of band management
  *
- * Copyright (C) 2020-2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
  */
 
 #include <linux/delay.h>
@@ -14,64 +14,10 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include "rmi-core.h"
 
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
 
 static int sbrmi_enable_alert(struct i2c_client *client)
 {
@@ -94,100 +40,6 @@ static int sbrmi_enable_alert(struct i2c_client *client)
 	return 0;
 }
 
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
 static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
@@ -297,7 +149,7 @@ static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 	return ret;
 }
 
-static int sbrmi_probe(struct i2c_client *client)
+static int sbrmi_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
@@ -321,14 +173,16 @@ static int sbrmi_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
-							 &sbrmi_chip_info, NULL);
-
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
+								 &sbrmi_chip_info, NULL);
+		ret = PTR_ERR_OR_ZERO(hwmon_dev);
+	}
+	return ret;
 }
 
 static const struct i2c_device_id sbrmi_id[] = {
-	{"sbrmi"},
+	{"sbrmi-i2c"},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, sbrmi_id);
@@ -343,15 +197,16 @@ MODULE_DEVICE_TABLE(of, sbrmi_of_match);
 
 static struct i2c_driver sbrmi_driver = {
 	.driver = {
-		.name = "sbrmi",
+		.name = "sbrmi-i2c",
 		.of_match_table = of_match_ptr(sbrmi_of_match),
 	},
-	.probe = sbrmi_probe,
+	.probe = sbrmi_i2c_probe,
 	.id_table = sbrmi_id,
 };
 
 module_i2c_driver(sbrmi_driver);
 
 MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
+MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
 MODULE_DESCRIPTION("Hwmon driver for AMD SB-RMI emulated sensor");
 MODULE_LICENSE("GPL");
-- 
2.25.1



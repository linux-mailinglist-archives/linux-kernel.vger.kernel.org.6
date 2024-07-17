Return-Path: <linux-kernel+bounces-254868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB09338AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7691F23931
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EBC224FA;
	Wed, 17 Jul 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B3BJ+To0"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA41D482D7;
	Wed, 17 Jul 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203873; cv=fail; b=sDUjy/HrvmeljP1lbYMq9EVYCMn8Pi+XCq5heEyOG3zczXaXnF86LET3ru/HwFLr1XU2vfPx5EeD14JnHiolA+somHtqNpvMQY9G8GU78rrFR1yM9eVC89E9zM0wjDMWLdY4klrS/36dv3y04CWg6il8g9xyU91bUtB7APGUdsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203873; c=relaxed/simple;
	bh=uv0IuzTzxABfURpktfHXf5Fhs4XxaPg7MsiikBhoUAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViOdpyycuMedkajGcn4GNXCGG8Bmr8Xz9iSX25IsBUNBX++FBHLTw1sdpzbgNoiSicf9IVhsFJ+1DTSl3AIwYr508z8FgZZlr9YPztOoHLh7Lilq42JEj/MnoaIyt89BqtkkIa549VuYA2cxo1YwlQ1UfRaQOrSOBDrYnM8e/yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B3BJ+To0; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsODCHOOxilm/Rax7lD3pQF19nL+uRoBJRsjD53V/GznyxxfFq500AS0D/TZQDDhuAFhP56nMaz8zhLhCXX1oJGSk4+0qUIG/1tk1JycrjU4zBSqGCTj6KsPeS21Te8AoAE0Tj53MhkgaPAXXDqnGWrLMwVzcXm8jfsVyMX4hb6KVTnEj77LxBwSK5ZL7F8CPxbSGDnD9CyqfKwugjXbwc5uXYS9uvI7y5oXpKKQRgsB4DduA+fMwc+LmLqtuMb44iYV14oK40i4Gqcimkrun7Fz3DYA9XLmCBTCIBSNYFw9pq9jIrFrWwgMQpL9nCrJzoa/I6DKDAm98KW8sIPPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBtLQryjXxUBpXiNGGM8aWHmkwp9nf8Ib5io34VO0fQ=;
 b=YsyiOA1D2/+mxJyJQYFb+N0bpK9aU6/1Mza4pLaciq0YVmQXXXuZF81OPBnBoXsSMPd3J5Uhst7Cf8vS+OSZTwQm/2555oRhI0lKqlEIneMr+5m9abLcJHjpzhS+0TFM33o1kYxaj9X/FuSgIA6YInabkAPWB1RK1Ibm94XgY7uXIX81005NIwypKU2uQcEybquQOVSQ6WewuWGz+B0b7/jP4pEBP/UJ1L+gAd8TgEOvPAe13p6UT28pNpapNR/Y1lbJBTJMMK939TJTVCPGzAbXOSRzY0aVs3a/k/NrY8HjTJMBgeop65dolzZniKenCxBPY7R0vTlpD1DWfv3fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBtLQryjXxUBpXiNGGM8aWHmkwp9nf8Ib5io34VO0fQ=;
 b=B3BJ+To04z4AWMP0QtiIaAJwUYe0czwZ0TsCQ1rt6kIBrNHDGr3kX9LtCdvwFyrsCo7ft63ophG3vMxHagmeP1qlMtrSTT5ZmzyTMZZkS9b/b0vWTg8PXjpJjZm3qIiW/OEWLorz7cCjg9BTv75a2En3SjHTjKoNKaTYfc/QwWo=
Received: from CH2PR18CA0057.namprd18.prod.outlook.com (2603:10b6:610:55::37)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 08:11:06 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::25) by CH2PR18CA0057.outlook.office365.com
 (2603:10b6:610:55::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 08:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:11:06 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:11:03 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 5/8] misc: amd-sbi: Add support for CPUID protocol
Date: Wed, 17 Jul 2024 08:10:24 +0000
Message-ID: <20240717081027.2079549-6-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240717081027.2079549-1-akshay.gupta@amd.com>
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa2388b-7903-44a1-d406-08dca638024c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFUZjJ60R11P0vMqQo2j7em2gsmqh4r2OfMWdaQLJ8XY/gmqpMehVts4G6SA?=
 =?us-ascii?Q?Xh4Fx2bO6h5HovO3IZVl5CcMwzA4gQ6DEj84r+xShW7skhZ9gJP0bEuot5Nb?=
 =?us-ascii?Q?GNNtZrcsB7+YsT9/jmm+DkFVDkWg2MN3+ZOeQ1jJ9dQBxvuMIiZyuGNi4iPf?=
 =?us-ascii?Q?8Qf2OHU97+KK9WGqsYm/awYuTqdl+cIDj+q8XksuN6VN0V7PB56XTjEvUedK?=
 =?us-ascii?Q?CHieWb17Sz2zwuHKZhx4J/YJUCJagFX1AJvgnLwTb6123N2ttI0OVDIeaS/P?=
 =?us-ascii?Q?9T+MdijSkrSaJbYNugNquneCXFlOMbO8PnseyCbxFirDztTcflBY1GVVzHyT?=
 =?us-ascii?Q?aJ/1dHBTcrCBeCwQwOnVKRM3IKYNzVjZX/YIIevqzGNO9CDnB4+AggIB9kTi?=
 =?us-ascii?Q?E8pDo1o41UvJBYMjvoGhMPOkn2ekIwVfkp32RER1f/o8Dnm4mFDCW8PxFU0o?=
 =?us-ascii?Q?x4MW7tmOjlS8hUKXSp9sLr2OKMIKB/Sq5OnqYMkGclZDCrmgqw1lQhQky3J9?=
 =?us-ascii?Q?YTB9zpz803/SbzXY37DmzJvDg/dTPzmq2BS+QDmafkWTuMVsy2RXfk2Vszgu?=
 =?us-ascii?Q?qA96JMJ5TU6hpb2JyQ6f3w+8UJE1mw64U5H+K37PpMSNLJFQ1a5cRRuEFuvX?=
 =?us-ascii?Q?E1EFQaUj8mAgiHwy22FKS8B+jjhBG7H315kviwdqo2xR39uY1W49FKpNRvGq?=
 =?us-ascii?Q?nbloLqWD2S++WbWJKXDLNJlmn8B1ZwsI7HRRXNI5v5GSje3FWLqBWgy+vDl/?=
 =?us-ascii?Q?ZhSxhTYxOseTDiRZQLqgt20vQK6XXG57Re8SsuuGZgk9DhkDV8AlT+zoiGdg?=
 =?us-ascii?Q?Mw3g+3EdtkCORWKbEhThPY4/b5Ed59D811yqxzQzZZ86s75UCiWvccvrt+uL?=
 =?us-ascii?Q?625brlge/Q4IZ6EfPsQDF1b/L12TlDmiDkXahuwVD8xQwRfa0qP/GvTnY7Wj?=
 =?us-ascii?Q?HV44j2t4ynmkA4+NGngxWfSGXoapIfzE7kIAIx0ScYrhS4h5mzt9jwt6AxCh?=
 =?us-ascii?Q?0S+C7OHXvCSTH06gAGj9L6P38dhXoyMc0w8tEiOMFI7PAXlIRSV7yMWDoCvN?=
 =?us-ascii?Q?DXh6EBPM8opH5adZhR4mMz5DOY5XOCpZRH9VjrED0jlE4n3cZvIsckDBUdfW?=
 =?us-ascii?Q?bZPVzc+d/Zy5g5wDLITyqQT22I7I6Ig+xELS/hRN+p4J7oyV/XczHF5wjsKp?=
 =?us-ascii?Q?DEYA0be7EVGIUo6qGgGPdLz1dLykqxq/gdI5gQIn0feEZ+aYBVBvMy+eY6Ww?=
 =?us-ascii?Q?3vRDL5BGA99CV0E7ZYzxYsU7cYrs1Orcmh+PxKedSPaUVojz7SWdU2c6Peso?=
 =?us-ascii?Q?Ka91Ie1wCa5tUFrK56YEenX2KKfTqFNh4Xbt3Z9KrPDmZw9/rzd56uKwiBcS?=
 =?us-ascii?Q?B0C0PE443MCaJAt220VFb8mhPe+BcZsgTARED+WOr2uVm7Uben2jc+x7NEPQ?=
 =?us-ascii?Q?H4BXETSdaAPED0/hYJLOoXRAjV7jQKxi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:11:06.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa2388b-7903-44a1-d406-08dca638024c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

- AMD provides custom protocol to read Processor feature
  capabilities and configuration information through side band.
  The information is accessed by providing CPUID Function,
  extended function and thread ID to the protocol.
  Undefined function returns 0.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 170 ++++++++++++++++++++++++++++++++
 drivers/misc/amd-sbi/rmi-core.h |   5 +-
 include/uapi/misc/amd-apml.h    |  15 +++
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 01c3a6c9c15c..57625bc1b4de 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -17,6 +17,8 @@
 
 /* Mask for Status Register bit[1] */
 #define SW_ALERT_MASK	0x2
+/* Mask to check H/W Alert status bit */
+#define HW_ALERT_MASK	0x80
 /* Do not allow setting negative power limit */
 #define SBRMI_PWR_MIN	0
 
@@ -24,6 +26,171 @@
 #define START_CMD	0x80
 #define TRIGGER_MAILBOX	0x01
 
+/* Default message lengths as per APML command protocol */
+/* CPUID */
+#define CPUID_RD_DATA_LEN	0x8
+#define CPUID_WR_DATA_LEN	0x8
+#define CPUID_RD_REG_LEN	0xa
+#define CPUID_WR_REG_LEN	0x9
+
+/* CPUID MSR Command Ids */
+#define CPUID_MCA_CMD	0x73
+#define RD_CPUID_CMD	0x91
+
+/* input for bulk write to CPUID protocol */
+struct cpu_msr_indata {
+	u8 wr_len;	/* const value */
+	u8 rd_len;	/* const value */
+	u8 proto_cmd;	/* const value */
+	u8 thread;	/* thread number */
+	union {
+		u8 reg_offset[4];	/* input value */
+		u32 value;
+	};
+	u8 ext; /* extended function */
+} __packed;
+
+/* output for bulk read from CPUID protocol */
+struct cpu_msr_outdata {
+	u8 num_bytes;	/* number of bytes return */
+	u8 status;	/* Protocol status code */
+	union {
+		u64 value;
+		u8 reg_data[8];
+	};
+} __packed;
+
+#define prepare_cpuid_input_message(input, thread_id, func, ext_func)	\
+	input.rd_len = CPUID_RD_DATA_LEN,				\
+	input.wr_len = CPUID_WR_DATA_LEN,				\
+	input.proto_cmd = RD_CPUID_CMD,					\
+	input.thread = thread_id << 1,					\
+	input.value =  func,						\
+	input.ext =  ext_func
+
+/*
+ * For Mailbox command software alert status bit is set by firmware
+ * to indicate command completion
+ * For RMI Rev 0x20, new h/w status bit is introduced. which is used
+ * by firmware to indicate completion of commands (0x71, 0x72, 0x73).
+ * wait for the status bit to be set by the firmware before
+ * reading the data out.
+ */
+static int sbrmi_wait_status(struct sbrmi_data *data,
+			     int *status, int mask)
+{
+	int ret, retry = 100;
+
+	do {
+		ret = regmap_read(data->regmap, SBRMI_STATUS, status);
+		if (ret < 0)
+			return ret;
+
+		if (*status & mask)
+			break;
+
+		/* Wait 1~2 second for firmware to return data out */
+		if (retry > 95)
+			usleep_range(50, 100);
+		else
+			usleep_range(10000, 20000);
+	} while (retry--);
+
+	if (retry < 0)
+		ret = -ETIMEDOUT;
+	return ret;
+}
+
+static int sbrmi_get_rev(struct sbrmi_data *data)
+{
+	struct apml_message msg = { 0 };
+	int ret;
+
+	msg.data_in.reg_in[REG_OFF_INDEX] = SBRMI_REV;
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 1;
+	ret = regmap_read(data->regmap,
+			  msg.data_in.reg_in[REG_OFF_INDEX],
+			  &msg.data_out.mb_out[RD_WR_DATA_INDEX]);
+	if (ret < 0)
+		return ret;
+
+	data->rev = msg.data_out.reg_out[RD_WR_DATA_INDEX];
+	return 0;
+}
+
+/* Read CPUID function protocol */
+static int rmi_cpuid_read(struct sbrmi_data *data,
+			  struct apml_message *msg)
+{
+	struct cpu_msr_indata input = {0};
+	struct cpu_msr_outdata output = {0};
+	int val = 0;
+	int ret, hw_status;
+	u16 thread;
+
+	mutex_lock(&data->lock);
+	/* cache the rev value to identify if protocol is supported or not */
+	if (!data->rev) {
+		ret = sbrmi_get_rev(data);
+		if (ret < 0)
+			goto exit_unlock;
+	}
+	/* CPUID protocol for REV 0x10 is not supported*/
+	if (data->rev == 0x10) {
+		ret = -EOPNOTSUPP;
+		goto exit_unlock;
+	}
+
+	thread = msg->data_in.reg_in[THREAD_LOW_INDEX] |
+		 msg->data_in.reg_in[THREAD_HI_INDEX] << 8;
+
+	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
+	if (thread > 127) {
+		thread -= 128;
+		val = 1;
+	}
+	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
+	if (ret < 0)
+		goto exit_unlock;
+
+	prepare_cpuid_input_message(input, thread,
+				    msg->data_in.mb_in[RD_WR_DATA_INDEX],
+				    msg->data_in.reg_in[EXT_FUNC_INDEX]);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, CPUID_WR_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = sbrmi_wait_status(data, &hw_status, HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_bulk_read(data->regmap, CPUID_MCA_CMD,
+			       &output, CPUID_RD_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_write(data->regmap, SBRMI_STATUS,
+			   HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	if (output.num_bytes != CPUID_RD_REG_LEN - 1) {
+		ret = -EMSGSIZE;
+		goto exit_unlock;
+	}
+	if (output.status) {
+		ret = -EPROTOTYPE;
+		msg->fw_ret_code = output.status;
+		goto exit_unlock;
+	}
+	msg->data_out.cpu_msr_out = output.value;
+exit_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct apml_message *msg)
 {
@@ -147,6 +314,9 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		/* Mailbox protocol */
 		ret = rmi_mailbox_xfer(data, &msg);
 		break;
+	case APML_CPUID:
+		ret = rmi_cpuid_read(data, &msg);
+		break;
 	default:
 		pr_err("Command:0x%x not recognized\n", msg.cmd);
 		break;
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-core.h
index b728f5582256..529c8284dec4 100644
--- a/drivers/misc/amd-sbi/rmi-core.h
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -15,7 +15,8 @@
 
 /* SB-RMI registers */
 enum sbrmi_reg {
-	SBRMI_CTRL		= 0x01,
+	SBRMI_REV		= 0x00,
+	SBRMI_CTRL,
 	SBRMI_STATUS,
 	SBRMI_OUTBNDMSG0	= 0x30,
 	SBRMI_OUTBNDMSG1,
@@ -34,6 +35,7 @@ enum sbrmi_reg {
 	SBRMI_INBNDMSG6,
 	SBRMI_INBNDMSG7,
 	SBRMI_SW_INTERRUPT,
+	SBRMI_THREAD128CS	= 0x4b,
 };
 
 /*
@@ -56,6 +58,7 @@ struct sbrmi_data {
 	struct mutex lock;
 	u32 pwr_limit_max;
 	u8 dev_static_addr;
+	u8 rev;
 };
 
 int rmi_mailbox_xfer(struct sbrmi_data *data, struct apml_message *msg);
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
index 06e93a6a8f4b..21ea8c65daa6 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -7,10 +7,15 @@
 
 #include <linux/types.h>
 
+/* command ID to identify CPUID protocol */
+#define APML_CPUID	0x1000
 /* These are byte indexes into data_in and data_out arrays */
 #define RD_WR_DATA_INDEX	0
 #define REG_OFF_INDEX		0
 #define REG_VAL_INDEX		4
+#define THREAD_LOW_INDEX	4
+#define THREAD_HI_INDEX		5
+#define EXT_FUNC_INDEX		6
 #define RD_FLAG_INDEX		7
 
 #define MB_DATA_SIZE		4
@@ -18,27 +23,37 @@
 struct apml_message {
 	/* message ids:
 	 * Mailbox Messages:	0x0 ... 0x999
+	 * APML_CPUID:		0x1000
 	 */
 	__u32 cmd;
 
 	/*
 	 * 8 bit data for reg read,
 	 * 32 bit data in case of mailbox,
+	 * up to 64 bit in case of cpuid
 	 */
 	union {
+		__u64 cpu_msr_out;
 		__u32 mb_out[2];
 		__u8 reg_out[8];
 	} data_out;
 
 	/*
 	 * [0]...[3] mailbox 32bit input
+	 *	     cpuid,
+	 * [4][5] cpuid: thread
+	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
+	 *	[7:0] -> bits [7:4] -> ext function &
+	 *	bit [0] read eax/ebx or ecx/edx
 	 * [7] read/write functionality
 	 */
 	union {
+		__u64 cpu_msr_in;
 		__u32 mb_in[2];
 		__u8 reg_in[8];
 	} data_in;
 	/*
+	 * Status code is returned in case of CPUID access
 	 * Error code is returned in case of soft mailbox
 	 */
 	__u32 fw_ret_code;
-- 
2.44.0



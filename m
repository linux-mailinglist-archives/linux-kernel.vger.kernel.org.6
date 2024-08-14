Return-Path: <linux-kernel+bounces-286220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8611F951832
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3721F23B44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5448B1AE857;
	Wed, 14 Aug 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnAvWr1U"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215D1AE851;
	Wed, 14 Aug 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629647; cv=fail; b=tbic0FD8ueRud4Upff2Lfs0DzYThOTZDGMBFxq4W0lmMabvO2WBMgFieEUkoBmW4eV4EinxtN2A6wbhPb3FM1sVtNYsMPnEsjKcKM1U+oAXHgb8IRpQl1vwcdlh3Ia19xmuo/sighfkNie+ky3/SiAvteJfhVXT3punrtrjxpLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629647; c=relaxed/simple;
	bh=3DY60OUbkJNZFkXM7N5542o+VeYxmQv/DMXU51BiRhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8X/GRiKmsiyD3uGKcfpUb0UW+ZGcvKiGVBN/qSw/dAEMu5EMJArUrKLFO7Ih8ihWTyK2eImNocOeVTj2178OWxhxkW/fcj5EXmeUOJPzBnnXDvRmbrrR9BKFTNwhRYNr/JEPdT41mEzxv5EHQxkGFL6mAgChhNQILgOXbgHPj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnAvWr1U; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXURBCOqIrspKec1wvuSVogs1vt5Cty0pLpIi+MT2xHori7hmg4U+1Z8eOW1W3ZvhDLLyw5x3yn9VfKqGpsGJJZdikYTVmwZXHkRxViEvJhFP+dphiza2IxL+9xKy6//8B7Jy/LPJzOCGlog70DXfBq68M9Of5Ix5A/vJ8zRQx9pp33Wcl6xvWbk0qyhG6H1+UiC2PHu0Pg5SoaeeVF2fEJU/+tG0ylgyQ+QZfzyL+ZOiHn4GS5gKMYnBH1ciZBAqDk6Dk8m8zaKolJpYEih8EOUIBbYt7nS0B965+d+34SIRRKLPjJqY/JnDIyGFYsJcgKozeuVC0i3nbv15IT3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4km2wvCIrJ3Hkgkp9XsrLga8DOCef7GR9NirxYsZkX0=;
 b=kvLVUMQaPFo0gHUEZFouRd21/PbDv3FkBG22tUXO3/HZ7Trp3Z3+owPXT1NQXLG0qmuhrasW1JagsVmzDZARtzTqWEZHg4/+JIn5m/F1FUVimsidZCL2Fs87y3G+L6gIHvj1UuIaeTTz4Bb+Ybdfwqc11MqUwSOJ1rBS05iyafzazaMPKtXKdv3nUSsaWaG7f2n2VSh+Lym5xIc2nYAJhflp+Z5ZQoGWudRkC0u3ZoBN1l8G6zBuLxDRx2V3E0b7F3odDs3b9xzAcRHHVmIakwr9n0PyES2Zz/x7IH3sacAkaEAfd/1DTQMmFgLDbCrXJESsht+IfNUrVyqs8qHqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4km2wvCIrJ3Hkgkp9XsrLga8DOCef7GR9NirxYsZkX0=;
 b=gnAvWr1UdJfIjh++1r1ZNsSxKwsTiCmVC7K81HGOE9z/TqYmtSm2JJd9qdrzMeSV3VWFEd6fN+2dC0z0qIhEwLXVhZXixom208q0lqQfn0nKPetcK4k0XH3a5l/9DyUZtDqI1EdYIn3llRi9ctjl8sIa0R7ytvNfUXWKKyEchHw=
Received: from CH2PR18CA0037.namprd18.prod.outlook.com (2603:10b6:610:55::17)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:38 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::62) by CH2PR18CA0037.outlook.office365.com
 (2603:10b6:610:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:38 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:34 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 5/8] misc: amd-sbi: Add support for CPUID protocol
Date: Wed, 14 Aug 2024 09:59:50 +0000
Message-ID: <20240814095954.2359863-6-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eab36c-cf41-4c63-4e7e-08dcbc47f309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	7ULjUcFCIXN3FDbYUoXN+QEnQGunDEUJDf90sTByHl5hkXOOHDncHOZOxZ/xrjpdzzkym8JHsGqyCcvguOTn1/x3rb+OdLrZpqhcMQERKyOjMRSwPnO+uG/wBe9f5NiiEMaKYd/eMytjXpyih8woQYdZb6CpBJU8Eu/Q9vFOSztS76cp+kbqr/gaJc9/MEB++s3Lqkd+emGMXIuoLeBKKIaX+QvLRZzNjqmveybDciiqvdDzURcT9QRidJIgAoUpDRDdrwWuz0gONDeXdwSWH1ReC/6GRJ96NXSHwSmanr8GtxKrBkRZnuzFvEEu4OSh+hvYTvvbIUCZx/fnLZ6/C8O+NskhgCRJ42H25Xtqcfv1YBxOWctwaXhW49UviLnOeYKS4iYe1VbUIuaQr05r04r8rTnbs0fQAi+cI0yg5nh1wxIj0jRDVXykPZT2JHKHRsk4seNFtBZL1Amwd48CaRHR6OBmsJqyjInBZoEyAcvpGFMR93Du/gwQ87tKN8HwkiTaO/w5KMV0xO3673VIWTgs/osvD8AbCy0YBLZGYe6fnY1TfR/ab1aKB6MvX1UdLzmO56VckAgOZxqKoZNl9V55uIvlec20s4PIymjSDqSIXdf6Ou9tVvzhORSB/kljOEFn0k64CnmZrujj3KMsGFReBmx8jkzRsCUPz8CB/03blWgRdgbQf2FfIdPVd4i8EqMMLjpvov9nXC+G6jALo8L7jf+pIbYAuT61I25/txRN+mpaoR2BL7MwdBzbiC6y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:38.4222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eab36c-cf41-4c63-4e7e-08dcbc47f309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528

- AMD provides custom protocol to read Processor feature
  capabilities and configuration information through side band.
  The information is accessed by providing CPUID Function,
  extended function and thread ID to the protocol.
  Undefined function returns 0.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 170 ++++++++++++++++++++++++++++++++
 drivers/misc/amd-sbi/rmi-core.h |   5 +-
 include/uapi/misc/amd-apml.h    |  15 +++
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index a6364337dc5e..fdac6848ae9a 100644
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
+	msg.data_in.reg_in[AMD_SBI_REG_OFF_INDEX] = SBRMI_REV;
+	msg.data_in.reg_in[AMD_SBI_RD_FLAG_INDEX] = 1;
+	ret = regmap_read(data->regmap,
+			  msg.data_in.reg_in[AMD_SBI_REG_OFF_INDEX],
+			  &msg.data_out.mb_out[AMD_SBI_RD_WR_DATA_INDEX]);
+	if (ret < 0)
+		return ret;
+
+	data->rev = msg.data_out.reg_out[AMD_SBI_RD_WR_DATA_INDEX];
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
+	thread = msg->data_in.reg_in[AMD_SBI_THREAD_LOW_INDEX] |
+		 msg->data_in.reg_in[AMD_SBI_THREAD_HI_INDEX] << 8;
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
+				    msg->data_in.mb_in[AMD_SBI_RD_WR_DATA_INDEX],
+				    msg->data_in.reg_in[AMD_SBI_EXT_FUNC_INDEX]);
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
index b2d711d422cb..30bb6307993b 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -7,38 +7,53 @@
 
 #include <linux/types.h>
 
+/* command ID to identify CPUID protocol */
+#define APML_CPUID	0x1000
 /* These are byte indexes into data_in and data_out arrays */
 #define AMD_SBI_RD_WR_DATA_INDEX	0
 #define AMD_SBI_REG_OFF_INDEX		0
 #define AMD_SBI_REG_VAL_INDEX		4
 #define AMD_SBI_RD_FLAG_INDEX		7
+#define AMD_SBI_THREAD_LOW_INDEX	4
+#define AMD_SBI_THREAD_HI_INDEX		5
+#define AMD_SBI_EXT_FUNC_INDEX		6
 
 #define AMD_SBI_MB_DATA_SIZE		4
 
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



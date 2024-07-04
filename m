Return-Path: <linux-kernel+bounces-240936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8659274CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D21F22447
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F01ACE7E;
	Thu,  4 Jul 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gDsmKcNm"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5D1AC25C;
	Thu,  4 Jul 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091848; cv=fail; b=USUigPYlMcPe6AlR53NPQhl4Ps0YxkKXVEn23DAkG05CobFkDOOZZ2loRBBpioGgVr4C2gJ462fvBp9jEW/eklU9F43FiROdV9/OXH9+aUFhJ1CVq2yTNGrYZeoMI5ct+Mcu9aFTtgtgLxx9Z6dC8xPz+smjr9GmOqBAYZgZNdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091848; c=relaxed/simple;
	bh=ko7Vt0D7C/ZNYckfkcuWWjS9+/6/emSwiME6cHHNzgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnP9JUKjOQvsdOkzpH4oSBLYH9PuAvUn5raQl00mvoXequ3Hsn7YvHOPKUamXaT+J1oGws/Y6N698JXUJSkGXnxfmCJ798WUuFcF7tIt0oyMA7uqvBX+/+rM96rYmeKBl9zXRIl1fAOBcyy+gaeRl3YCmax3V+XLAgx8RM6mLmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gDsmKcNm; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG8UzB7ATxLK+njgINnr/dc9MQI1SopgPLMmEGRghWPxpsiOnqdJU9U1p1xn8XQZy9148OUMaZahMqWFilu0hQ+/5SZ1adqkWsIQTnljrHEmjs+MznPFM/z40oht+Kc9RRIpbNkNCLr/93vxAlYICdxkPvGCopQwRc+RKGj1FrX7O61AFLG9PQjVA9tXAVGSmAzyaxCNJFX1VjPsHpbGpVxGC2xP0kvgDWmzFLdjaPp+/R51FNQjI92wYuV4CGh5D+nZtSoCIpGckky1CXyHgV+DV8BXnw1Po4RiuTvsVAlSgSFJxdLB/d3ePmIVaSx2F09hdI0C/0ayrE5QGy7gzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OLxUy7NEmHX2ztwgtammgtHISh750RsFHFwJgYoLPE=;
 b=SZV6sAtXZclqHMdVCHGXgL7/Yot3XALi+OCzb29rrSOKeuovLKl9zR1nw3ULz6zb2lqU5BdEqqe10RvJK7KElA2JQJRVu1q6Fsr5T47QotY8yRDqlSMwWHYeyrAFBBbIunOa82Xih9tP4fZAAASUYUgbEzzIn4Wrq5L5cDx0M1PWNPKUbOtBiKZIFybJj5/M0k+BDengRXDjQHMc1WoJ2ZfMxVfO1s1V9kBvird2Uu63IU/wnr/wERrXaQzHYPs8943RsU/TsSEsoqc7Jnl8bXyA0lW4vHHLSt+p8r7j1gfUFrcKe152/mqrsJIHraJBsr0jKgAsIY/m657BpUBCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OLxUy7NEmHX2ztwgtammgtHISh750RsFHFwJgYoLPE=;
 b=gDsmKcNmEzlVlS1h2BYiphx+L6boWLd35zB/mw++x5gbvmU0Ogu/0GS8hL8TnmeazN4ia14ncR4draGTiLjZMN9Aw6bXg37MaTDBFfGfvzo1kn+2XoO73V+/hyvaQySx1dAufyCEg9aoPcKTX3NuUnMBWcwVov0S7aGqSeR74lM=
Received: from CH2PR20CA0026.namprd20.prod.outlook.com (2603:10b6:610:58::36)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 11:17:24 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::f2) by CH2PR20CA0026.outlook.office365.com
 (2603:10b6:610:58::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Thu, 4 Jul 2024 11:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 11:17:23 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 06:17:20 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH 6/6] misc: sbrmi: Add support for new revision
Date: Thu, 4 Jul 2024 11:16:24 +0000
Message-ID: <20240704111624.1583460-7-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: cc64e856-ecf8-457d-e347-08dc9c1ae108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tWL+iaB8QCRJZfqjawVtMuatzi/weejwdC3hUdCWTqPNAQbFbBFYVl3Tzsgu?=
 =?us-ascii?Q?7F9ZoB3a/l0H6wT6aDu6ii0w/sE5HMV5aBIjyKirPFUsS973vVmTJM2HoWuv?=
 =?us-ascii?Q?L6Bwg1dPMvaY8bhRNw0vGOWp/dd7CPAmuQ/yQNYUS7alDxvWf8CreLO8XdSh?=
 =?us-ascii?Q?nUX0rp23j7ge2BeD8wKZlbgQXLqIEdGxyf7goq+a3FRGHs7Ru/+f0MGuemOl?=
 =?us-ascii?Q?1SwOED3diR02pV3/wxMhwKpKDVA7UEkjtwHW6h6Cqb/2jkthydXinsEAlzkr?=
 =?us-ascii?Q?FCXHp8T6vHxjt422UnrAsQcB8Cav3BOfhhKeRWCsZfP1gq1MjX4wjV/gG8hm?=
 =?us-ascii?Q?PNXqjEquO8jdEFlarxr9LZI+M1vKPVksYnkL500JppusPeTt91AmfA4B/rqL?=
 =?us-ascii?Q?f07SpBT21lABa2Q0rUAcIxk7h0r3WbQ877r0dAVysFZYeXjaYV3Sw9Qv5CCJ?=
 =?us-ascii?Q?wCSlPg4C4hGW9ZiGWR7YDQwFrbUdO3w2Ss35+SsYxXKVbBGhJyVUXwBMxWhv?=
 =?us-ascii?Q?hUCY7SUj1oMOyoY2J4GtpfPAHH7WaAKzGxzSbmTOvQ28repsK4OZS9P316zC?=
 =?us-ascii?Q?uI1YVNMQHzIu4VXDT2BYhaySy+Arnml2jOQD0TB0/z24F7cyiPJaw5l3chBT?=
 =?us-ascii?Q?NUU/LyJTjqP+YnjUDH6B0kGLRfsiJVPKFXMhgV86PUNynWsHnGFZM3wkxg1c?=
 =?us-ascii?Q?NiObXj3Xin+0bXUuxA2FU+koWLz4DlxLB6EyKOD/r5oQmPC2sP9jGmdPKxyB?=
 =?us-ascii?Q?WOKKtfhYrGh4hMaaQLt/LuHTb63HqXKhWL7GVyeDUt04hy4NnRCQ4jykoRRD?=
 =?us-ascii?Q?+7pzk9jiG6iRjBtWDX5c/58S74owg2ges4XwQFF4Nn5WhWB4d3/GIZa7WF3Q?=
 =?us-ascii?Q?6He4aQy4S/53aFQMsNhN652flHxXOocE1RplhLAeakRw+Uq9znS0Hq+7De7k?=
 =?us-ascii?Q?WjYTeRc9nEgoMS+cbU+xtGZi7ux1FKqGumSVzmJJD119hzpnRZQDlAxBytjv?=
 =?us-ascii?Q?aX+3B9x7nnJNPAmWkKAQWO4FlOXxg0x5120PdfIMmfTlAK/9YrmYVrDOK1ws?=
 =?us-ascii?Q?JQ/BDgwubgrotmTC7nzi/piC8MSc3O7Hrx6tukjSzJ+hg8xAi8KRuFM3TSMx?=
 =?us-ascii?Q?yw6n9llLkTH5A5GhG8G3jqvNJ4euKezywXgu1nHLN4ub/JVlcrBwd6ZppWZ/?=
 =?us-ascii?Q?ld2uhHdEm6H7fQV/p+qbTPdaYnGq752prcGNA5/z8GXhIAnwGjtDxy+Hxho1?=
 =?us-ascii?Q?DGcvyiiZkRDrKOja5S3PekKRhVDZbFMXXfO7E8JMqHcE/V+1atn/QJ2AarTt?=
 =?us-ascii?Q?QMkRC1aHuHen7yRZsA3vNOZ9raaVvnVM3jc9ptiGbgc/D+JPcXG5s1TsrY4f?=
 =?us-ascii?Q?7XOv/tyMG7Bv4GoZWKmfPBdJQ32qmDbWnSHOLd0ZT7blduvHMBbapo94YGSk?=
 =?us-ascii?Q?q0Zp1ijzulQJpw3gp6S4wak0mSAXnTK1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:17:23.7212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc64e856-ecf8-457d-e347-08dc9c1ae108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010

- RMI device supports v21 on Turin, which has increased register set.
  Hence, requires 2byte for register addressing.

- Both Genoa and Turin processors are SP5 compatible, often CPUs are
  interchanged on the base boards with BMC remaining the same.
  Hence, we need to identify correct regmap configuration. A mechanism
  was not defined to identify the RMI register address width.
- The address width can only be determined if the socket is powered ON.
- This patch also addresses CPUID and MCAMSR register read protocol,
  the modification is due to the increase in register address size and
  the modified thread input.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
 drivers/misc/amd-sb/sbrmi-core.c | 215 +++++++++++++++++++++++--------
 drivers/misc/amd-sb/sbrmi-i2c.c  |  94 ++++++++++++--
 2 files changed, 242 insertions(+), 67 deletions(-)

diff --git a/drivers/misc/amd-sb/sbrmi-core.c b/drivers/misc/amd-sb/sbrmi-core.c
index c180f58b92c3..dc6f4e806a91 100644
--- a/drivers/misc/amd-sb/sbrmi-core.c
+++ b/drivers/misc/amd-sb/sbrmi-core.c
@@ -29,13 +29,17 @@
 /* MSR */
 #define MSR_RD_REG_LEN		0xa
 #define MSR_WR_REG_LEN		0x8
+#define MSR_WR_REG_LEN_v21	0x9
 #define MSR_RD_DATA_LEN		0x8
 #define MSR_WR_DATA_LEN		0x7
+#define MSR_WR_DATA_LEN_v21	0x8
 /* CPUID */
 #define CPUID_RD_DATA_LEN	0x8
 #define CPUID_WR_DATA_LEN	0x8
+#define CPUID_WR_DATA_LEN_v21	0x9
 #define CPUID_RD_REG_LEN	0xa
 #define CPUID_WR_REG_LEN	0x9
+#define CPUID_WR_REG_LEN_v21	0xa
 
 /* CPUID MSR Command Ids */
 #define CPUID_MCA_CMD	0x73
@@ -55,6 +59,19 @@ struct cpu_msr_indata {
 	u8 ext; /* extended function */
 } __packed;
 
+/* input for bulk write to v21 of CPUID and MSR protocol */
+struct cpu_msr_indata_v21 {
+	u8 wr_len;	/* const value */
+	u8 rd_len;	/* const value */
+	u8 proto_cmd;	/* const value */
+	u16 thread;	/* thread number */
+	union {
+		u8 reg_offset[4];	/* input value */
+		u32 value;
+	};
+	u8 ext; /* extended function */
+} __packed;
+
 /* output for bulk read from CPUID and MSR protocol */
 struct cpu_msr_outdata {
 	u8 num_bytes;	/* number of bytes return */
@@ -65,16 +82,16 @@ struct cpu_msr_outdata {
 	};
 } __packed;
 
-#define prepare_mca_msr_input_message(input, thread_id, data_in)	\
+#define prepare_mca_msr_input_message(input, thread_id, data_in, wr_data_len)	\
 	input.rd_len = MSR_RD_DATA_LEN,					\
-	input.wr_len = MSR_WR_DATA_LEN,					\
+	input.wr_len = wr_data_len,					\
 	input.proto_cmd = RD_MCA_CMD,					\
 	input.thread = thread_id << 1,					\
 	input.value =  data_in
 
-#define prepare_cpuid_input_message(input, thread_id, func, ext_func)	\
+#define prepare_cpuid_input_message(input, thread_id, func, ext_func, wr_data_len)	\
 	input.rd_len = CPUID_RD_DATA_LEN,				\
-	input.wr_len = CPUID_WR_DATA_LEN,				\
+	input.wr_len = wr_data_len,				\
 	input.proto_cmd = RD_CPUID_CMD,					\
 	input.thread = thread_id << 1,					\
 	input.value =  func,						\
@@ -131,25 +148,13 @@ static int sbrmi_wait_status(struct sbrmi_data *data,
 }
 
 /* MCA MSR protocol */
-static int rmi_mca_msr_read(struct sbrmi_data *data,
-			    struct apml_message *msg)
+static int msr_datain_v20(struct sbrmi_data *data,
+			  struct apml_message *msg)
 {
-	struct cpu_msr_outdata output = {0};
 	struct cpu_msr_indata input = {0};
 	int ret, val = 0;
-	int hw_status;
 	u16 thread;
 
-	/* cache the rev value to identify if protocol is supported or not */
-	if (!data->rev) {
-		ret = sbrmi_get_rev(data);
-		if (ret < 0)
-			return ret;
-	}
-	/* MCA MSR protocol for REV 0x10 is not supported*/
-	if (data->rev == 0x10)
-		return -EOPNOTSUPP;
-
 	thread = msg->data_in.reg_in[THREAD_LOW_INDEX] |
 		 msg->data_in.reg_in[THREAD_HI_INDEX] << 8;
 
@@ -160,15 +165,71 @@ static int rmi_mca_msr_read(struct sbrmi_data *data,
 	}
 	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
 	if (ret < 0)
-		goto exit_unlock;
+		return ret;
 
 	prepare_mca_msr_input_message(input, thread,
-				      msg->data_in.mb_in[RD_WR_DATA_INDEX]);
+				      msg->data_in.mb_in[RD_WR_DATA_INDEX],
+				      MSR_WR_DATA_LEN);
 
 	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
 				&input, MSR_WR_REG_LEN);
-	if (ret < 0)
-		goto exit_unlock;
+	return ret;
+}
+
+static int msr_datain_v21(struct sbrmi_data *data,
+			  struct apml_message *msg)
+{
+	struct cpu_msr_indata_v21 input = {0};
+	int ret;
+	u16 thread;
+
+	thread = msg->data_in.reg_in[THREAD_LOW_INDEX] |
+		 msg->data_in.reg_in[THREAD_HI_INDEX] << 8;
+
+	prepare_mca_msr_input_message(input, thread,
+				      msg->data_in.mb_in[RD_WR_DATA_INDEX],
+				      MSR_WR_DATA_LEN_v21);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, MSR_WR_REG_LEN_v21);
+	return ret;
+}
+
+static int rmi_mca_msr_read(struct sbrmi_data *data,
+			    struct apml_message *msg)
+{
+	struct cpu_msr_outdata output = {0};
+	int ret;
+	int hw_status;
+
+	if (!data->regmap)
+		return -ENODEV;
+
+	/* cache the rev value to identify if protocol is supported or not */
+	if (!data->rev) {
+		ret = sbrmi_get_rev(data);
+		if (ret < 0)
+			return ret;
+	}
+
+	switch (data->rev) {
+	/* MCA MSR protocol for REV 0x10 is not supported*/
+	case 0x10:
+		return -EOPNOTSUPP;
+	case 0x20:
+		ret = msr_datain_v20(data, msg);
+		if (ret < 0)
+			goto exit_unlock;
+
+		break;
+	case 0x21:
+		ret = msr_datain_v21(data, msg);
+		if (ret < 0)
+			goto exit_unlock;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
 	ret = sbrmi_wait_status(data, &hw_status, HW_ALERT_MASK);
 	if (ret < 0)
@@ -200,25 +261,13 @@ static int rmi_mca_msr_read(struct sbrmi_data *data,
 }
 
 /* Read CPUID function protocol */
-static int rmi_cpuid_read(struct sbrmi_data *data,
-			  struct apml_message *msg)
+static int cpuid_datain_v20(struct sbrmi_data *data,
+			    struct apml_message *msg)
 {
 	struct cpu_msr_indata input = {0};
-	struct cpu_msr_outdata output = {0};
-	int val = 0;
-	int ret, hw_status;
+	int ret, val = 0;
 	u16 thread;
 
-	/* cache the rev value to identify if protocol is supported or not */
-	if (!data->rev) {
-		ret = sbrmi_get_rev(data);
-		if (ret < 0)
-			return ret;
-	}
-	/* CPUID protocol for REV 0x10 is not supported*/
-	if (data->rev == 0x10)
-		return -EOPNOTSUPP;
-
 	thread = msg->data_in.reg_in[THREAD_LOW_INDEX] |
 		 msg->data_in.reg_in[THREAD_HI_INDEX] << 8;
 
@@ -229,16 +278,71 @@ static int rmi_cpuid_read(struct sbrmi_data *data,
 	}
 	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
 	if (ret < 0)
-		goto exit_unlock;
-
+		return ret;
 	prepare_cpuid_input_message(input, thread,
 				    msg->data_in.mb_in[RD_WR_DATA_INDEX],
-				    msg->data_in.reg_in[EXT_FUNC_INDEX]);
+				    msg->data_in.reg_in[EXT_FUNC_INDEX],
+				    CPUID_WR_DATA_LEN);
 
 	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
 				&input, CPUID_WR_REG_LEN);
-	if (ret < 0)
-		goto exit_unlock;
+	return ret;
+}
+
+static int cpuid_datain_v21(struct sbrmi_data *data,
+			    struct apml_message *msg)
+{
+	struct cpu_msr_indata_v21 input = {0};
+	int ret;
+	u16 thread;
+
+	thread = msg->data_in.reg_in[THREAD_LOW_INDEX] |
+		 msg->data_in.reg_in[THREAD_HI_INDEX] << 8;
+
+	prepare_cpuid_input_message(input, thread,
+				    msg->data_in.mb_in[RD_WR_DATA_INDEX],
+				    msg->data_in.reg_in[EXT_FUNC_INDEX],
+				    CPUID_WR_DATA_LEN_v21);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, CPUID_WR_REG_LEN_v21);
+	return ret;
+}
+
+/* CPUID protocol */
+static int rmi_cpuid_read(struct sbrmi_data *data,
+			  struct apml_message *msg)
+{
+	struct cpu_msr_outdata output = {0};
+	int ret, hw_status;
+
+	if (!data->regmap)
+		return -ENODEV;
+
+	/* cache the rev value to identify if protocol is supported or not */
+	if (!data->rev) {
+		ret = sbrmi_get_rev(data);
+		if (ret < 0)
+			return ret;
+	}
+
+	switch (data->rev) {
+	/* CPUID protocol for REV 0x10 is not supported*/
+	case 0x10:
+		return -EOPNOTSUPP;
+	case 0x20:
+		ret = cpuid_datain_v20(data, msg);
+		if (ret < 0)
+			goto exit_unlock;
+		break;
+	case 0x21:
+		ret = cpuid_datain_v21(data, msg);
+		if (ret < 0)
+			goto exit_unlock;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
 	ret = sbrmi_wait_status(data, &hw_status, HW_ALERT_MASK);
 	if (ret < 0)
@@ -412,11 +516,11 @@ static int rmi_xfer(struct sbrmi_data *data,
 		/* REG R/W */
 		if (msg->data_in.reg_in[RD_FLAG_INDEX])
 			ret = regmap_read(data->regmap,
-					  msg->data_in.reg_in[REG_OFF_INDEX],
+					  msg->data_in.mb_in[REG_OFF_INDEX],
 					  &msg->data_out.mb_out[RD_WR_DATA_INDEX]);
 		else
 			ret = regmap_write(data->regmap,
-					   msg->data_in.reg_in[REG_OFF_INDEX],
+					   msg->data_in.mb_in[REG_OFF_INDEX],
 					   msg->data_in.reg_in[REG_VAL_INDEX]);
 		break;
 	default:
@@ -466,7 +570,6 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 	if (copy_struct_from_user(&msg, sizeof(msg), arguser,
 				  sizeof(struct apml_message)))
 		return ret;
-
 	/* Is this a read/monitor/get request */
 	if (msg.data_in.reg_in[RD_FLAG_INDEX])
 		read = true;
@@ -492,18 +595,18 @@ int create_misc_rmi_device(struct sbrmi_data *data,
 {
 	int ret;
 
-	data->sbrmi_misc_dev.name	= devm_kasprintf(dev,
-							 GFP_KERNEL,
-							 "sbrmi-%x",
-							 data->dev_static_addr);
-	data->sbrmi_misc_dev.minor	= MISC_DYNAMIC_MINOR;
-	data->sbrmi_misc_dev.fops	= &sbrmi_fops;
-	data->sbrmi_misc_dev.parent	= dev;
+	data->sbrmi_misc_dev.name		= devm_kasprintf(dev,
+								 GFP_KERNEL,
+								 "sbrmi-%x",
+								 data->dev_static_addr);
+	data->sbrmi_misc_dev.minor		= MISC_DYNAMIC_MINOR;
+	data->sbrmi_misc_dev.fops		= &sbrmi_fops;
+	data->sbrmi_misc_dev.parent		= dev;
 	data->sbrmi_misc_dev.nodename	= devm_kasprintf(dev,
-							 GFP_KERNEL,
-							 "sbrmi-%x",
-							 data->dev_static_addr);
-	data->sbrmi_misc_dev.mode	= 0600;
+								 GFP_KERNEL,
+								 "sbrmi-%x",
+								 data->dev_static_addr);
+	data->sbrmi_misc_dev.mode		= 0600;
 
 	ret = misc_register(&data->sbrmi_misc_dev);
 	if (ret)
diff --git a/drivers/misc/amd-sb/sbrmi-i2c.c b/drivers/misc/amd-sb/sbrmi-i2c.c
index f0499b0ef5e3..f0645b3fa05b 100644
--- a/drivers/misc/amd-sb/sbrmi-i2c.c
+++ b/drivers/misc/amd-sb/sbrmi-i2c.c
@@ -19,6 +19,82 @@
 
 #define MAX_WAIT_TIME_SEC	(3)
 
+/* Try 2 byte address size before switching to 1 byte */
+#define MAX_RETRY	5
+
+/*
+ * There are processor with RMI address size as 2 byte and others with 1 byte,
+ * with no clear detection mechanism in place.
+ * Execute 2 bytes access first, and then fall back to 1 byte.
+ * Sending 2 bytes first is safer as sending 1 byte address size on
+ * Turin(2 bytes) can cause unrecoverable error and may requries to reboot
+ * the system.
+ */
+static int configure_regmap(struct i2c_client *client, struct sbrmi_data *data)
+{
+	struct regmap_config sbrmi_i2c_regmap_config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+	};
+	struct regmap_config sbrmi_i2c_regmap_config_2_bytes = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	};
+	u32 i;
+	int ret, rev;
+
+	if (!client || !data)
+		return -ENODEV;
+
+	/* Checking RMI register address size as 2 bytes */
+	data->regmap = devm_regmap_init_i2c(client,
+					    &sbrmi_i2c_regmap_config_2_bytes);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	for (i = 0; i < MAX_RETRY; i++) {
+		ret = regmap_read(data->regmap, SBRMI_REV, &rev);
+		if (ret < 0) {
+			usleep_range(10000, 20000);
+			continue;
+		} else {
+			break;
+		}
+	}
+
+	/*
+	 * Fall back to register address size as 1 byte
+	 * Check for revision as 0x21 to not break backward compatbility
+	 * for few Family:0x19 processors
+	 */
+	if (ret || rev != 0x21) {
+		data->regmap = devm_regmap_init_i2c(client,
+						    &sbrmi_i2c_regmap_config);
+		if (IS_ERR(data->regmap))
+			return PTR_ERR(data->regmap);
+
+		ret = regmap_read(data->regmap, SBRMI_REV, &rev);
+		if (ret < 0)
+			return ret;
+	}
+	data->rev = rev;
+
+	/*
+	 * For some Turin platforms, first 1 byte transaction can be successful,
+	 * verify if revision is 0x21, if yes, switch to 2 byte address size
+	 */
+	if (data->rev == 0x21)
+		data->regmap = devm_regmap_init_i2c(client,
+						    &sbrmi_i2c_regmap_config_2_bytes);
+	else
+		data->regmap = devm_regmap_init_i2c(client,
+						    &sbrmi_i2c_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+	return ret;
+}
+
 static int sbrmi_enable_alert(struct sbrmi_data *data)
 {
 	int ctrl, ret;
@@ -58,24 +134,20 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct sbrmi_data *data;
-	struct regmap_config sbrmi_i2c_regmap_config = {
-		.reg_bits = 8,
-		.val_bits = 8,
-	};
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	ret = configure_regmap(client, data);
+	if (ret)
+		return -EPROBE_DEFER;
+
 	atomic_set(&data->in_progress, 0);
 	atomic_set(&data->no_new_trans, 0);
 	mutex_init(&data->lock);
 
-	data->regmap = devm_regmap_init_i2c(client, &sbrmi_i2c_regmap_config);
-	if (IS_ERR(data->regmap))
-		return PTR_ERR(data->regmap);
-
 	/* Enable alert for SB-RMI sequence */
 	ret = sbrmi_enable_alert(data);
 	if (ret < 0)
@@ -91,9 +163,9 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	dev_set_drvdata(dev, (void *)data);
 
 	data->pdev = platform_device_register_data(dev, "sbrmi-hwmon",
-						   PLATFORM_DEVID_NONE,
-						   data,
-						   sizeof(struct sbrmi_data));
+						      PLATFORM_DEVID_NONE,
+						      data,
+						      sizeof(struct sbrmi_data));
 	if (IS_ERR(data->pdev)) {
 		pr_err("unable to register platform device for sbrmi-hwmon\n");
 		return PTR_ERR(data->pdev);
-- 
2.25.1



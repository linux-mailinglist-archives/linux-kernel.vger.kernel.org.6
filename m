Return-Path: <linux-kernel+bounces-286222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164B951836
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24537284BED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E91AED29;
	Wed, 14 Aug 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kPRVKJEt"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B151AE867;
	Wed, 14 Aug 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629649; cv=fail; b=NLT996jxjeV39y51rjgoH1mKLor2PvAwRccTZhisot622gwRDfLEQOYnrD5Yg62Vo1gWmVKpNbbF/9hPLZK4FYF86c8omDAyIlE4p69FlBHPCtGbdEkE4vw+713hWDlUFgFKkztluaW09qOGPDubqcJPImHge+Nzv469RTKstB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629649; c=relaxed/simple;
	bh=iFVf/JO0cA7dy2pJy5xqprBiLAxpbM/aLUBMknlopmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivxs5EwrjCQ4G9pQM/yl2gUc2yZcAkhC/DPpYhB9/4oywRiKeBah0+BxeN/7TOfTQTad/zhOo45jPp5uoUjeLORtMjaI+U3LlqMrUYke8S2MzIimbMeKTzRMhYuw19Fc7RD1Kk7/4J0sudejn2L8LFp+/irD96kkzvoThA8cXLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kPRVKJEt; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1GrMPy33CPkjxBra0DpmHnV0z/Eii+OBQE5eEW5a2/JWMi5DxYkoMCaCix7HzK5XmG4RM26sVcDjPtjKKx9IO9gu4dxeZZ30KH0z1nkJ3Mn6cSb2sahBo8TXbp9IPC+d6dMymX55+NdrVs2r1iaXgMsza6jCWEofhTjU0l568oDrXDCrHRVMv9aD6ebdDUWwpZUJALu7gB/WZr5ySBgdcsFbtOXq35j9ct44GT+XG2REJYGQ27aG7wjFRhciST5RQ+9EfSMGtEDbGWS4Ks7iSg3abe6q0Haou3+mz142y2H8QK68tK1V8M9DpyKf3Um/4RwP1ewoKOF635DAC/rTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFo1PztKPXFLoupSBTE9yk3PY7y5Hn3DRuA56sZiaf4=;
 b=l2PfxtZH3ZiYzRF43ylcE1BVyEnKPRPIgFbmnbZ4Tgwb1Py2eyPsuOvCB0K9lrrQlEzqzlhx1KDWifbd+61mwga090tpaGURMR+2b/dGqfBJzw2obJyCV7PrB0Nw3d7LkFMCs1BOiLNz+gIiZ5OSBZ9FmUZetx8EKp1JETqI3pPPFPjY9E3wPbRqNNI0cv94xAmIK9L8vnRP7HQVtDmmHt6YY8A3CiorG/jhTpWibFvhheHFp9SjGF05iKVq+xBxSGkhXr72pzdbWEs5siRZWJk3JEznTFOXV+AZRHrrjIGEwrJSVZ3Fo4GWcnwK2gXfNVgf5Ea0QGx7WPLvqQzexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFo1PztKPXFLoupSBTE9yk3PY7y5Hn3DRuA56sZiaf4=;
 b=kPRVKJEtxTZWt9wbVrP9Ng2ZCmiaQ3LPKdgyWbEoANdnwqOJyGVxrTt38/NrqbkvWMllD/G91KM78AGUZgzg491h7xlTBkki1gzuhE4vf5WBjn8ssMUDRL9w+0TWwSgZ+81VYrmOwsdDK4GyrT9idHrWqpe3G4jOV0DtVPO9Lew=
Received: from CH2PR18CA0036.namprd18.prod.outlook.com (2603:10b6:610:55::16)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:40 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::7c) by CH2PR18CA0036.outlook.office365.com
 (2603:10b6:610:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:40 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:37 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 6/8] misc: amd-sbi: Add support for MCA register protocol
Date: Wed, 14 Aug 2024 09:59:51 +0000
Message-ID: <20240814095954.2359863-7-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: e4409ccf-682c-46dd-0789-08dcbc47f425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhTWXE7sTQCBaZkjkNgWD2JIoPE9JsUnvJXAEAvF68ZRpJJPuidQrp+nmSbZ?=
 =?us-ascii?Q?IuJuynTylUrhFjnJooIKvnX0fkFKnjTF8RpjQ/oVWwOZcik+DhXFkImzgRTS?=
 =?us-ascii?Q?ZG+Ss32bYs4egN4/Q1xY1+GcpOmY24nHBWZ7SUri6h+Sleo6pce+spxFNVdq?=
 =?us-ascii?Q?5Z8XsFCQJHQ8R3ynTpTACX6WPoWjlfyEWaVAKlXg51CQtUQJDQbWkt3haZVV?=
 =?us-ascii?Q?AK4KMVfJU5/TH4G5S6iRvzemd1Kp8f/SVskE+5QgEpVRiVsAvFJMZcWZcMqy?=
 =?us-ascii?Q?6l8kfjgpfk81lBdcn7X9JUAiJ78NjzF6d7xn4pvmpgrNFoFTplkRGTW0jmsL?=
 =?us-ascii?Q?MGC6my/2iZfAehPCUY3LC7LwKm+slAquh6JdNcrGWC3uTli9xvB9nI2vBZCE?=
 =?us-ascii?Q?ZlaTlnpeZBn4mZJF7WfZnUGYDbEcnyUleFD4btMs+EToqkMzLUr5DPhIhmjv?=
 =?us-ascii?Q?n4Zj2Ub9PAI2TpqJ1T3sMFIK9H7Uo+tkf7whtCClko3SfjRlwJdF97sDxtnt?=
 =?us-ascii?Q?eML7S/AITA1G6SZnf86vyJrZIu9crT0T9EKCNTq98JdPqGosh9C3f5sfmGNZ?=
 =?us-ascii?Q?38ZLqKVRGlQY3BzLsF7C6zpMuW4vtkCIr7b5dN1ECs+HIFG7VHwmJDdf7rla?=
 =?us-ascii?Q?ffbbYJDh0qFJkxxLKH9IhW95OPhmTLQsScKikEK+csYGdfKlWasfiJ9R8kE6?=
 =?us-ascii?Q?+hKI8DjaFx5P0NF3Zsgefsj/w1ngwYYt4Kfk/YxZmJ+kbWQ37/qvwRMmM8yS?=
 =?us-ascii?Q?WpKAl8SXSC0ytHoGV/LQOoJjhd1MHl/eFsIbXmjxbNeJ4DIiYoLzC7zpq9Hf?=
 =?us-ascii?Q?1AvwLYX+sraue0zhGN4HiduxDsPDRSDUwZZfiCkCQymg9+5iW/UDrqTm4fHj?=
 =?us-ascii?Q?xVGi1fyyPAflz6QBlxPkcNIaTgLKxWY0Ti75RMRcFhDAvWN4/pQy7+I5PJso?=
 =?us-ascii?Q?gYCN7yZCBUO1PTPFT5W6eOTrrqTbpzPEpr3BNX5ecjr/vi47pEiNSxFYLuV+?=
 =?us-ascii?Q?p8Qqj8JS2rtOp1oGt+WY+pi1oeMKO8QiSqb+rTL0ONwAX28FPyZ76vvYhhy1?=
 =?us-ascii?Q?kj+TiJBlUOoMhmnSatp64xzQfGwKiNQZNnCjVsKiYPALurj2ebLP5FjwOZ2q?=
 =?us-ascii?Q?f3Ijv7/HwVJV2ld0vba/zYaH2s5SjNzUPd6A+tkQ0qwRT7d3GeFNy5xeJH5X?=
 =?us-ascii?Q?bFXapc+N2ZaGMCcq0U9PTsecNH3b4odMY/gWBXOm/pvq0xmpFOyj3VYUQVPs?=
 =?us-ascii?Q?MIlB/gbpE9D4usveFdsZl9Zg49IEC7RCQK3Tu4yPHG1ZHOCN+VDFrVRJM4ka?=
 =?us-ascii?Q?WDo2O9BRZJNyti1vU68ojdc2eMRFfkKoCSH8I0yHbJx2IhWXekLZ1dV4ptyZ?=
 =?us-ascii?Q?ylhGz5rhZOp5vYkKN8KtkqHsQA9zjavLPjvLOrKW+CEkiTOnzWwPu+T3Zeeu?=
 =?us-ascii?Q?KxF6bYr5LxjTSbJF8FoMNkDaRuZfsbCF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:40.3753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4409ccf-682c-46dd-0789-08dcbc47f425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

- AMD provides custom protocol to read Machine Check Architecture(MCA)
  registers over sideband. The inforamtion is accessed for range of MCA registers
  by passing register address and thread ID to the protocol.
  Access is read-only

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 90 +++++++++++++++++++++++++++++++++
 include/uapi/misc/amd-apml.h    | 17 ++++---
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index fdac6848ae9a..56fe09e1e54c 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -32,10 +32,16 @@
 #define CPUID_WR_DATA_LEN	0x8
 #define CPUID_RD_REG_LEN	0xa
 #define CPUID_WR_REG_LEN	0x9
+/* MSR */
+#define MSR_RD_REG_LEN		0xa
+#define MSR_WR_REG_LEN		0x8
+#define MSR_RD_DATA_LEN		0x8
+#define MSR_WR_DATA_LEN		0x7
 
 /* CPUID MSR Command Ids */
 #define CPUID_MCA_CMD	0x73
 #define RD_CPUID_CMD	0x91
+#define RD_MCA_CMD	0x86
 
 /* input for bulk write to CPUID protocol */
 struct cpu_msr_indata {
@@ -68,6 +74,13 @@ struct cpu_msr_outdata {
 	input.value =  func,						\
 	input.ext =  ext_func
 
+#define prepare_mca_msr_input_message(input, thread_id, data_in)	\
+	input.rd_len = MSR_RD_DATA_LEN,					\
+	input.wr_len = MSR_WR_DATA_LEN,					\
+	input.proto_cmd = RD_MCA_CMD,					\
+	input.thread = thread_id << 1,					\
+	input.value =  data_in
+
 /*
  * For Mailbox command software alert status bit is set by firmware
  * to indicate command completion
@@ -191,6 +204,79 @@ static int rmi_cpuid_read(struct sbrmi_data *data,
 	return ret;
 }
 
+/* MCA MSR protocol */
+static int rmi_mca_msr_read(struct sbrmi_data *data,
+			    struct apml_message *msg)
+{
+	struct cpu_msr_outdata output = {0};
+	struct cpu_msr_indata input = {0};
+	int ret, val = 0;
+	int hw_status;
+	u16 thread;
+
+	mutex_lock(&data->lock);
+	/* cache the rev value to identify if protocol is supported or not */
+	if (!data->rev) {
+		ret = sbrmi_get_rev(data);
+		if (ret < 0)
+			goto exit_unlock;
+	}
+	/* MCA MSR protocol for REV 0x10 is not supported*/
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
+	prepare_mca_msr_input_message(input, thread,
+				      msg->data_in.mb_in[AMD_SBI_RD_WR_DATA_INDEX]);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, MSR_WR_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = sbrmi_wait_status(data, &hw_status, HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_bulk_read(data->regmap, CPUID_MCA_CMD,
+			       &output, MSR_RD_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_write(data->regmap, SBRMI_STATUS,
+			   HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	if (output.num_bytes != MSR_RD_REG_LEN - 1) {
+		ret = -EMSGSIZE;
+		goto exit_unlock;
+	}
+	if (output.status) {
+		ret = -EPROTOTYPE;
+		msg->fw_ret_code = output.status;
+		goto exit_unlock;
+	}
+	msg->data_out.cpu_msr_out = output.value;
+
+exit_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct apml_message *msg)
 {
@@ -317,6 +403,10 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 	case APML_CPUID:
 		ret = rmi_cpuid_read(data, &msg);
 		break;
+	case APML_MCA_MSR:
+		/* MCAMSR protocol */
+		ret = rmi_mca_msr_read(data, &msg);
+		break;
 	default:
 		pr_err("Command:0x%x not recognized\n", msg.cmd);
 		break;
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
index 30bb6307993b..8d1fdf2a54f0 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -7,8 +7,11 @@
 
 #include <linux/types.h>
 
-/* command ID to identify CPUID protocol */
-#define APML_CPUID	0x1000
+enum apml_protocol {
+	APML_CPUID	= 0x1000,
+	APML_MCA_MSR,
+};
+
 /* These are byte indexes into data_in and data_out arrays */
 #define AMD_SBI_RD_WR_DATA_INDEX	0
 #define AMD_SBI_REG_OFF_INDEX		0
@@ -24,13 +27,14 @@ struct apml_message {
 	/* message ids:
 	 * Mailbox Messages:	0x0 ... 0x999
 	 * APML_CPUID:		0x1000
+	 * APML_MCA_MSR:	0x1001
 	 */
 	__u32 cmd;
 
 	/*
 	 * 8 bit data for reg read,
 	 * 32 bit data in case of mailbox,
-	 * up to 64 bit in case of cpuid
+	 * up to 64 bit in case of cpuid and mca msr
 	 */
 	union {
 		__u64 cpu_msr_out;
@@ -40,8 +44,9 @@ struct apml_message {
 
 	/*
 	 * [0]...[3] mailbox 32bit input
-	 *	     cpuid,
-	 * [4][5] cpuid: thread
+	 *	     cpuid & mca msr,
+	 * [4][5] cpuid & mca msr: thread
+	 * [4] rmi reg wr: value
 	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
 	 *	[7:0] -> bits [7:4] -> ext function &
 	 *	bit [0] read eax/ebx or ecx/edx
@@ -53,7 +58,7 @@ struct apml_message {
 		__u8 reg_in[8];
 	} data_in;
 	/*
-	 * Status code is returned in case of CPUID access
+	 * Status code is returned in case of CPUID/MCA access
 	 * Error code is returned in case of soft mailbox
 	 */
 	__u32 fw_ret_code;
-- 
2.44.0



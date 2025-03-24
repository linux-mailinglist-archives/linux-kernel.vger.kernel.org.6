Return-Path: <linux-kernel+bounces-573889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D0A6DD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9064D7A2C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404125F7B7;
	Mon, 24 Mar 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qlhxw1B9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4D261565;
	Mon, 24 Mar 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828356; cv=fail; b=FeNL0cLKmy0YyGdu57BBP+1J7SbA5vkV2qLoJp8gFDi15CcUqwWh5KF5RtcReGOgIQgSoBVBL6TLXoKhcsRi4bDOrvWJHSvP0nXnUeX/TXmjHF83DkDyKNo8RZMs80B9g+g4FJGZoDZRE3aTQD16fs2an1zUfz7vniaVfpJADuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828356; c=relaxed/simple;
	bh=7t6DGffWtPIxl3OXqyw7MZnHwJrAmItTMeDp1O4SpYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUFdju3JomPQjEu0NqT3Q6gUN6Onup/E+MvA183lRAaRPtkMdZlt11d+mPhnt4NKXAk48Dv6niw5rZU+6/7egh3T0Gt+sbDZMxZBYOjpCbsFtrB7qgU5cl0pPNmDO6fhaaBjsGsr3JEnv1+NCVW6FQX/OI5YzFTy8IG89GrN4bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qlhxw1B9; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu2E3tiKXR7dILeSIkwwrw3kpDWrgblK8bkOpDerdPMp05T4lDNymwGKMDyWOKagA6GMdpyVJ4b7G0I6YHlf0dPl77+oIAsg4O9zC/gptjCGg84pZfM9EJO6YJ4nXsOx4qgdFP1vKhuOvJJTQE1od3RCFTaXnq3LUkSqrId97IthI8DNSstus+Q8WRpJIcHvmv2f9PeyDviowwbsdGk5o2oyxtSi9+frLim+mwplWgeNNGC3qJxYTc3K/5Iv+lUasVI7v5UaLRzugiUjx2oIXL5PfKb9OND2dHoz5wFPJlcZ2KVR/xFwADntypanCi45Ov8oMSb7uCHcMa80tjRRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1QcAhst+Ep55BFSnsvc73JKPkoA4fYw+6yxUuMQDL8=;
 b=LLVtqFzifW1ZG7n2EjJLl4QmMlGf04TAUK02r1tb46EX3vbO6eoisTTSf+XP1SMG3TXO8IH9Y08nLjy+Fz2jQgnwYFQuXa6bzJbZWCraOWU2SZ0jib1ibkrria2Q/l+FMy4MfzC+UOCuhsZA9WUmm5qYOvgxYGgyJz2haO1XeSYntg7WyrktXKlyl1H5h5b8cxWQAF6gjW1HsT4Y8G0bC3sCp9zgVBCxu37csP/K4NFLR8UYq1PttqoJr6AfoCgnb3wW05BJHBLAq42RgLJkXbvgtOYLBUl6kqUftH5k3HjAAV0qitg0DRzdp76JFgTWjsTCoMp7pAcfcfuUnh9woA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1QcAhst+Ep55BFSnsvc73JKPkoA4fYw+6yxUuMQDL8=;
 b=Qlhxw1B9lGEqzxoG/qSI44oUp0QRY2rzksRszo+67acEosDSxNrKwnsOkAQ+aAWFuqDbxGOzN6FUDE8ukpdzJ6yid9MwsDp8GPsnW+KauwnFuy03kgAmEYji0Q3d9U7X9Q03YRomNSRy4nHY+UIrHIoDWGPVRe4VbwgwqTom6k0=
Received: from PH7P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::16)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:59:11 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::8e) by PH7P221CA0060.outlook.office365.com
 (2603:10b6:510:33c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:59:11 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:59:07 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 09/11] misc: amd-sbi: Add support for read MCA register protocol
Date: Mon, 24 Mar 2025 14:58:13 +0000
Message-ID: <20250324145815.1026314-10-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ac76e7-b23c-4776-1a11-08dd6ae46fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zi2nlq0zH+w+koSEUO1pOYhb+RZfemOliRUemh0WMp6DVMC2GxZJjQeqtz7D?=
 =?us-ascii?Q?5ifNeCv8ZJytIBXKZQm1g/zquf1qLBiT5TBDTAtj/jVNnjAQ5sBAtC3MI3Ku?=
 =?us-ascii?Q?avzIdP/AFpCzHHA1QDCsCDVfDA3kv0k1qoEDS5gTivt8nPSM8/YPd0IADnju?=
 =?us-ascii?Q?SRmTNusI0MhjJPh4YEpv189t1R3e8b04b2fSzCnChLlp1NEqBNAYsh34qfCO?=
 =?us-ascii?Q?KBU1nYzJMzwXhxyT0U7TXxsPzr9PTR3yJP07fBZ++lCS6BEIS6m8WT7mV/WZ?=
 =?us-ascii?Q?Oj0+r1OQ5ZiNKuAydhsrpALI3gI7gPjk6z3SKQ+XcEz8V+WdSlIUHGsaGm5B?=
 =?us-ascii?Q?VKuhuyU6rRP6vUJZSSyGz220Romgc7tW4YF/LrLL0SpF4rA1az9xkyAzRKVL?=
 =?us-ascii?Q?opE4kqQOcjww6x0pQP152ntpor1jAM3GQoijvt1J99CQ2QzjfzRuXIkV0ybL?=
 =?us-ascii?Q?NwptnSPBmbXhaE4x3sH23wGS2bXFg+egLXPLzBmVAhY2MIGu4aD5fydrAmAU?=
 =?us-ascii?Q?aNDFU5OxbD/ZsowChoAiiFWszV+Pdy4arGO6E7v0Bs2zIBi4fxrlOjq+mtP/?=
 =?us-ascii?Q?BDBCv3PpIMz0v3TATFM2+fxxTNzftlPp7z4MA5cdp4cubzPmY8BGMrQn2F+4?=
 =?us-ascii?Q?4vpdK2XQSDYV8qFkGlAQTMEHScGHOW6nsY1fVb+MBZRtWBHAmUluIKr4D5j1?=
 =?us-ascii?Q?bML8s3AQgF8/CCm7TU/sIIJYu11jRW6LuQO1e5zRXY5a4f+ZxIZnfTkj9DXO?=
 =?us-ascii?Q?0y4yCYmGY9owOIo+lCUcKFRTgywCHjTpMvGBuDAPs0NoNC8NEJuVJbLq4KT+?=
 =?us-ascii?Q?3IqWiBWxo70ooa702mITkr8j323iKmdN89y9aR13Oklb+C7x2D6TyfPj+aRz?=
 =?us-ascii?Q?VXLVSPxg4rmB0uI94e0ROkMwX4hb5GkxZ9pyJhjQuQ1Kh8VW1bNIFF7S+XJz?=
 =?us-ascii?Q?W8joIIAAzM1MKT6JOD+0GQpTBYlYZV1chwRS7+b7FzCOGMVCI/WS6PQTVSV/?=
 =?us-ascii?Q?rpYDTLaCDos8MX394FKQa1HWSTRAl8KaP1NpUV8vj1e+OZDcIGdATbjahcTY?=
 =?us-ascii?Q?Ztxx/ZY02JBKeFCWSXL6JO9H3eBFQUpghjSOgOAyZPs9yoAp5SpnexutKhhP?=
 =?us-ascii?Q?cUYe71O5Di45lJ9ouDDxClwzEDdXfdZOWJYnm3q0xIu7gxtH/FB9KFJNo5oR?=
 =?us-ascii?Q?Fe7tbwnrrxHJWaG8qPz65nXbE8aB1SnajZes4d60COLlYmy1a/a/kZBP3gEf?=
 =?us-ascii?Q?W7uwip2/mS+VhpnejA+/jnS/RbzYOKwBWgHT+do/70xQrwiiXM8eC8vWGjBx?=
 =?us-ascii?Q?mPFz/kYRRDPvdHYjI6AXVsQFAXT4NmQNZSPZq7r8Ii3aI7o8pCxgXwCiALyz?=
 =?us-ascii?Q?X2+VPsasf/sqnG46BUail2D4qIDkKNjt5IHYAkp9PntOvEizBxY0Eog4zs8d?=
 =?us-ascii?Q?mQj0UiTK1bfW7JL/6MbaOy5w1hltl+cZvgT7KhoG19szrCR00EYa+pYfGa+8?=
 =?us-ascii?Q?AjldLG7+JvnXPZY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:59:11.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ac76e7-b23c-4776-1a11-08dd6ae46fb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

- AMD provides custom protocol to read Machine Check Architecture(MCA)
  registers over sideband. The information is accessed for range of
  MCA registers by passing register address and thread ID to the protocol.
  MCA register read command using the register address to access
  Core::X86::Msr::MCG_CAP which determines the number of MCA banks.
  Access is read-only

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v5:
- Patch rebased

Changes since v4:
- Previously patch 7
- Address review comment for documentation warning

Changes since v3:
- Address review comments:
  - update the #define to inline function
  - pack the union inside the structure

Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 100 ++++++++++++++++++++++++++++++++
 include/uapi/misc/amd-apml.h    |  18 ++++--
 2 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 1be45b26fa39..89fa6da453a7 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -30,10 +30,16 @@
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
@@ -70,6 +76,16 @@ static inline void prepare_cpuid_input_message(struct cpu_msr_indata *input,
 	input->ext		= ext_func;
 }
 
+static inline void prepare_mca_msr_input_message(struct cpu_msr_indata *input,
+						 u8 thread_id, u32 data_in)
+{
+	input->rd_len		= MSR_RD_DATA_LEN;
+	input->wr_len		= MSR_WR_DATA_LEN;
+	input->proto_cmd	= RD_MCA_CMD;
+	input->thread		= thread_id << 1;
+	input->value		= data_in;
+}
+
 static int sbrmi_get_rev(struct sbrmi_data *data)
 {
 	struct apml_message msg = { 0 };
@@ -167,6 +183,86 @@ static int rmi_cpuid_read(struct sbrmi_data *data,
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
+	prepare_mca_msr_input_message(&input, thread,
+				      msg->data_in.mb_in[AMD_SBI_RD_WR_DATA_INDEX]);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, MSR_WR_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	/*
+	 * For RMI Rev 0x20, new h/w status bit is introduced. which is used
+	 * by firmware to indicate completion of commands (0x71, 0x72, 0x73).
+	 * wait for the status bit to be set by the hardware before
+	 * reading the data out.
+	 */
+	ret = regmap_read_poll_timeout(data->regmap, SBRMI_STATUS, hw_status,
+				       hw_status & HW_ALERT_MASK, 500, 2000000);
+	if (ret)
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
@@ -285,6 +381,10 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 	case APML_CPUID:
 		ret = rmi_cpuid_read(data, &msg);
 		break;
+	case APML_MCA_MSR:
+		/* MCAMSR protocol */
+		ret = rmi_mca_msr_read(data, &msg);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
index a731f9301d06..efbdc7276e6b 100644
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
@@ -23,8 +26,9 @@
 struct apml_message {
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
@@ -38,7 +42,7 @@ struct apml_message {
 	/*
 	 * 8 bit data for reg read,
 	 * 32 bit data in case of mailbox,
-	 * up to 64 bit in case of cpuid
+	 * up to 64 bit in case of cpuid and mca msr
 	 */
 	union {
 		__u64 cpu_msr_out;
@@ -48,10 +52,11 @@ struct apml_message {
 	/* message ids:
 	 * Mailbox Messages:	0x0 ... 0x999
 	 * APML_CPUID:		0x1000
+	 * APML_MCA_MSR:	0x1001
 	 */
 	__u32 cmd;
 	/*
-	 * Status code is returned in case of CPUID access
+	 * Status code is returned in case of CPUID/MCA access
 	 * Error code is returned in case of soft mailbox
 	 */
 	__u32 fw_ret_code;
@@ -77,6 +82,7 @@ struct apml_message {
  * The APML RMI module checks whether the cmd is
  * - Mailbox message read/write(0x0~0x999)
  * - CPUID read(0x1000)
+ * - MCAMSR read(0x1001)
  * - returning "-EFAULT" if none of the above
  * "-EPROTOTYPE" error is returned to provide additional error details
  */
-- 
2.25.1



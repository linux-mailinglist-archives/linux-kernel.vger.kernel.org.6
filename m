Return-Path: <linux-kernel+bounces-541479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F888A4BD4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79A018936B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A11F561B;
	Mon,  3 Mar 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KxdVfa/0"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB21E991A;
	Mon,  3 Mar 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999613; cv=fail; b=sVrovgBKBtJpaXcyabPzF+UnWmrI1E/1xCUXJqo8bsaNmBmIBWHdbd7kipgisaa7RVRaxxomMU+3aEBZLRgt9CI39j4srFKNIqMgcO25ETVOdmm4JKwWxpVvhcv6uhO0xqh43XWoJ9qLstmfmhuXwNyp1mPn9VeBBQKhu2idec0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999613; c=relaxed/simple;
	bh=7AYevgm/dk0FY3evDjkmxRve/nPzE3jjDYRHUDalSQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G92Bd0fOIJmlwbjtl2uVYrO9ydZvX/i//4asiRxPNVRRPh48l7fV7s/UONN59D/KIm5Z5fUPB8lr8SwQz/ktBrh/9DDelH9Eo5ePbcB/N0Yr/H7dUMMK0q8UKcYdvAlhYAfog0UvL/GpNa/AZiJr12nAT/S70l4hfjaS0yoAHDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KxdVfa/0; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh0wE6B2hPz+CncnzdMwH1u7azP+T7TizMhiqUnIdXyOfALN74hyEbCTVrtu2NshZyolZTTQPMwjLl0itbWxgSFg3di8fSHYgUWC9t/4lfaAwF1A5+RI6sJBMNNnb4g5rEw9canOAb5MkxOMLTyHiV46l6h+w7lamkWQM1vJL+ZP4kq5Jl4jSXu3p/X8/8MzOGfYazT87VY8QDHQnD4MugXZyrnJ+PrfgMJeZ1taGInRARRvxj2DMdR0xMzAhwGJQZ49ltmfXjWTcnV2Z5EpIu4kAHA5Z4sIMdHNBgjnHh2dBCukl0pMSXyer9WnqvfYq0DdLbIarQgAPjqyNNr5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGMoeu14lEt8msC9YkjZnWB4zDinMCue4dnI2muRl0g=;
 b=QhT1zxgtY6q8Hr+/3xjeTgnvIfPbZy2PdWNleIDusV1jt8p+dwz3oIoUUoyaKWoeyrSg0REpyIQ3TXOLFj6gM8ZnN86ZhRlmSbNhtY4F9hg8KLMYnLMkEYIKlOgBsNb2I6W+A3965VvXwGVFvj0izMoAljxqWq4iLFcf45bANnZ00JEmVz4xa5Ay12XiKIAWGcnyCDP/FeeAFQi1w136GQlD3wGYFQX/Lc+l9y+t6T2ZWK02n3mln5QwZjI0OtrJI4IG5AXSgPA5Y9vEY1jXwz219ONNjB8MqyV6CrWHHgiYAJmtEC1znFK6jf3Lefm5nkA4ys+8rtosho7R4lkPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGMoeu14lEt8msC9YkjZnWB4zDinMCue4dnI2muRl0g=;
 b=KxdVfa/0FxId++72gTPi6moVmpW1s1kcv2KPbxxWvSmvAK/4thJgPuyIzBxnZo3OCEAz/qGl8pkiTTIMUNZ/mtMSdLb+gV4YZnq2en76T8NkNhjV+CcPWx8phOOPGCzbcTbk+VKHdRzCWE8Y2PNcdouGh+A9rJQLk8kMaXOIX8A=
Received: from SA1PR05CA0017.namprd05.prod.outlook.com (2603:10b6:806:2d2::20)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 11:00:02 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::7) by SA1PR05CA0017.outlook.office365.com
 (2603:10b6:806:2d2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.13 via Frontend Transport; Mon,
 3 Mar 2025 11:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 11:00:02 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:55 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 09/11] misc: amd-sbi: Add support for read MCA register protocol
Date: Mon, 3 Mar 2025 10:59:00 +0000
Message-ID: <20250303105902.215009-10-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105902.215009-1-akshay.gupta@amd.com>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4744807a-ea41-4a9f-807f-08dd5a428c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yD8EaVLkQp+mzDjiTshh+Jp6gixV3iCFzLHYroC/+h3yKuAa/GMmUzOCzB6o?=
 =?us-ascii?Q?hhivhPiMYU9nC4uBuyeG919jErenSEIQ0l+FpzBda2qybiCt6WaNo24iW5Mo?=
 =?us-ascii?Q?w9SfxO+INE0xGQJ/Tuf+jaQ3qNxJTIUgxRu+/ZuCQbHMDpnLQ0IRwRYGb2c3?=
 =?us-ascii?Q?h4Y2PswL3bBCfFWNS91VXFQyaYmksEbKnIGd3i8hUcfh8Hd7j9Ces5qPZzZS?=
 =?us-ascii?Q?yk2HCusW+nZpP5DZ3nuBWGcR0uaO++3FFHhfIyRtaqYSkeJEvYmiwzVuTaPU?=
 =?us-ascii?Q?3LKNKh52tiPm5cZnh4RghPhLmwsXz/vapwrjryKXFSlPWfIPbq7LtCzvA8y9?=
 =?us-ascii?Q?jdPyuM8x+7ywjqBJvpv4H4idLrlENCZ0kKd58dV8aX8ff4LR4WkavVpVMCQl?=
 =?us-ascii?Q?7jHdKop7Xi4UEkawE3s8/3QyNAbBWPt0qC23ryl71AWA5GYLU71xlwu88V0M?=
 =?us-ascii?Q?frv7yc8k2PR0MpNvLvvDib3KEwf34bWP4wrPBkPprEd3xmqtW5l8rOX9DpHD?=
 =?us-ascii?Q?nGc6HZrRVZeSt2UU6IVLd0WCM2m0Bn/3PllbhbDIGKZmaqsw4Z0EbPW7D8R7?=
 =?us-ascii?Q?iq4wv3wQTzVzk/z3yU3jS3vvQfDTNL1Kmwhyt3IAYS/WdrPakhqaJ4EgKplb?=
 =?us-ascii?Q?fMwF+R6s6OWGdISzQnqiRkwasMoY0SC4kCchPuXNySFf3SRZz2RAg1DCx1JI?=
 =?us-ascii?Q?eTptdwFIEy4tYut3F3Njo5ywU5VJ56v+tv1xSzRAWRXgBBF/6RouyczNAr2P?=
 =?us-ascii?Q?xxaczS5tNErMAyAAZs1mOpPEVWxribZ8XHlSKa1nSvKoNreBbKPDeqMyVfNA?=
 =?us-ascii?Q?lI97FPfrPx0CAgx9xGA16Ty3RLcwReTHNB02tMFGvpaMXZLT1fx5crwjtr2a?=
 =?us-ascii?Q?69DJmYhFH9sktDVDt5gHq43CuZ1C8/j8lc+tgE2IXOw5dF0vWb4YSq//7R1i?=
 =?us-ascii?Q?iYUa131uQax7DkDy+8rOo3d7HLdAvwScUYCvoA1jg0gSUPyW4E3EKY8FHp9q?=
 =?us-ascii?Q?LW0J7HFK+Pb7bD6cceJgmSgyPTRRK+hMSUYaVRSeAhzfQmYGnjPyASM9upZF?=
 =?us-ascii?Q?7Pfb6/BxosF3yHIzTZuDhduJrKMI1iNAEbgyKc+jt9Mwr1kaRV7D+9eNsZtD?=
 =?us-ascii?Q?M6IBmynnjRgWXceZy7BpznzbxFYOenKPdrKm43pktKSK6Izjr8dXpTW7nEsq?=
 =?us-ascii?Q?QMEwmLjXvG/ubuXjRpkV2iqYVKlQxgbsBcfvkJZZEoQDqvKZ4Vr5ftVp1bM/?=
 =?us-ascii?Q?E2N/3QZUqd7GiLgv3hpyacSgrDhzF7ST1Yd24zy+S19fND+HMuJPJE6Sifjz?=
 =?us-ascii?Q?NaaigLJQJSPMz3E+avcPtMOe0gU51ozDbooaEiE/u0wf+Dyq2jHrsvb1t7g9?=
 =?us-ascii?Q?GiLcDg76ttTstUHyigtVWQr63k+oTTdBk+rWagDLdfAi3ryJDqzKAWaB3MEw?=
 =?us-ascii?Q?cfzzsRt12wIPaQRWjpIT7MqZxfFkKQga3gYP22CfeITbkiTrEtsEDI0DRozo?=
 =?us-ascii?Q?tfdbEPOCeQqZCMA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:00:02.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4744807a-ea41-4a9f-807f-08dd5a428c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

- AMD provides custom protocol to read Machine Check Architecture(MCA)
  registers over sideband. The information is accessed for range of
  MCA registers by passing register address and thread ID to the protocol.
  MCA register read command using the register address to access
  Core::X86::Msr::MCG_CAP which determines the number of MCA banks.
  Access is read-only

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
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
index 6fd6e8e579d5..662aa90980fc 100644
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
@@ -282,6 +378,10 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
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
index 847a83770ab0..0a841809ca84 100644
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
@@ -79,6 +84,7 @@ struct apml_message {
  * The APML RMI module checks whether the cmd is
  * - Mailbox message read/write(0x0~0x999)
  * - CPUID read(0x1000)
+ * - MCAMSR read(0x1001)
  * - returning "-EFAULT" if none of the above
  * "-EPROTOTYPE" error is returned to provide additional error details
  */
-- 
2.25.1



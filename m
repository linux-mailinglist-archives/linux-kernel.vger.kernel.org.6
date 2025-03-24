Return-Path: <linux-kernel+bounces-573888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48CCA6DDA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ECD172342
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F111F2620FB;
	Mon, 24 Mar 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YKw89Z2Q"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E82620DF;
	Mon, 24 Mar 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828351; cv=fail; b=dHzxyl4e+JvXvnMoUA4koq7nYE8sWoXyMm4lComm+DRtylbDhkxQhGNpo90Hf79EVfeBpXb/Xrh6dXewq4moyH3MObwe415RS7OkekCk3OqzWWwT5hNUG0LtuqQdkZBi4pakT0xjtFljxZ7V00X+uTr9Ycl/c8lFXPguTxxrLkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828351; c=relaxed/simple;
	bh=Dqvt2sE585sc8DJx2skgsUaefcg8USXC5BMBcDxgrZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOccNQ9YVbxnaKtABo61UdtPVIuAGtMELeVAYoDOyFJihAoyB2eN4sZlYY+R558fXa+KnTUfcrGggj6o6M/qBn5DRKkU/WE+N3wZ1mF7EcCbc0TscIIGyxE/1sx1MmvMHHldiCi0v5qbYL92ir1iCufQ7+oOkukwn0S8n5oxe2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YKw89Z2Q; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj/TDxjcudAn3odoGyQ3hhVoKZKNaY5ErA5OAZ8aVSrSBeFaD4b93QfnDOqK0kPOjWMu9aXM/Lb39w8PJvjdRTRS6UchgsaozkCbw0RUj9P24k+Le03Z1xCrs2iioagbcywklijydwqdxbtdVuG8/+OonmSwgZI+lhK1UbPHfSO4pCpyXoyzKNIzZGUhfv/lWztEN5klfgOl4CGzQYf3VuSIwrngAACXHcjSUfLcc87r+JMACUQ7oV+8ZPUPT+PMFpelZR2SIn4ulBcptFkbKiaXRUZU04x4aWUt2NMajqFs6nam4C2BLet0QLe5ZPAc7prVBc2ddCWzYdT6LmdkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk6egc3SVJOwkoZrAv2SeModOT99f4U1Z/LASGryyq0=;
 b=k3IKHDTFwVwhgHJdTeH6ZRfCWUeTITHb6P5WONPHh1xCvDpu4Jp7cPBwIoFvlWEsU8dSzk1C4heSTVQcZm5Q5e6KOKXR2zX83DrhY8X6NSNN8390Z2xCL80Xw0gX/tocbT1w+jqQjQfPWLDcKY/CS41/WjuJvR9+Tw9hMGCN67FoIyFOMy0nhVIIiUcuQiStNnr/R+SuexIab361yf0h2ELXYdRJ63BzgIeKC0IX2wHMBbV7roip9tF5sISP88RkfMVUUjfUXQdLYhqOz2e/K1FC49nQIWOVM0p3neXIGRf+r9ht69KFf1yWOJ6hCj4NBDce58kLOIb/4mI9VOc1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk6egc3SVJOwkoZrAv2SeModOT99f4U1Z/LASGryyq0=;
 b=YKw89Z2QIPtPfI+Yjo1ADSiJdQbIVFnAicD+C5SriwODKI+8Dq7FK2oZU/JQR3Ndz2WF6Vq8D9f+w4dDeRityVCqyht05qLZIgCle698AnrH8Lhjz6Cx+CcmoFoY0trKa7I3jR5GlxtGZeQX56BGGpt/HJgi/Beq+R/IOb2ffw4=
Received: from BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:59:07 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::65) by BYAPR07CA0030.outlook.office365.com
 (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Mon,
 24 Mar 2025 14:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:59:06 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:59:03 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 08/11] misc: amd-sbi: Add support for CPUID protocol
Date: Mon, 24 Mar 2025 14:58:12 +0000
Message-ID: <20250324145815.1026314-9-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d6ecec-3999-4450-990c-08dd6ae46cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HNbH50BBZxL15Ng+EIVodcddWMs4tNasX95fqHFQLM6yHrXnBAo8wmWvRvpz?=
 =?us-ascii?Q?6OQm8fZFyevgCMM4orDVruuJzcAjmrSD/Wg5XWVLFO5m46GEdNh0YJ5gCpLB?=
 =?us-ascii?Q?TB5XVr8Y9hs1x96+BwatjkXwrH44AGLsoQqEAq2LlC2kMfG1WaLShGt9Yyxz?=
 =?us-ascii?Q?a/y8KSVm+GCTBJyYxbZ2SpjS4e2okiw+Sfp+y3qJucqURm15w2vn4MhetAB/?=
 =?us-ascii?Q?jUFyKQpW0OA3lvRMe5KJyWswlIrwo04H6b3SIGanW615QbHwJJzVULFfmzx7?=
 =?us-ascii?Q?1x4LYjUW47W9aIwwO8VtkHkkq3U284s6P5xw49V1TP7YKRzq/qNWnJscY9md?=
 =?us-ascii?Q?RG+j76zKqQSPCJKx0ERaZJhYTS5PoW7ZgETSH9zQbCWZajxx8fN9WEkLpgzJ?=
 =?us-ascii?Q?c2zn2A7L6pyNbjAXp95OFzZE/OZLVszk0/WKHp18vxiB7jzfu2clrF55p/HK?=
 =?us-ascii?Q?Kl9CpiLecu++wHfxy5925fYOr2caB2qJaIDs25wZeliVvThw216jZmS4qPyU?=
 =?us-ascii?Q?8rKfO21FWVksvK3gst7t+r1BUEiXWfMCmPOw6d+MqklWoafCHYqtYoPtggJc?=
 =?us-ascii?Q?g2Yu60gFn8BDxLdHWc+v3+8qlXY1O96vpjGIOkD8LBE0eDXKaDtPCbTKfe2N?=
 =?us-ascii?Q?0Q+KUWzAp4d42QmafBG2w9a/ulsrHovBRrMkhndOq3kgMmIJfErL23zCssUK?=
 =?us-ascii?Q?pyG/Rvj3kAxSLM1rS+7GyqFhVO3OTYiXYIJKf6w8xRGQhXI+wjUV7YQa1JCG?=
 =?us-ascii?Q?aUkSXBxp3XNSIIHVSGLTYkNBH0RQV5EOpyZJdK+k/Wr+QOm9BPdyHLb5fN5c?=
 =?us-ascii?Q?jS6Kgst27Y+ZBWhDeoWh8X3Yxojd8ZzITTPoY7nCv2evGXHPPP+0CSda1GrA?=
 =?us-ascii?Q?ONfkgfIdASBgGECtLtOTnAOLf5azeuU+/8Cn8S8oc6RbX/ZE+sNRA4Js3Ssp?=
 =?us-ascii?Q?kYbRcxgW/+iVqoMGDmnMuMzA+5uxFjCGLTLLrpTTZRCc8YzL7z5GGmmCvdwD?=
 =?us-ascii?Q?BzkEvk5tHJ6mdXP2mNDA4bPM0wmhr/O1JHKwkbUGwJC/G9D7szsUhZS6furb?=
 =?us-ascii?Q?1Umjs6YUe9jzpaEya+IclPV0NsR7XelJeHh4ccMh7KGSLyuHUyjwlZc+cZFr?=
 =?us-ascii?Q?XwidHdNpHLILLi14PRZObjp3Yg5/T5ShFFXuVPprgHVv4oPCeSqP1pyf9sky?=
 =?us-ascii?Q?AKJbLiZ5d2/s/9bfxdDwpv+WeeT6sIK0NynHXogUMirxIXtE2cgAHl/gS1t6?=
 =?us-ascii?Q?bMchIghgYc/pefxy/BOLKuEK4iZQfx8xw+T3NYU5pYgYo39VX0e07nJwsUqR?=
 =?us-ascii?Q?hv+gXILnHQSiW7oahiu6hFfG+tM857B9g/6nf2aCqBXLXqMtOdIXzBfel6Bj?=
 =?us-ascii?Q?nZCUR0YFgKSQKJ2S3d8u8MZ0sEv8WgLyjrRfxdLWTk9V2bDirTtYauiHrbss?=
 =?us-ascii?Q?wefEEhGVUmOg7uyVrBROUn8j1ajAPbudFeh4SGseaPgOU25yYVNrJitSEF1g?=
 =?us-ascii?Q?Ww2uhtCyCYhE4+8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:59:06.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d6ecec-3999-4450-990c-08dd6ae46cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342

- AMD provides custom protocol to read Processor feature
  capabilities and configuration information through side band.
  The information is accessed by providing CPUID Function,
  extended function and thread ID to the protocol.
  Undefined function returns 0.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v5:
- Patch rebased

Changes since v4:
- Previously patch 6
- Address review comments

Changes since v3:
- Address review comments:
  - update the #define to inline function
  - pack the union inside the structure

Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 148 ++++++++++++++++++++++++++++++++
 drivers/misc/amd-sbi/rmi-core.h |   5 +-
 include/uapi/misc/amd-apml.h    |  16 ++++
 3 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 332cb03e8326..1be45b26fa39 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -17,11 +17,156 @@
 
 /* Mask for Status Register bit[1] */
 #define SW_ALERT_MASK	0x2
+/* Mask to check H/W Alert status bit */
+#define HW_ALERT_MASK	0x80
 
 /* Software Interrupt for triggering */
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
+	} __packed;
+	u8 ext; /* extended function */
+};
+
+/* output for bulk read from CPUID protocol */
+struct cpu_msr_outdata {
+	u8 num_bytes;	/* number of bytes return */
+	u8 status;	/* Protocol status code */
+	union {
+		u64 value;
+		u8 reg_data[8];
+	} __packed;
+};
+
+static inline void prepare_cpuid_input_message(struct cpu_msr_indata *input,
+					       u8 thread_id, u32 func,
+					       u8 ext_func)
+{
+	input->rd_len		= CPUID_RD_DATA_LEN;
+	input->wr_len		= CPUID_WR_DATA_LEN;
+	input->proto_cmd	= RD_CPUID_CMD;
+	input->thread		= thread_id << 1;
+	input->value		= func;
+	input->ext		= ext_func;
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
+	prepare_cpuid_input_message(&input, thread,
+				    msg->data_in.mb_in[AMD_SBI_RD_WR_DATA_INDEX],
+				    msg->data_in.reg_in[AMD_SBI_EXT_FUNC_INDEX]);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, CPUID_WR_REG_LEN);
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
@@ -137,6 +282,9 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		/* Mailbox protocol */
 		ret = rmi_mailbox_xfer(data, &msg);
 		break;
+	case APML_CPUID:
+		ret = rmi_cpuid_read(data, &msg);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-core.h
index e3a11575d19e..3f2c1c6b22d4 100644
--- a/drivers/misc/amd-sbi/rmi-core.h
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -15,7 +15,8 @@
 
 /* SB-RMI registers */
 enum sbrmi_reg {
-	SBRMI_CTRL		= 0x01,
+	SBRMI_REV,
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
index d0c548e34150..a731f9301d06 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -7,36 +7,51 @@
 
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
 	 * 8 bit data for reg read,
 	 * 32 bit data in case of mailbox,
+	 * up to 64 bit in case of cpuid
 	 */
 	union {
+		__u64 cpu_msr_out;
 		__u32 mb_out[2];
 		__u8 reg_out[8];
 	} data_out;
 	/* message ids:
 	 * Mailbox Messages:	0x0 ... 0x999
+	 * APML_CPUID:		0x1000
 	 */
 	__u32 cmd;
 	/*
+	 * Status code is returned in case of CPUID access
 	 * Error code is returned in case of soft mailbox
 	 */
 	__u32 fw_ret_code;
@@ -61,6 +76,7 @@ struct apml_message {
  * The IOCTL provides userspace access to AMD sideband protocols
  * The APML RMI module checks whether the cmd is
  * - Mailbox message read/write(0x0~0x999)
+ * - CPUID read(0x1000)
  * - returning "-EFAULT" if none of the above
  * "-EPROTOTYPE" error is returned to provide additional error details
  */
-- 
2.25.1



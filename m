Return-Path: <linux-kernel+bounces-541477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B93A4BD48
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2DB1889E0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227AF1F5616;
	Mon,  3 Mar 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vzsD1VO0"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D71F543F;
	Mon,  3 Mar 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999603; cv=fail; b=N3Zgc8udVV8rVT68Iqa1MbeqR5uUMC7ELnpUo0Jh8JERqGbn6QCAqH07cTUEQoHIqGKko+39WMR6WDNLqONtAlSy2ttHQZ7jw1Cv0ea2p1D4yoRryORKYowLDZaX5y27RRDENNbeL1v8IcDND9xRNok4+D3o5ShRrdbwuGpDMtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999603; c=relaxed/simple;
	bh=sB6An38OMDyB404NMh9FVaYmbgXY4y4VmMg07BTI1+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0mSEsJJ6VX1YfQ/iGZ9g/mSHixZ1naNDOyXQNYeV6b2Akq+Moijr1R2H5KQLkzQ+tF0DlXcCqCGw2wVrvVJoDn/azUdS+Q54VUJ40181yVcHiceeB1ok2JxCnbEYrrCy4WTvjctD1RY5tKnI3ud4QDwws/JcU9TUiOAxKdvQQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzsD1VO0; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGUB4L4uSHiG7zNuHGTz5KMX1UwjwYdynnWbBNtqtxwwuurGr5QztlAtegDG7k4AaRu8Rf2BNa5V0VU0yB4Dn+yizWLx07r74N7FFwe14BYj8++tjqEy9IogEDi7adERcvORJiAQxpAqzdLfqvsugyyDZcLihVy2997/8IvmHBLu1VFnR009oNkYYEABz9ac3nvgCL2AJnIdH+8W9q0zP/suYsEUDa7asXawh3AA/LNcPwD/XsKYJKuyqxOO95rwCHbIvJiSHWf197qx+7meW6kb2hucegflSln748DLWZeipk0a1wvvUn/4g5v63a7Y9fPerRaVMyQFOfbn14LP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCTIFzxNOO2ssRJ+aV6RGLBNVh3/1ooq1UKFB+UgyFE=;
 b=O5mXeeTZ93hJ8IkDM67rUHPXZcNwFrydqhBoJECxrtGAhXrJE+J7yXoDOjUkDP3PJqvTAyCrAGlYKuRLeZppufqGTbZB/b91AyKPryLYBknHqqfE6Kp+URQoT4hZcmYAoKbZg8e0pIha05iOnHos+I9As77bwQngLBOVodDA9a+U6GGccb/sJukqMN2HD6qG/MQex4zYx/JMJx10G/lzyQwcySl2YLZH5NPRfCpmVqBZ3K74pLS9vphoW6QpSJBXm8HA5OetcerbbNkSZbqk5pXyJbcM0h0FCBnPQykBU9f9Pi7eVOyJYNoOMCqVWSky1bIBrXmcwQ12U+XkTjcLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCTIFzxNOO2ssRJ+aV6RGLBNVh3/1ooq1UKFB+UgyFE=;
 b=vzsD1VO0aDorgC6rOqotbev2d4YdHbk8VVhNceG+S09YnQ/3bmsfsZzGpKOnWZ06kjymOTAwXzw6qNHvP7kQBn4tEB0mQTadyAOk0J2nMIhuuFufbDYAuTGuCVpNciGz6DJhdlLkeKjoOiKr4sTyB8h67Ah+lAYkv/BEqp2Vyqk=
Received: from SA9P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::23)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:59:55 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::9a) by SA9P223CA0018.outlook.office365.com
 (2603:10b6:806:26::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.26 via Frontend Transport; Mon,
 3 Mar 2025 10:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:55 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:52 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 08/11] misc: amd-sbi: Add support for CPUID protocol
Date: Mon, 3 Mar 2025 10:58:59 +0000
Message-ID: <20250303105902.215009-9-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f910d6b-662d-4d15-119b-08dd5a428831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vMpB9rc6LXvjj1dlEcfqGIojyqetUDCe5BKk2L6kHTE0w4AucJ72+KiVt3wS?=
 =?us-ascii?Q?ZKXFP2fr870b3xzw6gRMEWI32LgVNogke7nd6Lvbi051LR9hpLSK/c8PRPfW?=
 =?us-ascii?Q?ANhzKcxTKJxKm2LrURozxM1KIh+aCyoEqZf4zJ1hDnvEejtjaII2O8gx+896?=
 =?us-ascii?Q?kEAK0HRh/YTC2Dy656WmxqLxq7haaUEYQ5fVWsUz+vidwfDcv3AKRzvewS2O?=
 =?us-ascii?Q?5AXBTTQUPu7vQZsvhYYu07Gh//sL6EaHar10lAngjxhbWEFn0Db1iO7PoSGA?=
 =?us-ascii?Q?T4G7iK6K3yhblj+SUT/y78hvAMORmIKrhrZpKHlb2mDoehFTYkpTooLkpQnS?=
 =?us-ascii?Q?ayOHm1IqVWWh4Gbty4RveCngWC0F9kh58atzg5ppafrOIlYvK3wRJwfjltgX?=
 =?us-ascii?Q?h6jZLmdzoydWDCj98hzPMcNkOcZQY2YrpgUwvREerLuqvx40AfEivYotUdTg?=
 =?us-ascii?Q?+wRPgA3f/ZrJPGopO7s11oaCgq81i54n00roasV5akIiuPPx2itg8yQnLqOr?=
 =?us-ascii?Q?Me+4uN6dl9H2pXI8CYXJUZVKxvpCqZ3LOQRKT3tbeGc9FpOGDDQFzLk4HOeJ?=
 =?us-ascii?Q?xTvIqgnpWSJskcesfJg68VtV10GfjXP4v2xzbsQkskztp3x2njod/qhI/iO4?=
 =?us-ascii?Q?Gq91VYQHlTlWckQ5uwcjyJ0Y5c0vom/BL23Spvy01EIon7u2veOgHSq17yap?=
 =?us-ascii?Q?cZ5l+ziz/nIzTnDv0uFW/gbrkXyj1XzHq/x6yfsVFOvp5hXBSsLaLo/iKHWO?=
 =?us-ascii?Q?BCXOMoDLMdbtdYrct1E7pqr1N4qg3128hAQ6ZnBhAxA4Xk2RZ9j2IShxAl8d?=
 =?us-ascii?Q?VJMrKuwowW1vfYFMJTsk3sLeinJTffZ+V8unVfhQ5sLJi8HsR3rTVmX07BX9?=
 =?us-ascii?Q?2u17GZ7xFmb0WJbijmB+HGml3dQezVczfk07+dZhjMdDWXd/CgAL9nIQU898?=
 =?us-ascii?Q?5harrHTKPzTb68+eOsIQkhgWpp2MEtRnKD4QD5FyXGhVErXWvtH7BY6xXq6l?=
 =?us-ascii?Q?jw6z23srPm0HZZiv80sPj14VWz9ExHEevP6kufnHcc+Hn+UUaB0FdyVZFges?=
 =?us-ascii?Q?nLUe66qhJBvCpT9Xg0VSgGQp/r7Hw+95g+bbO3z8vL+FGsfQ380LeGjBifAF?=
 =?us-ascii?Q?NaFp/OSiqhInWsUTFFAWoyCgpc5d0Cs9RZ6xISOVse9UKos+z2uA5jPwNo42?=
 =?us-ascii?Q?xO1Nl6lcCLSWVepvCtQMz5CUFuMEq9/MZF2toZCqTFm1RKn3ZrvbLjABbeaO?=
 =?us-ascii?Q?Dmfg42SL0yR9BjzokyL8L4VMSNFMOe8QulRa+7Lh+DpBAZATiyGnA0pYOIfC?=
 =?us-ascii?Q?40z40LI9vJ1XVn3L4yh3O9ieJkXWgDAWBHoCt0Ur+Tp9oxYU1kgiJL6hcXkP?=
 =?us-ascii?Q?txnYDodyf75pI0jrIdt4Q9Hzbwf78s6Zt8A8gYbe/aOx8NgBFA6++B4A/HBd?=
 =?us-ascii?Q?VWLveFHF2A4EOWkn2nLWq9ACf0N+kSF5sOpNCzzu8gINBCtAVO0/ILooFeLl?=
 =?us-ascii?Q?RgVYz4BKVTVXRhI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:55.4955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f910d6b-662d-4d15-119b-08dd5a428831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

- AMD provides custom protocol to read Processor feature
  capabilities and configuration information through side band.
  The information is accessed by providing CPUID Function,
  extended function and thread ID to the protocol.
  Undefined function returns 0.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
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
index 642fe762cf6f..6fd6e8e579d5 100644
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
@@ -134,6 +279,9 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
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
index 47a057226300..847a83770ab0 100644
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
@@ -63,6 +78,7 @@ struct apml_message {
  * The IOCTL provides userspace access to AMD sideband protocols
  * The APML RMI module checks whether the cmd is
  * - Mailbox message read/write(0x0~0x999)
+ * - CPUID read(0x1000)
  * - returning "-EFAULT" if none of the above
  * "-EPROTOTYPE" error is returned to provide additional error details
  */
-- 
2.25.1



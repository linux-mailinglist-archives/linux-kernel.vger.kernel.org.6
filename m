Return-Path: <linux-kernel+bounces-254869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A969338B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2693F1C20FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECF750288;
	Wed, 17 Jul 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wKP7GM38"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785A224E8;
	Wed, 17 Jul 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203875; cv=fail; b=Zzwa2CEPptaCnCi+HLa7L07FdsjdKrMmx9RjzUha8zxv2aPOziSKOGafdtSBvj6OzdkIDIABwb5jG9m9AM4sm35RdZp1W/AHvhL8BuRtfTWuB6LXoWbRKDRB6gty82qr+2kBK0cShP89leQl2y1hbNT5UsNx/UXuVl99+8bpDLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203875; c=relaxed/simple;
	bh=MdqBNc8j9NdnbkbtiXXCq9TCKug1ojLgITZCyWZUFl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4+6SpP6cSgJaNAUpIf4gBN9BO1ju8OvDeVjqwHBDeV8HzF5X0rDWNJ0MA+5nGutKFY6va9Mxl/DEY2d9AAkasg5DQPb3kA4FW9lSpB3UakhdjnBTSyqA0FXQ/qAyw4SwD53EoN9m8LGkPZuMGCTK8h+g8a8bfBiFWlnGIKXPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wKP7GM38; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSoUfe7wN1YFywj3JDRbiWhNNfOdA1Nn6xXIzIREoKkPTSPfgIaRoOxQTHSfjF45nPNjfYDyOpOl9zfrtyNkhsTEV4t2ihyKAavlA9C3Xd6ZQwXEbCeNbN9moF2lN6HSBSbfcIZT7n30zOCU/AxZ1XWy1hE1HfJI52KdxNPokUHV880G6n1W1XP87vzwnUnHW7aufX94NFZz0jQ5849xeC/1QyYYPyWiD0jxthYmFO0TBAgTuz2aL2YR6u9L98d9cHPLN6mloKveWEIJZBItKb2yBexVT7B5hxgu1xXHZBeHUF6cQYKs46ACelFEFBDMa7IX+Bk1udEMvOWdkZPp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spchOJetAREOlHKyuf8iHakIbpzUNfpjXstPC2CQBdU=;
 b=i9XB0yNRz9uJC9MWKSXUeBxZ90haaaeQ3wmsd4Z5DYunqZ84AkeO+TUtuS2Zlq1pHK5BMSVO14/lZGtqf9XPjGMuEhVs1FeIDtAmSuPjs2ltr/HCu/xGkWwnZXnwVvnAy5R7xRb3nX5DXMmDprwvBwv0uxE7yZ5IUXCe1wUPYpyQR+4LvtBciq6sIfBQw49q2AVLaifYRloMvDOCqTnYQ2aKJwRJ67XlV+R58tU26syYt5iZuwTdH64+rNsQaye4IzRQ930gmwGEcHXNk9/39e3NmwgpQkGUxTO4x5vZvy2X0lJ4qXaYYIiWy3wzdixa1GIA0hUU46/wcvRowO/97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spchOJetAREOlHKyuf8iHakIbpzUNfpjXstPC2CQBdU=;
 b=wKP7GM38JGfNL5iH/eYlnCyAOFPb8cUm79emi5dMj8BKcHwO0e2kvqYsZatnvy+Lpc7ERgwixThPsnsvvva1nKCofoONJiSVc0eMoiqaLDLcCIUumpR5IzsCrFTIjjE9VFmh2Qgwvt7nUIL3puOx7p/b92CM6fF9oL297quWLic=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Wed, 17 Jul 2024 08:11:10 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::b7) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 08:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:11:10 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:11:07 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 6/8] misc: amd-sbi: Add support for MCA register protocol
Date: Wed, 17 Jul 2024 08:10:25 +0000
Message-ID: <20240717081027.2079549-7-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 733f0c79-c321-48c4-b3eb-08dca6380464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jg/9hMpfs02cmzpcOZLZ74GqBVUkwS5aoz1+WtG834n+XFLzFxVXjmeEwhN3?=
 =?us-ascii?Q?sYoe1asDikB9eV3wefH0Ksv3CpXYCp8I2smldKt6y4qFuk4D41TOMpQcYiA1?=
 =?us-ascii?Q?Apg/+aujQjvmNC4+XPT5wSY4J2eZQpiZH4ynKyQXbCaxLUp7o3ISuOg8/wD0?=
 =?us-ascii?Q?RpT6VOr/Phds05A0N8EnK8ilGYkwzeTqg3meR2WJzCi1qF7n4UKWqW1K9hbX?=
 =?us-ascii?Q?AeV3rSgHxkXQEzWvAeBcRBl2B+g4C3ALKnsXmifdpXY3v+b9McYpqnA+En9s?=
 =?us-ascii?Q?5/OfR16rdvb8SEr0j8DTtB6QYyON2LRDzJNK8fpQpSumpcgLKrOpHP9NmD8n?=
 =?us-ascii?Q?kiuowQqhXGwTJa0I03CGY3F45yYZA56YOJ6x8d5Zeagf1zunQ+vlnAqfxeQ0?=
 =?us-ascii?Q?kNZue65QioFaT0Ojg82bahEPqDfsGsoSlQQNVw4jU39KvVm6kVifhlQnXvEX?=
 =?us-ascii?Q?Zk42FQEWAbKugsG+fTkY6elR1jQB5qNtp1pqTx/fL/FXYLizhticnhK6xt+Z?=
 =?us-ascii?Q?2bLBc7QVli1vibWcwwHZVCEZwxPsSUJwHP9eaMxVa2fgA9J8B6um0TqWTiis?=
 =?us-ascii?Q?xIeyYxV1BMzERAoYvFBbAPJkMOrpwUJ+TRHp75ZgOdcJUA7G7I/uCd106uHd?=
 =?us-ascii?Q?HvTn/4PG6AWt5H8C0OKZsrQDw5b1eZSnHXaW8I4W3RTc7JmsxmcJr4sh0fBy?=
 =?us-ascii?Q?DyItfiUiECLlSxMvz+3WTXkYHTopZuqnOfdgtkORErNIWzfItBKEVB2IUvjL?=
 =?us-ascii?Q?di2rO1EModImCwdHatcgRspoqfn25kwZW++OnCgvWGNa7QkuH4YHdTm0i+f+?=
 =?us-ascii?Q?gsOTekwGbvWQ+KTWUduv7EkEoRgKkVPh9fQfvCDU3cmB0uDkEWpRVlii4hK+?=
 =?us-ascii?Q?4VHBaHJbiBEFOe28i+C5mKbqkQjFBJb+t94W6am9Ux50AnToYSZfIeK1ZzW4?=
 =?us-ascii?Q?jWo6QsPk4lDdLrJgFREgVGQyVX5VgM+Hppb/980gwXJRVOGfnchl7vXpDrMp?=
 =?us-ascii?Q?BJ+KAw0Buk80HI87pdcrJwr7XPGKhsT/vqzdC1E6wAm+CEAvouupRsIcWRWP?=
 =?us-ascii?Q?aozfpWvH08BVsPN4SxzT7zotWz3AO0YURWt79YHVqkrogNXN0BbDoSmON8Xt?=
 =?us-ascii?Q?Fr/hbk9vCUGlsc5CLzREpmPFi/x88OrYqGqBI3vIDeDAzTA1espK+xUhL4xG?=
 =?us-ascii?Q?YmiehzWMj9ybiiPsFJMdiy4Yl8B5oDX0xhH80+SxA0LckChoJEzJMkUNyOp5?=
 =?us-ascii?Q?9CR6JwFoefm85Bpp7An1DFtpSpxg9OmkOpmeKHynmkGnLWt1+cPWvWtRRuWX?=
 =?us-ascii?Q?xXvt4hpskBySaIrZIfNw9SVGRxmLOppbFQZHitn0fGsEFZk9i8eX3AkcZ0JM?=
 =?us-ascii?Q?KshwdolHQkElC5+q26hmgZ41W0kNGpiTOeW2i3FUD81vhTjfFdcF1Zu/qks3?=
 =?us-ascii?Q?OScxX4qRsOFU/mifbYBtOUKNo7d5V+/l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:11:10.0918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733f0c79-c321-48c4-b3eb-08dca6380464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

- AMD provides custom protocol to read Machine Check Architecture(MCA)
  registers over sideband. The inforamtion is accessed for range of MCA registers
  by passing register address and thread ID to the protocol.
  Access is read-only

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 90 +++++++++++++++++++++++++++++++++
 include/uapi/misc/amd-apml.h    | 17 ++++---
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 57625bc1b4de..87bd2ffcbcc1 100644
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
+	prepare_mca_msr_input_message(input, thread,
+				      msg->data_in.mb_in[RD_WR_DATA_INDEX]);
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
index 21ea8c65daa6..3d536f2c8815 100644
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
 #define RD_WR_DATA_INDEX	0
 #define REG_OFF_INDEX		0
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



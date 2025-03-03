Return-Path: <linux-kernel+bounces-541478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58561A4BD4C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA25189887A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D1D1F4160;
	Mon,  3 Mar 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jBvqsmzs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE681F3BA2;
	Mon,  3 Mar 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999613; cv=fail; b=IkOCaFepwoTMapHw+nglir8uO8CY5KimyPHZpBoyfzOtPGEKwkOTG8nyyglvWp7oGMjDbjNpSXKmpYT8G5YDIIof+jzraCrjks+X7b2vLf9QXLEFY9+WkK/CmO4gY6Pumt/TaqcDqBeWLzXwfr1UdpivvOaoSJm8EwhAmTWbwm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999613; c=relaxed/simple;
	bh=PEdl4eQHD9NfySCtoWbslE9to1LRnSP0Ye0jpNWX08Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFxxlSM5/0qpEJJBV5KH27tS5dJdFurDmZeG6eIcoS4xn73j2lFyobLG0K/2Bc4osb/UuuE/Cj+t0lwcBy4PHRSENhZcTlJNfWQRUUfYAGqJF7Ng3eC+zhY41f7/KP2U8afuR+80AsKOJ/DamKheXDW2PCrNFe0l87pk0Oe/dG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jBvqsmzs; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syMxyWGXTeR7+BAK9J/oqKMOkx14u2vqI78YM5varsdv2BeAZpNxCA+VianhZtCFYaXwFBnIf2QjlVJcMdZkVtOHURE0vfzFq0MlFTnGqjTN4sy8KME08U7pta58qeDELwlq5iQmb0Nx8uraTl/hF5ttqpmolssI2RUTnNRGMEjL1P6cIO49A2Pg/XFqpZChtNhZUM9LQ99purk8quUKG2yX0VVglOyibzZJEIgc0zCpOiPlz60+/TOXhNbnu1uRzaKPulfIdXDd3O/JPCNE8q799beVef9hLhN/E/1lpevBfeeO/Qr2tWmYxd73rL9L3NH4CufcG/cpy3WBw1YE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpUzbkyvuMxU8l+A/IVX5UEJFfGy5cjiVhgG3qeC+sw=;
 b=jEdbhOAHIDlE5Jl+dAY0dia2sytWUneIBsqHW4r1l5Cs0fVOp5j5womoc3c/3+P3Co5XQSRCDBmkn+rRTJ5NKDP5Lt+NcQd+Mr2s65NPz0jerTDTXwWzDOLwBIE2z8PZrYEwN2Z9AL6cssUdpJYOAKJI/JpVexLuT76Hot+Zc2WgIUZPL+mRfRXbcfjZS2//tAO44sZCNPJgqlqNcbGH8umIS9nafKsjCFM99LKqykXUlB6ikA/MDW+W5xQGZnOumkXerebvrxEKY9wu6bt/gfIy1KzMpvoZqmp056Kp6DjS0RAl+ZEY2E9zIYC+q7u5/ZBYqDbAsd+UdH2m48bZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpUzbkyvuMxU8l+A/IVX5UEJFfGy5cjiVhgG3qeC+sw=;
 b=jBvqsmzsr1fo5jlLEZSK5uW21L024HF6M5hWmp/w1uJImPFBCOD5m8Y1L+TEwnxFTsBK5P4RoIL9Ki+1V/P3GBDqmBekSCNg4SR3F+FRtpftmpqPaSELGXLpibcS1FHdH22hbAqIldbj6OomSUpTJSAlbzqec8lhnPSUo+en1CI=
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 11:00:07 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::81) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.13 via Frontend Transport; Mon,
 3 Mar 2025 11:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 11:00:06 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:59 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 10/11] misc: amd-sbi: Add support for register xfer
Date: Mon, 3 Mar 2025 10:59:01 +0000
Message-ID: <20250303105902.215009-11-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 66032be2-14e4-463f-4deb-08dd5a428eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ouPU7Pvz+aH0hwhZsSwo6zXencZqvgL0EsCTd/mf0aGQ4eaCBLF9GG9I/qzX?=
 =?us-ascii?Q?6SJm04jFcbDYWnQ629KerJNKQuq1zROgRwx055pqNUNkG2LoIbFPFL37Dx06?=
 =?us-ascii?Q?If1pOxeg/P5mmeCoufaky6BVqEJuyid0m34jyJIjQ3WKJgxROhytYbicIzPa?=
 =?us-ascii?Q?rw3MNsxza1l2tMQcyi5wWAZPqxkk2fPvF02v6YeuzlKua8O/rFMBt0B9Vgpr?=
 =?us-ascii?Q?Nu2HL7Y77AowTNaFbecDj8PGC4ijFUBR8IyiiS2mAwGi6Kz+9X+epf2pId/j?=
 =?us-ascii?Q?T8UXYq2Uv7bKSl8NH4h2opgX4+XCHfQ2OQSdSUVOJp/suGn0gDxIyAoOKzMz?=
 =?us-ascii?Q?H/EDleZBeFmS99ljYL/VoJ7kajSIRQs472LvVHjUmewQ9p/TDag4BMvZljsg?=
 =?us-ascii?Q?RRJx920+T/uqUXhIi6IFRHOHK+lkCqzZSQ6CUCblVxi6TkYl4Ww+YM/AQ9tV?=
 =?us-ascii?Q?3GJW4KdeoDMWaO95AcnuAKiqihEE9aB6+i9xW2bVcKk/02RhVU6YcAVduT3k?=
 =?us-ascii?Q?6XAaZTLSDwEeQe8udCpj35Tl/8oOE9RmZFLaIp/iD0Ms3ZBeYT3WXH4EXyYh?=
 =?us-ascii?Q?yRYzC/wV6m04mXfIAp/pWdHFkiUUliyJU0PJRnEL06mLO7HgINUo/uyZVEF4?=
 =?us-ascii?Q?jrUlOadnDe9qJOQmlXL8zQRfG+6Kar3S3Fy6i0anX8zKPBjHUEJnXM1l5i4y?=
 =?us-ascii?Q?eg4qyl0mDBqggY0u9IO0GgBXvKCguuNNieya6i6PdKZ2cmp2orrxGJwSH6Ao?=
 =?us-ascii?Q?2gO7niUO6g0riEk0SoX7r8mz9LfT1v0W03k1LPvPsshWsXY1Fui148bObb/q?=
 =?us-ascii?Q?egPBtpu+TaJFf92u5QD16Q6j+UTu1Xho1sLOzXEe/Rhz1FY3NOMbnvmD3fl/?=
 =?us-ascii?Q?BsPtAI+lZ6X6eL/uHuzx4+G3xE3C9LoNoZ+45Yhri1Vf+myurKVQqZ8HQvHU?=
 =?us-ascii?Q?X3p7N4QQLKrzJBEPPg/+6W13VyJDUKYtExzz6eQmPx6T/z1FGN6W4r9YInPX?=
 =?us-ascii?Q?He1XfuWblVLuEr56KVXk4f3CO3wT9Pg9O0ukt0bhFcShX0yMgeLzfiZq+K1H?=
 =?us-ascii?Q?HMVvLWKsPcZhyLoUJDhXyBQqep5ksERzt3/lqR9UKZ/L/FvpUV+HP74URs2G?=
 =?us-ascii?Q?RBoTF20ury+Gz47PZas3wJe3VxMGdPtbfvznEA7tWwefTv/9iO5yys5vMVB/?=
 =?us-ascii?Q?sNsvLAOcw6gxc/P8pckv9XxifwIGkSTtJntKxwkkfMXy5zfp5KV2XrDFFi3U?=
 =?us-ascii?Q?hRTnlPBIY6z3r2t8QdGK5lNTBVYWt2mOlP4Zeh8vvv0HevQjLHHin/y/YclC?=
 =?us-ascii?Q?FFCBcuZ4r4M0Azn+xmxbsXhI8xJB6RIXJQuwiaehegrfxdQ3pltCiojpcvSP?=
 =?us-ascii?Q?GfuXKzOiPyF1hBFHWHLflijL5jGRw3rerAU7Dstx3koHbeuy951umv+OySlu?=
 =?us-ascii?Q?vtSt/vSK/Y0jiyrQAm3wqfJJUpaPxu9Fb2sbCTC3Yh5q1FYY3Xv5Lhd9s63x?=
 =?us-ascii?Q?LL0Sz3kUceYnPho=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:00:06.7864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66032be2-14e4-463f-4deb-08dd5a428eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

- Provide user register access over IOCTL.
  Both register read and write are supported.
- APML interface does not provide a synchronization method. By defining,
  a register access path, we use APML modules and library for
  all APML transactions. Without having to use external tools such as
  i2c-tools, which may cause race conditions.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v4:
- Previously patch 8
- Address review comment for documentation warning 

Changes since v3:
- Add ioctl description comment

Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 25 +++++++++++++++++++++++++
 include/uapi/misc/amd-apml.h    |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 662aa90980fc..1c248dcb8ce9 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -349,6 +349,27 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	return ret;
 }
 
+static int rmi_register_xfer(struct sbrmi_data *data,
+			     struct apml_message *msg)
+{
+	int ret;
+
+	if (WARN_ON(!msg))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	if (msg->data_in.reg_in[AMD_SBI_RD_FLAG_INDEX])
+		ret = regmap_read(data->regmap,
+				  msg->data_in.reg_in[AMD_SBI_REG_OFF_INDEX],
+				  &msg->data_out.mb_out[AMD_SBI_RD_WR_DATA_INDEX]);
+	else
+		ret = regmap_write(data->regmap,
+				   msg->data_in.reg_in[AMD_SBI_REG_OFF_INDEX],
+				   msg->data_in.reg_in[AMD_SBI_REG_VAL_INDEX]);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 {
 	int __user *arguser = (int  __user *)arg;
@@ -382,6 +403,10 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		/* MCAMSR protocol */
 		ret = rmi_mca_msr_read(data, &msg);
 		break;
+	case APML_REG:
+		/* REG R/W */
+		ret = rmi_register_xfer(data, &msg);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
index 0a841809ca84..b18c20f9f809 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -10,6 +10,7 @@
 enum apml_protocol {
 	APML_CPUID	= 0x1000,
 	APML_MCA_MSR,
+	APML_REG,
 };
 
 /* These are byte indexes into data_in and data_out arrays */
@@ -28,6 +29,7 @@ struct apml_message {
 	 * Mailbox Messages:	0x0 ... 0x999
 	 * APML_CPUID:		0x1000
 	 * APML_MCA_MSR:	0x1001
+	 * APML_REG:		0x1002
 	 */
 	__u32 cmd;
 
@@ -45,6 +47,7 @@ struct apml_message {
 	/*
 	 * [0]...[3] mailbox 32bit input
 	 *	     cpuid & mca msr,
+	 *	     rmi rd/wr: reg_offset
 	 * [4][5] cpuid & mca msr: thread
 	 * [4] rmi reg wr: value
 	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
@@ -85,6 +88,7 @@ struct apml_message {
  * - Mailbox message read/write(0x0~0x999)
  * - CPUID read(0x1000)
  * - MCAMSR read(0x1001)
+ * - Register read/write(0x1002)
  * - returning "-EFAULT" if none of the above
  * "-EPROTOTYPE" error is returned to provide additional error details
  */
-- 
2.25.1



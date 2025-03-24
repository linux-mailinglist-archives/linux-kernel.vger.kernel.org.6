Return-Path: <linux-kernel+bounces-573890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA7A6DDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3343B35F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BAA262803;
	Mon, 24 Mar 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z3Vya3NQ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D1261565;
	Mon, 24 Mar 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828363; cv=fail; b=Vb0qobZ3BEBVkHbSxpOhn34ElaBK4DHCQWV/Z6+7kc5grFE1y4ECgDg0Sr0FJf3pgSS2d1nmyu7jRb6Fa04BVH5fdEc5oXDZiUAOyTPaPVkexls5RhBic1+0XvadqT4H7m/VNl+BC//Qak+TDY+irspnLNezTz1YJ2CONYsLpvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828363; c=relaxed/simple;
	bh=Cre8cDa5UhRWuy1qunggHAFSe6fsgShNpZ7CgY09Fvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0Zh+eQFv0JHfCQGGklIf1qHiH7nqgXYaKyf7egL2QwJqW6qSeu5ZjvelK8xtjziCcU+AksWCdmUWa/gc//E3bCuO4of6XKnbJk0vGwxs4YX4JCFDQVUmGJVa+hqcfNzbWImdZU50Wh+gnTJFdVo26zPkmvh3e9WEoaezD+YOtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z3Vya3NQ; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Etto1+YNWzDZEobiH1fQquoovF1Gm0cvd2BtOcIlvIb0rUOC46yGllIunAFscXd16D928OkmrBylIGQlWQcRSM8I1qkDS9L0Km7QZZAqurNL1KuyN4XwqtIA3r4Gr74UGH3t2x8lN/bZ8xlWLwKGYgSrWRHSFAWW7W1fUiZ5GXdq37TYIj7xLThZACM8IfihHFtlrY2yXdak7LeLVi3c1K0bejrNG7M62XKQluc8Xxlk4c77i/QQlO6IoI6XILYNrYMRXfAQWbQ6wMelBPtW9mIVf71loap8jK6p+E0xVOtII7pO8o03dMONoI2/iod6WZyydv1O+ViO3/A4NZZ00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jhO1rQOsyOCC2qJeFUV9Wr3GwywrtAfxmgv7KF+I7E=;
 b=q6M5WCuyaZsoGAAjjLfy3O/uP+eo+KGI5s6Ba6mMi0lNweA5x0mXFRn/WSAZ5c3bf0+se54QLd3xTdSS8HB4DPUMj+RJZbTCU3ntUKfZmzUwRlZiE5BD14PPScYyD3TsXsJXHUNl6zq4DHwJ20K0Alk0OTsBt1tE48TZZQYpmCcsDyxbUHUCcL4CSzQwu85X1glGCO222Slt+e44so+jW/VkGUv04wc5OS0U37jWNmN5BtK6X15Hn4zBMgLUA4wvIelAZVV3YQg4NxwsuitOMsytDu1SOQ4QJEQOoDJ+N8da4rOWjqpadW4eZnbNZUc4yWjUfb4I/QbSqBn+JhrCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jhO1rQOsyOCC2qJeFUV9Wr3GwywrtAfxmgv7KF+I7E=;
 b=Z3Vya3NQGGNWsWx72HYQB7tKdLzk2+HYOCDYImQVEcVmDZ2+h4Wb1y5LXzV9ZqtCZQPFKpdDzkw/y9+5qCvQ4mxYIbJxhnq3uRWJaXTA2Wdbk1g5IDeA9phlSaA+txdbm1qYXcaXmZXr7YczNQONbpglmLXTT9cqkRPqjo3P3rk=
Received: from PH8PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:2cd::6)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:59:18 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::c8) by PH8PR07CA0012.outlook.office365.com
 (2603:10b6:510:2cd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Mon,
 24 Mar 2025 14:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:59:17 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:59:13 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 10/11] misc: amd-sbi: Add support for register xfer
Date: Mon, 24 Mar 2025 14:58:14 +0000
Message-ID: <20250324145815.1026314-11-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: a1842bc6-bbb2-453e-1c18-08dd6ae4734a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EsFrnUNUy7HnhKsyRBBVUJNbnO6NtbGLiMyueKwYj7x7x68K8nkE9hznGjYu?=
 =?us-ascii?Q?j8cDvnEadw8OotHQSCR8R8795o2fbB1DdgN0bgguub+wF3iIcJTLlDeg8WXw?=
 =?us-ascii?Q?rLH41RI2bwOmoL37RJ/NteuCtb59N/s6Xt0Wtt46jUSD9jjWVcHxx/HXIGme?=
 =?us-ascii?Q?BIRt8Oau62zHEBaTScX0oxGGIjIP+RskJUYql787ZArPq9FVhp+6zQf5loTb?=
 =?us-ascii?Q?f4PyLZJ7g+FPyEznRKIOXmkf9N3hU5vi/1yddMw3TiSGtaqPSMFaZEnPeWnn?=
 =?us-ascii?Q?HA5sllkZSS14iZTi7hoz5jjN4HbZXrQHrpbT4y+VvxyMpObANQK97f8oUkOT?=
 =?us-ascii?Q?/aMoCtkFCZRTYyb1mXw3lprlkEp+OWWyv11URbH+Or31a8PBRKNzGNnVsTNn?=
 =?us-ascii?Q?XDeU4wbR+3kknL40Lz3Trgk1Z17AG1EzSx6+pVV528+Qh3rWjEcTqKgU9qnS?=
 =?us-ascii?Q?e29lobE148PmhPhJifsfUQcYR6OKTL0iC7ZaTxcM60JQncpbZHNIQlpqLg6c?=
 =?us-ascii?Q?GUAYM3+roeLPKFX9XVz/HLIrLnzZxmrKXB03C5lWJhwhukiZuaRq7grTa8HO?=
 =?us-ascii?Q?ztBUl6NP05ppSIMXn6TXlvrJWSNN9JiDFyEUh9QflP97oRIYpT1xoiOajIyP?=
 =?us-ascii?Q?68LsSHIE95DqSHXxvxoGRoS449RlO87szvzT6LCmnFjfSiMbD4HanfUWisOS?=
 =?us-ascii?Q?W4CcPG5MVmLYDe7PU4CcK1rAQXvw9ncL76Li/gvosIG3pk1fh0m4ndbO2pRb?=
 =?us-ascii?Q?TItLk3S7zJ8vFvJAb57etOQdsZUq4OIiLoszUUuayn4YHj84sS1BIiF84upq?=
 =?us-ascii?Q?DGyuwj/F2isJxLY28Xm5KnHu5+xPGO2+1eyJM4o7aN1lf/wJ1BEptllRBEw4?=
 =?us-ascii?Q?Zv5a6a2rZt3xCBaCC9dahQA+0g8qRull8cgzJDNRDSif/guvHuvvABw9cdKu?=
 =?us-ascii?Q?cVtgFwYP7Qeublxbfo1SLZzY0v2yHibPYN6ZiO3yNJaaTN/JkW23yacj9VUY?=
 =?us-ascii?Q?9MJqt9QiWubrAFhqdyzEJx3AniQgCZ/67xSbp6MLg78Bh/y8/4a1pmU6/nzK?=
 =?us-ascii?Q?CsKYzesto7GCQ9Lx7W9v7uxeRtj+HcO9s42p2EbHTJVuVEXpXOFk30ChNXNC?=
 =?us-ascii?Q?KXsFCGQyyDtG7NaCOMM3aO52QJHNfeexscxMFZxMimiroBwrm6wYE4bgTHlQ?=
 =?us-ascii?Q?50HSKv7Y/HLALvrR+68XV96JPng9tnrgEA9MrGmlbMNVibAK4mjrMDq+lQk/?=
 =?us-ascii?Q?pGEHIIDS41uIpmjGs2GoiHrpWxC6twCyfSkfH8L/msN2RkyIvPAfweofX/op?=
 =?us-ascii?Q?7LlpPycOzm/hOoyNSpamz171TiYgZNpyKB7EF5nk371euFPIkt0KC9roioFo?=
 =?us-ascii?Q?3+uz0skmlGWCibof66KLxlXpSYjwke23sjyXvHPYQm7frC22YD57Q0YJMzWg?=
 =?us-ascii?Q?mpYG7eYluWLHb7dkhOhzPEEMuUrso/fVGMMfRCdKpCJ1DMeEmLahTQuCyvOQ?=
 =?us-ascii?Q?HUiQi5CCLja9kF4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:59:17.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1842bc6-bbb2-453e-1c18-08dd6ae4734a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520

- Provide user register access over IOCTL.
  Both register read and write are supported.
- APML interface does not provide a synchronization method. By defining,
  a register access path, we use APML modules and library for
  all APML transactions. Without having to use external tools such as
  i2c-tools, which may cause race conditions.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v5:
- Patch rebased

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
index 89fa6da453a7..44079bb92c78 100644
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
 	struct apml_message msg = { 0 };
@@ -385,6 +406,10 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
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
index efbdc7276e6b..0d33f6b07947 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -10,6 +10,7 @@
 enum apml_protocol {
 	APML_CPUID	= 0x1000,
 	APML_MCA_MSR,
+	APML_REG,
 };
 
 /* These are byte indexes into data_in and data_out arrays */
@@ -27,6 +28,7 @@ struct apml_message {
 	/*
 	 * [0]...[3] mailbox 32bit input
 	 *	     cpuid & mca msr,
+	 *	     rmi rd/wr: reg_offset
 	 * [4][5] cpuid & mca msr: thread
 	 * [4] rmi reg wr: value
 	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
@@ -53,6 +55,7 @@ struct apml_message {
 	 * Mailbox Messages:	0x0 ... 0x999
 	 * APML_CPUID:		0x1000
 	 * APML_MCA_MSR:	0x1001
+	 * APML_REG:		0x1002
 	 */
 	__u32 cmd;
 	/*
@@ -83,6 +86,7 @@ struct apml_message {
  * - Mailbox message read/write(0x0~0x999)
  * - CPUID read(0x1000)
  * - MCAMSR read(0x1001)
+ * - Register read/write(0x1002)
  * - returning "-EFAULT" if none of the above
  * "-EPROTOTYPE" error is returned to provide additional error details
  */
-- 
2.25.1



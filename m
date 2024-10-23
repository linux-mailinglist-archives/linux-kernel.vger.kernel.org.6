Return-Path: <linux-kernel+bounces-377386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04A9ABE29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D41E1C20DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162181474D9;
	Wed, 23 Oct 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rtRCJtYF"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03D14601F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662717; cv=fail; b=RbmzB9I73aAjyN6/r8UojlhKTB3JV8K55GUqNCYxx/RdC8ydzDkl1dYYpviKPEVj1786+2Q2K+NlMS+/YvYiLTumx/zzGvM1wLnf+YF/JhszpbZx8B0BXQLpw3P46qq5RLVTFc3RAk+aFsV3tGEe9dDk+Dg7YG2RYEXsiYXn1v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662717; c=relaxed/simple;
	bh=M/PfHRk9nXYNICDKekfonDpK4aCZfcw1z5GLsz1Mf0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2ZjH0KWv+tS6/Lsuyj1ba+ecfyXKtqunaxuf/4O/vYP//1IXyj+5mFMB9a9QjfM+sPnYL5JfwDQNqSK8JhjDQwXEdZOSb9mx8HV4VECLRffDoRi7ZzIEXR/v14dG193+sHyCpzs9nQBpBlGJ0O5iZRSHEKNFYnkSbftl4V1m2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rtRCJtYF; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYqVAtKJVqkH3JBxJln1Xg15yb2biR4TWhgkugimR0Eg/0kHrNpej7FLda5xkEAig2o4kbEicT08v8ChuL8Z7sQZ10nuivC61DPw3UxLKSJoPAcJnSIVBymd5jTmyuvBOsE/200kARTXzaaNZty1+MjgodWEdcQZW1wSLiIKllgiCWw0B58JICZxCxjV/JmNiNw3jbj79sEShw2nUbKnKQn86mOYOvgfqTRpEnb7Y1CIkeeyM0uE21uuBJzgG64pVdP47OeX46RrbrVR+WsStpjRN4nXqTrjrxaEn6v0Tsd02wqGwWsLuI/z3Peslkbl1dEK2AgkqaS05EW280dK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjwErfDQy6CzaMnw4++rs8wsNhqpWYxjOdTyHdGRSDQ=;
 b=l0P5lSRThFPgPKVEzrtKZzJg/cls+Rz2HbCoXBpjxPjWqh9tfhFN1lIPErP7XOjW5Z5rdmSB3Hvoi8dWRWZuapavWZaOGj+fpqcSpuVarhjtXE6YM1Z/E1et6wrZaC/3ep4vzwxUamnZhlazEw4Jric/E+ShLFDGO03x53mto1uYbcGGncgiLRMUnpRSgiDIG+u4PJXSKSPviIY+IYP2NuXkNg8vbCyXf/aHYxg/hShKWFV2JY/u407FrXBrL0+FedgJwO2fHkMFYP5nJLaFlMS4eOi+5Ili3V+2pkqUfYdHmVxI2UCLJiLvcFrtqiyu/E+aHOGYRYOeWXrkmfOMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjwErfDQy6CzaMnw4++rs8wsNhqpWYxjOdTyHdGRSDQ=;
 b=rtRCJtYFva9C3gqZPzA9PtURbmmwc28pZRXizmejamzdnEwFVfQhkZku7kFAVnASQFA4IDR6kyxLA7z4cmsLtX0iAQyyoQoJT1KQpsMf/dF1cxDs4mh1yBg+xX5lR5eykVTCbY5x6VHKgUrIH5uhPzT5IT/fsSaRrYM6qf1qgyE=
Received: from PH8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:510:2d1::29)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 05:51:51 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::ce) by PH8PR22CA0014.outlook.office365.com
 (2603:10b6:510:2d1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 05:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 05:51:50 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 00:51:48 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 1/6] i3c: dw: Add support for AMDI0015 ACPI ID
Date: Wed, 23 Oct 2024 11:21:13 +0530
Message-ID: <20241023055118.1400286-2-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: e64a0c13-c095-48da-591d-08dcf326ca77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODi72jCa5UKdy+XLQ6pDxrpmDgRQR7kI1dIB7GZtuK4WtdrJO9G86H6p73nm?=
 =?us-ascii?Q?H8c9+xwykrUW82YgAgIw0jTp6MIzqDvgZWenTLDE5z+Mbx0DcH7xMTdFioXW?=
 =?us-ascii?Q?RkHxzxgyIkvMOn7D7XkIOfVthn9odQ6mabrd5X0JLSgUQ8iLlOTokXZDLCVX?=
 =?us-ascii?Q?mLFh4QwfvRrgL0p8jNFkgXSKFi89F/7033FSjC/lbxV4W5GfY0EA3/4Mp/ci?=
 =?us-ascii?Q?esDw4225LSIhtHBFOmGUu5UGAQXkcgw//020VtG87rDryPuU5u0BImIKk3tF?=
 =?us-ascii?Q?iNiBfP7PXBZr0sfK64qiAdeCGEDPUe0wsaIifvcQfiGCAny6fzvpkSwdfZke?=
 =?us-ascii?Q?rXLIC3l79nppm6TvMo5iv6EmHt1DsjuQKDzoBEtMCdPwlf8OUwqN6xPT2x7a?=
 =?us-ascii?Q?lK3omuXEebW4bvi2LSZf4a06x2QLZ9+J2R3Cg1aJPfxSRoPxFkGxE68979XY?=
 =?us-ascii?Q?8PM8XzeXOZpkz/HE/YcgJm3M+BNnh7AC3zIsTHvc6KfJRzCO1TXLQRVaJJKS?=
 =?us-ascii?Q?rRQ2SG9viABQgoTxsWfv1P6bOzZCoEAr3WdQflFLzBRkVsH7oIgqPGttKJUc?=
 =?us-ascii?Q?j1ZEvaYQcHJgyVgoAJj66ydvn3aG4l/QPsS7xY4PnbrxXndVFqixJ/qpHMf3?=
 =?us-ascii?Q?WG4MATFVMlAfv/YjnowstH2eCoGnk9WLsKLqDGZkstqSFFugO74F/4I85qsd?=
 =?us-ascii?Q?ZO3f1MJzXtYfEUJQ+ruHtiX1qRTvk/E/9L//4UFKFTvFTC1QTD0NuHwmVrO3?=
 =?us-ascii?Q?N4G1cZa8bGnWJnxU0iGU1z84ptWonDZjYPy0HBt7AFtjrgNhPaq+r0r+LrFL?=
 =?us-ascii?Q?6YVcXD9I0qZDqu8eQUUQS4YQ+tSwOUxZVlA5Ha2h9duVs0kfEXiN9T5i4z6w?=
 =?us-ascii?Q?m22CqUJ0Vkc3Xp7IlPXxJ9kMrnUfsb6IEMu8Ou1So8obSXMwUxA1JM101emu?=
 =?us-ascii?Q?MMG0FTy6vNs7t5sGWYcmT9g8iAWlc0+URagSUo9Hn4aitvMQeFKr9+O8T4aa?=
 =?us-ascii?Q?pPDb9RUqGG2k5aYbZfmzq1wQ9/c+ivOhN1dOQ+lzYrMQ2t1ZlIOORMD5ReEM?=
 =?us-ascii?Q?5tKmDmSuLuKRfqcz8hgTPW4Zp6AwfCruljQ3fKfOFM0/f290e7XvloBYP0WQ?=
 =?us-ascii?Q?igMPy1uQ9+uSW5WlK4CnBoaAqpNz/GSbQynwU2lhPG5fvfEbADixKTWShUp8?=
 =?us-ascii?Q?kCKsjykwUUujGl9pBVtTb8HUk7oNSXCNQYEeHzSTJv8p686ScRVEbIkO2ts4?=
 =?us-ascii?Q?LMQVdRGy6iQVTK7B7UHZrXxT1RmC277Y2hJqT+Rw0Lul/Ywm5yYTQj45AQ+W?=
 =?us-ascii?Q?/p4E1KC8g/qNHc+/Ls+bjEheIyTYOJGRVZ9XUQE+KFAJc9ddMMPt7fERaLrW?=
 =?us-ascii?Q?vXURGNr4Npwtyi0gxa2bVetMjRTvWVA6qcDI3wpSCtLr7YdOPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:51:50.9175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a0c13-c095-48da-591d-08dcf326ca77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

Add AMDI0015 _HID for Designware I3C driver so that the dw-i3c-master
driver can be probed on AMD platforms.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8d694672c110..1a7c300b6d45 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1748,12 +1748,19 @@ static const struct of_device_id dw_i3c_master_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
 
+static const struct acpi_device_id amd_i3c_device_match[] = {
+	{ "AMDI0015" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_i3c_device_match);
+
 static struct platform_driver dw_i3c_driver = {
 	.probe = dw_i3c_probe,
 	.remove_new = dw_i3c_remove,
 	.driver = {
 		.name = "dw-i3c-master",
 		.of_match_table = dw_i3c_master_of_match,
+		.acpi_match_table = amd_i3c_device_match,
 		.pm = &dw_i3c_pm_ops,
 	},
 };
-- 
2.34.1



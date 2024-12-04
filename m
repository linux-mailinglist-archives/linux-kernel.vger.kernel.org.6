Return-Path: <linux-kernel+bounces-432187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D7B9E4705
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0E1880267
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036A202C2A;
	Wed,  4 Dec 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KvUZDI7G"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B18202C21
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348330; cv=fail; b=rK1Oeu1IxdIZHdCzUnN+5KxmNzb7P6vy2OPd9PKSR5pL0jN3tuB/icEhNPCUmuSXbi23iy7xNTXXs87rNOBiTg/8Z21Kg7A2Fvb9Xj4svCQ/PmxBdL4LCDWG4D3nThmDV8N4UHxvoJkJ/IIpVceAkKyCkjBnPz04U1bCDO9vvYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348330; c=relaxed/simple;
	bh=h4HBFjWIC9atrLsFo/Rt47PwVRA+JmWb/4dkkBbBHiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uzth1JGqnFhaiuedRaAnW9VcDYCZsOLoczRlwYHJdtcnL5WSGlnQsSr9PDrcLrs8XanFeZ2k+o+chXnFaGhaJfa9x2orFlqp4FhGeSYiJCgpU+0qnkcKAOeP4y+VWwalOLKJU4ryrLaG7GgR1uLtDTe3/TIYogdFCba5W/TAwZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KvUZDI7G; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA3jbbLshmJBx5zsbM7GHVEtTRcNCJ0Qb6TszQ1Ql5YBhdxcbZh3fqf6fIe8pbQEWQ27AZ7OA2AaXqU6vOYA3CJ+TdRVrcQQpcGrXzI+dDghorKtOvS3YFS7AMN+pJqEcbJ80WNC9pwTcr2GVnGSMALMbaeDH1IbrhZWBvM4IkL+6inf22BOmfE9cyN35g+BZrP0JfWWjjodKTzlYPpAe3pmWAuv/h0DWo55kx8auNbBSfo5ZQjK0ywzkWtPZu+1CoyujMtAYJ8LQAdFMI9Rebs5VjY4xAnIKGkEvcaof6t2xkmssvg/TgchjSEbG/T5bz4Jqd+prKt+YynMBf8aNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9hRiPIVNUQG7MePGZF7UkbYV+rrvkBIzPQXJ9odZ+8=;
 b=Lzk8Vr2nKwx/7AiwtXQOowZArb2Sp1XhhKzJ/yBU5S5dWjJtCGLM9Ck8hh6KKV1yziUk6o4uv67B9ff012KaGNQY7kmHQmkWmj6167oaCYKqW4C5tske1WiRAlsKn8Ygbxp9JW04Kh88HLQ3E34vc174SCW2IsNQ1vx+NQ0PyWUfoqtW6rBxlk2jUOUMzERIT80FILadS88zit9e9lFwXk9RC3MmMnyp8bRswbCEYc/NGt/2Blc4AAJleSd/7HKf68RTqBbUtaafwkH9eLRhtvDLfO5SFL/ttFcnDU4Y/kWsC8QdvYkbZ/wxClW4oRgPJ5Ud0FZtHPnUytgC7n+59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9hRiPIVNUQG7MePGZF7UkbYV+rrvkBIzPQXJ9odZ+8=;
 b=KvUZDI7G+Fzh9vY2VgtnLv8bXCakBZxcJO/r8f5l4YaPQyV5DTnf1PJF4QGE7W/gU9xGdchrI4ngcth7DouvdLlpMR6vwtMBohGuBHJP1SSOubuCxOEXN466cougrgVnxzb2jdpPGurW2BCit4YfYJhHdCqHs4kSyzX6qEdrvxg=
Received: from CH2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610::35) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 21:38:44 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::61) by CH2PR05CA0022.outlook.office365.com
 (2603:10b6:610::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Wed, 4
 Dec 2024 21:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 21:38:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 15:38:42 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Dec 2024 15:38:41 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V1 5/7] accel/amdxdna: Add query firmware version
Date: Wed, 4 Dec 2024 13:37:27 -0800
Message-ID: <20241204213729.3113941-6-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204213729.3113941-1-lizhi.hou@amd.com>
References: <20241204213729.3113941-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: decbea9d-765b-4349-508e-08dd14ac0683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zjvpmK5j85GlawwNiClMN6D5NaJDtZtriFOEzGHYTKogTwLnRE4iBsRTly0Y?=
 =?us-ascii?Q?0GcU41Tdtr59ekf7sjH/AZyc3i6/tcpX4xo/B9qmCjsJQPmZZtq89N3kRMgs?=
 =?us-ascii?Q?IVGwTMne6LaJE6f1NSeKZS1NNC0HY4cu49YfjBwYszu7YRHi7kmqLhHWpYhz?=
 =?us-ascii?Q?TGuWFng8GBbHyzrtm58AtRZvYb8Rqxu7iuPulHi1DXz/mlEO6lSZEuGrQ9QB?=
 =?us-ascii?Q?HalG22akBLBvW9s+d5XtMY745sw7nsJtsNtfpJnmDXJkQv+AHEZnCi7luC6V?=
 =?us-ascii?Q?dAoMJUalnRFWPt3A9RjWPWOXb8kVgkTKr8qP2aVEpn4URQV9IG0NJEpB8Lud?=
 =?us-ascii?Q?iBl6XlqwL/zORHQR49BxMbE+Jjmzo/3cV3i949FSTi0iE1/4P1MN0eU8AzQo?=
 =?us-ascii?Q?7aWmwa6BMG/P1Q+zmAzV7Stq7czAuxx0oTPquUIXEUjFHbhwIuz4DuYMRVGp?=
 =?us-ascii?Q?UigLaJobgs3CsxX9osVtxVpGfnsx669MHQV+rRnAPnSslMYWFlMWp3qPqcGh?=
 =?us-ascii?Q?rrUpoftLDEVhsQBrJPZkCunw8K2rY8yqy9zaYd3KpO3amBa0OiI+nZgjlLV+?=
 =?us-ascii?Q?zBBtxBw8KsV2uyyayW6RgYPoVgwbMdqN+URYXbTmQzksZC0XHM+dPbrdibLz?=
 =?us-ascii?Q?pcOjtBPYBtSks3GQypVhCxjofpUxIb8s0pJ3Df4WBquT7C22sR6LXNbogL7h?=
 =?us-ascii?Q?s6n0R6s6eoWXtXYS4L6kjXG+OQj6/ukLH/5JcQkQRWfAbtcvQig9UnfzLiwK?=
 =?us-ascii?Q?ot9fJP5A4RnoiuaiQL13QEOgFV1RXK+DrK+JRcopU3OSLjXXIBU7hhSmTkia?=
 =?us-ascii?Q?1JV7qVIvTbGnp/gfQMd/XwUNauyb+9ErFl440CWyWTu/CHsZMM0LF9Zifesw?=
 =?us-ascii?Q?syYQK+NpYwm5q7G5eACMCnC69i2mAmWxv7deS7YdndIAAtZf7wqnriBuoh1I?=
 =?us-ascii?Q?2N+lQtqoHD87riiGFLUZbk1OiqrnFkuNQJqL1R249MkKHouLxz2UM3ibBm0i?=
 =?us-ascii?Q?OA2hvTWPYXk4ArcM2iO3HTnb+gNPaVZ5S3Br2BhU2Murzu1GjYyNAzV716af?=
 =?us-ascii?Q?tR8EC8iFvDDMTzlBf2s9MRSgMJlDimtwD0jL32RBXmHVRHHua/h8wM1l30bT?=
 =?us-ascii?Q?xVXBHiCyGLUyh11sxsVAIOfstCWZsQYnjC4ncakQPeF9C/j6FadeUjeLTAG9?=
 =?us-ascii?Q?0bnkEncG+TtQmIXunTf5CNFEzaeWtQRNnbP0ffQk+OxImtwdsZhaDCcWmqAy?=
 =?us-ascii?Q?MC+NzMLs3mDV/uNdkT1Abz+3LbpQUHeXiF11/D3O1F6Pdn1wKw0fTUYtpPOM?=
 =?us-ascii?Q?ppXWiGh6VhjpgA+7iVfSXMXkXUb5wsaLiLM4jS4RVtx7oR4M34mTw8W+aIpx?=
 =?us-ascii?Q?1lfUaxv+t5AzJnf+VQj6g1UqiA1rxpGoNSyevOeakiwRMfD0Ejux3XPXDwts?=
 =?us-ascii?Q?miRhS0l6bW4+fLZdaqyLQDqd2Zd0RyO9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 21:38:43.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: decbea9d-765b-4349-508e-08dd14ac0683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Enhance GET_INFO ioctl to support retrieving firmware version.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 20 ++++++++++++++++++++
 include/uapi/drm/amdxdna_accel.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 1c8170325837..83abd16ade11 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -640,6 +640,23 @@ static int aie2_get_aie_version(struct amdxdna_client *client,
 	return 0;
 }
 
+static int aie2_get_firmware_version(struct amdxdna_client *client,
+				     struct amdxdna_drm_get_info *args)
+{
+	struct amdxdna_drm_query_firmware_version version;
+	struct amdxdna_dev *xdna = client->xdna;
+
+	version.major = xdna->fw_ver.major;
+	version.minor = xdna->fw_ver.minor;
+	version.patch = xdna->fw_ver.sub;
+	version.build = xdna->fw_ver.build;
+
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, sizeof(version)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int aie2_get_clock_metadata(struct amdxdna_client *client,
 				   struct amdxdna_drm_get_info *args)
 {
@@ -752,6 +769,9 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_HW_CONTEXTS:
 		ret = aie2_get_hwctx_status(client, args);
 		break;
+	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
+		ret = aie2_get_firmware_version(client, args);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index af12af8bd699..ea86c57beb92 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -375,6 +375,20 @@ struct amdxdna_drm_query_hwctx {
 	__u64 errors;
 };
 
+/**
+ * struct amdxdna_drm_query_firmware_version - Query the firmware version
+ * @major: The major version number
+ * @minor: The minor version number
+ * @patch: The patch level version number
+ * @build: The build ID
+ */
+struct amdxdna_drm_query_firmware_version {
+	__u32 major; /* out */
+	__u32 minor; /* out */
+	__u32 patch; /* out */
+	__u32 build; /* out */
+};
+
 enum amdxdna_drm_get_param {
 	DRM_AMDXDNA_QUERY_AIE_STATUS,
 	DRM_AMDXDNA_QUERY_AIE_METADATA,
@@ -382,6 +396,11 @@ enum amdxdna_drm_get_param {
 	DRM_AMDXDNA_QUERY_CLOCK_METADATA,
 	DRM_AMDXDNA_QUERY_SENSORS,
 	DRM_AMDXDNA_QUERY_HW_CONTEXTS,
+	DRM_AMDXDNA_READ_AIE_MEM,
+	DRM_AMDXDNA_READ_AIE_REG,
+	DRM_AMDXDNA_QUERY_FIRMWARE_VERSION,
+	DRM_AMDXDNA_GET_POWER_MODE,
+	DRM_AMDXDNA_QUERY_TELEMETRY,
 	DRM_AMDXDNA_NUM_GET_PARAM,
 };
 
-- 
2.34.1



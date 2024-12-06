Return-Path: <linux-kernel+bounces-435707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEA9E7B4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A6D2829A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8C213E99;
	Fri,  6 Dec 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1LziZ7kh"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37822C6D1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522428; cv=fail; b=WLK5DiR5pawt20Th3cyGHfL5GcCrXiDM275YKRiB4SF0MsEtD1uFo0pqLP7razuZhcBTcJky1IWuVuyXYdC78pb43ig8iX4a52SDzSL8OiXunN+L8JjdiIPjJc+1/SvXE62rD03opHjAq4LlEgC4geWTp+WGx+Bluj+BVoqsZ+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522428; c=relaxed/simple;
	bh=NRLKbLXDMt9xAJtFKAWZvfjT1KjmWSZPwzF9KfP7LHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxhTOvthm8Ui8oV4CXDfBV0NoEtS/fqRqsP4LIw1UH7MmPlt2TtP7yVxV44iSPoUCIJQO/Z1qo6C6ZTlHGwwnU7bQvq/XywR0tLQtQUjFXtHtf9Gri0Qk42kRbmJ7G2qH6JG+g6Su6oX9F6za7nRvwd5Ppvk2r3hnyOLVjNhTMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1LziZ7kh; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpRfd3w/iLNZGrkaK5NsA4rr0bayeUNeOCAr+aZyk78JSq/PcyYiYFZOnAGjGWxBEFMwgDWORwf8/Yc5uZjThae7RgFRVw99JV5+G/MMRFUQg3AAVCr44d8lLkh22i6K4/SZFYXOgzmqvG4EIrS6vlq4uQ+Jw/cDrrxuy44RsTNe24o1TTp+8bQzkrFCNHNGbRYEhrSq32kw1gA0wGBlMBPnyVjDarcKj0sqMKkA+GToPI/NUuzqQdy2haPOjZ2NZBOf8f5kvvby8yIjJwGMnzAYYcfDCXd1t6snJzrX7rF27etXR9yfBXuUCbi/+VsNYugFzJU+yq2TXMpd5RQd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwE5t2/5S1wLKlaP/pISPfBdAys8gh1SgeCIOUf489M=;
 b=sLfSL6t/Ei+wMLO9thSVPILjQPetRMEFFgUVVK/hKwddxfnoMXNGMCbike3J6XMNwTB5t3dz7MTxDlSyR6dWnw0ki4zSoYBbhadWAU1oiWmxgXa9XXfwZWdhM9w+aVG2Uka5AyDeykQ0+44LD1zffSwx1FvBpjnU3RPlJfZtFLWrJ+BEgtBLNhNt1UQqSK2qzOk32Xn7hjAbvdbkLwMLziTqfa2lIMOItEAKHT88l9BljcOANnJlxjKB/Rym7eO4+4eIFv5cwIpSyup3frxoA3Cj96TzK7u6Zl7VTapCsLAAxapJuMNjt48hkeQYY5BCqIRWLtMS2UMhVVu2Law14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwE5t2/5S1wLKlaP/pISPfBdAys8gh1SgeCIOUf489M=;
 b=1LziZ7khkr/gczEq8ka4NViBplwM+btP5Lz/N1/w1qIp0o6Lk6GtCzQ7kzLd8tTA/CyGc2QjRmbgsslqut0V4uDeFo06HY6b013SY5aV8I2TWK9OfAi9yOXRi+LyBsSAFI2Wm0ia5j5Eze8VNS12gk/Dp11a030rQ03WVPFF63k=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:00:20 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::85) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 22:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 22:00:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 16:00:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 16:00:17 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Dec 2024 16:00:17 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V2 5/8] accel/amdxdna: Add query firmware version
Date: Fri, 6 Dec 2024 13:59:58 -0800
Message-ID: <20241206220001.164049-6-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206220001.164049-1-lizhi.hou@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf3c90c-ad7f-424c-6f0b-08dd1641609f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3BPMpl0mEXgl9ecxo9UXg/xvD9t54Uz+iFf9bqk1qPbYEGtyprGiENIVCbvS?=
 =?us-ascii?Q?Q+u+TanNgiyJaT5II43a+A/Y5sCwJPxgbH4F4ZsThdQROpRtCjrWs1d0nXbq?=
 =?us-ascii?Q?rdvfHNJXm3AHRzmZQMz+53NtenX3R+1vsbmU1+A1NBNuMM9+3bbjd5lk7w2l?=
 =?us-ascii?Q?acGMlNntp2Ltt0npWVP0PyZNcBXAJQ0JBeYngksTwpaz74pP+dUzyZbboQxY?=
 =?us-ascii?Q?LV7+UXNiPuyrhL757Uymo+c05IZyOhSLx+znzg+cbLIvhYilgUKMn/YoFx80?=
 =?us-ascii?Q?ZzuW1cYf9OZJTSt6ajxx3FOIWFk6xUXEp9ou6nzT6uxSnVHch4cmh1aczy2s?=
 =?us-ascii?Q?N6/uRGw5eepmq23mMDm8HULsII90WSAIME4/4SVNxfIvAdEfZ8JrX4c5cuiw?=
 =?us-ascii?Q?tbPAOGTG+qx/4SNkRr21mG6/99hdHTkG9XdIQq/VdgDWkPb0pew56H0834sB?=
 =?us-ascii?Q?TkTwbjR3FYH5QbRLfxx3e/K1MPZqxQVWm+ef8+4D/+yHsFZoLu42EhC1v7mI?=
 =?us-ascii?Q?HO4VNjxrgDxPAi1W5ynAGXE5tOu/ADvzecQ8l9HtfHtTX4zQxrSDFpIqKJhE?=
 =?us-ascii?Q?ULg3WlSPwf72S/1Fib1DiwzAQFkpecHeHQepi0dSCM8brCF8SOaVyNDi+KHg?=
 =?us-ascii?Q?+IHX+AnyVEi97prKJid3xInYoZ7RTuFYr/j4RZE2GvWe90s+HBs7Ro7tFxw4?=
 =?us-ascii?Q?3UXk6sdOsGlyTK06Vmqa7ECnoUcV+clKruhKgodn5k75cIJ8Fv1vzPpJYcVJ?=
 =?us-ascii?Q?Mt98Gca8yyer4a35ksdb7G+oN2NMqlRgel9GIiUrfksTg5s2OrJBk/nfnELP?=
 =?us-ascii?Q?Ahm3km6HXnzMUkWyhfUm10KPZQ1Scu03Glws7C3a0PHVkXdjV8AKuk7yWRDl?=
 =?us-ascii?Q?gl/EfroC+PlNLuNzkxbh+Ytct5s9iITRs8T7AL3+jLYMcq2t3DTwtLQFenB0?=
 =?us-ascii?Q?U1j3E6ju8FRhSJxlAUF+sgR/w3eiQzLY3Wj0kjaItOD7iDA3tnDHYOxo0I6b?=
 =?us-ascii?Q?d9gj3UQkaIzwZr1K99YEb96nJhS31RM9J8bQddhqZLHPymnHl4pCZkH3He7/?=
 =?us-ascii?Q?n1XP+M1uKDAepomOJnY7QDdU/rZaecS04+wXy+M+FX0OT+k/6XtuIpExE8vh?=
 =?us-ascii?Q?GhgDl0/SHn/EOhrx1j4kAxOg7gPXhUCCyCsjiRPt7yA9fIbB+28ztXg5PFbD?=
 =?us-ascii?Q?inmVEGImUNpoUY5hCiVXsRc2eZtzDdtkj+WkUEzaH4k9zGAlQIAuV/3x6J7P?=
 =?us-ascii?Q?1nt6P7D7ERn5goWyQ4urnrif78kBVBRHvSpyLljjxhXUbbNxwFsjyh74JwaJ?=
 =?us-ascii?Q?FR59YrLs2psmVoCMYdgqziEN46kX3vSn0Q8DnohVTVGG5DgfZ+S+rbF38Duo?=
 =?us-ascii?Q?vyhWOK5etWsby4WDyOCEIbgSvmrjDJ3DDCGkX8gDxIxz5kiJfqDQGJye2O+6?=
 =?us-ascii?Q?HHxFtHeRQggFkJ4Ou5jjMnm9cZVUYnFK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:00:20.4818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf3c90c-ad7f-424c-6f0b-08dd1641609f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

Enhance GET_INFO ioctl to support retrieving firmware version.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 20 ++++++++++++++++++++
 include/uapi/drm/amdxdna_accel.h | 16 +++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

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
index af12af8bd699..4f15e53a548d 100644
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
@@ -382,7 +396,7 @@ enum amdxdna_drm_get_param {
 	DRM_AMDXDNA_QUERY_CLOCK_METADATA,
 	DRM_AMDXDNA_QUERY_SENSORS,
 	DRM_AMDXDNA_QUERY_HW_CONTEXTS,
-	DRM_AMDXDNA_NUM_GET_PARAM,
+	DRM_AMDXDNA_QUERY_FIRMWARE_VERSION = 8,
 };
 
 /**
-- 
2.34.1



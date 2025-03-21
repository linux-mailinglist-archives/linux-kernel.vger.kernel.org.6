Return-Path: <linux-kernel+bounces-570877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D374BA6B5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA6189916C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85A1EFFA3;
	Fri, 21 Mar 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3+zhvy/V"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3C1EE7D8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544087; cv=fail; b=EyTOXEOsB3Uah/q2w8GLC3M4eGzRFCFBGifiVJjBqM48G23+qf7mN5xl9QKmX2PV9UXUU2F9OhmYMRuTIeHEVCRPqXZywzgncZ3+hp/k6tSJfdh18QSQwmOA0HVc1nyfMm9P7wURBEfBi7K8ALweMrSY6dq9605I7tANMqbbkCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544087; c=relaxed/simple;
	bh=CHzSjb9zguNtN5DDO8uiq5qBLFg5BU1E8BZ3xKGLfaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPWJIR8yV48VzEkKTyVKbYPnMxsciWv5fdiEMIiPDo2xnyN2P+8Sfwefxy6Hk3ql3S9efUiUvy4f8cCcuTdsC4PmM46xmvpzAQSOBxcDWX2cHkYQ7QinrIY5ajnaSRiEuJnCRswZEFhg7nmTc6PPvP2F+rRuIW9+cr0wV95C8v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3+zhvy/V; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdxaQH7UatbImrZKA4uDJK97/hxHxI1E7sjTyUlnzCCpInn193cBN4na0SMv05G3lSgzwXzdNIJ6kHRkQFYha2zHvVBK4mN8QjnSgeBPW8uz8gOjopCHrJRypwic8lP8ILSLvLQQbv7Tf1D8iQYUkZx/7bC0allCXeG9U2NWPIqSCEbIQJ4rA6a+shyDceoT18FHSj7kcvfSFrIOFimm0piV6KEU028qefZ7QyKZweIzKFcKVLAFH6vGPrgRrYR6loRYtiYFcdouFUtxrShWE5xTPfcVT08Jsj9Sz1mavGm1ow15INZDB4DNK3s+oGGZFZjT0XcZ+Zn9rcvAx+2cfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n49a1sg6WxPz61LI+gIlE0wSqV6yReAXhsWydBLFgyk=;
 b=n4U+lXlmCQ9W5982iCEx3OD98BXpFOndcskqhfUPQnZsGPRMX0ZtnJVgKrIXagDHbbvunhSFuaKJid7RNKs/5bcZ4GhcPFok+KH2+qd3zs9sJh386Gf0oESubrZKN6g7tOm1m7mZkb8DSytjm8kVIN1R7zw1FAagZqaWolkqbvWv6Ho72hnefRYnngfqq/SDxorqPZn0wcPhfTsGE7XYFuMD6K7Y3CR9Fd1N+Yz0j6JrSxAN86pL6EFP24AYMlKS0wWF+FUmLeThLia3Jra+mv4gP4/C20omGyTSXN52b93FWqU6Nh/zoP4SRu+bqFJXSKeAfkJpzhS1Xdgtdwe2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n49a1sg6WxPz61LI+gIlE0wSqV6yReAXhsWydBLFgyk=;
 b=3+zhvy/VXkLM16hLv/hLUqWiq468i0HgoO/iYPeS7cF1Azjke8ZFBwkz723CmbIqLTYCG2R7jX6PXm48JUrtyR5KYlKiRmzOsBqbKgDoIBL2DhWXkYWy3WSe+WREdazRiLdwqyP5YnNNgsLsyqRkHImosrcRBxNHz2SM147DrXc=
Received: from CH2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:59::34)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 08:01:22 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::9a) by CH2PR03CA0024.outlook.office365.com
 (2603:10b6:610:59::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 08:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 08:01:22 +0000
Received: from jenkins-honglei.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 03:01:17 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
	<simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, Huang Rui
	<ray.huang@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Honglei Huang
	<Honglei1.Huang@amd.com>
Subject: [PATCH v2 6/7] drm/virtio: advertise base userptr feature to userspace
Date: Fri, 21 Mar 2025 16:00:28 +0800
Message-ID: <20250321080029.1715078-7-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321080029.1715078-1-honglei1.huang@amd.com>
References: <20250321080029.1715078-1-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7456493b-904c-421d-b9b4-08dd684e91fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dx3Uz+yHkBMQiNQTX55cL8y6kkkA/AWH8JaMFISourlOrMu2L+KTFCSKbPbQ?=
 =?us-ascii?Q?0YQb2Sr/2Kc4Dtu+kn+Bebv3dLYcOa++66vjhBiidFB7bLYaCRlDkhtDw+C6?=
 =?us-ascii?Q?36tsCiUJh5Lb3XJH4Q9xsmgG+yLE8gJ6ehpZ9YlGiH+e/0eBLBeV8blhvggo?=
 =?us-ascii?Q?ZsD2y/IC9DoB75XQ/jHPPKHJLTOrJl3Qn3dqVQk0vnd45TqcX7qvVKXVutet?=
 =?us-ascii?Q?uVP3BSK8m37WhnHy0f+Fvbe7yP4RiSvG3P5o6l96vgNtj7Y/f/HxFydbQuDI?=
 =?us-ascii?Q?OdzP+NIEyrhukG32vowPswqxrGgkbITHqNbCNFh5YDFVJaJ0D826WexLpLKx?=
 =?us-ascii?Q?2i1z8TKQ2YHy6N9Kjm4DGVYN2bXkxLZCGG7nxPVmTqSUp7MH1OI48xn9yS8w?=
 =?us-ascii?Q?Bhm68UpotvHkdqansxhPJKS6xupNUnpFg9SQofTj4ihoKsNrSTzhyb1Xo+E/?=
 =?us-ascii?Q?fc5sfhoIZL1XDB3H5t7sw20FEzemuTv322uKuQSDQ9huIxo1Pk7ccPr+WMo5?=
 =?us-ascii?Q?2rcWL0Ggxet+zm8Fgk110hKu7ruOxM8x+uBWXg2QkY0CE6iVluM5FbuLP4cj?=
 =?us-ascii?Q?Q/LJiTENjs04qeZHbjCQ9JEy6H0IfBxSGGA4mqY7perVXLNAMI+mbZVFUK0b?=
 =?us-ascii?Q?edO9mhn5AbQnMdmfXKXWilotaDk1TSdmMJhl4D4Rd+y+UzNP/XesjCjet1r1?=
 =?us-ascii?Q?KX+fifqnJzhwbecMbDcTP+yH6ZZqLr2T3WCOfeC+OfMih1ormW0foq34uXD0?=
 =?us-ascii?Q?+6AMRPSAk1pwxnrDGhzdw90x18oP3M0IJ4FvGeGByzWtM1zHBXfNtOJGIDh4?=
 =?us-ascii?Q?8kHsZQu8J7WH339uY0YLtT2iLSCUbbBJNblZdf93dqEOVFMQZTe5eybVthiw?=
 =?us-ascii?Q?sbZxg2ah+yxJb2DjkpmN4G2KYUn1Ni0h2/N2Cd9qSO54xRIgKlhOGKM/Q6Ho?=
 =?us-ascii?Q?PC9mbj+L/rrfvUr9bRoyR92YHsv1xhfSIE+jcHFxraxiR/eESxucNjhgRGO2?=
 =?us-ascii?Q?zzT9aqHPnS9z5E27lXaNIsi6MlSqXYchKAtmBttK5/DRDqqirWqF6ykZbphq?=
 =?us-ascii?Q?fLecKNYNXyY0yBXXVI35HnLKlOHnABfMC2H4Ib/GG4ZG/7VGPN+wE2gIMG5U?=
 =?us-ascii?Q?P50gi0iED5KCF++6tpgkl4YtKlA0Oamxh3F3auP+lZFZI9p6vCGzSXjA5TB/?=
 =?us-ascii?Q?BUaOq3LTEsHhAoKTBxrDxbPoUExEIHbBtPrYzK/WGG1ZXuCQ++McSUpoJH4e?=
 =?us-ascii?Q?i8xJNDqOCMuizJeuHWKpt9+1DLAnMgzs9JZ79/MBjmr4NroxOsXj9w5oOFlT?=
 =?us-ascii?Q?HhZCPzY03MJWb78WT5Quc69nV4jCkpIxI9cGk7RFw4jbEGouNTJCInHUpWne?=
 =?us-ascii?Q?gvPY1by6VoIreH3jIj/71Wt5tOPLSVh4CDqPWvmyixDJSWDeQxTIQ681F/Rg?=
 =?us-ascii?Q?JmiOY6yLn8Yp/Hix/ktSOsYJycHW4xJfB7QYDM79W9EtRMKOiJq8wpe5/Xw2?=
 =?us-ascii?Q?Geh18ddGjcpgQcrfzZO5qCsrngTwVQdp4M6/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 08:01:22.1825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7456493b-904c-421d-b9b4-08dd684e91fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

From: Honglei Huang <Honglei1.Huang@amd.com>

Introduce the basic userptr feature to userspace.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e4f76f315550..8a89774d0737 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -36,7 +36,9 @@
 
 #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
-				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
+				    VIRTGPU_BLOB_FLAG_USE_USERPTR | \
+				    VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)
 
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
@@ -444,6 +446,8 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 {
 	if (!vgdev->has_resource_blob)
 		return -EINVAL;
+	if (!vgdev->has_resource_userptr && rc_blob->userptr)
+		return -EINVAL;
 
 	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
 		return -EINVAL;
@@ -489,6 +493,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->size = rc_blob->size;
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
+	params->userptr = rc_blob->userptr;
 	return 0;
 }
 
@@ -527,8 +532,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob && !params.userptr)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
+	else if (guest_blob && params.userptr)
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
 	else
-- 
2.34.1



Return-Path: <linux-kernel+bounces-537799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E64A490FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF4E1893792
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8C1C1F20;
	Fri, 28 Feb 2025 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oe+atheV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F11C549E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721069; cv=fail; b=TTR6TzXagwPa//UnSd8g0cs7HFblxIEDn2XKO1YsRCYBrunTo6AKwDOMHccN79N9rDCv2Hv6/Ws26viQ+f2Q6EpuDSLN+bScytoEHHfnPPXsN9HQWnSmpGi7g+PPq6ImKr2YyN/kSF1IC/c5Od2uqpdUSVKM0EuH96NvyV8sJlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721069; c=relaxed/simple;
	bh=CHzSjb9zguNtN5DDO8uiq5qBLFg5BU1E8BZ3xKGLfaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axuntGQPdG1eYkuNlnwUxp5XXxrXOeGXsZcI1cvAPBy1/jJwgOleQBqPPs9Ic91bzmr4OuEEWT9pZrVIF7fmN7KL/lTgXKqn2ocYYPLBX19iw/ZyKjSG0BZu0lZCrZGAxEQZx/Ei0KIUvNA4WO+Uy6TqPi767npTW/KgiQdrQGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oe+atheV; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPnLrC1U5o9tRYepaRCwvRLZ19siMcq3mkKQDHroEV84B2Metdw/Tkn9hvGVc8Ok7bz9+pknt01DvEl6qt8XFeRXTtfMcJeZ3c3wujo1ouSB74UydaA9ZlZWMUuzjGsf4vzdRn1P/DhHxJHcLlWAa0e71Ou8a7hGwKrFuQnP2oDIvdMydfGSDqIsMxwVawPQouY7AqQQP6nhOcmrzjo5hh1C/paMvap5k0eA9eu6VynfVF8QmfwmSDGz+8Rd1I6FrbF1WMwJ/t9mErHAiabsONsBUEDf0N8zjVUrM8lbAOeqZBK0Pfbmx6vgXUhJTmDGmjENebfpMi+MkRBlAd+7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n49a1sg6WxPz61LI+gIlE0wSqV6yReAXhsWydBLFgyk=;
 b=g+buhE3Tg7Z+NkPw8Zrk1dDGxTaBD59+JiAJqWCz/meGX2eC1srs0x24z5OoqRlCMyt+adLd68PguiPIeFHv3zB5LCzGmaIDfw1sqNUqlnZZ5VPtq18ySkd6yP6BnTiySthVWfINU7QNqSd2bKaObNAZ9UmL+wISWQS3Y0mLgplU3QaxAgGumsaKgN0ItrVm7sjJNR5Qf48PMbAbASrOHC8xV3EFxtWd4oOzDpRnRX9N3mwWNgKInQfNWzDkogTO6ZM/qHVr5Sc+XvQV4LKZlB66g9a8u4hLLT4/DFT7bNQ9maEoxEqLvGVXegoFxuQ+G5301VpnoAFuuwVaWBjSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n49a1sg6WxPz61LI+gIlE0wSqV6yReAXhsWydBLFgyk=;
 b=oe+atheVErnKW1GM8pdGIJZkzMC9EkHMRQaG1xSZuZscftjdztSiPh3FreXBONmUrdaGQmy15z1dwu8PW22N9V+9zGe8GZKIgMw0sze5ufBFoSxMFlJr4qx477hv6/Ode99x4B1LY/UDHOpsaWThDN5AL92eHigY0v2N84Cn90k=
Received: from BN9PR03CA0095.namprd03.prod.outlook.com (2603:10b6:408:fd::10)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 05:37:44 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::e1) by BN9PR03CA0095.outlook.office365.com
 (2603:10b6:408:fd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Fri,
 28 Feb 2025 05:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 05:37:43 +0000
Received: from jenkins-honglei.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 23:37:39 -0600
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
Subject: [PATCH v1 5/7] drm/virtio: advertise base userptr feature to userspace
Date: Fri, 28 Feb 2025 13:36:48 +0800
Message-ID: <20250228053650.393646-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228053650.393646-1-honglei1.huang@amd.com>
References: <20250228053650.393646-1-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c9f902-3539-4048-8f40-08dd57ba0660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+UaeQYSUgltjVcTUWPXSzoYCn71SwOg07WZFnqdmp3q72MrgewnOgFGZeiDy?=
 =?us-ascii?Q?aaMW3Ih2tXk6/iIZeQAYL4yZBKoopTYYdtXPbNYxlQh0NHDby3yBdcLcXbDn?=
 =?us-ascii?Q?VoFc+EqHw8sC+PFvap5GEsXrcTFdUprY0vNC5tnXiry4gMs9P072/ddIQL3I?=
 =?us-ascii?Q?E6InRCaZYWnYlgH3XIyFBIc1bRAyuZXJXLWRk/TwQBR9TN3RooNw7MypteGu?=
 =?us-ascii?Q?FlbDFwMkjFDQJ3Zqgn6Nb64fp34Ujumt3Aj/BHApBM9UVuzkoDH2/7Hy2ROq?=
 =?us-ascii?Q?j6MQx2fTbuFXQYZHL8gPCAQjFYUeCsgtbAoOa2bUQrX63HHX5/qcKfIaS3lX?=
 =?us-ascii?Q?sENpS+KSz6HmmNgPDyMtkpclSvU+HfL66PxL51oSZY05YmBGsAEN3yu4bsBi?=
 =?us-ascii?Q?SwyUkRIWdMrPgFvHgNamkbOhdCeuXh5oT2zev4zb04pMp31h+lgqzpLUYGzb?=
 =?us-ascii?Q?7d20Ok2o0+fyKVXz1+/atbPcIpQGb3glY/s3FdfYv1XV6IHl7to79cv05BH+?=
 =?us-ascii?Q?aB14KGcPe4OIkf7Qx3JnOjkx4ffQSU8ACVYuN2DDcNF/7d8o2aVwnoWwcJ5H?=
 =?us-ascii?Q?6tmcp1QKkXUDtY0OdAxraCtlEjnwF4BWyHfLNfV3OJmq4/P9Ae4Mzw0HeFX9?=
 =?us-ascii?Q?85RumQTmC0+iXmF+2Gb5WMX7KOwH1u3l49s3zzyiYGtT75EpVRVcYO1LSA2A?=
 =?us-ascii?Q?bZazAz52mNaBRYGElGJGtmGWcTsIMPr0aNYpgJY3c9Ii6jA0Xl+7zXV+GIaL?=
 =?us-ascii?Q?bALOL8r35aqR2NwSHLEtw7UhK7MUcy6bcWe/Xd4vpNXq8ey8zIej1pfaCo+D?=
 =?us-ascii?Q?A8SUrZe4v4LjMIkLNwfv6ELfk6UFM90ddfYTSjZj2KM+v+PBDBIwMm01l3Wu?=
 =?us-ascii?Q?dIGyIAVzgsDPIwVVaHPMqC+CNwwNJFaLoAGR75yq2Siaqqm8/MdsnxCo1rsS?=
 =?us-ascii?Q?H9BSabF1TTVEL97oPo3g1HDLZHOtFmpUEor+flqQTVF/o3tSys2bbawuuFfz?=
 =?us-ascii?Q?FG3BBhhPmISEU7qHPDk0umtst+zNLkqzjeinJnMo/k5Adkrs22rcfp3/ZOuB?=
 =?us-ascii?Q?SENlPXL+g9x4TGSFlb5wBjqL+lMAPIcLcDC9wo/Zwf5S55PPnZ4Gm69cecCC?=
 =?us-ascii?Q?iRLSoycbRt3jaJq+clTNGP/NJdUp5m758mlgIWZLCk+1MAGbKXbuTKL/FKXd?=
 =?us-ascii?Q?QUxZID6qNYPNsfvKscqA/H6klFfNt/tyXeCwBuXFUq56QP8+HRUWWekV++m8?=
 =?us-ascii?Q?WRWSUSGIPiJ6iUWoUsqJYZDbVWp30CiTaqBWQHQJL26DIgydpV+0ml4FQmok?=
 =?us-ascii?Q?LLrjkqtwU8sh64KRT/F9rnv9JxNGKkXyvsRwlZWYwOMCssj+0Z1Z15wa5RQo?=
 =?us-ascii?Q?iNNJ0Nv3y3WMMTmDGOp/xd1hvbtNHcuk+grLyQKfcylDOxH0EQkg0MwDropM?=
 =?us-ascii?Q?cV9dde6Di85C3DYHWUcyK9ykC088gmnA/Aff/zzrQ2NAUUGZNJKK8cFuuctO?=
 =?us-ascii?Q?ecsSk2nYgg963jv9DycLr7nPeuss55hFPSGL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:37:43.8534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c9f902-3539-4048-8f40-08dd57ba0660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

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



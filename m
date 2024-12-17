Return-Path: <linux-kernel+bounces-449610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F159F5171
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846BF1687EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07B1F63F5;
	Tue, 17 Dec 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="avB3tEYP"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAF14A0A3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454517; cv=fail; b=vE1Ai7bNsHa+Trlqo4zV0Jr4Scgjg4ZF3kFDtLYwG9HD1ZA4aTl8LyjDgqeorbTafspDPlqZQVy5qmLUtbzX9Sj8UKl1RX3CLqMJWo+UvT4FjYLoLxSU+6YahQb7+nFwxFsh+RF00IUhQZPUSovPA6Ykz3hma1ga+w8f0YLR5Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454517; c=relaxed/simple;
	bh=ttw1aimfYrvdgreCH5bOCQL1BpUH0VqExt2P3ss1Gao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E38tGyW52mhlQVl7ijDiRSdOA/ZbhBQuJurJW0Eg6PJrfcDWahqZhjgfrWmUrB/NkZW2TuqgERLZzlkgPzihJHezfUCfRNQIKe/LCobWjU027RbCXvOhogn4+OFELPiB7PE5YSSt/hvHki4NfQueWTpM/18KIRZGBPhJjQ9MZlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=avB3tEYP; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PElnOUJc7fA3D0JWA+IdpZgc55XWdCjjXWSnjsgCmic34O2yshcsAfH0+Mf0gS6iyuZRym8M9D5eGiYQz90zgV0CvfjwBNmkMSQBMktpwwZGks/MhT55iooohYMzWDdrrrC1ALTCmkr5oK6UsasKZBzeEjKNmtPZum4bfeoiWYOAanOvQsl3bdP2d4VvET8lAIcmcyVfWzBTeLa4rbgxKzIU5FxCFvv8mVTTgQMgx9DrR00iA+7EUOwRfMgh11pvDCq4NkpjV4Phm9jvsqDMtSdv43K+h5xNcZUPxntvwRDIwlfymXf+vlJ2j6Ke60JRe/l+u+ExYFUboJ/m5F4K8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VrqIn8sGIpZs2MteK2ACxFjELnBUlDRUvOk8O0vZs4=;
 b=F7H9xLwiPp/xFxgQzYn2EcsnOycf8seb2AHsLEGSfDRVIjadrORiB7kn21xPyZLU1NAj9eiQ1FZlx2pX36LXdbMdQLyuXPGOH6rzsBSQDTftKKWYg9MivqgSJX5RpsrBF3EuekkbCyC6TT3gqqmYxx/iy4fmFFqQddXVKfBmrRDSu70ft4OI3FOs57oN4q5PRz75LQFr/OWUMxYJbEgj4VpU3cUB/L7dA8+BzdOVfPY9TdveFKNpAwqoG3tc3MKw2i8SkAQ4VNvNWC31skn0TpxV68wZngZF5Vd6et7ABg0AEUCA77R66IVHQJ+7EW6QgdtFubQ9cn3JjV7muOe0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VrqIn8sGIpZs2MteK2ACxFjELnBUlDRUvOk8O0vZs4=;
 b=avB3tEYPkAhbRQCfRaTgUtKdnEqNdiljU1yswCa5mTOalHqd4+WTzROY7s8AdStcypWcq6aWRsZc8APgsHhXFIN731CYVYLohDVLg5d7zi4VacCBQtuOU/4+mDbBDHuEUnoW+XWF41nYORElrVUvqSCLY9Yd3aIvfcd3Sxc7UEw=
Received: from BN0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:408:142::12)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 16:55:12 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::42) by BN0PR08CA0019.outlook.office365.com
 (2603:10b6:408:142::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 16:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.6 via Frontend Transport; Tue, 17 Dec 2024 16:55:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Dec
 2024 10:55:10 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 17 Dec 2024 10:55:09 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V1 1/2] accel/amdxdna: Add zero check for pad in ioctl input structures
Date: Tue, 17 Dec 2024 08:54:45 -0800
Message-ID: <20241217165446.2607585-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 631930d5-6fc8-461a-107e-08dd1ebb9244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UOzAcDgVce3ShoS5CE6rxUxK1zRZgFXHi0JHJY614OnbsuNbdrc6KMvTS2Zr?=
 =?us-ascii?Q?Xo0T0shhWPywVBpVwFwIr/tmSfvsEu5Ieb0VFh0ZJPOsVTRqAEbaty/HFvcz?=
 =?us-ascii?Q?ftdlWV1sJV2lHBshiBB+EFdEf2aP5Y172X7A8w1B9XOxH++M/9iiitx8RGs8?=
 =?us-ascii?Q?s9VgUlUudn3c9kiL6NJ+Bc0uVXH0NnyjuETxb2x4JJBQsW1bPuGq5usWTvLV?=
 =?us-ascii?Q?oFU5asnCTtcZ9yinoqCcKz3WWtK82VI+Xx2crxM5hMqxQU+2BXpDRo0MgpuS?=
 =?us-ascii?Q?NxgXyHS/yoXm43GAaQCIqW6llhMnuOGo84Zx/Wu0Y6p1mfHDeLxgooz6A9Fd?=
 =?us-ascii?Q?ury0dDkmOR1KPRaIXfeKy3WG2pDn6WYJmn4bvca+WvRediW7noZDyOx8Galw?=
 =?us-ascii?Q?dY3ZXF0H5/BHFcjUG6sZe+8pbOZ6a62FSGn+GwQTwPZyjOxgC8+4UZ0r/Us7?=
 =?us-ascii?Q?wjHgFS7OyyQUok+26nQ1rdwinprbpNdocDf8wZLpM+pzDohxjmIkNTZUMXn2?=
 =?us-ascii?Q?TdaUciCXWyauIVynBPwn41MljA+bIo8q0EuCmFa3NVDPQTfYKfoo5mO7/kDw?=
 =?us-ascii?Q?XUfjn7TsdQTxQBpDFTZ0n+gkLxrf6tCHauHecONZdEZxTC2sPfwh2dXvT56k?=
 =?us-ascii?Q?ZiBVLL18cOQYkasCPWExy+ZMKcIxMKKLxVfK8zfPp0Ee1Gta1U3iQilTu6WB?=
 =?us-ascii?Q?JXvmZctY0T9So69eMU6d9iNpAeynk2stDvJYQFLWgh56GqumzaUvqZIqEyxk?=
 =?us-ascii?Q?MJ1Sy/RWNhowvEqhXTpGNg4SdbsgF3ywy79clAc5Ers8p3wWUh90hLPibO3g?=
 =?us-ascii?Q?9lFxbJirIhtGQa8IbKiDjUciymbjmaJ7QUkzT3FNd2oib7+E+uWF8SMGCtFs?=
 =?us-ascii?Q?TCuitpmtDUEBFyi8KSRv++jnw0u0I9mSS+zjmI16WdokhGeJrg22ImXf/uBZ?=
 =?us-ascii?Q?+/RpB0dYM/+UVrgdyHgciurAYRzTx2Fo9L6Y1PI5R14hAeb/OSsJ5WScwzdb?=
 =?us-ascii?Q?k7OteLvnnlErjLRkHC4ER7il4rm5JWUD28C+i/IAr6s6aKvd3X7tjW3KfE7i?=
 =?us-ascii?Q?/lxk3Eo9rneKjVaaP2I0F6YWv49cVW4atl4Oj+h+VxejoXtmvlwiCUU6MeRP?=
 =?us-ascii?Q?dVUk5URnPr2JbexfeZcR2QXufFESjfGrnZG8TQrjfg3BqhyBN7emK65ORZIT?=
 =?us-ascii?Q?ty8uNQTKpkIAQdbSoQ7/+py7n7pQtk/mbBGEa9mkcYMeG0BWAt1kRytjZJxR?=
 =?us-ascii?Q?NxZYN89HmjNnrIyeKmJv3LbvXCSZ1oPucA1LNimX7HGkA+qdh31GTC9ElGtG?=
 =?us-ascii?Q?cAlNXWDar3KSMV90L34gecqDBIx87MVZfhprlCaSuUAZZarHPhZB94iaGLwp?=
 =?us-ascii?Q?vgipwS9Ahgkn6t8ZCQEBWB/nt9J9hi9S/FdbuvEyuFcJs3l69RqRCMdnLj+F?=
 =?us-ascii?Q?MBRFBHpRmZeMyiW0gh3iD0y0ScT3dk9se3Jw8TQSQTqLScUstgqIMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:55:11.7349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 631930d5-6fc8-461a-107e-08dd1ebb9244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043

For input ioctl structures, it is better to check if the pad is zero.
Thus, the pad bytes might be usable in the future.

Suggested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c     |  3 +++
 drivers/accel/amdxdna/aie2_message.c |  3 +++
 drivers/accel/amdxdna/amdxdna_ctx.c  |  6 ++++++
 drivers/accel/amdxdna/amdxdna_gem.c  |  2 +-
 include/uapi/drm/amdxdna_accel.h     | 10 +++++-----
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index cdeead75c6f5..9facf45818f9 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -690,6 +690,9 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwctx *hwctx, void *buf, u32 size
 	int ret;
 
 	XDNA_DBG(xdna, "Config %d CU to %s", config->num_cus, hwctx->name);
+	if (XDNA_MBZ_DBG(xdna, config->pad, sizeof(config->pad)))
+		return -EINVAL;
+
 	if (hwctx->status != HWCTX_STAT_INIT) {
 		XDNA_ERR(xdna, "Not support re-config CU");
 		return -EINVAL;
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index b2ca78cfd0a7..9e2c9a44f76a 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -395,6 +395,9 @@ int aie2_config_cu(struct amdxdna_hwctx *hwctx)
 	for (i = 0; i < hwctx->cus->num_cus; i++) {
 		struct amdxdna_cu_config *cu = &hwctx->cus->cu_configs[i];
 
+		if (XDNA_MBZ_DBG(xdna, cu->pad, sizeof(cu->pad)))
+			return -EINVAL;
+
 		gobj = drm_gem_object_lookup(hwctx->client->filp, cu->cu_bo);
 		if (!gobj) {
 			XDNA_ERR(xdna, "Lookup GEM object failed");
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 324f35c43f6c..d11b1c83d9c3 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -243,6 +243,9 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
 	struct amdxdna_hwctx *hwctx;
 	int ret = 0, idx;
 
+	if (XDNA_MBZ_DBG(xdna, &args->pad, sizeof(args->pad)))
+		return -EINVAL;
+
 	if (!drm_dev_enter(dev, &idx))
 		return -ENODEV;
 
@@ -277,6 +280,9 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 	void *buf;
 	u64 val;
 
+	if (XDNA_MBZ_DBG(xdna, &args->pad, sizeof(args->pad)))
+		return -EINVAL;
+
 	if (!xdna->dev_info->ops->hwctx_config)
 		return -EOPNOTSUPP;
 
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 4dfeca306d98..606433d73236 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -552,7 +552,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm
 	struct drm_gem_object *gobj;
 	int ret = 0;
 
-	if (args->ext || args->ext_flags)
+	if (args->ext || args->ext_flags || args->pad)
 		return -EINVAL;
 
 	gobj = drm_gem_object_lookup(filp, args->handle);
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index e4edb52bc27b..92eff83fac1f 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -87,7 +87,7 @@ struct amdxdna_drm_create_hwctx {
 /**
  * struct amdxdna_drm_destroy_hwctx - Destroy hardware context.
  * @handle: Hardware context handle.
- * @pad: Structure padding.
+ * @pad: MBZ.
  */
 struct amdxdna_drm_destroy_hwctx {
 	__u32 handle;
@@ -98,7 +98,7 @@ struct amdxdna_drm_destroy_hwctx {
  * struct amdxdna_cu_config - configuration for one CU
  * @cu_bo: CU configuration buffer bo handle.
  * @cu_func: Function of a CU.
- * @pad: Structure padding.
+ * @pad: MBZ.
  */
 struct amdxdna_cu_config {
 	__u32 cu_bo;
@@ -109,7 +109,7 @@ struct amdxdna_cu_config {
 /**
  * struct amdxdna_hwctx_param_config_cu - configuration for CUs in hardware context
  * @num_cus: Number of CUs to configure.
- * @pad: Structure padding.
+ * @pad: MBZ.
  * @cu_configs: Array of CU configurations of struct amdxdna_cu_config.
  */
 struct amdxdna_hwctx_param_config_cu {
@@ -133,7 +133,7 @@ enum amdxdna_drm_config_hwctx_param {
  * @param_val: A structure specified by the param_type struct member.
  * @param_val_size: Size of the parameter buffer pointed to by the param_val.
  *		    If param_val is not a pointer, driver can ignore this.
- * @pad: Structure padding.
+ * @pad: MBZ.
  *
  * Note: if the param_val is a pointer pointing to a buffer, the maximum size
  * of the buffer is 4KiB(PAGE_SIZE).
@@ -175,7 +175,7 @@ struct amdxdna_drm_create_bo {
  * @ext: MBZ.
  * @ext_flags: MBZ.
  * @handle: DRM buffer object handle.
- * @pad: Structure padding.
+ * @pad: MBZ.
  * @map_offset: Returned DRM fake offset for mmap().
  * @vaddr: Returned user VA of buffer. 0 in case user needs mmap().
  * @xdna_addr: Returned XDNA device virtual address.
-- 
2.34.1



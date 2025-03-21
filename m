Return-Path: <linux-kernel+bounces-570875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFDA6B5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863E4482BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D41F0E23;
	Fri, 21 Mar 2025 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zlV41TND"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F81EF087
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544076; cv=fail; b=TWxL1ex85axxbjdX4bsAYA8rBkBpr9kBhw8RCdctw3UdwwsVLP7TCoZ96RyIDcG045x8EK5IdxrWE2vraZTYBSAJbd1P4z9WFkKSxyqgZ9+Ij/PgT1Vw/QR6j/SyyPMK2mHkR+Vo8a8AQ+yD276EsXm2MUh3A1AXxAlMQ7d1Szc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544076; c=relaxed/simple;
	bh=+yoPK2GkB/2ho7lULS3bDY7XJrpCA5Uhcdn12QF1Eos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atNSx5PaMMzyqD3kZZA4Er6lUemuSxqUV1iteM/QoO/0sPuQFXdnKiBXD5WnXMm2IdDj4BOnSv91hs+397VEQAmpTijoPNe/N+NL6ZaUDi+v/ZAYf5cGmoh8owN/sFZlQiYQGc0yOn8hNbvh+S7gwydDuqhNYefHXGvbyxUK2oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zlV41TND; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvNYbrLGm6JgI3SYHLOwMpLV+pKZf+oBXNNIDAK9zOnvMQetJRsVm/TjawejqRXss9rlQOnhTJLOlMqUnRyv3tUDTlDubxm74s+H+fTTGtMTsMiIAx0b9Y1+AUMOoHadw6xbNAO7CLsaUxmK5m9y1Yf7WQQyuLfiRdQgHs4d96s/0BaweU3vUkWru8meZtwhVlccCg9ThPpTtsw5RclWQVlprKhAkcenBkhup916ER6AVl7BXW+fLG1PutbsjjRs2t/w0+0KpxL89hZhgzql1oHl28osxRxRBiD1mUi/aWfODMirFZimpCyiHahbf7zigg6+hHFhX5dFJpb8SMAbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtnNMx+vUKghdlfJoF1WVzFQstzpC4C5t/ZIjEViIMg=;
 b=aIyRa+BitDumZ/pSsAgjWzum2Lt/vZzsmakVqVybPn6BurRz8lbp14wYl4DHYM5cRRFWkticjAEJo9bWl82szL6o5fXfsw1gFGssXZ0QbgOWsp3CIe+6rVysOZyaMpSVHqlNBEFoONzUE2yYOUvvK4XlC6uyT8jrqNmkfPWvEfcq53hhqW/EM4+/qpojaF1DXnuh1ttQCWsz/B5l50R7gzvecCdTGNXGRRXl6jLe4XbUDQ2ygJfkWr074EFxJZIWxGYayJHDZv3BbgZmJjrA6DSiRLtznWe/8P5lSEP8w2C/cnQ2g9jb6XgidlylGNOK22sbG/I93TpG8p/WBAyeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtnNMx+vUKghdlfJoF1WVzFQstzpC4C5t/ZIjEViIMg=;
 b=zlV41TNDWLDccuK72ToMQWOrmQSmaRytLXu5c/UrKIM3SAv7/QJAq/tTeNj3CC1JmbQZLuFE7I9MNuglBdIoOg2JBX4HsJPTCGRus8HGd58ERAal8DbGEjwqGllMUgNGoEJQNT1QgJ5pNSc3FOX6wZ3I85NIyxJCo05z1HlyKMs=
Received: from DS7PR05CA0038.namprd05.prod.outlook.com (2603:10b6:8:2f::23) by
 SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 08:01:10 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::72) by DS7PR05CA0038.outlook.office365.com
 (2603:10b6:8:2f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 08:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 08:01:09 +0000
Received: from jenkins-honglei.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 03:01:05 -0500
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
Subject: [PATCH v2 3/7] drm/virtgpu api: add blob userptr resource
Date: Fri, 21 Mar 2025 16:00:25 +0800
Message-ID: <20250321080029.1715078-4-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 380a033e-6e0b-45b4-bf72-08dd684e8a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxNYtafyORExsb/kZEHvQbmLYOX2JT1RxTkolEltrj8MQCJ7BnwrO7W4bBas?=
 =?us-ascii?Q?GluoTxxSSH0us26+Qe6+eQpskIDgWPC7L6USAMbv4/V73I1zG/jXKmUSvFcV?=
 =?us-ascii?Q?BF0BISQYp5dslTW4WXozGHIrlWD1ErlNUAWXuNpDb7PuK9A6Z3NwNjmgWfhU?=
 =?us-ascii?Q?QCtjPUlngrKjjyyz7BmR/ExBjEHWvf4HVtLswO6a1IkVO/UUDP/QzBrrTIXm?=
 =?us-ascii?Q?XlZJpkhLZymjvZvJ61JzEXpcBHvbuue5/P/eew4Khx4mwypI4eyK3K006vZ0?=
 =?us-ascii?Q?AL3Xau/zS0aK6cI9MnzW/i9DKjy9hWe1TgRbGrFGcobCE8FH+SvXFdaXy81q?=
 =?us-ascii?Q?ao7CdcZ9/udkc6nDPBLSzWouUGRDIH9iExGD01I67TPAjfEkKmZfbNUXZPzX?=
 =?us-ascii?Q?uma9s6duO6qnqHUAsyRAdlY66asBgTrJcTKLnfa/CgIlsnXVl88E8F7MCbkX?=
 =?us-ascii?Q?wG/1Jwm2l2bseERSwkIYy/LCfG6qls541h/otRZQ+ftUC9CfCu0dq3U8Iyb5?=
 =?us-ascii?Q?cVgnzN1e7tXPwVzgb09KkxlmaiqPvxvARRTPnj5o3mxh2ySGJzCmSHIJlVSR?=
 =?us-ascii?Q?UO3BB6bVUfblD+1iALUkKX6KW01zdDdQLMDOa/7p5DqquC5VUb2yqqv5FaCn?=
 =?us-ascii?Q?Z9sUKUxXw7wwthVHqwvUtqJLFnZyWII3sZX8aGqdvJHHPwSwVVaTQpKTWxRM?=
 =?us-ascii?Q?gB+K6l9hzHqds1dQdoRHAkqmWocnH7xIbWIcZ6l7+33ve8hZYGFlhdhKwVHP?=
 =?us-ascii?Q?CbgYDcqhLSNU412f1oexig8o/e7efZSXeaX1Prmz5HrwqiMsuC1+ODSIF4jI?=
 =?us-ascii?Q?rdYLLpNJnFcd+/Fj10s5APkmINBZ9gBiG8+ok1ozd88zUkqbEGR8qNrH74a9?=
 =?us-ascii?Q?X1P0CCR91fPisOqcnq2IcOBh6/NZj9zJTf5+u/NmImlENii3SOpp6cJE+/Yp?=
 =?us-ascii?Q?KbmGjugNMsO/VezO8P4iWgSrTisOXXDtrVndMvbOx4U4X2ZDwwdscN4CHEXM?=
 =?us-ascii?Q?wP6MFZ0F9J7CmTUe4l6zJeTf6tKrd8+IBNZbixYN1EMA9jwSX2WTfzovkucw?=
 =?us-ascii?Q?jBhtd0fzRRTIF3M6xZCZFsmsGDnnF4wmbms5BIGXr6WfK5HyUOsxBrSIAuOp?=
 =?us-ascii?Q?jZVRKq1afTcMRg983hIq1nKdI5L+hvKBXtx7JUvLsVsuBMlAGVxCkyV5G4tA?=
 =?us-ascii?Q?6bPZSg+Zgs+hDjh7N58XqnxEqUTBPWd30gdnZdoTEtkHULHT9CWFB7FDbXGz?=
 =?us-ascii?Q?+FrPloezSYcJTpr0rcSYqBPU11CEkEfhczgrevbT/ryvtEVmEaLsnzMV5RWw?=
 =?us-ascii?Q?dvhmWP5nX/evSu2QVsoB+GiTRG7Ai73dBJ6D//At1ezqokEj+dwIavvDzOTc?=
 =?us-ascii?Q?U5l+TkI5ge2oBVZV9nQkQMl53IU/2gqQZZnlxIgcMnhXvqO9lkLX10k+qH3H?=
 =?us-ascii?Q?pIo7tp0Xtaz1tBsiBX+UKX8R0coGtmtTkiCLfQi/IS/s4k3N1pdr1CeAQsk4?=
 =?us-ascii?Q?qZQDX0VQW33byRxxVcDT7RhtCDd5D8FgmEMm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 08:01:09.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380a033e-6e0b-45b4-bf72-08dd684e8a58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

From: Honglei Huang <Honglei1.Huang@amd.com>

This makes blob userptr resource available to guest userspace.

- Flag VIRTGPU_BLOB_FLAG_USE_USERPTR for guest userspace blob create,
enable this flag to indicate blob userptr resource create.
- Flag VIRTGPU_BLOB_FLAG_USERPTR_RDONLY used for read only userptr,
if not set then the userptr will be writeable.
- New parameter blob_userptr for bypass userspace memory address to
virtio GPU, like other userptr design, virtio GPU needs a userspace
memory for device access.

Used for userptr feature, in compute side, this feature is basic and
essential. Let device to access userspace memory directly instead of
copying.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 include/uapi/drm/virtgpu_drm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index c2ce71987e9b..071f31752721 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -179,13 +179,14 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTGPU_BLOB_FLAG_USE_USERPTR      0x0008
+#define VIRTGPU_BLOB_FLAG_USERPTR_RDONLY   0x0010
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
 	__u32 bo_handle;
 	__u32 res_handle;
 	__u64 size;
-
 	/*
 	 * for 3D contexts with VIRTGPU_BLOB_MEM_HOST3D_GUEST and
 	 * VIRTGPU_BLOB_MEM_HOST3D otherwise, must be zero.
@@ -194,6 +195,7 @@ struct drm_virtgpu_resource_create_blob {
 	__u32 cmd_size;
 	__u64 cmd;
 	__u64 blob_id;
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
-- 
2.34.1



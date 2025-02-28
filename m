Return-Path: <linux-kernel+bounces-537798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB7A490FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD087A88F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB36C1C3F30;
	Fri, 28 Feb 2025 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCEdtR58"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9C1C3F04
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721065; cv=fail; b=KS2UzGomDnSbynPI8QoTwZl2NfOlP76pYpd7dlNu1kltT3QcWol0tjBVKW1HbZTv7NHFGn8HFMMkN/fRcDSD9vsSG5ypdY4INq8VgREwCPHTgvgeOD48WVleRVG6CZr1EEIUqkHUS/Xx3DAg9AbeOM3OfLv0rxlOHdX7BF9Jevg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721065; c=relaxed/simple;
	bh=geZ88N0Vp5EL9XOWvnUfUjF4QZINz/6DMLQb5cfcpzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7ZAh57rVoUfXU7jHN4/xnYrrhkDhOcOwIgKTWG/qPB2LV3fEJW+GOZBdPCmnGVahaVBQH9rMiHqtjfBHBo1HZEsq2KwT/D5ZXYAMb9CQs5eLyd+P9RQGK185i9iQpFfzTl7/eddQEhr7RMAYuaEWbJgtQcspnnKc7RaqAgs+CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCEdtR58; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjL4N91W4HAbEY9YzEE/HC7rPNnTWnjgWkJ55ekKegyayHJ7mHTlGgav/eFo/HYshVZDqJKibE3J5srmtr4Hw9rQgKH6MkQ6PJktt55jm5Bz/uk6aqIEMlLjg7RP6xz9i8UDSh3g9HLCHAxra/P4jJvlk0zme/2FNwaTsmOiX2ueuTHrc4CQ9gLsAX8YjGbJ9dEVESWfT177MsXWVHrv0dq9/TN2VxL4yQ/aGhq8+OoSjIu1qAwsooOAdwP2tZ7ykWrrnWPPmylUNJRNsXw/Ldzg08BJYzbs14BjWiqmrh667R1rTwyIMcH8bv/3PideSJoDYocOfPdpqr3ecIcRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86uHILBfB9VPjbFbb7fwYrDkXHq4q3fZex7aErIP4Y4=;
 b=cuqQubZrWUaoycTc8Izr5X43hKh8900WPvfOvx1VksAsHRP7iuaYmGkW2AUSXeFLEAGDDBkTHkY6i5LcGwAMY++yb518+VnhQrN5eDcX0Ry6GFMRwoMEn3V0VoY/4tuEqQzfWtiESp6vgTG7KGTlAhhXBY0x5cF7fXhyspFJfjrPV6G8kEnR8Wd7IJQsB2WvaQAF/HuPpYNBK2BRj0QgTJAq0OLNDOc5V2KeJcTpgQEHU8H2q5yesk4/cUftbCvRR9KeiKZ6+KA4IxFUeoWgroKl+CW5bH6PCXssUNV2G7qPdkIyGLuGk2hvLLSRA87NC4AjZbvXQf211C7NkIBlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86uHILBfB9VPjbFbb7fwYrDkXHq4q3fZex7aErIP4Y4=;
 b=QCEdtR580U/BbeYRv+l5ZQasnO1/E3XpihCFFs4eaT7BPUlGJhXCLGoypKiNeqcpNOAl1HTDdH2sDSlaUbtun4lYKolcx6J/cJKGJXUltRqJedqR+Jk3GD4M40lZnuW2vhPdN0NSh6OoeZRzVO6WOsC9feCE0EDfDPaxrXnQOS8=
Received: from BN9PR03CA0362.namprd03.prod.outlook.com (2603:10b6:408:f7::7)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 05:37:40 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::9c) by BN9PR03CA0362.outlook.office365.com
 (2603:10b6:408:f7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 05:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 05:37:39 +0000
Received: from jenkins-honglei.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 23:37:35 -0600
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
Subject: [PATCH v1 4/7] drm/virtio: implement userptr: add userptr obj
Date: Fri, 28 Feb 2025 13:36:47 +0800
Message-ID: <20250228053650.393646-5-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 7caf960d-912a-4a50-0061-08dd57ba0412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7Tust9hcI4U7wPMpEuqL5V8pUwDVyZ6vUTo9AxQ66uTcBGlVaN7pbhKjx7j?=
 =?us-ascii?Q?/kmqlsNRia4z5yANXUOEd4YIregjLN6T81+XTUCT3PjOe6hCnCDfOnSIMC/k?=
 =?us-ascii?Q?/I8FxxLDquluMEwiUdIqBfCiNtwx20WXlerluK701pKC6OYOs0hBJ5BCDG5D?=
 =?us-ascii?Q?98TLeNHs6VgWXqBI33meaWP0+V6wK4t70M3OJVgm2hFIQxPrsDJEm2/6jGs8?=
 =?us-ascii?Q?qRc3FaIXO15/7c5k/NZwtj6dErBEBUuZlYyMWXw/sB31+6P8CMTgBhdijBKS?=
 =?us-ascii?Q?N6BLqXpzuIJqJvtrLELUWCCNF1KAvSY5eCmkVnDle+Y9q/v5Dkoil1ISJoWK?=
 =?us-ascii?Q?IBQJnasHnpQfe20cgdk20UMKX+sH0lop8JcPXH+TnJCrF5+AG23zpVlVGwQX?=
 =?us-ascii?Q?demr1IhxRsN1UN/hv9ArTldczPxxpmWzOG2wWDGzXZkWpa8yQ6Vh0YFAHy89?=
 =?us-ascii?Q?UVjCNkQ/MclkNEBTqesOxnr2C1TOAz5LbCoR07dB6qo0Io7f1Tv7u8j/VnA3?=
 =?us-ascii?Q?vFtlPFH/6r/ODRt46912cD66GD8pSlnYhSxcPTT3UvWgqdYDyPZ/s0jhqPll?=
 =?us-ascii?Q?kDyzycisoMW7tcSSB8HqOMoPH5htPrTNDMijt4bVM3ihPXenu+ACPrURfM9E?=
 =?us-ascii?Q?+S2D2vyIq7+rSiEEFTLvzYPydeQdUakwDzyPI2k2R3XdgWIchjOlJ9oKVxNv?=
 =?us-ascii?Q?or/0FaI0dCTEv4eVTE707Y/zOlw4FEpB6+sEaTXqEr1u+noTSWCVqNEcawiM?=
 =?us-ascii?Q?Os/+n6DTz9PWhHlwl9vzKq/20GQzvVFjQorX/UAhjrEWbeROYHcZ9KQGDORu?=
 =?us-ascii?Q?850GUBFWbVrs6I/NiH63WyygLRORN4/sQxM4VrdPrTfuCEkJ2FgpX1+b8itm?=
 =?us-ascii?Q?5kV59K9AcZEoCgtRFhc0jB5H+yl77rnWPAX6qPjuWfxp+TPe9ZDR/f7aTkEX?=
 =?us-ascii?Q?ZC91Hk7pUG1NsHi+XA82/H78v74zYghA23JABFQQlyVgKkrzpWh2c5a4EOlv?=
 =?us-ascii?Q?bbwZS0qIbYkhsZxpz2DzjvoHCA9vjUEbSdft3SqbfM/Op8KRX9nc8q1ylgGj?=
 =?us-ascii?Q?PaTG8DMOB41nsvIsyiMC3uFtOVkNcEdsnROrT9/vDGSPuYtTDUlbPuDyLJMb?=
 =?us-ascii?Q?GFb1w2Ssu56lAPBi3IYJkx+kOddCTTsA9hp/95KdfKIGSNaq3yT1BXbwjDmO?=
 =?us-ascii?Q?6L/GQ0TaKhywY9IjyzFAA2OUEQeKSHJsAXfcXS271gaN0p7XT5QxHRHYmR/Y?=
 =?us-ascii?Q?CPbYwfOodn4beenkZTsAOkX8adIW2YIgpTFo4ouzzs1oAewV0x71GaX9wUdu?=
 =?us-ascii?Q?h5RzrT2PZxxT6JIUT/g6mjDf8+giK1h+e79oRAmYHMS2QRT4EfGIVelXfQlJ?=
 =?us-ascii?Q?7EAYdkSxWV54WRo6gQHfZTZnyRWJCKmn+5bad2dte0Ow1ONdQ/+2P/gTHEg2?=
 =?us-ascii?Q?8ASkKaMoSKMZ+QHjgJ3YlG/kBgLbhn3u0NvHwmluNODWdyNEXXfRjhueRvbU?=
 =?us-ascii?Q?82gIKcIANy/gAduaYOu4nVDz3m/XzxI/nO61?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:37:39.9675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caf960d-912a-4a50-0061-08dd57ba0412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

From: Honglei Huang <Honglei1.Huang@amd.com>

Add implement for virtio gpu userptr. Current solution is pinning
all the user space memory. The UMD needs manage all the userptrs.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  33 ++++
 drivers/gpu/drm/virtio/virtgpu_object.c  |   5 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 230 +++++++++++++++++++++++
 4 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c

diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index d2e1788a8227..fe7332a621aa 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -6,6 +6,7 @@
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
 	virtgpu_display.o virtgpu_vq.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
-	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o
+	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o \
+	virtgpu_userptr.o
 
 obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7bdcbaa20ef1..f3dcbd241f5a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -85,6 +85,7 @@ struct virtio_gpu_object_params {
 	uint32_t blob_mem;
 	uint32_t blob_flags;
 	uint64_t blob_id;
+	uint64_t userptr;
 };
 
 struct virtio_gpu_object {
@@ -112,12 +113,38 @@ struct virtio_gpu_object_vram {
 	struct drm_mm_node vram_node;
 };
 
+struct virtio_gpu_object_userptr;
+
+struct virtio_gpu_object_userptr_ops {
+	int (*get_pages)(struct virtio_gpu_object_userptr *userptr);
+	void (*put_pages)(struct virtio_gpu_object_userptr *userptr);
+	void (*release)(struct virtio_gpu_object_userptr *userptr);
+};
+struct virtio_gpu_object_userptr {
+	struct virtio_gpu_object base;
+	const struct virtio_gpu_object_userptr_ops *ops;
+	struct mutex lock;
+
+	uint64_t start;
+	uint32_t npages;
+	uint32_t bo_handle;
+	uint32_t flags;
+
+	struct virtio_gpu_device *vgdev;
+	struct drm_file *file;
+	struct page **pages;
+	struct sg_table *sgt;
+};
+
 #define to_virtio_gpu_shmem(virtio_gpu_object) \
 	container_of((virtio_gpu_object), struct virtio_gpu_object_shmem, base)
 
 #define to_virtio_gpu_vram(virtio_gpu_object) \
 	container_of((virtio_gpu_object), struct virtio_gpu_object_vram, base)
 
+#define to_virtio_gpu_userptr(virtio_gpu_object) \
+	container_of((virtio_gpu_object), struct virtio_gpu_object_userptr, base)
+
 struct virtio_gpu_object_array {
 	struct ww_acquire_ctx ticket;
 	struct list_head next;
@@ -489,4 +516,10 @@ void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file);
 
+/* virtgpu_userptr.c */
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr);
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index c7e74cf13022..31659b0a028d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -80,6 +80,11 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 		drm_gem_free_mmap_offset(&vram->base.base.base);
 		drm_gem_object_release(&vram->base.base.base);
 		kfree(vram);
+	} else if (virtio_gpu_is_userptr(bo)) {
+		struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
+
+		drm_gem_object_release(&userptr->base.base.base);
+		kfree(userptr);
 	}
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/virtio/virtgpu_userptr.c
new file mode 100644
index 000000000000..b4a08811d345
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/pid.h>
+#include <linux/vmalloc.h>
+
+#include "virtgpu_drv.h"
+#include "drm/drm_gem.h"
+
+static struct sg_table *
+virtio_gpu_userptr_get_sg_table(struct drm_gem_object *obj);
+
+static void virtio_gpu_userptr_free(struct drm_gem_object *obj)
+{
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
+
+	if (bo->created) {
+		userptr->ops->release(userptr);
+
+		virtio_gpu_cmd_unref_resource(vgdev, bo);
+		virtio_gpu_notify(vgdev);
+	}
+}
+
+static void virtio_gpu_userptr_object_close(struct drm_gem_object *obj,
+					    struct drm_file *file)
+{
+	virtio_gpu_gem_object_close(obj, file);
+}
+
+static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
+	.open = virtio_gpu_gem_object_open,
+	.close = virtio_gpu_userptr_object_close,
+	.free = virtio_gpu_userptr_free,
+	.get_sg_table = virtio_gpu_userptr_get_sg_table,
+};
+
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo)
+{
+	return bo->base.base.funcs == &virtio_gpu_userptr_funcs;
+}
+
+static int
+virtio_gpu_userptr_get_pages(struct virtio_gpu_object_userptr *userptr)
+{
+	unsigned int flag = FOLL_LONGTERM;
+	unsigned int num_pages, pinned = 0;
+	int ret = 0;
+
+	if (userptr->pages)
+		return 0;
+
+	userptr->pages = kvmalloc_array(userptr->npages, sizeof(struct page *),
+					GFP_KERNEL);
+	if (!userptr->pages)
+		return -ENOMEM;
+
+	if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY))
+		flag |= FOLL_WRITE;
+
+	do {
+		num_pages = userptr->npages - pinned;
+
+		ret = pin_user_pages_fast(userptr->start + pinned * PAGE_SIZE,
+					  num_pages, flag,
+					  userptr->pages + pinned);
+
+		if (ret < 0) {
+			if (pinned)
+				unpin_user_pages(userptr->pages, pinned);
+			kvfree(userptr->pages);
+			return ret;
+		}
+
+		pinned += ret;
+
+	} while (pinned < userptr->npages);
+
+	return 0;
+}
+
+static void
+virtio_gpu_userptr_put_pages(struct virtio_gpu_object_userptr *userptr)
+{
+	if (userptr->pages) {
+		unpin_user_pages(userptr->pages, userptr->npages);
+		kvfree(userptr->pages);
+		userptr->pages = NULL;
+	}
+
+	if (userptr->sgt) {
+		sg_free_table(userptr->sgt);
+		kfree(userptr->sgt);
+		userptr->sgt = NULL;
+	}
+}
+
+static void
+virtio_gpu_userptr_release(struct virtio_gpu_object_userptr *userptr)
+{
+	mutex_lock(&userptr->lock);
+	userptr->ops->put_pages(userptr);
+	mutex_unlock(&userptr->lock);
+}
+
+static struct sg_table *
+virtio_gpu_userptr_get_sg_table(struct drm_gem_object *obj)
+{
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
+
+	mutex_lock(&userptr->lock);
+	if (!userptr->pages) {
+		if (userptr->ops->get_pages(userptr)) {
+			mutex_unlock(&userptr->lock);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	if (!userptr->sgt)
+		userptr->sgt = drm_prime_pages_to_sg(NULL, userptr->pages,
+						     userptr->npages);
+	mutex_unlock(&userptr->lock);
+
+	return userptr->sgt;
+}
+
+static int
+virtio_gpu_userptr_init(struct drm_device *dev, struct drm_file *file,
+			struct virtio_gpu_object_userptr *userptr,
+			struct virtio_gpu_object_params *params,
+			const struct virtio_gpu_object_userptr_ops *ops)
+{
+	uint32_t page_offset;
+	uint64_t aligned_size;
+	uint64_t aligned_addr;
+	int ret;
+	struct drm_gem_object *obj;
+
+	page_offset = params->userptr & (PAGE_SIZE - 1UL);
+	aligned_addr = params->userptr - page_offset;
+	aligned_size = roundup(page_offset + params->size, PAGE_SIZE);
+
+	userptr->start = aligned_addr;
+	userptr->npages = aligned_size >> PAGE_SHIFT;
+	userptr->flags = params->blob_flags;
+
+	mutex_init(&userptr->lock);
+	userptr->vgdev = dev->dev_private;
+	userptr->file = file;
+	userptr->ops = ops;
+
+	obj = &userptr->base.base.base;
+	obj->funcs = &virtio_gpu_userptr_funcs;
+
+	drm_gem_private_object_init(dev, obj, aligned_size);
+
+	ret = virtio_gpu_resource_id_get(userptr->vgdev,
+					 &userptr->base.hw_res_handle);
+
+	return ret;
+}
+
+static const struct virtio_gpu_object_userptr_ops virtio_gpu_userptr_ops = {
+	.get_pages = virtio_gpu_userptr_get_pages,
+	.put_pages = virtio_gpu_userptr_put_pages,
+	.release = virtio_gpu_userptr_release,
+};
+
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr)
+{
+	struct virtio_gpu_object_userptr *userptr;
+	int ret, si;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+	struct virtio_gpu_mem_entry *ents;
+
+	if (!params->size)
+		return -EINVAL;
+
+	if (!access_ok((char __user *)(unsigned long)params->userptr,
+		       params->size))
+		return -EFAULT;
+
+	userptr = kzalloc(sizeof(*userptr), GFP_KERNEL);
+	if (!userptr)
+		return -ENOMEM;
+
+	ret = virtio_gpu_userptr_init(vgdev->ddev, file, userptr, params,
+				      &virtio_gpu_userptr_ops);
+
+	if (ret)
+		goto failed_free;
+
+	sgt = virtio_gpu_userptr_get_sg_table(&userptr->base.base.base);
+
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto failed_free;
+	}
+
+	ents = kvmalloc_array(sgt->nents, sizeof(struct virtio_gpu_mem_entry),
+			      GFP_KERNEL);
+
+	if (!ents) {
+		ret = -ENOMEM;
+		goto failed_free;
+	}
+
+	for_each_sgtable_sg(sgt, sg, si) {
+		(ents)[si].addr = cpu_to_le64(sg_phys(sg));
+		(ents)[si].length = cpu_to_le32(sg->length);
+		(ents)[si].padding = 0;
+	}
+
+	virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, params, ents,
+					    sgt->nents);
+
+	*bo_ptr = &userptr->base;
+	return 0;
+
+failed_free:
+	kfree(userptr);
+	return ret;
+}
-- 
2.34.1



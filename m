Return-Path: <linux-kernel+bounces-554280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7BA595BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C547A566A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64F22A1E5;
	Mon, 10 Mar 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="BQ5f+Psv"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90D1ADC7F;
	Mon, 10 Mar 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612285; cv=none; b=PBbN/hJFRQTJRgOpgoFdZG9zzrE30s7IL86i0MJGZ49dK2P8k1TEg14BTRai4Iq9yf1mvtWNed1m6vM2QFdzrCMSF7d5kGNYPRriz/bPlgtJsNYVdZT/6GiL4fSqvKUM+TEFLAeJV4Fcsmrw6smccxhH7w/ycif2gRCauCN56X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612285; c=relaxed/simple;
	bh=r1x470L4jwmbDuNUlklKPJk6JIqwC47B9etJYyW0vW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NXCrYO6hN/rRYI3kwvZ0q2UJn4cRH/ZGiB+D+ZkgwmmMsy5SwjQsdMmeKhKLDab9af3f5+s+fN0KnHv3ge430cpSwTjq8hOhRR9/aATiewoeZXH8BGKVZv6tFqA4QQSLW7swyZ8A6DFyw8Ga/TRY0zkjsTwYw+P3jKjS82kgNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=BQ5f+Psv; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A7A2JD004779;
	Mon, 10 Mar 2025 13:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=u
	ESA4QqfGTGCsO/HkNgYjU2s1+AKtHc4tu+9+ZTUrcM=; b=BQ5f+PsvMDuhwGK8E
	10RJVx0XT1RjJ1ux178sb6JHVgAHbMRnxxhWT0VZt3zscjtSFKsEobZ3tiQTm3NB
	T+6L0rXDjFyQfWtbOApNwC0SRSJnP61ETiVfkNtbM8IA1f2tfWOCSVK2gcVSL5ee
	ZSOdodCFjFPh8KpVxt9/1fBX9ysvtK+nNeO0SKVQvA+ExwtJ8PNjo8QuzLaxpiy1
	4OB573BBCyt0256l9FE8uSNHwqlznV+Nl4NPj932LQB3uLDBSXW7nGVQc1scx8W7
	aC6q2b64+f+VYc4PV0djGYxodAZldB/5B22JLNv5D17OFMQKR/lYALCf4wxYSnRu
	Aqy4g==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 458ev09es0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Mar 2025 13:10:55 +0000 (GMT)
Received: from Matts-MacBook-Pro.local (172.25.0.133) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 13:10:54 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 10 Mar 2025 13:10:39 +0000
Subject: [PATCH v3 15/18] drm/imagination: Use cached memory with
 dma_coherent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250310-sets-bxs-4-64-patch-v1-v3-15-143b3dbef02f@imgtec.com>
References: <20250310-sets-bxs-4-64-patch-v1-v3-0-143b3dbef02f@imgtec.com>
In-Reply-To: <20250310-sets-bxs-4-64-patch-v1-v3-0-143b3dbef02f@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Alessio
 Belle" <alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4974;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=r1x470L4jwmbDuNUlklKPJk6JIqwC47B9etJYyW0vW8=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaSfe3KJL830IYfNtUURzUx/8gtzf6/MdVp+ZcaN4PSlr
 PVvfq116ChlYRDjYJAVU2TZscJyhdofNS2JG7+KYeawMoEMYeDiFICJzDRkZNioyOe4o3x2+Jll
 d9e7TZ9mO8u1Y+fuq5e3bjW+EnJvE/MpRoY9DhpqP7LblWeahJn90e/xk1w7+0/I4/sqbsz23S/
 ibBkA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=67cee4df cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=0i1-_hofAh2E2eMZgqcA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: oIhM6dVq5HA_8GTn7csNNV7iln7BsNC-
X-Proofpoint-ORIG-GUID: oIhM6dVq5HA_8GTn7csNNV7iln7BsNC-

The TI k3-j721s2 platform does not allow us to use uncached memory
(which is what the driver currently does) without disabling cache snooping
on the AXI ACE-Lite interface, which would be too much of a performance
hit.

Given the platform is dma-coherent, we can simply force all
device-accessible memory allocations through the CPU cache. In fact, this
can be done whenever the dma_coherent attribute is present.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v3:
- Change from a workaround to a regular codepath
- Add missing <linux/property.h> include
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-19-3fd45d9fb0cf@imgtec.com
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-19-4ed30e865892@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_gem.c | 10 +++++++---
 drivers/gpu/drm/imagination/pvr_gem.h |  6 ++++--
 drivers/gpu/drm/imagination/pvr_mmu.c |  8 +++++++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_gem.c b/drivers/gpu/drm/imagination/pvr_gem.c
index 6a8c81fe8c1e85c2130a4fe90fce35b6a2be35aa..9467cd563339cd5bf62ff92edba115ed5721ee76 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.c
+++ b/drivers/gpu/drm/imagination/pvr_gem.c
@@ -19,6 +19,7 @@
 #include <linux/log2.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
+#include <linux/property.h>
 #include <linux/refcount.h>
 #include <linux/scatterlist.h>
 
@@ -336,6 +337,7 @@ struct drm_gem_object *pvr_gem_create_object(struct drm_device *drm_dev, size_t
 struct pvr_gem_object *
 pvr_gem_object_create(struct pvr_device *pvr_dev, size_t size, u64 flags)
 {
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
 	struct drm_gem_shmem_object *shmem_obj;
 	struct pvr_gem_object *pvr_obj;
 	struct sg_table *sgt;
@@ -345,7 +347,10 @@ pvr_gem_object_create(struct pvr_device *pvr_dev, size_t size, u64 flags)
 	if (size == 0 || !pvr_gem_object_flags_validate(flags))
 		return ERR_PTR(-EINVAL);
 
-	shmem_obj = drm_gem_shmem_create(from_pvr_device(pvr_dev), size);
+	if (device_get_dma_attr(drm_dev->dev) == DEV_DMA_COHERENT)
+		flags |= PVR_BO_CPU_CACHED;
+
+	shmem_obj = drm_gem_shmem_create(drm_dev, size);
 	if (IS_ERR(shmem_obj))
 		return ERR_CAST(shmem_obj);
 
@@ -360,8 +365,7 @@ pvr_gem_object_create(struct pvr_device *pvr_dev, size_t size, u64 flags)
 		goto err_shmem_object_free;
 	}
 
-	dma_sync_sgtable_for_device(shmem_obj->base.dev->dev, sgt,
-				    DMA_BIDIRECTIONAL);
+	dma_sync_sgtable_for_device(drm_dev->dev, sgt, DMA_BIDIRECTIONAL);
 
 	/*
 	 * Do this last because pvr_gem_object_zero() requires a fully
diff --git a/drivers/gpu/drm/imagination/pvr_gem.h b/drivers/gpu/drm/imagination/pvr_gem.h
index e0e5ea509a2e88a437b8d241ea13c7bab2220f56..c99f30cc62088c030bd8a806df79b738b62a968f 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.h
+++ b/drivers/gpu/drm/imagination/pvr_gem.h
@@ -44,8 +44,10 @@ struct pvr_file;
  * Bits not defined anywhere are "undefined".
  *
  * CPU mapping options
- *    :PVR_BO_CPU_CACHED: By default, all GEM objects are mapped write-combined on the CPU. Set this
- *       flag to override this behaviour and map the object cached.
+ *    :PVR_BO_CPU_CACHED: By default, all GEM objects are mapped write-combined on the CPU. Set
+ *       this flag to override this behaviour and map the object cached. If the dma_coherent
+ *       property is present in devicetree, all allocations will be mapped as if this flag was set.
+ *       This does not require any additional consideration at allocation time.
  *
  * Firmware options
  *    :PVR_BO_FW_NO_CLEAR_ON_RESET: By default, all FW objects are cleared and reinitialised on hard
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 4fe70610ed94cf707e631f8148af081a94f97327..450d476d183f0173d0ef03f0d8897fbeb04831a2 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -17,6 +17,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kmemleak.h>
 #include <linux/minmax.h>
+#include <linux/property.h>
 #include <linux/sizes.h>
 
 #define PVR_SHIFT_FROM_SIZE(size_) (__builtin_ctzll(size_))
@@ -259,6 +260,7 @@ pvr_mmu_backing_page_init(struct pvr_mmu_backing_page *page,
 	struct device *dev = from_pvr_device(pvr_dev)->dev;
 
 	struct page *raw_page;
+	pgprot_t prot;
 	int err;
 
 	dma_addr_t dma_addr;
@@ -268,7 +270,11 @@ pvr_mmu_backing_page_init(struct pvr_mmu_backing_page *page,
 	if (!raw_page)
 		return -ENOMEM;
 
-	host_ptr = vmap(&raw_page, 1, VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+	prot = PAGE_KERNEL;
+	if (device_get_dma_attr(dev) != DEV_DMA_COHERENT)
+		prot = pgprot_writecombine(prot);
+
+	host_ptr = vmap(&raw_page, 1, VM_MAP, prot);
 	if (!host_ptr) {
 		err = -ENOMEM;
 		goto err_free_page;

-- 
2.48.1



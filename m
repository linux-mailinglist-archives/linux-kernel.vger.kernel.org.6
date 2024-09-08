Return-Path: <linux-kernel+bounces-320115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72097064D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21401F221D1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC3E15DBB7;
	Sun,  8 Sep 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m2sGRkpo"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057114E2EF
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788726; cv=none; b=VmGFmB7xK6Azgi5CAVH0rY8fqggFF7t8yL0uTs/ldTDTP2+cXOg8foCQp87S0unpbqAo8KbLxvb4WOPiUWUOplGzvOPUjMrLk+UyF9gwymO3ozHeQBytlMAdmvY9GeK8Bc1JFx+HS6myA3nrOKL4j3FwRDF6at7uC4nehJcrwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788726; c=relaxed/simple;
	bh=uBC865AscrLFfoViPlN9//QXViJ/A1sZOO5wqBYsRgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMTWnoM7wqJ+MfEMDLLNgOhl/hJoHPIwAxm96XfeDeS9QogrbqEMCmdu/92lItjMC9GVRZauzreGBmwUcC7+AYhXTFTj1QDsC/Tit7T45a2zHzk1HSjGQ5/g+0wkIqGtPnkrnmkqrZ22qWUlp2A4xI+cTwk7nkfWyO8BCufWvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m2sGRkpo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0LGOVr63MzTgjkpsjkywu/CiseXOg+QYEm2YzMe//A=;
	b=m2sGRkpoAaX8t5hm9q20rCvKv/A6ZbryUZ7RVh9H6qykd44QWUf+rQZhx1hNMdrGAjdn83
	vkzlbYGVhuG+5z8xNDO1McZCqv8fzHJGD6WubzKdotgNUL1XNKGGNqAh1v1l3SHsOfCTME
	S369tlScpNkhHy7JLCYM0uZI6SJm5f0=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 19/19] drm/etnaviv: Expose basic sanity tests via debugfs
Date: Sun,  8 Sep 2024 17:43:57 +0800
Message-ID: <20240908094357.291862-20-sui.jingfeng@linux.dev>
In-Reply-To: <20240908094357.291862-1-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To test the correctess of the implemented vmap() and vunmap() operations,
to see if is works correctly on dedicated VRAM.

Usage:

cd /sys/kernel/debug/dri/etnaviv
cat sanity

My test is able to pass on x86-64 with a JM9230P card, see below log:

Test Write to VRAM 8294400 bytes
Write to VRAM Passed: 8294400 bytes
Test Write to SHMEM 8294400 bytes
Write to SHMEM Passed: 8294400 bytes

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/Makefile           |   1 +
 drivers/gpu/drm/etnaviv/etnaviv_debugfs.c  | 118 +++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_debugfs.h  |  15 +++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c      |  12 +++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c      |   5 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.h      |   2 +
 drivers/gpu/drm/etnaviv/etnaviv_gem_vram.c |   6 ++
 drivers/gpu/drm/etnaviv/etnaviv_gem_vram.h |   2 +
 8 files changed, 161 insertions(+)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_debugfs.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_debugfs.h

diff --git a/drivers/gpu/drm/etnaviv/Makefile b/drivers/gpu/drm/etnaviv/Makefile
index aba2578966ff..f278e75ee7cd 100644
--- a/drivers/gpu/drm/etnaviv/Makefile
+++ b/drivers/gpu/drm/etnaviv/Makefile
@@ -17,6 +17,7 @@ etnaviv-y := \
 	etnaviv_perfmon.o \
 	etnaviv_sched.o
 
+etnaviv-$(CONFIG_DEBUG_FS) += etnaviv_debugfs.o
 etnaviv-$(CONFIG_DRM_ETNAVIV_PCI_DRIVER) += etnaviv_pci_drv.o \
 					    pcie_ip_setup.o
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_debugfs.c b/drivers/gpu/drm/etnaviv/etnaviv_debugfs.c
new file mode 100644
index 000000000000..0cfedbc6574c
--- /dev/null
+++ b/drivers/gpu/drm/etnaviv/etnaviv_debugfs.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <drm/drm_debugfs.h>
+
+#include "etnaviv_debugfs.h"
+#include "etnaviv_drv.h"
+#include "etnaviv_gem.h"
+#include "etnaviv_gem_vram.h"
+
+static void bo_test_write_to_vram_by_cpu(void *addr, unsigned int num)
+{
+	u32 val = 0;
+
+	while (num--) {
+		writel(val, addr);
+		++val;
+		addr += 4;
+	}
+}
+
+static unsigned int bo_test_read_from_vram_by_cpu(void *addr, unsigned int num)
+{
+	unsigned int i = 0;
+
+	while (i < num) {
+		u32 val = readl(addr);
+
+		if (val != i)
+			return i;
+
+		addr += 4;
+		++i;
+	}
+
+	return 0;
+}
+
+void etnaviv_sanity_test_vram_impl(struct drm_device *drm, struct drm_printer *p)
+{
+	struct etnaviv_gem_object *etnaviv_obj;
+	unsigned int size = 1920 * 1080 * 4;
+	void *addr;
+	int ret;
+
+	size = ALIGN(size, PAGE_SIZE);
+
+	drm_printf(p, "Test Write to VRAM %u bytes\n", size);
+
+	ret = etnaviv_gem_new_private(drm, size, ETNA_BO_UNCACHED, false,
+				      etnaviv_gem_get_vram_ops(),
+				      &etnaviv_obj);
+	if (ret) {
+		drm_printf(p, "create dst bo failed\n");
+		return;
+	}
+
+	addr = etnaviv_gem_vmap(&etnaviv_obj->base);
+	if (!addr) {
+		drm_printf(p, "write to vram by cpu failed: vmap\n");
+		goto out;
+	}
+
+	etnaviv_gem_vunmap(&etnaviv_obj->base);
+
+	addr = etnaviv_gem_vmap(&etnaviv_obj->base);
+
+	bo_test_write_to_vram_by_cpu(addr, size / 4);
+
+	ret = bo_test_read_from_vram_by_cpu(addr, size / 4);
+
+	drm_printf(p, "Write to VRAM %s: %u bytes\n",
+		   ret ? "not pass" : "Passed", ret ? ret : size);
+
+	etnaviv_gem_vunmap(&etnaviv_obj->base);
+out:
+	drm_gem_object_put(&etnaviv_obj->base);
+}
+
+void etnaviv_sanity_test_shmem_impl(struct drm_device *drm, struct drm_printer *p)
+{
+	struct etnaviv_gem_object *etnaviv_obj;
+	unsigned int size = 1920 * 1080 * 4;
+	void *addr;
+	int ret;
+
+	size = ALIGN(size, PAGE_SIZE);
+
+	drm_printf(p, "Test Write to SHMEM %u bytes\n", size);
+
+	ret = etnaviv_gem_new_private(drm, size, ETNA_BO_CACHED, true,
+				      etnaviv_gem_get_shmem_ops(),
+				      &etnaviv_obj);
+	if (ret) {
+		drm_printf(p, "create dst bo failed\n");
+		return;
+	}
+
+	addr = etnaviv_gem_vmap(&etnaviv_obj->base);
+	if (!addr) {
+		drm_printf(p, "write to shmem by cpu failed: vmap\n");
+		goto out;
+	}
+
+	etnaviv_gem_vunmap(&etnaviv_obj->base);
+
+	addr = etnaviv_gem_vmap(&etnaviv_obj->base);
+
+	bo_test_write_to_vram_by_cpu(addr, size / 4);
+
+	ret = bo_test_read_from_vram_by_cpu(addr, size / 4);
+
+	drm_printf(p, "Write to SHMEM %s: %u bytes\n",
+		   ret ? "not pass" : "Passed", ret ? ret : size);
+
+	etnaviv_gem_vunmap(&etnaviv_obj->base);
+out:
+	drm_gem_object_put(&etnaviv_obj->base);
+}
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_debugfs.h b/drivers/gpu/drm/etnaviv/etnaviv_debugfs.h
new file mode 100644
index 000000000000..5214349534ef
--- /dev/null
+++ b/drivers/gpu/drm/etnaviv/etnaviv_debugfs.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ETNAVIV_DEBUGFS_H__
+#define __ETNAVIV_DEBUGFS_H__
+
+#include "etnaviv_drv.h"
+#include "etnaviv_gem.h"
+
+void etnaviv_sanity_test_vram_impl(struct drm_device *ddev,
+				   struct drm_printer *p);
+
+void etnaviv_sanity_test_shmem_impl(struct drm_device *ddev,
+				    struct drm_printer *p);
+
+#endif
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index cdc62f64b200..e500b8caf138 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -20,6 +20,7 @@
 #include <drm/drm_prime.h>
 
 #include "etnaviv_cmdbuf.h"
+#include "etnaviv_debugfs.h"
 #include "etnaviv_drv.h"
 #include "etnaviv_gpu.h"
 #include "etnaviv_gem.h"
@@ -183,6 +184,16 @@ static int etnaviv_gem_show(struct drm_device *dev, struct seq_file *m)
 	return 0;
 }
 
+static int etnaviv_sanity_test_show(struct drm_device *dev, struct seq_file *m)
+{
+	struct drm_printer printer = drm_seq_file_printer(m);
+
+	etnaviv_sanity_test_vram_impl(dev, &printer);
+	etnaviv_sanity_test_shmem_impl(dev, &printer);
+
+	return 0;
+}
+
 static int etnaviv_mm_show(struct drm_device *dev, struct seq_file *m)
 {
 	struct drm_printer p = drm_seq_file_printer(m);
@@ -296,6 +307,7 @@ static struct drm_info_list etnaviv_debugfs_list[] = {
 	{ "mm", show_unlocked, 0, etnaviv_mm_show },
 	{"mmu", show_each_gpu, 0, etnaviv_mmu_show},
 	{"ring", show_each_gpu, 0, etnaviv_ring_show},
+	{"sanity", show_unlocked, 0, etnaviv_sanity_test_show },
 };
 
 static void etnaviv_debugfs_init(struct drm_minor *minor)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index ee799c02d0aa..31bcd80770b3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -553,6 +553,11 @@ static const struct etnaviv_gem_ops etnaviv_gem_shmem_ops = {
 	.mmap = etnaviv_gem_mmap_obj,
 };
 
+const struct etnaviv_gem_ops *etnaviv_gem_get_shmem_ops(void)
+{
+	return &etnaviv_gem_shmem_ops;
+}
+
 void etnaviv_gem_free_object(struct drm_gem_object *obj)
 {
 	struct drm_device *drm = obj->dev;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index 60bbbbc2dd19..1836e1d82df2 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -134,4 +134,6 @@ void etnaviv_gem_mapping_unreference(struct etnaviv_vram_mapping *mapping);
 
 u64 etnaviv_obj_gpu_phys_addr(struct etnaviv_gem_object *etnaviv_obj);
 
+const struct etnaviv_gem_ops *etnaviv_gem_get_shmem_ops(void);
+
 #endif /* __ETNAVIV_GEM_H__ */
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.c
index c2942317a64e..1ca558429387 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.c
@@ -4,6 +4,7 @@
 
 #include "etnaviv_drv.h"
 #include "etnaviv_gem.h"
+#include "etnaviv_gem_vram.h"
 #include "etnaviv_pci_drv.h"
 
 static struct lock_class_key etnaviv_vram_lock_class;
@@ -171,6 +172,11 @@ static const struct etnaviv_gem_ops etnaviv_gem_vram_ops = {
 	.mmap = etnaviv_gem_vram_mmap,
 };
 
+const struct etnaviv_gem_ops *etnaviv_gem_get_vram_ops(void)
+{
+	return &etnaviv_gem_vram_ops;
+}
+
 int etnaviv_gem_new_vram(struct drm_device *dev, struct drm_file *file,
 			 u32 size, u32 flags, u32 *handle)
 {
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.h b/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.h
index bbce93f118a2..54f98936ddb4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_vram.h
@@ -3,6 +3,8 @@
 #ifndef __ETNAVIV_GEM_VRAM_H__
 #define __ETNAVIV_GEM_VRAM_H__
 
+const struct etnaviv_gem_ops *etnaviv_gem_get_vram_ops(void);
+
 int etnaviv_gem_new_vram(struct drm_device *dev, struct drm_file *file,
 			 u32 size, u32 flags, u32 *handle);
 
-- 
2.43.0



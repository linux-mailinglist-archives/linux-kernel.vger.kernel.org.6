Return-Path: <linux-kernel+bounces-297917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D608E95BF19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3554CB241FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB61D04BD;
	Thu, 22 Aug 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DEYi0iws"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23461CDA2E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356114; cv=none; b=BY2O1jOi0ql7C3HqTeNQI5I4n7AltllcpCmAEra7Hzq0eggxM6/4n7oKsgCrKwAuTExuycvr3Eue4S4y2ODzPzkvXPSLeTV8fbUY7ynsx+mknxkEbFgmqYRH36Hl47iOAGKoZsX9EGLVYLI9Vvh9LK9uz9rTBCGCSEIwCbvi+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356114; c=relaxed/simple;
	bh=NhZWZ56crKIP9VrORTWX1SKs6t8s1pwl3NqaRWSxOyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSaS7LsM81yPeu6fRMql/R32663ves0Jgaiq4y7I51oDFqFS9RAoFgk+dCCw+0NDVMJjMDDF+cePfbdmVVztJqSpI5N9pyRVJucjjaQWbRuMj0EzPTjcZqkL1ZWVOuXxfw3n4+uWm4F0OPlfDPhFplSJ0wfbPS6rbngAXMd7EGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DEYi0iws; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724356108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eR3d7maQzMLeszudpaA7uybEheUxvYsdireNMjQKRpw=;
	b=DEYi0iws5j+VwIPzZtuV09InhrzGG6fH08sFrd2t/Yn4NBdparV/5cpPcJYrZLDG8Jp6n/
	OAG4zhFf1vY9plC8TdgmO6eJBlNNFsLkJ8lKZbn9o9wMd6TinxBK/vBNQNs4Vz+DblC++v
	oTP/af+Rt/TFe1Dnk3yaEmYrr13aXR4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2] dma: Trace dma_map/unmap_page
Date: Thu, 22 Aug 2024 15:48:24 -0400
Message-Id: <20240822194824.1117803-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When debugging drivers, it can often be useful to trace when memory gets
(un)mapped for DMA (and can be accessed by the device). Add some
tracepoints for this purpose. While there are other interesting DMA
functions, this is a useful start.

We use unsigned long long instead of phys_addr_t and dma_addr_t (and
similarly %llx instead of %pa) because libtraceevent can't handle
typedefs.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Trace dma_(un)map_sg and dma_(un)map_resource

 include/trace/events/dma.h | 204 +++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c       |  10 ++
 2 files changed, 214 insertions(+)
 create mode 100644 include/trace/events/dma.h

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
new file mode 100644
index 000000000000..76dd486b4bed
--- /dev/null
+++ b/include/trace/events/dma.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dma
+
+#if !defined(_TRACE_DMA_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DMA_H
+
+#include <linux/tracepoint.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+
+TRACE_DEFINE_ENUM(DMA_BIDIRECTIONAL);
+TRACE_DEFINE_ENUM(DMA_TO_DEVICE);
+TRACE_DEFINE_ENUM(DMA_FROM_DEVICE);
+TRACE_DEFINE_ENUM(DMA_NONE);
+
+#define decode_dma_data_direction(dir) \
+	__print_symbolic(dir, \
+		{ DMA_BIDIRECTIONAL, "BIDIRECTIONAL" }, \
+		{ DMA_TO_DEVICE, "TO_DEVICE" }, \
+		{ DMA_FROM_DEVICE, "FROM_DEVICE" }, \
+		{ DMA_NONE, "NONE" })
+
+#define decode_dma_attrs(attrs) \
+	__print_flags(attrs, "|", \
+		{ DMA_ATTR_WEAK_ORDERING, "WEAK_ORDERING" }, \
+		{ DMA_ATTR_WRITE_COMBINE, "WRITE_COMBINE" }, \
+		{ DMA_ATTR_NO_KERNEL_MAPPING, "NO_KERNEL_MAPPING" }, \
+		{ DMA_ATTR_SKIP_CPU_SYNC, "SKIP_CPU_SYNC" }, \
+		{ DMA_ATTR_FORCE_CONTIGUOUS, "FORCE_CONTIGUOUS" }, \
+		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
+		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
+		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" })
+
+DECLARE_EVENT_CLASS(dma_map,
+	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(unsigned long long, phys_addr)
+		__field(unsigned long long, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->phys_addr = phys_addr;
+		__entry->dma_addr = dma_addr;
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addr=%llx attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__entry->phys_addr,
+		decode_dma_attrs(__entry->attrs))
+);
+
+DEFINE_EVENT(dma_map, dma_map_page,
+	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs));
+
+DEFINE_EVENT(dma_map, dma_map_resource,
+	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs));
+
+DECLARE_EVENT_CLASS(dma_unmap,
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, addr, size, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(unsigned long long, addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->addr,
+		__entry->size,
+		decode_dma_attrs(__entry->attrs))
+);
+
+DEFINE_EVENT(dma_unmap, dma_unmap_page,
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, addr, size, dir, attrs));
+
+DEFINE_EVENT(dma_unmap, dma_unmap_resource,
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, addr, size, dir, attrs));
+
+TRACE_EVENT(dma_map_sg,
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+		 int ents, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, sg, nents, ents, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(unsigned long long, phys_addrs, nents)
+		__dynamic_array(unsigned long long, dma_addrs, ents)
+		__dynamic_array(unsigned int, lengths, ents)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		int i;
+
+		__assign_str(device);
+		for (i = 0; i < nents; i++)
+			((unsigned long long *)__get_dynamic_array(phys_addrs))[i] =
+				sg_phys(sg + i);
+		for (i = 0; i < ents; i++) {
+			((unsigned long long *)__get_dynamic_array(dma_addrs))[i] =
+				sg_dma_address(sg + i);
+			((unsigned int *)__get_dynamic_array(lengths))[i] =
+				sg_dma_len(sg + i);
+		}
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(dma_addrs),
+			      __get_dynamic_array_len(dma_addrs) /
+				sizeof(unsigned long long), sizeof(unsigned long long)),
+		__print_array(__get_dynamic_array(lengths),
+			      __get_dynamic_array_len(lengths) /
+				sizeof(unsigned int), sizeof(unsigned int)),
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(unsigned long long), sizeof(unsigned long long)),
+		decode_dma_attrs(__entry->attrs))
+);
+
+TRACE_EVENT(dma_unmap_sg,
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+		 enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, sg, nents, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(unsigned long long, addrs, nents)
+		__dynamic_array(unsigned int, lengths, nents)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		int i;
+
+		__assign_str(device);
+		for (i = 0; i < nents; i++) {
+			((unsigned long long *)__get_dynamic_array(addrs))[i] =
+				sg_dma_address(sg + i);
+			((unsigned int *)__get_dynamic_array(lengths))[i] =
+				sg_dma_len(sg + i);
+		}
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addrs=%s sizes=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(addrs),
+			      __get_dynamic_array_len(addrs) /
+				sizeof(unsigned long long), sizeof(unsigned long long)),
+		__print_array(__get_dynamic_array(lengths),
+			      __get_dynamic_array_len(lengths) /
+				sizeof(unsigned int), sizeof(unsigned int)),
+		decode_dma_attrs(__entry->attrs))
+);
+
+#endif /*  _TRACE_DMA_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b50ae3d198a6..9993ba33d1bb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -18,6 +18,9 @@
 #include "debug.h"
 #include "direct.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dma.h>
+
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -181,6 +184,8 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	kmsan_handle_dma(page, offset, size, dir);
+	trace_dma_map_page(dev, page_to_phys(page) + offset, addr, size, dir,
+			   attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
@@ -200,6 +205,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		iommu_dma_unmap_page(dev, addr, size, dir, attrs);
 	else
 		ops->unmap_page(dev, addr, size, dir, attrs);
+	trace_dma_unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
@@ -225,6 +231,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	if (ents > 0) {
 		kmsan_handle_dma_sg(sg, nents, dir);
+		trace_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
 				ents != -EIO && ents != -EREMOTEIO)) {
@@ -310,6 +317,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
+	trace_dma_unmap_sg(dev, sg, nents, dir, attrs);
 	debug_dma_unmap_sg(dev, sg, nents, dir);
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_sg_direct(dev, sg, nents))
@@ -339,6 +347,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 	else if (ops->map_resource)
 		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
 
+	trace_dma_map_resource(dev, phys_addr, addr, size, dir, attrs);
 	debug_dma_map_resource(dev, phys_addr, size, dir, addr, attrs);
 	return addr;
 }
@@ -356,6 +365,7 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 		iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
 	else if (ops->unmap_resource)
 		ops->unmap_resource(dev, addr, size, dir, attrs);
+	trace_dma_unmap_resource(dev, addr, size, dir, attrs);
 	debug_dma_unmap_resource(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_resource);
-- 
2.35.1.1320.gc452695387.dirty



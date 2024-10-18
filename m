Return-Path: <linux-kernel+bounces-371894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4919A41DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE4528C919
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB42022E0;
	Fri, 18 Oct 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUFQMugH"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7652010EA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263675; cv=none; b=ulDSFkO6iBftK/N51fk5pUxF2WAyQBX4msBAzhiDY/JTexHuCG49j8z+YmsXRUtBWxYKWUdTX95GPMMAcBw93CMXxJwNZg3KAiAHQv9f1DCXP9/tVU/OHm/+3lhCXYIE4TfVE2JnBU7vLdN4H0z7Sgdw3iRZEEl/U6A1OBLqovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263675; c=relaxed/simple;
	bh=KXjgRjgViiBPoQ96NpbXV5Lg8af5ZYGzF262rMeCnRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9zvU+6dW/drGQs2STwQBgOOrpHrBFrdmuKP/ptnAkmS1gfknl9sRwn6tjqQ8//F7IcH9lnbnPlN36Ffx1Rb2GQVm2imMPhecEbMxUXC/RThvFJ9KGAj9fkVZMsc0br0dgYc7HnzlP1SPajX13otuALmW5E7f35UOox5Dg9DzGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUFQMugH; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729263672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1hpfqv0IHftVKZCYJJVLIjVqOdtAFHDnh0O340ruFg=;
	b=gUFQMugHKbc35RgKuzv1+0W/jX1DIhYapkZndWqtCsctIFCEMAijSCIMgXI6dkZ0kyk6dX
	TbG0rVtS+IUTwXzfgOdUr+hzKI2NMWoUZnEtu2jiWgJR2mmduGBGaYu9vDEfVLiu/K+4+P
	GfI4DNYuvR+polvwwwK+a09aAxH3bC0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 3/4] dma-mapping: Use trace_dma_alloc for dma_alloc* instead of using trace_dma_map
Date: Fri, 18 Oct 2024 11:00:36 -0400
Message-Id: <20241018150036.2878190-4-sean.anderson@linux.dev>
In-Reply-To: <20241018150036.2878190-1-sean.anderson@linux.dev>
References: <20241018150036.2878190-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In some cases, we use trace_dma_map to trace dma_alloc* functions. This
generally follows dma_debug. However, this does not record all of the
relevant information for allocations, such as GFP flags. Create new
dma_alloc tracepoints for these functions. Note that while
dma_alloc_noncontiguous may allocate discontiguous pages (from the CPU's
point of view), the device will only see one contiguous mapping.
Therefore, we just need to trace dma_addr and size.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Use macros to define events in a class

 include/trace/events/dma.h | 99 +++++++++++++++++++++++++++++++++++++-
 kernel/dma/mapping.c       | 10 ++--
 2 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 267cfa49d9d5..7a9606b8934e 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -112,7 +112,7 @@ DEFINE_EVENT(dma_unmap, name, \
 DEFINE_UNMAP_EVENT(dma_unmap_page);
 DEFINE_UNMAP_EVENT(dma_unmap_resource);
 
-TRACE_EVENT(dma_alloc,
+DECLARE_EVENT_CLASS(dma_alloc_class,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
 		 size_t size, enum dma_data_direction dir, gfp_t flags,
 		 unsigned long attrs),
@@ -147,7 +147,58 @@ TRACE_EVENT(dma_alloc,
 		decode_dma_attrs(__entry->attrs))
 );
 
-TRACE_EVENT(dma_free,
+#define DEFINE_ALLOC_EVENT(name) \
+DEFINE_EVENT(dma_alloc_class, name, \
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr, \
+		 size_t size, enum dma_data_direction dir, gfp_t flags, \
+		 unsigned long attrs), \
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs))
+
+DEFINE_ALLOC_EVENT(dma_alloc);
+DEFINE_ALLOC_EVENT(dma_alloc_pages);
+
+TRACE_EVENT(dma_alloc_sgt,
+	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
+		 enum dma_data_direction dir, gfp_t flags, unsigned long attrs),
+	TP_ARGS(dev, sgt, size, dir, flags, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, sgt->orig_nents)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(gfp_t, flags)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->dma_addr = sg_dma_address(sgt->sgl);
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->flags = flags;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addrs=%s flags=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)),
+		show_gfp_flags(__entry->flags),
+		decode_dma_attrs(__entry->attrs))
+);
+
+DECLARE_EVENT_CLASS(dma_free_class,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
 		 size_t size, enum dma_data_direction dir, unsigned long attrs),
 	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs),
@@ -179,6 +230,50 @@ TRACE_EVENT(dma_free,
 		decode_dma_attrs(__entry->attrs))
 );
 
+#define DEFINE_FREE_EVENT(name) \
+DEFINE_EVENT(dma_free_class, name, \
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr, \
+		 size_t size, enum dma_data_direction dir, unsigned long attrs), \
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs))
+
+DEFINE_FREE_EVENT(dma_free);
+DEFINE_FREE_EVENT(dma_free_pages);
+
+TRACE_EVENT(dma_free_sgt,
+	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, sgt, size, dir),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, sgt->orig_nents)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->dma_addr = sg_dma_address(sgt->sgl);
+		__entry->size = size;
+		__entry->dir = dir;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)))
+);
+
 TRACE_EVENT(dma_map_sg,
 	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 int ents, enum dma_data_direction dir, unsigned long attrs),
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 944ac835030a..b8a6bc492fae 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -685,8 +685,8 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
 	if (page) {
-		trace_dma_map_page(dev, page_to_phys(page), *dma_handle, size,
-				   dir, 0);
+		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
+				      size, dir, gfp, 0);
 		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
 	}
 	return page;
@@ -710,7 +710,7 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
-	trace_dma_unmap_page(dev, dma_handle, size, dir, 0);
+	trace_dma_free_pages(dev, page_to_virt(page), dma_handle, size, dir, 0);
 	debug_dma_unmap_page(dev, dma_handle, size, dir);
 	__dma_free_pages(dev, size, page, dma_handle, dir);
 }
@@ -770,7 +770,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 
 	if (sgt) {
 		sgt->nents = 1;
-		trace_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
+		trace_dma_alloc_sgt(dev, sgt, size, dir, gfp, attrs);
 		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
 	}
 	return sgt;
@@ -789,7 +789,7 @@ static void free_single_sgt(struct device *dev, size_t size,
 void dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
-	trace_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
+	trace_dma_free_sgt(dev, sgt, size, dir);
 	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
 
 	if (use_dma_iommu(dev))
-- 
2.35.1.1320.gc452695387.dirty



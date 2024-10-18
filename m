Return-Path: <linux-kernel+bounces-371893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E509A41DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F50B254F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03AE78C91;
	Fri, 18 Oct 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aNKTReZv"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCA200B96
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263675; cv=none; b=C9cRSjyzbCXB+3lgIGOmdDOMat0tid2ow/RYR+VpwSIgAm5B8cFAcrzwVe5aHmUyRls7VBxcJhsSJ1/PKnjfCKIcNcjPNuMPLOaSYlfk58ZriLBt/KDNeylXu40RjZaFoeVtrfQSqi/9XpbEtIsQ7/wpYKOMEZ92Ll1FhreEreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263675; c=relaxed/simple;
	bh=FflYoVmEaTfoCnf6mxw4dL6I4aSOsuk7qjziVsYvGTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJ0kk3XSUO6Wezhv2+BSV8EJVXWN2iMetoST/tuFzbVpJQsOc4eVJ/9Z22QZ5WD29jJxVrJVw26SlSraeE/1Bbcagovd0Cfffetu1GPtCZ/lO8GqnGdCZ1VvrdM8aYrAFsBzEQqIGzX0cb1ptYvj4E58TZziPN3vMoaok6bxAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aNKTReZv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729263670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOhKEGCgokt7ixwC/an2TCJlA1cCJn4+x/GHCZN12d0=;
	b=aNKTReZvPtHFMoiSKdttb6UBVkvS4tbVOboc5A3UCOcTCQb+kmVQ+XmacglSSLXygWen0+
	zgYEXOB8Zfol3Ii0V873EW+gQgmU8i2iCYnSTnB51DQMoWFA9hswdoi4Uz0aYgxaXddgq3
	4FMzH5Rk03VMdjyGJr2lJYQq1zJiswo=
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
Subject: [PATCH v2 2/4] dma-mapping: Trace dma_alloc/free direction
Date: Fri, 18 Oct 2024 11:00:35 -0400
Message-Id: <20241018150036.2878190-3-sean.anderson@linux.dev>
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

In preparation for using these tracepoints in a few more places, trace
the DMA direction as well. For coherent allocations this is always
bidirectional.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 include/trace/events/dma.h | 18 ++++++++++++------
 kernel/dma/mapping.c       |  6 ++++--
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 3d348cea4d7c..267cfa49d9d5 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -114,8 +114,9 @@ DEFINE_UNMAP_EVENT(dma_unmap_resource);
 
 TRACE_EVENT(dma_alloc,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
-		 size_t size, gfp_t flags, unsigned long attrs),
-	TP_ARGS(dev, virt_addr, dma_addr, size, flags, attrs),
+		 size_t size, enum dma_data_direction dir, gfp_t flags,
+		 unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -123,6 +124,7 @@ TRACE_EVENT(dma_alloc,
 		__field(u64, dma_addr)
 		__field(size_t, size)
 		__field(gfp_t, flags)
+		__field(enum dma_data_direction, dir)
 		__field(unsigned long, attrs)
 	),
 
@@ -135,8 +137,9 @@ TRACE_EVENT(dma_alloc,
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dma_addr=%llx size=%zu virt_addr=%p flags=%s attrs=%s",
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu virt_addr=%p flags=%s attrs=%s",
 		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
 		__entry->dma_addr,
 		__entry->size,
 		__entry->virt_addr,
@@ -146,14 +149,15 @@ TRACE_EVENT(dma_alloc,
 
 TRACE_EVENT(dma_free,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
-		 size_t size, unsigned long attrs),
-	TP_ARGS(dev, virt_addr, dma_addr, size, attrs),
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
 		__field(void *, virt_addr)
 		__field(u64, dma_addr)
 		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
 		__field(unsigned long, attrs)
 	),
 
@@ -162,11 +166,13 @@ TRACE_EVENT(dma_free,
 		__entry->virt_addr = virt_addr;
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
+		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dma_addr=%llx size=%zu virt_addr=%p attrs=%s",
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu virt_addr=%p attrs=%s",
 		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
 		__entry->dma_addr,
 		__entry->size,
 		__entry->virt_addr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 864a1121bf08..944ac835030a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -619,7 +619,8 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	else
 		return NULL;
 
-	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, flag, attrs);
+	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, DMA_BIDIRECTIONAL,
+			flag, attrs);
 	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
 	return cpu_addr;
 }
@@ -644,7 +645,8 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	if (!cpu_addr)
 		return;
 
-	trace_dma_free(dev, cpu_addr, dma_handle, size, attrs);
+	trace_dma_free(dev, cpu_addr, dma_handle, size, DMA_BIDIRECTIONAL,
+		       attrs);
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
 	if (dma_alloc_direct(dev, ops))
 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
-- 
2.35.1.1320.gc452695387.dirty



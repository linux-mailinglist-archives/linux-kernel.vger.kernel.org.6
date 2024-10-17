Return-Path: <linux-kernel+bounces-370392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54569A2BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B01E1F20126
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F41E00AA;
	Thu, 17 Oct 2024 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmzVUPhL"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A941DED44
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188851; cv=none; b=uBXKUjV2XFBnsmc4DALODapAKfu/rHKZYiruiIkEl28dj8syjsehQ4lTO0pkslwmr9InJmEL5H2kQNOW6e8FgCFJSr+YFAZBuZ1nu6ahl2w+Jc9RDQcLEFy8h02hU+CXuys9WSIR6bo7dyuUSnKrM/dJUULe1XgU2d+EYGhJjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188851; c=relaxed/simple;
	bh=XO+oLqPhK2FCwtl+k5xHn8MLn0qkKcZlSKIG+z+asss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHFXjzTfBIgioonk3Uwr+0N0vMWd0E2dp0TwV2FS7MAga2NskviM2G//5ABSGYE0uBuVvL2WWudXwg9pS95q+M0N+SHfQprkWq9kzk0O9Y//AkCd5ExoAwBHqwDmP7DXSESc1ZvFuoFimAe26KpXZbwSFHqyub1OoNfqXbbT2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DmzVUPhL; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729188843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzHmyuSvQgBZ0rMpQ3JAK1It+QHSTZx2/NVdS2eTqbg=;
	b=DmzVUPhLoqfcjzLAgI1+LMhg5q1KFfE1s5gk20uMsJjxwUS9QufgUU8YwIfE9NPRib7BJW
	UJ+aHLeiADWbmV0bMTB+11DZ001h8fPxyAMepyI8CLpwKxqPJQ8hBQqjj4Y1Lga2qLMlJ6
	daoMIfJc+4VhkPX0MUOPqiB7jT+tUwY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/3] dma-mapping: Trace dma_alloc/free direction
Date: Thu, 17 Oct 2024 14:13:52 -0400
Message-Id: <20241017181354.2834674-2-sean.anderson@linux.dev>
In-Reply-To: <20241017181354.2834674-1-sean.anderson@linux.dev>
References: <20241017181354.2834674-1-sean.anderson@linux.dev>
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

 include/trace/events/dma.h | 18 ++++++++++++------
 kernel/dma/mapping.c       |  6 ++++--
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index b0f41265191c..012729cc178f 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -116,8 +116,9 @@ DEFINE_EVENT(dma_unmap, dma_unmap_resource,
 
 TRACE_EVENT(dma_alloc,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
-		 size_t size, gfp_t flags, unsigned long attrs),
-	TP_ARGS(dev, virt_addr, dma_addr, size, flags, attrs),
+		 size_t size, enum dma_data_direction dir, gfp_t flags,
+		 unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -125,6 +126,7 @@ TRACE_EVENT(dma_alloc,
 		__field(u64, dma_addr)
 		__field(size_t, size)
 		__field(gfp_t, flags)
+		__field(enum dma_data_direction, dir)
 		__field(unsigned long, attrs)
 	),
 
@@ -137,8 +139,9 @@ TRACE_EVENT(dma_alloc,
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dma_addr=%llx size=%zu virt_addr=%p flags=%s attrs=%s",
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu virt_addr=%p flags=%s attrs=%s",
 		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
 		__entry->dma_addr,
 		__entry->size,
 		__entry->virt_addr,
@@ -148,14 +151,15 @@ TRACE_EVENT(dma_alloc,
 
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
 
@@ -164,11 +168,13 @@ TRACE_EVENT(dma_free,
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



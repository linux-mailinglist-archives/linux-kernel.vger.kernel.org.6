Return-Path: <linux-kernel+bounces-370033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512029A2627
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D21D281BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B71DB956;
	Thu, 17 Oct 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xr/JJiBx"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85551DE89A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177880; cv=none; b=dkY/xf4WjUCU/ZEb3K4bJPxv0WggfKMFNWy65ZJPPwyCipDbAn7fRM76EAzGzmuqU61n2t5m/iwXMKW8TVnQdxdRHqDU8/ZX59a8Dmb842nuazIN+pH+muV3V84NYGJhua7NKZjxuA/OplEWEaL1On5ERxFaF7QWQENXmzkIQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177880; c=relaxed/simple;
	bh=78VbEsJzL1vYUh50WA71jPZOLp0Ba1kPP5FVnPu22Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B0wvG2Nqxm0kkQXif9v33j7xWNwFlDVGHLs4TFruuyY+7QTHVJyYqZSrwlWVzxr6acGht1zMBYn4/8C86JWmHbe5eK2+XfUtL0Tlo4oRM0k6OfU1vzorgres3HpiTbl+QN9HqBDhcy93BZcLmmEblnqAgfG7sx0cIN4UhC172XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xr/JJiBx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729177872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a6q+RnpFBDPOiiiJDLMbcTS8++Kxh6v+wmc4kW9JV3E=;
	b=xr/JJiBxBP5miVm69oGUzNxiIzpRhwDHISb9zNH7SKWhiEaskO9G1dsxI1S7vSc7Zbm4fk
	LbhHT6kivnlYdEUWKLUQ5gdk53qrQtpDsB8Mj3ho6eXP8csgsb366ISYdCfv6BueoyGCzg
	bsyBQKfCQQtfATsshvHTIOtwqHswLNw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com
Subject: [PATCH] dma-mapping: Fix tracing dma_alloc/free with vmalloc'd memory
Date: Thu, 17 Oct 2024 11:10:55 -0400
Message-Id: <20241017151055.2806066-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Not all virtual addresses have physical addresses, such as if they were
vmalloc'd. Just trace the virtual address instead of trying to trace a
physical address. This aligns with the API, and is good enough to
associate dma_alloc with dma_free.

Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
Reported-by: syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/670ebde5.050a0220.d9b66.0154.GAE@google.com/
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
%p obfuscates virtual addresses when tracing just like with printk.

 include/trace/events/dma.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 569f86a44aaa..b0f41265191c 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -121,7 +121,7 @@ TRACE_EVENT(dma_alloc,
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
-		__field(u64, phys_addr)
+		__field(void *, virt_addr)
 		__field(u64, dma_addr)
 		__field(size_t, size)
 		__field(gfp_t, flags)
@@ -130,18 +130,18 @@ TRACE_EVENT(dma_alloc,
 
 	TP_fast_assign(
 		__assign_str(device);
-		__entry->phys_addr = virt_to_phys(virt_addr);
+		__entry->virt_addr = virt_addr;
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
 		__entry->flags = flags;
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dma_addr=%llx size=%zu phys_addr=%llx flags=%s attrs=%s",
+	TP_printk("%s dma_addr=%llx size=%zu virt_addr=%p flags=%s attrs=%s",
 		__get_str(device),
 		__entry->dma_addr,
 		__entry->size,
-		__entry->phys_addr,
+		__entry->virt_addr,
 		show_gfp_flags(__entry->flags),
 		decode_dma_attrs(__entry->attrs))
 );
@@ -153,7 +153,7 @@ TRACE_EVENT(dma_free,
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
-		__field(u64, phys_addr)
+		__field(void *, virt_addr)
 		__field(u64, dma_addr)
 		__field(size_t, size)
 		__field(unsigned long, attrs)
@@ -161,17 +161,17 @@ TRACE_EVENT(dma_free,
 
 	TP_fast_assign(
 		__assign_str(device);
-		__entry->phys_addr = virt_to_phys(virt_addr);
+		__entry->virt_addr = virt_addr;
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dma_addr=%llx size=%zu phys_addr=%llx attrs=%s",
+	TP_printk("%s dma_addr=%llx size=%zu virt_addr=%p attrs=%s",
 		__get_str(device),
 		__entry->dma_addr,
 		__entry->size,
-		__entry->phys_addr,
+		__entry->virt_addr,
 		decode_dma_attrs(__entry->attrs))
 );
 
-- 
2.35.1.1320.gc452695387.dirty



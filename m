Return-Path: <linux-kernel+bounces-371891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB959A41DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC728C6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB51200BB1;
	Fri, 18 Oct 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SjxUftEc"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA278C91
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263671; cv=none; b=nADgnqqRIShKhh3SuN6untfo6dFVW6631732UR0NX/x3fRX+2/yRXoczvsK96Ho9TDFrhngm/z8ZMcjnOpgsLt3mlPpuFC+rid0IjV71Sr+gEjcAliJLKxh8tD96vFi1yg9LHmfTK/UxeA88/A0TNNK5hvqeNxnX0vHJn+et2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263671; c=relaxed/simple;
	bh=6ychNUbuINVXdsVvpz1dtumTWLHjSfyYtkHsRdDm454=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svQ/sDd90MY3G9kccHI7MbRGZ8UkeVGPrsvFjLNdXIc3dydVRt5BUy/BzxdpT6pyX/n+Cq7KFK6MGZdcrs1968ksJ/7o1ZUym8NybjQf0F4oSKF9Zly2kZjJ7NA+R8ip6QYBGVnfjgpRqmRmawe15TMf/bSgQSVn1AfrYCXmcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SjxUftEc; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729263666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UvvnK4fcSjvxd/X21ONu95YZX+qIikjbIWJ5EiCB+vg=;
	b=SjxUftEcZ9LhZd8b5mye63Ons/SiQeK/cDCvpnCn+sTSV05/2gCLj6Nfef9H/oVRZ1IP4q
	YY3qDHjWzDZL7YNHPTJ9R9N503iXH/JPQHDi/2QU4400a0ZjzhT9T8gQ7AZLfm9crJDR5+
	nzHfCSevk9YlFBUE18M1wZeGMEwQJhE=
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
Subject: [PATCH v2 0/4] dma-mapping: Trace more error paths
Date: Fri, 18 Oct 2024 11:00:33 -0400
Message-Id: <20241018150036.2878190-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some DMA functions are not traced when they fail. I found this pretty
confusing, since it seems like the device skips calling the DMA function
and fails anyway. This series adds some additional tracepoints to
address this.

Changes in v2:
- Use macros to define events in a class

Sean Anderson (4):
  dma-mapping: Use macros to define events in a class
  dma-mapping: Trace dma_alloc/free direction
  dma-mapping: Use trace_dma_alloc for dma_alloc* instead of using
    trace_dma_map
  dma-mapping: Trace more error paths

 include/trace/events/dma.h | 213 ++++++++++++++++++++++++++++++-------
 kernel/dma/mapping.c       |  37 ++++---
 2 files changed, 198 insertions(+), 52 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty



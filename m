Return-Path: <linux-kernel+bounces-174099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C888C0A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8465B284755
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE0148300;
	Thu,  9 May 2024 03:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C9I4kRw8"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4ED26D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226137; cv=none; b=VBtffYJQEB4muBUoQS/rDQNUp941QmLYBdYcEyu1YnqHpupWBFf7PSQKc7AmCNp6HkY+r+sPoYDhkRRk9Xe8c8PMnUwuLo9mK2TgAiEMP7H0msSFU2EGkX3yCkCJwVb/6hcGpWJAtuWve5XuBP7VghEUtQmRe4wXX/0n42dNLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226137; c=relaxed/simple;
	bh=XbA4R/OJ/QKmeYyGMLZ4INzajwfxLTjdWKYR/SsggFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQQFkPQGhOcOLsQvHZsHqY13wDChxesy9Nb3Bp22bAcOyyJWGtY+TxRDVzzl2dKg8nxNFAd8Q9bdxzlGBPXoShWWZJEPpQeVMMw7EYzu4hrVb2BlxRZnxXL/U6Ac6BiLjE7p09KpV/6hzcSdv35LTjcZUKL4p6dNVmpWl8QxByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C9I4kRw8; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715226131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKLnjSMYW0rtryZBKZNGvNcP75p9Czb+/CvNXoeOoAw=;
	b=C9I4kRw8fb5UDp4pkzGRA9H3dZUtxqRmgP11T3RHqa8y3PoFuD/D9efJmQPHvyF/6rFi1f
	v7DvUV/c+DXZQPcbHtZL4P2IUSG7Nz1hbvfhvC+ERpvVgHD5GChL9h3uzRPnWdYLlU3v/V
	bqVXOv6tZwCWPqg9o0Og5NQnUZ/i53g=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 1/9] mm: memcg: introduce memcontrol-v1.c
Date: Wed,  8 May 2024 20:41:30 -0700
Message-ID: <20240509034138.2207186-2-roman.gushchin@linux.dev>
In-Reply-To: <20240509034138.2207186-1-roman.gushchin@linux.dev>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces the mm/memcontrol-v1.c source file which will be used for
all legacy (cgroup v1) memory cgroup code.

As of now, let's compile it if CONFIG_MEMCG is set, similar to mm/memcontrol.c.
Later on it can be switched to use a separate config option, so that the legacy
code won't be compiled if not required.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/Makefile        | 3 ++-
 mm/memcontrol-v1.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 mm/memcontrol-v1.c

diff --git a/mm/Makefile b/mm/Makefile
index 25da205becdd..c717a3ee612e 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -26,6 +26,7 @@ KCOV_INSTRUMENT_page_alloc.o := n
 KCOV_INSTRUMENT_debug-pagealloc.o := n
 KCOV_INSTRUMENT_kmemleak.o := n
 KCOV_INSTRUMENT_memcontrol.o := n
+KCOV_INSTRUMENT_memcontrol-v1.o := n
 KCOV_INSTRUMENT_mmzone.o := n
 KCOV_INSTRUMENT_vmstat.o := n
 KCOV_INSTRUMENT_failslab.o := n
@@ -95,7 +96,7 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
-obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+obj-$(CONFIG_MEMCG) += memcontrol.o memcontrol-v1.o vmpressure.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
new file mode 100644
index 000000000000..4bc66fc244c0
--- /dev/null
+++ b/mm/memcontrol-v1.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
-- 
2.43.2



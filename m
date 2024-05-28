Return-Path: <linux-kernel+bounces-193019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F098D25B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA400284002
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364C778C96;
	Tue, 28 May 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXZSc8P/"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7D2FB2
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927694; cv=none; b=fkRbaLbV382JwgU83UAesoeOs7TVhwqcqYKlXTeyorVuGD4MRHJOVnA4ob9zdV1bvlb6yzBWzYZ2oih/NHF41LPiAJVCzCYSnt3sNDLBl7wP6dz0T0a+XiH19SpNBE9DzNH58IJ5CGMh/us7Yv3IUk2aKfg7xp4st8JHKsXW84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927694; c=relaxed/simple;
	bh=GcC1nM0KPHMi8J+HZspHXls7Ljq3h3rbKXZ9orPDqxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWUgt+XVfcxABBAi4gqlDqaXj/4cVXjOGQAi5uN4UKeCHeih52EagMfpI7u8BXD8jvxr5WdH94nixwmWAX7/ZTgJvW3nSu1PaOkpYNles4lYMej8nWHXAz3UeWMhbcZs69QQvQIk0SfkjbC1a3euWbTCddaZ8HZBK9JMv8nkV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXZSc8P/; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716927690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skdB+ennJA28iFKwvEIuJBTK1zA9kQ9+RV54OQgd+d4=;
	b=kXZSc8P/l1zrFGRit40gHI3whujSvruQH3YhSlwEZ1uUMcCozwIdWfL6qDEkcRm9QzDSVc
	UHRXLckf864TfJOmD04sKC+D6vsPTG6HnILGtUgBzBbnRKJRSLW+ud56nXyAeDqTjFyNeV
	B/HrZW4NnMEMOrjHq8VMrBAJkpsXtPo=
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
Subject: [PATCH v1 01/14] mm: memcg: introduce memcontrol-v1.c
Date: Tue, 28 May 2024 13:20:53 -0700
Message-ID: <20240528202101.3099300-2-roman.gushchin@linux.dev>
In-Reply-To: <20240528202101.3099300-1-roman.gushchin@linux.dev>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces the mm/memcontrol-v1.c source file which will be used for
all legacy (cgroup v1) memory cgroup code. It also introduces mm/memcontrol-v1.h
to keep declarations shared between mm/memcontrol.c and mm/memcontrol-v1.c.

As of now, let's compile it if CONFIG_MEMCG is set, similar to mm/memcontrol.c.
Later on it can be switched to use a separate config option, so that the legacy
code won't be compiled if not required.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/Makefile        | 3 ++-
 mm/memcontrol-v1.c | 3 +++
 mm/memcontrol-v1.h | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 mm/memcontrol-v1.c
 create mode 100644 mm/memcontrol-v1.h

diff --git a/mm/Makefile b/mm/Makefile
index 8fb85acda1b1c..124d4dea20351 100644
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
index 0000000000000..a941446ba575b
--- /dev/null
+++ b/mm/memcontrol-v1.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "memcontrol-v1.h"
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
new file mode 100644
index 0000000000000..7c5f094755ff8
--- /dev/null
+++ b/mm/memcontrol-v1.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MM_MEMCONTROL_V1_H
+#define __MM_MEMCONTROL_V1_H
+
+
+#endif	/* __MM_MEMCONTROL_V1_H */
-- 
2.45.1



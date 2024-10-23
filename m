Return-Path: <linux-kernel+bounces-378621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB39AD348
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0BC1F21AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2D71CF5CB;
	Wed, 23 Oct 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3h5u2jw"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAB83CDA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705843; cv=none; b=uaP8ZbG8zCmFnC2fYo1ihr3N5yT2/mK+yvhAlHrwRDtXpj7D24f1YJR/kn0mrLaJY+QwfFNg85bscc7tqDfGPFm4rqIsGI7n633Qm+/d040+dVhpxhz21YptyN1pkE/fWYxKmabegWhqtnfUVVH3u6e4u4dmU1rYBZCUPYX+XvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705843; c=relaxed/simple;
	bh=U+dF3PrseWIsY+0K+pH1rf7XUrawSY1PaLbYxhEONXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L+gq5PGf87EmVuz4GtgdHNoyivRrdoQZTsXI0KcDi1xTslrQQJE3rT9HhYDrVVOsU49a1GZyu8gOXaJuc1u0S7FhihmTw5pZpoI5MmS+2GsDIGi3Ds3nN1+wePU/KDuqBIdbAGwxkxUtASznVMCfWN/qMSTJoh2segor4h14850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3h5u2jw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e5130832aso74164b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729705841; x=1730310641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tckut9jQa7rI5qyZ9d3+QecKLLm/EO/R4ZdBFp+YfyY=;
        b=X3h5u2jw6YGO8hZCXFqb72BMcpKIRFGGHSPKq8QztRUhFgSq4N2Wv2nYu77EkmMcVK
         6JIXjSEGFiEavd9sbOzu2Piq2plOJUWD0U7jKbgS4R+OYB//2n8uQBNlP5255XMIHi/h
         UCIscavW/AvsZOmW+reLZrq1HC1WKlPUXwZjGmPbju1Ln9uoI9asd83ZSBuiSW3cUI2A
         dLjJbFf5T8ca5Sa8LssDU8kHyMYky7w/voG8nCpol5K+/SqBFZs6twnSU49K2vgDb5DD
         QDnaIgFg7hV7ezG7ciqf90D0LCvj1LFODZe09CcgKuejXywrKBMT3+zIhFelvUYDBTyJ
         /16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705841; x=1730310641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tckut9jQa7rI5qyZ9d3+QecKLLm/EO/R4ZdBFp+YfyY=;
        b=cg7hJKf+ed17t7NjvOVRqxQ8vcwM3gwZCWM8WJAKB9YSbTwKS+VKVm1k3lmBiY+7Xy
         hfC877G9hy857PhkQ7moGjait0GNh3WVc3ndmATphqxv5NacKjg51ymM7ya2PFTNFETE
         gMCqGV8xd2UNWlkjS+WCRR4+dtz1mz+ZNeRkG2yetfyMBJdQ5fQqdo2/WAL4dgDGVVa8
         PXd1Xe0tiTL9D4ahE+Lu9/GeuySdev3RxKeNIprVrwxIIc/9eTvrXmNmH9qmUeH0SQFW
         qyPEL00kfBfpQgivtLsrJ2U1CW388sME7+OWOLecaole3ZRzl2+O/FjLtUT8cYgnKdSC
         nQGw==
X-Forwarded-Encrypted: i=1; AJvYcCVhLK2l1/GiVaWPMUirNRrgZBSXrgV2pgSwWsxJmFV9Osvd5na9zxgDMy4KDeijt4/qhbiOBqLPFT1BO4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CM1jrW2DeYh2NCAke06qdRXks6CMm26IB38LcEO24s2wd+NY
	mhtdUiRx2drYwY1vTR9ry3V4MWYY0ist6mlhS8KKPIyoT9e71phQ
X-Google-Smtp-Source: AGHT+IHbC9BxbdNRtNpmuEEUlHVpNB2/puTTvWOYiXtmO2xMU+xZAuBvui1C9Ac0Lt++cOuZApV5Mg==
X-Received: by 2002:a05:6a20:7b1e:b0:1d9:83cc:fd48 with SMTP id adf61e73a8af0-1d983ccfe02mr542463637.17.1729705841218;
        Wed, 23 Oct 2024 10:50:41 -0700 (PDT)
Received: from eqbm-smc020.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eb02bsm6817795b3a.178.2024.10.23.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:50:40 -0700 (PDT)
From: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: dave@stgolabs.net,
	dan.j.williams@intel.com,
	nifan@outlook.com,
	a.manzanares@samsung.com,
	Dongjoo Seo <dongjoo.linux.dev@gmail.com>
Subject: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Date: Wed, 23 Oct 2024 10:50:37 -0700
Message-Id: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects this issue by:
1. Checking if the zone or preferred zone is CPU-less before updating
   the NUMA stats.
2. Ensuring NUMA_HIT is only updated if the zone is not CPU-less.
3. Ensuring NUMA_FOREIGN is only updated if the preferred zone is not
   CPU-less.

Example Before and After Patch:
- Before Patch:
 node0                   node1           node2
 numa_hit                86333181       114338269            5108
 numa_miss                5199455               0        56844591
 numa_foreign            32281033        29763013               0
 interleave_hit                91              91               0
 local_node              86326417       114288458               0
 other_node               5206219           49768        56849702

- After Patch:
                            node0           node1           node2
 numa_hit                 2523058         9225528               0
 numa_miss                 150213           10226        21495942
 numa_foreign            17144215         4501270               0
 interleave_hit                91              94               0
 local_node               2493918         9208226               0
 other_node                179351           27528        21495942

In the case of memoryless node, when a process prefers a node
with no memory(e.g., because it is running on a CPU local to that
node), the kernel treats a nearby node with memory as the
preffered node. As a result, such allocation do not increment the
numa_foreign counter on the memoryless node, leading to skewed
NUMA_HIT, NUMA_MISS, and NUMA_FOREIGN stat for the nearest node.

Similarly, in the context of cpuless nodes, this patch ensures
that NUMA statistics are accurately updated by adding checks to
prevent the miscounting of memory allocations when the involved
nodes have no CPUs. This ensures more precise tracking of memory
access patterns accross all nodes, regardless of whether they
have CPUs or not, improving the overall reliability of NUMA stat.
The reason is that page allocation from dev_dax, cpuset, memcg ..
comes with preferred allocating zone in cpuless node and its hard
to track the zone info for miss information.

Signed-off-by: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Fan Ni <nifan@outlook.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>
---
 mm/page_alloc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0f33dab6d344..2981466e8e1a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2894,19 +2894,21 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 {
 #ifdef CONFIG_NUMA
 	enum numa_stat_item local_stat = NUMA_LOCAL;
+	bool z_is_cpuless = !node_state(zone_to_nid(z), N_CPU);
+	bool pref_is_cpuless = !node_state(zone_to_nid(preferred_zone), N_CPU);
 
-	/* skip numa counters update if numa stats is disabled */
 	if (!static_branch_likely(&vm_numa_stat_key))
 		return;
 
-	if (zone_to_nid(z) != numa_node_id())
+	if (zone_to_nid(z) != numa_node_id() || z_is_cpuless)
 		local_stat = NUMA_OTHER;
 
-	if (zone_to_nid(z) == zone_to_nid(preferred_zone))
+	if (zone_to_nid(z) == zone_to_nid(preferred_zone) && !z_is_cpuless)
 		__count_numa_events(z, NUMA_HIT, nr_account);
 	else {
 		__count_numa_events(z, NUMA_MISS, nr_account);
-		__count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
+		if (!pref_is_cpuless)
+			__count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
 	}
 	__count_numa_events(z, local_stat, nr_account);
 #endif
-- 
2.39.2



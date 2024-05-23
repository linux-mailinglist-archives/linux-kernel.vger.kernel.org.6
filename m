Return-Path: <linux-kernel+bounces-186960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207988CCB40
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB871F21551
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191892628D;
	Thu, 23 May 2024 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3eDKVBX"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D664685
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716436116; cv=none; b=G5XF10vpXrWWhnk9M+Hn3ePtvd/TLVtBUfs7C4EWN8n71oeEyzOttHzg9XKsQC9Ch8E97PsBWbcMkL2mlljMh1R0ulT0yAJSIYs/alI8TNaNqOFmxEesKLbZ9/ULlQudfnDdhOwC81saWVMwkBtcljOxcXju8Zu06iM1/HMYH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716436116; c=relaxed/simple;
	bh=jNp+TEvRuZkksS4ul5rTStcak21EccI9wVUKp5aOruY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5wOCBd7Nxb8dab/isvR4IrKu4rL0paTJAQXmCVqpEktatM4YdZ/VLlHmLDdE11KZoEELWIEMbLhG6tbCxGuWyauCsD/vwPSt4UwnQQhg/HXbKESfk4To7TvdzRCPiVSxsEJpa0ZC12VPYWTbJ8sUEhl6j/VsCtAGz++Y5OdFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3eDKVBX; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716436111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9tRgZzPEJaTN9YuDC4V2f++GoQNnZ4Ze+CSXfRX166U=;
	b=r3eDKVBX9w7H4aGL4t4v+4/UcYTl0OATfN707odf84XUtGWG1uh8PBqJF7P2H2909mvwkw
	Br64rnLByw/jpLjSZQLdN13e5o72SgHQ1AbBVq/vSDFiAxvqe++U6fZmA0EaXoxnknehWE
	elzJcJ0GPfuQW1QcxY5WMTgVAM1qP2U=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
X-Envelope-To: oliver.sang@intel.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>
Cc: ying.huang@intel.com,
	feng.tang@intel.com,
	fengwei.yin@intel.com,
	oliver.sang@intel.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memcg: rearrage fields of mem_cgroup_per_node
Date: Wed, 22 May 2024 20:48:24 -0700
Message-ID: <20240523034824.1255719-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Kernel test robot reported [1] performance regression for will-it-scale
test suite's page_fault2 test case for the commit 70a64b7919cb ("memcg:
dynamically allocate lruvec_stats"). After inspection it seems like the
commit has unintentionally introduced false cache sharing.

After the commit the fields of mem_cgroup_per_node which get read on the
performance critical path share the cacheline with the fields which
get updated often on LRU page allocations or deallocations. This has
caused contention on that cacheline and the workloads which manipulates
a lot of LRU pages are regressed as reported by the test report.

The solution is to rearrange the fields of mem_cgroup_per_node such that
the false sharing is eliminated. Let's move all the read only pointers
at the start of the struct, followed by memcg-v1 only fields and at the
end fields which get updated often.

Experiment setup: Ran fallocate1, fallocate2, page_fault1, page_fault2
and page_fault3 from the will-it-scale test suite inside a three level
memcg with /tmp mounted as tmpfs on two different machines, one a single
numa node and the other one, two node machine.

 $ ./[testcase]_processes -t $NR_CPUS -s 50

Results for single node, 52 CPU machine:

Testcase        base        with-patch

fallocate1      1031081     1431291  (38.80 %)
fallocate2      1029993     1421421  (38.00 %)
page_fault1     2269440     3405788  (50.07 %)
page_fault2     2375799     3572868  (50.30 %)
page_fault3     28641143    28673950 ( 0.11 %)

Results for dual node, 80 CPU machine:

Testcase        base        with-patch

fallocate1      2976288     3641185  (22.33 %)
fallocate2      2979366     3638181  (22.11 %)
page_fault1     6221790     7748245  (24.53 %)
page_fault2     6482854     7847698  (21.05 %)
page_fault3     28804324    28991870 ( 0.65 %)

Fixes: 70a64b7919cb ("memcg: dynamically allocate lruvec_stats")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202405171353.b56b845-oliver.sang@intel.com
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..16efd9737be9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -96,23 +96,25 @@ struct mem_cgroup_reclaim_iter {
  * per-node information in memory controller.
  */
 struct mem_cgroup_per_node {
-	struct lruvec		lruvec;
+	/* Keep the read-only fields at the start */
+	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
+						/* use container_of	   */
 
 	struct lruvec_stats_percpu __percpu	*lruvec_stats_percpu;
 	struct lruvec_stats			*lruvec_stats;
-
-	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
-
-	struct mem_cgroup_reclaim_iter	iter;
-
 	struct shrinker_info __rcu	*shrinker_info;
 
+	/* memcg-v1 only stuff in middle */
+
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
 	bool			on_tree;
-	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
-						/* use container_of	   */
+
+	/* Fields which get updated often at the end. */
+	struct lruvec		lruvec;
+	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
+	struct mem_cgroup_reclaim_iter	iter;
 };
 
 struct mem_cgroup_threshold {
-- 
2.43.0



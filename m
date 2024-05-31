Return-Path: <linux-kernel+bounces-196199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B98D58B7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F2D287253
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2402E7711F;
	Fri, 31 May 2024 02:49:27 +0000 (UTC)
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9B78C7A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123766; cv=none; b=QgfROSjVy6ANjzqwtQrIyS3K7frgQs/VrlrM7aRF+4o7rCrpaMsyP234rz3EPZkB4pbPZ+evd8E6EmK3nMMZFgRmtTN6qZ/CkbqwrnyUycSp+D2iAeh4uyQWsRTR6mzjWww53HLShsMKvhAuUnuioRB0nDLRFawku4lsLOzPJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123766; c=relaxed/simple;
	bh=yC+LB2Y6jUoQAATr+h19M50CQIqqD4nkhuJXFLuUmIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jgj0NArw22IWj2VJ1tghXDz1YydgoNrS1MlZ41GkR/gXEwkIl0SBslcWGauJX+cmmDRfu0hDuEST0qDljSTCrf3M9N/FI+2y/xBWoPQ0I8My7CpeSzyyBkzTP4TgkIlWgNAvVHGtGwfOsYVfVfcuqcgNFD3I4M2ODElHCWX1sCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost
Received: from unknown (HELO localhost)([101.132.132.191])
	by sina.com (10.182.253.22) with ESMTP
	id 66593A8700000D3E; Fri, 31 May 2024 10:48:41 +0800 (CST)
X-Sender: ghostxavier@sina.com
X-Auth-ID: ghostxavier@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=ghostxavier@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=ghostxavier@sina.com
X-SMAIL-MID: 2472246816138
X-SMAIL-UIID: C36FAEE0ECE84822B888075C91066179-20240531-104841-1
From: Xavier <ghostxavier@sina.com>
To: longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>
Subject: [PATCH v2] cpuset: Optimize the number of iterations in the scheduling domain construction process
Date: Fri, 31 May 2024 10:48:37 +0800
Message-Id: <20240531024837.255293-1-ghostxavier@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The process of constructing scheduling domains involves multiple loops
and repeated evaluations, leading to numerous redundant and ineffective
assessments that impact code efficiency.

Here, we use Union-Find to optimize the merging of cpumasks. By employing
path compression and union by rank, we effectively reduce the number of
lookups and merge comparisons.

Signed-off-by: Xavier <ghostxavier@sina.com>
---
 kernel/cgroup/cpuset.c | 117 +++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 51 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c12b9fdb2..4bea1c2db 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -891,6 +891,44 @@ static inline int nr_cpusets(void)
 	return static_key_count(&cpusets_enabled_key.key) + 1;
 }
 
+/*define a union find node struct*/
+struct uf_node {
+	int parent;
+	int rank;
+};
+
+static int find_root(struct uf_node *nodes, int x)
+{
+	int root = x;
+	int parent;
+
+	/*Find the root node and perform path compression at the same time*/
+	while (nodes[root].parent != root) {
+		parent = nodes[root].parent;
+		nodes[root].parent = nodes[parent].parent;
+		root = parent;
+	}
+	return root;
+}
+
+/*Function to merge two sets, using union by rank*/
+static void union_sets(struct uf_node *nodes, int a, int b)
+{
+	int root_a = find_root(nodes, a);
+	int root_b = find_root(nodes, b);
+
+	if (root_a != root_b) {
+		if (nodes[root_a].rank < nodes[root_b].rank) {
+			nodes[root_a].parent = root_b;
+		} else if (nodes[root_a].rank > nodes[root_b].rank) {
+			nodes[root_b].parent = root_a;
+		} else {
+			nodes[root_b].parent = root_a;
+			nodes[root_a].rank++;
+		}
+	}
+}
+
 /*
  * generate_sched_domains()
  *
@@ -950,13 +988,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
-	int i, j, k;		/* indices for partition finding loops */
+	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
 	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
+	struct uf_node *nodes;
 
 	doms = NULL;
 	dattr = NULL;
@@ -1022,33 +1061,31 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	}
 	rcu_read_unlock();
 
-	for (i = 0; i < csn; i++)
-		csa[i]->pn = i;
-	ndoms = csn;
-
-restart:
-	/* Find the best partition (set of sched domains) */
-	for (i = 0; i < csn; i++) {
-		struct cpuset *a = csa[i];
-		int apn = a->pn;
+	nodes = kmalloc_array(csn, sizeof(struct uf_node), GFP_KERNEL);
+	if (!nodes)
+		goto done;
 
-		for (j = 0; j < csn; j++) {
-			struct cpuset *b = csa[j];
-			int bpn = b->pn;
 
-			if (apn != bpn && cpusets_overlap(a, b)) {
-				for (k = 0; k < csn; k++) {
-					struct cpuset *c = csa[k];
+	/* Each node is initially its own parent */
+	for (i = 0; i < csn; i++) {
+		nodes[i].parent = i;
+		nodes[i].rank = 0;
+	}
 
-					if (c->pn == bpn)
-						c->pn = apn;
-				}
-				ndoms--;	/* one less element */
-				goto restart;
-			}
+	/* Merge overlapping cpusets */
+	for (i = 0; i < csn; i++) {
+		for (j = i + 1; j < csn; j++) {
+			if (cpusets_overlap(csa[i], csa[j]))
+				union_sets(nodes, i, j);
 		}
 	}
 
+	/* Calculate the number of domains after merging */
+	for (i = 0; i < csn; i++) {
+		if (nodes[i].parent == i)
+			ndoms++;
+	}
+
 	/*
 	 * Now we know how many domains to create.
 	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
@@ -1065,47 +1102,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
 			      GFP_KERNEL);
 
 	for (nslot = 0, i = 0; i < csn; i++) {
-		struct cpuset *a = csa[i];
-		struct cpumask *dp;
-		int apn = a->pn;
-
-		if (apn < 0) {
-			/* Skip completed partitions */
-			continue;
-		}
-
-		dp = doms[nslot];
-
-		if (nslot == ndoms) {
-			static int warnings = 10;
-			if (warnings) {
-				pr_warn("rebuild_sched_domains confused: nslot %d, ndoms %d, csn %d, i %d, apn %d\n",
-					nslot, ndoms, csn, i, apn);
-				warnings--;
-			}
-			continue;
-		}
+		struct cpumask *dp = doms[nslot];
 
 		cpumask_clear(dp);
 		if (dattr)
 			*(dattr + nslot) = SD_ATTR_INIT;
 		for (j = i; j < csn; j++) {
-			struct cpuset *b = csa[j];
+			if (find_root(nodes, j) == i) {
+				if (i == j)
+					nslot++;
 
-			if (apn == b->pn) {
-				cpumask_or(dp, dp, b->effective_cpus);
+				cpumask_or(dp, dp, csa[j]->effective_cpus);
 				cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
 				if (dattr)
-					update_domain_attr_tree(dattr + nslot, b);
-
-				/* Done with this partition */
-				b->pn = -1;
+					update_domain_attr_tree(dattr + nslot, csa[j]);
 			}
 		}
-		nslot++;
 	}
 	BUG_ON(nslot != ndoms);
-
+	kfree(nodes);
 done:
 	kfree(csa);
 
-- 
2.34.1



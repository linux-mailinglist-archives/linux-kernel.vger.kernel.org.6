Return-Path: <linux-kernel+bounces-544887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A3A4E655
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9866E8C2A17
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEA32045B7;
	Tue,  4 Mar 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZKXKxzpg"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF129B234
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104564; cv=none; b=L/iyxAqkLKKSlJpFjgAXqVC8+ZySMHjDToJAjcwIncvUjIB2yvjhhvhpjWTEz5XityBVE0QdT5/EAKjpxNRPY9QabPdHYDoB7wAloaQhH7TxH2fZE/eBbzA08F8Ycw0lvYDXUv1gCgpsm8NzNqg2UJ1w5g+3wSnNA/0B313R08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104564; c=relaxed/simple;
	bh=d9lE6uYynOpXuBv8OjFS5nKa2ct+/LoGZmNr7wreTo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJSq34p0me6QS5QfPeDDz0S7YRo93UOi9nONlJsDE95ed0VFyblUHN1y6GNEv0krdD2l3S0WgBXBTxNzl9mkNRuEvFuGVXuntDgfeqmnkgWfNig/B3RLfD/MJBWjM320emgc3UlyWrKKLObhXhVazJQKmLKGarY296/terW8JPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZKXKxzpg; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524FQdoS009012;
	Tue, 4 Mar 2025 16:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=0GJKDs6fZHjtm
	SKJsKmUawglHJQTIGhcgKQBQ/AV7Cc=; b=ZKXKxzpg9hQH5m0pCTGo7UFHkol4J
	khqyBwopjTwVYLU8/5EQgMmK/5Ms3oi2MrsEucLxBePKgg8FnCuwuOan4tq7ToY4
	Yps70QTMI78I2wcUoBSNa+bIt4jYMQiipadKC8DE9Fpji+1OFisVGK+ceD2a7VN5
	B1r0cxfsWvW7ScpBJ+ud2FnD97MmqeGY/G62AKN4B0ksYFV9Owf/a04jOYZ10m6E
	Pv+72Bi1m7fo5Sbl3qZ0Rleo9yl8mvD0r7ooR3+MbOGe91R9fHWKJsduTKep9+H5
	VRoZZTobFUCaF5BqEEwqjfkqKBhkdnsWL/5ngjeSO/ZPGqNCrRLkvXpug==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 455yvr2uxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:08:47 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0866E36CD2;
	Tue,  4 Mar 2025 16:08:46 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id C1B798014FB;
	Tue,  4 Mar 2025 16:08:44 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 438FD300069FE; Tue,  4 Mar 2025 10:08:44 -0600 (CST)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH v4 1/2] sched/topology: improve topology_span_sane speed
Date: Tue,  4 Mar 2025 10:08:43 -0600
Message-Id: <20250304160844.75373-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250304160844.75373-1-steve.wahl@hpe.com>
References: <20250304160844.75373-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rwcho1Mf0EbGQFMx542VFZNiAw0IcoKv
X-Proofpoint-GUID: Rwcho1Mf0EbGQFMx542VFZNiAw0IcoKv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040129

Use a different approach to topology_span_sane(), that checks for the
same constraint of no partial overlaps for any two CPU sets for
non-NUMA topology levels, but does so in a way that is O(N) rather
than O(N^2).

Instead of comparing with all other masks to detect collisions, keep
one mask that includes all CPUs seen so far and detect collisions with
a single cpumask_intersects test.

If the current mask has no collisions with previously seen masks, it
should be a new mask, which can be uniquely identified by the lowest
bit set in this mask.  Keep a pointer to this mask for future
reference (in an array indexed by the lowest bit set), and add the
CPUs in this mask to the list of those seen.

If the current mask does collide with previously seen masks, it should
be exactly equal to a mask seen before, looked up in the same array
indexed by the lowest bit set in the mask, a single comparison.

Move the topology_span_sane() check out of the existing topology level
loop, let it use its own loop so that the array allocation can be done
only once, shared across levels.

On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
the average time to take one processor offline is reduced from 2.18
seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
34m49.765s without this change, 16m10.038s with this change in place.)

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---

Version 4: No change.

Version 3 discussion:
    https://lore.kernel.org/all/20250210154259.375312-1-steve.wahl@hpe.com/

Version 3: While the intent of this patch is no functional change, I
discovered that version 2 had conditions where it would give different
results than the original code.  Version 3 returns to the V1 approach,
fixing the num_possible_cpus() problem Peter Zijlstra noted.  In a
stand-alone test program that used all possible sets of four 4-bit
masks, this algorithm matched the original code in all cases, where
the others did not.

Version 2 discussion:
    https://lore.kernel.org/all/20241031200431.182443-1-steve.wahl@hpe.com/

Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
simplifies the code, and eliminates the erroneous use of
num_possible_cpus() that Peter Zijlstra noted.

Version 1 discussion:
    https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/

 kernel/sched/topology.c | 83 ++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..3fb834301315 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2356,36 +2356,69 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 /*
  * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
- * any two given CPUs at this (non-NUMA) topology level.
+ * any two given CPUs on non-NUMA topology levels.
  */
-static bool topology_span_sane(struct sched_domain_topology_level *tl,
-			      const struct cpumask *cpu_map, int cpu)
+static bool topology_span_sane(const struct cpumask *cpu_map)
 {
-	int i = cpu + 1;
+	struct sched_domain_topology_level *tl;
+	const struct cpumask **masks;
+	struct cpumask *covered;
+	int cpu, id;
+	bool ret = false;
 
-	/* NUMA levels are allowed to overlap */
-	if (tl->flags & SDTL_OVERLAP)
-		return true;
+	lockdep_assert_held(&sched_domains_mutex);
+	covered = sched_domains_tmpmask;
+
+	masks = kmalloc_array(nr_cpu_ids, sizeof(struct cpumask *), GFP_KERNEL);
+	if (!masks)
+		return ret;
+
+	for_each_sd_topology(tl) {
+
+		/* NUMA levels are allowed to overlap */
+		if (tl->flags & SDTL_OVERLAP)
+			continue;
+
+		cpumask_clear(covered);
+		memset(masks, 0, nr_cpu_ids * sizeof(struct cpumask *));
 
-	/*
-	 * Non-NUMA levels cannot partially overlap - they must be either
-	 * completely equal or completely disjoint. Otherwise we can end up
-	 * breaking the sched_group lists - i.e. a later get_group() pass
-	 * breaks the linking done for an earlier span.
-	 */
-	for_each_cpu_from(i, cpu_map) {
 		/*
-		 * We should 'and' all those masks with 'cpu_map' to exactly
-		 * match the topology we're about to build, but that can only
-		 * remove CPUs, which only lessens our ability to detect
-		 * overlaps
+		 * Non-NUMA levels cannot partially overlap - they must be either
+		 * completely equal or completely disjoint. Otherwise we can end up
+		 * breaking the sched_group lists - i.e. a later get_group() pass
+		 * breaks the linking done for an earlier span.
 		 */
-		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
-		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
-			return false;
+		for_each_cpu(cpu, cpu_map) {
+			/* lowest bit set in this mask is used as a unique id */
+			id = cpumask_first(tl->mask(cpu));
+
+			/* zeroed masks cannot possibly collide */
+			if (id >= nr_cpu_ids)
+				continue;
+
+			/* if this mask doesn't collide with what we've already seen */
+			if (!cpumask_intersects(tl->mask(cpu), covered)) {
+				/* this failing would be an error in this algorithm */
+				if (WARN_ON(masks[id]))
+					goto notsane;
+
+				/* record the mask we saw for this id */
+				masks[id] = tl->mask(cpu);
+				cpumask_or(covered, tl->mask(cpu), covered);
+			} else if ((!masks[id]) || !cpumask_equal(masks[id], tl->mask(cpu))) {
+				/*
+				 * a collision with covered should have exactly matched
+				 * a previously seen mask with the same id
+				 */
+				goto notsane;
+			}
+		}
 	}
+	ret = true;
 
-	return true;
+ notsane:
+	kfree(masks);
+	return ret;
 }
 
 /*
@@ -2417,9 +2450,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		sd = NULL;
 		for_each_sd_topology(tl) {
 
-			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
-				goto error;
-
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
 			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
@@ -2433,6 +2463,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	if (WARN_ON(!topology_span_sane(cpu_map)))
+		goto error;
+
 	/* Build the groups for the domains */
 	for_each_cpu(i, cpu_map) {
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
-- 
2.26.2



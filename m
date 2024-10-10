Return-Path: <linux-kernel+bounces-359496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2D998D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B75B33BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5411C460E;
	Thu, 10 Oct 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="msjA1k/8"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21618FDAB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575557; cv=none; b=g2fs6pWOILpjSSL7nuqf9O2WwD87vEcGfViTCo6u4Bc86NLJj4Tg5FVLjgmI+R8X6i+BuhJyBpX+yrpcwktH21Z+7h76fS/7PAX7rZTusI8G0iM+xrHyBhoJW12LDkWJzD+TrRmcepkdMeOLnNKSxAxAWFTvKAP0w6n9c7hBkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575557; c=relaxed/simple;
	bh=eHfPfz1qT0ijced515uJZ28Rd2Tq2hEo1Dy0HJKjGwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uUxfTXvPlJAeEzcj2NcPNT4wiKkaGRbnP9vz3ABjbm0R8NAyIpgmi2L5dcJvmSRZVSE76qdgcEbasjl4ms6WNu25ZwnXiN0bUPiePLvbF8pxNcQ26vMY8y/ixremhwnxSxkW/Fbb3MttUkbclK+2yjtcY8g136zGka8GOoHLoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=msjA1k/8; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ADUFL1014480;
	Thu, 10 Oct 2024 15:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=TF+iorCoMobKG5Vn34ab63UDyf0a6S4CZvsrJ
	htjSWc=; b=msjA1k/8jrnE03NNemrvRzVS33WzbKODH5Nfu0EAIbxqW5H24EN/p
	/VwU2vK9HXn3BJZGS2t0c/JNqtGe+EayxcLoi7JUWiDxGQVBTe28Msrfg4snZl6F
	xaL+1iMQPTBpHKXguVOak9PbCMRhzKrCboSjCWMK3D2L4JFJGwC8EG196/3t9sGm
	lon2k1IU52KYSwCyU3jELj1Wk7uCo/SYNwsneQ1WMMC3CRTJ5vT5L0vbq2E/qYTA
	44ndO/XD1h7B0jlMkx++bwXQGREaim8yua8zIF2Z/xxCi3w8Ol4ZSqEX1GXBZK0F
	WyID65CHjVsQfHXffYiIDtoYBXxssRepA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 426bvxkeck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 15:51:16 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 7E4CC806B2B;
	Thu, 10 Oct 2024 15:51:13 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 80472809431;
	Thu, 10 Oct 2024 15:51:12 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id E236D302F4802; Thu, 10 Oct 2024 10:51:11 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH] sched/topology: improve topology_span_sane speed
Date: Thu, 10 Oct 2024 10:51:11 -0500
Message-Id: <20241010155111.230674-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9NRzbuLq5CQmY-0GsmePS1hn4GznItPR
X-Proofpoint-ORIG-GUID: 9NRzbuLq5CQmY-0GsmePS1hn4GznItPR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=821 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100105

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
 kernel/sched/topology.c | 79 ++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..c150074033d3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2356,36 +2356,65 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
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
+	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *), GFP_KERNEL);
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
+		memset(masks, 0, num_possible_cpus() * sizeof(struct cpumask *));
 
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
@@ -2417,9 +2446,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		sd = NULL;
 		for_each_sd_topology(tl) {
 
-			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
-				goto error;
-
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
 			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
@@ -2433,6 +2459,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
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



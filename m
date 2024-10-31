Return-Path: <linux-kernel+bounces-391257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB69B8480
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7222817D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179201CCEE8;
	Thu, 31 Oct 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nh5Fepyb"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E781AD3E0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407235; cv=none; b=VMgpiXZEopWV3aYCjlxy315amJ4i86sLEn4FU2xB3WTVKfo/kNGV0Np07hblLdf1rjA+4EBtq4IKRhGRiv3c0hypmD8fj7vn5rQw+VkH1zLYJTolvIhjhdvaOUdf8482zi/VaTS8N3OvMLCevrBInzd+1P7en8AxqqBQ0u5V09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407235; c=relaxed/simple;
	bh=Y/hHBCLf5eAa0ncB5X0FvLTDhS04elABzup+Lt7vO7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bH9mN2n6HodbynDbKZF+rbeCKY6uY1y+iiQVL68ZObDHD4r8alZEX1VD2NYZxUoVryYTExiUlquI+545H5YyuXjiiM7MKw1bPi82OAO9QXyezHyBqD3IQGgSBr7GXRMRBut38Gb4nLUEgNXWYznE4Xeev26fqtXb3S0LxcKIzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=nh5Fepyb; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VG2GjC018803;
	Thu, 31 Oct 2024 20:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=sNIBgrunP5oAigZyG5casGVmd2WvWu+sEA2ji
	soHWvU=; b=nh5FepybLZq/2sAOddl4ZxHtuW3I3/gCdVd91OofqMfhcOq3sV8v1
	ETIp/8H5A0eerO/1W5T0gx2DFCIDK2Ey4RZSI9ZyMTi4/7ZLUXuk9GUT5Rzkv4Dl
	f2hbCEqFO/CDe9oIU0a2XKX6RUvA78yTM1KUkE7xZZf88iubNavWkWZNEOsgKkU3
	5GV1hy4Zxiex4H4gLK2GBBcp3d+n8b14Eoezg4uauXYm1KC6j64vJ2MOIJpDMWMQ
	2pBwHRnsY04QFgEHkOOI+0UIkabsDasxo8pxskE5s0VyynA4uU88FTv2S2NAMdFt
	UyTSzuCSIqERGR6CjmKoOJ6APp5SSpYsQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42mc6yjecb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 20:04:35 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 26F0B806B3F;
	Thu, 31 Oct 2024 20:04:34 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 34055805769;
	Thu, 31 Oct 2024 20:04:32 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 9760B302F4802; Thu, 31 Oct 2024 15:04:31 -0500 (CDT)
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
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH v2] sched/topology: improve topology_span_sane speed
Date: Thu, 31 Oct 2024 15:04:31 -0500
Message-Id: <20241031200431.182443-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W5ZTZD-MGzjeRnwnhFWU9Yznb7F1RqXz
X-Proofpoint-GUID: W5ZTZD-MGzjeRnwnhFWU9Yznb7F1RqXz
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=775 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310151

Use a different approach to topology_span_sane(), that checks for the
same constraint of no partial overlaps for any two CPU sets for
non-NUMA topology levels, but does so in a way that is O(N) rather
than O(N^2).

Instead of comparing with all other masks to detect collisions, keep
one mask that includes all CPUs seen so far and detect collisions with
a single cpumask_intersects test.

If the current mask has no collisions with previously seen masks, it
should be a new mask, which can be uniquely identified ("id") by the
lowest bit set in this mask.  Mark that we've seen a mask with this
id, and add the CPUs in this mask to the list of those seen.

If the current mask does collide with previously seen masks, it should
be exactly equal to a mask seen before, identified once again by the
lowest bit the current mask has set.  It's an error if we haven't seen
a mask with that id, or if the current mask doesn't match the one we
get by looking up that id.

Move the topology_span_sane() check out of the existing topology level
loop, let it do its own looping to match the needs of this algorithm.

On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
the average time to take one processor offline is reduced from 2.18
seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
34m49.765s without this change, 16m10.038s with this change in place.)

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---

Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
simplifies the code, and eliminates the erroneous use of
num_possible_cpus() that Peter Zijlstra noted.

Version 1 discussion:
    https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/

 kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..6a2a3e91d59e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
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
+	struct cpumask *covered, *id_seen;
+	int cpu;
 
-	/* NUMA levels are allowed to overlap */
-	if (tl->flags & SDTL_OVERLAP)
-		return true;
+	lockdep_assert_held(&sched_domains_mutex);
+	covered = sched_domains_tmpmask;
+	id_seen = sched_domains_tmpmask2;
+
+	for_each_sd_topology(tl) {
+
+		/* NUMA levels are allowed to overlap */
+		if (tl->flags & SDTL_OVERLAP)
+			continue;
+
+		cpumask_clear(covered);
+		cpumask_clear(id_seen);
 
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
+			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
+			int id;
+
+			/* lowest bit set in this mask is used as a unique id */
+			id = cpumask_first(tl_cpu_mask);
+
+			/* if this mask doesn't collide with what we've already seen */
+			if (!cpumask_intersects(tl_cpu_mask, covered)) {
+				/* Really odd case when cpu != id, likely not sane */
+				if ((cpu != id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))
+					return false;
+				if (cpumask_test_and_set_cpu(id, id_seen))
+					return false;
+				cpumask_or(covered, tl_cpu_mask, covered);
+			} else if ((!cpumask_test_cpu(id, id_seen)) ||
+				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
+				/*
+				 * a collision with covered should have exactly matched
+				 * a previously seen mask with the same id
+				 */
+				return false;
+			}
+		}
 	}
-
 	return true;
 }
 
@@ -2417,9 +2440,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		sd = NULL;
 		for_each_sd_topology(tl) {
 
-			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
-				goto error;
-
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
 			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
@@ -2433,6 +2453,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
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



Return-Path: <linux-kernel+bounces-544886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC62A4E635
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA121B4033E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839FC27BF84;
	Tue,  4 Mar 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="O74lj08B"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970327BF75
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104560; cv=none; b=rk/YnelcCZ3GKkazW9pXf/S4mrLgRIixp7xTdPizydZZ6YsOegZnxD+SZViur/3cGs4kCRD7ck4fLluqucXS+3O0DRrbWoHEBqNVGd+S5RkjYsk/51d90XHBy4DhsY3GVFkuMPaxhoXYOezFo1e5zRVJhxyBNJLj//WrQEl9dgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104560; c=relaxed/simple;
	bh=mJTLK/7TnWwSHrZSt3aunpndt6+4loT/LhtIHq8hKVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3+XsdMGFfg603UopUGIcWSqTzwb+JKW+4MpvOJdwOiSRcdM2vpvuINaIf3zUXMF5SKb1F22nNITdhWZMid9rJgWj4UV5wRyOdh64v9SSUqsmTx8iYAZRyqxIM9PkpmM2gIU+iwQs806+5Bg2qtHjZhUylmrim3qaHAx/7qwkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=O74lj08B; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524FQdoR009012;
	Tue, 4 Mar 2025 16:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=8IO+qvE+qftdg
	RA4CkRXPZxyW8JXLIjvG84Ao/IZkUQ=; b=O74lj08BMfcdDc0jpQ9ywpRsMV8AB
	xt8fTRaOALm7slzGjj+B6siM73+j08W1WmMXAyZ5MRuTD60de00YOjrDsz8KWyDO
	V1YE/fgYJqIieWUXUarbn661sDckLN0izRYevCSy/cSeZJUeFGl2fIeWcxHcQXcb
	6bdAfhY2F2Z6lnOGs+I5zfwY067gtGfo51DP+j6qhqTsHz0s/tP5yQqqi0wlPmRA
	b/05Pf7XFlGSweQzWgV9jqfaDoFtvzeZNKUvKShl6Qlm5H/pWrRGKuy1PHKZy/nU
	BecurcZdUWpOIIsZug1oW2SOwLwwYpERs1GVIXZHGxS3UA8nUm2omRMBg==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 455yvr2uxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:08:47 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 08D9F2FCEB;
	Tue,  4 Mar 2025 16:08:46 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id C8F7D80CCE1;
	Tue,  4 Mar 2025 16:08:44 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 445F330006A04; Tue,  4 Mar 2025 10:08:44 -0600 (CST)
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
Subject: [PATCH v4 2/2] sched/topology: Refinement to topology_span_sane speedup
Date: Tue,  4 Mar 2025 10:08:44 -0600
Message-Id: <20250304160844.75373-3-steve.wahl@hpe.com>
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
X-Proofpoint-ORIG-GUID: HXv5A7qWG0ETYExWLsNNrL7g9W1TQhYc
X-Proofpoint-GUID: HXv5A7qWG0ETYExWLsNNrL7g9W1TQhYc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040129

Simplify the topology_span_sane code further, removing the need to
allocate an array and gotos used to make sure the array gets freed.

This version is in a separate commit because it could return a
different sanity result than the previous code, but only in odd
circumstances that are not expected to actually occur; for example,
when a CPU is not listed in its own mask.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---

Version 4: First appearance of this second patch.

 kernel/sched/topology.c | 48 ++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3fb834301315..23b2012ff2af 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2361,17 +2361,12 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(const struct cpumask *cpu_map)
 {
 	struct sched_domain_topology_level *tl;
-	const struct cpumask **masks;
-	struct cpumask *covered;
-	int cpu, id;
-	bool ret = false;
+	struct cpumask *covered, *id_seen;
+	int cpu;
 
 	lockdep_assert_held(&sched_domains_mutex);
 	covered = sched_domains_tmpmask;
-
-	masks = kmalloc_array(nr_cpu_ids, sizeof(struct cpumask *), GFP_KERNEL);
-	if (!masks)
-		return ret;
+	id_seen = sched_domains_tmpmask2;
 
 	for_each_sd_topology(tl) {
 
@@ -2380,7 +2375,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 			continue;
 
 		cpumask_clear(covered);
-		memset(masks, 0, nr_cpu_ids * sizeof(struct cpumask *));
+		cpumask_clear(id_seen);
 
 		/*
 		 * Non-NUMA levels cannot partially overlap - they must be either
@@ -2389,36 +2384,27 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 		 * breaks the linking done for an earlier span.
 		 */
 		for_each_cpu(cpu, cpu_map) {
-			/* lowest bit set in this mask is used as a unique id */
-			id = cpumask_first(tl->mask(cpu));
+			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
+			int id;
 
-			/* zeroed masks cannot possibly collide */
-			if (id >= nr_cpu_ids)
-				continue;
+			/* lowest bit set in this mask is used as a unique id */
+			id = cpumask_first(tl_cpu_mask);
 
-			/* if this mask doesn't collide with what we've already seen */
-			if (!cpumask_intersects(tl->mask(cpu), covered)) {
-				/* this failing would be an error in this algorithm */
-				if (WARN_ON(masks[id]))
-					goto notsane;
+			if (cpumask_test_cpu(id, id_seen)) {
+				/* First CPU has already been seen, ensure identical spans */
+				if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
+					return false;
+			} else {
+				/* First CPU hasn't been seen before, ensure it's a completely new span */
+				if (cpumask_intersects(tl_cpu_mask, covered))
+					return false;
 
-				/* record the mask we saw for this id */
-				masks[id] = tl->mask(cpu);
-				cpumask_or(covered, tl->mask(cpu), covered);
-			} else if ((!masks[id]) || !cpumask_equal(masks[id], tl->mask(cpu))) {
-				/*
-				 * a collision with covered should have exactly matched
-				 * a previously seen mask with the same id
-				 */
-				goto notsane;
+				cpumask_or(covered, covered, tl_cpu_mask);
+				cpumask_set_cpu(id, id_seen);
 			}
 		}
 	}
-	ret = true;
-
- notsane:
-	kfree(masks);
-	return ret;
+	return true;
 }
 
 /*
-- 
2.26.2



Return-Path: <linux-kernel+bounces-570381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99FA6AFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84223188BF93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D522A4EC;
	Thu, 20 Mar 2025 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Uf8sW8lv"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C2227E9F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504967; cv=none; b=RmxJBMa/mOwywZWZyY+fobcJIC4ql+DTiBgw2jcDVUYoeR9+vQdWbGiRz+p3HajkuDxp2tsTYfxpT+vOEyUKhtCaUIekZRdAHymEUh5bYoUeANaH9sjEXCkqwnzYmwYvTuO0G9RhSUCCWfkQzwg28YLzrrxCTbO1Ogd2bCNbBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504967; c=relaxed/simple;
	bh=memV5oylM8lSqed7Ts8zRJMhvg7Z2sJe8kjvfmyqhMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8c/oA2Di3RqmnlFbrd2dvg+jhSISprWcx3CEE9Xu6f3aLgV7o364PY4JULSESu4cPwMWNhA1tXcrpEZpDoe6O43+yZnSlNL9dFTR7bsFtwwADD6gn/r921UAwyizkY5ohl/dTEpYJOTeE2TZ/x5bDNgJmFBvEx4CEoMbnV7dPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Uf8sW8lv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd15d03eacso12596216d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742504964; x=1743109764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yrEskFz3SGebHv+YiQL9wB7TFOwxFXa/530qki8uYY=;
        b=Uf8sW8lv+YPKjOF8yNDmorMaTGo+wkG0Ji0JEfqL1S7YPSPKAYKJ9mKO+/QrJ5n07y
         SZu63MI6YVMUFNUuAd1PM7+tFGQAdSijfLx64KvJ7ObZ9Enc3HOVr8nyx31AwbGdz3Vn
         QJCqGbLfYZ/NfS+QS9vupGWuSN/s6RFVUZRv/99s/+Ev28ASgyzm7cEoPW6yISLvD8vm
         stngO2Cs0jWaMhXg5Zn4FyT90FlZ47mHqtRSgTdyh1IyfWyNnkF2y6mBfNBpWo9kQcJS
         kbm+q5FFkAx4HrNKY/snnMgDNMfb2BXgkziedDjY2slKvkmLOSrhfE/IobpnAcC1mKaW
         pXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504964; x=1743109764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yrEskFz3SGebHv+YiQL9wB7TFOwxFXa/530qki8uYY=;
        b=vSeK5R7xQj1Cp39zEJL4fYffgJBWaJ1nS2mE5HrF5AFbx4HvdEGBOApxbDIdjHj/kB
         ChndsDVgHw64zFSYtuzbHuUnyz7G7jtRosH+qlrWZMfxeZh2y9mCZFNWvoulJv2FJqXw
         mzFvT1FptCgvFno0qln2tq+sVnzrXB3eaO5coEWUc+wnovjhek6mjvo0GoBH1He7G7KW
         2xxO0I/bluHF3Zgyy1P0rkP+s21pjHVjlOtSiu+xexYevp5KCl0EqGm/mWOQklgCQEMD
         HE0OXajHuKAvrGDZAcp9/FBZstatrpK24vcqaovZrPfkv5OLvxqK1tRjj3l/YdaJ6QHp
         fgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfvdYCAR68XjB/tiJeZ2QytucweAWqVqmfjlTF5JtleKFaPsk0+hdulJHlZpZu7gD+VtCK+O4oiQvaiSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oDV8Jpj9IvbgXoyFWetrvrr5yQcvtzH35r7cD/I4o2OfC4kJ
	G0MwKSRxDzkXj661Jf2hefdZtcvNkApvkLY3twBS/wvmLpHm7PdYFEIMRigYK28=
X-Gm-Gg: ASbGncus54GslIYZN0nx+zV8mcjfp8ApgnyAJR2LwovQdYdxUxHo+ZjFAprh4ZwDYHU
	YNtAKQ/U1Dx11IiHnsMGU0tyEVnGLo0IuNDxLHwsr0Q25CSTY/gitoeiKhJ77WGlmZKYXrYCGUy
	rj0jhkh2kpg6ib1L+ueYj80kMFLC5J14i2F1Oa1aZkQii+DvaJR+bX+UGaBRjprlG4FvVZ8x64p
	yz5DNon3Cy4AqNt/HfqJHr3rhSN0ETD3a9Cc3CqnE2NpDxZxibcLsASpIMe6vNF5da91vuw0kbi
	vC2Za87FF8ZgZ0cTFY6WkdhfrgrKe6QMv3kl5iu8shjX8E5cZdEA9Y1UdTcfUbFnBBj9eG3IzME
	0m4s04251ALcrtJIWaSo7CXJ/miALUrlz
X-Google-Smtp-Source: AGHT+IEjJfoLWfjaQSMLv4pamkzSKWduPwtwMCPVDIeLP4SOBEfwmmhRDQOnEv81Tvlit0t1bVNB2w==
X-Received: by 2002:a05:6214:29e7:b0:6e8:ec18:a1be with SMTP id 6a1803df08f44-6eb349305d5mr64846176d6.7.1742504963955;
        Thu, 20 Mar 2025 14:09:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efdbe35sm2593626d6.105.2025.03.20.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:09:23 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Subject: [RFC PATCH] vmscan,cgroup: apply mems_effective to reclaim
Date: Thu, 20 Mar 2025 17:09:19 -0400
Message-ID: <20250320210919.439964-1-gourry@gourry.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for a reclaimer to cause demotions of an lruvec belonging
to a cgroup with cpuset.mems set to exclude some nodes. Attempt to apply
this limitation based on the lruvec's memcg and prevent demotion.

Notably, this may still allow demotion of shared libraries or any memory
first instantiated in another cgroup. This means cpusets still cannot
cannot guarantee complete isolation when demotion is enabled, and the
docs have been updated to reflect this.


Note: This is a fairly hacked up method that probably overlooks some
      cgroup/cpuset controls or designs. RFCing now for some discussion
      at LSFMM '25.


Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 14 +++++---
 include/linux/cpuset.h                        |  2 ++
 kernel/cgroup/cpuset.c                        | 10 ++++++
 mm/vmscan.c                                   | 32 ++++++++++++-------
 4 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
index 77e559d4ed80..27cdcab901f7 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
@@ -16,9 +16,13 @@ Description:	Enable/disable demoting pages during reclaim
 		Allowing page migration during reclaim enables these
 		systems to migrate pages from fast tiers to slow tiers
 		when the fast tier is under pressure.  This migration
-		is performed before swap.  It may move data to a NUMA
-		node that does not fall into the cpuset of the
-		allocating process which might be construed to violate
-		the guarantees of cpusets.  This should not be enabled
-		on systems which need strict cpuset location
+		is performed before swap if an eligible numa node is
+		present in cpuset.mems for the cgroup. If cpusets.mems
+		changes at runtime, it may move data to a NUMA node that
+		does not fall into the cpuset of the new cpusets.mems,
+		which might be construed to violate the guarantees of
+		cpusets.  Shared memory, such as libraries, owned by
+		another cgroup may still be demoted and result in memory
+		use on a node not present in cpusets.mem. This should not
+		be enabled on systems which need strict cpuset location
 		guarantees.
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 835e7b793f6a..d4169f1b1719 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
+bool memcg_mems_allowed(struct mem_cgroup *memcg, int nid);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973..bb9669cc105d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4296,3 +4296,13 @@ void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
 	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
 		   nodemask_pr_args(&task->mems_allowed));
 }
+
+bool memcg_mems_allowed(struct mem_cgroup *memcg, int nid)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *cs;
+
+	css = cgroup_get_e_css(memcg->css.cgroup, &cpuset_cgrp_subsys);
+	cs = css ? container_of(css, struct cpuset, css) : NULL;
+	return cs ? node_isset(nid, cs->effective_mems) : true;
+}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2b2ab386cab5..04152ea1c03d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -342,16 +342,22 @@ static void flush_reclaim_state(struct scan_control *sc)
 	}
 }
 
-static bool can_demote(int nid, struct scan_control *sc)
+static bool can_demote(int nid, struct scan_control *sc,
+		       struct mem_cgroup *memcg)
 {
+	int demotion_nid;
+
 	if (!numa_demotion_enabled)
 		return false;
 	if (sc && sc->no_demotion)
 		return false;
-	if (next_demotion_node(nid) == NUMA_NO_NODE)
+
+	demotion_nid = next_demotion_node(nid);
+	if (demotion_nid == NUMA_NO_NODE)
 		return false;
 
-	return true;
+	/* If demotion node isn't in mems_allowed, fall back */
+	return memcg ? memcg_mems_allowed(memcg, demotion_nid) : true;
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
@@ -376,7 +382,7 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 	 *
 	 * Can it be reclaimed from this node via demotion?
 	 */
-	return can_demote(nid, sc);
+	return can_demote(nid, sc, NULL);
 }
 
 /*
@@ -1096,7 +1102,8 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
  */
 static unsigned int shrink_folio_list(struct list_head *folio_list,
 		struct pglist_data *pgdat, struct scan_control *sc,
-		struct reclaim_stat *stat, bool ignore_references)
+		struct reclaim_stat *stat, bool ignore_references,
+		struct mem_cgroup *memcg)
 {
 	struct folio_batch free_folios;
 	LIST_HEAD(ret_folios);
@@ -1109,7 +1116,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	folio_batch_init(&free_folios);
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
-	do_demote_pass = can_demote(pgdat->node_id, sc);
+	do_demote_pass = can_demote(pgdat->node_id, sc, memcg);
 
 retry:
 	while (!list_empty(folio_list)) {
@@ -1658,7 +1665,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	 */
 	noreclaim_flag = memalloc_noreclaim_save();
 	nr_reclaimed = shrink_folio_list(&clean_folios, zone->zone_pgdat, &sc,
-					&stat, true);
+					&stat, true, NULL);
 	memalloc_noreclaim_restore(noreclaim_flag);
 
 	list_splice(&clean_folios, folio_list);
@@ -2031,7 +2038,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	if (nr_taken == 0)
 		return 0;
 
-	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false);
+	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false,
+					 lruvec_memcg(lruvec));
 
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
@@ -2214,7 +2222,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &stat, true);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &stat, true, NULL);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2654,7 +2662,7 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
 		return true;
 
 	/* Also valuable if anon pages can be demoted: */
-	return can_demote(pgdat->node_id, sc);
+	return can_demote(pgdat->node_id, sc, NULL);
 }
 
 #ifdef CONFIG_LRU_GEN
@@ -2732,7 +2740,7 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	if (!sc->may_swap)
 		return 0;
 
-	if (!can_demote(pgdat->node_id, sc) &&
+	if (!can_demote(pgdat->node_id, sc, NULL) &&
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
 
@@ -4695,7 +4703,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	if (list_empty(&list))
 		return scanned;
 retry:
-	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
+	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false, NULL);
 	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
-- 
2.48.1



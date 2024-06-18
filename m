Return-Path: <linux-kernel+bounces-220333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C114F90DFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDE5285AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F981891D4;
	Tue, 18 Jun 2024 23:27:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A11891A6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753227; cv=none; b=Wrpvlbs36nkGiMj8SRxYACd/y5tIV/Rx1w0Db6bMLCL/Q5PR0zFCH6whr0uR0Icsu5KQBlSHoQW+iGMqIAMvkI0S9CB8HMWn0bXo3CYTYOJddgo1XEoLAJOoGrTe7CNBYqT6FZ/kxNaPs2it+n2cbjFKlJcApmaZmBDCz/KetTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753227; c=relaxed/simple;
	bh=oW/XrdstAv09FNMedV19nsUUJDgFoszN7+cijJf697A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giLqEIz7E0iwj0BDN84HbQu6DM6iGPCTrgbkdNsYjyjWuL3NUYuBy0LaWFV12hBOYZhuBQNd4y9cvjDalyaXqUbPzhcgDvmG3+gzOy9rZqHTN7cJSAye7ibLb+I0mSzawHH8czkNkcUe9k0T5j71kJDCMTBG9aUP4hdkuyLAUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD4014BF;
	Tue, 18 Jun 2024 16:27:30 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDFD3F64C;
	Tue, 18 Jun 2024 16:27:03 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Barry Song <baohua@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 4/5] mm: swap: Scan for free swap entries in allocated clusters
Date: Wed, 19 Jun 2024 00:26:44 +0100
Message-ID: <20240618232648.4090299-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618232648.4090299-1-ryan.roberts@arm.com>
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously mTHP would only be swapped out if a CPU could allocate itself
a free cluster from which to allocate mTHP-sized contiguous swap entry
blocks. But for a system making heavy use of swap, after a while
fragmentation ensures there are no available free clusters and therefore
the swap entry allocation fails and forces the mTHP to be split to base
pages which then get swap entries allocated by scanning the swap file
for free individual pages.

But when swap entries are freed, this makes holes in the clusters, and
often it would be possible to allocate new mTHP swap entries in those
holes.

So if we fail to allocate a free cluster, scan through the clusters
until we find one that is in use and contains swap entries of the order
we require. Then scan it until we find a suitably sized and aligned
hole. We keep a per-order "next cluster to scan" pointer so that future
scanning can be picked up from where we last left off. And if we scan
through all clusters without finding a suitable hole, we give up to
prevent live lock.

Running the test case provided by Barry Song at the below link, I can
see swpout fallback rate, which was previously 100% after a few
iterations, falls to 0% and stays there for all 100 iterations. This is
also the case when sprinkling in some non-mTHP allocations ("-s") too.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmail.com/
---
 include/linux/swap.h |  2 +
 mm/swapfile.c        | 90 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2a40fe02d281..34ec4668a5c9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -310,6 +310,8 @@ struct swap_info_struct {
 	unsigned int cluster_nr;	/* countdown to next cluster search */
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
+	struct swap_cluster_info *next_order_scan[SWAP_NR_ORDERS];
+					/* Start cluster for next order-based scan */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7b13f02a7ac2..24db03db8830 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -644,6 +644,84 @@ static inline bool swap_range_empty(char *swap_map, unsigned int start,
 	return true;
 }

+static inline
+struct swap_cluster_info *offset_to_cluster(struct swap_info_struct *si,
+					    unsigned int offset)
+{
+	VM_WARN_ON(!si->cluster_info);
+	return si->cluster_info + (offset / SWAPFILE_CLUSTER);
+}
+
+static inline
+unsigned int cluster_to_offset(struct swap_info_struct *si,
+			       struct swap_cluster_info *ci)
+{
+	VM_WARN_ON(!si->cluster_info);
+	return (ci - si->cluster_info) * SWAPFILE_CLUSTER;
+}
+
+static inline
+struct swap_cluster_info *next_cluster_circular(struct swap_info_struct *si,
+						struct swap_cluster_info *ci)
+{
+	struct swap_cluster_info *last;
+
+	/*
+	 * Wrap after the last whole cluster; never return the final partial
+	 * cluster because users assume an entire cluster is accessible.
+	 */
+	last = offset_to_cluster(si, si->max) - 1;
+	return ci == last ? si->cluster_info : ++ci;
+}
+
+static inline
+struct swap_cluster_info *prev_cluster_circular(struct swap_info_struct *si,
+						struct swap_cluster_info *ci)
+{
+	struct swap_cluster_info *last;
+
+	/*
+	 * Wrap to the last whole cluster; never return the final partial
+	 * cluster because users assume an entire cluster is accessible.
+	 */
+	last = offset_to_cluster(si, si->max) - 1;
+	return ci == si->cluster_info ? last : --ci;
+}
+
+/*
+ * Returns the offset of the next cluster, allocated to contain swap entries of
+ * `order`, that is eligible to scan for free space. On first call, *stop should
+ * be set to SWAP_NEXT_INVALID to indicate the clusters should be scanned all
+ * the way back around to the returned cluster. The function updates *stop upon
+ * first call and consumes it in subsequent calls. Returns SWAP_NEXT_INVALID if
+ * no such clusters are available. Must be called with si lock held.
+ */
+static unsigned int next_cluster_for_scan(struct swap_info_struct *si,
+					  int order, unsigned int *stop)
+{
+	struct swap_cluster_info *ci;
+	struct swap_cluster_info *end;
+
+	ci = si->next_order_scan[order];
+	if (*stop == SWAP_NEXT_INVALID)
+		*stop = cluster_to_offset(si, prev_cluster_circular(si, ci));
+	end = offset_to_cluster(si, *stop);
+
+	while (ci != end) {
+		if ((ci->flags & CLUSTER_FLAG_FREE) == 0 && ci->order == order)
+			break;
+		ci = next_cluster_circular(si, ci);
+	}
+
+	if (ci == end) {
+		si->next_order_scan[order] = ci;
+		return SWAP_NEXT_INVALID;
+	}
+
+	si->next_order_scan[order] = next_cluster_circular(si, ci);
+	return cluster_to_offset(si, ci);
+}
+
 /*
  * Try to get swap entries with specified order from current cpu's swap entry
  * pool (a cluster). This might involve allocating a new cluster for current CPU
@@ -656,6 +734,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
 	unsigned int tmp, max;
+	unsigned int stop = SWAP_NEXT_INVALID;

 new_cluster:
 	cluster = this_cpu_ptr(si->percpu_cluster);
@@ -674,6 +753,15 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 			*scan_base = this_cpu_read(*si->cluster_next_cpu);
 			*offset = *scan_base;
 			goto new_cluster;
+		} else if (nr_pages < SWAPFILE_CLUSTER) {
+			/*
+			 * There is no point in scanning for free areas the same
+			 * size as the cluster, since the cluster would have
+			 * already been freed in that case.
+			 */
+			tmp = next_cluster_for_scan(si, order, &stop);
+			if (tmp == SWAP_NEXT_INVALID)
+				return false;
 		} else
 			return false;
 	}
@@ -2392,6 +2480,8 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
 	}
 	p->swap_map = swap_map;
 	p->cluster_info = cluster_info;
+	for (i = 0; i < SWAP_NR_ORDERS; i++)
+		p->next_order_scan[i] = cluster_info;
 }

 static void _enable_swap_info(struct swap_info_struct *p)
--
2.43.0



Return-Path: <linux-kernel+bounces-220334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B1090DFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD31F246D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031E1849E1;
	Tue, 18 Jun 2024 23:27:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D61891DF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753230; cv=none; b=FxOK4EcD2cAkJ9+1jYcHeHau/WL0759nMhNoYpcy7P10IZhYzru9eR+tvw4Ja4I6uSsHdKAAY+yD+OIpu1W7xGj1fY07PXyp2juequG/Yt0o+UooDbjuv4ExOjrYOZDFNhLZL5laJjMWBntYm/LKIkrh9e+khN1EXbDqyl1CmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753230; c=relaxed/simple;
	bh=Znl4Phg+yGQ/MP0Ne9Cpu0oIP0Wn8eDukS41b/ym+lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPc23c8YPA2u8sGMq6ugUKNaGuhX+/NfqjnKUXIrnXqA4t+rDKFmbppwYX/HDKD9VZbPT5EdyG2GSlqUi4CBtfZqToSXZnutYxdDU6eu8m5sEt7Mbw17rL4o892DylpnVfFE95mFHNwJV7jr7tNhBvfiSkgXq3xAoQ30eY15Wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A856150C;
	Tue, 18 Jun 2024 16:27:32 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8073F64C;
	Tue, 18 Jun 2024 16:27:05 -0700 (PDT)
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
Subject: [RFC PATCH v1 5/5] mm: swap: Optimize per-order cluster scanning
Date: Wed, 19 Jun 2024 00:26:45 +0100
Message-ID: <20240618232648.4090299-6-ryan.roberts@arm.com>
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

Add CLUSTER_FLAG_SKIP_SCAN cluster flag, which is applied to a cluster
under 1 of 2 conditions. When present, the cluster will be skipped
during a scan.

- When the number of free entries is less than the number of entries
  that would be required for a new allocation of the order that the
  cluster serves.

- When scanning completes for the cluster, and no further scanners are
  active for the cluster and no swap entries were freed for the cluster
  since the last scan began. In this case, it has been proven that there
  are no contiguous free entries of sufficient size to allcoate the
  order that the cluster serves. In this case the cluster is made
  eligible for scanning again when the next entry is freed.

The latter is implemented to permit multiple CPUs to scan the same
cluster, which in turn garrantees that if there is a free block
available in a cluster allocated for the desired order then it will be
allocated on a first come, first served basis.

As a result, the number of active scanners for a cluster must be
tracked, costing 4 bytes per cluster.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |  3 +++
 mm/swapfile.c        | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 34ec4668a5c9..40c308749e79 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -257,9 +257,12 @@ struct swap_cluster_info {
 	unsigned int data:24;
 	unsigned int flags:4;
 	unsigned int order:4;
+	unsigned int nr_scanners;
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
 #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
+#define CLUSTER_FLAG_SKIP_SCAN 4 /* Skip cluster for per-order scan */
+#define CLUSTER_FLAG_DECREMENT 8 /* A swap entry was freed from cluster */

 /*
  * swap_info_struct::max is an unsigned int, so the maximum number of pages in
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 24db03db8830..caf382b4ecd3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -574,6 +574,9 @@ static void add_cluster_info_page(struct swap_info_struct *p,
 	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
 	cluster_set_count(&cluster_info[idx],
 		cluster_count(&cluster_info[idx]) + count);
+
+	if (SWAPFILE_CLUSTER - cluster_count(&cluster_info[idx]) < count)
+		cluster_info[idx].flags |= CLUSTER_FLAG_SKIP_SCAN;
 }

 /*
@@ -595,6 +598,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
 	struct swap_cluster_info *cluster_info, unsigned long page_nr)
 {
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
+	unsigned long count = 1 << cluster_info[idx].order;

 	if (!cluster_info)
 		return;
@@ -603,6 +607,10 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
 	cluster_set_count(&cluster_info[idx],
 		cluster_count(&cluster_info[idx]) - 1);

+	cluster_info[idx].flags |= CLUSTER_FLAG_DECREMENT;
+	if (SWAPFILE_CLUSTER - cluster_count(&cluster_info[idx]) >= count)
+		cluster_info[idx].flags &= ~CLUSTER_FLAG_SKIP_SCAN;
+
 	if (cluster_count(&cluster_info[idx]) == 0)
 		free_cluster(p, idx);
 }
@@ -708,7 +716,8 @@ static unsigned int next_cluster_for_scan(struct swap_info_struct *si,
 	end = offset_to_cluster(si, *stop);

 	while (ci != end) {
-		if ((ci->flags & CLUSTER_FLAG_FREE) == 0 && ci->order == order)
+		if ((ci->flags & (CLUSTER_FLAG_SKIP_SCAN | CLUSTER_FLAG_FREE)) == 0
+		    && ci->order == order)
 			break;
 		ci = next_cluster_circular(si, ci);
 	}
@@ -722,6 +731,21 @@ static unsigned int next_cluster_for_scan(struct swap_info_struct *si,
 	return cluster_to_offset(si, ci);
 }

+static inline void cluster_inc_scanners(struct swap_cluster_info *ci)
+{
+	/* Protected by si lock. */
+	ci->nr_scanners++;
+	ci->flags &= ~CLUSTER_FLAG_DECREMENT;
+}
+
+static inline void cluster_dec_scanners(struct swap_cluster_info *ci)
+{
+	/* Protected by si lock. */
+	ci->nr_scanners--;
+	if (ci->nr_scanners == 0 && (ci->flags & CLUSTER_FLAG_DECREMENT) == 0)
+		ci->flags |= CLUSTER_FLAG_SKIP_SCAN;
+}
+
 /*
  * Try to get swap entries with specified order from current cpu's swap entry
  * pool (a cluster). This might involve allocating a new cluster for current CPU
@@ -764,6 +788,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 				return false;
 		} else
 			return false;
+
+		cluster_inc_scanners(offset_to_cluster(si, tmp));
 	}

 	/*
@@ -780,13 +806,19 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	}
 	unlock_cluster(ci);
 	if (tmp >= max) {
+		cluster_dec_scanners(ci);
 		cluster->next[order] = SWAP_NEXT_INVALID;
 		goto new_cluster;
 	}
 	*offset = tmp;
 	*scan_base = tmp;
 	tmp += nr_pages;
-	cluster->next[order] = tmp < max ? tmp : SWAP_NEXT_INVALID;
+	if (tmp >= max) {
+		cluster_dec_scanners(ci);
+		cluster->next[order] = SWAP_NEXT_INVALID;
+	} else {
+		cluster->next[order] = tmp;
+	}
 	return true;
 }

--
2.43.0



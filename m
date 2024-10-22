Return-Path: <linux-kernel+bounces-376859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C39AB6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554861C23272
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BB1CC889;
	Tue, 22 Oct 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV3GA1hq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC71CCB5B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625416; cv=none; b=uXyCQYdMmfR0zdkANYRO8bfhLGtpCD+jmh/TcjM4N+WFEg9WD2kOX7X4Q5yHjZ6AlI04o0642DWT4jMWqhmDs0TOY3Xzutcf5SdYYw0ruChwlDQ5+/FnGu1ZDe5+CIBAtRDwUmyy4dD3sfLre0v5rdinOI5VVY2T9Vcw4mAvpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625416; c=relaxed/simple;
	bh=aF9HuuUJqZ/FR4xwdwbEKu6qkcO16UmzN5/Fli3AOC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSinlmP4dKKmugerbnvRzlQKhW0NP9kwhfRQA1b4ba+ta8LGUajFhCd+Cicp+I5VD1758844+dpZuK7dWDAG1rSHmFJ+Qp4c3cPjsFrY/4cH3pD/b2rl1cpxugJmZQVS2OQDjHoMnpJcKOHR09AhGL3wOEwC/8xIGsmVGCWOIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV3GA1hq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca1b6a80aso57359765ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625413; x=1730230213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C0u3UHnFQamHvHumiMWfS42vAHn/bzcqM1FVrGPT7rA=;
        b=gV3GA1hqLsvzCc2+RUt0ucqgW5A1ehDgnNyb4c46ScUJFc5JX5L8ppEpAU/2HM1VEc
         43FwO2R53APXlypc9aZ/zwpMgK35QS1j726kSiICdTY95khTjU6XD6uNrcS7+bPu1/9b
         cZWT15etv3nQvzj61kPJ1WSOy3eo/6QSZR/P3EaauTZo4/tDYOWVzisi2VcvEwU4JwlO
         gHYBfZQEHa6iUAX2OCLf1HgdV1QhBKy5CMWaG0VZXjsUpHi7Zca3x4M34i6byO8dz7QA
         nATfYJkErVQiKXiNIcVb3Aalwd7XwUIu1+M4l4BXVSc2krinp78iyBbQkzMvY7oay9z3
         eg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625413; x=1730230213;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0u3UHnFQamHvHumiMWfS42vAHn/bzcqM1FVrGPT7rA=;
        b=uhq45i+edk0wiDWpPv6V0jCSQkqgflVLRyJGWnnxbXkZah6RW/a1Ev8kOEaSFLBcRO
         qoRjnfyQQOEZH9b3q++VEPmbhsnryXpNmjzrdUmcR0W/yNgVn5ankodQm7yNTdx9OUFc
         zTaYlUi8hlpuQl/5cjquhp9e+U4fjkRgj3EhAPMeMZ0ZldV8eC37hHCRgHPDYRyZBvq/
         7YfWrAty7t36yLpUVydSJ/lSrlJ9p1nW3mCh4S1zNr96Sy8GejdgPyipQ8fdc9hzMaEa
         yxl/UpwEFRkY+djvoTWpiHaGDiICfVYoCPSgGx5r2RZf6HeN0UTgDc1N4XgzCSj6LQdo
         FOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjUOZXg/w+mThUa0Om0SR8ZfC0z4hvQyJyztyK+b1EEiVMBBLZvhaPNIhG+w5mHaE6QcXryvJtGtmBTrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaHbcxkfpNXzEWqd/0dUxi2c/udTO1ZU87VVJg9QcmHGrzGzr
	/9h8koa8tMuEl64c7sOC6Vs2B0bszhNE7205sAnhNov811/mUeQ1
X-Google-Smtp-Source: AGHT+IGcRlQHedKQaqyDIKAfCIehFDARjRb4U2itQQ2f0zTHaoGQCyPSUA4jWG4iyNeB5YMGTc2MgA==
X-Received: by 2002:a17:902:db12:b0:20c:e875:12b5 with SMTP id d9443c01a7336-20fab3276b7mr2519545ad.59.1729625413398;
        Tue, 22 Oct 2024 12:30:13 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:12 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 08/13] mm, swap: use an enum to define all cluster flags and wrap flags changes
Date: Wed, 23 Oct 2024 03:24:46 +0800
Message-ID: <20241022192451.38138-9-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
References: <20241022192451.38138-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently we are only using flags to indicate which list the cluster is
on, using one bit for each list type might be a waste as the list type
grows we will consume too much bits. And current the mixed usage of "&"
and "==" is a bit confusing.

Make it clean by using an enum to define all possible cluster status,
only an off-list cluster will have the NONE (0) flag. And use
a wrapper to annotate and sanitize all flag setting and list movement.

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h | 17 +++++++---
 mm/swapfile.c        | 76 +++++++++++++++++++++++---------------------
 2 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1651174959c8..75fc2da1767d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -256,10 +256,19 @@ struct swap_cluster_info {
 	u8 order;
 	struct list_head list;
 };
-#define CLUSTER_FLAG_FREE 1 /* This cluster is free */
-#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
-#define CLUSTER_FLAG_FRAG 4 /* This cluster is on nonfull list */
-#define CLUSTER_FLAG_FULL 8 /* This cluster is on full list */
+
+/*
+ * All on-list cluster must have a non-zero flag.
+ */
+enum swap_cluster_flags {
+	CLUSTER_FLAG_NONE = 0, /* For temporary off-list cluster */
+	CLUSTER_FLAG_FREE,
+	CLUSTER_FLAG_NONFULL,
+	CLUSTER_FLAG_FRAG,
+	CLUSTER_FLAG_FULL,
+	CLUSTER_FLAG_DISCARD,
+	CLUSTER_FLAG_MAX,
+};
 
 /*
  * The first page in the swap file is the swap header, which is always marked
diff --git a/mm/swapfile.c b/mm/swapfile.c
index d6b6e71ccc19..96d8012b003c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -402,7 +402,7 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 
 static inline bool cluster_is_free(struct swap_cluster_info *info)
 {
-	return info->flags & CLUSTER_FLAG_FREE;
+	return info->flags == CLUSTER_FLAG_FREE;
 }
 
 static inline unsigned int cluster_index(struct swap_info_struct *si,
@@ -433,6 +433,27 @@ static inline void unlock_cluster(struct swap_cluster_info *ci)
 	spin_unlock(&ci->lock);
 }
 
+static void cluster_move(struct swap_info_struct *si,
+			 struct swap_cluster_info *ci, struct list_head *list,
+			 enum swap_cluster_flags new_flags)
+{
+	VM_WARN_ON(ci->flags == new_flags);
+	BUILD_BUG_ON(1 << sizeof(ci->flags) * BITS_PER_BYTE < CLUSTER_FLAG_MAX);
+
+	if (ci->flags == CLUSTER_FLAG_NONE) {
+		list_add_tail(&ci->list, list);
+	} else {
+		if (ci->flags == CLUSTER_FLAG_FRAG) {
+			VM_WARN_ON(!si->frag_cluster_nr[ci->order]);
+			si->frag_cluster_nr[ci->order]--;
+		}
+		list_move_tail(&ci->list, list);
+	}
+	ci->flags = new_flags;
+	if (new_flags == CLUSTER_FLAG_FRAG)
+		si->frag_cluster_nr[ci->order]++;
+}
+
 /* Add a cluster to discard list and schedule it to do discard */
 static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 		struct swap_cluster_info *ci)
@@ -446,10 +467,8 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 	 */
 	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
-
-	VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
-	list_move_tail(&ci->list, &si->discard_clusters);
-	ci->flags = 0;
+	VM_BUG_ON(ci->flags == CLUSTER_FLAG_FREE);
+	cluster_move(si, ci, &si->discard_clusters, CLUSTER_FLAG_DISCARD);
 	schedule_work(&si->discard_work);
 }
 
@@ -457,12 +476,7 @@ static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info
 {
 	lockdep_assert_held(&si->lock);
 	lockdep_assert_held(&ci->lock);
-
-	if (ci->flags)
-		list_move_tail(&ci->list, &si->free_clusters);
-	else
-		list_add_tail(&ci->list, &si->free_clusters);
-	ci->flags = CLUSTER_FLAG_FREE;
+	cluster_move(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 	ci->order = 0;
 }
 
@@ -478,6 +492,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
 	while (!list_empty(&si->discard_clusters)) {
 		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
 		list_del(&ci->list);
+		/* Must clear flag when taking a cluster off-list */
+		ci->flags = CLUSTER_FLAG_NONE;
 		idx = cluster_index(si, ci);
 		spin_unlock(&si->lock);
 
@@ -518,9 +534,6 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 	lockdep_assert_held(&si->lock);
 	lockdep_assert_held(&ci->lock);
 
-	if (ci->flags & CLUSTER_FLAG_FRAG)
-		si->frag_cluster_nr[ci->order]--;
-
 	/*
 	 * If the swap is discardable, prepare discard the cluster
 	 * instead of free it immediately. The cluster will be freed
@@ -572,13 +585,9 @@ static void dec_cluster_info_page(struct swap_info_struct *si,
 		return;
 	}
 
-	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
-		VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
-		if (ci->flags & CLUSTER_FLAG_FRAG)
-			si->frag_cluster_nr[ci->order]--;
-		list_move_tail(&ci->list, &si->nonfull_clusters[ci->order]);
-		ci->flags = CLUSTER_FLAG_NONFULL;
-	}
+	if (ci->flags != CLUSTER_FLAG_NONFULL)
+		cluster_move(si, ci, &si->nonfull_clusters[ci->order],
+			     CLUSTER_FLAG_NONFULL);
 }
 
 static bool cluster_reclaim_range(struct swap_info_struct *si,
@@ -657,11 +666,14 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 {
 	unsigned int nr_pages = 1 << order;
 
+	VM_BUG_ON(ci->flags != CLUSTER_FLAG_FREE &&
+		  ci->flags != CLUSTER_FLAG_NONFULL &&
+		  ci->flags != CLUSTER_FLAG_FRAG);
+
 	if (cluster_is_free(ci)) {
-		if (nr_pages < SWAPFILE_CLUSTER) {
-			list_move_tail(&ci->list, &si->nonfull_clusters[order]);
-			ci->flags = CLUSTER_FLAG_NONFULL;
-		}
+		if (nr_pages < SWAPFILE_CLUSTER)
+			cluster_move(si, ci, &si->nonfull_clusters[order],
+				     CLUSTER_FLAG_NONFULL);
 		ci->order = order;
 	}
 
@@ -669,14 +681,8 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 	swap_range_alloc(si, nr_pages);
 	ci->count += nr_pages;
 
-	if (ci->count == SWAPFILE_CLUSTER) {
-		VM_BUG_ON(!(ci->flags &
-			  (CLUSTER_FLAG_FREE | CLUSTER_FLAG_NONFULL | CLUSTER_FLAG_FRAG)));
-		if (ci->flags & CLUSTER_FLAG_FRAG)
-			si->frag_cluster_nr[ci->order]--;
-		list_move_tail(&ci->list, &si->full_clusters);
-		ci->flags = CLUSTER_FLAG_FULL;
-	}
+	if (ci->count == SWAPFILE_CLUSTER)
+		cluster_move(si, ci, &si->full_clusters, CLUSTER_FLAG_FULL);
 }
 
 static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigned long offset,
@@ -806,9 +812,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		while (!list_empty(&si->nonfull_clusters[order])) {
 			ci = list_first_entry(&si->nonfull_clusters[order],
 					      struct swap_cluster_info, list);
-			list_move_tail(&ci->list, &si->frag_clusters[order]);
-			ci->flags = CLUSTER_FLAG_FRAG;
-			si->frag_cluster_nr[order]++;
+			cluster_move(si, ci, &si->frag_clusters[order], CLUSTER_FLAG_FRAG);
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
 							 &found, order, usage);
 			frags++;
-- 
2.47.0



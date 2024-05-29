Return-Path: <linux-kernel+bounces-193745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB58D320D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05365B2E049
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0DE169396;
	Wed, 29 May 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnikDJFI"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2E44C7B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971341; cv=none; b=VZ4UVkiDsmMyRPe65VXYBOgSO9OwpqIvN0QwEVDp/etrNHm3PtGkynoot8H7+6uB4km9omXTsrTLJxca66xnOKtB5nfzW2si4IX+7VIvBnIyRm9zsUU5lToxxXNZX88zsvCImXReZUZjgMK136/sbQltnoGlL7Z5Q0AMluQZE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971341; c=relaxed/simple;
	bh=u6KL2RcBFKVFA2AMXZl6KLq4qv71vIG0xV+kBBsY/EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFmF7PYSPly/YUUEVzsmReszqI9g9OQ5ZXDPhiiSV4Nh9leuu7hFoWHuX0wVc7xyFDNlBIK6MjcrmEeTLCxZfDx5inBaY9pmwX3WDk36IrxJEyjrG+P7K8UYSyIszQoxa8uIRp3kg4FSw3EwAzeIHo86R/kk+HDEr77gIbhAvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnikDJFI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f8e9555eabso1451119b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971339; x=1717576139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8PkNiQW/mkvjIvpLEp+EBywhuNk7TaiPl+XTuB214I=;
        b=UnikDJFIAHtdFNbDczbB3ft3RhmfXYiHIGP5d3q7NNUV7aibEb7VF+p11b6uo1gt29
         c6rGSSJfm5Dl56mdtgVccGV1Ksi+03oimjWCWFElNgADGi+Bg8Z1rmADi1dmgq7nHd/D
         8h/PxBEMeCZWRVY/QKHEGx2fgmK6y/A6jFPr4gX6XFn4E7fVE0bM+e5S2l+B8r+if54a
         7fYCHyUWQFHWKQkI3q2R7qbRBxBdJDdCh6lFl5Ota+CS2HYu2VioFjrk6QSXYlxjmZTB
         dg4F6cnxX65DyM19BVJ+g2/JalHbGE7QtPJToVZLcppL/NLwGGax0fHfgkJoPcHABVX1
         vEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971339; x=1717576139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8PkNiQW/mkvjIvpLEp+EBywhuNk7TaiPl+XTuB214I=;
        b=OLjs6iWdb8bd0GP8RaBMD+8skNKK7m4eHsZTUVykelWlFOKSHruqjJwARDq74B6QSr
         b0J1RQ2DOnZuNhNNFc2qsAig8EB2ivSQqntFHV8xPZFQCNX1k2wG6kJfdgVdLzslVERp
         pw/ycUsC4iOez5peDpmHrsEdmi4Qdkpse0eBwWOeYaKYVUdmODAdU7AUlipsnu5XAGWE
         0UOX8CaaaZsLzwygSbOO6z5HLVyX+fZ2V8Htu0+ivv+Y++4+RgTxx+s8nZyBSDYoPhaR
         q6ZplfcppHeekJ6lJQ4FPPPyVyzuWJuI1zMqkpX/jP94ncaNr+6F2gFvUTqt2kZ3Lnkh
         iCJg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Nk7Ezoq2Z+uQSmhXWu+6EhZZOJKuBWW3+SkcKPUu7OaTLddXoFxTVVdu3/qOhdNH2u1gpGW/RwOt4uVWDJWGD0DjXuNBxHYJ5owz
X-Gm-Message-State: AOJu0YzTIY6KGmn0o+3Xfra75CfqXgLesxHu9iPJxsqCG4RRiHTKWLEW
	bnslKzgk2IQWiR4k2LQ4J87Z7HnMVeJEq7cvOE83xN/asKjOOThF
X-Google-Smtp-Source: AGHT+IFIIMwl+a1BFU1LURBAWUDnpnOzYB+DE372n3RJK0yLX+C7PJpG+VjhO1aGqsG0jKGc/xlpAg==
X-Received: by 2002:a05:6a00:4405:b0:6f8:caf2:8f4f with SMTP id d2e1a72fcca58-6f8f45d2624mr16218543b3a.33.1716971338932;
        Wed, 29 May 2024 01:28:58 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702220d948bsm174916b3a.131.2024.05.29.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:28:58 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v5 2/6] mm: remove the implementation of swap_free() and always use swap_free_nr()
Date: Wed, 29 May 2024 20:28:20 +1200
Message-Id: <20240529082824.150954-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082824.150954-1-21cnbao@gmail.com>
References: <20240529082824.150954-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

To streamline maintenance efforts, we propose removing the implementation
of swap_free(). Instead, we can simply invoke swap_free_nr() with nr
set to 1. swap_free_nr() is designed with a bitmap consisting of only
one long, resulting in overhead that can be ignored for cases where nr
equals 1.

A prime candidate for leveraging swap_free_nr() lies within
kernel/power/swap.c. Implementing this change facilitates the adoption
of batch processing for hibernation.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/swap.h | 10 +++++-----
 kernel/power/swap.c  |  5 ++---
 mm/swapfile.c        | 17 ++++-------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 45f76dfe29b1..3df75d62a835 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -480,7 +480,6 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
-extern void swap_free(swp_entry_t);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
@@ -559,10 +558,6 @@ static inline int swapcache_prepare(swp_entry_t swp)
 	return 0;
 }
 
-static inline void swap_free(swp_entry_t swp)
-{
-}
-
 static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }
@@ -611,6 +606,11 @@ static inline void free_swap_and_cache(swp_entry_t entry)
 	free_swap_and_cache_nr(entry, 1);
 }
 
+static inline void swap_free(swp_entry_t entry)
+{
+	swap_free_nr(entry, 1);
+}
+
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 {
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index d9abb7ab031d..85a8b5f4a081 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
 
 	while ((node = swsusp_extents.rb_node)) {
 		struct swsusp_extent *ext;
-		unsigned long offset;
 
 		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
-		for (offset = ext->start; offset <= ext->end; offset++)
-			swap_free(swp_entry(swap, offset));
+		swap_free_nr(swp_entry(swap, ext->start),
+			     ext->end - ext->start + 1);
 
 		kfree(ext);
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 92a045d34a97..9c6d8e557c0f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 	swap_range_free(p, offset, 1);
 }
 
-/*
- * Caller has made sure that the swap device corresponding to entry
- * is still around or has not been recycled.
- */
-void swap_free(swp_entry_t entry)
-{
-	struct swap_info_struct *p;
-
-	p = _swap_info_get(entry);
-	if (p)
-		__swap_entry_free(p, entry);
-}
-
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
 		unsigned long offset, int nr_pages)
 {
@@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 	unlock_cluster_or_swap_info(sis, ci);
 }
 
+/*
+ * Caller has made sure that the swap device corresponding to entry
+ * is still around or has not been recycled.
+ */
 void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 	int nr;
-- 
2.34.1



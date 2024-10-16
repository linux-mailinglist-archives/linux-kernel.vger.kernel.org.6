Return-Path: <linux-kernel+bounces-367179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F999FF86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523E01C24651
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09418158A2E;
	Wed, 16 Oct 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGc69wH1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BE17CA1D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049446; cv=none; b=KeBb2zc/MGVk2gMKjn7vcPjAqxxLoX/awd1fQ+5zzru6R8iiAUSZV/rrAN8vCpymSsXcOh+6QJPF+qxNG6i6hpHqS3hRECxiN8dJuEvo0ZSd2AhPDz8Gb2o4tq3VgjyQRhZxMW/sc8uwEmWpFsV+GzPxw3ZdsEaLKJjVvEW/qLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049446; c=relaxed/simple;
	bh=N10cKXLfo1cce58z7d8u0/EH2jJL3q0RbRB7OALJ0CM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S+QfVNv/+DAB4qTakoDOquEfaoGMYtRZBAhFdP2boQlam27g9yy+UK/nVtI7cSnCG3KM5J8O50e5RAUUX96e8kSyKxamdIyN8DGSlUpuwxD64H+Rk+ZbxrAOeKHkDYvl4RDW16st67iiZLrpShpI/+DxDxO/x2+n/PkgCotynVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGc69wH1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb7139d9dso33802435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729049444; x=1729654244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ36mmbSu0pf/cAbG7e4iK4xKL9jwKjnD5CjIn/Qois=;
        b=FGc69wH1nhnUDp1tdBSciKPiuBurTgsoBRkj8OTQLTyt4KOWKH0THtG4u7aDgj6xvs
         yGStK+PiR38Aoe4L2pP3VTFp2GGpr+l7/lv8bGHwJRxBLCuq42kxOvDXB7G8ATGXyG3d
         cV+uaeYNBo4FG8nDR8puE4Iul9v5lZFJ2H6ydfgDQKA42uKujime0wPtm7ve67yOxvbS
         aLuLfHIZwOrx/09maV1/+ZUUY7Bnt81vR5Y9hE9Kmxv5qh/xWjLzdCt/denfNvC8osHU
         z4I5f3piRZV5t0wiUiFROdGiQbY7qZcAOAUzQRJMGqIXPprzM4/V4qiiV/L6fB7xNy1L
         gRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729049444; x=1729654244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ36mmbSu0pf/cAbG7e4iK4xKL9jwKjnD5CjIn/Qois=;
        b=bMm+osh7sIC9bvYld2ew5U0o3DFiDXqMlvSOBSs3IR19JiyM8SlUxgQsq6RAw/z8M+
         BhteHNcQGC9eYtm75RkKnynbRIvYSF5jTyPcBFSK3ByVOJrDTnDPSm5JgJQiaIRs4EUV
         dxM9V/JGHXmOpU3yHNQFcooUAOimLdKT5weR+cakGoLtGeZ9E9pbRTT3roknSjnqD7sh
         W/DgOXL/WdbHOUbAgG8yVq/98EN6YhpSdgrg+ETlbhWzG/uLBKEr1XV44wVo3U10GzLU
         wsSHIZnU9gjfvpeHASEXDFPF0QaVzCUp1utCxP4GwU44I2AnMQGE3R0WSKTU4al3d3WG
         QZWg==
X-Forwarded-Encrypted: i=1; AJvYcCWM5sQsa3U9wAYMs5Ntc+lzK6BY8H4LYjQ36akyKZ6TWVTJOUN6MF8p587IIdLsrJlFRNq3EC1GtZi0Qqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrkQQGFdtc06JgnGECV+xDSMDdsJXoJ6L64rEDvbhuJXiVS3M
	NBQot+XjgTlrAvc3MovHN/jkIEs8YGZikB+6d9WxJUTfF3rfIgxr
X-Google-Smtp-Source: AGHT+IG5j8BN+C4OIH3m7G6bs8K3FsD2Iw/4x2nxnpvQ1c/F7F9oLeUB3otrh4oYnCo6/hjow8Sh/Q==
X-Received: by 2002:a17:902:e80c:b0:20b:7e0d:8f with SMTP id d9443c01a7336-20d27e46a2fmr34283895ad.3.1729049443517;
        Tue, 15 Oct 2024 20:30:43 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:e037:6314:f5c6:369b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805da3fsm19603485ad.243.2024.10.15.20.30.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Oct 2024 20:30:43 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: david@redhat.com,
	fengbaopeng@honor.com,
	gaoxu2@honor.com,
	hailong.liu@oppo.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	lokeshgidra@google.com,
	mhocko@suse.com,
	minchan@kernel.org,
	ngeoffray@google.com,
	shli@fb.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	yipengxiang@honor.com,
	yuzhao@google.com,
	Gao Xu <gaoxu2@hihonor.com>
Subject: [PATCH v2] mm: mglru: provide a separate list for lazyfree anon folios
Date: Wed, 16 Oct 2024 16:30:30 +1300
Message-Id: <20241016033030.36990-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This builds on the discussion about Gaoxu's work[1]. Significant
file refaults may occur when userspace makes extensive use of
MADV_FREE on anonymous folios, as these folios are not
positioned in an easily reclaimable area within the LRU.

According to Lokesh, MADV_FREE'd anon folios are expected to be
released earlier than file folios. One option, as implemented
by Gao Xu, is to place lazyfree anon folios at the tail of the
file's `min_seq` generation[1]. However, this approach results in
lazyfree folios being released in a LIFO manner, which conflicts
with LRU behavior, as noted by Michal.

To address this, this patch proposes maintaining a separate list
for lazyfree anon folios while keeping them classified under the
"file" LRU type to minimize code changes. These lazyfree anon
folios will still be counted as file folios and share the same
generation with regular files. In the eviction path, the lazyfree
list will be prioritized for scanning before the actual file
LRU list.

Thanks to Gao Xu for the test results, which look quite promising:

Base version：android V (enable Android ART use MADV_FREE)
Test cases: 60 apps repeatedly restarted, tested for 8 hours;
The test results are as follows:
        workingset_refault_anon   workingset_refault_file
base        42016805                92010542
patch       19834873                49383572
% diff       -52.79%                  -46.33%

A comparative test was also performed on approach [1], with the
following results:
               workingset_refault_anon   workingset_refault_file
lazyfree-tail     20313395                 52203061
patch             19834873                 49383572
% diff              -2.36%                  -5.40%

[1] https://lore.kernel.org/linux-mm/f29f64e29c08427b95e3df30a5770056@honor.com/

Tested-by: Gao Xu <gaoxu2@hihonor.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
 collect Gao Xu's test results and tested-by tag, thanks!

 include/linux/mm_inline.h |  5 +-
 include/linux/mmzone.h    |  2 +-
 mm/vmscan.c               | 97 +++++++++++++++++++++++----------------
 3 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 87580e8363ef..615fe80d73d0 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -226,6 +226,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
+	int lazyfree = type ? folio_test_anon(folio) : 0;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen != -1, folio);
@@ -265,9 +266,9 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	lru_gen_update_size(lruvec, folio, -1, gen);
 	/* for folio_rotate_reclaimable() */
 	if (reclaiming)
-		list_add_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_add_tail(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 	else
-		list_add(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_add(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 
 	return true;
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 96dea31fb211..5cb86ea324be 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -436,7 +436,7 @@ struct lru_gen_folio {
 	/* the birth time of each generation in jiffies */
 	unsigned long timestamps[MAX_NR_GENS];
 	/* the multi-gen LRU lists, lazily sorted on eviction */
-	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE + 1][MAX_NR_ZONES];
 	/* the multi-gen LRU sizes, eventually consistent */
 	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the exponential moving average of refaulted */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fd3908d43b07..e2f13a9b50da 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3736,21 +3736,25 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 
 	/* prevent cold/hot inversion if force_scan is true */
 	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
-		struct list_head *head = &lrugen->folios[old_gen][type][zone];
+		int list_num = type ? 2 : 1;
+		struct list_head *head;
 
-		while (!list_empty(head)) {
-			struct folio *folio = lru_to_folio(head);
+		for (int i = list_num - 1; i >= 0; i--) {
+			head = &lrugen->folios[old_gen][type + i][zone];
+			while (!list_empty(head)) {
+				struct folio *folio = lru_to_folio(head);
 
-			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
+				VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
+				VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
+				VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
+				VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
-			new_gen = folio_inc_gen(lruvec, folio, false);
-			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
+				new_gen = folio_inc_gen(lruvec, folio, false);
+				list_move_tail(&folio->lru, &lrugen->folios[new_gen][type + i][zone]);
 
-			if (!--remaining)
-				return false;
+				if (!--remaining)
+					return false;
+			}
 		}
 	}
 done:
@@ -4302,6 +4306,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	int refs = folio_lru_refs(folio);
 	int tier = lru_tier_from_refs(refs);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	int lazyfree = type ? folio_test_anon(folio) : 0;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
 
@@ -4317,7 +4322,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 
 	/* promoted */
 	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
-		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 		return true;
 	}
 
@@ -4326,7 +4331,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4336,7 +4341,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* ineligible */
 	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 		return true;
 	}
 
@@ -4344,7 +4349,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
 		gen = folio_inc_gen(lruvec, folio, true);
-		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 		return true;
 	}
 
@@ -4388,7 +4393,7 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		       int type, int tier, struct list_head *list)
 {
-	int i;
+	int i, j;
 	int gen;
 	enum vm_event_item item;
 	int sorted = 0;
@@ -4410,33 +4415,38 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		LIST_HEAD(moved);
 		int skipped_zone = 0;
 		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
-		struct list_head *head = &lrugen->folios[gen][type][zone];
-
-		while (!list_empty(head)) {
-			struct folio *folio = lru_to_folio(head);
-			int delta = folio_nr_pages(folio);
-
-			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
-
-			scanned += delta;
+		int list_num = type ? 2 : 1;
+		struct list_head *head;
+
+		for (j = list_num - 1; j >= 0; j--) {
+			head = &lrugen->folios[gen][type + j][zone];
+			while (!list_empty(head)) {
+				struct folio *folio = lru_to_folio(head);
+				int delta = folio_nr_pages(folio);
+
+				VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
+				VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
+				VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
+				VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
+
+				scanned += delta;
+
+				if (sort_folio(lruvec, folio, sc, tier))
+					sorted += delta;
+				else if (isolate_folio(lruvec, folio, sc)) {
+					list_add(&folio->lru, list);
+					isolated += delta;
+				} else {
+					list_move(&folio->lru, &moved);
+					skipped_zone += delta;
+				}
 
-			if (sort_folio(lruvec, folio, sc, tier))
-				sorted += delta;
-			else if (isolate_folio(lruvec, folio, sc)) {
-				list_add(&folio->lru, list);
-				isolated += delta;
-			} else {
-				list_move(&folio->lru, &moved);
-				skipped_zone += delta;
+				if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
+					goto isolate_done;
 			}
-
-			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
-				break;
 		}
 
+isolate_done:
 		if (skipped_zone) {
 			list_splice(&moved, head);
 			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
@@ -5588,8 +5598,15 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 	for (i = 0; i <= MIN_NR_GENS + 1; i++)
 		lrugen->timestamps[i] = jiffies;
 
-	for_each_gen_type_zone(gen, type, zone)
+	for_each_gen_type_zone(gen, type, zone) {
 		INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
+		/*
+		 * lazyfree anon folios have a separate list while using
+		 * file as type
+		 */
+		if (type)
+			INIT_LIST_HEAD(&lrugen->folios[gen][type + 1][zone]);
+	}
 
 	if (mm_state)
 		mm_state->seq = MIN_NR_GENS;
-- 
2.39.3 (Apple Git-146)



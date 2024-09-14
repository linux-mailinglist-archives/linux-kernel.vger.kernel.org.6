Return-Path: <linux-kernel+bounces-329184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284D978E73
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAD22871CE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5514EC71;
	Sat, 14 Sep 2024 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjmQlOfR"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8C748D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726295880; cv=none; b=eu4LTRNzqYczwFUGYeX2lCbEtsoDjOdRNTQrdq6h2bZVrHKltPLl1mzQjw81aL91mbPXPf8Y+45wMncfgo9qockm/Xh47LdzyQqi1IG3Aa2sQgVAsYLLcGlFPZjFhfL4ZpygZ3+bqbNPECLW0UYQz7jNCWXz1to32a/tlYXdbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726295880; c=relaxed/simple;
	bh=oz7QanlSOfMZ25ytwP5sFLfaEV2c2Lqp5/4E+nUWy6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXaiEVVfolavsjG5W6D1Y+j4dvh703KWSBZBHBf/L9BRrQhiNSLTd3N0CRbylKiikk0M3bWI88dUwOkoS7q24m7e2bQEUVaqItYC7jM3DirbxP1WS7fBoPuixsb4ofY5P3jc2VI5G/ZxXK7xhYP5Zm2EvrIZ/nIdWeRmNNGxtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjmQlOfR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d7a9200947so1010252a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726295878; x=1726900678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0XGXnTz50hOJaeNhqtXIh7+Vq+6DDbhWS4ntxPilS0=;
        b=IjmQlOfRibflEoQJ4x69+aTPKgPJJvJovJlIQKvhk1i8GsxJxL3UW/KHberUdkPEhx
         TJEp7EoRTwmh2amoS8traLPge4aEtDT07pye36Ko6KmwCDoETgGs3LjIbM1+KqwRAEIS
         u6fbkkCYoL7fYcjrIW1wz+cxXn8Z7+AxjuK7Ym93QZOTvQ4u85PKqWxL2DdtxAZ9VAuf
         k/1W065CESA6T1TV/VvAnu+u7bfI9rKdcf6ibHRIL9UNxWscbmEmys0vyq+o8orFb/XD
         6WadxZjKxvTV4c/F9oGjT6ld+s//nmzE5ldWH3/SZaQuBRUAMb5smpvTAWdWJMHf1eMf
         PG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726295878; x=1726900678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0XGXnTz50hOJaeNhqtXIh7+Vq+6DDbhWS4ntxPilS0=;
        b=ngQb9W4flXcPkGiQC7uGr/DJobUQjgohuZNGyiOgDVRs44mqg/FzUuIO9fwoJgAHRA
         HhFesn+SqhIyG/7XhFpdkHEGqPA7xb2cHoiI3yTu8rFiK8tpaErUsSknEDbOqKOcZE4j
         f76YvlknmPDMiRQKLM6BNCmrNaibsK1k8YU9ATQJB+plT1Ubw+Z/uYcDBGfmyJX+b3Ij
         bbeKmNhLUwd/K40v1luGmMTWp45/p4b1Zeepdc0xb2Umw3ttrPo50IN1eZUIIIKRpEbx
         z9EHhICpn0p8nDCCXhVCNre/cVrKfaXeaIPX4S8qAuKTOanGyO785x15Xnr3ZVRAkRMv
         6m0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/HWh0aFfKanm34gCyaazICqauzjG5Q1ttfFc7h8576/6PNQo3W0K2m559x+iE4vEh6tiy16kMu4Wm/BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVC8E14QVNoB7k6GL20NnsmMvKqY6fGWe5y+P8rTOrPSNAWR3P
	5CA64IimpB6BTS9nEJMzAkg4gbHXhPTMRzqwwNnljmiwCtANP5ncr6fMmpg2
X-Google-Smtp-Source: AGHT+IHUSR5jD2duXHLe3BrgPTf5h7DhPZAFxKcDMcB2yTXSiHyvVeTo590mSkNIjdz80NvYheEK+w==
X-Received: by 2002:a17:90b:388d:b0:2d8:f81f:87a0 with SMTP id 98e67ed59e1d1-2dbb9dee70cmr6516049a91.9.1726295878119;
        Fri, 13 Sep 2024 23:37:58 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:6927:3898:c182:14f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2928sm4835395ad.120.2024.09.13.23.37.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Sep 2024 23:37:57 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	fengbaopeng@honor.com,
	gaoxu2@honor.com,
	hailong.liu@oppo.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	lokeshgidra@google.com,
	ngeoffray@google.com,
	shli@fb.com,
	surenb@google.com,
	yipengxiang@honor.com,
	david@redhat.com,
	yuzhao@google.com,
	minchan@kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon folios
Date: Sat, 14 Sep 2024 18:37:46 +1200
Message-Id: <20240914063746.46290-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This follows up on the discussion regarding Gaoxu's work[1]. It's
unclear if there's still interest in implementing a separate LRU
list for lazyfree folios, but I decided to explore it out of
curiosity.

According to Lokesh, MADV_FREE'd anon folios are expected to be 
released earlier than file folios. One option, as implemented 
by Gao Xu, is to place lazyfree anon folios at the tail of the 
file's `min_seq` generation. However, this approach results in 
lazyfree folios being released in a LIFO manner, which conflicts 
with LRU behavior, as noted by Michal.

To address this, this patch proposes maintaining a separate list 
for lazyfree anon folios while keeping them classified under the 
"file" LRU type to minimize code changes. These lazyfree anon 
folios will still be counted as file folios and share the same 
generation with regular files. In the eviction path, the lazyfree 
list will be prioritized for scanning before the actual file 
LRU list.

[1] https://lore.kernel.org/linux-mm/f29f64e29c08427b95e3df30a5770056@honor.com/

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/mm_inline.h |  5 +-
 include/linux/mmzone.h    |  2 +-
 mm/vmscan.c               | 97 +++++++++++++++++++++++----------------
 3 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..118d70ed3120 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -225,6 +225,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
+	int lazyfree = type ? folio_test_anon(folio) : 0;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen != -1, folio);
@@ -262,9 +263,9 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
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
index 17506e4a2835..5d2331778528 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -434,7 +434,7 @@ struct lru_gen_folio {
 	/* the birth time of each generation in jiffies */
 	unsigned long timestamps[MAX_NR_GENS];
 	/* the multi-gen LRU lists, lazily sorted on eviction */
-	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE + 1][MAX_NR_ZONES];
 	/* the multi-gen LRU sizes, eventually consistent */
 	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the exponential moving average of refaulted */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96abf4a52382..9dc665dc6ba9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3725,21 +3725,25 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 
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
@@ -4291,6 +4295,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	int refs = folio_lru_refs(folio);
 	int tier = lru_tier_from_refs(refs);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	int lazyfree = type ? folio_test_anon(folio) : 0;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
 
@@ -4306,7 +4311,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 
 	/* promoted */
 	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
-		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 		return true;
 	}
 
@@ -4315,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4325,7 +4330,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* ineligible */
 	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 		return true;
 	}
 
@@ -4333,7 +4338,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
 		gen = folio_inc_gen(lruvec, folio, true);
-		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type + lazyfree][zone]);
 		return true;
 	}
 
@@ -4377,7 +4382,7 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		       int type, int tier, struct list_head *list)
 {
-	int i;
+	int i, j;
 	int gen;
 	enum vm_event_item item;
 	int sorted = 0;
@@ -4399,33 +4404,38 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
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
@@ -5586,8 +5596,15 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
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



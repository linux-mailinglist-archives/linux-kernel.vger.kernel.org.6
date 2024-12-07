Return-Path: <linux-kernel+bounces-436207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946599E8275
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502E2281388
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF318B46E;
	Sat,  7 Dec 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3LyzBBpY"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BA194A73
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609738; cv=none; b=maYGvHWizZI3XjpIgOsLuyiv0c7XQncPwOlQBNPNAgD+h+NYtod2vix2s+ugSyxO+Av2lDqNDixo8tlpc5tFsRIlzuDs6GhnqQwzybnGLqose2zl/IKcsud44mh5VZ5xAejx7ZvDItRJNrGYhbSB0k+m5zpJxcpE9ZRR+PDTK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609738; c=relaxed/simple;
	bh=KClDlWCi6SSa0R6rJOBLi/JB8ZGv/AnKAuzivugP4Fg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rTgVYhV4XxjW5/h5IWjew5orQG3gx0QKWAq6rwffp9Nyvo1KvXP2yvj3iLHZDHbHMvbgS2P/eT7VdhMPSK33akqlQOsGXLY47tXE7BOyN4wdEPs86tY+qkM9o87uuM98NIOeZIdIL5vj/PZwW7+NDlZs0iAkEI8WwOvkUEZmFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3LyzBBpY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so3439908a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733609736; x=1734214536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1mvjlX5nT1rLjjtVWZn8iR4hG3sSfAtSE80GuqS3ww=;
        b=3LyzBBpYh8ez/MIT2WVAO/cCoQYlsnjdTOB2EExLPNcjkeMtlchf27xPKeQlXBtQps
         5bPmWFIR7U9Mw8mRyTrZQlZl3kchXrTRPgiFcd5u9AntYYfdSWrORUHiAtCZrhWIF0t9
         rvw7dHk72bl4oLdkjLi3eIONAbvyLjME0XvimonvR1m24XXO+2rbqN3B7vPuhnRR3qPO
         UCryGp0E2UMrYgBY+PaUxoWTLekEDLxjPH8dMjhvD2c/j1mq+iTjdekRffEUbo5WroA7
         Xfok79eXdrtS5qdGQEggeYktCqpf149l8u85EuJAZ38UBhaZgziueANiYajbcwKrIQEz
         eIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609736; x=1734214536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1mvjlX5nT1rLjjtVWZn8iR4hG3sSfAtSE80GuqS3ww=;
        b=ai8slAbtxDgelDgDBcKA4NYzRbfL6UgcFuuTuaIqHfCue9ujGnF2KsseFj5o6ZhGLJ
         kwpT8xpRVDCdntxPP5DVgIevWeRMMsOhsjGMTwjwfp7pXbUyffgVQ1dWB9ygPuUX0Pjs
         6l1uGtYy9jvNgG6/Tqlj7y3rCBND+6Ls5H08gL9ETtgSkwuM7soKR+GqU3IFmTuxlg08
         mZX0r+xft/0nVIdsCvRlfvz9FP55dNGsZpEavf78+IB/0ZK+FKHMOB7xrK/sM21A8/O9
         6bA8SWx6EIDYUoav3yfVWHXzUVRwesBJ09O/nkXolL76a9Ngi1MXwh8DHppefPac2jne
         c69Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7soqKXq79NYq03xVxL+l5gcazAw8h2zQv+VdwhMpXGckLwIi5ozCyrQqfUXK8L/ArCUnr0FNQpe4fbp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCeiM/wsMHlcTrJhAuvBAR7BNArQuKNSJPXSPP2GYRG01nOgV
	THCMXR2BEDZIssVo56KFvtDcXRhugLTDQzjOXE4tdACEc2TWtzDYqKS8BJ2GmxVWpJz9F4vhyMk
	ESQ==
X-Google-Smtp-Source: AGHT+IE1cK9olUWYZZEb01UAnSqV/H0pU5jqrRIyuw+rrX9BP0rn/osA43XuWh8gcnpTcn+qx/sjV1NZo0M=
X-Received: from pjm5.prod.google.com ([2002:a17:90b:2fc5:b0:2ea:448a:8cd1])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558f:b0:2ee:4b8f:a5b1
 with SMTP id 98e67ed59e1d1-2ef6aadb4cbmr13013029a91.24.1733609736695; Sat, 07
 Dec 2024 14:15:36 -0800 (PST)
Date: Sat,  7 Dec 2024 15:15:20 -0700
In-Reply-To: <20241207221522.2250311-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207221522.2250311-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207221522.2250311-5-yuzhao@google.com>
Subject: [PATCH mm-unstable v3 4/6] mm/mglru: rework type selection
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, David Stevens <stevensd@chromium.org>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

With anon and file min_seq being able to move independently, rework
type selection so that it is based on the total refaults from all
tiers of each type. Also allow a type to be selected until that type
reaches MIN_NR_GENS, and therefore abs_diff(min_seq[0],min_seq[1]) now
can be 2 (MAX_NR_GENS-MIN_NR_GENS) instead of 1.

Since some tiers of a selected type can have higher refaults than the
first tier of the other type, use a less larger gain factor 2:3
instead of 1:2, in order for those tiers in the selected type to be
better protected.

As an intermediate step to the final optimization, this change by
itself should not have userspace-visiable effects beyond performance.

Reported-by: David Stevens <stevensd@chromium.org>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/vmscan.c | 82 +++++++++++++++++------------------------------------
 1 file changed, 26 insertions(+), 56 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 00a5aff3db42..02b01ae2bdbb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3089,15 +3089,20 @@ struct ctrl_pos {
 static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 			  struct ctrl_pos *pos)
 {
+	int i;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
-	pos->refaulted = lrugen->avg_refaulted[type][tier] +
-			 atomic_long_read(&lrugen->refaulted[hist][type][tier]);
-	pos->total = lrugen->avg_total[type][tier] +
-		     lrugen->protected[hist][type][tier] +
-		     atomic_long_read(&lrugen->evicted[hist][type][tier]);
 	pos->gain = gain;
+	pos->refaulted = pos->total = 0;
+
+	for (i = tier % MAX_NR_TIERS; i <= min(tier, MAX_NR_TIERS - 1); i++) {
+		pos->refaulted += lrugen->avg_refaulted[type][i] +
+				  atomic_long_read(&lrugen->refaulted[hist][type][i]);
+		pos->total += lrugen->avg_total[type][i] +
+			      lrugen->protected[hist][type][i] +
+			      atomic_long_read(&lrugen->evicted[hist][type][i]);
+	}
 }
 
 static void reset_ctrl_pos(struct lruvec *lruvec, int type, bool carryover)
@@ -4480,13 +4485,13 @@ static int get_tier_idx(struct lruvec *lruvec, int type)
 	struct ctrl_pos sp, pv;
 
 	/*
-	 * To leave a margin for fluctuations, use a larger gain factor (1:2).
+	 * To leave a margin for fluctuations, use a larger gain factor (2:3).
 	 * This value is chosen because any other tier would have at least twice
 	 * as many refaults as the first tier.
 	 */
-	read_ctrl_pos(lruvec, type, 0, 1, &sp);
+	read_ctrl_pos(lruvec, type, 0, 2, &sp);
 	for (tier = 1; tier < MAX_NR_TIERS; tier++) {
-		read_ctrl_pos(lruvec, type, tier, 2, &pv);
+		read_ctrl_pos(lruvec, type, tier, 3, &pv);
 		if (!positive_ctrl_err(&sp, &pv))
 			break;
 	}
@@ -4494,68 +4499,34 @@ static int get_tier_idx(struct lruvec *lruvec, int type)
 	return tier - 1;
 }
 
-static int get_type_to_scan(struct lruvec *lruvec, int swappiness, int *tier_idx)
+static int get_type_to_scan(struct lruvec *lruvec, int swappiness)
 {
-	int type, tier;
 	struct ctrl_pos sp, pv;
-	int gain[ANON_AND_FILE] = { swappiness, MAX_SWAPPINESS - swappiness };
 
+	if (!swappiness)
+		return LRU_GEN_FILE;
+
+	if (swappiness == MAX_SWAPPINESS)
+		return LRU_GEN_ANON;
 	/*
-	 * Compare the first tier of anon with that of file to determine which
-	 * type to scan. Also need to compare other tiers of the selected type
-	 * with the first tier of the other type to determine the last tier (of
-	 * the selected type) to evict.
+	 * Compare the sum of all tiers of anon with that of file to determine
+	 * which type to scan.
 	 */
-	read_ctrl_pos(lruvec, LRU_GEN_ANON, 0, gain[LRU_GEN_ANON], &sp);
-	read_ctrl_pos(lruvec, LRU_GEN_FILE, 0, gain[LRU_GEN_FILE], &pv);
-	type = positive_ctrl_err(&sp, &pv);
+	read_ctrl_pos(lruvec, LRU_GEN_ANON, MAX_NR_TIERS, swappiness, &sp);
+	read_ctrl_pos(lruvec, LRU_GEN_FILE, MAX_NR_TIERS, MAX_SWAPPINESS - swappiness, &pv);
 
-	read_ctrl_pos(lruvec, !type, 0, gain[!type], &sp);
-	for (tier = 1; tier < MAX_NR_TIERS; tier++) {
-		read_ctrl_pos(lruvec, type, tier, gain[type], &pv);
-		if (!positive_ctrl_err(&sp, &pv))
-			break;
-	}
-
-	*tier_idx = tier - 1;
-
-	return type;
+	return positive_ctrl_err(&sp, &pv);
 }
 
 static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
 			  int *type_scanned, struct list_head *list)
 {
 	int i;
-	int type;
-	int tier = -1;
-	DEFINE_MIN_SEQ(lruvec);
-
-	/*
-	 * Try to make the obvious choice first, and if anon and file are both
-	 * available from the same generation,
-	 * 1. Interpret swappiness 1 as file first and MAX_SWAPPINESS as anon
-	 *    first.
-	 * 2. If !__GFP_IO, file first since clean pagecache is more likely to
-	 *    exist than clean swapcache.
-	 */
-	if (!swappiness)
-		type = LRU_GEN_FILE;
-	else if (min_seq[LRU_GEN_ANON] < min_seq[LRU_GEN_FILE])
-		type = LRU_GEN_ANON;
-	else if (swappiness == 1)
-		type = LRU_GEN_FILE;
-	else if (swappiness == MAX_SWAPPINESS)
-		type = LRU_GEN_ANON;
-	else if (!(sc->gfp_mask & __GFP_IO))
-		type = LRU_GEN_FILE;
-	else
-		type = get_type_to_scan(lruvec, swappiness, &tier);
+	int type = get_type_to_scan(lruvec, swappiness);
 
 	for_each_evictable_type(i, swappiness) {
 		int scanned;
-
-		if (tier < 0)
-			tier = get_tier_idx(lruvec, type);
+		int tier = get_tier_idx(lruvec, type);
 
 		*type_scanned = type;
 
@@ -4564,7 +4535,6 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 			return scanned;
 
 		type = !type;
-		tier = -1;
 	}
 
 	return 0;
-- 
2.47.0.338.g60cca15819-goog



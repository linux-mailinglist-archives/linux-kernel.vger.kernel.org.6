Return-Path: <linux-kernel+bounces-426872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE79DF997
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D345A281D37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B583F1E25EB;
	Mon,  2 Dec 2024 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="daG/P1qy"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C751E22F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110121; cv=none; b=jwzzpxauGB9VKcCyS3bw6i3vAAJi0O6gzVRPeQv0lvfA0AvMfi9tw0pa6jx5CXm0zPLwUrAld8t1T0wBr7owQJFbyv6ZrJWOOaQyh60/e+ipgVEEhAg53NzjEQuJkIvxGvAeQ+GQ+zswrNzxk0i+qQEeyZGs565YLHuurkZ6cfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110121; c=relaxed/simple;
	bh=WHOuPRCy//RCAKcTssz6Q2wexBSEDMdrcNFaKJhW49E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/+xKaTb6Me/oki0c8vxeuvCxSk6iN7qYfBkJFJlkui7xM2HZGcE8JSg3ssDG8+mR86StVZs5Ro+jZQxWBb2++zSYdysDQkNW1nkrQR3cIday2z0eXNsmhL5xQEhyBrRhCdSA0UfDre39xRcpeUHHTFZ1y+2pvQuvfU+sVl7L7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=daG/P1qy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72467cd273dso3555580b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733110118; x=1733714918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAZ7EXnKaWj8C19Di4ja72nho7QoBFM1H+8+YKhOaNc=;
        b=daG/P1qyRlxSN3uDXi7jJgkya339LGky6eZ9wg8Sk7sTKgF8HD2yVbS0vUJoX5nbMm
         GQv1NIMSf/L+fDkjVFjJ+VTRqL/UcXA8j2gl2FDJVR+tSwL6nFBTqQSNU9AuUDyDPqHX
         iBfsvnmeXzAISlVFVZRfmoRPQjIr91n0T9iCYLkCHHwIzT+kx5YRFjzKqzWQJ4ZztucQ
         8vMRpYnWpB/ybrre7+ImL/mAB/0ZwAGk9FZGT4k3+j9AHVroqSW30NBGP2HRSTFLvqlx
         guMRry84fquejbO4s4w0XT4O36UEV+fMjhiaqkmPhgq6pw1QJ9pUB7XpiNGFT0hOcPdk
         8WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110118; x=1733714918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAZ7EXnKaWj8C19Di4ja72nho7QoBFM1H+8+YKhOaNc=;
        b=U2RyWU/9TiMDyypGHn7I0kjhP3SfjEH77GbELgg2P1gu5KBP9YjY19GMke0yCp8lIq
         By75FVkDh2j1un814WtwjIlOgK0vC42/44+bP+Ij3TcFe1S+MbCzy4rUFmIRfTjmu5W3
         S+qr3+1atznAS6Sf4ZZWpEhUtb2IECGrLsKZ2TG9uNZfpUqDy//kblIlsj4mchDdKBX7
         OZ4uQhRaQA3cCvlLq7IUmdjNKpiXjf8W7M1rITOCVnaQLvYMGFbhXgtptFiUH55fE6la
         LNsqMw3a/o19wRMH02tq1iyyn5iyYXOxbIOhvDWJI61SKRymozy5GqS5ulSdoPj9aOTa
         ekOg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7PeJH2cwU9axSAsPRPkDyV3pEmIRRSnLXmdymfLnKMEvrh4N1fvzpR05GfZIifFetQ7MyBy4fkEdRag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1xa7cFYYWsI/7fSujz7oJYc60tlMv2aZdnxA40dE++A177Hi
	LvD8ZtlZ4v0pwCcJWbrk2COeDj8mmdjK7Vn7hJB6Mcr3DvY1/kh71HlxdjGraBhRFyEZi27ke5A
	1Vg==
X-Google-Smtp-Source: AGHT+IEv//P/jMaTg8qmYerNeCdqWyYAtY0F42kcb0T+44U79mT8shI+AxtZNoulfnzTgxMAL0SEqCiFUhE=
X-Received: from pjbqd4.prod.google.com ([2002:a17:90b:3cc4:b0:2ea:c64d:fccb])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5186:b0:2ee:9229:e4bd
 with SMTP id 98e67ed59e1d1-2ee9229e5d9mr9120161a91.2.1733110118614; Sun, 01
 Dec 2024 19:28:38 -0800 (PST)
Date: Sun,  1 Dec 2024 20:28:21 -0700
In-Reply-To: <20241202032823.2741019-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202032823.2741019-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202032823.2741019-5-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 4/6] mm/mglru: rework type selection
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
index 00a5aff3db42..307ae8b03d0d 100644
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
+	pos->refaulted = pos->total = 0;
 	pos->gain = gain;
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



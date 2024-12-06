Return-Path: <linux-kernel+bounces-434152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A949E6245
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9ECB2835EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B44193;
	Fri,  6 Dec 2024 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZmDDcAh"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C992558A5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445104; cv=none; b=lcFkAUtEks9Nc/cDRhgCgja1XxEkmclNyvT/fAlzHJSr+ZdJHkeDHhEoyxBNWcDSwj8MEP3vawGVHEFkQpqkRPoyN2Wb0SIwSanvfjqgsn7WItMENcQBtUc8cZoEw4H8M9Phhu/k1LegDEnMBPNPq4AP314vnTeEyyZHOh3B5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445104; c=relaxed/simple;
	bh=KClDlWCi6SSa0R6rJOBLi/JB8ZGv/AnKAuzivugP4Fg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJvXidDLni6hp8oM6YRMg80SaTCeW/FGjCq/xmPont/HNUzLmmFVUBgaIlc62ZQemquRscC1iii/QIHYTQSNzZQwiKcS5CP4EsrGbUUBmG7A+5GeuIyLPfPvIyXrIrvUzoKALX+PheI9qpkNQdUeqImUWQm+ESfcbs01t+7vfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZmDDcAh; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725b7e75f15so571565b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733445102; x=1734049902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1mvjlX5nT1rLjjtVWZn8iR4hG3sSfAtSE80GuqS3ww=;
        b=XZmDDcAhR7B2s9NLqaNNu9Ar/e8zo3r2+PmHQ0rXaF6KUyhLBozxJd7a4u8RnfGJud
         GjWuhiC22BKgAX9zz5areNrl08bfKyNaWKWRHyaBueQD89rnLgbk/c7PFw9FlSMNQ9i0
         vSxy1aqETUZAgjG37GWbrC6+dy2UgCemg5WTEz18ZkUp8uR/MUyiQ/8Z/DZDsdiLK2Mk
         kL1llIv87Zony6ID2V5Y5s9FlF0pMlOPg0y4M9Lm/bTc2aLQb5y06yctLaFZ9qYL8MmI
         mJhtS2/8Q5/2aVGo06UUvcnpkLWCOL9BECKosck0xEE8cBJ8cH415a8EW7SvFA61WYA0
         esdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445102; x=1734049902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1mvjlX5nT1rLjjtVWZn8iR4hG3sSfAtSE80GuqS3ww=;
        b=Z1HYrlUEjST+Qhv1Qu4NHp9Pdf02vIh9ZxBg587ayosgc1/S0KMGo2bnbo5ET/ujw4
         AVKsuM0iaPHkT0VCarYoJ1XevgQ6FLpS+e0EhGBXModqp0+SHkhaRmvMW50DWMtuDppj
         GfHyKcQuE9o7Ns5RRRwrdP2Ce0fle/JBSprbbH2ehJzvZ85gQihWaYo8pGatma/qZlY6
         PUATWfViNwouVWPXyftWWLlc62df8w/6LxnsAir1utejg2zuakPEhQj/pAzpLpNycOuS
         UmgLKYKOH8x05z9jaLp4f4Nh8rJxxCV2Qy6Fu1XjrG3eUzwOrDxOKaNjlpqSBw2JPbCd
         YbLg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Egy34xN0NKeRyGI7RRiB0wVWh8QihcnacxilZktpt+gNgG1fWiRGJwE/uQHVHv1U8D384ixN2ZumxfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuNkAlXllaBnJzs1OlEg1jtZo+r0u5Bkq5EBZs7xTbb4Tnpc+
	UIsBDB1onpIB3HGFZpwGfhi42aRj9tffyhx0hSRKu97tQOF3hqp4DJO8rszZxYoVdSdcw10sajx
	QuQ==
X-Google-Smtp-Source: AGHT+IHDpfbWWJjycwRdIOATm4/TSA+FDknfDh4D0XImpwFKpP+OCJtRJF+zzzhrB+mJ306ByBPns1yu/E8=
X-Received: from pfbim19.prod.google.com ([2002:a05:6a00:8d93:b0:725:3321:1f0c])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc7:b0:725:9d1d:3462
 with SMTP id d2e1a72fcca58-725b81c1481mr1987282b3a.25.1733445102450; Thu, 05
 Dec 2024 16:31:42 -0800 (PST)
Date: Thu,  5 Dec 2024 17:31:24 -0700
In-Reply-To: <20241206003126.1338283-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206003126.1338283-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206003126.1338283-5-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 4/6] mm/mglru: rework type selection
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



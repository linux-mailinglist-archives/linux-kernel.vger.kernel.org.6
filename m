Return-Path: <linux-kernel+bounces-426869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF69DF994
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49305162343
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFFD1E261E;
	Mon,  2 Dec 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="26vKLyMv"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF71E1C26
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110112; cv=none; b=jREyCn+RG1i1DpQ5mthemJRQqkd/sAPGWqA60EjzAfasrKYW1hkAeyfavW4UZSBxiKU+MdnDUPThKxP+arnRETNkj/ahE8EQSfRj8bbExdBnYDpOJRwRfdur9Odm6BV7CwYy8N9aBSekRFnAWoeSpIvgT0Tjf9PAp+M+/wUGktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110112; c=relaxed/simple;
	bh=XiSEz2JJBtdIoxT7K/+uOXzsYf9JPp/DAxpitCZzgn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SuLbb9zWZXyhyk+8oDLkUly6sUjF3IY/A9RSGRRea/+Yl+qnc7cI/Bm4xv2LHkDJDu+m9+dylyj2PW8/zslCQbobDlluhg3xS/jtcWfw1y/qKWbCxyEvs9eYvf3Uv8Y69qrPIBT8TPSUw8jwHx0/wE6593Xp/FWPc5zbXEUFXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=26vKLyMv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee3c572485so4397770a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733110111; x=1733714911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9A2hZ07C4gph5EkXou5eK7gRFH6gXGFcx+0iC/Exo=;
        b=26vKLyMvYvlNo08BggWR1W8sp3n3C2o+G9eJ8bJt94jTB/72htmaV+ajKVJ+MEp4aI
         K24l1Hd3G3nLHMnOgT1TJahaRanVSxCQn8abpt7ivZd/h7DSGo1jCTVx+BS8QQuKVDSW
         6roN9IruPZfl9RRwwA6rR9NqPRiOdomczZQ1gR9gXapwaLHU3rOIHp09IXYMeZv11Jyy
         I1125u95qNerGf4BzvnAVNEzro9p1r3tof3wnqTmjpTMSWj6rGkHVY+RJyS8w9gN1uRl
         kUZff/hgT2U0qE57EHeRLER7aIZHG8+Bdx0wPED1p7pnt0BxreJiF6yjIBuitYomh7EH
         3bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110111; x=1733714911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9A2hZ07C4gph5EkXou5eK7gRFH6gXGFcx+0iC/Exo=;
        b=GiNHMm2x459mwGjMsnXI/lN+3RU+yJeUs9M7DxHWmIzl57EI8nUW26IZI/HIMTIS2J
         G1XFKU/qg5Z9YiwDH63/meS0yQHHmHHZJefsKKkBj2+5uClx3J5J2RcBZ/YhTbnBk5Fg
         Fc4Hww9c+JMHzJ+j5eM1Jm930piWlBiwIuMRwmX2HH+hI4IPOhe/mBVhIHo+0JAgxUwN
         a1rQt4rQn2UGvtaMuuOzs35D8zS9v4Qc3rzyTEZmWyEwEM1bZe35P+tGNR/1QkQHHSYF
         /2TghpY9jmC804X4Fv+3yWDrUgJ46v/XoUEdwjpa4tnBUeYaRACS5iOQQBB6ZRHlb4FH
         E/aA==
X-Forwarded-Encrypted: i=1; AJvYcCUF8m35lld6ULTDZnisG7cofM317WqSSJleQCjmOBnbanMpnTfZFxUghzVJCm/MweicZpwz+gQI/zfDMZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHXWZrgx6QGNPyI+b1rqAiHMBeoOWif8o0chbddH6Qh9ek2GS
	CYhGnLnm7UTLJm3GH5wd1bjBpBhh51eG5h2SrBfnB51KlYRRd/Chb7JKgM3leIYA8n4LNj6Ogls
	dHA==
X-Google-Smtp-Source: AGHT+IEqTdJXZQhb+wWTbmtYxN0jo2FTMzf/EWYgoLBGFBa+R/zRxwCYD577vOiuDbQ1RP0KS+rm7MbIVxI=
X-Received: from plbll14.prod.google.com ([2002:a17:903:90e:b0:215:3fc5:cd3f])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e881:b0:215:7b70:79fe
 with SMTP id d9443c01a7336-2157b707c93mr79972115ad.32.1733110110727; Sun, 01
 Dec 2024 19:28:30 -0800 (PST)
Date: Sun,  1 Dec 2024 20:28:18 -0700
In-Reply-To: <20241202032823.2741019-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202032823.2741019-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202032823.2741019-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 1/6] mm/mglru: clean up workingset
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move VM_BUG_ON_FOLIO() to cover both the default and MGLRU paths. Also
use a pair of rcu_read_lock() and rcu_read_unlock() within each path,
to improve readability.

This change should not have any side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/workingset.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index a4705e196545..ad181d1b8cf1 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -428,17 +428,17 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 	struct pglist_data *pgdat;
 	unsigned long eviction;
 
-	rcu_read_lock();
-
 	if (lru_gen_enabled()) {
-		bool recent = lru_gen_test_recent(shadow, file,
-				&eviction_lruvec, &eviction, workingset);
+		bool recent;
 
+		rcu_read_lock();
+		recent = lru_gen_test_recent(shadow, file, &eviction_lruvec,
+					     &eviction, workingset);
 		rcu_read_unlock();
 		return recent;
 	}
 
-
+	rcu_read_lock();
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
 
@@ -459,14 +459,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 	 * configurations instead.
 	 */
 	eviction_memcg = mem_cgroup_from_id(memcgid);
-	if (!mem_cgroup_disabled() &&
-	    (!eviction_memcg || !mem_cgroup_tryget(eviction_memcg))) {
-		rcu_read_unlock();
+	if (!mem_cgroup_tryget(eviction_memcg))
+		eviction_memcg = NULL;
+	rcu_read_unlock();
+
+	if (!mem_cgroup_disabled() && !eviction_memcg)
 		return false;
-	}
-
-	rcu_read_unlock();
-
 	/*
 	 * Flush stats (and potentially sleep) outside the RCU read section.
 	 *
@@ -544,6 +542,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	bool workingset;
 	long nr;
 
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
 	if (lru_gen_enabled()) {
 		lru_gen_refault(folio, shadow);
 		return;
@@ -558,7 +558,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 * is actually experiencing the refault event. Make sure the folio is
 	 * locked to guarantee folio_memcg() stability throughout.
 	 */
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	nr = folio_nr_pages(folio);
 	memcg = folio_memcg(folio);
 	pgdat = folio_pgdat(folio);
-- 
2.47.0.338.g60cca15819-goog



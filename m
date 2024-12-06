Return-Path: <linux-kernel+bounces-434153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D19E6246
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BEB282AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AF581AD7;
	Fri,  6 Dec 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xJWIrak"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843D5EE97
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445107; cv=none; b=nO3Qag89YaHN86FZGbKxtvczrOw62fsVBqY6TPQcVm3S1pU6iGFLrkCIx7ehkV6mX7DuKGIDfFHYvLu+83Q7vGd8+ijd47MF9KeINV0p5fsk+dnkv1UF1TgyePZJsaeZjHynucev7epqk1uS1cFnSrfRJIPxR3jqNtCovtdnFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445107; c=relaxed/simple;
	bh=7eooM8lictiogeSqDWNnopPiMIbG0zFPlbWX1bsoFTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pAp/A4kryZ3X+xNILLErJ2np4NaXNwHdfkX32mSYv1aI0NqAZA8zz9BUtbDeVvseSfqkpm1NFLQo8Gv+6C9baHC+YEh+Q/ZDOYmp+4TYlBNOuYTS+su9K4mQfdLx31ybq9f5XIHwfrUPos2MSC/KGis2mhMA7k04sTUuM04P5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xJWIrak; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-215b45a6e2aso15871965ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733445105; x=1734049905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW2cgcwHB51Y5IYZaisd+Bp0HxAyG3VEQ4AUms4DlWs=;
        b=3xJWIrak1tSliUpXcCyShFM9HW3y+w1/uTZ/SeJDCrCyKOACGgj3FDBufNx8e9okx8
         NPBmPdlQClLjUqaFtt6jS/gRwA0HCMc5ztfwuGxBzQPApV/93FSHvURXzqUdYu/4W7Hp
         meKarKNwxyQAUduvkbFxGBsmc9k7DHvqmFfhcOsV9+yDsxrYuZULdYuwoq0808rRvPo5
         rPDA3TpG1N46IQiRt+W/99YMjwobvSnlW5bLlPYrdx6QNzdoZjsBlMoxnfy+OAFGAiFN
         +1zLcM8Hl9s9S23hHoLIHtDirc6lsrkWnfKQrZYnVYwcQ037GQheVZg6mL48cUuhV9H2
         ZWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445105; x=1734049905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW2cgcwHB51Y5IYZaisd+Bp0HxAyG3VEQ4AUms4DlWs=;
        b=vtg0ul0IkoXwKgK07lZqHAUUb0ae5a5Mb75Fw3kZBHXKFD9yn2z1EuYdJl4ImkfkvD
         wPtGz9Y52Rj6RUw/ynr+bzytnmyuYr2WcPzg4LQTeEndhqnlPfMx9901WdKHEbCGy8Ik
         rimpPNngqPPTSG/aVeL+bzfgjPoRrc6pybYB1GPXKG0wUJX1J2urRov3inKCkQMrcjfV
         hx29qZl2JAPxcAAHyCT2Ct1ELQol/qI7Q9O2a1H7pyhXMV9c48SrJs73d9h0NMzWAb5b
         sv5dIOenRmdnaMZ5W+j3tV7g5R22TQ0Wx8MPZY22hQx1np3tov6YUNcAuI+oPqb9ns5w
         B73A==
X-Forwarded-Encrypted: i=1; AJvYcCVmb3BNVHONxCOxtWS4Z7q7Ic0j+UT6iQ1VD2Efi4Ntj5LypRBRIFdSJTs40JmrJOm8jWXhYiXMjBQmjyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPanPuVlSshrmw8TPF2geHK7TxgHBJYmgIO+MDFYW3ekcjYfX9
	//fDJZkPJ07ijdCfXVVHTy9WoiEeEsSrFyTJfEwxYQKL6hgolUPQwdMZwwTEyFcm97P/VJstr7M
	eRw==
X-Google-Smtp-Source: AGHT+IGcBw64P6PC43lwi6CEzaODCf5NQzsvKmv+pkev0Vd7uHGWUIM2qXHUyE9c6qDAYcuhyiX00sGOta8=
X-Received: from pllb6.prod.google.com ([2002:a17:902:e946:b0:215:83cc:b135])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:24d:b0:216:1367:7e3d
 with SMTP id d9443c01a7336-21614d67fc3mr14295335ad.31.1733445105156; Thu, 05
 Dec 2024 16:31:45 -0800 (PST)
Date: Thu,  5 Dec 2024 17:31:25 -0700
In-Reply-To: <20241206003126.1338283-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206003126.1338283-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206003126.1338283-6-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 5/6] mm/mglru: rework refault detection
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Kairui Song <kasong@tencent.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

With anon and file min_seq being able to move independently, rework
workingset protection as well so that the comparison of refaults
between anon and file is always on an equal footing.

Specifically, make lru_gen_test_recent() return true for refaults
happening within the distance of MAX_NR_GENS. For example, if min_seq
of a type is max_seq-MIN_NR_GENS, refaults from min_seq-1, i.e.,
max_seq-MIN_NR_GENS-1, are also considered recent, since the distance
max_seq-(max_seq-MIN_NR_GENS-1), i.e., MIN_NR_GENS+1 is less than
MAX_NR_GENS.

As an intermediate step to the final optimization, this change by
itself should not have userspace-visiable effects beyond performance.

Reported-by: Kairui Song <kasong@tencent.com>
Closes: https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/workingset.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index ad181d1b8cf1..2c310c29f51e 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -260,11 +260,11 @@ static void *lru_gen_eviction(struct folio *folio)
  * Tests if the shadow entry is for a folio that was recently evicted.
  * Fills in @lruvec, @token, @workingset with the values unpacked from shadow.
  */
-static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
+static bool lru_gen_test_recent(void *shadow, struct lruvec **lruvec,
 				unsigned long *token, bool *workingset)
 {
 	int memcg_id;
-	unsigned long min_seq;
+	unsigned long max_seq;
 	struct mem_cgroup *memcg;
 	struct pglist_data *pgdat;
 
@@ -273,8 +273,10 @@ static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
 	memcg = mem_cgroup_from_id(memcg_id);
 	*lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-	min_seq = READ_ONCE((*lruvec)->lrugen.min_seq[file]);
-	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
+	max_seq = READ_ONCE((*lruvec)->lrugen.max_seq);
+	max_seq &= EVICTION_MASK >> LRU_REFS_WIDTH;
+
+	return abs_diff(max_seq, *token >> LRU_REFS_WIDTH) < MAX_NR_GENS;
 }
 
 static void lru_gen_refault(struct folio *folio, void *shadow)
@@ -290,7 +292,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 
 	rcu_read_lock();
 
-	recent = lru_gen_test_recent(shadow, type, &lruvec, &token, &workingset);
+	recent = lru_gen_test_recent(shadow, &lruvec, &token, &workingset);
 	if (lruvec != folio_lruvec(folio))
 		goto unlock;
 
@@ -331,7 +333,7 @@ static void *lru_gen_eviction(struct folio *folio)
 	return NULL;
 }
 
-static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
+static bool lru_gen_test_recent(void *shadow, struct lruvec **lruvec,
 				unsigned long *token, bool *workingset)
 {
 	return false;
@@ -432,8 +434,7 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 		bool recent;
 
 		rcu_read_lock();
-		recent = lru_gen_test_recent(shadow, file, &eviction_lruvec,
-					     &eviction, workingset);
+		recent = lru_gen_test_recent(shadow, &eviction_lruvec, &eviction, workingset);
 		rcu_read_unlock();
 		return recent;
 	}
-- 
2.47.0.338.g60cca15819-goog



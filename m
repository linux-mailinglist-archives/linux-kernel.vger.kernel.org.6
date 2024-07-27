Return-Path: <linux-kernel+bounces-264299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F293E16A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 01:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069F0281A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B165186E5E;
	Sat, 27 Jul 2024 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJJ7FXZ9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009F1862B2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722121613; cv=none; b=POuPsEuB0TYBLuS44x4nArpS3nyef9sbl6cly8RoGcqCtgyn2r0KNuDWrcvOxlJIn4wk6Uqi24ehRV3cPBZaKTAEeONN9tkeZR5tq8sKAHQViDKG61zEZW3nZq5UydOR9MDQfjqB0E2NhEhQogMcapKyHIu3VPAqenHSlZqHnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722121613; c=relaxed/simple;
	bh=LTy+jkbEyRIQPOLyxWnCz08S5NOGybmn236jQt0GbRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/DXwU780uq1GxnkuTG04qhiS1o3Sdpg8DUgxeyrkLjr8Xpxwsy7XtJ3rY3opPi2yBmnY6diDGfSsS/kjWthvWrETBPFe4Mm8ZGC+8gtnf0fO25UB215KkD6cnrxPOZeahXlP904GzCV6kGaHMgy07ts0xy3JkqNh2kOqLjKrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJJ7FXZ9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fed72d23a7so13213665ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722121611; x=1722726411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd+/PkNsbnZGnxyGV+P8ksi9diuCZ2xuAbwQqloCs2E=;
        b=jJJ7FXZ9wMpXIhY5moV0qhAk/rR0Yqcj+MUR99Uk9sgNppkLEYdPL7xVg+CTCkUAlW
         s0s8P6SCUJ5P+0X/2OofP7+yE/bhdh2UNoTib0Jmp+huj0Dgo05EFMIuPoDiZw1fC9IP
         tU7OL3G78U2j82MRbfeoscFEcszo6gAvr3BhKEALh1sMN3+jreMCyjhOqbpub04vhXxE
         GNGLZRUQhJ1+MySgdDQv6vuYlIDlRZq5IhWpSt8jiw4hQlvHe01IfYVk5Yh6QRq+0Lp4
         Pn6aaFGjpEuWuaBoud9gggY9gCo9Wv4TlgdzanIWtqdh8HaJO4+bUPH2jusRf8wU6ZFc
         ksog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722121611; x=1722726411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yd+/PkNsbnZGnxyGV+P8ksi9diuCZ2xuAbwQqloCs2E=;
        b=J/bvEtI1rpD6ggTJAVagu2f2E2bSwt1TyyZuliHknprEHnsdUGy79GctIdGUNWzBVy
         yw9nL2nq40jV4rOvYTfPo4R/uhIzyCDBHJmAdYAu04V+MVv9fa4rgJOV+itnWiqbbcrL
         AgMlCOKAFNQbDIvIMlcxI1tVYe/wGNaSUHB+OQy/v7beavwYm/Veq34AMk+MR2AJ6+X5
         UH/Y0ISzeXHWiyWXXSpkCExEOZ2zVq3W8m1gw1XxQDodz3iObfqJe7RewjKbVjRCihcc
         JG2hOZaYAJJWdkE/0uL9RBSquX9bwO239aTy0nC/NhWcuPE8hqpHYri6PtO616qlIomZ
         kO4A==
X-Forwarded-Encrypted: i=1; AJvYcCU84DKLwiu/R/hWeoBAdA5uZMycJfcZIFfHXauAQiQWH6FocmIZANNjtoEOIYG1fjMFI5ipfNT8S/pw7KoH0KCSCWBaSpyqYV8ap2J8
X-Gm-Message-State: AOJu0Yy1I2WQXWNiF71OsH8YHE0W70qs6Y8uMnoXjjBqRtWh7R+djFys
	itW9hYzV3vK/ekQ/mTTVqMsCAoaFqXgMiWUu9dpw6JeeVK+1l+yq
X-Google-Smtp-Source: AGHT+IF/8gi3Mz4DsUNG9UiAYAkoJ0FEr706604n2lQS02Byp3AL/IAe8zts+2DvzxbR9MZ9cSUcCg==
X-Received: by 2002:a17:902:e5ca:b0:1fb:3d7:1d01 with SMTP id d9443c01a7336-1ff048e4fd6mr30034875ad.59.1722121611214;
        Sat, 27 Jul 2024 16:06:51 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f274a7sm55881145ad.209.2024.07.27.16.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 16:06:50 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm: zswap: fix global shrinker error handling logic
Date: Sat, 27 Jul 2024 23:06:30 +0000
Message-ID: <20240727230635.3170-3-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727230635.3170-1-flintglass@gmail.com>
References: <20240727230635.3170-1-flintglass@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the zswap global shrinker, which did not shrink the
zpool as expected.

The issue addressed is that shrink_worker() did not distinguish between
unexpected errors and expected errors, such as failed writeback from an
empty memcg. The shrinker would stop shrinking after iterating through
the memcg tree 16 times, even if there was only one empty memcg.

With this patch, the shrinker no longer considers encountering an empty
memcg, encountering a memcg with writeback disabled, or reaching the end
of a memcg tree walk as a failure, as long as there are memcgs that are
candidates for writeback. Systems with one or more empty memcgs will now
observe significantly higher zswap writeback activity after the zswap
pool limit is hit.

To avoid an infinite loop when there are no writeback candidates, this
patch tracks writeback attempts during memcg tree walks and limits
reties if no writeback candidates are found.

To handle the empty memcg case, the helper function shrink_memcg() is
modified to check if the memcg is empty and then return -ENOENT.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e9b5343256cd..60c8b1232ec9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1293,10 +1293,10 @@ static struct shrinker *zswap_alloc_shrinker(void)
 
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
-	int nid, shrunk = 0;
+	int nid, shrunk = 0, scanned = 0;
 
 	if (!mem_cgroup_zswap_writeback_enabled(memcg))
-		return -EINVAL;
+		return -ENOENT;
 
 	/*
 	 * Skip zombies because their LRUs are reparented and we would be
@@ -1310,20 +1310,34 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 
 		shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
 					    &shrink_memcg_cb, NULL, &nr_to_walk);
+		scanned += 1 - nr_to_walk;
 	}
+
+	if (!scanned)
+		return -ENOENT;
+
 	return shrunk ? 0 : -EAGAIN;
 }
 
 static void shrink_worker(struct work_struct *w)
 {
 	struct mem_cgroup *memcg;
-	int ret, failures = 0;
+	int ret, failures = 0, attempts = 0;
 	unsigned long thr;
 
 	/* Reclaim down to the accept threshold */
 	thr = zswap_accept_thr_pages();
 
-	/* global reclaim will select cgroup in a round-robin fashion.
+	/*
+	 * Global reclaim will select cgroup in a round-robin fashion from all
+	 * online memcgs, but memcgs that have no pages in zswap and
+	 * writeback-disabled memcgs (memory.zswap.writeback=0) are not
+	 * candidates for shrinking.
+	 *
+	 * Shrinking will be aborted if we encounter the following
+	 * MAX_RECLAIM_RETRIES times:
+	 * - No writeback-candidate memcgs found in a memcg tree walk.
+	 * - Shrinking a writeback-candidate memcg failed.
 	 *
 	 * We save iteration cursor memcg into zswap_next_shrink,
 	 * which can be modified by the offline memcg cleaner
@@ -1361,9 +1375,14 @@ static void shrink_worker(struct work_struct *w)
 		spin_unlock(&zswap_shrink_lock);
 
 		if (!memcg) {
-			if (++failures == MAX_RECLAIM_RETRIES)
+			/*
+			 * Continue shrinking without incrementing failures if
+			 * we found candidate memcgs in the last tree walk.
+			 */
+			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
 				break;
 
+			attempts = 0;
 			goto resched;
 		}
 
@@ -1371,8 +1390,16 @@ static void shrink_worker(struct work_struct *w)
 		/* drop the extra reference */
 		mem_cgroup_put(memcg);
 
-		if (ret == -EINVAL)
-			break;
+		/*
+		 * There are no writeback-candidate pages in the memcg.
+		 * This is not an issue as long as we can find another memcg
+		 * with pages in zswap. Skip this without incrementing attempts
+		 * and failures.
+		 */
+		if (ret == -ENOENT)
+			continue;
+		++attempts;
+
 		if (ret && ++failures == MAX_RECLAIM_RETRIES)
 			break;
 resched:
-- 
2.43.0



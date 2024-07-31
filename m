Return-Path: <linux-kernel+bounces-268382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D19423F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B87F1C22E25
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7BDF44;
	Wed, 31 Jul 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bidbvLFG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB64C13D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386972; cv=none; b=CbRK9tm9VDcnk5SrmFW6PlXw5p2IhPxbzc+MVMVgP1yb8lJLctLkz5ZWqUoVwr6aJ68XRZHT7KhxLlPOhCwXFay+R7U7bOpNn67d2nYEd301H0hNKK4QN9AW5WNJ2E5UE81SQKkFivyoAgsDq/HG0PY9KGcvLnD3E6uOIu3Uu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386972; c=relaxed/simple;
	bh=4E9Uz9Lw+tAu8w7u7FTRNbpBbSvQBCWWSfZGvG9FEkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsCI+EDDueV+Mf5gZyy5DdnpJcjVWI9XWIIBX/+YkiLMAvzvgn03Tg+M6TYYW+2Js6LitbR+Wwp9iYdmYQ/DS6S/TgS7GC64Fp5eFfFv0Tj0hKOvWCVw0CMYF3M6bPo7vMtYsY/YpUnV307h+AHnNodNvN8Dju7jB16VaUhV5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bidbvLFG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d18112b60so359468b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722386970; x=1722991770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHWVkWtAJLeMRIP1sg21d7QalxJky60cE7fLnsOK5JE=;
        b=bidbvLFGJRgwi1JSite67h5lnH/3YUsh9y/uFALLHaYH659w0Z6TGOo/pSsb/SWtW7
         NFQmR2J3yG/Kz+VTDuQvUFmH0xnDIJXd5ghXKKQyf7W/SqYrnBB3IGRi16V4soY+nxdO
         cK5AXI6L/DwZ+cROBVdD4x4ps7aAgJPoZeZmikKm4b4QYlEYZGiX/+JfeLsE6eOcZ/pM
         MwWN1W8TRLpIjYBX5CI8PlS6Am545896A1kXRuyoGPv1pKuxG5IDRHNqpD0PyXy48CeR
         v1QuVFg6mflBlXIiOjCnHSiq7oGjfNbP6gImunE7NnzVQ8sjZkJhFk3rhh2DBNKfs6v4
         vl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722386970; x=1722991770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHWVkWtAJLeMRIP1sg21d7QalxJky60cE7fLnsOK5JE=;
        b=BmSqj4l/4BWqBTuR4w+Lmn2FKH9SpLBCnLdq7SMhPTiC/Z7asJj2onK3O2DAa9gHlD
         Y4sE6NmL3bIkGgtwnbNPmiBiF4/THBGHwQhITz5aoHP0dDELDKGgcR1VHCv4kuLthgUd
         /af5YTPEzLSYYiIfVmmrGw1ZZVLVcYcHRtAh5VOZ4hX/iVyRptDVjoCqm9qjL4p/BOj6
         vqg8CvKFGzhbNgzJ7HygyxsAI8IhM9ZiKvE3wDt7mytruaDAt3IKh9NZX3BFVyan2NsH
         ISn4MpwSjj2F9PyU+Igi5zXy3xt3sUlCg9csRSZatDoh0B9rLjlSI7g+6xvfaRMR9SuR
         REoA==
X-Forwarded-Encrypted: i=1; AJvYcCUbH3URSiFHWP8c2BvOuHUXVdUWlnDCOeXOWFx5t5lGGIqz+UBp4z32ZxYhqPTPwEOtgFw1txj6yQvdcUacRHJklt1QC2aP++7bbcsJ
X-Gm-Message-State: AOJu0YxB1eQKYsVu2/eXWrgvA9VuVGwzyv447MZlRQnuhzGKS/MN1rFN
	bNog7K6aLBxEhCpCpc1b2Hi4fglEywkW4pRMlVR6Y/4OxRxNEdobkzWybQ==
X-Google-Smtp-Source: AGHT+IGxh+nOGAXTweiYx7CpvYGWrlgN26RD1qgQah0xJQsagfw5xIafFAFOhPQthqNbvggCal/Chw==
X-Received: by 2002:a05:6a00:2ea3:b0:70e:aa44:39df with SMTP id d2e1a72fcca58-70efe4074c5mr6088259b3a.1.1722386969877;
        Tue, 30 Jul 2024 17:49:29 -0700 (PDT)
Received: from localhost.localdomain (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8837edsm9344745b3a.148.2024.07.30.17.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:49:29 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] mm: zswap: fix global shrinker error handling logic
Date: Wed, 31 Jul 2024 00:49:10 +0000
Message-ID: <20240731004918.33182-3-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731004918.33182-1-flintglass@gmail.com>
References: <20240731004918.33182-1-flintglass@gmail.com>
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
 mm/zswap.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3c16a1192252..d46caa42ed4f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1287,10 +1287,10 @@ static struct shrinker *zswap_alloc_shrinker(void)
 
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
-	int nid, shrunk = 0;
+	int nid, shrunk = 0, scanned = 0;
 
 	if (!mem_cgroup_zswap_writeback_enabled(memcg))
-		return -EINVAL;
+		return -ENOENT;
 
 	/*
 	 * Skip zombies because their LRUs are reparented and we would be
@@ -1304,21 +1304,34 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 
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
 
 	/*
-	 * Global reclaim will select cgroup in a round-robin fashion.
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
@@ -1356,9 +1369,14 @@ static void shrink_worker(struct work_struct *w)
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
 
@@ -1366,8 +1384,16 @@ static void shrink_worker(struct work_struct *w)
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



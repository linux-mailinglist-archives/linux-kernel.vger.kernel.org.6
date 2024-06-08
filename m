Return-Path: <linux-kernel+bounces-207107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D50901272
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D9B282882
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C017B519;
	Sat,  8 Jun 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZhy3vjp"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7517B4E2;
	Sat,  8 Jun 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862012; cv=none; b=rkeDMC3Rpm6U/EsdoOnQutxdeEQL0liIP2H/E+uuc+hnR0Gw9FiONgsUB5l/doIkAGDYXXMntw9YWu0y/SuQQsD1U2U2HEpqAI8xD02mR9mfy5mYqOB8/Q2G8Q7ehMN4O8MnHCcY2G6vSm2JJA3feavtmbSc85giB4HtLDwgK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862012; c=relaxed/simple;
	bh=LT86OGMvkfYTxhefOYCi7bv3FCawM9/Lf+EF2JUYET4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6Kqobtk5Oc4jwVe/C3jpIdxdGu2PuReu6dCuWwGWwjCY8SiY/uxqm2R4GFbyo9z5QGGRrLO/wmAePnhwiouWSgJ+l/MjMwygm5hss6w7566zQd9vV9fLK0UWwVWFp5rkdFBXKbseg3GfgBncFRW+21J6aZpqLL1bJQ7/cq6CQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZhy3vjp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so2318339a12.1;
        Sat, 08 Jun 2024 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717862010; x=1718466810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SvMQN/q38nefiYyRiVmPEMKlu3DU/JjYA/6JNmM/yw=;
        b=fZhy3vjph008FoGRMbItexbVfs/7bjVZRUgXiBnnBSXiSiJoYu85GpqhRkfxyJB9We
         H2JSXGgE92hIgRqeG5pSvYRX5nx1DKkj46NckpQ1VuWPbSgeMSCHJcjc/OxaNpqAoEif
         OkqMG4O3DsTVB73JH2sNdSAJChmnfPWEyTRLucOeN0xSXkidHT8pQx5Nz7Kp1DYhPXva
         hxIzEq7vKaAqIQJO0/1XahK7XlNxPLtdauLN5Wp1MQ+jtIIPqUgNg30xqi3IvJ+8HlAN
         67VuAQIKcoxrMQFmpMtzwzEEZzWoItFHxAz6jkhammBX9fhPcFKXjWhAISWbpx420+qf
         RkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717862010; x=1718466810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SvMQN/q38nefiYyRiVmPEMKlu3DU/JjYA/6JNmM/yw=;
        b=ZhmRY7XPGSb4NmM3RqEwtKeEwhWxT8dIB7spVY6TDwnIe0IRbfj52/i0Gpf6db6ejB
         cOKjDAZXPB+vBeLJlRU05XuASVnvTz3tOtZw6iOMiF6VKTFFcG0DTMtuch1gKWBFfieV
         RYug05G57APgoUz3vh+YioiK1yXl48BCqRJzvtf5+4QR/1HMsS2yXUciqUKxle2fJa2g
         wbbFesvl/mYhdDn3thQIEkkjfFD4AHJWz8NzIZLrzCqSXcOOoar+yeju4vJ5e4piZSb1
         x724VHSe3dAdtMWJWTWsI/J87JRlE/ZnY8CoGL7bIz/eW7SXw7oc3OqkIjMuiN4pZxwM
         FjVg==
X-Forwarded-Encrypted: i=1; AJvYcCXxTcsCRC++U8OeUETOP4vNUW+odTYlZPVqFYkM/mADq2zJRdXFLrShqHw9MgM3F4ITMvMJYayOH21IiR6u4D3FXa0GRn35mXofIr/NaG5C+ad12imlMmOESdEIWupVVgMixWEnMmYQ
X-Gm-Message-State: AOJu0YxKgu/B73VkN/F1IrNp84Sv0U9qhfrOw4YXf/e362y6AUfs4Z+i
	7akKO8hf8PPSMIPVWiI/iz+I0D8wznkCnh4TmrKFQ9rD3NPkuwOMS98jJJ45KFI=
X-Google-Smtp-Source: AGHT+IEG/zCdA3pqdzro3I+Qtktx3F9FKRDjkiSf63QDjZuWrfOfFPcvyEL5zE403+r39r2Uach56A==
X-Received: by 2002:a05:6a20:12d6:b0:1b2:b220:2db6 with SMTP id adf61e73a8af0-1b2f969ed25mr5659976637.6.1717862009830;
        Sat, 08 Jun 2024 08:53:29 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4d9d8fsm4335209b3a.149.2024.06.08.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 08:53:29 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] mm: zswap: fix global shrinker error handling logic
Date: Sat,  8 Jun 2024 15:53:09 +0000
Message-ID: <20240608155316.451600-3-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608155316.451600-1-flintglass@gmail.com>
References: <20240608155316.451600-1-flintglass@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes zswap global shrinker that did not shrink zpool as
expected.

The issue it addresses is that `shrink_worker()` did not distinguish
between unexpected errors and expected error codes that should be
skipped, such as when there is no stored page in a memcg. This led to
the shrinking process being aborted on the expected error codes.

The shrinker should ignore these cases and skip to the next memcg.
However,  skipping all memcgs presents another problem. To address this,
this patch tracks progress while walking the memcg tree and checks for
progress once the tree walk is completed.

To handle the empty memcg case, the helper function `shrink_memcg()` is
modified to check if the memcg is empty and then return -ENOENT.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index d720a42069b6..1a90f434f247 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1393,7 +1393,7 @@ static struct shrinker *zswap_alloc_shrinker(void)
 
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
-	int nid, shrunk = 0;
+	int nid, shrunk = 0, stored = 0;
 
 	if (!mem_cgroup_zswap_writeback_enabled(memcg))
 		return -EINVAL;
@@ -1408,9 +1408,16 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
 		unsigned long nr_to_walk = 1;
 
+		if (!list_lru_count_one(&zswap_list_lru, nid, memcg))
+			continue;
+		++stored;
 		shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
 					    &shrink_memcg_cb, NULL, &nr_to_walk);
 	}
+
+	if (!stored)
+		return -ENOENT;
+
 	return shrunk ? 0 : -EAGAIN;
 }
 
@@ -1418,12 +1425,18 @@ static void shrink_worker(struct work_struct *w)
 {
 	struct mem_cgroup *memcg = NULL;
 	struct mem_cgroup *next_memcg;
-	int ret, failures = 0;
+	int ret, failures = 0, progress;
 	unsigned long thr;
 
 	/* Reclaim down to the accept threshold */
 	thr = zswap_accept_thr_pages();
 
+	/*
+	 * We might start from the last memcg.
+	 * That is not a failure.
+	 */
+	progress = 1;
+
 	/* global reclaim will select cgroup in a round-robin fashion.
 	 *
 	 * We save iteration cursor memcg into zswap_next_shrink,
@@ -1461,9 +1474,12 @@ static void shrink_worker(struct work_struct *w)
 		 */
 		if (!memcg) {
 			spin_unlock(&zswap_shrink_lock);
-			if (++failures == MAX_RECLAIM_RETRIES)
+
+			/* tree walk completed but no progress */
+			if (!progress && ++failures == MAX_RECLAIM_RETRIES)
 				break;
 
+			progress = 0;
 			goto resched;
 		}
 
@@ -1493,10 +1509,15 @@ static void shrink_worker(struct work_struct *w)
 		/* drop the extra reference */
 		mem_cgroup_put(memcg);
 
-		if (ret == -EINVAL)
-			break;
+		/* not a writeback candidate memcg */
+		if (ret == -EINVAL || ret == -ENOENT)
+			continue;
+
 		if (ret && ++failures == MAX_RECLAIM_RETRIES)
 			break;
+
+		++progress;
+		/* reschedule as we performed some IO */
 resched:
 		cond_resched();
 	} while (zswap_total_pages() > thr);
-- 
2.43.0



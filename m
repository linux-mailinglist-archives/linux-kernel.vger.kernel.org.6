Return-Path: <linux-kernel+bounces-257788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A31937EEE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268E4B21A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9F175A1;
	Sat, 20 Jul 2024 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmq4mDG2"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EC12E61
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721450502; cv=none; b=Q9sYxdVHUXs+xl7AubKyp9neodDs2r15fBWFtyMkPMg9hXNLzdj4+iBP4ziOAz0KEX6S6WkFtqujDPXQV4WSrHdetq76d1uqMTRL319JdY28TqTdvI1UORVb493tlzda1SuMAFsUeB/c2hdE98pqqIYzsoMYb4lBSPHPGJo6Zsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721450502; c=relaxed/simple;
	bh=sA3RiZ1oJA7H4jOOExLeQTxHrL4N4UV7cJ2ZeT0u6E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjC2FrTsSyPixu2z9pkCZ0fwe1T/KAabGLpjVfjRAoXc/4jCB2RPjeDTGp/9voV+igWoKweOQhOe+bxUekc60cnmCMy3UVhFJIkDyBIexrPGS2PXOrAEhjShJD2bb+psW6EB+v1fSEk4ip9UXhzl2OR7/dlKTMvGOlcCTmAKk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmq4mDG2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af22a9c19so1182392b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721450500; x=1722055300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVw0vATACj76JfvzKQY4usxRkR0Oycm1bE+vKC2rk9g=;
        b=lmq4mDG2bSV1sek1BGh+GwgSv/G3ulo5TBkX4P+b5OPO6Me+iwOzBbZCcSYfoAdC/H
         vZpHSPPBDxOdonxEsMi7G64QylCddYDgUglXIVtTuYmhwiqUG0swFlayENnpqJYYSpAl
         DnXeElytmrb2FX5X5QX0ybdlbzeXiQ7JHVOuWNp3+jrjAgYj7CMjVmdt4CB702+X6H97
         UyU4E3nQjmQeTkf9On9IKa2l5bpASvxdVhYi9qUQMsEvl9oP/s7bHFehKOToqAkov3Wf
         qcBNBXyQ9IVe5SBqjq4jtBtLgf+ckEF7IOrwMs0XpPY02aFmy5Jq+xUVBJ89X/rGohNo
         F4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721450500; x=1722055300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVw0vATACj76JfvzKQY4usxRkR0Oycm1bE+vKC2rk9g=;
        b=Xry+oR8oulLyrCysaEnvEhSCF291K0W91NTrft4ERxWbdByZ+9BAkAqlESyUAsLa4v
         PsprYCD4cwhmjW2wX+DJvCnLLKfC82VjXzY+fxoDAfGSMpQDNsMOG/+gY6ZvGYZgCQDk
         LqkZcd5/d+cZ7C2mA6yU//8sYHl+t3eirK7wOVEGNwh8r+vKnSuBNQK5ltQTgUr2U2hb
         fPtZsi1IqlND+TJgeARKccx2/5ME0eGog/43BihN+5R4M5ejH1796Ge39joPsh0o1BZc
         5uJ9SwaAE8Cm+QA5c6AzftlDIxbMO2xc4bLqt0Rvsy8VdtheyM3mZy/px1o6B/UPvyFM
         J2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUfUybLTUKNkEGTJs7h2dxipM5gPow7gZbhevxzGtBH97x+CPdGeUBnhNVGu8YncGim1f4juQX+md7TRkHyY7/39O62P9YF6iEPVabg
X-Gm-Message-State: AOJu0YxZJXj9/BZVNcMNIozuaLm3WKxGjgM2skuXVVaKBEw3bHL+H8MB
	ukuDzzgnxPL3XzTftzfJyGR/w0czDlt36mODDMdSrkSuJ7kfM8T6
X-Google-Smtp-Source: AGHT+IEBS8Y5Ko/VqlXvrI1x+MdtVUYash+4xiAPzeysJsdDGDKxK2XNTIGZDknK0HVwrl0eHrrHzA==
X-Received: by 2002:a05:6a21:710a:b0:1c2:92ad:3331 with SMTP id adf61e73a8af0-1c4285b7637mr683649637.2.1721450500245;
        Fri, 19 Jul 2024 21:41:40 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f315c11sm13023465ad.125.2024.07.19.21.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 21:41:39 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm: zswap: fix global shrinker error handling logic
Date: Sat, 20 Jul 2024 04:41:25 +0000
Message-ID: <20240720044127.508042-3-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720044127.508042-1-flintglass@gmail.com>
References: <20240720044127.508042-1-flintglass@gmail.com>
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
 mm/zswap.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6528668c9af3..053d5be81d9a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1310,10 +1310,10 @@ static struct shrinker *zswap_alloc_shrinker(void)
 
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
-	int nid, shrunk = 0;
+	int nid, shrunk = 0, scanned = 0;
 
 	if (!mem_cgroup_zswap_writeback_enabled(memcg))
-		return -EINVAL;
+		return -ENOENT;
 
 	/*
 	 * Skip zombies because their LRUs are reparented and we would be
@@ -1327,14 +1327,19 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 
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
+	int ret, failures = 0, progress = 0;
 	unsigned long thr;
 
 	/* Reclaim down to the accept threshold */
@@ -1379,9 +1384,12 @@ static void shrink_worker(struct work_struct *w)
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
 
@@ -1396,10 +1404,13 @@ static void shrink_worker(struct work_struct *w)
 		/* drop the extra reference */
 		mem_cgroup_put(memcg);
 
-		if (ret == -EINVAL)
-			break;
+		if (ret == -ENOENT)
+			continue;
+
 		if (ret && ++failures == MAX_RECLAIM_RETRIES)
 			break;
+
+		++progress;
 resched:
 		cond_resched();
 	} while (zswap_total_pages() > thr);
-- 
2.43.0



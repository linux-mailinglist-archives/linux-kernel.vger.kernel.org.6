Return-Path: <linux-kernel+bounces-242998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1159C929009
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CC11C215A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026215E89;
	Sat,  6 Jul 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjnTIp3y"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111AE556;
	Sat,  6 Jul 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232742; cv=none; b=S6ZcLZ9hLV1xcg6+1/WDkJO17xD09gsEjedQd1H0jNRoq1dV5Xw6XJY3sk4aYOGSfFxvF3RXxLH0RoxUtfXA+JucteECF7/s96aN1VDRQLFDRpB5hzht1ozGExSg8MFKgQJWzqC/VOTPY74dBPHl8mqgVhx/+HH05wJytrO7thA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232742; c=relaxed/simple;
	bh=htQvuYdHzyfl1t7p3JhCzVIzFtwXuyaFt499DRvp5Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiEuzWRnhwaTtqHOtD27rk3Ae2uciIyfY1bLP5MbxBWVWIZcebs/qvR2OehElhyV2Y+649BTQgON1Xx/ZkdIW8b0sEeY6RZ6s0ijeRawfTe8wctv+G08xwHYYpOBO+vC6FUDvQJ0PWb2bGyncjiI8XdpyjITv+H1eqh9EgeeTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjnTIp3y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b12572bd8so716321b3a.2;
        Fri, 05 Jul 2024 19:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720232740; x=1720837540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRlR8/y+l8PvWrquEyoi8ASknDqVdftiNelGYNv1VVY=;
        b=bjnTIp3yhwh4VRZRjZPXjKWpNzPlVr7vpuQLwEfdkFTVWDlz4NdjujpADkIRpwKvUv
         EZVKeXpg5IDN60kCymCyvlZueepE+5au/J9QHMc7Hv3TWWZS60m42pYe537ojUF9Jk3Y
         9aFC1TCnjnwPD2XnSW06VEMEj9sn2A1R7qQ6VRiYKNAKyuau3VyNcN0DxYljdZ76bsh4
         bnNqtK8EtE9Tx4YsPclBUf3WBuz+Cxe62DqJsUlgtM1CYky11nCBf1L8sRihAyd4A12H
         s5Ilk3oYeouHHGV0plujnKXNqq3e34Ct2SnqS9DYiLm3mAPXyDsrBWiAIOrsPUxM5rBa
         9v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720232740; x=1720837540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRlR8/y+l8PvWrquEyoi8ASknDqVdftiNelGYNv1VVY=;
        b=P3LyY6KNr6aRnx+6mqNHvSkYOwqawXCgFgXdkcMFbBKsipv7f3VAOj3hlRKsi7zcno
         yu/8KL82UdMGLqSXFBA0DbMjE6gaCDCDfpBvood4No+63+/tQ37l3I3WCteYfSEFv5UK
         xxgaLQsUDj5gi2HIiAHnl4legC6OUTq/LYiuzfjLjWCN1b44kPNKhm0qZ8blJdA65YDN
         Co4xA+S+ZYluKC0XPLFsTZsJYUAledOS7mo8znIPonB/a3AZkMFtulqLbBJ26FMkDyPP
         xxwdinukQaJQuND68sBkp8Lv5PHr4khg1AQT96Ovqv7STN+FX2S79Nhvw4DMOwjkM8dF
         zJ4A==
X-Forwarded-Encrypted: i=1; AJvYcCVb16HpyiEVs+dJk0wz0Nc+EHhCOp59b6AWs1blvkkDGOr3anKBsuV/qOl3toY6H3GT2Me/bkaiCASYmFNflXZsKNrSk0C+MXcVwq4826UomAipBxlCfdAXgkUqPQjHMX7L7pjBFjsP
X-Gm-Message-State: AOJu0YybGyQKNNg93GuXUKSHuYv8U1sZfFKT6N0UUj2eC7fwIT4kenEB
	WfXlLQZVrRzN/5GjLGuUd7ZwFkKyI0Y+C3xZex3HmXxx89WmuBrQ
X-Google-Smtp-Source: AGHT+IG56GKxKgPYasJZgCXiIS0yNg+4e9MZ/x8H5QnSjo5MAOd2N3kS6crvl3b3Vs1PQwvmsl4Zow==
X-Received: by 2002:a05:6a00:b51:b0:704:2d64:747 with SMTP id d2e1a72fcca58-70b00930ae3mr7055265b3a.7.1720232739761;
        Fri, 05 Jul 2024 19:25:39 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15417a7bsm971274b3a.205.2024.07.05.19.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 19:25:39 -0700 (PDT)
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
Subject: [PATCH v2 2/6] mm: zswap: fix global shrinker error handling logic
Date: Sat,  6 Jul 2024 02:25:18 +0000
Message-ID: <20240706022523.1104080-3-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706022523.1104080-1-flintglass@gmail.com>
References: <20240706022523.1104080-1-flintglass@gmail.com>
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
 mm/zswap.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 29944d8145af..f092932e652b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1317,10 +1317,10 @@ static struct shrinker *zswap_alloc_shrinker(void)
 
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
-	int nid, shrunk = 0;
+	int nid, shrunk = 0, scanned = 0;
 
 	if (!mem_cgroup_zswap_writeback_enabled(memcg))
-		return -EINVAL;
+		return -ENOENT;
 
 	/*
 	 * Skip zombies because their LRUs are reparented and we would be
@@ -1334,19 +1334,30 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 
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
@@ -1390,9 +1401,12 @@ static void shrink_worker(struct work_struct *w)
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
 
@@ -1407,10 +1421,15 @@ static void shrink_worker(struct work_struct *w)
 		/* drop the extra reference */
 		mem_cgroup_put(memcg);
 
-		if (ret == -EINVAL)
-			break;
+		/* not a writeback candidate memcg */
+		if (ret == -ENOENT)
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



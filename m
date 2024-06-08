Return-Path: <linux-kernel+bounces-207106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C201901270
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A999D1F21B35
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2741617B4F2;
	Sat,  8 Jun 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STLc3mJ0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41E178373;
	Sat,  8 Jun 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862010; cv=none; b=oTh7gJbZcnIPVlIATpEpkRG6JaIsNnWfeDDPvfZcBxLG1zNHerTUt/j0Jr4FrP6K8JZqXvQdSDbevGKl8Cn4eGextosBuv+p/3qFOc5aoY2Tq/1MX3wvEXBsZXRlbrf5FI5d1hT/fXaHmNwmdpnh5GcTqbhxLdHAb+rOUXZlGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862010; c=relaxed/simple;
	bh=F9ls/zaY0aWwRmQsgCEGvjaAZXp6qmxbCVIzrVc4nqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Shfwx1yALdz7i64fQLayx9zGUDAUHklj07ytlMvZC6kBXGhLanFy3buCFonRWk2mj07Dgf0xFN8ZAdwJ5m6nlGyQcUuFmxxaVcrROQ6tnM+nOwxkK1o6DeIV2VHmrKqRuVLBEOws0WSV54o1gjQH4UsTS8NzQrF64OUYoUca2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STLc3mJ0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7041082a80aso1274507b3a.1;
        Sat, 08 Jun 2024 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717862008; x=1718466808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZHxiUjeMqD6vZkOfwjSbyKs/eS2zlbVa8rN6xjbDxU=;
        b=STLc3mJ0NF05jGRkzR6o8v07T/ult0GsR5sUeAsa7/jodoULdOZ2s/I6gILCrvVUTn
         3vTFonZu5ZRM4HhSW61EF3aY6lCw2kErips7ENWJQr1FzRP+zdwv5aoDmYU5XzMdNBY9
         nnv5IIo+bim0PgUF3X0amX8kqsOff+mEnMhnPlafsq0XcApRIgIzRhnvStq/ig+cJYVd
         6RSls5oUV0twR9mLuUlc7zSEdo9Jgl/dX32oouSahzwKCT7ykblZ5qZG5S7iPd4fAori
         9YZxu2MvXbrNF+8nzazOmVuCXMxVBiiXm568o7twsJTw6OVHMV0SKs2Yc8kZUdJ0fTwd
         P4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717862008; x=1718466808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZHxiUjeMqD6vZkOfwjSbyKs/eS2zlbVa8rN6xjbDxU=;
        b=OaQs0SfEBFJIXpoth1Fhx9bT1B16PRtuLFoiqLnq5ESClxBkvTK7gi3YFMc5USPMCX
         Cj/lM0UjasJD2IiZwUs8LZuTbgMtdYoOJqTwmJfLwW4gluLT89JrNC6I909xcnm03fVP
         2cwJnbtnJGZMrKxcNXSx74QHb01B7wHa0pzg+XK1OI+NFs28mESGmrt73rAZpIhovoEx
         NXDsjGGuBL0a8Iv23Z+eESzKg/3vuIcK/L7UD9n+epfTHlt/CSLMfzvNAFokAOTS76xh
         Av89BGHwvlde7Gefgcmm14s9uMhoQXy9i8qD6FGAlFJ9QXNGORaYSFGbxzcgSyVX+TDt
         CXng==
X-Forwarded-Encrypted: i=1; AJvYcCXL4w6yHnqvm3xnklL2prW+/gBIK9mxB+6kV0TttJjDldM2HOzrMsNYcVpNaJuphe1nM56DaKNEYFxq95UN+xtRoVHyfhWTPDl+qgw6ty+7UXh1xyl5U7y25U0cx22maHaZHSJeg4vl
X-Gm-Message-State: AOJu0YwgRlMCzIjJB8ZcHCnX6m1kiOlYvIfzcGVElcroeXXCxFX+Vtcw
	DZImycgCR4fMIxrNqIwsChEMQVk1TVfXYQKLWQoLB+2CKVDBszh5
X-Google-Smtp-Source: AGHT+IGe4Ii+KwF0gPByGAcULNxz091Evf59hb1FQhfH6o9f5mRo+uFoQZvIIBQ3ItmZA7vqYSzMtQ==
X-Received: by 2002:a05:6a21:32a3:b0:1b5:cf9c:2936 with SMTP id adf61e73a8af0-1b5cf9c2b30mr1003625637.39.1717862007919;
        Sat, 08 Jun 2024 08:53:27 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4d9d8fsm4335209b3a.149.2024.06.08.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 08:53:27 -0700 (PDT)
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
Subject: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
Date: Sat,  8 Jun 2024 15:53:08 +0000
Message-ID: <20240608155316.451600-2-flintglass@gmail.com>
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

This patch fixes an issue where the zswap global shrinker stopped
iterating through the memcg tree.

The problem was that `shrink_worker()` would stop iterating when a memcg
was being offlined and restart from the tree root.  Now, it properly
handles the offlining memcg and continues shrinking with the next memcg.

This patch also modified handing of the lock for offlined memcg cleaner
to adapt the change in the iteration, and avoid negligibly rare skipping
of a memcg from shrink iteration.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 87 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 80c634acb8d5..d720a42069b6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -827,12 +827,27 @@ void zswap_folio_swapin(struct folio *folio)
 	}
 }
 
+/*
+ * This function should be called when a memcg is being offlined.
+ *
+ * Since the global shrinker shrink_worker() may hold a reference
+ * of the memcg, we must check and release the reference in
+ * zswap_next_shrink.
+ *
+ * shrink_worker() must handle the case where this function releases
+ * the reference of memcg being shrunk.
+ */
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 {
 	/* lock out zswap shrinker walking memcg tree */
 	spin_lock(&zswap_shrink_lock);
-	if (zswap_next_shrink == memcg)
-		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
+
+	if (READ_ONCE(zswap_next_shrink) == memcg) {
+		/* put back reference and advance the cursor */
+		memcg = mem_cgroup_iter(NULL, memcg, NULL);
+		WRITE_ONCE(zswap_next_shrink, memcg);
+	}
+
 	spin_unlock(&zswap_shrink_lock);
 }
 
@@ -1401,25 +1416,44 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 
 static void shrink_worker(struct work_struct *w)
 {
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg = NULL;
+	struct mem_cgroup *next_memcg;
 	int ret, failures = 0;
 	unsigned long thr;
 
 	/* Reclaim down to the accept threshold */
 	thr = zswap_accept_thr_pages();
 
-	/* global reclaim will select cgroup in a round-robin fashion. */
+	/* global reclaim will select cgroup in a round-robin fashion.
+	 *
+	 * We save iteration cursor memcg into zswap_next_shrink,
+	 * which can be modified by the offline memcg cleaner
+	 * zswap_memcg_offline_cleanup().
+	 *
+	 * Since the offline cleaner is called only once, we cannot abandone
+	 * offline memcg reference in zswap_next_shrink.
+	 * We can rely on the cleaner only if we get online memcg under lock.
+	 * If we get offline memcg, we cannot determine the cleaner will be
+	 * called later. We must put it before returning from this function.
+	 */
 	do {
+iternext:
 		spin_lock(&zswap_shrink_lock);
-		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
-		memcg = zswap_next_shrink;
+		next_memcg = READ_ONCE(zswap_next_shrink);
+
+		if (memcg != next_memcg) {
+			/*
+			 * Ours was released by offlining.
+			 * Use the saved memcg reference.
+			 */
+			memcg = next_memcg;
+		} else {
+			/* advance cursor */
+			memcg = mem_cgroup_iter(NULL, memcg, NULL);
+			WRITE_ONCE(zswap_next_shrink, memcg);
+		}
 
 		/*
-		 * We need to retry if we have gone through a full round trip, or if we
-		 * got an offline memcg (or else we risk undoing the effect of the
-		 * zswap memcg offlining cleanup callback). This is not catastrophic
-		 * per se, but it will keep the now offlined memcg hostage for a while.
-		 *
 		 * Note that if we got an online memcg, we will keep the extra
 		 * reference in case the original reference obtained by mem_cgroup_iter
 		 * is dropped by the zswap memcg offlining callback, ensuring that the
@@ -1434,16 +1468,25 @@ static void shrink_worker(struct work_struct *w)
 		}
 
 		if (!mem_cgroup_tryget_online(memcg)) {
-			/* drop the reference from mem_cgroup_iter() */
-			mem_cgroup_iter_break(NULL, memcg);
-			zswap_next_shrink = NULL;
+			/*
+			 * It is an offline memcg which we cannot shrink
+			 * until its pages are reparented.
+			 *
+			 * Since we cannot determine if the offline cleaner has
+			 * been already called or not, the offline memcg must be
+			 * put back unconditonally. We cannot abort the loop while
+			 * zswap_next_shrink has a reference of this offline memcg.
+			 */
 			spin_unlock(&zswap_shrink_lock);
-
-			if (++failures == MAX_RECLAIM_RETRIES)
-				break;
-
-			goto resched;
+			goto iternext;
 		}
+		/*
+		 * We got an extra memcg reference before unlocking.
+		 * The cleaner cannot free it using zswap_next_shrink.
+		 *
+		 * Our memcg can be offlined after we get online memcg here.
+		 * In this case, the cleaner is waiting the lock just behind us.
+		 */
 		spin_unlock(&zswap_shrink_lock);
 
 		ret = shrink_memcg(memcg);
@@ -1457,6 +1500,12 @@ static void shrink_worker(struct work_struct *w)
 resched:
 		cond_resched();
 	} while (zswap_total_pages() > thr);
+
+	/*
+	 * We can still hold the original memcg reference.
+	 * The reference is stored in zswap_next_shrink, and then reused
+	 * by the next shrink_worker().
+	 */
 }
 
 /*********************************
-- 
2.43.0



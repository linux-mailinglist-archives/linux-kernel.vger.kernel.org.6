Return-Path: <linux-kernel+bounces-242997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E702929007
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AA0284520
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B7E56A;
	Sat,  6 Jul 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HflXfhDT"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DEBE71;
	Sat,  6 Jul 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232739; cv=none; b=lZ2q8XwLUdY8HlXaF0XDUATgyU1Fg1umv8NyxcuPv9MnEkV50mk4a5rVGfKAsIVmHDY/hWeb5LAu7JRg4owRIz7n1O8Tft1sEnK1mQbY5JnsFeq3aozLPVCae2UWQwTp2KtmrkOu/mWPkEXpdZLjm7D0q178179zuYT2oCcU/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232739; c=relaxed/simple;
	bh=Q7txvHo6ye/cyUQbnSWQOZ8G0fkP6YGg1pRLu+BJp0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZHzCszbTZj9bN+6SdrtazuEqiCBDlZI4nHsZAofIlasS68bAsv3z1vjmDtKpHINTfGDDDsx3uxxLLhdw4L8xibOO5fuI3CO5ktTlU+tC1x0m+9LuC1bHylafs4mwm+yLY1q6BalbHdT+uTJ7GAwdpL1zH1IIP+Om/vf3YvRWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HflXfhDT; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48fde151f25so826982137.1;
        Fri, 05 Jul 2024 19:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720232737; x=1720837537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbIMyqv9tB/GsH5Iw1jm24no2JCeDavbkHBCIGxkGw8=;
        b=HflXfhDTXeV1mJgr/hkohtwvIlk7Dl5+Mnh+9pNLCuzycXANVrC0uBUWXUu/24yU23
         bI7g/4fX5AHuLIJ5t3CE9sQlILiCwdKPblTUzK95Es80D1HDkFxye5aQm757UYdRL0p7
         ZEcQZbai8k8A+25dIxHlf3+GwZF9E3scjBeYfBNwQEPzlN98h74m0vBmM4ug20SiAkkQ
         /yVTw0Ts70voAHxa4qj2z3ed3LEpYYOlsddqAwctW+3p4MJK39qHhJIFMHAxULRvK6i3
         oWmPUd59w6kjXtAZGNebjJXhUP0mAvMqqtsN4Rwb/hEfojndbBD0nTgzxuZyGj5ZuBli
         iL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720232737; x=1720837537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbIMyqv9tB/GsH5Iw1jm24no2JCeDavbkHBCIGxkGw8=;
        b=mNQz0INT6DWjo426bulryHb3oIup5me0l2yYmtTRoYd+X83du8VLu7U3uPdB6RLdcq
         iV6+DsR5ONZBbKw/TyuHRFjPy++gwJLn8QYXoPF5yH3pwKY8mZmCZLwTxEycv1YJkqqD
         EDzZY/6PnCnSf/aJUOB6HqCUjWjLb3vZiiJhC0HktGNnGFtPfqQaEfgu3pzRVBo5jZhx
         uT2g7z8Mmjw3sbPawgPyH1FdA4nLdsBqbywCfYgCLi49RkSgc9hhKfC0FnYIuia9vCLF
         +/VZt0ighnCREdlFbLFyo6Kz+s7uFKOa/ejxsGXmPTGkJOBlxhmYlgAE6XjB5aUfNmOR
         SEBw==
X-Forwarded-Encrypted: i=1; AJvYcCXGT0D329JFQL3tBkqALqg7h8whgexn5SIosb9cqfSHCgRiTN3v9MxgQCnyopERukosXVsW+/plhQ8dtqa9NqXrKv41AjaG7OWxpmtbbOq6c4TYdTwfRVohZGKjpddHzkxX4RG8cKPc
X-Gm-Message-State: AOJu0Yz5bbgg5YCHUR+XleRagbGw2hW758PimILi3GNDjbwP+S95A/+B
	wfkrkuI/3fTEs1R2/KK4Cvh1gWBpmiR62oYTyNqDhOIh8IH1Xyz3
X-Google-Smtp-Source: AGHT+IE3TI13f2MUhqpsXQi2pAAWlKDBboY+QlYd3pKVMH50xN1fnf49vI6E9VU4VCM40PvN8Tuofg==
X-Received: by 2002:a67:e98a:0:b0:48f:eda3:2f80 with SMTP id ada2fe7eead31-48fee6255c2mr7281458137.5.1720232736977;
        Fri, 05 Jul 2024 19:25:36 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15417a7bsm971274b3a.205.2024.07.05.19.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 19:25:36 -0700 (PDT)
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
Subject: [PATCH v2 1/6] mm: zswap: fix global shrinker memcg iteration
Date: Sat,  6 Jul 2024 02:25:17 +0000
Message-ID: <20240706022523.1104080-2-flintglass@gmail.com>
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

This patch fixes an issue where the zswap global shrinker stopped
iterating through the memcg tree.

The problem was that shrink_worker() would stop iterating when a memcg
was being offlined and restart from the tree root.  Now, it properly
handles the offlie memcg and continues shrinking with the next memcg.

Note that, to avoid a refcount leak of offline memcg encountered during
the memcg tree walking, shrink_worker() must continue iterating to find
the next online memcg.

The following minor issues in the existing code are also resolved by the
change in the iteration logic:

- A rare temporary refcount leak in the offline memcg cleaner, where the
  next memcg of the offlined memcg is also offline.  The leaked memcg
  cannot be freed until the next shrink_worker() releases the reference.

- One memcg was skipped from shrinking when the offline memcg cleaner
  advanced the cursor of memcg tree. It is addressed by a flag to
  indicate that the cursor has already been advanced.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 94 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 21 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a50e2986cd2f..29944d8145af 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -171,6 +171,7 @@ static struct list_lru zswap_list_lru;
 /* The lock protects zswap_next_shrink updates. */
 static DEFINE_SPINLOCK(zswap_shrink_lock);
 static struct mem_cgroup *zswap_next_shrink;
+static bool zswap_next_shrink_changed;
 static struct work_struct zswap_shrink_work;
 static struct shrinker *zswap_shrinker;
 
@@ -775,12 +776,39 @@ void zswap_folio_swapin(struct folio *folio)
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
+	if (zswap_next_shrink == memcg) {
+		/*
+		 * We advances the cursor to put back the offlined memcg.
+		 * shrink_worker() should not advance the cursor again.
+		 */
+		zswap_next_shrink_changed = true;
+
+		do {
+			zswap_next_shrink = mem_cgroup_iter(NULL,
+					zswap_next_shrink, NULL);
+		} while (zswap_next_shrink &&
+				!mem_cgroup_online(zswap_next_shrink));
+		/*
+		 * We verified the next memcg is online.  Even if the next
+		 * memcg is being offlined here, another cleaner must be
+		 * waiting for our lock.  We can leave the online memcg
+		 * reference.
+		 */
+	}
 	spin_unlock(&zswap_shrink_lock);
 }
 
@@ -1319,18 +1347,42 @@ static void shrink_worker(struct work_struct *w)
 	/* Reclaim down to the accept threshold */
 	thr = zswap_accept_thr_pages();
 
-	/* global reclaim will select cgroup in a round-robin fashion. */
+	/* global reclaim will select cgroup in a round-robin fashion.
+	 *
+	 * We save iteration cursor memcg into zswap_next_shrink,
+	 * which can be modified by the offline memcg cleaner
+	 * zswap_memcg_offline_cleanup().
+	 *
+	 * Since the offline cleaner is called only once, we cannot leave an
+	 * offline memcg reference in zswap_next_shrink.
+	 * We can rely on the cleaner only if we get online memcg under lock.
+	 *
+	 * If we get an offline memcg, we cannot determine the cleaner has
+	 * already been called or will be called later. We must put back the
+	 * reference before returning from this function. Otherwise, the
+	 * offline memcg left in zswap_next_shrink will hold the reference
+	 * until the next run of shrink_worker().
+	 */
 	do {
 		spin_lock(&zswap_shrink_lock);
-		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
-		memcg = zswap_next_shrink;
 
 		/*
-		 * We need to retry if we have gone through a full round trip, or if we
-		 * got an offline memcg (or else we risk undoing the effect of the
-		 * zswap memcg offlining cleanup callback). This is not catastrophic
-		 * per se, but it will keep the now offlined memcg hostage for a while.
-		 *
+		 * Start shrinking from the next memcg after zswap_next_shrink.
+		 * To not skip a memcg, do not advance the cursor when it has
+		 * already been advanced by the offline cleaner.
+		 */
+		do {
+			if (zswap_next_shrink_changed) {
+				/* cleaner advanced the cursor */
+				zswap_next_shrink_changed = false;
+			} else {
+				zswap_next_shrink = mem_cgroup_iter(NULL,
+						zswap_next_shrink, NULL);
+			}
+			memcg = zswap_next_shrink;
+		} while (memcg && !mem_cgroup_tryget_online(memcg));
+
+		/*
 		 * Note that if we got an online memcg, we will keep the extra
 		 * reference in case the original reference obtained by mem_cgroup_iter
 		 * is dropped by the zswap memcg offlining callback, ensuring that the
@@ -1344,17 +1396,11 @@ static void shrink_worker(struct work_struct *w)
 			goto resched;
 		}
 
-		if (!mem_cgroup_tryget_online(memcg)) {
-			/* drop the reference from mem_cgroup_iter() */
-			mem_cgroup_iter_break(NULL, memcg);
-			zswap_next_shrink = NULL;
-			spin_unlock(&zswap_shrink_lock);
-
-			if (++failures == MAX_RECLAIM_RETRIES)
-				break;
-
-			goto resched;
-		}
+		/*
+		 * We verified the memcg is online and got an extra memcg
+		 * reference.  Our memcg might be offlined concurrently but the
+		 * respective offline cleaner must be waiting for our lock.
+		 */
 		spin_unlock(&zswap_shrink_lock);
 
 		ret = shrink_memcg(memcg);
@@ -1368,6 +1414,12 @@ static void shrink_worker(struct work_struct *w)
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



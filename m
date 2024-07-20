Return-Path: <linux-kernel+bounces-257787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AD937EED
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA7281EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232012E63;
	Sat, 20 Jul 2024 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCD8SJiV"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078FD50F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721450500; cv=none; b=bMz7hNVmOz2CL6ukVxDi7SjdquECsbqs4Hz4Mk7NAhXftD2Gle8hAKj04QCZSmo5IJSHypHXyg4FA3pLnp2IiNXm8laRaL+Yn87xXeHgugY1e0jH9y7burIaPWa+ViyJNOie95JtkbpDguEBPH2dBIl4ih5vMJSfF17rR+XIXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721450500; c=relaxed/simple;
	bh=UaIs/aK6bf4wokEFWlwvfAn9h/tzBl6ekF80mPAEMXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4BR5mTvpmMAHxt3vCuNX3cWhVWgkzgkes23Et/Oz/3RBCYdn8WZ01ZrRzzxeQTp3X8ie5bZvMGCDjW8LeVskXIAMrmG7r2lewdEYPOOUM7bkZAhLOpE4+QZCfQe0V7dgRiI/p49NVYEDH+2CsxB3YNf11ZrAVOp7hiRht62kws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCD8SJiV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd78c165eeso2328685ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721450498; x=1722055298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he3tUu8hce94zy7aE7UWp0ZYRUcHVjdNDmthPwwFIA0=;
        b=DCD8SJiVv1RUr25Cs0zQ+jFQfDgOsQoCjr83S4ByWzPmpx2UcS9fOGW5In7LORzUwT
         5ioRYRDpTWsbjGYljQd0Hc/OlO71al1GYi7aMky2dXmSQC3PHxPsWxk3xn6cp80kEigQ
         npJNaay4uGO8CHgd941i4LTV6CnzL+zdQBwAugJicmWT0ZbfT1OnU2c12+KbIVywU+R4
         /Re9c0CPKaCXnjMqyZ5QTWEPbbS6HwiuABs9hZdqfu4LnblNV9qbzJKGCCJsOTK+eiBy
         A2yOBBdSB9jY/o/knE27Cd45reuenc0ikJRt5yG56btOkY7Nqbr6u4YGo0YdPgo0V4Km
         Y7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721450498; x=1722055298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he3tUu8hce94zy7aE7UWp0ZYRUcHVjdNDmthPwwFIA0=;
        b=TzuOaOKy5nE/UpGVpyCwoawxlv7K8r29eN0pTIiQ5eJG9+pfZpMlffspylvy99c04D
         n6B0BLcIK/dtdjqLYKrThihSvPlMepd8pp2xh0jEVk5a+7AfyB3DM8zfcESiZ35bud3o
         UwICOZBwrh2KqbfZBz8iTO6EJCBIgOij55sNrhegdTVYeYZxtiEnpVaxV2vP1h5X/UHh
         axQ3KE+jKoLxwlVJFAQ2SEewbTJ+woSNNeTOqPDMd+0dQR7lAFnFuRzDUPg1QaIlaEOJ
         MOic4MU+Q/rYXl2evka1VwZPcoXYhptpIspymSQ/2gY/RwsZh/ORy0F75aYJAKShs7zH
         ULOg==
X-Forwarded-Encrypted: i=1; AJvYcCVMKRlTUb6XT+lLWE4mzOKZ2NfDmO27J1F/MehKpKHkWifhoyw6P8rw7WMiKIdtvNTES22s1bq7ePLCMN9k8fpc/WusVso795Pm8rIX
X-Gm-Message-State: AOJu0Yw2iRzGi94K6/IueUS2cUl2VihyH/GFAFNlm/LllZLttRYmbNuC
	ojpmEPTwq9UfYdFvaqgz3cVippsGNG+55WGV0+QQ2Xb6PHuWy5u0
X-Google-Smtp-Source: AGHT+IFvM2lNyXUN9LVAOKq+J4/wuDMlKQi87gVV6VjvwsGhIKSM7HeB8GT80zfsb38iH5tBT6b/VQ==
X-Received: by 2002:a17:902:c793:b0:1fa:ff88:891a with SMTP id d9443c01a7336-1fd745f81b3mr11825855ad.48.1721450497927;
        Fri, 19 Jul 2024 21:41:37 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f315c11sm13023465ad.125.2024.07.19.21.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 21:41:37 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm: zswap: fix global shrinker memcg iteration
Date: Sat, 20 Jul 2024 04:41:24 +0000
Message-ID: <20240720044127.508042-2-flintglass@gmail.com>
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

This patch fixes an issue where the zswap global shrinker stopped
iterating through the memcg tree.

The problem was that shrink_worker() would stop iterating when a memcg
was being offlined and restart from the tree root.  Now, it properly
handles the offline memcg and continues shrinking with the next memcg.

To avoid holding refcount of offline memcg encountered during the memcg
tree walking, shrink_worker() must continue iterating to release the
offline memcg to ensure the next memcg stored in the cursor is online.

The offline memcg cleaner has also been changed to avoid the same issue.
When the next memcg of the offlined memcg is also offline, the refcount
stored in the iteration cursor was held until the next shrink_worker()
run. The cleaner must release the offline memcg recursively.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 77 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 21 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a50e2986cd2f..6528668c9af3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -775,12 +775,33 @@ void zswap_folio_swapin(struct folio *folio)
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
 
@@ -1319,18 +1340,38 @@ static void shrink_worker(struct work_struct *w)
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
+	 * If we get an offline memcg, we cannot determine if the cleaner has
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
+		 * When the offline cleaner has already advanced the cursor,
+		 * advancing the cursor here overlooks one memcg, but this
+		 * should be negligibly rare.
+		 */
+		do {
+			zswap_next_shrink = mem_cgroup_iter(NULL,
+						zswap_next_shrink, NULL);
+			memcg = zswap_next_shrink;
+		} while (memcg && !mem_cgroup_tryget_online(memcg));
+
+		/*
 		 * Note that if we got an online memcg, we will keep the extra
 		 * reference in case the original reference obtained by mem_cgroup_iter
 		 * is dropped by the zswap memcg offlining callback, ensuring that the
@@ -1344,17 +1385,11 @@ static void shrink_worker(struct work_struct *w)
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
-- 
2.43.0



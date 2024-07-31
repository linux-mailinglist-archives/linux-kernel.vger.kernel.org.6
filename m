Return-Path: <linux-kernel+bounces-268381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C939423F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AF28630D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A82C2ED;
	Wed, 31 Jul 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub1HK/n+"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAE79D0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386969; cv=none; b=Fprz8y9VSNLvsNg6yJoSack7hcTy74ez/CinC3OUJlxkl0Be8/xL40KjNukYE7M3uqe60QVaTSPeiFxBxEVQqD73tQuNa4+j90evZH92W/yZFs70L3/iRaNDxoteMH1TdkwRpGAR/R3VJlVVU52vzM61hxpOxWgQErOd6mP8hYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386969; c=relaxed/simple;
	bh=pDjMif8lBhcshwxqWQgBKERBDBmwnu6FAp4SmlHUfIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoELhsLRpj7wgrAxO6ocgvhukp2HtBjdQGSMrA8dGoWetplwUSBVtpM6PFHrBJHcAs+sB4Y6Ik1J+KP5m14iGOS3G5MdZt+u2cRNzPPxCYcAns4Rwzd4VBf+w57eZBHE0rMB7aDkAwxCmnBSCN94gGX3nYh5Wz6PSLy0m4B6pHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub1HK/n+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d333d5890so4872880b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722386968; x=1722991768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Cdx1T6GHgjmAgTg6EIeCB+6MuRMcWljgS8+6HcHrs=;
        b=Ub1HK/n+9r+MLpahwhMpi9ACvKuCs1KbT9RITSXx715XGqXm0nwWeBKHOS6Ao64O9X
         tbh0otL+1LVJoFET8ey86TluzTV+LZQrk1nQAKHlNjqJM593obJZ1GpPYcKcYqVGTwcH
         jcCFJWd1a9Iybu5WwHY4RwECkINRZVdpO1di3qZi6+7CW52Yib928eAgYVqkNXK+dhXQ
         kgeaVqvY1HV6QhPdqVJPw7oyyVRKvSlCTTPqx0FT8ck13bXCet+mKa+X023AXrgBYO4W
         Ie9HUqyN2nJNWo1xkfZTDwWhSsl2QFKIxqsM0UDc/HMPYjv4LzsPHwjJ3IfJ77y4RPew
         CoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722386968; x=1722991768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/Cdx1T6GHgjmAgTg6EIeCB+6MuRMcWljgS8+6HcHrs=;
        b=RpslaYN8c6VOPIXQneaj7seEjM0K/7ySSD/cesqDKk4iveYBfkYt/FgpjxCXh71Bu/
         xL4Zwe+N5J/Lv8v967Ipm5mLj+Y89pilwfhq0g1q23jwJRcjXBeC/yiOdV4i+gVBabAE
         62B3/atN4ZTbpjs+GTAXgVKM69rGB3xifODD/ZQGRdQBGk4lpL6JECYktCIFluRwrcdi
         EFCsG+p9wuHAaV+dOf4MUUZEN9wyiLTYFR11Gl9xr5atsOy5GarrAXJaj2HOR0UEDTKs
         xNAvDsLWzeT2Oa+LxmQdhlPSKbplNDt66ZwSVFKp05bQIleB2rCJ0AJ5PoCXW/hp018k
         S/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBdcVqMeWzbdL85+g6c7GrSximJNSYiaigKSmL4fRfHV+g9Ho3V/3jXzyDxo2Pfzx7W3oZrbZHGyrxro+bdfsKUStPja+iqPnDf6KH
X-Gm-Message-State: AOJu0Yy3HEyBZSwvm5mGI0/aO7IO4YT6FUq/ECQYyUUN5WjaO59Wb6Qt
	q2EHYUaBZr/8If45EMd/Oysf/h1qKDG1GR6WCaYXo0Pq/ZGeLS5T
X-Google-Smtp-Source: AGHT+IHLx6udqOUFkS+9d9hCGSl0IfacbgTXMPerHS+1yI6/gvCgRmwDQEFwQRz/wxs519E5SDePjw==
X-Received: by 2002:a05:6a00:3c95:b0:70d:1e0a:e609 with SMTP id d2e1a72fcca58-70ecedbe08fmr14440153b3a.30.1722386967647;
        Tue, 30 Jul 2024 17:49:27 -0700 (PDT)
Received: from localhost.localdomain (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8837edsm9344745b3a.148.2024.07.30.17.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:49:27 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] mm: zswap: fix global shrinker memcg iteration
Date: Wed, 31 Jul 2024 00:49:09 +0000
Message-ID: <20240731004918.33182-2-flintglass@gmail.com>
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

This patch fixes an issue where the zswap global shrinker stopped
iterating through the memcg tree.

The problem was that shrink_worker() would restart iterating memcg tree
from the tree root, considering an offline memcg as a failure, and abort
shrinking after encountering the same offline memcg 16 times even if
there is only one offline memcg. After this change, an offline memcg in
the tree is no longer considered a failure. This allows the shrinker to
continue shrinking the other online memcgs regardless of whether an
offline memcg exists, gives higher zswap writeback activity.

To avoid holding refcount of offline memcg encountered during the memcg
tree walking, shrink_worker() must continue iterating to release the
offline memcg to ensure the next memcg stored in the cursor is online.

The offline memcg cleaner has also been changed to avoid the same issue.
When the next memcg of the offlined memcg is also offline, the refcount
stored in the iteration cursor was held until the next shrink_worker()
run. The cleaner must release the offline memcg recursively.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 68 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index adeaf9c97fde..3c16a1192252 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -765,12 +765,25 @@ void zswap_folio_swapin(struct folio *folio)
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
+			zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
+		} while (zswap_next_shrink && !mem_cgroup_online(zswap_next_shrink));
+	}
 	spin_unlock(&zswap_shrink_lock);
 }
 
@@ -1304,43 +1317,50 @@ static void shrink_worker(struct work_struct *w)
 	/* Reclaim down to the accept threshold */
 	thr = zswap_accept_thr_pages();
 
-	/* global reclaim will select cgroup in a round-robin fashion. */
+	/*
+	 * Global reclaim will select cgroup in a round-robin fashion.
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
+			memcg = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
+			zswap_next_shrink = memcg;
+		} while (memcg && !mem_cgroup_tryget_online(memcg));
+		/*
 		 * Note that if we got an online memcg, we will keep the extra
 		 * reference in case the original reference obtained by mem_cgroup_iter
 		 * is dropped by the zswap memcg offlining callback, ensuring that the
 		 * memcg is not killed when we are reclaiming.
 		 */
-		if (!memcg) {
-			spin_unlock(&zswap_shrink_lock);
-			if (++failures == MAX_RECLAIM_RETRIES)
-				break;
-
-			goto resched;
-		}
-
-		if (!mem_cgroup_tryget_online(memcg)) {
-			/* drop the reference from mem_cgroup_iter() */
-			mem_cgroup_iter_break(NULL, memcg);
-			zswap_next_shrink = NULL;
-			spin_unlock(&zswap_shrink_lock);
+		spin_unlock(&zswap_shrink_lock);
 
+		if (!memcg) {
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
 
 			goto resched;
 		}
-		spin_unlock(&zswap_shrink_lock);
 
 		ret = shrink_memcg(memcg);
 		/* drop the extra reference */
-- 
2.43.0



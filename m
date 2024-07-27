Return-Path: <linux-kernel+bounces-264298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E236693E169
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 01:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125921C20D67
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE02BAE5;
	Sat, 27 Jul 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCxkIncc"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724944594C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722121610; cv=none; b=rCXEdrt0wKZ0PyEgMN8w++qInunJsPJmtHTIXNcDzK65Da1V6H5NRnf8EF9Fo0BntaNUJlpHMRTIM4hlzlCILR31S3tOer4FwCXiYuS90LrDCwQec+eVOjKcvKbok7+VbYiEysSbFeXHezh79I8T2tD8LpZ0AnGEmtSC5eSWGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722121610; c=relaxed/simple;
	bh=aFLj1QSiEQEy13YhFRDSi4VuCzbZhepih4OHEDHYR0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUT3kTkcl9hRSqPxYJ5aMyeExW+CMWU9nPSfga1M/lz/skc9ZkaeVX+gIpuVxdRWhf7bZz7nENP/CxDRYODpDdOODckTgqPEVqZPwYP4Afgn7X6/5W0zWal75mTdk4HAkuJgX2OwK1e54cwpE0DNdYwrM9WW9icmRIAOcOpOvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCxkIncc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so22811a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722121609; x=1722726409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc8l+AoqZ/lOD+WyY+7XMFYuKOmIy9AbESjq+dymj8E=;
        b=DCxkInccGcP+iIz6SbbamQR0smyz56AsbqxoOmEOEivrv5aCKnyMzFFFwTu9c9uPdL
         ZW82TpkKU0Cw+BVfZ6itl60kJxXKGGfTbUtUmYU4vsH2r/bat5WFecLw4Np5IWNYU2v/
         yofWuD4OfxGs5rIjKdRC4pQ+blx3iQOcLYcZsXeub8LwvsS1eH2AWUSVsBFTtTsD4kav
         1QSX9WTFLEqY3xoXlm0XyIWygqYDbhSZ/SCfn5FL4Oj58USFJ6sHvPhVTQOJlD6ZfG8k
         lXc2+WJb0hG4+8n89pvUP7shztlE3hfbXVcV/zvNJWaopDAliYH+c5U1+8lC3y9yQDkh
         oEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722121609; x=1722726409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc8l+AoqZ/lOD+WyY+7XMFYuKOmIy9AbESjq+dymj8E=;
        b=VVpMJmoaDWNX5jv44FXOEoOv8uXx8f0lge9Z0OrhqI77s6TsTGwVdICoggySSnyzBS
         b7nYXOqWhXjfuPACS8L4KrmWjejbR4HidjpYFZdo0SUtsOkkSH0B2hJSBN5HMo/sDJHg
         ihZwFkd0PSoSvQgvjrYg3/mX8/XSPFwzBhHLVNYj6UXhrT/V47/I4bPWIbgRpv9nKrb/
         zAe06janlOPE7rsYifT5W+1eAYEJQsyJZ7LLd1ILTm10iSW188kon055BA/3MKcK4Qf4
         59nRwlO36IV5kiJ30XTZ2/0QGJMCnDy2vSD26EgV9nEB13ozaIywCoCpGFKhqEpK+CPq
         Bd3g==
X-Forwarded-Encrypted: i=1; AJvYcCX6scYm4esHIUMgFVMcS8yFvEAMhkE4KYaHxeuMGx2HBHB0DEa130YRW/A7LBQMfUBE8G60UJ/7j4qA5AtFekBCWWP1gkwaR3ddK1nN
X-Gm-Message-State: AOJu0YxOoDvaAZ2SCVf7Y7RTqGnT5Q2ETNQZTi2f41lpE5L4Tg4ZgXGY
	jAX0K+cddGOlnoKCz6me6FPHvmFQ3VsyPqaFT7dqLgV626mqq6wE
X-Google-Smtp-Source: AGHT+IEP0u9cC0ABzPcUiF/6yrcR6z/JGO3GPmbyGGVg/iRkTfavw47MJeKi1Uf1gwD15gqjnwfpkQ==
X-Received: by 2002:a17:902:e5c9:b0:1fd:64ec:886f with SMTP id d9443c01a7336-1ff0482f73emr46302535ad.26.1722121608658;
        Sat, 27 Jul 2024 16:06:48 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f274a7sm55881145ad.209.2024.07.27.16.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 16:06:48 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mm: zswap: fix global shrinker memcg iteration
Date: Sat, 27 Jul 2024 23:06:29 +0000
Message-ID: <20240727230635.3170-2-flintglass@gmail.com>
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
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index adeaf9c97fde..e9b5343256cd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -765,12 +765,31 @@ void zswap_folio_swapin(struct folio *folio)
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
+		/*
+		 * We verified the next memcg is online.  Even if the next
+		 * memcg is being offlined here, another cleaner must be
+		 * waiting for our lock.  We can leave the online memcg
+		 * reference.
+		 */
+	}
 	spin_unlock(&zswap_shrink_lock);
 }
 
@@ -1304,43 +1323,49 @@ static void shrink_worker(struct work_struct *w)
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



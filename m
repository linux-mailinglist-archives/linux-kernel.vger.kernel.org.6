Return-Path: <linux-kernel+bounces-191737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C08D1374
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7031B1F23F02
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D80524B2F;
	Tue, 28 May 2024 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg8Y30kd"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD922F19;
	Tue, 28 May 2024 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870886; cv=none; b=JNvK+xjNNirLSW0LuGheq26JRKsYy1eopVzO61ZMH3G7XI+k6seM0ukYC5VQjS/RiNoT73eqfYnOkcQBB1MV3y9ZidF9E/WGBQZHZKRYCRptHejFie4s86TYuAYtooyNAWgDVqi9wGZxkXhHJ6lOEyM+ayT3EF586HBB4dQGyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870886; c=relaxed/simple;
	bh=zd7BoK2yPEDT3dqyajhY6RYvyU5jTzCjXI4nB2sACME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2ZJl0SIFalcT+SJ/PCYk0SIkOGeGc1FcmF9TrVrUiGWpWUefJ0Y+weuJRKzfMzxSn8pxfwTR4e5NEZqU8DD2TL+p/SC5ob7B3SdntSV2XMF08P50K4/zRoIrzchv4+Cyi7S3Z4JoDkbeo10g/o9E54esgMqfs5rLXlLeeWRess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg8Y30kd; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b9735d7ab4so186349eaf.2;
        Mon, 27 May 2024 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716870884; x=1717475684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0FwtNJwtUXGe6IZ+n9Z0anxXb12NEWwpY37V9CVD5c=;
        b=Yg8Y30kddOObhv8Qm6MCUPlUFCyHc3LQ2EVDkXTdML3AvmJFb+siG2ekY66/kwQSx1
         CJhdbdPaquc5w4F2201WPwhnbmGLGM3xh8/vMp5CScwTBe4CQTVRUgNeRE9MXn+qHZa4
         VTENjdj91tFVUe1LAloU2H9DF1PzI2yzp6wkzXS//id1p8q4yqW9RLL3Z0ei+4qDDJx0
         U7zihVDVoeOXhsrBV6bMmnnvTXgYXlvT+BgftCc0vy1OmC7fK8kIf/hwaMJW1OWPpVAs
         z/Xz6hWLRp3Xac2hyUN/Afb/hn+BLGYfN1V7Pd4BCKcJIdzcGGJNchzZGWhoNSPCwwbS
         OlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716870884; x=1717475684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0FwtNJwtUXGe6IZ+n9Z0anxXb12NEWwpY37V9CVD5c=;
        b=mvly4AXgI1iqECVLB1mmSN9CZRpGw39Td/IQ/96HDgfUQDZJkEtRGG0jyMSXf4Pmin
         hYj4EC1eb0o59kSAdoceYxU8nANrqs35fNSc0q7j3rulkF4uP9o1ZarcltLvlrcYzJ+d
         ENLENu7VFSCl9Cy4Y3fRRIzVvagkiW2WAC0xWGhLyNiLo2iXFT5o9ppBs5uFDGRufKJD
         QbJ92yrJNHkDME4UUNErwJ9d7SnxpLSicv743/GXT1DofO/kNCxjzeLa6KAVR9rpT4Vi
         WatvC2+ehIhE/KPylNgvhFO7bdZWAO9/LM8d1R7CfBBjKXycv5LUyEQI76sLhznx55XY
         wMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBDsVwfas70GHBH0HG5HALsaab8ddQAu9+i6HSSdvFRSHW680uSuzhwkPnT+9gOca4a6Rgwm8/xLfe022oh7Py0FHw3g3K5AMTg0EUFR2plJy24OYcs++y4UuYNhutAH/jLi99521i
X-Gm-Message-State: AOJu0YyU0ZxOIW2XJ+3t85aFZpDlXc2Mbjwu9NQeB4Whed7Uv2IwVQpL
	sO+AyRsHnGS2tYgnp4v8Q0n3DS+lCe5lwM1EwRAjp8+51e70d4x5
X-Google-Smtp-Source: AGHT+IG+M9uCZ37lujmkacVFpRUOUtCzWpjhQ3KyJPVcIXwjbpjOXZt7xy4QwP8AV7IDU0AkNndjrQ==
X-Received: by 2002:a05:6870:2183:b0:24f:c42e:3124 with SMTP id 586e51a60fabf-24fc42f1cdcmr8469019fac.40.1716870883408;
        Mon, 27 May 2024 21:34:43 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d57b9sm5620036b3a.193.2024.05.27.21.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:34:43 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: flintglass@gmail.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: zswap: fix global shrinker memcg iteration
Date: Tue, 28 May 2024 04:34:02 +0000
Message-ID: <20240528043404.39327-3-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528043404.39327-2-flintglass@gmail.com>
References: <20240528043404.39327-2-flintglass@gmail.com>
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

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 76 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a50e2986cd2f..0b1052cee36c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -775,12 +775,27 @@ void zswap_folio_swapin(struct folio *folio)
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
 
@@ -1312,25 +1327,38 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 
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
+	 */
 	do {
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
+iternext:
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
@@ -1345,16 +1373,18 @@ static void shrink_worker(struct work_struct *w)
 		}
 
 		if (!mem_cgroup_tryget_online(memcg)) {
-			/* drop the reference from mem_cgroup_iter() */
-			mem_cgroup_iter_break(NULL, memcg);
-			zswap_next_shrink = NULL;
-			spin_unlock(&zswap_shrink_lock);
-
-			if (++failures == MAX_RECLAIM_RETRIES)
-				break;
-
-			goto resched;
+			/*
+			 * It is an offline memcg which we cannot shrink
+			 * until its pages are reparented.
+			 * Put back the memcg reference before cleanup
+			 * function reads it from zswap_next_shrink.
+			 */
+			goto iternext;
 		}
+		/*
+		 * We got an extra memcg reference before unlocking.
+		 * The cleaner cannot free it using zswap_next_shrink.
+		 */
 		spin_unlock(&zswap_shrink_lock);
 
 		ret = shrink_memcg(memcg);
@@ -1368,6 +1398,12 @@ static void shrink_worker(struct work_struct *w)
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



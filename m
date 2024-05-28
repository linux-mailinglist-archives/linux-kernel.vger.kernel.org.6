Return-Path: <linux-kernel+bounces-191738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A558D1376
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0254AB21EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50841C6B8;
	Tue, 28 May 2024 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekFioCR2"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAC2837F;
	Tue, 28 May 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870889; cv=none; b=eLpGxx/oxoHlxzRv8ZdzouaQj/1+Yyh1xsRRESmhxOX9CRpSbzQBAh2vHtRBYbAYQqvo5Dxt+sGdQvTJRSub7Ji/wH1Nn1OCV8bUnh2S8m30l6EwejODejiGpefuqlpljVrEUd3ZDmQjwsMlLRBBKAHhfML2oYqGX4KrdDLkozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870889; c=relaxed/simple;
	bh=/RpI2/xF4Y24lM7BtnMG5SoMQmZ0dhWq8ISQ7dpoAfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSX7ccZ8IOvJdKSRUP3HlIFsE+Kn/jSFjb8IBhYG7XxUEFQbhkjNdDYFbuc2LeHYW0TLdw0yzudamMO7bh7BuEojTmqIInJdac3fdBIRPa5rqWuYomGshHdrtXeYdp8NnwrVGHEfSkp6CaqxtJjR5AgBeGazAAZvMj36RL4lrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekFioCR2; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f12ed79fdfso249339a34.0;
        Mon, 27 May 2024 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716870885; x=1717475685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36ahJbEkFkRc61ECH6sYqp715enbxmd67+pVP96vSYE=;
        b=ekFioCR268K/awrkEcLCZaN14XZLYJBOv56oKrXtAAEeaNGPyfMhR73VhiZ+J4d7y1
         WnoJaUBjaGgnP/O1gnRNIDvVczTjEc64CgvksPp+NNoCybwHpRCw+5o/Wnpgj5w9Edat
         89lknZR9/GRLc0QWl3lkjwC8Ml6wPS/bZzoRWZSRHgk8Ctxl3uHx0hVfDi1euIL1H9RE
         97PDwN4O3bTFQpMScKO94p3VIo71ocrrKRUTyJdvp6l3DZ2eje6iE8NOuFvkwV/xv/t9
         Af/BjFMYCTYVuObI/PouMKUE0xyS6LzGaBa4LZ7G7mRhV+i+DfLAYtqf2laTacGb88Fk
         BXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716870885; x=1717475685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36ahJbEkFkRc61ECH6sYqp715enbxmd67+pVP96vSYE=;
        b=GEFyx4g0nSrZeGKnImkis3JIB/ml68ZpdpVs7lsyn4tMz7QP60UtoyYcTC9z12kjuB
         WqCCC27njw5vxf6Xb2UHjCMGvo3dF6kjDZ+xeZIf9RU9d3qgWgbp84eDAkfQ9FLCPsff
         cUzK+/loUfJrPt8nwLbie7MPLUInvJddTlUzZ/9X8SKlX5dN40FAJd1Nc5uidjdSzr6h
         yUDv1lPummg9sRuJ3QlJV4bbw/yEs/IxNKIKJr0y0FCnE0twDg2Gp+TtFxktcC1vM0Kj
         tiHFQKXaraihSjyz2HxbcN2IhRJlExJTRPw2/8by7HrCaeIVvfllw1CxwcdZEjhjWRvQ
         5DFg==
X-Forwarded-Encrypted: i=1; AJvYcCUl1Ct2qbSCwwYqf0n//aFJohK5JW8+jKYGPpY06jaamCk4C9wkdXdQ+8UhGKABY7GThfcm+Ak17OH02t3Jbd+kdPDrIDRdqnDJe49osnGJuszOW9ifDdVISSLvvzsFMoxe4F5FfYrr
X-Gm-Message-State: AOJu0YxWs4ieHp+O7yjtSlicoQS71ZnxiHnwG08BPRP7hI90lkh6IWSl
	L/6UecFrNxcb6N3NJJ/QD02lhKzaBVCXXscKDdviG7/OScOVTH4J
X-Google-Smtp-Source: AGHT+IFDnpPzLL+0Rgx4NniGVbtCLdQVXzKbNuKb68x21uhgaNXJP54HK5dD4BAlWphqV2kWqKuurA==
X-Received: by 2002:a05:6871:741e:b0:250:79d:5839 with SMTP id 586e51a60fabf-250079d5d84mr3666204fac.45.1716870885494;
        Mon, 27 May 2024 21:34:45 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d57b9sm5620036b3a.193.2024.05.27.21.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:34:45 -0700 (PDT)
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
Subject: [PATCH 2/3] mm: zswap: fix global shrinker error handling logic
Date: Tue, 28 May 2024 04:34:03 +0000
Message-ID: <20240528043404.39327-4-flintglass@gmail.com>
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
index 0b1052cee36c..08a6f5a6bf62 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1304,7 +1304,7 @@ static struct shrinker *zswap_alloc_shrinker(void)
 
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
-	int nid, shrunk = 0;
+	int nid, shrunk = 0, stored = 0;
 
 	if (!mem_cgroup_zswap_writeback_enabled(memcg))
 		return -EINVAL;
@@ -1319,9 +1319,16 @@ static int shrink_memcg(struct mem_cgroup *memcg)
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
 
@@ -1329,12 +1336,18 @@ static void shrink_worker(struct work_struct *w)
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
@@ -1366,9 +1379,12 @@ static void shrink_worker(struct work_struct *w)
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
 
@@ -1391,10 +1407,15 @@ static void shrink_worker(struct work_struct *w)
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



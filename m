Return-Path: <linux-kernel+bounces-262720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5293CB3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2421F210E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3C149C7E;
	Thu, 25 Jul 2024 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvSKvGxd"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F800145B05
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950098; cv=none; b=BSiuDS5EYd86ymI0PjlRuUeSD1hXJg985LsrpBlMvPfg+kEpwMdRmpOmBM+YF3afV8hwZYq64MvSVAJeri6rwvu2gOYWIAffoRWyx/Hxqw4yEG1tv8Ku5uLniVocWSpfcjOARdCtuoI4gIU2bzPZ6AUbd9yj2KprpOpmHBR2+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950098; c=relaxed/simple;
	bh=rQiHNXeSOGY3neEtQ+ISaU1+DMsNM98qczGQPKXZbFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XI20dsSinSm2v3IUHNGCh+IyqBZbWLfQ7qM65x462duhb6c9YaZg47iq3SzWc2nK/ChFiQnLjR/lVb4dIgywa0Q0rszIUBfyvjEeGxS7vEu3TlXDvunmTHTcG+nCtnZS2/aK2PlrzRMV+QVQhdDXkKSL74Nbp91MwkNOuoXYvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvSKvGxd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6694b50a937so18508657b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721950095; x=1722554895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4hnJFsfLt33aZBeoJY1bqyzrEBlyMzRqpVt6Wmxo/I=;
        b=IvSKvGxdXcIVkZRq1C6K5KGWvOSdBYPTMxnxSn/AgvkN6CwUz/p0fBjEzBCfQAJSOL
         m23kuqn0hzUxMypiDBlD8ggSYMogUoiQBoH1hsQcTRyQElTVomTbzKDsIyVVKiVEri2Q
         0mP8WT7iGMR9tT4QZvbIjII+B9Vc+logUwkGmw/hhvs+75xfQPW63HWJ528fze98Gc5u
         kIZdXgVMPnvQuitda//qcsyeiI9ml/KFXkTMn+R/MC9DdpcPlRdJFExQqegmmRV6MarC
         UbL73JhafsqPoQujs+la7gwVEt8om05PgCOsDToKDl8WBEhzboeHdt+9XE+CCTEuQKwJ
         nZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721950095; x=1722554895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4hnJFsfLt33aZBeoJY1bqyzrEBlyMzRqpVt6Wmxo/I=;
        b=PAd/YRWcTamy3ywtDlUEIqdoXtK+8oVkWTetT+zvVyYpYsgbg51jqY9LUBYysH9Um/
         CubQ1yzxfYSGZrP3fZdJwVHKWqmWqsJz+sz0A5H4pJt1g0fVZPnCDP8IzqWk3b4gN0Gd
         V6MACAqAORW7HMyv13ZWIF9qVBoYqDFdKQPYr3UdYdMxdoA0nyiWUTusJFHRD5jCHsan
         H9uHy3NQqTjcOMpzZEFINVUqmCNdcILgewwyVvG46vEXap7T6UmYX8n/n2Qn8f0QfNac
         MW6Zsvd95NY11XKBSEzM6sRtkYdRJ5ZMe6xGD7Oxbjp7SIFmXCWXj10oOQBCIadpsjbH
         C5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXswp5cUZWUmiT4s4jWzhfFA7SMDMhMVpTaZzGbuE6aiU/FpdqOqOnrqvBGGKOvF/4Iw9osaW8lMOR5gi8w/62rCdnxlrB0eAY/9i/0
X-Gm-Message-State: AOJu0Yzjf8hnvQk/MePH6tkaLHCGkzv7YOc4DgqbEeaZnJRvyRg39C+i
	Ax60ZLGwafYxQygc9Qxur9/0GJszxakl7kJ4r3lA/n1TWE/lKUac
X-Google-Smtp-Source: AGHT+IHMRvmpREzfHp9MTziEwTmKWI/CclFCpOKGls4UgocwHK4nP3Wuzq9o+Q/xBN8NQZ5Xw1YlYQ==
X-Received: by 2002:a05:690c:6501:b0:64a:5443:7cbd with SMTP id 00721157ae682-675b9f4d002mr44231387b3.25.1721950095372;
        Thu, 25 Jul 2024 16:28:15 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67568113ceesm6043477b3.61.2024.07.25.16.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:28:15 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeelb@google.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com
Subject: [PATCH 2/2] zswap: increment swapin count for non-pivot swapped in pages
Date: Thu, 25 Jul 2024 16:28:13 -0700
Message-ID: <20240725232813.2260665-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725232813.2260665-1-nphamcs@gmail.com>
References: <20240725232813.2260665-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only increment the swapin counter on pivot pages. This
means we are not taking into account pages that also need to be swapped
in, but are already taken care of as part of the readahead window. We
are also incrementing when the pages are read from the zswap pool, which
is inaccurate.

This patch rectifies this issue by incrementing whenever we need to
perform a non-zswap read.

To test this change, I built the kernel under a cgroup with its
memory.max set to 2 GB:

real: 236.66s
user: 4286.06s
sys: 652.86s
swapins: 81552

For comparison, with just the new second chance algorithm, the build
time is as follows:

real: 244.85s
user: 4327.22s
sys: 664.39s
swapins: 94663

Without neither:

real: 263.89s
user: 4318.11s
sys: 673.29s
swapins: 227300.5

(average over 5 runs)

With this change, the kernel CPU time reduces by a further 1.7%, and
the real time is reduced by another 3.3%, compared to just the second
chance algorithm by itself. The swapins count also reduces by another
13.85%.

Combinng the two changes, we reduce the real time by 10.32%, kernel CPU
time by 3%, and number of swapins by 64.12%.

To gauge the new scheme's ability to offload cold data, I ran another
benchmark, in which the kernel was built under a cgroup with memory.max
set to 3 GB, but with 0.5 GB worth of cold data allocated before each
build (in a shmem file).

Under the old scheme:

real: 197.18s
user: 4365.08s
sys: 289.02s
zswpwb: 72115.2

Under the new scheme:

real: 195.8s
user: 4362.25s
sys: 290.14s
zswpwb: 87277.8

(average over 5 runs)

Notice that we actually observe a 21% increase in the number of written
back pages - so the new scheme is just as good, if not better at
offloading pages from the zswap pool when they are cold. Build time
reduces by around 0.7% as a result.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/page_io.c    | 11 ++++++++++-
 mm/swap_state.c |  8 ++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index ff8c99ee3af7..0004c9fbf7e8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -521,7 +521,15 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 
 	if (zswap_load(folio)) {
 		folio_unlock(folio);
-	} else if (data_race(sis->flags & SWP_FS_OPS)) {
+		goto finish;
+	}
+
+	/*
+	 * We have to read the page from slower devices. Increase zswap protection.
+	 */
+	zswap_folio_swapin(folio);
+
+	if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
 	} else if (synchronous) {
 		swap_read_folio_bdev_sync(folio, sis);
@@ -529,6 +537,7 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 		swap_read_folio_bdev_async(folio, sis);
 	}
 
+finish:
 	if (workingset) {
 		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a1726e49a5eb..3a0cf965f32b 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -698,10 +698,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	/* The page was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated)) {
-		zswap_folio_swapin(folio);
+	if (unlikely(page_allocated))
 		swap_read_folio(folio, NULL);
-	}
 	return folio;
 }
 
@@ -850,10 +848,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	/* The folio was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated)) {
-		zswap_folio_swapin(folio);
+	if (unlikely(page_allocated))
 		swap_read_folio(folio, NULL);
-	}
 	return folio;
 }
 
-- 
2.43.0



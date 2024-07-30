Return-Path: <linux-kernel+bounces-268297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5929422EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA311F253CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E2192B97;
	Tue, 30 Jul 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzlqdjzc"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F4191484
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378432; cv=none; b=pNvwcHn5RmW0xjf+9Ord6T6n+Eomxd+6WsNWbMkeMxVmP+s9U0D3EqpBX5si+9rzmGUuLo1p/L5WFxDXggaPELXa3HSls8tu15qLCYrXkKSWOa6qPb44X+e0y5IPyVDPt0G+2ablw7DWO6K+w/AOdvQTBSFL1hmhjToi0e70dSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378432; c=relaxed/simple;
	bh=rQiHNXeSOGY3neEtQ+ISaU1+DMsNM98qczGQPKXZbFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wzsdgd8nZJg6KLjXUdglmAjU5Ob5AlIMaQS7Dz/5k6PKyVHnjDCQgOsi0Z1mSWfCjkO4ZgpYPUfvLDEBGK3DPdeyE0+gMDVSfUFuR8HvnFS0sKIwGTiPW5zkl6tOt0IM12JCYUN7vo8a9sN6jwkLVv2GGmvnIDjhshIQOGkKcPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzlqdjzc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e05ef3aefcfso3817644276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722378430; x=1722983230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4hnJFsfLt33aZBeoJY1bqyzrEBlyMzRqpVt6Wmxo/I=;
        b=BzlqdjzcHCZfWCmxBxix5EM/jxSCROrg7mApBxO3vXvFSn7UOrH+iiqknSDeBD7IyB
         fvuxQuMBjeDFNinzkT9kQKQO+Kxp0WCChsOgYssLEwSsyvqdH8EA6MHY4qp3qR1Eip/6
         SRJ9HtGjw0dl+5I12NjeMVsL4vL9QD1QxPBcl1CADSIkmDH8IheI0eDLB7sL5fwAor4c
         YiSB/jj0iUIPikxnF4jPVCk+0zz7cS783zkdpmPzsz+MpSa5ZcMEmbstIkIB9rgNm6d7
         vs3Wh0DqHcfLDwwcjJDvHmHiYI37xxstrDXY1nNq4gDQJKKbbM8ytgPASLMejQCgeWyS
         ZMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378430; x=1722983230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4hnJFsfLt33aZBeoJY1bqyzrEBlyMzRqpVt6Wmxo/I=;
        b=Qu9w6v9/q4PB98ghHYKpTPpYP6yx/IQ5uc/6QAvOr9bAevS9Og51Fmi3VffCZIbMnk
         EqMc31R7rEVK2u5SMbE5mutgYY6MtjmZlaasRfD2sLJAcH9FyNqvsmwQByXg/FwdKY2I
         nUoZyrE3MgjAvXwoPRelwyYOdry8oAgiWXI9reqooJG2DWOWSRnrRN4dO1dWTUGWOt05
         wzw+UesNcDHb0ccEuk5PyMVdR2FOoHoBGdn2NXbkN0gdWZ7N//RD7+sgbND5gNrWTugJ
         oWjUlytgb2pfO3XGB0Fn8PPdrcxaLyeb7CX40APqJ9KCsMf0d5xm+pKdLIDuLssgKrC8
         b35A==
X-Forwarded-Encrypted: i=1; AJvYcCXCkzDh17VJCXzh4OABipZb2DtmW6nMf0gphRpnA+z8wHn/VGH3l+2YLIS7ok68OED+dPfCgdnmtw5RiTmlFUYCOFy54BIMkcWQKpsY
X-Gm-Message-State: AOJu0YxXt4hniUpC5obk+b4tYX9ChfspyLCxdSV9DJU29CulTd7FT7pr
	uinvrauPxJhW+wWE1Cg1IKyj7ihevEGecEda1Dmhg/RvCxvEFZ8kkXGAmg==
X-Google-Smtp-Source: AGHT+IEDpXcJKoeIOERp2NH7899jLowbHdtHLsB6NDYOMXttj9SNXSNeVKXOov11l1XP/MwO3SJ8Jg==
X-Received: by 2002:a05:6902:1209:b0:e03:a983:3d83 with SMTP id 3f1490d57ef6-e0b544c9f51mr12729774276.27.1722378429577;
        Tue, 30 Jul 2024 15:27:09 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f7e037sm2597472276.26.2024.07.30.15.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:27:09 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: [PATCH v2 2/2] zswap: increment swapin count for non-pivot swapped in pages
Date: Tue, 30 Jul 2024 15:27:07 -0700
Message-ID: <20240730222707.2324536-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730222707.2324536-1-nphamcs@gmail.com>
References: <20240730222707.2324536-1-nphamcs@gmail.com>
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


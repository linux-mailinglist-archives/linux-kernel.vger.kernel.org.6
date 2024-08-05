Return-Path: <linux-kernel+bounces-275448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771E9485D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E291F234EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C916F0C6;
	Mon,  5 Aug 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNBW+iF2"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CE158DCD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900168; cv=none; b=R03NZWboLDmT9yzaTzdkMF9I8wqqbt+uW6+GzNrIRjmd1DlD3yAZBpcuVsP4lDVjC8Mm1ZuBlYM6rirbtAKLIdmvYZEt0CX6Yra/uL4blGs+x4pF95ec6u4D8npVqGzDch+17jPRj4oz/j19TRH3lkgr497+Rwq+zdvQKIAb0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900168; c=relaxed/simple;
	bh=YctzVd8U55ea6D163squYrADwMnXG20Zi0wPhNvhfi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYlTjrlzxYh/bJh8wqRzYNNg0yhEAzjmkrSRI/rTFzxeNpPh4lCa1DS/ZUWDJvNy9dUL9Xwz5g8sRwq/uRHVsceAlacMoObQXxH9guy70FZX5bLc9jLR1uqT+5OvAkoIQTIi/l+RSnMzNuS4zgpznZEwuH8/B7dXjPgEVAirFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNBW+iF2; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-68d30057ae9so233577b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722900166; x=1723504966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkaEIx/k4xuzqcdyf8vlncyqK6jYETnvINbJiqVkRs4=;
        b=RNBW+iF2Up4k4WQna3TCfI30Y/s4Qb9Wz4iVVj0h2dnFSp4isUHNIGHpAv24bGBJBy
         MgYNoVHdVej9AfQc6ctVKWx5CGjDBGaPfIrcktqQimytOPG94vJxOqZ3AovFZDFIVkBV
         DabPmq5gO6HMiu8td9fAiZYSZp/CHmw4CRkgM3P7Q/GH4hDPlLeLfzIH6NOfq/67rH8b
         KYUINPEWFWxasRX+5UxDqw6XdulK5xaqw9PgMJavGNYWQdIVqmogEwFfvjkEcBcdlLG6
         ASjQAn77cVsDKjnR5JUtC9QTJyKo+z8SEfH1lRBPw6/UAGMCyav9BMewYMEwMOLGYVBW
         g1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722900166; x=1723504966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkaEIx/k4xuzqcdyf8vlncyqK6jYETnvINbJiqVkRs4=;
        b=Y0epR595b5ohv6FQUzXORBU0l0Fxr/UC+NG3CfoyPxJEUS2hXs2b5Gsys2YUkMXXj+
         Nhp5eDdQR2XbBMOuYHb3dEW9iFksGf15mEc0cKsgYEHCg3SyIuhywZRxV+KJX8rJFP3T
         4zh3T3hlh2fwVkyGdDPgS9HhWUIr6+cQuIA2lP217hShOqnfnbdSilbayyg6AZxlgXSr
         tGLq5rMhLXe5gKrXxCllB4JbRq+SPyVg2Mt2bjMCcap/sO8F1trzBfkdusOblH6vnhCR
         I9Qiibe/KwsEpo0G9CRHWHOR+OJJeL6+GnjtdmUohslSDH+/js7TaYxEHeQTOhkiYXHs
         vtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVC5w4cRNKKRVjse0W2XYNY2eM9mqv792/LpdxmXrKSLnI5WR8h8ZNizdwuz8SaL/P0XqbEN6vlfJiM68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5wP6mPrZA8hhXpZ4J6Kcr1KpviId57fHAu5KCJukQHADAji5
	BBPn7i3BKi2LrU0eD9lTRS97q9ykdYTFUvnm6rS7eZnnqurP6/TV
X-Google-Smtp-Source: AGHT+IE4Tl8ohAx6IIeKCZxM6CjsiKWomCPMWkpF+m0TYpAKSVDKJNP3Zx4RTKZcwi7+KTZ1YLQcpQ==
X-Received: by 2002:a0d:f7c2:0:b0:63b:c16e:a457 with SMTP id 00721157ae682-689601aa7b8mr136816817b3.13.1722900165711;
        Mon, 05 Aug 2024 16:22:45 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4193desm13652527b3.6.2024.08.05.16.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:22:45 -0700 (PDT)
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
Subject: [PATCH v3 2/2] zswap: track swapins from disk more accurately
Date: Mon,  5 Aug 2024 16:22:43 -0700
Message-ID: <20240805232243.2896283-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805232243.2896283-1-nphamcs@gmail.com>
References: <20240805232243.2896283-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are a couple of issues with our disk swapin tracking
for dynamic zswap shrinker heuristics:

1. We only increment the swapin counter on pivot pages. This means we
   are not taking into account pages that also need to be swapped in,
   but are already taken care of as part of the readahead window.

2. We are also incrementing when the pages are read from the zswap pool,
   which is inaccurate.

This patch rectifies these issues by incrementing the counter whenever
we need to perform a non-zswap read. Note that we are slightly
overcounting, as a page might be read into memory by the readahead
algorithm even though it will not be neeeded by users - however, this is
an acceptable inaccuracy, as the readahead logic itself will adapt to
these kind of scenarios.

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

Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
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


Return-Path: <linux-kernel+bounces-560038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 771EDA5FCE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F5C7A3885
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55926B0A1;
	Thu, 13 Mar 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBqi/Wat"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5126AAA2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885293; cv=none; b=BU8o6d/NJha3ugwf5P0Wg00eBbLTw+ShfBGkKFhXuauy0iC0BWC8jxK25m1RU8MijOqiC9yAaofh2plPCC2oqKYRt3OPkTMKqN9OJlX8by0zcsDrxlCpMv7ZLmR0MXtmJRgiqeW3syWbML+e/pGTnk64FqQLudyCLSBX77Ss3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885293; c=relaxed/simple;
	bh=RHI3AKJ18YJQw15g5mIoicSngTlptd4/6GkNMVoIGN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXJiv8iDj2t7oKLbiRFp0rQPka7YihcEWlpcyylY7c0o0dGN+LiYSY7rRW6GHqfhW2zDYXtr+ND259EY2S/i7V8yXIqbuaKdB0yOWOAjZpveLlIAJRClcQQiw1fBSKYjSwUlKMoiiQVlEFTdk2vwFEIYCU2gXBalpQDB3fiU95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBqi/Wat; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225a28a511eso22998165ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741885291; x=1742490091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKRxUK1y7Id83Wc7nB4qFch4/Nkz0/Hx3e5OqBZUaiQ=;
        b=dBqi/WatOSBtZI3ThLPSk7ks0rfTbT0/pDjl5yn1gASx3srV38nZQIeAIgUUpPnVGm
         wGR25xfEja5/dTHkJSWL3HpJYyNdmr++C9rmfjRMpJ54quqF0eK0t7Bn9fu4mUd8IraA
         dqLybALdqDP1pl78ng32pU5G/ljd+zvEsHOuLXx1QUEF+Yu4YWJ/b2QOAt9UY4MxQ5KK
         FLgDtqDDBHboNXcasZaEr7Jgzt2UnunhDMw4Z8aObgRsyFt9obH9ADeYhpK2ywoz2hxg
         bwvo9S5aHfPbaR53xCSUjlLRy62yvB9ISa4AnFqErFyj00yVYddsAcwwklzbPEq3OBxT
         24wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885291; x=1742490091;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKRxUK1y7Id83Wc7nB4qFch4/Nkz0/Hx3e5OqBZUaiQ=;
        b=UNCKBf8HocED6SMzGYnvNO/1dIjPVylUbO5orY23v43mxmrquTaVnrA+FjTii66/eh
         rc1m8oMH0UZqF2ivuBp0tsvwPDlX7M/QXgeDJpti5csdvmyWrBS3Y9rmV4WayhIuCWi8
         f4oQOhdLpcGcIEF8i8Z7+wsaE66dkPRLKatrUvJ47Zh59KMi6AqyISEEBeIx2va5JbDO
         gJPIwFjxlrl2EHT6Yufk+ob0p1nY9ysi2budOluXFWVvK05q6iF6F3FQ9S6j8mMTJttB
         B1o+lCqjxqzNlXC41sO008PlGDqgAAP/CGr3zC1k9wVDpG1wpmMK0D/Qn0c3iZjaYDdh
         Wo0w==
X-Forwarded-Encrypted: i=1; AJvYcCV010RugwOYbBccWzyaVrDfZ1ENu5FJd0J/Xw2ql0iE7XG6YNtFJqsbWheBnlnwJoYk8WaUSwqmQXnjBeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2YDlNomtA9YCZyuAekuNL53zNYdnd/A/I3LVRqnz9w4/8Krr
	U0jkbUAO9sl+9m7GEo0G3Ay8eNx+1sAJpIt7CkqO1MzjvNWECqru
X-Gm-Gg: ASbGncuJeVpexvPCHUVwVNuujIJM2ZgHDvtsXrUiGRhojaY3VGdE3t7OSX0kQpypujW
	cgu3yXVqLf3FaapX25thtKQR3ORHnNz4qZ5PwqTSLI1k4zgGmc7foUbsCkujMcGzjnBNZZ+q9ly
	TMVPuHYjuMszva6PGk4U6rNJZI5acmrpxl19Waqg+ZTWoJP50u/KtAA398PjsZiBLlWNBO7jj10
	6qEwAIBSU1kQ/YDQRUiviMv0DgdumBvfxdmWqeKGxUjj1GiRmIzQZA/oQCYLV433XQfUlj74WbK
	Mf7wYjO66VvqK8p9kpU9YqeTTfwuIoU1giE8YcbEGpARvEoETiNTJQT41waLpi16qMYETIml0NJ
	F
X-Google-Smtp-Source: AGHT+IE/NjRSkW5y7+0MzcGG6ioih4/hqPl9Wj5CnaKDtJUm8hn8RvTkO7mg55Bhe4Ik+x9Cr+r9SQ==
X-Received: by 2002:a17:903:2b0f:b0:223:6657:5001 with SMTP id d9443c01a7336-225dd8b9881mr3214035ad.40.1741885290866;
        Thu, 13 Mar 2025 10:01:30 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1613529b3a.93.2025.03.13.10.01.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 10:01:30 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 3/7] mm, swap: avoid redundant swap device pinning
Date: Fri, 14 Mar 2025 00:59:31 +0800
Message-ID: <20250313165935.63303-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313165935.63303-1-ryncsn@gmail.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently __read_swap_cache_async() has get/put_swap_device() calls to
increase/decrease a swap device reference to prevent swapoff.  While some
of its callers have already held the swap device reference, e.g in
do_swap_page() and shmem_swapin_folio() where __read_swap_cache_async()
will finally called.  Now there are only two callers not holding a swap
device reference, so make them hold a reference instead.  And drop the
get/put_swap_device calls in __read_swap_cache_async.  This should reduce
the overhead for swap in during page fault slightly.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swap_state.c | 14 ++++++++------
 mm/zswap.c      |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index a54b035d6a6c..50840a2887a5 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -426,17 +426,13 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
 {
-	struct swap_info_struct *si;
+	struct swap_info_struct *si = swp_swap_info(entry);
 	struct folio *folio;
 	struct folio *new_folio = NULL;
 	struct folio *result = NULL;
 	void *shadow = NULL;
 
 	*new_page_allocated = false;
-	si = get_swap_device(entry);
-	if (!si)
-		return NULL;
-
 	for (;;) {
 		int err;
 		/*
@@ -532,7 +528,6 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	put_swap_folio(new_folio, entry);
 	folio_unlock(new_folio);
 put_and_return:
-	put_swap_device(si);
 	if (!(*new_page_allocated) && new_folio)
 		folio_put(new_folio);
 	return result;
@@ -552,11 +547,16 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug)
 {
+	struct swap_info_struct *si;
 	bool page_allocated;
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct folio *folio;
 
+	si = get_swap_device(entry);
+	if (!si)
+		return NULL;
+
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
@@ -564,6 +564,8 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	if (page_allocated)
 		swap_read_folio(folio, plug);
+
+	put_swap_device(si);
 	return folio;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 7d8d684e54d4..c470073c17cc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1055,15 +1055,21 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
+	struct swap_info_struct *si;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
+	si = get_swap_device(swpentry);
+	if (!si)
+		return -EEXIST;
+
 	mpol = get_task_policy(current);
 	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
+	put_swap_device(si);
 	if (!folio)
 		return -ENOMEM;
 
-- 
2.48.1



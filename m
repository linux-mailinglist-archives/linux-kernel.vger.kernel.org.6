Return-Path: <linux-kernel+bounces-515454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C24A3651D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C1C18918BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613882690D8;
	Fri, 14 Feb 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ4MrWKh"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBB2690C7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555909; cv=none; b=m39+AdACfopWfIv7aik/6bRETqB351q8CsgzXSnLjAm5EL5lEiLFHa/vQNU3hOG6qPPE999pMkLNLAflZf+atveiKP/1EYglj405vG792MsjfWGDxmNW2qKxesNEEVEvv6TXnZvgXvSP/7+4cQIoXGny+ONfjyLRAds0Tdu6034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555909; c=relaxed/simple;
	bh=5wWmsfWZOJQ4wTvtj1C8ZBtsAx3MzJiXlQSsmX0f7N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W44WhdAJEnklfGlOU909mIVavLYbVnjSoh8+SOZuDmCaa99P4+rnz1yn0G83pVibuAyAIk5kh/QDHwXlgQ211o+q60xc5neVQP126e6mmtKVKHCSPKcwSCqbSWrJwyw56qpZeJzJZ6JoM/yDV4U0Vn6NmmtTQz3l5OXmaE6zHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ4MrWKh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c665ef4cso35650335ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555907; x=1740160707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wbraR41/doRi2Xpub6gCucxiI0zUxRVmW0Za0OUBAfw=;
        b=QJ4MrWKhGbw84caCli1dfix49RbwtFFTyztA1o0MODKIv3nYHHcdmYSI0UBGA9D5/2
         MlGIFhgp0OL8R2EcolNNDxSHIqiSZKqXepuI2FZnOeppz5aKARKPatqvrMg9FMCWuUnS
         dBAc5kU65Vj3W9v533OGF1iHQIcPt1EOQ8xSaiiqWLudb1s/GHCKDLnrmduuNUgmtLoO
         R2g4Z/BqFIbb13Xo8stO08oSJtdtljS+NVyrcx6ASwc/tuYc3MKCHmTscFnCbFZdAktM
         T8kxpRA4OPs8/TValZMDjdJNth2TAiC35iWfAFJSjMRedcFDSh7eJRpPCSvf1l+egZiO
         tTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555907; x=1740160707;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbraR41/doRi2Xpub6gCucxiI0zUxRVmW0Za0OUBAfw=;
        b=KkHVeaxvZ/BHvbzHapXCcFbuWg/EGdycPtPitdW31Ej+FDkIaLsVA7q9hkMZW7pC09
         Qn0PAqP9+AmPEh/X2Dvb8U6vAWMpMFar8BgHloRByKMyXvJJ5dqGi/5d5dDoKd/MWvXw
         776OjvnVRfppd5D1z/r6B8DYLTYthTFUW2D3QzlWTCSkme1imJClE/Bb2UAg9jsf9yoR
         guij6Ame8hwqgNVzhZAwn02bmBigafSXT0x89rkDuXQlaqhs1qc9dPG7vSfsYH0F9KIg
         aFn6HLvEJtJRimHo3G6oP11TJUxvErkrD55tmQX5Q4Kub437N5u/URR9y+xt8RRxpSvt
         Tjyg==
X-Forwarded-Encrypted: i=1; AJvYcCUFrcs2LT9Zlrk1Yfd2UTGj5mEFf7Xgert1YwAVn3Rro/zoYa8fIMGP/QJRRxQ66CTwWeuackOw0aFRRrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCppHtRqd3kyzhPpc6/JV9aoS51Uvvx5mOwkIBZK5VGD+CI6kP
	5VuYixbHGCuJqbspbpEX4ziQ1+Jgekr66CtwAn2Zx0IE8x+3ad1E
X-Gm-Gg: ASbGncuHnrfqjGWBkut0e1GYMSsDu756IGezENI/6YLsU6nh7sDL1nMYeyWvExt1KEX
	+BBJ6HtCl/1xRnwDJxmoGFaqnLcjZ0Y4+s+CTgkk6+ffMPU0sx3CwNbh4rRfJVOUI8/BlS4UbYu
	3zqZSgxJQOIL5hqy9RkuRiMtgme5ZsvLRtqHlDm6W9xHVtLMO+lm8EsxR4EuJYdHJI6BwFOpx1R
	HSKTNeH7jONH1mk/8RvazhxtINn/eqjRgV8qXllF2fuaVnYSbtQucJJnutDwT5lO3Y6I4y9gqDg
	wMMkwjrwpiHpmokEJDCbLvqBRtkSDRU/ZDQu
X-Google-Smtp-Source: AGHT+IEcy2yWQYwogQ6KcjhIKWsRSf0nE2f/TYKhfF4cn7HOpM1wAXZnP8din7GApc5tHvB2ixsFGg==
X-Received: by 2002:a17:903:18a:b0:220:c8e2:5e30 with SMTP id d9443c01a7336-221040bd29dmr1683615ad.46.1739555907510;
        Fri, 14 Feb 2025 09:58:27 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:27 -0800 (PST)
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
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/7] mm, swap: avoid reclaiming irrelevant swap cache
Date: Sat, 15 Feb 2025 01:57:03 +0800
Message-ID: <20250214175709.76029-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214175709.76029-1-ryncsn@gmail.com>
References: <20250214175709.76029-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Swap allocator will do swap cache reclaim to recycle HAS_CACHE slots for
allocation. It initiates the reclaim from the offset to be reclaimed and
looks up the corresponding folio. The lookup process is lockless, so it's
possible the folio will be removed from the swap cache and given
a different swap entry before the reclaim locks the folio. If
it happens, the reclaim will end up reclaiming an irrelevant folio, and
return wrong return value.

This shouldn't cause any problem with correctness or stability, but
it is indeed confusing and unexpected, and will increase fragmentation,
decrease performance.

Fix this by checking whether the folio is still pointing to the offset
the allocator want to reclaim before reclaiming it.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 34baefb000b5..c77ffee4af86 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -210,6 +210,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	int ret, nr_pages;
 	bool need_reclaim;
 
+again:
 	folio = filemap_get_folio(address_space, swap_cache_index(entry));
 	if (IS_ERR(folio))
 		return 0;
@@ -227,8 +228,16 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!folio_trylock(folio))
 		goto out;
 
-	/* offset could point to the middle of a large folio */
+	/*
+	 * Offset could point to the middle of a large folio, or folio
+	 * may no longer point to the expected offset before it's locked.
+	 */
 	entry = folio->swap;
+	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
+		folio_unlock(folio);
+		folio_put(folio);
+		goto again;
+	}
 	offset = swp_offset(entry);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
-- 
2.48.1



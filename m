Return-Path: <linux-kernel+bounces-383432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8769B1B9A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445411F216BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70469DDDC;
	Sun, 27 Oct 2024 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynz/jgae"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E94C85
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729992019; cv=none; b=OtiREs4oqpOOSEgg3oUd1MKsZgousEy4g9NrLUF3+SL8rjreVr7a/2QM498XqBwIBcGPvvrIDAqWs0uW/pvdAVEqO0b24W9YK71NF1Pf3zpxuhvI0Lwla+Safi9ZXhKGegYSkvdZy0ooqBi5NB8KWpSMZePOwodaxNMJF6Wy5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729992019; c=relaxed/simple;
	bh=aoGOW9UMQu3eHbNSLgmSRaBhzUUjb5RcXfatKTV7/3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WcgULrU3qyqYlgWH9yqQu/Spm30PfDwrKUI+l7B1H08CO2ayR0A0RfGZGsgHQixvZu4Mqgq17LzX0dlMfwe6h1TPsrQvBjP+/EoIvUMYoaCIIMWx8s87Yr7ASmU7OFKx882WH+HxVuidlBGct2QfRO6xUa+/CFqIzes2C7bTQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ynz/jgae; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so2289983a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729992017; x=1730596817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PC+F0uXppq0my0Enu0GUjnL3zjI0FTc8OpigtshywaQ=;
        b=Ynz/jgae2WXckGSPUTgOoQHCCNwICDOl5Qf6oM/KgQ+tOnpXERqqLYaFOF/q/jKHOh
         Z8ZuTafrtPUlylhHilSW4tOuSoqXij1d/EFnSpt45XY+tN0GPwL7ENm8ZyPvmDYEM3Ke
         SFcgmJb6SjQB4qrRjJGBzgY1Dg5ConIsyShvypuKVx7peoZNxRxcGmW6qqTvF+zPhITa
         ufR+ZW7hU7M01EaozvYHUfJmeGA8O+q5UogtIsUzjHxcu7htkBBqEMWy9DSpisQtLv0M
         YAAGzVKjoULVbg1/pKz/hcgGPyfBLMSfdyPgnFBinHRdP+mlAw89Vlp81pZ1O2AWhTyy
         UWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729992017; x=1730596817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PC+F0uXppq0my0Enu0GUjnL3zjI0FTc8OpigtshywaQ=;
        b=n6GyJYiQHOhBLVLukk45al1YmLBEoPSBNUnUHU0UdIQ7D0KVOA3BoJDSuybZgtmHMz
         HS4TIoCT18/9acMqQVC244TEPb13Vem3ovsOaHrT6r+/XIx08IBYEIyjuoIOmfmtQaYI
         RjgMoUZlo9qnOKpPr2vdxH5NfaOy0ghXp9y07sP4o+G48O65q2jFbozvHmzSTqg7gYjg
         ZLQMeWQzZ7VJSvPt3sc+uMXhMIdirlYhHiho/yZRWRtEakBDyVzyAlPmARsioZ1arzD/
         KE7/FOzRBVDlo1KBHETPkaktoqV7GgPvvUlM+fCuhwfQ+ZlM0FQ15HyGMVKOUZf/2J20
         YgOQ==
X-Gm-Message-State: AOJu0YwtkH6h1MyCmuyV6IhWVzniVJ+AivQt9Q5MrOPGMIAZU0RaHUpk
	i3rqhxmr4Obq8NL8reXLPcFaHfImxR7MmT6k/CAJSN5GaOlTyKNK
X-Google-Smtp-Source: AGHT+IEG22nqSr90rq439P2EfIDTm8P1FSy/cp8zFJqQJiDLfrSlxzYAvColiz62KcHhN3XpYvDaOA==
X-Received: by 2002:a17:90b:1202:b0:2e2:d1c9:95c with SMTP id 98e67ed59e1d1-2e8f105f207mr5062395a91.16.1729992016932;
        Sat, 26 Oct 2024 18:20:16 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:dd3b:f946:8c2b:40fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bdfesm6204592a91.10.2024.10.26.18.20.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Oct 2024 18:20:16 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
Date: Sun, 27 Oct 2024 14:19:59 +1300
Message-Id: <20241027011959.9226-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When the proportion of folios from the zero map is small, missing their
accounting may not significantly impact profiling. However, it’s easy
to construct a scenario where this becomes an issue—for example,
allocating 1 GB of memory, writing zeros from userspace, followed by
MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
and swap-in counts seem to vanish into a black hole, potentially
causing semantic ambiguity.

We have two ways to address this:

1. Add a separate counter specifically for the zero map.
2. Continue using the current accounting, treating the zero map like
a normal backend. (This aligns with the current behavior of zRAM
when supporting same-page fills at the device level.)

This patch adopts option 2. I'm curious if others have different
opinions, so I'm marking it as RFC.

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_io.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 5d9b6e6cf96c..90c5ea870038 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -226,6 +226,19 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
+static inline void count_swpout_vm_event(struct folio *folio)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (unlikely(folio_test_pmd_mappable(folio))) {
+		count_memcg_folio_events(folio, THP_SWPOUT, 1);
+		count_vm_event(THP_SWPOUT);
+	}
+#endif
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
+	count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
+	count_vm_events(PSWPOUT, folio_nr_pages(folio));
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -258,6 +271,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	 */
 	if (is_folio_zero_filled(folio)) {
 		swap_zeromap_folio_set(folio);
+		count_swpout_vm_event(folio);
 		folio_unlock(folio);
 		return 0;
 	} else {
@@ -282,19 +296,6 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
-static inline void count_swpout_vm_event(struct folio *folio)
-{
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(folio_test_pmd_mappable(folio))) {
-		count_memcg_folio_events(folio, THP_SWPOUT, 1);
-		count_vm_event(THP_SWPOUT);
-	}
-#endif
-	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
-	count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
-	count_vm_events(PSWPOUT, folio_nr_pages(folio));
-}
-
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 static void bio_associate_blkg_from_page(struct bio *bio, struct folio *folio)
 {
@@ -621,6 +622,9 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	delayacct_swapin_start();
 
 	if (swap_read_folio_zeromap(folio)) {
+		count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
+		count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
+		count_vm_events(PSWPIN, folio_nr_pages(folio));
 		folio_unlock(folio);
 		goto finish;
 	} else if (zswap_load(folio)) {
-- 
2.39.3 (Apple Git-146)



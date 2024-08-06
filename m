Return-Path: <linux-kernel+bounces-275538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 678439486F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2EB1F21B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C2A8F6C;
	Tue,  6 Aug 2024 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo1BheAp"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AC64A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907465; cv=none; b=czu0iXS7iKNzNzFpT5n/7obCrkFlRsu60RbTGd8UhIA0+9V8LblNg9KhKUfcT04Ho9J0lr3bHgbgHioT4/YhAPLISPSPKoEGpw3+dNBJ6CJpEhhXfX0xLrzh+yrNBlfcZgd7uZxFZ/0kPTakzSsx5bPHglIv6Ay40nCob9AmHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907465; c=relaxed/simple;
	bh=bYK90ozy2LiDYRXwWEu32/hIAw/rZVr9deT0DnSa+FY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KVcCio1ZkpW1kUDjXcCdX1ToV0z+yeNK0fV3sg4sOWDk0NRu0BeLB6mA/FREiIbpEO2ZoaLrFJGggfbY2Ym7V+QVuyKWzHkLdQ7ThF+E8dzU5lFkidwH+upwpbZtxWQ9OrxILFIZmq8uUtmxZ+h8zh/XSHYxo7v/9rGoPCIRWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo1BheAp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so68439b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722907462; x=1723512262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsOKPbhkPaiydzWP1r4G7J0zjFvZD/lYhHn26zn4nj4=;
        b=bo1BheApTfo3rJpPyfagZycVBaFdLfhYRi9yfx6NySDwA2gizRzF78+uxVy48k0n9H
         b+l+XVSvIsDFnF2cEn7q+bDoZ/0kN02io+NH4fT9JPUPJascnXH0pqJbtPBs7mpfCSWx
         eZBuE1m2xZPJBr+ULmI4uCks3Sm1E1Db5J/h3Kj3ZC7SBki9sbofvuojJPpw630ogywg
         gn9W1fz8sKGABd7/njDLrGXMhU3PfcR7xzI+ipWMMpRFtTnR/9QTOt0WOU/Oez8igIuv
         SUb58T/z4+E0fuxuvryenajVXFAfhpIZ948B+PimqiQ9JBuk4jqh3DxiyYPRUW32n9ZI
         IbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722907462; x=1723512262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsOKPbhkPaiydzWP1r4G7J0zjFvZD/lYhHn26zn4nj4=;
        b=PJ4ga+6bgne1dpbb4vo2ObQJyt3m+xRi7B094nKU+DHPtTUNUtAtUPupspvETU1bc0
         q46++sCdCcIZ+/4QIlVAV5F8GtDawl5fbA+y485TKkzrOqG5VCDghpblOSpu+Yx2qZoN
         SqdIlNGlf8qmBE0PsDmqvdQo75OQestAnYlEeBNPMUO3fX7FOnnN+SgpGeL24ZVemU0l
         cJLG4mYy/YNGrapiKv24yoQiDd48U3mATZdTcN7R16Gbdyaq8tg6ucy6+C8qNoH4exWT
         qMM8XkYpNRH5rMyvUubsF6F+UlejLecKI/R2K32LpfD2EgOuWebFb6c1xoTJGgza0NOA
         pFiA==
X-Gm-Message-State: AOJu0YzFMe8OPlF/onFMHp8A66FljnaSaPnGUN0TPqpSV12gbhGPo5S8
	QRWA1z/8TpZVT37VLCCeNUSeEuhrOocN0iYDbEx0hHTIl5VgYqIW
X-Google-Smtp-Source: AGHT+IGQabLP6wltWJMRjg7CFpG1IbbrvX8MeFaOWs4NUqm6t+TEzRUeBUqafrhxsW9P18Bw0trtRw==
X-Received: by 2002:a05:6a00:3d0c:b0:70d:39d9:4523 with SMTP id d2e1a72fcca58-7106cfce26cmr14875707b3a.7.1722907462284;
        Mon, 05 Aug 2024 18:24:22 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed0d462sm6215808b3a.174.2024.08.05.18.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:24:21 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm: attempt to batch free swap entries for zap_pte_range()
Date: Tue,  6 Aug 2024 13:24:09 +1200
Message-Id: <20240806012409.61962-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Zhiguo reported that swap release could be a serious bottleneck
during process exits[1]. With mTHP, we have the opportunity to
batch free swaps.
Thanks to the work of Chris and Kairui[2], I was able to achieve
this optimization with minimal code changes by building on their
efforts.
If swap_count is 1, which is likely true as most anon memory are
private, we can free all contiguous swap slots all together.

Ran the below test program for measuring the bandwidth of munmap
using zRAM and 64KiB mTHP:

 #include <sys/mman.h>
 #include <sys/time.h>
 #include <stdlib.h>

 unsigned long long tv_to_ms(struct timeval tv)
 {
        return tv.tv_sec * 1000 + tv.tv_usec / 1000;
 }

 main()
 {
        struct timeval tv_b, tv_e;
        int i;
 #define SIZE 1024*1024*1024
        void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (!p) {
                perror("fail to get memory");
                exit(-1);
        }

        madvise(p, SIZE, MADV_HUGEPAGE);
        memset(p, 0x11, SIZE); /* write to get mem */

        madvise(p, SIZE, MADV_PAGEOUT);

        gettimeofday(&tv_b, NULL);
        munmap(p, SIZE);
        gettimeofday(&tv_e, NULL);

        printf("munmap in bandwidth: %ld bytes/ms\n",
                        SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
 }

The result is as below (munmap bandwidth):
                mm-unstable  mm-unstable-with-patch
   round1       21053761      63161283
   round2       21053761      63161283
   round3       21053761      63161283
   round4       20648881      67108864
   round5       20648881      67108864

munmap bandwidth becomes 3X faster.

[1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@vivo.com/
[2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/

Cc: Kairui Song <kasong@tencent.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea023fc25d08..ed872a186e81 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struct *si,
 	return true;
 }
 
+static bool swap_is_last_map(struct swap_info_struct *si,
+			      unsigned long offset, int nr_pages,
+			      bool *has_cache)
+{
+	unsigned char *map = si->swap_map + offset;
+	unsigned char *map_end = map + nr_pages;
+	bool cached = false;
+
+	do {
+		if ((*map & ~SWAP_HAS_CACHE) != 1)
+			return false;
+		if (*map & SWAP_HAS_CACHE)
+			cached = true;
+	} while (++map < map_end);
+
+	*has_cache = cached;
+	return true;
+}
+
 /*
  * returns number of pages in the folio that backs the swap entry. If positive,
  * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
@@ -1469,6 +1488,39 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
 	return usage;
 }
 
+static bool try_batch_swap_entries_free(struct swap_info_struct *p,
+		swp_entry_t entry, int nr, bool *any_only_cache)
+{
+	unsigned long offset = swp_offset(entry);
+	struct swap_cluster_info *ci;
+	bool has_cache = false;
+	bool can_batch;
+	int i;
+
+	/* cross into another cluster */
+	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
+		return false;
+	ci = lock_cluster_or_swap_info(p, offset);
+	can_batch = swap_is_last_map(p, offset, nr, &has_cache);
+	if (can_batch) {
+		for (i = 0; i < nr; i++)
+			WRITE_ONCE(p->swap_map[offset + i], SWAP_HAS_CACHE);
+	}
+	unlock_cluster_or_swap_info(p, ci);
+
+	/* all swap_maps have count==1 and have no swapcache */
+	if (!can_batch)
+		goto out;
+	if (!has_cache) {
+		spin_lock(&p->lock);
+		swap_entry_range_free(p, entry, nr);
+		spin_unlock(&p->lock);
+	}
+	*any_only_cache = has_cache;
+out:
+	return can_batch;
+}
+
 /*
  * Drop the last HAS_CACHE flag of swap entries, caller have to
  * ensure all entries belong to the same cgroup.
@@ -1797,6 +1849,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	bool any_only_cache = false;
 	unsigned long offset;
 	unsigned char count;
+	bool batched;
 
 	if (non_swap_entry(entry))
 		return;
@@ -1808,6 +1861,13 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	if (WARN_ON(end_offset > si->max))
 		goto out;
 
+	if (nr > 1 && swap_count(data_race(si->swap_map[start_offset]) == 1)) {
+		batched = try_batch_swap_entries_free(si, entry, nr,
+						&any_only_cache);
+		if (batched)
+			goto reclaim;
+	}
+
 	/*
 	 * First free all entries in the range.
 	 */
@@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 		}
 	}
 
+reclaim:
 	/*
 	 * Short-circuit the below loop if none of the entries had their
 	 * reference drop to zero.
-- 
2.34.1



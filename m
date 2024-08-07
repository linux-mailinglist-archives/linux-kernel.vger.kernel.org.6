Return-Path: <linux-kernel+bounces-278624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C37C94B286
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23189281450
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3052155322;
	Wed,  7 Aug 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5Ua0nN/"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C41153828
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067968; cv=none; b=goRxvug1+kh7hbab4lmeWr/WMqp7iKjG9VyB2ie3RMiCykpCWlXq6qSBMuCMGP31jeBCyHRioYxqT4gtAdTLJ4CSO8O51RZUC7Z+AjA9aNradrGtevPr+Md5hzO6VEvV1es+RK9OvaS3nvkdPtJvKfFOaQupNQ4wDTHidquUwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067968; c=relaxed/simple;
	bh=v+AStcKwqmUGey01xH+QBLosL4BbjN7rGab//1djoVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gu2DLEf45TopRrXfeCIspnw7IKl8a37PsXNFMz4EzvQ59GFdd1M+QMFZDPFCKtYWZIVdNhhDnz33qnw/r3Dku1bSWugYXaiRgcmXSp5AtfEXt4b1/Mn2avWzOTED0A00TJcbVl229ShAduLGOErdjgE6MUQy29LkxsHDVmopSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5Ua0nN/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2b921c48so316133b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723067965; x=1723672765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzFcUPVCCsNEEO6wggctSe/wwwFolwBCADY8RalXXJk=;
        b=m5Ua0nN/4RbYEcFiWFi9VYcadk8WaSWkzpNAfCApCqsfGZAHCB/b59qEyr19ize/8M
         VqSCjO3e8Qugfr87z2ooLdb0/Qva5Us3bq0emZR6JCClF/s9NcsqNkC1j3aVqemT0CoK
         x7+32BOJpgWAZGoYecM37O1IHwmosHULyQJTjKuITK6rZR5tyHah9x1UZw1+BzFumVwH
         tSJBX6Mq3Z1s/c5ad+k1suR8HnA+aY42ftwh1IVORswcR7A/5zwxxgX4r2Caknmykqx2
         TJWAgAogUYYjmY89uD/PXd4U/unP+b0teXn5lMshxVo7BwweOzo6ayHjs3hP96Lq+srL
         1/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067965; x=1723672765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzFcUPVCCsNEEO6wggctSe/wwwFolwBCADY8RalXXJk=;
        b=nBt6b6e+/CgXRPxt9kdX3ZW4cHjg9OU65NOLsSOQ5pqitdiW9FZ6aU0LAtZt9ppl9z
         ymbCI06bkuN3NVs6JSEBe95Jmr6mGRKshp8ZWUygED4FyRRq1/Qqv3thI7cZJ9nbHkYe
         DKdiCP+v7erH8io6g02VnVlkvr+YMxW8Kjt9FIdtkMRB9ahK3S+INha1/GYsDUY7rrsc
         T98GqvY/xMUmYRAghjEEsWScrZm6IdkCHjDdl4kN9h1FdEHRIJALgItbnR+1yqfiCp34
         QlTptSqLaivZgvN9qBvOXUe/qgreXcuc/P3+y4wykrg9ukO7Oo+FRhiPCRolxyuc//tY
         HRlg==
X-Forwarded-Encrypted: i=1; AJvYcCUPY2pLjFpFUH1PA8xOrMwLIy9+EHs/yamEKbClwLuUlbV56kCVSOLTZ6xRIBeFHsPdKY0CxNEU3P1DceI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJvk4pXYMopYBZVCdvmjOgFuYkpHa8xP9rh8esg6N+bHWnTZC
	2uEqlb4rx1VFlCftd0Mq+PuQGkUAbPonMnvAez+8JMXRZe7AZSEoRQbpqQ==
X-Google-Smtp-Source: AGHT+IGMPWobDarrgKt42vF8ANwf3Thpok2LgQoSPuTbAgCMx8u10ccyhNYakBhpVvmjfGMIxCtTiQ==
X-Received: by 2002:a05:6a00:2e1c:b0:706:742a:1c3b with SMTP id d2e1a72fcca58-710cad8df81mr60999b3a.8.1723067964390;
        Wed, 07 Aug 2024 14:59:24 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2d544sm8842695b3a.187.2024.08.07.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:59:24 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	hughd@google.com,
	justinjiang@vivo.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: [PATCH v3 2/2] mm: attempt to batch free swap entries for zap_pte_range()
Date: Thu,  8 Aug 2024 09:58:59 +1200
Message-Id: <20240807215859.57491-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807215859.57491-1-21cnbao@gmail.com>
References: <20240807215859.57491-1-21cnbao@gmail.com>
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
 mm/swapfile.c | 76 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 35cb58373493..52e941b6d626 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struct *si,
 	return true;
 }
 
+static bool swap_is_last_map(struct swap_info_struct *si,
+		unsigned long offset, int nr_pages, bool *has_cache)
+{
+	unsigned char *map = si->swap_map + offset;
+	unsigned char *map_end = map + nr_pages;
+	unsigned char count = *map;
+
+	if (swap_count(count) != 1)
+		return false;
+
+	while (++map < map_end) {
+		if (*map != count)
+			return false;
+	}
+
+	*has_cache = !!(count & SWAP_HAS_CACHE);
+	return true;
+}
+
 /*
  * returns number of pages in the folio that backs the swap entry. If positive,
  * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
@@ -1469,6 +1488,51 @@ static unsigned char __swap_entry_free(struct swap_info_struct *si,
 	return usage;
 }
 
+static bool __swap_entries_free(struct swap_info_struct *si,
+		swp_entry_t entry, int nr)
+{
+	unsigned long offset = swp_offset(entry);
+	unsigned int type = swp_type(entry);
+	struct swap_cluster_info *ci;
+	bool has_cache = false;
+	unsigned char count;
+	int i;
+
+	if (nr <= 1 || swap_count(data_race(si->swap_map[offset])) != 1)
+		goto fallback;
+	/* cross into another cluster */
+	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
+		goto fallback;
+
+	ci = lock_cluster_or_swap_info(si, offset);
+	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
+		unlock_cluster_or_swap_info(si, ci);
+		goto fallback;
+	}
+	for (i = 0; i < nr; i++)
+		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
+	unlock_cluster_or_swap_info(si, ci);
+
+	if (!has_cache) {
+		spin_lock(&si->lock);
+		swap_entry_range_free(si, entry, nr);
+		spin_unlock(&si->lock);
+	}
+	return has_cache;
+
+fallback:
+	for (i = 0; i < nr; i++) {
+		if (data_race(si->swap_map[offset + i])) {
+			count = __swap_entry_free(si, swp_entry(type, offset + i));
+			if (count == SWAP_HAS_CACHE)
+				has_cache = true;
+		} else {
+			WARN_ON_ONCE(1);
+		}
+	}
+	return has_cache;
+}
+
 /*
  * Drop the last HAS_CACHE flag of swap entries, caller have to
  * ensure all entries belong to the same cgroup.
@@ -1792,11 +1856,9 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 {
 	const unsigned long start_offset = swp_offset(entry);
 	const unsigned long end_offset = start_offset + nr;
-	unsigned int type = swp_type(entry);
 	struct swap_info_struct *si;
 	bool any_only_cache = false;
 	unsigned long offset;
-	unsigned char count;
 
 	if (non_swap_entry(entry))
 		return;
@@ -1811,15 +1873,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	/*
 	 * First free all entries in the range.
 	 */
-	for (offset = start_offset; offset < end_offset; offset++) {
-		if (data_race(si->swap_map[offset])) {
-			count = __swap_entry_free(si, swp_entry(type, offset));
-			if (count == SWAP_HAS_CACHE)
-				any_only_cache = true;
-		} else {
-			WARN_ON_ONCE(1);
-		}
-	}
+	any_only_cache = __swap_entries_free(si, entry, nr);
 
 	/*
 	 * Short-circuit the below loop if none of the entries had their
-- 
2.34.1



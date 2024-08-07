Return-Path: <linux-kernel+bounces-277546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D458D94A2C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCDA1C223FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBAC1CB313;
	Wed,  7 Aug 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3WN5WbT"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C1CB30E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019141; cv=none; b=bWGL6bPe4ERzkHa4QRpoQDBM30pg04pc+bJ5WUevoYKmnZ25mJR31CmIUO7HYQZMetcyXrfVuwrJVaaVu5r+zPpmVBWk86rZBJKYXbfip53g2q3SYmAKqROxKeJjDCmbrODJOFWydpYaADReWYluYy4HrQfCh/vvA3FpMsurFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019141; c=relaxed/simple;
	bh=TE0dMbcGCouZl9eTik1kK4YJtAM4y+zty2arx2p8O8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUF0yLAknkaBBczpIXND5xMfd+en4n8SQZQwBnj/tawpBeTYf7hhmE8nyI+iBgS2guiN11HcNjX20/F4FeRcJZE5XuL5BooA6dnJJW89xmvPwCm3gZWME4DHlZtDabjO1rzs7Kl2t1Pawp0jjIfP83d0jAVdYR+MEa0bwDfUD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3WN5WbT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-71871d5e087so918967a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723019139; x=1723623939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlFQkb2cMvN1c1QVMf0JMKTkCt490ubd3m2R1WYvp/E=;
        b=C3WN5WbTXyB0YRM1ZeBstPG+BA5bQ8YWOUmRxWxteylUEMaEUVxJ0a0+XmyBhead9k
         Yj6/08i3N+lkSdXa9q0ybsLhgwFxIyM9oUqbargZ6E4TGTlE7QTALGM6k0zU2rpvlE/a
         Fp1X3ySjMEx21ErdQB7nXowEmvbuM+7vxfW2dNYIfZ1q/v3Ft6+Bj1brTjjXwRQ5BHh7
         tVHN7Q26T5+rQc8Z/cDQtB+mCnX7Xmnv8eX/aGoWOpr/ISC78TTofwVB/0iAPKuGPzdW
         OOYO/oSHXH4Hmj1LQO+CnIm8AyeDW0ojnAc/+8/55EB/KhVuQAQofWZkWJ1y2dRu1uDB
         7OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019139; x=1723623939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlFQkb2cMvN1c1QVMf0JMKTkCt490ubd3m2R1WYvp/E=;
        b=Lybhw9Bg/UYLrmtkWHEmmjyQZHdcKfm98xgX2KlnxyTGZ+4FINlUwz1+K3voMhgJ8y
         HkaGxWCSWLwNW0aFG1h3lntiOc7AdsiACN/rxHYw5niqtzspknC6CKOFSUKHjk636ruI
         XH6dH3hQ8bGUGkwrqBkU4pK06ro5H6Gbn5f4dLOftguKI/BlJtatiFsBNsZTQLOZ4fbY
         sLh/0tWhNjm6cd68Ljs32DuliHsf/6NS1e1CtOzTbICmScxiw80UjveO9uN7SfNNiBUK
         pYrHXLFgmuIzO5pr8FLcZuo+YpBti3DsWx6UwkhfciRn4Dfrn+uaUFu2VfiaX23K0jsk
         XaEg==
X-Forwarded-Encrypted: i=1; AJvYcCW4jiaH4HOpGO/I+putamRYC1Tlxh9Z1wJrtfxKADELBYNh/RkMp8wN/e+JYn+s6Qel/Bzc3nv5dDBMAr1jl2MqYUiVuphHsBVeD0xd
X-Gm-Message-State: AOJu0YyGa/MDHtA9ajoHp3hwpBEuXcwy6rNd8R1aJeAW/gQLpH3EBM7T
	LwAKZuWgJXZUW+EL9fGsVVgN2hCjdSRpM95i0KMh2Z9FSdhEIrPA
X-Google-Smtp-Source: AGHT+IG8xn5/66z7PTJPV4BCOi2Y/r1TSf0uignh/HpGSQRadyx5jGGO3Tw+w7ebVq7amQ4F6zh+BA==
X-Received: by 2002:a05:6a20:de16:b0:1c6:ba8b:1e41 with SMTP id adf61e73a8af0-1c6ba8b1ebfmr12002331637.1.1723019138731;
        Wed, 07 Aug 2024 01:25:38 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed0d457sm7911763b3a.156.2024.08.07.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:25:38 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: justinjiang@vivo.com,
	chrisl@kernel.org,
	david@redhat.com,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: [PATCH v2 2/2] mm: attempt to batch free swap entries for zap_pte_range()
Date: Wed,  7 Aug 2024 20:25:08 +1200
Message-Id: <20240807082508.358322-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807082508.358322-1-21cnbao@gmail.com>
References: <20240807082508.358322-1-21cnbao@gmail.com>
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
 mm/swapfile.c | 78 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 11 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 35cb58373493..25c3f98fa8d5 100644
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
@@ -1469,6 +1488,53 @@ static unsigned char __swap_entry_free(struct swap_info_struct *si,
 	return usage;
 }
 
+static bool __swap_entries_free(struct swap_info_struct *si,
+				swp_entry_t entry, int nr)
+{
+	unsigned long offset = swp_offset(entry);
+	unsigned int type = swp_type(entry);
+	struct swap_cluster_info *ci;
+	bool has_cache = false;
+	unsigned char count;
+	bool can_batch;
+	int i;
+
+	if (nr <= 1 || swap_count(data_race(si->swap_map[offset])) != 1)
+		goto fallback;
+	/* cross into another cluster */
+	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
+		goto fallback;
+
+	ci = lock_cluster_or_swap_info(si, offset);
+	can_batch = swap_is_last_map(si, offset, nr, &has_cache);
+	if (can_batch) {
+		for (i = 0; i < nr; i++)
+			WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
+	}
+	unlock_cluster_or_swap_info(si, ci);
+
+	if (!can_batch)
+		goto fallback;
+	if (!has_cache) {
+		spin_lock(&si->lock);
+		swap_entry_range_free(si, entry, nr);
+		spin_unlock(&si->lock);
+	}
+	return has_cache;
+
+fallback:
+	for (i = 0; i  < nr; i++) {
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
@@ -1792,11 +1858,9 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
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
@@ -1811,15 +1875,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
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



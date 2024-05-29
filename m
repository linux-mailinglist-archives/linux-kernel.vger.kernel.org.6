Return-Path: <linux-kernel+bounces-193744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA18D316A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CED28DD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B042168C3A;
	Wed, 29 May 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewyicS+C"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721344C7B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971333; cv=none; b=jfHdnAWTP9ktNf77j/Gnqz5+KUWcE043CrhvwXGqFigyK7h+NE76vv7RpgnnZ/uAwxg5bGYybo5QIsosC2SmSLWJBPYXK0kacFVkWal7AtGJ+2Abmp8E2tCT313DfNRVJVhXcI2i9qr56y2rZLj/4DX9EBsyMGIp3bvfVVsWUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971333; c=relaxed/simple;
	bh=08oobRwRz3gaF/temZ05IpZbrn5Dik268m1bTOTym00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sp+ViFYbDXy4pRbD4R7Cr8jHIqvNWGFkKfLiFcukOffqXstiv0WW3OKvS12eOnP6Mhjo6DP9EvhJagYapF/6TT3ULeW2eOUkswXqJH3+5MA2DXTcvdemai1O+60nwoxIUqRgScKsQ6wiPXoYCNnaqqIPRUV/d5/uueOBWyOgUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewyicS+C; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24fca68b554so727476fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971331; x=1717576131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k7udukJq/5lufC/QvLOUP0N512BAUWebXH46Q8HtFk=;
        b=ewyicS+CzMUpq+qTA46ap/qls+3Ujh28I1AS3Y+m42gAw8VCGd5W0zPs93yqo/qBMp
         yVudo/IJ6f4ScwAn305sa8RGtgG8oJPicMjiKVti2BB1td41PEdGs/CC/KqMabkKHpDu
         0bHbNxoI6n+SsHDpiULlItiMk4yqm21kHeNjtaQybL5u2NFBG6IkDHwoSEpvWXEUwl2U
         KgYz20sIL8s/MbOJtuNxri9xVs82lcT9lkhcAP/ULCrukVqSuDz0skqgXwjRSDtv6Ses
         i+Zz4xliYeYa37CBKH95QZISOLDdq7bEpGR7Nlv3KMXSkcFsgJD0cuAV2ylbDFRW24nQ
         5CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971331; x=1717576131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k7udukJq/5lufC/QvLOUP0N512BAUWebXH46Q8HtFk=;
        b=d17DbSM5Yx8l0VtH7d77VzqDPJKkaTGTBmR3SHfPe8pxI42mgW4D3QmHYt/iFYqmIO
         daenHd3k6J84XMZPj8aLrnhccKg/j2RdYX7s42FiOVjXGMVLRzImjPyQrwTnX8efcyGm
         Ra/ppFlwl93Eplb98GzLorm7F1AmTGNkrVlXolsNmAbxIyN/YrWfAQiAX1uqzOgVvq5e
         IvvyHoZWcS5v+dtGnxJb1IOmSUBc7ao0YMOTixw+JjlFo82Kt6tpAHkuj57K7uMR3/Yt
         baMoo9ddL0RX2VnELNpjIwYrcx5H4qchd18Ikvt5SMp6ktBoraii5TiHBVXnxQCYyAOU
         KsTA==
X-Forwarded-Encrypted: i=1; AJvYcCXTnasSD++hlIALFJ/oNx6zd4R7qKrrh3558FoCoyrKyATb7826jl7eKrX1tRTVe/qeg38hQYrobxVGDf5u/TwfU2P/J6EsYqYFiJzi
X-Gm-Message-State: AOJu0YxLOchNq4ociJ7UsEOExVy6wTmWffrjZzar0UmxSTMc+dBevXGD
	mZEqg9OaQ/wMLY/809rJYvGnyMT22XCZImOFlt8hEz0O3Vvy45Uh
X-Google-Smtp-Source: AGHT+IFwms1cBvU+f9ojhWDg3nZKfLTfOVGOcCh0o9BJomwXX1OgvRueLY1XlvYRSI7zo2uCYFeifw==
X-Received: by 2002:a05:6870:96a2:b0:24c:a414:3eab with SMTP id 586e51a60fabf-24ca41467f3mr15324961fac.32.1716971330911;
        Wed, 29 May 2024 01:28:50 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702220d948bsm174916b3a.131.2024.05.29.01.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:28:50 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v5 1/6] mm: swap: introduce swap_free_nr() for batched swap_free()
Date: Wed, 29 May 2024 20:28:19 +1200
Message-Id: <20240529082824.150954-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082824.150954-1-21cnbao@gmail.com>
References: <20240529082824.150954-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

While swapping in a large folio, we need to free swaps related to the whole
folio. To avoid frequently acquiring and releasing swap locks, it is better
to introduce an API for batched free.
Furthermore, this new function, swap_free_nr(), is designed to efficiently
handle various scenarios for releasing a specified number, nr, of swap
entries.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 include/linux/swap.h |  5 +++++
 mm/swapfile.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a11c75e897ec..45f76dfe29b1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -481,6 +481,7 @@ extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free(swp_entry_t);
+extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int swap_type_of(dev_t device, sector_t offset);
@@ -562,6 +563,10 @@ static inline void swap_free(swp_entry_t swp)
 {
 }
 
+static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+}
+
 static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
 {
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f1e559e216bd..92a045d34a97 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1356,6 +1356,53 @@ void swap_free(swp_entry_t entry)
 		__swap_entry_free(p, entry);
 }
 
+static void cluster_swap_free_nr(struct swap_info_struct *sis,
+		unsigned long offset, int nr_pages)
+{
+	struct swap_cluster_info *ci;
+	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
+	int i, nr;
+
+	ci = lock_cluster_or_swap_info(sis, offset);
+	while (nr_pages) {
+		nr = min(BITS_PER_LONG, nr_pages);
+		for (i = 0; i < nr; i++) {
+			if (!__swap_entry_free_locked(sis, offset + i, 1))
+				bitmap_set(to_free, i, 1);
+		}
+		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
+			unlock_cluster_or_swap_info(sis, ci);
+			for_each_set_bit(i, to_free, BITS_PER_LONG)
+				free_swap_slot(swp_entry(sis->type, offset + i));
+			if (nr == nr_pages)
+				return;
+			bitmap_clear(to_free, 0, BITS_PER_LONG);
+			ci = lock_cluster_or_swap_info(sis, offset);
+		}
+		offset += nr;
+		nr_pages -= nr;
+	}
+	unlock_cluster_or_swap_info(sis, ci);
+}
+
+void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+	int nr;
+	struct swap_info_struct *sis;
+	unsigned long offset = swp_offset(entry);
+
+	sis = _swap_info_get(entry);
+	if (!sis)
+		return;
+
+	while (nr_pages) {
+		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
+		cluster_swap_free_nr(sis, offset, nr);
+		offset += nr;
+		nr_pages -= nr;
+	}
+}
+
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
-- 
2.34.1



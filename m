Return-Path: <linux-kernel+bounces-173904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1338C076C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2462843F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916E2837E;
	Wed,  8 May 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/aKUiKW"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614D286AE
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208112; cv=none; b=IPpST/WpV6QQS3J3nYolcvkv+f46+hXVNjrbu/VCxskf4gYYBRFCghz8z6X2+dY9F4T8rAJVqtjvuL07Tpqza/Tp238bE7fNGVrstty2bg6sTlGGAZqld8Z3muLwiDM+OkZ/Jii44hhJip80mBc2FIyEIhQYnYmvbFWByFzu3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208112; c=relaxed/simple;
	bh=nrAk9y30+c6gajgSfc4mOHwujo2W6S4FOBjLI/TfuUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLm7IvszcmbmM8IHcabSvCgiG6V/kTnWOqjs3N1fbNQZJw3KXm2R1Qb/+uuevHseb7kpxuD0zjRcWR/KX+EWkdOnVV1QHU9vDsd6IAsD1JuL487gSDketZmEGNtiipjzwaB8tU6aOfcYpDcGqyZ8xB27dM24x81AEG0FUzX23iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/aKUiKW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b3646494a8so241119a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715208110; x=1715812910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOx+XLJ6NG229/wS5wOB5lVEjUmMQDyjSrW3ljEjCDo=;
        b=O/aKUiKWhsaKrkTDqwOqlNKY4Ch3rw/6FIPZLSiC8zybtq28idaiYgnAhp+rBugAjA
         nelqlXFAtxGqsXAAfiKKvYnM2OM0Srn4IknZmnMc6tgOy2kE/eqhhE0r4N5zuYuJR4sr
         rDmDABBWyx6cy8/FZthDBdmfAAYW8ylbZAt9hH7C6dsOoAbXPLvT7+43Xid4tVpPGYcQ
         JjjiBk2Lmb5UMnd+5DvpAJI7dtUQJJizlLy8NyfCHzYUkZ5jal/9J3MaDBzcYxWd1G8W
         X2yL2gc79x/tGFDmO7QJkCUeG6YIwHXtBjLyKGEw47Kf0lD2QrDZbf4FzXSoyS8DAlSp
         EMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208110; x=1715812910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOx+XLJ6NG229/wS5wOB5lVEjUmMQDyjSrW3ljEjCDo=;
        b=f+EvEIDqy35CBwuoeXR83ZwFSF26PAhFsapUNHLcXMHWoOI/ZN0CEDbsprDQqR2xnr
         w9IQxTzJcX6yN6VSjS9MawbCeLIoEdt+91MkLQl3N3p17ElSmQiEkun/goC4ekhxf251
         989UkgE6gMBz21g9Hbk/6/w4P/CeNwWrbBlOXzGcqSU/+oC+MP/SmHei8drR5M/BWoM9
         Olik5y4fbLwrRyL1DQT74uWZDvKqsCl8fKhISAAKJSfoAT0PSi4bJVgMvb0D6qwUfvGU
         2WSCMaaF0bXEQaubdZWRFMsWoCBtXa/6N5ENOHcRQSi9iqH4nILbOp0HHxYb8Gb/fAsm
         ALmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5w5a7aPQH8YucFQS3yCz8ok6i/yIUIG6Lbn0U7uDJvauj5YPhEsobx8eIDQ0jvH6OoWFyFKCRva8e83iORoOLAKnCAzWMxyjbhQaK
X-Gm-Message-State: AOJu0YyHPrrJ7lzxGarUQqjuY7w9bkVwu/ltEzyLPTiE9HJK8uvxE37A
	rzfYRlLYkIjeYt06ZaQknP/GLaSRybFHjZxaBedmzKTo+4vJJY25
X-Google-Smtp-Source: AGHT+IEFp0bWFb71EA7kiwqcgB9bekLg3MgzbqqZFw9IyUlHL4NxSW9RrXf+dnY9e3fmsofVV/uA3A==
X-Received: by 2002:a17:90a:fa8c:b0:2b5:1f7d:7eae with SMTP id 98e67ed59e1d1-2b6165c4fbbmr3664457a91.24.1715208110215;
        Wed, 08 May 2024 15:41:50 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126b666sm102082a91.34.2024.05.08.15.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:41:49 -0700 (PDT)
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
Subject: [PATCH v4 1/6] mm: swap: introduce swap_free_nr() for batched swap_free()
Date: Thu,  9 May 2024 10:40:35 +1200
Message-Id: <20240508224040.190469-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508224040.190469-1-21cnbao@gmail.com>
References: <20240508224040.190469-1-21cnbao@gmail.com>
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
index 11c53692f65f..d1d35e92d7e9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free(swp_entry_t);
+extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int swap_type_of(dev_t device, sector_t offset);
@@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
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
index f6ca215fb92f..ec12f2b9d229 100644
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



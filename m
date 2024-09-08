Return-Path: <linux-kernel+bounces-320448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26215970A94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC41C211D7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE25D1531E6;
	Sun,  8 Sep 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALkz4Arl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE554136663
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725837705; cv=none; b=l7SuAyRgSZ0QTQVJvgCmTHgY3/rW3X1Y9ZDOoNwCg08SKXOhxE8yiqrgnxA9SUVwt/jpyuwyULm3YU6/TO4JLWkN9vjFdGvlJ622cZhkyQZzjNrDlphb/6t9wX4pGoW4R2CCUMopqhHMtvT/HXmxAiSEaa2NdXs4T+HqFMHgAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725837705; c=relaxed/simple;
	bh=wdNlq0LZHcppiaaSB0gvnyZ/a3Roq3Xi+TBV9VIz/98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEtvfSsNTF5srhkEXos25X7QeqLK2V07uCux1bBR4QtRBxCxuhfGYPC2MmuJwKnNnxN2Z92+t3QEZXa1NIx44zk4Dfpusbdnjo440b7jE5gOq8Ds1OdX86y6Mqmgsy4gR20G+/hPdd1UgFlTVCbBNpXo2bGpeaHZWHzz3SyBIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALkz4Arl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2054feabfc3so31917725ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725837703; x=1726442503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2xC+tIjHn2wWvMR2T1OflcDy+oEzjuKFqq/trb+O1U=;
        b=ALkz4ArlhG8xp4wV8o8tuvplyF3DnevefyuNWha2Dw5iW+5RMv8qzCc+d2ih6uZG8M
         sRi8Y7S5OzaCbWZlIt0bzMkMxP7gF0GJaEwJU11t4n6MQLtQRnIPRDyHOnu0qpxo6LEi
         7LueX0G63m3qVzeXTVQa81YYraFqXmjFw8bnexgl/s2Bxc+EuibjWa725fi2HaQkBLp6
         chSFgp6ej68uz/9A/em/WfBCN8mkyIQtk7GLzwBsffDyRmvXjNR+LS0zk0aHm59rmL+n
         gWcbDXbnAge2fbPAQOVOHcStkS5J+nZDyjiSN0wLc9Nj9/SZjPmkyfQIvV5BXrHjrf+b
         AqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725837703; x=1726442503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2xC+tIjHn2wWvMR2T1OflcDy+oEzjuKFqq/trb+O1U=;
        b=iFvI9sfcDwgk6gLTr/5MdSqC+KXWU+YWbNqCg92oyjSIsW5Nf+fYfLiJJwSeSPMekw
         O3BOt+CDetV0QKD4IgWT1/Qawzz09HVUgF6JxiG8hq8e72b37xuIjSBVqpn/Sdy9jpmi
         4+LA7WLhlBOGhOHLzHonV1dQTF6Rjzz1I64/f1Lir1RhSV5cf27FKoBanvN+qoOIusFs
         it1+FquYyNNKHgCPPbs/25ZkVbDTwSHHBG7FWEpRrbWpN2BH+Vp6dPfbVY0TsUjLWZ43
         xOT1EguCp0eoIzcpcqzDFDRKdK6gfCzF2441GdkksL442tGOFho6I4+TV1RIAbFdSIb1
         ufXg==
X-Forwarded-Encrypted: i=1; AJvYcCVSaSeSZgc/4KZaHvK1Mv0XR/8AsnL6LuOG0CpVKJZgkmx32aAlfXR+7bQXaMOV1rRuuroTQ4H+e1bL7Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Xi2fBTtqeQ5xNVLoc6m4QeEUXjiCT6EKITTL0M3YIhx19vTD
	uw4unbun1B3KqonjxSVUa0ZiqojJVdXp8JoR5VXzcgtyT/zxD/ef
X-Google-Smtp-Source: AGHT+IFgSDJb5dN2/2g631ifqwqWtDRQhZpgCd9etl+bEZOuXVcAb2DQHY5prsg3HDa8T4Pw/lnH/g==
X-Received: by 2002:a05:6a21:4581:b0:1cf:3838:1ec5 with SMTP id adf61e73a8af0-1cf38381efdmr4465870637.5.1725837702701;
        Sun, 08 Sep 2024 16:21:42 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:ecbd:b95f:f7b2:8158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c703asm2447643b3a.82.2024.09.08.16.21.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Sep 2024 16:21:42 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v9 1/3] mm: Fix swap_read_folio_zeromap() for large folios with partial zeromap
Date: Mon,  9 Sep 2024 11:21:17 +1200
Message-Id: <20240908232119.2157-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240908232119.2157-1-21cnbao@gmail.com>
References: <20240908232119.2157-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

There could be a corner case where the first entry is non-zeromap,
but a subsequent entry is zeromap. In this case, we should not
let swap_read_folio_zeromap() return false since we will still
read corrupted data.

Additionally, the iteration of test_bit() is unnecessary and
can be replaced with bitmap operations, which are more efficient.

We can adopt the style of swap_pte_batch() and folio_pte_batch() to
introduce swap_zeromap_batch() which seems to provide the greatest
flexibility for the caller. This approach allows the caller to either
check if the zeromap status of all entries is consistent or determine
the number of contiguous entries with the same status.

Since swap_read_folio() can't handle reading a large folio that's
partially zeromap and partially non-zeromap, we've moved the code
to mm/swap.h so that others, like those working on swap-in, can
access it.

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Cc: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_io.c | 32 +++++++-------------------------
 mm/swap.h    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4bc77d1c6bfa..bc1183299a7d 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
-/*
- * Return the index of the first subpage which is not zero-filled
- * according to swap_info_struct->zeromap.
- * If all pages are zero-filled according to zeromap, it will return
- * folio_nr_pages(folio).
- */
-static unsigned int swap_zeromap_folio_test(struct folio *folio)
-{
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
-	swp_entry_t entry;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		if (!test_bit(swp_offset(entry), sis->zeromap))
-			return i;
-	}
-	return i;
-}
-
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -524,19 +504,21 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
-	unsigned int idx = swap_zeromap_folio_test(folio);
-
-	if (idx == 0)
-		return false;
+	int nr_pages = folio_nr_pages(folio);
+	bool is_zeromap;
 
 	/*
 	 * Swapping in a large folio that is partially in the zeromap is not
 	 * currently handled. Return true without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
+			&is_zeromap) != nr_pages))
 		return true;
 
+	if (!is_zeromap)
+		return false;
+
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
 	return true;
diff --git a/mm/swap.h b/mm/swap.h
index f8711ff82f84..ad2f121de970 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return swp_swap_info(folio->swap)->flags;
 }
+
+/*
+ * Return the count of contiguous swap entries that share the same
+ * zeromap status as the starting entry. If is_zeromap is not NULL,
+ * it will return the zeromap status of the starting entry.
+ */
+static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
+		bool *is_zeromap)
+{
+	struct swap_info_struct *sis = swp_swap_info(entry);
+	unsigned long start = swp_offset(entry);
+	unsigned long end = start + max_nr;
+	bool first_bit;
+
+	first_bit = test_bit(start, sis->zeromap);
+	if (is_zeromap)
+		*is_zeromap = first_bit;
+
+	if (max_nr <= 1)
+		return max_nr;
+	if (first_bit)
+		return find_next_zero_bit(sis->zeromap, end, start) - start;
+	else
+		return find_next_bit(sis->zeromap, end, start) - start;
+}
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
@@ -171,6 +197,13 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
 }
+
+static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
+		bool *has_zeromap)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SWAP */
 
 #endif /* _MM_SWAP_H */
-- 
2.34.1



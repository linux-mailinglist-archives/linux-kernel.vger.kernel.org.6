Return-Path: <linux-kernel+bounces-300603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40995E5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8E71C209BC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F197441F;
	Sun, 25 Aug 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVZdCV33"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDB3987D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724628343; cv=none; b=htpfl/ExgUC0yV2SfFYZ2KEnIZ9AbI5+0aXcNMFyWQVM10tJV4pax0wwmE4tE36rmzkIYqD1eBNXpI9AgxLnEbsTVyQZnrAUx1l2KHutXiuMtZ0voFKjWZidb5+Fh84aCupXLv1aeYJGK2e5q22ezNw6tBWN7z2JRQcF8kcpeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724628343; c=relaxed/simple;
	bh=9vqtVOimSk9osFYVMzG344l53NqqdU1gp6Li+2HgY9Q=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=m9031Wa46Bsy6J1USYDfugUtCG97C7CyCQWILcna0V9QRzquYnbeVwqqgTFRU37z65vcIvartgw+FKz42ALyY74XfMDxcOZnsjF5HCiF2QwnshFJp1/9LkYs3HKFdUj3OGuW09Mg/P2AhUwh2TXMdR368r+i08FEH0e5fMYyIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVZdCV33; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3ec4bacc5so3350446a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724628341; x=1725233141; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rzeE9bKcsZgsUP1FogvmerFavSQnv357IASYuLar6TQ=;
        b=YVZdCV33HwmqI3vpysuFqVp7mUmXDuiAMBlnbwY/N0V/bf28sCZCbGW+rxHVcryfdJ
         f1R2Y0buydM22FI2IZD3s9AH1UKbwIOnuazK5zvKO1Eas/TFkISmmh9DIEZZvssfJ+u3
         vqdrDvUDyge8JzZpOLqmS/w2CMPQsAZCu/7C8+HE8e7WZ/pJAyAeXaYFNXu4Nm0Tbfqd
         BS31SJw29UP1gczOlrXGNo9pOOFX2kpL227U79cTLp/JYetL8rq6xX7oRPkVKfJnPuS3
         3/7iFAM8Fhrlr6DGz9DfnQtj8cuj9Es2+3T3PtUw0G/jXhfsB/623ppf9kcCIyfTJlTC
         1SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724628341; x=1725233141;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzeE9bKcsZgsUP1FogvmerFavSQnv357IASYuLar6TQ=;
        b=VBmbujXAwLVKubMdILMv9dFyMchewo42LYL5TB00T7ltdSwXwtACgUrFaub+V4dKWM
         VeM8xndnZhcAcaSG5urLBCSQJFNZ7zMpSQGw6ecqs1W0QuVBAI2HVs8yDE1aBj+AkNZC
         rXamdFMrErQoNfTZkAqnN8YQebaqOGRExbI4/rceJxTLRxmpZfJ9sbhs0ZHJlo3ivUdr
         T6znmCMECL/UEZiVMXT4+WWdGQG+KFT1pl1ZA/csQEdGke+ha6qY1AHmwOTD5pv++a6v
         RjNgYll4EWXIFqvLlk+HlOaKj+W47IrgfWPdRrqP6QKHdusWcFSe7EupPnp8f300txyq
         Y1jw==
X-Forwarded-Encrypted: i=1; AJvYcCWBGNxafy30AiN9vLQzHYqyscfmzaWlwuMibEETAjcFI83roDR3wohLVn2TI+3uCHQYQb4V7E8DkWS7aEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcPim3pVPFMtkEHo82jCCcXFYbg79wk9uZshbUvUI/9okFFiA
	44QQn4y5nAzUboi8iJqrf0hs5icJh2MGVVOUdE+7zqKuDPbJMZBv4ZORh+E+qw==
X-Google-Smtp-Source: AGHT+IGM1pZchLOaXRCnXn9BkaDFEykmTV38Q2MqO8HiEk46KGpvNq1YwBDhJHoU6Iofmf8ahpOMew==
X-Received: by 2002:a17:90b:180f:b0:2d3:c365:53b1 with SMTP id 98e67ed59e1d1-2d6447b2771mr14905062a91.6.1724628341207;
        Sun, 25 Aug 2024 16:25:41 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613a58fdbsm8424175a91.29.2024.08.25.16.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 16:25:40 -0700 (PDT)
Date: Sun, 25 Aug 2024 16:25:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH] mm: shmem: extend shmem_unused_huge_shrink() to all sizes
Message-ID: <d8c40850-6774-7a93-1e2c-8d941683b260@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Although shmem_get_folio_gfp() is correctly putting inodes on the
shrinklist according to the folio size, shmem_unused_huge_shrink()
was still dealing with that shrinklist in terms of HPAGE_PMD_SIZE.

Generalize that; and to handle the mixture of sizes more sensibly,
shmem_alloc_and_add_folio() give it a number of pages to be freed
(approximate: no need to minimize that with an exact calculation)
instead of a number of inodes to split.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
This patch would most naturally go into mm-unstable as 10/9 over
Baolin's "support large folio swap-out and swap-in for shmem" series.

 mm/shmem.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4dd0570962fa..4c9921c234b7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -636,15 +636,14 @@ static const char *shmem_format_huge(int huge)
 #endif
 
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
-		struct shrink_control *sc, unsigned long nr_to_split)
+		struct shrink_control *sc, unsigned long nr_to_free)
 {
 	LIST_HEAD(list), *pos, *next;
-	LIST_HEAD(to_remove);
 	struct inode *inode;
 	struct shmem_inode_info *info;
 	struct folio *folio;
 	unsigned long batch = sc ? sc->nr_to_scan : 128;
-	int split = 0;
+	unsigned long split = 0, freed = 0;
 
 	if (list_empty(&sbinfo->shrinklist))
 		return SHRINK_STOP;
@@ -662,13 +661,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 			goto next;
 		}
 
-		/* Check if there's anything to gain */
-		if (round_up(inode->i_size, PAGE_SIZE) ==
-				round_up(inode->i_size, HPAGE_PMD_SIZE)) {
-			list_move(&info->shrinklist, &to_remove);
-			goto next;
-		}
-
 		list_move(&info->shrinklist, &list);
 next:
 		sbinfo->shrinklist_len--;
@@ -677,34 +669,36 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 	}
 	spin_unlock(&sbinfo->shrinklist_lock);
 
-	list_for_each_safe(pos, next, &to_remove) {
-		info = list_entry(pos, struct shmem_inode_info, shrinklist);
-		inode = &info->vfs_inode;
-		list_del_init(&info->shrinklist);
-		iput(inode);
-	}
-
 	list_for_each_safe(pos, next, &list) {
+		pgoff_t next, end;
+		loff_t i_size;
 		int ret;
-		pgoff_t index;
 
 		info = list_entry(pos, struct shmem_inode_info, shrinklist);
 		inode = &info->vfs_inode;
 
-		if (nr_to_split && split >= nr_to_split)
+		if (nr_to_free && freed >= nr_to_free)
 			goto move_back;
 
-		index = (inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT;
-		folio = filemap_get_folio(inode->i_mapping, index);
-		if (IS_ERR(folio))
+		i_size = i_size_read(inode);
+		folio = filemap_get_entry(inode->i_mapping, i_size / PAGE_SIZE);
+		if (!folio || xa_is_value(folio))
 			goto drop;
 
-		/* No huge page at the end of the file: nothing to split */
+		/* No large page at the end of the file: nothing to split */
 		if (!folio_test_large(folio)) {
 			folio_put(folio);
 			goto drop;
 		}
 
+		/* Check if there is anything to gain from splitting */
+		next = folio_next_index(folio);
+		end = shmem_fallocend(inode, DIV_ROUND_UP(i_size, PAGE_SIZE));
+		if (end <= folio->index || end >= next) {
+			folio_put(folio);
+			goto drop;
+		}
+
 		/*
 		 * Move the inode on the list back to shrinklist if we failed
 		 * to lock the page at this time.
@@ -725,6 +719,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		if (ret)
 			goto move_back;
 
+		freed += next - end;
 		split++;
 drop:
 		list_del_init(&info->shrinklist);
@@ -769,7 +764,7 @@ static long shmem_unused_huge_count(struct super_block *sb,
 #define shmem_huge SHMEM_HUGE_DENY
 
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
-		struct shrink_control *sc, unsigned long nr_to_split)
+		struct shrink_control *sc, unsigned long nr_to_free)
 {
 	return 0;
 }
@@ -1852,7 +1847,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		 * Try to reclaim some space by splitting a few
 		 * large folios beyond i_size on the filesystem.
 		 */
-		shmem_unused_huge_shrink(sbinfo, NULL, 2);
+		shmem_unused_huge_shrink(sbinfo, NULL, pages);
 		/*
 		 * And do a shmem_recalc_inode() to account for freed pages:
 		 * except our folio is there in cache, so not quite balanced.
-- 
2.35.3


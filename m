Return-Path: <linux-kernel+bounces-245055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C21192ADBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220411F223D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDE2837D;
	Tue,  9 Jul 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTtkA4At"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA539ADD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488099; cv=none; b=FWrUs3h1Phh3S7VWbC69HKKNGhsmMy+qaFzRWEc/di/oJ7X/g71fBhmjQriu3gitWBoTd20Ir69CfhWGu7j3zuOEB93H60lt6D46ZGwGWLhK1coqGHwRqvegLMenUMtkKul7afBSbR4dYeX/ZWXh383FuPHEA6Sh3dLuKo3jzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488099; c=relaxed/simple;
	bh=tw5e/ii7kOtznxLNCArpOb56vtv6Tfwb9ywQ8YS0q4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1Gw57XWMMQ0qqgLAGTRmkF3gj1VJNAQpQfF9HYQUfylGpxtNX1QaqFEH34lNkiOpkYe/2yBrEPEDR8c0pSenk+5EDdIi1iMLJaD/uN/r8a512qke6crdddb4EWomzt1np+oea/Ni+CgUNxDbVWd6wK3U34BEs8xBqex6or8BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTtkA4At; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so29027005ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720488098; x=1721092898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rp5LIY/csjN1lG+GtCfJFxmKq047kymV7T1r6/i6YSU=;
        b=nTtkA4AtDe6EdxkZgOqb+aIpOwI5Y74ex+33sj2AkY/nePNsylKp7FSj4JsL39gPPB
         EtyYUIS1cAHUOYWuYT+xH9DBxUsoi7YhK1QxU6fcFJ4hU2+uEfN/8gS+WViuruubhq+3
         kzbPb0RCI+7E6F5OnTJXQvVuL4pIJMeUlmSIccxZ+b2OUBXBad2o3SDgNP7p0u7RckJb
         JkW7Bl8ws+NNEHMcsrNtwEcp7Y98NReCxlb7OcDE9ekbg+FyeeGpCxZ8BlZuM5I8tj/t
         /j95ULp53vqu8XyZjGygiIM2GhaesMypzNxFESbSBR3U0liEYy6UEqDfNNWPONPWfDxc
         391w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720488098; x=1721092898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rp5LIY/csjN1lG+GtCfJFxmKq047kymV7T1r6/i6YSU=;
        b=opvJJy0wlyyxGblVRx6+8SoyAcqpMget3wZ8zdJQWRPm4eqQyeXadyou7/HgZwdZwz
         jhz4iKDKxr7D/6p80XNjScxO/YRZqL0MYbGvJ9PGe/iVodmVm+OgCM455UiGqJ+4B1ie
         BPh1BroByjSvE6FWl8DjoyLbM+Vvd7F96/cEE7tpy4TpQsXU77kCHRZXBZzCQf5ie3mX
         xbImkYwpS3rn5VfMwXWsuxj8KtjJvPFzLbCZGwgxpDDvQjLw8Pi3ca4bq54U5rJS41tm
         V2c4grrUKN8NgNFqM2byiptNjEeJhaqKGLJ/zDWiywBKjiX0G6gobdolxdiQoYsLzKoO
         l4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVSi7UvfJYy1qH2OsodKFvTZ5VGAWgbuo94qWqKPXJ3HVsKqFfDbDIJi3cAD6EryQaZWEgxd6Rzii4YN9ZhsgEhplQ3cC8wJHkxVhNR
X-Gm-Message-State: AOJu0YyOL2j+xYSGjWbYBYvx77P//OamY130fPeTlIf2p3s4XqmISgFQ
	/t6e60Faf0CPjKytm9kL5lGaM70XAsqztXzaIoHkQ7puEm49K7NJ
X-Google-Smtp-Source: AGHT+IFwt7lbvTqeTvAwSBA7I39AeW+RkqFofI4QK5RRnNC/qFaLuMwKyyKjN4ysz3LU5RPkMqmueg==
X-Received: by 2002:a17:902:e549:b0:1fb:46a7:dbda with SMTP id d9443c01a7336-1fbb6d89a46mr9779605ad.47.1720488097664;
        Mon, 08 Jul 2024 18:21:37 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2a72csm4792395ad.77.2024.07.08.18.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:21:37 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: [PATCH v2] mm: Extend 'usage' parameter so that cluster_swap_free_nr() can be reused
Date: Tue,  9 Jul 2024 13:21:22 +1200
Message-Id: <20240709012122.16994-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Extend a usage parameter so that cluster_swap_free_nr() can be reused by
both swapcache_clear() and swap_free().
__swap_entry_free() is quite similar but more tricky as it requires the
return value of __swap_entry_free_locked() which cluster_swap_free_nr()
doesn't support.

Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/swapfile.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f7224bc1320c..c097c513db02 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1352,7 +1352,8 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 }
 
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
-		unsigned long offset, int nr_pages)
+		unsigned long offset, int nr_pages,
+		unsigned char usage)
 {
 	struct swap_cluster_info *ci;
 	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
@@ -1362,7 +1363,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 	while (nr_pages) {
 		nr = min(BITS_PER_LONG, nr_pages);
 		for (i = 0; i < nr; i++) {
-			if (!__swap_entry_free_locked(sis, offset + i, 1))
+			if (!__swap_entry_free_locked(sis, offset + i, usage))
 				bitmap_set(to_free, i, 1);
 		}
 		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
@@ -1396,7 +1397,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 
 	while (nr_pages) {
 		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-		cluster_swap_free_nr(sis, offset, nr);
+		cluster_swap_free_nr(sis, offset, nr, 1);
 		offset += nr;
 		nr_pages -= nr;
 	}
@@ -3492,15 +3493,9 @@ int swapcache_prepare(swp_entry_t entry)
 
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
 {
-	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
-	unsigned char usage;
 
-	ci = lock_cluster_or_swap_info(si, offset);
-	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
-	unlock_cluster_or_swap_info(si, ci);
-	if (!usage)
-		free_swap_slot(entry);
+	cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
 }
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-- 
2.34.1



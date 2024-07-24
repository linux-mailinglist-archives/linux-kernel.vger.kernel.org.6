Return-Path: <linux-kernel+bounces-260552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02F193AADB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA991C22C18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D8F9EC;
	Wed, 24 Jul 2024 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRmJ/ewr"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184A1843
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786471; cv=none; b=XYkiUMP944PALol8gQJ+wzQvs9F2gJaOE3YLKhkGHa64frVAnS6Bkwtuc8x0KTUTr5DAEYQH3XwMBk25x14UEErfYyRhIbiVMDGA7GATODXKvRg5aXvHw0HmSdwvrhTZdqA6kLYfmFkdkd7L/0R3MG/9E1GH/vsPFkQ2+r24uNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786471; c=relaxed/simple;
	bh=5fl9lGgLE0g5PNztAiKtX+0uRVrom8iX+GhsoI4ZraA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUtDu585dQP3Gly+f+Rq9I0pgR41HaJ+S/sU5/owUcED33HfWG8ViYERtlb8ls1Te2q6DeGl8ld4r4Y7fQ/jP+RvRfetMUWgoEAX24JKQqN0dBKGJ9dDMCQeD78zYj1fjfCt9HPYqZ8h6bjTzrGF/mWU6fVk7EfY/CfrzB2TiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRmJ/ewr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so1857080a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721786469; x=1722391269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVUcSmjoF8uFIYy2DZhQyn83BKjAD1GneoeqabmtAz8=;
        b=QRmJ/ewrgz2AikGL+aaHp8E52IwN6NXMKVDfDkgZkRVNm3kXuN1Gvu9sRn2fO7LcD2
         UgmWp5WajkBWx+ep477qn0mEAuUzdePHfOeqt7b3xRuJrdEdWJwn1798YIUKR4fsx8CT
         4/RKV7f2QUVdbN402THl5uVhCxn8EQEbvPRKtCiargEUITiizhgpi8VTURCagt8+IOmf
         Bff24c79s7I4o6wGVEMsFw17bbftNZBRmgQJwX6fIDOnEz8WTR+P+iqYr4f/PnDJlhQH
         7lO6kGHYt+1TzAYv+RaYBZOQkKKZOyuGWbbIfK63eqTFCu+bvLfngN2vFfR4Yhl7NaPG
         tY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721786469; x=1722391269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVUcSmjoF8uFIYy2DZhQyn83BKjAD1GneoeqabmtAz8=;
        b=hie+9qPK8NiAmI5QrQWoZgHp0Dw4L2SfDL0/iMuWHjyD+LA5gDUsDQacrNOeNuhL9y
         TsyUw63LKIKdxrjMRJ/hWYHDnHYxAn1uKRrd0z/908z1j7a3Gah+NHW9DHNqwhmAHZ0Y
         u4fKTaOBFgCdTKMcS++K7QT0YbHSEmyus6Np0pc6l2MxKMnfMJkmqb0b47DeCeSyuSeM
         p74AY/umpeu2Crqex0PNXWZSgRvYpvBUf3IVR/Ye2R0Vrvbd6ODunQntDapzv+jQRygr
         /E7JQ+7pPo2C+tw3hHN/QpdeEr+Nu7LECm/HlrD9Tl2Lvs8rjeVqiiALVLWzsLtJZQ9V
         kGzA==
X-Forwarded-Encrypted: i=1; AJvYcCU/5TqAA4EAbYm7cPv3gaOn8F8lqej5Cp306QYt4WoFC018vzdgcYGU1Q6Dl9XTggVmYW0w1XyH03UsIY/QeEZLMRumc4NArEewmLhK
X-Gm-Message-State: AOJu0YxZHt+v1qwYF/otHBrVAoZcbypUYBre5dPaPvaSTsp6WPaaKK1Q
	CpEPtkhdK6SX+Yx68HPR+rkDpbFqgDsbPuZhHDkFRdm0oPIPvjUvqwdI2Q==
X-Google-Smtp-Source: AGHT+IGajzuaNCAxSBXn7gIE6oHhkTvGkNCn2JCeYtx4lkKmPSG7JAN/pWKAhYOO9i7LVKx/K2CQBw==
X-Received: by 2002:a17:90a:fa8c:b0:2c9:a3ca:cc98 with SMTP id 98e67ed59e1d1-2cd273ec800mr7829077a91.7.1721786469414;
        Tue, 23 Jul 2024 19:01:09 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb747c703sm323634a91.44.2024.07.23.19.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 19:01:08 -0700 (PDT)
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
Subject: [PATCH v3] mm: Extend 'usage' parameter so that cluster_swap_free_nr() can be reused
Date: Wed, 24 Jul 2024 14:00:56 +1200
Message-Id: <20240724020056.65838-1-21cnbao@gmail.com>
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
Cc: Kairui Song <kasong@tencent.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v3: resend &collect Ryan's reviewed-by

 mm/swapfile.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 38bdc439651a..5f73a8553371 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1344,7 +1344,8 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 }
 
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
-		unsigned long offset, int nr_pages)
+		unsigned long offset, int nr_pages,
+		unsigned char usage)
 {
 	struct swap_cluster_info *ci;
 	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
@@ -1354,7 +1355,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 	while (nr_pages) {
 		nr = min(BITS_PER_LONG, nr_pages);
 		for (i = 0; i < nr; i++) {
-			if (!__swap_entry_free_locked(sis, offset + i, 1))
+			if (!__swap_entry_free_locked(sis, offset + i, usage))
 				bitmap_set(to_free, i, 1);
 		}
 		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
@@ -1388,7 +1389,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 
 	while (nr_pages) {
 		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-		cluster_swap_free_nr(sis, offset, nr);
+		cluster_swap_free_nr(sis, offset, nr, 1);
 		offset += nr;
 		nr_pages -= nr;
 	}
@@ -3472,15 +3473,9 @@ int swapcache_prepare(swp_entry_t entry)
 
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



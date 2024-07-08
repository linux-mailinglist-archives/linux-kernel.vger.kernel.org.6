Return-Path: <linux-kernel+bounces-243872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B74E929C02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAAE4B21227
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB711720;
	Mon,  8 Jul 2024 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6Pn+AKa"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6176FB9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419320; cv=none; b=drjCbP8lnBscmtaV65UwOt2msEv6u28P0jVleI2DjW4aSbVapoIa88G5OmkZ5qy66NhlQn3WPZ2wGlIIDBW7ZgtQsQp9lN0UU5es0ZJzP35br6HgZckXjOG1R3VawGkKDfpbABIMqwD/mDyWeIr6LgZkmK4NlFIea63i16HgpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419320; c=relaxed/simple;
	bh=YjzZtIyHJ+7V+oR2e3ex1aJEqT0DA9k9DYoSUGGgSF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OAO6dXPz2eHW1AvZvCzkwRMPq31ATaYnCgif7S8+CoXoN4qstUaaYZxsRhk+EgHP4I1Rh9z0363i2NO/foK9z4EUXyNixyZUhQDpO8W0CkWVMOhRSFxccPNJSRimX7HrEBmTe5mQQVJDZFv5/jP3u2lRCFEJrjL7rWUvKlA0J7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6Pn+AKa; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-38713b03039so6516165ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720419318; x=1721024118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQIqWVaUpLW7tNHj4brQfTw/7FKBab3/cxzq1ObVSc8=;
        b=T6Pn+AKanDuLYMh1sxAiqRIQ0VcyRWpoXY9QZp/ejJMKiM7FQHYh3CO7QjEyBtrcG+
         42SxwGy87SIXJj9mOwn8N9mv7t4RbsU24fJElH/m8qFYuLt+AfWLtFP6fP9CEsR0GBV3
         IyTLyFwKf6rC0kr3GN+wHFtjmhAEdKXLoLhkSg0DXSFnFAZ7S1TXd3bXHX4wA79AMyq7
         NJmbFaD8KYnEYOwN3tfVcIY2duMZIfW8kOR9UIenmalneiPVTBOViPIj45C3xuCmTTKH
         E+LI8/3CxIPc7r729Y5CdDKB4DI2DMuKtHe3XDFK5OaUaF+SitBDYquy892DWajTPI89
         3ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419318; x=1721024118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQIqWVaUpLW7tNHj4brQfTw/7FKBab3/cxzq1ObVSc8=;
        b=pSxnIW9RxMm4HmiVP7977zb4Aez7lM5yUFkzkavVk//vrDojNopqTyyXzucZggEXdk
         EOGun3RID8TPWt4pVKONj0oP94y8SsaLaSvDfEd1P86VjQACClak5h8pKwgByJuhTF3h
         EHhf61d0mY8VarlL9irnzN2jhAWVzmNY6vK/aSIDhIYl838nZaFjnO4ysiWF8KcWvMq3
         g6uV5H2eYNsUCdsUAxYm/Of0hCqSMz7LOlfpEkDknfeKJh/3Iy9j1WA11VE4puhoZhxg
         QFAln2fM932hpNWO0huEati/1exjb50XJotf2zG7iUT0ZxR+EERn9w+BxYAdLahRkqlH
         4Tmg==
X-Gm-Message-State: AOJu0Yz6bLgZNEk3N4PEM1gIAOVDDS5HbRqAd4+w5XBng0Qof4WyeECd
	X8Fv2sGimflKbdJ7nIXZ1NsP03UTNn722J7CMOLgDvZozGMJpl7Z
X-Google-Smtp-Source: AGHT+IGHGlicSVY55FROKSe9KZmtjkxvug0KMI9c/n0YLb3ZClpmuNJ7SGyya4Xv5GO73u8uYJv2lg==
X-Received: by 2002:a05:6e02:20ed:b0:375:a3d8:97a5 with SMTP id e9e14a558f8ab-38398b02a27mr156595925ab.5.1720419317691;
        Sun, 07 Jul 2024 23:15:17 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2585e8c7sm2425736b3a.171.2024.07.07.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:15:17 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kairui Song <kasong@tencent.com>,
	David Hildenbrand <david@redhat.com>,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH] mm: Extend 'usage' parameter so that cluster_swap_free_nr() can be reused
Date: Mon,  8 Jul 2024 18:15:02 +1200
Message-Id: <20240708061502.9006-1-21cnbao@gmail.com>
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
index f7224bc1320c..70c4a9132672 100644
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
@@ -1363,7 +1364,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 		nr = min(BITS_PER_LONG, nr_pages);
 		for (i = 0; i < nr; i++) {
 			if (!__swap_entry_free_locked(sis, offset + i, 1))
-				bitmap_set(to_free, i, 1);
+				bitmap_set(to_free, i, usage);
 		}
 		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
 			unlock_cluster_or_swap_info(sis, ci);
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
2.39.2



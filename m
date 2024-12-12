Return-Path: <linux-kernel+bounces-443159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CE9EE818
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5DC18886B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA72144C0;
	Thu, 12 Dec 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJUzAX4K"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DB2153C8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011696; cv=none; b=UvB08mIdiT0qYVRLbZO8JFOLMzsjgQwzCzwjmign1AmEW4ljFv58ZuOGGjskLMRVdnAWU/z9TlPmNvG9lg0Tult3rf3rPGESXTi6T21pXFPXh07MjPz8b8+6dCDPULr0EkH3OVFDmjaFgVOrUpGpHz7tx7nHA4B0h1TAtWMO6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011696; c=relaxed/simple;
	bh=DxSTyo12d1BqkfflKXmj0s26FsTGfuHU0KKx9JBJPT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CD7+qSukC3tsT+OWlm5Ag4hn05c2BkAIDMqe+BIjEHkQPLJFB6kJezJ2kDzSK/TTLYesYSp387dMr+e/azAufgxmS/aG78akNMgUC2kjXAb3bO36hCMwhfssflQUulZOP6HD4+n+B8I7IDxQhyf3Nc6ElWobimTotRteg07gasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJUzAX4K; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6e5c74cb7so48887785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734011691; x=1734616491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9RP6+zMY8aaxIMFUve3LW6blFGvDtrBs3qVoCstadg=;
        b=SJUzAX4KH717LJI2d3u8TE/+j9KgwCNxX/ITW4Uf659nAmcg+vDyZX127l3w5ahewY
         I5IMlNJKB8OI5vudqtwIXS3CI3uFvKsGaiLg/YffrkFF8GxGH2LN+QhU3Rq81dx6EEoS
         uJltmMMd8glfxxmugKvFiNDA/U7hMP5fYeA2pLewIwW76/UTyoEM7KZXdO9+yx84/0gx
         T04ePxgOCKnCPvKWp/LM/4r2vhJ+9SxNbpGz8MR3PanhuMRv4widVlm+a7Lgi+4haJhp
         cnbmDtUK9kgtJ4kc2g6MCosw/OC1e0F2in/MYQv4jj5/NgsTLsl3RUkENR+DXRu78H0Q
         hrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734011691; x=1734616491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9RP6+zMY8aaxIMFUve3LW6blFGvDtrBs3qVoCstadg=;
        b=pXkN2xpf7YALQotgRleJzBDxBuKijWXCC2hCmKU9rqxNL2y9FGgzYVVcNcqhgtihrI
         5Rx5jO9/VxaamVdzFjrwqgH9j09d2OsNVN7jSayaJT9vvauQXwXIck94CmPv8D4IpeVy
         M2YBPQamdko0rckZIGcmXshY+Wps/9tifDvpaaNxXyYCIaV8qhFb8US6tScTC/U242Zb
         mi6YRYN19H01JeyoD4m1x98YdAcgFHQnzv3DeUmSuRZEg7cuGPY9PIQyAfIspp6tjGdH
         5m/7ma1o0IRF/+kxBYxVjjO0xSIYj3Ait0GoUTuvvVbfc7Kjv2RWRSWEhtCCP4fiiR1e
         79Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUBYuk1aZDVwm7QpgXqK2FbyarnQ+xtK+fNAOnCWgbdX0xVZ+rVLY+ByEC8BXg5p/bV1bDee9j0mROrO1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XYmSwPWA0B9leOh0SOyDKjihH2RDo9zkkcQwsP0+0/8B3XV8
	qV3Fh15C0yj9CFVA6BEj9O2wdHc/lCxKeqJVdVe3QAWGLl+o6lc8
X-Gm-Gg: ASbGncvwx+9l2LFlOTwNiNuourMCIpvegKUk3JoCIRKBFhzHJacJ2lzo/z4VoGDY2fT
	lXGQoPsYZ87KEJXMY4gX+eR4C2Olu39f/9C5H5auO2KUW5Fwmjz//frbJkvpdWdugSao1O+cZ2N
	mgTN2/NIdRAXEGyFh2HD2JXA2lgyHzUTivcea7mXuK3FTKpfG23uD5gutEUUpJmH3ktQVxbIN+8
	tcfup8vqH1HdbFBYiVHeB3LlFtUoSkICz9eKkFS0qvcs2ijYD4jXA==
X-Google-Smtp-Source: AGHT+IFnwr5pOaX9RAL7iibiXd0fE91LuA/C2ZlY+4FYQT+m+IouRTrDzR2WX7o9HmUFOBZ0IUG5og==
X-Received: by 2002:a05:620a:6005:b0:7b6:91a4:845b with SMTP id af79cd13be357-7b6f88e7889mr93164685a.15.1734011691567;
        Thu, 12 Dec 2024 05:54:51 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:2::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a8441asm741138985a.84.2024.12.12.05.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:54:50 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	npache@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm: convert partially_mapped set/clear operations to be atomic
Date: Thu, 12 Dec 2024 13:54:47 +0000
Message-ID: <20241212135447.3530047-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other page flags in the 2nd page, like PG_hwpoison and
PG_anon_exclusive can get modified concurrently. Hence,
partially_mapped flags need to be changed atomically.

Fixes: 8422acdc97ed ("mm: introduce a pageflag for partially mapped folios")
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/page-flags.h | 12 ++----------
 mm/huge_memory.c           |  8 ++++----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cf46ac720802..691506bdf2c5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -862,18 +862,10 @@ static inline void ClearPageCompound(struct page *page)
 	ClearPageHead(page);
 }
 FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
-FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
-/*
- * PG_partially_mapped is protected by deferred_split split_queue_lock,
- * so its safe to use non-atomic set/clear.
- */
-__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
-__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
+FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
 #else
 FOLIO_FLAG_FALSE(large_rmappable)
-FOLIO_TEST_FLAG_FALSE(partially_mapped)
-__FOLIO_SET_FLAG_NOOP(partially_mapped)
-__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
+FOLIO_FLAG_FALSE(partially_mapped)
 #endif
 
 #define PG_head_mask ((1UL << PG_head))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2da5520bfe24..120cd2cdc614 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3583,7 +3583,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
 			if (folio_test_partially_mapped(folio)) {
-				__folio_clear_partially_mapped(folio);
+				folio_clear_partially_mapped(folio);
 				mod_mthp_stat(folio_order(folio),
 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			}
@@ -3695,7 +3695,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		if (folio_test_partially_mapped(folio)) {
-			__folio_clear_partially_mapped(folio);
+			folio_clear_partially_mapped(folio);
 			mod_mthp_stat(folio_order(folio),
 				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		}
@@ -3739,7 +3739,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (partially_mapped) {
 		if (!folio_test_partially_mapped(folio)) {
-			__folio_set_partially_mapped(folio);
+			folio_set_partially_mapped(folio);
 			if (folio_test_pmd_mappable(folio))
 				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
@@ -3832,7 +3832,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		} else {
 			/* We lost race with folio_put() */
 			if (folio_test_partially_mapped(folio)) {
-				__folio_clear_partially_mapped(folio);
+				folio_clear_partially_mapped(folio);
 				mod_mthp_stat(folio_order(folio),
 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			}
-- 
2.43.5



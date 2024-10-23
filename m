Return-Path: <linux-kernel+bounces-378846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72559AD645
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA461F25A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7F1FF5EB;
	Wed, 23 Oct 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiM7Vowp"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364491FF044
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717337; cv=none; b=OJa9kZNodtmmCHd20YO2yTZ77o1Lx5YlxgqZF4MLRP0FABzI3n33XjeQg/BGYV8kmP+9pQrIq5hBC2738uW+wLE4DtC0pSLc1izsbMcByETNsMgOBijR5npF83JP2JqjohPRM4Q92WXjNjFW5sy25jZyvx7Mm/rsTAyJ0DNdoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717337; c=relaxed/simple;
	bh=/paCse8vOntHRa3ZkcAAMTyRGt3t7A6RSS6PgDLuk0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtgEu9tPb2O8E8AXp0rssZAT8RjMkjQl35zBNDkCzUA3zcKV1L7TeviKc7dh/+gsKaeeTEGed3jVfF9yKV78nycys28Ym2xqs8Uy0vl8eN7nIFepvZvReaTkcjtyH3lJReD2fdmw8QLHrvIkUT/JvetD2BVWcMnTwGCL+lMyFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiM7Vowp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so997204a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729717335; x=1730322135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml8qGMnD8wyWC7ziO9cF4S6Zf0jnQsJbeVtFeepzb0E=;
        b=LiM7VowpZieO6pHvQ8ReXc8pQ+1mUf1OnwMaBuQ8q5MMf8slXVvjHLZABOHNB3hQFb
         5Q5ZcXY2e93Af+S7xNW2nxFpseix+r+r2FX69jkbDxGWqXox3WkwKrWaRnFPv5AsM05v
         pN51gUrhwndh7aWZsHwx3vYlPhHFVlOaDcfaax0b5shqyODaAy+AEsK/TRUMunDVoOj6
         71gyLs8mm95oiaNHe1MP7IN08FYG0TQNv+3PtotIlHhkR83oyr4sOgJ2LuNr4k/NYajT
         HdWQAIkUxvuudYwAw65s6q7Uy7RJWpCPsLsQJpYQ4AtnWIcQESt0Omf2jidtTrZYHp6R
         9TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717335; x=1730322135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ml8qGMnD8wyWC7ziO9cF4S6Zf0jnQsJbeVtFeepzb0E=;
        b=P+IOQcwSR8x+eCN2e3V756ZPvpnFBIiZjWFAr93JvR6XuQuMyHF59mFRLTQbPIAGF3
         218U7tRPBFARmlO0c2uI2tFIiZ6NWN+2n49yiLDBu/yv5t1HGH9p6yVFPuOG3v/LKild
         VKIBcDYFhUL+YrtiSQ3sLMB/HBb93/nKmGN/afm8Cgb2XaQY5V5gC3L4r7anYp+Igycn
         quYm4KwcwwPTjzapV3aFsLgz/bVr0UFoedT5y0+aaqxo/GeqzUFYuYu/haXCED6lbnoW
         qAJV6PKZbsqeF22kHiwbFEQbp35vL0kqEX9QPEQOUMX9G3lDptnN6ANSZoCnJREdxWmB
         6vuw==
X-Gm-Message-State: AOJu0YxRs4YYrV743EqqTDH7hBnradB6WmubsSnuBZirXAM6UmX3+gOJ
	pwtOQCtuy0kdiL3FX0XqrX49F+ul0HYKHI7XGWizGZCZuzwCr2Y1
X-Google-Smtp-Source: AGHT+IFB+OM5KwRnyuAHM7yiKyvnRK7TQLuhW1Tt7IcMYOwaYThOylgh1uhhjXLrV9fk5aGXf+bw2w==
X-Received: by 2002:a17:90b:364c:b0:2e0:7580:6853 with SMTP id 98e67ed59e1d1-2e76a858bdfmr5720431a91.17.1729717335185;
        Wed, 23 Oct 2024 14:02:15 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:3020:9cde:9371:3772])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76e05b884sm1942590a91.40.2024.10.23.14.02.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Oct 2024 14:02:14 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm: Fix PSWPIN counter for large folios swap-in
Date: Thu, 24 Oct 2024 10:02:01 +1300
Message-Id: <20241023210201.2798-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Similar to PSWPOUT, we should count the number of base pages
instead of large folios.

Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io devices")
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index a28d28b6b3ce..c69fab5060a1 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -574,7 +574,7 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
 	 */
 	get_task_struct(current);
 	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
-	count_vm_event(PSWPIN);
+	count_vm_events(PSWPIN, folio_nr_pages(folio));
 	submit_bio_wait(&bio);
 	__end_swap_bio_read(&bio);
 	put_task_struct(current);
@@ -590,7 +590,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
 	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
-	count_vm_event(PSWPIN);
+	count_vm_events(PSWPIN, folio_nr_pages(folio));
 	submit_bio(bio);
 }
 
-- 
2.39.3 (Apple Git-146)


